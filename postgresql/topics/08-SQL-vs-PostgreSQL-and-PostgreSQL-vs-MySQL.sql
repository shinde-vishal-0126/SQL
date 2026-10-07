-- ======================================================================
-- Topic 8: SQL vs PostgreSQL (and PostgreSQL vs MySQL)
-- ======================================================================

-- ------------------------------------------------------------
-- 📖 In Simple Words
-- ------------------------------------------------------------

-- * Definition: SQL is a language; MySQL / PostgreSQL are software products (RDBMS) that understand SQL. Each product adds its own extra features on top of standard SQL.

-- * Real-life example: English is the language; BBC and CNN are channels that speak English, each with its own style.

-- * 🧩 Syntax:
--     -- Standard SQL (works everywhere):
--     SELECT col FROM t WHERE ... ORDER BY col;
--     -- PostgreSQL extensions:
--     SELECT a || b, COALESCE(x, 0) FROM "table" WHERE col ILIKE 'a%' LIMIT n;
--     UPDATE t SET ... RETURNING *;

-- * Syntax explained (each part):
--   - Standard SQL → the common language every RDBMS understands
--   - Extensions → product-specific syntax: MySQL backticks / IFNULL; PostgreSQL || / ILIKE / RETURNING / double quotes

-- * Example on salesdb (run 00-Setup-Sample-Data.sql first):
SET search_path TO sales;
SELECT firstname || ' ' || COALESCE(lastname, '') AS full_name
FROM customers;

-- * Example explained (step by step):
--   1. Both queries do the same thing: join first and last name into one column.
--   2. MySQL uses CONCAT and IFNULL; PostgreSQL uses || and COALESCE.
--   3. Mary has no last name (NULL), so it is replaced with an empty text instead of making the whole result NULL.

-- ------------------------------------------------------------
-- 8.1 What is SQL?
-- ------------------------------------------------------------

-- * Q. What is SQL?

--   * SQL stands for: Structured Query Language.

--   * Category: Domain-specific declarative query language.

--   * Role: Serves as the universal standard language to query, manipulate, and administer relational databases.

--   * Note: SQL does not store data on its own; it is the communication language.

-- ---

-- ------------------------------------------------------------
-- 8.2 What is PostgreSQL?
-- ------------------------------------------------------------

-- * Q. What is PostgreSQL?

--   * Category: An open-source Object-Relational Database Management System (ORDBMS) — often just called "Postgres".

--   * Role: An executable database engine and server program that stores and manages data.

--   * Function: Stores records in structured tables, executes SQL queries, manages storage (heap tables + WAL), caching (shared buffers), and multi-user concurrency (MVCC).

--   * Known for: Following the SQL standard closely, strong data correctness, and extensions (PostGIS, pg_trgm, TimescaleDB, pgvector).

-- ---

-- ------------------------------------------------------------
-- 8.3 Key Differences: Comparison Table
-- ------------------------------------------------------------

-- | Feature / Aspect | SQL (Structured Query Language) | PostgreSQL (Relational DBMS) |
-- | :--- | :--- | :--- |
-- | Category | Declarative Query Language. | Complete RDBMS Software Engine. |
-- | Primary Purpose | Querying, filtering, and manipulating data. | Storing, persisting, indexing, and securing data files. |
-- | Data Storage | Does not store data itself. | Stores and manages data pages (8 KB) on physical disk. |
-- | Version Cycles | Standardized language specification (ANSI SQL). | Continuously updated database software (one major version per year, e.g., PostgreSQL 16, 17). |
-- | Installation | Cannot be installed (it is a language standard). | Installed as a background service on servers and cloud (AWS RDS, Azure, Supabase, Neon). |
-- | Analogy | Like the English Language (medium of speech). | Like a Person who understands and speaks English. |

-- ---

-- ------------------------------------------------------------
-- 8.4 Visual Concept: Language vs RDBMS Software
-- ------------------------------------------------------------

-- ------------------------------------------------------------
-- Simple Explanation of the Diagram:
-- ------------------------------------------------------------

-- * Left Card (SQL): The declarative language used to communicate instructions (`SELECT`, `INSERT`, `UPDATE`, `DELETE`).

-- * Right Card (the diagram shows MySQL — read it as PostgreSQL): The database software engine that receives SQL instructions and performs disk storage, caching, and retrieval.

-- * Bottom Rule: SQL is the Language, while PostgreSQL is the Software Engine that executes that language!

-- ---

-- ------------------------------------------------------------
-- 8.5 🐘 PostgreSQL vs MySQL — Quick Difference Table (New)
-- ------------------------------------------------------------

-- * Q. What are the main differences between PostgreSQL and MySQL? (Very common interview question.)

-- | Area | MySQL | PostgreSQL |
-- | :--- | :--- | :--- |
-- | Type | RDBMS | Object-Relational DBMS |
-- | Default port / admin user | `3306` / `root` | `5432` / `postgres` |
-- | Command-line client | `mysql` | `psql` |
-- | Auto-increment | `AUTO_INCREMENT` | `SERIAL` / `GENERATED AS IDENTITY` |
-- | Database vs Schema | Same thing | Different: Database → Schema (`public`) → Table |
-- | Switch database | `USE db;` | `\c db` (in psql) — one connection = one database |
-- | Quote identifiers | `` `name` `` (backticks) | `"name"` (double quotes) |
-- | String compare | Case-insensitive by default | Case-sensitive (`ILIKE` for case-insensitive) |
-- | Boolean | `TINYINT(1)` (0/1) | Real `BOOLEAN` (`TRUE`/`FALSE`) |
-- | Date + time types | `DATETIME`, `TIMESTAMP` | `TIMESTAMP`, `TIMESTAMPTZ`, `INTERVAL` |
-- | JSON | `JSON` | `JSON` and `JSONB` (indexable with GIN) |
-- | Arrays | No | Yes (`INT[]`, `TEXT[]`) |
-- | `FULL OUTER JOIN` | Not supported (use `UNION`) | Supported |
-- | `INTERSECT` / `EXCEPT` | From 8.0.31 | Always supported |
-- | Upsert | `ON DUPLICATE KEY UPDATE` | `ON CONFLICT ... DO UPDATE` |
-- | Get inserted id | `LAST_INSERT_ID()` | `RETURNING id` |
-- | Transactional DDL | No (DDL auto-commits) | Yes (`CREATE`/`ALTER`/`DROP` can be rolled back) |
-- | Storage engine | Pluggable (InnoDB, MyISAM…) | One built-in heap storage + WAL |
-- | Primary key storage | Clustered index (InnoDB) | Heap table + separate B-Tree index |
-- | Old row cleanup | Undo log (purge thread) | `VACUUM` / autovacuum |
-- | Index types | B-Tree, Full-text, Spatial, Hash (memory) | B-Tree, Hash, GIN, GiST, SP-GiST, BRIN |
-- | Partial / expression index | Functional index only (8.0.13+) | Both (`WHERE` in index, any expression) |
-- | Procedural language | SQL/PSM in procedures | PL/pgSQL (+ PL/Python, PL/Perl…) |
-- | Scheduled jobs | `CREATE EVENT` | Extension `pg_cron` (or OS cron) |
-- | Backup tool | `mysqldump` | `pg_dump` / `pg_restore` |
-- | License | GPL (Oracle owned) | PostgreSQL License (very permissive, community owned) |

-- ---

-- * SQL (Structured Query Language):

-- * PostgreSQL:

-- ---

-- ======================================================================
-- 🧪 Practice Examples (salesdb sample data)
-- ======================================================================
-- First run 00-Setup-Sample-Data.sql once. Then run these one by one (select a statement → execute).
-- pgAdmin: open the Query Tool on database "salesdb".
SET search_path TO sales;

-- Standard SQL — the same in PostgreSQL, MySQL, SQL Server:
SELECT country, COUNT(*) AS total_customers
FROM customers
GROUP BY country
ORDER BY total_customers DESC;

-- PostgreSQL-specific syntax:
SELECT firstname, score FROM customers ORDER BY score DESC NULLS LAST LIMIT 2;  -- NULLS LAST
SELECT firstname || ' ' || COALESCE(lastname, '') AS full_name FROM customers;  -- || concatenation
SELECT firstname FROM customers WHERE firstname ILIKE 'm%';                     -- ILIKE (case-insensitive)
SELECT orderid, sales::numeric / 3 AS third FROM orders;                         -- :: cast
UPDATE customers SET score = score WHERE customerid = 1 RETURNING *;            -- RETURNING
SELECT "firstname" FROM "customers";                                            -- double quotes for identifiers

-- Same query in MySQL would use: IFNULL, CONCAT(), backticks, no ILIKE / RETURNING.

-- ======================================================================
-- 🎯 Practice Questions (salesdb sample data) — try first, then look at the answer
-- ======================================================================
-- Run 00-Setup-Sample-Data.sql once before this section.

SET search_path TO sales;

-- Q1. Standard SQL that runs everywhere: customers ordered by score.
SELECT firstname, score FROM customers ORDER BY score DESC;

-- Q2. Full name — MySQL uses CONCAT/IFNULL (Postgres: || and COALESCE).
SELECT firstname || ' ' || COALESCE(lastname, '') AS full_name FROM customers;

-- Q3. Top 3 most expensive products (LIMIT works in MySQL and PostgreSQL).
SELECT product, price FROM products ORDER BY price DESC LIMIT 3;
