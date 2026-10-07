-- ======================================================================
-- Topic 46: SQL Table Partitioning (Performance Optimization)
-- ======================================================================

-- ------------------------------------------------------------
-- 📖 In Simple Words
-- ------------------------------------------------------------

-- * Definition: Partitioning splits one big table into smaller parts (partitions) by a rule, e.g. by year, while you still query it as one table. Queries that filter on the rule read only the needed part.

-- * Real-life example: Keeping bills in separate folders per year instead of one huge folder.

-- * 🧩 Syntax:
--     CREATE TABLE t (cols ...)
--     PARTITION BY RANGE (expression) (
--       PARTITION p1 VALUES LESS THAN (value1),
--       PARTITION p2 VALUES LESS THAN (value2),
--       PARTITION pmax VALUES LESS THAN MAXVALUE
--     );
--     -- also: PARTITION BY LIST (col) / HASH (col) PARTITIONS n

-- * Syntax explained (each part):
--   - RANGE → rows go to a partition by value ranges (dates, numbers)
--   - LIST → by a list of values (countries, statuses)
--   - HASH → spread evenly by a hash
--   - Partition pruning → WHERE on the partition key reads only the needed partitions

-- * Example on salesdb (run 00-Setup-Sample-Data.sql first):
USE salesdb;
CREATE TABLE orders_by_year (orderid INT, orderdate DATE, sales INT)
PARTITION BY RANGE (YEAR(orderdate)) (
  PARTITION p2024 VALUES LESS THAN (2025),
  PARTITION p2025 VALUES LESS THAN (2026)
);
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

-- * How it works: MySQL automatically decides which partition(s) to read based on your query. You don't have to manually select from different tables; the database engine handles the routing for you.

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

-- * Targeted Scanning: We split the table by year. When you run `SELECT * FROM table WHERE year = 2025`, MySQL will only scan the 2025 partition and completely ignore 2023 and 2024.

-- * Parallel Processing: Modern databases can process each partition independently and in parallel. This drastically reduces overall execution time.

-- * Smaller Indexes: 

--   * Instead of one giant index, each partition gets its own smaller index. When you insert data in 2025, it only updates the small index for 2025 without touching the 2023/2024 indexes. This makes indexing highly efficient.

-- ------------------------------------------------------------
-- 46.4 Advantages & Limitations of Partitioning
-- ------------------------------------------------------------

-- * Advantages:

--   * Speeds up queries: Targeted partition scanning is incredibly fast.

--   * Maintenance: Archiving is trivial.

--   * Fast Deletions: You can drop old data instantly: `ALTER TABLE sales DROP PARTITION p2022;` (This is much faster than running a massive `DELETE` query).

--   * Parallelism: Supports parallel processing for big data.

--     * ⚠️ Note: MySQL itself does not scan partitions in parallel for one query; the main MySQL benefit is partition pruning (skipping partitions). Parallel partition processing is found in SQL Server, Oracle and data warehouses.

-- * Limitations (MySQL):

--   * Works mostly with `InnoDB` or `NDB` engines.

--   * The Primary Key (or Unique Key) MUST include the partition key column(s).

--   * Too many partitions can actually hurt performance.

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

--   * *Note (corrected): MySQL has no LEFT/RIGHT keyword. MySQL uses `VALUES LESS THAN (x)`, which means "strictly less than x", so the boundary value `x` itself always goes to the next (right) partition. Example: with `PARTITION p2023 VALUES LESS THAN (2024)`, year 2023 goes to `p2023`, but year 2024 goes to the next partition.*

-- ------------------------------------------------------------
-- 46.6 Building Partitions in MySQL (4 Steps)
-- ------------------------------------------------------------

-- 1. Create a Partitioned Table (Inline Creation)
-- In MySQL, partitioning logic is defined inline with the table creation.
CREATE TABLE person_data (
    sales_id INT AUTO_INCREMENT,
    amount INT,
    order_date DATE,
    -- The partition column (order_date) MUST be part of the Primary Key
    PRIMARY KEY(sales_id, order_date)
)
PARTITION BY RANGE(YEAR(order_date)) (
    PARTITION p2022 VALUES LESS THAN (2023),
    PARTITION p2023 VALUES LESS THAN (2024),
    PARTITION p2024 VALUES LESS THAN (2025),
    PARTITION pmax VALUES LESS THAN MAXVALUE
);

-- 2. View All Partitions

-- * Check table structure:
SHOW CREATE TABLE person_data;

-- * Best way to check partition metadata (Detailed):
SELECT 
    TABLE_SCHEMA,
    TABLE_NAME,
    PARTITION_NAME,
    PARTITION_ORDINAL_POSITION AS position,
    PARTITION_METHOD,
    PARTITION_DESCRIPTION AS range_value,
    TABLE_ROWS
FROM INFORMATION_SCHEMA.PARTITIONS
WHERE TABLE_NAME = 'person_data';

-- 3. Adding Partitions to an Existing Empty Table
-- If the table is completely empty, you can alter it directly:
ALTER TABLE sales
PARTITION BY RANGE (YEAR(order_date)) (
    PARTITION p2022 VALUES LESS THAN (2023),
    PARTITION p2023 VALUES LESS THAN (2024),
    PARTITION pmax VALUES LESS THAN MAXVALUE
);

-- * ⚠️ Note: The same `ALTER TABLE ... PARTITION BY` also works on a table that already has data — MySQL rebuilds (copies) the whole table, which can take a long time and blocks writes on a big table. That is why the clone method below is preferred for huge tables. Remember: every `PRIMARY KEY` / `UNIQUE` key must include `order_date`, otherwise the `ALTER` fails.

-- 4. Adding Partitions to a Table WITH Existing Data (Recommended Safe Way)
-- MySQL doesn’t easily let you add partitions to a huge table full of data. The safest way is to clone it.

-- * Step 1: Rename the old table.
RENAME TABLE sales TO sales_old;

-- * Step 2: Create a new partitioned table with the exact same structure (Ensure the partition key is in the PK).

-- * Step 3: Copy data back.
INSERT INTO sales SELECT * FROM sales_old;

-- ------------------------------------------------------------
-- 46.7 Interview Perspective (Pro-Tips)
-- ------------------------------------------------------------

-- * Q: Indexing vs Partitioning?

--   * A: Indexing optimizes search by creating a sorted tree of pointers. Partitioning optimizes search by physically dividing the table into smaller chunks. Combining both (Partitioned Indexing) gives maximum performance for massive data.

-- * Q: Why is dropping a partition better than deleting old rows?

--   * A: Running `DELETE FROM table WHERE year = 2022` removes rows one-by-one, logging every deletion and heavily fragmenting the index. Running `ALTER TABLE table DROP PARTITION p2022` just deletes the physical file from the disk instantly, saving hours of processing time!

-- ---

-- ======================================================================
-- 🎯 Practice Questions (salesdb sample data) — try first, then look at the answer
-- ======================================================================
-- Run 00-Setup-Sample-Data.sql once before this section.

USE salesdb;

-- Q1. Create a copy of orders partitioned by year (RANGE).
CREATE TABLE orders_part (
  orderid INT, orderdate DATE, sales INT     -- no primary key: the archive has repeated orderids
)
PARTITION BY RANGE (YEAR(orderdate)) (
  PARTITION p2024 VALUES LESS THAN (2025),
  PARTITION p2025 VALUES LESS THAN (2026),
  PARTITION pmax  VALUES LESS THAN MAXVALUE
);
INSERT INTO orders_part SELECT orderid, orderdate, sales FROM orders;
INSERT INTO orders_part SELECT orderid + 100, orderdate, sales FROM orders_archive;

-- Q2. Rows per partition and partition pruning.
SELECT partition_name, table_rows FROM information_schema.partitions WHERE table_name = 'orders_part';
EXPLAIN SELECT * FROM orders_part WHERE orderdate >= '2025-01-01';   -- partitions: p2025,pmax

-- Q3. Drop the practice table.
DROP TABLE orders_part;
