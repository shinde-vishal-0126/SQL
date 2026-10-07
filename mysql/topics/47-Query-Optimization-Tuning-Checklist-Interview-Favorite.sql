-- ======================================================================
-- Topic 47: Query Optimization / Tuning Checklist (Interview Favorite)
-- ======================================================================

-- ------------------------------------------------------------
-- 📖 In Simple Words
-- ------------------------------------------------------------

-- * Definition: Query tuning means rewriting a query or adding indexes so the same result comes back faster and with less work for the database.

-- * Real-life example: Taking the highway instead of small lanes — same destination, less time.

-- * Example on salesdb (run 00-Setup-Sample-Data.sql first):
USE salesdb;
-- Slow style: function on the column hides the index
SELECT * FROM orders WHERE YEAR(orderdate) = 2025 AND MONTH(orderdate) = 2;
-- Fast style: plain range on the column
SELECT * FROM orders WHERE orderdate >= '2025-02-01' AND orderdate < '2025-03-01';

-- * Example explained (step by step):
--   1. Both queries return the same 4 February orders (5, 6, 7, 8).
--   2. The first one wraps orderdate in a function, so an index on orderdate cannot be used.
--   3. The second one compares the column directly, so an index can be used — this is called a sargable query.

-- If an interviewer asks: "You have a slow query, how do you optimize it?", follow this checklist:

-- 1. **Check the Execution Plan (`EXPLAIN`):** Look for "Full Table Scans". Are indexes being used properly (Index Seek vs Scan)?

-- 2. **Avoid `SELECT *`:** Only select the columns you actually need. Less data transferred = faster query.

-- 3. **Analyze `WHERE` clauses:** 

--    * Avoid functions on indexed columns in the `WHERE` clause (e.g., `WHERE YEAR(date) = 2023` breaks the index. Use `WHERE date >= '2023-01-01'`).

--    * Avoid leading wildcards in `LIKE` (e.g., `LIKE '%name'` prevents index usage. Use `LIKE 'name%'`).

-- 4. Optimize Joins: 

--    * Join on indexed columns (Foreign Keys / Primary Keys).

--    * Filter data before joining by using subqueries or CTEs to reduce the dataset size early on.

-- 5. Add or Rebuild Indexes: If a query filters on a column frequently, add an index. If the index is fragmented, rebuild it.

-- 6. Consider Partitioning: If the table is massive (millions of rows), partition it by Date/Year.

-- ---

-- ======================================================================
-- 🧪 Practice Examples (salesdb sample data)
-- ======================================================================
-- First run 00-Setup-Sample-Data.sql once. Then run these one by one (select a statement → execute).
USE salesdb;

-- 1. Select only needed columns (not SELECT *)
SELECT orderid, orderdate, sales FROM orders WHERE customerid = 2;

-- 2. Do not wrap the indexed column in a function — the index cannot be used:
EXPLAIN SELECT * FROM orders WHERE YEAR(orderdate) = 2025;                        -- full scan
EXPLAIN SELECT * FROM orders WHERE orderdate >= '2025-01-01' AND orderdate < '2026-01-01';  -- sargable

-- 3. Index columns used in WHERE / JOIN / ORDER BY:
CREATE INDEX idx_orders_orderdate ON orders (orderdate);
EXPLAIN SELECT * FROM orders WHERE orderdate >= '2025-02-01';
DROP INDEX idx_orders_orderdate ON orders;

-- 4. EXISTS instead of IN for "has any" checks:
SELECT c.customerid, c.firstname
FROM customers c
WHERE EXISTS (SELECT 1 FROM orders o WHERE o.customerid = c.customerid);

-- 5. UNION ALL instead of UNION when duplicates are fine (no sort / distinct step):
SELECT orderid, sales FROM orders
UNION ALL
SELECT orderid, sales FROM orders_archive;

-- 6. Filter before grouping (WHERE), not after (HAVING) when possible:
SELECT customerid, SUM(sales) AS total
FROM orders
WHERE orderstatus = 'Delivered'
GROUP BY customerid;

-- 7. Check the plan:
EXPLAIN ANALYZE SELECT customerid, SUM(sales) FROM orders GROUP BY customerid;

-- ======================================================================
-- 🎯 Practice Questions (salesdb sample data) — try first, then look at the answer
-- ======================================================================
-- Run 00-Setup-Sample-Data.sql once before this section.

USE salesdb;

-- Q1. Rewrite a non-sargable filter (function on column) into a sargable one.
-- slow: SELECT * FROM orders WHERE MONTH(orderdate) = 2;
SELECT * FROM orders WHERE orderdate >= '2025-02-01' AND orderdate < '2025-03-01';

-- Q2. Replace a correlated subquery with a JOIN + GROUP BY.
SELECT c.firstname, COUNT(o.orderid) AS orders_count
FROM customers c
LEFT JOIN orders o ON o.customerid = c.customerid
GROUP BY c.customerid, c.firstname;
