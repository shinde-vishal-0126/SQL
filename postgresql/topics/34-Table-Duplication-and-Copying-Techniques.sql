-- ======================================================================
-- Topic 34: Table Duplication & Copying Techniques
-- ======================================================================

-- ------------------------------------------------------------
-- 📖 In Simple Words
-- ------------------------------------------------------------

-- * Definition: Table duplication means making a copy of a table — structure only, or structure plus data — for backup, testing or archiving.

-- * Real-life example: Photocopying a form: a blank copy (structure only) or a filled copy (structure + data).

-- * 🧩 Syntax:
--     CREATE TABLE copy_name (LIKE source INCLUDING ALL); -- structure only (with indexes, defaults)
--     INSERT INTO copy_name SELECT * FROM source;          -- then the data
--     CREATE TABLE copy_name AS SELECT * FROM source;      -- structure + data (no keys)

-- * Syntax explained (each part):
--   - LIKE → copies the column definitions (and indexes)
--   - AS SELECT → copies the data with basic column types
--   - WHERE in the SELECT → copy only some rows

-- * Example on salesdb (run 00-Setup-Sample-Data.sql first):
SET search_path TO sales;
CREATE TABLE products_backup AS SELECT * FROM products;   -- structure + data
CREATE TABLE products_blank (LIKE products INCLUDING ALL); -- structure only
SELECT COUNT(*) FROM products_backup;   -- 5
SELECT COUNT(*) FROM products_blank;    -- 0
DROP TABLE products_backup;
DROP TABLE products_blank;

-- * Example explained (step by step):
--   1. products_backup gets the columns and the 5 rows.
--   2. products_blank gets only the columns (and keys/indexes), no rows.
--   3. The counts prove it: 5 and 0. Both copies are dropped at the end.

-- * Diagram summary: Compares CREATE TABLE AS vs CREATE TABLE LIKE

--   ┌ ASCII diagram
--   │  CREATE TABLE copy AS SELECT * FROM t   → columns + DATA      (no keys / indexes)
--   │  CREATE TABLE copy LIKE t               → columns + indexes   (NO data)
--   └

-- ------------------------------------------------------------
-- 34.1 Copying Table Data WITHOUT Constraints
-- ------------------------------------------------------------

-- * Definition: You can create a new table from an existing one that contains the structure and the data, but does NOT copy constraints (Indexes, Primary Keys, Foreign Keys, Triggers, defaults or the identity/sequence).

-- * Syntax / Example:
CREATE TABLE salesdb_customers_hp AS
SELECT * FROM customers;

-- Structure only, no rows:
CREATE TABLE customers_empty AS
SELECT * FROM customers WITH NO DATA;

-- ------------------------------------------------------------
-- 34.2 Copying Table Data WITH Constraints (Exact Clone)
-- ------------------------------------------------------------

-- * Definition: If you want a clone of the table structure (including indexes, primary key, defaults, check constraints), PostgreSQL uses `LIKE` inside brackets with `INCLUDING` options. After creating the empty clone, you copy the data using `INSERT INTO ... SELECT`.

-- * Step 1: Copy Structure & Constraints
CREATE TABLE customers2 (LIKE customers INCLUDING ALL);
-- MySQL: CREATE TABLE customers2 LIKE customers;

--   * `INCLUDING ALL` = `INCLUDING DEFAULTS CONSTRAINTS INDEXES IDENTITY GENERATED STORAGE COMMENTS STATISTICS`. Without it, `LIKE` copies only column names, types and `NOT NULL`.

-- * Step 2: Copy the Data
INSERT INTO customers2
SELECT * FROM customers;
-- Verify the copy
SELECT * FROM customers2;

-- * ⚠️ Note (PostgreSQL):

--   * Foreign keys and triggers are never copied by `LIKE` — add them again manually.

--   * A `SERIAL` column is copied with a default that still points to the OLD table's sequence (both tables then share one number generator). With `IDENTITY` columns and `INCLUDING IDENTITY`, the new table gets its own new sequence. After copying data, reset it: `SELECT setval(pg_get_serial_sequence('customers2', 'id'), (SELECT MAX(id) FROM customers2));`

--   * CTAS (34.1) in PostgreSQL does NOT keep `NOT NULL` or defaults (MySQL's CTAS keeps them).

-- ------------------------------------------------------------
-- 34.2.1 🐘 Other PostgreSQL Copy Options (New)
-- ------------------------------------------------------------

-- * Copy to another database or server: `pg_dump -t customers source_db | psql target_db` (Topic 51).

-- * Copy to a file and back: `\copy customers TO 'customers.csv' CSV HEADER` and `\copy customers2 FROM 'customers.csv' CSV HEADER`.

-- * Quick empty copy for tests: `CREATE TABLE customers_test (LIKE customers INCLUDING ALL);`

-- ---

-- ======================================================================
-- 🎯 Practice Questions (salesdb sample data) — try first, then look at the answer
-- ======================================================================
-- Run 00-Setup-Sample-Data.sql once before this section.

SET search_path TO sales;

-- Q1. Copy structure + data.
CREATE TABLE products_copy AS SELECT * FROM products;
SELECT * FROM products_copy;
DROP TABLE products_copy;

-- Q2. Copy structure only (with keys/indexes).
CREATE TABLE products_empty (LIKE products INCLUDING ALL);
SELECT COUNT(*) FROM products_empty;   -- 0
DROP TABLE products_empty;

-- Q3. Copy only some rows (Clothing products).
CREATE TABLE clothing AS SELECT * FROM products WHERE category = 'Clothing';
SELECT * FROM clothing;
DROP TABLE clothing;
