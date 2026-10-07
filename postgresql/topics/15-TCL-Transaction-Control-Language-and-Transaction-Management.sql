-- ======================================================================
-- Topic 15: TCL (Transaction Control Language) & Transaction Management
-- ======================================================================

-- ------------------------------------------------------------
-- 📖 In Simple Words
-- ------------------------------------------------------------

-- * Definition: TCL (Transaction Control Language) commands control a transaction: START TRANSACTION / BEGIN starts it, COMMIT saves it, ROLLBACK cancels it, SAVEPOINT marks a point you can go back to.

-- * Real-life example: Like a shopping cart: you add items (changes); Pay = COMMIT, Empty cart = ROLLBACK.

-- * 🧩 Syntax:
--     BEGIN;                      -- or START TRANSACTION
--       ...statements...
--     SAVEPOINT sp_name;
--       ...statements...
--     ROLLBACK TO SAVEPOINT sp_name;
--     COMMIT;                     -- or ROLLBACK;

-- * Syntax explained (each part):
--   - START TRANSACTION / BEGIN → start a group of changes
--   - COMMIT → save all changes permanently
--   - ROLLBACK → cancel all changes since the start
--   - SAVEPOINT / ROLLBACK TO → a checkpoint you can return to without cancelling everything

-- * Example on salesdb (run 00-Setup-Sample-Data.sql first):
SET search_path TO sales;
BEGIN;
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

-- * Definition: TCL (Transaction Control Language) commands decide whether changes are saved permanently (`COMMIT`) or undone (`ROLLBACK`).

--   * Core Formula:
--     $$\text{TCL} = \text{Transaction Control} = \text{Save or Undo Changes}$$

-- ---

-- ------------------------------------------------------------
-- 15.2 What is a Transaction? (ACID Overview)
-- ------------------------------------------------------------

-- * Definition: A Transaction is a group of one or more SQL statements executed as a single, indivisible logical unit of work.

-- * All-or-Nothing Principle: Either all statements succeed, or none of them take effect.

-- * Common Statements in Transactions:

--   * DML statements (`INSERT`, `UPDATE`, `DELETE`) — and in PostgreSQL also most DDL (`CREATE`, `ALTER`, `DROP`, `TRUNCATE`).

-- * The 4 ACID Pillars:

--   * Atomicity (A): The entire transaction either completes successfully or is completely rolled back (no partial execution).

--   * Consistency (C): Takes the database from one valid state to another, maintaining all constraints and schema rules.

--   * Isolation (I): Intermediate transaction states are invisible to other concurrently running transactions.

--   * Durability (D): Once committed, data changes survive permanently on disk even during system failures or power outages.

-- ---

-- ------------------------------------------------------------
-- 15.3 Core TCL Commands: BEGIN, COMMIT, ROLLBACK, SAVEPOINT, SET
-- ------------------------------------------------------------

-- | Command | Action / Role | Effect on Data |
-- | :--- | :--- | :--- |
-- | `BEGIN` / `START TRANSACTION` | Begins a new transaction block | Opens an atomic session |
-- | `COMMIT` (or `END`) | Saves changes permanently | Makes changes visible to others and durable; ends transaction |
-- | `ROLLBACK` (or `ABORT`) | Undoes uncommitted changes | Restores database back to pre-transaction state |
-- | `SAVEPOINT` | Sets an intermediate checkpoint | Allows partial rollback to a specific marker |
-- | `SET TRANSACTION` | Sets transaction properties | Configures isolation level and read-only mode |

-- ------------------------------------------------------------
-- 1. Beginning a Transaction: `BEGIN` / `START TRANSACTION`
-- ------------------------------------------------------------

-- * Definition: BEGIN (or START TRANSACTION) tells PostgreSQL to open a new transaction. In PostgreSQL, `BEGIN` is the most common spelling.
BEGIN;
-- OR
START TRANSACTION;

-- With options in one line:
BEGIN ISOLATION LEVEL REPEATABLE READ;

-- ------------------------------------------------------------
-- 2. Saving Changes Permanently: `COMMIT`
-- ------------------------------------------------------------

-- * Definition: COMMIT permanently saves all changes of the transaction (they are flushed to the WAL on disk) and ends the transaction.
BEGIN;
UPDATE customers
SET balance = balance - 1000
WHERE id = 1;

COMMIT;  -- Changes are permanently saved!

-- ------------------------------------------------------------
-- 3. Undoing Changes: `ROLLBACK`
-- ------------------------------------------------------------

-- * Definition: ROLLBACK discards all uncommitted changes made in the current transaction and restores the data to its pre-transaction state.

-- * Important: Works only before `COMMIT`, and only inside a `BEGIN` block (psql autocommits single statements).
BEGIN;
DELETE FROM customers
WHERE id = 5;

ROLLBACK;  -- Data is restored; row 5 is NOT deleted!

-- ------------------------------------------------------------
-- 4. Partial Rollback via `SAVEPOINT`
-- ------------------------------------------------------------

-- * Definition: SAVEPOINT creates points inside a transaction to roll back to, so part of the work can be undone without discarding the whole transaction.
BEGIN;

-- First operation:
UPDATE accounts SET balance = balance - 500 WHERE acc_id = 101;

-- Create a checkpoint:
SAVEPOINT sp1;

-- Second operation:
UPDATE customers SET balance = 5000 WHERE id = 2;

-- Rollback only the second operation:
ROLLBACK TO sp1;  -- Only changes after sp1 are undone; earlier changes remain!

-- Finally commit the remaining first operation:
COMMIT;

-- ------------------------------------------------------------
-- 5. Setting Transaction Properties: `SET TRANSACTION`
-- ------------------------------------------------------------

-- * Definition: SET TRANSACTION configures the current transaction, such as access mode (READ ONLY / READ WRITE) and isolation level. It must be the first statement after `BEGIN`.
BEGIN;
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
-- ... queries ...
COMMIT;

-- For all following transactions of this session:
SET SESSION CHARACTERISTICS AS TRANSACTION ISOLATION LEVEL REPEATABLE READ;

-- Check the current level:
SHOW transaction_isolation;

-- ---

-- ------------------------------------------------------------
-- 15.4 Real-World Banking Transaction Example (Atomic Transfer)
-- ------------------------------------------------------------

-- A classic banking scenario transferring \$1,000 from Account 101 to Account 102:
-- Step 1: Begin the transaction
BEGIN;

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

--   * If a server crash occurs right after Step 2, the money is not lost. On restart, PostgreSQL replays the WAL; the uncommitted transaction never becomes visible, so the \$1,000 is still in Account 101.

-- ---

-- ------------------------------------------------------------
-- 15.5 Critical Rules & Constraints of TCL (PostgreSQL)
-- ------------------------------------------------------------

-- * 1. Works with DML and Most DDL:

--   * TCL controls `INSERT`, `UPDATE`, `DELETE`, and also `CREATE`, `ALTER`, `DROP`, `TRUNCATE` in PostgreSQL.

-- * 2. Every Table is Transactional:

--   * PostgreSQL has only one storage system, and it is always transactional. (MySQL has non-transactional engines like MyISAM that ignore transactions.)

-- * 3. ROLLBACK Does NOT Work After COMMIT:

--   * Once `COMMIT` is executed, the transaction is finalized. `ROLLBACK` has zero effect on committed data.

-- * 4. DDL Does NOT Commit Automatically:

--   * In PostgreSQL, `CREATE`, `ALTER`, `DROP`, `TRUNCATE` inside `BEGIN ... ROLLBACK` are undone too. Exceptions: `CREATE/DROP DATABASE`, `CREATE INDEX CONCURRENTLY`, `VACUUM` cannot run inside a transaction block.

-- * 5. One Error Aborts the Whole Transaction (PostgreSQL-specific):

--   * If any statement inside a transaction fails, PostgreSQL marks the whole transaction as failed. Every next statement gives:
--     `ERROR: current transaction is aborted, commands ignored until end of transaction block`

--   * You must `ROLLBACK` (or `ROLLBACK TO SAVEPOINT`). Even `COMMIT` will act as a rollback. (MySQL just skips the failed statement and lets you continue.)

--   * Use savepoints to recover from an expected error and continue:
BEGIN;
INSERT INTO orders (id, item) VALUES (1, 'Laptop');
SAVEPOINT before_risky;
INSERT INTO orders (id, item) VALUES (1, 'Duplicate');   -- ERROR: duplicate key
ROLLBACK TO before_risky;                                -- transaction is usable again
INSERT INTO orders (id, item) VALUES (2, 'Mouse');
COMMIT;                                                  -- saves rows 1 and 2

--   * In psql, `\set ON_ERROR_ROLLBACK interactive` does this automatically for every statement.

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
-- | Serialization Anomaly (extra) | The result of running transactions together is different from any one-by-one order (e.g., write skew). Only `SERIALIZABLE` prevents it. |

-- ------------------------------------------------------------
-- 2. The 4 ANSI SQL Isolation Levels in PostgreSQL
-- ------------------------------------------------------------
-- Isolation levels control how transactions see each other's data:

-- | Isolation Level | Dirty Read | Non-Repeatable Read | Phantom Read | PostgreSQL behavior |
-- | :--- | :---: | :---: | :---: | :--- |
-- | `READ UNCOMMITTED` | ✓ Prevented | ❌ Allowed | ❌ Allowed | Accepted, but behaves exactly like `READ COMMITTED` (PostgreSQL never shows dirty data). |
-- | `READ COMMITTED` | ✓ Prevented | ❌ Allowed | ❌ Allowed | DEFAULT in PostgreSQL. Each statement sees a fresh snapshot. |
-- | `REPEATABLE READ` | ✓ Prevented | ✓ Prevented | ✓ Prevented | One snapshot for the whole transaction (Snapshot Isolation). Concurrent update of the same row → error `could not serialize access`; retry. |
-- | `SERIALIZABLE` | ✓ Prevented | ✓ Prevented | ✓ Prevented | Serializable Snapshot Isolation (SSI): no blocking locks, but may abort a transaction with SQLSTATE `40001`; the app must retry. |

-- * Difference from MySQL: MySQL's default is `REPEATABLE READ`; PostgreSQL's default is `READ COMMITTED`.

-- ---

-- ------------------------------------------------------------
-- 15.7 Advanced Interview Concepts & Gotchas in TCL / Transaction Management
-- ------------------------------------------------------------

-- ------------------------------------------------------------
-- 1. Autocommit Mode & Default Session Behavior
-- ------------------------------------------------------------

-- * Q. If you execute an UPDATE statement without running BEGIN, can you roll it back?

-- * Answer & Mechanics:

--   * PostgreSQL (and psql, pgAdmin, most drivers) work in autocommit mode by default.

--   * Every single statement outside a `BEGIN` block is its own transaction and is committed immediately. So you cannot roll it back.

-- * How to Control Autocommit:
-- PostgreSQL has no server-side "SET autocommit = 0".
-- Option 1: use an explicit block
BEGIN;
UPDATE accounts SET balance = balance - 200 WHERE acc_id = 101;
ROLLBACK; -- Successfully rolls back!

-- Option 2: in psql, turn off autocommit for the session
-- (psql/client command — run it in psql, not in a GUI query tool):
-- \set AUTOCOMMIT off
UPDATE accounts SET balance = balance - 200 WHERE acc_id = 101;
ROLLBACK;  -- works, because psql opened a transaction for you
-- (psql/client command — run it in psql, not in a GUI query tool):
-- \set AUTOCOMMIT on

-- Option 3: in drivers, e.g. Python psycopg: conn.autocommit = False (the default there)
--   > [!WARNING]
--   > Production Gotcha: A session that runs `BEGIN` and then waits (app bug, open psql window) is "idle in transaction". It keeps its locks and stops `VACUUM` from cleaning old rows. Protect with `SET idle_in_transaction_session_timeout = '5min';` and watch `pg_stat_activity` (`state = 'idle in transaction'`).

-- ---

-- ------------------------------------------------------------
-- 2. The DDL "Implicit Commit" Interview Trap (Answer is Different in PostgreSQL!)
-- ------------------------------------------------------------

-- * Q. What happens to the 20% salary hike in this transaction? Is it rolled back or saved?
BEGIN;
UPDATE employees SET salary = salary * 1.20 WHERE dept = 'IT';
CREATE TABLE audit_log (id INT PRIMARY KEY, action VARCHAR(50));
ROLLBACK;

-- * Answer in PostgreSQL: Everything is rolled back — the salary update AND the `audit_log` table. Nothing is saved.

-- * Explanation:

--   * PostgreSQL supports transactional DDL. `CREATE TABLE` does not commit anything; it is just another step inside the transaction.

--   * In MySQL the answer is the opposite: `CREATE TABLE` causes an implicit commit, so the salary update is saved and the `ROLLBACK` does nothing.

--   * This is one of the most asked "PostgreSQL vs MySQL" interview questions.

-- ---

-- ------------------------------------------------------------
-- 3. Deadlocks in PostgreSQL & Automatic Resolution
-- ------------------------------------------------------------

-- * Q. What is a Deadlock in SQL transactions, how does PostgreSQL detect it, and what does it do?

-- * What Causes a Deadlock:

--   * A circular dependency where two or more transactions wait for locks held by each other:

--     1. Transaction 1 locks `Row A` and requests a lock on `Row B`.

--     2. Transaction 2 locks `Row B` and requests a lock on `Row A`.

--     3. Neither can advance; both are blocked waiting for the other.

-- * How PostgreSQL Resolves Deadlocks:

--   * When a transaction has waited for a lock longer than `deadlock_timeout` (default 1 second), PostgreSQL runs a deadlock check on the wait-for graph.

--   * If a cycle is found, PostgreSQL aborts one of the transactions (usually the one that ran the check) and rolls it back.

--   * The victim gets:
-- ┌── (text — not SQL, shown for reference) ──
-- │ ERROR:  deadlock detected
-- │ DETAIL: Process 4521 waits for ShareLock on transaction 1001; blocked by process 4522.
-- │         Process 4522 waits for ShareLock on transaction 1000; blocked by process 4521.
-- │ HINT:  See server log for query details.
-- │ SQLSTATE: 40P01
-- └──

-- * Production Best Practice: Always lock rows in a consistent order (e.g., sorted by id) across application code, keep transactions short, and retry on SQLSTATE `40P01` with a small backoff.

-- ---

-- ------------------------------------------------------------
-- 4. `ROLLBACK TO SAVEPOINT` vs. `RELEASE SAVEPOINT`
-- ------------------------------------------------------------

-- * Q. What is the exact difference between ROLLBACK TO SAVEPOINT and RELEASE SAVEPOINT? Does RELEASE SAVEPOINT commit changes?

-- * Comparison Table:

-- | Feature / Behavior | `ROLLBACK TO SAVEPOINT name;` | `RELEASE SAVEPOINT name;` |
-- | :--- | :--- | :--- |
-- | Data Modifications | Undoes changes made after the savepoint | Keeps all data modifications |
-- | Commit Changes? | No (transaction remains open) | No (does NOT commit changes) |
-- | Savepoint Marker | Keeps the savepoint active for further use | Removes the savepoint marker |
-- | Use Case | Recovering from a failed sub-task (also clears the "aborted" state) | Freeing resources when the checkpoint is no longer needed |

-- * Code Demonstration:
BEGIN;
INSERT INTO orders (id, item) VALUES (1, 'Laptop');
SAVEPOINT sp1;

INSERT INTO orders (id, item) VALUES (2, 'Mouse');

-- Option A: Revert only row 2 (row 1 remains):
-- ROLLBACK TO sp1;

-- Option B: Remove the checkpoint marker (both row 1 and row 2 remain):
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
BEGIN;

-- Locks row id = 101; other transactions that want to change or lock it must wait:
SELECT stock FROM products WHERE id = 101 FOR UPDATE;

-- Safely decrement stock:
UPDATE products SET stock = stock - 1 WHERE id = 101;

COMMIT; -- Lock is released!

-- * Note: Plain `SELECT` (without `FOR UPDATE`) is never blocked in PostgreSQL — readers don't wait for writers (MVCC).

-- * Variants in PostgreSQL:

--   * `FOR SHARE`: others can read and also take `FOR SHARE`, but cannot update/delete.

--   * `FOR NO KEY UPDATE` / `FOR KEY SHARE`: lighter locks (used internally by foreign keys).

--   * `FOR UPDATE NOWAIT`: error at once instead of waiting.

--   * `FOR UPDATE SKIP LOCKED`: skip rows that are already locked — perfect for job queues (many workers pick different jobs).

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
WHERE id = 101 AND version = 4
RETURNING version;

-- Step 3: Check Rows Affected:
-- If 1 row returned -> Success!
-- If 0 rows -> Another transaction modified the row concurrently; retry or abort.

-- * PostgreSQL extra: every row has a hidden system column `xmin` (the id of the transaction that wrote it). It can be used as a free version number: `SELECT xmin, * FROM products WHERE id = 101;`

-- ---

-- ------------------------------------------------------------
-- 6. Under the Hood: How PostgreSQL Guarantees Atomicity & Durability (MVCC + WAL)
-- ------------------------------------------------------------

-- * Q. How does PostgreSQL physically implement Rollback (Atomicity) and Crash Recovery (Durability)? (MySQL InnoDB uses an Undo Log and a Redo Log.)

-- * Direct Comparison:

-- | Component | Storage Role | Guarantees | How it Works |
-- | :--- | :--- | :--- | :--- |
-- | MVCC row versions (no undo log) | Old and new row versions live in the table itself | Atomicity & Isolation | An `UPDATE` writes a new row version and keeps the old one. Each row has `xmin`/`xmax` transaction ids. On `ROLLBACK`, PostgreSQL just marks the transaction as aborted in the commit log (`pg_xact`) — the new versions become invisible instantly. That is why rollback is very fast in PostgreSQL. |
-- | WAL (Write-Ahead Log) | Change records in `pg_wal/` | Durability | On `COMMIT`, the WAL records are flushed to disk (`fsync`) before success is returned. Table files are written later by the checkpointer. After a power cut, crash recovery replays the WAL. |
-- | VACUUM | Cleanup | Keeps tables small | Removes dead row versions that no transaction can see anymore (autovacuum runs automatically). |

-- ---

-- ------------------------------------------------------------
-- 7. Can `TRUNCATE` or `DROP` be Rolled Back? (`DELETE` vs. `TRUNCATE` in TCL)
-- ------------------------------------------------------------

-- * Q. Can you rollback a DELETE? Can you rollback a TRUNCATE?

-- * Detailed Breakdown (PostgreSQL):

--   * `DELETE`:

--     * Operates as a DML statement row-by-row.

--     * Each deleted row is only marked as deleted (its `xmax` is set).

--     * Can be rolled back completely inside an uncommitted transaction.

--   * `TRUNCATE`:

--     * Operates as a DDL statement. It gives the table a new empty data file.

--     * The old file is kept until the transaction commits.

--     * ✅ CAN be rolled back in PostgreSQL if run inside `BEGIN ... ROLLBACK`. (In MySQL it cannot.)

--   * `DROP TABLE`: also rollback-able inside a transaction in PostgreSQL.

-- ---

-- ------------------------------------------------------------
-- 15.8 Visual Architecture Diagram: TCL Lifecycle & Isolation Levels
-- ------------------------------------------------------------

--   * Left Panel (Transaction Lifecycle):

--     * Displays `START TRANSACTION` (= `BEGIN` in PostgreSQL) opening the atomic block.

--     * Demonstrates `SAVEPOINT sp1` checkpointing.

--     * Highlights the 3 resolution branches: `COMMIT` (permanent), `ROLLBACK` (complete reversal), and `ROLLBACK TO sp1` (selective undo).

--   * Right Panel (Isolation Levels Matrix):

--     * Details the 3 concurrency phenomena (Dirty Read, Non-Repeatable Read, Phantom Read).

--     * The diagram highlights MySQL's default `REPEATABLE READ`. In PostgreSQL the default is `READ COMMITTED`, and `READ UNCOMMITTED` behaves like `READ COMMITTED`.

-- ---

-- ---

-- ======================================================================
-- 🎯 Practice Questions (salesdb sample data) — try first, then look at the answer
-- ======================================================================
-- Run 00-Setup-Sample-Data.sql once before this section.

SET search_path TO sales;

-- Q1. COMMIT vs ROLLBACK: change a price and roll it back.
BEGIN;
UPDATE products SET price = 99 WHERE productid = 105;
SELECT price FROM products WHERE productid = 105;
ROLLBACK;
SELECT price FROM products WHERE productid = 105;

-- Q2. SAVEPOINT: keep the first change, undo the second.
BEGIN;
UPDATE orders SET orderstatus = 'Delivered' WHERE orderid = 2;
SAVEPOINT after_order2;
UPDATE orders SET orderstatus = 'Delivered' WHERE orderid = 8;
ROLLBACK TO SAVEPOINT after_order2;
SELECT orderid, orderstatus FROM orders WHERE orderid IN (2, 8);
ROLLBACK;

-- Q3. Is autocommit on?
-- psql: \echo :AUTOCOMMIT   (pgAdmin: Auto commit toggle in the Query Tool toolbar)
SELECT current_setting('transaction_isolation') AS isolation;
