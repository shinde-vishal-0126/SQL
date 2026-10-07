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

-- * 🧩 Syntax:
--     SHOW ENGINES;
--     SELECT table_name, engine, data_length, index_length
--     FROM information_schema.tables WHERE table_schema = 'db';
--     CREATE TABLE t (...) ENGINE = InnoDB;

-- * Syntax explained (each part):
--   - Engine → the storage layer (MySQL: InnoDB; PostgreSQL: one built-in heap engine)
--   - Page → fixed-size block on disk (InnoDB 16 KB / PostgreSQL 8 KB)
--   - Buffer pool / shared_buffers → memory cache for pages

-- * Example on salesdb (run 00-Setup-Sample-Data.sql first):
USE salesdb;
SELECT table_name, engine, table_rows, data_length
FROM information_schema.tables
WHERE table_schema = 'salesdb';

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

--      * Information Schema: All this metadata is stored in a special, built-in schema called the **`INFORMATION_SCHEMA`**. It contains views that help us find information about our tables. (e.g., `SELECT * FROM INFORMATION_SCHEMA.COLUMNS;`).

--   3. Temporary Data Storage: Temporary space used by the database for short-term tasks like processing complex queries or sorting data. Once the task is done, this storage is cleared.

-- ------------------------------------------------------------
-- 2. Cache Storage (Short-term Memory)
-- ------------------------------------------------------------

-- * Definition: Cache is fast, short-term memory (like RAM) where data is stored temporarily.

-- * Pros/Cons: It can only store smaller amounts of data (lower capacity), but it is extremely fast to read and write.

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

--   * ⚠️ Correction (MySQL): MySQL 8.0 has no query-result cache (the old Query Cache was removed). What is cached is the data pages in the InnoDB Buffer Pool (RAM). So the second run is faster because the pages are already in memory, but the query itself is still executed again.

-- ---

-- ======================================================================
-- 🧪 Practice Examples (salesdb sample data)
-- ======================================================================
-- First run 00-Setup-Sample-Data.sql once. Then run these one by one (select a statement → execute).
USE salesdb;

-- Storage engine of each table (InnoDB = transactions, row locks, clustered index):
SELECT table_name, engine, row_format, table_rows, data_length, index_length
FROM information_schema.tables
WHERE table_schema = 'salesdb';

SHOW ENGINES;                                  -- engines available on this server
SHOW TABLE STATUS FROM salesdb LIKE 'orders';  -- size, rows, engine of one table

-- Pages and buffer pool:
SELECT @@innodb_page_size;                     -- default 16384 bytes (16 KB) per page
SELECT @@innodb_buffer_pool_size / 1024 / 1024 AS buffer_pool_mb;

-- Where the data files live:
SELECT @@datadir;

-- ======================================================================
-- 🎯 Practice Questions (salesdb sample data) — try first, then look at the answer
-- ======================================================================
-- Run 00-Setup-Sample-Data.sql once before this section.

USE salesdb;

-- Q1. Which storage engine / access method do the tables use?
SELECT table_name, engine FROM information_schema.tables WHERE table_schema = 'salesdb';

-- Q2. Data size vs index size of each table.
SELECT table_name, data_length, index_length FROM information_schema.tables WHERE table_schema = 'salesdb';
