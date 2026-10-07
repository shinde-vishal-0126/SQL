-- ======================================================================
-- Topic 51: Database Import & Export (CSV, SQL Dumps)
-- ======================================================================

-- ------------------------------------------------------------
-- 📖 In Simple Words
-- ------------------------------------------------------------

-- * Definition: Import and export move data between the database and files: CSV for tables, SQL dump files (mysqldump / pg_dump) for full backups.

-- * Real-life example: Exporting your phone contacts to a file and importing them on a new phone.

-- * Example on salesdb (run 00-Setup-Sample-Data.sql first):
USE salesdb;
-- Export (MySQL folder allowed by secure_file_priv):
-- SELECT * FROM customers INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/customers.csv'
--   FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n';
-- Full backup from the terminal:
-- mysqldump -u root -p salesdb > salesdb_backup.sql
SHOW VARIABLES LIKE 'secure_file_priv';

-- * Example explained (step by step):
--   1. The commented lines are the real export / backup commands (they write files, so run them on purpose).
--   2. CSV export writes one line per customer with values separated by commas.
--   3. A dump file contains CREATE TABLE + INSERT statements that rebuild salesdb anywhere.

-- ------------------------------------------------------------
-- 51.1 Working with CSV Files
-- ------------------------------------------------------------

-- * CSV: Stands for Comma Separated Value.

-- * Rule of CSV Imports: The table schema must exactly match the CSV file. Columns in the table must correspond (in number, order, and data type) to the values in the CSV. (e.g., If CSV has `id, name, salary`, the table must have the exact same structure).

--   * Tip: This is the default behaviour. `LOAD DATA` also lets you list the target columns at the end, e.g. `... IGNORE 1 ROWS (id, name, @skip, salary);`, to change the order or skip a CSV column (`@skip` is a throw-away variable).

-- ------------------------------------------------------------
-- CSV Format Rules
-- ------------------------------------------------------------

-- 1. Delimiter: Usually a comma (`,`), but it could be `;` or `\t` (Tab). You must specify it.

-- 2. Quotes: Text values may be enclosed in double-quotes `"`.

-- 3. Header Row: If the file has column headers at the top, you must use `IGNORE 1 ROWS` during the import.

-- 4. Line Endings: Should match the operating system (`\n` for Linux/Mac, `\r\n` for Windows).

-- ------------------------------------------------------------
-- File Location Rules & Privileges
-- ------------------------------------------------------------

-- * **Server Machine (`LOAD DATA INFILE`):** If you omit the word `LOCAL`, MySQL expects the file to be on the server. The file must be placed in a directory allowed by the MySQL variable `secure_file_priv`. You also need the `FILE` privilege (`GRANT FILE ON *.* TO 'username'@'localhost';`).

-- * **Local Machine (`LOAD DATA LOCAL INFILE`):** If the file is on your personal client machine (your laptop), you use `LOCAL`. 

--   * ⚠️ Note: In MySQL 8, `LOCAL` is disabled by default. Enable it on the server (`SET GLOBAL local_infile = 1;`) and on the client (connect with `mysql --local-infile=1`, or in Workbench add `OPT_LOCAL_INFILE=1` to the connection's Advanced options). Otherwise you get error 3948 / 2068.

-- * Handling NULL & Constraints: Empty fields in CSV may become `NULL` if allowed. If the table has a Primary Key or Unique constraint, duplicates in the CSV will cause errors (unless the `IGNORE` keyword is used in the query).

-- ------------------------------------------------------------
-- 51.2 Importing Data into MySQL
-- Method 1: Using `LOAD DATA INFILE` (Fastest Way)
-- ------------------------------------------------------------
-- MySQL has a built-in command to directly import CSV into a table extremely fast.

-- * Scenario: You have a file `employees.csv` (`id, name, salary, dept_id`).
CREATE TABLE employees (
  id INT,
  name VARCHAR(100),
  salary DECIMAL(10,2),
  dept_id INT
);

-- Importing the file
LOAD DATA INFILE '/path/to/employees.csv'
INTO TABLE employees
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- * Explanation:

--   * `FIELDS TERMINATED BY ','` $\rightarrow$ The CSV delimiter.

--   * `ENCLOSED BY '"'` $\rightarrow$ Handles text values wrapped in quotes.

--   * `IGNORE 1 ROWS` $\rightarrow$ Skips the header row in the CSV file.

--   * *(If the file is on your local machine, change it to `LOAD DATA LOCAL INFILE 'C:/path/employees.csv'`)*.

-- ------------------------------------------------------------
-- Method 2: Using `mysqlimport` Command-Line Tool
-- ------------------------------------------------------------
-- You can run this directly from your terminal (CMD/Bash) without logging into the MySQL shell.
-- ┌── (bash — not SQL, shown for reference) ──
-- │ mysqlimport --local -u root -p --fields-terminated-by=',' --lines-terminated-by='\n' --ignore-lines=1 my_database employees.csv
-- └──

-- * `--local` $\rightarrow$ File is on the client machine.

-- * `my_database` $\rightarrow$ The target database name.

-- * `employees.csv` $\rightarrow$ Important: The filename must exactly match the table name (i.e., `employees` table).

-- ------------------------------------------------------------
-- Method 3: Using GUI Tools (MySQL Workbench / phpMyAdmin)
-- ------------------------------------------------------------

-- * Workbench: Right-click table $\rightarrow$ `Table Data Import Wizard` $\rightarrow$ Select CSV file $\rightarrow$ Map columns $\rightarrow$ Finish.

-- ------------------------------------------------------------
-- 51.3 Exporting Data from MySQL
-- 1. Export Query Results to CSV (`INTO OUTFILE`)
-- ------------------------------------------------------------
SELECT id, name, salary
FROM employees
INTO OUTFILE '/var/lib/mysql-files/employees.csv'
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n';

-- * Note: This creates the `employees.csv` file on the server. You require write access to that directory and the `FILE` privilege in MySQL.

-- ------------------------------------------------------------
-- 2. Export via GUI (MySQL Workbench)
-- ------------------------------------------------------------

-- * Right-click a table $\rightarrow$ `Table Data Export Wizard` $\rightarrow$ Choose CSV, JSON, or SQL format.

-- ------------------------------------------------------------
-- 51.4 Database Backups & Dumps (`mysqldump`)
-- ------------------------------------------------------------
-- `mysqldump` is a powerful command-line tool provided by MySQL to create a full backup (SQL Dump) of your schema and data.

-- * Export Full Database: 
-- ┌── (bash — not SQL, shown for reference) ──
-- │ mysqldump -u root -p mydb > mydb.sql
-- └──
--   *(Creates a `.sql` file with schema + data. `>` redirects output into the file).*

-- * Export Single Table:
-- ┌── (bash — not SQL, shown for reference) ──
-- │ mysqldump -u root -p mydb employees > employees.sql
-- └──

-- * Export Only Schema (Without Data):
-- ┌── (bash — not SQL, shown for reference) ──
-- │ mysqldump -u root -p --no-data mydb > schema.sql
-- └──

-- * Export Only Data (No Table Structure):
-- ┌── (bash — not SQL, shown for reference) ──
-- │ mysqldump -u root -p --no-create-info mydb > data.sql
-- └──

-- * **Export with Conditions (`WHERE` clause):**
-- ┌── (bash — not SQL, shown for reference) ──
-- │ mysqldump -u root -p mydb employees --where="salary > 5000" > high_salary.sql
-- └──

-- ------------------------------------------------------------
-- How to Import a Dump file back to MySQL:
-- ------------------------------------------------------------
-- ┌── (bash — not SQL, shown for reference) ──
-- │ mysql -u root -p mydb < mydb.sql
-- └──
-- *(This executes all the `CREATE TABLE` and `INSERT` statements inside the `.sql` file, restoring your database completely).*

-- ------------------------------------------------------------
-- 51.5 Exporting/Importing Other File Types (XML & JSON)
-- ------------------------------------------------------------

-- ------------------------------------------------------------
-- 1. XML Files
-- ------------------------------------------------------------
-- MySQL natively supports XML exports and imports.

-- * Exporting to XML:
-- ┌── (bash — not SQL, shown for reference) ──
-- │ mysql -u root -p --xml -e "SELECT * FROM mydb.employees" > employees.xml
-- └──

-- * **Importing XML (`LOAD XML INFILE`):**
LOAD XML INFILE '/path/to/employees.xml'
INTO TABLE employees
ROWS IDENTIFIED BY '<row>';

-- ------------------------------------------------------------
-- 2. JSON Files
-- ------------------------------------------------------------

-- * Exporting to JSON (MySQL 8.0+):
--   You can use MySQL Workbench GUI (Export to JSON) or write a query using JSON functions:
SELECT JSON_ARRAYAGG(JSON_OBJECT('id', id, 'name', name, 'salary', salary)) 
FROM employees 
INTO OUTFILE '/path/to/employees.json';

-- * Importing JSON:
--   MySQL doesn't have a direct `LOAD JSON INFILE` command. Instead, you read it using `LOAD DATA` into a single text column and parse it using `JSON_TABLE()`. For bulk JSON imports, GUI Tools (MySQL Workbench) or scripts (Python/Node.js) are highly recommended over raw SQL.

-- ------------------------------------------------------------
-- 51.6 Advanced `mysqldump` (Routines, Triggers, Events)
-- ------------------------------------------------------------
-- By default, `mysqldump` exports tables and data. If you have Stored Procedures, Functions, Triggers, or Scheduled Events, you MUST include specific flags; otherwise, they will be left behind in the backup!

-- * Export everything including Routines, Triggers, and Events:
-- ┌── (bash — not SQL, shown for reference) ──
-- │ mysqldump -u root -p --routines --triggers --events mydb > full_backup.sql
-- └──
--   *(Note: `--routines` exports Procedures & Functions. `--triggers` is usually on by default, but it's good practice to specify it).*

-- ------------------------------------------------------------
-- 51.7 Performance Tip: Importing HUGE SQL Files
-- ------------------------------------------------------------
-- When you import a massive `.sql` dump (e.g., 50GB file), running `mysql < dump.sql` can take hours. To drastically speed it up, log into MySQL and temporarily disable constraint checks:

SET autocommit=0;
SET unique_checks=0;
SET foreign_key_checks=0;

-- In the MySQL command line, use the 'source' command (Faster than < in terminal)
SOURCE C:/path/to/huge_backup.sql;

-- After import completes, turn them back on and commit
COMMIT;
SET autocommit=1;
SET unique_checks=1;
SET foreign_key_checks=1;
-- (This prevents MySQL from verifying constraints and writing transaction logs for every single row inserted, making bulk imports extremely fast).

-- ------------------------------------------------------------
-- 51.8 Backup Strategy & Replication
-- ------------------------------------------------------------

-- * Types of backup:

--   * Logical backup – SQL statements (`mysqldump`, `mysqlpump`, MySQL Shell `util.dumpInstance`). Portable and readable, but slow to restore for big databases.

--   * Physical backup – copies of the data files (Percona XtraBackup, MySQL Enterprise Backup). Fast for large databases.

--   * Full vs incremental – full = everything; incremental = only changes since the last backup (binary logs or XtraBackup incremental).

--   * Point-in-time recovery (PITR) – restore the last full backup, then replay the binary logs up to the moment before the mistake: `mysqlbinlog --stop-datetime="2025-10-01 10:59:00" binlog.000123 | mysql -u root -p`.

--   * For a consistent InnoDB dump without locking tables: `mysqldump --single-transaction --routines --triggers --events mydb > mydb.sql`.

-- * Replication: one server (source / primary) writes changes to its binary log; one or more replicas copy and replay them.

--   * Uses: read scaling (send reports to replicas), high availability (promote a replica if the source fails), backups taken from a replica.

--   * Asynchronous (default): the source doesn't wait for replicas — fast, but a crash can lose the last transactions. Semi-synchronous: the source waits until at least one replica has received the change.

--   * Replication lag: replicas can be behind; reading your own write from a replica may show old data. Check with `SHOW REPLICA STATUS\G` (`Seconds_Behind_Source`).

--   * Group Replication / InnoDB Cluster: several servers with automatic failover.

-- * Rule of thumb: replication is not a backup — a `DROP TABLE` is replicated to every replica too. Keep real backups and test restoring them.

-- ---

-- ======================================================================
-- 🎯 Practice Questions (salesdb sample data) — try first, then look at the answer
-- ======================================================================
-- Run 00-Setup-Sample-Data.sql once before this section.

USE salesdb;

-- Q1. Export query result to CSV (path must be allowed by secure_file_priv).
SHOW VARIABLES LIKE 'secure_file_priv';
-- SELECT * FROM customers
-- INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/customers.csv'
-- FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n';

-- Q2. Import the course CSV into a new table.
CREATE TABLE customers_csv LIKE customers;
-- LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Customers.csv'
-- INTO TABLE customers_csv FIELDS TERMINATED BY ',' IGNORE 1 LINES;
-- (Workbench: right-click table → Table Data Import Wizard → sql-ultimate-course-main/datasets/Customers.csv)
DROP TABLE customers_csv;

-- Q3. Backup / restore the whole salesdb (run in a terminal, not in the query tool).
-- mysqldump -u root -p salesdb > salesdb_backup.sql
-- mysql -u root -p salesdb < salesdb_backup.sql
SELECT 'run the commands above in cmd / terminal' AS note;
