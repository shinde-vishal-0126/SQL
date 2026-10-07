-- ======================================================================
-- Topic 46: SQL Table Partitioning (Performance Optimization)
-- ======================================================================

-- ------------------------------------------------------------
-- 📖 In Simple Words
-- ------------------------------------------------------------

-- * Definition: Partitioning splits one big table into smaller parts (partitions) by a rule, e.g. by year, while you still query it as one table. Queries that filter on the rule read only the needed part.

-- * Real-life example: Keeping bills in separate folders per year instead of one huge folder.

-- * Example on salesdb (run 00-Setup-Sample-Data.sql first):
SET search_path TO sales;
CREATE TABLE orders_by_year (orderid INT, orderdate DATE, sales INT) PARTITION BY RANGE (orderdate);
CREATE TABLE orders_2024 PARTITION OF orders_by_year FOR VALUES FROM ('2024-01-01') TO ('2025-01-01');
CREATE TABLE orders_2025 PARTITION OF orders_by_year FOR VALUES FROM ('2025-01-01') TO ('2026-01-01');
INSERT INTO orders_by_year SELECT orderid, orderdate, sales FROM orders;
EXPLAIN SELECT * FROM orders_by_year WHERE orderdate >= '2025-01-01';
DROP TABLE orders_by_year;

-- * Example explained (step by step):
--   1. The table is split into a 2024 part and a 2025 part.
--   2. All 10 orders are from 2025, so they go into the 2025 partition.
--   3. EXPLAIN shows only the 2025 partition is read (partition pruning).

-- ------------------------------------------------------------
-- 46.1 What is Partitioning?
-- ------------------------------------------------------------

-- * Definition: Partitioning is the process of splitting one large, big table into smaller, manageable physical pieces (called partitions) while keeping it logically as one single table for queries.

-- * How it works: PostgreSQL automatically decides which partition(s) to read based on your query (partition pruning). You don't have to manually select from different tables; the database engine handles the routing for you.

-- ------------------------------------------------------------
-- 46.2 The Problem: Why Do We Need Partitioning?
-- ------------------------------------------------------------

-- * Diagram summary: A massive 100M+ row table causes full table scans to be extremely slow. Trying to fix it with a massive single index also fails because inserting, updating, and deleting rows in a huge index takes a long time

-- * Scenario: Imagine a table with 100 million rows that grows every year (e.g., 2023, 2024, 2025). 

--   * If you do a full table scan, it takes forever.

--   * If you add a massive index, reading is faster, but `INSERT`, `UPDATE`, and `DELETE` operations become extremely slow because updating a massive index tree takes heavy processing.

--   * Usually, you only query new data (e.g., 2025) heavily, and rarely need old data (e.g., 2023).

-- ------------------------------------------------------------
-- 46.3 The Solution: Partitioning & Scalability
-- ------------------------------------------------------------

-- * Diagram summary: Each partition gets its own small index instead of one giant index for the whole table

-- * Diagram summary: The big table is split by year. A query for 2025 ONLY scans the 2025 partition

-- * Targeted Scanning: We split the table by year. When you run `SELECT * FROM table WHERE year = 2025`, PostgreSQL will only scan the 2025 partition and completely ignore 2023 and 2024.

-- * Parallel Processing: PostgreSQL can scan partitions with parallel workers (`Parallel Append`) and can join two tables partition-by-partition (`enable_partitionwise_join`). This drastically reduces overall execution time.

-- * Smaller Indexes: 

--   * Instead of one giant index, each partition gets its own smaller index. When you insert data in 2025, it only updates the small index for 2025 without touching the 2023/2024 indexes. This makes indexing highly efficient.

-- ------------------------------------------------------------
-- 46.4 Advantages & Limitations of Partitioning
-- ------------------------------------------------------------

-- * Advantages:

--   * Speeds up queries: Targeted partition scanning is incredibly fast.

--   * Maintenance: Archiving is trivial.

--   * Fast Deletions: You can drop old data instantly: `DROP TABLE sales_2022;` or first `ALTER TABLE sales DETACH PARTITION sales_2022;` (much faster than a massive `DELETE`, and no `VACUUM` work).

--   * Parallelism: Supports parallel processing for big data.

--     * 🐘 PostgreSQL can use parallel workers across partitions (MySQL cannot do this for one query).

-- * Limitations (PostgreSQL):

--   * A primary key or unique constraint on the parent table MUST include the partition key column(s).

--   * Rows don't go anywhere if no partition matches → error, unless you create a `DEFAULT` partition.

--   * Too many partitions (thousands) make planning slower.

--   * Partition pruning needs the filter on the partition key itself (`WHERE order_date >= ...`), not on a function of it.

-- ------------------------------------------------------------
-- 46.5 Partition Boundaries (LEFT vs RIGHT)
-- ------------------------------------------------------------

-- * Diagram summary: LEFT partitioning includes the boundary in the left partition, while RIGHT includes it in the right partition

-- * When using `RANGE` partitioning, we define boundaries (e.g., the last day of the year). But where does the exact boundary value go?

-- * **1. LEFT Partitioning (SQL Server `RANGE LEFT`):**

--   * The boundary value is included in the partition to the LEFT of the boundary.

--   * Example: A row exactly on `2023-12-31` belongs to Partition 1 (2023). 

-- * **2. RIGHT Partitioning (SQL Server `RANGE RIGHT`):**

--   * The boundary value is included in the partition to the RIGHT of the boundary.

--   * Example: A row exactly on `2023-12-31` belongs to Partition 2 (Next year).

--   * 🐘 PostgreSQL has no LEFT/RIGHT keyword. It uses `FOR VALUES FROM (lower) TO (upper)`: lower is inclusive, upper is exclusive. So the upper value always belongs to the next partition. Example: `FROM ('2023-01-01') TO ('2024-01-01')` holds every 2023 date; `2024-01-01` goes to the 2024 partition. (MySQL: `VALUES LESS THAN (x)` — same idea.)

-- ------------------------------------------------------------
-- 46.6 Building Partitions in PostgreSQL (Declarative Partitioning, 4 Steps)
-- ------------------------------------------------------------

-- 1. Create a Partitioned Table (parent + child tables)
-- In PostgreSQL the parent table only defines the structure and the partition key; each partition is its own table.
CREATE TABLE person_data (
    sales_id   BIGINT GENERATED ALWAYS AS IDENTITY,
    amount     INT,
    order_date DATE NOT NULL,
    -- The partition column (order_date) MUST be part of the Primary Key
    PRIMARY KEY (sales_id, order_date)
) PARTITION BY RANGE (order_date);

CREATE TABLE person_data_2022 PARTITION OF person_data FOR VALUES FROM ('2022-01-01') TO ('2023-01-01');
CREATE TABLE person_data_2023 PARTITION OF person_data FOR VALUES FROM ('2023-01-01') TO ('2024-01-01');
CREATE TABLE person_data_2024 PARTITION OF person_data FOR VALUES FROM ('2024-01-01') TO ('2025-01-01');
CREATE TABLE person_data_default PARTITION OF person_data DEFAULT;   -- like MySQL MAXVALUE (catches everything else)

-- * Other methods: `PARTITION BY LIST (country)` → `FOR VALUES IN ('India', 'Nepal')`; `PARTITION BY HASH (customer_id)` → `FOR VALUES WITH (MODULUS 4, REMAINDER 0)`.

-- * An index created on the parent is created on every partition automatically: `CREATE INDEX ON person_data (amount);`

-- 2. View All Partitions

-- * Check table structure (psql):
-- (psql/client command — run it in psql, not in a GUI query tool):
-- \d+ person_data

-- * Partition metadata with row counts:
SELECT c.relname AS partition_name,
       pg_get_expr(c.relpartbound, c.oid) AS range_value,
       s.n_live_tup AS approx_rows
FROM pg_inherits i
JOIN pg_class c ON c.oid = i.inhrelid
LEFT JOIN pg_stat_user_tables s ON s.relid = c.oid
WHERE i.inhparent = 'person_data'::regclass;

-- PostgreSQL 12+:
SELECT * FROM pg_partition_tree('person_data');

-- 3. Adding a New Partition / Removing an Old One
-- add next year
CREATE TABLE person_data_2025 PARTITION OF person_data
    FOR VALUES FROM ('2025-01-01') TO ('2026-01-01');

-- take old year out (keeps it as a normal table, e.g. for archive)
ALTER TABLE person_data DETACH PARTITION person_data_2022;     -- PG 14+: ... CONCURRENTLY
DROP TABLE person_data_2022;                                   -- instant delete of all 2022 rows

-- * ⚠️ Note: An existing normal table cannot be turned into a partitioned table with one `ALTER` in PostgreSQL. Use the clone method below, or attach an existing table as a partition: `ALTER TABLE sales ATTACH PARTITION sales_2021 FOR VALUES FROM ('2021-01-01') TO ('2022-01-01');` (PostgreSQL checks all rows; add a matching `CHECK` constraint first to skip the scan).

-- 4. Partitioning a Table WITH Existing Data (Safe Way)

-- * Step 1: Rename the old table.
ALTER TABLE sales RENAME TO sales_old;

-- * Step 2: Create a new partitioned table `sales` with the same columns and its partitions (partition key in the PK).

-- * Step 3: Copy data back (in batches for very big tables).
INSERT INTO sales SELECT * FROM sales_old;

-- * Tip: The `pg_partman` extension creates future partitions and drops old ones automatically (often run by `pg_cron`).

-- ------------------------------------------------------------
-- 46.7 Interview Perspective (Pro-Tips)
-- ------------------------------------------------------------

-- * Q: Indexing vs Partitioning?

--   * A: Indexing optimizes search by creating a sorted tree of pointers. Partitioning optimizes search by physically dividing the table into smaller chunks. Combining both (Partitioned Indexing) gives maximum performance for massive data.

-- * Q: Why is dropping a partition better than deleting old rows?

--   * A: Running `DELETE FROM sales WHERE order_date < '2023-01-01'` marks rows dead one-by-one, writes WAL for every row, bloats the table and indexes, and leaves work for `VACUUM`. `DROP TABLE sales_2022` (after `DETACH PARTITION`) just removes the partition's files instantly.

-- ---

-- ======================================================================
-- 🎯 Practice Questions (salesdb sample data) — try first, then look at the answer
-- ======================================================================
-- Run 00-Setup-Sample-Data.sql once before this section.

SET search_path TO sales;

-- Q1. Create a copy of orders partitioned by year (RANGE).
CREATE TABLE orders_part (
  orderid INT, orderdate DATE, sales INT     -- no primary key: the archive has repeated orderids
) PARTITION BY RANGE (orderdate);
CREATE TABLE orders_part_2024 PARTITION OF orders_part FOR VALUES FROM ('2024-01-01') TO ('2025-01-01');
CREATE TABLE orders_part_2025 PARTITION OF orders_part FOR VALUES FROM ('2025-01-01') TO ('2026-01-01');
INSERT INTO orders_part SELECT orderid, orderdate, sales FROM orders;
INSERT INTO orders_part SELECT orderid + 100, orderdate, sales FROM ordersarchive;

-- Q2. Rows per partition and partition pruning.
SELECT tableoid::regclass AS partition, COUNT(*) FROM orders_part GROUP BY 1;
EXPLAIN SELECT * FROM orders_part WHERE orderdate >= '2025-01-01';   -- only orders_part_2025

-- Q3. Drop the practice table.
DROP TABLE orders_part;
