-- ======================================================================
-- Topic 37: Triggers in MySQL
-- ======================================================================

-- ------------------------------------------------------------
-- 📖 In Simple Words
-- ------------------------------------------------------------

-- * Definition: A trigger is code that runs automatically when an INSERT, UPDATE or DELETE happens on a table — you do not call it yourself.

-- * Real-life example: A burglar alarm: nobody presses it; it rings by itself when the door opens.

-- * 🧩 Syntax:
--     DELIMITER //
--     CREATE TRIGGER trigger_name
--     {BEFORE | AFTER} {INSERT | UPDATE | DELETE} ON table_name
--     FOR EACH ROW
--     BEGIN
--       -- use OLD.col (before change) and NEW.col (after change)
--     END //
--     DELIMITER ;
--     DROP TRIGGER trigger_name;

-- * Syntax explained (each part):
--   - BEFORE / AFTER → run before the change (can modify NEW) or after it
--   - INSERT / UPDATE / DELETE → which action fires the trigger
--   - FOR EACH ROW → runs once per changed row
--   - OLD / NEW → row values before / after the change

-- * Example on salesdb (run 00-Setup-Sample-Data.sql first):
USE salesdb;
CREATE TABLE price_history (productid INT, old_price INT, new_price INT);
CREATE TRIGGER trg_price AFTER UPDATE ON products
FOR EACH ROW INSERT INTO price_history VALUES (OLD.productid, OLD.price, NEW.price);
UPDATE products SET price = 12 WHERE productid = 101;
SELECT * FROM price_history;
UPDATE products SET price = 10 WHERE productid = 101;
DROP TRIGGER trg_price;
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

-- * A trigger is a special kind of stored program (a set of SQL statements) that automatically runs ("fires") in response to a specific event on a table.

-- * In MySQL, a trigger is a database object that is executed automatically when an `INSERT`, `UPDATE` or `DELETE` happens on a particular table. It is an automatic action that happens in response to changes in the table.

-- * It is mainly used to:

--   * enforce business rules,

--   * validate data,

--   * maintain audit logs,

--   * automate tasks.

-- * A trigger is defined by its timing (when it fires: `BEFORE` / `AFTER`) and its event (which operation fires it: `INSERT`, `UPDATE`, `DELETE`).

-- ------------------------------------------------------------
-- 37.3 Trigger Levels (Row-level vs Statement-level)
-- ------------------------------------------------------------

-- * Most relational databases (Oracle, SQL Server, PostgreSQL) have two levels of triggers:

--   1. Row-level trigger – fires once per row affected by the DML statement. ✅ This is the only level MySQL supports (`FOR EACH ROW`).

--   2. Statement-level trigger – fires once per SQL statement, no matter how many rows are affected. ❌ Not supported in MySQL.

-- ------------------------------------------------------------
-- 37.4 Key Points About Triggers
-- ------------------------------------------------------------

-- * Automatic execution 👉 runs when the specified event happens (no need to call it manually).

-- * Tied to a table 👉 you define a trigger on one specific table (in MySQL, not on views).

-- * Event-driven 👉 fires automatically on `INSERT`, `UPDATE` or `DELETE`.

-- * Timing 👉 runs `BEFORE` or `AFTER` the event.

-- * A trigger is like a "hidden automatic rule" that runs when data changes, keeping data consistent, enforcing rules or logging changes.

-- * Events: `INSERT`, `UPDATE`, `DELETE`.

-- * Fire timing:

--   * `BEFORE` → `INSERT`, `UPDATE`, `DELETE`

--   * `AFTER` → `INSERT`, `UPDATE`, `DELETE`

--   * So there are 6 combinations per table (e.g. `BEFORE INSERT`, `AFTER DELETE`).

-- * Two levels of triggers: Row level 👉 once for each affected row · Statement level 👉 once per SQL statement (not in MySQL).

-- * **Important — `OLD` and `NEW`:** Inside a row-level trigger you can read two special row references (they are not real tables; SQL Server uses the pseudo-tables `inserted` and `deleted` instead):

--   * `OLD` 👉 the row before the change (available in `UPDATE`, `DELETE`).

--   * `NEW` 👉 the row after the change (available in `INSERT`, `UPDATE`); in a `BEFORE` trigger you can even change it with `SET NEW.col = ...`.

-- ------------------------------------------------------------
-- 37.5 Syntax of a Trigger
-- ------------------------------------------------------------

-- * Syntax:
DELIMITER $$
CREATE TRIGGER trigger_name
{BEFORE | AFTER} {INSERT | UPDATE | DELETE}
ON table_name
FOR EACH ROW
BEGIN
    -- Trigger logic here
END $$
DELIMITER ;

-- * Explanation:

--   * `trigger_name` → unique name of the trigger.

--   * `BEFORE | AFTER` → whether the trigger runs before or after the event.

--   * `INSERT | UPDATE | DELETE` → type of DML operation.

--   * `table_name` → table on which the trigger is created.

--   * `FOR EACH ROW` → row-level trigger (runs once for each affected row) — MySQL supports only this.

--   * `BEGIN … END` → needed when the trigger has more than one statement.

--   * Special references: `NEW.column_name` → new value (after insert/update); `OLD.column_name` → old value (before update/delete).

-- * Note on DELIMITER: A trigger body contains `;`, so we temporarily change the delimiter (e.g. `DELIMITER $$`) so MySQL doesn't stop early, and reset it with `DELIMITER ;` after creating the trigger.

-- ------------------------------------------------------------
-- 37.6 Types of Triggers (and Which Databases Support Them)
-- ------------------------------------------------------------

-- | Type | What it does | MySQL | Others |
-- | :--- | :--- | :---: | :--- |
-- | DML trigger | Fires on `INSERT`, `UPDATE`, `DELETE` on a table | ✅ | SQL Server, Oracle, PostgreSQL |
-- | DDL trigger | Fires on `CREATE`, `ALTER`, `DROP` | ❌ | SQL Server, Oracle (PostgreSQL: "event triggers") |
-- | Logon / Logoff trigger | Fires when a user logs in or out | ❌ | Oracle, SQL Server |
-- | INSTEAD OF trigger | Runs instead of the DML statement (mostly on views) | ❌ | SQL Server, Oracle, PostgreSQL |
-- | Compound trigger | Several timing points (BEFORE / AFTER) in one trigger | ❌ | Oracle |
-- | Row-level trigger | Once per affected row | ✅ | SQL Server (via inserted/deleted), Oracle, PostgreSQL |
-- | Statement-level trigger | Once per statement | ❌ | SQL Server, Oracle, PostgreSQL |

-- ------------------------------------------------------------
-- 37.7 Trigger Timing in MySQL (BEFORE vs AFTER)
-- ------------------------------------------------------------

-- * MySQL supports only row-level triggers with two timing options:

--   * BEFORE – executes before the DML operation. Used for validation or changing values before they are saved (`SET NEW.col = ...`).

--   * AFTER – executes after the DML operation. Used for logging, auditing, or updating other tables (the row is already saved, `NEW` can no longer be changed).

-- ------------------------------------------------------------
-- 37.8 Managing Triggers in MySQL
-- ------------------------------------------------------------

SHOW TRIGGERS;                                            -- all triggers in the current database
SHOW TRIGGERS FROM db_name;                               -- triggers of a specific database
SHOW TRIGGERS FROM db_name WHERE `Table` = 'employees';   -- triggers of one table
SHOW CREATE TRIGGER trigger_name;                         -- full definition of one trigger
DROP TRIGGER IF EXISTS trigger_name;                      -- delete a trigger

-- * `ALTER TRIGGER` 👉 MySQL doesn't support altering a trigger directly — you must drop and recreate it.

-- ------------------------------------------------------------
-- 37.9 How to Modify / Update a Trigger
-- ------------------------------------------------------------

-- * In MySQL — you cannot directly modify a trigger. Unlike some other databases, MySQL has no `ALTER TRIGGER` (and no `CREATE OR REPLACE TRIGGER`).

--   * Correct process:

--     1. Drop the existing trigger 👉 `DROP TRIGGER IF EXISTS trg_order_audit;`

--     2. Recreate it with the new logic (`CREATE TRIGGER trg_order_audit ...`).

-- * Other databases:

--   * SQL Server — you can modify a trigger directly with `ALTER TRIGGER` (no need to drop it).

--   * Oracle — use `CREATE OR REPLACE TRIGGER`; it replaces the trigger in a single statement.

--   * PostgreSQL — a trigger calls a trigger function, so to change the logic you usually update the function with `CREATE OR REPLACE FUNCTION` (PostgreSQL 14+ also has `CREATE OR REPLACE TRIGGER`).

-- ------------------------------------------------------------
-- 37.10 Use Cases of Triggers (15 Practical Examples)
-- ------------------------------------------------------------

-- * A trigger automatically runs when an event (`INSERT`, `UPDATE`, `DELETE`) happens on a table. Triggers help automate business logic, enforce rules and maintain data integrity without application code.

-- * Use case 1 | Data Validation — prevent inserting invalid or inconsistent data

--   * Q1. Trigger: Reject inserting orders with an invalid quantity or a missing product.
DELIMITER $$

CREATE TRIGGER T_before_insert_validate_data
BEFORE INSERT
ON orders
FOR EACH ROW   -- trigger executes once for every row affected by the INSERT
BEGIN
    IF NEW.quantity <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'QUANTITY MUST BE GREATER THAN ZERO';
    END IF;

    IF NEW.productid IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'PRODUCT ID CAN NOT BE NULL';
    END IF;
END $$

DELIMITER ;

--   * Insert invalid data — the trigger fires automatically and rejects it:
INSERT INTO orders (orderid, productid, customerid, salespersonid, orderdate, shipdate, orderstatus, shipaddress, billaddress, quantity, sales, creationtime)
VALUES (1002,
  101,            -- Valid Product
  201, 301, '2025-10-10', '2025-10-12', 'Pending', '123 Market Street', '123 Market Street',
  0,              -- ❌ Invalid Quantity
  0, NOW());
-- Error 1644: QUANTITY MUST BE GREATER THAN ZERO

--   * Before inserting a new order, MySQL checks that the quantity is valid and the product exists. If not, the insert fails.

--   * Notes:

--     * `SIGNAL` raises an error manually inside a stored program (trigger, procedure, function). When the condition is not valid, `SIGNAL` stops the statement and returns an error message.

--     * `SQLSTATE` is a 5-character error code in SQL-standard format. `'45000'` is the generic code for an "unhandled user-defined exception" — the standard choice for custom validation errors. (Codes starting with `40` mean transaction rollback, so don't use `'40000'` for validation.)

--     * `SET MESSAGE_TEXT = '...'` sets the custom error message shown to the user.

--     * `FOR EACH ROW` tells MySQL the trigger runs once for every row affected by the statement (row-level trigger) and works on the `NEW` / `OLD` values of that row.

--     * `NEW.column` = value being inserted/updated; `OLD.column` = existing value before update/delete.

-- * Use case 2 | Default / Derived Values — fill a value when it is empty

--   * Keeps addresses consistent and prevents NULL data.

--   * **Q1. Trigger: Automatically copy `shipaddress` into `billaddress` if it's empty.**
DELIMITER $$

CREATE TRIGGER T_copy_default_billaddress
BEFORE INSERT
ON orders
FOR EACH ROW
BEGIN
    IF NEW.billaddress IS NULL OR NEW.billaddress = '' THEN
        SET NEW.billaddress = NEW.shipaddress;
    END IF;
END $$

DELIMITER ;

--   * Instead of keeping a NULL or empty value, we store a default/derived value.
INSERT INTO orders (orderid, productid, customerid, salespersonid, orderdate, shipdate, orderstatus, shipaddress, billaddress, quantity, sales, creationtime)
VALUES (12, 102, 2, 5, '2025-10-11', '2025-10-16', 'Pending', '456 River Drive', NULL, 3, 75, NOW());
-- billaddress is saved as '456 River Drive'

-- * Use case 3 | Audit / Change Tracking

--   * Q1. Trigger: Track salary changes in employees.
-- First create the audit table
CREATE TABLE employee_salary_audit (
  auditid INT AUTO_INCREMENT PRIMARY KEY,
  employeeid INT,
  old_salary INT,
  new_salary INT,
  changed_on TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DELIMITER $$

CREATE TRIGGER T_salary_audit
AFTER UPDATE
ON employees
FOR EACH ROW
BEGIN
    IF OLD.salary <> NEW.salary THEN
        INSERT INTO employee_salary_audit (employeeid, old_salary, new_salary, changed_on)
        VALUES (NEW.employeeid, OLD.salary, NEW.salary, NOW());
    END IF;
END $$

DELIMITER ;

-- Change the salary
UPDATE employees SET salary = 80000 WHERE employeeid = 4;

-- The change is logged into the audit table
SELECT * FROM employee_salary_audit;

--   * Every time an employee's salary changes, the old and new values are logged.

-- * Use case 4 | Archiving Historical Data

--   * **Q1. Trigger: Copy an order into `orders_archive` when its status becomes 'Delivered'.**
DELIMITER $$

CREATE TRIGGER T_archive_delivered_order
AFTER UPDATE
ON orders
FOR EACH ROW
BEGIN
    IF OLD.orderstatus <> 'Delivered' AND NEW.orderstatus = 'Delivered' THEN
        INSERT INTO orders_archive
          (orderid, productid, customerid, salespersonid, orderdate, shipdate,
           orderstatus, shipaddress, billaddress, quantity, sales, creationtime)
        VALUES
          (NEW.orderid, NEW.productid, NEW.customerid, NEW.salespersonid, NEW.orderdate, NEW.shipdate,
           NEW.orderstatus, NEW.shipaddress, NEW.billaddress, NEW.quantity, NEW.sales, NEW.creationtime);
    END IF;
END $$

DELIMITER ;

-- Update query
UPDATE orders SET orderstatus = 'Delivered' WHERE orderid = 10;

SELECT * FROM orders_archive;

--   * The values are copied from `NEW`, so the trigger does not need to read the `orders` table again.

-- * Use case 5 | Prevent Deletions

--   * Q1. Trigger: Prevent deleting customers who have orders.
DELIMITER $$

CREATE TRIGGER T_prevent_customer_delete
BEFORE DELETE
ON customers
FOR EACH ROW
BEGIN
    IF (SELECT COUNT(*) FROM orders WHERE customerid = OLD.customerid) > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'CAN NOT DELETE THE CUSTOMER WITH EXISTING ORDER';
    END IF;
END $$

DELIMITER ;
-- If the customer has any linked orders, deletion is blocked.

-- Check a customer with existing orders
SELECT orderid, customerid, orderstatus
FROM orders
WHERE customerid = 3;

-- Trying to delete shows: CAN NOT DELETE THE CUSTOMER WITH EXISTING ORDER
DELETE FROM customers WHERE customerid = 3;

-- * Use case 6 | Automatically Update a Related Table

--   * Q1. Trigger: Increase the customer's "score" after each new order.
DELIMITER $$

CREATE TRIGGER T_autoupdate_score
AFTER INSERT
ON orders
FOR EACH ROW
BEGIN
    UPDATE customers
    SET score = IFNULL(score, 0) + (NEW.sales * 0.1)
    WHERE customerid = NEW.customerid;
END$$

DELIMITER ;

-- drop (if you need to remove it)
-- DROP TRIGGER T_autoupdate_score;

SELECT * FROM customers WHERE customerid = 2;

-- Insert the data
INSERT INTO orders (orderid, customerid, productid, salespersonid, orderdate, shipdate, orderstatus, shipaddress, billaddress, quantity, sales)
VALUES (111, 2, 104, 3, '2025-10-10', '2025-10-12', 'Pending', '123 Main St', '123 Main St', 2, 2000);
-- customer 2 gets +200 score

-- * Use case 7 | Prevent Unauthorized Field Update

--   * **Q1. Trigger: Block updates to `orderdate`.**
DELIMITER $$
CREATE TRIGGER T_prevent_update_orderdate
BEFORE UPDATE
ON orders
FOR EACH ROW
BEGIN
    IF NEW.orderdate <> OLD.orderdate THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'ORDER DATE CAN NOT BE UPDATED';
    END IF;
END $$
DELIMITER ;

-- This update is rejected
UPDATE orders
SET orderdate = '2025-02-01'
WHERE orderid = 1;

--   * This trigger rejects any update that tries to change the original order date.

-- * Use case 8 | Maintain Derived Totals / Aggregates

--   * Q1. Trigger: Update the employee's total sales when a new order is added.
DELIMITER $$

CREATE TRIGGER trg_update_employee_sales
AFTER INSERT ON orders
FOR EACH ROW
BEGIN
    UPDATE employees
    SET totalsales = IFNULL(totalsales, 0) + NEW.sales
    WHERE employeeid = NEW.salespersonid;
END$$

DELIMITER ;

-- * Use case 9 | Security / Logging Changes (log who did what)

--   * Q1. Trigger: Log who deleted an order.
SELECT CURRENT_USER();

-- First create the delete-log table
CREATE TABLE orders_delete_log (
 logid INT AUTO_INCREMENT PRIMARY KEY,
 orderid INT,
 deleted_by VARCHAR(100),
 deleted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DELIMITER $$

CREATE TRIGGER trg_log_order_delete
AFTER DELETE ON orders
FOR EACH ROW
BEGIN
    INSERT INTO orders_delete_log (orderid, deleted_by)
    VALUES (OLD.orderid, USER());   -- USER() = the user who is connected and ran the DELETE
END$$

DELIMITER ;

DELETE FROM orders WHERE orderid = 102;

SELECT * FROM orders_delete_log;           -- 102 | 'vishal@localhost' | 2025-10-10 ...

-- Check
SELECT * FROM orders WHERE orderid = 102;  -- no row

-- * Use case 10 | Custom Business Rule

--   * Q1. Trigger: Allow only high-score customers to place expensive orders.
DELIMITER $$

CREATE TRIGGER trg_check_customer_eligibility
BEFORE INSERT ON orders
FOR EACH ROW
BEGIN
    DECLARE cust_score INT;
    SET cust_score = (SELECT COALESCE(score, 0) FROM customers WHERE customerid = NEW.customerid);

    IF NEW.sales > 500 AND cust_score < 500 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = '❌ Customer score too low for high-value order.';
    END IF;
END$$

DELIMITER ;

-- * Use case 11 | Version History / Data Snapshot

--   * Q1. Trigger: Save the old order record before update.
DELIMITER $$

CREATE TRIGGER trg_order_version_history
BEFORE UPDATE ON orders
FOR EACH ROW
BEGIN
  INSERT INTO orders_archive
  (
    orderid, productid, customerid, salespersonid, orderdate,
    shipdate, orderstatus, shipaddress, billaddress, quantity,
    sales, creationtime
  )
  VALUES
  (
    OLD.orderid, OLD.productid, OLD.customerid, OLD.salespersonid,
    OLD.orderdate, OLD.shipdate, OLD.orderstatus, OLD.shipaddress,
    OLD.billaddress, OLD.quantity, OLD.sales, OLD.creationtime
  );
END$$

DELIMITER ;

-- * Use case 12 | Enforce Consistency Between Tables

--   * Q1. Trigger: Recalculate order sales when a product price changes.
DELIMITER $$

CREATE TRIGGER trg_update_orders_on_price_change
AFTER UPDATE ON products
FOR EACH ROW
BEGIN
    IF OLD.price <> NEW.price THEN
        UPDATE orders
        SET sales = NEW.price * quantity
        WHERE productid = NEW.productid
          AND orderstatus <> 'Delivered';
    END IF;
END$$

DELIMITER ;

-- * Use case 13 | Cascading Action

--   * Q1. Trigger: Delete archived orders when a customer is deleted.
DELIMITER $$

CREATE TRIGGER T_archived_orders
AFTER DELETE
ON customers
FOR EACH ROW
BEGIN
    DELETE FROM orders_archive WHERE customerid = OLD.customerid;
END $$

DELIMITER ;

DELETE FROM customers WHERE customerid = 10;

-- Check that no archived rows remain for that customer
SELECT * FROM orders_archive WHERE customerid = 10;

-- * Use case 14 | Trigger Notification / Alert

--   * Q1. Trigger: Detect large salary increases (more than 20%).
-- First create the alert table
CREATE TABLE salary_alerts (
  alertid INT AUTO_INCREMENT PRIMARY KEY,
  employeeid INT,
  old_salary INT,
  new_salary INT,
  alert_message VARCHAR(255),
  created_on TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DELIMITER $$

CREATE TRIGGER T_update_notification
AFTER UPDATE
ON employees
FOR EACH ROW
BEGIN
    IF NEW.salary > OLD.salary * 1.2 THEN
        INSERT INTO salary_alerts (employeeid, old_salary, new_salary, alert_message, created_on)
        VALUES (NEW.employeeid, OLD.salary, NEW.salary, 'SALARY INCREASED BY MORE THAN 20%', NOW());
    END IF;
END $$
DELIMITER ;

-- Update query that fires the trigger
UPDATE employees
SET salary = 75000
WHERE employeeid = 2;

-- Check the alerts
SELECT * FROM salary_alerts;

-- * Use case 15 | Data Quality / Standardization

--   * Q1. Trigger: Automatically capitalize customer names.
DELIMITER $$

CREATE TRIGGER trg_format_customer_names
BEFORE INSERT ON customers
FOR EACH ROW
BEGIN
    SET NEW.firstname = CONCAT(UCASE(LEFT(NEW.firstname, 1)), LCASE(SUBSTRING(NEW.firstname, 2)));
    SET NEW.lastname  = CONCAT(UCASE(LEFT(NEW.lastname, 1)),  LCASE(SUBSTRING(NEW.lastname, 2)));
END$$

DELIMITER ;

INSERT INTO customers (customerid, firstname, lastname, country, score)
VALUES (10, 'vISHAL', 'shINDE', 'India', 500);

SELECT * FROM customers;   -- saved as 'Vishal', 'Shinde'

-- ------------------------------------------------------------
-- 37.11 Summary of Trigger Use Cases
-- ------------------------------------------------------------

-- * Enforce business rules automatically 👉 prevent invalid data (e.g. salary < 0).

-- * Maintain audit trails 👉 log every insert/update/delete into an audit table.

-- * Validate data before saving.

-- * Synchronize tables.

-- * Prevent invalid transactions.

-- * Maintain derived data 👉 update totals in a parent table when child rows change.

-- * Default value handling 👉 fill missing fields.

-- * Security / compliance 👉 track who deleted sensitive records.

-- ------------------------------------------------------------
-- 37.12 Important Key Points About Triggers in MySQL
-- ------------------------------------------------------------

-- * Supported:

--   * DML triggers (`BEFORE` / `AFTER`, row-level).

--   * Events: `INSERT`, `UPDATE`, `DELETE`.

--   * `OLD` and `NEW` references.

--   * Multiple triggers on the same table/event/timing (since MySQL 5.7.2), ordered with `FOLLOWS` / `PRECEDES`.

-- * Not supported:

--   * Statement-level triggers → only row-level.

--   * `INSTEAD OF` triggers.

--   * DDL, LOGON or COMPOUND triggers.

--   * Triggers on views → in MySQL you cannot put a trigger on a view; SQL Server, Oracle and PostgreSQL support `INSTEAD OF` triggers on views to handle DML on them.

--   * Manual invocation → triggers cannot be called; they only fire automatically.

--   * `COMMIT` or `ROLLBACK` inside a trigger body → not allowed (the trigger is part of the statement's transaction; if the trigger fails, the whole statement fails).

--   * A trigger cannot modify the same table it is defined on (error 1442), so a trigger cannot trigger itself (no recursion).

-- * Triggers vs Events: Triggers → work on data events (`INSERT`/`UPDATE`/`DELETE`). Events → work on time (schedules) — Topic 38.

-- * You cannot delay a trigger (like "run 1 second after insert") in MySQL. That behaviour needs an Event or an external scheduler (like CRON).

-- ------------------------------------------------------------
-- 37.13 Triggers with Programming Logic (Variables, IF, CASE, Loops)
-- ------------------------------------------------------------

-- * These examples show a trigger collection that works with a realistic sales schema and uses different MySQL logic patterns: variables (`DECLARE`, `SET`), `IF / ELSEIF / ELSE`, `CASE`, loops (`WHILE`, `LOOP` with `LEAVE`), data logging and `BEFORE` / `AFTER` timing.

-- * Trigger using Variables + IF / ELSE

--   * **Q1. Create an `AFTER INSERT` trigger that awards bonus points to customers based on product category and sales amount.**

--     * Whenever a new order is inserted, the company rewards the customer with bonus points based on the product category and sales amount.

--     * Use a variable to store the product category of the ordered item, and `IF / ELSEIF / ELSE` to decide the bonus:

--       * category `'Clothing'` → 20 points,

--       * category `'Accessories'` and sales ≥ 50 → 15 points,

--       * otherwise → 5 points.

--     * Add the bonus to the customer's score; if the score is `NULL`, treat it as 0 with `COALESCE()`.
SELECT * FROM orders;
SELECT * FROM customers;
SELECT * FROM products;

DELIMITER $$

CREATE TRIGGER after_order_insert_bonus_points
AFTER INSERT
ON orders
FOR EACH ROW
BEGIN
    -- DECLARE VARIABLES
    DECLARE v_bonus INT DEFAULT 0;
    DECLARE v_category VARCHAR(50);

    -- GET THE PRODUCT CATEGORY
    SELECT category
    INTO v_category        -- INTO stores the query result in the variable
    FROM products
    WHERE productid = NEW.productid;

    -- DETERMINE BONUS POINTS USING IF / ELSE
    IF v_category = 'Clothing' THEN
        SET v_bonus = 20;
    ELSEIF v_category = 'Accessories' AND NEW.sales >= 50 THEN
        SET v_bonus = 15;
    ELSE
        SET v_bonus = 5;
    END IF;

    -- UPDATE THE CUSTOMER'S SCORE
    UPDATE customers
    SET score = COALESCE(score, 0) + v_bonus
    WHERE customerid = NEW.customerid;
END$$

DELIMITER ;

SELECT customerid, firstname, score FROM customers WHERE customerid = 2;

INSERT INTO orders (orderid, productid, customerid, salespersonid, orderdate, shipdate, orderstatus, shipaddress, billaddress, quantity, sales, creationtime)
VALUES (11, 102, 2, 3, '2025-10-10', '2025-10-12', 'Delivered', 'Test Address', 'Test Address', 2, 60, NOW());

-- * Trigger using a CASE statement

--   * **Q1. Create `before_employee_insert_set_department_salary` that assigns a default salary based on the department before a new employee is inserted.**

--     * Fires `BEFORE INSERT` on `employees`.

--     * `CASE` on department: `'Sales'` → 70000, `'Marketing'` → 60000, `'HR'` → 50000, any other → 40000.

--     * If the insert already gives a salary, keep it; if the salary is `NULL`, set it to the department default.
DELIMITER $$
CREATE TRIGGER before_employee_insert_set_department_salary
BEFORE INSERT ON employees
FOR EACH ROW
BEGIN
    DECLARE base_salary INT;

    -- Assign default salary depending on department
    SET base_salary = CASE NEW.department
        WHEN 'Sales'     THEN 70000
        WHEN 'HR'        THEN 50000
        WHEN 'Marketing' THEN 60000
        ELSE 40000
    END;

    -- If salary not provided, set it
    IF NEW.salary IS NULL THEN
        SET NEW.salary = base_salary;
    END IF;
END$$

DELIMITER ;

INSERT INTO employees (employeeid, firstname, department, salary)
VALUES (10000, 'Amit Sharma', 'Sales', 899999),     -- salary given → kept
       (20000, 'Priya Patel', 'Marketing', NULL);   -- salary NULL → 60000
SELECT * FROM employees;

-- * Trigger using a LOOP + variable

--   * **Q1. Create `after_order_insert_generate_shipment_logs` that inserts one shipment log per unit of the order quantity (quantity = 3 → 3 logs).**

--     * Use a counter variable and a `WHILE` loop.

--     * Each log has `orderid`, `piece_no` (1, 2, 3 …) and `created_at` (current timestamp).

--     * Fires `AFTER INSERT` on `orders`. First create the `shipment_log` table.
USE salesdb;

DROP TRIGGER IF EXISTS after_order_insert_generate_shipment_logs;
DROP TABLE IF EXISTS shipment_log;

CREATE TABLE shipment_log (
  logid INT AUTO_INCREMENT PRIMARY KEY,
  orderid INT,
  piece_no INT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DELIMITER $$

CREATE TRIGGER after_order_insert_generate_shipment_logs
AFTER INSERT ON orders
FOR EACH ROW
BEGIN
    DECLARE i INT DEFAULT 1;

    WHILE i <= NEW.quantity DO
        INSERT INTO shipment_log (orderid, piece_no)
        VALUES (NEW.orderid, i);
        SET i = i + 1;
    END WHILE;
END$$

DELIMITER ;

-- ✅ Make sure these exist:
SELECT * FROM products WHERE productid = 101;
SELECT * FROM customers WHERE customerid = 2;
SELECT * FROM employees WHERE employeeid = 3;

-- ✅ Now insert
INSERT INTO orders (orderid, productid, customerid, salespersonid, orderdate, shipdate, orderstatus, shipaddress, billaddress, quantity, sales, creationtime)
VALUES (100, 101, 2, 3, '2025-04-01', '2025-04-05', 'Processing', '123 Elm St', '456 Oak St', 3, 30, NOW());

-- ✅ Check shipment log (3 rows: piece 1, 2, 3)
SELECT * FROM shipment_log;

-- * Trigger using IF and CASE together + logging

--   * **Q1. Create `before_employee_update_audit_salary` on `employees` that logs every salary change into `salary_change_log`.**

--     * Fires `BEFORE UPDATE`; variable `v_reason` stores the reason.

--     * `IF OLD.salary <> NEW.salary` → only real changes are logged.

--     * `CASE`: new > old → 'Salary Increment'; new < old → 'Salary Reduction'; else 'No Change'.

--     * Insert employeeid, old salary, new salary, reason and timestamp; no log when the salary stays the same.
CREATE TABLE IF NOT EXISTS salary_change_log (
  logid INT AUTO_INCREMENT PRIMARY KEY,
  employeeid INT,
  old_salary INT,
  new_salary INT,
  change_reason VARCHAR(100),
  logged_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DELIMITER $$
CREATE TRIGGER before_employee_update_audit_salary
BEFORE UPDATE ON employees
FOR EACH ROW
BEGIN
    DECLARE v_reason VARCHAR(100);

    -- Check if salary changed
    IF OLD.salary <> NEW.salary THEN

        -- Determine reason using CASE
        SET v_reason = CASE
            WHEN NEW.salary > OLD.salary THEN 'Salary Increment'
            WHEN NEW.salary < OLD.salary THEN 'Salary Reduction'
            ELSE 'No Change'
        END;

        -- Insert into audit log
        INSERT INTO salary_change_log (employeeid, old_salary, new_salary, change_reason)
        VALUES (OLD.employeeid, OLD.salary, NEW.salary, v_reason);
    END IF;
END$$
DELIMITER ;

UPDATE employees SET salary = 65000 WHERE employeeid = 1;   -- logged (increment or reduction)
UPDATE employees SET salary = 48000 WHERE employeeid = 3;   -- logged
UPDATE employees SET salary = 65000 WHERE employeeid = 1;   -- same salary again → not logged

-- * Trigger using a variable + nested IF (data cleanup)

--   * **Q1. Create `before_order_insert_null_address_check` on `orders` that automatically fills in default shipping and billing addresses when they are not provided.**

--     * The default address is built from the customer's country.

--     * Runs `BEFORE INSERT`; reads the customer's country into a variable.

--     * `shipaddress` NULL/empty → `'Default Shipping - <country>'`; `billaddress` NULL/empty → `'Default Billing - <country>'`.

--     * Addresses that are provided are not changed.
DELIMITER $$
CREATE TRIGGER before_order_insert_null_address_check
BEFORE INSERT ON orders
FOR EACH ROW
BEGIN
    DECLARE v_country VARCHAR(50);

    -- Get customer country
    SELECT country INTO v_country
    FROM customers
    WHERE customerid = NEW.customerid;

    -- Ensure addresses aren't empty or NULL
    IF NEW.shipaddress IS NULL OR NEW.shipaddress = '' THEN
        SET NEW.shipaddress = CONCAT('Default Shipping - ', v_country);
    END IF;

    IF NEW.billaddress IS NULL OR NEW.billaddress = '' THEN
        SET NEW.billaddress = CONCAT('Default Billing - ', v_country);
    END IF;
END$$

DELIMITER ;

-- Insert data with missing addresses
INSERT INTO orders (orderid, customerid, shipaddress, billaddress, orderdate)
VALUES (101, 1, NULL, '', '2025-10-10');
-- saved as 'Default Shipping - Germany', 'Default Billing - Germany'

-- * Trigger using a loop + conditional break (advanced)

--   * **Q1. Create `after_customer_insert_generate_loyalty_vouchers` that issues loyalty vouchers to a new customer based on their score.**

--     * Score ≥ 300 → up to 3 vouchers; score below 300 → no vouchers.

--     * Runs `AFTER INSERT` on `customers`, uses a loop, and leaves the loop early with `LEAVE` when the condition fails.

--     * Voucher codes look like `VCHR<customerid>_<voucher_number>` (e.g. `VCHR5_1`, `VCHR5_2`).
-- Create loyalty voucher table
CREATE TABLE IF NOT EXISTS loyalty_vouchers (
  voucherid INT AUTO_INCREMENT PRIMARY KEY,
  customerid INT,
  voucher_code VARCHAR(20),
  issued_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DELIMITER $$

CREATE TRIGGER after_customer_insert_generate_loyalty_vouchers
AFTER INSERT ON customers
FOR EACH ROW
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE max_vouchers INT DEFAULT 3;

    voucher_loop: WHILE i <= max_vouchers DO
        -- Stop issuing vouchers if customer score too low
        IF NEW.score < 300 THEN
            LEAVE voucher_loop;
        END IF;

        INSERT INTO loyalty_vouchers (customerid, voucher_code)
        VALUES (NEW.customerid, CONCAT('VCHR', NEW.customerid, '_', i));

        SET i = i + 1;
    END WHILE voucher_loop;
END$$

DELIMITER ;

INSERT INTO customers (customerid, firstname, lastname, country, score)
VALUES (10, 'Amit', 'Patel', 'India', 900);
-- loyalty_vouchers gets VCHR10_1, VCHR10_2, VCHR10_3

--   * `LEAVE` needs a label on the loop (`voucher_loop:`), otherwise MySQL gives a syntax error.

-- * Q1. BEFORE vs AFTER trigger — when do you use each?

--   * Answer: BEFORE to validate or change `NEW` values before saving; AFTER to log or update other tables once the row is saved.

-- * Q2. What are OLD and NEW?

--   * Answer: Row references: OLD = values before the change (UPDATE, DELETE), NEW = values after (INSERT, UPDATE). In BEFORE triggers NEW can be modified.

-- * Q3. Limitations of MySQL triggers?

--   * Answer: Row-level only; no statement-level/INSTEAD OF/DDL triggers; not on views; no COMMIT/ROLLBACK inside; cannot modify the table it's defined on; cannot be called directly; no ALTER TRIGGER.

-- * Q4. Why are too many triggers considered bad practice?

--   * Answer: Hidden logic (hard to debug), extra work on every write (slower bulk inserts), and chains of triggers make behaviour unpredictable. Keep them small; put complex logic in procedures or the application.

-- * Q5. How do you stop an invalid insert from a trigger?

--   * Answer: `SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '...';` in a BEFORE INSERT trigger — the whole statement fails.

-- ---

-- ======================================================================
-- 🎯 Practice Questions (salesdb sample data) — try first, then look at the answer
-- ======================================================================
-- Run 00-Setup-Sample-Data.sql once before this section.

USE salesdb;

-- Q1. Audit table + AFTER UPDATE trigger on products.price.
CREATE TABLE price_log (productid INT, old_price INT, new_price INT, changed_at DATETIME);
DELIMITER //
CREATE TRIGGER trg_price_log AFTER UPDATE ON products
FOR EACH ROW
BEGIN
  IF OLD.price <> NEW.price THEN
    INSERT INTO price_log VALUES (OLD.productid, OLD.price, NEW.price, NOW());
  END IF;
END //
DELIMITER ;

-- Q2. Fire the trigger and read the log, then restore the price.
UPDATE products SET price = 12 WHERE productid = 101;
SELECT * FROM price_log;
UPDATE products SET price = 10 WHERE productid = 101;

-- Q3. Clean up.
DROP TRIGGER trg_price_log;
DROP TABLE price_log;
