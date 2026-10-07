-- ======================================================================
-- Topic 51: Database Import & Export (CSV, SQL Dumps)
-- ======================================================================

-- ------------------------------------------------------------
-- 📖 In Simple Words
-- ------------------------------------------------------------

-- * Definition: Import and export move data between the database and files: CSV for tables, SQL dump files (mysqldump / pg_dump) for full backups.

-- * Real-life example: Exporting your phone contacts to a file and importing them on a new phone.

-- * Example on salesdb (run 00-Setup-Sample-Data.sql first):
SET search_path TO sales;
-- Export from psql:
-- \copy sales.customers TO 'customers.csv' WITH (FORMAT csv, HEADER)
-- Full backup from the terminal:
-- pg_dump -U postgres -d salesdb -f salesdb_backup.sql
SELECT COUNT(*) AS rows_to_export FROM customers;

-- * Example explained (step by step):
--   1. The commented lines are the real export / backup commands (they write files, so run them on purpose).
--   2. CSV export writes one line per customer with values separated by commas.
--   3. A dump file contains CREATE TABLE + INSERT statements that rebuild salesdb anywhere.

-- ------------------------------------------------------------
-- 51.1 Working with CSV Files
-- ------------------------------------------------------------

-- * CSV: Stands for Comma Separated Value.

-- * Rule of CSV Imports: The table columns must match the CSV file (in number, order, and data type). (e.g., If CSV has `id, name, salary`, the table must have the same structure.)

--   * Tip: `COPY` lets you list the target columns, e.g. `COPY employees (id, name, salary) FROM ...`, to change the order or load into a table with extra columns (the missing ones get their defaults). To skip a CSV column, load into a staging table first.

-- ------------------------------------------------------------
-- CSV Format Rules
-- ------------------------------------------------------------

-- 1. Delimiter: Usually a comma (`,`), but it could be `;` or `\t` (Tab). You must specify it (`DELIMITER ';'`).

-- 2. Quotes: Text values may be enclosed in double-quotes `"` (`QUOTE '"'` is the default in CSV format).

-- 3. Header Row: If the file has column headers at the top, use `HEADER true` during the import.

-- 4. NULLs: In CSV format an unquoted empty value is NULL; you can change it with `NULL 'NA'`.

-- 5. Encoding: Use UTF-8 (`ENCODING 'UTF8'`) so Marathi text loads correctly.

-- ------------------------------------------------------------
-- File Location Rules & Privileges
-- ------------------------------------------------------------

-- * Server Machine (`COPY ... FROM '/path'`): The file is read by the PostgreSQL server process, so it must be on the database server. You need to be a superuser or have the role `pg_read_server_files` (for `COPY TO` a file: `pg_write_server_files`).

-- * Local Machine (`\copy` in psql): If the file is on your own laptop, use psql's `\copy` meta-command. psql reads the file and streams it to the server — no special privileges needed except `INSERT` on the table. (This replaces MySQL's `LOAD DATA LOCAL INFILE` — nothing needs to be enabled.)

-- * Handling NULL & Constraints: If the table has a Primary Key or Unique constraint, a duplicate in the CSV makes the whole `COPY` fail (it's all-or-nothing). Load into a staging table and use `INSERT ... ON CONFLICT DO NOTHING`, or (PostgreSQL 17+) `COPY ... WITH (ON_ERROR ignore)` to skip rows with bad data types.

-- ------------------------------------------------------------
-- 51.2 Importing Data into PostgreSQL
-- ------------------------------------------------------------

-- ------------------------------------------------------------
-- Method 1: Using `COPY` / `\copy` (Fastest Way)
-- ------------------------------------------------------------
-- PostgreSQL has a built-in command to import CSV into a table extremely fast.

-- * Scenario: You have a file `employees.csv` (`id, name, salary, dept_id`).
CREATE TABLE employees (
  id INT,
  name VARCHAR(100),
  salary NUMERIC(10,2),
  dept_id INT
);

-- Importing a file that is on the database server
COPY employees (id, name, salary, dept_id)
FROM '/path/to/employees.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', QUOTE '"');

-- Importing a file from your own computer (run in psql)
-- (psql/client command — run it in psql, not in a GUI query tool):
-- \copy employees FROM 'C:/data/employees.csv' WITH (FORMAT csv, HEADER true)

-- * Explanation:

--   * `FORMAT csv` $\rightarrow$ CSV rules (quotes, commas). The default `text` format uses tabs.

--   * `DELIMITER ','` $\rightarrow$ The CSV delimiter (comma is the default for CSV).

--   * `QUOTE '"'` $\rightarrow$ Handles text values wrapped in quotes.

--   * `HEADER true` $\rightarrow$ Skips the header row (MySQL: `IGNORE 1 ROWS`).

--   * `\copy` (psql) $\rightarrow$ the file is on your client machine (MySQL: `LOAD DATA LOCAL INFILE`).

-- ------------------------------------------------------------
-- Method 2: Using the Command Line (no SQL shell)
-- ------------------------------------------------------------
-- ┌── (bash — not SQL, shown for reference) ──
-- │ psql -U postgres -d my_database -c "\copy employees FROM 'employees.csv' WITH (FORMAT csv, HEADER true)"
-- └──

-- * `-d my_database` $\rightarrow$ The target database name.

-- * The table name is written in the command (unlike `mysqlimport`, the file name doesn't have to match the table).

-- * For very large or messy CSV files, the `pgloader` tool can load and convert data (it can even migrate a whole MySQL database to PostgreSQL).

-- ------------------------------------------------------------
-- Method 3: Using GUI Tools (pgAdmin / DBeaver)
-- ------------------------------------------------------------

-- * pgAdmin: Right-click table $\rightarrow$ `Import/Export Data...` $\rightarrow$ choose Import, select the CSV file, set Header/Delimiter $\rightarrow$ OK. (pgAdmin runs `\copy` for you.)

-- ------------------------------------------------------------
-- 51.3 Exporting Data from PostgreSQL
-- ------------------------------------------------------------

-- ------------------------------------------------------------
-- 1. Export Query Results to CSV (`COPY ... TO`)
-- ------------------------------------------------------------
-- file is written on the database server (needs pg_write_server_files)
COPY (SELECT id, name, salary FROM employees)
TO '/var/lib/postgresql/exports/employees.csv'
WITH (FORMAT csv, HEADER true);

-- file is written on your own computer (psql)
-- (psql/client command — run it in psql, not in a GUI query tool):
-- \copy (SELECT id, name, salary FROM employees) TO 'C:/data/employees.csv' WITH (FORMAT csv, HEADER true)

-- * Note: `COPY ... TO` writes on the server (MySQL: `SELECT ... INTO OUTFILE`); `\copy ... TO` writes on your machine.

-- ------------------------------------------------------------
-- 2. Export via GUI (pgAdmin / DBeaver)
-- ------------------------------------------------------------

-- * Right-click a table $\rightarrow$ `Import/Export Data...` $\rightarrow$ choose Export and CSV format. DBeaver can also export to JSON, Excel, SQL INSERTs.

-- ------------------------------------------------------------
-- 51.4 Database Backups & Dumps (`pg_dump`)
-- ------------------------------------------------------------
-- `pg_dump` is the command-line tool provided by PostgreSQL to create a logical backup of one database (schema + data). It takes a consistent snapshot without blocking other users.

-- * Export Full Database (plain SQL file):
-- ┌── (bash — not SQL, shown for reference) ──
-- │ pg_dump -U postgres -d mydb -f mydb.sql
-- └──
--   (Creates a `.sql` file with schema + data.)

-- * Export in the custom compressed format (recommended — restore with `pg_restore`, can restore single tables and in parallel):
-- ┌── (bash — not SQL, shown for reference) ──
-- │ pg_dump -U postgres -d mydb -F c -f mydb.dump
-- └──

-- * Export Single Table:
-- ┌── (bash — not SQL, shown for reference) ──
-- │ pg_dump -U postgres -d mydb -t employees -f employees.sql
-- └──

-- * Export Only Schema (Without Data):
-- ┌── (bash — not SQL, shown for reference) ──
-- │ pg_dump -U postgres -d mydb --schema-only -f schema.sql
-- └──

-- * Export Only Data (No Table Structure):
-- ┌── (bash — not SQL, shown for reference) ──
-- │ pg_dump -U postgres -d mydb --data-only -f data.sql
-- └──

-- * Export with Conditions: `pg_dump` has no `--where`. Use `\copy (SELECT * FROM employees WHERE salary > 5000) TO 'high_salary.csv' WITH (FORMAT csv, HEADER true)`.

-- * Export ALL databases + roles of the server:
-- ┌── (bash — not SQL, shown for reference) ──
-- │ pg_dumpall -U postgres -f all_databases.sql
-- │ pg_dumpall -U postgres --globals-only -f roles.sql      # only users/roles and tablespaces
-- └──

-- ------------------------------------------------------------
-- How to Import a Dump file back to PostgreSQL:
-- ------------------------------------------------------------
-- ┌── (bash — not SQL, shown for reference) ──
-- │ # plain .sql file
-- │ createdb -U postgres mydb
-- │ psql -U postgres -d mydb -f mydb.sql
-- │ 
-- │ # custom-format .dump file (4 parallel jobs)
-- │ pg_restore -U postgres -d mydb -j 4 mydb.dump
-- │ 
-- │ # restore only one table from a custom dump
-- │ pg_restore -U postgres -d mydb -t employees mydb.dump
-- └──
-- (This executes all the `CREATE TABLE`, `COPY` and index statements, restoring your database completely.)

-- ------------------------------------------------------------
-- 51.5 Exporting/Importing Other File Types (XML & JSON)
-- ------------------------------------------------------------

-- ------------------------------------------------------------
-- 1. XML Files
-- ------------------------------------------------------------
-- PostgreSQL has an `xml` type and functions, but no `LOAD XML` command.

-- * Exporting to XML:
SELECT query_to_xml('SELECT * FROM employees', true, false, '');
-- or a whole table: SELECT table_to_xml('employees', true, false, '');

-- * Importing XML: load the file into one `xml`/`text` value (e.g. with `pg_read_file()` on the server, or from the app), then turn it into rows with `XMLTABLE`:
SELECT x.*
FROM XMLTABLE('/rows/row' PASSING (SELECT pg_read_file('/path/employees.xml')::xml)
              COLUMNS id INT PATH 'id', name TEXT PATH 'name', salary NUMERIC PATH 'salary') AS x;

-- ------------------------------------------------------------
-- 2. JSON Files
-- ------------------------------------------------------------

-- * Exporting to JSON:
-- (psql/client command — run it in psql, not in a GUI query tool):
-- \copy (SELECT json_agg(e) FROM employees e) TO 'employees.json'
-- or one JSON object per line (easy to stream):
-- (psql/client command — run it in psql, not in a GUI query tool):
-- \copy (SELECT row_to_json(e) FROM employees e) TO 'employees.jsonl'

-- * Importing JSON:
-- 1. load each line (one JSON object per line) into a staging table
CREATE TEMP TABLE staging (doc JSONB);
-- (psql/client command — run it in psql, not in a GUI query tool):
-- \copy staging (doc) FROM 'employees.jsonl'

-- 2. turn JSON into real columns
INSERT INTO employees (id, name, salary)
SELECT (doc->>'id')::INT, doc->>'name', (doc->>'salary')::NUMERIC
FROM staging;

-- or for one big JSON array: jsonb_array_elements() / jsonb_to_recordset()

-- ------------------------------------------------------------
-- 51.6 What `pg_dump` Includes (Functions, Triggers, Scheduled Jobs)
-- ------------------------------------------------------------
-- Unlike `mysqldump` (which needs `--routines --events`), `pg_dump` by default includes everything inside the database: tables, data, indexes, constraints, views, materialized views, sequences, functions, procedures, triggers, types and extensions (the `CREATE EXTENSION` command).

-- * Not included in `pg_dump`:

--   * Roles/users and tablespaces → use `pg_dumpall --globals-only`.

--   * Server settings (`postgresql.conf`, `pg_hba.conf`) → copy the files.

--   * `pg_cron` jobs live in the `cron.job` table of the cron database — they are dumped only if you dump that database.

-- ------------------------------------------------------------
-- 51.7 Performance Tip: Importing HUGE Files
-- ------------------------------------------------------------
-- When you import a massive dump or CSV (e.g. 50 GB), it can take hours. To speed it up:

-- 1. Load with COPY (much faster than many INSERT statements)
-- 2. Create the table WITHOUT indexes/foreign keys, load, then add them:
CREATE TABLE big_sales (id BIGINT, amount NUMERIC, sold_at TIMESTAMPTZ);
-- (psql/client command — run it in psql, not in a GUI query tool):
-- \copy big_sales FROM 'big_sales.csv' WITH (FORMAT csv, HEADER true)
ALTER TABLE big_sales ADD PRIMARY KEY (id);
CREATE INDEX ON big_sales (sold_at);
ANALYZE big_sales;                      -- fresh statistics after the load

-- 3. Give index builds more memory for this session:
SET maintenance_work_mem = '2GB';

-- 4. For a staging table you can lose on crash, skip WAL:
CREATE UNLOGGED TABLE staging_sales (LIKE big_sales);

-- * `pg_restore -j 8` restores tables and builds indexes in parallel.

-- * `pg_dump` already writes data first and creates indexes/constraints at the end — that is why restores are reasonably fast.

-- * Avoid turning off `fsync` on a real server — a crash during the load can corrupt the whole cluster.

-- ------------------------------------------------------------
-- 51.8 Backup Strategy & Replication
-- ------------------------------------------------------------

-- * Types of backup:

--   * Logical backup – SQL / custom dump (`pg_dump`, `pg_dumpall`). Portable across versions and readable, but slow to restore for big databases.

--   * Physical backup – a copy of the whole data directory (`pg_basebackup`, pgBackRest, Barman). Fast for large databases; same major version only.

--   * Full vs incremental – full = everything; incremental = only changes (WAL archiving; PostgreSQL 17 also has incremental `pg_basebackup`).

--   * Point-in-time recovery (PITR) – restore the last physical base backup, then replay archived WAL files up to the moment before the mistake: set `recovery_target_time = '2025-10-01 10:59:00'` in the config and start the server. Needs `archive_mode = on` and `archive_command` (or pgBackRest) beforehand.

--   * `pg_dump` is already consistent (it uses one snapshot) and does not lock tables against reads/writes — no `--single-transaction` flag needed.

-- * Replication: the primary writes every change to its WAL; standbys receive and replay it (streaming replication).

--   * Uses: read scaling (send reports to a hot standby), high availability (promote a standby if the primary fails, e.g. with Patroni), backups taken from a standby.

--   * Asynchronous (default): the primary doesn't wait for standbys — fast, but a crash can lose the last transactions. Synchronous (`synchronous_standby_names`): the primary waits until a standby has the change.

--   * Replication lag: standbys can be behind. Check on the primary: `SELECT client_addr, state, replay_lag FROM pg_stat_replication;` and on a standby: `SELECT now() - pg_last_xact_replay_timestamp();`

--   * Logical replication (`CREATE PUBLICATION` / `CREATE SUBSCRIPTION`): copies changes of selected tables, even between different PostgreSQL versions — used for upgrades and data sharing.

-- * Rule of thumb: replication is not a backup — a `DROP TABLE` is replicated to every standby too. Keep real backups and test restoring them.

-- ---

-- ======================================================================
-- 🎯 Practice Questions (salesdb sample data) — try first, then look at the answer
-- ======================================================================
-- Run 00-Setup-Sample-Data.sql once before this section.

SET search_path TO sales;

-- Q1. Export query result to CSV (path must be allowed by secure_file_priv).
-- Server side (superuser / pg_write_server_files):
-- COPY sales.customers TO 'C:/temp/customers.csv' WITH (FORMAT csv, HEADER);
-- psql client side:
-- \copy sales.customers TO 'customers.csv' WITH (FORMAT csv, HEADER)
SELECT * FROM customers;   -- pgAdmin: run, then use "Save results to file"

-- Q2. Import the course CSV into a new table.
CREATE TABLE customers_csv (LIKE customers);
-- \copy sales.customers_csv FROM 'sql-ultimate-course-main/datasets/Customers.csv' WITH (FORMAT csv, HEADER)
-- (pgAdmin: right-click table → Import/Export Data)
DROP TABLE customers_csv;

-- Q3. Backup / restore the whole salesdb (run in a terminal, not in the query tool).
-- pg_dump -U postgres -d salesdb -f salesdb_backup.sql
-- psql -U postgres -d salesdb -f salesdb_backup.sql
SELECT 'run the commands above in cmd / terminal' AS note;
