-- ======================================================================
-- Topic 45: SQL Join Algorithms (How Joins Work Internally)
-- ======================================================================

-- ------------------------------------------------------------
-- 📖 In Simple Words
-- ------------------------------------------------------------

-- * Definition: Join algorithms are the methods the engine uses to match rows of two tables: Nested Loop (for each row, look up matches), Hash Join (build a hash table, then probe), Merge Join (both sides sorted, then merge).

-- * Real-life example: Nested loop = for each guest, search the list; hash = sort guests into boxes by first letter first; merge = two alphabetically sorted lists walked side by side.

-- * Example on salesdb (run 00-Setup-Sample-Data.sql first):
SET search_path TO sales;
EXPLAIN
SELECT o.orderid, p.product
FROM orders o JOIN products p ON p.productid = o.productid;

-- * Example explained (step by step):
--   1. The plan shows which algorithm the optimizer picked for this join.
--   2. MySQL usually shows a nested loop using the products primary key; PostgreSQL often shows a Hash Join on small tables.
--   3. You write the same JOIN — the database chooses the algorithm.

-- * Diagram summary: Shows Nested Loop Join, Hash Join, and Block Nested Loop Join concepts. PostgreSQL uses Nested Loop, Hash Join and Merge Join.

-- * Definition: A join algorithm is the method the SQL engine uses under the hood to combine rows from two (or more) tables. Even though you just write `JOIN`, the PostgreSQL planner must decide exactly how to perform that match — it estimates the cost of each algorithm and picks the cheapest. All three algorithms are available in PostgreSQL.

-- ------------------------------------------------------------
-- 45.1 Nested Loop Join (NLJ)
-- ------------------------------------------------------------

-- * Definition: For each row in the first (outer) table, PostgreSQL looks up matching rows in the second (inner) table.

-- * Details: Best when the outer side is small and the inner join column has an index (`Nested Loop` → `Index Scan` on the inner table). Without an index it becomes very slow, so PostgreSQL then prefers a Hash Join. It is the only algorithm that can handle non-equality joins (e.g. `ON a.x < b.y`).

-- ------------------------------------------------------------
-- 45.2 Hash Join
-- ------------------------------------------------------------

-- * Definition: Builds a hash table in memory from the smaller table (`Hash` node), then probes (checks) it with rows from the other table (`Hash Join`).

-- * Details: Used for large joins on `=` without useful indexes. The hash table must fit in `work_mem` × `hash_mem_multiplier`, otherwise it spills to disk in batches (`Batches: 4` in `EXPLAIN ANALYZE`). Can run in parallel.

-- ------------------------------------------------------------
-- 45.3 Merge Join (PostgreSQL) and Block Nested Loop (old MySQL)
-- ------------------------------------------------------------

-- * Merge Join: Both inputs are sorted on the join key (by an index, or by an explicit `Sort` step), then PostgreSQL walks both lists together, like merging two sorted lists. Very efficient for big joins when the data is already in order (e.g. both sides have a B-Tree index on the key), and for `FULL JOIN`.

-- * Block Nested Loop (BNLJ): An old MySQL algorithm that compared rows in blocks; removed in MySQL 8.0.20 (replaced by Hash Join). PostgreSQL never had it.

-- * See which one is used:
EXPLAIN SELECT * FROM orders o JOIN customers c ON o.customer_id = c.id;
--  Hash Join  (cost=... )
--    Hash Cond: (o.customer_id = c.id)
--    ->  Seq Scan on orders o
--    ->  Hash
--          ->  Seq Scan on customers c

-- * Testing tip: you can switch an algorithm off for one session to compare plans: `SET enable_hashjoin = off;` (only for testing, never in production).

-- ---

-- ======================================================================
-- 🎯 Practice Questions (salesdb sample data) — try first, then look at the answer
-- ======================================================================
-- Run 00-Setup-Sample-Data.sql once before this section.

SET search_path TO sales;

-- Q1. Look at the join algorithm chosen for orders ⨝ products.
EXPLAIN SELECT o.orderid, p.product FROM orders o JOIN products p ON p.productid = o.productid;

-- Q2. Force a different algorithm and compare (PostgreSQL) / hash join without index (MySQL).
SET enable_hashjoin = off;
EXPLAIN SELECT o.orderid, p.product FROM orders o JOIN products p ON p.productid = o.productid;   -- Merge or Nested Loop
SET enable_mergejoin = off;
EXPLAIN SELECT o.orderid, p.product FROM orders o JOIN products p ON p.productid = o.productid;   -- Nested Loop
RESET enable_hashjoin;
RESET enable_mergejoin;
