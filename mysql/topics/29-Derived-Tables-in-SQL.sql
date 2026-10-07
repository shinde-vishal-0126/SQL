-- ======================================================================
-- Topic 29: Derived Tables in SQL
-- ======================================================================

-- ------------------------------------------------------------
-- 📖 In Simple Words
-- ------------------------------------------------------------

-- * Definition: A derived table is a subquery written in the FROM clause. It acts like a temporary table that exists only while the query runs.

-- * Real-life example: Making a rough summary on a scrap paper, then reading from that paper.

-- * 🧩 Syntax:
--     SELECT outer_columns
--     FROM (
--       SELECT ... FROM ... GROUP BY ...
--     ) AS derived_name
--     [JOIN other ON ...]
--     WHERE ...;

-- * Syntax explained (each part):
--   - ( … ) → the inner query builds a temporary result
--   - AS derived_name → the alias is mandatory
--   - Scope → the derived table exists only during this one query

-- * Example on salesdb (run 00-Setup-Sample-Data.sql first):
USE salesdb;
SELECT AVG(total_sales) AS avg_per_customer
FROM (SELECT customerid, SUM(sales) AS total_sales
      FROM orders
      GROUP BY customerid) AS t;

-- * Example explained (step by step):
--   1. The inner query (derived table t) gives each customer's total: 110, 55, 125, 90.
--   2. The outer query takes the average of those totals.
--   3. Result: (110 + 55 + 125 + 90) / 4 = 95.

-- ------------------------------------------------------------
-- 29.1 What is a Derived Table?
-- ------------------------------------------------------------

-- * Definition: A derived table is a subquery inside the `FROM` clause that acts like a temporary table for the duration of the main query.

-- * Key Properties:

--   * It is not stored permanently (unlike normal tables or views).

--   * It only exists while the query is running.

--   * It is primarily used to simplify complex queries and break down logic into simpler steps.

--   * Important Rule: You MUST give the derived table an alias (a name).

-- ------------------------------------------------------------
-- 29.2 Syntax and Example
-- ------------------------------------------------------------

-- * Syntax:
SELECT columns
FROM (subquery) AS alias_name;

-- * Example (Derived Table with Aggregation):
--   Suppose you want the average salary of active employees by department.
SELECT dept_id, AVG(salary) AS avg_salary
FROM (
    -- This is the Derived Table (Subquery in FROM clause)
    SELECT dept_id, salary
    FROM employees
    WHERE status = 'ACTIVE'
) AS active_emps
GROUP BY dept_id;

--   * Explanation: The subquery `(SELECT dept_id, salary FROM employees WHERE status = 'ACTIVE')` acts like a temporary table named `active_emps`. The main query then groups this temporary table.

-- ------------------------------------------------------------
-- 29.3 Difference Between Derived Table and Subquery
-- ------------------------------------------------------------
-- (Feature → Subquery (in WHERE / SELECT) | Derived Table (in FROM))
--
-- * Placement
--     - Subquery (in WHERE / SELECT) : Written inside WHERE, HAVING, or SELECT clauses.
--     - Derived Table (in FROM)      : Written only inside the FROM clause.
--
-- * Output Type
--     - Subquery (in WHERE / SELECT) : Returns a single value or a list of values (1 column).
--     - Derived Table (in FROM)      : Acts like a full virtual table (Rows & Columns).
--
-- * Usage
--     - Subquery (in WHERE / SELECT) : Used for filtering or returning a single calculated column.
--     - Derived Table (in FROM)      : Used so you can JOIN, GROUP BY, or filter on its result like a real table.
--

-- ---

-- ======================================================================
-- 🎯 Practice Questions (salesdb sample data) — try first, then look at the answer
-- ======================================================================
-- Run 00-Setup-Sample-Data.sql once before this section.

USE salesdb;

-- Q1. Derived table: average total sales per customer.
SELECT AVG(total_sales) AS avg_customer_sales
FROM (SELECT customerid, SUM(sales) AS total_sales FROM orders GROUP BY customerid) AS t;

-- Q2. Derived table + join: customers with their totals and names.
SELECT c.firstname, t.total_sales
FROM customers c
JOIN (SELECT customerid, SUM(sales) AS total_sales FROM orders GROUP BY customerid) t
  ON t.customerid = c.customerid;

-- Q3. Top product per category using a derived table with ROW_NUMBER.
SELECT category, product, price
FROM (SELECT category, product, price,
             ROW_NUMBER() OVER (PARTITION BY category ORDER BY price DESC) AS rn
      FROM products) AS ranked
WHERE rn = 1;
