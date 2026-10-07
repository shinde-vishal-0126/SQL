-- ======================================================================
-- Topic 5: Why SQL?
-- ======================================================================

-- ------------------------------------------------------------
-- 📖 In Simple Words
-- ------------------------------------------------------------

-- * Definition: We use SQL because it is a standard, simple, English-like language that works on almost every relational database and can answer business questions in one statement.

-- * Real-life example: Like English for travellers: learn it once and you can talk in most countries (MySQL, PostgreSQL, SQL Server, Oracle).

-- * 🧩 Syntax:
--     SELECT column, AGGREGATE(column)
--     FROM table_name
--     WHERE condition
--     GROUP BY column;

-- * Syntax explained (each part):
--   - AGGREGATE() → COUNT, SUM, AVG, MIN, MAX — one value per group
--   - GROUP BY → makes one group per distinct value
--   - Why SQL → one short, standard statement answers a business question on any RDBMS

-- * Example on salesdb (run 00-Setup-Sample-Data.sql first):
SET search_path TO sales;
SELECT country, COUNT(*) AS total_customers
FROM customers
GROUP BY country;

-- * Example explained (step by step):
--   1. GROUP BY country puts customers of the same country together.
--   2. COUNT(*) counts rows in each group.
--   3. Result: Germany 2, USA 3 — a business answer in three lines, and the same query runs in MySQL and PostgreSQL.

-- ------------------------------------------------------------
-- 5.1 Standardized Way to Interact with Databases
-- ------------------------------------------------------------

-- * Q. Why is SQL considered a standardized database language?

--   * Universal Standard: SQL is an ANSI/ISO standard language, so the same basic SQL works on PostgreSQL, MySQL, Oracle and MS SQL Server. PostgreSQL is known for following the SQL standard very closely.

--   * Cross-Platform Compatibility: Without SQL, every database would need its own language, and moving to a new database would be hard.

-- ---

-- ------------------------------------------------------------
-- 5.2 Efficient Data Retrieval
-- ------------------------------------------------------------

-- * Instead of downloading the whole table, SQL lets you fetch only the rows and columns you need.

-- * Using these clauses:

--   * `SELECT`: Chooses which columns to show.

--   * `WHERE`: Keeps only the rows that match a condition (e.g., `WHERE age >= 18`).

--   * `JOIN`: Combines data from two or more tables.

--   * `GROUP BY`: Groups rows so you can calculate totals like `SUM` or `COUNT` per group.

-- ---

-- ------------------------------------------------------------
-- 5.3 Data Manipulation (CRUD Examples)
-- ------------------------------------------------------------

-- SQL can add, change and remove data:

-- * Insert new data:
INSERT INTO users (name, age) VALUES ('Vishal', 25);

-- * Update existing data:
UPDATE users SET age = 26 WHERE name = 'Vishal';

-- * Delete data:
DELETE FROM users WHERE age < 18;

-- ---

-- ------------------------------------------------------------
-- 5.4 Relationships Between Data
-- ------------------------------------------------------------

-- * Relational databases keep different things in separate tables (e.g., `Customers`, `Orders`, `Products`).

-- * SQL links these tables using keys (`PRIMARY KEY` and `FOREIGN KEY`), so the same data is not stored twice.

-- ---

-- ------------------------------------------------------------
-- 5.5 Data Integrity and Security
-- ------------------------------------------------------------

-- * Q. How does SQL enforce data integrity and database security?

--   * SQL protects data in 3 ways:

--     1. Constraints: Rules like `PRIMARY KEY`, `FOREIGN KEY`, `NOT NULL`, and `UNIQUE` reject wrong or duplicate data.

--     2. ACID Transactions: A group of queries (like a money transfer) either fully completes or is fully undone (rollback) if an error occurs.

--     3. Access Control (Security): DBAs give or take away permissions with statements like `GRANT SELECT` and `REVOKE DELETE`.

-- ---

-- ------------------------------------------------------------
-- 5.6 Scalability and Engine Optimization
-- ------------------------------------------------------------

-- * SQL databases can handle hundreds of millions of rows and still answer in under a second.

-- * They use B-Tree indexes, memory caching and a query planner to stay fast.

-- * Filtering or joining millions of rows in application code (Python, Java, C#) is much slower than letting the database do it.

-- ---

-- ------------------------------------------------------------
-- 5.7 The 3 Core Drivers: Talk to Data, High Demand, Industry Standard
-- ------------------------------------------------------------

-- ┌── (text — not SQL, shown for reference) ──
-- │               ┌──────────────────────────────────────────────┐
-- │               │              WHY LEARN SQL?                  │
-- │               └──────────────────────┬───────────────────────┘
-- │                                      │
-- │          ┌───────────────────────────┼───────────────────────────┐
-- │          ▼                           ▼                           ▼
-- │   [ 💬 TALK TO DATA ]      [ 🔥 HIGH DEMAND ]         [ 🌐 INDUSTRY STANDARD ]
-- │   Standardized queries      Required for Devs,         Native support across
-- │   to retrieve, insert,      Data Analysts, Data        Power BI, Tableau,
-- │   update, & delete data.    Engineers, Scientists.     Spark, Kafka, Cloud.
-- └──

-- 1. 💬 TALK TO DATA:

--    * Universal communication bridge between users, client apps, and relational tables.

-- 2. 🔥 HIGH DEMAND (Core Technical Competency):

--    * Foundational skill across key engineering and analytics professions:

--      * Software Developers: Designing application backends, ORMs, and persistence layers.

--      * Data Analysts: Extracting data to evaluate business trends and performance.

--      * Data Engineers: Building ETL pipelines and cloud data warehouse architectures.

--      * Data Scientists: Querying training and validation datasets for machine learning.

-- 3. 🌐 INDUSTRY STANDARD (Broad Ecosystem Integration):

--    * Universally supported by analytics, streaming, and enterprise big data platforms:

--      * BI & Analytics: Power BI, Tableau, Looker

--      * Streaming & Big Data: Apache Spark, Apache Kafka

--      * Cloud Data Warehouses: Snowflake, Google BigQuery, AWS Redshift

-- ---

-- ------------------------------------------------------------
-- 5.8 Visual Concept: Why SQL Mind-Map
-- ------------------------------------------------------------

-- ------------------------------------------------------------
-- Simple Explanation of the Diagram:
-- ------------------------------------------------------------

-- * The "Why SQL?" Core: Branches out into three primary real-world drivers:

--   1. Talk to Data: Standardized commands (`SELECT`, `INSERT`, `UPDATE`, `DELETE`) addressing enterprise datasets.

--   2. High Demand: Core skill set for developers, analysts, engineers, and data scientists.

--   3. Industry Standard: Native execution across Power BI, Tableau, Kafka, Spark, and cloud data warehouses.

-- * Engine Guarantees (Bottom Banner): Enforces data integrity through constraints, transactional reliability via rollback mechanisms, role permissions, and scalable performance over millions of records.

-- ---

-- ---

-- ======================================================================
-- 🎯 Practice Questions (salesdb sample data) — try first, then look at the answer
-- ======================================================================
-- Run 00-Setup-Sample-Data.sql once before this section.

SET search_path TO sales;

-- Q1. Answer a business question with one SQL statement: total sales per country.
SELECT c.country, SUM(o.sales) AS total_sales
FROM orders o
JOIN customers c ON c.customerid = o.customerid
GROUP BY c.country;

-- Q2. Which product sold the most quantity?
SELECT p.product, SUM(o.quantity) AS total_qty
FROM orders o
JOIN products p ON p.productid = o.productid
GROUP BY p.product
ORDER BY total_qty DESC
LIMIT 1;

-- Q3. Which orders are not delivered yet?
SELECT orderid, orderstatus FROM orders WHERE orderstatus <> 'Delivered';
