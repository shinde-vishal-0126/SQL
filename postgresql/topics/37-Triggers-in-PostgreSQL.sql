-- ======================================================================
-- Topic 37: Triggers in PostgreSQL
-- ======================================================================

-- ------------------------------------------------------------
-- 📖 In Simple Words
-- ------------------------------------------------------------

-- * Definition: A trigger is code that runs automatically when an INSERT, UPDATE or DELETE happens on a table — you do not call it yourself.

-- * Real-life example: A burglar alarm: nobody presses it; it rings by itself when the door opens.

-- * 🧩 Syntax:
--     CREATE FUNCTION trg_func() RETURNS trigger LANGUAGE plpgsql AS $$
--     BEGIN
--       -- use OLD.col and NEW.col
--       RETURN NEW;            -- (RETURN OLD for DELETE)
--     END $$;
--     CREATE TRIGGER trigger_name
--     {BEFORE | AFTER} {INSERT | UPDATE | DELETE} ON table_name
--     FOR EACH ROW EXECUTE FUNCTION trg_func();
--     DROP TRIGGER trigger_name ON table_name;

-- * Syntax explained (each part):
--   - BEFORE / AFTER → run before the change (can modify NEW) or after it
--   - INSERT / UPDATE / DELETE → which action fires the trigger
--   - FOR EACH ROW → runs once per changed row
--   - OLD / NEW → row values before / after the change

-- * Example on salesdb (run 00-Setup-Sample-Data.sql first):
SET search_path TO sales;
CREATE TABLE price_history (productid INT, old_price INT, new_price INT);
CREATE OR REPLACE FUNCTION fn_price() RETURNS trigger LANGUAGE plpgsql AS $$
BEGIN
  INSERT INTO price_history VALUES (OLD.productid, OLD.price, NEW.price);
  RETURN NEW;
END $$;
CREATE TRIGGER trg_price AFTER UPDATE ON products
FOR EACH ROW EXECUTE FUNCTION fn_price();
UPDATE products SET price = 12 WHERE productid = 101;
SELECT * FROM price_history;
UPDATE products SET price = 10 WHERE productid = 101;
DROP TRIGGER trg_price ON products;
DROP FUNCTION fn_price();
DROP TABLE price_history;

-- * Example explained (step by step):
--   1. The trigger watches UPDATEs on products.
--   2. When the Bottle price changes 10 → 12, the trigger writes (101, 10, 12) into price_history by itself.
--   3. OLD = value before the change, NEW = value after. The price is then set back and everything is cleaned up.

-- ------------------------------------------------------------
-- 37.1 Why Triggers? (From Procedures to Automatic Actions)
-- ------------------------------------------------------------

-- * With stored procedures we put all our SQL statements in one procedure, but we must execute it manually (`CALL ...`). That is a limitation.

-- * So how about doing it automatically?

--   * Take a table in your database. Things happen to this table: data is inserted, updated or deleted. These happenings are called events.

--   * We can attach a trigger on top of that table. Each time such an event happens, something else runs automatically — for example inserting a row into another table, deciding whether the delete is allowed at all, or raising a warning message.

--   * So, based on any change in the table, we can automatically fire another action using an SQL trigger.

-- ------------------------------------------------------------
-- 37.2 What are Triggers?
-- ------------------------------------------------------------

-- * A trigger is a special kind of stored program that automatically runs ("fires") in response to a specific event on a table.

-- * 🐘 In PostgreSQL a trigger has TWO parts:

--   1. A trigger function — a function that `RETURNS TRIGGER` and contains the logic (written in PL/pgSQL).

--   2. The trigger itself — `CREATE TRIGGER ... EXECUTE FUNCTION trigger_function();` attaches that function to a table and an event.

--   * Benefit: one trigger function can be reused by many triggers on many tables (e.g. one `set_updated_at()` for every table).

-- * It is mainly used to:

--   * enforce business rules,

--   * validate data,

--   * maintain audit logs,

--   * automate tasks.

-- * A trigger is defined by its timing (`BEFORE` / `AFTER` / `INSTEAD OF`), its event (`INSERT`, `UPDATE`, `DELETE`, `TRUNCATE`) and its level (`FOR EACH ROW` / `FOR EACH STATEMENT`).

-- ------------------------------------------------------------
-- 37.3 Trigger Levels (Row-level vs Statement-level)
-- ------------------------------------------------------------

-- * PostgreSQL supports both levels:

--   1. Row-level trigger (`FOR EACH ROW`) – fires once per row affected by the DML statement. Can read `OLD` / `NEW`.

--   2. Statement-level trigger (`FOR EACH STATEMENT`, the default if you don't write anything) – fires once per SQL statement, no matter how many rows (even 0). ✅ Supported in PostgreSQL (MySQL doesn't have it). With "transition tables" (`REFERENCING NEW TABLE AS new_rows`) a statement trigger can still see all changed rows at once.

-- ------------------------------------------------------------
-- 37.4 Key Points About Triggers
-- ------------------------------------------------------------

-- * Automatic execution 👉 runs when the specified event happens (no need to call it manually).

-- * Tied to a table (or a view, with `INSTEAD OF`) 👉 you define a trigger on one specific object.

-- * Event-driven 👉 fires on `INSERT`, `UPDATE` (optionally only `UPDATE OF column`), `DELETE`, `TRUNCATE`.

-- * Timing 👉 runs `BEFORE`, `AFTER` or `INSTEAD OF` the event.

-- * A trigger is like a "hidden automatic rule" that runs when data changes, keeping data consistent, enforcing rules or logging changes.

-- * Return value rule of a row-level trigger function (very important):

--   * `BEFORE` trigger: `RETURN NEW;` → save the (maybe changed) row. `RETURN NULL;` → silently skip this row. For `DELETE` return `OLD`.

--   * `AFTER` trigger: the return value is ignored — write `RETURN NULL;` (or `RETURN NEW;`).

-- * Special variables in a trigger function: `NEW`, `OLD`, `TG_OP` ('INSERT' / 'UPDATE' / 'DELETE' / 'TRUNCATE'), `TG_TABLE_NAME`, `TG_WHEN` ('BEFORE' / 'AFTER'), `TG_LEVEL` ('ROW' / 'STATEMENT').

-- ------------------------------------------------------------
-- 37.5 Syntax of a Trigger
-- ------------------------------------------------------------

-- * Syntax (2 steps):
-- Step 1: the trigger function
CREATE OR REPLACE FUNCTION trigger_function_name()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    -- Trigger logic here (use NEW / OLD)
    RETURN NEW;          -- BEFORE: NEW (or NULL to skip); AFTER: ignored
END;
$$;

-- Step 2: the trigger
CREATE [OR REPLACE] TRIGGER trigger_name
{BEFORE | AFTER | INSTEAD OF} {INSERT | UPDATE [OF col] | DELETE | TRUNCATE} [OR ...]
ON table_name
[FOR EACH ROW | FOR EACH STATEMENT]
[WHEN (condition)]
EXECUTE FUNCTION trigger_function_name();

-- * Explanation:

--   * `RETURNS TRIGGER` → marks the function as a trigger function (it takes no arguments).

--   * `trigger_name` → name of the trigger (unique per table, not per database).

--   * `BEFORE | AFTER | INSTEAD OF` → timing.

--   * `INSERT OR UPDATE OR DELETE` → one trigger can handle several events; check `TG_OP` inside.

--   * `FOR EACH ROW` → row-level; without it the trigger is statement-level.

--   * `WHEN (OLD.salary IS DISTINCT FROM NEW.salary)` → the trigger fires only when the condition is true (cheaper than an `IF` inside).

--   * `EXECUTE FUNCTION` (PostgreSQL 11+; older versions write `EXECUTE PROCEDURE`).

-- * No `DELIMITER` — the function body is in `$$ ... $$`.

-- ------------------------------------------------------------
-- 37.6 Types of Triggers (and Which Databases Support Them)
-- ------------------------------------------------------------

-- | Type | What it does | PostgreSQL | MySQL |
-- | :--- | :--- | :---: | :---: |
-- | DML trigger | Fires on `INSERT`, `UPDATE`, `DELETE` | ✅ | ✅ |
-- | `TRUNCATE` trigger | Fires on `TRUNCATE` (statement-level) | ✅ | ❌ |
-- | DDL trigger | Fires on `CREATE`, `ALTER`, `DROP` | ✅ "event triggers" (`CREATE EVENT TRIGGER`) | ❌ |
-- | Logon trigger | Fires when a user logs in | ❌ (PG 17 has a `login` event trigger) | ❌ |
-- | `INSTEAD OF` trigger | Runs instead of the DML (on views) | ✅ | ❌ |
-- | Row-level trigger | Once per affected row | ✅ | ✅ |
-- | Statement-level trigger | Once per statement | ✅ | ❌ |
-- | Constraint trigger | `AFTER` trigger that can be `DEFERRABLE` (checked at commit) | ✅ | ❌ |

-- ------------------------------------------------------------
-- 37.7 Trigger Timing (BEFORE vs AFTER vs INSTEAD OF)
-- ------------------------------------------------------------

-- * Timing options:

--   * BEFORE – runs before the row is saved. Used for validation or changing values (`NEW.col := ...; RETURN NEW;`).

--   * AFTER – runs after the row is saved. Used for logging, auditing, or updating other tables.

--   * INSTEAD OF – only on views; replaces the `INSERT`/`UPDATE`/`DELETE` on the view with your own logic (e.g., write into the base tables of a join view).

-- ------------------------------------------------------------
-- 37.8 Managing Triggers in PostgreSQL
-- ------------------------------------------------------------

-- (psql/client command — run it in psql, not in a GUI query tool):
-- \d employees                                    -- table details incl. its triggers (psql)
-- (psql/client command — run it in psql, not in a GUI query tool):
-- \dft                                            -- list trigger functions (psql)

SELECT trigger_name, event_manipulation, action_timing, event_object_table
FROM information_schema.triggers;               -- all triggers

SELECT pg_get_triggerdef(oid) FROM pg_trigger WHERE tgname = 'trg_salary_audit';   -- definition

DROP TRIGGER IF EXISTS trg_salary_audit ON employees;     -- the table name is required
ALTER TABLE employees DISABLE TRIGGER trg_salary_audit;   -- turn off temporarily
ALTER TABLE employees ENABLE TRIGGER trg_salary_audit;    -- turn on again
ALTER TRIGGER trg_salary_audit ON employees RENAME TO trg_emp_salary_audit;

-- ------------------------------------------------------------
-- 37.9 How to Modify / Update a Trigger
-- ------------------------------------------------------------

-- * In PostgreSQL:

--   * To change the logic → `CREATE OR REPLACE FUNCTION trigger_function()` — all triggers using it get the new logic immediately.

--   * To change timing/event/table → `CREATE OR REPLACE TRIGGER ...` (PostgreSQL 14+), or `DROP TRIGGER ... ON table;` + `CREATE TRIGGER ...`.

--   * Rename → `ALTER TRIGGER old ON table RENAME TO new;`

-- * Other databases: MySQL — drop and recreate; SQL Server — `ALTER TRIGGER`; Oracle — `CREATE OR REPLACE TRIGGER`.

-- ------------------------------------------------------------
-- 37.10 Use Cases of Triggers (15 Practical Examples)
-- ------------------------------------------------------------

-- * A trigger automatically runs when an event happens on a table. Triggers help automate business logic, enforce rules and maintain data integrity without application code.

-- * Use case 1 | Data Validation — prevent inserting invalid or inconsistent data

--   * Q1. Trigger: Reject inserting orders with an invalid quantity or a missing product.
CREATE OR REPLACE FUNCTION fn_before_insert_validate_data()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    IF NEW.quantity <= 0 THEN
        RAISE EXCEPTION 'QUANTITY MUST BE GREATER THAN ZERO';
    END IF;

    IF NEW.productid IS NULL THEN
        RAISE EXCEPTION 'PRODUCT ID CAN NOT BE NULL';
    END IF;

    RETURN NEW;            -- row is valid → save it
END;
$$;

CREATE TRIGGER t_before_insert_validate_data
BEFORE INSERT ON orders
FOR EACH ROW               -- trigger executes once for every row affected by the INSERT
EXECUTE FUNCTION fn_before_insert_validate_data();

--   * Insert invalid data — the trigger fires automatically and rejects it:
INSERT INTO orders (orderid, productid, customerid, salespersonid, orderdate, shipdate, orderstatus, shipaddress, billaddress, quantity, sales, creationtime)
VALUES (1002,
  101,            -- Valid Product
  201, 301, '2025-10-10', '2025-10-12', 'Pending', '123 Market Street', '123 Market Street',
  0,              -- ❌ Invalid Quantity
  0, now());
-- ERROR:  QUANTITY MUST BE GREATER THAN ZERO

--   * Before inserting a new order, PostgreSQL checks that the quantity is valid and the product exists. If not, the insert fails.

--   * Notes:

--     * `RAISE EXCEPTION` stops the statement with an error (MySQL `SIGNAL SQLSTATE '45000'`). Default SQLSTATE is `P0001`; set your own with `USING ERRCODE = '...'`.

--     * `RETURN NEW;` is required in a BEFORE row trigger — without it (returning NULL) the row is silently skipped.

--     * `FOR EACH ROW` = row-level trigger that works on the `NEW` / `OLD` values of that row.

--     * Simple rules like these are better as `CHECK (quantity > 0)` and `NOT NULL` constraints — use triggers for rules that constraints can't express.

-- * Use case 2 | Default / Derived Values — fill a value when it is empty

--   * Keeps addresses consistent and prevents NULL data.

--   * Q1. Trigger: Automatically copy `shipaddress` into `billaddress` if it's empty.
CREATE OR REPLACE FUNCTION fn_copy_default_billaddress()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    IF NEW.billaddress IS NULL OR NEW.billaddress = '' THEN
        NEW.billaddress := NEW.shipaddress;
    END IF;
    RETURN NEW;
END;
$$;

CREATE TRIGGER t_copy_default_billaddress
BEFORE INSERT ON orders
FOR EACH ROW
EXECUTE FUNCTION fn_copy_default_billaddress();

--   * Instead of keeping a NULL or empty value, we store a default/derived value.
INSERT INTO orders (orderid, productid, customerid, salespersonid, orderdate, shipdate, orderstatus, shipaddress, billaddress, quantity, sales, creationtime)
VALUES (12, 102, 2, 5, '2025-10-11', '2025-10-16', 'Pending', '456 River Drive', NULL, 3, 75, now());
-- billaddress is saved as '456 River Drive'

--   * 🐘 Bonus — the most common PostgreSQL trigger: keep `updated_at` fresh (replaces MySQL `ON UPDATE CURRENT_TIMESTAMP`):
CREATE OR REPLACE FUNCTION set_updated_at()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    NEW.updated_at := now();
    RETURN NEW;
END;
$$;

CREATE TRIGGER trg_customers_updated_at
BEFORE UPDATE ON customers
FOR EACH ROW
EXECUTE FUNCTION set_updated_at();      -- reuse the same function on every table

-- * Use case 3 | Audit / Change Tracking

--   * Q1. Trigger: Track salary changes in employees.
-- First create the audit table
CREATE TABLE employee_salary_audit (
  auditid SERIAL PRIMARY KEY,
  employeeid INT,
  old_salary INT,
  new_salary INT,
  changed_on TIMESTAMPTZ DEFAULT now()
);

CREATE OR REPLACE FUNCTION fn_salary_audit()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO employee_salary_audit (employeeid, old_salary, new_salary, changed_on)
    VALUES (NEW.employeeid, OLD.salary, NEW.salary, now());
    RETURN NULL;           -- AFTER trigger: return value ignored
END;
$$;

CREATE TRIGGER t_salary_audit
AFTER UPDATE OF salary ON employees
FOR EACH ROW
WHEN (OLD.salary IS DISTINCT FROM NEW.salary)    -- fire only when salary really changed
EXECUTE FUNCTION fn_salary_audit();

-- Change the salary
UPDATE employees SET salary = 80000 WHERE employeeid = 4;

-- The change is logged into the audit table
SELECT * FROM employee_salary_audit;

--   * Every time an employee's salary changes, the old and new values are logged. `IS DISTINCT FROM` also handles NULL salaries correctly (`<>` would not).

-- * Use case 4 | Archiving Historical Data

--   * Q1. Trigger: Copy an order into `orders_archive` when its status becomes 'Delivered'.
CREATE OR REPLACE FUNCTION fn_archive_delivered_order()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO orders_archive
      (orderid, productid, customerid, salespersonid, orderdate, shipdate,
       orderstatus, shipaddress, billaddress, quantity, sales, creationtime)
    VALUES
      (NEW.orderid, NEW.productid, NEW.customerid, NEW.salespersonid, NEW.orderdate, NEW.shipdate,
       NEW.orderstatus, NEW.shipaddress, NEW.billaddress, NEW.quantity, NEW.sales, NEW.creationtime);
    RETURN NULL;
END;
$$;

CREATE TRIGGER t_archive_delivered_order
AFTER UPDATE OF orderstatus ON orders
FOR EACH ROW
WHEN (OLD.orderstatus IS DISTINCT FROM 'Delivered' AND NEW.orderstatus = 'Delivered')
EXECUTE FUNCTION fn_archive_delivered_order();

-- Update query
UPDATE orders SET orderstatus = 'Delivered' WHERE orderid = 10;

SELECT * FROM orders_archive;

--   * The values are copied from `NEW`, so the trigger does not need to read the `orders` table again. (Shorter: `INSERT INTO orders_archive SELECT (NEW).*;` if both tables have the same columns.)

-- * Use case 5 | Prevent Deletions

--   * Q1. Trigger: Prevent deleting customers who have orders.
CREATE OR REPLACE FUNCTION fn_prevent_customer_delete()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    IF EXISTS (SELECT 1 FROM orders WHERE customerid = OLD.customerid) THEN
        RAISE EXCEPTION 'CAN NOT DELETE THE CUSTOMER WITH EXISTING ORDER';
    END IF;
    RETURN OLD;            -- for DELETE, return OLD to allow the delete
END;
$$;

CREATE TRIGGER t_prevent_customer_delete
BEFORE DELETE ON customers
FOR EACH ROW
EXECUTE FUNCTION fn_prevent_customer_delete();

-- Check a customer with existing orders
SELECT orderid, customerid, orderstatus FROM orders WHERE customerid = 3;

-- Trying to delete shows: CAN NOT DELETE THE CUSTOMER WITH EXISTING ORDER
DELETE FROM customers WHERE customerid = 3;

-- * Use case 6 | Automatically Update a Related Table

--   * Q1. Trigger: Increase the customer's "score" after each new order.
CREATE OR REPLACE FUNCTION fn_autoupdate_score()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE customers
    SET score = COALESCE(score, 0) + (NEW.sales * 0.1)
    WHERE customerid = NEW.customerid;
    RETURN NULL;
END;
$$;

CREATE TRIGGER t_autoupdate_score
AFTER INSERT ON orders
FOR EACH ROW
EXECUTE FUNCTION fn_autoupdate_score();

-- drop (if you need to remove it)
-- DROP TRIGGER t_autoupdate_score ON orders;

SELECT * FROM customers WHERE customerid = 2;

INSERT INTO orders (orderid, customerid, productid, salespersonid, orderdate, shipdate, orderstatus, shipaddress, billaddress, quantity, sales)
VALUES (111, 2, 104, 3, '2025-10-10', '2025-10-12', 'Pending', '123 Main St', '123 Main St', 2, 2000);
-- customer 2 gets +200 score

-- * Use case 7 | Prevent Unauthorized Field Update

--   * Q1. Trigger: Block updates to `orderdate`.
CREATE OR REPLACE FUNCTION fn_prevent_update_orderdate()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    RAISE EXCEPTION 'ORDER DATE CAN NOT BE UPDATED';
END;
$$;

CREATE TRIGGER t_prevent_update_orderdate
BEFORE UPDATE OF orderdate ON orders
FOR EACH ROW
WHEN (NEW.orderdate IS DISTINCT FROM OLD.orderdate)
EXECUTE FUNCTION fn_prevent_update_orderdate();

-- This update is rejected
UPDATE orders SET orderdate = '2025-02-01' WHERE orderid = 1;

--   * This trigger rejects any update that tries to change the original order date.

-- * Use case 8 | Maintain Derived Totals / Aggregates

--   * Q1. Trigger: Update the employee's total sales when a new order is added.
CREATE OR REPLACE FUNCTION fn_update_employee_sales()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE employees
    SET totalsales = COALESCE(totalsales, 0) + NEW.sales
    WHERE employeeid = NEW.salespersonid;
    RETURN NULL;
END;
$$;

CREATE TRIGGER trg_update_employee_sales
AFTER INSERT ON orders
FOR EACH ROW
EXECUTE FUNCTION fn_update_employee_sales();

-- * Use case 9 | Security / Logging Changes (log who did what)

--   * Q1. Trigger: Log who deleted an order.
SELECT current_user, session_user;

-- First create the delete-log table
CREATE TABLE orders_delete_log (
 logid SERIAL PRIMARY KEY,
 orderid INT,
 deleted_by TEXT,
 deleted_at TIMESTAMPTZ DEFAULT now()
);

CREATE OR REPLACE FUNCTION fn_log_order_delete()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO orders_delete_log (orderid, deleted_by)
    VALUES (OLD.orderid, session_user);   -- the user who connected and ran the DELETE
    RETURN NULL;
END;
$$;

CREATE TRIGGER trg_log_order_delete
AFTER DELETE ON orders
FOR EACH ROW
EXECUTE FUNCTION fn_log_order_delete();

DELETE FROM orders WHERE orderid = 102;

SELECT * FROM orders_delete_log;           -- 102 | vishal | 2025-10-10 ...
SELECT * FROM orders WHERE orderid = 102;  -- no row

-- * Use case 10 | Custom Business Rule

--   * Q1. Trigger: Allow only high-score customers to place expensive orders.
CREATE OR REPLACE FUNCTION fn_check_customer_eligibility()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
DECLARE
    v_cust_score INT;
BEGIN
    SELECT COALESCE(score, 0) INTO v_cust_score
    FROM customers WHERE customerid = NEW.customerid;

    IF NEW.sales > 500 AND COALESCE(v_cust_score, 0) < 500 THEN
        RAISE EXCEPTION '❌ Customer score too low for high-value order.';
    END IF;
    RETURN NEW;
END;
$$;

CREATE TRIGGER trg_check_customer_eligibility
BEFORE INSERT ON orders
FOR EACH ROW
EXECUTE FUNCTION fn_check_customer_eligibility();

-- * Use case 11 | Version History / Data Snapshot

--   * Q1. Trigger: Save the old order record before update.
CREATE OR REPLACE FUNCTION fn_order_version_history()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
  INSERT INTO orders_archive
  (orderid, productid, customerid, salespersonid, orderdate,
   shipdate, orderstatus, shipaddress, billaddress, quantity,
   sales, creationtime)
  VALUES
  (OLD.orderid, OLD.productid, OLD.customerid, OLD.salespersonid,
   OLD.orderdate, OLD.shipdate, OLD.orderstatus, OLD.shipaddress,
   OLD.billaddress, OLD.quantity, OLD.sales, OLD.creationtime);
  RETURN NEW;
END;
$$;

CREATE TRIGGER trg_order_version_history
BEFORE UPDATE ON orders
FOR EACH ROW
EXECUTE FUNCTION fn_order_version_history();

-- * Use case 12 | Enforce Consistency Between Tables

--   * Q1. Trigger: Recalculate order sales when a product price changes.
CREATE OR REPLACE FUNCTION fn_update_orders_on_price_change()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE orders
    SET sales = NEW.price * quantity
    WHERE productid = NEW.productid
      AND orderstatus <> 'Delivered';
    RETURN NULL;
END;
$$;

CREATE TRIGGER trg_update_orders_on_price_change
AFTER UPDATE OF price ON products
FOR EACH ROW
WHEN (OLD.price IS DISTINCT FROM NEW.price)
EXECUTE FUNCTION fn_update_orders_on_price_change();

-- * Use case 13 | Cascading Action

--   * Q1. Trigger: Delete archived orders when a customer is deleted.
CREATE OR REPLACE FUNCTION fn_delete_archived_orders()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    DELETE FROM orders_archive WHERE customerid = OLD.customerid;
    RETURN NULL;
END;
$$;

CREATE TRIGGER t_archived_orders
AFTER DELETE ON customers
FOR EACH ROW
EXECUTE FUNCTION fn_delete_archived_orders();

DELETE FROM customers WHERE customerid = 10;

SELECT * FROM orders_archive WHERE customerid = 10;   -- no rows

-- * Use case 14 | Trigger Notification / Alert

--   * Q1. Trigger: Detect large salary increases (more than 20%).
CREATE TABLE salary_alerts (
  alertid SERIAL PRIMARY KEY,
  employeeid INT,
  old_salary INT,
  new_salary INT,
  alert_message VARCHAR(255),
  created_on TIMESTAMPTZ DEFAULT now()
);

CREATE OR REPLACE FUNCTION fn_update_notification()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO salary_alerts (employeeid, old_salary, new_salary, alert_message)
    VALUES (NEW.employeeid, OLD.salary, NEW.salary, 'SALARY INCREASED BY MORE THAN 20%');

    -- PostgreSQL extra: send a live message to listening apps
    PERFORM pg_notify('salary_alerts', NEW.employeeid::TEXT);
    RETURN NULL;
END;
$$;

CREATE TRIGGER t_update_notification
AFTER UPDATE OF salary ON employees
FOR EACH ROW
WHEN (NEW.salary > OLD.salary * 1.2)
EXECUTE FUNCTION fn_update_notification();

UPDATE employees SET salary = 75000 WHERE employeeid = 2;
SELECT * FROM salary_alerts;

-- * Use case 15 | Data Quality / Standardization

--   * Q1. Trigger: Automatically capitalize customer names.
CREATE OR REPLACE FUNCTION fn_format_customer_names()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    NEW.firstname := INITCAP(NEW.firstname);   -- PostgreSQL built-in: first letter capital
    NEW.lastname  := INITCAP(NEW.lastname);
    RETURN NEW;
END;
$$;

CREATE TRIGGER trg_format_customer_names
BEFORE INSERT OR UPDATE ON customers
FOR EACH ROW
EXECUTE FUNCTION fn_format_customer_names();

INSERT INTO customers (customerid, firstname, lastname, country, score)
VALUES (10, 'vISHAL', 'shINDE', 'India', 500);

SELECT * FROM customers;   -- saved as 'Vishal', 'Shinde'

-- * 🐘 Use case 16 | INSTEAD OF trigger on a view (PostgreSQL only)
CREATE VIEW v_customer_orders AS
SELECT c.customerid, c.firstname, o.orderid, o.sales
FROM customers c JOIN orders o ON o.customerid = c.customerid;

CREATE OR REPLACE FUNCTION fn_v_customer_orders_update()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE customers SET firstname = NEW.firstname WHERE customerid = OLD.customerid;
    UPDATE orders    SET sales = NEW.sales         WHERE orderid = OLD.orderid;
    RETURN NEW;
END;
$$;

CREATE TRIGGER trg_v_customer_orders_update
INSTEAD OF UPDATE ON v_customer_orders
FOR EACH ROW
EXECUTE FUNCTION fn_v_customer_orders_update();

UPDATE v_customer_orders SET sales = 99 WHERE orderid = 1;   -- works on a JOIN view

-- ------------------------------------------------------------
-- 37.11 Summary of Trigger Use Cases
-- ------------------------------------------------------------

-- * Enforce business rules automatically 👉 prevent invalid data (e.g. salary < 0).

-- * Maintain audit trails 👉 log every insert/update/delete into an audit table.

-- * Validate data before saving.

-- * Synchronize tables.

-- * Prevent invalid transactions.

-- * Maintain derived data 👉 update totals in a parent table when child rows change.

-- * Default value handling 👉 fill missing fields, keep `updated_at` fresh.

-- * Security / compliance 👉 track who deleted sensitive records.

-- * Make complex views writable (`INSTEAD OF`) and notify apps (`pg_notify`).

-- ------------------------------------------------------------
-- 37.12 Important Key Points About Triggers in PostgreSQL
-- ------------------------------------------------------------

-- * Supported:

--   * Row-level and statement-level triggers; `BEFORE`, `AFTER`, `INSTEAD OF` (views).

--   * Events: `INSERT`, `UPDATE` (also `UPDATE OF col`), `DELETE`, `TRUNCATE`; several in one trigger with `OR`.

--   * `OLD` and `NEW`, plus `TG_OP`, `TG_TABLE_NAME` etc.; `WHEN (...)` conditions.

--   * Multiple triggers on the same table/event — they fire in alphabetical order of trigger name.

--   * Event triggers for DDL (`CREATE EVENT TRIGGER ... ON ddl_command_end`).

--   * A trigger may modify its own table (no MySQL error 1442) — but watch out for endless recursion (use `WHEN` or `pg_trigger_depth()`).

-- * Not supported / rules:

--   * Manual invocation → triggers cannot be called; they only fire automatically.

--   * `COMMIT` / `ROLLBACK` inside a trigger → not allowed (the trigger is part of the statement's transaction; if it fails, the whole statement fails).

--   * No delayed triggers ("run 1 second after insert"). Use a queue table + a worker, or `pg_cron` (Topic 38).

-- * Triggers vs scheduled jobs: Triggers → work on data events. `pg_cron` jobs → work on time — Topic 38.

-- ------------------------------------------------------------
-- 37.13 Triggers with Programming Logic (Variables, IF, CASE, Loops)
-- ------------------------------------------------------------

-- * These examples show triggers on a sales schema that use PL/pgSQL logic: variables (`DECLARE`, `:=`), `IF / ELSIF / ELSE`, `CASE`, loops (`WHILE`, `FOR`, `EXIT WHEN`), data logging and `BEFORE` / `AFTER` timing.

-- * Trigger using Variables + IF / ELSE

--   * Q1. Create an `AFTER INSERT` trigger that awards bonus points to customers based on product category and sales amount.

--     * category `'Clothing'` → 20 points; `'Accessories'` and sales ≥ 50 → 15 points; otherwise → 5 points.

--     * Add the bonus to the customer's score; treat a NULL score as 0 with `COALESCE()`.
CREATE OR REPLACE FUNCTION fn_after_order_insert_bonus_points()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
DECLARE
    v_bonus    INT := 0;
    v_category VARCHAR(50);
BEGIN
    -- GET THE PRODUCT CATEGORY
    SELECT category INTO v_category
    FROM products
    WHERE productid = NEW.productid;

    -- DETERMINE BONUS POINTS USING IF / ELSE
    IF v_category = 'Clothing' THEN
        v_bonus := 20;
    ELSIF v_category = 'Accessories' AND NEW.sales >= 50 THEN
        v_bonus := 15;
    ELSE
        v_bonus := 5;
    END IF;

    -- UPDATE THE CUSTOMER'S SCORE
    UPDATE customers
    SET score = COALESCE(score, 0) + v_bonus
    WHERE customerid = NEW.customerid;

    RETURN NULL;
END;
$$;

CREATE TRIGGER after_order_insert_bonus_points
AFTER INSERT ON orders
FOR EACH ROW
EXECUTE FUNCTION fn_after_order_insert_bonus_points();

INSERT INTO orders (orderid, productid, customerid, salespersonid, orderdate, shipdate, orderstatus, shipaddress, billaddress, quantity, sales, creationtime)
VALUES (11, 102, 2, 3, '2025-10-10', '2025-10-12', 'Delivered', 'Test Address', 'Test Address', 2, 60, now());

-- * Trigger using a CASE statement

--   * Q1. Assign a default salary based on the department before a new employee is inserted (`'Sales'` → 70000, `'Marketing'` → 60000, `'HR'` → 50000, else 40000); keep a given salary.
CREATE OR REPLACE FUNCTION fn_before_employee_insert_set_department_salary()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
DECLARE
    v_base_salary INT;
BEGIN
    v_base_salary := CASE NEW.department
        WHEN 'Sales'     THEN 70000
        WHEN 'HR'        THEN 50000
        WHEN 'Marketing' THEN 60000
        ELSE 40000
    END;

    IF NEW.salary IS NULL THEN
        NEW.salary := v_base_salary;
    END IF;
    RETURN NEW;
END;
$$;

CREATE TRIGGER before_employee_insert_set_department_salary
BEFORE INSERT ON employees
FOR EACH ROW
EXECUTE FUNCTION fn_before_employee_insert_set_department_salary();

INSERT INTO employees (employeeid, firstname, department, salary)
VALUES (10000, 'Amit Sharma', 'Sales', 899999),     -- salary given → kept
       (20000, 'Priya Patel', 'Marketing', NULL);   -- salary NULL → 60000
SELECT * FROM employees;

-- * Trigger using a LOOP + variable

--   * Q1. Insert one shipment log per unit of the order quantity (quantity = 3 → 3 logs).
DROP TRIGGER IF EXISTS after_order_insert_generate_shipment_logs ON orders;
DROP TABLE IF EXISTS shipment_log;

CREATE TABLE shipment_log (
  logid SERIAL PRIMARY KEY,
  orderid INT,
  piece_no INT,
  created_at TIMESTAMPTZ DEFAULT now()
);

CREATE OR REPLACE FUNCTION fn_generate_shipment_logs()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    FOR i IN 1..NEW.quantity LOOP
        INSERT INTO shipment_log (orderid, piece_no) VALUES (NEW.orderid, i);
    END LOOP;
    -- (one-statement alternative: INSERT ... SELECT NEW.orderid, g FROM generate_series(1, NEW.quantity) g;)
    RETURN NULL;
END;
$$;

CREATE TRIGGER after_order_insert_generate_shipment_logs
AFTER INSERT ON orders
FOR EACH ROW
EXECUTE FUNCTION fn_generate_shipment_logs();

INSERT INTO orders (orderid, productid, customerid, salespersonid, orderdate, shipdate, orderstatus, shipaddress, billaddress, quantity, sales, creationtime)
VALUES (100, 101, 2, 3, '2025-04-01', '2025-04-05', 'Processing', '123 Elm St', '456 Oak St', 3, 30, now());

SELECT * FROM shipment_log;   -- 3 rows: piece 1, 2, 3

-- * Trigger using IF and CASE together + logging

--   * Q1. Log every real salary change with a reason ('Salary Increment' / 'Salary Reduction').
CREATE TABLE IF NOT EXISTS salary_change_log (
  logid SERIAL PRIMARY KEY,
  employeeid INT,
  old_salary INT,
  new_salary INT,
  change_reason VARCHAR(100),
  logged_at TIMESTAMPTZ DEFAULT now()
);

CREATE OR REPLACE FUNCTION fn_before_employee_update_audit_salary()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
DECLARE
    v_reason VARCHAR(100);
BEGIN
    IF OLD.salary IS DISTINCT FROM NEW.salary THEN
        v_reason := CASE
            WHEN NEW.salary > OLD.salary THEN 'Salary Increment'
            WHEN NEW.salary < OLD.salary THEN 'Salary Reduction'
            ELSE 'No Change'
        END;

        INSERT INTO salary_change_log (employeeid, old_salary, new_salary, change_reason)
        VALUES (OLD.employeeid, OLD.salary, NEW.salary, v_reason);
    END IF;
    RETURN NEW;
END;
$$;

CREATE TRIGGER before_employee_update_audit_salary
BEFORE UPDATE ON employees
FOR EACH ROW
EXECUTE FUNCTION fn_before_employee_update_audit_salary();

UPDATE employees SET salary = 65000 WHERE employeeid = 1;   -- logged
UPDATE employees SET salary = 48000 WHERE employeeid = 3;   -- logged
UPDATE employees SET salary = 65000 WHERE employeeid = 1;   -- same salary again → not logged

-- * Trigger using a variable + nested IF (data cleanup)

--   * Q1. Fill default shipping/billing addresses from the customer's country when they are missing.
CREATE OR REPLACE FUNCTION fn_before_order_insert_null_address_check()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
DECLARE
    v_country VARCHAR(50);
BEGIN
    SELECT country INTO v_country
    FROM customers
    WHERE customerid = NEW.customerid;

    IF NEW.shipaddress IS NULL OR NEW.shipaddress = '' THEN
        NEW.shipaddress := 'Default Shipping - ' || v_country;
    END IF;

    IF NEW.billaddress IS NULL OR NEW.billaddress = '' THEN
        NEW.billaddress := 'Default Billing - ' || v_country;
    END IF;
    RETURN NEW;
END;
$$;

CREATE TRIGGER before_order_insert_null_address_check
BEFORE INSERT ON orders
FOR EACH ROW
EXECUTE FUNCTION fn_before_order_insert_null_address_check();

INSERT INTO orders (orderid, customerid, shipaddress, billaddress, orderdate)
VALUES (101, 1, NULL, '', '2025-10-10');
-- saved as 'Default Shipping - Germany', 'Default Billing - Germany'

-- * Trigger using a loop + conditional exit (advanced)

--   * Q1. Issue up to 3 loyalty vouchers to a new customer if score ≥ 300; codes like `VCHR5_1`.
CREATE TABLE IF NOT EXISTS loyalty_vouchers (
  voucherid SERIAL PRIMARY KEY,
  customerid INT,
  voucher_code VARCHAR(20),
  issued_at TIMESTAMPTZ DEFAULT now()
);

CREATE OR REPLACE FUNCTION fn_generate_loyalty_vouchers()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
DECLARE
    i INT := 1;
    v_max_vouchers INT := 3;
BEGIN
    WHILE i <= v_max_vouchers LOOP
        -- Stop issuing vouchers if customer score too low
        EXIT WHEN COALESCE(NEW.score, 0) < 300;     -- MySQL: LEAVE label

        INSERT INTO loyalty_vouchers (customerid, voucher_code)
        VALUES (NEW.customerid, 'VCHR' || NEW.customerid || '_' || i);

        i := i + 1;
    END LOOP;
    RETURN NULL;
END;
$$;

CREATE TRIGGER after_customer_insert_generate_loyalty_vouchers
AFTER INSERT ON customers
FOR EACH ROW
EXECUTE FUNCTION fn_generate_loyalty_vouchers();

INSERT INTO customers (customerid, firstname, lastname, country, score)
VALUES (10, 'Amit', 'Patel', 'India', 900);
-- loyalty_vouchers gets VCHR10_1, VCHR10_2, VCHR10_3

--   * `EXIT WHEN` needs no label (labels like `<<voucher_loop>>` are optional, for nested loops).

-- * Q1. BEFORE vs AFTER trigger — when do you use each?

--   * Answer: BEFORE to validate or change `NEW` values before saving (must `RETURN NEW`); AFTER to log or update other tables once the row is saved.

-- * Q2. What are OLD and NEW?

--   * Answer: Row variables: OLD = values before the change (UPDATE, DELETE), NEW = values after (INSERT, UPDATE). In BEFORE triggers NEW can be modified with `:=`.

-- * Q3. How is a PostgreSQL trigger different from a MySQL trigger?

--   * Answer: PostgreSQL needs a separate trigger function (`RETURNS TRIGGER`) + `CREATE TRIGGER ... EXECUTE FUNCTION`; supports statement-level, `INSTEAD OF`, `TRUNCATE`, `WHEN` conditions, transition tables and DDL event triggers; can enable/disable triggers; a trigger may modify its own table.

-- * Q4. Why are too many triggers considered bad practice?

--   * Answer: Hidden logic (hard to debug), extra work on every write (slower bulk loads), and chains of triggers make behaviour unpredictable. Keep them small; for bulk loads you can `DISABLE TRIGGER` temporarily.

-- * Q5. How do you stop an invalid insert from a trigger?

--   * Answer: `RAISE EXCEPTION '...';` in a BEFORE INSERT trigger — the whole statement fails. (`RETURN NULL;` would skip the row silently instead.)

-- ---

-- ======================================================================
-- 🎯 Practice Questions (salesdb sample data) — try first, then look at the answer
-- ======================================================================
-- Run 00-Setup-Sample-Data.sql once before this section.

SET search_path TO sales;

-- Q1. Audit table + AFTER UPDATE trigger on products.price.
CREATE TABLE price_log (productid INT, old_price INT, new_price INT, changed_at TIMESTAMP);
CREATE OR REPLACE FUNCTION fn_price_log() RETURNS trigger LANGUAGE plpgsql AS $$
BEGIN
  IF OLD.price <> NEW.price THEN
    INSERT INTO price_log VALUES (OLD.productid, OLD.price, NEW.price, now());
  END IF;
  RETURN NEW;
END $$;
CREATE TRIGGER trg_price_log AFTER UPDATE ON products
FOR EACH ROW EXECUTE FUNCTION fn_price_log();

-- Q2. Fire the trigger and read the log, then restore the price.
UPDATE products SET price = 12 WHERE productid = 101;
SELECT * FROM price_log;
UPDATE products SET price = 10 WHERE productid = 101;

-- Q3. Clean up.
DROP TRIGGER trg_price_log ON products;
DROP FUNCTION fn_price_log();
DROP TABLE price_log;
