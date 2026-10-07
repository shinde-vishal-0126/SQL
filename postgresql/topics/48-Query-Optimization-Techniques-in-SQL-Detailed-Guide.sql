-- ======================================================================
-- Topic 48: Query Optimization Techniques in SQL (Detailed Guide)
-- ======================================================================

-- ------------------------------------------------------------
-- 📖 In Simple Words
-- ------------------------------------------------------------

-- * Definition: Optimization techniques are practical habits for fast SQL: select only needed columns, filter early, use EXISTS for checks, avoid functions on indexed columns, paginate with keys, and check EXPLAIN.

-- * Real-life example: Packing only what you need for a trip instead of the whole house.

-- * Example on salesdb (run 00-Setup-Sample-Data.sql first):
SET search_path TO sales;
SELECT p.product
FROM products p
WHERE EXISTS (SELECT 1 FROM orders o WHERE o.productid = p.productid);

-- * Example explained (step by step):
--   1. We want products that were ordered at least once.
--   2. EXISTS stops searching as soon as it finds one matching order — no duplicates, no DISTINCT needed.
--   3. Result: Bottle, Tire, Caps, Gloves (Socks was never ordered).

-- ------------------------------------------------------------
-- 48.1 What is Query Optimization?
-- ------------------------------------------------------------

-- * Query optimization techniques are methods used to improve the efficiency of SQL queries so that they run faster and use fewer resources (CPU, memory, disk I/O, network).

-- * When you write a query, the DBMS query optimizer decides the best execution plan. Optimization techniques help the optimizer produce efficient plans (and help us write queries that it can run efficiently).

-- ------------------------------------------------------------
-- 48.2 Step 1: Measure First — EXPLAIN, EXPLAIN (FORMAT JSON), EXPLAIN ANALYZE
-- ------------------------------------------------------------

-- * Before optimizing, measure the performance of your query: how it runs and how much time it takes.

-- * `EXPLAIN` shows how the database will execute a query — the order of tables, the access/join methods and the index usage. It is the plan the database made to run the query.

-- * Why use `EXPLAIN`? It helps you understand:

--   * The query execution plan,

--   * Which indexes are used or ignored,

--   * Sequential scans and other bottlenecks,

--   * The join order and join algorithms,

--   * The estimated number of rows, and whether sorting (`Sort`), hashing (`Hash`) or full scans (`Seq Scan`) will happen.
EXPLAIN SELECT * FROM employees WHERE department_id = 5;

--   * This shows a tree of plan nodes with `cost`, `rows` and `width`. `EXPLAIN` does not run the query and does not show time — it only predicts the execution.

-- * `EXPLAIN (FORMAT JSON)` — for a structured output (also `YAML`, `XML`):
EXPLAIN (FORMAT JSON) SELECT * FROM employees WHERE department_id = 5;

--   * Returns the same plan as JSON — easy to paste into visual tools (explain.depesz.com, explain.dalibo.com) or parse in scripts.

--   * It still does not run the query.

-- * `EXPLAIN ANALYZE` actually executes the query and shows the real execution plan with real statistics:
EXPLAIN (ANALYZE, BUFFERS) SELECT * FROM employees WHERE department_id = 5;

--   * It is realistic → actual time, actual rows and loops per step, plus `Buffers: shared hit / read` (memory vs disk).

--   * Why use it? Compare estimated vs actual rows, find the slow steps, and tune indexes, joins, `work_mem` or the query itself.

--   * ⚠️ It really runs the statement — for `INSERT/UPDATE/DELETE` use `BEGIN; EXPLAIN ANALYZE ...; ROLLBACK;`.

-- * Find WHICH queries to optimize: `pg_stat_statements` extension:
CREATE EXTENSION IF NOT EXISTS pg_stat_statements;   -- also needs shared_preload_libraries
SELECT query, calls, total_exec_time, mean_exec_time, rows
FROM pg_stat_statements
ORDER BY total_exec_time DESC
LIMIT 10;

-- ------------------------------------------------------------
-- 48.3 Optimize Data Retrieval
-- ------------------------------------------------------------

-- * Select only the needed columns – avoid `SELECT *`; list the columns explicitly to reduce data transfer and processing.

-- * **Filter early with `WHERE`** – apply restrictive `WHERE` conditions to reduce the dataset as soon as possible.

-- * Use `LIMIT` / `FETCH FIRST` (PostgreSQL) or `TOP` (SQL Server) with `OFFSET` for pagination – don't fetch rows you don't need when you only need a subset. For very deep pages, use keyset pagination (`WHERE id > last_seen_id ORDER BY id LIMIT 20`) because a large `OFFSET` still reads and skips all earlier rows.

-- * Avoid unnecessary subqueries; use `JOIN` or `EXISTS` instead.

-- * Avoid functions on indexed columns in `WHERE` (e.g. `WHERE EXTRACT(YEAR FROM order_date) = 2023` prevents index use) → rewrite as a range: `WHERE order_date >= '2023-01-01' AND order_date < '2024-01-01'`.

-- ------------------------------------------------------------
-- 48.4 Indexing Strategies
-- ------------------------------------------------------------

-- * Use indexes on frequently searched columns (primary keys, foreign keys, and columns in `WHERE`, `JOIN`, `ORDER BY`, `GROUP BY`).

-- * Indexing acts as a shortcut that helps the database find and retrieve data much faster. But indexes must also be designed well:

--   * Index the columns used in `WHERE`, `JOIN`, `GROUP BY`, `ORDER BY`.

--   * Use covering indexes (`CREATE INDEX ... (col) INCLUDE (other_cols)`), so PostgreSQL can answer from the index — `EXPLAIN` shows `Index Only Scan` (needs a recently vacuumed table).

--   * Avoid indexing very small tables — the overhead is not worth it.

--   * Avoid over-indexing (it hurts write performance).

--   * Use composite indexes wisely → column order matters (leftmost prefix rule).

--   * Keep index columns short. PostgreSQL has no prefix index like MySQL `INDEX(email(20))`; use an expression index (`CREATE INDEX ON users (LEFT(email, 20))`) or a hash index for long values.

--   * PostgreSQL extras: partial indexes (`WHERE status = 'ACTIVE'`), GIN for JSONB/arrays/full-text, BRIN for huge time-ordered tables, and index foreign keys yourself.

-- ------------------------------------------------------------
-- 48.5 Join Optimization
-- ------------------------------------------------------------

-- * Join only the necessary tables (don't bring in extra tables you don't use).

-- * Filter early: add filters so fewer rows go into the join — for an `INNER JOIN` put conditions in `WHERE` or `ON`; for a `LEFT JOIN`, conditions on the right table belong in `ON` (in `WHERE` they turn it into an inner join).

-- * Use indexed join keys (make sure the columns used in the join are indexed).

-- * Select only the needed columns (avoid `SELECT *`).

-- * Let the planner choose the join order (PostgreSQL has no index hints like MySQL `FORCE INDEX` / `STRAIGHT_JOIN`); give it good statistics (`ANALYZE`) and check it with `EXPLAIN`.

-- * Use `EXISTS` instead of `DISTINCT` with joins when you only need to check existence.

-- * Use CTEs or derived tables for repeated subsets.

-- * Combine joins with pagination (`LIMIT`) to show limited data on a page.

-- ------------------------------------------------------------
-- 48.6 Avoid Costly Operations
-- ------------------------------------------------------------

-- * **`DISTINCT` – use only when necessary** (prefer `GROUP BY` or `EXISTS`).

--   * It forces the database to sort/hash and compare rows to remove duplicates. This is extra work, especially when you retrieve many columns, the dataset is large and there is no supporting index.

--   * Fix the root cause of duplicates: add a `UNIQUE` constraint on the column, or fix the join that creates duplicates.

--   * If you are aggregating anyway, `GROUP BY` removes duplicates too.

--   * If the `DISTINCT` column is indexed, the database can read sorted data directly without a full sort.

--   * Use `EXISTS` instead of `DISTINCT` on joins; avoid `SELECT *` with `DISTINCT`.

-- * **`UNION` vs `UNION ALL`:**

--   * **`UNION`** – combines the results of two or more queries and removes duplicates. Slower — needs an extra deduplication step. Use it when the final result must have unique rows, or when duplicates would give wrong results (reports, aggregation).

--   * **`UNION ALL`** – combines results without removing duplicates. Faster — no extra comparison. Use it when you don't care about duplicates, when the inputs are already unique, or when performance is critical.

-- * **`NOT IN`, `<>`, `!=`** often cause full scans → use `NOT EXISTS` or positive/range filters.

-- * **`LIKE` searches** → `'%abc'` cannot use an index, but `'abc%'` can.

-- * Use PostgreSQL full-text search (`tsvector @@ tsquery` + GIN), `pg_trgm` for `%x%` searches, or search engines (Elasticsearch) for complex text search.

-- ------------------------------------------------------------
-- 48.7 Data Type Optimization
-- ------------------------------------------------------------

-- * Use the smallest suitable type → smaller types = less storage = faster reads/writes and better cache usage.

-- * Use `SMALLINT`, `INT`, `BIGINT` appropriately (PostgreSQL has no `TINYINT`); `NUMERIC` for money, `REAL`/`DOUBLE PRECISION` for scientific values.

-- * Use `TEXT` / `VARCHAR(n)` for strings (`CHAR(n)` has no speed benefit in PostgreSQL).

-- * Use proper date/time types (`DATE`, `TIMESTAMPTZ`), `BOOLEAN` for flags, `UUID` for UUIDs (16 bytes, not `CHAR(36)`), `JSONB` (not `JSON`) for documents.

-- * Use an `ENUM` type or a small lookup table / `CHECK` for fixed categorical values.

-- * Avoid storing numbers or dates as `VARCHAR`.

-- * Column order matters a little in PostgreSQL: put fixed-size columns (`BIGINT`, `TIMESTAMPTZ`, `INT`) before variable ones to reduce alignment padding.

-- ------------------------------------------------------------
-- 48.8 Stored Procedures for Optimization
-- ------------------------------------------------------------

-- * Why can stored procedures help with optimization?

--   * PL/pgSQL caches the plans of the SQL statements inside a function/procedure per connection, so repeated calls skip parsing and planning (after a few calls PostgreSQL may use a generic plan).

--   * They reduce network traffic: the logic is sent once and each run is a single `CALL` instead of many queries — related queries are combined in one call, reducing round trips.

--   * Useful for batch processing and frequently repeated queries.

-- ------------------------------------------------------------
-- 48.9 Avoid `!=` / `<>` in WHERE Clauses
-- ------------------------------------------------------------

-- * Conditions like `WHERE status != 'completed'` usually cause a full scan: the database must look at every row to find the non-completed statuses.

-- * To optimize, use positive matching instead: `WHERE status IN ('pending', 'processing')`.

-- ------------------------------------------------------------
-- 48.10 Subquery Optimization
-- ------------------------------------------------------------

-- * Prefer `EXISTS` over `IN` when checking existence (especially for large subquery results, and always prefer `NOT EXISTS` over `NOT IN` because of `NULL`s).

-- * Use a `JOIN` instead of a correlated subquery where possible.

-- * Use range conditions for numbers and dates (`BETWEEN`, `>=` and `<`) so indexes can be used.

-- ------------------------------------------------------------
-- 48.11 Batch & Parallel Processing
-- ------------------------------------------------------------

-- * Process large updates/inserts/deletes in batches. PostgreSQL has no `DELETE ... LIMIT`, so use a subquery: `DELETE FROM logs WHERE id IN (SELECT id FROM logs WHERE created_at < '2024-01-01' LIMIT 10000);` repeated until 0 rows (a procedure can `COMMIT` after each batch — Topic 35.18). For whole time ranges, dropping a partition is best.

-- * Avoid row-by-row processing ("RBAR" — Row By Agonizing Row) → use set-based queries (one `UPDATE` for many rows instead of a loop).

-- * PostgreSQL runs big scans, joins and aggregates in parallel automatically (`Gather` + `Parallel Seq Scan` in the plan). Tune `max_parallel_workers_per_gather` (default 2).

-- ------------------------------------------------------------
-- 48.12 Partitioning & Sharding (Advanced)
-- ------------------------------------------------------------

-- * Partition large tables by range, list or hash — queries get faster because irrelevant partitions are skipped (partition pruning). (Topic 46)

-- * Shard very large datasets across multiple servers (each server holds part of the data, e.g. by customer region).

-- ------------------------------------------------------------
-- 48.13 Caching
-- ------------------------------------------------------------

-- * Application-level caching (Redis, Memcached) reduces repeated database calls. PostgreSQL has no query-result cache; `shared_buffers` caches data pages. For heavy reports, a materialized view is a database-side cache (`REFRESH MATERIALIZED VIEW CONCURRENTLY`).

-- ------------------------------------------------------------
-- 48.14 Use Window Functions
-- ------------------------------------------------------------

-- * Instead of subqueries or self-joins for ranking/aggregation, use `ROW_NUMBER()`, `RANK()`, `LAG()`, etc. They process the data in one pass and are often faster. (Topic 26)

-- ------------------------------------------------------------
-- 48.15 Connection & Transaction Management
-- ------------------------------------------------------------

-- * Use connection pooling → avoid the overhead of opening/closing database connections. This is extra important in PostgreSQL because every connection is a separate server process; use PgBouncer (or the app's pool) instead of thousands of direct connections.

-- * 🐘 Keep autovacuum healthy: dead rows from updates/deletes slow scans and bloat indexes (Topic 19.9).

-- * Keep transactions short → reduces locking and blocking.

-- * In short: Query optimization techniques include measuring with `EXPLAIN`, indexing, efficient joins, reducing unnecessary data retrieval, avoiding costly operations, choosing proper data types, partitioning, caching and using execution plans.

-- ---

-- ======================================================================
-- 🎯 Practice Questions (salesdb sample data) — try first, then look at the answer
-- ======================================================================
-- Run 00-Setup-Sample-Data.sql once before this section.

SET search_path TO sales;

-- Q1. Pagination: page 2 of orders (3 per page) — keyset is faster than OFFSET on big tables.
SELECT orderid, sales FROM orders ORDER BY orderid LIMIT 3 OFFSET 3;
SELECT orderid, sales FROM orders WHERE orderid > 3 ORDER BY orderid LIMIT 3;   -- keyset

-- Q2. Avoid SELECT DISTINCT on a join; use EXISTS.
SELECT p.product FROM products p
WHERE EXISTS (SELECT 1 FROM orders o WHERE o.productid = p.productid);

-- Q3. Pre-aggregate before joining.
SELECT p.product, t.total_sales
FROM (SELECT productid, SUM(sales) AS total_sales FROM orders GROUP BY productid) t
JOIN products p ON p.productid = t.productid;
