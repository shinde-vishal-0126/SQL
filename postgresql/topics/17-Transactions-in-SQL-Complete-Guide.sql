-- ======================================================================
-- Topic 17: Transactions in SQL (Complete Guide)
-- ======================================================================

-- ------------------------------------------------------------
-- 📖 In Simple Words
-- ------------------------------------------------------------

-- * Definition: A transaction is a group of SQL statements treated as one unit of work: either all of them succeed and are saved, or none of them are.

-- * Real-life example: Placing an online order: create the order, reduce stock, take payment — all three or nothing.

-- * Example on salesdb (run 00-Setup-Sample-Data.sql first):
SET search_path TO sales;
BEGIN;
INSERT INTO orders (orderid, productid, customerid, orderdate, sales) VALUES (11, 103, 5, '2025-03-25', 20);
UPDATE customers SET score = COALESCE(score, 0) + 10 WHERE customerid = 5;
ROLLBACK;

-- * Example explained (step by step):
--   1. Anna (customer 5) places her first order and gets 10 bonus points — two changes, one unit.
--   2. Because we end with ROLLBACK, both changes disappear together.
--   3. With COMMIT both would be saved together.

-- > Topics covered: What is a transaction · Why we use transactions · ACID properties · Transaction control commands (`BEGIN`, `COMMIT`, `ROLLBACK`, `SAVEPOINT`, `SET TRANSACTION`) · Transaction states · Autocommit, explicit commit & transactional DDL · Transactions inside PostgreSQL procedures.

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

--   * The intermediate (half-done) state of one transaction should not be visible to others (how strictly depends on the isolation level — Topic 15 and 16).

-- * Durability (permanent after commit)

--   * Once a transaction is committed, its changes are permanent.

--   * Even after a crash or power failure, the committed data remains, because PostgreSQL first writes every change to its WAL (Write-Ahead Log) on disk.

-- * ACID properties make transactions reliable, consistent and safe, even with failures or many users at once.

-- ------------------------------------------------------------
-- 17.4 Transaction Control Commands (How to Start a Transaction)
-- ------------------------------------------------------------

-- * `BEGIN` / `START TRANSACTION` → start a new transaction.

-- * `COMMIT` → save all changes made in the current transaction permanently.

-- * `ROLLBACK` → undo all changes made in the current transaction.

-- * `SAVEPOINT name` → create a checkpoint inside a transaction; later `ROLLBACK TO name` undoes only the work done after that point.

-- * `RELEASE SAVEPOINT name` → remove a savepoint (no data is undone).

-- * `SET TRANSACTION` → set transaction properties, like the isolation level (`SET TRANSACTION ISOLATION LEVEL READ COMMITTED;`) or `READ ONLY`.

-- * Example (all commands together):
BEGIN;
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

-- * 🐘 PostgreSQL view of the Failed state: after an error inside `BEGIN`, psql shows the prompt `postgres=!#` and every next command gives `current transaction is aborted, commands ignored until end of transaction block`. Only `ROLLBACK` (or `ROLLBACK TO SAVEPOINT`) moves it on to Aborted → Terminated.

-- ------------------------------------------------------------
-- 17.6 What is Autocommit in PostgreSQL?
-- ------------------------------------------------------------

-- * Autocommit decides whether each SQL statement is committed automatically.

--   * ON → each statement outside `BEGIN` is its own transaction and is committed right after it runs.

--   * OFF → changes stay pending until you run `COMMIT` or `ROLLBACK`.

-- * In PostgreSQL the server itself always works in autocommit mode. Turning autocommit off is a client feature (psql, JDBC, psycopg). There is no `SET autocommit = 0` on the server.

-- * Commands to control autocommit:
-- psql: check current mode
-- (psql/client command — run it in psql, not in a GUI query tool):
-- \echo :AUTOCOMMIT

-- psql: enable autocommit (default)
-- (psql/client command — run it in psql, not in a GUI query tool):
-- \set AUTOCOMMIT on

-- psql: disable autocommit (manual commit required)
-- (psql/client command — run it in psql, not in a GUI query tool):
-- \set AUTOCOMMIT off

-- JDBC:    conn.setAutoCommit(false);
-- psycopg: conn.autocommit = False   (psycopg is NOT in autocommit mode by default)

-- * Example with autocommit ON (default):
UPDATE accounts SET balance = balance + 500 WHERE account_id = 2;
ROLLBACK;   -- WARNING: there is no transaction in progress

--   * The update is saved immediately — no `COMMIT` needed.

--   * The `ROLLBACK` does nothing because the change was already committed.

-- * Example with autocommit OFF (psql):
-- (psql/client command — run it in psql, not in a GUI query tool):
-- \set AUTOCOMMIT off
UPDATE accounts SET balance = balance - 500 WHERE account_id = 1;
-- Change not yet permanent (psql opened a transaction for you)
ROLLBACK;  -- undo the change
-- or
COMMIT;    -- make the change permanent

--   * With autocommit disabled, you decide when the transaction ends.

-- ------------------------------------------------------------
-- 17.7 Explicit Commit & Transactional DDL (No Implicit Commit in PostgreSQL)
-- ------------------------------------------------------------

-- * Explicit transaction / explicit commit: you start and end the transaction yourself. Even when autocommit is ON, `BEGIN` groups statements until the next `COMMIT` or `ROLLBACK`.
BEGIN;
UPDATE accounts SET balance = balance - 1000 WHERE account_id = 1;
UPDATE accounts SET balance = balance + 1000 WHERE account_id = 2;

COMMIT;  -- save both updates together
-- or
ROLLBACK; -- undo both updates

-- * Implicit commit in PostgreSQL happens only in one case: autocommit ON and a statement is run outside `BEGIN`.

--   * DDL does NOT commit automatically. `CREATE`, `ALTER`, `DROP`, `TRUNCATE` inside `BEGIN` are part of the transaction and can be rolled back.

--   * A few commands cannot run inside a transaction at all (error: `cannot run inside a transaction block`): `CREATE DATABASE`, `DROP DATABASE`, `VACUUM`, `CREATE INDEX CONCURRENTLY`, `ALTER SYSTEM`.

--   * A second `BEGIN` inside an open transaction does not commit anything; it only gives a warning (`there is already a transaction in progress`).

-- * Other databases: MySQL and Oracle commit automatically before/after DDL. PostgreSQL and SQL Server support transactional DDL.

-- * The same "trap" example — safe in PostgreSQL:
BEGIN;
DELETE FROM orders WHERE order_id = 10;
CREATE TABLE temp_backup (id INT);   -- NO implicit commit in PostgreSQL
ROLLBACK;                            -- order 10 is back, and temp_backup does not exist

-- ------------------------------------------------------------
-- 17.8 Transactions with Stored Procedures (PL/pgSQL)
-- ------------------------------------------------------------

-- * In PostgreSQL, a function always runs inside the caller's transaction — it cannot `COMMIT`. A procedure (`CREATE PROCEDURE`, PostgreSQL 11+) called with `CALL` can `COMMIT` / `ROLLBACK` inside it.

-- * Error handling: in PL/pgSQL, any unhandled error automatically rolls back the whole `CALL`. You don't need an `EXIT HANDLER` just to get "all or nothing". Use `EXCEPTION` when you want to log or replace the error:
CREATE OR REPLACE PROCEDURE place_order(p_order_id INT, p_customer_id INT, p_product_id INT, p_qty INT)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO orders (order_id, customer_id, order_date) VALUES (p_order_id, p_customer_id, now());
    INSERT INTO order_items (order_id, product_id, qty) VALUES (p_order_id, p_product_id, p_qty);
    UPDATE products SET stock = stock - p_qty WHERE product_id = p_product_id;

    IF (SELECT stock FROM products WHERE product_id = p_product_id) < 0 THEN
        RAISE EXCEPTION 'Not enough stock for product %', p_product_id;   -- undoes all 3 steps
    END IF;
END;
$$;

CALL place_order(501, 7, 12, 2);

-- * The `EXCEPTION` block works like a savepoint: if an error happens in the `BEGIN` part, everything since that `BEGIN` is undone and the handler runs:
CREATE OR REPLACE PROCEDURE place_order_safe(p_order_id INT, p_customer_id INT, p_product_id INT, p_qty INT)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO orders (order_id, customer_id, order_date) VALUES (p_order_id, p_customer_id, now());
    INSERT INTO order_items (order_id, product_id, qty) VALUES (p_order_id, p_product_id, p_qty);
    UPDATE products SET stock = stock - p_qty WHERE product_id = p_product_id;
EXCEPTION
    WHEN OTHERS THEN
        RAISE NOTICE 'Order % failed: %', p_order_id, SQLERRM;   -- message for the log
        RAISE;   -- send the original error to the caller (like MySQL RESIGNAL)
END;
$$;

-- * Remember: functions and triggers cannot `COMMIT` / `ROLLBACK`; only procedures can (and only when called with `CALL` outside an explicit `BEGIN` block). More examples (money transfer with `FOR UPDATE`) are in Topic 35.

-- * Q1. What happens if you run `ROLLBACK` after an `UPDATE` when autocommit is ON?

--   * Answer: Nothing — with autocommit ON the `UPDATE` was already committed. PostgreSQL only prints `WARNING: there is no transaction in progress`. `ROLLBACK` only undoes work inside an open transaction (`BEGIN`, or psql with `AUTOCOMMIT off`).

-- * Q2. Can you roll back a `TRUNCATE` or `CREATE TABLE` in PostgreSQL?

--   * Answer: Yes, if it runs inside `BEGIN ... ROLLBACK`. PostgreSQL has transactional DDL, so DDL does not commit pending changes either. (In MySQL the answer is No.)

-- * Q3. What is a savepoint? Give a use case.

--   * Answer: A named checkpoint inside a transaction; `ROLLBACK TO sp` undoes only the work after it. Use case: in a multi-item order, undo just the failed item and keep the order.

-- * Q4. How do you make sure a stored procedure does 'all or nothing'?

--   * Answer: In PostgreSQL it is automatic — any unhandled error in a procedure/function rolls back the whole call. Use `RAISE EXCEPTION` to stop on a business rule, and `EXCEPTION WHEN OTHERS THEN ... RAISE;` if you want to log the error first.

-- * Q5. Why should transactions be short?

--   * Answer: Locks are held until COMMIT/ROLLBACK; long transactions block other users, cause lock waits and deadlocks, and stop `VACUUM` from removing old row versions (table bloat).

-- * Commands: `BEGIN`/`START TRANSACTION`, `COMMIT`, `ROLLBACK`, `SAVEPOINT` + `ROLLBACK TO`, `RELEASE SAVEPOINT`, `SET TRANSACTION ISOLATION LEVEL ...`.

-- ---

-- ======================================================================
-- 🎯 Practice Questions (salesdb sample data) — try first, then look at the answer
-- ======================================================================
-- Run 00-Setup-Sample-Data.sql once before this section.

SET search_path TO sales;

-- Q1. Place a new order and reduce nothing else — all inside one transaction, then undo.
BEGIN;
INSERT INTO orders (orderid, productid, customerid, salespersonid, orderdate, orderstatus, quantity, sales)
VALUES (11, 103, 4, 3, '2025-03-20', 'Shipped', 1, 20)
RETURNING *;
ROLLBACK;

-- Q2. Lock a row while you work on it (SELECT ... FOR UPDATE).
BEGIN;
SELECT * FROM products WHERE productid = 104 FOR UPDATE;
UPDATE products SET price = price + 1 WHERE productid = 104;
ROLLBACK;

-- Q3. An error inside a transaction: roll everything back.
BEGIN;
UPDATE customers SET score = 1000 WHERE customerid = 4;
INSERT INTO customers (customerid, firstname) VALUES (4, 'Duplicate');   -- error, transaction aborted
ROLLBACK;
SELECT score FROM customers WHERE customerid = 4;
