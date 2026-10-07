-- 📘 Part 1: Database Fundamentals (Topics 1–8)
-- ======================================================================

-- ---

-- ======================================================================
-- Topic 1: What is a Database?
-- ======================================================================

-- ------------------------------------------------------------
-- 📖 In Simple Words
-- ------------------------------------------------------------

-- * Definition: A database is an organised place where data is stored so it can be found, changed and protected easily.

-- * Real-life example: Like a well-arranged cupboard with labelled boxes, instead of papers thrown in a bag.

-- * Example on salesdb (run 00-Setup-Sample-Data.sql first):
SET search_path TO sales;
SELECT * FROM customers;

-- * Example explained (step by step):
--   1. customers is one table (one labelled box) inside the salesdb database.
--   2. SELECT * means "show every column", FROM customers means "from this table".
--   3. Result: 5 rows — one row per customer (Jossef, Kevin, Mary, Mark, Anna).

-- ------------------------------------------------------------
-- 1.1 Definition & Core Concept
-- ------------------------------------------------------------

-- * Q. What is a Database?

--   * Definition: A database is an organized collection of structured data that can be stored, managed, and retrieved efficiently using a computer system.

--   * A database serves as a central container to store data in a systematic format that can be easily accessed and queried.

-- ---

-- ------------------------------------------------------------
-- 1.2 Detailed Database Structure & Components
-- ------------------------------------------------------------

-- * Q. What is a Database Structure and what are its core components?

--   * Database structure means how data is arranged inside a database — which tables exist, what columns they have, and how they are linked.

-- It includes the following five core building blocks:

-- 1. Schema

--    * The complete blueprint or architectural design of the database (analogous to an architectural floor plan).

--    * Defines which tables exist, their fields, relational links, and integrity constraints.

-- 2. Tables (Relations)

--    * A grid of rows and columns where the actual data is stored.

--    * Consists of Rows (Tuples / Records) representing individual entities, and Columns (Attributes) representing entity properties.

-- 3. Columns (Attributes / Fields)

--    * Specific attributes of an entity with strictly defined Data Types (e.g., `INT` for numbers, `VARCHAR` for variable text, `DATE`/`TIMESTAMP` for temporal values, `BOOLEAN` for true/false flags).

-- 4. Relationship Between Tables

--    * Establishes logical connections between tables using key references:

--      * One-to-One (1:1): One user $\leftrightarrow$ One profile.

--      * One-to-Many (1:N): One customer $\rightarrow$ Multiple placed orders.

--      * Many-to-Many (N:M): Multiple students $\leftrightarrow$ Multiple enrolled courses.

-- 5. Constraints (Integrity Rules)

--    * Rules that stop wrong, empty or duplicate data from entering a table:

--      * `PRIMARY KEY`: Uniquely identifies each record; neither `NULL` nor duplicate values are permitted.

--      * `FOREIGN KEY`: Links a column to the primary key of another table, guaranteeing referential integrity.

--      * `NOT NULL`: Requires the field to have a value (cannot be empty).

--      * `UNIQUE`: Guarantees distinct values across all rows (e.g., email address, phone number).

--      * `CHECK`: Validates conditions on input data (e.g., `CHECK (age >= 18)` or `CHECK (salary > 0)`).

--      * `DEFAULT`: Fills in a preset value automatically when you don't give a value.

-- ---

-- ------------------------------------------------------------
-- 1.3 Visual Concept: Without Database vs. With Database & SQL
-- ------------------------------------------------------------

-- ------------------------------------------------------------
-- Simple Explanation of the Diagram:
-- ------------------------------------------------------------

-- 1. Left Side (Without a Database):

--    * Data is scattered across uncoordinated files like `.txt`, spreadsheets (`.xlsx`), and manual notes.

--    * Asking a question like "What is the total spending?" requires manual, error-prone file searches across hundreds of documents.

-- 2. Right Side (With a Database & SQL):

--    * All data is kept together in one organized place — the database.

--    * Data is structured into relational tables connected by keys.

--    * Users ask questions using SQL (Structured Query Language).

--    * The database calculates the answer (e.g., "30M") in milliseconds.

-- ---

-- ---

-- ======================================================================
-- 🧪 Practice Examples (salesdb sample data)
-- ======================================================================
-- First run 00-Setup-Sample-Data.sql once. Then run these one by one (select a statement → execute).
-- pgAdmin: open the Query Tool on database "salesdb".
SET search_path TO sales;

-- Databases on this server:
SELECT datname FROM pg_database WHERE NOT datistemplate;

-- Tables inside salesdb (schema sales):
SELECT table_name FROM information_schema.tables WHERE table_schema = 'sales';

-- A table stores rows (records) and columns (fields):
SELECT * FROM customers;

-- Read only what you need — customers from Germany:
SELECT firstname, lastname, score
FROM customers
WHERE country = 'Germany';

-- ======================================================================
-- 🎯 Practice Questions (salesdb sample data) — try first, then look at the answer
-- ======================================================================
-- Run 00-Setup-Sample-Data.sql once before this section.

SET search_path TO sales;

-- Q1. Show every row and column of the customers table.
SELECT * FROM customers;

-- Q2. How many rows (records) does each table have?
SELECT 'customers' AS table_name, COUNT(*) AS total_rows FROM customers
UNION ALL SELECT 'employees', COUNT(*) FROM employees
UNION ALL SELECT 'products',  COUNT(*) FROM products
UNION ALL SELECT 'orders',    COUNT(*) FROM orders;

-- Q3. Show only the product name and price (two columns = two fields).
SELECT product, price FROM products;
