-- ======================================================================
-- Topic 36: Stored Functions (User-Defined Functions) in MySQL
-- ======================================================================

-- ------------------------------------------------------------
-- 📖 In Simple Words
-- ------------------------------------------------------------

-- * Definition: A user-defined function is saved code that takes inputs and returns one value, so you can use it inside SELECT like a built-in function.

-- * Real-life example: A calculator button you program yourself, e.g. "add GST".

-- * 🧩 Syntax:
--     DELIMITER //
--     CREATE FUNCTION func_name(p1 INT, p2 VARCHAR(50))
--     RETURNS return_type
--     DETERMINISTIC
--     BEGIN
--       RETURN expression;
--     END //
--     DELIMITER ;
--     SELECT func_name(col1, col2) FROM t;

-- * Syntax explained (each part):
--   - RETURNS → the data type of the single result
--   - DETERMINISTIC / IMMUTABLE → same input always gives the same output
--   - RETURN → sends the value back
--   - Use → inside SELECT, WHERE … like a built-in function

-- * Example on salesdb (run 00-Setup-Sample-Data.sql first):
USE salesdb;
DELIMITER //
CREATE FUNCTION with_gst(p_price INT) RETURNS DECIMAL(10,2) DETERMINISTIC
RETURN p_price * 1.18;
//
DELIMITER ;
SELECT product, price, with_gst(price) AS price_with_gst FROM products;
DROP FUNCTION with_gst;

-- * Example explained (step by step):
--   1. with_gst takes a price and returns the price plus 18%.
--   2. It is used inside SELECT exactly like ROUND or UPPER.
--   3. Result: Bottle 10 → 11.80, Gloves 30 → 35.40.

-- ------------------------------------------------------------
-- 36.1 What is a Function in SQL?
-- ------------------------------------------------------------

-- * A function in SQL is a named block of code stored in the database that:

--   * Accepts parameters (only `IN` parameters in MySQL — you don't write the word `IN`).

--   * Always returns a single value (a number, string, date, etc.). (Some databases like SQL Server/PostgreSQL also have table-valued functions; MySQL functions return only one scalar value.)

--   * Can be used inside SQL statements (`SELECT`, `WHERE`, `ORDER BY`, etc.).

--   * Is called a Stored Function (user-defined function) when created by users — different from built-in functions like `UPPER()` or `ROUND()` (Topic 23).

-- ------------------------------------------------------------
-- 36.2 Why Use Functions?
-- ------------------------------------------------------------

-- * Reusability → define the logic once, use it anywhere.

-- * Simplifies queries → replace complex expressions with a single function call.

-- * Improves readability → business logic inside a function is easier to understand.

-- * Encapsulation → keeps calculations in the database layer.

-- ------------------------------------------------------------
-- 36.3 Syntax in MySQL
-- ------------------------------------------------------------

-- * Syntax:
DELIMITER //

CREATE FUNCTION function_name (param1 datatype, param2 datatype)
RETURNS return_datatype
DETERMINISTIC
BEGIN
    -- logic
    RETURN value;
END //

DELIMITER ;

-- * Explanation:

--   * `RETURNS` → mandatory; defines the return type.

--   * `RETURN` → the statement inside the body that gives the output.

--   * `DETERMINISTIC` → means the function always returns the same output for the same input (used for optimization).

--   * Other characteristics: `NOT DETERMINISTIC` (result can change, e.g. uses `NOW()`), `READS SQL DATA` (reads tables), `NO SQL` (no SQL inside).

--   * When binary logging is ON (the default in MySQL 8), you must declare one of `DETERMINISTIC`, `NO SQL` or `READS SQL DATA`, otherwise `CREATE FUNCTION` fails with error 1418.

-- ------------------------------------------------------------
-- 36.4 Function Examples
-- ------------------------------------------------------------

-- * Ex. Function without parameters:
DELIMITER //

CREATE FUNCTION GetToday()
RETURNS DATE
NOT DETERMINISTIC   -- CURDATE() changes every day
NO SQL
BEGIN
    RETURN CURDATE();
END //

DELIMITER ;
--   Use the function like: `SELECT GetToday();`

-- * Function with parameters:
DELIMITER //

CREATE FUNCTION GetFullName(first_name VARCHAR(50), last_name VARCHAR(50))
RETURNS VARCHAR(100)
DETERMINISTIC
BEGIN
    RETURN CONCAT(first_name, ' ', last_name);
END //

DELIMITER ;
--   Used as: `SELECT GetFullName('Vishal', 'Shinde');` → `'Vishal Shinde'`

-- * Function with a table query:
DELIMITER //

CREATE FUNCTION GetEmployeeCount(p_dept_id INT)
RETURNS INT
READS SQL DATA
BEGIN
    DECLARE emp_count INT;
    SELECT COUNT(*) INTO emp_count
    FROM employees
    WHERE department_id = p_dept_id;
    RETURN emp_count;
END //

DELIMITER ;
--   Use it:
SELECT department_id, GetEmployeeCount(department_id) AS total_employees
FROM departments;

--   * `SELECT GetFullName('Vishal', 'Shinde');` ➔ `'Vishal Shinde'`.

-- ------------------------------------------------------------
-- 36.5 How to Manage & Drop Functions
-- ------------------------------------------------------------

-- * See functions: `SHOW FUNCTION STATUS WHERE Db = 'mydb';` and `SHOW CREATE FUNCTION GetEmployeeCount;`

-- * Drop a function: `DROP FUNCTION IF EXISTS GetEmployeeCount;`

-- * Like procedures, MySQL has no `CREATE OR REPLACE FUNCTION` → drop it first, then create it again.

-- ------------------------------------------------------------
-- 36.6 Differences Between Function and Procedure
-- ------------------------------------------------------------

-- | Feature | Procedure | Function |
-- | :--- | :--- | :--- |
-- | Return value | Optional — may or may not return values (via `OUT` / `INOUT` parameters, or result sets) | Mandatory — must return exactly one value using `RETURN` |
-- | Use in SQL | Cannot be used in `SELECT` | Can be used in `SELECT`, `WHERE`, `ORDER BY` etc. |
-- | Parameters | `IN`, `OUT`, `INOUT` | Only `IN` |
-- | Transactions | Can use `START TRANSACTION`, `COMMIT`, `ROLLBACK` | Not allowed (no statements that commit or roll back) |
-- | Purpose | Perform actions: `INSERT`, `UPDATE`, `DELETE`, complex operations, transactions | Compute and return a value (calculation, transformation, lookup) |
-- | How it is called | `CALL procedure_name(...)` | Inside SQL: `SELECT function_name(...)` |
-- | Multiple values | Can return many values using `OUT` parameters and many result sets | Always returns one single (scalar) value; cannot return a result set |
-- | Typical size | Usually heavy business logic | Usually lightweight, focused on calculations |
-- | Examples | Transfer money, insert employee, audit logs | Calculate tax, format full name, count employees |

-- * A function in MySQL is like a procedure, but it must return a single value and can be used inside SQL queries. Best for calculations, transformations and reusable business logic inside queries.

-- * Use a procedure when you want to do something (action). Use a function when you want to calculate and return something (value).

-- * Q1. Stored function vs stored procedure?

--   * Answer: A function returns exactly one value and can be used inside SELECT/WHERE; a procedure is called with CALL, can return many values (OUT params, result sets) and can use transactions.

-- * **Q2. Why does `CREATE FUNCTION` fail with error 1418?**

--   * Answer: Binary logging is on, and the function doesn't declare `DETERMINISTIC`, `NO SQL` or `READS SQL DATA`. Declare the correct characteristic (or set `log_bin_trust_function_creators = 1`).

-- * Q3. Can a function modify data or use COMMIT?

--   * Answer: A function may run DML, but it cannot commit/roll back, cannot return a result set, and cannot modify a table that the calling statement is using. Keep functions for calculations.

-- * Q4. What is the performance risk of a function in WHERE?

--   * Answer: It runs once per row and blocks index use on that column (`WHERE GetYear(order_date) = 2025` → full scan). Prefer ranges or joins.

-- ---

-- ======================================================================
-- 🎯 Practice Questions (salesdb sample data) — try first, then look at the answer
-- ======================================================================
-- Run 00-Setup-Sample-Data.sql once before this section.

USE salesdb;

-- Q1. Function: full name of a customer.
DELIMITER //
CREATE FUNCTION full_name(p_first VARCHAR(50), p_last VARCHAR(50))
RETURNS VARCHAR(101) DETERMINISTIC
RETURN CONCAT(p_first, ' ', IFNULL(p_last, ''));
//
DELIMITER ;
SELECT full_name(firstname, lastname) FROM customers;

-- Q2. Function: price with discount percent.
DELIMITER //
CREATE FUNCTION discounted(p_price INT, p_pct INT)
RETURNS DECIMAL(10,2) DETERMINISTIC
RETURN p_price - p_price * p_pct / 100;
//
DELIMITER ;
SELECT product, price, discounted(price, 10) AS after_10pct FROM products;

-- Q3. Drop the functions.
DROP FUNCTION IF EXISTS full_name;
DROP FUNCTION IF EXISTS discounted;
