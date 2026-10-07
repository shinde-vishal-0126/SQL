-- ======================================================================
-- Topic 34: Table Duplication & Copying Techniques
-- ======================================================================

-- ------------------------------------------------------------
-- 📖 In Simple Words
-- ------------------------------------------------------------

-- * Definition: Table duplication means making a copy of a table — structure only, or structure plus data — for backup, testing or archiving.

-- * Real-life example: Photocopying a form: a blank copy (structure only) or a filled copy (structure + data).

-- * Example on salesdb (run 00-Setup-Sample-Data.sql first):
USE salesdb;
CREATE TABLE products_backup AS SELECT * FROM products;   -- structure + data
CREATE TABLE products_blank LIKE products;                 -- structure only
SELECT COUNT(*) FROM products_backup;   -- 5
SELECT COUNT(*) FROM products_blank;    -- 0
DROP TABLE products_backup;
DROP TABLE products_blank;

-- * Example explained (step by step):
--   1. products_backup gets the columns and the 5 rows.
--   2. products_blank gets only the columns (and keys/indexes), no rows.
--   3. The counts prove it: 5 and 0. Both copies are dropped at the end.

-- * Diagram summary: Compares CREATE TABLE AS vs CREATE TABLE LIKE

-- ------------------------------------------------------------
-- 34.1 Copying Table Data WITHOUT Constraints
-- ------------------------------------------------------------

-- * Definition: You can create a new table from an existing one that contains the structure and the data, but does NOT copy constraints (Indexes, Primary Keys, Foreign Keys, Triggers, or Auto-increment properties).

-- * Syntax / Example:
CREATE TABLE SALESDB_CUSTOMERS_HP AS
SELECT * FROM CUSTOMERS;

-- ------------------------------------------------------------
-- 34.2 Copying Table Data WITH Constraints (Exact Clone)
-- ------------------------------------------------------------

-- * Definition: If you want an exact clone of the table structure (including all indexes, primary keys, and auto-increments), you must use `LIKE`. After creating the empty clone, you copy the data using `INSERT INTO ... SELECT`.

-- * Step 1: Copy Structure & Constraints
CREATE TABLE CUSTOMERS2 LIKE CUSTOMERS;

-- * Step 2: Copy the Data
INSERT INTO CUSTOMERS2 
SELECT * FROM CUSTOMERS;
-- Verify the copy
SELECT * FROM CUSTOMERS2;

-- * ⚠️ Note: `CREATE TABLE ... LIKE` copies columns, `NOT NULL`, defaults, indexes, the Primary Key and `AUTO_INCREMENT`, but not Foreign Keys and not Triggers — add those again manually. Also, `CREATE TABLE ... AS SELECT` (34.1) does keep `NOT NULL` and default values; it only loses keys, indexes and `AUTO_INCREMENT`.

-- ---

-- ======================================================================
-- 🎯 Practice Questions (salesdb sample data) — try first, then look at the answer
-- ======================================================================
-- Run 00-Setup-Sample-Data.sql once before this section.

USE salesdb;

-- Q1. Copy structure + data.
CREATE TABLE products_copy AS SELECT * FROM products;
SELECT * FROM products_copy;
DROP TABLE products_copy;

-- Q2. Copy structure only (with keys/indexes).
CREATE TABLE products_empty LIKE products;
SELECT COUNT(*) FROM products_empty;   -- 0
DROP TABLE products_empty;

-- Q3. Copy only some rows (Clothing products).
CREATE TABLE clothing AS SELECT * FROM products WHERE category = 'Clothing';
SELECT * FROM clothing;
DROP TABLE clothing;
