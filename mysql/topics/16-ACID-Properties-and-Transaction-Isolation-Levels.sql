-- ======================================================================
-- Topic 16: ACID Properties & Transaction Isolation Levels
-- ======================================================================

-- ------------------------------------------------------------
-- 📖 In Simple Words
-- ------------------------------------------------------------

-- * Definition: ACID are 4 promises of a transaction: Atomicity (all or nothing), Consistency (rules always hold), Isolation (transactions do not disturb each other), Durability (committed data is never lost). Isolation levels decide how strictly transactions are separated.

-- * Real-life example: A bank transfer: money leaves one account AND reaches the other, or nothing happens; others never see half a transfer; once done, a power cut cannot undo it.

-- * 🧩 Syntax:
--     SET [SESSION|GLOBAL] TRANSACTION ISOLATION LEVEL
--         READ UNCOMMITTED | READ COMMITTED | REPEATABLE READ | SERIALIZABLE;
--     SELECT @@transaction_isolation;

-- * Syntax explained (each part):
--   - READ UNCOMMITTED → can see other sessions' unsaved changes (dirty reads)
--   - READ COMMITTED → sees only saved data; a re-read can change
--   - REPEATABLE READ → same rows give the same values for the whole transaction (MySQL default)
--   - SERIALIZABLE → strictest; behaves as if transactions ran one after another

-- * Example on salesdb (run 00-Setup-Sample-Data.sql first):
USE salesdb;
START TRANSACTION;
UPDATE customers SET score = score - 100 WHERE customerid = 2;
UPDATE customers SET score = score + 100 WHERE customerid = 3;
COMMIT;
UPDATE customers SET score = 900 WHERE customerid = 2;   -- reset
UPDATE customers SET score = 750 WHERE customerid = 3;   -- reset

-- * Example explained (step by step):
--   1. 100 points move from Kevin (2) to Mary (3) inside one transaction.
--   2. Atomicity: if the second UPDATE failed, the first would also be undone.
--   3. Durability: after COMMIT the new values are saved permanently. The last two lines just put the original values back.

-- ------------------------------------------------------------
-- 16.1 What are ACID Properties?
-- ------------------------------------------------------------
-- ACID guarantees that database transactions are processed reliably.

-- 1. Atomicity (All or Nothing): A transaction is a single unit. Either all statements in the transaction succeed, or none do (Rollback).

-- 2. Consistency: A transaction must take the database from one valid state to another. (e.g., constraints and rules are never violated).

-- 3. Isolation: Concurrent transactions execute independently without interfering with each other.

-- 4. Durability: Once a transaction is committed, it remains saved even if the system crashes or loses power.

-- ------------------------------------------------------------
-- 16.2 Concurrency Problems (Read Phenomena)
-- ------------------------------------------------------------

-- 1. Dirty Read: Reading uncommitted data from another transaction (which might get rolled back later).

-- 2. Non-Repeatable Read: Reading the same row twice in a transaction, but getting different data because someone else UPDATED it in between.

-- 3. Phantom Read: Running the same query twice, but getting a different number of rows because someone else INSERTED/DELETED rows in between.

-- ------------------------------------------------------------
-- 16.3 Transaction Isolation Levels (MySQL InnoDB)
-- ------------------------------------------------------------

-- * Isolation levels determine how strictly a database handles concurrency problems.

-- 1. READ UNCOMMITTED: No isolation. Allows Dirty, Non-Repeatable, and Phantom reads. (Fastest, but dangerous).

-- 2. READ COMMITTED: Fixes Dirty Reads. (You only read committed data).

-- 3. REPEATABLE READ (MySQL Default): Fixes Dirty & Non-Repeatable reads. If you read a row, it stays exactly the same for your entire transaction.

-- 4. SERIALIZABLE: Fixes all problems. Transactions wait in line (lock the tables). (Safest, but slowest).

-- * ⚠️ InnoDB Notes: (1) In MySQL InnoDB, `REPEATABLE READ` also prevents most phantom reads — normal `SELECT`s read from a consistent snapshot (MVCC), and locking reads use next-key (gap) locks. (2) `SERIALIZABLE` in InnoDB locks the rows it reads (shared locks), not whole tables.

-- * Q1. What does ACID stand for? Explain with one example.

--   * Answer: Atomicity (all or nothing), Consistency (rules always hold), Isolation (transactions don't see each other's half-done work), Durability (committed data survives a crash). Example: a bank transfer debits A and credits B inside one transaction.

-- * Q2. Which isolation level does MySQL use by default, and why?

--   * Answer: `REPEATABLE READ`. It gives every transaction a consistent snapshot (MVCC), so re-reading a row gives the same value, and InnoDB's next-key locks also stop most phantom rows — good safety without SERIALIZABLE's cost.

-- * Q3. Dirty read vs non-repeatable read vs phantom read?

--   * Answer: Dirty = reading another transaction's uncommitted change; non-repeatable = the same row gives a different value on re-read; phantom = re-running a range query returns new/missing rows.

-- * Q4. How do you check and change the isolation level?

--   * Answer: `SELECT @@transaction_isolation;` and `SET SESSION TRANSACTION ISOLATION LEVEL READ COMMITTED;` (or `GLOBAL` for new connections).

-- * Q5. Which isolation level would you pick for a reporting dashboard vs a bank transfer?

--   * Answer: Reports: `READ COMMITTED` (never dirty, fewer locks, fresh data per statement). Money transfer: keep `REPEATABLE READ` and lock the rows you change with `SELECT ... FOR UPDATE`; use `SERIALIZABLE` only when you cannot lock explicitly.

-- * ACID:

-- ---

-- ======================================================================
-- 🧪 Practice Examples (salesdb sample data)
-- ======================================================================
-- First run 00-Setup-Sample-Data.sql once. Then run these one by one (select a statement → execute).
USE salesdb;

-- A (Atomicity): both changes happen or none.
START TRANSACTION;
UPDATE products SET price = price - 5 WHERE productid = 101;
UPDATE products SET price = price + 5 WHERE productid = 102;
SELECT productid, price FROM products WHERE productid IN (101, 102);
ROLLBACK;                                     -- undo both
SELECT productid, price FROM products WHERE productid IN (101, 102);   -- back to 10 and 15

-- C (Consistency): a rule violation stops the change. Fails — customerid 1 exists.
START TRANSACTION;
INSERT INTO customers (customerid, firstname) VALUES (1, 'Duplicate');
ROLLBACK;

-- D (Durability): after COMMIT the change survives restarts.
START TRANSACTION;
UPDATE customers SET score = 360 WHERE customerid = 1;
COMMIT;
UPDATE customers SET score = 350 WHERE customerid = 1;   -- put the original value back

-- I (Isolation): check / change the isolation level
SELECT @@transaction_isolation;               -- default REPEATABLE-READ
SET SESSION TRANSACTION ISOLATION LEVEL READ COMMITTED;
SET SESSION TRANSACTION ISOLATION LEVEL REPEATABLE READ;

-- Isolation demo — open TWO query tabs (Session A and Session B):
-- Session A:
--   START TRANSACTION;
--   SELECT score FROM customers WHERE customerid = 2;      -- 900
-- Session B:
--   UPDATE customers SET score = 999 WHERE customerid = 2; -- autocommit
-- Session A:
--   SELECT score FROM customers WHERE customerid = 2;      -- REPEATABLE READ: still 900 (same snapshot)
--   COMMIT;
--   SELECT score FROM customers WHERE customerid = 2;      -- now 999
-- Reset:
--   UPDATE customers SET score = 900 WHERE customerid = 2;

-- ======================================================================
-- 🎯 Practice Questions (salesdb sample data) — try first, then look at the answer
-- ======================================================================
-- Run 00-Setup-Sample-Data.sql once before this section.

USE salesdb;

-- Q1. Atomicity: move 5 score points from Kevin (2) to Mary (3) — both or none.
START TRANSACTION;
UPDATE customers SET score = score - 5 WHERE customerid = 2;
UPDATE customers SET score = score + 5 WHERE customerid = 3;
SELECT customerid, score FROM customers WHERE customerid IN (2, 3);
ROLLBACK;

-- Q2. Which isolation level is the session using?
SELECT @@transaction_isolation;

-- Q3. Run one transaction in SERIALIZABLE level.
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
START TRANSACTION;
SELECT SUM(sales) FROM orders;
COMMIT;
