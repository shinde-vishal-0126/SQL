-- ======================================================================
-- Topic 11: DML (Data Manipulation Language) In-Depth
-- ======================================================================

-- ------------------------------------------------------------
-- 📖 In Simple Words
-- ------------------------------------------------------------

-- * Definition: DML (Data Manipulation Language) commands change the data inside tables: INSERT adds rows, UPDATE changes rows, DELETE removes rows.

-- * Real-life example: If DDL builds the cupboard, DML puts things in, changes them and takes them out.

-- * Example on salesdb (run 00-Setup-Sample-Data.sql first):
SET search_path TO sales;
INSERT INTO customers (customerid, firstname, country, score) VALUES (6, 'Ravi', 'India', 600);
UPDATE customers SET score = 650 WHERE customerid = 6;
DELETE FROM customers WHERE customerid = 6;

-- * Example explained (step by step):
--   1. INSERT adds a new customer Ravi with id 6.
--   2. UPDATE changes only Ravi's score, because WHERE customerid = 6 picks that one row.
--   3. DELETE removes Ravi again. Without WHERE, UPDATE/DELETE would touch every row — always check the WHERE first.

-- ------------------------------------------------------------
-- 11.1 What is DML (Data Manipulation Language)?
-- ------------------------------------------------------------

-- * Definition: DML (Data Manipulation Language) commands work on the data (rows) inside tables — adding, changing and deleting rows.

--   * Operates on Records (Rows): DML works strictly on the rows (records) stored in tables, not on the table structure (schema blueprint).

--   * Transaction Safety (Controlled with Transactions): DML operations can be controlled using `COMMIT` (to permanently save changes) and `ROLLBACK` (to undo changes if an error occurs). In PostgreSQL even DDL can be rolled back (Topic 9.4).

-- * Classification of Primary DML Commands:

--   1. `INSERT`: Adds new data (rows/records) into a table.

--   2. `UPDATE`: Updates or modifies existing data inside a table.

--   3. `DELETE`: Removes data records from a table.

--   4. `INSERT ... ON CONFLICT` (PostgreSQL "upsert"): Inserts a row, or updates / skips it if the key already exists. (This replaces MySQL's `REPLACE` and `ON DUPLICATE KEY UPDATE`.)

--   5. `MERGE` (PostgreSQL 15+): Insert, update or delete rows in one statement by comparing a source with a target table.

-- * 🐘 PostgreSQL bonus for all DML: `RETURNING` gives back the rows that were inserted, updated or deleted — no extra `SELECT` needed.

-- ---

-- ------------------------------------------------------------
-- 11.2 The INSERT Command & Bulk Operations
-- ------------------------------------------------------------

-- * Definition: The INSERT statement is used to insert new data or rows into an existing table.

-- ------------------------------------------------------------
-- 1. Syntax for INSERT
-- ------------------------------------------------------------
-- Single and Multi-Row Insertion:
INSERT INTO table_name (column1, column2, column3, ...)
VALUES
    (value1, value2, value3, ...),
    (value11, value12, value13, ...),
    (value21, value22, value23, ...)
[RETURNING column_list];

-- ------------------------------------------------------------
-- 2. Critical Rules & Best Practices for INSERT
-- ------------------------------------------------------------

-- * Match Number of Columns and Values: The number of values in the `VALUES` clause must match the number of specified columns.

-- * Column and Value Order: At the time of insert, ensure that values appear in the exact same order as the listed columns.

-- * Matching Data Types & Constraints: Inserted values must be compatible with the column's data type and satisfy all constraints (Primary Key uniqueness, Foreign Key existence, Not Null rules). PostgreSQL is strict: `'abc'` into an `INT` column is an error, not a silent `0` like old MySQL modes.

-- * Optional Column Names:

--   * Specifying column names is optional. If no columns are specified, SQL expects values for all columns in the exact sequence defined in the table schema.

--   * Tip: Always list column names explicitly for clarity, maintainability, and to avoid bugs when table structure evolves.

-- * Handling Unspecified Columns: Any column omitted from the column list automatically becomes `NULL`, unless a `DEFAULT` value or a `SERIAL` / `IDENTITY` is defined on that column. You can also write the keyword `DEFAULT` as a value.

-- ------------------------------------------------------------
-- 3. Standard INSERT Examples
-- ------------------------------------------------------------
-- Explicit Column Insertion (Best Practice):
INSERT INTO students (id, name, age)
VALUES (1, 'Vishal', 21);

-- Multi-Row Insertion in a Single Query:
INSERT INTO students (id, name, age)
VALUES
    (2, 'Amit', 22),
    (3, 'Neha', 20),
    (4, 'Pooja', 23);

-- Omitting Column List (Must provide values for all table columns in order):
INSERT INTO students
VALUES (5, 'Rahul', 24);

-- PostgreSQL extra: get back the new row (very useful with SERIAL ids)
INSERT INTO students (name, age)
VALUES ('Sneha', 22)
RETURNING id, name;

--   * Method ①: Manual Entry (`VALUES` Clause):

--     * User / Developer Input: The developer specifies literal values manually from their workstation or application code using:
INSERT INTO students (id, name, age) VALUES (1, 'Vishal', 21);

--     * Execution Flow: PostgreSQL receives the `INSERT ... VALUES` statement, checks the rules (constraints) and saves the new row(s) into the Target Table.

--   * Method ②: INSERT Using `SELECT` (Automated Query-Driven Ingestion):

--     * Source Table Query: An inner query (`SELECT col1, col2 FROM source_table WHERE ...`) reads rows from an existing Source Table.

--     * Execution Flow: Those rows go straight into the Target Table using `INSERT INTO target_table SELECT ...` — no need to type the values by hand.

-- ------------------------------------------------------------
-- 4. How to Insert Data from One Table to Another (Source to Target Table)
-- ------------------------------------------------------------

-- * Interview Questions:

--   * Q. How to insert data from one table to another table (from source table to target table)?

--   * Q. Write the SQL query to get data from the source table and insert into the target table (e.g., how to copy data from `customers` to `customers2` / `orders`)?

-- You can copy data from an existing source table directly into a target table using `INSERT INTO ... SELECT`.

-- * Syntax:
-- Copying specific matched columns:
INSERT INTO target_table (col1, col2, col3, ...)
SELECT col1, col2, col3, ...
FROM source_table
[WHERE condition];

-- Copying all columns directly:
INSERT INTO target_table
SELECT * FROM source_table;

-- * Practical Concrete Examples (Copying Customers Table):
-- Example 1: Explicit column selection from source to target
INSERT INTO customers2 (customerid, firstname, lastname, country, score)
SELECT customerid, firstname, lastname, country, score
FROM customers;

-- Example 2: Copying all columns using wildcard
INSERT INTO customers2 (customerid, firstname, lastname, country, score)
SELECT *
FROM customers;

-- Example 3: Filtered copy (only customers from India with high score)
INSERT INTO premium_customers (customerid, firstname, country, score)
SELECT customerid, firstname, country, score
FROM customers
WHERE country = 'India' AND score >= 800;

-- * ⚠️ Note: Example 2 works only if `customers` has exactly these 5 columns in the same order, because `SELECT *` must return the same number of columns as the target column list.

-- ------------------------------------------------------------
-- 5. Bulk Load from a File: `COPY` (PostgreSQL extra)
-- ------------------------------------------------------------

-- * The fastest way to load many rows (MySQL: `LOAD DATA INFILE`):
-- Server-side file (needs superuser or pg_read_server_files role):
COPY customers (customerid, firstname, country, score)
FROM '/tmp/customers.csv' WITH (FORMAT csv, HEADER true);

-- From your own computer using psql:
-- (psql/client command — run it in psql, not in a GUI query tool):
-- \copy customers FROM 'C:/data/customers.csv' WITH (FORMAT csv, HEADER true)

-- ---

-- ------------------------------------------------------------
-- 11.3 The UPDATE Command & Best Practices
-- ------------------------------------------------------------

-- * Definition: The UPDATE command changes values in existing rows. It does not change the table structure.

-- * Use of UPDATE & SET: `UPDATE` specifies the target table to be modified, while `SET` specifies the column name(s) and assigns their new values.

--   * 1. Row-Level / Cell-Level Data Modification:

--     * `ALTER TABLE` (DDL) changes the table's structure, but `UPDATE` only changes the data inside rows — column names, data types and constraints stay the same.

--   * 2. Granular Filtering via `WHERE` Clause:

--     * You can update one row, a few rows or all rows using `WHERE`. If you forget the `WHERE` clause, every row in the table is updated.

--   * 3. Dynamic Computations, Expressions & Subqueries:

--     * You can set a fixed value (e.g., `SET status = 'Active'`), calculate from the current value (e.g., `SET salary = salary * 1.10`, `SET score = score + 50`), or even use a subquery.

--   * 4. Transactional Safety (`COMMIT` & `ROLLBACK`):

--     * You can run `UPDATE` inside a transaction, check the result, and use `ROLLBACK` if it was a mistake.

--   * 5. Constraint & Index Integrity:

--     * Every update is checked against the constraints (`PRIMARY KEY`, `FOREIGN KEY`, `UNIQUE`, `CHECK`, `NOT NULL`). If any rule is broken, the whole statement fails. Indexes are updated automatically.

--   * 6. How PostgreSQL really updates (MVCC):

--     * PostgreSQL does not change the row in place. It writes a new version of the row and marks the old version as dead. `VACUUM` later cleans dead rows. That is why a huge `UPDATE` can make a table bigger for a while.

-- ------------------------------------------------------------
-- 1. Syntax for UPDATE
-- ------------------------------------------------------------
UPDATE table_name
SET
    column1 = value1,
    column2 = value2,
    ...
[FROM other_table]
WHERE condition
[RETURNING ...];

-- ------------------------------------------------------------
-- 2. Features & Clauses Supported by UPDATE
-- ------------------------------------------------------------

-- * Single or Multiple Columns: You can update one column or multiple columns simultaneously in a single statement.

-- * Combine with Clauses: `UPDATE` can be combined with `WHERE`, `LIKE`, `IN`, a `FROM` clause (for joins), subqueries and `RETURNING`.

-- * ⚠️ Not allowed in PostgreSQL: `JOIN` directly after `UPDATE`, and `ORDER BY` / `LIMIT` in `UPDATE`. See the PostgreSQL way below.

-- ------------------------------------------------------------
-- 3. Practical Examples
-- ------------------------------------------------------------

-- Q. How to update the customer's score where customer id is 4?
UPDATE customers
SET score = 600
WHERE customerid = 4;

-- Updating multiple columns at once:
UPDATE employees
SET salary = 75000, department = 'Engineering', status = 'Promoted'
WHERE employee_id = 101;

-- Conditional update using LIKE:
UPDATE customers
SET score = score + 50
WHERE country LIKE 'Ind%';

-- Conditional update using IN:
UPDATE products
SET discount = 15
WHERE category_id IN (1, 3, 5);

-- Cross-Table Update (PostgreSQL uses FROM instead of JOIN):
UPDATE employees e
SET salary = e.salary * 1.15
FROM departments d
WHERE e.dept_id = d.dept_id
  AND d.dept_name = 'Research & Development';

-- Top-N update (PostgreSQL has no ORDER BY / LIMIT in UPDATE — use a subquery):
-- Increase scores for only the bottom 5 lowest-scoring customers in India:
UPDATE customers
SET score = score + 20
WHERE customerid IN (
    SELECT customerid
    FROM customers
    WHERE country = 'India'
    ORDER BY score ASC
    LIMIT 5
);

-- PostgreSQL extra: see the new values right away
UPDATE customers
SET score = score + 10
WHERE country = 'India'
RETURNING customerid, score;

-- * Note: In the `SET` part of a PostgreSQL `UPDATE`, don't put the table alias before the column (`SET e.salary = ...` is an error). Write `SET salary = ...`.

-- ------------------------------------------------------------
-- 4. Critical Warnings & Best Practices
-- ------------------------------------------------------------
-- > ⚠️ CRITICAL WARNING:
-- > Always use a WHERE clause in an UPDATE statement!
-- > Without a `WHERE` clause, ALL rows in the table will be updated unconditionally.
-- >
-- > 💡 Industry Best Practice:
-- > Always verify your criteria first by running a `SELECT` query with the exact same `WHERE` clause before executing the `UPDATE`. In PostgreSQL you can also wrap it in a transaction:
-- Step 1: Verify the rows to be modified:
SELECT * FROM customers WHERE customerid = 4;

-- Step 2: Run the UPDATE inside a transaction and check the row count:
BEGIN;
UPDATE customers SET score = 600 WHERE customerid = 4;   -- psql prints: UPDATE 1
COMMIT;   -- or ROLLBACK; if the count is wrong

-- ---

-- ------------------------------------------------------------
-- 11.4 The DELETE Command & Safe Execution
-- ------------------------------------------------------------

-- * Definition: DELETE removes some rows (or all rows) from a table. The table structure, columns, constraints and indexes stay the same.

-- * Role of DELETE FROM & WHERE: `DELETE FROM table_name` specifies the target table, while the `WHERE condition` identifies the exact records to be deleted. By default, standard SQL `DELETE` performs a hard delete.

--   * 1. Row-by-Row Removal (Record-Level Action):

--     * `DROP` removes the whole table and `TRUNCATE` empties it in one go, but `DELETE` (a DML command) removes rows one by one, so it can be rolled back.

--     * In PostgreSQL the deleted rows are only marked as dead; the disk space is reused after `VACUUM` (autovacuum does this automatically).

--   * 2. Granular Filtering with `WHERE` Clause:

--     * Supports fine-grained row selection using conditions (`=`, `!=`, `<`, `>`, `LIKE`, `IN`, `BETWEEN`). If the `WHERE` clause is omitted, all records in the table will be deleted.

--   * 3. Transaction Safety & Rollback:

--     * You can run `DELETE` inside a transaction (`BEGIN`). If you delete something by mistake, run `ROLLBACK` before `COMMIT` to get the rows back.

--   * 4. Foreign Key & Referential Integrity Enforcement:

--     * Checks related child tables before deletion (`ON DELETE NO ACTION / RESTRICT`, `CASCADE`, `SET NULL`, `SET DEFAULT`). If a child table holds dependent records, the default rule rejects the deletion to prevent orphan records.

--   * 5. Trigger Activation:

--     * Fires `BEFORE DELETE` and `AFTER DELETE` triggers on each affected row, which is essential for audit logging and archival workflows.

--   * 6. Auto-number Preservation:

--     * Running `DELETE` (even without a `WHERE` clause) does not reset the `SERIAL` / `IDENTITY` sequence.

-- ------------------------------------------------------------
-- 1. Syntax for DELETE
-- ------------------------------------------------------------
DELETE FROM table_name
[USING other_table]
WHERE condition
[RETURNING ...];

-- ------------------------------------------------------------
-- 2. Practical Examples
-- ------------------------------------------------------------
-- Delete customer records where country is India:
DELETE FROM customers
WHERE country = 'India';

-- Delete customer records where score is 999:
DELETE FROM customers
WHERE score = 999;

-- Delete using another table (PostgreSQL uses USING instead of a JOIN):
DELETE FROM orders o
USING customers c
WHERE o.customer_id = c.customerid
  AND c.country = 'Unknown';

-- See exactly which rows were removed:
DELETE FROM customers WHERE score = 999 RETURNING *;

-- ------------------------------------------------------------
-- 3. Critical Safety Rules
-- ------------------------------------------------------------

-- * Avoid `DELETE` without a `WHERE` clause: Executing `DELETE FROM table_name;` without a `WHERE` clause will wipe out all records in the table.

-- * Verify with `SELECT` first: Run `SELECT * FROM table_name WHERE condition;` prior to running the delete to inspect the exact rows that will be eliminated.

-- ---

-- ------------------------------------------------------------
-- 11.5 Safe Updates in PostgreSQL (No `SQL_SAFE_UPDATES` Mode)
-- ------------------------------------------------------------

-- * MySQL has a setting `SQL_SAFE_UPDATES` that blocks `UPDATE` / `DELETE` without a key column in `WHERE` (Error 1175). PostgreSQL has no such setting. `DELETE FROM customers WHERE score = 999;` simply runs.

-- * How PostgreSQL users stay safe instead:

-- ------------------------------------------------------------
-- 1. Use a Transaction and Check the Row Count (Best Practice)
-- ------------------------------------------------------------

BEGIN;

DELETE FROM customers WHERE score = 999;
-- psql shows: DELETE 3      ← number of rows affected

-- If 3 is what you expected:
COMMIT;
-- If not:
ROLLBACK;

-- ------------------------------------------------------------
-- 2. Use RETURNING to See the Rows
-- ------------------------------------------------------------

BEGIN;
DELETE FROM customers WHERE score = 999 RETURNING customerid, firstname;
ROLLBACK;   -- just a preview; nothing is deleted

-- ------------------------------------------------------------
-- 3. psql Safety Settings
-- ------------------------------------------------------------

-- * psql is in autocommit mode by default (every statement saves at once). You can turn that off for a session:
-- (psql/client command — run it in psql, not in a GUI query tool):
-- \set AUTOCOMMIT off       -- now every statement waits for COMMIT
-- (psql/client command — run it in psql, not in a GUI query tool):
-- \set ON_ERROR_ROLLBACK interactive   -- an error doesn't kill the whole transaction

-- * Tools like DBeaver and pgAdmin also have a "manual commit" mode.

-- ------------------------------------------------------------
-- 4. Extension: `pg_safeupdate`
-- ------------------------------------------------------------

-- * If you really want MySQL-style blocking, the small extension `pg_safeupdate` rejects `UPDATE` and `DELETE` without a `WHERE` clause:
LOAD 'safeupdate';
DELETE FROM customers;   -- ERROR: DELETE requires a WHERE clause

-- * Interview Answer Summary:
--   > "PostgreSQL has no safe-update mode like MySQL's `SQL_SAFE_UPDATES`. Instead we run risky `UPDATE`/`DELETE` statements inside `BEGIN ... COMMIT`, check the affected row count (or use `RETURNING`), and `ROLLBACK` if it is wrong. The `pg_safeupdate` extension can block `UPDATE`/`DELETE` without a `WHERE` clause."

-- ---

-- ------------------------------------------------------------
-- 11.6 Soft Delete vs Hard Delete (In-Depth Comparison)
-- ------------------------------------------------------------

-- ------------------------------------------------------------
-- 1. Detailed 9-Point Comparison Matrix
-- ------------------------------------------------------------

-- | :--- | :--- | :--- |
-- | 1. Meaning | Data is permanently removed from the table | Data is not removed; it is only marked as deleted using a status flag |
-- | 2. Data Recovery | Cannot be recovered unless a backup / PITR is available | Easily restored by changing the status flag back to active |
-- | 3. How It Works | Removes the row (marked dead, cleaned by `VACUUM`) | Updates a flag or timestamp column to indicate deletion |
-- | 4. SQL Command | Executed using `DELETE` or `TRUNCATE` | Executed using `UPDATE` (`SET is_deleted = TRUE`) |
-- | 5. Storage Usage | Uses less storage because deleted records are cleared | Uses more storage because deleted records remain in the table |
-- | 6. Query Performance | Generally faster; fewer records remain to scan and index | Queries need a filter (`WHERE NOT is_deleted`); a partial index helps |
-- | 7. Data History & Audit | Historical data is permanently lost | Maintains audit history: who deleted what and when |
-- | 8. Implementation | No extra table columns required | Requires additional columns like `is_deleted`, `deleted_at`, or `status` |
-- | 9. Common Use Cases | Temporary data, cache tables, compliance data removal (GDPR) | Banking, e-commerce orders, user accounts, audit-heavy enterprise apps |

-- ------------------------------------------------------------
-- 2. Practical Implementation of Soft Delete
-- ------------------------------------------------------------
-- Step 1: Add soft delete tracking columns to the table
ALTER TABLE customers
    ADD COLUMN is_deleted BOOLEAN DEFAULT FALSE,
    ADD COLUMN deleted_at TIMESTAMPTZ NULL;

-- Step 2: Perform a "Soft Delete" (UPDATE instead of DELETE)
UPDATE customers
SET is_deleted = TRUE, deleted_at = now()
WHERE customer_id = 101;

-- Step 3: Query active records (Exclude soft-deleted rows)
SELECT * FROM customers
WHERE is_deleted = FALSE;          -- or: WHERE NOT is_deleted

-- Step 4: Restore / Undelete a record
UPDATE customers
SET is_deleted = FALSE, deleted_at = NULL
WHERE customer_id = 101;

-- PostgreSQL extra: index only the active rows (small and fast)
CREATE INDEX idx_customers_active ON customers (customer_id) WHERE NOT is_deleted;

-- ---

-- ------------------------------------------------------------
-- 11.7 Foreign Key Referential Actions (Complete Guide)
-- ------------------------------------------------------------

-- ------------------------------------------------------------
-- 1. What is Referential Integrity?
-- ------------------------------------------------------------

-- * Definition: Referential Integrity means links between tables always stay valid — a child row can never point to a parent row that doesn't exist.

-- * It prevents child records from pointing to non-existing parent records.

-- ------------------------------------------------------------
-- 2. What is a Referential Action?
-- ------------------------------------------------------------

-- * Definition: A Referential Action tells PostgreSQL: "If a parent row is UPDATED or DELETED, what should automatically happen to the related child rows?"
-- This action is defined directly inside the Foreign Key constraint clause:
FOREIGN KEY (department_id)
REFERENCES department(department_id)
ON DELETE CASCADE
ON UPDATE CASCADE

-- ------------------------------------------------------------
-- 3. The 5 Types of Referential Actions
-- ------------------------------------------------------------

-- 1. `CASCADE`: Automatically deletes or updates child rows when parent is deleted or updated.

-- 2. `NO ACTION` (PostgreSQL Default): Blocks the parent delete/update if matching child rows exist. The check happens at the end of the statement (or at commit, if the constraint is `DEFERRABLE`).

-- 3. `RESTRICT`: Also blocks, but checks immediately and can never be deferred. In everyday use it behaves the same as `NO ACTION`.

-- 4. `SET NULL`: Sets child foreign key columns to `NULL` when parent row is deleted or updated (requires column to be nullable). PostgreSQL 15+ can list columns: `ON DELETE SET NULL (department_id)`.

-- 5. `SET DEFAULT`: Sets child foreign key to its column default value. ✅ Supported in PostgreSQL (MySQL InnoDB does not support it). The default value must exist in the parent table.

-- ---

-- ------------------------------------------------------------
-- 4. Deep-Dive: `ON DELETE CASCADE`
-- ------------------------------------------------------------

-- * Definition: ON DELETE CASCADE is a referential action used with foreign key constraints. When a row in the parent table is deleted, PostgreSQL automatically deletes all related rows from the child table.

-- * What happens WITHOUT `ON DELETE CASCADE`?

--   * If not specified, PostgreSQL uses `NO ACTION`.

--   * Deleting the parent row fails with:
--     `ERROR: update or delete on table "department" violates foreign key constraint "fk_dept" on table "employee"`
--     `DETAIL: Key (department_id)=(1) is still referenced from table "employee".`

--   * You must first manually delete all child records before deleting the parent record.

-- * Complete Executable SQL Demonstration:
-- Step 1: Create Parent Table (department)
DROP TABLE IF EXISTS employee;
DROP TABLE IF EXISTS department;

CREATE TABLE department (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50) NOT NULL
);

-- Step 2: Create Child Table (employee) with ON DELETE CASCADE
CREATE TABLE employee (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50) NOT NULL,
    department_id INT,
    CONSTRAINT fk_dept
        FOREIGN KEY (department_id) REFERENCES department(department_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- Step 3: Insert Sample Data
INSERT INTO department VALUES (1, 'HR'), (2, 'Engineering');
INSERT INTO employee VALUES (101, 'Amit', 1), (102, 'Neha', 1), (103, 'Rahul', 2);

-- Inspect before deletion
SELECT * FROM department;
SELECT * FROM employee;

-- Step 4: Delete Parent Record (department_id = 1)
DELETE FROM department WHERE department_id = 1;

-- Step 5: Verify Cascade Deletion
-- Notice Amit and Neha are AUTOMATICALLY deleted from employee table!
SELECT * FROM employee;

-- * Step-by-Step Point-Wise Breakdown of the ON DELETE CASCADE Example:

--   * Point 1 (Parent Table Definition): Table `department` is created with `department_id` as the primary key.

--   * Point 2 (Child Foreign Key with CASCADE): Table `employee` is created with `CONSTRAINT fk_dept FOREIGN KEY (department_id) REFERENCES department(department_id) ON DELETE CASCADE`.

--   * Point 3 (Data Seeding): Department `1` ('HR') is created, and two employees (`101` Amit, `102` Neha) are assigned to Department `1`.

--   * Point 4 (Parent Deletion): Running `DELETE FROM department WHERE department_id = 1;` removes the parent record.

--   * Point 5 (Automatic Cascade Purge): Because `ON DELETE CASCADE` is active, PostgreSQL automatically deletes Amit and Neha from `employee`. Querying `employee` confirms that no orphan records remain.

--   * Point 6 (Without Cascade Behavior): Without `ON DELETE CASCADE` (default `NO ACTION`), deleting department 1 fails with the "violates foreign key constraint" error. You must run a manual 2-step deletion (delete child rows first, then delete parent).

-- * What happens without Cascade? (Demonstration of the error):
-- Suppose employee was created without ON DELETE CASCADE (default NO ACTION):
DELETE FROM department WHERE department_id = 1;
-- ERROR: update or delete on table "department" violates foreign key constraint "fk_dept" on table "employee"

-- To delete, you MUST manually delete child records first:
DELETE FROM employee WHERE department_id = 1;
DELETE FROM department WHERE department_id = 1;

-- * 🐘 Performance tip: Add an index on `employee(department_id)`. PostgreSQL does not create it automatically, and without it every parent delete scans the whole child table.

-- * Interview Answer (ON DELETE CASCADE):

-- ---

-- ------------------------------------------------------------
-- 5. Deep-Dive: `ON UPDATE CASCADE`
-- ------------------------------------------------------------

-- * Definition: ON UPDATE CASCADE automatically updates the foreign key values in the child table whenever the referenced primary key in the parent table is updated.

-- * Purpose: Keeps parent and child records continuously synchronized.

-- * What happens WITHOUT `ON UPDATE CASCADE`?

--   * Changing a parent's primary key fails under the default `NO ACTION`, because existing child rows would point to an invalid key. You would have to manually update child tables first.

-- * Complete Executable Demonstration:
-- (department and employee created above with ON UPDATE CASCADE)

-- Update Parent Primary Key (change HR department_id from 1 to 101):
-- PostgreSQL has no safe-update mode, so no SET SQL_SAFE_UPDATES is needed.
UPDATE department
SET department_id = 101
WHERE department_name = 'HR';

-- Verify Child Table:
-- Notice Amit and Neha's department_id is automatically updated to 101!
SELECT * FROM employee;

-- * Step-by-Step Point-Wise Breakdown of the ON UPDATE CASCADE Example:

--   * Point 1 (Parent Key Modification): Department `1` ('HR') needs to have its primary key changed from `1` to `101`.

--   * Point 2 (Automatic Key Synchronization): PostgreSQL detects the parent primary key change and automatically updates `employee.department_id` from `1` to `101` for both Amit and Neha.

--   * Point 3 (Verification & Data Integrity): Running `SELECT * FROM employee;` shows Amit and Neha now reference `department_id = 101`. No manual update on `employee` was required.

--   * Point 4 (Without Update Cascade Behavior): Without `ON UPDATE CASCADE`, PostgreSQL uses `NO ACTION` and aborts the primary key update with a foreign key violation error.

-- * Interview Questions & Answers (ON UPDATE CASCADE):

--   * Q. What is ON UPDATE CASCADE?

--     * Answer: ON UPDATE CASCADE is a referential action used in a foreign key constraint. When the primary key value in the parent table changes, PostgreSQL automatically updates the matching foreign key values in the child table, keeping related data synchronized.

--   * Q. Why do we use ON UPDATE CASCADE?

--     * Answer: To avoid manually updating child table records whenever a parent table's primary key changes. It ensures data consistency and prevents broken relationships between parent and child tables.

-- ---

-- ------------------------------------------------------------
-- 6. Summary Matrix of Referential Actions (PostgreSQL)
-- ------------------------------------------------------------

-- | Action Type | Behavior on Parent Deletion (`ON DELETE`) | Behavior on Parent Update (`ON UPDATE`) | Best Use Case |
-- | :--- | :--- | :--- | :--- |
-- | `CASCADE` | Automatically deletes all related child rows | Automatically updates related child foreign keys | Child data has no meaning without parent (e.g., Order Items $\rightarrow$ Order) |
-- | `NO ACTION` (DEFAULT) | Blocks parent deletion if child rows exist (check at end of statement; can be deferred) | Blocks parent key update if child rows exist | Default protection; works with `DEFERRABLE` |
-- | `RESTRICT` | Blocks immediately (cannot be deferred) | Blocks immediately | Strict protection |
-- | `SET NULL` | Sets child foreign key column to `NULL` (Child remains) | Sets child foreign key column to `NULL` | Child can exist independently (e.g., Employee stays if Department is deleted) |
-- | `SET DEFAULT` | Sets child foreign key to its default value | Sets child foreign key to its default value | ✅ Supported in PostgreSQL (e.g., move employees to a "General" department) |

--   * 1. `ON DELETE CASCADE`:

--     * Behavior: When a parent row is deleted, all related child rows are deleted automatically.

--     * Use Case: Used when child data has no meaning without the parent (e.g., deleting an `orders` record automatically purges all corresponding `order_items`).

--   * 2. `ON UPDATE CASCADE`:

--     * Behavior: When the parent primary key is updated, the child foreign key values are updated automatically.

--     * Use Case: Used when parent key values may change over time and child records must stay synchronized.

--   * 3. `ON DELETE SET NULL`:

--     * Behavior: When the parent row is deleted, the child foreign key is set to `NULL` so the child record remains intact.

--     * Use Case: Used when a child entity can exist without a parent (e.g., an `employee` keeps their record when a `department` is dissolved).

--     * Prerequisite: The child foreign key column must allow `NULL` values.

--   * 4. `ON DELETE NO ACTION` (PostgreSQL Default):

--     * Behavior: Parent deletion is blocked with a foreign key violation error if any related child records exist.

--     * Difference from `RESTRICT`: with a `DEFERRABLE` constraint, `NO ACTION` waits until `COMMIT` to check — so you can delete the parent and child in any order inside one transaction.

--   * 5. `ON DELETE RESTRICT`:

--     * Behavior: Same blocking, but always checked immediately.

--   * 6. `ON DELETE SET DEFAULT` (Works in PostgreSQL):

--     * Behavior: If the parent row is deleted, the child foreign key is set to its column default.

--     * Example:
CREATE TABLE employee2 (
    emp_id INT PRIMARY KEY,
    department_id INT DEFAULT 2      -- 2 = 'Engineering' / general department
        REFERENCES department(department_id) ON DELETE SET DEFAULT
);

-- * MySQL vs PostgreSQL difference: MySQL default is `RESTRICT` and InnoDB rejects `SET DEFAULT`; PostgreSQL default is `NO ACTION` and `SET DEFAULT` works.

-- ---

-- ------------------------------------------------------------
-- 11.8 Upsert in PostgreSQL: `INSERT ... ON CONFLICT` (instead of MySQL `REPLACE`)
-- ------------------------------------------------------------

-- ------------------------------------------------------------
-- 1. What is an Upsert?
-- ------------------------------------------------------------

-- * Definition: An "upsert" means: insert the row; if a row with the same key already exists, update it (or skip it) instead of failing.

-- * MySQL has two commands for this: `REPLACE INTO` (delete + insert) and `INSERT ... ON DUPLICATE KEY UPDATE`. PostgreSQL has one standard command: `INSERT ... ON CONFLICT`.

-- * PostgreSQL has NO `REPLACE INTO` statement.

-- * Formula:
--   $$\text{ON CONFLICT DO UPDATE} = \text{INSERT (new key)} \;\text{or}\; \text{UPDATE (existing key)}$$

-- ------------------------------------------------------------
-- 2. Crucial Requirements for ON CONFLICT
-- ------------------------------------------------------------

-- * Requires a unique key: `ON CONFLICT (column)` works only if that column has a `PRIMARY KEY` or `UNIQUE` constraint/index. Otherwise PostgreSQL raises: `there is no unique or exclusion constraint matching the ON CONFLICT specification`.

-- * `EXCLUDED` is a special name for "the row you tried to insert". Use it to copy the new values: `SET score = EXCLUDED.score`.

-- ------------------------------------------------------------
-- 3. Practical Code Examples (same data as MySQL notes)
-- ------------------------------------------------------------
-- Step 1: Normal Insert
INSERT INTO customers (id, first_name, country, score)
VALUES (6, 'Vishal', 'India', 999);

-- Step 2: id = 6 already exists → replace all values with the new row
-- (Result is like MySQL REPLACE: row becomes Ram, India, 888 — but it is an UPDATE, not delete + insert)
INSERT INTO customers (id, first_name, country, score)
VALUES (6, 'Ram', 'India', 888)
ON CONFLICT (id) DO UPDATE
SET first_name = EXCLUDED.first_name,
    country    = EXCLUDED.country,
    score      = EXCLUDED.score;

-- Step 3: key does not exist → inserted as a new record
INSERT INTO customers (id, first_name, country, score)
VALUES (7, 'Vishal', 'India', 999)
ON CONFLICT (id) DO UPDATE
SET first_name = EXCLUDED.first_name, country = EXCLUDED.country, score = EXCLUDED.score;

-- Step 4: Ignore duplicates silently (MySQL: INSERT IGNORE)
INSERT INTO customers (id, first_name, country, score)
VALUES (6, 'Duplicate', 'UK', 100)
ON CONFLICT (id) DO NOTHING;

-- Step 5: Update only if a condition is true
INSERT INTO customers (id, first_name, country, score)
VALUES (6, 'Ram', 'India', 500)
ON CONFLICT (id) DO UPDATE
SET score = EXCLUDED.score
WHERE customers.score < EXCLUDED.score;     -- keep the higher score

-- ------------------------------------------------------------
-- 4. Differences: UPDATE vs INSERT ... ON CONFLICT
-- ------------------------------------------------------------

-- | Dimension | `UPDATE` | `INSERT ... ON CONFLICT DO UPDATE` |
-- | :--- | :--- | :--- |
-- | Operation Type | Modifies existing rows | Inserts, or updates the existing row with the same key |
-- | Key Conflict | Needs `WHERE` to find rows | Uses the unique key to detect the conflict |
-- | Non-Existing Key | 0 rows affected (does not insert) | Inserts as a brand new row |
-- | Trigger Execution | Fires `UPDATE` triggers | Fires `INSERT` triggers, plus `UPDATE` triggers if a conflict happened |
-- | Columns not mentioned | Unchanged | Unchanged (only the `SET` columns change) |
-- | Auto-number | No effect | The sequence still moves forward even when the row is updated (gaps in ids are normal) |

-- ------------------------------------------------------------
-- 5. Q. MySQL REPLACE vs ON DUPLICATE KEY UPDATE vs PostgreSQL ON CONFLICT
-- ------------------------------------------------------------

-- | | MySQL `REPLACE INTO` | MySQL `ON DUPLICATE KEY UPDATE` | PostgreSQL `ON CONFLICT DO UPDATE` |
-- | :--- | :--- | :--- | :--- |
-- | On existing key | Delete old row + insert new | Update the row | Update the row |
-- | Columns not given | Lost (NULL/default) | Kept | Kept |
-- | Refer to new values | — | `VALUES(col)` / alias | `EXCLUDED.col` |
-- | Which key? | Any PK/unique | Any PK/unique | You name it: `ON CONFLICT (col)` or `ON CONSTRAINT name` |
-- | Skip duplicates | `INSERT IGNORE` | — | `ON CONFLICT DO NOTHING` |

-- * Practical SQL Code Demonstration (From Workbench Examples, PostgreSQL version):
-- =========================================================================
-- 1. INSERT ... ON CONFLICT DO UPDATE  (MySQL: ON DUPLICATE KEY UPDATE)
-- If data is already present with PRIMARY KEY or UNIQUE KEY, modify existing data.
-- If record is not present, insert new record.
-- It does NOT delete any record.
-- =========================================================================
INSERT INTO customers
VALUES (8, 'DEF', 'IND', 800)
ON CONFLICT (id) DO UPDATE SET first_name = 'SHINDE';

-- =========================================================================
-- 2. Full replace of all columns (closest to MySQL REPLACE INTO)
-- =========================================================================
INSERT INTO customers
VALUES (6, 'SHINDE...', 'UK', 890)
ON CONFLICT (id) DO UPDATE
SET first_name = EXCLUDED.first_name,
    country    = EXCLUDED.country,
    score      = EXCLUDED.score;

-- * Standard Example for User Profiles:
-- Updating an existing user without wiping their profile data:
INSERT INTO users (id, name, email)
VALUES (1, 'Alicia', 'alicia@example.com')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name;

-- ------------------------------------------------------------
-- 6. `MERGE` (PostgreSQL 15+, SQL standard)
-- ------------------------------------------------------------

-- * `MERGE` compares a source (table or query) with a target table and decides, row by row, to insert, update or delete:
MERGE INTO customers AS t
USING customers_staging AS s
    ON t.id = s.id
WHEN MATCHED AND s.is_deleted THEN
    DELETE
WHEN MATCHED THEN
    UPDATE SET first_name = s.first_name, score = s.score
WHEN NOT MATCHED THEN
    INSERT (id, first_name, country, score)
    VALUES (s.id, s.first_name, s.country, s.score);

-- * `ON CONFLICT` vs `MERGE`: `ON CONFLICT` is best for one-row upserts from an app (safe under concurrency). `MERGE` is best for syncing a whole staging table (ETL).

-- ---

-- ------------------------------------------------------------
-- 11.9 Comparison: ALTER Command vs UPDATE Command
-- ------------------------------------------------------------

-- | Feature / Dimension | `ALTER` Command | `UPDATE` Command |
-- | :--- | :--- | :--- |
-- | 1. Command Category | DDL (Data Definition Language) | DML (Data Manipulation Language) |
-- | 2. Target of Operation | Works on Table Structure / Blueprint | Works on Data Values / Rows |
-- | 3. Core Action | Adds, deletes, or changes columns, constraints, data types | Modifies contents of existing rows |
-- | 4. Default Initialization | New columns are `NULL` (or the default) for all existing rows | Sets specific cell values according to `SET` clause |
-- | 5. Transaction Control | Can be rolled back in PostgreSQL (inside `BEGIN`); implicit commit in MySQL | Can be rolled back before commit |
-- | 6. Summary Purpose | Alters the definition of the database object | Modifies the actual data inside the table |

-- ---

-- ------------------------------------------------------------
-- 11.10 Visual Diagrams & Architectural Explanations
-- ------------------------------------------------------------

-- ------------------------------------------------------------
-- Diagram 1: DML Operations Overview (INSERT, UPDATE, DELETE, REPLACE)
-- ------------------------------------------------------------

-- * Explanation:

--   * Illustrates how DML commands work directly on table rows.

--   * Demonstrates the transaction safety net (`COMMIT` vs `ROLLBACK`). In PostgreSQL, read the `REPLACE` card as `INSERT ... ON CONFLICT`.

-- ---

-- ------------------------------------------------------------
-- Diagram 2: Soft Delete vs Hard Delete Architecture
-- ------------------------------------------------------------

-- * Explanation:

--   * Compares physical record removal (Hard Delete) against flag columns like `is_deleted` or timestamps (Soft Delete). In PostgreSQL use `BOOLEAN` and `TIMESTAMPTZ` for these flags.

--   * Outlines recovery, storage, performance, and compliance implications.

-- ---

-- ------------------------------------------------------------
-- Diagram 3: Foreign Key Referential Actions (CASCADE, RESTRICT, SET NULL)
-- ------------------------------------------------------------

-- * Explanation:

--   * Visualizes Parent table (`department`) and Child table (`employee`) relationships.

--   * Shows how `CASCADE` propagates changes automatically, `RESTRICT` / `NO ACTION` blocks destructive operations, and `SET NULL` disconnects the child while keeping it.

-- ---

-- ------------------------------------------------------------
-- Diagram 4: Two Methods of INSERT Operations (Manual Values vs. INSERT Using SELECT)
-- ------------------------------------------------------------

-- * Explanation:

--   * Contrasts manual row insertion using `INSERT INTO ... VALUES` with bulk insertion via `INSERT INTO ... SELECT`.

--   * Shows how the result of a source table query goes straight into the target table. For files, PostgreSQL uses `COPY` / `\copy`.

-- ---

-- ------------------------------------------------------------
-- Diagram 5: Foreign Key Referential Actions Summary Decision Matrix
-- ------------------------------------------------------------

-- * Explanation:

--   * 6-card decision matrix for `CASCADE`, `RESTRICT`, `SET NULL`, `NO ACTION`, and `SET DEFAULT`.

--   * The diagram says InnoDB rejects `SET DEFAULT` — that is MySQL only. In PostgreSQL `SET DEFAULT` works, and the default action is `NO ACTION`.

-- ---

-- ------------------------------------------------------------
-- Diagram 6: REPLACE INTO vs. INSERT ... ON DUPLICATE KEY UPDATE (MySQL) → ON CONFLICT (PostgreSQL)
-- ------------------------------------------------------------

-- * Explanation:

--   * Shows the two MySQL conflict paths.

--   * PostgreSQL has only the "update in place" path: `INSERT ... ON CONFLICT (key) DO UPDATE SET ...`, plus `DO NOTHING` to skip.

-- ---

--       * `INSERT INTO table (cols) VALUES (...) RETURNING id;`

--       * `UPDATE table SET col = val WHERE condition;`

-- * Safe Updates:

-- * Upsert (PostgreSQL):

-- ---

-- ======================================================================
-- 🎯 Practice Questions (salesdb sample data) — try first, then look at the answer
-- ======================================================================
-- Run 00-Setup-Sample-Data.sql once before this section.

SET search_path TO sales;

-- Q1. INSERT a new customer, then remove it.
INSERT INTO customers (customerid, firstname, lastname, country, score) VALUES (6, 'Ravi', 'Patil', 'India', 600);
SELECT * FROM customers WHERE customerid = 6;
DELETE FROM customers WHERE customerid = 6;

-- Q2. UPDATE safely: first SELECT the rows, then update inside a transaction and roll back.
SELECT * FROM customers WHERE score IS NULL;
BEGIN;
UPDATE customers SET score = 0 WHERE score IS NULL RETURNING *;
ROLLBACK;

-- Q3. INSERT ... SELECT: copy German customers into a new table.
CREATE TABLE german_customers AS SELECT * FROM customers WHERE 1 = 0;
INSERT INTO german_customers SELECT * FROM customers WHERE country = 'Germany';
SELECT * FROM german_customers;
DROP TABLE german_customers;
