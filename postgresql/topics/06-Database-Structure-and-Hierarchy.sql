-- ======================================================================
-- Topic 6: Database Structure & Hierarchy
-- ======================================================================

-- ------------------------------------------------------------
-- 📖 In Simple Words
-- ------------------------------------------------------------

-- * Definition: Database structure is the order in which data is organised: server → database → (schema) → table → columns and rows. Each column has a data type that says what kind of value it can hold.

-- * Real-life example: Building → floor → room → shelf → box. Each box has a label saying what may go inside (only numbers, only dates…).

-- * 🧩 Syntax:
--     CREATE TABLE table_name (
--       column_name DATA_TYPE [constraint],
--       ...
--     );
--     -- see columns and data types:
--     SELECT column_name, data_type FROM information_schema.columns WHERE table_name = 'table_name';

-- * Syntax explained (each part):
--   - column_name → name of the field
--   - DATA_TYPE → kind of value: INT, DECIMAL(p,s), VARCHAR(n), DATE, TIMESTAMP, JSON …
--   - [constraint] → optional rule: PRIMARY KEY, NOT NULL, UNIQUE, DEFAULT …

-- * Example on salesdb (run 00-Setup-Sample-Data.sql first):
SET search_path TO sales;
SELECT column_name, data_type
FROM information_schema.columns
WHERE table_schema = 'sales' AND table_name = 'products';

-- * Example explained (step by step):
--   1. This lists the columns of the products table and their data types.
--   2. productid and price are INT (whole numbers); product and category are VARCHAR(50) (text up to 50 characters).
--   3. The data type stops wrong data, e.g. text cannot go into price.

-- ------------------------------------------------------------
-- 6.1 The Relational Database Hierarchy
-- ------------------------------------------------------------

-- * Q. What is the Relational Database Hierarchy?

--   * Definition: The database hierarchy is the set of levels in which data is organized: Server → Database → Schema → Table.

--   * Relational databases organize data in 4 levels:

-- ┌── (text — not SQL, shown for reference) ──
-- │ [ Tier 1: SERVER ] ──► [ Tier 2: DATABASES ] ──► [ Tier 3: SCHEMAS ] ──► [ Tier 4: OBJECTS / TABLES ]
-- └──

-- ------------------------------------------------------------
-- Point-Wise Breakdown of the Hierarchy:
-- ------------------------------------------------------------

-- 1. Level 1: Server (Host Machine Environment)

--    * A computer (physical or cloud) that runs the database software.

--    * Runs 24/7 and can host one or many databases.

--    * Accepts connections, checks logins, runs queries and manages backups.

-- 2. Level 2: Databases (Isolated Storage Containers)

--    * Separate containers of data that live on the server.

--    * A single server instance can host multiple independent databases (e.g., `Sales_DB`, `HR_DB`, `Inventory_DB`).

--    * Each database holds the data of one application or department.

-- 3. Level 3: Schemas (Logical Categories & Namespaces)

--    * Logical folders inside a database that group related tables together.

--    * They avoid name clashes and keep hundreds of tables organized (e.g., `orders.*`, `customers.*`).

-- 4. Level 4: Database Objects (Functional Components)

--    * A schema contains these database objects:

--      * ⭐ Tables: The primary object; stores physical records in rows and columns.

--      * 👁️ Views: Virtual tables compiled from saved `SELECT` queries.

--      * ⚡ Indexes: Search structures (B-Trees) that make lookups fast.

--      * 📜 Stored Procedures: Saved blocks of SQL code that you run by name.

--      * 🔧 Functions: Reusable code that returns a value.

--      * 🎯 Triggers: Code that runs automatically when a row is inserted, updated or deleted (`INSERT`, `UPDATE`, `DELETE`).

--      * 🔢 Sequences: Number generators used for IDs. PostgreSQL `SERIAL` and `IDENTITY` columns use a sequence internally (MySQL uses `AUTO_INCREMENT` instead).

-- ------------------------------------------------------------
-- 🐘 PostgreSQL Hierarchy in Practice (Different from MySQL)
-- ------------------------------------------------------------

-- * PostgreSQL really has all 4 levels: Server (called a "cluster") → Database → Schema → Table.

-- * Every new database already has a schema called `public`. If you don't write a schema name, tables go into `public`.

-- * One query can join tables from different schemas of the same database, but NOT from a different database (MySQL can do `db1.t1 JOIN db2.t2`; PostgreSQL needs the `postgres_fdw` / `dblink` extension for that).

CREATE DATABASE sales_db;            -- Level 2
-- (psql/client command — run it in psql, not in a GUI query tool):
-- \c sales_db                           -- psql command: connect to the database (MySQL: USE sales_db;)

CREATE SCHEMA orders;                 -- Level 3
CREATE TABLE orders.order_items (     -- Level 4: schema.table
    id SERIAL PRIMARY KEY,
    product VARCHAR(100)
);

SELECT * FROM orders.order_items;     -- schema-qualified name

SET search_path TO orders, public;    -- now you can write just: SELECT * FROM order_items;

-- ---

-- ------------------------------------------------------------
-- 6.2 The Starting Point: Server
-- ------------------------------------------------------------

-- * Q. What is a Database Server?

--   * Definition: A Database Server is the computer (physical machine or cloud VM) that runs the database software. It stores the data, runs queries and handles security.

--   * Core Functions:

--     * Provides storage for one or more databases.

--     * Accepts network connections from apps, developers and reporting tools.

--     * Reads, optimizes and runs incoming queries.

--     * Handles user logins, encryption, backups and crash recovery.

-- ---

-- ------------------------------------------------------------
-- 6.3 The Container: Database
-- ------------------------------------------------------------

-- * Q. What is a Database container?

--   * Definition: A database is a collection of related data, stored as a separate container inside the database server.

--   * Core Functions:

--     * Keeps business data in one secure, organized place that can be queried.

--     * Keeps the data of different applications or departments separate from each other.

--   * Real-World Examples:

--     * `Employee Database` (personnel records, compensation, department assignments)

--     * `Student Database` (enrollments, grades, academic transcripts)

--     * `Hospital Database` (patient charts, clinician schedules, medical prescriptions)

-- ---

-- ------------------------------------------------------------
-- 6.4 The Logical Organizer: Schema
-- ------------------------------------------------------------

-- * Q. What is a Schema and why are schemas essential in enterprise databases?

--   * Definition: A schema is a logical folder inside a database that groups tables and other objects. The word also means the structure (blueprint) of those objects.

--   * Why do we need Schemas?

--     * Big systems have hundreds of tables. Keeping all of them in one flat list causes name clashes and is hard to manage.

--     * Schemas split the tables into groups:

--       * Cart, checkout, payment, and invoice tables $\rightarrow$ categorized under the orders schema.

--       * Authentication, profiles, and billing addresses $\rightarrow$ categorized under the customers schema.

-- ---

-- ------------------------------------------------------------
-- 6.5 Types of Schemas (Logical vs. Physical)
-- ------------------------------------------------------------

-- Databases are designed in two complementary layers: Logical and Physical.

-- (Dimension → Logical Schema | Physical Schema)
--
-- * Definition
--     - Logical Schema  : Design of the tables and how they are related.
--     - Physical Schema : How the data is actually stored on disk (files, partitions, indexes).
--
-- * Core Focus
--     - Logical Schema  : What data is stored and how tables relate.
--     - Physical Schema : How data is physically laid out, indexed, and partitioned on disk.
--
-- * Key Question
--     - Logical Schema  : "What data do we store and how is it connected?"
--     - Physical Schema : "How and where is the data stored on disk?"
--
-- * Components
--     - Logical Schema  : Tables, column datatypes, relationships, constraints.
--     - Physical Schema : Filepaths, tablespaces, data files under PGDATA/base/, partitions, B-tree block sizes.
--
-- * Primary Audience
--     - Logical Schema  : Developers, Data Analysts, Data Modelers.
--     - Physical Schema : Database Administrators (DBAs), Storage Engineers, DB Engines.
--
-- * Visibility
--     - Logical Schema  : Visible to developers and SQL queries.
--     - Physical Schema : Hidden inside the storage engine.
--

-- ------------------------------------------------------------
-- 1. Logical Schema (The Conceptual Blueprint)
-- ------------------------------------------------------------

-- * Definition: The Logical Schema describes the tables, columns, relationships and rules — without caring how they are stored on disk.

-- * Example: every row in `Orders` must point to an existing `Customer_ID` in `Customers`.

-- ------------------------------------------------------------
-- 2. Physical Schema (The Hardware Storage Blueprint)
-- ------------------------------------------------------------

-- * Definition: The Physical Schema describes how the data is actually stored — files, locations, partitions and indexes.

-- * Example: keep old 2020 data on cheaper, slower disks and current 2026 data on fast NVMe SSDs.

-- ---

-- ------------------------------------------------------------
-- 6.6 The Core Object: Table, Columns, Rows & Cells
-- ------------------------------------------------------------

-- * Q. What is a Table and what constitutes its anatomy?

--   * Definition: A Table stores data in rows (horizontal) and columns (vertical), like an Excel sheet.

-- (Customer_ID → Customer_Name | City)
--
-- * 101
--     - Customer_Name : Rahul
--     - City          : Pune
--
-- * 102
--     - Customer_Name : Priya
--     - City          : Mumbai
--
-- * 103
--     - Customer_Name : Amit
--     - City          : Nashik
--

-- ------------------------------------------------------------
-- 1. Columns (Fields / Attributes)
-- ------------------------------------------------------------

-- * A column stores one property (attribute) for every row, e.g. `City`.

-- * Each column is bound to a single, strict Data Type (`INT`, `VARCHAR`, `DATE`, `DECIMAL`).

-- * Examples: `Customer_ID`, `Customer_Name`, `City`, `Age`.

-- ------------------------------------------------------------
-- 2. Rows (Records / Tuples)
-- ------------------------------------------------------------

-- * A row is one complete record, e.g. one customer.

-- * Example: The row `[101 | Rahul | Pune]` is one complete customer.

-- ------------------------------------------------------------
-- 3. Cell (Single Value)
-- ------------------------------------------------------------

-- * The meeting point of one row and one column — a single value (e.g., `101` or `'Rahul'`).

-- * Every cell must follow the column's data type and rules (constraints).

-- ---

-- ------------------------------------------------------------
-- 6.7 The Fingerprint: Primary Key
-- ------------------------------------------------------------

-- * Q. What is a Primary Key and what are its 5 essential properties?

--   * Definition: A Primary Key is a column (or a group of columns) that uniquely identifies every row in a table.

--   * Like a fingerprint: no two rows can ever have the same Primary Key value.

-- (Customer_ID (🔑 Primary Key) → Customer_Name | City)
--
-- * 101
--     - Customer_Name : Rahul
--     - City          : Pune
--
-- * 102
--     - Customer_Name : Priya
--     - City          : Mumbai
--

-- * The 5 Core Properties of a Primary Key:

--   1. Unique: Every row must hold a distinct, non-duplicate key value.

--   2. Cannot be NULL: Primary keys can never contain empty or missing values.

--   3. Only ONE per Table: Each table is restricted to exactly one primary key definition.

--   4. Automatic Index: PostgreSQL automatically builds a unique B-Tree index on it, so lookups by key are very fast. (Unlike MySQL InnoDB, this index is not clustered — the table itself is a heap; see Topic 42.)

--   5. Referential Anchor: Serves as the referenced parent key for Foreign Keys in child tables.

-- ---

-- ------------------------------------------------------------
-- 6.8 PostgreSQL Data Types In-Depth
-- ------------------------------------------------------------

-- Definition: A data type tells what kind of value a column can store (number, text, date…), how much space it takes, and what operations can be done on it.

-- > 🐘 Big picture (MySQL vs PostgreSQL): PostgreSQL has a richer and stricter type system. There is no `TINYINT`, `MEDIUMINT`, `UNSIGNED`, `DATETIME`, `YEAR` or `SET`. Instead PostgreSQL gives a real `BOOLEAN`, `TEXT` without size limit, `TIMESTAMPTZ`, `INTERVAL`, `UUID`, `JSONB`, arrays (`TEXT[]`) and many more.

-- ---

-- ------------------------------------------------------------
-- 6.8.1 Memory Classification: Fixed Data Types vs. Variable Data Types
-- ------------------------------------------------------------

-- Q. What are the two main types of data types based on memory allocation in PostgreSQL?

-- Based on how much space they use, data types are of 2 kinds:

-- 1. Fixed Data Type (Fixed Storage Allocation):

--    * Definition: Fixed data types always take the same amount of space, no matter what the value is.

--    * They are best used when the size of data is known, uniform, and consistent across all rows.

--    * `CHAR(n)` is the text example: if the inserted value is shorter than `n`, PostgreSQL pads it with spaces up to `n` characters.

--    * Key Examples: `SMALLINT` (2 B), `INTEGER` (4 B), `BIGINT` (8 B), `REAL` (4 B), `DOUBLE PRECISION` (8 B), `DATE` (4 B), `TIMESTAMP` (8 B), `BOOLEAN` (1 B), `UUID` (16 B), `CHAR(n)`.

--    * Performance Advantage: Fixed-size columns let PostgreSQL find a column inside a row quickly.

-- 2. Variable Data Type (Dynamic Storage Allocation):

--    * Definition: Variable data types take only as much space as the actual value, plus a small length header.

--    * Length header: 1 byte for short values (up to 126 bytes), 4 bytes for longer values.

--    * Key Examples: `VARCHAR(n)`, `TEXT`, `BYTEA`, `NUMERIC`, `JSONB`, arrays.

--    * Space Advantage: Saves a lot of space when value lengths differ a lot from row to row.

--    * TOAST: When a value is very large (around 2 KB or more), PostgreSQL automatically compresses it and/or moves it to a separate TOAST table. You don't have to do anything.

-- ------------------------------------------------------------
-- Comparison: Fixed vs. Variable Data Types
-- ------------------------------------------------------------

-- (Feature / Dimension → Fixed Data Types (e.g., CHAR(10)) | Variable Data Types (e.g., VARCHAR(10)))
--
-- * Storage Allocation
--     - Fixed Data Types (e.g., CHAR(10))       : Takes fixed, predetermined storage size
--     - Variable Data Types (e.g., VARCHAR(10)) : Takes storage based on actual value length
--
-- * Space Utilization
--     - Fixed Data Types (e.g., CHAR(10))       : Can waste space if values are short (CHAR pads with spaces)
--     - Variable Data Types (e.g., VARCHAR(10)) : Space-efficient (actual length + 1 or 4 byte header)
--
-- * Read / Write Speed
--     - Fixed Data Types (e.g., CHAR(10))       : No real speed benefit for text in PostgreSQL
--     - Variable Data Types (e.g., VARCHAR(10)) : Same speed as CHAR in PostgreSQL
--
-- * Space Overhead
--     - Fixed Data Types (e.g., CHAR(10))       : Header + padding for CHAR; no header for numbers
--     - Variable Data Types (e.g., VARCHAR(10)) : 1 byte (short values) or 4 bytes (long values)
--
-- * Space Padding
--     - Fixed Data Types (e.g., CHAR(10))       : CHAR is padded with spaces
--     - Variable Data Types (e.g., VARCHAR(10)) : No padding; stored exactly as entered
--
-- * Best Used When
--     - Fixed Data Types (e.g., CHAR(10))       : Numbers, dates, flags
--     - Variable Data Types (e.g., VARCHAR(10)) : Text whose length varies
--
-- * Primary Examples
--     - Fixed Data Types (e.g., CHAR(10))       : INTEGER, BIGINT, DATE, BOOLEAN, CHAR(n)
--     - Variable Data Types (e.g., VARCHAR(10)) : VARCHAR(n), TEXT, BYTEA, NUMERIC, JSONB
--

-- > 🐘 Important PostgreSQL fact: In PostgreSQL, `CHAR(n)` is NOT faster than `VARCHAR(n)` or `TEXT`. The official docs say `CHAR(n)` is usually the slowest of the three because of the padding work. Most PostgreSQL developers use `TEXT` or `VARCHAR(n)` for all strings.

-- ------------------------------------------------------------
-- Practical Example to Understand Memory Storage (CHAR(10) vs. VARCHAR(10))
-- ------------------------------------------------------------

-- Suppose we create two columns: `code_fixed CHAR(10)` and `code_var VARCHAR(10)`, and store the same string values (English letters = 1 byte each). Notice how PostgreSQL stores them:

-- (Inserted String → Actual Length | CHAR(10) Physical Storage | Bytes Used (CHAR(10)) | VARCHAR(10) Physical Storage | Bytes Used (VARCHAR(10)) | Memory Saved by VARCHAR)
--
-- * '' (Empty)
--     - Actual Length                : 0 chars
--     - CHAR(10) Physical Storage    : '          ' (10 spaces)
--     - Bytes Used (CHAR(10))        : 11 Bytes (1 + 10)
--     - VARCHAR(10) Physical Storage : [0] (header only)
--     - Bytes Used (VARCHAR(10))     : 1 Byte
--     - Memory Saved by VARCHAR      : 10 Bytes
--
-- * 'AB'
--     - Actual Length                : 2 chars
--     - CHAR(10) Physical Storage    : 'AB        ' (2 chars + 8 spaces)
--     - Bytes Used (CHAR(10))        : 11 Bytes
--     - VARCHAR(10) Physical Storage : [2] + 'AB'
--     - Bytes Used (VARCHAR(10))     : 3 Bytes (1 + 2)
--     - Memory Saved by VARCHAR      : 8 Bytes
--
-- * 'Pune'
--     - Actual Length                : 4 chars
--     - CHAR(10) Physical Storage    : 'Pune      ' (4 chars + 6 spaces)
--     - Bytes Used (CHAR(10))        : 11 Bytes
--     - VARCHAR(10) Physical Storage : [4] + 'Pune'
--     - Bytes Used (VARCHAR(10))     : 5 Bytes (1 + 4)
--     - Memory Saved by VARCHAR      : 6 Bytes
--
-- * 'India'
--     - Actual Length                : 5 chars
--     - CHAR(10) Physical Storage    : 'India     ' (5 chars + 5 spaces)
--     - Bytes Used (CHAR(10))        : 11 Bytes
--     - VARCHAR(10) Physical Storage : [5] + 'India'
--     - Bytes Used (VARCHAR(10))     : 6 Bytes (1 + 5)
--     - Memory Saved by VARCHAR      : 5 Bytes
--
-- * '0123456789'
--     - Actual Length                : 10 chars
--     - CHAR(10) Physical Storage    : '0123456789' (no spaces)
--     - Bytes Used (CHAR(10))        : 11 Bytes
--     - VARCHAR(10) Physical Storage : [10] + '0123456789'
--     - Bytes Used (VARCHAR(10))     : 11 Bytes (1 + 10)
--     - Memory Saved by VARCHAR      : 0 Bytes
--

-- ------------------------------------------------------------
-- Visual Memory Layout Diagram
-- ------------------------------------------------------------

-- ┌── (text — not SQL, shown for reference) ──
-- │ Storing 'Pune' (4 characters) in a 10-character column:
-- │ 
-- │ CHAR(10) (always 10 characters + 1 header byte):
-- │ +--------+---+---+---+---+---+---+---+---+---+---+
-- │ | Header | P | u | n | e |   |   |   |   |   |   |  -> 11 Bytes
-- │ +--------+---+---+---+---+---+---+---+---+---+---+
-- │                           ^^^^^^^^^^^^^^^^^^^^^^
-- │                           (6 padded space bytes wasted)
-- │ 
-- │ VARCHAR(10) / TEXT (only what you store + 1 header byte):
-- │ +--------+---+---+---+---+
-- │ | Header | P | u | n | e |  -> Only 5 Bytes total
-- │ +--------+---+---+---+---+
-- └──

-- ------------------------------------------------------------
-- Hands-On SQL Demonstration: Fixed vs Variable Storage
-- ------------------------------------------------------------

-- 1. Create demonstration table
CREATE TABLE storage_comparison (
    id SERIAL PRIMARY KEY,           -- PostgreSQL auto-number (instead of AUTO_INCREMENT)
    description VARCHAR(30),
    country_iso_fixed CHAR(10),      -- Fixed allocation (padded)
    country_name_var VARCHAR(10)     -- Dynamic allocation
);

-- 2. Insert sample rows with varying lengths
INSERT INTO storage_comparison (description, country_iso_fixed, country_name_var)
VALUES
    ('Two characters', 'IN', 'IN'),
    ('Four characters', 'Pune', 'Pune'),
    ('Full ten characters', '0123456789', '0123456789');

-- 3. Query actual character length vs storage consumption
SELECT
    description,
    country_iso_fixed,
    CHAR_LENGTH(country_iso_fixed)  AS fixed_char_count,   -- trailing spaces NOT counted
    pg_column_size(country_iso_fixed) AS fixed_bytes_stored,
    country_name_var,
    CHAR_LENGTH(country_name_var)   AS var_char_count,
    pg_column_size(country_name_var) AS var_bytes_stored
FROM storage_comparison;

-- * `pg_column_size()` is a PostgreSQL function that shows how many bytes a value really takes (MySQL has no direct equivalent; there we used `OCTET_LENGTH`).

-- > [!TIP]
-- > Production Rule of Thumb (PostgreSQL):
-- > * Use `TEXT` or `VARCHAR(n)` for almost all strings — names, emails, cities, URLs, addresses.
-- > * Use `VARCHAR(n)` only when you really want a maximum length rule (e.g., `VARCHAR(10)` for a phone number).
-- > * `CHAR(n)` is rarely used in PostgreSQL. If you need "exactly 2 letters", use `VARCHAR(2)` or `TEXT` with a `CHECK (length(code) = 2)` constraint.

-- ---

-- ------------------------------------------------------------
-- 6.8.2 Numeric Data Types
-- ------------------------------------------------------------

-- Q. What are the primary Numeric Data Types in PostgreSQL and their storage ranges?

-- Numeric data types store numbers and are broadly divided into Integers (Whole Numbers), Exact Decimals and Floating-Point Numbers.

-- ------------------------------------------------------------
-- 1. Integer Data Types (Whole Numbers)
-- ------------------------------------------------------------
-- Stores whole numbers (no decimals). ⚠️ PostgreSQL has no `TINYINT`, no `MEDIUMINT` and no `UNSIGNED`. Use a `CHECK (col >= 0)` constraint if you need "only positive".

-- * `SMALLINT` (alias `INT2`):

--   - Storage Size: 2 Bytes (16 bits).

--   - Range: `-32,768` to `32,767`.

--   - Best for: Age, status codes, small quantities, years (this replaces MySQL `TINYINT` / `YEAR`).

-- * `INTEGER` / `INT` (alias `INT4`):

--   - Storage Size: 4 Bytes (32 bits).

--   - Stores whole numbers (no decimals).

--   - Range: `-2,147,483,648` to `2,147,483,647` (~2.14 Billion).

--   - Best for: Standard table primary keys, employee IDs, customer numbers.

-- * `BIGINT` (alias `INT8`):

--   - Storage Size: 8 Bytes (64 bits).

--   - Stores very large whole numbers.

--   - Range: `-9,223,372,036,854,775,808` to `9,223,372,036,854,775,807` (about ±9 quintillion).

--   - Best for: High-volume financial transactions, global e-commerce order tracking, social media view counts.

-- ------------------------------------------------------------
-- 2. Auto-Increment Types: `SERIAL` and `IDENTITY` (PostgreSQL way of AUTO_INCREMENT)
-- ------------------------------------------------------------

-- * MySQL uses `AUTO_INCREMENT`. PostgreSQL uses a sequence behind the scenes. There are two ways to write it:

-- (PostgreSQL → Size | Same as MySQL)
--
-- * SMALLSERIAL
--     - Size          : 2 B
--     - Same as MySQL : SMALLINT AUTO_INCREMENT
--
-- * SERIAL
--     - Size          : 4 B
--     - Same as MySQL : INT AUTO_INCREMENT
--
-- * BIGSERIAL
--     - Size          : 8 B
--     - Same as MySQL : BIGINT AUTO_INCREMENT
--
-- * INT GENERATED ALWAYS AS IDENTITY
--     - Size          : 4 B
--     - Same as MySQL : INT AUTO_INCREMENT (SQL-standard, recommended in new code)
--

-- Old style (still very common)
CREATE TABLE customers (
    id   SERIAL PRIMARY KEY,
    name VARCHAR(100)
);

-- New SQL-standard style (PostgreSQL 10+)
CREATE TABLE customers2 (
    id   INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(100)
);

INSERT INTO customers (name) VALUES ('Rahul') RETURNING id;   -- RETURNING gives back the new id

-- * `RETURNING id` is a PostgreSQL feature: the `INSERT` itself returns the new id (MySQL needs a separate `SELECT LAST_INSERT_ID();`).

-- * `GENERATED ALWAYS` blocks manual id values (error if you try `INSERT ... (id) VALUES (5)`); `GENERATED BY DEFAULT` allows them.

-- ------------------------------------------------------------
-- 3. Exact Numeric Data Type: `NUMERIC(p, s)` / `DECIMAL(p, s)`
-- ------------------------------------------------------------

-- * Definition: `NUMERIC` (same as `DECIMAL` in PostgreSQL) stores exact numeric values (not approximate) with user-defined precision and scale.

-- * Used for exact decimal values like prices and money.

-- * Parameters:

--   - `p` = Precision: Total number of significant digits (both before and after the decimal point). Up to 1000 when you give `p`.

--   - `s` = Scale: Number of digits after the decimal point.

--   - `NUMERIC` without `(p, s)` can store almost any size of number exactly (up to 131,072 digits before the point).

-- * Core Characteristics:

--   - Stores exact numbers (not approximate).

--   - Does not suffer from binary floating-point rounding inaccuracies.

--   - Best for: Money, financial accounting, banking balances, product prices.

--   - Example: `NUMERIC(10, 2)` stores numbers up to `99,999,999.99`.

-- * PostgreSQL also has a `MONEY` type, but most teams avoid it (it depends on the locale setting). Use `NUMERIC(12, 2)` for money.

-- ------------------------------------------------------------
-- 4. Approximate Numeric Data Types: `REAL` & `DOUBLE PRECISION`
-- ------------------------------------------------------------
-- Stores approximate decimal numbers (floating-point representation).

-- * `REAL` (alias `FLOAT4`) — MySQL `FLOAT`:

--   - Storage Size: 4 Bytes.

--   - Less precision (~6 decimal digits of precision).

--   - Used for approximate decimal values.

-- * `DOUBLE PRECISION` (alias `FLOAT8`, `FLOAT`) — MySQL `DOUBLE`:

--   - Storage Size: 8 Bytes.

--   - More precision (~15 decimal digits of precision).

--   - Used for higher-accuracy scientific calculations.

-- * Core Characteristics:

--   - Store approximate decimal numbers (floating point).

--   - Used in science, engineering and statistics where speed matters more than exact accuracy. ⚠️ Never use `REAL`/`DOUBLE PRECISION` for money — use `NUMERIC`.

--   - PostgreSQL extra: these types can also store `'NaN'`, `'Infinity'` and `'-Infinity'`.

-- ---

-- ------------------------------------------------------------
-- 6.8.3 String, Text, Binary & Specialized Data Types
-- ------------------------------------------------------------

-- Q. What are the String, Text, Binary, and Category Data Types available in PostgreSQL?

-- ------------------------------------------------------------
-- 1. `CHAR(n)` / `CHARACTER(n)` (Fixed-Length String)
-- ------------------------------------------------------------

-- * Definition: CHAR(n) is a fixed-length string. It always stores n characters, even if the value is shorter.

-- * Core Characteristics:

--   - Fixed length string: Shorter values are padded with spaces up to `n`.

--   - Trailing spaces are ignored when comparing (`'AB'::CHAR(5) = 'AB   '` is true) and removed when you convert to `TEXT`.

--   - Performance: Not faster in PostgreSQL (see the tip in 6.8.1).

--   - Range: `n` can be up to about 10,485,760 characters (MySQL: 255).

--   - Wastes Space: Wastes space if the inserted data is shorter than `n`.

--   - Use Cases: Rarely needed. Fixed codes like `'IN'`, `'US'`, `'INR'` can use it, but `VARCHAR(n)` / `TEXT` is preferred.

-- ------------------------------------------------------------
-- 2. `VARCHAR(n)` / `CHARACTER VARYING(n)` (Variable-Length String)
-- ------------------------------------------------------------

-- * Definition: VARCHAR(n) is a variable-length string with a maximum of `n` characters. It stores only the characters you insert, plus a 1 or 4 byte header.

-- * Core Characteristics:

--   - Variable length string: Uses space based on the actual string length.

--   - Inserting a longer value gives an error: `value too long for type character varying(10)` (no silent cut).

--   - `VARCHAR` without `(n)` has no limit — it behaves exactly like `TEXT`.

--   - Range: `n` up to 10,485,760 characters; any single value can be up to 1 GB.

--   - Space Efficient: No space padding.

--   - Best Use Cases: Customer names, email addresses, street addresses, descriptions, URLs.

-- ------------------------------------------------------------
-- Comparison: `CHAR` vs. `VARCHAR` vs. `TEXT` (PostgreSQL)
-- ------------------------------------------------------------

-- (Feature / Dimension → CHAR(n) | VARCHAR(n) | TEXT)
--
-- * String Length Type
--     - CHAR(n)    : Fixed-length
--     - VARCHAR(n) : Variable, max n
--     - TEXT       : Variable, no max
--
-- * Storage
--     - CHAR(n)    : Padded with spaces to n
--     - VARCHAR(n) : Actual length + header
--     - TEXT       : Actual length + header
--
-- * Performance
--     - CHAR(n)    : Slightly slowest
--     - VARCHAR(n) : Same as TEXT
--     - TEXT       : Fastest / simplest
--
-- * Maximum
--     - CHAR(n)    : ~10 million chars
--     - VARCHAR(n) : ~10 million chars (n)
--     - TEXT       : 1 GB per value
--
-- * Trailing Spaces
--     - CHAR(n)    : Ignored in comparisons
--     - VARCHAR(n) : Kept as entered
--     - TEXT       : Kept as entered
--
-- * Use Cases
--     - CHAR(n)    : Rare (fixed codes)
--     - VARCHAR(n) : When a max length rule is needed
--     - TEXT       : Default choice for strings
--

-- ------------------------------------------------------------
-- 3. `TEXT` (Long Text Strings)
-- ------------------------------------------------------------

-- * PostgreSQL has only one `TEXT` type. There is no `TINYTEXT`, `MEDIUMTEXT` or `LONGTEXT`.

-- * `TEXT` can store up to 1 GB per value.

-- * Best for: Blog articles, product descriptions, customer feedback, HTML/XML content — and also short strings like names (`TEXT` is fine for everything).

-- ------------------------------------------------------------
-- 4. `BYTEA` (Binary Data) — PostgreSQL version of `BLOB`
-- ------------------------------------------------------------

-- * Definition: `BYTEA` ("byte array") stores raw binary data (files), not text.

-- * Stores binary data (images, files, PDFs, audio clips) up to 1 GB.

-- * There are no `TINYBLOB` / `MEDIUMBLOB` / `LONGBLOB` variants — just `BYTEA`.

-- * Difference from TEXT: `BYTEA` has no character set; it is plain bytes.

-- * Tip: For big files, most apps store the file in cloud storage (S3) and keep only the URL in a `TEXT` column.

-- ------------------------------------------------------------
-- 5. `BIT(n)` & `BIT VARYING(n)`
-- ------------------------------------------------------------

-- * `BIT(n)`: Fixed-length string of bits, e.g. `B'1010'`.

-- * `BIT VARYING(n)` / `VARBIT(n)`: Variable-length bit string.

-- * For binary strings (MySQL `BINARY` / `VARBINARY`) use `BYTEA`.

-- * If you don't give a `DEFAULT`, the column is `NULL` when no value is inserted.

-- ------------------------------------------------------------
-- 6. `BOOLEAN` / `BOOL`
-- ------------------------------------------------------------

-- * Definition: In PostgreSQL, BOOLEAN is a real type (1 byte) with three states: `TRUE`, `FALSE` and `NULL`.

-- * Not a number alias like MySQL (`TINYINT(1)`). `SELECT TRUE;` shows `t`, not `1`.

-- * Accepted inputs: `TRUE`/`FALSE`, `'t'`/`'f'`, `'yes'`/`'no'`, `'on'`/`'off'`, `'1'`/`'0'`.

-- * ⚠️ `WHERE is_active = 1` gives an error in PostgreSQL (`operator does not exist: boolean = integer`). Write `WHERE is_active` or `WHERE is_active = TRUE`.

-- * Tip: add `DEFAULT FALSE` if new rows should start as false (otherwise the default is `NULL`).

-- ------------------------------------------------------------
-- 7. ENUM (Custom Type with `CREATE TYPE`)
-- ------------------------------------------------------------

-- * Definition: An ENUM stores ONE value from a fixed list of allowed values.

-- * In PostgreSQL you first create the enum as its own type, then use it in tables (MySQL writes the list inside the column):

CREATE TYPE account_status AS ENUM ('active', 'inactive', 'pending');

CREATE TABLE accounts (
    id     SERIAL PRIMARY KEY,
    status account_status DEFAULT 'pending'
);

INSERT INTO accounts (status) VALUES ('active');    -- OK
INSERT INTO accounts (status) VALUES ('deleted');   -- ERROR: invalid input value for enum

-- * Add a new value later: `ALTER TYPE account_status ADD VALUE 'blocked';`

-- * Many teams use `VARCHAR` + `CHECK (status IN ('active', 'inactive', 'pending'))` instead, because a CHECK is easier to change.

-- ------------------------------------------------------------
-- 8. Arrays — PostgreSQL replacement for MySQL `SET`
-- ------------------------------------------------------------

-- * PostgreSQL has no `SET` type. To store MULTIPLE values in one column, use an array type like `TEXT[]` (any type can be an array).

CREATE TABLE students (
    id      SERIAL PRIMARY KEY,
    name    TEXT,
    hobbies TEXT[]                         -- array of text
);

INSERT INTO students (name, hobbies)
VALUES ('Vishal', ARRAY['Reading', 'Coding']);   -- or '{Reading,Coding}'

SELECT name FROM students WHERE 'Coding' = ANY(hobbies);   -- contains Coding?
SELECT name, hobbies[1] AS first_hobby FROM students;       -- arrays start at 1, not 0

-- * To limit array values to a fixed list (like `SET`), use an enum array: `hobbies hobby_type[]`.

-- ------------------------------------------------------------
-- 9. Extra PostgreSQL-only Types (Not in MySQL)
-- ------------------------------------------------------------

-- (Type → What it stores | Example)
--
-- * UUID
--     - What it stores : 128-bit unique id (16 bytes)
--     - Example        : gen_random_uuid() → 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11'
--
-- * INTERVAL
--     - What it stores : A length of time
--     - Example        : INTERVAL '2 days 3 hours'
--
-- * INET / CIDR
--     - What it stores : IP address / network
--     - Example        : '192.168.1.10'
--
-- * MACADDR
--     - What it stores : Network card address
--     - Example        : '08:00:2b:01:02:03'
--
-- * JSONB
--     - What it stores : Binary JSON document (see 6.8.8)
--     - Example        : '{"age": 25}'
--
-- * TSVECTOR
--     - What it stores : Full-text search document
--     - Example        : to_tsvector('english', 'SQL notes')
--
-- * Range types
--     - What it stores : A range of values
--     - Example        : INT4RANGE(1, 10), DATERANGE('2026-01-01', '2026-12-31')
--

-- ---

-- ------------------------------------------------------------
-- 6.8.4 Date and Time (Temporal) Data Types
-- ------------------------------------------------------------

-- Q. What are the Temporal (Date and Time) Data Types in PostgreSQL?

-- It is also known as the temporal data type family.

-- * Default Date Format: PostgreSQL shows dates in ISO format **`YYYY-MM-DD`** (controlled by the `DateStyle` setting).

-- * Memory Allocation: 4 bytes for a single `DATE` (MySQL: 3 bytes).

-- * Supported Range for Date: `4713 BC` to `5874897 AD` (much bigger than MySQL's `1000–9999`).

-- ------------------------------------------------------------
-- 1. `DATE`
-- ------------------------------------------------------------

-- * Stores date only (`YYYY-MM-DD`).

-- * Storage: 4 Bytes.

-- * Range: `4713 BC` to `5874897 AD`.

-- * Example: `'2026-09-21'` or `DATE '2026-09-21'`.

-- ------------------------------------------------------------
-- 2. `TIME` and `TIMETZ`
-- ------------------------------------------------------------

-- * `TIME` stores time of day only (`HH:MM:SS`, with up to 6 fractional digits).

-- * Storage: 8 Bytes.

-- * Range: `00:00:00` to `24:00:00` — only one day (MySQL `TIME` can go up to `838:59:59`; for durations PostgreSQL uses `INTERVAL`).

-- * Example: `'15:45:30'`.

-- * `TIME WITH TIME ZONE` (`TIMETZ`) also exists, but the docs advise not to use it.

-- ------------------------------------------------------------
-- 3. No `YEAR` type
-- ------------------------------------------------------------

-- * PostgreSQL has no `YEAR` type. Use `SMALLINT` (with `CHECK (yr BETWEEN 1900 AND 2100)`) or a `DATE`, and get the year with `EXTRACT(YEAR FROM some_date)`.

-- ------------------------------------------------------------
-- 4. `TIMESTAMP` (= `TIMESTAMP WITHOUT TIME ZONE`) — PostgreSQL version of MySQL `DATETIME`
-- ------------------------------------------------------------

-- * Stores both date and time in format: **`YYYY-MM-DD HH:MM:SS`** (microsecond precision).

-- * Storage: 8 Bytes.

-- * Range: `4713 BC` to `294276 AD` (no 2038 problem).

-- * Key Characteristics:

--   - No time zone conversion. Stores exactly what you insert.

--   - `DATETIME` doesn't exist in PostgreSQL — `TIMESTAMP` is the same idea.

--   - Useful when the value must look the same everywhere, whatever the time zone (birthdays, schedules).

-- ------------------------------------------------------------
-- 5. `TIMESTAMPTZ` (= `TIMESTAMP WITH TIME ZONE`) — PostgreSQL version of MySQL `TIMESTAMP`
-- ------------------------------------------------------------

-- * Stores an exact moment in time.

-- * Storage: 8 Bytes (does NOT store the time zone name — it converts to UTC).

-- * Range: `4713 BC` to `294276 AD` (no 2038 problem, unlike MySQL `TIMESTAMP`).

-- * Key Characteristics:

--   - On insert, the value is converted from your session time zone to UTC.

--   - On read, it is converted from UTC to the session time zone (`SET TIME ZONE 'Asia/Kolkata';`).

--   - Recommended for `created_at`, `updated_at`, logs and audit trails.

--   - There is no `ON UPDATE CURRENT_TIMESTAMP` in PostgreSQL. To auto-update `updated_at`, use a trigger (see Topic 37).

-- ------------------------------------------------------------
-- 6. `INTERVAL` (PostgreSQL extra)
-- ------------------------------------------------------------

-- * Stores a length of time: `INTERVAL '1 day'`, `INTERVAL '2 hours 30 minutes'`, `INTERVAL '3 months'`.

-- * Storage: 16 Bytes.

-- * Subtracting two timestamps gives an interval: `SELECT TIMESTAMP '2026-01-02 10:00' - TIMESTAMP '2026-01-01 08:00';` → `1 day 02:00:00`.

-- ---

-- ------------------------------------------------------------
-- 6.8.5 What is UTC (Coordinated Universal Time) & Why Does It Matter?
-- ------------------------------------------------------------

-- Q. What is UTC?

-- * Definition: UTC (Coordinated Universal Time) is the global time standard used to coordinate clocks around the world.

-- * It is the base reference time zone — all other time zones are defined as offsets from UTC.

-- * UTC = World's "neutral" time.

-- * It does not change with location or daylight savings.

-- * Every local time zone is expressed as:
--   $$\text{Local Time} = \text{UTC} \pm \text{offset}$$
--   (For example: IST = $\text{UTC} + 5:30$).

-- * In PostgreSQL (TIMESTAMPTZ and UTC):

--   - PostgreSQL internally stores `TIMESTAMPTZ` values in UTC, then:

--     1. Converts to your session time zone (`SHOW timezone;`) when you read them.

--     2. Converts from your session time zone to UTC when you insert them.

--   - Example:

SET TIME ZONE 'Asia/Kolkata';
SELECT TIMESTAMPTZ '2026-09-21 10:00:00+05:30';   -- 2026-09-21 10:00:00+05:30

SET TIME ZONE 'UTC';
SELECT TIMESTAMPTZ '2026-09-21 10:00:00+05:30';   -- 2026-09-21 04:30:00+00 (same moment)

SELECT NOW() AT TIME ZONE 'America/New_York';     -- show current time in New York

-- Q. Why Does UTC Matter?

-- 1. Keeps timestamps consistent across servers: In multi-region deployments, servers across different continents all log events consistently.

-- 2. Prevents confusion between time zones: Eliminates time-shifting bugs caused by regional Daylight Saving Time changes.

-- 3. Useful for global applications, scheduling, and logging: Ensures events are sequentially ordered worldwide.

-- 4. Clean display to end-users: You can always convert UTC $\rightarrow$ Local time when displaying records to users in their localized interface.

-- ---

-- ------------------------------------------------------------
-- 6.8.6 Differences Between TIMESTAMP and TIMESTAMPTZ
-- ------------------------------------------------------------

-- Q. What is the difference between TIMESTAMP and TIMESTAMPTZ in PostgreSQL? (Same question as "DATETIME vs TIMESTAMP" in MySQL.)

-- (Feature / Dimension → TIMESTAMP (without time zone) | TIMESTAMPTZ (with time zone))
--
-- * 1. MySQL equivalent
--     - TIMESTAMP (without time zone) : DATETIME
--     - TIMESTAMPTZ (with time zone)  : TIMESTAMP
--
-- * 2. Display Format
--     - TIMESTAMP (without time zone) : 2026-09-21 10:00:00
--     - TIMESTAMPTZ (with time zone)  : 2026-09-21 10:00:00+05:30
--
-- * 3. Storage Size
--     - TIMESTAMP (without time zone) : 8 Bytes
--     - TIMESTAMPTZ (with time zone)  : 8 Bytes
--
-- * 4. Supported Range
--     - TIMESTAMP (without time zone) : 4713 BC to 294276 AD
--     - TIMESTAMPTZ (with time zone)  : 4713 BC to 294276 AD (no 2038 limit)
--
-- * 5. Time Zone Handling
--     - TIMESTAMP (without time zone) : No conversion; stores exactly what you insert.
--     - TIMESTAMPTZ (with time zone)  : Converted to UTC on insert, back to session time zone on read.
--
-- * 6. Auto-Update Capability
--     - TIMESTAMP (without time zone) : DEFAULT now() on insert; no ON UPDATE (use a trigger).
--     - TIMESTAMPTZ (with time zone)  : Same: DEFAULT now(); update via trigger.
--
-- * 7. Best Use Cases
--     - TIMESTAMP (without time zone) : Birthdays, historical dates, "local" appointment times.
--     - TIMESTAMPTZ (with time zone)  : created_at, updated_at, logs, audit trails, anything global.
--

-- ------------------------------------------------------------
-- Point-Wise Detailed Breakdown:
-- ------------------------------------------------------------

-- 1. `TIMESTAMP` (without time zone) Details:

--    - Stores date and time: `YYYY-MM-DD HH:MM:SS[.ffffff]`.

--    - Storage size: 8 bytes.

--    - Range: `4713 BC` → `294276 AD`.

--    - Does not store or convert time zones. Stores exactly what you insert.

--    - Use when you need a date & time exactly as given, independent of time zones.

--    - Example: Birthdays, historical events, schedule times.

-- 2. `TIMESTAMPTZ` (with time zone) Details:

--    - Same display format plus the offset: `2026-09-21 10:00:00+05:30`.

--    - Storage size: 8 bytes.

--    - Range: `4713 BC` → `294276 AD` (no 2038 problem).

--    - Stored in UTC internally, but converted to the session time zone when retrieved.

--    - Useful for tracking system-wide events.

--    - Set current time on insert with `DEFAULT now()` (or `DEFAULT CURRENT_TIMESTAMP`).

--    - Update on modification with a `BEFORE UPDATE` trigger (PostgreSQL has no `ON UPDATE CURRENT_TIMESTAMP`).

--    - Example: Logging creation/update times, audit trails.

-- > 🐘 Best practice: In PostgreSQL, use `TIMESTAMPTZ` for almost every "when did it happen" column.

-- ---

-- ------------------------------------------------------------
-- 6.8.7 Practical Code Examples for Data Types
-- ------------------------------------------------------------

-- Production Example: Utilizing Diverse PostgreSQL Data Types

-- ENUM types must be created first
CREATE TYPE gender_type AS ENUM ('Male', 'Female', 'Other');

CREATE TABLE customer_profiles (
    -- Integer Types:
    customer_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,  -- or SERIAL
    reward_points BIGINT DEFAULT 0,
    age SMALLINT CHECK (age >= 0),                 -- no TINYINT / UNSIGNED in PostgreSQL

    -- Exact Numeric for Currency:
    account_balance NUMERIC(10, 2) DEFAULT 0.00,

    -- Latitude / longitude (exact):
    latitude NUMERIC(9, 6),
    longitude NUMERIC(9, 6),

    -- Fixed String vs Variable String:
    country_code CHAR(2) NOT NULL,             -- Always 2 characters (e.g. 'IN', 'US')
    full_name VARCHAR(100) NOT NULL,           -- Dynamic length
    email VARCHAR(150) UNIQUE NOT NULL,

    -- Large Text:
    bio TEXT,

    -- Real Boolean:
    is_verified BOOLEAN DEFAULT FALSE,

    -- Category Types (ENUM & array instead of SET):
    gender gender_type,
    interests TEXT[],                          -- e.g. '{Sports,Tech}'

    -- Unique id from outside systems:
    public_id UUID DEFAULT gen_random_uuid(),

    -- Temporal Types (TIMESTAMP vs TIMESTAMPTZ):
    date_of_birth DATE NOT NULL,               -- Date only: YYYY-MM-DD
    login_time TIME,                           -- Time only: HH:MM:SS
    birth_timestamp TIMESTAMP,                 -- Exact literal birth time (no timezone conversion)
    created_at TIMESTAMPTZ DEFAULT now(),      -- Stored as UTC
    updated_at TIMESTAMPTZ DEFAULT now()       -- Keep it fresh with a trigger (Topic 37)
);

-- * `gen_random_uuid()` is built in from PostgreSQL 13.

-- * For real map distance use PostGIS (6.8.9) instead of two `NUMERIC` columns.

-- ---

-- ------------------------------------------------------------
-- 6.8.8 Special Data Types: JSON & JSONB In-Depth
-- ------------------------------------------------------------

-- * Q. What are the JSON and JSONB Data Types in PostgreSQL and How Do They Work?

--   * Definition: JSON (JavaScript Object Notation) is a simple text format that stores data as key-value pairs and lists.

--   * PostgreSQL has two JSON types:

-- (Type → How it is stored | Speed | Keeps key order / duplicate keys / spaces? | Can be indexed (GIN)?)
--
-- * JSON
--     - How it is stored                           : As plain text, exactly as typed
--     - Speed                                      : Slower to query (parsed every time)
--     - Keeps key order / duplicate keys / spaces? : Yes
--     - Can be indexed (GIN)?                      : No
--
-- * JSONB
--     - How it is stored                           : Binary, already parsed
--     - Speed                                      : Faster to query
--     - Keeps key order / duplicate keys / spaces? : No (keys sorted, duplicates removed)
--     - Can be indexed (GIN)?                      : Yes
--

--   * Rule: Always use `JSONB` unless you must keep the exact original text. (MySQL `JSON` is also binary, so it is like PostgreSQL `JSONB`.)

--   * Validation: PostgreSQL rejects invalid JSON on insert (`invalid input syntax for type json`).

-- * Path Syntax — no `$` needed:

--   * PostgreSQL uses operators with key names and array positions instead of MySQL's `'$.path'` strings.

-- (What you want → MySQL | PostgreSQL)
--
-- * Field age (as JSON)
--     - MySQL      : details->'$.age'
--     - PostgreSQL : details->'age'
--
-- * Field age (as text)
--     - MySQL      : details->>'$.age'
--     - PostgreSQL : details->>'age'
--
-- * Nested address.city (text)
--     - MySQL      : details->>'$.address.city'
--     - PostgreSQL : details->'address'->>'city' or details#>>'{address,city}'
--
-- * First array element
--     - MySQL      : details->>'$.skills[0]'
--     - PostgreSQL : details->'skills'->>0 (0-based)
--
-- * SQL/JSON path (PG 12+)
--     - MySQL      : —
--     - PostgreSQL : jsonb_path_query(details, '.skills[0]') (same  style as MySQL)
--

-- * JSON Extraction Operators (`->` vs. `->>`):

-- (Operator → Extraction Syntax | Output Type | Description & Purpose | Example | Result)
--
-- * ->
--     - Extraction Syntax     : column->'key'
--     - Output Type           : jsonb (JSON value)
--     - Description & Purpose : Keeps the value as JSON. Use when you want to go deeper or keep JSON type.
--     - Example               : details->'email'
--     - Result                : "alice@example.com"
--
-- * ->>
--     - Extraction Syntax     : column->>'key'
--     - Output Type           : text
--     - Description & Purpose : Gives plain text. Use in WHERE, display, joins.
--     - Example               : details->>'email'
--     - Result                : alice@example.com
--
-- * #>
--     - Extraction Syntax     : column#>'{a,b}'
--     - Output Type           : jsonb
--     - Description & Purpose : Nested path as JSON
--     - Example               : details#>'{address,city}'
--     - Result                : "Pune"
--
-- * #>>
--     - Extraction Syntax     : column#>>'{a,b}'
--     - Output Type           : text
--     - Description & Purpose : Nested path as text
--     - Example               : details#>>'{address,city}'
--     - Result                : Pune
--
-- * @>
--     - Extraction Syntax     : column @> '{...}'
--     - Output Type           : boolean
--     - Description & Purpose : Contains? (can use a GIN index)
--     - Example               : details @> '{"isAdmin": true}'
--     - Result                : true
--
-- * ?
--     - Extraction Syntax     : column ? 'key'
--     - Output Type           : boolean
--     - Description & Purpose : Does the key exist?
--     - Example               : details ? 'phone'
--     - Result                : true / false
--

-- > ⚠️ Note: `->>` always returns text. To compare numbers, cast: `(details->>'age')::INT > 25`.

-- * Core PostgreSQL JSON Functions (MySQL name → PostgreSQL name):

--   * `JSON_EXTRACT()` → use the `->`, `->>`, `#>` operators, or `jsonb_extract_path()`.

--   * `JSON_SET()` → `jsonb_set(doc, '{path}', new_value)` or the `||` merge operator.

--   * `JSON_ARRAY()` → `jsonb_build_array(...)`.

--   * `JSON_OBJECT()` → `jsonb_build_object(...)`.

--   * `JSON_REMOVE()` → the `-` operator (`details - 'phone'`) or `#-` for paths.

-- * Step-by-Step Practical SQL Implementation (same example as the MySQL notes):

-- 1. Create a table with a JSONB column:
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100),
  details JSONB
);

-- 2. Inserting data with structured JSON documents:
INSERT INTO users (name, details) VALUES
('Alice', '{"age": 25, "email": "alice@example.com", "skills": ["SQL", "Python", "JavaScript"]}'),
('Bob', '{"age": 30, "email": "bob@example.com", "skills": ["Java", "C++"], "isAdmin": true}');

-- 3. Extract individual fields:
SELECT
  name,
  details->'email' AS email_json,       -- "alice@example.com" (JSON)
  details->>'age'  AS age_text          -- 25 (text)
FROM users;

-- 4. Use ->> operator to extract plain text (without quotes):
SELECT name, details->>'email' AS user_email FROM users;

-- 5. Use -> operator to get JSON value (with quotes for strings):
SELECT name, details->'email' AS email_json FROM users;

-- 6. Extract array values (0-indexed inside JSON):
SELECT details->'skills'->>0 AS first_skill FROM users WHERE id = 2;   -- Java

-- 7. Filter rows based on JSON content in the WHERE clause:
SELECT name, details
FROM users
WHERE (details->>'isAdmin')::BOOLEAN = TRUE;

-- Same filter using the containment operator (fast with a GIN index):
SELECT name FROM users WHERE details @> '{"isAdmin": true}';

-- 8. Update a JSON field (Modify existing key):
UPDATE users
SET details = jsonb_set(details, '{email}', '"alice.new@example.com"')
WHERE name = 'Alice';

-- 9. Add a new JSON key into an existing document:
UPDATE users
SET details = details || '{"phone": "123456789"}'
WHERE id = 1;

-- 10. Update or Add key using jsonb_set() (create_missing = true by default):
UPDATE users
SET details = jsonb_set(details, '{mobileNumber}', '"9988999889"')
WHERE id = 1;

SELECT * FROM users;

-- 11. Extract nested properties of an object (needs the address key from step 15):
SELECT name, details#>>'{address,city}' AS user_city FROM users WHERE id = 2;

-- 12. Create a JSON Array on the fly:
SELECT jsonb_build_array('SQL', 'Node.js', 'Python') AS skills;

-- 13. Create a JSON Object on the fly:
SELECT jsonb_build_object('name', 'Vishal', 'age', 25, 'city', 'Pune') AS user_details;

-- 14. Replace the skills array:
UPDATE users
SET details = jsonb_set(details, '{skills}', jsonb_build_array('SQL', 'Node.js', 'Python'))
WHERE name = 'Bob';

-- 15. Add a new nested object inside existing JSON:
UPDATE users
SET details = jsonb_set(
  details,
  '{address}',
  jsonb_build_object('street', 'MG Road', 'city', 'Pune', 'zip', '411001')
)
WHERE name = 'Bob';

-- 16. Create an object inside an existing object (Deep Nesting):
UPDATE users
SET details = jsonb_set(
  details,
  '{address,geo}',
  jsonb_build_object('lat', 18.5204, 'lng', 73.8567)
)
WHERE name = 'Bob';

-- 17. Remove a key:
UPDATE users SET details = details - 'phone' WHERE id = 1;

-- 18. Index JSONB for fast searching (PostgreSQL extra):
CREATE INDEX idx_users_details ON users USING GIN (details);

-- > ⚠️ Note: JSON keys are case-sensitive in PostgreSQL too: `details->>'AGE'` returns NULL because the stored key is `age`. `jsonb_set` path `'{address,geo}'` works only after `address` exists (step 15).

-- * Summary Checklist for PostgreSQL JSONB Operations:

--   * `->'key'` : Field as JSON.

--   * `->>'key'` : Field as text.

--   * `#>'{a,b}'` / `#>>'{a,b}'` : Nested path as JSON / text.

--   * `->'arr'->>0` : Array element (0-based).

--   * `@>` : Contains (works with a GIN index).

--   * `?` : Key exists.

--   * `jsonb_set()` : Updates or adds a key.

--   * `||` : Merges two JSONB documents (adds/overwrites keys).

--   * `-` : Removes a key.

--   * `jsonb_build_array()` / `jsonb_build_object()` : Create an array / object.

-- ---

-- ------------------------------------------------------------
-- 6.8.9 Special Data Types: Spatial / GIS Data with PostGIS
-- ------------------------------------------------------------

-- * Q. How does PostgreSQL store Spatial / GIS data?

--   * Definition: Spatial (GIS) data types store locations and shapes — points, lines and areas on a map.

--   * PostgreSQL has small built-in geometric types (`point`, `line`, `lseg`, `box`, `path`, `polygon`, `circle`), but they have no map projection and few functions.

--   * For real GIS work, PostgreSQL uses the PostGIS extension — the most popular open-source GIS database. It follows the same OpenGIS (OGC) standard and the same `ST_` function names as MySQL.

CREATE EXTENSION IF NOT EXISTS postgis;   -- run once per database

--   * Primary Use Cases:

--     * Mapping applications (Google Maps, GIS portals, GPS telemetry).

--     * Real-time location tracking (latitude/longitude coordinates of users or delivery fleets).

--     * Geofencing, restricted zones, and delivery service coverage boundaries.

--     * Spatial calculations (distance between locations, area of regions, point-in-polygon checks).

-- * PostGIS column syntax: `geometry(Type, SRID)` or `geography(Type, SRID)`.

--   * `geometry` = flat (planar) math. `geography` = real Earth math (distances in meters).

--   * SRID `4326` = normal GPS latitude/longitude (WGS 84).

-- * The 8 OpenGIS Spatial Data Types (PostGIS):

-- (Data Type → Structural Category | Geometric Representation | Primary Real-World Use Case)
--
-- * geometry (any)
--     - Structural Category         : Generic Spatial
--     - Geometric Representation    : Any geometric shape (POINT, LINESTRING, POLYGON).
--     - Primary Real-World Use Case : Flexible column capable of holding any spatial geometry per row.
--
-- * geometry(Point)
--     - Structural Category         : Single Coordinate
--     - Geometric Representation    : Single 2D coordinate pair (x, y) (longitude, latitude).
--     - Primary Real-World Use Case : User coordinates, GPS device locations, store/branch coordinates.
--
-- * geometry(LineString)
--     - Structural Category         : Connected Points
--     - Geometric Representation    : Series of connected coordinate points representing a line.
--     - Primary Real-World Use Case : Roads, delivery routes, rivers, railway tracks, flight paths.
--
-- * geometry(Polygon)
--     - Structural Category         : Closed Area
--     - Geometric Representation    : Closed boundary where the last coordinate connects to the first.
--     - Primary Real-World Use Case : City limits, delivery coverage zones, lakes, property plots.
--
-- * geometry(MultiPoint)
--     - Structural Category         : Multi-Geometry
--     - Geometric Representation    : Collection of multiple separate POINT objects.
--     - Primary Real-World Use Case : Multiple branch locations of a company, multiple check-in points.
--
-- * geometry(MultiLineString)
--     - Structural Category         : Multi-Geometry
--     - Geometric Representation    : Collection of multiple separate LINESTRING objects.
--     - Primary Real-World Use Case : Road networks, subway transit systems, highway networks.
--
-- * geometry(MultiPolygon)
--     - Structural Category         : Multi-Geometry
--     - Geometric Representation    : Collection of multiple separate POLYGON objects.
--     - Primary Real-World Use Case : Country territories with islands, multi-district zones.
--
-- * geometry(GeometryCollection)
--     - Structural Category         : Mixed Collection
--     - Geometric Representation    : Mixed geometry types (POINT + LINE + POLYGON).
--     - Primary Real-World Use Case : Mixed complex geographic zones (e.g., city with points, routes, and parks).
--

-- * In-Depth Breakdown of Each Geometry Type with Code Examples:

-- ------------------------------------------------------------
-- 1. GEOMETRY (Any Geometric Object)
-- ------------------------------------------------------------

-- * Definition: A generic spatial data type that can store any spatial object (`POINT`, `LINESTRING`, or `POLYGON`).

-- * Use Case: When a single column needs the flexibility to store varying geometry types across different records.

CREATE TABLE geo_objects (
  id SERIAL PRIMARY KEY,
  name VARCHAR(50),
  shape geometry                       -- any type
);

-- Insert a Point into GEOMETRY column:
INSERT INTO geo_objects (name, shape)
VALUES ('Store Location', ST_GeomFromText('POINT(72.8777 19.0760)', 4326));

SELECT name, ST_AsText(shape) FROM geo_objects;

-- ------------------------------------------------------------
-- 2. POINT (Single Coordinate $(x, y)$)
-- ------------------------------------------------------------

-- * Definition: Represents a single location in 2D space with $x$ (longitude) and $y$ (latitude) coordinates.

-- * Use Case: Track user/device live location, store physical address coordinates, pin landmarks and points of interest.

CREATE TABLE user_location (
  id SERIAL PRIMARY KEY,
  name VARCHAR(50),
  location geometry(Point, 4326)
);

INSERT INTO user_location (name, location)
VALUES ('VISHAL', ST_SetSRID(ST_MakePoint(72.8777, 19.0760), 4326));   -- (lng, lat)

-- Convert binary geometry to readable WKT text:
SELECT name, ST_AsText(location) AS location_text FROM user_location;

-- ------------------------------------------------------------
-- 3. LINESTRING (Connected Path / Route)
-- ------------------------------------------------------------

-- * Definition: A series of two or more connected coordinate points forming a continuous path.

-- * Use Case: Model roads, rivers, walking paths, delivery vehicle routes, and transit tracks.

CREATE TABLE road (
  id SERIAL PRIMARY KEY,
  road_name VARCHAR(50),
  road_path geometry(LineString, 4326)
);

INSERT INTO road (road_name, road_path)
VALUES ('pune_nashik_hiway', ST_GeomFromText('LINESTRING(77.59 12.97, 77.60 12.98, 77.62 12.99)', 4326));

SELECT road_name, ST_AsText(road_path) FROM road;

-- ------------------------------------------------------------
-- 4. POLYGON (Closed Area / Boundary)
-- ------------------------------------------------------------

-- * Definition: A closed surface shape formed by connecting multiple points where the last point connects back to the first point.

-- * Use Case: Define city municipal boundaries, restricted zones, delivery service radiuses, lakes, parks, and agricultural plots.

CREATE TABLE region (
  id SERIAL PRIMARY KEY,
  region_name VARCHAR(50),
  area geometry(Polygon, 4326)
);

INSERT INTO region (region_name, area)
VALUES ('KASARSAI_DAM', ST_GeomFromText('POLYGON((77.58 12.97, 77.60 12.97, 77.60 12.99, 77.58 12.99, 77.58 12.97))', 4326));

SELECT region_name, ST_AsText(area) FROM region;

-- ------------------------------------------------------------
-- 5. MULTIPOINT (Collection of Multiple Points)
-- ------------------------------------------------------------

-- * Definition: A collection of multiple individual `POINT` geometries stored in a single record.

-- * Use Case: Store all branches, stores, or user check-in points within a single corporate zone.

CREATE TABLE multipoint_data (
  id SERIAL PRIMARY KEY,
  name VARCHAR(50),
  locations geometry(MultiPoint, 4326)
);

INSERT INTO multipoint_data (name, locations)
VALUES ('PUNE-ZONE', ST_GeomFromText('MULTIPOINT((77.59 12.97), (77.61 12.98), (77.63 12.99))', 4326));

SELECT name, ST_AsText(locations) FROM multipoint_data;

-- ------------------------------------------------------------
-- 6. MULTILINESTRING (Collection of Multiple Lines)
-- ------------------------------------------------------------

-- * Definition: A collection of multiple `LINESTRING` objects grouped together in a single record.

-- * Use Case: Represent a full network of roads, train transit networks, or delivery flight paths.

CREATE TABLE multilinestring_data (
  id SERIAL PRIMARY KEY,
  network_name VARCHAR(50),
  paths geometry(MultiLineString, 4326)
);

INSERT INTO multilinestring_data (network_name, paths)
VALUES ('D-MART', ST_GeomFromText('MULTILINESTRING((77.58 12.97, 77.60 12.98), (77.61 12.99, 77.63 13.00))', 4326));

SELECT network_name, ST_AsText(paths) FROM multilinestring_data;

-- ------------------------------------------------------------
-- 7. MULTIPOLYGON (Collection of Multiple Closed Polygons)
-- ------------------------------------------------------------

-- * Definition: A collection of multiple separate `POLYGON` closed areas grouped into a single spatial entity.

-- * Use Case: Represent non-contiguous land territories, islands, multi-district sales zones.

CREATE TABLE multipolygon_data (
  id SERIAL PRIMARY KEY,
  name VARCHAR(50),
  areas geometry(MultiPolygon, 4326)
);

INSERT INTO multipolygon_data (name, areas)
VALUES ('District Zones', ST_GeomFromText('MULTIPOLYGON(((77.58 12.97, 77.60 12.97, 77.60 12.99, 77.58 12.99, 77.58 12.97)), ((77.62 13.00, 77.64 13.00, 77.64 13.02, 77.62 13.02, 77.62 13.00)))', 4326));

SELECT name, ST_AsText(areas) FROM multipolygon_data;

-- ------------------------------------------------------------
-- 8. GEOMETRYCOLLECTION (Mixed Collection of Geometries)
-- ------------------------------------------------------------

-- * Definition: A collection container capable of storing any combination of geometry types (`POINT`, `LINESTRING`, and `POLYGON`) within a single record.

-- * Use Case: Storing city maps that include points of interest, transit lines, and zone polygons together.

CREATE TABLE geo_collection (
  id SERIAL PRIMARY KEY,
  name VARCHAR(50),
  geo_data geometry(GeometryCollection, 4326)
);

INSERT INTO geo_collection (name, geo_data)
VALUES ('City Example', ST_GeomFromText(
  'GEOMETRYCOLLECTION(
     POINT(77.59 12.97),
     LINESTRING(77.59 12.97, 77.61 12.98),
     POLYGON((77.62 13.00, 77.64 13.00, 77.64 13.02, 77.62 13.02, 77.62 13.00))
   )', 4326
));

-- ---

-- ------------------------------------------------------------
-- Detailed Comparison: `GEOMETRY` vs. `GEOMETRYCOLLECTION`
-- ------------------------------------------------------------

-- * High-Level Analogy:

--   * `geometry` = A flexible container that can hold one single item of any geometry type (a single Point, a single Line, or a single Polygon).

--   * `GeometryCollection` = A container that holds multiple items together in one record (Points + Lines + Polygons combined).

-- (Feature / Aspect → geometry Type | GeometryCollection Type)
--
-- * Storage Capacity
--     - geometry Type           : Stores only one geometry object at a time per row.
--     - GeometryCollection Type : Stores multiple geometry objects in a single record.
--
-- * Object Variation
--     - geometry Type           : The type can vary across rows (Row 1 = Point, Row 2 = Polygon).
--     - GeometryCollection Type : Can contain a mix of Points, Lines, and Polygons together.
--
-- * Shape Complexity
--     - geometry Type           : Models simple shapes (individual point or single polygon).
--     - GeometryCollection Type : Models complex compound shapes (entire city layout).
--
-- * Use Case
--     - geometry Type           : When you want column flexibility without knowing the type ahead of time.
--     - GeometryCollection Type : When multiple shapes make up one geographic thing.
--
-- * WKT Syntax Example
--     - geometry Type           : 'POINT(77.59 12.97)' or 'POLYGON((...))'
--     - GeometryCollection Type : 'GEOMETRYCOLLECTION(POINT(...), LINESTRING(...), POLYGON(...))'
--

-- * Code Demonstration: `geometry` vs `GeometryCollection`:

-- A. geometry: Storing one simple shape per row
CREATE TABLE geo_examples (
  id SERIAL PRIMARY KEY,
  name VARCHAR(50),
  shape geometry
);

INSERT INTO geo_examples (name, shape)
VALUES ('Restaurant', ST_GeomFromText('POINT(77.59 12.97)'));

INSERT INTO geo_examples (name, shape)
VALUES ('Park', ST_GeomFromText('POLYGON((77.58 12.96, 77.60 12.96, 77.60 12.98, 77.58 12.98, 77.58 12.96))'));

-- B. GeometryCollection: Storing multiple combined shapes together
CREATE TABLE city_shapes (
  id SERIAL PRIMARY KEY,
  city_name VARCHAR(50),
  objects geometry(GeometryCollection)
);

INSERT INTO city_shapes (city_name, objects)
VALUES ('ExampleCity', ST_GeomFromText(
  'GEOMETRYCOLLECTION(
     POINT(77.59 12.97),
     LINESTRING(77.58 12.96, 77.61 12.99),
     POLYGON((77.62 13.00, 77.64 13.00, 77.64 13.02, 77.62 13.02, 77.62 13.00))
   )'
));

-- ---

-- ------------------------------------------------------------
-- Special Spatial Functions in PostGIS
-- ------------------------------------------------------------

-- * 1. `ST_GeomFromText('WKT', srid)`:

--   * Purpose: Creates a geometry object from a Well-Known Text (WKT) string.

CREATE TABLE locations (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    geom geometry
);

INSERT INTO locations (name, geom)
VALUES ('User A', ST_GeomFromText('POINT(77.5946 12.9716)'));

INSERT INTO locations (name, geom)
VALUES ('Park Area', ST_GeomFromText(
    'POLYGON((77.58 12.97, 77.60 12.97, 77.60 12.99, 77.58 12.99, 77.58 12.97))'
));

-- * 2. `ST_AsText(geometry)`:

--   * Purpose: Converts internal binary geometry back into readable WKT text.

SELECT name, ST_AsText(geom) AS geom_text
FROM locations;

-- * 3. `ST_Distance(geometry1, geometry2)`:

--   * Purpose: Calculates the distance between two geometry objects.

--   * Note: On `geometry` with SRID 4326 the answer is in degrees (flat math). Cast to `geography` to get real meters. (MySQL uses `ST_Distance_Sphere()` for this.)

-- PostgreSQL has no @variables; use a CTE (WITH) to name the two points:
WITH pts AS (
  SELECT ST_GeomFromText('POINT(77.5946 12.9716)', 4326) AS p1,   -- Bangalore
         ST_GeomFromText('POINT(77.6090 12.9721)', 4326) AS p2    -- Nearby location
)
SELECT ST_Distance(p1, p2)                       AS distance_degrees,
       ST_Distance(p1::geography, p2::geography) AS distance_meters
FROM pts;

-- * 4. `ST_Within(geometry_a, geometry_b)`:

--   * Purpose: Checks whether geometry `a` is completely inside geometry `b` (e.g. Point inside a Polygon). Returns `true` / `false` (MySQL returns `1` / `0`).

WITH g AS (
  SELECT ST_GeomFromText('POINT(77.59 12.98)') AS point,
         ST_GeomFromText('POLYGON((77.58 12.97, 77.60 12.97, 77.60 12.99, 77.58 12.99, 77.58 12.97))') AS polygon
)
SELECT ST_Within(point, polygon) AS is_within FROM g;   -- true

-- * 5. `ST_Contains(geometry_a, geometry_b)`:

--   * Purpose: Checks whether geometry `a` contains geometry `b` (e.g. Polygon contains a Point). Returns `true` / `false`.

WITH g AS (
  SELECT ST_GeomFromText('POINT(77.59 12.98)') AS point,
         ST_GeomFromText('POLYGON((77.58 12.97, 77.60 12.97, 77.60 12.99, 77.58 12.99, 77.58 12.97))') AS polygon
)
SELECT ST_Contains(polygon, point) AS contains FROM g;  -- true

-- * Spatial index (PostGIS uses GiST): `CREATE INDEX idx_loc ON user_location USING GIST (location);`

-- ---

-- ------------------------------------------------------------
-- 6.8.10 Quick Overview: JSONB & PostGIS (Methods & Properties Master Cheat Sheet)
-- ------------------------------------------------------------

-- * Q. What is the Quick Reference for PostgreSQL JSONB and PostGIS?

--   * A quick lookup table for JSONB operators and functions, and for spatial types and functions.

-- ------------------------------------------------------------
-- Part 1: JSONB — Quick Reference & Methods Matrix
-- ------------------------------------------------------------

-- ------------------------------------------------------------
-- 1. JSONB Path / Access Properties
-- ------------------------------------------------------------
-- (Expression → Target Element | Description & Behavior | Example)
--
-- * col
--     - Target Element         : Document Root
--     - Description & Behavior : The entire JSON document.
--     - Example                : SELECT details FROM users;
--
-- * col->'key'
--     - Target Element         : Direct Object Key
--     - Description & Behavior : Value of key as JSON.
--     - Example                : details->'age'
--
-- * col->>'key'
--     - Target Element         : Direct Object Key (text)
--     - Description & Behavior : Value of key as text.
--     - Example                : details->>'age'
--
-- * col#>>'{a,b}'
--     - Target Element         : Nested Property
--     - Description & Behavior : Goes inside a to get b, as text.
--     - Example                : details#>>'{address,city}'
--
-- * col->'arr'->>i
--     - Target Element         : Array Element
--     - Description & Behavior : Element at 0-based index i.
--     - Example                : details->'skills'->>0
--
-- * jsonb_array_elements(col->'arr')
--     - Target Element         : Array Wildcard
--     - Description & Behavior : Returns all elements as rows.
--     - Example                : SELECT jsonb_array_elements(details->'skills') FROM users;
--
-- * jsonb_each(col)
--     - Target Element         : Object Wildcard
--     - Description & Behavior : Returns every key/value as rows.
--     - Example                : SELECT * FROM jsonb_each('{"a":1,"b":2}');
--

-- ------------------------------------------------------------
-- 2. JSONB Operators Matrix
-- ------------------------------------------------------------
-- (Operator → Name | Syntax | Return Format | Best Used For)
--
-- * ->
--     - Name          : Arrow
--     - Syntax        : col->'key'
--     - Return Format : jsonb
--     - Best Used For : Going deeper, keeping JSON type
--
-- * ->>
--     - Name          : Text Arrow
--     - Syntax        : col->>'key'
--     - Return Format : text
--     - Best Used For : Display, WHERE, joins
--
-- * #> / #>>
--     - Name          : Path
--     - Syntax        : col#>'{a,b}'
--     - Return Format : jsonb / text
--     - Best Used For : Nested values
--
-- * @>
--     - Name          : Contains
--     - Syntax        : col @> '{"k":"v"}'
--     - Return Format : boolean
--     - Best Used For : Fast filters with GIN index
--
-- * ?
--     - Name          : Key exists
--     - Syntax        : col ? 'key'
--     - Return Format : boolean
--     - Best Used For : Checking a key
--
-- * ||
--     - Name          : Concatenate
--     - Syntax        : col || '{"k":1}'
--     - Return Format : jsonb
--     - Best Used For : Add / overwrite keys
--
-- * -
--     - Name          : Delete
--     - Syntax        : col - 'key'
--     - Return Format : jsonb
--     - Best Used For : Remove a key
--

-- ------------------------------------------------------------
-- 3. MySQL JSON Function → PostgreSQL JSONB Equivalent
-- ------------------------------------------------------------
-- (MySQL Function → PostgreSQL Equivalent | Purpose | Practical SQL Example)
--
-- * JSON_EXTRACT()
--     - PostgreSQL Equivalent : ->, #>, jsonb_extract_path()
--     - Purpose               : Get a value
--     - Practical SQL Example : details->'email'
--
-- * JSON_SET()
--     - PostgreSQL Equivalent : jsonb_set()
--     - Purpose               : Update or add a key
--     - Practical SQL Example : jsonb_set(details, '{active}', 'true')
--
-- * JSON_INSERT()
--     - PostgreSQL Equivalent : jsonb_insert() / jsonb_set(..., create_missing)
--     - Purpose               : Add new value (arrays)
--     - Practical SQL Example : jsonb_insert(details, '{skills,0}', '"Go"')
--
-- * JSON_REPLACE()
--     - PostgreSQL Equivalent : jsonb_set(doc, path, val, false)
--     - Purpose               : Change only if key exists
--     - Practical SQL Example : jsonb_set(details, '{age}', '31', false)
--
-- * JSON_REMOVE()
--     - PostgreSQL Equivalent : - / #- operator
--     - Purpose               : Remove a key or element
--     - Practical SQL Example : details #- '{skills,1}'
--
-- * JSON_ARRAY()
--     - PostgreSQL Equivalent : jsonb_build_array()
--     - Purpose               : Create an array
--     - Practical SQL Example : jsonb_build_array('Java', 'Python', 'SQL')
--
-- * JSON_OBJECT()
--     - PostgreSQL Equivalent : jsonb_build_object()
--     - Purpose               : Create an object
--     - Practical SQL Example : jsonb_build_object('city', 'Pune', 'zip', 411001)
--
-- * JSON_CONTAINS()
--     - PostgreSQL Equivalent : @> operator
--     - Purpose               : Contains a value?
--     - Practical SQL Example : details->'skills' @> '"SQL"'
--
-- * JSON_SEARCH()
--     - PostgreSQL Equivalent : jsonb_path_query()
--     - Purpose               : Search with a JSON path
--     - Practical SQL Example : jsonb_path_query(details, '$.skills[*] ? (@ == "Python")')
--
-- * JSON_TYPE()
--     - PostgreSQL Equivalent : jsonb_typeof()
--     - Purpose               : Type name (object, array, number…)
--     - Practical SQL Example : jsonb_typeof(details->'age')
--
-- * JSON_VALID()
--     - PostgreSQL Equivalent : IS JSON (PG 16+) / try a cast
--     - Purpose               : Valid JSON text?
--     - Practical SQL Example : '{"valid": true}' IS JSON
--

-- ---

-- ------------------------------------------------------------
-- Part 2: PostGIS Spatial Types — Quick Reference & Methods Matrix
-- ------------------------------------------------------------

-- ------------------------------------------------------------
-- 1. The 8 OpenGIS Spatial Data Types Matrix
-- ------------------------------------------------------------
-- (Spatial Type → Structural Geometry | Dimension | Real-World Application | WKT Syntax Pattern)
--
-- * POINT
--     - Structural Geometry    : Single 2D coordinate (x, y)
--     - Dimension              : 0D (Point)
--     - Real-World Application : GPS user locations, pin drop, branch coordinates
--     - WKT Syntax Pattern     : POINT(77.59 12.97)
--
-- * LINESTRING
--     - Structural Geometry    : Connected series of points
--     - Dimension              : 1D (Length)
--     - Real-World Application : Roads, delivery routes, rivers, railways, flight corridors
--     - WKT Syntax Pattern     : LINESTRING(x1 y1, x2 y2, ...)
--
-- * POLYGON
--     - Structural Geometry    : Closed area (first = last point)
--     - Dimension              : 2D (Area)
--     - Real-World Application : Delivery geofencing zones, lakes, city boundaries, plots
--     - WKT Syntax Pattern     : POLYGON((x1 y1, x2 y2, ..., x1 y1))
--
-- * MULTIPOINT
--     - Structural Geometry    : Multiple distinct points
--     - Dimension              : 0D Set
--     - Real-World Application : Multiple store branches, delivery drop points
--     - WKT Syntax Pattern     : MULTIPOINT((x1 y1), (x2 y2))
--
-- * MULTILINESTRING
--     - Structural Geometry    : Multiple distinct line paths
--     - Dimension              : 1D Set
--     - Real-World Application : Highway networks, subway train lines, multi-segment routes
--     - WKT Syntax Pattern     : MULTILINESTRING((...), (...))
--
-- * MULTIPOLYGON
--     - Structural Geometry    : Multiple closed polygon zones
--     - Dimension              : 2D Set
--     - Real-World Application : Islands, multi-district sales territories
--     - WKT Syntax Pattern     : MULTIPOLYGON(((...)), ((...)))
--
-- * GEOMETRYCOLLECTION
--     - Structural Geometry    : Mixed collection
--     - Dimension              : Mixed
--     - Real-World Application : Complex city models (Points + Lines + Polygons combined)
--     - WKT Syntax Pattern     : GEOMETRYCOLLECTION(POINT(...), ...)
--
-- * geometry
--     - Structural Geometry    : Any spatial column
--     - Dimension              : Any
--     - Real-World Application : Column that can store any single geometric object per row
--     - WKT Syntax Pattern     : Holds any single geometry object
--

-- ------------------------------------------------------------
-- 2. PostGIS Spatial Analysis Methods (`ST_` Functions)
-- ------------------------------------------------------------
-- (Function Name → Input Signature | Output Type | Description & Analysis Role | Practical SQL Example)
--
-- * ST_GeomFromText()
--     - Input Signature             : (wkt_string[, srid])
--     - Output Type                 : geometry
--     - Description & Analysis Role : Converts WKT text to geometry.
--     - Practical SQL Example       : ST_GeomFromText('POINT(72.87 19.07)', 4326)
--
-- * ST_MakePoint()
--     - Input Signature             : (x, y)
--     - Output Type                 : geometry
--     - Description & Analysis Role : Builds a point from two numbers.
--     - Practical SQL Example       : ST_SetSRID(ST_MakePoint(72.87, 19.07), 4326)
--
-- * ST_AsText()
--     - Input Signature             : (geom)
--     - Output Type                 : text
--     - Description & Analysis Role : Converts geometry back to readable text.
--     - Practical SQL Example       : SELECT ST_AsText(location) FROM user_location;
--
-- * ST_Distance()
--     - Input Signature             : (geom1, geom2)
--     - Output Type                 : double
--     - Description & Analysis Role : Distance (degrees for geometry, meters for geography).
--     - Practical SQL Example       : ST_Distance(a::geography, b::geography)
--
-- * ST_DWithin()
--     - Input Signature             : (geom1, geom2, dist)
--     - Output Type                 : boolean
--     - Description & Analysis Role : Within a distance? (uses the index — best for "nearby")
--     - Practical SQL Example       : ST_DWithin(a::geography, b::geography, 5000)
--
-- * ST_Within()
--     - Input Signature             : (geom_a, geom_b)
--     - Output Type                 : boolean
--     - Description & Analysis Role : Is A completely inside B?
--     - Practical SQL Example       : ST_Within(user_point, zone_polygon)
--
-- * ST_Contains()
--     - Input Signature             : (geom_a, geom_b)
--     - Output Type                 : boolean
--     - Description & Analysis Role : Does A completely contain B?
--     - Practical SQL Example       : ST_Contains(zone_polygon, user_point)
--
-- * ST_Area()
--     - Input Signature             : (polygon)
--     - Output Type                 : double
--     - Description & Analysis Role : Area of a polygon.
--     - Practical SQL Example       : ST_Area(area::geography)
--
-- * ST_Length()
--     - Input Signature             : (linestring)
--     - Output Type                 : double
--     - Description & Analysis Role : Length of a line.
--     - Practical SQL Example       : ST_Length(road_path::geography)
--
-- * ST_Buffer()
--     - Input Signature             : (geom, distance)
--     - Output Type                 : geometry
--     - Description & Analysis Role : Zone of radius d around a shape.
--     - Practical SQL Example       : ST_Buffer(store_point::geography, 5000)
--
-- * ST_Intersects()
--     - Input Signature             : (geom1, geom2)
--     - Output Type                 : boolean
--     - Description & Analysis Role : Do they touch or overlap?
--     - Practical SQL Example       : ST_Intersects(route_line, flood_zone)
--

-- ---

-- ------------------------------------------------------------
-- 6.9 Visual Architectural Diagrams for Data Types & Hierarchy
-- ------------------------------------------------------------

-- > Note: These diagrams are shared from the MySQL notes. The ideas are the same; the PostgreSQL differences are written under each diagram.

-- ------------------------------------------------------------
-- Diagram 1: Comprehensive Data Types Architecture
-- ------------------------------------------------------------

--   * Top Section (Memory Strategy): Fixed Data Types (same size every time) vs. Variable Data Types (size depends on value length + header).

--   * 4 Main Taxonomy Cards — PostgreSQL version:

--     1. Numeric Types: `SMALLINT` (2B), `INTEGER` (4B), `BIGINT` (8B), exact `NUMERIC(p,s)` for money, `REAL`/`DOUBLE PRECISION` for science. (The diagram's `TINYINT` does not exist in PostgreSQL — use `SMALLINT`.)

--     2. String & Text Types: `CHAR(n)` (padding) vs `VARCHAR(n)` vs `TEXT` (no limit, up to 1 GB), and `BYTEA` for binary files (instead of `BLOB`).

--     3. Date & Time (Temporal): `DATE`, `TIME`, `TIMESTAMP` (no time zone — like MySQL `DATETIME`), `TIMESTAMPTZ` (UTC-aware — like MySQL `TIMESTAMP`), `INTERVAL`. No `YEAR`.

--     4. Specialized Types: real `BOOLEAN`, `BIT`, `ENUM` (via `CREATE TYPE`), arrays (instead of `SET`), `UUID`, `JSONB`.

-- ---

-- ------------------------------------------------------------
-- Diagram 2: TIMESTAMP vs. TIMESTAMPTZ (shown as DATETIME vs. TIMESTAMP)
-- ------------------------------------------------------------

--   * Left Card (`DATETIME` in MySQL) = `TIMESTAMP` in PostgreSQL: stores exactly what you insert, no time zone conversion; best for birthdays and schedules. In PostgreSQL it is 8 bytes and goes far beyond 9999.

--   * Right Card (`TIMESTAMP` in MySQL) = `TIMESTAMPTZ` in PostgreSQL: stored as UTC, shown in the session time zone; best for audit logs. In PostgreSQL there is no 2038 limit and no `ON UPDATE` — use a trigger.

--   * Bottom Pipeline (UTC Workflow): A client in India writes in IST ($\text{UTC}+5:30$), the database stores UTC ($0:00$), and a client in the US reads in EST ($\text{UTC}-5:00$). This works the same with `TIMESTAMPTZ`.

-- ---

-- ------------------------------------------------------------
-- Diagram 3: Database Structure & Hierarchy Diagram
-- ------------------------------------------------------------

-- * Explanation:

--   * Displays the 4-tier relational structure: Server $\rightarrow$ Databases $\rightarrow$ Schemas $\rightarrow$ Tables. In PostgreSQL all 4 levels are real and separate (see 6.1).

--   * Details table anatomy (Columns, Rows, Cells) and Primary Key indexing.

-- ---

-- ------------------------------------------------------------
-- Diagram 4: JSON Data Type Architecture & Path Traversal
-- ------------------------------------------------------------

--   * Header & Concept: JSON stored in a binary format for fast key lookup — in PostgreSQL this is the `JSONB` type.

--   * The `$` Root Symbol & Path Navigation: The diagram uses MySQL paths (`$.key`). In PostgreSQL write `col->'key'`, `col#>'{object,key}'`, `col->'array'->>i`. (The `$` style is used only in `jsonb_path_query()`.)

--   * Extraction Operators (`->` vs. `->>`): Same meaning in PostgreSQL: `->` gives JSON, `->>` gives text.

--   * Core Functions: `JSON_EXTRACT()` → `->`, `JSON_SET()` → `jsonb_set()`, `JSON_ARRAY()` → `jsonb_build_array()`, `JSON_OBJECT()` → `jsonb_build_object()`.

-- ---

-- ------------------------------------------------------------
-- Diagram 5: Spatial / GIS Geometry Data Types & Functions Architecture
-- ------------------------------------------------------------

--   * OpenGIS Spatial Hierarchy: Base `GEOMETRY` class down to concrete subtypes — PostGIS follows the same hierarchy.

--   * Core Geometry Types: `POINT(x y)` (locations), `LINESTRING` (routes/roads), `POLYGON` (closed boundaries/zones), and their multi-counterparts.

--   * GEOMETRY vs. GEOMETRYCOLLECTION: A container for one shape vs. a container for many mixed shapes.

--   * Spatial Analysis Functions (`ST_`): `ST_GeomFromText()`, `ST_AsText()`, `ST_Distance()`, `ST_Within()`, `ST_Contains()` — same names in PostGIS.

-- ---

--   4. Date & Time (Temporal Types):

--   8. Spatial / GIS Data Types (PostGIS):

-- ---

-- ======================================================================
-- 🎯 Practice Questions (salesdb sample data) — try first, then look at the answer
-- ======================================================================
-- Run 00-Setup-Sample-Data.sql once before this section.

SET search_path TO sales;

-- Q1. Database → table → column: list the tables of salesdb and the columns of products.
SELECT table_name FROM information_schema.tables WHERE table_schema = 'sales';
SELECT column_name, data_type FROM information_schema.columns WHERE table_schema = 'sales' AND table_name = 'products';

-- Q2. Data types: show the data type of every column in orders.
SELECT column_name, data_type, character_maximum_length
FROM information_schema.columns
WHERE table_schema = 'sales' AND table_name = 'orders';

-- Q3. DATE vs TIMESTAMP: show orderdate (DATE) and creationtime (TIMESTAMP) side by side.
SELECT orderid, orderdate, creationtime FROM orders;
