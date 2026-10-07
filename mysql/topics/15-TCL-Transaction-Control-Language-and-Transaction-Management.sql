-- ======================================================================
-- Topic 15: TCL (Transaction Control Language) & Transaction Management
-- ======================================================================

-- ------------------------------------------------------------
-- 📖 In Simple Words
-- ------------------------------------------------------------

-- * Definition: TCL (Transaction Control Language) commands control a transaction: START TRANSACTION / BEGIN starts it, COMMIT saves it, ROLLBACK cancels it, SAVEPOINT marks a point you can go back to.

-- * Real-life example: Like a shopping cart: you add items (changes); Pay = COMMIT, Empty cart = ROLLBACK.

-- * Example on salesdb (run 00-Setup-Sample-Data.sql first):
USE salesdb;
START TRANSACTION;
UPDATE products SET price = 100 WHERE productid = 101;
ROLLBACK;
SELECT price FROM products WHERE productid = 101;

-- * Example explained (step by step):
--   1. The transaction starts and the Bottle price is changed to 100.
--   2. ROLLBACK cancels everything done since the start.
--   3. The final SELECT shows 10 — the old price is back.

-- ------------------------------------------------------------
-- 15.1 What is TCL (Transaction Control Language)?
-- ------------------------------------------------------------

-- * *Definition: TCL (Transaction Control Language) commands decide whether changes are saved permanently (`COMMIT`) or undone (`ROLLBACK`).*

--   * Core Formula:
--     $$\text{TCL} = \text{Transaction Control} = \text{Save or Undo Changes}$$

-- ---

-- ------------------------------------------------------------
-- 15.2 What is a Transaction? (ACID Overview)
-- ------------------------------------------------------------

-- * Definition: A Transaction is a group of one or more SQL statements executed as a single, indivisible logical unit of work.

-- * All-or-Nothing Principle: Either all statements succeed, or none of them take effect.

-- * Common Statements in Transactions:

--   * Primarily groups DML statements (`INSERT`, `UPDATE`, `DELETE`).

-- * The 4 ACID Pillars:

--   * Atomicity (A): The entire transaction either completes successfully or is completely rolled back (no partial execution).

--   * Consistency (C): Takes the database from one valid state to another, maintaining all constraints and schema rules.

--   * Isolation (I): Intermediate transaction states are invisible to other concurrently running transactions.

--   * Durability (D): Once committed, data changes survive permanently on disk even during system failures or power outages.

-- ---

-- ------------------------------------------------------------
-- 15.3 Core TCL Commands: START, COMMIT, ROLLBACK, SAVEPOINT, SET
-- ------------------------------------------------------------

-- | Command | Action / Role | Effect on Data |
-- | :--- | :--- | :--- |
-- | **`START TRANSACTION`** | Begins a new transaction block | Opens an atomic staging session |
-- | **`COMMIT`** | Saves changes permanently | Writes staged changes to disk; ends transaction |
-- | **`ROLLBACK`** | Undoes uncommitted changes | Restores database back to pre-transaction state |
-- | **`SAVEPOINT`** | Sets an intermediate checkpoint | Allows partial rollback to a specific marker |
-- | **`SET TRANSACTION`** | Sets transaction properties | Configures isolation levels and read-only modes |

-- ------------------------------------------------------------
-- 1. Beginning a Transaction: `START TRANSACTION` / `BEGIN`
-- ------------------------------------------------------------

-- * Definition: START TRANSACTION (or BEGIN) instructs the database engine to open a new atomic transaction context.
START TRANSACTION;
-- OR
BEGIN;

-- ------------------------------------------------------------
-- 2. Saving Changes Permanently: `COMMIT`
-- ------------------------------------------------------------

-- * Definition: COMMIT permanently commits and saves all staged changes to the storage engine (InnoDB) and concludes the transaction.
UPDATE customers
SET balance = balance - 1000
WHERE id = 1;

COMMIT;  -- Changes are permanently written to disk!

-- ------------------------------------------------------------
-- 3. Undoing Changes: `ROLLBACK`
-- ------------------------------------------------------------

-- * Definition: ROLLBACK discards all uncommitted changes made in the current transaction and restores the data to its pre-transaction state.

-- * Important: Works **only before `COMMIT`**.
DELETE FROM customers
WHERE id = 5;

ROLLBACK;  -- Data is restored to its previous state; row 5 is NOT deleted!

-- ------------------------------------------------------------
-- 4. Partial Rollback via `SAVEPOINT`
-- ------------------------------------------------------------

-- * Definition: SAVEPOINT creates points within a group of statements to rollback to, allowing partial changes to be undone without discarding the entire transaction.
START TRANSACTION;

-- First operation:
UPDATE accounts SET balance = balance - 500 WHERE acc_id = 101;

-- Create a checkpoint:
SAVEPOINT sp1;

-- Second operation:
UPDATE customers SET balance = 5000 WHERE id = 2;

-- Rollback only the second operation:
ROLLBACK TO sp1;  -- Only changes after sp1 are undone; earlier changes remain active!

-- Finally commit the remaining first operation:
COMMIT;

-- ------------------------------------------------------------
-- 5. Setting Transaction Properties: `SET TRANSACTION`
-- ------------------------------------------------------------

-- * Definition: SET TRANSACTION configures transaction behavior, such as access mode (READ ONLY / READ WRITE) and isolation levels.
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
SET SESSION TRANSACTION ISOLATION LEVEL REPEATABLE READ;

-- ---

-- ------------------------------------------------------------
-- 15.4 Real-World Banking Transaction Example (Atomic Transfer)
-- ------------------------------------------------------------

-- A classic banking scenario transferring \$1,000 from Account 101 to Account 102:
-- Step 1: Begin the transaction
START TRANSACTION;

-- Step 2: Debit money from Sender (Account 101)
UPDATE accounts 
SET balance = balance - 1000 
WHERE acc_id = 101;

-- Step 3: Credit money to Receiver (Account 102)
UPDATE accounts 
SET balance = balance + 1000 
WHERE acc_id = 102;

-- Step 4: Commit both operations together
COMMIT;

-- * Why Transactions are Critical Here:

--   * If a server crash occurs right after Step 2, the money is not lost. The database automatically executes a `ROLLBACK` upon recovery, restoring the \$1,000 back to Account 101.

-- ---

-- ------------------------------------------------------------
-- 15.5 Critical Rules & Constraints of TCL
-- ------------------------------------------------------------

-- * 1. Works Only with DML Commands:

--   * TCL controls **`INSERT`**, **`UPDATE`**, and **`DELETE`**.

-- * 2. Requires Transaction-Supported Storage Engine:

--   * Requires engines like InnoDB in MySQL. Non-transactional engines like MyISAM ignore transactions!

-- * 3. ROLLBACK Does NOT Work After COMMIT:

--   * Once `COMMIT` is executed, the transaction is finalized. `ROLLBACK` has zero effect on committed data.

-- * 4. DDL Commands Trigger an Implicit Commit:

--   * Running any DDL statement (`CREATE`, `ALTER`, `DROP`, `TRUNCATE`, `RENAME`) inside a transaction immediately commits all pending changes automatically. You cannot rollback DDL statements in MySQL.

-- ---

-- ------------------------------------------------------------
-- 15.6 Transaction Isolation Levels & Concurrency Anomalies
-- ------------------------------------------------------------

-- When multiple transactions execute concurrently on the same tables, three common data anomalies can occur:

-- ------------------------------------------------------------
-- 1. The 3 Common Concurrency Problems
-- ------------------------------------------------------------
-- | Problem / Phenomenon | Meaning & Manifestation |
-- | :--- | :--- |
-- | Dirty Read | A transaction reads uncommitted data written by another ongoing transaction (which might later be rolled back). |
-- | Non-Repeatable Read | A transaction re-reads the same row and discovers the data has changed because another transaction committed an `UPDATE` or `DELETE`. |
-- | Phantom Read | A transaction re-executes a range query (`WHERE score > 500`) and finds newly inserted rows committed by another transaction. |

-- ------------------------------------------------------------
-- 2. The 4 ANSI SQL Isolation Levels Matrix
-- ------------------------------------------------------------
-- Isolation levels control how transactions see each other's data:

-- | Isolation Level | Dirty Read | Non-Repeatable Read | Phantom Read | Standard Use Case & Defaults |
-- | :--- | :---: | :---: | :---: | :--- |
-- | **`READ UNCOMMITTED`** | ❌ Allowed | ❌ Allowed | ❌ Allowed | Highest speed, zero consistency; rarely used. |
-- | **`READ COMMITTED`** | ✓ Prevented | ❌ Allowed | ❌ Allowed | Default in Oracle, PostgreSQL, and SQL Server. |
-- | **`REPEATABLE READ`** | ✓ Prevented | ✓ Prevented | ✓ Prevented* | Default in MySQL InnoDB (Next-Key Locking blocks Phantoms). |
-- | **`SERIALIZABLE`** | ✓ Prevented | ✓ Prevented | ✓ Prevented | Strict table/row locking; highest consistency, slowest speed. |

-- ---

-- ------------------------------------------------------------
-- 15.7 Advanced Interview Concepts & Gotchas in TCL / Transaction Management
-- ------------------------------------------------------------

-- ------------------------------------------------------------
-- 1. Autocommit Mode (`@@autocommit`) & Default Session Behavior
-- ------------------------------------------------------------

-- * Q. If you execute an UPDATE statement without running START TRANSACTION, can you roll it back?

-- * Answer & Mechanics:

--   * In MySQL, **`autocommit` is enabled by default (`1`)**.

--   * Every single standalone SQL statement is treated as an independent transaction that is committed to disk immediately upon completion. Therefore, you cannot roll it back unless explicit transaction controls are enabled.

-- * How to Inspect and Control Autocommit:
-- Check current autocommit status (1 = ON, 0 = OFF):
SELECT @@autocommit;

-- Disable autocommit for the current session:
SET autocommit = 0;

-- With autocommit disabled, every DML requires an explicit COMMIT or ROLLBACK:
UPDATE accounts SET balance = balance - 200 WHERE acc_id = 101;
ROLLBACK; -- Successfully rolls back!

-- Re-enable autocommit:
SET autocommit = 1;
--   > [!WARNING]
--   > Production Gotcha: If you set `SET autocommit = 0;` in your session and forget to call `COMMIT` or `ROLLBACK`, open row-level locks remain active indefinitely, causing application connection pools to hang and lock-wait timeouts (`ERROR 1205`) for other users!

-- ---

-- ------------------------------------------------------------
-- 2. The DDL "Implicit Commit" Interview Trap
-- ------------------------------------------------------------

-- * Q. What happens to the 20% salary hike in this transaction? Is it rolled back or saved?
START TRANSACTION;
UPDATE employees SET salary = salary * 1.20 WHERE dept = 'IT';
CREATE TABLE audit_log (id INT PRIMARY KEY, action VARCHAR(50));
ROLLBACK;

-- * Answer: It is permanently saved! It CANNOT be rolled back.

-- * Explanation:

--   * In MySQL (and most relational databases), DDL statements (`CREATE`, `ALTER`, `DROP`, `TRUNCATE`, `RENAME`) trigger an Implicit Commit.

--   * The moment MySQL encounters `CREATE TABLE audit_log`, it immediately and irreversibly executes an internal `COMMIT` on all pending transactional modifications (including the preceding `UPDATE`).

--   * The subsequent `ROLLBACK;` statement has nothing left to revert because the transaction was already closed and finalized by the DDL operation.

-- ---

-- ------------------------------------------------------------
-- 3. Deadlocks in MySQL InnoDB (`ERROR 1213`) & Automatic Cycle Resolution
-- ------------------------------------------------------------

-- * Q. What is a Deadlock in SQL transactions, how does MySQL detect it, and what does it do?

-- * What Causes a Deadlock:

--   * A circular dependency where two or more transactions wait for locks held by each other:

--     1. Transaction 1 locks `Row A` and requests a lock on `Row B`.

--     2. Transaction 2 locks `Row B` and requests a lock on `Row A`.

--     3. Neither can advance; both are blocked waiting for the other.

-- * How InnoDB Resolves Deadlocks:

--   * InnoDB features an active Deadlock Detection Engine that tracks a wait-for lock graph.

--   * When a cycle is discovered, InnoDB automatically selects one transaction as the victim (the transaction that has modified fewer rows or has a smaller undo log).

--   * InnoDB automatically aborts and rolls back the victim transaction, throwing:
-- ┌── (text — not SQL, shown for reference) ──
-- │ ERROR 1213 (40001): Deadlock found when trying to get lock; try restarting transaction
-- └──

-- * Production Best Practice: Always lock tables/rows in a consistent, alphabetical or sorted order across application endpoints, and wrap database calls in retry loops with exponential backoff.

-- ---

-- ------------------------------------------------------------
-- 4. `ROLLBACK TO SAVEPOINT` vs. `RELEASE SAVEPOINT`
-- ------------------------------------------------------------

-- * Q. What is the exact difference between ROLLBACK TO SAVEPOINT and RELEASE SAVEPOINT? Does RELEASE SAVEPOINT commit changes?

-- * Comparison Table:

-- | Feature / Behavior | `ROLLBACK TO SAVEPOINT name;` | `RELEASE SAVEPOINT name;` |
-- | :--- | :--- | :--- |
-- | Data Modifications | Undoes (reverts) changes made after the savepoint | Preserves all data modifications |
-- | Commit Changes? | No (transaction remains open) | No (does NOT commit changes) |
-- | Savepoint Marker | Keeps the savepoint active for further use | Deletes the checkpoint marker from memory |
-- | Use Case | Recovering from a failed sub-task | Freeing server memory resources when checkpoint is no longer needed |

-- * Code Demonstration:
START TRANSACTION;
INSERT INTO orders (id, item) VALUES (1, 'Laptop');
SAVEPOINT sp1;

INSERT INTO orders (id, item) VALUES (2, 'Mouse');

-- Option A: Revert only row 2 (row 1 remains staged):
-- ROLLBACK TO sp1;

-- Option B: Delete the checkpoint marker (both row 1 and row 2 remain staged):
RELEASE SAVEPOINT sp1;

COMMIT; -- Permanently saves both rows!

-- ---

-- ------------------------------------------------------------
-- 5. Concurrency Control: Pessimistic Locking vs. Optimistic Locking
-- ------------------------------------------------------------

-- * Q. How do you prevent race conditions during high-volume checkout (e.g., ticket booking / inventory flash sale)?

-- ------------------------------------------------------------
-- A. Pessimistic Locking (`SELECT ... FOR UPDATE`)
-- ------------------------------------------------------------

-- * Concept: Assumes concurrent collisions are frequent. Locks target rows immediately upon reading until the transaction finishes.

-- * SQL Implementation:
START TRANSACTION;

-- Exclusively locks row id = 101; other transactions cannot read or write with locks:
SELECT stock FROM products WHERE id = 101 FOR UPDATE;

-- Safely decrement stock:
UPDATE products SET stock = stock - 1 WHERE id = 101;

COMMIT; -- Lock is released!

-- * **Shared Lock Variant (`LOCK IN SHARE MODE` / `FOR SHARE`):** Allows other transactions to read, but blocks any other transaction from updating or deleting until completed.

-- ------------------------------------------------------------
-- B. Optimistic Locking (Version Tracking)
-- ------------------------------------------------------------

-- * Concept: Assumes collisions are rare. Does not acquire database-level locks. Instead, uses an integer `version` or timestamp column.

-- * SQL Implementation:
-- Step 1: Read current state and version without locking:
SELECT stock, version FROM products WHERE id = 101;
-- Suppose version = 4, stock = 10

-- Step 2: Update only if version has not changed:
UPDATE products 
SET stock = stock - 1, version = version + 1 
WHERE id = 101 AND version = 4;

-- Step 3: Check Rows Affected:
-- If Rows Affected == 1 -> Success!
-- If Rows Affected == 0 -> Another transaction modified the row concurrently; retry or abort.

-- ---

-- ------------------------------------------------------------
-- 6. Under the Hood: How InnoDB Guarantees Atomicity & Durability (Undo Log vs. Redo Log)
-- ------------------------------------------------------------

-- * Q. How does MySQL InnoDB physically implement Rollback (Atomicity) and Crash Recovery (Durability)?

-- * Direct Comparison:

-- | Component | Storage Role | Guarantees | How it Works |
-- | :--- | :--- | :--- | :--- |
-- | Undo Log | Before-Images (Reverse operations) | Atomicity & MVCC | When you run an `UPDATE`, the old values are recorded in the undo log. If you run `ROLLBACK` or the server crashes mid-transaction, InnoDB replays the undo log in reverse to restore initial data. |
-- | Redo Log (WAL) | After-Images (Write-Ahead Log) | Durability | When you run `COMMIT`, InnoDB writes changes sequentially to the redo log buffer and flushes to disk before updating the actual tablespace `.ibd` files. If power cuts out, crash recovery replays the redo log. |

-- ---

-- ------------------------------------------------------------
-- 7. Can `TRUNCATE` or `DROP` be Rolled Back? (`DELETE` vs. `TRUNCATE` in TCL)
-- ------------------------------------------------------------

-- * Q. Can you rollback a DELETE? Can you rollback a TRUNCATE?

-- * Detailed Breakdown:

--   * **`DELETE`:**

--     * Operates as a DML statement row-by-row.

--     * Every individual row deletion is logged in the Undo Log.

--     * Can be rolled back completely if executed inside an uncommitted transaction (`ROLLBACK;`).

--   * **`TRUNCATE`:**

--     * Operates as a DDL statement. It de-allocates and drops the table data pages and creates empty ones.

--     * It does not write row-by-row before-images to the undo log.

--     * It triggers an Implicit Commit in MySQL.

--     * CANNOT be rolled back under any circumstances in MySQL.

-- ---

-- ------------------------------------------------------------
-- 15.8 Visual Architecture Diagram: TCL Lifecycle & Isolation Levels
-- ------------------------------------------------------------

--   * Left Panel (Transaction Lifecycle):

--     * Displays `START TRANSACTION` opening the atomic block.

--     * Demonstrates `SAVEPOINT sp1` checkpointing.

--     * Highlights the 3 resolution branches: `COMMIT` (permanent disk write), `ROLLBACK` (complete reversal), and `ROLLBACK TO sp1` (selective undo).

--   * Right Panel (Isolation Levels Matrix):

--     * Details the 3 concurrency phenomena (Dirty Read, Non-Repeatable Read, Phantom Read).

--     * Summarizes the 4 ANSI isolation levels with clear visual badges, highlighting MySQL's default `REPEATABLE READ`.

-- ---

-- ---

-- ======================================================================
-- 🎯 Practice Questions (salesdb sample data) — try first, then look at the answer
-- ======================================================================
-- Run 00-Setup-Sample-Data.sql once before this section.

USE salesdb;

-- Q1. COMMIT vs ROLLBACK: change a price and roll it back.
START TRANSACTION;
UPDATE products SET price = 99 WHERE productid = 105;
SELECT price FROM products WHERE productid = 105;   -- 99
ROLLBACK;
SELECT price FROM products WHERE productid = 105;   -- 30 again

-- Q2. SAVEPOINT: keep the first change, undo the second.
START TRANSACTION;
UPDATE orders SET orderstatus = 'Delivered' WHERE orderid = 2;
SAVEPOINT after_order2;
UPDATE orders SET orderstatus = 'Delivered' WHERE orderid = 8;
ROLLBACK TO SAVEPOINT after_order2;
SELECT orderid, orderstatus FROM orders WHERE orderid IN (2, 8);   -- 2 Delivered, 8 Shipped
ROLLBACK;

-- Q3. Is autocommit on?
SELECT @@autocommit;
