-- ======================================================================
-- Topic 11: DML (Data Manipulation Language) In-Depth
-- ======================================================================

-- ------------------------------------------------------------
-- 📖 In Simple Words
-- ------------------------------------------------------------

-- * Definition: DML (Data Manipulation Language) commands change the data inside tables: INSERT adds rows, UPDATE changes rows, DELETE removes rows.

-- * Real-life example: If DDL builds the cupboard, DML puts things in, changes them and takes them out.

-- * 🧩 Syntax:
--     INSERT INTO table_name (col1, col2) VALUES (v1, v2), (v3, v4);
--     INSERT INTO table_name (col1, col2) SELECT c1, c2 FROM other_table WHERE ...;
--     UPDATE table_name SET col1 = value1, col2 = value2 WHERE condition;
--     DELETE FROM table_name WHERE condition;

-- * Syntax explained (each part):
--   - INSERT INTO … VALUES → add new rows; column list and value list must match in order
--   - INSERT … SELECT → add rows copied from a query
--   - UPDATE … SET … WHERE → change rows; without WHERE every row changes
--   - DELETE FROM … WHERE → remove rows; without WHERE every row is deleted

-- * Example on salesdb (run 00-Setup-Sample-Data.sql first):
USE salesdb;
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

-- * *Definition: DML (Data Manipulation Language) commands work on the data (rows) inside tables — adding, changing and deleting rows.*

--   * Operates on Records (Rows): DML works strictly on the rows (records) stored in tables, not on the table structure (schema blueprint).

--   * Transaction Safety (Controlled with Transactions): Unlike DDL (which performs implicit commits in MySQL), DML operations can be controlled using **`COMMIT`** (to permanently save changes) and **`ROLLBACK`** (to undo/revert changes if an error occurs).

-- * Classification of Primary DML Commands:

--   1. **`INSERT`:** Adds new data (rows/records) into a table.

--   2. **`UPDATE`:** Updates or modifies existing data inside a table.

--   3. **`DELETE`:** Removes data records from a table.

--   4. **`REPLACE` (MySQL-specific):** Replaces a row by deleting the existing row if a duplicate key exists and inserting a new row.

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
    (value21, value22, value23, ...);

-- ------------------------------------------------------------
-- 2. Critical Rules & Best Practices for INSERT
-- ------------------------------------------------------------

-- * Match Number of Columns and Values: The number of values in the `VALUES` clause must match the number of specified columns.

-- * Column and Value Order: At the time of insert, ensure that values appear in the exact same order as the listed columns.

-- * Matching Data Types & Constraints: Inserted values must be compatible with the column's defined data type and satisfy all constraints (Primary Key uniqueness, Foreign Key existence, Not Null rules).

-- * Optional Column Names:

--   * Specifying column names is optional. If no columns are specified, SQL expects values for all columns in the exact sequence defined in the table schema.

--   * Tip: Always list column names explicitly for clarity, maintainability, and to avoid bugs when table structure evolves.

-- * Handling Unspecified Columns: Any column omitted from the column list automatically becomes `NULL`, unless a `DEFAULT` value or an `AUTO_INCREMENT` constraint is defined on that column.

-- ------------------------------------------------------------
-- 3. Standard INSERT Examples
-- ------------------------------------------------------------
-- Explicit Column Insertion (Best Practice):
INSERT INTO Students (id, name, age)
VALUES (1, 'Vishal', 21);

-- Multi-Row Insertion in a Single Query:
INSERT INTO Students (id, name, age)
VALUES
    (2, 'Amit', 22),
    (3, 'Neha', 20),
    (4, 'Pooja', 23);

-- Omitting Column List (Must provide values for all table columns in order):
INSERT INTO Students
VALUES (5, 'Rahul', 24);

--   * **Method ①: Manual Entry (`VALUES` Clause):**

--     * User / Developer Input: The developer specifies literal values manually from their workstation or application code using:
INSERT INTO Students (id, name, age) VALUES (1, 'Vishal', 21);

--     * Execution Flow: MySQL receives the `INSERT ... VALUES` statement, checks the rules (constraints) and saves the new row(s) into the Target Table.

--   * **Method ②: INSERT Using `SELECT` (Automated Query-Driven Ingestion):**

--     * Source Table Query: An inner query (`SELECT col1, col2 FROM source_table WHERE ...`) reads rows from an existing Source Table.

--     * Execution Flow: Those rows go straight into the Target Table using `INSERT INTO target_table SELECT ...` — no need to type the values by hand.

-- ------------------------------------------------------------
-- 4. How to Insert Data from One Table to Another (Source to Target Table)
-- ------------------------------------------------------------

-- * Interview Questions:

--   * Q. How to insert data from one table to another table (from source table to target table)?

--   * **Q. Write the SQL query to get data from the source table and insert into the target table (e.g., how to copy data from `customers` to `customers2` / `orders`)?**

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

-- ---

-- ------------------------------------------------------------
-- 11.3 The UPDATE Command & Best Practices
-- ------------------------------------------------------------

-- * Definition: The UPDATE command changes values in existing rows. It does not change the table structure.

-- * Use of UPDATE & SET: `UPDATE` specifies the target table to be modified, while `SET` specifies the column name(s) and assigns their new values.

--   * 1. Row-Level / Cell-Level Data Modification:

--     * `ALTER TABLE` (DDL) changes the table's structure, but `UPDATE` only changes the data inside rows — column names, data types and constraints stay the same.

--   * **2. Granular Filtering via `WHERE` Clause:**

--     * You can update one row, a few rows or all rows using `WHERE`. If you forget the `WHERE` clause, every row in the table is updated.

--   * 3. Dynamic Computations, Expressions & Subqueries:

--     * You can set a fixed value (e.g., `SET status = 'Active'`), calculate from the current value (e.g., `SET salary = salary * 1.10`, `SET score = score + 50`), or even use a subquery.

--   * **4. Transactional Safety (`COMMIT` & `ROLLBACK`):**

--     * In InnoDB, you can run `UPDATE` inside a transaction, check the result, and use `ROLLBACK` if it was a mistake.

--   * 5. Constraint & Index Integrity:

--     * Every update is checked against the constraints (`PRIMARY KEY`, `FOREIGN KEY`, `UNIQUE`, `CHECK`, `NOT NULL`). If any rule is broken, the whole statement fails. Indexes are updated automatically.

-- ------------------------------------------------------------
-- 1. Syntax for UPDATE
-- ------------------------------------------------------------
UPDATE table_name
SET
    column1 = value1,
    column2 = value2,
    ...
WHERE condition;

-- ------------------------------------------------------------
-- 2. Features & Clauses Supported by UPDATE
-- ------------------------------------------------------------

-- * Single or Multiple Columns: You can update one column or multiple columns simultaneously in a single statement.

-- * Combine with Advanced Clauses: `UPDATE` can be combined with `WHERE`, `LIKE`, `IN`, `JOIN`, `ORDER BY`, and `LIMIT`.

-- ------------------------------------------------------------
-- 3. Practical Examples
-- ------------------------------------------------------------

-- Q. How to update the customer's score where customer id is 4?
UPDATE CUSTOMERS
SET SCORE = 600
WHERE CUSTOMERID = 4;

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

-- Conditional update using JOIN (Cross-Table Update):
UPDATE employees e
JOIN departments d ON e.dept_id = d.dept_id
SET e.salary = e.salary * 1.15
WHERE d.dept_name = 'Research & Development';

-- Update with ORDER BY and LIMIT (Safe Batch / Top-N Updates in MySQL):
-- Increase scores for only the bottom 5 lowest-scoring customers in India:
UPDATE customers
SET score = score + 20
WHERE country = 'India'
ORDER BY score ASC
LIMIT 5;

-- ------------------------------------------------------------
-- 4. Critical Warnings & Best Practices
-- ------------------------------------------------------------
-- > ⚠️ CRITICAL WARNING:
-- > Always use a WHERE clause in an UPDATE statement!
-- > Without a `WHERE` clause, ALL rows in the table will be updated unconditionally.
-- >
-- > 💡 Industry Best Practice:
-- > Always verify your criteria first by running a `SELECT` query with the exact same `WHERE` clause before executing the `UPDATE`.
-- Step 1: Verify the rows to be modified:
SELECT * FROM customers WHERE customerid = 4;

-- Step 2: Once verified, execute the UPDATE:
UPDATE customers SET score = 600 WHERE customerid = 4;

-- ---

-- ------------------------------------------------------------
-- 11.4 The DELETE Command & Safe Execution
-- ------------------------------------------------------------

-- * Definition: DELETE removes some rows (or all rows) from a table. The table structure, columns, constraints and indexes stay the same.

-- * Role of DELETE FROM & WHERE: `DELETE FROM table_name` specifies the target table, while the `WHERE condition` identifies the exact records to be deleted. By default, standard SQL `DELETE` performs a hard delete (physical removal from the table).

--   * 1. Row-by-Row Removal (Record-Level Action):

--     * `DROP` removes the whole table and `TRUNCATE` empties it in one go, but `DELETE` (a DML command) removes rows one by one and logs each one, so it can be rolled back.

--   * **2. Granular Filtering with `WHERE` Clause:**

--     * Supports fine-grained row selection using conditions (`=`, `!=`, `<`, `>`, `LIKE`, `IN`, `BETWEEN`). If the `WHERE` clause is omitted, all records in the table will be deleted.

--   * 3. Transaction Safety & Rollback:

--     * In InnoDB, you can run `DELETE` inside a transaction (`START TRANSACTION`). If you delete something by mistake, run `ROLLBACK` before `COMMIT` to get the rows back.

--   * 4. Foreign Key & Referential Integrity Enforcement:

--     * Checks related child tables before deletion (`ON DELETE RESTRICT`, `CASCADE`, or `SET NULL`). If a child table holds dependent records and is protected by `RESTRICT`, the deletion will be rejected to prevent orphan records.

--   * 5. Trigger Activation:

--     * Fires `BEFORE DELETE` and `AFTER DELETE` database triggers on each affected row, which is essential for audit logging and archival workflows.

--   * 6. Auto-Increment Preservation:

--     * Unlike `TRUNCATE`, running `DELETE` (even without a `WHERE` clause) does not reset the `AUTO_INCREMENT` sequence counter in MySQL.

-- ------------------------------------------------------------
-- 1. Syntax for DELETE
-- ------------------------------------------------------------
DELETE FROM table_name
WHERE condition;

-- ------------------------------------------------------------
-- 2. Practical Examples
-- ------------------------------------------------------------
-- Delete customer records where country is India:
DELETE FROM customers
WHERE country = 'India';

-- Delete customer records where score is 999:
DELETE FROM CUSTOMERS
WHERE SCORE = 999;

-- ------------------------------------------------------------
-- 3. Critical Safety Rules
-- ------------------------------------------------------------

-- * **Avoid `DELETE` without a `WHERE` clause:** Executing `DELETE FROM table_name;` without a `WHERE` clause will wipe out all records in the table.

-- * **Verify with `SELECT` first:** Run `SELECT * FROM table_name WHERE condition;` prior to running the delete to inspect the exact rows that will be eliminated.

-- ---

-- ------------------------------------------------------------
-- 11.5 MySQL Safe Update Mode (`SQL_SAFE_UPDATES`)
-- ------------------------------------------------------------

-- * Definition: Safe update mode (SQL_SAFE_UPDATES) is a MySQL setting that blocks UPDATE and DELETE statements that could accidentally change the whole table.

--   * When safe mode is enabled, MySQL does not allow an `UPDATE` or `DELETE` statement unless:

--     1. The `WHERE` clause uses a key column (such as a Primary Key or an Indexed column).

--     2. OR the statement includes a **`LIMIT`** clause.

-- ------------------------------------------------------------
-- 1. Error Analysis: Why Non-Key Deletes Fail
-- ------------------------------------------------------------
-- If you run:
DELETE FROM customers WHERE SCORE = 999;
-- MySQL triggers an error:
-- ┌── (text — not SQL, shown for reference) ──
-- │ Error Code: 1175. You are using safe update mode and you tried to update a table without a WHERE that uses a KEY column.
-- │ To disable safe mode, toggle the option in Preferences -> SQL Editor and reconnect.
-- └──

-- * Why this happens: `SCORE` is not a Primary Key or indexed column, so MySQL blocks the command to protect you from deleting many rows by mistake.

-- ------------------------------------------------------------
-- 2. How to Handle Safe Mode (Two Approaches)
-- ------------------------------------------------------------

-- ------------------------------------------------------------
-- Approach A: Use a Key Column in WHERE or Add LIMIT (Best Practice)
-- ------------------------------------------------------------

-- * Example (Not Allowed in Safe Mode):
DELETE FROM employees;
-- Reason: This statement attempts to delete all rows because it lacks both a WHERE clause and a LIMIT clause.

-- * Example (Allowed in Safe Mode):
-- Allowed: Using the Primary Key / Indexed column:
DELETE FROM employees WHERE employee_id = 101;
DELETE FROM customers WHERE customer_id = 101;

-- Allowed: Using a LIMIT clause:
DELETE FROM employees LIMIT 1;
DELETE FROM customers WHERE score = 999 LIMIT 1;

-- ------------------------------------------------------------
-- Approach B: Temporarily Toggle Safe Mode for Current Session
-- ------------------------------------------------------------
-- If you genuinely need to perform a bulk delete/update on a non-key column:
-- Step 1: Temporarily disable safe mode in current session (0 = Disabled / OFF)
SET SQL_SAFE_UPDATES = 0;

-- Step 2: Execute your bulk query safely
DELETE FROM customers WHERE score = 999;
DELETE FROM customers WHERE score = 350;

-- Step 3: Immediately re-enable safe mode (1 = Enabled / ON)
SET SQL_SAFE_UPDATES = 1;

-- * Interview Answer Summary:
--   > "MySQL Safe Mode (`SQL_SAFE_UPDATES`) is a safety feature that prevents accidental mass `UPDATE` and `DELETE` operations. It requires a `WHERE` clause using a key column (such as a Primary Key or indexed column) or a `LIMIT` clause. This helps protect data from unintended modifications or deletions."

-- ---

-- ------------------------------------------------------------
-- 11.6 Soft Delete vs Hard Delete (In-Depth Comparison)
-- ------------------------------------------------------------

-- ------------------------------------------------------------
-- 1. Detailed 9-Point Comparison Matrix
-- ------------------------------------------------------------

-- | :--- | :--- | :--- |
-- | 1. Meaning | Data is permanently and physically removed from disk | Data is not physically removed; it is only marked as deleted using a status flag |
-- | 2. Data Recovery | Cannot be recovered unless a database backup is available | Easily restored by changing the status flag back to active |
-- | 3. How It Works | Removes the actual row records from the storage pages | Updates a flag or timestamp column to indicate deletion |
-- | 4. SQL Command | Executed using **`DELETE`** or **`TRUNCATE`** | Executed using **`UPDATE`** (`SET is_deleted = 1`) |
-- | 5. Storage Usage | Uses less storage because deleted records are cleared | Uses more storage because deleted records remain in the table indefinitely |
-- | 6. Query Performance | Generally faster; fewer records remain to scan and index | Queries may require filtering index checks (`WHERE is_deleted = 0`) |
-- | 7. Data History & Audit | Historical data is permanently lost | Maintains complete audit history and allows tracking of who deleted what and when |
-- | 8. Implementation | No extra table columns required | Requires additional columns like `is_deleted`, `deleted_at`, or `status` |
-- | 9. Common Use Cases | Temporary data, cache tables, compliance data removal (GDPR) | Banking, e-commerce orders, user accounts, audit-heavy enterprise apps |

-- ------------------------------------------------------------
-- 2. Practical Implementation of Soft Delete
-- ------------------------------------------------------------
-- Step 1: Add soft delete tracking columns to the table
ALTER TABLE customers
ADD COLUMN is_deleted TINYINT(1) DEFAULT 0,
ADD COLUMN deleted_at DATETIME NULL;

-- Step 2: Perform a "Soft Delete" (UPDATE instead of DELETE)
UPDATE customers
SET is_deleted = 1, deleted_at = NOW()
WHERE customer_id = 101;

-- Step 3: Query active records (Exclude soft-deleted rows)
SELECT * FROM customers
WHERE is_deleted = 0;

-- Step 4: Restore / Undelete a record
UPDATE customers
SET is_deleted = 0, deleted_at = NULL
WHERE customer_id = 101;

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

-- * Definition: A Referential Action instructs MySQL: "If a parent row is UPDATED or DELETED, what should automatically happen to the related child rows?"
-- This action is defined directly inside the Foreign Key constraint clause:
FOREIGN KEY (department_id)
REFERENCES department(department_id)
ON DELETE CASCADE
ON UPDATE CASCADE;

-- ------------------------------------------------------------
-- 3. The 5 Types of Referential Actions
-- ------------------------------------------------------------

-- 1. **`CASCADE`:** Automatically deletes or updates child rows when parent is deleted or updated.

-- 2. **`RESTRICT` (MySQL Default):** Prevents deletion or modification of a parent row if matching child rows exist.

-- 3. **`NO ACTION`:** Exactly the same as `RESTRICT` in MySQL. (Technically `NO ACTION` is the default keyword, but in MySQL both behave the same.)

-- 4. **`SET NULL`:** Sets child foreign key columns to `NULL` when parent row is deleted or updated (requires column to be nullable).

-- 5. **`SET DEFAULT`:** Sets child foreign key to its defined default value (*Note: MySQL's InnoDB engine does not support `SET DEFAULT` for foreign keys*).

-- ---

-- ------------------------------------------------------------
-- 4. Deep-Dive: `ON DELETE CASCADE`
-- ------------------------------------------------------------

-- * Definition: ON DELETE CASCADE is a referential action used with foreign key constraints. When a row in the parent table is deleted, MySQL automatically deletes all related rows from the child table.

-- * **What happens WITHOUT `ON DELETE CASCADE`?**

--   * If not specified, MySQL defaults to `RESTRICT`.

--   * Deleting the parent row will fail with `ERROR 1451 (23000): Cannot delete or update a parent row: a foreign key constraint fails`.

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

--   * Point 5 (Automatic Cascade Purge): Because `ON DELETE CASCADE` is active, MySQL automatically and immediately deletes Amit and Neha from `employee`. Querying `employee` confirms that no orphan records remain.

--   * Point 6 (Without Cascade Behavior): Without `ON DELETE CASCADE` (under default `RESTRICT`), deleting department 1 fails with `ERROR 1451 (23000)`. You are required to run a manual 2-step deletion (delete child rows first, then delete parent).

-- * What happens without Cascade? (Demonstration of Error 1451):
-- Suppose employee was created without ON DELETE CASCADE (Default RESTRICT):
DELETE FROM department WHERE department_id = 1;
-- Output: ERROR 1451 (23000): Cannot delete or update a parent row: a foreign key constraint fails

-- To delete under RESTRICT, you MUST manually delete child records first:
DELETE FROM employee WHERE department_id = 1;
DELETE FROM department WHERE department_id = 1;

-- * Interview Answer (ON DELETE CASCADE):

-- ---

-- ------------------------------------------------------------
-- 5. Deep-Dive: `ON UPDATE CASCADE`
-- ------------------------------------------------------------

-- * Definition: ON UPDATE CASCADE automatically updates the foreign key values in the child table whenever the referenced primary key in the parent table is updated.

-- * Purpose: Keeps parent and child records continuously synchronized.

-- * **What happens WITHOUT `ON UPDATE CASCADE`?**

--   * Changing a parent's primary key would fail under default `RESTRICT` because existing child rows would point to an invalid key. You would have to manually update child tables first.

-- * Complete Executable Demonstration:
-- Ensure tables are ready with ON UPDATE CASCADE:
-- (department and employee created above)

-- Temporarily disable safe mode if updating by name:
SET SQL_SAFE_UPDATES = 0;

-- Update Parent Primary Key (change HR department_id from 1 to 101):
UPDATE department
SET department_id = 101
WHERE department_name = 'HR';

SET SQL_SAFE_UPDATES = 1;

-- Verify Child Table:
-- Notice Amit and Neha's department_id is automatically updated to 101!
SELECT * FROM employee;

-- * Step-by-Step Point-Wise Breakdown of the ON UPDATE CASCADE Example:

--   * Point 1 (Parent Key Modification): Department `1` ('HR') needs to have its primary key changed from `1` to `101`.

--   * Point 2 (Automatic Key Synchronization): MySQL detects the parent primary key modification and automatically updates `employee.department_id` from `1` to `101` for both Amit and Neha.

--   * Point 3 (Verification & Data Integrity): Running `SELECT * FROM employee;` shows Amit and Neha now reference `department_id = 101`. No manual update on `employee` was required, and referential integrity remained unbroken.

--   * Point 4 (Without Update Cascade Behavior): Without `ON UPDATE CASCADE`, MySQL defaults to `RESTRICT` and aborts the primary key update with `ERROR 1451 (23000)`. You would be forced to manually update the child table foreign keys before modifying the parent primary key.

-- * Interview Questions & Answers (ON UPDATE CASCADE):

--   * Q. What is ON UPDATE CASCADE?

--     * Answer: ON UPDATE CASCADE is a referential action used in a foreign key constraint. When the primary key value in the parent table changes, MySQL automatically updates the corresponding foreign key values in the child table, maintaining referential integrity and keeping related data synchronized.

--   * Q. Why do we use ON UPDATE CASCADE?

--     * Answer: We use ON UPDATE CASCADE to avoid manually updating child table records whenever a parent table's primary key changes. It ensures data consistency and prevents broken relationships between parent and child tables.

-- ---

-- ------------------------------------------------------------
-- 6. Summary Matrix of Referential Actions
-- ------------------------------------------------------------

-- | Action Type | Behavior on Parent Deletion (`ON DELETE`) | Behavior on Parent Update (`ON UPDATE`) | Best Use Case |
-- | :--- | :--- | :--- | :--- |
-- | **`CASCADE`** | Automatically deletes all related child rows | Automatically updates related child foreign keys | Child data has no standalone meaning without parent (e.g., Order Items $\rightarrow$ Order) |
-- | **`RESTRICT` (DEFAULT)**| Blocks parent deletion if child records exist | Blocks parent primary key update if child records exist | Strong data protection required; prevents accidental loss |
-- | **`NO ACTION`** | Same as `RESTRICT` in MySQL (blocks deletion) | Same as `RESTRICT` in MySQL (blocks update) | Standard ANSI compliance |
-- | **`SET NULL`** | Sets child foreign key column to `NULL` (Child remains) | Sets child foreign key column to `NULL` | Child can exist independently (e.g., Employee retains job if Department is deleted) |
-- | **`SET DEFAULT`** | Sets child foreign key to default value | Sets child foreign key to default value | Rare in MySQL; NOT supported by InnoDB engine |

--   * **1. `ON DELETE CASCADE`:**

--     * Behavior: When a parent row is deleted, all related child rows are deleted automatically.

--     * Use Case: Used when child data has no meaning without the parent (e.g., deleting an `orders` record automatically purges all corresponding `order_items`).

--   * **2. `ON UPDATE CASCADE`:**

--     * Behavior: When the parent primary key is updated, the child foreign key values are updated automatically.

--     * Use Case: Used when parent key values may change over time and child records must remain continuously synchronized.

--   * **3. `ON DELETE SET NULL`:**

--     * Behavior: When the parent row is deleted, the child foreign key is set to `NULL` so the child record remains intact.

--     * Use Case: Used when a child entity can exist without a parent (e.g., an `employee` retains their record when a `department` is dissolved).

--     * Prerequisite: The child foreign key column **must allow `NULL` values** (must not be defined as `NOT NULL`).

--   * **4. `ON DELETE RESTRICT` (MySQL Default):**

--     * Behavior: Parent deletion is strictly blocked with `Error 1451` if any related child records exist.

--     * Use Case: Used when strong data protection is required to safeguard against unintended deletions. You must manually delete child rows first before deleting the parent record.

--   * **5. `ON DELETE NO ACTION`:**

--     * Behavior: Exactly the same as `RESTRICT` in MySQL InnoDB. Deletion is prevented if child rows exist.

--     * Use Case: Standard ANSI SQL compliance.

--   * **6. `ON DELETE SET DEFAULT` (Rare in MySQL):**

--     * Behavior: If the parent row is deleted, the child foreign key is set to its predefined default value.

--     * Critical Engine Note: MySQL's **InnoDB storage engine does NOT support `SET DEFAULT`** for foreign keys. If specified, it is rejected with a syntax error or treated as `RESTRICT`/`NO ACTION`.

-- ---

-- ------------------------------------------------------------
-- 11.8 The REPLACE Command in SQL (MySQL Specific)
-- ------------------------------------------------------------

-- ------------------------------------------------------------
-- 1. What is the REPLACE Command?
-- ------------------------------------------------------------

-- * Definition: REPLACE is a MySQL-only version of INSERT. If a row with the same key already exists, MySQL deletes that row and then inserts the new one.

-- * If a row already exists (with the exact same `PRIMARY KEY` or `UNIQUE KEY` value), MySQL first deletes the old row and then inserts the new row.

-- * If no duplicate key exists, it behaves exactly like a standard `INSERT` statement.

-- * Formula:
--   $$\text{REPLACE} = \text{DELETE (Old Row)} + \text{INSERT (New Row)}$$

-- ------------------------------------------------------------
-- 2. Crucial Requirements for REPLACE
-- ------------------------------------------------------------

-- * Requires Key: `REPLACE` works only if the table has a defined `PRIMARY KEY` or `UNIQUE INDEX`. Without keys, MySQL cannot detect conflicts and will always execute a normal insert.

-- ------------------------------------------------------------
-- 3. Practical Code Examples
-- ------------------------------------------------------------
-- Step 1: Normal Insert
INSERT INTO customers (id, first_name, country, score)
VALUES (6, 'Vishal', 'India', 999);

-- Step 2: REPLACE when duplicate key exists (id = 6 already exists):
-- Result: MySQL deletes old row (Vishal, India, 999) and inserts new row (Ram, India, 888)
REPLACE INTO customers (id, first_name, country, score)
VALUES (6, 'Ram', 'India', 888);

-- Step 3: REPLACE when key does not exist:
-- Result: Inserts as a new record
REPLACE INTO customers (id, first_name, country, score)
VALUES (7, 'Vishal', 'India', 999);

-- ------------------------------------------------------------
-- 4. Differences: UPDATE vs REPLACE INTO
-- ------------------------------------------------------------

-- | Dimension | `UPDATE` | `REPLACE INTO` |
-- | :--- | :--- | :--- |
-- | Operation Type | Modifies existing row in-place | Deletes old row, then Inserts new row |
-- | Key Conflict | Requires key to locate; does not delete | If key exists, deletes old record first |
-- | Non-Existing Key | Returns 0 rows affected (does not insert) | Inserts as a brand new row |
-- | Trigger Execution | Fires `UPDATE` triggers only | Fires **both `DELETE` and `INSERT` triggers** |
-- | Performance | Faster (in-place modification) | Slightly slower (two-step delete + insert cycle) |
-- | AUTO_INCREMENT | Does not affect auto_increment | May cause auto-increment counter to advance |

-- ------------------------------------------------------------
-- 5. Q. What is the difference between REPLACE and INSERT ... ON DUPLICATE KEY UPDATE?
-- ------------------------------------------------------------

--   * **`ON DUPLICATE KEY UPDATE`:**

--     * When Key Exists: If data is already present with a `PRIMARY KEY` or `UNIQUE KEY`, it modifies the existing record in-place.

--     * When Key Does Not Exist: If the record is not present, it inserts a brand new record.

--     * No Deletion: It does NOT delete any record like `REPLACE INTO`.

--     * Column Preservation: Preserves all other existing column values that are not specified in the `UPDATE` clause.

--   * **`REPLACE INTO`:**

--     * When Key Exists: If the record is already present with a `PRIMARY KEY` or `UNIQUE KEY`, first the old record is physically DELETED, and then a new record is INSERTED into the table.

--     * Column Reset Warning: Any column omitted from the `REPLACE INTO` statement will lose its existing value and revert to `NULL` or its column default!

-- * Practical SQL Code Demonstration (From Workbench Examples):
-- =========================================================================
-- 1. INSERT ... ON DUPLICATE KEY UPDATE
-- If data is already present with PRIMARY KEY or UNIQUE KEY, modify existing data.
-- If record is not present, insert new record.
-- It does NOT delete any record like REPLACE INTO.
-- It modifies the record if already present; otherwise creates a new record.
-- =========================================================================
INSERT INTO CUSTOMERS
VALUES (8, 'DEF', 'IND', 800)
ON DUPLICATE KEY UPDATE FIRST_NAME = 'SHINDE';

-- =========================================================================
-- 2. REPLACE INTO
-- If the record is present with PRIMARY KEY,
-- first the existing record is DELETED, and then a new record is INSERTED.
-- =========================================================================
REPLACE INTO CUSTOMERS
VALUES (6, 'SHINDE...', 'UK', 890);

-- * Standard Example for User Profiles:
-- Updating an existing user without wiping their profile data:
INSERT INTO users (id, name, email)
VALUES (1, 'Alicia', 'alicia@example.com')
ON DUPLICATE KEY UPDATE name = 'Alicia';

-- ---

-- ------------------------------------------------------------
-- 11.9 Comparison: ALTER Command vs UPDATE Command
-- ------------------------------------------------------------

-- | Feature / Dimension | `ALTER` Command | `UPDATE` Command |
-- | :--- | :--- | :--- |
-- | 1. Command Category | DDL (Data Definition Language) | DML (Data Manipulation Language) |
-- | 2. Target of Operation | Works on Table Structure / Blueprint | Works on Data Values / Rows |
-- | 3. Core Action | Adds, deletes, or changes columns, constraints, data types | Modifies contents of existing rows |
-- | 4. Default Initialization | Initializes new columns for all existing rows as `NULL` (or default) | Sets specific fixed cell values according to `SET` clause |
-- | 5. Transaction Control | Implicit Commit (Cannot rollback in MySQL) | Transaction Controlled (Can rollback before commit) |
-- | 6. Summary Purpose | Alters the definition of the database object | Modifies the actual data inside the table |

-- ---

-- ------------------------------------------------------------
-- 11.10 Visual Diagrams & Architectural Explanations
-- ------------------------------------------------------------

-- ------------------------------------------------------------
-- Diagram 1: DML Operations Overview (INSERT, UPDATE, DELETE, REPLACE)
-- ------------------------------------------------------------

-- * Explanation:

--   * Illustrates how DML commands interact directly with table rows inside the storage engine.

--   * Demonstrates the transaction safety net (`COMMIT` vs `ROLLBACK`) available exclusively to DML operations.

-- ---

-- ------------------------------------------------------------
-- Diagram 2: Soft Delete vs Hard Delete Architecture
-- ------------------------------------------------------------

-- * Explanation:

--   * Compares physical record wiping from disk pages (Hard Delete) against state updates using logical flag columns like `is_deleted` or timestamps (Soft Delete).

--   * Outlines recovery, storage, performance, and compliance implications.

-- ---

-- ------------------------------------------------------------
-- Diagram 3: Foreign Key Referential Actions (CASCADE, RESTRICT, SET NULL)
-- ------------------------------------------------------------

-- * Explanation:

--   * Visualizes Parent table (`department`) and Child table (`employee`) relationships.

--   * Shows how `CASCADE` propagates changes automatically, `RESTRICT` blocks destructive operations to protect integrity, and `SET NULL` disassociates relationships while preserving child entities.

-- ---

-- ------------------------------------------------------------
-- Diagram 4: Two Methods of INSERT Operations (Manual Values vs. INSERT Using SELECT)
-- ------------------------------------------------------------

-- * Explanation:

--   * Contrasts manual interactive row insertion using explicit literal values via `INSERT INTO ... VALUES` with automated, bulk query ingestion via `INSERT INTO ... SELECT`.

--   * Details how the intermediate result set from a source table query is directly transformed and populated into the destination target table.

-- ---

-- ------------------------------------------------------------
-- Diagram 5: Foreign Key Referential Actions Summary Decision Matrix
-- ------------------------------------------------------------

-- * Explanation:

--   * Comprehensive 6-card visual decision matrix outlining behavioral differences and use cases for `CASCADE`, `RESTRICT`, `SET NULL`, `NO ACTION`, and `SET DEFAULT`.

--   * Highlights why InnoDB rejects `SET DEFAULT` and how default `RESTRICT` guards against unintended cascading data purges.

-- ---

-- ------------------------------------------------------------
-- Diagram 6: REPLACE INTO vs. INSERT ... ON DUPLICATE KEY UPDATE
-- ------------------------------------------------------------

-- * Explanation:

--   * Visualizes the two distinct conflict-resolution pathways in MySQL.

--   * Shows how `REPLACE` physically drops and reinserts entire rows versus how `ON DUPLICATE KEY UPDATE` mutates target cells in-place while keeping existing row data intact.

-- ---

--       * `INSERT INTO table (cols) VALUES (...);`

--       * `UPDATE table SET col = val WHERE condition;`

--       * `DELETE FROM table WHERE condition;`

-- * **MySQL Safe Update Mode (`SQL_SAFE_UPDATES`):**

-- ---

-- ======================================================================
-- 🎯 Practice Questions (salesdb sample data) — try first, then look at the answer
-- ======================================================================
-- Run 00-Setup-Sample-Data.sql once before this section.

USE salesdb;

-- Q1. INSERT a new customer, then remove it.
INSERT INTO customers (customerid, firstname, lastname, country, score) VALUES (6, 'Ravi', 'Patil', 'India', 600);
SELECT * FROM customers WHERE customerid = 6;
DELETE FROM customers WHERE customerid = 6;

-- Q2. UPDATE safely: first SELECT the rows, then update inside a transaction and roll back.
SELECT * FROM customers WHERE score IS NULL;
START TRANSACTION;
UPDATE customers SET score = 0 WHERE score IS NULL;
SELECT * FROM customers;
ROLLBACK;

-- Q3. INSERT ... SELECT: copy German customers into a new table.
CREATE TABLE german_customers AS SELECT * FROM customers WHERE 1 = 0;
INSERT INTO german_customers SELECT * FROM customers WHERE country = 'Germany';
SELECT * FROM german_customers;
DROP TABLE german_customers;
