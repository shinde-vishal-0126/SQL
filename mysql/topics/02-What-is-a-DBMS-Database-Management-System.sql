-- Topic 2: What is a DBMS (Database Management System)?
-- * Definition: A DBMS (Database Management System) is the software that stores the database and lets you read, change and protect the data.
-- * MySQL and PostgreSQL are DBMS.
-- * Real-life example: The database is the library; the DBMS is the librarian who finds books, stops wrong entries and controls who may enter.
-- * 🧩 Syntax:
--     SELECT VERSION();                 -- which DBMS version
--     SHOW DATABASES;                    -- databases the DBMS manages
--     SHOW TABLES;                       -- tables in the current database
-- * Syntax explained (each part):
--   - VERSION() → function that returns the DBMS version
--   - SHOW … / catalog query → asks the DBMS for its own metadata (data about data)
-- * Example on salesdb (run 00-Setup-Sample-Data.sql first):
USE salesdb;
SELECT VERSION();
INSERT INTO customers (customerid, firstname)
VALUES (1, 'Copy');
-- fails
-- * Example explained (step by step):
--   1. The first line asks the DBMS which version is running.
--   2. The second line tries to add a customer with id 1, but id 1 already exists.
--   3. The DBMS rejects it (duplicate primary key) — this is the DBMS protecting your data.
-- ------------------------------------------------------------
-- 2.1 Definition & Meaning
-- ------------------------------------------------------------
-- * Q. What is a DBMS (Database Management System)?
--   * DBMS stands for Database Management System.
--   * Definition: A DBMS is software that manages a database.
--   * It lets users and applications create, read, update and delete data easily.
--   * It also keeps the data secure and consistent (correct), even when many people use it at the same time.
--   * It powers the core CRUD operations:
--     * Create: Insert new records (`INSERT`)
--     * Read: Search and retrieve records (`SELECT`)
--     * Update: Modify existing records (`UPDATE`)
--     * Delete: Remove obsolete records (`DELETE`)
--

-- ------------------------------------------------------------
-- 2.2 Why Do We Need a DBMS?
-- ------------------------------------------------------------
-- * Q. Why do we need a DBMS instead of accessing raw database storage directly?
--   * A database alone is only storage.
--   * It cannot check who the user is, decide which request runs first, or safely handle many users at the same time.
--   * Real-world applications encounter simultaneous high-volume traffic from:
--     1. Multiple Developers / Database Administrators (running scripts and administration tasks)
--     2. Web & Mobile Applications (concurrent read/write requests from millions of users)
--     3. BI & Reporting Tools like Power BI / Tableau (generating real-time analytical dashboards)
--   * So we need a smart manager in the middle that handles many requests at once, avoids crashes and protects the data — that manager is the DBMS.
-- ---
-- ------------------------------------------------------------
-- 2.3 Key Functions & Responsibilities
-- ------------------------------------------------------------
-- 1. Request Management & Traffic Routing:
--    * Receives requests from many applications, checks them, and passes them on for execution.
-- 2. Priority Handling (Query Scheduling):
--    * Decides which query runs first, so no request waits forever and queries don't block each other.
-- 3. Security Management & Access Control:
--    * Checks whether the user has permission to read or change the requested data.
-- 4. Data Integrity & Concurrency Control:
--    * Uses locks and transactions so that many users updating at the same time never corrupt the data.
-- 5. Backup & Disaster Recovery:
--    * Keeps a log of every change (write-ahead log, `WAL`) so data can be recovered after a power cut or crash.
-- ---
-- ------------------------------------------------------------
-- 2.4 Step-by-Step Query Execution Lifecycle in DBMS
-- ------------------------------------------------------------
-- ------------------------------------------------------------
-- Detailed Step-by-Step Explanation of the Lifecycle:
-- ------------------------------------------------------------
-- 1. Step 1: Client Submits SQL Query
--    * Developers, client applications, and BI tools submit queries formatted in standard SQL (e.g., `SELECT SUM(amount) FROM sales;`).
-- 2. Step 2: DBMS Security & Authentication Check (Gatekeeper)
--    * Before parsing, the DBMS verifies:
--      * Is the user account authenticated?
--      * Does the account hold permission to read or write the targeted tables?
--      * Is the statement safe to process?
--    * Unauthorized requests are immediately blocked with an authentication error.
-- 3. Step 3: Query Priority & Optimization
--    * Approved queries wait in a queue. The Query Optimizer then chooses the fastest way to run each query (for example, whether to use an index and how to join tables).
-- 4. Step 4: Execution Engine (Storage I/O)
--    * The execution engine runs that plan: it takes the needed locks and reads/writes the data on disk.
-- 5. Step 5: Database Storage & Instant Result Delivery
--    * The matching rows are sent back to the client as a table (result set), usually in milliseconds.
-- ---
-- ------------------------------------------------------------
-- 2.5 The 4 Core Pillars (Quick Reference)
-- ------------------------------------------------------------
-- (Component → Role in the Ecosystem | Simple Analogy)
--
-- * 🗄️ Database
--     - Role in the Ecosystem : Stores Data
--     - Simple Analogy        : The physical storage locker / container
--
-- * 🗣️ SQL
--     - Role in the Ecosystem : Speaks to Database
--     - Simple Analogy        : The standardized language used to communicate
--
-- * ⚙️ DBMS
--     - Role in the Ecosystem : Manages Database
--     - Simple Analogy        : The intelligent manager / security controller
--
-- * 🖥️ Server
--     - Role in the Ecosystem : Hosts Database Engine
--     - Simple Analogy        : The 24/7 operating computer host (Cloud / On-Premise)
--

-- ---
-- ------------------------------------------------------------
-- 2.6 Popular Examples of DBMS / RDBMS
-- ------------------------------------------------------------
-- > Note on RDBMS: Modern enterprise DBMS solutions are typically RDBMS (Relational Database Management Systems) because they structure information into related tables.
-- * MySQL: The world's most widely deployed open-source RDBMS (ideal for web architectures with PHP, Python, Java, Node.js).
-- * PostgreSQL / pgAdmin:
--   * PostgreSQL: Highly extensible, enterprise-grade open-source relational DBMS.
--   * pgAdmin: The official graphical management console for interacting with PostgreSQL.
-- * Oracle Database: Paid enterprise RDBMS used by large banks and big companies.
-- * Microsoft SQL Server (MS SQL): Enterprise database suite integrated with the Microsoft ecosystem and .NET.
-- ---
-- ------------------------------------------------------------
-- 2.7 Visual Architecture: Server, Database, DBMS & Clients
-- ------------------------------------------------------------
-- ------------------------------------------------------------
-- Simple Explanation of the Diagram:
-- ------------------------------------------------------------
/*
 ASCII Diagram:
 +--------------------------------------------------------------------+
 |                     SERVER (host machine, 24/7)                    |
 |                                                                    |
 |   +------------------------- DBMS (manager) -------------------+   |
 |   |  connections | permissions | run queries | read/write disk  |   |
 |   |                                                            |   |
 |   |        +------------------ DATABASE ------------------+    |   |
 |   |        |  tables -> rows + columns -> relationships   |    |   |
 |   |        +----------------------------------------------+    |   |
 |   +------------------------------------------------------------+   |
 +--------------------------------------------------------------------+
 ^ SQL                    ^ SQL                   ^ SQL
 |                        |                       |
 +-------------------+   +-------------------+   +-------------------+
 | Developers & DBAs |   | Applications </>  |   | Power BI / Dashb. |
 +-------------------+   +-------------------+   +-------------------+


 1. The Server (Host Environment):
 * The computer (physical or cloud) that runs the database 24/7.
 2. The Database (Data Container):
 * The storage container containing tables, rows, columns, and relationships.
 3. The DBMS (The Manager):
 * The software in the middle: it accepts connections, checks permissions, runs queries and reads/writes storage.
 4. Clients (Speaking via SQL):
 * Developers & DBAs: Running administrative queries and migrations.
 * *Applications (App `</>`):* Web and mobile backend services processing user transactions.
 * Analytics Tools (Power BI / Dashboards): Running aggregate calculations for live executive reports.
 */


-- ======================================================================
-- 🧪 Practice Examples (salesdb sample data)
-- ======================================================================
-- First run 00-Setup-Sample-Data.sql once. Then run these one by one (select a statement → execute).


USE salesdb;
-- The DBMS (MySQL) manages storage, users, security and concurrency for you.


SELECT VERSION();
-- which DBMS version is running


SELECT DATABASE();
-- current database

SELECT CURRENT_USER();
-- who is connected
-- The DBMS keeps metadata (data about data) in its own catalog:
SELECT table_name,
   table_rows,
   engine
FROM information_schema.tables
WHERE table_schema = 'salesdb';


-- The DBMS enforces rules (integrity). This fails: customerid 1 already exists (PRIMARY KEY).
INSERT INTO customers (customerid, firstname, country)
VALUES (1, 'Test', 'India');


-- This fails too: product 999 does not exist (FOREIGN KEY on orders.productid).
INSERT INTO orders (orderid, productid, customerid)
VALUES (99, 999, 1);
-- ======================================================================
-- 🎯 Practice Questions (salesdb sample data) — try first, then look at the answer
-- ======================================================================
-- Run 00-Setup-Sample-Data.sql once before this section.
USE salesdb;

-- Q1. Which DBMS version and which database are you using?
SELECT VERSION(),

DATABASE();


-- Q2. List the columns and data types of the orders table from the DBMS catalog.
SELECT column_name,
   data_type
FROM information_schema.columns
WHERE table_schema = 'salesdb'
   AND table_name = 'orders'
ORDER BY ordinal_position;
/*
   📘 Understanding information_schema (used in Q2)
   ------------------------------------------------
   - information_schema : a built-in, read-only system database that stores
                          metadata (data about your databases).
   - columns            : a table inside it — one row for every column of
                          every table in every database.

   Columns used in Q2:
   - table_schema     : database name (here 'salesdb').
   - table_name       : table name (here 'orders').
   - column_name      : name of each column (orderid, productid, ...).
   - data_type        : type of the column (int, varchar, date, ...).
   - ordinal_position : position of the column in the table (1, 2, 3 ...);
                        ORDER BY ordinal_position lists columns in created order.

   Other useful columns in information_schema.columns:
   - is_nullable              : YES / NO — whether NULL is allowed.
   - column_key               : PRI = primary key, UNI = unique, MUL = indexed.
   - column_default           : default value of the column.
   - character_maximum_length : max length, e.g. 50 for varchar(50).
   - extra                    : extra info such as auto_increment.

   Related catalog tables:
   - information_schema.tables   : one row per table
                                   (table_rows = approx. row count,
                                    table_type = BASE TABLE / VIEW).
   - information_schema.schemata : one row per database (schema_name).

   Rules for catalog tables (you do NOT define them yourself):
   1. Part of the ANSI/ISO SQL standard — similar names in MySQL,
      PostgreSQL, SQL Server.
   2. Created and kept up to date by MySQL automatically — every
      CREATE / ALTER / DROP updates them.
   3. Read-only — only SELECT works; INSERT / UPDATE / DELETE / CREATE fail.
   4. Names and columns are fixed — you cannot rename or change them.
   5. They are related through common columns:
      - schemata.schema_name = tables.table_schema = columns.table_schema
      - tables.table_name    = columns.table_name
      Hierarchy: schemata (database) -> tables (table) -> columns (column).
*/

-- Example 1: All details of every column in the orders table
--            (uses every field explained above).
SELECT table_schema,
   table_name,
   column_name,
   ordinal_position,
   data_type,
   character_maximum_length,
   is_nullable,
   column_key,
   column_default,
   extra
FROM information_schema.columns
WHERE table_schema = 'salesdb'
   AND table_name = 'orders'
ORDER BY ordinal_position;


-- Example 2: is_nullable — which columns of customers allow NULL?
SELECT column_name,
   is_nullable
FROM information_schema.columns
WHERE table_schema = 'salesdb'
   AND table_name = 'customers';


-- Example 3: column_key — find the primary key / indexed columns in salesdb.
SELECT table_name,
   column_name,
   column_key
FROM information_schema.columns
WHERE table_schema = 'salesdb'
   AND column_key IN ('PRI', 'UNI', 'MUL');


-- Example 4: character_maximum_length — max length of text columns.
SELECT table_name,
   column_name,
   data_type,
   character_maximum_length
FROM information_schema.columns
WHERE table_schema = 'salesdb'
   AND data_type IN ('varchar', 'char');


-- Example 5: column_default and extra — default values and auto_increment.
SELECT table_name,
   column_name,
   column_default,
   extra
FROM information_schema.columns
WHERE table_schema = 'salesdb'
   AND (column_default IS NOT NULL OR extra <> '');


-- Example 6: information_schema.tables — tables, their type and approx. row count.
SELECT table_name,
   table_type,
   table_rows
FROM information_schema.tables
WHERE table_schema = 'salesdb';


-- Example 7: information_schema.schemata — list all databases on the server.
SELECT schema_name
FROM information_schema.schemata;


-- Example 8: Join related catalog tables — each table's row count with its columns.



-- Q3. The DBMS protects data: try to add a customer without an id (fails — primary key cannot be NULL).
INSERT INTO customers (firstname, country)
VALUES ('NoId', 'India');
