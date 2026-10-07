-- ======================================================================
-- Topic 44: Scans & Seeks (Data Access Methods)
-- ======================================================================

-- ------------------------------------------------------------
-- 📖 In Simple Words
-- ------------------------------------------------------------

-- * Definition: Data access methods are the ways the database reads rows: full table scan (read everything), index scan (read the whole index), index seek / range (jump to the needed rows).

-- * Real-life example: Finding a name in a phone book: read every page (scan) or open at the right letter (seek).

-- * Example on salesdb (run 00-Setup-Sample-Data.sql first):
USE salesdb;
EXPLAIN SELECT * FROM customers WHERE country = 'USA';   -- scan (no index)
EXPLAIN SELECT * FROM customers WHERE customerid = 3;     -- seek (primary key)

-- * Example explained (step by step):
--   1. country has no index, so the database reads all 5 rows and checks each one (full scan).
--   2. customerid is the primary key, so it jumps directly to row 3 (seek).
--   3. On big tables a seek is much faster than a scan.

-- * Diagram summary: Visual comparison of Full Table Scan vs Index Scan vs Index Seek

-- ------------------------------------------------------------
-- 44.1 What is a Table Scan?
-- ------------------------------------------------------------

-- * Definition: Reading the entire table page by page and row by row.

-- * Impact: Leads to very slow query performance on large datasets.

-- * Example: Like reading every single page of a book to find a name.

-- ------------------------------------------------------------
-- 44.2 What is an Index Scan?
-- ------------------------------------------------------------

-- * Definition: Scanning all data inside an index to find matching rows (or only scanning the data which is part of the index).

-- * Impact: Faster than a table scan, but still reads a lot of entries.

-- * Example: Like reading every entry in the index section at the back of a book.

-- ------------------------------------------------------------
-- 44.3 What is an Index Seek?
-- ------------------------------------------------------------

-- * Definition: A targeted search within an index, retrieving only specific rows. MySQL directly looks up the specific rows it needs using the index key.

-- * Impact: Extremely fast (Targeted lookup).

-- * Example: Looking up the name "John Smith" in an index and jumping directly to that exact page.

-- ------------------------------------------------------------
-- 44.4 Best Practices to Ensure Index Seek
-- ------------------------------------------------------------

-- 1. Use `WHERE` filters on indexed columns.

-- 2. Prefer equality (`=`) or range conditions (`>`, `<`).

-- 3. Create composite indexes for multi-column filters.

-- ---

-- ======================================================================
-- 🧪 Practice Examples (salesdb sample data)
-- ======================================================================
-- First run 00-Setup-Sample-Data.sql once. Then run these one by one (select a statement → execute).
USE salesdb;

-- Full table scan (type = ALL): no index on country
EXPLAIN SELECT * FROM customers WHERE country = 'USA';

-- Index seek (type = const): primary key lookup
EXPLAIN SELECT * FROM customers WHERE customerid = 3;

-- Index seek on a secondary index (type = ref)
EXPLAIN SELECT * FROM orders WHERE productid = 101;

-- Range scan (type = range)
EXPLAIN SELECT * FROM orders WHERE orderid BETWEEN 2 AND 5;

-- Full index scan (type = index): reads the whole index, not the table
EXPLAIN SELECT customerid FROM orders;

-- Turn the table scan into a seek:
CREATE INDEX idx_customers_country ON customers (country);
EXPLAIN SELECT * FROM customers WHERE country = 'USA';
DROP INDEX idx_customers_country ON customers;

-- ======================================================================
-- 🎯 Practice Questions (salesdb sample data) — try first, then look at the answer
-- ======================================================================
-- Run 00-Setup-Sample-Data.sql once before this section.

USE salesdb;

-- Q1. Which access method is used for a primary key lookup vs a non-indexed filter?
EXPLAIN SELECT * FROM products WHERE productid = 103;
EXPLAIN SELECT * FROM products WHERE category = 'Clothing';

-- Q2. Range scan on dates after adding an index.
CREATE INDEX idx_orders_orderdate ON orders (orderdate);
EXPLAIN SELECT * FROM orders WHERE orderdate BETWEEN '2025-02-01' AND '2025-02-28';
DROP INDEX idx_orders_orderdate ON orders;
