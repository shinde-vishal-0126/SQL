-- ======================================================================
-- Topic 33: Tables, CTAS & Temporary Tables Deep Dive
-- ======================================================================

-- ------------------------------------------------------------
-- 📖 In Simple Words
-- ------------------------------------------------------------

-- * Definition: CTAS (CREATE TABLE AS SELECT) makes a new real table from a query result. A temporary table is a table that lives only during your session and disappears when you disconnect.

-- * Real-life example: CTAS = photocopying a report and keeping it in a file. Temporary table = notes on a whiteboard wiped at the end of the meeting.

-- * 🧩 Syntax:
--     CREATE TABLE new_table AS SELECT ... FROM ... WHERE ...;   -- CTAS
--     CREATE TEMP TABLE tmp_name AS SELECT ...;                   -- session-only
--     DROP TABLE tmp_name;

-- * Syntax explained (each part):
--   - CREATE TABLE … AS SELECT → new real table filled with the query result (keys/indexes are not copied)
--   - TEMPORARY → visible only in your session; dropped automatically on disconnect

-- * Example on salesdb (run 00-Setup-Sample-Data.sql first):
SET search_path TO sales;
CREATE TABLE usa_customers AS
SELECT * FROM customers WHERE country = 'USA';
SELECT * FROM usa_customers;
DROP TABLE usa_customers;

-- * Example explained (step by step):
--   1. CREATE TABLE … AS SELECT copies the 3 USA customers into a new table.
--   2. The new table is independent: later changes in customers do not change it.
--   3. With CREATE TEMPORARY TABLE it would be dropped automatically at the end of the session.

-- ------------------------------------------------------------
-- 33.1 What are Database Tables? (Physical Storage vs Logical Grid)
-- ------------------------------------------------------------

-- * Diagram summary: Shows the connection between physical database files on disk and the logical grid of rows, columns, and cells

-- * Definition: A database table is a structured collection of data. It is similar to a simple grid or spreadsheet (like Excel).

-- * Logical Structure:

--   * Columns: Represent different fields (e.g., `ID`, `Name`, `Score`).

--   * Rows: Represent a single record or entry (e.g., one employee's complete data).

--   * Cells: The intersection of a row and a column, holding a single piece of data.

-- * Physical Storage: 

--   * While they look like spreadsheets to us, tables are physically stored as database files on the disk.

--   * Users and developers usually do not have direct access to these files. The "Table" we see is an abstraction. Every time you query a table, the database engine goes to these files on the disk, fetches the data, and presents it to you.

-- * Types of Tables:

--   1. Permanent Tables: Stay in the database permanently until you drop them.

--   2. Temporary Tables: Session-specific tables that are automatically deleted when the session ends.

-- ------------------------------------------------------------
-- 33.2 How to Create Permanent Tables: CREATE/INSERT vs CTAS
-- ------------------------------------------------------------

-- * Diagram summary: Shows the syntax differences between the two methods

-- * Diagram summary: Compares the 2-step CREATE/INSERT process vs the 1-step CTAS process
-- There are two main ways to create and populate a permanent table in SQL.

-- 1. The Classical Way: CREATE / INSERT (2 Steps)

-- * Step 1 (CREATE): You define the structure of the table from scratch using a DDL statement.
CREATE TABLE Table_Name (
    ID INT,
    Name VARCHAR(50)
);

-- * Step 2 (INSERT): You insert data into the newly created structure (from a CSV, manual input, or another query).
INSERT INTO Table_Name VALUES (1, 'Frank');

-- 2. CTAS (Create Table As Select) - (1 Step)

-- * Definition: Creates a brand new table based on the result of an SQL query.

-- * How it works: You define a query. The database executes it, retrieves the data, and creates a new table whose structure (columns/datatypes) and data come one-to-one directly from the query's result. You don't need to manually define data types.
CREATE TABLE new_table_name AS 
SELECT * FROM source_table WHERE condition;

-- ---

-- ------------------------------------------------------------
-- 33.3 CTAS Use Cases
-- ------------------------------------------------------------

-- ------------------------------------------------------------
-- Use Case 1: Optimizing Performance (Storing Complex Logic)
-- ------------------------------------------------------------

-- * Diagram summary: Shows a 30-min complex query saved into a CTAS table, allowing multiple analysts to query it instantly

-- * The Problem with Views: If you put a very complex, heavy query (e.g., massive joins and aggregations) inside a View, the database has to execute that 30-minute query every time an analyst queries the view. This makes the system incredibly slow.

-- * The CTAS Solution: Instead of a view, you run a CTAS query at night. The database takes the 30 minutes to generate the intermediate result, but it saves it as a Physical Table.

-- * Result: In the morning, when analysts query the CTAS table, the response time is fast and instant, because the data is already computed and prepared.

-- Example: Total Orders by Month
DROP TABLE IF EXISTS TOTAL_ORDERS;

-- CREATE TABLE AS SELECT
CREATE TABLE total_orders AS (
    SELECT
        COUNT(*) AS total_count,
        TO_CHAR(orderdate, 'FMMonth') AS month,     -- MySQL: MONTHNAME(orderdate)
        SUM(sales) AS total_sales
    FROM orders
    GROUP BY TO_CHAR(orderdate, 'FMMonth')
);

-- Query the prepared data instantly
SELECT * FROM total_orders;

-- > How to Refresh a CTAS Table (PostgreSQL)?
-- > CTAS tables do not auto-refresh. If the source data changes, the CTAS table becomes stale.
-- > 1. Option 1 (Full Refresh): `DROP TABLE IF EXISTS` and run CTAS again. (Warning: loses indexes/constraints).
-- > 2. Option 2 (Best Practice): `TRUNCATE TABLE total_orders;` followed by `INSERT INTO total_orders SELECT ...`. (Preserves table structure and indexes).
-- > 3. Option 3 (Incremental): `INSERT ... ON CONFLICT (key) DO UPDATE` or `MERGE` (if a primary/unique key exists).
-- > 4. Option 4 (PostgreSQL best): use a `MATERIALIZED VIEW` instead of a CTAS table and run `REFRESH MATERIALIZED VIEW` (Topic 32.8).
-- > Tip: in PostgreSQL steps 1 and 2 can run inside `BEGIN ... COMMIT`, so readers never see an empty table.

-- ------------------------------------------------------------
-- Use Case 2: Creating a Persistent Snapshot (Debugging)
-- ------------------------------------------------------------

-- * Diagram summary: Shows live orders changing, and a static CTAS snapshot being extracted for analysis

-- * The Problem: You have a data quality issue to investigate, but the live table is constantly receiving updates and new records. It is impossible to analyze a moving target.

-- * The Solution: Use CTAS to create a fixed, persistent snapshot of the data at a specific moment in time. You can safely run your analysis on this static snapshot table without worrying about live updates messing up your debugging.

-- ------------------------------------------------------------
-- Use Case 3: Physical Data Marts in Data Warehouses
-- ------------------------------------------------------------

-- * Diagram summary: Shows Source Systems feeding a Data Warehouse, and CTAS creating fast Physical Data Marts for Reporting

-- * Definition: A data mart is a subset of a data warehouse that focuses on a specific business area, department, or function (for example: sales, finance, marketing, or HR).

-- * The Performance Issue: If you create Data Marts as Views (Virtual Layer), performance can be slow because the view has to waste time waiting for the data mart to get the data from the warehouse every single time.

-- * The CTAS Solution: Using CTAS (e.g., taking 30 mins to run), you convert the Virtual Data Mart into a Physical Data Mart. Parsing a physical data mart improves the speed of data retrieval dramatically compared to using a view. The response time from a table is always much faster.

-- * Important Note (Best Practice): You have to use CTAS for performance. But the recommendation is that you start first with a view (Virtual Table). Why? Because view implementation is very dynamic, fast to set up, and you are always getting fresh data. Once performance drops, convert it to a CTAS physical table.

-- ---

-- ------------------------------------------------------------
-- 33.4 Temporary Tables (Session-Based Tables)
-- ------------------------------------------------------------

-- * Definition: Temporary tables are used to store intermediate results during a specific database session.

-- * Lifecycle: The database automatically drops (deletes) all temporary tables once the session ends (i.e., when you close your connection/client).

-- Syntax:
CREATE TEMP TABLE temp_users (          -- TEMP = TEMPORARY
    id INT PRIMARY KEY,
    name VARCHAR(100)
);

-- Or using CTAS logic:
CREATE TEMP TABLE temp_orders AS
SELECT * FROM orders WHERE order_date >= '2025-01-01';

-- PostgreSQL extra: drop automatically at the end of the transaction
CREATE TEMP TABLE temp_calc (x INT) ON COMMIT DROP;

-- * Visibility: Temporary tables are visible only within the current session. Other users/sessions cannot see them. You can even have a temp table with the exact same name as a permanent table (the temp one takes precedence in your session).

-- * Storage: In PostgreSQL a temp table lives in a private schema called `pg_temp_N` (one per session). Its pages are cached in the session's `temp_buffers` memory and written to the database's data directory when it grows. Temp tables are not written to the WAL (so they are faster, but not crash-safe or replicated). Autovacuum does not process them — run `ANALYZE temp_orders;` after loading big data so the planner has statistics.

-- * How to check if a temp table exists (PostgreSQL):
SELECT to_regclass('pg_temp.temp_users');   -- returns the name, or NULL if it does not exist

-- or in psql:
-- (psql/client command — run it in psql, not in a GUI query tool):
-- \dt pg_temp.*

--   * Unlike MySQL, PostgreSQL temp tables are visible in `information_schema.tables` (with `table_type = 'LOCAL TEMPORARY'`) for your own session.

-- > What does a session mean?
-- > The time between connecting and disconnecting from the database is called a session. 
-- > Once you open a client (like psql, pgAdmin or DBeaver), connect, and start doing queries, the session begins. When you close the client or shut down your PC, you disconnect. At that exact moment, the database goes and destroys all the temporary tables you created during that session. They live only as long as you have the session open.

-- ------------------------------------------------------------
-- 33.5 How Database Executes Temporary Tables
-- ------------------------------------------------------------

-- * Diagram summary: Shows the Database Engine linking a client session to temporary storage on disk

-- 1. Creation: When you execute `CREATE TEMP TABLE ... AS SELECT...`, the engine runs the query and gets the data from the source table.

-- 2. Storage: The engine stores the metadata in the system catalog and stores the actual physical table inside the temporary storage (TEMP partition) on the Server's disk.

-- 3. Usage: A Data Engineer or Analyst can write multiple SQL queries to analyze this temp table while the session is active.

-- 4. Automatic Cleanup: Once you close your client or disconnect (session ends), the database engine realizes the connection is gone. That means the database automatically cleans up the storage (making room for other sessions). This is how database engines work with temporary tables.

-- ------------------------------------------------------------
-- 33.6 Use Case of Temporary Tables (ETL & Intermediate Results)
-- ------------------------------------------------------------

-- * Diagram summary: Summary sheet of Tables, separating Permanent and Temporary types, defining CTAS use cases, and highlighting the auto-cleanup advantage of temp tables

-- * Diagram summary: Shows Extraction from a Source DB to an Intermediate Temp Table, Transformations like Filtering and Aggregation, Loading to a DWH, and automatic Dropping

-- * Why do we need temporary tables? In your source database, you have an `orders` table. Now you would like to load the table into your data warehouse. We have to do several transformations in order to prepare the data for analysis.

-- * You cannot run these heavy transformations directly on the source database. Of course it is not allowed! That's why in data warehousing we have to go and get our own copy of the data, and then on top of this data we can do our transformation.

-- ETL (Extract, Transform, Load) flow using Temp Tables:

--   1. Extraction (Query): You have one script in order to extract the data from the table `orders` and put it into a Temporary Table to act as an intermediate result.

--   2. Transformation (Query): You safely perform operations like Filtering, Handling Nulls, Removing Duplicates, and Aggregation on this intermediate copy without affecting live data.

--   3. Load (Query): Once transformed and clean, you load the final data into the target DWH Database Table.

--   4. Drop (Auto): The temp table handles its own cleanup. Once the ETL script finishes and the session closes, the database automatically runs the equivalent of a `DROP` query, deleting the junk intermediate data.

-- > Important Note on Debugging ETLs:
-- > While automatic cleanup is amazing, if there is something wrong with your loaded data in the Data Warehouse, you might want to check the intermediate copy (where the transformations were done) in order to debug and find the issue. If you use a temporary table, the data is gone the moment the script ends. Therefore, in scenarios where debugging is critical, developers often avoid temporary tables and just use normal permanent tables to store intermediate results.

-- ---

-- ---

-- ------------------------------------------------------------
-- 33.7 Ultimate Comparison: Subquery vs CTE vs Temp Table vs CTAS vs View
-- ------------------------------------------------------------

-- * Diagram summary: Comparison showing how a View fetches fresh data directly from the updated base table, whereas a CTAS returns old, snapshot data from the time it was physically created

-- | Feature | Subquery | CTE | Temp Table | CTAS (Permanent) | View |
-- | :--- | :--- | :--- | :--- | :--- | :--- |
-- | Storage Type | Memory / Cache | Memory / Cache | Temp Disk Storage | Physical Disk Storage | No Storage (Only Metadata) |
-- | Lifetime | Ends when Query ends | Ends when Query ends | Ends when Session ends | Permanent (Until Dropped) | Permanent (Until Dropped) |
-- | Scope (Access) | One specific Query | One specific Query | Multiple Queries (Same Session) | Global (All Users/Sessions) | Global (All Users/Sessions) |
-- | Reusability | Worst (Repeated logic) | Low (Reused in 1 query) | Medium (Reused in 1 session) | High (Reused globally) | High (Reused globally) |
-- | Data Freshness| 100% Fresh (On-the-fly) | 100% Fresh (On-the-fly)| Stale (Snapshot at creation) | Stale (Snapshot at creation) | 100% Fresh (Queries base table) |
-- | Performance | Slow for complex logic | Slow for complex logic | Fast for session analysis | Fastest (Precomputed) | Slowest (Executes every time) |

-- * ⚠️ Note: "Memory / Cache" for Subquery and CTE is simplified: in PostgreSQL they are planned together with the main query, or computed once into a work area (memory up to `work_mem`, then disk). The View "Slowest" rating means the view's query re-runs every time; a simple view is just as fast as writing the same query yourself.

-- ---

-- ------------------------------------------------------------
-- 33.8 The Big Picture of SQL (How everything connects)
-- ------------------------------------------------------------

-- * Diagram summary: Visual flow showing how Tables, Views, Subqueries, CTEs, and CTAS connect from the Database Admin level to the Data Scientist's final query

-- The Complete Story (Only for overview):

-- 1. Creation (DDL): So we have a database, and a developer or data engineer creates a new table from scratch. They are going to write a DDL (`CREATE TABLE`) statement in order to create one physical table in our database. Since the database table is empty, we move to the 2nd step.

-- 2. Insertion (DML): They go and write an `INSERT INTO VALUES` statement in order to fill our new table with data. 

-- 3. Access: Now once we have the table, we're going to give access to a Data Scientist or Data Analyst in order to start writing SQL queries.

-- 4. Subquery: The first thing that could happen is that the logic is complex, and the analyst has to do it in two steps. The first step is a query that prepares data in order to execute the 2nd step. That is why they are going to use a Subquery. The main query is going to retrieve the data from the intermediate result in order to prepare the final result for the analyst.

-- 5. CTE (Common Table Expression): Now, what could happen is that there will be SQL logic in the query that keeps repeating in the script. So instead of writing another subquery for that, she goes and puts this logic in a CTE (Temp Set). Now she is going to the main query and using the result of the CTE in multiple places in the same single script. So all those subqueries, CTE queries, and main queries happen in one single query window.

-- 6. View: And now what could happen is she is writing an amazing code that everyone can benefit from! Instead of keeping it just in her query, she is going to go and persist the logic in the database. She puts it as a VIEW in the database so all users can benefit from the logic and they don't have to write it again. Instead, they're going to go and query the view directly, making life easier. (The end user uses this view in the main query).

-- 7. CTAS (Physical Table): And one more thing: she has another piece of logic that is really complex and everyone can benefit from it, but the issue is this query is very slow. She has to decide: "Do I put it in a view, or do I create a new table based on the query using CTAS?". Because of performance (the view takes around 30 minutes to execute), she decides to execute the query using CTAS where she generates a physical table so end users can access those tables in order to reuse the result instantly.

-- 8. Conclusion: And of course, she can use the CTAS table in her main query. With that, now you have experience on how things progress. It is not just a simple query from a table; it is understanding how and why most people create Sub-queries, CTEs, Temporary Tables, and CTAS for different purposes.

-- ---

-- ------------------------------------------------------------
-- 33.9 Interview Perspective & Marathi Summary
-- ------------------------------------------------------------

-- * Pro-Tip for Interviews: Always remember the difference in Data Freshness. Views are always fresh but slow. CTAS is extremely fast but the data is stale (snapshot) and needs to be truncated/re-inserted to refresh. Temporary tables are amazing for ETL pipelines to avoid dropping intermediate tables manually.

-- ---

-- ======================================================================
-- 🎯 Practice Questions (salesdb sample data) — try first, then look at the answer
-- ======================================================================
-- Run 00-Setup-Sample-Data.sql once before this section.

SET search_path TO sales;

-- Q1. CTAS: create a monthly sales table from a query.
CREATE TABLE monthly_sales AS
SELECT EXTRACT(MONTH FROM orderdate) AS month_no, SUM(sales) AS total_sales
FROM orders
GROUP BY EXTRACT(MONTH FROM orderdate);
SELECT * FROM monthly_sales;
DROP TABLE monthly_sales;

-- Q2. Temporary table: lives only in this session.
CREATE TEMPORARY TABLE tmp_usa_customers AS
SELECT * FROM customers WHERE country = 'USA';
SELECT * FROM tmp_usa_customers;
DROP TABLE tmp_usa_customers;

-- Q3. Temporary table for cleaning data before reporting.
CREATE TEMPORARY TABLE tmp_orders AS SELECT * FROM orders;
UPDATE tmp_orders SET billaddress = NULL WHERE billaddress = '';
SELECT orderid, billaddress FROM tmp_orders;
DROP TABLE tmp_orders;
