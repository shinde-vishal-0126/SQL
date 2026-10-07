-- ======================================================================
-- Topic 44: Scans & Seeks (Data Access Methods)
-- ======================================================================

-- ------------------------------------------------------------
-- 📖 In Simple Words
-- ------------------------------------------------------------

-- * Definition: Data access methods are the ways the database reads rows: full table scan (read everything), index scan (read the whole index), index seek / range (jump to the needed rows).

-- * Real-life example: Finding a name in a phone book: read every page (scan) or open at the right letter (seek).

-- * Example on salesdb (run 00-Setup-Sample-Data.sql first):
SET search_path TO sales;
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

-- * Definition: Reading the entire table page by page and row by row. In PostgreSQL this is a `Seq Scan` (it can run as a `Parallel Seq Scan` with several workers on big tables).

-- * Impact: Leads to very slow query performance on large datasets.

-- * Example: Like reading every single page of a book to find a name.

-- ------------------------------------------------------------
-- 44.2 What is an Index Scan?
-- ------------------------------------------------------------

-- * Definition: Scanning all data inside an index to find matching rows (or only scanning the data which is part of the index). In PostgreSQL you see this as an `Index Scan` / `Index Only Scan` with no `Index Cond` — e.g. to return rows already sorted for `ORDER BY id LIMIT 10`.

-- * Impact: Faster than a table scan, but still reads a lot of entries.

-- * Example: Like reading every entry in the index section at the back of a book.

-- ------------------------------------------------------------
-- 44.3 What is an Index Seek?
-- ------------------------------------------------------------

-- * Definition: A targeted search within an index, retrieving only specific rows. PostgreSQL walks the B-Tree directly to the key (`Index Cond: (customer_id = 5)` in the plan).

-- * Impact: Extremely fast (Targeted lookup).

-- * Example: Looking up the name "John Smith" in an index and jumping directly to that exact page.

-- ------------------------------------------------------------
-- 44.4 Best Practices to Ensure Index Seek
-- ------------------------------------------------------------

-- 1. Use `WHERE` filters on indexed columns.

-- 2. Prefer equality (`=`) or range conditions (`>`, `<`).

-- 3. Create composite indexes for multi-column filters.

-- 4. Don't wrap the indexed column in a function — or create an expression index for that function.

-- 5. Keep statistics fresh (`ANALYZE`) so the planner trusts the index.

-- ---

-- ======================================================================
-- 🧪 Practice Examples (salesdb sample data)
-- ======================================================================
-- First run 00-Setup-Sample-Data.sql once. Then run these one by one (select a statement → execute).
-- pgAdmin: open the Query Tool on database "salesdb".
SET search_path TO sales;

-- Sequential scan (full table scan):
EXPLAIN SELECT * FROM customers WHERE country = 'USA';

-- Index scan via primary key (tiny tables may still show Seq Scan — force it for the demo):
SET enable_seqscan = off;
EXPLAIN SELECT * FROM customers WHERE customerid = 3;            -- Index Scan
EXPLAIN SELECT * FROM orders WHERE orderid BETWEEN 2 AND 5;      -- Index Scan (range)
EXPLAIN SELECT customerid FROM customers WHERE customerid > 1;   -- Index Only Scan

-- Bitmap scan:
CREATE INDEX idx_customers_country ON customers (country);
EXPLAIN SELECT * FROM customers WHERE country = 'USA';           -- Bitmap Index Scan + Bitmap Heap Scan
DROP INDEX idx_customers_country;
RESET enable_seqscan;

-- Actual numbers:
EXPLAIN ANALYZE SELECT * FROM orders WHERE customerid = 2;

-- ======================================================================
-- 🎯 Practice Questions (salesdb sample data) — try first, then look at the answer
-- ======================================================================
-- Run 00-Setup-Sample-Data.sql once before this section.

SET search_path TO sales;

-- Q1. Which access method is used for a primary key lookup vs a non-indexed filter?
EXPLAIN SELECT * FROM products WHERE productid = 103;
EXPLAIN SELECT * FROM products WHERE category = 'Clothing';

-- Q2. Range scan on dates after adding an index.
CREATE INDEX idx_orders_orderdate ON orders (orderdate);
SET enable_seqscan = off;
EXPLAIN SELECT * FROM orders WHERE orderdate BETWEEN '2025-02-01' AND '2025-02-28';
RESET enable_seqscan;
DROP INDEX idx_orders_orderdate;
