-- ======================================================================
-- Topic 6: Database Structure & Hierarchy
-- ======================================================================

-- ------------------------------------------------------------
-- 📖 In Simple Words
-- ------------------------------------------------------------

-- * Definition: Database structure is the order in which data is organised: server → database → (schema) → table → columns and rows. Each column has a data type that says what kind of value it can hold.

-- * Real-life example: Building → floor → room → shelf → box. Each box has a label saying what may go inside (only numbers, only dates…).

-- * Example on salesdb (run 00-Setup-Sample-Data.sql first):
USE salesdb;
DESCRIBE products;

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

--      * 🔢 Sequences: Number generators used for IDs (MySQL uses `AUTO_INCREMENT` instead).

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

-- | Dimension | Logical Schema | Physical Schema |
-- | :--- | :--- | :--- |
-- | Definition | Design of the tables and how they are related. | How the data is actually stored on disk (files, partitions, indexes). |
-- | Core Focus | What data is stored and how tables relate. | How data is physically laid out, indexed, and partitioned on disk. |
-- | Key Question | "What data do we store and how is it connected?" | "How and where is the data stored on disk?" |
-- | Components | Tables, column datatypes, relationships, constraints. | Filepaths, tablespace files (`.ibd`), partitions, B-tree block sizes. |
-- | Primary Audience | Developers, Data Analysts, Data Modelers. | Database Administrators (DBAs), Storage Engineers, DB Engines. |
-- | Visibility | Visible to developers and SQL queries. | Hidden inside the storage engine. |

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

-- | Customer_ID | Customer_Name | City |
-- | :--- | :--- | :--- |
-- | 101 | Rahul | Pune |
-- | 102 | Priya | Mumbai |
-- | 103 | Amit | Nashik |

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

-- | Customer_ID (🔑 Primary Key) | Customer_Name | City |
-- | :--- | :--- | :--- |
-- | 101 | Rahul | Pune |
-- | 102 | Priya | Mumbai |

-- * The 5 Core Properties of a Primary Key:

--   1. Unique: Every row must hold a distinct, non-duplicate key value.

--   2. Cannot be NULL: Primary keys can never contain empty or missing values.

--   3. Only ONE per Table: Each table is restricted to exactly one primary key definition.

--   4. Automatic Index: MySQL (InnoDB) automatically builds a clustered index on it, so lookups by key are very fast.

--   5. Referential Anchor: Serves as the referenced parent key for Foreign Keys in child tables.

-- ---

-- ------------------------------------------------------------
-- 6.8 MySQL Data Types In-Depth
-- ------------------------------------------------------------

-- Definition: A data type tells what kind of value a column can store (number, text, date…), how much space it takes, and what operations can be done on it.

-- ---

-- ------------------------------------------------------------
-- 6.8.1 Memory Classification: Fixed Data Types vs. Variable Data Types
-- ------------------------------------------------------------

-- Q. What are the two main types of data types based on memory allocation in MySQL?

-- Based on how much space they use, data types are of 2 kinds:

-- 1. Fixed Data Type (Fixed Storage Allocation):

--    * Definition: Fixed data types always take the same amount of space, no matter how long the actual value is.

--    * They are best used when the size of data is known, uniform, and consistent across all rows.

--    * If an inserted value is shorter than the defined length, MySQL automatically pads it with spaces to fill the entire allocated slot (e.g., in `CHAR(n)`).

--    * Key Examples: `CHAR(n)`, `INT`, `BIGINT`, `FLOAT`, `DOUBLE`, `DECIMAL`.

--    * Performance Advantage: Slightly faster, because MySQL always knows the exact size — it doesn't need to read a length value first.

-- 2. Variable Data Type (Dynamic Storage Allocation):

--    * Definition: Variable data types take only as much space as the actual value, plus 1–2 extra bytes to store its length.

--    * If a column allows up to 255 characters but only 5 characters are stored, it consumes only 5 bytes + 1 byte overhead.

--    * Key Examples: `VARCHAR(n)`, `TEXT` (TINYTEXT, TEXT, MEDIUMTEXT, LONGTEXT), `BLOB`, `VARBINARY(n)`.

--    * Space Advantage: Saves a lot of space when value lengths differ a lot from row to row.

-- ------------------------------------------------------------
-- Comparison: Fixed vs. Variable Data Types
-- ------------------------------------------------------------

-- | Feature / Dimension | Fixed Data Types (e.g., `CHAR(10)`) | Variable Data Types (e.g., `VARCHAR(10)`) |
-- | :--- | :--- | :--- |
-- | Storage Allocation | Takes fixed, predetermined storage size in memory | Takes storage dynamically based on actual value length |
-- | Space Utilization | Can waste disk/RAM space if values are short (pads with spaces) | Highly space-efficient (stores actual length + 1-2 prefix bytes) |
-- | Read / Write Speed | Slightly faster (size is always known) | Slightly slower (must read the length first) |
-- | Space Overhead | 0 overhead bytes (exact allocated size is reserved) | 1 byte (for $L \le 255$) or 2 bytes (for $L > 255$) length header |
-- | Space Padding | Automatically padded with right-side spaces on disk | No space padding; stored exactly as entered |
-- | Best Used When | Length is fixed and predictable across all rows | Length varies significantly across different rows |
-- | Primary Examples | `CHAR(n)`, `INT`, `BIGINT`, `DECIMAL`, `FLOAT`, `DOUBLE` | `VARCHAR(n)`, `TEXT`, `BLOB`, `VARBINARY(n)` |

-- ------------------------------------------------------------
-- Practical Example to Understand Memory Storage (CHAR(10) vs. VARCHAR(10))
-- ------------------------------------------------------------

-- Suppose we create two columns: `code_fixed CHAR(10)` and `code_var VARCHAR(10)`, and store the same string values. Notice how MySQL stores them physically:

-- | Inserted String | Actual Length | `CHAR(10)` Physical Storage | Bytes Used (`CHAR(10)`) | `VARCHAR(10)` Physical Storage | Bytes Used (`VARCHAR(10)`) | Memory Saved by VARCHAR |
-- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
-- | `''` (Empty) | 0 chars | `'          '` (10 spaces) | 10 Bytes | `[0]` (length prefix 0) | 1 Byte | 90% Saved (9 Bytes) |
-- | `'AB'` | 2 chars | `'AB        '` (2 chars + 8 spaces) | 10 Bytes | `[2] + 'AB'` | 3 Bytes (2 + 1) | 70% Saved (7 Bytes) |
-- | `'Pune'` | 4 chars | `'Pune      '` (4 chars + 6 spaces) | 10 Bytes | `[4] + 'Pune'` | 5 Bytes (4 + 1) | 50% Saved (5 Bytes) |
-- | `'India'` | 5 chars | `'India     '` (5 chars + 5 spaces) | 10 Bytes | `[5] + 'India'` | 6 Bytes (5 + 1) | 40% Saved (4 Bytes) |
-- | `'0123456789'` | 10 chars | `'0123456789'` (no spaces) | 10 Bytes | `[10] + '0123456789'` | 11 Bytes (10 + 1) | -1 Byte (overhead) |

-- ------------------------------------------------------------
-- Visual Memory Layout Diagram
-- ------------------------------------------------------------

-- ┌── (text — not SQL, shown for reference) ──
-- │ Storing 'Pune' (4 characters) in a 10-character column:
-- │ 
-- │ CHAR(10) Memory Slot (Always 10 bytes):
-- │ +---+---+---+---+---+---+---+---+---+---+
-- │ | P | u | n | e |   |   |   |   |   |   |  -> Fixed 10 Bytes allocated
-- │ +---+---+---+---+---+---+---+---+---+---+
-- │                  ^^^^^^^^^^^^^^^^^^^^^^
-- │                  (6 padded space bytes wasted)
-- │ 
-- │ VARCHAR(10) Memory Slot (Dynamic 4 + 1 = 5 bytes):
-- │ +--------+---+---+---+---+
-- │ | Length | P | u | n | e |  -> Only 5 Bytes total on disk
-- │ |   04   |   |   |   |   |     (1 byte length prefix + 4 char bytes)
-- │ +--------+---+---+---+---+
-- └──

-- ------------------------------------------------------------
-- Hands-On SQL Demonstration: Fixed vs Variable Storage
-- ------------------------------------------------------------

-- 1. Create demonstration table
CREATE TABLE storage_comparison (
    id INT AUTO_INCREMENT PRIMARY KEY,
    description VARCHAR(30),
    country_iso_fixed CHAR(10),     -- Fixed allocation
    country_name_var VARCHAR(10)    -- Dynamic allocation
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
    CHAR_LENGTH(country_iso_fixed) AS fixed_char_count,
    OCTET_LENGTH(country_iso_fixed) AS fixed_bytes_stored,
    country_name_var,
    CHAR_LENGTH(country_name_var) AS var_char_count,
    OCTET_LENGTH(country_name_var) AS var_bytes_stored
FROM storage_comparison;

-- > [!TIP]
-- > Production Rule of Thumb:
-- > * Use **Fixed Data Types (`CHAR`)** when values are guaranteed to be the exact same length in every single row — e.g., ISO Country Codes (`'IN'`, `'US'`), SHA-256 Hashes (always 64 characters), UUIDs (36 characters), Currency codes (`'INR'`, `'USD'`), or MD5 checksums.
-- > * Use **Variable Data Types (`VARCHAR`)** whenever data length varies — e.g., User names, email addresses, city names, URLs, and street addresses.

-- ---

-- ------------------------------------------------------------
-- 6.8.2 Numeric Data Types
-- ------------------------------------------------------------

-- Q. What are the primary Numeric Data Types in MySQL and their storage ranges?

-- Numeric data types store numbers and are broadly divided into Integers (Whole Numbers) and Fractional / Decimal / Floating-Point Numbers.

-- ------------------------------------------------------------
-- 1. Integer Data Types (Whole Numbers)
-- ------------------------------------------------------------
-- Stores whole numbers (no decimals).

-- * **`TINYINT`:**

--   - Storage Size: 1 Byte (8 bits).

--   - Signed Range: `-128` to `127`.

--   - Unsigned Range: `0` to `255`.

--   - Best for: Age, status codes, small quantities.

-- * **`SMALLINT`:**

--   - Storage Size: 2 Bytes (16 bits).

--   - Signed Range: `-32,768` to `32,767`.

--   - Unsigned Range: `0` to `65,535`.

--   - Best for: Small inventory items, years.

-- * **`MEDIUMINT`:**

--   - Storage Size: 3 Bytes (24 bits).

--   - Signed Range: `-8,388,608` to `8,388,607`.

--   - Unsigned Range: `0` to `16,777,215`.

-- * **`INT` / `INTEGER`:**

--   - Storage Size: 4 Bytes (32 bits).

--   - Stores whole numbers (no decimals).

--   - Signed Range: `-2,147,483,648` to `2,147,483,647` (~2.14 Billion).

--   - `UNSIGNED INT` Range: `0` to `4,294,967,295` (~4.29 Billion).

--   - Best for: Standard table primary keys, employee IDs, customer numbers.

-- * **`BIGINT`:**

--   - Storage Size: 8 Bytes (64 bits).

--   - Stores very large whole numbers.

--   - Signed Range: `-9 quintillion` to `9 quintillion` (`-9,223,372,036,854,775,808` to `9,223,372,036,854,775,807`).

--   - Best for: High-volume financial transactions, global e-commerce order tracking, social media view counts.

-- ------------------------------------------------------------
-- 2. Exact Numeric Data Type: `DECIMAL(p, s)`
-- ------------------------------------------------------------

-- * Definition: DECIMAL stores exact numeric values (not approximate) with user-defined precision and scale.

-- * Used for exact decimal values like prices and money.

-- * Parameters:

--   - `p` = Precision: Total number of significant digits (both before and after the decimal point). Maximum is 65.

--   - `s` = Scale: Number of digits after the decimal point. Maximum is 30 ($s \le p$).

-- * Core Characteristics:

--   - Stores exact numbers (not approximate).

--   - Does not suffer from binary floating-point rounding inaccuracies.

--   - Best for: Money, financial accounting, banking balances, product prices.

--   - Example: `DECIMAL(10, 2)` stores numbers up to `99,999,999.99`.

-- ------------------------------------------------------------
-- 3. Approximate Numeric Data Types: `FLOAT` & `DOUBLE`
-- ------------------------------------------------------------
-- Stores approximate decimal numbers (floating-point representation).

-- * **`FLOAT`:**

--   - Storage Size: 4 Bytes.

--   - Less precision (~7 decimal digits of precision).

--   - Used for approximate decimal values.

-- * **`DOUBLE`:**

--   - Storage Size: 8 Bytes.

--   - More precision (~15 decimal digits of precision).

--   - Used for higher-accuracy scientific calculations.

-- * Core Characteristics:

--   - Store approximate decimal numbers (floating point).

--   - Used in science, engineering and statistics where speed matters more than exact accuracy. ⚠️ Never use `FLOAT`/`DOUBLE` for money — use `DECIMAL`.

-- ---

-- ------------------------------------------------------------
-- 6.8.3 String, Text, Binary & Specialized Data Types
-- ------------------------------------------------------------

-- Q. What are the String, Text, Binary, and Category Data Types available in MySQL?

-- ------------------------------------------------------------
-- 1. `CHAR(n)` (Fixed-Length String)
-- ------------------------------------------------------------

-- * Definition: CHAR(n) is a fixed-length string. It always uses space for n characters, even if the value is shorter.

-- * Core Characteristics:

--   - Fixed length string: Pre-allocates memory for the full defined length.

--   - Storage: Always uses full defined length. If the data is shorter than $n$, MySQL automatically pads it with spaces on the right upon storage.

--   - Performance: Slightly faster for fixed-length values.

--   - Range: Supports up to 255 characters ($0 \le n \le 255$).

--   - Wastes Space: Wastes disk and RAM space if the inserted data is shorter than the defined capacity.

--   - Best Use Cases: Fixed-size data where length is identical across every row (e.g., Postal/ZIP codes, ISO Country codes `'IN'`, `'US'`, Currency codes `'USD'`, `'INR'`, MD5/SHA hashes, Phone extensions).

-- ------------------------------------------------------------
-- 2. `VARCHAR(n)` (Variable-Length String)
-- ------------------------------------------------------------

-- * Definition: VARCHAR(n) is a variable-length string. It stores only the characters you insert, plus 1–2 bytes for the length.

-- * Core Characteristics:

--   - Variable length string: Uses space based on the actual string length.

--   - Storage: Uses only the number of characters actually stored + 1 byte (for $L \le 255$) or 2 bytes (for $L > 255$) for the length prefix.

--   - Performance: Slightly slower when an update changes the value's length (the row may need to move).

--   - Range: Up to 65,535 in theory, but the whole row is limited to 65,535 bytes, so in practice it is less (e.g., about 16,383 characters with `utf8mb4`).

--   - Space Efficient: Highly space-efficient; stores only the needed length without space padding.

--   - Best Use Cases: Variable data where string length differs widely across rows (e.g., Customer names, email addresses, street addresses, descriptions, URLs).

-- ------------------------------------------------------------
-- Comparison: `CHAR` vs. `VARCHAR`
-- ------------------------------------------------------------

-- | Feature / Dimension | `CHAR(n)` | `VARCHAR(n)` |
-- | :--- | :--- | :--- |
-- | String Length Type | Fixed-length string | Variable-length string |
-- | Storage Allocation | Always uses full defined length (padded with spaces if shorter) | Uses only the actual characters stored + 1 or 2 length prefix bytes |
-- | Performance | Faster for fixed-length values (predictable byte offsets) | Slightly slower for dynamic updates (variable row sizes) |
-- | Maximum Range | Up to 255 characters | Up to 65,535 characters (shared across row) |
-- | Space Utilization | Wastes space if data is shorter than $n$ | Highly efficient (allocates only needed space) |
-- | Trailing Spaces | Padded with spaces on storage; stripped when retrieved | Preserves trailing spaces exactly as entered |
-- | Primary Use Cases | Fixed-size data: Postal codes, Country codes (`'IN'`, `'US'`), Hashes | Variable-size data: User names, Email addresses, Passwords, URLs |

-- ------------------------------------------------------------
-- 3. `TEXT` Family (Long Text Strings)
-- ------------------------------------------------------------
-- Stores long text. (Limits are in bytes — with multi-byte characters like Marathi or emoji, fewer characters fit.)

-- * **`TINYTEXT`:** Stores up to 255 bytes.

-- * **`TEXT`:** Stores up to 65,535 characters (~64 KB).

-- * **`MEDIUMTEXT`:** Stores up to 16,777,215 characters (~16 MB).

-- * **`LONGTEXT`:** Stores up to 4,294,967,295 characters (~4 GB).

-- * Best for: Blog articles, product descriptions, customer feedback, HTML/XML content.

-- ------------------------------------------------------------
-- 4. `BLOB` (Binary Large Object)
-- ------------------------------------------------------------

-- * Definition: BLOB (Binary Large Object) stores raw binary data (files), not text.

-- * Stores binary data (images, files, PDFs, audio clips, compiled code).

-- * Variants: `TINYBLOB`, `BLOB`, `MEDIUMBLOB`, `LONGBLOB`.

-- * Difference from TEXT: Unlike `TEXT`, it is intended for raw binary files and has no character set or collation.

-- ------------------------------------------------------------
-- 5. `BIT` & `BINARY(n)`
-- ------------------------------------------------------------

-- * **`BINARY(n)`:** Fixed-length binary string.

-- * **`VARBINARY(n)`:** Variable-length binary string.

-- * **`BIT(m)`:** Stores bit values from 1 to 64 bits.

--   - Stored in format 0 and 1.

--   - If you don't give a `DEFAULT`, the column is `NULL` (not 0) when no value is inserted.

-- ------------------------------------------------------------
-- 6. `BOOLEAN` / `BOOL`
-- ------------------------------------------------------------

-- * Definition: In MySQL, BOOLEAN is just another name (alias) for TINYINT(1).

-- * Some databases (like SQL Server) use a `BIT` type instead. In MySQL, BOOLEAN stores 0 or 1:

--   - `0` means FALSE.

--   - `1` means TRUE.

-- * Tip: add `DEFAULT FALSE` if new rows should start as 0 (otherwise the default is `NULL`).

-- ------------------------------------------------------------
-- 7. `ENUM('val1', 'val2', ...)`
-- ------------------------------------------------------------

-- * Definition: ENUM is a string data type that allows you to store ONE value from a predefined list of permitted values.

-- * Useful when a column should accept only specific values (like gender, status, etc.) — kind of like a controlled vocabulary.

-- * Useful for fixed categories.

-- * Example: `status ENUM('active', 'inactive', 'pending')`. Rejects any value not in the list.

-- ------------------------------------------------------------
-- 8. `SET('val1', 'val2', ...)`
-- ------------------------------------------------------------

-- * Definition: The SET data type is similar to ENUM, but instead of storing only one value, it can store MULTIPLE values (a combination) from a predefined list.

-- * Stores multiple values from a predefined list.

-- * Each row can contain any combination of permitted values separated by commas.

-- * Example: `hobbies SET('Reading', 'Sports', 'Coding', 'Music')`. A row can store `'Reading,Coding'`.

-- ---

-- ------------------------------------------------------------
-- 6.8.4 Date and Time (Temporal) Data Types
-- ------------------------------------------------------------

-- Q. What are the Temporal (Date and Time) Data Types in MySQL?

-- It is also known as the temporal data type family.

-- * Default Date Format: By default, MySQL stores date in **`YYYY-MM-DD`** format.

-- * Memory Allocation: 3 bytes of memory allocated for a single date.

-- * Supported Range for Date: `1000-01-01` to `9999-12-31`.

-- ------------------------------------------------------------
-- 1. `DATE`
-- ------------------------------------------------------------

-- * Stores date only (`YYYY-MM-DD`).

-- * Storage: 3 Bytes.

-- * Range: `1000-01-01` to `9999-12-31`.

-- * Example: `'2026-09-21'`.

-- ------------------------------------------------------------
-- 2. `TIME`
-- ------------------------------------------------------------

-- * Stores time only (`HH:MM:SS`).

-- * Storage: 3 Bytes of memory occupied by a single time value.

-- * Covers 24 hours, 60 minutes, 60 seconds.

-- * Range: `-838:59:59` to `838:59:59` (supports elapsed intervals over multiple days).

-- * Example: `'15:45:30'`.

-- ------------------------------------------------------------
-- 3. `YEAR`
-- ------------------------------------------------------------

-- * Stores year in 4 digits (`YYYY`).

-- * Storage: 1 Byte.

-- * Range: `1901` to `2155`.

-- ------------------------------------------------------------
-- 4. `DATETIME`
-- ------------------------------------------------------------

-- * Stores both date and time in format: **`YYYY-MM-DD HH:MM:SS`**.

-- * Storage: Takes 5 to 8 bytes of memory to store date and time (8 bytes originally, 5 bytes in MySQL 5.6+).

-- * Range: `1000-01-01 00:00:00` to `9999-12-31 23:59:59` (covers years 1000 to 9999).

-- * Key Characteristics:

--   - Not auto-set by default — but you can add `DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP` (supported since MySQL 5.6.5), just like `TIMESTAMP`.

--   - No time zone conversion.

--   - Useful when the value must look the same everywhere, whatever the time zone.

--   - `DATETIME` doesn't change with the server time zone.

--   - It stores the exact value as inserted.

-- ------------------------------------------------------------
-- 5. `TIMESTAMP`
-- ------------------------------------------------------------

-- * Stores both date and time in format: **`YYYY-MM-DD HH:MM:SS`**.

-- * Storage: 4 Bytes (compact storage).

-- * Range: `1970-01-01 00:00:01 UTC` to `2038-01-19 03:14:07 UTC` (based on 32-bit UNIX epoch time, i.e., 1970 to 2038).

-- * Key Characteristics:

--   - Auto-updates when row changes (if defined: `DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP`).

--   - Stores date and time, but it is timezone-sensitive.

--   - MySQL automatically converts `TIMESTAMP` values from the current time zone to UTC for storage, and back to the session time zone when retrieved.

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

-- * In MySQL (TIMESTAMP and UTC):

--   - MySQL internally stores `TIMESTAMP` values in UTC, then:

--     1. Converts to your session time zone when you read them.

--     2. Converts back to UTC when you insert them.

-- Q. Why Does UTC Matter?

-- 1. Keeps timestamps consistent across servers: In multi-region deployments, servers across different continents all log events consistently.

-- 2. Prevents confusion between time zones: Eliminates time-shifting bugs caused by regional Daylight Saving Time changes.

-- 3. Useful for global applications, scheduling, and logging: Ensures events are sequentially ordered worldwide.

-- 4. Clean display to end-users: You can always convert UTC $\rightarrow$ Local time when displaying records to users in their localized interface.

-- ---

-- ------------------------------------------------------------
-- 6.8.6 Differences Between DATETIME and TIMESTAMP
-- ------------------------------------------------------------

-- Q. What is the difference between DATETIME and TIMESTAMP?

-- | Feature / Dimension | `DATETIME` | `TIMESTAMP` |
-- | :--- | :--- | :--- |
-- | 1. Display Format | `YYYY-MM-DD HH:MM:SS` | `YYYY-MM-DD HH:MM:SS` |
-- | 2. Storage Size | 5 Bytes in MySQL 5.6.4+ (+0–3 bytes for fractional seconds); 8 bytes in older versions | 4 Bytes (more compact) |
-- | 3. Supported Range | `1000-01-01 00:00:00` to `9999-12-31 23:59:59` (Years 1000 $\rightarrow$ 9999) | `1970-01-01 00:00:01 UTC` to `2038-01-19 03:14:07 UTC` (Years 1970 $\rightarrow$ 2038) |
-- | 4. Time Zone Handling | Does NOT store time zone information. Stores exactly what you insert; no conversion. `DATETIME` doesn't change with server time zone. | Timezone-sensitive. Stored in UTC internally, but converted to current session time zone when retrieved. |
-- | 5. Auto-Update Capability | Not automatic by default. You can add `DEFAULT` / `ON UPDATE` with `CURRENT_TIMESTAMP` (MySQL 5.6.5+). | Can automatically update: Set current time on insert (`DEFAULT CURRENT_TIMESTAMP`) and update on modification (`ON UPDATE CURRENT_TIMESTAMP`). |
-- | 6. Epoch Dependency | Independent of UNIX Epoch | Bound to UNIX Epoch (Seconds elapsed since Jan 1, 1970 UTC) |
-- | 7. Best Use Cases | When you need to store date & time exactly as given, independent of time zones.<br>Examples: Birthdays, historical events, scheduled appointment times. | When you need to track events relative to the current time zone.<br>Examples: Logging creation/update times (`created_at`, `updated_at`), audit trails. |

-- ------------------------------------------------------------
-- Point-Wise Detailed Breakdown:
-- ------------------------------------------------------------

-- 1. **`DATETIME` Details:**

--    - Stores both date and time in the format: `YYYY-MM-DD HH:MM:SS`.

--    - Storage size: 5 bytes in modern MySQL (8 bytes in very old versions).

--    - Range: `1000-01-01 00:00:00` $\rightarrow$ `9999-12-31 23:59:59` (i.e. 1000 $\rightarrow$ 9999).

--    - Does not store time zone information. Stores exactly what you insert, no conversion.

--    - Not auto-set by default. You can add `DEFAULT` / `ON UPDATE` with `CURRENT_TIMESTAMP` (MySQL 5.6.5+) if needed.

--    - When you need to store a date & time exactly as given, independent of time zones.

--    - Example: Birthdays, historical events, schedule times.

-- 2. **`TIMESTAMP` Details:**

--    - Stores both date and time in the same format: `YYYY-MM-DD HH:MM:SS`.

--    - Storage size: 4 bytes (more compact).

--    - Range: `1970-01-01 00:00:01 UTC` $\rightarrow$ `2038-01-19 03:14:07 UTC` (because it is based on UNIX epoch time, i.e., 1970 $\rightarrow$ 2038).

--    - Stored in UTC internally, but converted to the current time zone when retrieved.

--    - Useful for tracking system-wide events.

--    - Can automatically:

--      - Set current time on insert (`DEFAULT CURRENT_TIMESTAMP`)

--      - Update to current time on update (`ON UPDATE CURRENT_TIMESTAMP`)

--    - When you need to track events relative to the current time zone.

--    - Example: Logging creation/update times, audit trails.

-- ---

-- ------------------------------------------------------------
-- 6.8.7 Practical Code Examples for Data Types
-- ------------------------------------------------------------

-- Production Example: Utilizing Diverse MySQL Data Types
CREATE TABLE customer_profiles (
    -- Integer Types:
    customer_id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    reward_points BIGINT DEFAULT 0,
    age TINYINT UNSIGNED,
    
    -- Exact Numeric for Currency:
    account_balance DECIMAL(10, 2) DEFAULT 0.00,
    
    -- Approximate Floating Point for Geolocation:
    latitude FLOAT(10, 6),
    longitude FLOAT(10, 6),
    
    -- Fixed String vs Variable String:
    country_code CHAR(2) NOT NULL,            -- Always 2 characters (e.g. 'IN', 'US')
    full_name VARCHAR(100) NOT NULL,           -- Dynamic length
    email VARCHAR(150) UNIQUE NOT NULL,
    
    -- Large Text:
    bio TEXT,
    
    -- Boolean Flag (TINYINT(1)):
    is_verified BOOLEAN DEFAULT FALSE,
    
    -- Category Types (ENUM & SET):
    gender ENUM('Male', 'Female', 'Other'),
    interests SET('Sports', 'Tech', 'Music', 'Travel', 'Art'),
    
    -- Temporal Types (DATETIME vs TIMESTAMP):
    date_of_birth DATE NOT NULL,              -- Date only: YYYY-MM-DD
    login_time TIME,                          -- Time only: HH:MM:SS
    birth_timestamp DATETIME,                 -- Exact literal birth time (no timezone conversion)
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- UTC converted auto-timestamp
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- > ⚠️ Note: `FLOAT(10, 6)` is deprecated since MySQL 8.0.17 (you get a warning). For latitude/longitude prefer `DECIMAL(9, 6)` or a spatial `POINT` column (see 6.8.9).

-- ---

-- ------------------------------------------------------------
-- 6.8.8 Special Data Types: JSON In-Depth
-- ------------------------------------------------------------

-- * Q. What is the JSON Data Type in MySQL and How Does It Function?

--   * Definition: JSON (JavaScript Object Notation) is a simple text format that stores data as key-value pairs and lists.

--   * *Capability: MySQL's `JSON` data type lets you store a whole JSON document (an object or an array) in one column.*

--   * Format & Structure: In JSON format, data is stored in key-value pairs, arrays, and objects. The keys are always strings (enclosed in double quotes), and values can be of any JSON-supported type (string, number, boolean, array, object, or null).

--   * Storage: MySQL saves JSON in a special binary format, so it can jump straight to a key without reading the whole text.

--   * *Validation: MySQL automatically validates any document inserted into a `JSON` column and raises an error if the document is not valid JSON syntax.*

-- * **Path Traversal Syntax & The `$` Root Symbol:**

--   * *The `$` symbol represents the root (starting point) of the JSON document.*

--   * `$` : Root JSON $\rightarrow$ Represents the entire JSON document/object.

--   * `$.key` : Specific field $\rightarrow$ Field named "key" inside the root object (e.g., `$.age` returns the age value).

--   * `$.object.key` : Nested key $\rightarrow$ Accesses a nested property inside an object (e.g., `$.address.city` accesses "city" inside "address").

--   * `$.array[index]` : Array element $\rightarrow$ Accesses an element by zero-based index position (e.g., `$.skills[0]` retrieves the first element of the "skills" array).

-- * **JSON Extraction Operators (`->` vs. `->>`):**

--   * MySQL provides two convenient inline operators for extracting values from JSON documents:

-- | Operator | Extraction Syntax | Output Type | Description & Purpose | Example | Result |
-- | :--- | :--- | :--- | :--- | :--- | :--- |
-- | `->` | `column->'path'` | JSON Value (with quotes) | Extracts the data as a JSON value preserving double quotes. Use `->` when you need to treat the result as JSON for further JSON manipulation. | `details->'$.age'` | `"25"` |
-- | `->>` | `column->>'path'` | Plain Text (unquoted) | Inline unquoting path operator. Extracts the value as clean, unquoted plain text. Use `->>` when comparing in `WHERE` clauses or displaying in UI. | `details->>'$.age'` | `25` |

-- > ⚠️ Note: `age` is a number, so `details->'$.age'` actually returns `25` (without quotes). Quotes appear only for text values: `details->'$.email'` → `"alice@example.com"`, while `details->>'$.email'` → `alice@example.com`.

-- * Core MySQL Built-in JSON Functions:

--   * `JSON_EXTRACT(json_doc, path[, path] ...)`: Extracts values from a JSON document at the specified path(s).

--   * `JSON_SET(json_doc, path, val[, path, val] ...)`: Inserts or updates values in a JSON document (updates existing keys or appends new keys).

--   * `JSON_ARRAY([val[, val] ...])`: Creates a valid JSON array from an argument list of values.

--   * `JSON_OBJECT([key, val[, key, val] ...])`: Creates a valid JSON object from alternating key-value pairs.

-- * Step-by-Step Practical SQL Implementation:

-- 1. Create a table with a native JSON column:
CREATE TABLE users (
 id INT AUTO_INCREMENT PRIMARY KEY,
 name VARCHAR(100),
 details JSON
);

-- 2. Inserting data with structured JSON documents:
INSERT INTO users (name, details) VALUES
('Alice', '{"age": 25, "email": "alice@example.com", "skills": ["SQL", "Python", "JavaScript"]}'),
('Bob', '{"age": 30, "email": "bob@example.com", "skills": ["Java", "C++"], "isAdmin": true}');

-- 3. Extract individual fields using JSON_EXTRACT():
SELECT 
  NAME,
  JSON_EXTRACT(DETAILS, '$.FIRSTNAME') AS FirstName,
  JSON_EXTRACT(DETAILS, '$.AGE') AS Age,
  JSON_EXTRACT(DETAILS, '$.ADDREDD') AS Address
FROM USER;

-- 4. Use ->> operator to extract plain text (without quotes):
SELECT NAME, DETAILS ->> '$.AGE' AS USERAGE FROM USER;

-- 5. Use -> operator to get JSON value (with quotes):
-- GET THE JSON VALUE WITH QUOTES
SELECT NAME, DETAILS -> '$.AGE' AS ISADMIN FROM USER;

-- 6. Extract nested array values (0-indexed):
-- EXTRACT NESTED ARRAY VALUE 
SELECT DETAILS->>'$.skills[0]' AS FIRST FROM USER WHERE ID = 2;
-- $ -> root, skills -> array name, [0] -> first element in the array

-- 7. Filter rows based on JSON content in the WHERE clause:
SELECT NAME, 
       DETAILS  
FROM USER 
WHERE JSON_EXTRACT(DETAILS, '$.isAdmin') = TRUE;

-- 8. Update a JSON field (Modify existing key):
UPDATE USER
SET DETAILS = JSON_SET(DETAILS, '$.ADDREDD', 'MUMBAI')
WHERE NAME = 'VISHAL';

-- 9. Add a new JSON key into an existing document:
UPDATE USER
SET DETAILS = JSON_SET(DETAILS, '$.PHONE', '123456789')
WHERE ID = 1;

-- 10. Update or Add key using JSON_SET():
UPDATE USER
SET DETAILS = JSON_SET(DETAILS, '$.MOBILENUMBER', '9988999889')
WHERE ID = 1;

SELECT * FROM USER;

-- 11. Extract nested properties of an object:
-- GET NESTED PROPERTIES 
SELECT NAME, DETAILS, JSON_EXTRACT(DETAILS, '$.address.city') AS USERCITY FROM USER WHERE ID = 2;

-- 12. Create a JSON Array on the fly:
SELECT JSON_ARRAY('SQL', 'Node.js', 'Python') AS skills;

-- 13. Create a JSON Object on the fly:
SELECT JSON_OBJECT('name', 'Vishal', 'age', 25, 'city', 'Pune') AS user_details;

-- 14. Advanced JSON Manipulation: Create a new JSON Array inside details:
-- Use JSON_ARRAY() along with JSON_SET()
UPDATE users
SET details = JSON_SET(details, '$.skills', JSON_ARRAY('SQL', 'Node.js', 'Python'))
WHERE name = 'Vishal';

-- 15. Advanced JSON Manipulation: Add a new nested object inside existing JSON:
-- Use JSON_OBJECT() to create a nested object
UPDATE users
SET details = JSON_SET(
  details,
  '$.address',
  JSON_OBJECT('street', 'MG Road', 'city', 'Pune', 'zip', '411001')
)
WHERE name = 'Vishal';

-- 16. Advanced JSON Manipulation: Create an object inside an existing object (Deep Nesting):
-- Specify deeper nested paths like $.address.geo
UPDATE users
SET details = JSON_SET(
  details,
  '$.address.geo',
  JSON_OBJECT('lat', 18.5204, 'lng', 73.8567)
)
WHERE name = 'Vishal';

-- > ⚠️ Note on the code above: Steps 3–13 use the table name `USER`, but step 1 created `users` — use `users`. JSON keys are case-sensitive: `'$.AGE'` returns NULL because the stored key is `age`. `'$.FIRSTNAME'` and `'$.ADDREDD'` (typo) don't exist in the inserted data, so they also return NULL. Step 11 needs an `address` key first (it is added in step 15).

-- * Summary Checklist for MySQL JSON Operations:

--   * `$` : Root of the JSON document.

--   * `$.key` : Specific field in root object.

--   * `$.object.key` : Nested field inside an object.

--   * `$.array[index]` : Specific element from an array.

--   * `->` : Shortcut for `JSON_EXTRACT()` returning quoted JSON value.

--   * `->>` : Shortcut for `JSON_UNQUOTE(JSON_EXTRACT())` returning clean plain text.

--   * `JSON_EXTRACT()` : Extracts values from JSON data paths.

--   * `JSON_SET()` : Inserts or updates key-value pairs in a JSON document.

--   * `JSON_ARRAY()` : Creates a JSON array from given values.

--   * `JSON_OBJECT()` : Creates a JSON object from key-value pairs.

-- ---

-- ------------------------------------------------------------
-- 6.8.9 Special Data Types: GEOMETRY Types for GIS / Spatial Data In-Depth
-- ------------------------------------------------------------

-- * Q. What are MySQL Spatial / GIS Data Types and How Are They Used?

--   * Definition: Spatial (GIS) data types store locations and shapes — points, lines and areas on a map.

--   * Standards: MySQL follows the OpenGIS (OGC) standard for these types.

--   * Primary Use Cases:

--     * Mapping applications (Google Maps, GIS portals, GPS telemetry).

--     * Real-time location tracking (latitude/longitude coordinates of users or delivery fleets).

--     * Geofencing, restricted zones, and delivery service coverage boundaries.

--     * Spatial calculations (distance between locations, area of regions, point-in-polygon checks).

-- * The 8 OpenGIS Spatial Data Types in MySQL:

-- | Data Type | Structural Category | Geometric Representation | Primary Real-World Use Case |
-- | :--- | :--- | :--- | :--- |
-- | `GEOMETRY` | Generic Spatial | Any geometric shape (`POINT`, `LINESTRING`, `POLYGON`). | Flexible column capable of holding any spatial geometry per row. |
-- | `POINT` | Single Coordinate | Single 2D coordinate pair $(x, y)$ (longitude, latitude). | User coordinates, GPS device locations, store/branch coordinates. |
-- | `LINESTRING` | Connected Points | Series of connected coordinate points representing a line. | Roads, delivery routes, rivers, railway tracks, flight paths. |
-- | `POLYGON` | Closed Area | Closed boundary where the last coordinate connects to the first. | City limits, delivery coverage zones, lakes, property plots. |
-- | `MULTIPOINT` | Multi-Geometry | Collection of multiple separate `POINT` objects. | Multiple branch locations of a company, multiple check-in points. |
-- | `MULTILINESTRING` | Multi-Geometry | Collection of multiple separate `LINESTRING` objects. | Road networks, subway transit systems, highway networks. |
-- | `MULTIPOLYGON` | Multi-Geometry | Collection of multiple separate `POLYGON` objects. | Country territories with archipelagos/islands, multi-district zones. |
-- | `GEOMETRYCOLLECTION` | Mixed Collection | Collection containing mixed geometry types (`POINT` + `LINE` + `POLYGON`). | Mixed complex geographic zones (e.g., city with points, routes, and parks). |

-- * In-Depth Breakdown of Each Geometry Type with Code Examples:

-- ------------------------------------------------------------
-- 1. GEOMETRY (Any Geometric Object)
-- ------------------------------------------------------------

-- * *Definition: A generic spatial data type that can store any spatial object (`POINT`, `LINESTRING`, or `POLYGON`).*

-- * Use Case: When a single column needs the flexibility to store varying geometry types across different records.

-- CREATE TABLE WITH GEOMETRY DATA TYPE 
CREATE TABLE GEO_OBJECTS(
  ID INT AUTO_INCREMENT PRIMARY KEY,
  NAME VARCHAR(50),
  SHAP GEOMETRY
);

-- Insert a Point into GEOMETRY column:
INSERT INTO geo_objects (name, SHAP)
VALUES ('Store Location', ST_GeomFromText('POINT(72.8777 19.0760)'));

SELECT * FROM GEO_OBJECTS;

-- ------------------------------------------------------------
-- 2. POINT (Single Coordinate $(x, y)$)
-- ------------------------------------------------------------

-- * Definition: Represents a single location in 2D space with $x$ (longitude) and $y$ (latitude) coordinates.

-- * Use Case: Track user/device live location, store physical address coordinates, pin landmarks and points of interest.

-- CREATE TABLE TO STORE THE LOCATION OF USER
CREATE TABLE USER_LOCATION(
  ID INT AUTO_INCREMENT PRIMARY KEY,
  NAME VARCHAR(50),
  LOCATION POINT
);

-- INSERT DATA INTO USER LOCATION TABLE USING POINT GEOMETRY TYPE
INSERT INTO USER_LOCATION(NAME, LOCATION) 
VALUES('VISHAL', ST_GeomFromText('POINT(72.8777 19.0760)'));

-- Convert binary geometry to readable WKT text:
SELECT NAME, ST_AsText(location) AS location_text FROM USER_LOCATION;

-- ------------------------------------------------------------
-- 3. LINESTRING (Connected Path / Route)
-- ------------------------------------------------------------

-- * Definition: A series of two or more connected coordinate points forming a continuous path.

-- * Use Case: Model roads, rivers, walking paths, delivery vehicle routes, and transit tracks.

-- CREATE TABLE WITH LINESTRING
CREATE TABLE road(
  id INT AUTO_INCREMENT PRIMARY KEY,
  road_name VARCHAR(50),
  road_path LINESTRING
);

-- INSERT LINESTRING DATA INTO THE TABLE 
INSERT INTO road (road_name, road_path) 
VALUES ('pune_nashik_hiway', ST_GeomFromText('LINESTRING(77.59 12.97, 77.60 12.98, 77.62 12.99)'));

SELECT road_name, ST_AsText(road_path) FROM road;

-- ------------------------------------------------------------
-- 4. POLYGON (Closed Area / Boundary)
-- ------------------------------------------------------------

-- * Definition: A closed surface shape formed by connecting multiple points where the last point connects back to the first point.

-- * Use Case: Define city municipal boundaries, restricted zones, delivery service radiuses, lakes, parks, and agricultural plots.

-- CREATE TABLE WITH POLYGON 
CREATE TABLE REAGION(
  ID INT AUTO_INCREMENT PRIMARY KEY,
  REGION_NAME VARCHAR(50),
  REAGION POLYGON
);

-- INSERT POLYGON DATA 
INSERT INTO REAGION(REGION_NAME, REAGION)
VALUES('KASARSAI_DAM', ST_GEOMFROMTEXT('POLYGON((77.58 12.97, 77.60 12.97, 77.60 12.99, 77.58 12.99, 77.58 12.97))'));

SELECT * FROM REAGION;

-- ------------------------------------------------------------
-- 5. MULTIPOINT (Collection of Multiple Points)
-- ------------------------------------------------------------

-- * *Definition: A collection of multiple individual `POINT` geometries stored in a single record.*

-- * Use Case: Store all branches, stores, or user check-in points within a single corporate zone.

-- CREATE TABLE FOR MULTIPOINT 
CREATE TABLE MULTIPOINT(
  ID INT AUTO_INCREMENT PRIMARY KEY,
  NAME VARCHAR(50),
  LOCATION MULTIPOINT
);

-- INSERT MULTIPOINT DATA 
INSERT INTO MULTIPOINT (NAME, LOCATION) 
VALUES('PUNE-ZONE', ST_GEOMFROMTEXT('MULTIPOINT((77.59 12.97), (77.61 12.98), (77.63 12.99))'));

SELECT * FROM MULTIPOINT;

-- ------------------------------------------------------------
-- 6. MULTILINESTRING (Collection of Multiple Lines)
-- ------------------------------------------------------------

-- * *Definition: A collection of multiple `LINESTRING` objects grouped together in a single record.*

-- * Use Case: Represent a full network of roads, train transit networks, or delivery flight paths.

CREATE TABLE MULTLILINESTRINGDATA(
  ID INT AUTO_INCREMENT PRIMARY KEY,
  NETWORK_NAME VARCHAR(50),
  PATHS MULTILINESTRING
);

-- INSERT MULTILINE DATA 
INSERT INTO MULTLILINESTRINGDATA (NETWORK_NAME, PATHS) 
VALUES ('D-MART', ST_GEOMFROMTEXT('MULTILINESTRING((77.58 12.97, 77.60 12.98), (77.61 12.99, 77.63 13.00))'));

SELECT * FROM MULTLILINESTRINGDATA;

-- ------------------------------------------------------------
-- 7. MULTIPOLYGON (Collection of Multiple Closed Polygons)
-- ------------------------------------------------------------

-- * *Definition: A collection of multiple separate `POLYGON` closed areas grouped into a single spatial entity.*

-- * Use Case: Represent non-contiguous land territories, archipelagos/islands, multi-district sales zones.

-- CREATE TABLE MULTIPOLYGON 
CREATE TABLE MULTIPOLYGONDATA(
  ID INT AUTO_INCREMENT PRIMARY KEY, 
  NAME VARCHAR(50),
  AREAS MULTIPOLYGON
);

-- INSERT MULTIPOLYGON DATA INTO TABLE
INSERT INTO MULTIPOLYGONDATA (NAME, AREAS)
VALUES('District Zones', ST_GeomFromText('MULTIPOLYGON(((77.58 12.97, 77.60 12.97, 77.60 12.99, 77.58 12.99, 77.58 12.97)), ((77.62 13.00, 77.64 13.00, 77.64 13.02, 77.62 13.02, 77.62 13.00)))'));

SELECT * FROM MULTIPOLYGONDATA;

-- ------------------------------------------------------------
-- 8. GEOMETRYCOLLECTION (Mixed Collection of Geometries)
-- ------------------------------------------------------------

-- * *Definition: A collection container capable of storing any arbitrary combination of geometry types (`POINT`, `LINESTRING`, and `POLYGON`) within a single record.*

-- * Use Case: Storing comprehensive city maps that incorporate points of interest, transit lines, and zone polygons simultaneously.

CREATE TABLE geo_collection (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(50),
  geo_data GEOMETRYCOLLECTION
);

INSERT INTO geo_collection (name, geo_data)
VALUES ('City Example', ST_GeomFromText(
  'GEOMETRYCOLLECTION(
     POINT(77.59 12.97),
     LINESTRING(77.59 12.97, 77.61 12.98),
     POLYGON((77.62 13.00, 77.64 13.00, 77.64 13.02, 77.62 13.02, 77.62 13.00))
   )'
));

-- ---

-- ------------------------------------------------------------
-- Detailed Comparison: `GEOMETRY` vs. `GEOMETRYCOLLECTION`
-- ------------------------------------------------------------

-- * High-Level Analogy:

--   * `GEOMETRY` = A flexible container that can hold one single item of any geometry type (a single Point, a single Line, or a single Polygon).

--   * `GEOMETRYCOLLECTION` = A comprehensive container that holds multiple items together in one record (Points + Lines + Polygons combined).

-- | Feature / Aspect | `GEOMETRY` Type | `GEOMETRYCOLLECTION` Type |
-- | :--- | :--- | :--- |
-- | Storage Capacity | Stores only one geometry object at a time per row. | Stores multiple geometry objects in a single record. |
-- | Object Variation | The type can vary across rows (Row 1 = Point, Row 2 = Polygon). | Can contain a heterogeneous mix of Points, Lines, and Polygons simultaneously. |
-- | Shape Complexity | Models simple shapes (individual point or single polygon). | Models complex compound shapes (entire city layout). |
-- | Use Case | When you want column flexibility without knowing the specific type ahead of time. | When multiple geometric elements make up a single logical geographic entity. |
-- | WKT Syntax Example | `'POINT(77.59 12.97)'` or `'POLYGON((...))'` | `'GEOMETRYCOLLECTION(POINT(...), LINESTRING(...), POLYGON(...))'` |

-- * **Code Demonstration: `GEOMETRY` vs `GEOMETRYCOLLECTION`:**

-- A. GEOMETRY: Storing one simple shape per row
CREATE TABLE geo_examples (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(50),
  shape GEOMETRY
);

-- Store a single point:
INSERT INTO geo_examples (name, shape)
VALUES ('Restaurant', ST_GeomFromText('POINT(77.59 12.97)'));

-- Store a single polygon:
INSERT INTO geo_examples (name, shape)
VALUES ('Park', ST_GeomFromText('POLYGON((77.58 12.96, 77.60 12.96, 77.60 12.98, 77.58 12.98, 77.58 12.96))'));

-- B. GEOMETRYCOLLECTION: Storing multiple combined shapes together
CREATE TABLE city_shapes (
  id INT AUTO_INCREMENT PRIMARY KEY,
  city_name VARCHAR(50),
  objects GEOMETRYCOLLECTION
);

-- Store multiple shapes together in one record:
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
-- Special Spatial Functions in MySQL
-- ------------------------------------------------------------

-- * **1. `ST_GeomFromText('WKT')`:**

--   * Purpose: Creates a binary geometry object from Well-Known Text (WKT) string representation.

CREATE TABLE locations (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    geom GEOMETRY
);

-- Insert a POINT using WKT:
INSERT INTO locations (name, geom)
VALUES ('User A', ST_GeomFromText('POINT(77.5946 12.9716)'));

-- Insert a POLYGON using WKT:
INSERT INTO locations (name, geom)
VALUES ('Park Area', ST_GeomFromText(
    'POLYGON((77.58 12.97, 77.60 12.97, 77.60 12.99, 77.58 12.99, 77.58 12.97))'
));

-- * **2. `ST_AsText(geometry)`:**

--   * Purpose: Converts internal binary geometry data back into human-readable WKT string format.

SELECT name, ST_AsText(geom) AS geom_text
FROM locations;

-- * **3. `ST_Distance(geometry1, geometry2)`:**

--   * Purpose: Calculates the distance between two geometry objects.

--   * *Note: With the default SRID 0, MySQL gives a flat (planar) distance, not the real distance on Earth. For real distance in meters, use SRID 4326 or `ST_Distance_Sphere()`.*

-- Create two points:
SET @p1 = ST_GeomFromText('POINT(77.5946 12.9716)'); -- Bangalore
SET @p2 = ST_GeomFromText('POINT(77.6090 12.9721)'); -- Nearby location

-- Calculate distance:
SELECT ST_Distance(@p1, @p2) AS distance;

-- * **4. `ST_Within(geometry_a, geometry_b)`:**

--   * *Purpose: Checks whether geometry `a` is completely located inside geometry `b` (e.g. Point inside a Polygon). Returns `1` (true) or `0` (false).*

-- Create a point and a polygon:
SET @point = ST_GeomFromText('POINT(77.59 12.98)');
SET @polygon = ST_GeomFromText('POLYGON((77.58 12.97, 77.60 12.97, 77.60 12.99, 77.58 12.99, 77.58 12.97))');

-- Check if point is within polygon:
SELECT ST_Within(@point, @polygon) AS is_within;

-- * **5. `ST_Contains(geometry_a, geometry_b)`:**

--   * *Purpose: Checks whether geometry `a` contains geometry `b` (e.g. Polygon contains a Point). Returns `1` (true) or `0` (false).*

-- Check if polygon contains point:
SELECT ST_Contains(@polygon, @point) AS contains;

-- ---

-- ------------------------------------------------------------
-- 6.8.10 Quick Overview: JSON & Spatial GEOMETRY (Methods & Properties Master Cheat Sheet)
-- ------------------------------------------------------------

-- * Q. What is the Quick Reference for MySQL JSON and Spatial GEOMETRY Data Types?

--   * A quick lookup table for JSON paths, operators and functions, and for spatial types and functions (MySQL 8.0+).

-- ------------------------------------------------------------
-- Part 1: JSON Data Type — Quick Reference & Methods Matrix
-- ------------------------------------------------------------

-- ------------------------------------------------------------
-- 1. JSON Path Traversal Properties
-- ------------------------------------------------------------
-- | Path Expression | Target Element | Description & Behavior | Example |
-- | :--- | :--- | :--- | :--- |
-- | `$` | Document Root | The entire JSON document / top-level object or array. | `SELECT data->'$' FROM t;` |
-- | `$.key` | Direct Object Key | Extracts the value of property `key` from the root object. | `data->>'$.age'` |
-- | `$.parent.child` | Nested Property | Traverses inside object `parent` to retrieve `child`. | `data->>'$.address.city'` |
-- | `$.array[i]` | Array Element | Retrieves element at 0-based index `i`. | `data->>'$.skills[0]'` |
-- | `$.array[*]` | Array Wildcard | Returns all elements of the array. | `JSON_EXTRACT(data, '$.skills[*]')` |
-- | `$.*` | Object Wildcard | Returns the values of all direct keys in the object. | `JSON_EXTRACT(data, '$.*')` |

-- ------------------------------------------------------------
-- 2. JSON Extraction Operators Matrix
-- ------------------------------------------------------------
-- | Operator | Name | Syntax | Return Format | Best Used For |
-- | :--- | :--- | :--- | :--- | :--- |
-- | `->` | Arrow Operator | `column->'path'` | JSON-formatted value (with double quotes) | Further JSON functions, preserving JSON typing |
-- | `->>` | Inline Unquote Operator | `column->>'path'` | Clean unquoted plain string (without quotes) | Displaying in UI, filtering in `WHERE`, joining |

-- ------------------------------------------------------------
-- 3. Complete MySQL JSON Built-in Methods
-- ------------------------------------------------------------
-- | Method / Function | Signature / Parameters | Purpose & Description | Practical SQL Example |
-- | :--- | :--- | :--- | :--- |
-- | `JSON_EXTRACT()` | `(doc, path[, path]...)` | Extracts data from a JSON document at specified path(s). | `JSON_EXTRACT(details, '$.email')` |
-- | `JSON_SET()` | `(doc, path, val[, path, val]...)` | Updates existing keys or adds new keys if absent. | `JSON_SET(details, '$.active', true)` |
-- | `JSON_INSERT()` | `(doc, path, val[, path, val]...)` | Adds new key-value pair only if the key does not exist. | `JSON_INSERT(details, '$.role', 'Admin')` |
-- | `JSON_REPLACE()` | `(doc, path, val[, path, val]...)` | Overwrites value only if the key already exists. | `JSON_REPLACE(details, '$.age', 31)` |
-- | `JSON_REMOVE()` | `(doc, path[, path]...)` | Deletes a key, property, or array element from the JSON. | `JSON_REMOVE(details, '$.skills[1]')` |
-- | `JSON_ARRAY()` | `([val1, val2, ...])` | Creates a JSON array on the fly from arguments. | `JSON_ARRAY('Java', 'Python', 'SQL')` |
-- | `JSON_OBJECT()` | `([k1, v1, k2, v2, ...])` | Creates a JSON object on the fly from key-value pairs. | `JSON_OBJECT('city', 'Pune', 'zip', 411001)` |
-- | `JSON_CONTAINS()` | `(target, candidate[, path])` | Checks if JSON document contains a specific value (returns 1 or 0). | `JSON_CONTAINS(details, '"SQL"', '$.skills')` |
-- | `JSON_SEARCH()` | `(doc, 'one'\|'all', search_str)` | Searches for a string within a document and returns its path. | `JSON_SEARCH(details, 'one', 'Python')` |
-- | `JSON_TYPE()` | `(json_val)` | Returns the data type string (`OBJECT`, `ARRAY`, `INTEGER`, etc.). | `JSON_TYPE(JSON_EXTRACT(details, '$.age'))` |
-- | `JSON_VALID()` | `(val)` | Validates whether a string has valid JSON syntax (returns 1 or 0). | `JSON_VALID('{"valid": true}')` |

-- ---

-- ------------------------------------------------------------
-- Part 2: Spatial GEOMETRY Types — Quick Reference & Methods Matrix
-- ------------------------------------------------------------

-- ------------------------------------------------------------
-- 1. The 8 OpenGIS Spatial Data Types Matrix
-- ------------------------------------------------------------
-- | Spatial Type | Structural Geometry | Dimension | Real-World Application | WKT Syntax Pattern |
-- | :--- | :--- | :--- | :--- | :--- |
-- | `POINT` | Single 2D coordinate $(x, y)$ | 0D (Point) | GPS user locations, pin drop, branch coordinates | `POINT(77.59 12.97)` |
-- | `LINESTRING` | Connected series of points | 1D (Length) | Roads, delivery routes, rivers, railways, flight corridors | `LINESTRING(x1 y1, x2 y2, ...)` |
-- | `POLYGON` | Closed area (first = last point) | 2D (Area) | Delivery geofencing zones, lakes, city boundaries, plots | `POLYGON((x1 y1, x2 y2, ..., x1 y1))` |
-- | `MULTIPOINT` | Multiple distinct points | 0D Set | Multiple store branches, delivery drop points | `MULTIPOINT((x1 y1), (x2 y2))` |
-- | `MULTILINESTRING` | Multiple distinct line paths | 1D Set | Highway networks, subway train lines, multi-segment routes | `MULTILINESTRING((...), (...))` |
-- | `MULTIPOLYGON` | Multiple closed polygon zones | 2D Set | Archipelagos/islands, multi-district sales territories | `MULTIPOLYGON(((...)), ((...)))` |
-- | `GEOMETRYCOLLECTION` | Mixed heterogeneous collection | Mixed | Complex city models (Points + Lines + Polygons combined) | `GEOMETRYCOLLECTION(POINT(...), ...)` |
-- | `GEOMETRY` | Polymorphic spatial column | Any | Column that can store any single geometric object per row | Holds any single geometry object |

-- ------------------------------------------------------------
-- 2. Complete MySQL Spatial Analysis Methods (`ST_` Functions)
-- ------------------------------------------------------------
-- | Function Name | Input Signature | Output Type | Description & Analysis Role | Practical SQL Example |
-- | :--- | :--- | :--- | :--- | :--- |
-- | `ST_GeomFromText()` | `(wkt_string[, srid])` | Geometry Object | Converts Well-Known Text (WKT) string to internal binary geometry. | `ST_GeomFromText('POINT(72.87 19.07)')` |
-- | `ST_AsText()` | `(geometry_obj)` | WKT String | Converts internal binary geometry back into human-readable text. | `SELECT ST_AsText(location) FROM user_location;` |
-- | `ST_Distance()` | `(geom1, geom2)` | Double | Computes planar Euclidean distance between two geometries. | `ST_Distance(point1, point2)` |
-- | `ST_Within()` | `(geom_a, geom_b)` | Boolean (0 or 1) | Checks if geometry `A` is completely inside geometry `B`. | `ST_Within(user_point, zone_polygon)` |
-- | `ST_Contains()` | `(geom_a, geom_b)` | Boolean (0 or 1) | Checks if geometry `A` completely surrounds/encloses geometry `B`. | `ST_Contains(zone_polygon, user_point)` |
-- | `ST_Area()` | `(polygon_obj)` | Double | Calculates total surface area of a closed Polygon or MultiPolygon. | `ST_Area(region)` |
-- | `ST_Length()` | `(linestring_obj)` | Double | Calculates the total length of a LineString or MultiLineString. | `ST_Length(road_path)` |
-- | `ST_Buffer()` | `(geom, distance)` | Polygon Object | Generates a polygon buffer zone of radius $d$ around a geometry. | `ST_Buffer(store_point, 5000)` |
-- | `ST_Intersects()` | `(geom1, geom2)` | Boolean (0 or 1) | Returns 1 if any part of `geom1` touches or overlaps `geom2`. | `ST_Intersects(route_line, flood_zone)` |

-- ---

-- ------------------------------------------------------------
-- 6.9 Visual Architectural Diagrams for Data Types & Hierarchy
-- ------------------------------------------------------------

-- ------------------------------------------------------------
-- Diagram 1: Comprehensive MySQL Data Types Architecture
-- ------------------------------------------------------------

--   * Top Section (Memory Strategy): Highlights the architectural difference between Fixed Data Types (pre-allocating memory bytes) and Variable Data Types (dynamically allocating based on string length + prefix byte).

--   * 4 Main Taxonomy Cards:

--     1. Numeric Types: Explains `INT` (4B), `TINYINT` (1B), `BIGINT` (8B), exact arithmetic `DECIMAL(p,s)` for money, and `FLOAT`/`DOUBLE` for science.

--     2. String & Text Types: Details `CHAR(n)` (fixed padding) vs `VARCHAR(n)` (dynamic), `TEXT` scaling (up to 4GB), and `BLOB` for binary assets.

--     3. Date & Time (Temporal): Illustrates `DATE`, `TIME`, `YEAR`, `DATETIME` (independent), and `TIMESTAMP` (UTC-aware).

--     4. Specialized Types: Outlines `BOOLEAN` (0/1), `BIT`, single-category `ENUM`, and multi-category `SET`.

-- ---

-- ------------------------------------------------------------
-- Diagram 2: DATETIME vs. TIMESTAMP In-Depth Architectural Comparison
-- ------------------------------------------------------------

--   * **Left Card (`DATETIME`):** 8/5 Bytes storage, 9,000-year span (`1000` to `9999`), literal storage with zero time zone conversion, best for birthdays and schedules.

--   * **Right Card (`TIMESTAMP`):** 4 Bytes compact storage, bound by 32-bit UNIX Epoch (`1970` to `2038`), automatic UTC conversion, auto-update on changes (`CURRENT_TIMESTAMP`), best for audit logs.

--   * Bottom Pipeline (UTC Workflow): Shows client in India writing in IST ($\text{UTC}+5:30$), engine storing in universal UTC ($0:00$), and client in the US reading in EST ($\text{UTC}-5:00$) seamlessly.

-- ---

-- ------------------------------------------------------------
-- Diagram 3: Database Structure & Hierarchy Diagram
-- ------------------------------------------------------------

-- * Explanation:

--   * Displays the 4-tier relational structure: Server $\rightarrow$ Databases $\rightarrow$ Schemas $\rightarrow$ Tables.

--   * Details table anatomy (Columns, Rows, Cells) and Primary Key indexing.

-- ---

-- ------------------------------------------------------------
-- Diagram 4: MySQL JSON Data Type Architecture & Path Traversal
-- ------------------------------------------------------------

--   * Header & Concept: Highlights the internal binary format of MySQL JSON columns, distinguishing it from raw text strings for fast key-indexed lookup.

--   * **The `$` Root Symbol & Path Navigation:** Shows how `$` represents the root document, `$.key` targets a specific field, `$.object.key` navigates nested objects, and `$.array[i]` indexes into arrays.

--   * **Extraction Operators (`->` vs. `->>`):** Visualizes the critical difference between `->` (quoted JSON value) and `->>` (unquoted clean plain text).

--   * Core Built-in JSON Functions: Details `JSON_EXTRACT()`, `JSON_SET()`, `JSON_ARRAY()`, and `JSON_OBJECT()`.

-- ---

-- ------------------------------------------------------------
-- Diagram 5: MySQL Spatial / GIS Geometry Data Types & Functions Architecture
-- ------------------------------------------------------------

--   * OpenGIS Spatial Hierarchy: Illustrates the OpenGIS geometry hierarchy starting from the base `GEOMETRY` class down to concrete subtypes.

--   * Core Geometry Types: Visualizes `POINT(x y)` (locations), `LINESTRING` (routes/roads), `POLYGON` (closed boundaries/zones), and their multi-counterparts (`MULTIPOINT`, `MULTILINESTRING`, `MULTIPOLYGON`).

--   * GEOMETRY vs. GEOMETRYCOLLECTION: Visually contrasts a flexible container holding one shape vs. a composite container holding multiple heterogeneous shapes together.

--   * **Spatial Analysis Functions (`ST_`):** Summarizes `ST_GeomFromText()`, `ST_AsText()`, `ST_Distance()` (planar Euclidean), `ST_Within()`, and `ST_Contains()`.

-- ---

--   4. Date & Time (Temporal Types):

-- ---

-- ======================================================================
-- 🎯 Practice Questions (salesdb sample data) — try first, then look at the answer
-- ======================================================================
-- Run 00-Setup-Sample-Data.sql once before this section.

USE salesdb;

-- Q1. Database → table → column: list the tables of salesdb and the columns of products.
SHOW TABLES;
SHOW COLUMNS FROM products;

-- Q2. Data types: show the data type of every column in orders.
SELECT column_name, data_type, character_maximum_length
FROM information_schema.columns
WHERE table_schema = 'salesdb' AND table_name = 'orders';

-- Q3. DATE vs TIMESTAMP: show orderdate (DATE) and creationtime (TIMESTAMP) side by side.
SELECT orderid, orderdate, creationtime FROM orders;
