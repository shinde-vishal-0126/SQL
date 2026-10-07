-- ======================================================================
-- Topic 7: SQL Server Architecture & Database Hierarchy
-- ======================================================================

-- ------------------------------------------------------------
-- 📖 In Simple Words
-- ------------------------------------------------------------

-- * Definition: Architecture is how the database server is built: a server holds many databases, a database holds schemas/tables, and tables hold columns and rows.

-- * Real-life example: A shopping mall (server) has shops (databases), each shop has racks (tables), each rack has items (rows).

-- * Example on salesdb (run 00-Setup-Sample-Data.sql first):
USE salesdb;
SHOW DATABASES;
SELECT * FROM salesdb.customers;

-- * Example explained (step by step):
--   1. The first query lists all databases on the server (the shops in the mall).
--   2. The second query names the full path: salesdb.customers (MySQL: database.table, PostgreSQL: schema.table).
--   3. This shows the levels of the hierarchy in practice.

-- ------------------------------------------------------------
-- 7.1 What is a SQL Server and Database Hierarchy?
-- ------------------------------------------------------------

-- * Diagram summary: Shows the top-down hierarchy: SQL Server -> Database -> Schema -> Table / View

-- 1. SQL Server (DBMS): It allows us to store, manage, and provide access to databases for users or applications.

-- 2. Database: Inside a SQL Server, there are multiple databases. A database is a collection of information stored in a structured way where all your data is kept and organized into different tables and objects. Each database is separated from the others and has its own data.

-- 3. Schema: Inside each database, you will find multiple schemas. A schema is a logical layer that groups up related objects (like tables and views) together.

-- 4. Table: Inside the schema, we find tables. A table is the place where your data actually lives physically, organized into rows and columns.

-- 5. View: Inside the schema, there is another object called a View.

--    - A View is like a virtual table that has a structure (columns and data types) but does not store data physically.

--    - It shows data without storing it. To see the data, the query behind the view must execute.

--    - Unlike a table, it does not store data permanently.

-- * ⚠️ MySQL Note: Here "SQL Server" means any database server (it is not only Microsoft SQL Server). In MySQL, `DATABASE` and `SCHEMA` are the same thing (`CREATE SCHEMA` = `CREATE DATABASE`), so the MySQL hierarchy is Server ➔ Database (= Schema) ➔ Tables / Views. In Microsoft SQL Server a database contains several schemas (e.g. `dbo`, `sales`).

-- ---

-- ------------------------------------------------------------
-- 7.2 The 3-Tier Database Architecture (Three Levels of Abstraction)
-- ------------------------------------------------------------

-- * Diagram summary: Shows the High to Low Abstraction levels involving Business Analysts, Power BI, App Developers, and DBAs

-- The architecture of a database is divided into three distinct levels:

-- ------------------------------------------------------------
-- 1. Physical Level (Internal Layer)
-- ------------------------------------------------------------

-- * What is it? This is the lowest level of the database. It is where data is actually stored in physical storage (Disk).

-- * Who uses it? Database Administrators (DBA). They are experts who manage access, security, performance optimization, backups, recovery, and configuration.

-- * What it deals with: Data files, partitions, logs, catalogs, blocks, cache, and everything a database needs to physically store data.

-- * Complexity: This is the most complicated layer.

-- ------------------------------------------------------------
-- 2. Logical Level (Conceptual Layer)
-- ------------------------------------------------------------

-- * What is it? This level describes what data is stored in the database and the relationships among those data. It focuses on how to structure the data rather than how it is physically stored.

-- * Who uses it? Application Developers. They interact with this layer to build the data model for their projects.

-- * What it deals with: Creating tables, defining relationships, views, indexing for performance optimization, and writing stored procedures/functions. 

-- * Complexity: Less complicated than the physical layer. It provides a perfect abstraction for developers, so they don't have to worry about physical storage.

-- ------------------------------------------------------------
-- 3. View Level (External Layer)
-- ------------------------------------------------------------

-- * What is it? This is the highest level of abstraction. It only holds the relevant data or information needed for a specific use case.

-- * Who uses it? End Users and Applications. They access and see the data through different views tailored to their perspectives.

-- * What it deals with: Users at this level only deal with Views. They don't have to deal with complex tables, indexes, stored procedures, data files, or partitions.

-- * Complexity: The least complicated. Its focus is to make data friendly and easy to consume for end users.

-- ---

-- ------------------------------------------------------------
-- 7.3 Interview Perspective & Key Takeaways
-- ------------------------------------------------------------

-- * Abstraction: The 3-tier architecture exists to provide Data Abstraction. End-users don't need to know how data is logically structured, and developers don't need to know how data is physically stored on the hard drive.

-- * Security: Views (External Layer) provide a massive security benefit because you can hide sensitive columns (like passwords or salaries) from end-users by simply not including them in the view.

-- * 3-Tier Architecture (Data Abstraction):

--   * Logical (Conceptual): tables, relationships, indexes, procedures ➔ Application Developers.

-- ---

-- ======================================================================
-- 🧪 Practice Examples (salesdb sample data)
-- ======================================================================
-- First run 00-Setup-Sample-Data.sql once. Then run these one by one (select a statement → execute).
-- Hierarchy: Server → Database → Table → Column / Row
SHOW DATABASES;                         -- level 1: databases on this server
USE salesdb;
SHOW TABLES;                            -- level 2: tables in salesdb
SHOW COLUMNS FROM orders;               -- level 3: columns of one table (= DESCRIBE orders;)

-- The same hierarchy from the catalog:
SELECT table_schema AS database_name, table_name, column_name, data_type
FROM information_schema.columns
WHERE table_schema = 'salesdb'
ORDER BY table_name, ordinal_position;

-- Fully qualified name: database.table.column
SELECT salesdb.customers.firstname FROM salesdb.customers;

-- ======================================================================
-- 🎯 Practice Questions (salesdb sample data) — try first, then look at the answer
-- ======================================================================
-- Run 00-Setup-Sample-Data.sql once before this section.

USE salesdb;

-- Q1. Which databases exist on the server?
SHOW DATABASES;

-- Q2. Use a fully qualified name to read a table.
SELECT * FROM salesdb.products;

-- Q3. Count the columns of each table in salesdb.
SELECT table_name, COUNT(*) AS columns_count
FROM information_schema.columns
WHERE table_schema = 'salesdb'
GROUP BY table_name;
