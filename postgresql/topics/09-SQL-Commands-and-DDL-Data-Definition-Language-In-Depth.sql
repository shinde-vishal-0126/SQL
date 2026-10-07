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
--     ALTER TABLE table_name ALTER COLUMN col TYPE new_type;
--     ALTER TABLE table_name RENAME COLUMN old TO new;
--     ALTER TABLE table_name DROP COLUMN col;
--     ALTER TABLE old_name RENAME TO new_name;
--     TRUNCATE TABLE table_name;
--     DROP TABLE [IF EXISTS] table_name [CASCADE];

-- * Syntax explained (each part):
--   - CREATE → build a new object
--   - ALTER → change an existing object (add / change / rename / drop a column)
--   - TRUNCATE → remove all rows quickly, keep the structure
--   - DROP → remove the object completely
--   - [IF EXISTS] → optional: no error if the object is missing

-- * Example on salesdb (run 00-Setup-Sample-Data.sql first):
SET search_path TO sales;
CREATE TABLE suppliers (supplierid INT PRIMARY KEY, name VARCHAR(50));
ALTER TABLE suppliers ADD COLUMN city VARCHAR(50);
DROP TABLE suppliers;

-- * Example explained (step by step):
--   1. CREATE TABLE makes a new empty table with two columns.
--   2. ALTER TABLE adds a third column (city) to the existing table.
--   3. DROP TABLE removes the table completely — structure and data.

-- ------------------------------------------------------------
-- 9.1 Check Current PostgreSQL Version
-- ------------------------------------------------------------

-- To verify the current installed version of your database engine:

SELECT version();
--                                    version
-- -----------------------------------------------------------------------------
--  PostgreSQL 17.2 on x86_64-pc-linux-gnu, compiled by gcc ... 64-bit
-- (1 row)
-- 
SHOW server_version;
--  server_version
-- ----------------
--  17.2
-- (1 row)

-- * `postgres=#` is the psql prompt (`#` means you are a superuser; a normal user sees `=>`).

-- ---

-- ------------------------------------------------------------
-- 9.2 Broad Classification of SQL Commands
-- ------------------------------------------------------------
-- SQL commands are used to communicate with the database, manage structures, and manipulate data. They are classified into:

-- 1. DDL (Data Definition Language): Defines and modifies the structure/blueprint of database objects (`CREATE`, `ALTER`, `DROP`, `TRUNCATE`, and renaming with `ALTER ... RENAME`).

-- 2. DML (Data Manipulation Language): Manipulates actual row data (`INSERT`, `UPDATE`, `DELETE`, `MERGE`).

-- 3. DQL (Data Query Language): Searches, filters, and retrieves data (`SELECT`).

-- ---

-- ------------------------------------------------------------
-- 9.3 What is DDL (Data Definition Language)?
-- ------------------------------------------------------------

-- * Definition: DDL (Data Definition Language) commands create, change and delete the structure of the database — databases, schemas, tables, indexes, views, etc.

--   * Defines the structure of the database object: It is how you create, modify, or delete the blueprint of your database.

--   * Works on structure, not on individual rows: DDL changes tables and other objects. (`DROP` and `TRUNCATE` also remove the data, because they remove/empty the whole table.)

-- * Objects It Works On: Databases, Schemas, Tables, Views, Indexes, Sequences, Types (ENUM), Stored Procedures, Functions, and Triggers.

-- * Core Functions:

--   * `CREATE`: Creates a database or database objects inside the DB (Database, Schema, Table, Index, View, Sequence, Type, Procedure, Function, Trigger).

--   * `ALTER`: Modifies the structure of existing objects without deleting them.

--   * `DROP`: Permanently deletes database objects and all their data.

--   * `TRUNCATE`: Removes all records from a table while preserving the table structure.

--   * Rename: In PostgreSQL renaming is done with `ALTER ... RENAME TO ...` (there is no separate `RENAME TABLE` statement).

-- ---

-- ------------------------------------------------------------
-- 9.4 Transactional DDL in PostgreSQL (Big Difference from MySQL)
-- ------------------------------------------------------------

-- > ⚠️ Critical Architectural Note:
-- > In MySQL, DDL statements perform an implicit commit, so you cannot roll them back.
-- > In PostgreSQL, almost all DDL is transactional. Inside `BEGIN ... COMMIT`, a `CREATE`, `ALTER`, `DROP` or `TRUNCATE` can be undone with `ROLLBACK`.

BEGIN;
DROP TABLE employees;          -- table is gone (only inside this transaction)
ALTER TABLE orders ADD COLUMN note TEXT;
ROLLBACK;                       -- employees is back, note column never existed

-- * Exceptions (cannot run inside a transaction block): `CREATE DATABASE`, `DROP DATABASE`, `CREATE INDEX CONCURRENTLY`, `VACUUM`, `ALTER SYSTEM`.

-- * Why it matters: You can run a whole migration (many DDL + DML statements) in one transaction. If one step fails, everything is rolled back and the schema is never left half-changed.

-- ---

-- ------------------------------------------------------------
-- 9.5 CREATE Commands (Database, Tables, Indexes & Info)
-- ------------------------------------------------------------
-- The `CREATE` command is used to create a database or database objects inside the DB (such as Schemas, Tables, Indexes, Views, Procedures, Functions and Triggers).

-- ------------------------------------------------------------
-- 1. How to Create a Database
-- ------------------------------------------------------------

-- * Syntax:
CREATE DATABASE db_name;

-- * Examples:
-- Basic creation:
CREATE DATABASE company_db;

-- With owner and encoding:
CREATE DATABASE school_db OWNER postgres ENCODING 'UTF8';

-- * ⚠️ PostgreSQL has no `CREATE DATABASE IF NOT EXISTS`. (It works for tables, schemas and indexes, but not databases.) In psql you can check first:
SELECT 1 FROM pg_database WHERE datname = 'school_db';

-- * Shell command alternative: `createdb school_db`

-- ------------------------------------------------------------
-- 2. How to Show All Databases in the RDBMS
-- ------------------------------------------------------------

-- * Command / Syntax:
-- psql meta-command (MySQL: SHOW DATABASES;)
-- (psql/client command — run it in psql, not in a GUI query tool):
-- \l

-- Plain SQL (works in any tool, e.g. pgAdmin, DBeaver):
SELECT datname FROM pg_database WHERE datistemplate = false;

-- ------------------------------------------------------------
-- 3. How to Select or Use a Particular Database
-- ------------------------------------------------------------

-- * PostgreSQL has no `USE db_name;`. One connection always belongs to one database.

-- * In psql, reconnect to another database with `\c`:
-- (psql/client command — run it in psql, not in a GUI query tool):
-- \c db_name

-- * Example:
-- (psql/client command — run it in psql, not in a GUI query tool):
-- \c company_db
-- You are now connected to database "company_db" as user "postgres".

-- * In pgAdmin / DBeaver / an app, you choose the database in the connection settings (e.g. `postgresql://user:pass@localhost:5432/company_db`).

-- * Inside one database, you switch between schemas with `SET search_path TO schema_name;`.

-- ------------------------------------------------------------
-- 4. How to Show All Tables in the Current Database
-- ------------------------------------------------------------

-- * Command / Syntax:
-- psql meta-command (MySQL: SHOW TABLES;)
-- (psql/client command — run it in psql, not in a GUI query tool):
-- \dt

-- Tables of all schemas:
-- (psql/client command — run it in psql, not in a GUI query tool):
-- \dt *.*

-- Plain SQL:
SELECT table_schema, table_name
FROM information_schema.tables
WHERE table_schema NOT IN ('pg_catalog', 'information_schema');

-- ------------------------------------------------------------
-- 5. How to Create a Table
-- ------------------------------------------------------------

-- * General Syntax:
CREATE TABLE [IF NOT EXISTS] table_name (
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
    salary NUMERIC(10, 2)
);

-- * Production Example (With Constraints: Primary Key, Not Null, Unique, Default):
CREATE TABLE employees (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    age INT,
    email VARCHAR(150) UNIQUE,
    salary NUMERIC(10, 2) DEFAULT 0
);

-- ------------------------------------------------------------
-- 6. How to Show Detailed Information / Schema of a Table
-- ------------------------------------------------------------

-- * Syntax:
-- psql meta-command (MySQL: DESCRIBE table_name; / DESC table_name;)
-- (psql/client command — run it in psql, not in a GUI query tool):
-- \d table_name

-- More details (storage, description):
-- (psql/client command — run it in psql, not in a GUI query tool):
-- \d+ table_name

-- * Example:
-- (psql/client command — run it in psql, not in a GUI query tool):
-- \d employees

-- * Plain SQL alternative:
SELECT column_name, data_type, is_nullable, column_default
FROM information_schema.columns
WHERE table_name = 'employees'
ORDER BY ordinal_position;

-- ------------------------------------------------------------
-- 7. How to Create an Index on a Table
-- ------------------------------------------------------------
-- An index makes searching on a column much faster (like the index at the back of a book):

-- * Syntax:
CREATE INDEX [IF NOT EXISTS] index_name
ON table_name (column_name);

-- * Real Example:
CREATE INDEX age_index ON student (age);

-- * 🐘 PostgreSQL extra: `CREATE INDEX CONCURRENTLY age_index ON student (age);` builds the index without blocking inserts/updates on a live table.

-- ------------------------------------------------------------
-- 8. Handy psql Meta-Commands (PostgreSQL extra)
-- ------------------------------------------------------------

-- (psql command → What it shows | MySQL equivalent)
--
-- * \l
--     - What it shows    : All databases
--     - MySQL equivalent : SHOW DATABASES;
--
-- * \c db
--     - What it shows    : Connect to a database
--     - MySQL equivalent : USE db;
--
-- * \dn
--     - What it shows    : All schemas
--     - MySQL equivalent : —
--
-- * \dt
--     - What it shows    : Tables
--     - MySQL equivalent : SHOW TABLES;
--
-- * \d table
--     - What it shows    : Table structure
--     - MySQL equivalent : DESCRIBE table;
--
-- * \di
--     - What it shows    : Indexes
--     - MySQL equivalent : SHOW INDEX FROM table;
--
-- * \dv
--     - What it shows    : Views
--     - MySQL equivalent : SHOW FULL TABLES WHERE Table_type = 'VIEW';
--
-- * \df
--     - What it shows    : Functions / procedures
--     - MySQL equivalent : SHOW FUNCTION STATUS;
--
-- * \du
--     - What it shows    : Users / roles
--     - MySQL equivalent : SELECT user FROM mysql.user;
--
-- * \x
--     - What it shows    : Expanded (vertical) output
--     - MySQL equivalent : \G at end of query
--
-- * \timing
--     - What it shows    : Show query time
--     - MySQL equivalent : (shown by default)
--
-- * \q
--     - What it shows    : Quit
--     - MySQL equivalent : exit
--

-- ---

-- ------------------------------------------------------------
-- 9.6 ALTER Commands (Database Level & Table Level)
-- ------------------------------------------------------------

-- * Definition: ALTER is a DDL command that changes the structure of an existing table or database, without deleting and re-creating it.

--   * Using ALTER, you can: add, change, rename or remove columns, constraints and indexes.

--   * Existing data stays: `ALTER` changes only the structure; data in the other columns is not touched.

-- * Two Main Scopes of ALTER:

--   1. On a Database (ALTER DATABASE):

--      * You can use `ALTER DATABASE` to rename the database, change its owner, connection limit or default settings.

--      * ⚠️ The encoding / collation of an existing database cannot be changed in PostgreSQL. They are chosen at `CREATE DATABASE` time.

--   2. On Table Level (ALTER TABLE):

--      * `ALTER TABLE` changes the structure of a table.

--      * If you want modification on table structure, you use `ALTER` to perform tasks such as:

--        * Add column: Insert new columns into an existing table (always at the end — PostgreSQL has no `FIRST` / `AFTER`).

--        * Change column datatype: `ALTER COLUMN ... TYPE ...`.

--        * Change nullability or default: `ALTER COLUMN ... SET/DROP NOT NULL`, `SET/DROP DEFAULT`.

--        * Rename column: `RENAME COLUMN old TO new`.

--        * Drop a column: Permanently delete a column from the table.

--        * Add a constraint: Add rules like `PRIMARY KEY`, `UNIQUE`, `FOREIGN KEY`, or `CHECK`.

--        * Drop constraint: Remove existing constraints by name (`DROP CONSTRAINT`).

--        * Rename table: `RENAME TO new_name`.

--        * Move to another schema: `SET SCHEMA new_schema`.

-- ------------------------------------------------------------
-- 1. Database-Level Alter Operations
-- ------------------------------------------------------------

-- * Common database changes:
ALTER DATABASE company_db RENAME TO company_main;         -- rename (no one must be connected to it)
ALTER DATABASE company_main OWNER TO app_admin;          -- change owner
ALTER DATABASE company_main SET timezone TO 'Asia/Kolkata'; -- default setting for new sessions
ALTER DATABASE company_main CONNECTION LIMIT 50;

-- * Q. Can we rename a database in PostgreSQL?

--   * Answer: Yes. `ALTER DATABASE old_name RENAME TO new_name;` works directly (MySQL cannot do this). Rule: no session may be connected to that database, and you cannot rename the database you are connected to.

-- * Encoding / collation: chosen only at creation:
CREATE DATABASE marathi_db
    ENCODING 'UTF8'
    LC_COLLATE 'en_US.UTF-8'
    LC_CTYPE 'en_US.UTF-8'
    TEMPLATE template0;

-- ---

-- ------------------------------------------------------------
-- 2. Table-Level Alter Operations
-- ------------------------------------------------------------

-- ------------------------------------------------------------
-- A. Add a New Column
-- ------------------------------------------------------------

-- * Syntax:
ALTER TABLE table_name ADD COLUMN [IF NOT EXISTS] column_name datatype [constraints];

-- * Examples:

--   * Default (Adds column at the end of the table):
ALTER TABLE employees ADD COLUMN address VARCHAR(255);

--   * Add several columns at once:
ALTER TABLE employees
    ADD COLUMN city VARCHAR(50),
    ADD COLUMN joined_on DATE DEFAULT CURRENT_DATE;

-- * ⚠️ `FIRST` and `AFTER column` do not exist in PostgreSQL. A new column always goes to the end. If column order matters for display, list the columns in your `SELECT` or create a view.

-- ------------------------------------------------------------
-- B. Modify an Existing Column (Datatype, Size, Nullability)
-- ------------------------------------------------------------

-- * PostgreSQL has no `MODIFY`. Each kind of change has its own `ALTER COLUMN` clause:
ALTER TABLE table_name ALTER COLUMN column_name TYPE new_datatype;        -- change type / size
ALTER TABLE table_name ALTER COLUMN column_name SET NOT NULL;            -- make mandatory
ALTER TABLE table_name ALTER COLUMN column_name DROP NOT NULL;           -- allow NULL
ALTER TABLE table_name ALTER COLUMN column_name SET DEFAULT value;       -- default

-- * Examples:
-- Increase size and make NOT NULL (two clauses in one statement):
ALTER TABLE employees
    ALTER COLUMN salary TYPE NUMERIC(12, 2),
    ALTER COLUMN salary SET NOT NULL;

-- Change student_phone size from VARCHAR(100) to VARCHAR(20):
ALTER TABLE student ALTER COLUMN student_phone TYPE VARCHAR(20);

-- Change a text column to integer (PostgreSQL needs USING to know how to convert):
ALTER TABLE student ALTER COLUMN roll_no TYPE INT USING roll_no::INT;

-- * `USING expression` tells PostgreSQL how to convert old values to the new type. MySQL converts silently; PostgreSQL asks you to be explicit when there is no automatic cast.

-- ------------------------------------------------------------
-- C. Change a Column (Rename + Modify Datatype At Once)
-- ------------------------------------------------------------

-- * PostgreSQL has no `CHANGE`. Do it in one `ALTER TABLE` with two steps, or in two statements:
ALTER TABLE table_name RENAME COLUMN old_column TO new_column;
ALTER TABLE table_name ALTER COLUMN new_column TYPE datatype;

-- * Examples (same as MySQL notes):
-- Rename phoneno to mobile and change datatype to VARCHAR(100):
ALTER TABLE person1 RENAME COLUMN phoneno TO mobile;
ALTER TABLE person1 ALTER COLUMN mobile TYPE VARCHAR(100);

-- Rename phone to student_phone with VARCHAR(200):
ALTER TABLE student RENAME COLUMN phone TO student_phone;
ALTER TABLE student ALTER COLUMN student_phone TYPE VARCHAR(200);

-- Rename mobile to student_mobile with VARCHAR(50):
ALTER TABLE student RENAME COLUMN mobile TO student_mobile;
ALTER TABLE student ALTER COLUMN student_mobile TYPE VARCHAR(50);

-- * Tip: wrap both statements in `BEGIN; ... COMMIT;` so they succeed or fail together.

-- ------------------------------------------------------------
-- D. Rename ONLY a Column
-- ------------------------------------------------------------

-- * Syntax:
ALTER TABLE table_name RENAME COLUMN old_column_name TO new_column_name;

-- * Example:
ALTER TABLE employees RENAME COLUMN salary TO monthly_salary;

-- ------------------------------------------------------------
-- E. Drop a Column
-- ------------------------------------------------------------

-- * Syntax:
ALTER TABLE table_name DROP COLUMN [IF EXISTS] column_name [CASCADE];

-- * Examples (Permanently removes column and its data):
ALTER TABLE employees DROP COLUMN phone;

ALTER TABLE student DROP COLUMN student_phone;

-- CASCADE also drops views/constraints that depend on the column:
ALTER TABLE student DROP COLUMN email CASCADE;

-- ------------------------------------------------------------
-- F. Rename a Table
-- ------------------------------------------------------------

-- * Syntax:
ALTER TABLE [IF EXISTS] table_name RENAME TO new_table_name;

-- * Examples:
ALTER TABLE employees RENAME TO staff;
ALTER TABLE student RENAME TO student_info;

-- * ⚠️ PostgreSQL has no `RENAME TABLE` statement (MySQL-only). Always use `ALTER TABLE ... RENAME TO`.

-- ------------------------------------------------------------
-- G. Set or Drop Default Values
-- ------------------------------------------------------------

-- * Syntax:
-- Set Default Value:
ALTER TABLE table_name ALTER COLUMN column_name SET DEFAULT default_value;

-- Drop Default Value:
ALTER TABLE table_name ALTER COLUMN column_name DROP DEFAULT;
--   (The keyword `COLUMN` is optional in PostgreSQL too.)

-- * Examples:
-- Set Default Value:
ALTER TABLE employees ALTER COLUMN salary SET DEFAULT 5000;

-- Drop Default Value:
ALTER TABLE employees ALTER COLUMN salary DROP DEFAULT;

-- ------------------------------------------------------------
-- H. Change the Auto-Number Starting Value (instead of `AUTO_INCREMENT = n`)
-- ------------------------------------------------------------

-- * A `SERIAL` / `IDENTITY` column takes its numbers from a sequence. Change the sequence:
-- IDENTITY column:
ALTER TABLE employees ALTER COLUMN id RESTART WITH 1000;

-- SERIAL column (sequence name is usually table_column_seq):
ALTER SEQUENCE employees_id_seq RESTART WITH 1000;

-- Or set it from the current max id:
SELECT setval('employees_id_seq', (SELECT MAX(id) FROM employees));

-- * Find the sequence name of a column: `SELECT pg_get_serial_sequence('employees', 'id');`

-- ------------------------------------------------------------
-- I. Move a Table to Another Schema (PostgreSQL extra)
-- ------------------------------------------------------------

ALTER TABLE employees SET SCHEMA hr;     -- now it is hr.employees

-- ---

-- ------------------------------------------------------------
-- 9.7 Constraints Management via ALTER (Add & Drop Rules)
-- ------------------------------------------------------------

-- Constraints enforce data integrity and business rules on table columns. Using `ALTER TABLE`, you can add or remove these constraints on existing tables without rebuilding them.

-- > 🐘 Key PostgreSQL rule: Every constraint has a name, and you drop all of them the same way: `ALTER TABLE t DROP CONSTRAINT name;`. If you don't give a name, PostgreSQL creates one like `employees_pkey`, `employees_email_key`, `orders_customer_id_fkey`, `employees_age_check`. See the names with `\d table_name`.

-- ------------------------------------------------------------
-- Quick Reference Matrix:
-- ------------------------------------------------------------

-- (Constraint → How to ADD | How to DROP)
--
-- * PRIMARY KEY
--     - How to ADD  : ALTER TABLE employees ADD PRIMARY KEY (id);
--     - How to DROP : ALTER TABLE employees DROP CONSTRAINT employees_pkey;
--
-- * UNIQUE
--     - How to ADD  : ALTER TABLE employees ADD CONSTRAINT unique_email UNIQUE (email);
--     - How to DROP : ALTER TABLE employees DROP CONSTRAINT unique_email;
--
-- * FOREIGN KEY
--     - How to ADD  : ALTER TABLE orders ADD CONSTRAINT fk_cust FOREIGN KEY (customer_id) REFERENCES customers(id);
--     - How to DROP : ALTER TABLE orders DROP CONSTRAINT fk_cust;
--
-- * CHECK
--     - How to ADD  : ALTER TABLE employees ADD CONSTRAINT chk_age CHECK (age >= 18);
--     - How to DROP : ALTER TABLE employees DROP CONSTRAINT chk_age;
--
-- * NOT NULL
--     - How to ADD  : ALTER TABLE student ALTER COLUMN education SET NOT NULL;
--     - How to DROP : ALTER TABLE student ALTER COLUMN education DROP NOT NULL;
--
-- * DEFAULT
--     - How to ADD  : ALTER TABLE employees ALTER COLUMN salary SET DEFAULT 5000;
--     - How to DROP : ALTER TABLE employees ALTER COLUMN salary DROP DEFAULT;
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

-- To DROP a Primary Key (by its name):
ALTER TABLE table_name DROP CONSTRAINT constraint_name;

-- * Step-by-Step Example:
-- Add PRIMARY KEY to 'id' column:
ALTER TABLE employees ADD PRIMARY KEY (id);          -- auto name: employees_pkey

-- Drop PRIMARY KEY from employees table:
ALTER TABLE employees DROP CONSTRAINT employees_pkey;

-- * MySQL has `DROP PRIMARY KEY`; PostgreSQL does not — use the constraint name.

-- ------------------------------------------------------------
-- 2. UNIQUE Constraint
-- ------------------------------------------------------------

-- * What it does: Ensures that all values in a column are distinct (different). Unlike Primary Key, it allows `NULL` values (many NULLs are allowed, because NULL is not equal to NULL).

-- * Important Note: PostgreSQL also creates a unique index behind a `UNIQUE` constraint, but you drop the constraint (not the index) with `DROP CONSTRAINT`.

-- * PostgreSQL 15+ extra: `UNIQUE NULLS NOT DISTINCT (email)` allows only one NULL.

-- * Syntax:
-- To ADD a Unique constraint:
ALTER TABLE table_name ADD CONSTRAINT constraint_name UNIQUE (column_name);

-- To DROP a Unique constraint:
ALTER TABLE table_name DROP CONSTRAINT constraint_name;

-- * Step-by-Step Example:
-- Add UNIQUE constraint on email:
ALTER TABLE employees ADD CONSTRAINT unique_email UNIQUE (email);

-- Drop UNIQUE constraint by name:
ALTER TABLE employees DROP CONSTRAINT unique_email;

-- Another Example (auto-generated name for a UNIQUE on mobileno):
ALTER TABLE personinformation DROP CONSTRAINT personinformation_mobileno_key;

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
ALTER TABLE child_table DROP CONSTRAINT fk_name;

-- * Step-by-Step Example:
-- Add FOREIGN KEY linking orders.customer_id to customers.id:
ALTER TABLE orders
ADD CONSTRAINT fk_cust
FOREIGN KEY (customer_id) REFERENCES customers(id);

-- Drop FOREIGN KEY constraint:
ALTER TABLE orders DROP CONSTRAINT fk_cust;

-- * ⚠️ PostgreSQL does NOT create an index on the child column automatically (MySQL InnoDB does). Add one yourself for fast joins and deletes:
CREATE INDEX idx_orders_customer_id ON orders (customer_id);

-- * 🐘 Big-table trick: `ADD CONSTRAINT ... NOT VALID` adds the FK without checking old rows (fast), then `ALTER TABLE orders VALIDATE CONSTRAINT fk_cust;` checks them later without a long lock.

-- ------------------------------------------------------------
-- 4. CHECK Constraint
-- ------------------------------------------------------------

-- * What it does: Enforces a condition that all values inserted or updated in a column must satisfy (e.g., minimum age, positive salary).

-- * Syntax:
-- To ADD a Check constraint:
ALTER TABLE table_name ADD CONSTRAINT chk_name CHECK (condition);

-- To DROP a Check constraint:
ALTER TABLE table_name DROP CONSTRAINT chk_name;

-- * Step-by-Step Example:
-- Add CHECK constraint ensuring employee age is 18 or older:
ALTER TABLE employees ADD CONSTRAINT chk_age CHECK (age >= 18);

-- Add CHECK constraint ensuring salary is greater than 0:
ALTER TABLE employees ADD CONSTRAINT chk_salary CHECK (salary > 0);

-- Drop CHECK constraint:
ALTER TABLE employees DROP CONSTRAINT chk_age;

-- ------------------------------------------------------------
-- 5. NOT NULL Constraint
-- ------------------------------------------------------------

-- * What it does: Ensures that a column never accepts empty or missing (`NULL`) values.

-- * Syntax:
-- To ADD NOT NULL (make column mandatory):
ALTER TABLE table_name ALTER COLUMN column_name SET NOT NULL;

-- To DROP NOT NULL (allow NULL values):
ALTER TABLE table_name ALTER COLUMN column_name DROP NOT NULL;

-- * Step-by-Step Example:
-- Make education column mandatory:
ALTER TABLE student ALTER COLUMN education SET NOT NULL;

-- Allow NULL values in education column:
ALTER TABLE student ALTER COLUMN education DROP NOT NULL;

-- * No need to repeat the data type (MySQL `MODIFY` needs it).

-- ------------------------------------------------------------
-- 6. DEFAULT Constraint
-- ------------------------------------------------------------

-- * What it does: Automatically assigns a preset value when no value is provided for the column during an `INSERT`.

-- * Syntax:
-- To SET / ADD a Default value:
ALTER TABLE table_name ALTER COLUMN column_name SET DEFAULT default_value;

-- To DROP a Default value:
ALTER TABLE table_name ALTER COLUMN column_name DROP DEFAULT;

-- * Step-by-Step Example:
-- Set default salary of 5000:
ALTER TABLE employees ALTER COLUMN salary SET DEFAULT 5000;

-- Set default status to 'Active':
ALTER TABLE employees ALTER COLUMN status SET DEFAULT 'Active';

-- Drop the default salary value:
ALTER TABLE employees ALTER COLUMN salary DROP DEFAULT;

-- ---

-- ------------------------------------------------------------
-- 9.8 Quick Revision Cheat Sheet: ALTER Operations (PostgreSQL vs MySQL)
-- ------------------------------------------------------------

-- (What you want → MySQL | PostgreSQL)
--
-- * Add column
--     - MySQL      : ADD COLUMN c INT [FIRST / AFTER x]
--     - PostgreSQL : ADD COLUMN c INT (always at end)
--
-- * Change type
--     - MySQL      : MODIFY c BIGINT
--     - PostgreSQL : ALTER COLUMN c TYPE BIGINT [USING ...]
--
-- * Rename + change type
--     - MySQL      : CHANGE old new VARCHAR(50)
--     - PostgreSQL : RENAME COLUMN old TO new + ALTER COLUMN new TYPE VARCHAR(50)
--
-- * Rename column
--     - MySQL      : RENAME COLUMN a TO b
--     - PostgreSQL : RENAME COLUMN a TO b (same)
--
-- * NOT NULL
--     - MySQL      : MODIFY c INT NOT NULL
--     - PostgreSQL : ALTER COLUMN c SET NOT NULL
--
-- * Default
--     - MySQL      : ALTER c SET DEFAULT 5
--     - PostgreSQL : ALTER COLUMN c SET DEFAULT 5 (same)
--
-- * Drop PK
--     - MySQL      : DROP PRIMARY KEY
--     - PostgreSQL : DROP CONSTRAINT t_pkey
--
-- * Drop unique / FK / check
--     - MySQL      : DROP INDEX / DROP FOREIGN KEY / DROP CHECK
--     - PostgreSQL : DROP CONSTRAINT name (one command for all)
--
-- * Rename table
--     - MySQL      : RENAME TABLE a TO b
--     - PostgreSQL : ALTER TABLE a RENAME TO b
--
-- * Auto-number start
--     - MySQL      : AUTO_INCREMENT = 1000
--     - PostgreSQL : ALTER COLUMN id RESTART WITH 1000 / ALTER SEQUENCE
--
-- * Move to other schema
--     - MySQL      : RENAME TABLE db1.t TO db2.t
--     - PostgreSQL : ALTER TABLE t SET SCHEMA s2
--

-- ---

-- ------------------------------------------------------------
-- 9.9 DROP Commands (Permanent Object Deletion)
-- ------------------------------------------------------------

-- * What it does: Completely and permanently removes a database object and all its stored data.

-- * Rollback: In PostgreSQL, `DROP TABLE` inside `BEGIN ... ROLLBACK` can be undone (not `DROP DATABASE`). In MySQL it cannot.

-- * Difference from `DELETE`: `DELETE` only removes row records; `DROP` destroys the entire table structure, indexes, and constraints.

-- * `CASCADE` vs `RESTRICT` (PostgreSQL): By default (`RESTRICT`) a `DROP` fails if other objects (views, foreign keys) depend on it. `CASCADE` drops those dependent objects too.

-- ------------------------------------------------------------
-- 1. Drop Database
-- ------------------------------------------------------------

-- * Syntax:
DROP DATABASE [IF EXISTS] database_name [WITH (FORCE)];

-- * Example:
DROP DATABASE company_db;

-- PostgreSQL 13+: disconnect other users and drop anyway
DROP DATABASE company_db WITH (FORCE);

-- * You cannot drop the database you are connected to. Connect to `postgres` first (`\c postgres`).

-- ------------------------------------------------------------
-- 2. Drop Table
-- ------------------------------------------------------------

-- * Syntax:
DROP TABLE [IF EXISTS] table_name [, ...] [CASCADE | RESTRICT];

-- * Examples:
DROP TABLE employees;
DROP TABLE IF EXISTS person;
DROP TABLE customers CASCADE;   -- also drops the FK constraints in child tables that point to it

-- ---

-- ------------------------------------------------------------
-- 9.10 TRUNCATE Commands (Wipe Data, Keep Structure)
-- ------------------------------------------------------------

-- * Definition: TRUNCATE deletes all rows from a table in one go and frees the space, but keeps the table structure.

-- * Syntax:
TRUNCATE [TABLE] table_name [, ...] [RESTART IDENTITY | CONTINUE IDENTITY] [CASCADE | RESTRICT];

-- * Example:
TRUNCATE TABLE students;

-- Also reset SERIAL / IDENTITY numbering back to 1:
TRUNCATE TABLE students RESTART IDENTITY;

-- Truncate parent and all child tables that reference it:
TRUNCATE TABLE customers CASCADE;

-- * Key Characteristics of TRUNCATE (PostgreSQL):

--   1. Keeps the Structure: Table name, column names, data types, primary key, unique constraints, and foreign key definitions remain 100% intact.

--   2. Auto-number: NOT reset by default (`CONTINUE IDENTITY`). Add `RESTART IDENTITY` to reset it to the start. (MySQL always resets `AUTO_INCREMENT`.)

--   3. DDL Operation: Much faster than `DELETE`, because it doesn't delete rows one by one — PostgreSQL gives the table a new empty data file.

--   4. Can be Rolled Back: Inside `BEGIN ... ROLLBACK`, a `TRUNCATE` is undone. (MySQL: cannot.)

--   5. Foreign Key Rule: You cannot truncate a table that is referenced by a foreign key, unless you truncate the child tables in the same command or use `CASCADE`.

--   6. Triggers: Does not fire `ON DELETE` row triggers, but PostgreSQL supports special `ON TRUNCATE` statement triggers.

--   7. Locking: Takes an `ACCESS EXCLUSIVE` lock — nobody can read the table until it finishes.

-- ---

-- ------------------------------------------------------------
-- 9.11 RENAME Operations (Objects & Tables)
-- ------------------------------------------------------------

-- * Definition: Renaming changes the name of a table (or a column, index, view, schema or database) without touching the data.

-- * Core Characteristics & Architectural Rules:

--   * Only the name changes: PostgreSQL just updates the name in its system catalog (`pg_class`); no data is copied.

--   * Zero Data Loss: All column definitions, constraints (Primary Key, Foreign Key, Unique), indexes, and existing rows remain 100% intact.

--   * Transactional: In PostgreSQL a rename can be rolled back (`BEGIN; ... ROLLBACK;`).

--   * Views keep working: Views store the table's internal id (OID), so a view automatically follows a renamed table. But application queries, functions and procedures that use the old name in text must be updated.

-- ---

-- ------------------------------------------------------------
-- 1. Renaming Tables
-- ------------------------------------------------------------

-- * Syntax:
ALTER TABLE [IF EXISTS] table_name RENAME TO new_table_name;

-- * Examples:
-- 1. Standard single table rename:
ALTER TABLE student_info RENAME TO stud;

-- 2. Renaming employee table to staff:
ALTER TABLE employees RENAME TO staff_members;

-- * Zero-Downtime Atomic Swap (MySQL does this with one `RENAME TABLE a TO b, c TO a`). In PostgreSQL, use one transaction:
BEGIN;
ALTER TABLE live_products RENAME TO backup_products;
ALTER TABLE staging_products RENAME TO live_products;
COMMIT;   -- other sessions see both renames at the same moment

-- ---

-- ------------------------------------------------------------
-- 2. Moving Tables Across Schemas
-- ------------------------------------------------------------

-- * Description: In PostgreSQL you move a table to another schema (inside the same database) with `SET SCHEMA`. Moving to another database is not possible with one command — use `pg_dump` / `pg_restore` (Topic 51).

-- * Syntax:
ALTER TABLE source_schema.table_name SET SCHEMA target_schema;

-- * Example:
-- Moves the 'orders' table from 'staging' schema to 'production' schema:
ALTER TABLE staging.orders SET SCHEMA production;

-- ---

-- ------------------------------------------------------------
-- 3. Renaming Other Database Objects
-- ------------------------------------------------------------

-- ------------------------------------------------------------
-- A. Renaming a Column Inside a Table
-- ------------------------------------------------------------

-- * Syntax:
ALTER TABLE table_name RENAME COLUMN old_col_name TO new_col_name;

--   * Example:
ALTER TABLE employees RENAME COLUMN phone TO mobile_number;

-- ------------------------------------------------------------
-- B. Renaming an Index
-- ------------------------------------------------------------

-- * Description: Changes the name of an existing index without rebuilding it.

-- * Syntax:
ALTER INDEX old_index_name RENAME TO new_index_name;

-- * Example:
ALTER INDEX idx_emp_email RENAME TO idx_staff_email;

-- ------------------------------------------------------------
-- C. Renaming a View
-- ------------------------------------------------------------

-- * Syntax:
ALTER VIEW old_view_name RENAME TO new_view_name;

-- * Example:
ALTER VIEW active_users_view RENAME TO current_users_view;

-- ------------------------------------------------------------
-- D. Renaming a Schema / Sequence / Constraint (PostgreSQL extra)
-- ------------------------------------------------------------

ALTER SCHEMA staging RENAME TO stage;
ALTER SEQUENCE employees_id_seq RENAME TO staff_id_seq;
ALTER TABLE employees RENAME CONSTRAINT chk_age TO chk_min_age;

-- ---

-- ------------------------------------------------------------
-- 4. Q. Can We Directly Rename a Database in PostgreSQL?
-- ------------------------------------------------------------

-- * Direct Answer: YES (unlike MySQL).
ALTER DATABASE old_database_name RENAME TO new_database_name;

-- * Rules:

--   1. Nobody may be connected to that database (close pgAdmin tabs / apps first).

--   2. You must be connected to a different database (e.g. `\c postgres`).

--   3. You must be the owner or a superuser.

-- * Kick out other sessions if needed:
SELECT pg_terminate_backend(pid)
FROM pg_stat_activity
WHERE datname = 'old_database_name' AND pid <> pg_backend_pid();

-- ---

-- ------------------------------------------------------------
-- 9.12 Differences Between DELETE, TRUNCATE, and DROP
-- ------------------------------------------------------------

-- In SQL, you can remove data with three commands: `DELETE`, `TRUNCATE`, and `DROP`. All three remove data, but they work very differently (speed, rollback, and what happens to the table).

-- ---

-- ------------------------------------------------------------
-- 1. Comprehensive 10-Point Comparison Matrix (PostgreSQL)
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
--     - TRUNCATE : Wipes all rows in a table at once
--     - DROP     : Completely deletes table, structure & data
--
-- * 3. WHERE Clause Filtering
--     - DELETE   : Supported (WHERE condition)
--     - TRUNCATE : NOT Supported
--     - DROP     : NOT Supported
--
-- * 4. Rollback / Transactions
--     - DELETE   : YES
--     - TRUNCATE : YES in PostgreSQL (inside BEGIN) — NO in MySQL
--     - DROP     : YES in PostgreSQL (inside BEGIN) — NO in MySQL
--
-- * 5. Execution Speed
--     - DELETE   : Slower (marks each row as deleted)
--     - TRUNCATE : Very Fast (new empty data file)
--     - DROP     : Fastest (removes object from catalog)
--
-- * 6. Space Deallocation
--     - DELETE   : NO (dead rows stay until VACUUM)
--     - TRUNCATE : YES (old file removed)
--     - DROP     : YES (100% space freed)
--
-- * 7. Auto-number (sequence)
--     - DELETE   : Not reset
--     - TRUNCATE : Not reset unless RESTART IDENTITY
--     - DROP     : Sequence dropped with the table (SERIAL/IDENTITY)
--
-- * 8. Trigger Execution
--     - DELETE   : Fires ON DELETE triggers
--     - TRUNCATE : Fires only ON TRUNCATE statement triggers
--     - DROP     : No triggers (triggers dropped)
--
-- * 9. Foreign Key Rules
--     - DELETE   : Allowed if FK rules permit (ON DELETE ...)
--     - TRUNCATE : BLOCKED if referenced, unless CASCADE
--     - DROP     : BLOCKED if referenced, unless CASCADE (drops the FK constraints)
--
-- * 10. Table Structure After Query
--     - DELETE   : 100% Intact
--     - TRUNCATE : 100% Intact
--     - DROP     : DESTROYED
--

-- ---

-- ------------------------------------------------------------
-- 2. Syntax and Concrete Practical Examples
-- ------------------------------------------------------------

-- ------------------------------------------------------------
-- A. `DELETE` Command
-- ------------------------------------------------------------

-- * Syntax:
DELETE FROM table_name [WHERE condition] [RETURNING ...];

-- * Examples:
-- 1. Conditional deletion (removes single row):
DELETE FROM employees WHERE id = 101;

-- 2. Range deletion:
DELETE FROM employees WHERE age < 18;

-- 3. Delete all rows (row-by-row, rollback possible):
DELETE FROM employees;

-- 4. PostgreSQL extra: see what was deleted
DELETE FROM employees WHERE age < 18 RETURNING id, name;

-- ------------------------------------------------------------
-- B. `TRUNCATE` Command
-- ------------------------------------------------------------

-- * Syntax:
TRUNCATE TABLE table_name [RESTART IDENTITY];

-- * Example:
-- Wipes all records, resets numbering to 1, table structure stays intact:
TRUNCATE TABLE employees RESTART IDENTITY;

-- ------------------------------------------------------------
-- C. `DROP` Command
-- ------------------------------------------------------------

-- * Syntax:
DROP TABLE [IF EXISTS] table_name [CASCADE];

-- * Example:
-- Permanently deletes the table structure and its data from the database:
DROP TABLE employees;

-- ---

-- ------------------------------------------------------------
-- 3. When to Use Which? (Decision Guide)
-- ------------------------------------------------------------

-- 1. Use `DELETE` when:

--    - You need to delete only specific rows based on a criteria (`WHERE condition`).

--    - You need the safety of `ROLLBACK` in case of errors.

--    - You have auditing triggers that must execute on every deleted row.

--    - You want the deleted rows back with `RETURNING`.

-- 2. Use `TRUNCATE` when:

--    - You want to wipe out all records from a table quickly (e.g., staging tables, logs, testing caches).

--    - You want the numbering to restart (`RESTART IDENTITY`).

--    - You want to give disk space back immediately (no `VACUUM` needed).

-- 3. Use `DROP` when:

--    - You want to completely decommission and delete an entire table that is no longer needed.

--    - You are rebuilding a table from scratch by dropping and recreating it.

-- ---

-- ------------------------------------------------------------
-- 4. Focused Deep-Dive: DROP vs. TRUNCATE (Direct 6-Point Comparison)
-- ------------------------------------------------------------

-- * `DROP TABLE` (Total Structural Elimination):

--   * Core Action: Removes the entire table structure (schema + data). After drop, the table no longer exists.
DROP TABLE table_name;  -- Drop table completely

--   * Storage: Frees up the storage completely from disk (after commit).

--   * Rollback: In PostgreSQL, DDL can be rolled back inside a transaction (`BEGIN; DROP TABLE t; ROLLBACK;`). In MySQL it is permanent.

--   * Speed: Extremely fast (removes the catalog entry and the data files).

--   * Objects Removed: Removes table definition, constraints, indexes, triggers and owned sequences—everything.

--   * Auto-number: The `SERIAL` / `IDENTITY` sequence is dropped with the table.

-- * `TRUNCATE TABLE` (Fast Data Wipe, Structure Retained):

--   * Core Action: Clears the whole table at once without row-by-row work. Removes all rows, but keeps the table structure intact.
TRUNCATE TABLE table_name;  -- Truncate table (delete all rows)

--   * Storage: Empties the table data; structure, indexes and permissions stay.

--   * Rollback: Can be rolled back in PostgreSQL (inside a transaction).

--   * Speed: Faster than `DELETE` (no per-row work, no dead rows for `VACUUM`).

--   * Objects Preserved: Only removes row records; preserves columns, data types, constraints, indexes, and triggers.

--   * Auto-number: Kept as it is, unless you add `RESTART IDENTITY`.

-- ---

-- ------------------------------------------------------------
-- 9.13 Visual Diagrams & Architectural Explanations
-- ------------------------------------------------------------

-- > Note: These diagrams are shared from the MySQL notes. Where PostgreSQL behaves differently, it is written below the diagram.

-- ------------------------------------------------------------
-- Diagram 1: SQL Commands Overview (DDL, DML, DQL)
-- ------------------------------------------------------------

-- * Explanation:

--   * DDL (Left): Used by developers to define the blueprint (`CREATE`, `ALTER`, `DROP`, `TRUNCATE`, rename). The diagram says "implicit commit" — that is MySQL. In PostgreSQL, DDL is transactional and can be rolled back.

--   * DML (Bottom-Right): Used to write and modify actual rows (`INSERT`, `UPDATE`, `DELETE`).

--   * DQL (Top-Right): Used to search and retrieve data reports (`SELECT`).

-- ---

-- ------------------------------------------------------------
-- Diagram 2: DDL Structure & Scope of ALTER
-- ------------------------------------------------------------

-- * Explanation:

--   * Left Panel: `CREATE`, `ALTER`, and `DROP` acting upon the database container and its tables.

--   * Right Panel: Changes at the Database Level vs. Table Level (Columns, Datatypes, Constraints, and Indexes). In PostgreSQL the database level means rename / owner / settings (encoding is fixed at creation).

-- ---

-- ------------------------------------------------------------
-- Diagram 3: Descriptive Summary (Database Level vs Table Level ALTER Operations)
-- ------------------------------------------------------------

-- * Explanation (PostgreSQL reading of the MySQL diagram):

--   * Database Level (Left Panel): The diagram shows MySQL character set / collation changes and "no RENAME DATABASE". In PostgreSQL it is the opposite: `ALTER DATABASE ... RENAME TO` works, but encoding/collation cannot be changed after creation.

--   * Table Level (Right Panel): MySQL keywords → PostgreSQL keywords: `MODIFY` → `ALTER COLUMN ... TYPE / SET NOT NULL`, `CHANGE` → `RENAME COLUMN` + `ALTER COLUMN TYPE`, `RENAME TABLE` → `ALTER TABLE ... RENAME TO`, `AUTO_INCREMENT` → `RESTART WITH` / `ALTER SEQUENCE`.

-- ---

-- ------------------------------------------------------------
-- Diagram 4: Detailed Comparison (DELETE vs TRUNCATE vs DROP)
-- ------------------------------------------------------------

-- * Explanation:

--   * DELETE (Blue): DML row-by-row filtering via `WHERE`, with rollback capability and preserved table structure and auto-number.

--   * TRUNCATE (Amber): DDL instant wipe, leaving an empty table. In PostgreSQL the counter resets only with `RESTART IDENTITY`, and it can be rolled back.

--   * DROP (Red): Table definition and all data are removed.

-- ---

-- ------------------------------------------------------------
-- 9.14 Generated (Computed) Columns
-- ------------------------------------------------------------

-- * A generated column gets its value automatically from an expression on other columns of the same row. You never insert it yourself (PostgreSQL 12+).
CREATE TABLE order_items (
    item_id    SERIAL PRIMARY KEY,
    price      NUMERIC(10,2) NOT NULL,
    qty        INT NOT NULL,
    total      NUMERIC(12,2) GENERATED ALWAYS AS (price * qty) STORED,
    first_name VARCHAR(50),
    last_name  VARCHAR(50),
    full_name  VARCHAR(101) GENERATED ALWAYS AS (first_name || ' ' || last_name) STORED
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

-- * VIRTUAL vs STORED in PostgreSQL:

-- (Point → VIRTUAL | STORED)
--
-- * Supported?
--     - VIRTUAL : Only from PostgreSQL 18 (it is the default there)
--     - STORED  : Yes (PostgreSQL 12+)
--
-- * Disk space
--     - VIRTUAL : None — computed on every read
--     - STORED  : Uses space — computed on INSERT/UPDATE
--
-- * Read speed
--     - VIRTUAL : Slightly slower
--     - STORED  : Faster
--
-- * Index
--     - VIRTUAL : Not allowed
--     - STORED  : Allowed
--

-- * Big use case — index an expression. In PostgreSQL you usually don't need a generated column for this, because expression indexes are built in:
-- Expression index on the email domain (no extra column needed):
CREATE INDEX idx_email_domain ON customers ((split_part(email, '@', 2)));

SELECT * FROM customers WHERE split_part(email, '@', 2) = 'gmail.com';   -- uses the index

-- Or with a stored generated column + normal index:
ALTER TABLE customers
    ADD COLUMN email_domain VARCHAR(100) GENERATED ALWAYS AS (split_part(email, '@', 2)) STORED;
CREATE INDEX idx_email_domain2 ON customers (email_domain);

--   * Expression index on a year: `CREATE INDEX idx_year ON orders ((EXTRACT(YEAR FROM order_date)));`

-- * Rules: the expression must be immutable (no `now()`, `random()`, subqueries, or other tables), and you cannot write a value into it (`INSERT` / `UPDATE` of that column gives an error unless you use `DEFAULT`).

--     * `SET/DROP NOT NULL`, `SET/DROP DEFAULT`.

--   5. NOT NULL: `ALTER COLUMN col SET NOT NULL` / `DROP NOT NULL`.

--   6. DEFAULT: `ALTER COLUMN col SET DEFAULT` / `DROP DEFAULT`.

-- ---

-- ======================================================================
-- 🎯 Practice Questions (salesdb sample data) — try first, then look at the answer
-- ======================================================================
-- Run 00-Setup-Sample-Data.sql once before this section.

SET search_path TO sales;

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
SELECT column_name, data_type FROM information_schema.columns WHERE table_name = 'reviews';

-- Q3. TRUNCATE and DROP: empty the table, then remove it.
INSERT INTO reviews (reviewid, productid, stars) VALUES (1, 101, 5);
TRUNCATE TABLE reviews;
DROP TABLE reviews;
