-- ======================================================================
-- Topic 8: SQL vs MySQL
-- ======================================================================

-- ------------------------------------------------------------
-- 📖 In Simple Words
-- ------------------------------------------------------------

-- * Definition: SQL is a language; MySQL / PostgreSQL are software products (RDBMS) that understand SQL. Each product adds its own extra features on top of standard SQL.

-- * Real-life example: English is the language; BBC and CNN are channels that speak English, each with its own style.

-- * 🧩 Syntax:
--     -- Standard SQL (works everywhere):
--     SELECT col FROM t WHERE ... ORDER BY col;
--     -- MySQL extensions:
--     SELECT CONCAT(a, b), IFNULL(x, 0) FROM `table` LIMIT n;

-- * Syntax explained (each part):
--   - Standard SQL → the common language every RDBMS understands
--   - Extensions → product-specific syntax: MySQL backticks / IFNULL; PostgreSQL || / ILIKE / RETURNING / double quotes

-- * Example on salesdb (run 00-Setup-Sample-Data.sql first):
USE salesdb;
SELECT CONCAT(firstname, ' ', IFNULL(lastname, '')) AS full_name
FROM customers;

-- * Example explained (step by step):
--   1. Both queries do the same thing: join first and last name into one column.
--   2. MySQL uses CONCAT and IFNULL; PostgreSQL uses || and COALESCE.
--   3. Mary has no last name (NULL), so it is replaced with an empty text instead of making the whole result NULL.

-- ------------------------------------------------------------
-- 8.1 What is SQL?
-- ------------------------------------------------------------

-- * Q. What is SQL?

--   * SQL stands for: Structured Query Language.

--   * Category: Domain-specific declarative query language.

--   * Role: Serves as the universal standard language to query, manipulate, and administer relational databases.

--   * Note: SQL does not store data on its own; it is the communication language.

-- ---

-- ------------------------------------------------------------
-- 8.2 What is MySQL?
-- ------------------------------------------------------------

-- * Q. What is MySQL?

--   * Category: An open-source Relational Database Management System (RDBMS) software application.

--   * Role: An executable database engine and server program that stores and manages data.

--   * Function: Stores records in structured tables, executes SQL queries, manages storage engines (InnoDB), caching, and multi-user concurrency.

-- ---

-- ------------------------------------------------------------
-- 8.3 Key Differences: Comparison Table
-- ------------------------------------------------------------

-- (Feature / Aspect → SQL (Structured Query Language) | MySQL (Relational DBMS))
--
-- * Category
--     - SQL (Structured Query Language) : Declarative Query Language.
--     - MySQL (Relational DBMS)         : Complete RDBMS Software Engine.
--
-- * Primary Purpose
--     - SQL (Structured Query Language) : Querying, filtering, and manipulating data.
--     - MySQL (Relational DBMS)         : Storing, persisting, indexing, and securing data files.
--
-- * Data Storage
--     - SQL (Structured Query Language) : Does not store data itself.
--     - MySQL (Relational DBMS)         : Stores and manages data blocks on physical disk.
--
-- * Version Cycles
--     - SQL (Structured Query Language) : Standardized language specification (ANSI SQL).
--     - MySQL (Relational DBMS)         : Continuously updated database software (e.g., MySQL 8.0, 8.4).
--
-- * Installation
--     - SQL (Structured Query Language) : Cannot be installed (it is a language standard).
--     - MySQL (Relational DBMS)         : Installed as a background service/daemon on servers and cloud.
--
-- * Analogy
--     - SQL (Structured Query Language) : Like the English Language (medium of speech).
--     - MySQL (Relational DBMS)         : Like a Person who understands and speaks English.
--

-- ---

-- ------------------------------------------------------------
-- 8.4 Visual Concept: Language vs RDBMS Software
-- ------------------------------------------------------------

-- ------------------------------------------------------------
-- Simple Explanation of the Diagram:
-- ------------------------------------------------------------

-- * Left Card (SQL): The declarative language used to communicate instructions (`SELECT`, `INSERT`, `UPDATE`, `DELETE`).

-- * Right Card (MySQL): The database software engine that receives SQL instructions and performs disk storage, caching, and retrieval.

-- * Bottom Rule: SQL is the Language, while MySQL is the Software Engine that executes that language!

-- ---

-- * SQL (Structured Query Language):

-- * MySQL:

-- ---

-- ======================================================================
-- 🧪 Practice Examples (salesdb sample data)
-- ======================================================================
-- First run 00-Setup-Sample-Data.sql once. Then run these one by one (select a statement → execute).
USE salesdb;

-- Standard SQL — works the same in MySQL, PostgreSQL, SQL Server:
SELECT country, COUNT(*) AS total_customers
FROM customers
GROUP BY country
ORDER BY total_customers DESC;

-- MySQL-specific syntax (extensions on top of SQL):
SELECT firstname, score FROM customers ORDER BY score DESC LIMIT 2;       -- LIMIT (SQL Server uses TOP)
SELECT CONCAT(firstname, ' ', IFNULL(lastname, '')) AS full_name FROM customers;  -- IFNULL (standard: COALESCE)
SHOW TABLES;                                                              -- MySQL command, not standard SQL
SELECT `firstname` FROM `customers`;                                    -- backticks for identifiers

-- ======================================================================
-- 🎯 Practice Questions (salesdb sample data) — try first, then look at the answer
-- ======================================================================
-- Run 00-Setup-Sample-Data.sql once before this section.

USE salesdb;

-- Q1. Standard SQL that runs everywhere: customers ordered by score.
SELECT firstname, score FROM customers ORDER BY score DESC;

-- Q2. Full name — MySQL uses CONCAT/IFNULL (Postgres: || and COALESCE).
SELECT CONCAT(firstname, ' ', IFNULL(lastname, '')) AS full_name FROM customers;

-- Q3. Top 3 most expensive products (LIMIT works in MySQL and PostgreSQL).
SELECT product, price FROM products ORDER BY price DESC LIMIT 3;
