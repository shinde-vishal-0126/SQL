-- ======================================================================
-- Topic 42: Heap vs Clustered Index (Internal Storage)
-- ======================================================================

-- ------------------------------------------------------------
-- 📖 In Simple Words
-- ------------------------------------------------------------

-- * Definition: A heap is a table whose rows are stored in no particular order. A clustered index stores the rows themselves sorted by the key (InnoDB primary key). PostgreSQL tables are always heaps with separate indexes.

-- * Real-life example: Heap = clothes thrown in a pile. Clustered = clothes folded and arranged by size on the shelf.

-- * 🧩 Syntax:
--     -- Clustered index in InnoDB = the PRIMARY KEY:
--     CREATE TABLE t (id INT PRIMARY KEY, ...);           -- rows stored in id order
--     CREATE INDEX idx_name ON t (col);                    -- secondary (non-clustered) index

-- * Syntax explained (each part):
--   - Heap → rows stored without order
--   - Clustered index → the table rows themselves sorted by the key
--   - Secondary index → separate structure that points to the row

-- * Example on salesdb (run 00-Setup-Sample-Data.sql first):
USE salesdb;
SHOW INDEX FROM orders;          -- PRIMARY = clustered index
SHOW INDEX FROM orders_archive;  -- no PRIMARY → hidden row id

-- * Example explained (step by step):
--   1. MySQL: orders has a PRIMARY index, so its rows are stored in orderid order (clustered); orders_archive has no primary key.
--   2. PostgreSQL: ctid shows where each row physically sits in the heap, e.g. (0,1) = page 0, row 1.
--   3. Indexes then point to those row locations.

-- ------------------------------------------------------------
-- 42.1 What is a Heap Table?
-- ------------------------------------------------------------

-- * Definition: A Heap is a table without a clustered index (no Primary Key). The data is not stored in any specific order — it’s just a collection of rows stored randomly wherever space is available.

-- * Characteristics:

--   * No clustered index: Data has no defined physical order.

--   * Storage: Rows are appended randomly.

--   * Access Method: Usually requires a Full Table Scan (unless non-clustered indexes exist).

--   * Pros: Faster inserts (data goes anywhere).

--   * Cons: Slower lookups.

-- * ⚠️ MySQL Note: This describes SQL Server. In MySQL InnoDB there are no heap tables: without a Primary Key, InnoDB clusters the table on the first `UNIQUE NOT NULL` index or on a hidden 6-byte row ID.

-- ------------------------------------------------------------
-- 42.2 What is a Clustered Index?
-- ------------------------------------------------------------

-- * Definition: A Clustered Index determines the physical order of data in the table. The table’s rows are stored on disk in the exact order of the clustered index key. (In InnoDB MySQL, the primary key is always the clustered index).

-- * Characteristics:

--   * One per table: You can have only ONE clustered index.

--   * Data stored in order: Physically arranged by the key.

--   * Pros: Extremely fast range queries and exact match lookups.

--   * Cons: Slower inserts if the key order changes (can cause page splits).

--   * Note: Non-clustered indexes store this clustered key as a pointer to find the actual data row.

-- ---

-- ======================================================================
-- 🧪 Practice Examples (salesdb sample data)
-- ======================================================================
-- First run 00-Setup-Sample-Data.sql once. Then run these one by one (select a statement → execute).
USE salesdb;

-- InnoDB tables are clustered on the PRIMARY KEY: rows are stored in customerid order.
SELECT * FROM customers;                         -- comes back in primary key order

-- orders_archive has NO primary key → InnoDB adds a hidden row id (heap-like table).
SHOW INDEX FROM orders_archive;                  -- only secondary indexes, no PRIMARY
SHOW INDEX FROM orders;                          -- PRIMARY (clustered) + secondary indexes

-- Secondary (non-clustered) index lookup → then reads the row from the clustered index:
EXPLAIN SELECT * FROM orders WHERE customerid = 2;

-- Covering index: the index alone answers the query (Extra: Using index):
EXPLAIN SELECT customerid FROM orders WHERE customerid = 2;

-- ======================================================================
-- 🎯 Practice Questions (salesdb sample data) — try first, then look at the answer
-- ======================================================================
-- Run 00-Setup-Sample-Data.sql once before this section.

USE salesdb;

-- Q1. Which tables have a primary key (clustered in InnoDB) and which do not?
SELECT t.table_name, MAX(c.constraint_type = 'PRIMARY KEY') AS has_pk
FROM information_schema.tables t
LEFT JOIN information_schema.table_constraints c
  ON c.table_schema = t.table_schema AND c.table_name = t.table_name
WHERE t.table_schema = 'salesdb'
GROUP BY t.table_name;

-- Q2. Covering index: answer the query from the index only.
CREATE INDEX idx_orders_cust_sales ON orders (customerid, sales);
EXPLAIN SELECT customerid, sales FROM orders WHERE customerid = 2;   -- Extra: Using index
DROP INDEX idx_orders_cust_sales ON orders;
