-- ======================================================================
-- Topic 12: DQL (Data Query Language) & Data Retrieval
-- ======================================================================

-- ------------------------------------------------------------
-- 📖 In Simple Words
-- ------------------------------------------------------------

-- * Definition: DQL (Data Query Language) is the SELECT statement: it reads data and never changes it.

-- * Real-life example: Reading a book in the library — you look, but you do not write in it.

-- * 🧩 Syntax:
--     SELECT [DISTINCT] col1, col2 AS alias
--     FROM table_name
--     WHERE condition
--     ORDER BY col [ASC|DESC]
--     LIMIT n;

-- * Syntax explained (each part):
--   - DISTINCT → remove duplicate result rows
--   - AS alias → rename a column in the output
--   - ORDER BY … ASC/DESC → sort ascending (default) or descending
--   - LIMIT n → return only the first n rows

-- * Example on salesdb (run 00-Setup-Sample-Data.sql first):
USE salesdb;
SELECT firstname, score
FROM customers
WHERE score > 500
ORDER BY score DESC;

-- * Example explained (step by step):
--   1. WHERE score > 500 keeps customers with a score above 500.
--   2. ORDER BY score DESC sorts from highest to lowest.
--   3. Result: Kevin 900, Mary 750. The table itself is not changed.

-- ------------------------------------------------------------
-- 12.1 What is DQL (Data Query Language)?
-- ------------------------------------------------------------

-- * Definition: DQL (Data Query Language) is used to read data from tables. It never changes the data or the table structure.

--   * The primary command of DQL is **`SELECT`**.

-- * Key Characteristics of DQL:

--   * 1. Read-Only Nature: DQL only reads data; it never inserts, changes or deletes anything.

--   * 2. Tabular Result Set (Virtual Table): Every `SELECT` query returns results structured into rows and columns, known as a Result Set.

--   * 3. Extreme Flexibility: Can retrieve everything, target specific columns, filter rows (`WHERE`), sort results (`ORDER BY`), aggregate metrics (`GROUP BY`, `COUNT`, `SUM`), and join across multiple related tables (`JOIN`).

-- ---

-- ------------------------------------------------------------
-- 12.2 Two Fundamental Ways to Retrieve Data via SELECT
-- ------------------------------------------------------------

-- You can select or retrieve data in two primary ways:

-- ------------------------------------------------------------
-- 1. Method ①: Get Whole Data from the Table (All Columns via Wildcard `*`)
-- ------------------------------------------------------------

-- * Q. How to get whole data from the customers table?

-- * SQL Query:
SELECT * FROM CUSTOMERS;

-- * Detailed Explanation:

--   * The asterisk (`*`) is a wildcard character that instructs the SQL engine to fetch all columns defined in the table schema in their exact declared order.

--   * When to use: Ideal during development, exploratory analysis, ad-hoc debugging, or schema verification.

--   * Production Caveat: In high-traffic production APIs, avoid `SELECT *` because it retrieves unnecessary columns (including large text or BLOB columns), increases network bandwidth consumption, and prevents the database from utilizing covering indexes.

-- ------------------------------------------------------------
-- 2. Method ②: Get Only Required Data from the Table (Column Projection)
-- ------------------------------------------------------------

-- * Q. How to get only the required data from the table (whatever columns are required)?

-- * SQL Query:
SELECT ID, FIRST_NAME, COUNTRY, SCORE 
FROM CUSTOMERS;

-- * Detailed Explanation:

--   * By explicitly naming columns separated by commas (`ID, FIRST_NAME, COUNTRY, SCORE`), you project only the exact columns needed by your application or report.

--   * When to use: Industry standard best practice for all application queries, dashboards, and APIs.

--   * Key Benefits:

--     1. Lower Network Payload: Only relevant byte streams travel over the network between database and client.

--     2. Index Optimization (Covering Index): If all requested columns are inside an index, MySQL can answer from the index alone, without reading the table.

--     3. Schema Change Resilience: If new columns are later added to the table, queries with explicit column lists will not break or consume unexpected memory.

-- ---

-- ------------------------------------------------------------
-- 12.3 Visual Concept: Whole Table vs. Specific Column Projection
-- ------------------------------------------------------------

--   * **Left Panel (`SELECT * FROM CUSTOMERS;`):**

--     * The database engine retrieves every single column (`ID`, `FIRST_NAME`, `LAST_NAME`, `COUNTRY`, `SCORE`, `STATUS`).

--     * Returns 100% of the table attributes across all records.

--   * **Right Panel (`SELECT ID, FIRST_NAME, COUNTRY, SCORE FROM CUSTOMERS;`):**

--     * The engine projects only the 4 requested attributes, safely filtering out unneeded columns (`LAST_NAME` and `STATUS`).

--     * Produces a streamlined, lightweight result set optimized for memory and network performance.

-- ---

-- ---

-- ======================================================================
-- 🎯 Practice Questions (salesdb sample data) — try first, then look at the answer
-- ======================================================================
-- Run 00-Setup-Sample-Data.sql once before this section.

USE salesdb;

-- Q1. Customers from the USA, highest score first.
SELECT firstname, score FROM customers WHERE country = 'USA' ORDER BY score DESC;

-- Q2. Distinct countries of customers.
SELECT DISTINCT country FROM customers;

-- Q3. Number of orders per order status.
SELECT orderstatus, COUNT(*) AS total FROM orders GROUP BY orderstatus;
