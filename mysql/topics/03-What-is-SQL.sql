-- ======================================================================
-- Topic 3: What is SQL?
-- ======================================================================

-- ------------------------------------------------------------
-- 📖 In Simple Words
-- ------------------------------------------------------------

-- * Definition: SQL (Structured Query Language) is the language you use to talk to a relational database: ask questions, add, change and delete data, and create tables.

-- * Real-life example: SQL is like the language you speak to the librarian: "Give me all books by this author".

-- * 🧩 Syntax:
--     SELECT column1, column2      -- what to show
--     FROM table_name              -- where to read from
--     WHERE condition;             -- which rows

-- * Syntax explained (each part):
--   - SELECT → keyword: read data; list the columns (or * for all)
--   - FROM → the table to read
--   - WHERE → optional filter; only rows where the condition is TRUE
--   - ; (semicolon) → ends the statement

-- * Example on salesdb (run 00-Setup-Sample-Data.sql first):
USE salesdb;
SELECT firstname, country
FROM customers
WHERE country = 'Germany';

-- * Example explained (step by step):
--   1. SELECT firstname, country → which columns you want to see.
--   2. FROM customers → which table to read.
--   3. WHERE country = 'Germany' → keep only German customers.
--   4. Result: Jossef and Mark.

-- ------------------------------------------------------------
-- 3.1 Definition & Core Meaning
-- ------------------------------------------------------------

-- * Q. What is SQL?

--   * SQL stands for: Structured Query Language (pronounced "Sequel" or "S-Q-L").

--   * Definition: SQL is the standard language used to talk to relational databases — to create, read, update and delete data.

--   * Almost every relational database (MySQL, PostgreSQL, Oracle, SQL Server) understands SQL.

-- ---

-- ------------------------------------------------------------
-- 3.2 Communicating with the Database Brain (Asking Questions)
-- ------------------------------------------------------------

-- * With SQL you simply describe what data you want, and the database finds it for you (this is why SQL is called a declarative language).

-- * Q. How do you query recent customer purchases in SQL?

--   * Business requirement: "Show me all customers who completed purchases since last month."

--   * Query implementation:
SELECT customer_id, first_name, last_name, email, purchase_date
FROM customers
WHERE purchase_date >= CURRENT_DATE - INTERVAL '1 month';

--   * ⚠️ Note: `INTERVAL '1 month'` is PostgreSQL syntax. In MySQL write `CURRENT_DATE - INTERVAL 1 MONTH` (no quotes).

-- ---

-- ------------------------------------------------------------
-- 3.3 Accessing & Manipulating Data (CRUD Operations)
-- ------------------------------------------------------------

-- SQL supports all 4 basic data operations, together called CRUD:

-- (CRUD Operation → Meaning | Primary SQL Command | Example Syntax & Usage)
--
-- * Create
--     - Meaning                : Adding new data records
--     - Primary SQL Command    : INSERT
--     - Example Syntax & Usage : INSERT INTO customers (name, email) VALUES ('Rohan', 'rohan@example.com');
--
-- * Read
--     - Meaning                : Searching & viewing records
--     - Primary SQL Command    : SELECT
--     - Example Syntax & Usage : SELECT * FROM customers WHERE id = 101;
--
-- * Update
--     - Meaning                : Modifying existing records
--     - Primary SQL Command    : UPDATE
--     - Example Syntax & Usage : UPDATE customers SET email = 'new_email@example.com' WHERE id = 101;
--
-- * Delete
--     - Meaning                : Removing unwanted records
--     - Primary SQL Command    : DELETE
--     - Example Syntax & Usage : DELETE FROM customers WHERE id = 101;
--

-- ---

-- ------------------------------------------------------------
-- 3.4 Real-World Applications & Use Cases of SQL
-- ------------------------------------------------------------

-- SQL is used for much more than reading rows. 8 common uses:

-- 1. Data Integration: Combining separate tables into unified analytical views using relational `JOIN` operations.

-- 2. Backup & Recovery: Exporting database snapshots and recovering state after system failures.

-- 3. Big Data & Analytics: Running aggregate analytics (`COUNT`, `SUM`, `AVG`, `GROUP BY`) to derive business metrics.

-- 4. Managing User Permissions: Administering security using DCL statements (`GRANT`, `REVOKE`) to protect sensitive schemas.

-- 5. Creating Indexes: Creating indexes (`CREATE INDEX`) so searches stay fast even with millions of rows.

-- 6. Automating Workflows: Writing Stored Procedures, Functions, and Triggers to automate repeating database logic.

-- 7. Generating Reports: Feeding clean, structured tables directly to BI dashboards, spreadsheets, and reporting engines.

-- 8. Powering Real-Time Applications: Handling live transactions in e-commerce, banking, logistics and social media apps.

-- ---

-- ------------------------------------------------------------
-- 3.5 In Short: The 4 Pillars Chain
-- ------------------------------------------------------------

-- ┌── (text — not SQL, shown for reference) ──
-- │ [ 🗄️ Database ] ────────► [ 🗣️ SQL ] ────────► [ ⚙️ DBMS ] ────────► [ 🖥️ Server ]
-- │ (Container to             (Language to           (Software manager      (Physical/cloud host
-- │  store data)               speak to DB)           for database)          running 24/7)
-- └──

-- 1. Database: The container that stores organized records.

-- 2. SQL: The language used to speak to the database.

-- 3. DBMS: The software manager that executes queries, optimizes performance, and enforces security.

-- 4. Server: The machine environment where the database services execute 24/7.

-- ---

-- ------------------------------------------------------------
-- 3.6 Visual Concept: How SQL Speaks to the Database
-- ------------------------------------------------------------

-- ------------------------------------------------------------
-- Simple Explanation of the Diagram:
-- ------------------------------------------------------------
/*
  ASCII Diagram:
   HUMAN REQUEST                          SQL CAN DO
  +--------------------------------+     +------------------------------+
  | "Show me all customers who     |     |  * CRUD (insert/read/update/ |
  |  bought items since last       |     |    delete)                   |
  |  month!"                       |     |  * Analytics / reports       |
  +--------------------------------+     |  * Permissions / security    |
                 |  translate            |  * Indexing (speed)          |
                 v                       |  * Backup / recovery         |
  +--------------------------------+     |  * Real-time app support     |
  | SELECT * FROM customers        |     +------------------------------+
  | WHERE ...;                     |
  +--------------------------------+

  DATABASE ----> SQL ----------> DBMS ---------> SERVER
  (container)    (language)      (manager)       (host machine)


  1. Left Panel (Speaking in SQL):

     * A human-language request ("Show me all customers who bought items since last month!") translates into standard SQL (`SELECT * FROM customers WHERE ...`).

  2. Right Panel (Capabilities):

     * Highlights the core functional roles of SQL: CRUD operations, Analytics, Permissions/Security, Indexing, Backup/Recovery, and Real-Time application support.

  3. Bottom Chain:

     * Summarizes the foundational ecosystem formula: Database (Container) $\rightarrow$ SQL (Language) $\rightarrow$ DBMS (Manager) $\rightarrow$ Server (Host Machine).
*/

-- ---

-- ---

-- ======================================================================
-- 🎯 Practice Questions (salesdb sample data) — try first, then look at the answer
-- ======================================================================
-- Run 00-Setup-Sample-Data.sql once before this section.

USE salesdb;

-- Q1. (DQL) Show the first name and country of all customers.
SELECT firstname, country FROM customers;

-- Q2. (DML) Raise the price of Socks by 2, check it, then undo the change.
START TRANSACTION;
UPDATE products SET price = price + 2 WHERE product = 'Socks';
SELECT product, price FROM products WHERE product = 'Socks';
ROLLBACK;

-- Q3. (DDL) Create a small table, look at it, then drop it.
CREATE TABLE sql_demo (id INT PRIMARY KEY, note VARCHAR(50));
SELECT * FROM sql_demo;
DROP TABLE sql_demo;
