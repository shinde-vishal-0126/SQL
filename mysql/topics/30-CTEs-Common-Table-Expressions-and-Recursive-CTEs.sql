-- ======================================================================
-- Topic 30: CTEs (Common Table Expressions) & Recursive CTEs
-- ======================================================================

-- ------------------------------------------------------------
-- 📖 In Simple Words
-- ------------------------------------------------------------

-- * Definition: A CTE (Common Table Expression) is a named temporary result created with WITH, used by the next query. A recursive CTE calls itself to walk through levels like a hierarchy.

-- * Real-life example: Giving a name to a step in a recipe ("the sauce") and using it later; recursive = following a family tree generation by generation.

-- * 🧩 Syntax:
--     WITH cte_name [(col1, col2)] AS (
--       SELECT ...
--     )
--     SELECT ... FROM cte_name;
--     
--     WITH RECURSIVE cte_name AS (
--       SELECT ...                    -- anchor: starting rows
--       UNION ALL
--       SELECT ... FROM table JOIN cte_name ON ...   -- recursive part
--     )
--     SELECT * FROM cte_name;

-- * Syntax explained (each part):
--   - WITH → starts the CTE and gives it a name
--   - Anchor member → first query, runs once
--   - Recursive member → refers to the CTE itself, repeats until it returns no rows
--   - UNION ALL → joins the anchor and recursive results

-- * Example on salesdb (run 00-Setup-Sample-Data.sql first):
USE salesdb;
WITH RECURSIVE chain AS (
  SELECT employeeid, firstname, managerid, 1 AS level FROM employees WHERE managerid IS NULL
  UNION ALL
  SELECT e.employeeid, e.firstname, e.managerid, c.level + 1
  FROM employees e JOIN chain c ON e.managerid = c.employeeid
)
SELECT * FROM chain ORDER BY level;

-- * Example explained (step by step):
--   1. The first part starts with the top boss (no manager): Frank, level 1.
--   2. The second part repeatedly finds employees whose manager is already in the list.
--   3. Result: Frank (1) → Kevin, Mary (2) → Michael, Carol (3).

-- ------------------------------------------------------------
-- 30.1 What is a CTE?
-- ------------------------------------------------------------

-- * Definition: A CTE (Common Table Expression) is a temporary result set that you can reference within another `SELECT`, `INSERT`, `UPDATE`, or `DELETE` statement. It exists only for the duration of the query.

-- * Syntax:
WITH EmployeeCTE AS (
    SELECT id, name, salary FROM employees WHERE salary > 50000
)
SELECT * FROM EmployeeCTE;

-- ------------------------------------------------------------
-- 30.2 CTE vs Subquery vs Temp Table (Interview Favorite)
-- ------------------------------------------------------------
-- | Feature | Subquery | CTE | Temp Table (`#Temp`) |
-- | :--- | :--- | :--- | :--- |
-- | Readability | Hard to read if nested deeply. | Very easy to read (Top-down logic). | Easy to read. |
-- | Reusability | Cannot be reused in the same query. | Can be referenced multiple times in the same query. | Can be used across multiple queries in the same session. |
-- | Storage | Lives in memory (usually). | Lives in memory. | Lives physically in `tempdb` (on disk). |
-- | Performance | Optimizer treats it similarly to a CTE. | Optimizer treats it similarly to a Subquery. | Good for massive data (supports indexing). |

-- * ⚠️ MySQL Note: `#Temp` and `tempdb` are SQL Server names. In MySQL a temp table is created with `CREATE TEMPORARY TABLE t (...)` and lives in the session's temporary tablespace. Also, in MySQL a CTE or derived table is either merged into the main query or materialized into an internal temporary table (in memory, or on disk if it is large) — it is not guaranteed to "live in memory".

-- ------------------------------------------------------------
-- 30.3 Recursive CTEs
-- ------------------------------------------------------------

-- * Definition: A Recursive CTE is a CTE that references itself. It is primarily used for querying hierarchical data, such as Employee-Manager relationships, category trees, or organization charts.

-- * How it works: It has an Anchor Member (the starting point) and a Recursive Member (which loops until a condition is met), connected by `UNION ALL`.

-- * Recursive CTE Execution Flow:

-- ---

-- ======================================================================
-- 🎯 Practice Questions (salesdb sample data) — try first, then look at the answer
-- ======================================================================
-- Run 00-Setup-Sample-Data.sql once before this section.

USE salesdb;

-- Q1. CTE: customer totals, then filter.
WITH customer_totals AS (
  SELECT customerid, SUM(sales) AS total_sales FROM orders GROUP BY customerid
)
SELECT * FROM customer_totals WHERE total_sales > 50;

-- Q2. Multiple CTEs: totals and last order date, joined to customers.
WITH totals AS (SELECT customerid, SUM(sales) AS total_sales FROM orders GROUP BY customerid),
     last_order AS (SELECT customerid, MAX(orderdate) AS last_date FROM orders GROUP BY customerid)
SELECT c.firstname, t.total_sales, l.last_date
FROM customers c
JOIN totals t     ON t.customerid = c.customerid
JOIN last_order l ON l.customerid = c.customerid;

-- Q3. Recursive CTE: employee hierarchy with levels.
WITH RECURSIVE hierarchy AS (
  SELECT employeeid, firstname, managerid, 1 AS level FROM employees WHERE managerid IS NULL
  UNION ALL
  SELECT e.employeeid, e.firstname, e.managerid, h.level + 1
  FROM employees e JOIN hierarchy h ON e.managerid = h.employeeid
)
SELECT * FROM hierarchy ORDER BY level;
