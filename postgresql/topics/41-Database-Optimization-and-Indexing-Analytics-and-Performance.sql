-- ======================================================================
-- Topic 41: Database Optimization & Indexing (Analytics & Performance)
-- ======================================================================

-- ------------------------------------------------------------
-- 📖 In Simple Words
-- ------------------------------------------------------------

-- * Definition: An index is an extra sorted structure that helps the database find rows fast, like a book index, without reading the whole table. It speeds up reading but slightly slows down writing.

-- * Real-life example: The index at the back of a book: jump straight to page 214 instead of reading every page.

-- * Example on salesdb (run 00-Setup-Sample-Data.sql first):
SET search_path TO sales;
EXPLAIN SELECT * FROM orders WHERE orderstatus = 'Shipped';
CREATE INDEX idx_orders_status ON orders (orderstatus);
EXPLAIN SELECT * FROM orders WHERE orderstatus = 'Shipped';
DROP INDEX idx_orders_status;

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

-- * Without an index: PostgreSQL reads the entire table page by page (Sequential Scan, "Seq Scan") ➔ Slow for large tables.

-- * With an index: PostgreSQL can directly jump to the location of the data (Index Scan) ➔ Much faster.

-- Types of Indexes in PostgreSQL (Access Methods):
-- PostgreSQL has one storage engine, but several index types (MySQL has mostly B-Tree):

-- * B-Tree (default): For `=`, `<`, `>`, `BETWEEN`, `ORDER BY`, `LIKE 'abc%'`. Used for 95% of indexes.

-- * Hash: Only `=` lookups (crash-safe since PostgreSQL 10). Rarely better than B-Tree.

-- * GIN (Generalized Inverted Index): For values that contain many items — `JSONB`, arrays, full-text search (`tsvector`), trigram search (`pg_trgm`).

-- * GiST / SP-GiST: For geometric / PostGIS data, ranges, nearest-neighbour search, `EXCLUDE` constraints.

-- * BRIN (Block Range Index): Tiny index for huge tables where values follow the physical order (e.g., `created_at` in an append-only log table).

-- * 🐘 Big difference from MySQL InnoDB: PostgreSQL has NO clustered index. Every table is a heap, and every index (including the primary key) is a separate structure pointing to the row's physical location (see 41.3–41.6).

-- ------------------------------------------------------------
-- 41.2 Database Storage Architecture: How data is stored?
-- ------------------------------------------------------------

-- Before understanding indexes, we must understand how a database stores data on a hard drive.
-- English: Databases store data in fixed-size blocks called Pages (PostgreSQL: 8KB; MySQL InnoDB: 16KB). A table's data is split across multiple data pages inside physical files. In PostgreSQL each table (and each index) is a file named by a number under `PGDATA/base/<database_oid>/` (split into 1 GB segments).

-- Description: Overview of a Data File containing Data Pages (actual table rows) and Index Pages (B-Tree pointers).

-- * Find the file of a table: `SELECT pg_relation_filepath('customers');` → e.g. `base/16384/24576`.

-- Anatomy of a PostgreSQL Data Page (8KB):

-- * Page Header: 24 Bytes. Stores metadata (LSN of the last WAL change, free space pointers, checksum). (SQL Server: 96 bytes.)

-- * Item Pointers (Line Pointer Array): Right after the header — a small array; each entry points to one row (tuple) in the page. A row's address is `(page number, item number)`, called the CTID, e.g. `(0,3)`.

-- * Free Space: Empty space in the middle; item pointers grow down from the top, rows grow up from the bottom.

-- * Tuples (Data Rows): Actual rows, stored from the end of the page backwards. Each tuple has a 23-byte header with `xmin`, `xmax` (MVCC, Topic 19).

-- * See it yourself: `SELECT ctid, * FROM customers LIMIT 5;`

-- Description: Anatomy of an 8KB Data Page showing Header, Rows, Free Space, and the row pointer array.

-- ------------------------------------------------------------
-- 41.3 The HEAP Structure & Full Table Scan
-- ------------------------------------------------------------

-- What happens when a table has NO Clustered Index?
-- Such a table is called a HEAP. 🐘 In PostgreSQL, EVERY table is a heap.

-- English: In a Heap structure, data is stored in no particular order. New rows are just put wherever there is free space (and an `UPDATE` writes a new row version, often in another place).

-- * Fast Write: Because the database doesn't need to keep rows sorted, inserts are fast.

-- * Slow Read without an index: finding a specific row requires scanning every page. In PostgreSQL this is a Sequential Scan (`Seq Scan` in `EXPLAIN`).

-- * 🐘 PostgreSQL Note: Unlike MySQL InnoDB (where the table IS the primary-key B-Tree), PostgreSQL stores the table as a heap and the primary key as a separate B-Tree index. A table without a primary key is still a normal table — but please always add one.

-- Description: HEAP Structure showing randomly ordered rows across pages.

-- Description: Full Table Scan searching for ID=14. SQL must read every row across every page to find it.

-- ------------------------------------------------------------
-- 41.4 The Clustered Index (B-Tree Structure) & Reading Speed
-- ------------------------------------------------------------

-- In SQL Server and MySQL InnoDB, the primary key creates a Clustered Index — the table itself is stored sorted inside the B-Tree. 🐘 PostgreSQL does not have this; its primary key is a normal B-Tree index (see 41.5). But the B-Tree idea is the same for every index, so learn it here.

-- English: A Clustered Index physically sorts the data in the table based on the indexed column (e.g., Customer ID). It uses a B-Tree (Balanced Tree) structure. In a clustered index, the leaf nodes (the bottom level of the tree) are the actual Data Pages themselves.

-- Structure of a B-Tree:

-- 1. Root Node: The starting point. It contains high-level ranges and points to Intermediate nodes.

-- 2. Intermediate Nodes: Act as signboards, narrowing down the search and pointing to the correct Leaf nodes.

-- 3. Leaf Nodes: For a Clustered Index, the leaf node is the actual data page containing your rows. (In a PostgreSQL B-Tree, the leaf holds the key + the row's CTID.)

-- Detailed Execution Example (Searching for ID 14):
-- If you query `WHERE customer_id = 14`, SQL does not scan all pages. Instead, it navigates the B-Tree:

-- 1. Step 1 (Root Node): SQL checks the root node. Since 14 is between 11 and 20, it uses the 2nd pointer to jump to the intermediate index page.

-- 2. Step 2 (Intermediate Node): Since 14 is between 11 and 15, it uses the pointer to the correct leaf page.

-- 3. Step 3 (Leaf Node): SQL locates the correct page and finds customer ID 14 (in PostgreSQL: finds the CTID and then reads that heap page).

-- Why is this so fast?
-- It only took 3 jumps! The B-Tree skips almost all pages. Instead of reading every page of the table, the database reads only one small page per level (Root ➔ Intermediate ➔ Leaf). Even a table with millions of rows usually has a B-Tree only 3–4 levels deep, so a lookup needs about 3–4 page reads instead of thousands.

--   * Root: 11–20 ➔ Intermediate: 11–15 ➔ Leaf.

-- Description: Clustered Index B-Tree. The search for ID=14 traverses the Root (Step 1), then Intermediate (Step 2), directly landing on the correct Data Page (Step 3).

-- * 🐘 PostgreSQL `CLUSTER` command: you can sort a table once by an index — `CLUSTER customers USING customers_pkey;` — which helps range scans. But PostgreSQL does not keep the order for new rows, and `CLUSTER` locks the table while it runs. It is a one-time reorganization, not a real clustered index.

-- ------------------------------------------------------------
-- 41.5 Non-Clustered Index (Secondary Index) — every PostgreSQL index
-- ------------------------------------------------------------

-- When you create an index on a column (e.g., `Customer Name`), SQL builds a new, separate B-Tree structure. This is called a Non-Clustered Index (or Secondary Index). 🐘 In PostgreSQL, all indexes — including the primary key — work this way.

-- * Definition: An index that is a separate structure. It sorts the indexed column without changing the physical order of the actual table.

-- English: A Non-Clustered Index is a completely separate structure from the data pages. The B-Tree contains a sorted copy of the indexed column. The Leaf Nodes do not contain the full row data. Instead, they contain a pointer back to the actual data page where the rest of the row is stored.

-- What exactly is this Pointer?

-- 1. In PostgreSQL (heap table): The pointer is the CTID = `(page number, item number)`, e.g. `(102, 4)`. PostgreSQL jumps straight to that page in the heap. (SQL Server heap: RID — same idea.)

-- 2. In MySQL InnoDB (clustered table): The pointer is the Primary Key (e.g., `EmpID = 1`), and MySQL must walk the clustered B-Tree a second time.

-- The "Extra Lookup" Process (Heap Fetch):
-- When you query `WHERE name = 'Vishal'`:

-- 1. PostgreSQL scans the B-Tree on `name` to find 'Vishal'.

-- 2. It reaches the Leaf Node and finds the CTID (e.g., `(102, 4)`).

-- 3. PostgreSQL does one extra jump to heap page 102 to read the rest of the row, and checks the MVCC visibility (`xmin`/`xmax`) of that row version.

-- 4. 🐘 Index-Only Scan: If all columns the query needs are in the index (add extra columns with `INCLUDE`), and the page is marked "all-visible" by `VACUUM`, PostgreSQL skips the heap completely:
CREATE INDEX idx_customers_name ON customers (name) INCLUDE (city);
SELECT name, city FROM customers WHERE name = 'Vishal';   -- Index Only Scan

-- Description: Non-Clustered Index B-Tree. The leaf nodes contain pointers. SQL must perform an extra jump to fetch the full row from the physically separate Data Pages.

-- ------------------------------------------------------------
-- 41.6 Clustered vs Non-Clustered Index Summary
-- ------------------------------------------------------------

-- English: Here is a quick comparison. Remember: PostgreSQL only has the right column (non-clustered) indexes, on a heap table.

-- | Feature | Clustered Index (SQL Server / MySQL PK) | Non-Clustered Index (all PostgreSQL indexes) |
-- | :--- | :--- | :--- |
-- | Definition | Physically sorts and stores rows. | Separate structure with pointers to the data. |
-- | Number of Indexes | One Index per Table. | Multiple indexes are allowed. |
-- | Read Performance | Faster for PK lookups/ranges (data is right there). | Needs an extra heap fetch (unless Index-Only Scan). |
-- | Write Performance | Slower, due to page splits / row reordering. | No reordering; but every index must be updated (HOT updates help). |
-- | Storage Efficiency | More storage-efficient. | Requires additional storage space for the B-Tree. |
-- | Use Case | Unique Column, Not frequently modified, Range queries. | Columns frequently used in search conditions and exact match queries. |

-- Syntax to Create Indexes (PostgreSQL):
-- PostgreSQL has no CLUSTERED / NONCLUSTERED keywords
CREATE INDEX index_name ON table_name [USING method] (column1, column2, ...);

CREATE INDEX ix_customers_city ON customers (city);

CREATE INDEX ix_customers_name ON customers (lastname ASC, firstname DESC);

-- one-time physical sort by an index (not maintained)
CLUSTER customers USING customers_pkey;

-- build without blocking writes on a live table
CREATE INDEX CONCURRENTLY ix_customers_country ON customers (country);

-- * ⚠️ Note: `CLUSTERED` / `NONCLUSTERED` keywords are SQL Server syntax. In PostgreSQL every `CREATE INDEX` makes a secondary index on the heap.

-- * 🐘 HOT updates: If an `UPDATE` does not change any indexed column and the new row version fits on the same page, PostgreSQL makes a "Heap-Only Tuple" and does not touch the indexes at all — so don't index columns that change often unless you need it. Leave some free space with `ALTER TABLE t SET (fillfactor = 90);` for busy tables.

-- ------------------------------------------------------------
-- 41.7 Rowstore vs Columnstore Index (Storage Architecture)
-- ------------------------------------------------------------

-- Indexes can also be categorized by how they physically store data on the disk (By Storage).

-- ------------------------------------------------------------
-- 1. Rowstore Index (The Default)
-- ------------------------------------------------------------
-- English: Organizes and stores data row by row. This is the traditional RDBMS structure. If you fetch a single row, the database pulls the entire row together.

-- * Note: In PostgreSQL every table is a heap stored row by row inside 8KB data pages — a rowstore.

-- Description: Rowstore stores complete rows in pages. Columnstore stores each column separately in its own pages.

-- ------------------------------------------------------------
-- 2. Columnstore Index (For Analytics)
-- ------------------------------------------------------------
-- English: Organizes and stores data column by column. This is highly optimized for analytical queries (OLAP) where you might need to sum up a single column (e.g., Sales) across millions of rows without reading the rest of the columns.

-- The Columnstore Creation Process:

-- Description: The three steps of creating a Columnstore index.

-- 1. #1 Row Groups: The table is first divided horizontally into Row Groups (up to 1 million rows per group).

-- 2. #2 Column Segments: Each Row Group is then divided vertically into independent Column Segments.

-- 3. #3 Compression (Dictionary): Each Column Segment is heavily compressed. For example, if a `Status` column has 'Active' and 'Inactive' repeating thousands of times, it creates a Dictionary (`'Active' -> 1`, `'Inactive' -> 2`) and stores tiny numbers instead of large strings.

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

-- Columnstore Index Syntax (SQL Server, for comparison):
-- Default is ROWSTORE
CREATE [CLUSTERED | NONCLUSTERED] [COLUMNSTORE] INDEX index_name ON table_name (column1, column2, ...)

-- Rowstore
CREATE NONCLUSTERED INDEX IX_Customers_Country ON Customers (Country)
CREATE CLUSTERED INDEX IX_Customers_ID ON Customers (ID)

-- Columnstore
CREATE NONCLUSTERED COLUMNSTORE INDEX IX_Customers_Country ON Customers (Country)
CREATE CLUSTERED COLUMNSTORE INDEX IX_Customers ON Customers ❌ -- NOT ALLOWED TO USE COLUMNS

-- Rules: You can't specify columns in Clustered Index Columnstore

-- * ⚠️ Note: Columnstore indexes are a SQL Server feature. Core PostgreSQL is a rowstore. For column-store analytics, PostgreSQL users use extensions (Citus columnar access method: `CREATE TABLE t (...) USING columnar;`), TimescaleDB compression, or a separate analytics database (ClickHouse, Redshift, BigQuery). PostgreSQL's BRIN index also helps big analytic scans on time-ordered data.

-- ------------------------------------------------------------
-- 41.8 Indexing by Function (Unique, Partial, Composite, Expression, GIN, GiST, BRIN)
-- ------------------------------------------------------------

-- * Diagram summary: Shows Filtered Index syntax with WHERE condition and a flowchart on When To Use different indexes

-- * Diagram summary: Compares default index syntax which allows duplicates vs unique index syntax which enforces uniqueness

-- * Definition: A Unique Index ensures that all values in a specific column are distinct (no duplicate values exist).

-- * Why it is important:

--   * Data Integrity: Enforces uniqueness of data at the database level.

--   * Improved Performance: The planner knows there is at most one match.

-- * Important Note:

--   * Writing to a unique index is slightly slower than writing to a normal index, because the database must first check that the value does not already exist.

--   * Reading from a unique index is fast (stops at the first match).

--   * If a duplicate exists in the column, it will prevent you from creating a unique index.

--   * NULLs: many NULLs are allowed (NULL ≠ NULL), unless you write `UNIQUE NULLS NOT DISTINCT` (PG 15+).

-- * Example / Syntax:
CREATE UNIQUE INDEX idx_email ON employees (email);

-- case-insensitive unique email (expression index):
CREATE UNIQUE INDEX idx_email_lower ON employees (LOWER(email));

-- 2. Partial Index (Filtered Index) — ✅ supported in PostgreSQL

-- * Definition: An index that includes only the rows meeting a condition. SQL Server calls it "filtered", PostgreSQL calls it "partial".

-- * Benefits:

--   * Targeted Optimization: Optimizes queries for a specific subset of data.

--   * Reduced Storage: Stores less data in the index, which saves space and speeds up writes for other rows.

-- * When to use: Use when a query frequently targets a specific category (e.g., Active employees, unpaid invoices, not-deleted rows).

-- * Syntax:
CREATE INDEX idx_active_users ON users (status) WHERE status = 'ACTIVE';

-- a very common pattern: index only the rows that are still to be processed
CREATE INDEX idx_unpaid ON invoices (customer_id) WHERE paid = FALSE;

-- * ⚠️ The query's `WHERE` must match (or imply) the index condition; e.g. `WHERE status = 'ACTIVE' AND ...` can use the index, but `WHERE status = 'INACTIVE'` cannot.

-- 3. Simple (Single-Column) Index

-- * Definition: An index created on just one column.

-- * Example:
CREATE INDEX idx_salary ON employees (salary);

-- 4. Composite (Multi-Column) Index

-- * Definition: An index created on multiple columns.

-- * Leftmost Prefix Rule: A B-Tree index works best when your query filters on the first column(s) of the index.

--   * If the index is `(col1, col2, col3)`, it works for: `col1` | `col1, col2` | `col1, col2, col3`.

--   * For only `col2` without `col1`, PostgreSQL usually cannot use it efficiently (it may scan the whole index; PostgreSQL 18 adds B-Tree "skip scan" for some cases). Always start with the leftmost column!

--   * Clarification: The order of conditions inside `WHERE` does not matter (`WHERE col2 = 5 AND col1 = 3` still uses the index); what matters is that the leftmost index columns are used.

--   * PostgreSQL can also combine two separate indexes with a "BitmapAnd" — but one good composite index is usually faster.

-- * Example:
CREATE INDEX idx_name_salary ON employees (name, salary);

-- 5. Expression (Functional) Index — PostgreSQL

-- * An index on the result of an expression, used when the query uses the same expression:
CREATE INDEX idx_lower_email ON customers (LOWER(email));
SELECT * FROM customers WHERE LOWER(email) = 'a@x.com';    -- uses the index

CREATE INDEX idx_order_year ON orders ((EXTRACT(YEAR FROM order_date)));

-- 6. Full-Text Index (GIN on tsvector)

-- * Definition: Used for searching words efficiently within large text columns. PostgreSQL uses a `tsvector` (list of words) + a GIN index, and the `@@` match operator (MySQL: `FULLTEXT` + `MATCH() AGAINST()`). Details in 41.13.

-- * Example:
CREATE INDEX idx_desc_fts ON products USING GIN (to_tsvector('english', description));

-- 7. Spatial Index (GiST)

-- * Definition: Used for geometry or GIS data (PostGIS). PostgreSQL uses a GiST index.

-- * Example:
CREATE INDEX idx_location ON places USING GIST (location);

-- 8. GIN Index for JSONB and Arrays (PostgreSQL)
CREATE INDEX idx_users_details ON users USING GIN (details);        -- JSONB
SELECT * FROM users WHERE details @> '{"isAdmin": true}';            -- uses the index

CREATE INDEX idx_students_hobbies ON students USING GIN (hobbies);   -- TEXT[]
SELECT * FROM students WHERE hobbies @> ARRAY['Coding'];

-- 9. BRIN Index (huge, naturally ordered tables)
CREATE INDEX idx_logs_created_brin ON logs USING BRIN (created_at);
-- very small (KBs for a billion rows); great for WHERE created_at >= now() - INTERVAL '1 day'

-- ------------------------------------------------------------
-- Summary of Index Types: When & How to Use
-- ------------------------------------------------------------

-- * Diagram summary: A visual summary of index types, showing when to use them and what their primary purpose is

--   * Full-Text (GIN + tsvector) · Spatial (GiST/PostGIS).

-- | Index Type (PostgreSQL) | When To Use (Scenario) | How It Helps |
-- | :--- | :--- | :--- |
-- | B-Tree (default) | PK, FK, WHERE filters, joins, sorting, ranges | Fast `=`, `<`, `>`, `BETWEEN`, `ORDER BY` |
-- | Unique | When a column must not have duplicates | Enforces data integrity & speeds up exact matches |
-- | Partial (`WHERE`) | When querying a specific subset (e.g., Active only) | Smaller index & faster writes |
-- | Composite | When queries filter by multiple columns often | One index for the whole filter (Leftmost Rule) |
-- | Expression | When the query uses `LOWER(col)`, `EXTRACT(...)` etc. | Lets function-based filters use an index |
-- | Covering (`INCLUDE`) | When a query needs a few extra columns | Enables Index-Only Scans |
-- | GIN | JSONB, arrays, full-text search, `pg_trgm` (`LIKE '%x%'`) | Finds rows containing an item |
-- | GiST / SP-GiST | PostGIS, ranges, nearest neighbour, `EXCLUDE` | Geometric / range searches |
-- | BRIN | Huge append-only tables ordered by time/id | Tiny index for range scans |
-- | Hash | Only equality, very long keys | Equality lookups |

-- ------------------------------------------------------------
-- 41.9 Indexing Best Practices in PostgreSQL
-- ------------------------------------------------------------

-- * Do Use Indexes For:

--   * Columns frequently used in `WHERE`, `JOIN`, `ORDER BY`, and `GROUP BY` clauses.

--   * Frequently searched columns.

--   * Foreign keys — ⚠️ PostgreSQL does NOT index foreign key columns automatically (MySQL InnoDB does). Create them yourself: `CREATE INDEX ON orders (customer_id);`

-- * Avoid Indexing (Do Not Use For):

--   * Avoid Over-Indexing: every index slows down writes and blocks HOT updates on its columns.

--   * Columns with low selectivity (e.g., `gender` with only 'M'/'F' values) — unless it is a partial index on the rare value.

--   * Very small tables (a Seq Scan of a few pages is already fast).

--   * Columns that are updated frequently (high index maintenance overhead).

-- * Useful Commands:

--   * See existing indexes: `\di` or `\d employees` (psql), or `SELECT indexname, indexdef FROM pg_indexes WHERE tablename = 'employees';`

--   * Check if a query uses an index: `EXPLAIN ANALYZE SELECT * FROM employees WHERE name = 'Vishal';`

--   * Build on a live table without blocking writes: `CREATE INDEX CONCURRENTLY ...`

-- ------------------------------------------------------------
-- 41.10 Advantages & Disadvantages of Indexes
-- ------------------------------------------------------------

-- * Advantages:

--   * Faster `SELECT` queries (Reading).

--   * Efficient `JOIN` operations.

--   * Enforces uniqueness (via `PRIMARY` / `UNIQUE` constraints).

--   * Helps with faster sorting (`ORDER BY`) and grouping (`GROUP BY`).

--   * Summary: Indexes = Speed for reads.

-- * Disadvantages:

--   * Requires extra disk space (and RAM in `shared_buffers`).

--   * Slower writes (`INSERT`, `UPDATE`, `DELETE`) and more WAL.

--   * Poorly chosen or over-indexed tables can severely hurt performance.

--   * Summary: Indexes = Cost for writes.

-- ------------------------------------------------------------
-- 41.11 Index Management & Monitoring
-- ------------------------------------------------------------

-- * Definition: Building an index is not the final step. Over time, indexes become bloated, outdated, and unused. This can lead to poor query performance, increased storage costs, and slower writes.

-- * Key Maintenance Steps (PostgreSQL commands):

--   1. Monitor Index Usage — unused indexes (`idx_scan = 0`):
SELECT relname AS table_name, indexrelname AS index_name, idx_scan
FROM pg_stat_user_indexes
ORDER BY idx_scan;

--   2. Monitor Missing Indexes: tables with many sequential scans:
SELECT relname, seq_scan, idx_scan FROM pg_stat_user_tables ORDER BY seq_scan DESC;
--      and slow queries from `pg_stat_statements`.

--   3. Monitor Duplicate Indexes: remove indexes on the same columns.

--   4. Update Statistics: `ANALYZE employees;` (autovacuum also does it automatically).

--   5. Index Bloat: indexes grow with dead entries after many updates/deletes. Rebuild with `REINDEX INDEX CONCURRENTLY idx_name;` (PostgreSQL 12+). Check sizes with `SELECT pg_size_pretty(pg_relation_size('idx_name'));`

-- ------------------------------------------------------------
-- 41.12 Indexing Strategies
-- ------------------------------------------------------------

-- * Diagram summary: 4-step Indexing Strategy flowchart: 1. Initial Strategy (OLAP vs OLTP), 2. Usage Patterns Indexing, 3. Scenario-Based Indexing, 4. Monitoring & Maintenance

-- * Point-Wise Explanation:

--   1. Initial Indexing Strategy (OLAP vs OLTP):

--      * OLAP (Analytical): Goal is to optimize READ performance (e.g., Data Warehouses). In PostgreSQL: BRIN indexes, table partitioning, materialized views, columnar extensions.

--      * OLTP (Transactional): Goal is to optimize WRITE performance (e.g., Apps, Web). Keep a small primary key and only the indexes you need.

--   2. Usage Patterns Indexing:

--      * Identify frequently used tables & columns.

--      * Choose the right index (Unique, Composite, Partial, Expression, GIN).

--      * Test the index performance.

--   3. Scenario-Based Indexing:

--      * Identify slow queries using `pg_stat_statements` and `log_min_duration_statement`.

--      * Check the execution plan using `EXPLAIN (ANALYZE, BUFFERS)`.

--      * Choose the right index and compare the execution plans before and after.

--   4. Monitoring & Maintenance:

--      * Continuously monitor usage, missing indexes, duplicates, statistics, and bloat.

-- ------------------------------------------------------------
-- 41.13 Full-Text Search (tsvector, tsquery, GIN Index)
-- ------------------------------------------------------------

-- * `LIKE '%word%'` cannot use a normal B-Tree index (leading `%`), so it scans the whole table and has no relevance ranking. PostgreSQL's built-in full-text search turns text into a `tsvector` (normalized words: "indexes" → "index") and searches it with a `tsquery`; a GIN index makes it fast (inverted index: word → rows).
CREATE TABLE articles (
    id    SERIAL PRIMARY KEY,
    title VARCHAR(200),
    body  TEXT,
    search_doc TSVECTOR GENERATED ALWAYS AS
        (to_tsvector('english', coalesce(title, '') || ' ' || coalesce(body, ''))) STORED
);

CREATE INDEX ft_title_body ON articles USING GIN (search_doc);

INSERT INTO articles (title, body) VALUES
('PostgreSQL Indexing Guide', 'Learn how B-Tree indexes speed up PostgreSQL queries'),
('Joins Explained', 'INNER JOIN and LEFT JOIN with examples'),
('PostgreSQL Transactions', 'COMMIT, ROLLBACK and isolation levels in PostgreSQL');

-- * 1. Simple search — ranked by relevance (MySQL natural language mode):
SELECT id, title, ts_rank(search_doc, query) AS score
FROM articles, plainto_tsquery('english', 'postgresql indexes') AS query
WHERE search_doc @@ query
ORDER BY score DESC;

--   * `plainto_tsquery('postgresql indexes')` = both words must be present (`postgresql & index`). `@@` means "matches".

-- * 2. Operators (MySQL boolean mode):
-- must have postgresql, must not have join   (MySQL: '+mysql -join')
SELECT title FROM articles WHERE search_doc @@ to_tsquery('english', 'postgresql & !join');

-- prefix: transaction, transactions        (MySQL: 'trans*')
SELECT title FROM articles WHERE search_doc @@ to_tsquery('english', 'trans:*');

-- exact phrase                              (MySQL: '"isolation levels"')
SELECT title FROM articles WHERE search_doc @@ phraseto_tsquery('english', 'isolation levels');

-- Google-like syntax from user input (quotes, OR, -)
SELECT title FROM articles WHERE search_doc @@ websearch_to_tsquery('english', 'postgresql -join');

-- * Highlight matches: `SELECT ts_headline('english', body, to_tsquery('english', 'postgresql')) FROM articles;`

-- * Rules and tips:

--   * Use the same language config (`'english'`) when building the `tsvector` and the query. Stop words ("the", "and") are removed and words are reduced to their root ("indexes" → "index").

--   * For Marathi/Hindi text, use the `'simple'` config (no stemming) or the `pg_trgm` extension for similarity search.

--   * For "contains any part of a word" (`LIKE '%mum%'`) and typo-tolerant search, use `pg_trgm` + a GIN index: `CREATE INDEX ON customers USING GIN (city gin_trgm_ops);` then `WHERE city ILIKE '%mum%'` or `WHERE similarity(city, 'Mumbia') > 0.3`.

--   * For very large search needs (facets, synonyms at scale) teams still use Elasticsearch/OpenSearch.

-- ------------------------------------------------------------
-- 41.14 Pagination: LIMIT OFFSET vs Keyset (Seek) Pagination
-- ------------------------------------------------------------

-- * OFFSET pagination (common but slow on deep pages):
-- page 1
SELECT order_id, order_date, amount FROM orders ORDER BY order_id LIMIT 20 OFFSET 0;
-- page 5001
SELECT order_id, order_date, amount FROM orders ORDER BY order_id LIMIT 20 OFFSET 100000;

--   * PostgreSQL must read and throw away 100,000 rows to return 20, so every next page gets slower.

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

--   * PostgreSQL uses the composite B-Tree index directly for this row comparison (it is one of the databases that does this well).

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

--   * A: Avoid over-indexing! Indexes require disk space. Every `INSERT`, `UPDATE`, or `DELETE` must update the indexes (and in PostgreSQL an index on a changed column also prevents HOT updates). Too many indexes will kill write performance.

-- * Q: What is an Execution Plan (`EXPLAIN`)?

--   * A: Write `EXPLAIN ANALYZE SELECT ...` to see if PostgreSQL uses your index (`Index Scan` / `Index Only Scan` / `Bitmap Index Scan`) or does a `Seq Scan` (Topic 43).

-- * Q: Does PostgreSQL have a clustered index?

--   * A: No. Tables are heaps; every index (including the primary key) is secondary and points to the row's CTID. `CLUSTER` can sort a table once, but the order is not maintained. This is why a random UUID primary key hurts PostgreSQL less than MySQL InnoDB.

-- * Q: Name PostgreSQL index types and a use for each.

--   * A: B-Tree (general), Hash (equality), GIN (JSONB, arrays, full-text), GiST/SP-GiST (geo, ranges), BRIN (huge time-ordered tables); plus partial, expression and covering (`INCLUDE`) variants.

-- ---

-- ======================================================================
-- 🎯 Practice Questions (salesdb sample data) — try first, then look at the answer
-- ======================================================================
-- Run 00-Setup-Sample-Data.sql once before this section.

SET search_path TO sales;

-- Q1. Create an index for a frequent filter and check the plan.
CREATE INDEX idx_orders_status ON orders (orderstatus);
EXPLAIN SELECT * FROM orders WHERE orderstatus = 'Shipped';

-- Q2. Composite index for customer + date queries.
CREATE INDEX idx_orders_cust_date ON orders (customerid, orderdate);
EXPLAIN SELECT * FROM orders WHERE customerid = 1 AND orderdate >= '2025-01-15';

-- Q3. List indexes, then drop the practice indexes.
SELECT indexname, indexdef FROM pg_indexes WHERE tablename = 'orders';
DROP INDEX idx_orders_status;
DROP INDEX idx_orders_cust_date;
