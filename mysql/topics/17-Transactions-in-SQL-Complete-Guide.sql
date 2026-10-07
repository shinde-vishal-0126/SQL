-- ======================================================================
-- Topic 17: Transactions in SQL (Complete Guide)
-- ======================================================================

-- ------------------------------------------------------------
-- 📖 In Simple Words
-- ------------------------------------------------------------

-- * Definition: A transaction is a group of SQL statements treated as one unit of work: either all of them succeed and are saved, or none of them are.

-- * Real-life example: Placing an online order: create the order, reduce stock, take payment — all three or nothing.

-- * 🧩 Syntax:
--     START TRANSACTION;
--       INSERT ...;
--       UPDATE ...;
--       -- on error: ROLLBACK;
--     COMMIT;

-- * Syntax explained (each part):
--   - One unit → every statement between START and COMMIT succeeds together or is undone together
--   - COMMIT → end and save
--   - ROLLBACK → end and undo

-- * Example on salesdb (run 00-Setup-Sample-Data.sql first):
USE salesdb;
START TRANSACTION;
INSERT INTO orders (orderid, productid, customerid, orderdate, sales) VALUES (11, 103, 5, '2025-03-25', 20);
UPDATE customers SET score = IFNULL(score, 0) + 10 WHERE customerid = 5;
ROLLBACK;

-- * Example explained (step by step):
--   1. Anna (customer 5) places her first order and gets 10 bonus points — two changes, one unit.
--   2. Because we end with ROLLBACK, both changes disappear together.
--   3. With COMMIT both would be saved together.

-- > Topics covered: What is a transaction · Why we use transactions · ACID properties · Transaction control commands (`START TRANSACTION`, `COMMIT`, `ROLLBACK`, `SAVEPOINT`, `SET TRANSACTION`) · Transaction states · Autocommit, implicit & explicit commit · Transactions inside stored procedures.

-- ------------------------------------------------------------
-- 17.1 What is a Transaction?
-- ------------------------------------------------------------

-- * A transaction is a sequence of one or more SQL operations (such as `INSERT`, `UPDATE`, `DELETE`) that are executed as a single unit of work.

--   * Either all operations succeed → the changes are saved (`COMMIT`),

--   * or, if something fails, all operations are undone (`ROLLBACK`).

-- * This ensures data consistency and integrity:

--   * If all operations in the transaction succeed, the changes are committed to the database.

--   * If any operation fails, the entire transaction can be rolled back.

-- * Use cases:

--   * Bank transfer – deduct from one account and credit another.

--   * Order processing – update inventory, place the order and generate the invoice.

--   * User registration – insert into several related tables (user, profile, settings).

-- * Analogy: A transaction is like a group project — if one person fails, everyone fails. But in a database we can at least roll back and try again.

-- ------------------------------------------------------------
-- 17.2 Why Do We Use Transactions?
-- ------------------------------------------------------------

-- * Transactions are very important whenever you need data accuracy, integrity and consistency. They are used to:

--   1. Ensure data integrity – prevent partial updates when something fails.

--      * Example: when you transfer money between two accounts, you don't want only the debit to happen without the credit.

--   2. Group multiple queries into a single unit – useful when several operations must succeed or fail together.

--      * Example: inserting an order and its order details.

--   3. Error handling & recovery – if an error occurs (power failure, query failure), you can `ROLLBACK` to return the database to a consistent state.

--   4. Concurrency control – make sure many users working on the same data don't cause conflicts.

--      * Example: two users withdrawing from the same account at the same time.

--   5. Maintain business rules – rules like "total debit = total credit" always stay true.

--   6. Durability of changes – once committed, changes are permanent and survive crashes.

-- * The use of transactions is to protect data from corruption, keep it consistent, and run many operations safely as one unit.

-- ------------------------------------------------------------
-- 17.3 Transaction Properties (ACID)
-- ------------------------------------------------------------

-- * Transaction properties are known as the ACID properties. They define how a transaction must behave to keep data reliable.

-- * Atomicity (all or nothing)

--   * All steps of a transaction are treated as a single unit. If one step fails, the entire transaction fails.

--   * Either all operations succeed or none are applied — if one part fails, the whole transaction is rolled back.

-- * Consistency (valid state → valid state)

--   * The database moves from one valid state to another valid state.

--   * The database must be valid before and after the transaction.

--   * Database rules (constraints, foreign keys, triggers) must always hold.

-- * Isolation (no interference)

--   * Transactions run independently, even when many run at the same time.

--   * Multiple transactions can run together, but they must not interfere with each other.

--   * The intermediate (half-done) state of one transaction should not be visible to others (how strictly depends on the isolation level — Topic 15 and 15).

-- * Durability (permanent after commit)

--   * Once a transaction is committed, its changes are permanent.

--   * Even after a crash or power failure, the committed data remains, because InnoDB first writes every change to its redo log on disk.

-- * ACID properties make transactions reliable, consistent and safe, even with failures or many users at once.

-- ------------------------------------------------------------
-- 17.4 Transaction Control Commands (How to Start a Transaction)
-- ------------------------------------------------------------

-- * `START TRANSACTION` / `BEGIN` → start a new transaction.

-- * `COMMIT` → save all changes made in the current transaction permanently.

-- * `ROLLBACK` → undo all changes made in the current transaction.

-- * `SAVEPOINT name` → create a checkpoint inside a transaction; later `ROLLBACK TO name` undoes only the work done after that point.

-- * `RELEASE SAVEPOINT name` → remove a savepoint (no data is undone).

-- * `SET TRANSACTION` → set transaction properties, like the isolation level (`SET TRANSACTION ISOLATION LEVEL READ COMMITTED;`) or `READ ONLY`.

-- * Example (all commands together):
START TRANSACTION;
INSERT INTO orders (order_id, customer_id, amount) VALUES (501, 7, 1200);
SAVEPOINT after_order;

INSERT INTO order_items (order_id, product_id, qty) VALUES (501, 99, 1);  -- wrong product
ROLLBACK TO after_order;   -- undo only the wrong item, the order stays

INSERT INTO order_items (order_id, product_id, qty) VALUES (501, 12, 1);
COMMIT;                    -- order 501 + correct item saved permanently

-- ------------------------------------------------------------
-- 17.5 Transaction States (5 States in DBMS)
-- ------------------------------------------------------------

-- * Active – the initial state of every transaction. The transaction is running and can read and write data.

-- * Partially Committed – the transaction enters this state after its final operation has executed, but the changes are not yet permanent.

-- * Committed – all operations finished successfully and `COMMIT` made the changes permanent in the database.

-- * Failed – an error happened before completion (query error, constraint violation, crash), so the transaction cannot continue.

--   * Aborted – after failing, the transaction is rolled back and the database returns to the state before the transaction started (then it can be restarted or killed).

-- * Terminated – the final state: the transaction is finished, either committed or aborted, and the system is ready for the next transaction.

-- * Flow: Active → Partially Committed → Committed → Terminated, or Active / Partially Committed → Failed → Aborted → Terminated.

-- ------------------------------------------------------------
-- 17.6 What is Autocommit in SQL?
-- ------------------------------------------------------------

-- * Autocommit is a session mode that decides whether each SQL statement is committed automatically.

--   * `autocommit = 1` (ON) → each statement is its own transaction and is committed right after it runs.

--   * `autocommit = 0` (OFF) → changes stay pending until you run `COMMIT` or `ROLLBACK`.

-- * In MySQL, autocommit is ON by default (`autocommit = 1`).

-- * Commands to control autocommit:
-- Check current mode
SELECT @@autocommit;

-- Enable autocommit (default in MySQL)
SET autocommit = 1;

-- Disable autocommit (manual commit required)
SET autocommit = 0;

-- * Example with autocommit = 1 (ON):
SET autocommit = 1;
UPDATE Accounts SET balance = balance + 500 WHERE account_id = 2;

--   * The update is saved immediately — no `COMMIT` needed.

--   * If you run `ROLLBACK;` afterwards, nothing happens, because the change was already committed.

-- * Example with autocommit = 0 (OFF):
SET autocommit = 0;
UPDATE Accounts SET balance = balance - 500 WHERE account_id = 1;
-- Change not yet permanent
ROLLBACK;  -- undo the change
-- or
COMMIT;    -- make the change permanent

--   * With autocommit disabled, you decide when the transaction ends.

-- ------------------------------------------------------------
-- 17.7 Explicit vs Implicit Commit
-- ------------------------------------------------------------

-- * Explicit transaction / explicit commit: you start and end the transaction yourself. Even when autocommit is ON, `START TRANSACTION` (or `BEGIN`) temporarily switches autocommit off until the next `COMMIT` or `ROLLBACK`.
SET autocommit = 1;

START TRANSACTION;   -- or BEGIN;
UPDATE Accounts SET balance = balance - 1000 WHERE account_id = 1;
UPDATE Accounts SET balance = balance + 1000 WHERE account_id = 2;

COMMIT;  -- save both updates together
-- or
ROLLBACK; -- undo both updates

-- * Implicit commit: MySQL commits automatically, without you writing `COMMIT`:

--   * after every statement when autocommit is ON, and

--   * before and after DDL statements (`CREATE`, `ALTER`, `DROP`, `TRUNCATE`, `RENAME`) — also `START TRANSACTION`, `LOCK TABLES` and user/privilege commands — even inside an open transaction.

--   * So in MySQL a `CREATE TABLE` is committed immediately and cannot be rolled back, and it also commits any pending changes made before it.

-- * Other databases: Oracle behaves like MySQL (DDL commits), but PostgreSQL and SQL Server support transactional DDL — a `CREATE TABLE` inside a transaction can be rolled back there.

-- * Example of the trap:
START TRANSACTION;
DELETE FROM orders WHERE order_id = 10;
CREATE TABLE temp_backup (id INT);   -- implicit COMMIT happens here
ROLLBACK;                            -- too late: the DELETE is already permanent

-- ------------------------------------------------------------
-- 17.8 Transactions with Stored Procedures
-- ------------------------------------------------------------

-- * A stored procedure can start, commit and roll back a transaction itself, so the application only runs one `CALL` and the "all or nothing" rule is guaranteed inside the database.

-- * Always add an **`EXIT HANDLER`** that rolls back, so a failed step never leaves half of the work saved:
DELIMITER //
CREATE PROCEDURE PlaceOrder(IN p_order_id INT, IN p_customer_id INT, IN p_product_id INT, IN p_qty INT)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;   -- undo everything done so far
        RESIGNAL;   -- report the original error to the caller
    END;

    START TRANSACTION;

    INSERT INTO orders (order_id, customer_id, order_date) VALUES (p_order_id, p_customer_id, NOW());
    INSERT INTO order_items (order_id, product_id, qty) VALUES (p_order_id, p_product_id, p_qty);
    UPDATE products SET stock = stock - p_qty WHERE product_id = p_product_id;

    COMMIT;
END //
DELIMITER ;

CALL PlaceOrder(501, 7, 12, 2);

-- * Remember: a function or a trigger cannot use `COMMIT` / `ROLLBACK` — only procedures (and plain SQL sessions) can. More procedure examples (money transfer with `FOR UPDATE`) are in Topic 35.

-- * **Q1. What happens if you run `ROLLBACK` after an `UPDATE` when autocommit is ON?**

--   * Answer: Nothing — with autocommit ON the `UPDATE` was already committed. `ROLLBACK` only undoes work inside an open transaction (`START TRANSACTION` or autocommit = 0).

-- * **Q2. Can you roll back a `TRUNCATE` or `CREATE TABLE` in MySQL?**

--   * Answer: No. DDL causes an implicit commit before and after it, so it cannot be rolled back — and it also commits any pending changes made before it.

-- * Q3. What is a savepoint? Give a use case.

--   * Answer: A named checkpoint inside a transaction; `ROLLBACK TO sp` undoes only the work after it. Use case: in a multi-item order, undo just the failed item and keep the order.

-- * Q4. How do you make sure a stored procedure does 'all or nothing'?

--   * Answer: Wrap the statements in `START TRANSACTION ... COMMIT` and declare `DECLARE EXIT HANDLER FOR SQLEXCEPTION BEGIN ROLLBACK; RESIGNAL; END;`.

-- * Q5. Why should transactions be short?

--   * Answer: Locks are held until COMMIT/ROLLBACK; long transactions block other users, cause lock-wait timeouts and deadlocks, and keep old row versions (undo log) alive.

-- * Commands: `START TRANSACTION`/`BEGIN`, `COMMIT`, `ROLLBACK`, `SAVEPOINT` + `ROLLBACK TO`, `RELEASE SAVEPOINT`, `SET TRANSACTION ISOLATION LEVEL ...`.

-- ---

-- ======================================================================
-- 🎯 Practice Questions (salesdb sample data) — try first, then look at the answer
-- ======================================================================
-- Run 00-Setup-Sample-Data.sql once before this section.

USE salesdb;

-- Q1. Place a new order and reduce nothing else — all inside one transaction, then undo.
START TRANSACTION;
INSERT INTO orders (orderid, productid, customerid, salespersonid, orderdate, orderstatus, quantity, sales)
VALUES (11, 103, 4, 3, '2025-03-20', 'Shipped', 1, 20);
SELECT * FROM orders WHERE orderid = 11;
ROLLBACK;

-- Q2. Lock a row while you work on it (SELECT ... FOR UPDATE).
START TRANSACTION;
SELECT * FROM products WHERE productid = 104 FOR UPDATE;
UPDATE products SET price = price + 1 WHERE productid = 104;
ROLLBACK;

-- Q3. An error inside a transaction: roll everything back.
START TRANSACTION;
UPDATE customers SET score = 1000 WHERE customerid = 4;
INSERT INTO customers (customerid, firstname) VALUES (4, 'Duplicate');   -- error
ROLLBACK;                                                               -- score of 4 stays 500
SELECT score FROM customers WHERE customerid = 4;
