-- ======================================================================
-- Topic 41: Database Optimization & Indexing (Analytics & Performance)
-- ======================================================================

-- ------------------------------------------------------------
-- 📖 In Simple Words
-- ------------------------------------------------------------

-- * Definition: An index is an extra sorted structure that helps the database find rows fast, like a book index, without reading the whole table. It speeds up reading but slightly slows down writing.

-- * Real-life example: The index at the back of a book: jump straight to page 214 instead of reading every page.

-- * 🧩 Syntax:
--     CREATE [UNIQUE] INDEX index_name ON table_name (col1 [, col2 ...]);
--     SHOW INDEX FROM table_name;
--     DROP INDEX index_name ON table_name;

-- * Syntax explained (each part):
--   - UNIQUE → index also blocks duplicate values
--   - (col1, col2) → composite index: order matters (leftmost column first)
--   - USING / WHERE (PostgreSQL) → index type / partial index on some rows only

-- * Example on salesdb (run 00-Setup-Sample-Data.sql first):
USE salesdb;
EXPLAIN SELECT * FROM orders WHERE orderstatus = 'Shipped';
CREATE INDEX idx_orders_status ON orders (orderstatus);
EXPLAIN SELECT * FROM orders WHERE orderstatus = 'Shipped';
DROP INDEX idx_orders_status ON orders;

-- * Example explained (step by step):
--   1. The first EXPLAIN shows a full table scan: every row is checked.
--   2. After creating the index, the plan can use idx_orders_status to jump to Shipped rows (on a tiny table the optimizer may still scan — on big tables the index wins).
--   3. The index is dropped at the end to keep the data clean.

-- ------------------------------------------------------------
-- 41.1 Introduction to Performance Optimization
-- ------------------------------------------------------------
-- English: The first and most famous way to optimize database performance is by building indexes. An index in SQL is a data structure (similar to an index in a book) that improves the speed of data retrieval operations on a database table. It acts as a guide for your database to speed up the process of searching for data, especially in large tables.

-- While indexes speed up reads, they slow down writes (INSERT, UPDATE, DELETE) because the index must be updated every time data changes.

-- * Pros: Faster `SELECT`, `WHERE`, `JOIN`, `ORDER BY`, `GROUP BY`.

-- * Without an index: MySQL scans the entire table row by row (Full Table Scan) ➔ Slow for large tables.

-- * With an index: MySQL can directly jump to the location of the data ➔ Much faster.

-- Types of Indexes in MySQL (Engines):
-- MySQL uses B-Tree or Hash indexes depending on the storage engine:

-- * InnoDB Engine (Default): Uses B+Tree indexes (balanced tree structure). Supports Clustered Indexes (The Primary Key is always the Clustered Index, and all others are Non-Clustered / Secondary).

-- * MyISAM Engine: Does not support Clustered Indexes. All indexes in MyISAM are Non-Clustered.

-- * Memory Engine: Uses Hash indexes (excellent for exact equality lookups like `WHERE id = 5`, but bad for range queries like `>`, `<`).

-- ------------------------------------------------------------
-- 41.2 Database Storage Architecture: How data is stored?
-- ------------------------------------------------------------

-- Before understanding indexes, we must understand how a database stores data on a hard drive.
-- English: Databases store data in fixed-size blocks called Pages (typically 8KB or 16KB). A table's data is split across multiple data pages inside a physical file (like `.mdf` or `.ibd`).

-- Description: Overview of a Data File containing Data Pages (actual table rows) and Index Pages (B-Tree pointers).

-- * ⚠️ Note: The 8KB page and the `.mdf` file are SQL Server. In MySQL InnoDB, the page size is 16KB by default and each table's data lives in a `.ibd` file.

-- Anatomy of a Data Page:

-- * Page Header: 96 Bytes. Stores metadata (Page ID, next/previous page pointers, free space info). (96 bytes is the SQL Server page header; InnoDB uses a 38-byte file header + 56-byte page header.)

-- * Data Rows: Actual rows inserted into the database.

-- * Free Space: Empty space for new rows.

-- * Offset Array (Row Locator): Located at the bottom. It contains pointers (memory addresses) to the exact location of each row in the page. When SQL reads a page, it uses the offset array to find rows instantly without scanning the whole page.

-- Description: Anatomy of an 8KB Data Page showing Header, Rows, Free Space, and the Offset Array.

-- ------------------------------------------------------------
-- 41.3 The HEAP Structure & Full Table Scan
-- ------------------------------------------------------------

-- What happens when a table has NO Clustered Index?
-- Such a table is called a HEAP.

-- English: In a Heap structure, data is stored in no particular order. New rows are just appended wherever there is free space.

-- * Fast Write: Because the database doesn't need to sort the data, inserts are extremely fast. (Just toss the data anywhere).

-- * Slow Read: Because data is random, finding a specific row requires scanning every single page and row. This is called a Full Table Scan.

-- * ⚠️ MySQL Note: Heap tables exist in SQL Server. In MySQL InnoDB every table is a clustered index: if you don't define a Primary Key, InnoDB uses the first `UNIQUE NOT NULL` index, or else creates a hidden 6-byte row ID and clusters on it. So an InnoDB table without a PK is not a heap, but searching it by any other column still needs a full scan.

-- Description: HEAP Structure showing randomly ordered rows across pages.

-- Description: Full Table Scan searching for ID=14. SQL must read every row across every page to find it.

-- ------------------------------------------------------------
-- 41.4 The Clustered Index (B-Tree Structure) & Reading Speed
-- ------------------------------------------------------------

-- To fix the Full Table Scan problem, SQL uses a Clustered Index, usually created automatically when you define a `PRIMARY KEY`. You can think of the clustered index like the table of contents at the front of a book, telling you exactly where to find each chapter.

-- English: A Clustered Index physically sorts the data in the table based on the indexed column (e.g., Customer ID). It uses a B-Tree (Balanced Tree) structure. In a clustered index, the leaf nodes (the bottom level of the tree) are the actual Data Pages themselves.

-- Structure of a B-Tree:

-- 1. Root Node: The starting point. It contains high-level ranges and points to Intermediate nodes.

-- 2. Intermediate Nodes: Act as signboards, narrowing down the search and pointing to the correct Leaf nodes.

-- 3. Leaf Nodes (Base Data Pages): For a Clustered Index, the leaf node is the actual data page containing your rows.

-- Detailed Execution Example (Searching for ID 14):
-- If you query `WHERE customer_id = 14`, SQL does not scan all pages. Instead, it navigates the B-Tree:

-- 1. Step 1 (Root Node): SQL checks the root node. Since 14 is between 11 and 20, it uses the 2nd pointer to jump to the intermediate index page `1:201`.

-- 2. Step 2 (Intermediate Node): SQL checks the pointers in page `1:201`. Since 14 is between 11 and 15, it uses the pointer pointing to data page `1:102`.

-- 3. Step 3 (Leaf Node): SQL locates the correct data page (`1:102`), opens it, and instantly finds customer ID 14.

-- Why is this so fast?
-- It only took 3 jumps! You might think, "Well, we still read 3 pages (Root, Intermediate, Leaf), how is this faster than a HEAP?"
-- The secret is: the B-Tree skips almost all pages. Instead of reading every page of the table, the database reads only one small page per level (Root ➔ Intermediate ➔ Leaf). Even a table with millions of rows usually has a B-Tree only 3–4 levels deep, so a lookup needs about 3–4 page reads instead of thousands. The B-Tree structure allows the database to locate the exact row without scanning irrelevant data. 

-- Description: Clustered Index B-Tree. The search for ID=14 traverses the Root (Step 1), then Intermediate (Step 2), directly landing on the correct Data Page (Step 3).

-- ------------------------------------------------------------
-- 41.5 Non-Clustered Index (Secondary Index)
-- ------------------------------------------------------------

-- If we already have a Heap or a Clustered Index, what happens when we create an index on another column (e.g., `Customer Name`)? SQL immediately builds a new, separate B-Tree structure. This is called a Non-Clustered Index (or Secondary Index).

-- * Definition: Any index that is not the Primary Key. It logically sorts the indexed column without changing the physical order of the actual table.

-- English: A Non-Clustered Index is a completely separate structure from the data pages. The B-Tree contains a sorted copy of the indexed column. However, the Leaf Nodes do not contain the full row data. Instead, they contain a pointer back to the actual data page where the rest of the row is stored.

-- What exactly is this Pointer?
-- The value of the pointer depends on the base table structure:

-- 1. If the base table is a HEAP: The pointer is a Row ID (RID). It looks like `Page Number : Row Offset` (e.g., `1:102:96`). SQL uses this RID to jump straight to the exact byte in the heap.

-- 2. If the base table has a Clustered Index: The pointer is the Primary Key (e.g., `EmpID = 1`). SQL takes this primary key and traverses the Clustered Index B-Tree to find the row.

-- The "Extra Lookup" Process (Key Lookup):
-- When you query `WHERE name = 'Vishal'`:

-- 1. MySQL scans the Non-Clustered B-Tree to find the name 'Vishal'.

-- 2. It reaches the Leaf Node and finds the pointer (e.g., `Primary Key = 1`).

-- 3. MySQL must now do one extra jump (an Extra Lookup) using the Clustered Index to find the rest of the row for `EmpID = 1`.

-- Description: Non-Clustered Index B-Tree. The leaf nodes contain pointers. SQL must perform an extra jump to fetch the full row from the physically separate Data Pages.

-- ------------------------------------------------------------
-- 41.6 Clustered vs Non-Clustered Index Summary
-- ------------------------------------------------------------

-- English: Here is a quick comparison summarizing the differences between a Clustered and Non-Clustered Index.

-- | Feature | Clustered Index (Primary Key) | Non-Clustered Index (Secondary Index) |
-- | :--- | :--- | :--- |
-- | Definition | Physically sorts and stores rows. | Separate structure with pointers to the data. |
-- | Number of Indexes | One Index per Table. | Multiple indexes are allowed. |
-- | Read Performance | Faster (data is right there). | Slower (requires an extra pointer lookup). |
-- | Write Performance | Slower, due to potential data row reordering. | Faster, since physical data order is unaffected. |
-- | Storage Efficiency | More storage-efficient. | Requires additional storage space for the B-Tree. |
-- | Use Case | Unique Column, Not frequently modified, Range queries. | Columns frequently used in search conditions and exact match queries. |

-- Syntax to Create Indexes:
-- Default is NONCLUSTERED
CREATE [CLUSTERED | NONCLUSTERED] INDEX index_name ON table_name (column1, column2, ...)

CREATE CLUSTERED INDEX IX_Customers_ID ON Customers (ID)

CREATE NONCLUSTERED INDEX IX_Customers_City ON Customers (City)

CREATE INDEX IX_Customers_Name ON Customers (LastName ASC, FirstName DESC)

-- * ⚠️ Note: `CLUSTERED` / `NONCLUSTERED` keywords are SQL Server syntax. In MySQL you cannot choose: the Primary Key is always the clustered index, and every `CREATE INDEX` makes a secondary (non-clustered) index. MySQL versions of the examples above: `CREATE INDEX IX_Customers_City ON Customers (City);` and `CREATE INDEX IX_Customers_Name ON Customers (LastName ASC, FirstName DESC);`.

-- ------------------------------------------------------------
-- 41.7 Rowstore vs Columnstore Index (Storage Architecture)
-- ------------------------------------------------------------

-- Indexes can also be categorized by how they physically store data on the disk (By Storage).

-- ------------------------------------------------------------
-- 1. Rowstore Index (The Default)
-- ------------------------------------------------------------
-- English: Organizes and stores data row by row. This is the traditional RDBMS structure. If you fetch a single row, the database pulls the entire row together.

-- * Note: By default, a table is built as a Heap structure where rows are stored row by row inside the data pages.

--   * ⚠️ This is true for SQL Server. In MySQL InnoDB, a table is always stored as a clustered index (by the Primary Key), still row by row.

-- Description: Rowstore stores complete rows in pages. Columnstore stores each column separately in its own pages.

-- ------------------------------------------------------------
-- 2. Columnstore Index (For Analytics)
-- ------------------------------------------------------------
-- English: Organizes and stores data column by column. This is highly optimized for analytical queries (OLAP) where you might need to sum up a single column (e.g., Sales) across millions of rows without reading the rest of the columns.

-- The Columnstore Creation Process:

-- Description: The three steps of creating a Columnstore index.

-- 1. #1 Row Groups: The table is first divided horizontally into Row Groups (up to 1 million rows per group).

-- 2. #2 Column Segments: Each Row Group is then divided vertically into independent Column Segments.

-- 3. #3 Compression (Dictionary): Each Column Segment is heavily compressed. For example, if a `Status` column has 'Active' and 'Inactive' repeating thousands of times, it creates a Dictionary (`'Active' -> 1`, `'Inactive' -> 2`) and stores tiny numbers instead of large strings. This saves massive amounts of space and memory.

-- ------------------------------------------------------------
-- Comparison: Rowstore vs Columnstore
-- ------------------------------------------------------------

-- | Feature | Rowstore Index | Columnstore Index |
-- | :--- | :--- | :--- |
-- | Definition | Organizes and stores data row by row | Organizes and stores data column by column |
-- | Storage Efficiency | Less efficient in storage | Highly efficient with Compression |
-- | Read/Write Optimization | Fair speed for read & write operations | Fast read performance, Slow write performance |
-- | I/O Efficiency | Lower (retrieves all columns) | Higher (retrieves specific columns) |
-- | Best for | OLTP (Transactional) commerce, banking, order processing | OLAP (Analytical) Data Warehouse, Business intelligence, Analytics |
-- | Use Case | High-frequency transaction applications, Quick access to complete records | Big Data Analytics, Scanning large datasets, Fast aggregation |

-- Columnstore Index Syntax:
-- Default is ROWSTORE
CREATE [CLUSTERED | NONCLUSTERED] [COLUMNSTORE] INDEX index_name ON table_name (column1, column2, ...)

-- Rowstore
CREATE NONCLUSTERED INDEX IX_Customers_Country ON Customers (Country)
CREATE CLUSTERED INDEX IX_Customers_ID ON Customers (ID)

-- Columnstore
CREATE NONCLUSTERED COLUMNSTORE INDEX IX_Customers_Country ON Customers (Country)
CREATE CLUSTERED COLUMNSTORE INDEX IX_Customers ON Customers ❌ -- NOT ALLOWED TO USE COLUMNS

-- Rules: You can't specify columns in Clustered Index Columnstore

-- * ⚠️ Note: Columnstore indexes are a SQL Server feature. Normal MySQL (InnoDB) has only row-store indexes; for column-store analytics, MySQL users use MySQL HeatWave or a separate analytics database (e.g. ClickHouse, Redshift, BigQuery).

-- ------------------------------------------------------------
-- 41.8 Indexing by Function (Unique, Filtered, Composite)
-- ------------------------------------------------------------

-- * Diagram summary: Shows Filtered Index syntax with WHERE condition and a flowchart on When To Use different indexes: Heap for staging, Clustered for PK/OLTP, Columnstore for OLAP, Non-Clustered for Joins/Filters

-- * Diagram summary: Compares default index syntax which allows duplicates vs unique index syntax which enforces uniqueness

-- * Definition: A Unique Index ensures that all values in a specific column are distinct (no duplicate values exist).

-- * Why it is important: 

--   * Data Integrity: Enforces uniqueness of data at the database level.

--   * Improved Performance: Slightly increases query performance as the database engine knows there's only one match.

-- * Important Note: 

--   * Writing to a unique index is slightly slower than writing to a normal (non-unique) index, because the database must first check that the value does not already exist.

--   * Reading from a unique index is faster than a non-unique index.

--   * If a duplicate exists in the column, it will prevent you from creating a unique index.

-- * Example / Syntax: 
CREATE UNIQUE INDEX idx_email ON employees(email);

-- * Definition: An index that includes only a specific subset of rows meeting a defined condition.

-- * Benefits: 

--   * Targeted Optimization: Optimizes queries for a specific subset of data.

--   * Reduced Storage: Stores less data in the index, which saves space and improves overall index maintenance performance.

-- * When to use: Use when a query frequently targets a specific category (e.g., Active employees, unpaid invoices).

-- * Syntax: 
CREATE NONCLUSTERED INDEX idx_active_users ON users(status) WHERE status = 'ACTIVE';

-- * ⚠️ Note: Filtered indexes (`CREATE INDEX ... WHERE`) exist in SQL Server (and PostgreSQL calls them partial indexes). MySQL does not support them. A common MySQL workaround is a normal index on the filter column, e.g. `CREATE INDEX idx_status ON users(status);`, or a composite index that starts with that column.

-- 3. Simple (Single-Column) Index

-- * Definition: An index created on just one column.

-- * Example: 
CREATE INDEX idx_salary ON employees(salary);

-- 4. Composite (Multi-Column) Index

-- * Definition: An index created on multiple columns.

-- * Leftmost Prefix Rule: The index works only if your query filters start from the first column in the index and follow its exact order.

--   * If the index is `(col1, col2, col3)`, it works for: `col1` | `col1, col2` | `col1, col2, col3`.

--   * It will NOT work for only `col2` without `col1`. Always start with the leftmost column!

--   * Clarification: The order in which you write the conditions inside `WHERE` does not matter (`WHERE col2 = 5 AND col1 = 3` still uses the index); what matters is that the leftmost index columns are used. MySQL 8.0.13+ can sometimes use an "index skip scan" when `col1` is missing, but you should not depend on it.

-- * Example: 
CREATE INDEX idx_name_salary ON employees(name, salary);

-- 5. Full-Text Index

-- * Definition: Used for searching text efficiently within large text columns. Allows usage of `MATCH() AGAINST()` functions.

-- * Example: 
CREATE FULLTEXT INDEX idx_desc ON products(description);

-- 6. Spatial Index

-- * Definition: Used for geometry or GIS (Geographic Information System) data. (MySQL supports SPATIAL indexes with MyISAM and InnoDB since 5.7).

-- * Example: 
CREATE SPATIAL INDEX idx_location ON places(location);

-- ------------------------------------------------------------
-- Summary of Index Types: When & How to Use
-- ------------------------------------------------------------

-- * Diagram summary: A visual summary of index types, showing when to use them and what their primary purpose is

-- | Index Type | When To Use (Scenario) | How It Helps |
-- | :--- | :--- | :--- |
-- | Clustered Index | For Primary Keys and ranges. | Sorts physical data. (1 per table). |
-- | Non-Clustered | For Foreign keys, WHERE filters, Joins. | Creates secondary pointers. (Many allowed). |
-- | Unique Index | When a column must not have duplicates. | Enforces data integrity & speeds up exact matches. |
-- | Filtered Index | When querying a specific subset (e.g., Active only). | Reduces index size & increases speed. |
-- | Composite Index | When queries filter by multiple columns often. | Avoids multiple index lookups (respects Leftmost Rule). |
-- | Columnstore Index| When aggregating massive data (Data Warehouse).| Reads specific columns efficiently (OLAP). |
-- | Full-Text Index | When searching for words inside large text/articles. | Enables fast keyword searches (`MATCH AGAINST`). |
-- | Spatial Index | When dealing with maps, GPS, geometry. | Fast spatial queries on polygon/point data. |

-- ------------------------------------------------------------
-- 41.9 Indexing Best Practices in MySQL
-- ------------------------------------------------------------

-- * Do Use Indexes For:

--   * Columns frequently used in `WHERE`, `JOIN`, `ORDER BY`, and `GROUP BY` clauses.

--   * Frequently searched columns.

--   * Foreign keys (MySQL automatically indexes foreign keys).

-- * Avoid Indexing (Do Not Use For):

--   * Avoid Over-Indexing: Indexing slows down write performance. When data is inserted, updated, or deleted, the database has to update the indexes.

--   * Columns with low selectivity (e.g., `Gender` with only 'M'/'F' values).

--   * Very small tables (indexes have overhead and don't help much).

--   * Columns that are updated frequently (high index maintenance overhead).

-- * Useful Commands:

--   * See existing indexes: `SHOW INDEX FROM employees;`

--   * Check if a query uses an index: `EXPLAIN SELECT * FROM employees WHERE name = 'Vishal';`

-- ------------------------------------------------------------
-- 41.10 Advantages & Disadvantages of Indexes
-- ------------------------------------------------------------

-- * Advantages:

--   * Faster `SELECT` queries (Reading).

--   * Efficient `JOIN` operations.

--   * Enforces uniqueness (via `PRIMARY` / `UNIQUE` constraints).

--   * Helps with faster sorting (`ORDER BY`) and grouping (`GROUP BY`).

--   * Summary: Indexes in MySQL = Speed for reads.

-- * Disadvantages:

--   * Requires extra disk space.

--   * Slower writes (`INSERT`, `UPDATE`, `DELETE`).

--   * Poorly chosen or over-indexed tables can severely hurt performance.

--   * Summary: Indexes in MySQL = Cost for writes.

-- ------------------------------------------------------------
-- 41.11 Index Management & Monitoring
-- ------------------------------------------------------------

-- * Definition: Building an index is not the final step. Over time, indexes get fragmented, outdated, and unused. This can lead to poor query performance, increased storage costs, and a drop in overall database speed.

-- * Key Maintenance Steps:

--   1. Monitor Index Usage: Identify if the created indexes are actually being used by queries. Unused indexes consume unnecessary storage and slow down writes.

--   2. Monitor Missing Indexes: Find queries that are slow because an index is missing.

--   3. Monitor Duplicate Indexes: Remove redundant indexes that cover the same columns.

--   4. Update Statistics: The Query Optimizer relies on statistics to choose the best index. Keep them updated.

--   5. Monitor Fragmentation: As data is added or deleted, indexes become fragmented (scattered). Rebuild or reorganize them to maintain speed.

-- ------------------------------------------------------------
-- 41.12 Indexing Strategies
-- ------------------------------------------------------------

-- * Diagram summary: 4-step Indexing Strategy flowchart: 1. Initial Strategy (OLAP vs OLTP), 2. Usage Patterns Indexing, 3. Scenario-Based Indexing, 4. Monitoring & Maintenance

-- * Point-Wise Explanation:

--   1. Initial Indexing Strategy (OLAP vs OLTP):

--      * OLAP (Analytical): Goal is to optimize READ performance (e.g., Data Warehouses). Switch large frequently used tables to ColumnStore Index.

--      * OLTP (Transactional): Goal is to optimize WRITE performance (e.g., Apps, Web). Use Clustered Index for Primary Keys.

--   2. Usage Patterns Indexing:

--      * Identify frequently used tables & columns.

--      * Choose the right index (Unique, Composite, Filtered).

--      * Test the index performance.

--   3. Scenario-Based Indexing:

--      * Identify slow queries using logs.

--      * Check the execution plan using `EXPLAIN`.

--      * Choose the right index and compare the execution plans before and after.

--   4. Monitoring & Maintenance:

--      * Continuously monitor usage, missing indexes, duplicates, statistics, and fragmentation.

-- ------------------------------------------------------------
-- 41.13 Full-Text Search (FULLTEXT Index, MATCH ... AGAINST)
-- ------------------------------------------------------------

-- * `LIKE '%word%'` cannot use a normal B-Tree index (leading `%`), so it scans the whole table and has no relevance ranking. A FULLTEXT index splits text into words (an inverted index: word → rows) for fast word search.
CREATE TABLE articles (
    id    INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(200),
    body  TEXT,
    FULLTEXT INDEX ft_title_body (title, body)
);

INSERT INTO articles (title, body) VALUES
('MySQL Indexing Guide', 'Learn how B-Tree indexes speed up MySQL queries'),
('Joins Explained', 'INNER JOIN and LEFT JOIN with examples'),
('MySQL Transactions', 'COMMIT, ROLLBACK and isolation levels in MySQL');

-- * 1. Natural language mode (default) — ranked by relevance:
SELECT id, title, MATCH(title, body) AGAINST ('mysql indexes') AS score
FROM articles
WHERE MATCH(title, body) AGAINST ('mysql indexes')
ORDER BY score DESC;

--   * The article that has both words ranks first. On a very small table, words that appear in 50% or more of the rows get little or no weight, so test on realistic data.

-- * 2. Boolean mode — operators:
SELECT title FROM articles
WHERE MATCH(title, body) AGAINST ('+mysql -join' IN BOOLEAN MODE);   -- must have mysql, must not have join

SELECT title FROM articles
WHERE MATCH(title, body) AGAINST ('trans*' IN BOOLEAN MODE);         -- prefix: transaction, transactions

SELECT title FROM articles
WHERE MATCH(title, body) AGAINST ('"isolation levels"' IN BOOLEAN MODE);  -- exact phrase

-- * 3. Query expansion: `AGAINST ('database' WITH QUERY EXPANSION)` runs the search twice and adds related words found in the best results (it can return loosely related rows).

-- * Rules and limits (InnoDB):

--   * The `MATCH()` column list must be exactly the columns of one FULLTEXT index.

--   * Minimum word length is `innodb_ft_min_token_size = 3` (shorter words are ignored), and stopwords like "the" and "and" are ignored.

--   * For Marathi/Hindi or Chinese/Japanese text, use `WITH PARSER ngram` when creating the index.

--   * For very large search needs (typo tolerance, facets, synonyms) teams use Elasticsearch or OpenSearch.

-- ------------------------------------------------------------
-- 41.14 Pagination: LIMIT OFFSET vs Keyset (Seek) Pagination
-- ------------------------------------------------------------

-- * OFFSET pagination (common but slow on deep pages):
-- page 1
SELECT order_id, order_date, amount FROM orders ORDER BY order_id LIMIT 20 OFFSET 0;
-- page 5001
SELECT order_id, order_date, amount FROM orders ORDER BY order_id LIMIT 20 OFFSET 100000;

--   * MySQL must read and throw away 100,000 rows to return 20, so every next page gets slower.

--   * If rows are inserted or deleted between page loads, rows shift: users see duplicates or miss rows.

-- * Keyset (seek) pagination — remember the last key of the previous page:
-- page 1
SELECT order_id, order_date, amount FROM orders
ORDER BY order_id
LIMIT 20;
-- the last order_id on page 1 was 1020

-- next page: jump straight to it through the index
SELECT order_id, order_date, amount FROM orders
WHERE order_id > 1020
ORDER BY order_id
LIMIT 20;

--   * With an index on `order_id`, this is an index range scan that reads only 20 rows, so page 1 and page 5001 are equally fast.

-- * Sorting by a non-unique column (e.g. newest first): add a unique tie-breaker and use a row comparison:
CREATE INDEX idx_date_id ON orders (order_date, order_id);

-- last row on the previous page: order_date = '2026-09-28', order_id = 5531
SELECT order_id, order_date, amount FROM orders
WHERE (order_date, order_id) < ('2026-09-28', 5531)
ORDER BY order_date DESC, order_id DESC
LIMIT 20;

--   * If the optimizer doesn't use the index for the row comparison, write it out: `WHERE order_date < '2026-09-28' OR (order_date = '2026-09-28' AND order_id < 5531)`.

-- | Point | LIMIT OFFSET | Keyset (seek) |
-- | :--- | :--- | :--- |
-- | Deep page speed | Slower and slower (reads offset + limit rows) | Constant (reads only limit rows) |
-- | Jump to page N | ✅ Easy | ❌ Only next / previous |
-- | Rows added/deleted meanwhile | Duplicates or missed rows | Stable |
-- | Best for | Small tables, admin pages with page numbers | Infinite scroll, APIs ("load more"), big tables |

-- * If you must keep OFFSET — "deferred join": page through the small index first, then fetch the full rows:
SELECT o.order_id, o.order_date, o.amount
FROM orders o
JOIN (SELECT order_id FROM orders ORDER BY order_id LIMIT 20 OFFSET 100000) AS p
     ON o.order_id = p.order_id
ORDER BY o.order_id;

-- >

-- ------------------------------------------------------------
-- 41.15 Interview Perspective (Pro-Tips)
-- ------------------------------------------------------------

-- * Q: Why not put an index on every column?

--   * A: Avoid over-indexing! Indexes require disk space. More importantly, every `INSERT`, `UPDATE`, or `DELETE` requires the database to update the index. Too many indexes will kill write performance.

-- * **Q: What is an Execution Plan (`EXPLAIN`)?**

--   * A: You can write `EXPLAIN SELECT ...` in MySQL to see if the database is using your index (Index Seek) or doing a Full Table Scan.

-- * Q: Heap vs Clustered vs Non-Clustered Index?

--   * A: A Heap is a table without a primary key (reads are full scans). A Clustered Index stores data in physical sorted order (only 1 allowed). Non-Clustered Indexes are secondary pointers (many allowed). Choose wisely → help reads, hurt writes.

--   * MySQL tip for the interview: InnoDB has no heap tables — without a PK it creates a hidden clustered key — so always define a small Primary Key (e.g. `INT AUTO_INCREMENT`).

-- ---

-- ======================================================================
-- 🎯 Practice Questions (salesdb sample data) — try first, then look at the answer
-- ======================================================================
-- Run 00-Setup-Sample-Data.sql once before this section.

USE salesdb;

-- Q1. Create an index for a frequent filter and check the plan.
CREATE INDEX idx_orders_status ON orders (orderstatus);
EXPLAIN SELECT * FROM orders WHERE orderstatus = 'Shipped';

-- Q2. Composite index for customer + date queries.
CREATE INDEX idx_orders_cust_date ON orders (customerid, orderdate);
EXPLAIN SELECT * FROM orders WHERE customerid = 1 AND orderdate >= '2025-01-15';

-- Q3. List indexes, then drop the practice indexes.
SHOW INDEX FROM orders;
DROP INDEX idx_orders_status ON orders;
DROP INDEX idx_orders_cust_date ON orders;
