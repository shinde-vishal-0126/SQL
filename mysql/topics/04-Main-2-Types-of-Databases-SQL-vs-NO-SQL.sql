-- ======================================================================
-- Topic 4: Main 2 Types of Databases (SQL vs NO-SQL)
-- ======================================================================

-- ------------------------------------------------------------
-- 📖 In Simple Words
-- ------------------------------------------------------------

-- * Definition: There are two main kinds of databases: SQL (relational) databases keep data in tables with fixed columns and relations; NoSQL databases keep data in flexible forms like documents, key-value pairs or graphs.

-- * Real-life example: SQL = an Excel sheet with fixed columns. NoSQL = a folder of free-form notes where each note can look different.

-- * 🧩 Syntax:
--     -- SQL (relational): fixed columns, linked by keys
--     SELECT t1.col, t2.col
--     FROM table1 t1 JOIN table2 t2 ON t1.key = t2.key;
--     -- NoSQL-style document built in SQL:
--     SELECT JSON_OBJECT('key1', col1, 'key2', col2) FROM table_name;

-- * Syntax explained (each part):
--   - JOIN … ON → links rows of two tables using a common key (relational way)
--   - JSON_OBJECT / json_build_object → builds a key-value document (NoSQL way)

-- * Example on salesdb (run 00-Setup-Sample-Data.sql first):
USE salesdb;
SELECT o.orderid, c.firstname, o.sales
FROM orders o
JOIN customers c ON c.customerid = o.customerid;

-- * Example explained (step by step):
--   1. Data is split into two tables: orders and customers.
--   2. JOIN connects them using the common column customerid — this "relation" is what makes it a relational (SQL) database.
--   3. A NoSQL document store would instead save the customer name inside every order document.

-- ------------------------------------------------------------
-- 4.1 Overview: SQL vs NO-SQL
-- ------------------------------------------------------------

-- * Q. What are the two primary classifications of modern databases?

--   * Modern database architectures are primarily classified into two main paradigms:

--     1. SQL (Relational Databases)

--     2. NO-SQL (Non-Relational Databases)

-- (Dimension → SQL (Relational Databases) | NO-SQL (Non-Relational Databases))
--
-- * Storage Paradigm
--     - SQL (Relational Databases)        : Tables with strictly typed columns and rows
--     - NO-SQL (Non-Relational Databases) : Key-Value, Document, Columnar, or Graph models
--
-- * Schema Design
--     - SQL (Relational Databases)        : Predefined, rigid, structured schema
--     - NO-SQL (Non-Relational Databases) : Flexible, dynamic, schema-less architecture
--
-- * Primary Query Tool
--     - SQL (Relational Databases)        : Standardized SQL language
--     - NO-SQL (Non-Relational Databases) : Specialized document queries, APIs, or key lookups
--
-- * Primary Strengths
--     - SQL (Relational Databases)        : ACID compliance, data integrity, complex relations
--     - NO-SQL (Non-Relational Databases) : Rapid horizontal scalability, big data, rapid prototyping
--
-- * Typical Examples
--     - SQL (Relational Databases)        : MySQL, PostgreSQL, Oracle, SQL Server
--     - NO-SQL (Non-Relational Databases) : MongoDB, Redis, Cassandra, Neo4j
--

-- > 📌 Important Note:
-- > * Relational Database is commonly referred to as SQL.
-- > * We group Document, Graph, Column-based, and Key-value data stores together $\rightarrow$ all those database engines are classified as NO-SQL databases.

-- ---

-- ------------------------------------------------------------
-- 4.2 Relational Database (SQL)
-- ------------------------------------------------------------

-- * Q. What is a Relational Database and how does it organize data?

--   * Definition: A relational database stores data in tables (rows and columns), and the tables are linked to each other using keys.

--   * How it works:

--     * It works like Excel sheets.

--     * Data entities are organized into tables, where each column represents an attribute and each row represents an individual record.

--     * Data is held strictly in a tabular format.

--     * Foreign keys create relationships between tables, so the same data doesn't have to be stored again and again.

-- * Popular Examples:

--   * MySQL

--   * PostgreSQL

--   * Microsoft SQL Server

-- ---

-- ------------------------------------------------------------
-- 4.3 NO-SQL Databases (Non-Relational Models)
-- ------------------------------------------------------------

-- NoSQL (non-relational) databases store data that does not fit neatly into tables. There are 4 main types:

-- ------------------------------------------------------------
-- 1. Key-Value Pair Database
-- ------------------------------------------------------------

-- * Q. What is a Key-Value database and where is it used?

--   * Definition: A Key-Value database stores every item as a pair: a unique key and its value — like a dictionary.

--   * Think of it like an indexed dictionary:

--     * The word functions as the Key.

--     * The explanation represents the Value.

--   * Data is stored directly as Key ➔ Value pairs in object formats.

-- * Popular Examples:

--   * Redis

--   * Amazon DynamoDB

-- ------------------------------------------------------------
-- 2. Column-Based Database
-- ------------------------------------------------------------

-- * Q. What is a Column-Based database and why is it used for Big Data?

--   * Definition: A Column-Based (wide-column) database stores data column by column instead of row by row, which makes reading and summarizing huge data very fast.

--   * Built for Big Data and data warehouses with billions of records.

--   * Because data is stored by column, a query reads only the columns it needs, so much less disk reading is required.

-- * Popular Examples:

--   * Apache Cassandra

--   * Amazon Redshift

-- ------------------------------------------------------------
-- 3. Graph Database
-- ------------------------------------------------------------

-- * Q. What is a Graph database and what problems does it solve?

--   * Definition: A Graph database stores data as nodes (things) and edges (connections between things).

--   * Best when the relationships between items matter most (e.g., social network followers, fraud detection, recommendations).

-- * Popular Example:

--   * Neo4j

-- ------------------------------------------------------------
-- 4. Document-Based Database
-- ------------------------------------------------------------

-- * Q. What is a Document database?

--   * Definition: A Document database stores each record as a document (usually JSON), and different documents can have different fields.

--   * Instead of splitting data into many tables, all details of one item are kept together in one document.

-- * Popular Example:

--   * MongoDB

-- ---

-- ------------------------------------------------------------
-- 4.4 Visual Concept: SQL vs NO-SQL Architecture
-- ------------------------------------------------------------

-- ------------------------------------------------------------
-- Simple Explanation of the Diagram:
-- ------------------------------------------------------------

-- 1. Right Side (SQL - Relational):

--    * Stored in structured tables with rows and columns (analogous to spreadsheets).

--    * Tables maintain explicit relationships through primary and foreign keys.

--    * Examples: Microsoft SQL Server, MySQL, PostgreSQL.

-- 2. Left Side (NO-SQL Cloud):

--    * Combines four specialized non-relational storage models:

--      * Document: Packages all related entity data inside a single JSON document (MongoDB).

--      * Graph: Maps interconnected data points focusing on network relationships (Neo4j).

--      * Column-Based: Organizes storage by columns for rapid big data search queries (Cassandra, Redshift).

--      * Key-Value: Associative dictionary model indexing pairs (Redis, DynamoDB).

-- ---

-- ------------------------------------------------------------
-- 4.5 CAP Theorem & When to Choose SQL vs NoSQL
-- ------------------------------------------------------------

-- * CAP theorem (for distributed databases spread over many servers): when the network between servers breaks (Partition), a system must choose between:

--   * C – Consistency: every read gets the latest write (or an error).

--   * A – Availability: every request gets an answer, even if it may be old data.

--   * P – Partition tolerance: the system keeps working when servers can't talk to each other.

-- * Network partitions will happen, so real systems choose CP or AP during a partition:

-- (Type → During a network split | Examples)
--
-- * CP
--     - During a network split : Refuses some requests to stay correct
--     - Examples               : MongoDB (default), HBase, etcd, ZooKeeper, MySQL Group Replication (single primary)
--
-- * AP
--     - During a network split : Always answers, data may be briefly stale (eventual consistency)
--     - Examples               : Cassandra, DynamoDB, CouchDB, Riak
--
-- * CA
--     - During a network split : Only possible when there is no partition — a single-server RDBMS (one MySQL server)
--     - Examples               : Single-node MySQL / PostgreSQL
--

-- * ACID vs BASE: SQL databases follow ACID (strict correctness); many NoSQL systems follow BASE — Basically Available, Soft state, Eventually consistent.

-- * When to choose SQL: structured data with relations, joins and reports, money/orders/inventory where correctness matters (ACID), complex queries, a fixed schema.

-- * When to choose NoSQL: huge scale with simple key lookups, flexible or changing schema (JSON documents), very high write speed (logs, IoT, events), caching/sessions (Redis), graph relations (Neo4j).

-- * Many real systems use both: MySQL for orders and payments + Redis for cache + Elasticsearch for search + MongoDB for product catalogues ("polyglot persistence").

-- >

--   1. SQL (Relational Database)

--   2. NO-SQL (Non-Relational Database)

--   * Key-Value Pair Database:

--   * Column-Based Database:

--   * Graph Database:

--   * Document-Based Database:

-- ---

-- ======================================================================
-- 🧪 Practice Examples (salesdb sample data)
-- ======================================================================
-- First run 00-Setup-Sample-Data.sql once. Then run these one by one (select a statement → execute).
USE salesdb;

-- SQL (relational) database: fixed columns, rows linked by keys, read with JOIN.
SELECT o.orderid, c.firstname, p.product, o.sales
FROM orders o
JOIN customers c ON c.customerid = o.customerid
JOIN products  p ON p.productid  = o.productid;

-- NoSQL style (document): one order kept as a JSON document with everything nested inside.
-- MySQL can produce/store such documents too:
SELECT JSON_OBJECT(
         'orderid',  o.orderid,
         'customer', JSON_OBJECT('name', c.firstname, 'country', c.country),
         'product',  JSON_OBJECT('name', p.product, 'price', p.price),
         'sales',    o.sales) AS order_document
FROM orders o
JOIN customers c ON c.customerid = o.customerid
JOIN products  p ON p.productid  = o.productid;

-- ======================================================================
-- 🎯 Practice Questions (salesdb sample data) — try first, then look at the answer
-- ======================================================================
-- Run 00-Setup-Sample-Data.sql once before this section.

USE salesdb;

-- Q1. Relational (SQL) style: show each order with customer name and product name using JOIN.
SELECT o.orderid, c.firstname, p.product
FROM orders o
JOIN customers c ON c.customerid = o.customerid
JOIN products  p ON p.productid  = o.productid;

-- Q2. Document (NoSQL) style: build one JSON document per customer.
SELECT JSON_OBJECT('id', customerid, 'name', firstname, 'country', country, 'score', score) AS doc
FROM customers;

-- Q3. Fixed schema: which columns must every orders row follow?
DESCRIBE orders;
