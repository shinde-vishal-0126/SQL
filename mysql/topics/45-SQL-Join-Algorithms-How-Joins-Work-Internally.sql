-- ======================================================================
-- Topic 45: SQL Join Algorithms (How Joins Work Internally)
-- ======================================================================

-- ------------------------------------------------------------
-- 📖 In Simple Words
-- ------------------------------------------------------------

-- * Definition: Join algorithms are the methods the engine uses to match rows of two tables: Nested Loop (for each row, look up matches), Hash Join (build a hash table, then probe), Merge Join (both sides sorted, then merge).

-- * Real-life example: Nested loop = for each guest, search the list; hash = sort guests into boxes by first letter first; merge = two alphabetically sorted lists walked side by side.

-- * 🧩 Syntax:
--     EXPLAIN FORMAT=TREE SELECT ... FROM a JOIN b ON a.k = b.k;
--     -- shows: Nested loop inner join / Inner hash join

-- * Syntax explained (each part):
--   - Nested Loop → for each outer row, look up inner rows (best with an index)
--   - Hash Join → build a hash table of the smaller side, then probe it
--   - Merge Join → both inputs sorted by the key, then merged

-- * Example on salesdb (run 00-Setup-Sample-Data.sql first):
USE salesdb;
EXPLAIN FORMAT=TREE
SELECT o.orderid, p.product
FROM orders o JOIN products p ON p.productid = o.productid;

-- * Example explained (step by step):
--   1. The plan shows which algorithm the optimizer picked for this join.
--   2. MySQL usually shows a nested loop using the products primary key; PostgreSQL often shows a Hash Join on small tables.
--   3. You write the same JOIN — the database chooses the algorithm.

-- * Diagram summary: Shows Nested Loop Join, Hash Join, and Block Nested Loop Join concepts

--   ┌ ASCII diagram
--   │  Nested Loop : for each row in A ─► look up matches in B (best with an index on B)
--   │  Hash Join   : build hash table of small B ─► scan A and probe the hash
--   │  Block NL    : read A in blocks ─► compare each block with B (fewer passes over B)
--   └

-- * Definition: A join algorithm is the method the SQL engine uses under the hood to combine rows from two (or more) tables. Even though you just write `JOIN`, MySQL must decide exactly how to perform that match.

-- ------------------------------------------------------------
-- 45.1 Nested Loop Join (NLJ)
-- ------------------------------------------------------------

-- * Definition: For each row in the first (outer) table, MySQL looks up matching rows in the second (inner) table.

-- * Details: This is the most common (default) algorithm. If there is an index on the join column, it is an Index Nested Loop Join (Very Fast). If there is no index, it becomes very slow.

-- ------------------------------------------------------------
-- 45.2 Hash Join (MySQL 8.0.18+)
-- ------------------------------------------------------------

-- * Definition: Builds a hash table in memory from one table, then probes (checks) it with rows from the other table.

-- * Details: Used for large, non-indexed joins. It is much faster than nested loops when indexes are missing.

-- ------------------------------------------------------------
-- 45.3 Block Nested Loop Join (BNLJ)
-- ------------------------------------------------------------

-- * Definition: Uses blocks of rows (chunks) instead of one-by-one row comparisons.

-- * Details: Improves performance when indexes aren't helpful, reducing the number of times the inner table needs to be scanned.

-- * ⚠️ Note: Block Nested Loop was removed in MySQL 8.0.20; MySQL now uses Hash Join in the same situations (join without a usable index). You will still see BNL in older MySQL 5.7 plans.

-- * Interview Perspective (SQL Server specific): 

--   * Merge Join Algorithm: Used when both tables are already sorted on the join keys. It merges them extremely efficiently. (Popular in SQL Server).

-- ---

-- ======================================================================
-- 🧪 Practice Examples (salesdb sample data)
-- ======================================================================
-- First run 00-Setup-Sample-Data.sql once. Then run these one by one (select a statement → execute).
USE salesdb;

-- Index nested loop: for each order, look up the customer by primary key (eq_ref)
EXPLAIN FORMAT=TREE
SELECT o.orderid, c.firstname
FROM orders o
JOIN customers c ON c.customerid = o.customerid;

-- Hash join (MySQL 8.0.18+): join column without an index → "Inner hash join"
EXPLAIN FORMAT=TREE
SELECT c.firstname, e.firstname AS employee
FROM customers c
JOIN employees e ON e.firstname = c.firstname;     -- Kevin and Mary appear in both tables

-- Run it to see the result:
SELECT c.firstname, e.firstname AS employee, e.department
FROM customers c
JOIN employees e ON e.firstname = c.firstname;

-- Compare with actual timing:
EXPLAIN ANALYZE
SELECT o.orderid, p.product
FROM orders o
JOIN products p ON p.productid = o.productid;

-- ======================================================================
-- 🎯 Practice Questions (salesdb sample data) — try first, then look at the answer
-- ======================================================================
-- Run 00-Setup-Sample-Data.sql once before this section.

USE salesdb;

-- Q1. Look at the join algorithm chosen for orders ⨝ products.
EXPLAIN FORMAT=TREE SELECT o.orderid, p.product FROM orders o JOIN products p ON p.productid = o.productid;

-- Q2. Force a different algorithm and compare (PostgreSQL) / hash join without index (MySQL).
EXPLAIN FORMAT=TREE SELECT c.firstname, e.department FROM customers c JOIN employees e ON e.lastname = c.lastname;
