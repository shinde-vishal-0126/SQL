-- ======================================================================
-- Topic 42: Heap vs Clustered Index (Internal Storage)
-- ======================================================================

-- ------------------------------------------------------------
-- 📖 In Simple Words
-- ------------------------------------------------------------

-- * Definition: A heap is a table whose rows are stored in no particular order. A clustered index stores the rows themselves sorted by the key (InnoDB primary key). PostgreSQL tables are always heaps with separate indexes.

-- * Real-life example: Heap = clothes thrown in a pile. Clustered = clothes folded and arranged by size on the shelf.

-- * 🧩 Syntax:
--     -- PostgreSQL tables are heaps; indexes are separate:
--     CREATE TABLE t (id INT PRIMARY KEY, ...);
--     CREATE INDEX idx_name ON t (col) INCLUDE (other_col); -- covering index
--     CLUSTER t USING idx_name;                             -- one-time physical re-order

-- * Syntax explained (each part):
--   - Heap → rows stored without order
--   - Clustered index → the table rows themselves sorted by the key
--   - Secondary index → separate structure that points to the row

-- * Example on salesdb (run 00-Setup-Sample-Data.sql first):
SET search_path TO sales;
SELECT ctid, orderid FROM orders;   -- ctid = physical location (page, item) in the heap

-- * Example explained (step by step):
--   1. MySQL: orders has a PRIMARY index, so its rows are stored in orderid order (clustered); orders_archive has no primary key.
--   2. PostgreSQL: ctid shows where each row physically sits in the heap, e.g. (0,1) = page 0, row 1.
--   3. Indexes then point to those row locations.

-- ------------------------------------------------------------
-- 42.1 What is a Heap Table?
-- ------------------------------------------------------------

-- * Definition: A Heap is a table whose rows are not stored in any specific order — it's a collection of rows stored wherever space is available.

-- * Characteristics:

--   * No clustered order: Data has no defined physical order.

--   * Storage: Rows go into any page with free space (PostgreSQL tracks it in the Free Space Map).

--   * Access Method: Sequential Scan, unless an index exists (then Index Scan → heap fetch by CTID).

--   * Pros: Fast inserts; all indexes point straight to the row location (CTID).

--   * Cons: Range scans on the PK may read rows spread over many pages; an `UPDATE` that changes the row location must update every index (unless it is a HOT update).

-- * 🐘 PostgreSQL Note: In PostgreSQL EVERY table is a heap — with or without a primary key. The primary key is just a unique B-Tree index on the heap. (SQL Server: a heap is a table without a clustered index. MySQL InnoDB: no heap tables at all.)

-- ------------------------------------------------------------
-- 42.2 What is a Clustered Index?
-- ------------------------------------------------------------

-- * Definition: A Clustered Index determines the physical order of data in the table. The table's rows are stored on disk in the exact order of the clustered index key. (In MySQL InnoDB and SQL Server the primary key is usually the clustered index.)

-- * Characteristics:

--   * One per table: You can have only ONE clustered index.

--   * Data stored in order: Physically arranged by the key.

--   * Pros: Extremely fast range queries and exact match lookups.

--   * Cons: Slower inserts if the key order changes (can cause page splits).

--   * Note: In those databases, non-clustered indexes store the clustered key as a pointer to find the actual data row.

-- * 🐘 PostgreSQL: There is no clustered index. The closest things are:

--   * `CLUSTER table USING index;` — rewrites the table once in index order (locks the table; order is not kept for new rows).

--   * Covering indexes (`INCLUDE`) — the query can be answered from the index alone (Index-Only Scan).

--   * BRIN indexes — cheap when data is naturally in insert order (time-series).

-- ---

-- ======================================================================
-- 🧪 Practice Examples (salesdb sample data)
-- ======================================================================
-- First run 00-Setup-Sample-Data.sql once. Then run these one by one (select a statement → execute).
-- pgAdmin: open the Query Tool on database "salesdb".
SET search_path TO sales;

-- PostgreSQL tables are always heaps: rows stored where space is free (ctid = page, item).
SELECT ctid, customerid, firstname FROM customers;

-- An UPDATE writes a new row version in a new place (ctid changes):
UPDATE customers SET score = score WHERE customerid = 1;
SELECT ctid, customerid FROM customers WHERE customerid = 1;

-- Indexes are separate structures pointing to ctid:
SELECT indexname, indexdef FROM pg_indexes WHERE schemaname = 'sales';

-- CLUSTER physically re-orders the heap once by an index (not kept up to date):
CLUSTER customers USING customers_pkey;
SELECT ctid, customerid FROM customers;

-- Index-only scan (covering): needs the visibility map → run VACUUM first
VACUUM customers;
SET enable_seqscan = off;        -- tiny tables: force index use just for the demo
EXPLAIN SELECT customerid FROM customers WHERE customerid = 2;
RESET enable_seqscan;

-- ======================================================================
-- 🎯 Practice Questions (salesdb sample data) — try first, then look at the answer
-- ======================================================================
-- Run 00-Setup-Sample-Data.sql once before this section.

SET search_path TO sales;

-- Q1. Which tables have a primary key (clustered in InnoDB) and which do not?
SELECT t.table_name, bool_or(c.constraint_type = 'PRIMARY KEY') AS has_pk
FROM information_schema.tables t
LEFT JOIN information_schema.table_constraints c
  ON c.table_schema = t.table_schema AND c.table_name = t.table_name
WHERE t.table_schema = 'sales'
GROUP BY t.table_name;

-- Q2. Covering index: answer the query from the index only.
CREATE INDEX idx_orders_cust_sales ON orders (customerid) INCLUDE (sales);
VACUUM orders;
SET enable_seqscan = off;
EXPLAIN SELECT customerid, sales FROM orders WHERE customerid = 2;   -- Index Only Scan
RESET enable_seqscan;
DROP INDEX idx_orders_cust_sales;
