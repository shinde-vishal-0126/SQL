-- ======================================================================
-- Topic 18: Deadlocks in SQL
-- ======================================================================

-- ------------------------------------------------------------
-- 📖 In Simple Words
-- ------------------------------------------------------------

-- * Definition: A deadlock happens when two transactions each hold a lock the other one needs, so both wait forever. The database detects it and cancels one of them.

-- * Real-life example: Two cars on a narrow bridge from opposite sides — neither can move until one reverses.

-- * Example on salesdb (run 00-Setup-Sample-Data.sql first):
SET search_path TO sales;
-- Tab A: BEGIN; UPDATE products SET price = price + 1 WHERE productid = 101;
-- Tab B: BEGIN; UPDATE products SET price = price + 1 WHERE productid = 102;
-- Tab A: UPDATE products SET price = price + 1 WHERE productid = 102;   -- waits for B
-- Tab B: UPDATE products SET price = price + 1 WHERE productid = 101;   -- deadlock detected → one is aborted
-- Then ROLLBACK; in both tabs.
SHOW deadlock_timeout;

-- * Example explained (step by step):
--   1. A locks product 101, B locks product 102.
--   2. Then A wants 102 (held by B) and B wants 101 (held by A) — a circle, nobody can continue.
--   3. The database kills one transaction with a deadlock error so the other can finish. Fix: always lock rows in the same order.

-- ------------------------------------------------------------
-- 18.1 What is a Deadlock?
-- ------------------------------------------------------------

-- * Definition: A deadlock occurs when two or more transactions are waiting for each other to release locks. They get stuck in an infinite wait, and neither can proceed.

-- * Example:

--   * Transaction A locks Row 1 and needs Row 2.

--   * Transaction B locks Row 2 and needs Row 1.

--   * Result: Deadlock! The Database Engine steps in, kills one transaction (the "victim"), and lets the other finish.

-- * Example in PostgreSQL (two psql windows):
-- Session A
BEGIN;
UPDATE accounts SET balance = balance - 100 WHERE acc_id = 1;   -- locks row 1

-- Session B
BEGIN;
UPDATE accounts SET balance = balance - 100 WHERE acc_id = 2;   -- locks row 2

-- Session A
UPDATE accounts SET balance = balance + 100 WHERE acc_id = 2;   -- waits for B

-- Session B
UPDATE accounts SET balance = balance + 100 WHERE acc_id = 1;   -- waits for A → deadlock!
-- After ~1 second one session gets:
-- ERROR:  deadlock detected   (SQLSTATE 40P01)

-- ------------------------------------------------------------
-- 18.2 How to Prevent Deadlocks?
-- ------------------------------------------------------------

-- 1. Always access tables and rows in the same order across all transactions (e.g., always lock the smaller `acc_id` first).

-- 2. Keep transactions as short and fast as possible.

-- 3. Add proper Indexes so queries run faster and release locks quicker. Index foreign key columns too (PostgreSQL does not do it automatically).

-- 4. Lock everything you need at the start: `SELECT ... FROM accounts WHERE acc_id IN (1, 2) ORDER BY acc_id FOR UPDATE;`

-- 5. Use `lock_timeout` / `NOWAIT` so a session gives up instead of waiting forever.

-- * Q1. What is a deadlock and how does PostgreSQL resolve it?

--   * Answer: Two transactions each hold a lock the other needs. When a session has waited longer than `deadlock_timeout` (default 1 s), PostgreSQL checks the wait-for graph; if it finds a cycle, it aborts one transaction with `ERROR: deadlock detected` (SQLSTATE `40P01`) and the other continues.

-- * Q2. Deadlock vs lock wait timeout?

--   * Answer: A deadlock is a cycle, detected and broken automatically (`40P01`). A lock timeout happens when one transaction simply waits longer than `lock_timeout` for a lock someone else holds (`ERROR: canceling statement due to lock timeout`, SQLSTATE `55P03`). In PostgreSQL `lock_timeout` is 0 (wait forever) by default.

-- * Q3. How do you find the cause of the last deadlock?

--   * Answer: PostgreSQL writes the full deadlock report (both process ids and their queries) to the server log. Turn on `log_lock_waits = on` to also log any wait longer than `deadlock_timeout`. The counter `SELECT deadlocks FROM pg_stat_database;` shows how many happened.

-- * Q4. Your application gets deadlocks — what do you do?

--   * Answer: Retry the failed transaction in the application (on SQLSTATE `40P01`); access rows/tables in the same order; keep transactions short; add indexes so fewer rows are locked; lock all needed rows up front with `ORDER BY ... FOR UPDATE`.

-- ---

-- ======================================================================
-- 🎯 Practice Questions (salesdb sample data) — try first, then look at the answer
-- ======================================================================
-- Run 00-Setup-Sample-Data.sql once before this section.

SET search_path TO sales;

-- Q1. Lock rows always in the same order (prevents deadlocks).
BEGIN;
SELECT * FROM customers WHERE customerid IN (2, 3) ORDER BY customerid FOR UPDATE;
UPDATE customers SET score = score + 1 WHERE customerid = 2;
UPDATE customers SET score = score + 1 WHERE customerid = 3;
ROLLBACK;

-- Q2. How long does a session wait for a lock?
SHOW deadlock_timeout;
SHOW lock_timeout;

-- Q3. Where do you see deadlock details?
SELECT datname, deadlocks FROM pg_stat_database WHERE datname = current_database();
