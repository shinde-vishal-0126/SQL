-- ======================================================================
-- Topic 18: Deadlocks in SQL
-- ======================================================================

-- ------------------------------------------------------------
-- 📖 In Simple Words
-- ------------------------------------------------------------

-- * Definition: A deadlock happens when two transactions each hold a lock the other one needs, so both wait forever. The database detects it and cancels one of them.

-- * Real-life example: Two cars on a narrow bridge from opposite sides — neither can move until one reverses.

-- * Example on salesdb (run 00-Setup-Sample-Data.sql first):
USE salesdb;
-- Tab A: START TRANSACTION; UPDATE products SET price = price + 1 WHERE productid = 101;
-- Tab B: START TRANSACTION; UPDATE products SET price = price + 1 WHERE productid = 102;
-- Tab A: UPDATE products SET price = price + 1 WHERE productid = 102;   -- waits for B
-- Tab B: UPDATE products SET price = price + 1 WHERE productid = 101;   -- deadlock → one is rolled back
-- Then ROLLBACK; in both tabs.
SHOW ENGINE INNODB STATUS;

-- * Example explained (step by step):
--   1. A locks product 101, B locks product 102.
--   2. Then A wants 102 (held by B) and B wants 101 (held by A) — a circle, nobody can continue.
--   3. The database kills one transaction with a deadlock error so the other can finish. Fix: always lock rows in the same order.

-- ------------------------------------------------------------
-- 18.1 What is a Deadlock?
-- ------------------------------------------------------------

-- * Definition: A deadlock occurs when two or more transactions are waiting for each other to release locks. They get stuck in an infinite wait, and neither can proceed.

-- * Example: 

--   * Transaction A locks Table 1 and needs Table 2.

--   * Transaction B locks Table 2 and needs Table 1.

--   * Result: Deadlock! The Database Engine steps in, kills one transaction (the "victim"), and lets the other finish.

-- ------------------------------------------------------------
-- 18.2 How to Prevent Deadlocks?
-- ------------------------------------------------------------

-- 1. Always access tables in the same order across all transactions.

-- 2. Keep transactions as short and fast as possible.

-- 3. Add proper Indexes so queries run faster and release locks quicker.

-- 4. Use a lower Isolation Level if appropriate (e.g., READ COMMITTED).

-- * Q1. What is a deadlock and how does MySQL resolve it?

--   * Answer: Two transactions each hold a lock the other needs. InnoDB detects the cycle immediately, rolls back the transaction with less work (error 1213) and lets the other continue.

-- * Q2. Deadlock vs lock wait timeout?

--   * Answer: A deadlock is a cycle, detected and broken instantly (1213). A lock wait timeout (error 1205) happens when one transaction simply waits longer than `innodb_lock_wait_timeout` (default 50 s) for a lock someone else holds.

-- * Q3. How do you find the cause of the last deadlock?

--   * Answer: `SHOW ENGINE INNODB STATUS;` → section 'LATEST DETECTED DEADLOCK' shows both transactions, their statements and locks. Turn on `innodb_print_all_deadlocks` to log every deadlock.

-- * Q4. Your application gets deadlocks — what do you do?

--   * Answer: Retry the failed transaction in the application; access rows/tables in the same order; keep transactions short; add indexes so fewer rows are locked; consider `READ COMMITTED` to reduce gap locks.

-- ---

-- ======================================================================
-- 🧪 Practice Examples (salesdb sample data)
-- ======================================================================
-- First run 00-Setup-Sample-Data.sql once. Then run these one by one (select a statement → execute).
USE salesdb;

-- Deadlock demo — open TWO query tabs and run the steps in this order.
-- Step 1 (Session A):
--   START TRANSACTION;
--   UPDATE products SET price = price + 1 WHERE productid = 101;   -- A locks row 101
-- Step 2 (Session B):
--   START TRANSACTION;
--   UPDATE products SET price = price + 1 WHERE productid = 102;   -- B locks row 102
-- Step 3 (Session A):
--   UPDATE products SET price = price + 1 WHERE productid = 102;   -- A waits for B
-- Step 4 (Session B):
--   UPDATE products SET price = price + 1 WHERE productid = 101;   -- B waits for A → DEADLOCK
--   → MySQL rolls one back: Error 1213: Deadlock found when trying to get lock
-- Step 5: ROLLBACK; in both tabs.

-- See the last deadlock (section "LATEST DETECTED DEADLOCK"):
SHOW ENGINE INNODB STATUS;

-- Lock wait timeout (error 1205) setting:
SELECT @@innodb_lock_wait_timeout;

-- Prevention: always lock rows in the same order (101 then 102) in every transaction.
START TRANSACTION;
SELECT * FROM products WHERE productid IN (101, 102) ORDER BY productid FOR UPDATE;
UPDATE products SET price = price + 1 WHERE productid = 101;
UPDATE products SET price = price + 1 WHERE productid = 102;
ROLLBACK;

-- ======================================================================
-- 🎯 Practice Questions (salesdb sample data) — try first, then look at the answer
-- ======================================================================
-- Run 00-Setup-Sample-Data.sql once before this section.

USE salesdb;

-- Q1. Lock rows always in the same order (prevents deadlocks).
START TRANSACTION;
SELECT * FROM customers WHERE customerid IN (2, 3) ORDER BY customerid FOR UPDATE;
UPDATE customers SET score = score + 1 WHERE customerid = 2;
UPDATE customers SET score = score + 1 WHERE customerid = 3;
ROLLBACK;

-- Q2. How long does a session wait for a lock?
SELECT @@innodb_lock_wait_timeout;

-- Q3. Where do you see deadlock details?
SHOW ENGINE INNODB STATUS;
