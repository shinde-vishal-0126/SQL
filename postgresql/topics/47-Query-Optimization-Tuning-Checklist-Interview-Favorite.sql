-- ======================================================================
-- Topic 47: Query Optimization / Tuning Checklist (Interview Favorite)
-- ======================================================================

-- ------------------------------------------------------------
-- 📖 In Simple Words
-- ------------------------------------------------------------

-- * Definition: Query tuning means rewriting a query or adding indexes so the same result comes back faster and with less work for the database.

-- * Real-life example: Taking the highway instead of small lanes — same destination, less time.

-- * 🧩 Syntax:
--     -- Sargable filter (index-friendly):
--     WHERE col >= start_value AND col < end_value
--     -- instead of:
--     WHERE FUNCTION(col) = value
--     EXPLAIN [ANALYZE] SELECT ...;     -- always check the plan

-- * Syntax explained (each part):
--   - Sargable → the column stays bare on one side so an index can be used
--   - Function on column → hides the index and forces a scan
--   - EXPLAIN → proves whether the change helped

-- * Example on salesdb (run 00-Setup-Sample-Data.sql first):
SET search_path TO sales;
-- Slow style: function on the column hides the index
SELECT * FROM orders WHERE EXTRACT(YEAR FROM orderdate) = 2025 AND EXTRACT(MONTH FROM orderdate) = 2;
-- Fast style: plain range on the column
SELECT * FROM orders WHERE orderdate >= '2025-02-01' AND orderdate < '2025-03-01';

-- * Example explained (step by step):
--   1. Both queries return the same 4 February orders (5, 6, 7, 8).
--   2. The first one wraps orderdate in a function, so an index on orderdate cannot be used.
--   3. The second one compares the column directly, so an index can be used — this is called a sargable query.

-- If an interviewer asks: "You have a slow query, how do you optimize it?", follow this checklist:

-- 1. Check the Execution Plan (`EXPLAIN (ANALYZE, BUFFERS)`): Look for `Seq Scan` on big tables and wrong row estimates. Are indexes being used (`Index Scan` / `Index Only Scan`)?

-- 2. Avoid `SELECT *`: Only select the columns you actually need. Less data transferred = faster query.

-- 3. Analyze `WHERE` clauses:

--    * Avoid functions on indexed columns in the `WHERE` clause (e.g., `WHERE EXTRACT(YEAR FROM order_date) = 2023` breaks the index. Use `WHERE order_date >= '2023-01-01' AND order_date < '2024-01-01'`, or create an expression index).

--    * Avoid leading wildcards in `LIKE` (e.g., `LIKE '%name'` can't use a B-Tree; use `LIKE 'name%'` with a `text_pattern_ops` index, or a `pg_trgm` GIN index for `%name%`).

--    * Make the types match (e.g., don't compare an `INT` column with a text value) so no cast blocks the index.

-- 4. Optimize Joins: 

--    * Join on indexed columns (Foreign Keys / Primary Keys).

--    * Filter data before joining by using subqueries or CTEs to reduce the dataset size early on.

-- 5. Add or Rebuild Indexes: If a query filters on a column frequently, add an index (and index foreign keys — PostgreSQL doesn't do it automatically). If an index is bloated, `REINDEX CONCURRENTLY`. Keep statistics fresh with `ANALYZE` and make sure autovacuum keeps up.

-- 6. Consider Partitioning: If the table is massive (millions of rows), partition it by Date/Year.

-- 7. 🐘 PostgreSQL extras: check `pg_stat_statements` to find the most expensive queries; tune `work_mem` for sorts/hashes; use a materialized view for heavy reports; use a connection pooler (PgBouncer).

-- ---

-- ======================================================================
-- 🧪 Practice Examples (salesdb sample data)
-- ======================================================================
-- First run 00-Setup-Sample-Data.sql once. Then run these one by one (select a statement → execute).
-- pgAdmin: open the Query Tool on database "salesdb".
SET search_path TO sales;

-- 1. Select only needed columns
SELECT orderid, orderdate, sales FROM orders WHERE customerid = 2;

-- 2. Keep the indexed column clean (sargable):
EXPLAIN SELECT * FROM orders WHERE EXTRACT(YEAR FROM orderdate) = 2025;                  -- cannot use index on orderdate
EXPLAIN SELECT * FROM orders WHERE orderdate >= '2025-01-01' AND orderdate < '2026-01-01';

-- 3. Index columns used in WHERE / JOIN / ORDER BY:
CREATE INDEX idx_orders_orderdate ON orders (orderdate);
EXPLAIN SELECT * FROM orders WHERE orderdate >= '2025-02-01';
DROP INDEX idx_orders_orderdate;

-- 4. EXISTS for "has any" checks:
SELECT c.customerid, c.firstname
FROM customers c
WHERE EXISTS (SELECT 1 FROM orders o WHERE o.customerid = c.customerid);

-- 5. UNION ALL when duplicates are fine:
SELECT orderid, sales FROM orders
UNION ALL
SELECT orderid, sales FROM ordersarchive;   -- archive table is named ordersarchive in the course PostgreSQL data

-- 6. Filter early with WHERE:
SELECT customerid, SUM(sales) AS total
FROM orders
WHERE orderstatus = 'Delivered'
GROUP BY customerid;

-- 7. Keep statistics fresh and read the plan:
ANALYZE orders;
EXPLAIN (ANALYZE, BUFFERS) SELECT customerid, SUM(sales) FROM orders GROUP BY customerid;

-- ======================================================================
-- 🎯 Practice Questions (salesdb sample data) — try first, then look at the answer
-- ======================================================================
-- Run 00-Setup-Sample-Data.sql once before this section.

SET search_path TO sales;

-- Q1. Rewrite a non-sargable filter (function on column) into a sargable one.
-- slow: SELECT * FROM orders WHERE EXTRACT(MONTH FROM orderdate) = 2;
SELECT * FROM orders WHERE orderdate >= '2025-02-01' AND orderdate < '2025-03-01';

-- Q2. Replace a correlated subquery with a JOIN + GROUP BY.
SELECT c.firstname, COUNT(o.orderid) AS orders_count
FROM customers c
LEFT JOIN orders o ON o.customerid = c.customerid
GROUP BY c.customerid, c.firstname;
