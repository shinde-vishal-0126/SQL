-- 📘 Part 2: SQL Commands, Keys & Transactions (DDL, DML, DQL, DCL, TCL) (Topics 9–19)
-- ======================================================================

-- ---

-- ======================================================================
-- Topic 9: SQL Commands & DDL (Data Definition Language) In-Depth
-- ======================================================================

-- ------------------------------------------------------------
-- 📖 In Simple Words
-- ------------------------------------------------------------

-- * Definition: DDL (Data Definition Language) commands build and change the structure of the database: CREATE, ALTER, DROP, TRUNCATE, RENAME. They work on tables, not on individual rows.

-- * Real-life example: DDL is the carpenter who builds, resizes or removes the cupboard; it does not decide what goes inside.

-- * 🧩 Syntax:
--     CREATE TABLE table_name (col DATA_TYPE [constraint], ...);
--     ALTER TABLE table_name ADD COLUMN col DATA_TYPE;
--     ALTER TABLE table_name MODIFY COLUMN col NEW_TYPE;
--     ALTER TABLE table_name RENAME COLUMN old TO new;
--     ALTER TABLE table_name DROP COLUMN col;
--     RENAME TABLE old_name TO new_name;
--     TRUNCATE TABLE table_name;
--     DROP TABLE [IF EXISTS] table_name;

-- * Syntax explained (each part):
--   - CREATE → build a new object
--   - ALTER → change an existing object (add / change / rename / drop a column)
--   - TRUNCATE → remove all rows quickly, keep the structure
--   - DROP → remove the object completely
--   - [IF EXISTS] → optional: no error if the object is missing

-- * Example on salesdb (run 00-Setup-Sample-Data.sql first):
USE salesdb;
CREATE TABLE suppliers (supplierid INT PRIMARY KEY, name VARCHAR(50));
ALTER TABLE suppliers ADD COLUMN city VARCHAR(50);
DROP TABLE suppliers;

-- * Example explained (step by step):
--   1. CREATE TABLE makes a new empty table with two columns.
--   2. ALTER TABLE adds a third column (city) to the existing table.
--   3. DROP TABLE removes the table completely — structure and data.

-- ------------------------------------------------------------
-- 9.1 Check Current SQL / MySQL Version
-- ------------------------------------------------------------

-- To verify the current installed version of your database engine:

SELECT VERSION();
-- +-----------+
-- | VERSION() |
-- +-----------+
-- | 9.1.0     |
-- +-----------+
-- 1 row in set (0.00 sec)

-- ---

-- ------------------------------------------------------------
-- 9.2 Broad Classification of SQL Commands
-- ------------------------------------------------------------
-- SQL commands are used to communicate with the database, manage structures, and manipulate data. They are classified into:

-- 1. DDL (Data Definition Language): Defines and modifies the structure/blueprint of database objects (`CREATE`, `ALTER`, `DROP`, `TRUNCATE`, `RENAME`).

-- 2. DML (Data Manipulation Language): Manipulates actual row data (`INSERT`, `UPDATE`, `DELETE`).

-- 3. DQL (Data Query Language): Searches, filters, and retrieves data (`SELECT`).

-- ---

-- ------------------------------------------------------------
-- 9.3 What is DDL (Data Definition Language)?
-- ------------------------------------------------------------

-- * *Definition: DDL (Data Definition Language) commands create, change and delete the structure of the database — databases, tables, indexes, views, etc.*

--   * Defines the structure of the database object: It is how you create, modify, or delete the blueprint of your database.

--   * Works on structure, not on individual rows: DDL changes tables and other objects. (`DROP` and `TRUNCATE` also remove the data, because they remove/empty the whole table.)

-- * Objects It Works On: Databases, Schemas, Tables, Views, Indexes, Stored Procedures, Triggers, and Functions.

-- * Core Functions:

--   * **`CREATE`**: Creates a database or database objects inside the DB (Database / Schema, Table, Index, View, Stored Procedure, Triggers, Function).

--   * **`ALTER`**: Modifies the structure of existing objects without deleting them.

--   * **`DROP`**: Permanently deletes database objects and all their data.

--   * **`TRUNCATE`**: Removes all records from a table while preserving the table structure.

--   * **`RENAME`**: Changes the name of existing database objects.

-- ---

-- ------------------------------------------------------------
-- 9.4 The Implicit Commit Rule in MySQL
-- ------------------------------------------------------------
-- > ⚠️ Critical Architectural Note:
-- > In MySQL, most DDL statements perform an implicit commit.
-- > This means that when you execute a DDL command (`CREATE`, `ALTER`, `DROP`, `TRUNCATE`), MySQL commits the current transaction automatically.
-- > You CANNOT use ROLLBACK to undo a DDL operation!

-- ---

-- ------------------------------------------------------------
-- 9.5 CREATE Commands (Database, Tables, Indexes & Info)
-- ------------------------------------------------------------
-- The **`CREATE`** command is used to create a database or database objects inside the DB (such as Tables, Indexes, Views, Stored Procedures, Triggers, and Functions).

-- ------------------------------------------------------------
-- 1. How to Create a Database
-- ------------------------------------------------------------

-- * Syntax:
CREATE DATABASE [IF NOT EXISTS] db_name;

-- * Examples:
-- Basic creation:
CREATE DATABASE company_db;

-- Safe creation (avoids error if it already exists):
CREATE DATABASE IF NOT EXISTS school_db;

-- ------------------------------------------------------------
-- 2. How to Show All Databases in the RDBMS
-- ------------------------------------------------------------

-- * Command / Syntax:
SHOW DATABASES;

-- ------------------------------------------------------------
-- 3. How to Select or Use a Particular Database
-- ------------------------------------------------------------

-- * Once a database is created, you must select it before creating tables or querying:

-- * Syntax:
USE db_name;

-- * Example:
USE company_db;

-- ------------------------------------------------------------
-- 4. How to Show All Tables in the Current Database
-- ------------------------------------------------------------

-- * Command / Syntax:
SHOW TABLES;

-- ------------------------------------------------------------
-- 5. How to Create a Table
-- ------------------------------------------------------------

-- * General Syntax:
CREATE TABLE table_name (
    column1 datatype constraints,
    column2 datatype constraints,
    ...
);

-- * Basic Example (Without explicit constraints):
CREATE TABLE employees (
    id INT,
    name VARCHAR(100),
    age INT,
    email VARCHAR(150),
    salary DECIMAL(10, 2)
);

-- * Production Example (With Constraints: Primary Key, Not Null, Unique, Default):
CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    age INT,
    email VARCHAR(150) UNIQUE,
    salary DECIMAL(10, 2) DEFAULT 0
);

-- ------------------------------------------------------------
-- 6. How to Show Detailed Information / Schema of a Table
-- ------------------------------------------------------------

-- * Syntax:
DESCRIBE table_name;
-- or shorthand:
DESC table_name;

-- * Example:
DESCRIBE employees;
-- or
DESC employees;

-- ------------------------------------------------------------
-- 7. How to Create an Index on a Table
-- ------------------------------------------------------------
-- An index makes searching on a column much faster (like the index at the back of a book):

-- * Syntax:
CREATE INDEX index_name
ON table_name (column_name);

-- * Real Example:
CREATE INDEX AGE_INDEX ON STUDENT(AGE);

-- ---

-- ------------------------------------------------------------
-- 9.6 ALTER Commands (Database Level & Table Level)
-- ------------------------------------------------------------

-- * Definition: ALTER is a DDL command that changes the structure of an existing table or database, without deleting and re-creating it.

--   * Using ALTER, you can: add, change, rename or remove columns, constraints and indexes.

--   * Existing data stays: `ALTER` changes only the structure; data in the other columns is not touched.

-- * Two Main Scopes of ALTER:

--   1. On a Database (ALTER DATABASE / ALTER SCHEMA):

--      * You can use `ALTER DATABASE` (or `ALTER SCHEMA`) to change certain database properties.

--      * Examples: Change the default CHARACTER SET (e.g., `utf8mb4`) or default COLLATION (e.g., `utf8mb4_unicode_ci`).

--   2. On Table Level (ALTER TABLE):

--      * `ALTER TABLE` changes the structure of a table.

--      * If you want modification on table structure, you use `ALTER` to perform tasks such as:

--        * Add column: Insert new columns into an existing table (at the end, `FIRST`, or `AFTER column_name`).

--        * Modify column datatype: Change datatype, size, nullability, or default value.

--        * Rename column: Change column names (`RENAME COLUMN` or `CHANGE`).

--        * Drop a column: Permanently delete a column from the table.

--        * Add a constraint: Add rules like `PRIMARY KEY`, `UNIQUE`, `FOREIGN KEY`, or `CHECK`.

--        * Drop constraint: Remove existing constraints.

--        * Add / modify / drop indexes: Add or remove lookup indexes for faster query performance.

--        * Rename table: Rename an existing table entity (`RENAME TO`).

--        * (i.e., Edit, modify, and change the existing table structure and definition).

-- ------------------------------------------------------------
-- 1. Database-Level Alter Operations
-- ------------------------------------------------------------

-- * Modifying Default Character Set and Collation:
ALTER DATABASE database_name
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

-- * Q. Can we rename a database in MySQL?

--   * Answer: No. MySQL does not support a direct `RENAME DATABASE` statement (to prevent data corruption). To rename a database, you create a new database, dump/move the tables to it, and drop the old database after verification.

-- ---

-- ------------------------------------------------------------
-- 2. Table-Level Alter Operations
-- ------------------------------------------------------------

-- ------------------------------------------------------------
-- A. Add a New Column
-- ------------------------------------------------------------

-- * Syntax:
-- 1. Default (adds column at the end of the table):
ALTER TABLE table_name ADD COLUMN column_name datatype [constraints];

-- 2. Add column as the FIRST column:
ALTER TABLE table_name ADD COLUMN column_name datatype [constraints] FIRST;

-- 3. Add column AFTER a specific column:
ALTER TABLE table_name ADD COLUMN column_name datatype [constraints] AFTER existing_column;

-- * Examples:

--   * Default (Adds column at the end of the table):
ALTER TABLE employees ADD COLUMN address VARCHAR(255);

--   * Add column as the FIRST column:
ALTER TABLE employees ADD COLUMN address VARCHAR(255) FIRST;

--   * Add column AFTER a specific column:
ALTER TABLE employees ADD COLUMN address VARCHAR(255) AFTER name;

-- ------------------------------------------------------------
-- B. Modify an Existing Column (Datatype, Size, Nullability)
-- ------------------------------------------------------------

-- * Syntax:
ALTER TABLE table_name MODIFY COLUMN column_name new_datatype [new_constraints];
--   *(Note: The keyword `COLUMN` is optional in MySQL: `ALTER TABLE table_name MODIFY column_name new_datatype;`)*

-- * Examples:

--   * `MODIFY` is used to change column data type, size, nullability, or default without renaming:
-- Increase size and make NOT NULL:
ALTER TABLE employees MODIFY salary DECIMAL(12, 2) NOT NULL;

-- Change student_phone size from VARCHAR(100) to VARCHAR(20):
ALTER TABLE STUDENT MODIFY STUDENT_PHONE VARCHAR(20);

-- ------------------------------------------------------------
-- C. Change a Column (Rename + Modify Datatype At Once)
-- ------------------------------------------------------------

-- * Syntax:
ALTER TABLE table_name CHANGE COLUMN old_column new_column datatype [constraints];
--   *(Note: The keyword `COLUMN` is optional in MySQL)*

-- * Examples:
-- Rename PHONENO to MOBILE and change datatype to VARCHAR(100):
ALTER TABLE PERSON1 CHANGE PHONENO MOBILE VARCHAR(100);

-- Rename PHONE to STUDENT_PHONE with VARCHAR(200):
ALTER TABLE STUDENT CHANGE PHONE STUDENT_PHONE VARCHAR(200);

-- Rename MOBILE to STUDENT_MOBILE with VARCHAR(50):
ALTER TABLE STUDENT CHANGE MOBILE STUDENT_MOBILE VARCHAR(50);

-- ------------------------------------------------------------
-- D. Rename ONLY a Column (MySQL 8.0+)
-- ------------------------------------------------------------

-- * Syntax:
ALTER TABLE table_name RENAME COLUMN old_column_name TO new_column_name;

-- * Example:
ALTER TABLE employees RENAME COLUMN salary TO monthly_salary;

-- ------------------------------------------------------------
-- E. Drop a Column
-- ------------------------------------------------------------

-- * Syntax:
ALTER TABLE table_name DROP COLUMN column_name;

-- * Examples (Permanently removes column and its data):
ALTER TABLE employees DROP COLUMN phone;

ALTER TABLE STUDENT DROP COLUMN STUDENT_PHONE;

-- ------------------------------------------------------------
-- F. Rename a Table
-- ------------------------------------------------------------

-- * Syntax:
-- Method 1 (Using ALTER TABLE):
ALTER TABLE table_name RENAME TO new_table_name;

-- Method 2 (Using RENAME TABLE statement):
RENAME TABLE old_table_name TO new_table_name;

-- * Examples:
-- Method 1 Examples:
ALTER TABLE employees RENAME TO staff;
ALTER TABLE STUDENT RENAME STUDENT_INFO;

-- Method 2 Examples:
RENAME TABLE employee TO staff;
RENAME TABLE STUDENT_INFO TO STUD;

-- ------------------------------------------------------------
-- G. Set or Drop Default Values
-- ------------------------------------------------------------

-- * Syntax:
-- Set Default Value:
ALTER TABLE table_name ALTER COLUMN column_name SET DEFAULT default_value;

-- Drop Default Value:
ALTER TABLE table_name ALTER COLUMN column_name DROP DEFAULT;
--   *(Note: The keyword `COLUMN` is optional in MySQL)*

-- * Examples:
-- Set Default Value:
ALTER TABLE employees ALTER salary SET DEFAULT 5000;

-- Drop Default Value:
ALTER TABLE employees ALTER salary DROP DEFAULT;

-- ------------------------------------------------------------
-- H. Change AUTO_INCREMENT Starting Value
-- ------------------------------------------------------------

-- * Syntax:
ALTER TABLE table_name AUTO_INCREMENT = starting_number;

-- * Example:
ALTER TABLE employees AUTO_INCREMENT = 1000;

-- ---

-- ------------------------------------------------------------
-- 9.7 Constraints Management via ALTER (Add & Drop Rules)
-- ------------------------------------------------------------

-- Constraints enforce data integrity and business rules on table columns. Using `ALTER TABLE`, you can add or remove these constraints on existing tables without rebuilding them.

-- ------------------------------------------------------------
-- Quick Reference Matrix:
-- ------------------------------------------------------------

-- (Constraint → How to ADD | How to DROP)
--
-- * PRIMARY KEY
--     - How to ADD  : ALTER TABLE employees ADD PRIMARY KEY (id);
--     - How to DROP : ALTER TABLE employees DROP PRIMARY KEY;
--
-- * UNIQUE
--     - How to ADD  : ALTER TABLE employees ADD CONSTRAINT unique_email UNIQUE (email);
--     - How to DROP : ALTER TABLE employees DROP INDEX unique_email;
--
-- * FOREIGN KEY
--     - How to ADD  : ALTER TABLE orders ADD CONSTRAINT fk_cust FOREIGN KEY (customer_id) REFERENCES customers(id);
--     - How to DROP : ALTER TABLE orders DROP FOREIGN KEY fk_cust;
--
-- * CHECK
--     - How to ADD  : ALTER TABLE employees ADD CONSTRAINT chk_age CHECK (age >= 18);
--     - How to DROP : ALTER TABLE employees DROP CHECK chk_age;
--
-- * NOT NULL
--     - How to ADD  : ALTER TABLE STUDENT MODIFY EDUCATION VARCHAR(255) NOT NULL;
--     - How to DROP : ALTER TABLE STUDENT MODIFY EDUCATION VARCHAR(255) NULL;
--
-- * DEFAULT
--     - How to ADD  : ALTER TABLE employees ALTER salary SET DEFAULT 5000;
--     - How to DROP : ALTER TABLE employees ALTER salary DROP DEFAULT;
--

-- ---

-- ------------------------------------------------------------
-- Detailed Breakdown & Examples for Each Constraint:
-- ------------------------------------------------------------

-- ------------------------------------------------------------
-- 1. PRIMARY KEY Constraint
-- ------------------------------------------------------------

-- * What it does: Uniquely identifies each record in a table. It cannot contain `NULL` values, and each table can have only one primary key.

-- * Syntax:
-- To ADD a Primary Key:
ALTER TABLE table_name ADD PRIMARY KEY (column_name);

-- With explicit constraint name:
ALTER TABLE table_name ADD CONSTRAINT constraint_name PRIMARY KEY (column_name);

-- To DROP a Primary Key:
ALTER TABLE table_name DROP PRIMARY KEY;

-- * Step-by-Step Example:
-- Add PRIMARY KEY to 'id' column:
ALTER TABLE employees ADD PRIMARY KEY (id);

-- Drop PRIMARY KEY from employees table:
ALTER TABLE employees DROP PRIMARY KEY;

-- ------------------------------------------------------------
-- 2. UNIQUE Constraint
-- ------------------------------------------------------------

-- * What it does: Ensures that all values in a column are distinct (different). Unlike Primary Key, it allows `NULL` values.

-- * Important Note: In MySQL, adding a `UNIQUE` constraint creates an internal unique index. Therefore, to drop it, you use `DROP INDEX`.

-- * Syntax:
-- To ADD a Unique constraint:
ALTER TABLE table_name ADD CONSTRAINT constraint_name UNIQUE (column_name);

-- To DROP a Unique constraint (drops the underlying index):
ALTER TABLE table_name DROP INDEX constraint_name;

-- * Step-by-Step Example:
-- Add UNIQUE constraint on email:
ALTER TABLE employees ADD CONSTRAINT unique_email UNIQUE (email);

-- Drop UNIQUE constraint using its index name:
ALTER TABLE employees DROP INDEX unique_email;

-- Another Example (Dropping unique mobile number index):
ALTER TABLE PERSONINFORMATION DROP INDEX MOBILENO;

-- ------------------------------------------------------------
-- 3. FOREIGN KEY Constraint
-- ------------------------------------------------------------

-- * What it does: Enforces referential integrity between two tables by ensuring that values in a child table correspond to valid primary key values in the parent table.

-- * Syntax:
-- To ADD a Foreign Key:
ALTER TABLE child_table
ADD CONSTRAINT fk_name
FOREIGN KEY (child_column) REFERENCES parent_table (parent_primary_key);

-- To DROP a Foreign Key:
ALTER TABLE child_table DROP FOREIGN KEY fk_name;

-- * Step-by-Step Example:
-- Add FOREIGN KEY linking orders.customer_id to customers.id:
ALTER TABLE orders
ADD CONSTRAINT fk_cust
FOREIGN KEY (customer_id) REFERENCES customers(id);

-- Drop FOREIGN KEY constraint:
ALTER TABLE orders DROP FOREIGN KEY fk_cust;

-- ------------------------------------------------------------
-- 4. CHECK Constraint
-- ------------------------------------------------------------

-- * What it does: Enforces a condition that all values inserted or updated in a column must satisfy (e.g., minimum age, positive salary).

-- * Syntax:
-- To ADD a Check constraint:
ALTER TABLE table_name ADD CONSTRAINT chk_name CHECK (condition);

-- To DROP a Check constraint:
ALTER TABLE table_name DROP CHECK chk_name;

-- * Step-by-Step Example:
-- Add CHECK constraint ensuring employee age is 18 or older:
ALTER TABLE employees ADD CONSTRAINT chk_age CHECK (age >= 18);

-- Add CHECK constraint ensuring salary is greater than 0:
ALTER TABLE employees ADD CONSTRAINT chk_salary CHECK (salary > 0);

-- Drop CHECK constraint:
ALTER TABLE employees DROP CHECK chk_age;

-- ------------------------------------------------------------
-- 5. NOT NULL Constraint
-- ------------------------------------------------------------

-- * What it does: Ensures that a column never accepts empty or missing (`NULL`) values.

-- * Syntax:
-- To ADD NOT NULL (make column mandatory):
ALTER TABLE table_name MODIFY column_name datatype NOT NULL;

-- To DROP NOT NULL (allow NULL values):
ALTER TABLE table_name MODIFY column_name datatype NULL;

-- * Step-by-Step Example:
-- Make EDUCATION column mandatory:
ALTER TABLE STUDENT MODIFY EDUCATION VARCHAR(255) NOT NULL;

-- Allow NULL values in EDUCATION column:
ALTER TABLE STUDENT MODIFY EDUCATION VARCHAR(255) NULL;

-- ------------------------------------------------------------
-- 6. DEFAULT Constraint
-- ------------------------------------------------------------

-- * What it does: Automatically assigns a preset value when no value is provided for the column during an `INSERT`.

-- * Syntax:
-- To SET / ADD a Default value:
ALTER TABLE table_name ALTER COLUMN column_name SET DEFAULT default_value;

-- To DROP a Default value:
ALTER TABLE table_name ALTER COLUMN column_name DROP DEFAULT;
--   *(Note: The keyword `COLUMN` is optional in MySQL)*

-- * Step-by-Step Example:
-- Set default salary of 5000:
ALTER TABLE employees ALTER salary SET DEFAULT 5000;

-- Set default status to 'Active':
ALTER TABLE employees ALTER status SET DEFAULT 'Active';

-- Drop the default salary value:
ALTER TABLE employees ALTER salary DROP DEFAULT;

-- ---

-- ------------------------------------------------------------
-- 9.8 Quick Revision Cheat Sheet: ALTER Operations
-- ------------------------------------------------------------

-- (Keyword → What it Does)
--
-- * ADD
--     - What it Does : Adds column, constraint, or index
--
-- * DROP
--     - What it Does : Drops column, constraint, index, or primary key
--
-- * MODIFY
--     - What it Does : Changes column definition (datatype, null, default) without renaming
--
-- * CHANGE
--     - What it Does : Renames + modifies column definition in one step
--
-- * RENAME
--     - What it Does : Renames table or index (or column in MySQL 8.0+)
--
-- * ALTER
--     - What it Does : Sets/drops default values, character sets, or AUTO_INCREMENT
--

-- ---

-- ------------------------------------------------------------
-- 9.9 DROP Commands (Permanent Object Deletion)
-- ------------------------------------------------------------

-- * What it does: Completely and permanently removes a database object and all its stored data.

-- * Automatic Commit: In MySQL, `DROP` cannot be rolled back with `ROLLBACK`.

-- * **Difference from `DELETE`:** `DELETE` only removes row records; `DROP` destroys the entire table structure, indexes, and constraints.

-- ------------------------------------------------------------
-- 1. Drop Database
-- ------------------------------------------------------------

-- * Syntax:
DROP DATABASE [IF EXISTS] database_name;

-- * Example:
DROP DATABASE company_db;

-- ------------------------------------------------------------
-- 2. Drop Table
-- ------------------------------------------------------------

-- * Syntax:
DROP TABLE [IF EXISTS] table_name;

-- * Examples:
DROP TABLE employees;
DROP TABLE person;

-- ---

-- ------------------------------------------------------------
-- 9.10 TRUNCATE Commands (Wipe Data, Keep Structure)
-- ------------------------------------------------------------

-- * Definition: TRUNCATE deletes all rows from a table in one go and frees the space, but keeps the table structure.

-- * Syntax:
TRUNCATE TABLE table_name;

-- * Example:
TRUNCATE TABLE Students;

-- * Key Characteristics of TRUNCATE:

--   1. Keeps the Structure: Table name, column names, data types, primary key, unique constraints, and foreign key definitions remain 100% intact.

--   2. Resets AUTO_INCREMENT: Resets auto-increment counters back to 1.

--   3. DDL Operation: Much faster than `DELETE`, because it doesn't delete rows one by one — MySQL simply empties the table (internally it drops and re-creates it).

--   4. Cannot be Rolled Back: Cannot undo with `ROLLBACK` in MySQL.

--   5. Foreign Key Rule: You cannot truncate a table that is actively referenced by an existing foreign key constraint.

-- ---

-- ------------------------------------------------------------
-- 9.11 RENAME Commands (Objects & Tables)
-- ------------------------------------------------------------

-- * Definition: RENAME is a DDL command that changes the name of a table (or a column, index or view) without touching the data.

-- * Core Characteristics & Architectural Rules:

--   * Only the name changes: MySQL just updates the name in its internal list (data dictionary); no data is copied.

--   * Zero Data Loss: All column definitions, constraints (Primary Key, Foreign Key, Unique), indexes, and existing rows remain 100% intact.

--   * Implicit Commit: In MySQL, executing `RENAME` immediately causes an implicit transaction commit. It cannot be rolled back with ROLLBACK.

--   * Application & View Impact: Any application queries, views, or stored procedures that hardcode the old object name must be updated to reference the new name.

-- ---

-- ------------------------------------------------------------
-- 1. Renaming Tables (Two Distinct Methods)
-- ------------------------------------------------------------

-- ------------------------------------------------------------
-- Method A: The Standalone `RENAME TABLE` Statement (Recommended)
-- ------------------------------------------------------------

-- * Description: MySQL provides a dedicated `RENAME TABLE` statement. Its unique superpower is that it can rename multiple tables atomically in a single statement.

-- * Syntax:
-- Single table:
RENAME TABLE old_table_name TO new_table_name;

-- Multiple tables atomically (Zero-Downtime Swapping):
RENAME TABLE old_tbl1 TO new_tbl1,
             old_tbl2 TO new_tbl2;

-- * Examples:
-- 1. Standard single table rename:
RENAME TABLE STUDENT_INFO TO STUD;

-- 2. Renaming employee table to staff:
RENAME TABLE employees TO staff_members;

-- 3. Production Zero-Downtime Atomic Swap (Swapping staging table to live table):
RENAME TABLE live_products TO backup_products,
             staging_products TO live_products;

-- ------------------------------------------------------------
-- Method B: Using `ALTER TABLE ... RENAME TO`
-- ------------------------------------------------------------

-- * Description: Part of the standard `ALTER TABLE` suite. Best used when you are already performing table-level modifications.

-- * Syntax:
ALTER TABLE table_name RENAME TO new_table_name;
-- or shorthand:
ALTER TABLE table_name RENAME new_table_name;

-- * Examples:
ALTER TABLE STUDENT RENAME TO STUDENT_INFO;
ALTER TABLE employees RENAME TO staff;

-- ---

-- ------------------------------------------------------------
-- 2. Moving Tables Across Databases (Cross-Database Move)
-- ------------------------------------------------------------

-- * Description: Because MySQL intentionally does not support a `RENAME DATABASE` command, the `RENAME TABLE` statement is the official, instant way to move a table from one database schema to another without copying data.

-- * Syntax:
RENAME TABLE source_db.table_name TO target_db.table_name;

-- * Example:
-- Instantly moves the 'orders' table from 'staging_db' to 'production_db':
RENAME TABLE staging_db.orders TO production_db.orders;

-- ---

-- ------------------------------------------------------------
-- 3. Renaming Other Database Objects
-- ------------------------------------------------------------

-- ------------------------------------------------------------
-- A. Renaming a Column Inside a Table
-- ------------------------------------------------------------

-- * Modern Syntax (MySQL 8.0+):
ALTER TABLE table_name RENAME COLUMN old_col_name TO new_col_name;

--   * Example:
ALTER TABLE employees RENAME COLUMN phone TO mobile_number;

-- * **Legacy Syntax (MySQL 5.7 and earlier using `CHANGE`):**
ALTER TABLE table_name CHANGE old_col_name new_col_name datatype [constraints];

--   * Example:
ALTER TABLE employees CHANGE phone mobile_number VARCHAR(20);

-- ------------------------------------------------------------
-- B. Renaming an Index
-- ------------------------------------------------------------

-- * Description: Changes the name of an existing performance index without rebuilding the B-Tree index structure.

-- * Syntax:
ALTER TABLE table_name RENAME INDEX old_index_name TO new_index_name;

-- * Example:
ALTER TABLE employees RENAME INDEX idx_emp_email TO idx_staff_email;

-- ------------------------------------------------------------
-- C. Renaming a View
-- ------------------------------------------------------------

-- * Description: A database view can be renamed exactly like a table using the `RENAME TABLE` command.

-- * Syntax:
RENAME TABLE old_view_name TO new_view_name;

-- * Example:
RENAME TABLE active_users_view TO current_users_view;

-- ---

-- ------------------------------------------------------------
-- 4. Q. Can We Directly Rename a Database in MySQL?
-- ------------------------------------------------------------

-- * Direct Answer: NO. MySQL had an experimental `RENAME DATABASE` in MySQL 5.1.7, but it was quickly removed in 5.1.23 because it carried extreme risks of file-system data corruption.

-- * Recommended Production Method to "Rename" a Database:

--   1. Create the new target database:
CREATE DATABASE new_database_name;

--   2. Move all tables from old database to new database using `RENAME TABLE`:
RENAME TABLE old_db.table1 TO new_db.table1,
             old_db.table2 TO new_db.table2;

--   3. Verify data and drop the now-empty old database:
DROP DATABASE old_database_name;

-- ---

-- ------------------------------------------------------------
-- 9.12 Differences Between DELETE, TRUNCATE, and DROP
-- ------------------------------------------------------------

-- In SQL, you can remove data with three commands: **`DELETE`**, **`TRUNCATE`**, and **`DROP`**. All three remove data, but they work very differently (speed, rollback, and what happens to the table).

-- ---

-- ------------------------------------------------------------
-- 1. Comprehensive 10-Point Comparison Matrix
-- ------------------------------------------------------------

-- (Feature / Dimension → DELETE | TRUNCATE | DROP)
--
-- * 1. Command Category
--     - DELETE   : DML (Data Manipulation Language)
--     - TRUNCATE : DDL (Data Definition Language)
--     - DROP     : DDL (Data Definition Language)
--
-- * 2. Core Purpose & Action
--     - DELETE   : Deletes specific rows or all rows
--     - TRUNCATE : Wipes all rows in a table simultaneously
--     - DROP     : Completely deletes table, schema & data
--
-- * 3. WHERE Clause Filtering
--     - DELETE   : Supported (WHERE condition)
--     - TRUNCATE : NOT Supported (Cannot filter rows)
--     - DROP     : NOT Supported (Cannot filter rows)
--
-- * 4. Rollback / Transactions
--     - DELETE   : YES (Can be undone with ROLLBACK)
--     - TRUNCATE : NO in MySQL (Implicit Commit)
--     - DROP     : NO in MySQL (Implicit Commit)
--
-- * 5. Execution Speed
--     - DELETE   : Slower (Logs row-by-row deletions)
--     - TRUNCATE : Very Fast (Deallocates entire data pages)
--     - DROP     : Fastest (Removes object from catalog)
--
-- * 6. Space Deallocation
--     - DELETE   : NO (Keeps disk pages allocated to table)
--     - TRUNCATE : YES (Releases data pages back to engine)
--     - DROP     : YES (100% disk and memory space freed)
--
-- * 7. AUTO_INCREMENT Counter
--     - DELETE   : Preserved (Next ID = Max ID + 1)
--     - TRUNCATE : RESET back to 1 (Starts numbering fresh)
--     - DROP     : Deleted (Table no longer exists)
--
-- * 8. Trigger Execution
--     - DELETE   : Fires ON DELETE row triggers
--     - TRUNCATE : Does NOT fire row-level triggers
--     - DROP     : Does NOT fire triggers (Triggers dropped)
--
-- * 9. Foreign Key Rules
--     - DELETE   : Allowed if cascade/child rules permit
--     - TRUNCATE : BLOCKED if referenced by active FK
--     - DROP     : BLOCKED if another table's FK points to it (drop the FK or child table first; in MySQL the CASCADE keyword does nothing here)
--
-- * 10. Table Structure After Query
--     - DELETE   : 100% Intact (Columns, keys preserved)
--     - TRUNCATE : 100% Intact (Columns, keys preserved)
--     - DROP     : DESTROYED (Table completely vanishes)
--

-- ---

-- ------------------------------------------------------------
-- 2. Syntax and Concrete Practical Examples
-- ------------------------------------------------------------

-- ------------------------------------------------------------
-- A. `DELETE` Command
-- ------------------------------------------------------------

-- * Syntax:
DELETE FROM table_name [WHERE condition];

-- * Examples:
-- 1. Conditional deletion (removes single row):
DELETE FROM employees WHERE id = 101;

-- 2. Range deletion:
DELETE FROM employees WHERE age < 18;

-- 3. Delete all rows (row-by-row, rollback possible):
DELETE FROM employees;

-- ------------------------------------------------------------
-- B. `TRUNCATE` Command
-- ------------------------------------------------------------

-- * Syntax:
TRUNCATE TABLE table_name;

-- * Example:
-- Wipes all records, resets AUTO_INCREMENT to 1, table structure stays intact:
TRUNCATE TABLE employees;

-- ------------------------------------------------------------
-- C. `DROP` Command
-- ------------------------------------------------------------

-- * Syntax:
DROP TABLE [IF EXISTS] table_name;

-- * Example:
-- Permanently deletes the table structure and its data from the database:
DROP TABLE employees;

-- ---

-- ------------------------------------------------------------
-- 3. When to Use Which? (Decision Guide)
-- ------------------------------------------------------------

-- 1. **Use `DELETE` when:**

--    - You need to delete only specific rows based on a criteria (`WHERE condition`).

--    - You need the safety of **`ROLLBACK`** in case of errors.

--    - You have auditing triggers that must execute on every deleted row.

-- 2. **Use `TRUNCATE` when:**

--    - You want to wipe out all records from a table quickly (e.g., staging tables, logs, testing caches).

--    - You want the primary key **`AUTO_INCREMENT` counter to reset back to 1**.

--    - You want to release allocated disk pages back to the database system.

-- 3. **Use `DROP` when:**

--    - You want to completely decommission and delete an entire table that is no longer needed.

--    - You are rebuilding a table from scratch by dropping and recreating it.

-- ---

-- ------------------------------------------------------------
-- 4. Focused Deep-Dive: DROP vs. TRUNCATE (Direct 6-Point Comparison)
-- ------------------------------------------------------------

-- * **`DROP TABLE` (Total Structural Elimination):**

--   * Core Action: Removes the entire table structure (schema + data). After drop, the table no longer exists.
DROP TABLE table_name;  -- Drop table completely

--   * Storage: Frees up the storage completely from disk.

--   * Rollback: Permanent and irreversible in MySQL (`DDL = Implicit Commit`). (Note: In PostgreSQL, DDL can rollback inside transactions).

--   * Speed: Extremely fast (removes metadata entry from system catalog in one step).

--   * Objects Removed: Removes table definition, constraints, indexes, triggers—everything.

--   * Auto-Increment Counter: Disappears completely because the table entity is destroyed.

-- * **`TRUNCATE TABLE` (Fast Data Wipe, Structure Retained):**

--   * Core Action: Clears the whole table at once without row-by-row logging. Removes all rows, but keeps the table structure intact (table becomes empty and ready for fresh use).
TRUNCATE TABLE table_name;  -- Truncate table (delete all rows)

--   * Storage: Empties the table data, but structure and table allocations stay.

--   * Rollback: Not rollback-able in MySQL (`DDL = Implicit Commit`).

--   * Speed: Faster than `DELETE` (deallocates pages rather than writing undo logs), but slightly slower than `DROP` because table schema must be preserved.

--   * Objects Preserved: Only removes row records; preserves columns, data types, constraints, indexes, and triggers.

--   * Auto-Increment Counter: Resets the `AUTO_INCREMENT` sequence counter back to `1` (fresh start).

-- ---

-- ------------------------------------------------------------
-- 9.13 Visual Diagrams & Architectural Explanations
-- ------------------------------------------------------------

-- ------------------------------------------------------------
-- Diagram 1: SQL Commands Overview (DDL, DML, DQL)
-- ------------------------------------------------------------

-- * Explanation:

--   * DDL (Left): Used by developers to define the blueprint (`CREATE`, `ALTER`, `DROP`, `TRUNCATE`, `RENAME`). Operates with implicit commits.

--   * DML (Bottom-Right): Used to write and modify actual rows (`INSERT`, `UPDATE`, `DELETE`).

--   * DQL (Top-Right): Used to search and retrieve data reports (`SELECT`).

-- ---

-- ------------------------------------------------------------
-- Diagram 2: DDL Structure & Scope of ALTER
-- ------------------------------------------------------------

-- * Explanation:

--   * Left Panel: Illustrates `CREATE`, `ALTER`, and `DROP` acting upon the database container and its tables.

--   * Right Panel: Visualizes the scope tree showing changes at the Database Level (Character Set, Collation) vs. Table Level (Columns, Datatypes, Constraints, and Indexes).

-- ---

-- ------------------------------------------------------------
-- Diagram 3: Descriptive Summary (Database Level vs Table Level ALTER Operations)
-- ------------------------------------------------------------

-- * Explanation:

--   * Database Level (Left Panel): Focuses on schema-wide properties—modifying default `CHARACTER SET` (e.g., `utf8mb4` for complete multilingual & emoji storage) and default `COLLATION` (e.g., `utf8mb4_unicode_ci` for case-insensitive accurate comparisons), along with the safeguard that direct `RENAME DATABASE` is disallowed in MySQL.

--   * Table Level (Right Panel): Categorizes all table structural modifications (`ADD`, `MODIFY`, `CHANGE`, `RENAME COLUMN`, `DROP COLUMN`, `RENAME TABLE`, `CONSTRAINTS`, `DEFAULT`, and `AUTO_INCREMENT`).

-- ---

-- ------------------------------------------------------------
-- Diagram 4: Detailed Comparison (DELETE vs TRUNCATE vs DROP)
-- ------------------------------------------------------------

-- * Explanation:

--   * DELETE (Blue): Shows DML row-by-row filtering via `WHERE`, with rollback capability and preserved table structure and auto-increment counter.

--   * TRUNCATE (Amber): Shows DDL page-level instant wipe, leaving empty table structure with counter reset to 1.

--   * DROP (Red): Shows total structural obliteration where the table definition and all data are permanently removed.

-- ---

-- ------------------------------------------------------------
-- 9.14 Generated (Computed) Columns
-- ------------------------------------------------------------

-- * A generated column gets its value automatically from an expression on other columns of the same row. You never insert it yourself (MySQL 5.7+).
CREATE TABLE order_items (
    item_id    INT PRIMARY KEY AUTO_INCREMENT,
    price      DECIMAL(10,2) NOT NULL,
    qty        INT NOT NULL,
    total      DECIMAL(12,2) AS (price * qty) STORED,          -- saved on disk
    first_name VARCHAR(50),
    last_name  VARCHAR(50),
    full_name  VARCHAR(101) AS (CONCAT(first_name, ' ', last_name)) VIRTUAL  -- calculated when read
);

INSERT INTO order_items (price, qty, first_name, last_name) VALUES (250.00, 4, 'Asha', 'Patil');
SELECT price, qty, total, full_name FROM order_items;

-- * Output:

-- (price → qty | total | full_name)
--
-- * 250.00
--     - qty       : 4
--     - total     : 1000.00
--     - full_name : Asha Patil
--

-- * VIRTUAL vs STORED:

-- (Point → VIRTUAL (default) | STORED)
--
-- * Disk space
--     - VIRTUAL (default) : None — computed on every read
--     - STORED            : Uses space — computed on INSERT/UPDATE
--
-- * Read speed
--     - VIRTUAL (default) : Slightly slower
--     - STORED            : Faster
--
-- * Index
--     - VIRTUAL (default) : Allowed (InnoDB secondary index)
--     - STORED            : Allowed (also PRIMARY KEY)
--

-- * Big use case — index an expression or a JSON field:
ALTER TABLE customers
    ADD COLUMN email_domain VARCHAR(100) AS (SUBSTRING_INDEX(email, '@', -1)) VIRTUAL,
    ADD INDEX idx_email_domain (email_domain);

SELECT * FROM customers WHERE email_domain = 'gmail.com';   -- uses the index

--   * MySQL 8.0.13+ also has functional indexes: `CREATE INDEX idx_year ON orders ((YEAR(order_date)));` — internally this is a hidden virtual generated column.

-- * Rules: the expression must be deterministic (no `NOW()`, `RAND()`, subqueries or user variables), and you cannot write a value into it (`INSERT` / `UPDATE` of that column gives an error unless you use `DEFAULT`).

-- ---

-- ======================================================================
-- 🎯 Practice Questions (salesdb sample data) — try first, then look at the answer
-- ======================================================================
-- Run 00-Setup-Sample-Data.sql once before this section.

USE salesdb;

-- Q1. CREATE: make a table for product reviews linked to products.
CREATE TABLE reviews (
  reviewid  INT PRIMARY KEY,
  productid INT,
  rating    INT,
  FOREIGN KEY (productid) REFERENCES products (productid)
);

-- Q2. ALTER: add a comment column and rename rating to stars.
ALTER TABLE reviews ADD COLUMN comment_text VARCHAR(200);
ALTER TABLE reviews RENAME COLUMN rating TO stars;
DESCRIBE reviews;

-- Q3. TRUNCATE and DROP: empty the table, then remove it.
INSERT INTO reviews (reviewid, productid, stars) VALUES (1, 101, 5);
TRUNCATE TABLE reviews;
DROP TABLE reviews;
