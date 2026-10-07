-- ======================================================================
-- Topic 16: ACID Properties & Transaction Isolation Levels
-- ======================================================================

-- ------------------------------------------------------------
-- 📖 In Simple Words
-- ------------------------------------------------------------

-- * Definition: ACID are 4 promises of a transaction: Atomicity (all or nothing), Consistency (rules always hold), Isolation (transactions do not disturb each other), Durability (committed data is never lost). Isolation levels decide how strictly transactions are separated.

-- * Real-life example: A bank transfer: money leaves one account AND reaches the other, or nothing happens; others never see half a transfer; once done, a power cut cannot undo it.

-- * Example on salesdb (run 00-Setup-Sample-Data.sql first):
SET search_path TO sales;
BEGIN;
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
-- 16.3 Transaction Isolation Levels (PostgreSQL)
-- ------------------------------------------------------------

-- * Isolation levels determine how strictly a database handles concurrency problems.

-- 1. READ UNCOMMITTED: In the SQL standard it allows dirty reads. In PostgreSQL it is accepted but works exactly like READ COMMITTED — PostgreSQL never shows uncommitted data.

-- 2. READ COMMITTED (PostgreSQL Default): Fixes Dirty Reads. Each statement sees only data committed before that statement started.

-- 3. REPEATABLE READ: Fixes Dirty, Non-Repeatable and (in PostgreSQL) Phantom reads. The whole transaction sees one snapshot taken at its first query. If two transactions update the same row, the second one fails with `could not serialize access due to concurrent update` and must retry.

-- 4. SERIALIZABLE: Fixes all problems including write skew. PostgreSQL uses Serializable Snapshot Isolation (SSI): it does not make transactions wait in line; instead it watches for dangerous patterns and aborts one transaction with SQLSTATE `40001`. (Safest; the app must retry.)

-- * 🐘 PostgreSQL Notes: (1) PostgreSQL uses MVCC snapshots, not read locks, so readers never block writers and writers never block readers at any level. (2) MySQL's default is `REPEATABLE READ`; PostgreSQL's default is `READ COMMITTED`.

-- * Q1. What does ACID stand for? Explain with one example.

--   * Answer: Atomicity (all or nothing), Consistency (rules always hold), Isolation (transactions don't see each other's half-done work), Durability (committed data survives a crash). Example: a bank transfer debits A and credits B inside one transaction.

-- * Q2. Which isolation level does PostgreSQL use by default, and why?

--   * Answer: `READ COMMITTED`. Each statement gets a fresh snapshot, so it never sees dirty data, and transactions almost never fail with serialization errors — a good balance of safety and simplicity. (MySQL's default is `REPEATABLE READ`.)

-- * Q3. Dirty read vs non-repeatable read vs phantom read?

--   * Answer: Dirty = reading another transaction's uncommitted change; non-repeatable = the same row gives a different value on re-read; phantom = re-running a range query returns new/missing rows.

-- * Q4. How do you check and change the isolation level?

--   * Answer: `SHOW transaction_isolation;` to check. Change for one transaction: `BEGIN ISOLATION LEVEL REPEATABLE READ;`. For the session: `SET SESSION CHARACTERISTICS AS TRANSACTION ISOLATION LEVEL REPEATABLE READ;`. Server default: `ALTER SYSTEM SET default_transaction_isolation = 'repeatable read';`.

-- * Q5. Which isolation level would you pick for a reporting dashboard vs a bank transfer?

--   * Answer: Long report that must see one consistent picture: `REPEATABLE READ` (one snapshot, no locks, never blocks writers) — often with `READ ONLY`. Money transfer: `READ COMMITTED` + `SELECT ... FOR UPDATE` on the rows you change, or `SERIALIZABLE` with a retry loop.

-- * ACID:

-- ---

-- ======================================================================
-- 🧪 Practice Examples (salesdb sample data)
-- ======================================================================
-- First run 00-Setup-Sample-Data.sql once. Then run these one by one (select a statement → execute).
-- pgAdmin: open the Query Tool on database "salesdb".
SET search_path TO sales;

-- A (Atomicity): both changes happen or none.
BEGIN;
UPDATE products SET price = price - 5 WHERE productid = 101;
UPDATE products SET price = price + 5 WHERE productid = 102;
SELECT productid, price FROM products WHERE productid IN (101, 102);
ROLLBACK;
SELECT productid, price FROM products WHERE productid IN (101, 102);   -- back to 10 and 15

-- C (Consistency): a rule violation aborts the transaction.
BEGIN;
INSERT INTO customers (customerid, firstname) VALUES (1, 'Duplicate');  -- error
ROLLBACK;                                      -- in Postgres the whole transaction is now aborted

-- D (Durability): after COMMIT the change survives restarts.
BEGIN;
UPDATE customers SET score = 360 WHERE customerid = 1;
COMMIT;
UPDATE customers SET score = 350 WHERE customerid = 1;   -- put the original value back

-- I (Isolation):
SHOW transaction_isolation;                    -- default read committed
BEGIN TRANSACTION ISOLATION LEVEL REPEATABLE READ;
SELECT score FROM customers WHERE customerid = 2;
COMMIT;

-- Isolation demo — open TWO Query Tool tabs (Session A and Session B):
-- Session A:
--   BEGIN;                                                  -- READ COMMITTED
--   SELECT score FROM sales.customers WHERE customerid = 2; -- 900
-- Session B:
--   UPDATE sales.customers SET score = 999 WHERE customerid = 2;
-- Session A:
--   SELECT score FROM sales.customers WHERE customerid = 2; -- READ COMMITTED: 999 (non-repeatable read)
--   COMMIT;
-- Repeat with BEGIN ISOLATION LEVEL REPEATABLE READ; → Session A keeps seeing 900.
-- Reset:
--   UPDATE sales.customers SET score = 900 WHERE customerid = 2;

-- ======================================================================
-- 🎯 Practice Questions (salesdb sample data) — try first, then look at the answer
-- ======================================================================
-- Run 00-Setup-Sample-Data.sql once before this section.

SET search_path TO sales;

-- Q1. Atomicity: move 5 score points from Kevin (2) to Mary (3) — both or none.
BEGIN;
UPDATE customers SET score = score - 5 WHERE customerid = 2;
UPDATE customers SET score = score + 5 WHERE customerid = 3;
SELECT customerid, score FROM customers WHERE customerid IN (2, 3);
ROLLBACK;

-- Q2. Which isolation level is the session using?
SHOW transaction_isolation;

-- Q3. Run one transaction in SERIALIZABLE level.
BEGIN ISOLATION LEVEL SERIALIZABLE;
SELECT SUM(sales) FROM orders;
COMMIT;
