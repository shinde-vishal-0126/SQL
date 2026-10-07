-- ======================================================================
-- Topic 7: SQL Server Architecture & Database Hierarchy
-- ======================================================================

-- ------------------------------------------------------------
-- 📖 In Simple Words
-- ------------------------------------------------------------

-- * Definition: Architecture is how the database server is built: a server holds many databases, a database holds schemas/tables, and tables hold columns and rows.

-- * Real-life example: A shopping mall (server) has shops (databases), each shop has racks (tables), each rack has items (rows).

-- * 🧩 Syntax:
--     SELECT * FROM schema_name.table_name;
--     SELECT * FROM information_schema.columns WHERE table_schema = 'schema_name';

-- * Syntax explained (each part):
--   - database.table (MySQL) → full name: in MySQL a database and a schema are the same thing
--   - schema.table (PostgreSQL) → server → database → schema → table; one query runs inside one database
--   - information_schema → built-in catalog that describes the hierarchy

-- * Example on salesdb (run 00-Setup-Sample-Data.sql first):
SET search_path TO sales;
SELECT datname FROM pg_database;
SELECT * FROM sales.customers;

-- * Example explained (step by step):
--   1. The first query lists all databases on the server (the shops in the mall).
--   2. The second query names the full path: salesdb.customers (MySQL: database.table, PostgreSQL: schema.table).
--   3. This shows the levels of the hierarchy in practice.

-- ------------------------------------------------------------
-- 7.1 What is a SQL Server and Database Hierarchy?
-- ------------------------------------------------------------

-- * Diagram summary: Shows the top-down hierarchy: SQL Server -> Database -> Schema -> Table / View

--   ┌ ASCII diagram
--   │  [ SQL Server / DB Server ]
--   │             │
--   │    ┌────────┴────────┐
--   │  [Database A]     [Database B]
--   │       │
--   │    ┌──┴──────────┐
--   │  [Schema: sales] [Schema: hr]
--   │       │
--   │    ┌──┴─────┐
--   │  [Table]  [View]
--   │    │
--   │  columns + rows
--   └

-- 1. SQL Server (DBMS): It allows us to store, manage, and provide access to databases for users or applications.

-- 2. Database: Inside a SQL Server, there are multiple databases. A database is a collection of information stored in a structured way where all your data is kept and organized into different tables and objects. Each database is separated from the others and has its own data.

-- 3. Schema: Inside each database, you will find multiple schemas. A schema is a logical layer that groups up related objects (like tables and views) together.

-- 4. Table: Inside the schema, we find tables. A table is the place where your data actually lives physically, organized into rows and columns.

-- 5. View: Inside the schema, there is another object called a View.

--    - A View is like a virtual table that has a structure (columns and data types) but does not store data physically.

--    - It shows data without storing it. To see the data, the query behind the view must execute.

--    - Unlike a table, it does not store data permanently.

-- * 🐘 PostgreSQL Note: Here "SQL Server" means any database server (it is not only Microsoft SQL Server). PostgreSQL follows this exact hierarchy: Server (cluster) ➔ Database ➔ Schema ➔ Tables / Views. Every database has a default schema `public` (like `dbo` in Microsoft SQL Server). In MySQL, `DATABASE` and `SCHEMA` are the same thing, so MySQL skips one level.

-- ---

-- ------------------------------------------------------------
-- 7.2 The 3-Tier Database Architecture (Three Levels of Abstraction)
-- ------------------------------------------------------------

-- * Diagram summary: Shows the High to Low Abstraction levels involving Business Analysts, Power BI, App Developers, and DBAs

--   ┌ ASCII diagram
--   │  HIGH abstraction (sees only results)
--   │    ▲  Business Analyst  → reports, dashboards
--   │    │  Power BI / Tools  → views, ready tables
--   │    │  App Developer     → tables, SQL queries
--   │    │  DBA               → files, storage, indexes, users
--   │    ▼
--   │  LOW abstraction (sees physical details)
--   └

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
-- pgAdmin: open the Query Tool on database "salesdb".
-- Hierarchy: Cluster (server) → Database → Schema → Table → Column / Row
SELECT datname FROM pg_database WHERE NOT datistemplate;     -- databases
SELECT schema_name FROM information_schema.schemata;          -- schemas in salesdb (sales, public, ...)
SELECT table_name FROM information_schema.tables WHERE table_schema = 'sales';   -- tables

SELECT table_schema, table_name, column_name, data_type
FROM information_schema.columns
WHERE table_schema = 'sales'
ORDER BY table_name, ordinal_position;

-- Fully qualified name: schema.table (cross-database queries are not allowed)
SELECT sales.customers.firstname FROM sales.customers;

-- ======================================================================
-- 🎯 Practice Questions (salesdb sample data) — try first, then look at the answer
-- ======================================================================
-- Run 00-Setup-Sample-Data.sql once before this section.

SET search_path TO sales;

-- Q1. Which databases exist on the server?
SELECT datname FROM pg_database WHERE NOT datistemplate;

-- Q2. Use a fully qualified name to read a table.
SELECT * FROM sales.products;   -- schema.table

-- Q3. Count the columns of each table in salesdb.
SELECT table_name, COUNT(*) AS columns_count
FROM information_schema.columns
WHERE table_schema = 'sales'
GROUP BY table_name;
