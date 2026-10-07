-- 📘 Part 6: Performance, Indexing & Database Internals (Topics 40–48)
-- ======================================================================

-- ---

-- ======================================================================
-- Topic 40: Database Engine Architecture & Storage Concepts
-- ======================================================================

-- ------------------------------------------------------------
-- 📖 In Simple Words
-- ------------------------------------------------------------

-- * Definition: The database engine is the part of the DBMS that actually stores data on disk and reads it back, in fixed-size pages, using memory (buffer pool / shared buffers) to stay fast.

-- * Real-life example: A warehouse: goods (rows) are packed in boxes (pages) on shelves (disk), and popular boxes are kept near the door (memory).

-- * Example on salesdb (run 00-Setup-Sample-Data.sql first):
SET search_path TO sales;
SELECT relname, n_live_tup, pg_size_pretty(pg_table_size(relid)) AS size
FROM pg_stat_user_tables
WHERE schemaname = 'sales';

-- * Example explained (step by step):
--   1. This asks the engine how each table is stored.
--   2. MySQL shows the engine InnoDB and the bytes used; PostgreSQL shows rows and size on disk.
--   3. Each small table still takes at least one page (16 KB in MySQL, 8 KB in PostgreSQL).

-- ------------------------------------------------------------
-- 40.1 What is a Data Warehouse?
-- ------------------------------------------------------------

-- * Definition: A special database that collects data from different sources and integrates it into one centralized place. It enables heavy analytics and supports business decision-making.

-- ------------------------------------------------------------
-- 40.2 The Database Engine
-- ------------------------------------------------------------

-- * Definition: The Database Engine is the "brain" of the database. It is responsible for executing multiple operations such as storing, retrieving, and managing data within the database.

-- * Every time you execute a query, the Database Engine takes care of processing it.

-- ------------------------------------------------------------
-- 40.3 Database Storage Types (Disk vs Cache)
-- ------------------------------------------------------------

-- * Diagram summary: Shows Client sending query to Server. Database Engine checks Cache first, then checks Disk [Temp, Catalog, User]

-- * In a database, there are two main types of data storage:

-- ------------------------------------------------------------
-- 1. Disk Storage (Long-term Memory)
-- ------------------------------------------------------------

-- * Definition: Disk storage is where data is stored permanently. 

-- * Pros/Cons: It has a very high capacity to hold massive amounts of data, but it is slow to read and write compared to cache.

-- * Disk storage is divided into 3 main areas depending on their purpose:

--   1. User Data Storage: This is the main content of the database. It stores the actual data that the user cares about (e.g., all the information in your `customer` or `orders` tables). This is the storage the user actively interacts with.

--   2. System Catalog Storage (Metadata): This is the database's internal storage for its own information. It is a blueprint that keeps track of everything about the database itself (not the user data). Its main purpose is to hold the Metadata (Data about Data). 

--      * Example: If you create a `customer` table, the Database doesn't just store the user data. It also stores metadata like `tableName`, `columnName`, `dataTypes`, length, and constraints in the System Catalog.

--      * Information Schema & pg_catalog: PostgreSQL stores this metadata in system tables in the `pg_catalog` schema (`pg_class` = tables/indexes, `pg_attribute` = columns, `pg_namespace` = schemas). The SQL-standard `information_schema` views sit on top of them. (e.g., `SELECT * FROM information_schema.columns;` or psql `\d orders`).

--   3. Temporary Data Storage: Temporary space used for short-term tasks like big sorts or hash joins that don't fit in `work_mem`. PostgreSQL writes them as temp files (in `base/pgsql_tmp` or a `temp_tablespaces` location) and deletes them when the query ends.

--   4. 🐘 WAL (Write-Ahead Log) in `pg_wal/`: every change is written here first, for crash recovery and replication.

-- ------------------------------------------------------------
-- 2. Cache Storage (Short-term Memory)
-- ------------------------------------------------------------

-- * Definition: Cache is fast, short-term memory (like RAM) where data is stored temporarily.

-- * Pros/Cons: It can only store smaller amounts of data (lower capacity), but it is extremely fast to read and write.

-- * 🐘 In PostgreSQL the cache is `shared_buffers` (shared by all connections; often ~25% of RAM). PostgreSQL also relies on the operating system's file cache (double buffering). Each query also gets private memory `work_mem` for sorts and hashes.

-- ------------------------------------------------------------
-- 40.4 How a Simple Query Works (Step-by-Step)
-- ------------------------------------------------------------

-- * Diagram summary: Shows the flow of a query: Client -> Engine -> Cache [MISS] -> Disk -> Return Result & Store in Cache

-- When a Data Engineer writes a query like `SELECT * FROM orders`:

-- 1. Send Query: The query is sent from the Client side to the Database Server.

-- 2. Check Cache (Fast Path): The Database Engine takes the query and first checks the Cache Storage. Because cache is extremely fast, if the information is already there, the engine solves the task instantly.

-- 3. Check Disk (Slow Path): If the query information is NOT in the cache, the Database Engine says, "Query data is not in cache, let's check Disk Storage." It finds the relevant table in the User Data Storage and executes the query.

-- 4. Return Result: The result of the query is sent back to the Client side. 

-- * Note: Once the result is fetched from the disk, the Database Engine will also store it in the Cache so that if someone runs the exact same query again, it returns instantly!

--   * ⚠️ Correction (PostgreSQL): PostgreSQL has no query-result cache. What is cached is the 8 KB data pages in `shared_buffers` (and the OS cache). So the second run is faster because the pages are already in memory, but the query itself is executed again. See it with `EXPLAIN (ANALYZE, BUFFERS)`: `shared hit` = from memory, `read` = from disk.

-- ---

-- ======================================================================
-- 🧪 Practice Examples (salesdb sample data)
-- ======================================================================
-- First run 00-Setup-Sample-Data.sql once. Then run these one by one (select a statement → execute).
-- pgAdmin: open the Query Tool on database "salesdb".
SET search_path TO sales;

-- Size of each table (heap) and its indexes:
SELECT relname AS table_name,
       pg_size_pretty(pg_table_size(relid))   AS table_size,
       pg_size_pretty(pg_indexes_size(relid)) AS index_size,
       n_live_tup, n_dead_tup
FROM pg_stat_user_tables
WHERE schemaname = 'sales';

-- Page (block) size and shared buffers:
SHOW block_size;                 -- 8192 bytes (8 KB) per page
SHOW shared_buffers;

-- Where the data files live and which file holds the orders table:
SHOW data_directory;
SELECT pg_relation_filepath('sales.orders');

-- MVCC: each row version has hidden system columns
SELECT xmin, xmax, ctid, orderid FROM orders LIMIT 5;

-- ======================================================================
-- 🎯 Practice Questions (salesdb sample data) — try first, then look at the answer
-- ======================================================================
-- Run 00-Setup-Sample-Data.sql once before this section.

SET search_path TO sales;

-- Q1. Which storage engine / access method do the tables use?
SELECT c.relname, am.amname FROM pg_class c JOIN pg_am am ON am.oid = c.relam
JOIN pg_namespace n ON n.oid = c.relnamespace WHERE n.nspname = 'sales';

-- Q2. Data size vs index size of each table.
SELECT relname, pg_table_size(relid) AS data_bytes, pg_indexes_size(relid) AS index_bytes
FROM pg_stat_user_tables WHERE schemaname = 'sales';
