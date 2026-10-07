-- ======================================================================
-- Topic 36: Stored Functions (User-Defined Functions) in PostgreSQL
-- ======================================================================

-- ------------------------------------------------------------
-- 📖 In Simple Words
-- ------------------------------------------------------------

-- * Definition: A user-defined function is saved code that takes inputs and returns one value, so you can use it inside SELECT like a built-in function.

-- * Real-life example: A calculator button you program yourself, e.g. "add GST".

-- * 🧩 Syntax:
--     CREATE [OR REPLACE] FUNCTION func_name(p1 INT, p2 VARCHAR)
--     RETURNS return_type
--     LANGUAGE sql | plpgsql
--     IMMUTABLE AS $$
--       SELECT expression;                -- (plpgsql: BEGIN RETURN ...; END)
--     $$;
--     SELECT func_name(col1, col2) FROM t;

-- * Syntax explained (each part):
--   - RETURNS → the data type of the single result
--   - DETERMINISTIC / IMMUTABLE → same input always gives the same output
--   - RETURN → sends the value back
--   - Use → inside SELECT, WHERE … like a built-in function

-- * Example on salesdb (run 00-Setup-Sample-Data.sql first):
SET search_path TO sales;
CREATE OR REPLACE FUNCTION with_gst(p_price INT) RETURNS NUMERIC
LANGUAGE sql IMMUTABLE AS $$ SELECT p_price * 1.18 $$;
SELECT product, price, with_gst(price) AS price_with_gst FROM products;
DROP FUNCTION with_gst(INT);

-- * Example explained (step by step):
--   1. with_gst takes a price and returns the price plus 18%.
--   2. It is used inside SELECT exactly like ROUND or UPPER.
--   3. Result: Bottle 10 → 11.80, Gloves 30 → 35.40.

-- ------------------------------------------------------------
-- 36.1 What is a Function in PostgreSQL?
-- ------------------------------------------------------------

-- * A function in PostgreSQL is a named block of code stored in the database that:

--   * Accepts parameters (`IN` by default; `OUT` / `INOUT` are also allowed and become the result columns).

--   * Returns something — a single value (scalar), a single row, or a whole set of rows (a table). (MySQL functions can return only one scalar value.)

--   * Can be used inside SQL statements (`SELECT`, `WHERE`, `ORDER BY`, `FROM`, etc.).

--   * Is called a user-defined function when created by users — different from built-in functions like `UPPER()` or `ROUND()` (Topic 23).

--   * Can be written in `LANGUAGE sql` (just SQL, simplest and fastest for small things) or `LANGUAGE plpgsql` (variables, IF, loops).

-- ------------------------------------------------------------
-- 36.2 Why Use Functions?
-- ------------------------------------------------------------

-- * Reusability → define the logic once, use it anywhere.

-- * Simplifies queries → replace complex expressions with a single function call.

-- * Improves readability → business logic inside a function is easier to understand.

-- * Encapsulation → keeps calculations in the database layer.

-- * In PostgreSQL also: return a reusable "parameterized view" (a function that returns a table), and power triggers (trigger functions, Topic 37).

-- ------------------------------------------------------------
-- 36.3 Syntax in PostgreSQL
-- ------------------------------------------------------------

-- * Syntax:
CREATE [OR REPLACE] FUNCTION function_name (param1 datatype, param2 datatype)
RETURNS return_datatype
LANGUAGE plpgsql              -- or LANGUAGE sql
IMMUTABLE                     -- or STABLE / VOLATILE (default)
AS $$
DECLARE
    -- variables
BEGIN
    -- logic
    RETURN value;
END;
$$;

-- * Explanation:

--   * `RETURNS` → mandatory; defines the return type (`INT`, `TEXT`, `TABLE (...)`, `SETOF table_name`, `VOID`, `TRIGGER`).

--   * `RETURN` → the statement inside the body that gives the output.

--   * Volatility (PostgreSQL's version of MySQL `DETERMINISTIC`):

--     * `IMMUTABLE` → same input always gives the same output, and it reads no tables (e.g., a math or text formula). Needed if you want to use the function in an index.

--     * `STABLE` → same output within one statement; may read tables (e.g., a lookup).

--     * `VOLATILE` (default) → can change any time or modifies data (e.g., uses `random()` or inserts rows).

--   * Other useful options: `STRICT` (returns NULL automatically if any argument is NULL), `PARALLEL SAFE`, `SECURITY DEFINER`, `COST`.

--   * No binary-log error like MySQL 1418 — PostgreSQL never refuses `CREATE FUNCTION` because of a missing characteristic.

-- ------------------------------------------------------------
-- 36.4 Function Examples
-- ------------------------------------------------------------

-- * Ex. Function without parameters:
CREATE OR REPLACE FUNCTION get_today()
RETURNS DATE
LANGUAGE sql
STABLE                  -- CURRENT_DATE is the same during one statement, but changes every day
AS $$
    SELECT CURRENT_DATE;
$$;
--   Use the function like: `SELECT get_today();`

-- * Function with parameters:
CREATE OR REPLACE FUNCTION get_full_name(p_first_name VARCHAR(50), p_last_name VARCHAR(50))
RETURNS VARCHAR(100)
LANGUAGE sql
IMMUTABLE
AS $$
    SELECT p_first_name || ' ' || p_last_name;
$$;
--   Used as: `SELECT get_full_name('Vishal', 'Shinde');` → `'Vishal Shinde'`

-- * Function with a table query (PL/pgSQL version):
CREATE OR REPLACE FUNCTION get_employee_count(p_dept_id INT)
RETURNS INT
LANGUAGE plpgsql
STABLE
AS $$
DECLARE
    v_emp_count INT;
BEGIN
    SELECT COUNT(*) INTO v_emp_count
    FROM employees
    WHERE department_id = p_dept_id;
    RETURN v_emp_count;
END;
$$;
--   Use it:
SELECT department_id, get_employee_count(department_id) AS total_employees
FROM departments;

-- * 🐘 Table-valued function (PostgreSQL only — MySQL cannot do this):
CREATE OR REPLACE FUNCTION get_employees_of_dept(p_dept_id INT)
RETURNS TABLE (emp_id INT, emp_name VARCHAR, salary NUMERIC)
LANGUAGE sql
STABLE
AS $$
    SELECT e.id, e.name, e.salary
    FROM employees e
    WHERE e.department_id = p_dept_id;
$$;

-- Use it like a table (filter, sort, join):
SELECT * FROM get_employees_of_dept(2) WHERE salary > 50000 ORDER BY salary DESC;

-- Call it once per department with LATERAL:
SELECT d.department_id, x.emp_name
FROM departments d
CROSS JOIN LATERAL get_employees_of_dept(d.department_id) AS x;

-- * Function with OUT parameters (returns one row with several columns):
CREATE OR REPLACE FUNCTION dept_stats(p_dept_id INT, OUT emp_count BIGINT, OUT avg_salary NUMERIC)
LANGUAGE sql
STABLE
AS $$
    SELECT COUNT(*), AVG(salary) FROM employees WHERE department_id = p_dept_id;
$$;

SELECT * FROM dept_stats(2);   -- emp_count | avg_salary

--   * `SELECT get_full_name('Vishal', 'Shinde');` ➔ `'Vishal Shinde'`.

-- ------------------------------------------------------------
-- 36.5 How to Manage & Drop Functions
-- ------------------------------------------------------------

-- * See functions: `\df` (psql), `\sf get_employee_count` (source), or `SELECT pg_get_functiondef('get_employee_count'::regproc);`

-- * Drop a function: `DROP FUNCTION IF EXISTS get_employee_count(INT);` — PostgreSQL allows several functions with the same name and different parameter types (overloading), so include the types when needed.

-- * Change a function: `CREATE OR REPLACE FUNCTION ...` (no need to drop). If you change the parameter types or the return type, drop it first.

-- ------------------------------------------------------------
-- 36.6 Differences Between Function and Procedure (PostgreSQL)
-- ------------------------------------------------------------

-- | Feature | Procedure | Function |
-- | :--- | :--- | :--- |
-- | Return value | No return value; values come back through `OUT` / `INOUT` parameters | Must return something: a value, a row, a set of rows, or `VOID` |
-- | Use in SQL | Cannot be used in `SELECT` | Can be used in `SELECT`, `WHERE`, `ORDER BY`, `FROM` |
-- | Parameters | `IN`, `OUT` (PG 14+), `INOUT` | `IN`, `OUT`, `INOUT` (OUT params become result columns) |
-- | Transactions | Can `COMMIT` / `ROLLBACK` inside (when called outside a `BEGIN` block) | Not allowed — always runs inside the caller's transaction |
-- | Purpose | Perform actions: batch jobs, multi-step changes with commits | Compute and return values or tables; trigger functions |
-- | How it is called | `CALL procedure_name(...)` | `SELECT function_name(...)` / `SELECT * FROM function_name(...)` |
-- | Returning rows | ❌ Not possible directly | ✅ `RETURNS TABLE (...)` / `RETURNS SETOF ...` |
-- | Can modify data? | Yes | Yes (if `VOLATILE`) — e.g. `INSERT ... RETURNING` inside a function |
-- | Introduced | PostgreSQL 11 | Always existed |
-- | Examples | Archive in batches, nightly job, money transfer | Calculate tax, format full name, report table, trigger logic |

-- * In PostgreSQL, functions are used much more than procedures. Use a procedure mainly when you need transaction control (`COMMIT` in the middle) or when you want the "CALL" style.

-- * Use a procedure when you want to do something big with commits (action). Use a function when you want to calculate and return something (value or rows).

-- * Q1. Stored function vs stored procedure in PostgreSQL?

--   * Answer: A function returns a value or a table and can be used inside SELECT/WHERE/FROM; a procedure (PostgreSQL 11+) is called with CALL, returns values only through OUT/INOUT parameters, and can COMMIT/ROLLBACK inside.

-- * Q2. What is function volatility (IMMUTABLE / STABLE / VOLATILE) and why does it matter?

--   * Answer: It tells the planner how much it can trust the function. `IMMUTABLE` functions can be pre-computed and used in indexes; `STABLE` can be evaluated once per statement (good for index scans with a lookup value); `VOLATILE` must run for every row. Marking a function wrongly can give wrong results (e.g., `IMMUTABLE` on something that reads a table).

-- * Q3. Can a function modify data or use COMMIT?

--   * Answer: A `VOLATILE` function may run `INSERT`/`UPDATE`/`DELETE`, but it cannot `COMMIT`/`ROLLBACK` — it always runs inside the caller's transaction. If you need commits, use a procedure.

-- * Q4. What is the performance risk of a function in WHERE?

--   * Answer: It may run once per row and prevent normal index use (`WHERE get_year(order_date) = 2025` → full scan). Prefer ranges (`order_date >= '2025-01-01' AND order_date < '2026-01-01'`), or create an expression index on an `IMMUTABLE` function: `CREATE INDEX ON orders (get_year(order_date));`

-- * Q5. Can a PostgreSQL function return multiple rows?

--   * Answer: Yes — `RETURNS TABLE (...)` or `RETURNS SETOF type`. In PL/pgSQL use `RETURN QUERY SELECT ...;` or `RETURN NEXT` inside a loop.

-- ---

-- ======================================================================
-- 🎯 Practice Questions (salesdb sample data) — try first, then look at the answer
-- ======================================================================
-- Run 00-Setup-Sample-Data.sql once before this section.

SET search_path TO sales;

-- Q1. Function: full name of a customer.
CREATE OR REPLACE FUNCTION full_name(p_first VARCHAR, p_last VARCHAR)
RETURNS VARCHAR LANGUAGE sql IMMUTABLE AS $$
  SELECT p_first || ' ' || COALESCE(p_last, '');
$$;
SELECT full_name(firstname, lastname) FROM customers;

-- Q2. Function: price with discount percent.
CREATE OR REPLACE FUNCTION discounted(p_price INT, p_pct INT)
RETURNS NUMERIC LANGUAGE sql IMMUTABLE AS $$
  SELECT p_price - p_price * p_pct / 100.0;
$$;
SELECT product, price, discounted(price, 10) AS after_10pct FROM products;

-- Q3. Drop the functions.
DROP FUNCTION IF EXISTS full_name(VARCHAR, VARCHAR);
DROP FUNCTION IF EXISTS discounted(INT, INT);
