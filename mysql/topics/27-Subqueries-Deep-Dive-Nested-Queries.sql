-- 📘 Part 5: Advanced Querying (Subqueries, CTEs, Views, Tables) (Topics 27–39)
-- ======================================================================

-- ---

-- ======================================================================
-- Topic 27: Subqueries Deep Dive (Nested Queries)
-- ======================================================================

-- ------------------------------------------------------------
-- 📖 In Simple Words
-- ------------------------------------------------------------

-- * Definition: A subquery is a query written inside another query. The inner query runs first and its result is used by the outer query.

-- * Real-life example: "Show me students who scored above the class average" — first find the average, then compare.

-- * 🧩 Syntax:
--     -- in WHERE (scalar / list):
--     SELECT ... FROM t WHERE col > (SELECT AGG(col) FROM t2);
--     SELECT ... FROM t WHERE col IN (SELECT col FROM t2);
--     -- in FROM (derived table):
--     SELECT ... FROM (SELECT ...) AS alias;
--     -- in SELECT (one value per row):
--     SELECT col, (SELECT ... ) AS alias FROM t;

-- * Syntax explained (each part):
--   - Inner query → runs first and returns a value, a list or a table
--   - Outer query → uses that result
--   - Scalar subquery → must return exactly one value
--   - AS alias → required for a subquery in FROM

-- * Example on salesdb (run 00-Setup-Sample-Data.sql first):
USE salesdb;
SELECT product, price
FROM products
WHERE price > (SELECT AVG(price) FROM products);

-- * Example explained (step by step):
--   1. The inner query calculates the average price: (10+15+20+25+30)/5 = 20.
--   2. The outer query keeps products more expensive than 20.
--   3. Result: Caps 25 and Gloves 30.

-- ------------------------------------------------------------
-- 27.1 What is a Subquery?
-- ------------------------------------------------------------

-- * Definition: A subquery is a SQL query that is written inside another query. It is also known as an Inner Query or a Nested Query. 

-- * The Structure:

--   1. The outer query is called the Main Query.

--   2. The inside query is called the Subquery (or Nested Query).

-- ------------------------------------------------------------
-- 27.2 How Subqueries Work (The Execution Flow)
-- ------------------------------------------------------------

-- * Diagram summary: Shows the DB Tables sending data to the Inner SubQuery, which creates an intermediate result, which is then used by the Main Query to produce the Final Result

--   ┌ ASCII diagram
--   │  [DB Tables] ──► [Inner SubQuery] ──► (intermediate result) ──► [Main Query] ──► [Final Result]
--   │                     runs first                                   uses it
--   └

-- * Subqueries act as an embedded query. SQL executes them in a specific order (usually from the innermost query to the outermost — sometimes described as "Right to Left"). (A correlated subquery is the exception: it runs once for each row of the outer query — see 28.3.)

-- * Step-by-step Flow:

--   1. Inner Query Runs First: SQL executes the subquery first. It retrieves data from the database.

--   2. Intermediate Result: The result of the subquery is NOT shown directly to the user. Instead, it becomes a temporary (intermediate) dataset stored in memory.

--   3. Main Query Takes Over: The main query uses this intermediate result to perform operations like Filtering (`WHERE`), Joining, Ordering, or Aggregation.

--   4. Final Output: The main query merges its own table data with the subquery's result to produce the final output for the user.

-- ------------------------------------------------------------
-- 27.3 Why are Subqueries Important? (When to use them)
-- ------------------------------------------------------------

-- * Diagram summary: Shows Main Query, SubQuery, and Nested Subquery wrapped like Russian Dolls

--   ┌ ASCII diagram
--   │  ┌──────────── Main Query ────────────┐
--   │  │  ┌──────── SubQuery ─────────┐      │
--   │  │  │  ┌── Nested SubQuery ──┐  │      │
--   │  │  │  │   runs 1st          │  │      │
--   │  │  │  └─────────────────────┘  │ 2nd  │
--   │  │  └───────────────────────────┘      │ 3rd
--   │  └─────────────────────────────────────┘
--   └

-- * Use Cases:

--   * To filter data based on values calculated from another table.

--   * To perform aggregations (like `MAX`, `AVG`) and use that aggregated value in a `WHERE` condition.

--   * To simplify complex logic step-by-step and avoid confusing `JOIN` operations.

-- * Importance:

--   * They break down complex problems into smaller, manageable chunks.

--   * They allow writing cleaner and more readable SQL.

--   * They prevent the need for creating physical Temporary Tables.

-- * Where can they be used?

--   * In the `SELECT` clause (to return a calculated value).

--   * In the `FROM` clause (used as a temporary table/derived table).

--   * In the `WHERE` clause (to filter based on another query).

--   * In the `HAVING` clause (to filter after a `GROUP BY`).

-- ------------------------------------------------------------
-- 27.4 The Golden Rules of Subqueries
-- ------------------------------------------------------------

-- 1. The inner query runs first, and its result is passed to the outer query.

-- 2. A subquery must be enclosed in parentheses `()`.

-- 3. No DML Inside: By design, a subquery cannot perform DML (`INSERT`, `UPDATE`, `DELETE`) operations inside it. It must produce a result set (rows/columns or a single value). *Example of what NOT to do: `SELECT * FROM (DELETE FROM employees);` (This will fail).*

-- 4. The outer query depends on the result of the inner query. The outer query can be an `INSERT`, `UPDATE`, or `DELETE` statement.

-- ------------------------------------------------------------
-- Using Subqueries with DML (Outer Query)
-- ------------------------------------------------------------

-- * INSERT with Subquery:
INSERT INTO high_salary_emps (emp_id, name, salary)
SELECT id, name, salary FROM employees 
WHERE salary > (SELECT AVG(salary) FROM employees);

-- * UPDATE with Subquery:
UPDATE employees SET bonus = 1000 
WHERE dept_id IN (SELECT id FROM departments WHERE location = 'New York');

-- * DELETE with Subquery:
DELETE FROM employees 
WHERE dept_id = (SELECT id FROM departments WHERE dept_name = 'ClosedDept');

-- ------------------------------------------------------------
-- 27.5 Subquery Classification (Types of Subqueries)
-- ------------------------------------------------------------

-- * Diagram summary: Shows the classification by Result Types, Dependency, and Location

--   ┌ ASCII diagram
--   │                     Subqueries
--   │       ┌─────────────────┼─────────────────┐
--   │   By Result Type     By Dependency     By Location
--   │   - Scalar (1 value) - Non-correlated  - SELECT
--   │   - Row (1 row)      - Correlated      - FROM
--   │   - Table (many)                       - JOIN
--   │                                        - WHERE
--   └

-- Subqueries can be categorized in three different ways:

-- ------------------------------------------------------------
-- A. Based on DEPENDENCY (Connection to Main Query)
-- ------------------------------------------------------------

-- 1. Non-Correlated Subquery: 

--    * The subquery is completely independent of the outer query. It executes only ONCE, and the result is passed to the outer query. This is the most common type.

-- 2. Correlated Subquery: 

--    * The subquery totally depends on the main query. It is executed ONCE FOR EACH ROW processed by the outer query. It is used when comparing values within a group or partition.

-- ------------------------------------------------------------
-- B. Based on RESULT TYPE (What the Inner Query Returns)
-- ------------------------------------------------------------

-- 1. Scalar Subquery (Single-Row, Single-Column):

--    * Returns exactly one single value (one row and one column). Often used in `SELECT` or `WHERE` with operators like `=`, `<`, `>`.

--    * Example: Find all employees who earn more than the average salary.
SELECT name, salary FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);

-- 2. Row Subquery (Single-Row, Multiple-Columns):

--    * Returns a single row but multiple columns. Used with operators like `=`, `IN`, or row-value comparison.

--    * Example: `WHERE (col1, col2) = (SELECT col1, col2 FROM table LIMIT 1);`

-- 3. Table Subquery (Multiple-Rows, Multiple-Columns):

--    * Returns multiple rows and columns (looks like a table). It is heavily used in the `FROM` clause (also known as a Derived Table) or with the `IN` operator.

--    * Example: `SELECT * FROM (SELECT id, name FROM employees) AS temp_table;`

-- ------------------------------------------------------------
-- C. Based on LOCATION / CLAUSES
-- ------------------------------------------------------------

-- 1. SELECT clause

-- 2. FROM clause (Creates a derived table)

-- 3. JOIN clause

-- 4. WHERE clause: This is the most common place. Operations here are split into two types:

--    * Comparison Operators: `<`, `>`, `=`, `!=`, `<=`, `>=` (Used with Scalar subqueries).

--    * Logical Operators: `IN`, `ANY`, `ALL`, `EXISTS` (Used with Row or Table subqueries).

-- * Q1. Correlated vs non-correlated subquery?

--   * Answer: A non-correlated subquery runs once on its own; a correlated one references the outer row and conceptually runs once per outer row (e.g. salary above own department's average).

-- * **Q2. `IN` vs `EXISTS` — which is faster?**

--   * Answer: `EXISTS` stops at the first match and never has the NULL problem, so it is the safe choice for 'does a related row exist?', especially when the subquery is large. `IN` is fine for a short, fixed list or a small, NULL-free subquery. MySQL 8 often rewrites both into the same semi-join, so check `EXPLAIN`.

-- * **Q3. Why does `NOT IN (subquery)` sometimes return 0 rows?**

--   * Answer: If the subquery returns even one NULL, `x NOT IN (..., NULL)` is UNKNOWN for every row. Use `NOT EXISTS` or add `WHERE col IS NOT NULL` in the subquery.

-- * Q4. Error 1093 'You can't specify target table for update in FROM clause' — how do you fix it?

--   * Answer: MySQL cannot UPDATE/DELETE a table while reading the same table in a subquery. Wrap the subquery in a derived table (`... WHERE id IN (SELECT id FROM (SELECT ...) t)`) or use a JOIN: `DELETE c1 FROM customers c1 JOIN customers c2 ON ...`.

-- * Q5. Subquery vs JOIN — which do you prefer?

--   * Answer: JOIN when you need columns from both tables; subquery/EXISTS for filtering; avoid correlated subqueries on big tables — rewrite them as JOIN or window functions.

-- ---

-- ======================================================================
-- 🎯 Practice Questions (salesdb sample data) — try first, then look at the answer
-- ======================================================================
-- Run 00-Setup-Sample-Data.sql once before this section.

USE salesdb;

-- Q1. Products more expensive than the average price.
SELECT product, price FROM products WHERE price > (SELECT AVG(price) FROM products);

-- Q2. Customers who placed at least one order (IN).
SELECT firstname FROM customers WHERE customerid IN (SELECT customerid FROM orders);

-- Q3. Each customer with their number of orders (subquery in SELECT).
SELECT firstname,
       (SELECT COUNT(*) FROM orders o WHERE o.customerid = c.customerid) AS orders_count
FROM customers c;
