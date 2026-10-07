-- 📘 Part 7: Database Design & Data Management (Topics 49–51)
-- ======================================================================

-- ---

-- ======================================================================
-- Topic 49: Database Normalization (1NF to BCNF)
-- ======================================================================

-- ------------------------------------------------------------
-- 📖 In Simple Words
-- ------------------------------------------------------------

-- * Definition: Normalization is organising tables so each fact is stored only once (no repeated data), using rules called 1NF, 2NF, 3NF and BCNF.

-- * Real-life example: Keeping a friend's phone number once in your contacts instead of writing it in every message.

-- * 🧩 Syntax:
--     -- Split repeated data into its own table and link it:
--     CREATE TABLE parent (id INT PRIMARY KEY, name VARCHAR(50));
--     CREATE TABLE child  (id INT PRIMARY KEY, parent_id INT,
--                          FOREIGN KEY (parent_id) REFERENCES parent (id));

-- * Syntax explained (each part):
--   - 1NF → one value per cell, no repeating groups
--   - 2NF → 1NF + every column depends on the whole primary key
--   - 3NF → 2NF + no column depends on another non-key column
--   - BCNF → every determinant is a candidate key

-- * Example on salesdb (run 00-Setup-Sample-Data.sql first):
USE salesdb;
SELECT o.orderid, o.productid, p.product, p.category
FROM orders o JOIN products p ON p.productid = o.productid;

-- * Example explained (step by step):
--   1. orders stores only productid, not the product name or category.
--   2. Name and category live once in products and are joined when needed.
--   3. If Bottle is renamed, we change one row in products instead of many orders — that is normalization (3NF).

-- ------------------------------------------------------------
-- 49.1 What is Normalization?
-- ------------------------------------------------------------

-- * Definition: The process of organizing data in a database to eliminate redundancy (data duplication) and ensure data integrity.

-- ------------------------------------------------------------
-- 49.2 The Normal Forms (Step-by-Step)
-- ------------------------------------------------------------

-- 1. 1NF (First Normal Form):

--    * Rule: Each column must have atomic (single) values. No comma-separated lists in one column!

-- 2. 2NF (Second Normal Form):

--    * Rule: Must be in 1NF. AND all non-key columns must depend on the entire Primary Key (Removes partial dependency). Usually solved by moving data to a new table with a Foreign Key.

-- 3. 3NF (Third Normal Form):

--    * Rule: Must be in 2NF. AND no non-key column should depend on another non-key column (Removes transitive dependency). "Every non-key attribute must provide a fact about the key, the whole key, and nothing but the key."

-- 4. BCNF (Boyce-Codd Normal Form):

--    * Rule: A stricter version of 3NF. Every determinant must be a candidate key.

-- ------------------------------------------------------------
-- 49.3 What is Denormalization?
-- ------------------------------------------------------------

-- * Definition: Intentionally adding redundancy back to a normalized database to speed up heavy read queries (avoiding complex Joins). Common in Data Warehouses (OLAP).

-- ------------------------------------------------------------
-- 49.4 Data Warehouse Modeling: OLTP vs OLAP, Star & Snowflake Schema
-- ------------------------------------------------------------

-- * OLTP vs OLAP:

-- | Point | OLTP (Online Transaction Processing) | OLAP (Online Analytical Processing) |
-- | :--- | :--- | :--- |
-- | Purpose | Run the business: orders, payments, logins | Analyse the business: reports, dashboards, trends |
-- | Queries | Many small reads/writes of a few rows | Few huge reads that scan and aggregate millions of rows |
-- | Design | Highly normalized (3NF) to avoid duplicates | Denormalized (star / snowflake) for fast reads |
-- | Data | Current data | Historical data (years) |
-- | Examples | MySQL/PostgreSQL app database | Data warehouse: Snowflake, BigQuery, Redshift, ClickHouse |

-- * Fact table: stores measurable events (numbers) — e.g. `fact_sales(date_key, product_key, customer_key, store_key, quantity, amount)`. It is long (millions of rows) and narrow.

-- * Dimension table: stores descriptive context used to filter and group — e.g. `dim_product(product_key, name, category, brand)`, `dim_date(date_key, date, month, quarter, year)`. It is short and wide.

-- * Star schema: one fact table in the centre joined directly to denormalized dimension tables (one join per dimension). Simple, fast queries — the most common design in BI tools like Power BI.

-- * Snowflake schema: dimensions are normalized further into sub-dimensions (e.g. `dim_product` → `dim_category` → `dim_department`). Less duplicate data, but more joins and slower queries.

-- * Example star-schema query:
SELECT d.year, p.category, SUM(f.amount) AS revenue
FROM fact_sales f
JOIN dim_date d    ON f.date_key = d.date_key
JOIN dim_product p ON f.product_key = p.product_key
GROUP BY d.year, p.category;

-- * Slowly Changing Dimension (SCD) — interview favourite: Type 1 overwrites the old value (no history); Type 2 adds a new row with `valid_from`, `valid_to`, `is_current` (keeps history).

-- >

-- ---

-- ======================================================================
-- 🎯 Practice Questions (salesdb sample data) — try first, then look at the answer
-- ======================================================================
-- Run 00-Setup-Sample-Data.sql once before this section.

USE salesdb;

-- Q1. Spot redundancy: orders_archive repeats order 4 and 6 (not normalized history).
SELECT orderid, COUNT(*) AS versions FROM orders_archive GROUP BY orderid HAVING COUNT(*) > 1;

-- Q2. 3NF check: product category depends on product, so it lives in products, not in orders.
SELECT o.orderid, p.product, p.category
FROM orders o JOIN products p ON p.productid = o.productid;

-- Q3. Normalize categories into their own table (practice copy).
CREATE TABLE categories (categoryid INT PRIMARY KEY, category VARCHAR(50)) DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;   -- same collation as products.category
INSERT INTO categories VALUES (1, 'Accessories'), (2, 'Clothing');
SELECT p.product, c.categoryid FROM products p JOIN categories c ON c.category = p.category;
DROP TABLE categories;
