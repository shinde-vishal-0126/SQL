-- ======================================================================
-- Topic 2: What is a DBMS (Database Management System)?
-- ======================================================================

-- ------------------------------------------------------------
-- 📖 In Simple Words
-- ------------------------------------------------------------

-- * Definition: A DBMS (Database Management System) is the software that stores the database and lets you read, change and protect the data. MySQL and PostgreSQL are DBMS.

-- * Real-life example: The database is the library; the DBMS is the librarian who finds books, stops wrong entries and controls who may enter.

-- * Example on salesdb (run 00-Setup-Sample-Data.sql first):
USE salesdb;
SELECT VERSION();
INSERT INTO customers (customerid, firstname) VALUES (1, 'Copy');   -- fails

-- * Example explained (step by step):
--   1. The first line asks the DBMS which version is running.
--   2. The second line tries to add a customer with id 1, but id 1 already exists.
--   3. The DBMS rejects it (duplicate primary key) — this is the DBMS protecting your data.

-- ------------------------------------------------------------
-- 2.1 Definition & Meaning
-- ------------------------------------------------------------

-- * Q. What is a DBMS (Database Management System)?

--   * DBMS stands for Database Management System.

--   * Definition: A DBMS is software that manages a database. It lets users and applications create, read, update and delete data easily.

--   * It also keeps the data secure and consistent (correct), even when many people use it at the same time.

--   * It powers the core CRUD operations:

--     * Create: Insert new records (`INSERT`)

--     * Read: Search and retrieve records (`SELECT`)

--     * Update: Modify existing records (`UPDATE`)

--     * Delete: Remove obsolete records (`DELETE`)

-- ---

-- ------------------------------------------------------------
-- 2.2 Why Do We Need a DBMS?
-- ------------------------------------------------------------

-- * Q. Why do we need a DBMS instead of accessing raw database storage directly?

--   * A database alone is only storage. It cannot check who the user is, decide which request runs first, or safely handle many users at the same time.

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

-- | Component | Role in the Ecosystem | Simple Analogy |
-- | :--- | :--- | :--- |
-- | 🗄️ Database | Stores Data | The physical storage locker / container |
-- | 🗣️ SQL | Speaks to Database | The standardized language used to communicate |
-- | ⚙️ DBMS | Manages Database | The intelligent manager / security controller |
-- | 🖥️ Server | Hosts Database Engine | The 24/7 operating computer host (Cloud / On-Premise) |

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

-- 1. The Server (Host Environment):

--    * The computer (physical or cloud) that runs the database 24/7.

-- 2. The Database (Data Container):

--    * The storage container containing tables, rows, columns, and relationships.

-- 3. The DBMS (The Manager):

--    * The software in the middle: it accepts connections, checks permissions, runs queries and reads/writes storage.

-- 4. Clients (Speaking via SQL):

--    * Developers & DBAs: Running administrative queries and migrations.

--    * *Applications (App `</>`):* Web and mobile backend services processing user transactions.

--    * Analytics Tools (Power BI / Dashboards): Running aggregate calculations for live executive reports.

-- ---

-- ---

-- ======================================================================
-- 🧪 Practice Examples (salesdb sample data)
-- ======================================================================
-- First run 00-Setup-Sample-Data.sql once. Then run these one by one (select a statement → execute).
USE salesdb;

-- The DBMS (MySQL) manages storage, users, security and concurrency for you.
SELECT VERSION();          -- which DBMS version is running
SELECT DATABASE();         -- current database
SELECT CURRENT_USER();     -- who is connected

-- The DBMS keeps metadata (data about data) in its own catalog:
SELECT table_name, table_rows, engine
FROM information_schema.tables
WHERE table_schema = 'salesdb';

-- The DBMS enforces rules (integrity). This fails: customerid 1 already exists (PRIMARY KEY).
INSERT INTO customers (customerid, firstname, country) VALUES (1, 'Test', 'India');

-- This fails too: product 999 does not exist (FOREIGN KEY on orders.productid).
INSERT INTO orders (orderid, productid, customerid) VALUES (99, 999, 1);

-- ======================================================================
-- 🎯 Practice Questions (salesdb sample data) — try first, then look at the answer
-- ======================================================================
-- Run 00-Setup-Sample-Data.sql once before this section.

USE salesdb;

-- Q1. Which DBMS version and which database are you using?
SELECT VERSION(), DATABASE();

-- Q2. List the columns and data types of the orders table from the DBMS catalog.
SELECT column_name, data_type
FROM information_schema.columns
WHERE table_schema = 'salesdb' AND table_name = 'orders'
ORDER BY ordinal_position;

-- Q3. The DBMS protects data: try to add a customer without an id (fails — primary key cannot be NULL).
INSERT INTO customers (firstname, country) VALUES ('NoId', 'India');
