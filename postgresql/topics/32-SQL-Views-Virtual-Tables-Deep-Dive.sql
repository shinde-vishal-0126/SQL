-- ======================================================================
-- Topic 32: SQL Views (Virtual Tables) Deep Dive
-- ======================================================================

-- ------------------------------------------------------------
-- 📖 In Simple Words
-- ------------------------------------------------------------

-- * Definition: A view is a saved SELECT query that you can use like a table. It stores no data itself; it reads from the real tables every time.

-- * Real-life example: A window in a wall — you see the garden (real tables) through it, but the window holds no plants.

-- * 🧩 Syntax:
--     CREATE [OR REPLACE] VIEW view_name AS
--     SELECT ...;
--     SELECT * FROM view_name;
--     CREATE MATERIALIZED VIEW mv_name AS SELECT ...;
--     REFRESH MATERIALIZED VIEW mv_name;
--     DROP VIEW [IF EXISTS] view_name;

-- * Syntax explained (each part):
--   - CREATE VIEW … AS SELECT → save a query under a name
--   - OR REPLACE → overwrite an existing view
--   - Use → query it exactly like a table
--   - DROP VIEW → removes only the saved query, not the table data

-- * Example on salesdb (run 00-Setup-Sample-Data.sql first):
SET search_path TO sales;
CREATE VIEW v_customer_orders AS
SELECT c.firstname, o.orderid, o.sales
FROM customers c JOIN orders o ON o.customerid = c.customerid;
SELECT * FROM v_customer_orders WHERE firstname = 'Kevin';
DROP VIEW v_customer_orders;

-- * Example explained (step by step):
--   1. CREATE VIEW saves the join query under the name v_customer_orders.
--   2. Now anyone can query it like a simple table, without writing the join.
--   3. Result for Kevin: orders 1, 5, 9. DROP VIEW removes only the saved query, not the data.

-- ------------------------------------------------------------
-- 32.1 What is a View?
-- ------------------------------------------------------------

-- * Diagram summary: Shows the flow of execution and the differences between Physical Tables and Views

-- * Definition: A View is a database object that acts like a Virtual Table. It is based on the result set of an SQL query.

-- * Types of Views:

--   1. Simple View: Based on only one table, contains no functions or joins.

--   2. Complex View: Based on multiple tables, uses joins, `GROUP BY`, aggregate functions, etc.

-- * No Persistence: A View does not store any data physically (by default). It only stores the SQL query structure (metadata) in the database system catalog.

-- * Execution Flow (How it works behind the scenes):

--   1. Real data is stored inside physical database tables.

--   2. The View acts as an Abstraction Layer between the user and the real data.

--   3. When a user queries a view (`SELECT * FROM my_view`), SQL retrieves the query attached to the view from the catalog.

--   4. The View's query then executes against the physical table, fills the virtual structure with results, and returns it to the user.
--   (You are directly querying the view, but indirectly querying the physical table).

-- ------------------------------------------------------------
-- 32.2 Differences Between Table and View
-- ------------------------------------------------------------

-- | Feature | Physical Table | Virtual Table (View) |
-- | :--- | :--- | :--- |
-- | Storage | Persists actual data physically on disk. | No persistence. Stores only the SQL query logic. |
-- | Maintenance & Flexibility | Hard to maintain/change. Modifying large tables (adding/moving columns) takes huge effort. | Easy to maintain & flexible. You just update the underlying query without touching physical data. |
-- | Performance | Fast Response. (1 Query execution). | Slow Response. (2 Queries execute: User's query + View's query). |
-- | Operations | Read and Write. | Mostly Read-Only (some exceptions apply for simple views). |

-- > Does a View improve performance?
-- > No. By themselves, views do NOT automatically improve performance. A view is just a saved SELECT query. Executing it 100 times executes the base query 100 times. No extra indexes are created just because it’s a view.

-- * ⚠️ Note on "2 queries": The "Slow Response (2 Queries)" point is a simplified picture. In PostgreSQL a view is stored as a rewrite rule; the planner replaces the view name with its query and plans everything as one combined query (filters are pushed down into the view). A view is slow only when its own query is heavy (big joins, `GROUP BY`), because that work is repeated every time. For that case PostgreSQL offers materialized views (32.8).

-- ------------------------------------------------------------
-- 32.3 Why Do We Need Views? (6 Major Use Cases)
-- ------------------------------------------------------------

-- * Diagram summary: Shows data flowing from Source Systems to a Physical Data Warehouse, then abstracted into Virtual Data Marts for Reporting

-- * Diagram summary: Shows one base table connected to multiple views, each translated for a specific region's users

-- * Diagram summary: Shows how changing a physical table breaks queries, but a view absorbs the impact

-- * Diagram summary: Demonstrates how Manager, Data Analyst, and Student get different views with column/row level security

-- * Diagram summary: Shows how multiple complex tables are joined and abstracted into one simple view for the user

-- * Diagram summary: Shows 3 analysts writing redundant CTEs vs using a central View

-- 1. Central Query Logic (Reusability & Reducing Redundancy)

-- * Scenario without View (CTE Issue): If 3 analysts need to rank, get min/max, or compare sales, they all write the same `SUM` & `JOIN` logic in their own CTEs. This is redundant and wastes time.

-- * Solution: Create a View for the `SUM` & `JOIN` logic. Now, it is centralized in the database. All analysts just `SELECT` from the view and apply their specific `RANK` or `MIN/MAX` logic.

-- 2. Hide Complexity (Abstraction)

-- * Large databases have complex, cryptic table names and relationships. Asking an end-user to do 5 `JOIN`s just to get customer details is a nightmare.

-- * Solution: A developer creates a View that pre-joins all tables into one clean, friendly virtual table.

-- 3. Data Security (Column & Row-Level Protection)

-- * Column-Level Security: A table has a sensitive `salary` column. You create a view that selects everything except the salary column, and give data analysts access only to the view.

-- * Row-Level Security: You want the EU Sales team to only see EU data. You create a view with `WHERE Country != 'USA'`. They can never access USA data.

--   * Tip: `Country != 'USA'` shows every non-USA row (including Asia). To show only EU rows, filter on the EU list, e.g. `WHERE region = 'EU'` or `WHERE Country IN ('Germany', 'France', 'Italy')`.

-- 4. Flexibility and Dynamic Changes

-- * If you rename a physical table column or split a table, 100 users' queries will break.

-- * Solution: Instead, users query the View. If you rename the physical column, you just update the View's query to alias it back. Users won't notice a thing!

-- 5. Multiple Languages Support

-- 6. Virtual Data Marts (DWH)

-- * Used in Data Warehousing to provide flexible, efficient presentation layers (Data Marts). Instead of creating physical tables for every mart, you create Virtual Data Marts using views, which connect directly to BI Tools/Reporting Dashboards.

-- ------------------------------------------------------------
-- 32.4 View vs CTE
-- ------------------------------------------------------------

-- * Diagram summary: Comparison chart showing Redundancy, Reusability, Persistence, and Maintenance differences

-- | Feature | View | CTE (Common Table Expression) |
-- | :--- | :--- | :--- |
-- | Purpose | Reduces redundancy across Multiple Queries / Entire Project. | Reduces redundancy within One Single Query. |
-- | Persistence | Logic is saved permanently in the database as an object. | Logic is temporary, calculated on the fly, and destroyed when query ends. |
-- | Maintenance | Requires manual maintenance (`CREATE`, `ALTER`, `DROP`). | No maintenance. Cleaned up automatically. |

-- ------------------------------------------------------------
-- 32.5 Syntax & Schema Naming
-- ------------------------------------------------------------

-- * Diagram summary: Basic DDL syntax showing CREATE VIEW view-name AS query

-- * Create View:
CREATE VIEW view_name AS
SELECT column1, column2 FROM table_name WHERE condition;

-- * Schema Qualification: If you don't specify a schema, it goes to the first schema in `search_path` (normally `public` in PostgreSQL; `dbo` in SQL Server). To place it in a specific schema: `CREATE VIEW sales.v_total_sales AS (...)`

--   * 🐘 PostgreSQL Note: `sales.v_total_sales` means "schema `sales`, view `v_total_sales`" inside the current database. (In MySQL the same text would mean database `sales`.)

-- * Drop View: `DROP VIEW view_name;`

-- ------------------------------------------------------------
-- 32.6 Modifying/Updating Views (`CREATE OR REPLACE` vs `ALTER VIEW`)
-- ------------------------------------------------------------

-- 1. `CREATE OR REPLACE VIEW` (Best & Most Common in PostgreSQL)

-- * Replaces the existing view definition automatically without dropping it first. Keeps existing permissions safe. Works even if the view doesn't exist yet.

-- 2. `ALTER VIEW` (in PostgreSQL only for properties, not the query)

-- * In SQL Server/MySQL, `ALTER VIEW` replaces the query. In PostgreSQL, `ALTER VIEW` cannot change the query — it only renames the view or a column, changes the owner/schema, or sets options. Use `CREATE OR REPLACE VIEW` to change the query.

-- 3. Drop & Recreate (Two-step method)

-- * `DROP VIEW IF EXISTS...` then `CREATE VIEW...`. Warning: Loses permissions assigned to the view.

-- Rules for Modifying a View:

-- * Allowed: Add new columns (they must be added at the end), remove columns, change/add joins, modify `WHERE`, `GROUP BY`, `ORDER BY`.

-- * Not Allowed: You cannot change the order of existing columns, you cannot insert a new column in the middle, and you cannot change underlying data types without breaking dependencies.

--   * 🐘 These rules are exactly PostgreSQL's rules for `CREATE OR REPLACE VIEW`: the new query must return the same columns with the same names and types in the same order; you may only add new columns at the end. Removing or reordering a column gives an error like `cannot drop columns from view`. In that case use `DROP VIEW v; CREATE VIEW v ...` (inside one transaction) — and re-grant permissions. (MySQL lets you change anything.)

-- * Note: If you add a new column to the underlying physical table, the view won't show it automatically — even a view written as `SELECT *` stores the column list from creation time. You must use `CREATE OR REPLACE VIEW` to refresh it.

-- * PostgreSQL also protects views: you cannot `DROP` a table or column that a view uses (error `cannot drop table ... because other objects depend on it`) unless you add `CASCADE`, which drops the view too.

-- Renaming Columns and Views:

-- * Rename a Column in a View (PostgreSQL): `ALTER VIEW view_name RENAME COLUMN old_col TO new_col;` (This does NOT affect the base table, only the view).

-- * Rename the View Itself (PostgreSQL): `ALTER VIEW old_view_name RENAME TO new_view_name;`

-- * Both commands above work directly in PostgreSQL. (MySQL does not support them — there you re-create the view with a new alias and use `RENAME TABLE` for the view name.)

-- ------------------------------------------------------------
-- 32.7 Updatable Views (Insert / Update / Delete through a View)
-- ------------------------------------------------------------
-- Normally views are read-only, but you can update the base table through a view only if the view meets strict criteria:

-- 1. It must reference only one base table (No Joins).

-- 2. Cannot contain `GROUP BY`, `HAVING`, `DISTINCT`, Aggregate functions (`SUM`, `COUNT`), Window functions, or `WITH` (CTE) clauses.

-- 3. Must include primary keys/NOT NULL columns of the base table for inserts (or those columns must have defaults).

-- * 🐘 PostgreSQL: simple views like this are automatically updatable (since PostgreSQL 9.3). For complex views (joins, aggregates) you can still make them writable with an `INSTEAD OF` trigger (Topic 37).

-- WITH CHECK OPTION:

-- * A security feature for updatable views. It ensures that any `INSERT` or `UPDATE` through the view satisfies the view's `WHERE` condition.

-- * Example: View filters `WHERE salary > 5000 WITH CHECK OPTION;`. If you try to update a salary to `4000` via the view, it will fail because the new row wouldn't be visible in the view anymore.

-- ------------------------------------------------------------
-- 32.8 Materialized Views (Performance Booster)
-- ------------------------------------------------------------

-- * What is it? A normal view just stores the query. A Materialized View (MV) stores the query AND physically stores the precomputed data (snapshot) on the disk.

-- * Why do we need it? For complex joins and aggregations (Data Warehousing/Dashboards) that take too long to compute every time. Querying an MV is instant because data is precomputed.

-- * Indexes: Because data is physically stored, you can add Indexes to an MV (unlike normal views).

-- * Refresh Strategies: Because data is stored, it gets stale. You must refresh it:

--   1. ON DEMAND (Manual): `REFRESH MATERIALIZED VIEW view_name;`

--   2. SCHEDULED: Auto-refreshes daily/hourly.

--   3. ON COMMIT: Refreshes immediately when base table changes.

-- * 🐘 PostgreSQL supports Materialized Views natively (MySQL does not):
-- 1. Create: runs the query once and stores the result on disk
CREATE MATERIALIZED VIEW mv_monthly_sales AS
SELECT DATE_TRUNC('month', order_date) AS month, SUM(sales) AS total_sales
FROM orders
GROUP BY DATE_TRUNC('month', order_date);

-- 2. Index it like a table
CREATE UNIQUE INDEX idx_mv_month ON mv_monthly_sales (month);

-- 3. Read it (instant)
SELECT * FROM mv_monthly_sales ORDER BY month;

-- 4. Refresh when the base data changes (locks readers while refreshing)
REFRESH MATERIALIZED VIEW mv_monthly_sales;

-- 5. Refresh without blocking readers (needs a UNIQUE index)
REFRESH MATERIALIZED VIEW CONCURRENTLY mv_monthly_sales;

-- * PostgreSQL refresh options: only ON DEMAND (`REFRESH`). There is no built-in ON COMMIT refresh. For scheduled refresh use `pg_cron` (Topic 38) or an external scheduler; for near real-time use triggers on the base tables.

-- ------------------------------------------------------------
-- 32.9 Index vs View vs Materialized View
-- ------------------------------------------------------------
-- | Feature | Index | View | Materialized View |
-- | :--- | :--- | :--- | :--- |
-- | Purpose | Fast Search (Lookups) | Query Shortcut / Security | Precomputed Result for Speed |
-- | Data Storage | Stores a lookup structure (B-Tree). | No data storage (Virtual). | Stores actual precomputed query results. |
-- | Data Freshness| Auto-updates instantly. | Always 100% fresh (queries base table). | Stale until Refreshed (Manual/Auto). |

-- ---

-- ------------------------------------------------------------
-- 32.10 How Database Executes a View
-- ------------------------------------------------------------

-- * Diagram summary: Shows the DB Engine interacting with the Catalog (Disk) to fetch the View's query, and then executing it against the Physical Table

-- Step-by-Step Execution Flow:

-- 1. Creation: When a Data Engineer creates a view (`CREATE VIEW TOPN AS...`), the database engine does not store any actual data. It stores the metadata and the SQL statement inside the System Catalog (Disk).

-- 2. Querying: A Data Analyst executes a query against the view (`SELECT * FROM TOPN`).

-- 3. Execution Query 1 (Metadata Lookup): The database engine realizes it's a view, not a table. It goes to the System Catalog, retrieves the stored SQL query attached to that view, and prepares it.

-- 4. Execution Query 2 (Physical Table): The database engine then executes that retrieved query against the actual underlying Physical Table (e.g., `ORDERS`), fetches the physical data, and returns the result back to the analyst.

-- * Conclusion: Querying a view always results in executing two steps/queries internally (fetching the definition from the catalog + querying the base table).

--   * ⚠️ Clarification: Step 1 (reading the definition from the catalog, `pg_rewrite`) is very cheap. PostgreSQL's rewriter then merges the view query with your query and runs one query against the base table, not two full queries. See the stored query with `SELECT pg_get_viewdef('topn');` or `\d+ topn`.

-- ------------------------------------------------------------
-- 32.11 Summary of SQL Views
-- ------------------------------------------------------------

-- * Diagram summary: A quick cheat-sheet summarizing that a View is a virtual table used to persist complex logic, better than CTEs for reusability, and outlining the 6 core use cases

-- ---

-- ------------------------------------------------------------
-- 32.12 Interview Perspective & Marathi Summary
-- ------------------------------------------------------------

-- * What is a View?: A view is not a real table; it stores no data. It is only a saved query.
--   * Ex: When you run SELECT * FROM view, the database runs the view's query on the physical tables and shows you the result.

-- * Benefits (6 Use Cases):
--   1. Security: hide sensitive columns (e.g. employee salary) — create a view without that column and give users access only to the view (column-level security).
--   2. Central Logic: a complex JOIN / SUM query that the whole team keeps writing is saved once as a view and reused everywhere (unlike a CTE, which must be rewritten in every query).
--   3. Flexibility: if the real table is renamed or changed, users' code does not break because they query the view.
--   4. Hide Complexity: join many tables into one simple view.
--   5. Multiple Languages: a view with column names in the users' own language.
--   6. Virtual Data Marts: reporting tables in a data warehouse without using extra storage.

-- * How the database runs a view:
--   - On CREATE VIEW the database stores only the query in its catalog, not the data.
--   - On SELECT * FROM view it reads the query from the catalog (Query 1) and runs it on the physical tables (Query 2); in practice the optimizer merges both into one query.

-- * View vs Materialized View: a view is recalculated on every run (slower); a materialized view stores the result on disk (faster, but must be refreshed with REFRESH MATERIALIZED VIEW). PostgreSQL has materialized views (MySQL does not).

-- Example (salesdb — run 00-Setup-Sample-Data.sql first):
SET search_path TO sales;

-- Security: employees without salary / birthdate
CREATE OR REPLACE VIEW v_employees_public AS
SELECT employeeid, firstname, lastname, department
FROM employees;

-- Central logic: total sales per customer
CREATE OR REPLACE VIEW v_customer_sales AS
SELECT c.customerid, c.firstname, c.country, SUM(o.sales) AS total_sales
FROM customers c
JOIN orders o ON o.customerid = c.customerid
GROUP BY c.customerid, c.firstname, c.country;

SELECT * FROM v_employees_public;
SELECT * FROM v_customer_sales ORDER BY total_sales DESC;

SELECT pg_get_viewdef('v_customer_sales', true);   -- the stored query (catalog)

-- Materialized view: result stored on disk, refresh to update
CREATE MATERIALIZED VIEW mv_customer_sales AS SELECT * FROM v_customer_sales;
SELECT * FROM mv_customer_sales;
REFRESH MATERIALIZED VIEW mv_customer_sales;

DROP MATERIALIZED VIEW mv_customer_sales;
DROP VIEW v_employees_public;
DROP VIEW v_customer_sales;

-- ---

-- ======================================================================
-- 🎯 Practice Questions (salesdb sample data) — try first, then look at the answer
-- ======================================================================
-- Run 00-Setup-Sample-Data.sql once before this section.

SET search_path TO sales;

-- Q1. Create a view of delivered orders and query it.
CREATE VIEW v_delivered_orders AS
SELECT orderid, customerid, sales FROM orders WHERE orderstatus = 'Delivered';
SELECT * FROM v_delivered_orders;

-- Q2. Change the view to also show the product name.
DROP VIEW v_delivered_orders;     -- Postgres: OR REPLACE cannot insert a column in the middle
CREATE VIEW v_delivered_orders AS
SELECT o.orderid, o.customerid, p.product, o.sales
FROM orders o JOIN products p ON p.productid = o.productid
WHERE o.orderstatus = 'Delivered';
SELECT * FROM v_delivered_orders;

-- Q3. Drop the view.
DROP VIEW v_delivered_orders;
