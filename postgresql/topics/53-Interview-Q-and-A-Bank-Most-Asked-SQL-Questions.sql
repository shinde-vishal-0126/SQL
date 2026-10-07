-- ======================================================================
-- Topic 53: Interview Q&A Bank (Most-Asked SQL Questions)
-- ======================================================================

-- ------------------------------------------------------------
-- 📖 In Simple Words
-- ------------------------------------------------------------

-- * Definition: Interview questions test whether you can turn a business question into correct SQL — ranking, duplicates, top-N, joins and NULL handling come up again and again.

-- * Real-life example: Practice papers before the exam.

-- * 🧩 Syntax:
--     -- Top-N per group:
--     SELECT * FROM (
--       SELECT ..., ROW_NUMBER() OVER (PARTITION BY grp ORDER BY val DESC) AS rn FROM t
--     ) x WHERE rn <= N;
--     -- Duplicates:
--     SELECT key, COUNT(*) FROM t GROUP BY key HAVING COUNT(*) > 1;
--     -- Nth highest:
--     SELECT DISTINCT val FROM t ORDER BY val DESC LIMIT 1 OFFSET N-1;

-- * Syntax explained (each part):
--   - ROW_NUMBER / RANK / DENSE_RANK → numbering inside groups for top-N questions
--   - GROUP BY … HAVING COUNT(*) > 1 → finds duplicates
--   - LIMIT … OFFSET → skip N-1 rows to get the Nth value

-- * Example on salesdb (run 00-Setup-Sample-Data.sql first):
SET search_path TO sales;
SELECT firstname, department, salary
FROM (SELECT firstname, department, salary,
             DENSE_RANK() OVER (ORDER BY salary DESC) AS rnk
      FROM employees) t
WHERE rnk = 2;

-- * Example explained (step by step):
--   1. DENSE_RANK orders salaries from highest: 90000 (rank 1), 75000 (rank 2), 65000 (rank 3)…
--   2. The outer query keeps rank 2 — the second highest salary.
--   3. Result: Mary, Sales, 75000.

-- > Short, simple answers you can say in an interview. The See column tells you where the full explanation is in these notes.

-- ------------------------------------------------------------
-- 53.1 Part A: Database Basics
-- ------------------------------------------------------------

-- (# → Question | Short Answer | See)
--
-- * 1
--     - Question     : What is a database?
--     - Short Answer : An organized collection of data stored so it can be easily saved, managed and retrieved.
--     - See          : 1.1
--
-- * 2
--     - Question     : What is a DBMS / RDBMS?
--     - Short Answer : Software that manages a database (security, many users, backup). An RDBMS stores data in related tables — e.g., PostgreSQL, MySQL, Oracle.
--     - See          : 2.1, 2.6
--
-- * 3
--     - Question     : What is SQL?
--     - Short Answer : Structured Query Language — the standard language to create, read, update and delete data in relational databases.
--     - See          : 3.1
--
-- * 4
--     - Question     : SQL vs PostgreSQL? PostgreSQL vs MySQL?
--     - Short Answer : SQL is the language; PostgreSQL is the software (ORDBMS) that understands SQL and stores the data. vs MySQL: PostgreSQL has transactional DDL, JSONB, arrays, more index types, FULL JOIN, RETURNING, ON CONFLICT, real BOOLEAN.
--     - See          : Topic 8
--
-- * 5
--     - Question     : SQL vs NoSQL?
--     - Short Answer : SQL = tables with a fixed schema and relations (PostgreSQL). NoSQL = flexible formats: key-value, document, column, graph (Redis, MongoDB, Cassandra, Neo4j). PostgreSQL JSONB covers many document use cases.
--     - See          : Topic 4
--
-- * 6
--     - Question     : What is a schema?
--     - Short Answer : A logical folder inside a database that groups tables (default public in PostgreSQL); also means the structure (blueprint) of the tables.
--     - See          : 6.1, 6.4
--
-- * 7
--     - Question     : What is CRUD?
--     - Short Answer : Create (INSERT), Read (SELECT), Update (UPDATE), Delete (DELETE).
--     - See          : 3.3
--

-- ------------------------------------------------------------
-- 53.2 Part B: Data Types
-- ------------------------------------------------------------

-- (# → Question | Short Answer | See)
--
-- * 8
--     - Question     : CHAR vs VARCHAR vs TEXT?
--     - Short Answer : CHAR(n) is fixed length (padded with spaces); VARCHAR(n) has a max length; TEXT has no limit. In PostgreSQL all perform the same — TEXT/VARCHAR are preferred.
--     - See          : 6.8.3
--
-- * 9
--     - Question     : TIMESTAMP vs TIMESTAMPTZ?
--     - Short Answer : TIMESTAMP: no time zone conversion (like MySQL DATETIME). TIMESTAMPTZ: stored in UTC, shown in the session time zone (like MySQL TIMESTAMP, but no 2038 limit). Use TIMESTAMPTZ for events.
--     - See          : 6.8.6
--
-- * 10
--     - Question     : Which data type for money?
--     - Short Answer : NUMERIC(p, s) — it is exact. Never REAL/DOUBLE PRECISION (approximate).
--     - See          : 6.8.2
--
-- * 11
--     - Question     : What is BOOLEAN in PostgreSQL?
--     - Short Answer : A real type with TRUE / FALSE / NULL (1 byte) — not a TINYINT(1) alias like MySQL. WHERE flag = 1 is an error; write WHERE flag.
--     - See          : 6.8.3
--
-- * 12
--     - Question     : ENUM vs SET in PostgreSQL?
--     - Short Answer : ENUM = a custom type made with CREATE TYPE ... AS ENUM (one value). There is no SET — use an array (TEXT[]) for many values.
--     - See          : 6.8.3
--

-- ------------------------------------------------------------
-- 53.3 Part C: DDL, DML & Command Types
-- ------------------------------------------------------------

-- (# → Question | Short Answer | See)
--
-- * 13
--     - Question     : Types of SQL commands?
--     - Short Answer : DDL (CREATE, ALTER, DROP, TRUNCATE), DML (INSERT, UPDATE, DELETE, MERGE), DQL (SELECT), DCL (GRANT, REVOKE), TCL (BEGIN, COMMIT, ROLLBACK, SAVEPOINT).
--     - See          : 9.2
--
-- * 14
--     - Question     : DELETE vs TRUNCATE vs DROP?
--     - Short Answer : DELETE: removes chosen rows, DML, rollback possible. TRUNCATE: empties the whole table fast, DDL, resets the sequence only with RESTART IDENTITY. DROP: removes the table itself. In PostgreSQL all three can be rolled back inside BEGIN.
--     - See          : 9.12
--
-- * 15
--     - Question     : Can we rollback DDL in PostgreSQL?
--     - Short Answer : Yes — PostgreSQL has transactional DDL: BEGIN; DROP TABLE t; ROLLBACK; brings the table back. (MySQL: no, DDL auto-commits.) Exceptions: CREATE/DROP DATABASE, VACUUM, CREATE INDEX CONCURRENTLY.
--     - See          : 9.4, 15.7
--
-- * 16
--     - Question     : ALTER vs UPDATE?
--     - Short Answer : ALTER (DDL) changes the table structure; UPDATE (DML) changes the data in rows.
--     - See          : 11.9
--
-- * 17
--     - Question     : How do you change a column type / rename a column?
--     - Short Answer : ALTER TABLE t ALTER COLUMN c TYPE BIGINT [USING ...] and ALTER TABLE t RENAME COLUMN a TO b. (PostgreSQL has no MySQL MODIFY / CHANGE.)
--     - See          : 9.6
--
-- * 18
--     - Question     : Can we rename a database in PostgreSQL?
--     - Short Answer : Yes: ALTER DATABASE old RENAME TO new; — nobody may be connected to it.
--     - See          : 9.11
--
-- * 19
--     - Question     : Is there a safe update mode?
--     - Short Answer : No SQL_SAFE_UPDATES in PostgreSQL. Run risky UPDATE/DELETE inside BEGIN, check the row count (or RETURNING), then COMMIT/ROLLBACK; or use the pg_safeupdate extension.
--     - See          : 11.5
--
-- * 20
--     - Question     : How do you do an upsert?
--     - Short Answer : INSERT ... ON CONFLICT (key) DO UPDATE SET col = EXCLUDED.col (or DO NOTHING). PostgreSQL has no REPLACE INTO / ON DUPLICATE KEY UPDATE. MERGE (PG 15+) syncs whole tables.
--     - See          : 11.8
--
-- * 21
--     - Question     : Soft delete vs hard delete?
--     - Short Answer : Hard delete removes the row (DELETE). Soft delete only marks it (UPDATE ... SET is_deleted = TRUE, deleted_at = now()), so it can be restored; a partial index on active rows keeps queries fast.
--     - See          : 11.6
--

-- ------------------------------------------------------------
-- 53.4 Part D: Keys & Constraints
-- ------------------------------------------------------------

-- (# → Question | Short Answer | See)
--
-- * 22
--     - Question     : What is a Primary Key?
--     - Short Answer : A column (or columns) that uniquely identifies each row. Unique, not NULL, only one per table.
--     - See          : 6.7, Topic 10
--
-- * 23
--     - Question     : Primary Key vs Unique Key?
--     - Short Answer : Primary: one per table, no NULL. Unique: many per table, NULL allowed.
--     - See          : Topic 10
--
-- * 24
--     - Question     : What is a Foreign Key?
--     - Short Answer : A column that refers to the Primary Key of another table, so child rows always point to a real parent row (referential integrity).
--     - See          : 11.7, Topic 10
--
-- * 25
--     - Question     : ON DELETE CASCADE vs NO ACTION/RESTRICT vs SET NULL?
--     - Short Answer : CASCADE deletes child rows too; NO ACTION (PostgreSQL default) / RESTRICT block the delete; SET NULL keeps child rows but sets the FK to NULL; SET DEFAULT also works in PostgreSQL.
--     - See          : 11.7
--
-- * 26
--     - Question     : Super, Candidate, Alternate, Composite, Surrogate key?
--     - Short Answer : Super = any set that identifies a row; Candidate = minimal super key; Alternate = candidate not chosen as PK; Composite = key of 2+ columns; Surrogate = artificial ID like SERIAL / IDENTITY.
--     - See          : Topic 10
--
-- * 27
--     - Question     : Name the SQL constraints.
--     - Short Answer : PRIMARY KEY, FOREIGN KEY, UNIQUE, NOT NULL, CHECK, DEFAULT.
--     - See          : 9.7, Topic 10
--

-- ------------------------------------------------------------
-- 53.5 Part E: Querying, Filtering, Grouping
-- ------------------------------------------------------------

-- (# → Question | Short Answer | See)
--
-- * 28
--     - Question     : Execution order of a SELECT query?
--     - Short Answer : FROM → WHERE → GROUP BY → HAVING → SELECT → DISTINCT → ORDER BY → LIMIT.
--     - See          : 20.5, 20.12
--
-- * 29
--     - Question     : Can we use a SELECT alias in WHERE?
--     - Short Answer : No — WHERE runs before SELECT. But you can use it in ORDER BY.
--     - See          : 20.12
--
-- * 30
--     - Question     : WHERE vs HAVING?
--     - Short Answer : WHERE filters rows before grouping (no aggregates). HAVING filters groups after GROUP BY (aggregates allowed).
--     - See          : 20.12
--
-- * 31
--     - Question     : Can we use HAVING without GROUP BY?
--     - Short Answer : Yes — the whole table is treated as one group.
--     - See          : 20.9
--
-- * 32
--     - Question     : Why is SELECT * bad in production?
--     - Short Answer : It reads and sends unneeded columns, can't use covering indexes, and breaks when columns change.
--     - See          : 12.2
--
-- * 33
--     - Question     : BETWEEN — inclusive or exclusive?
--     - Short Answer : Inclusive: both ends are included (>= low AND <= high).
--     - See          : 20.7.7
--
-- * 34
--     - Question     : % vs _ in LIKE?
--     - Short Answer : % = zero or more characters; _ = exactly one character.
--     - See          : 20.7.9
--
-- * 35
--     - Question     : Why does col = NULL return nothing?
--     - Short Answer : Any comparison with NULL gives UNKNOWN, not TRUE. Use IS NULL / IS NOT NULL.
--     - See          : 20.7.10
--
-- * 36
--     - Question     : What does NOT IN (1, 2, NULL) return?
--     - Short Answer : Zero rows, because of the NULL. Use NOT EXISTS or filter NULLs out.
--     - See          : 20.7.8
--
-- * 37
--     - Question     : COUNT(*) vs COUNT(col) vs COUNT(DISTINCT col)?
--     - Short Answer : All rows / non-NULL values / unique non-NULL values.
--     - See          : 20.9
--
-- * 38
--     - Question     : What happens if a selected column is not in GROUP BY?
--     - Short Answer : PostgreSQL always raises an error (must appear in the GROUP BY clause or be used in an aggregate function) — except columns of a table whose primary key is in GROUP BY.
--     - See          : 20.9
--
-- * 39
--     - Question     : LIMIT vs TOP? Pagination?
--     - Short Answer : PostgreSQL uses LIMIT n OFFSET m (or FETCH FIRST n ROWS ONLY), SQL Server uses TOP. Page 3 with 10 rows per page: LIMIT 10 OFFSET 20. MySQL's LIMIT 20, 10 is an error in PostgreSQL.
--     - See          : 20.12
--

-- ------------------------------------------------------------
-- 53.6 Part F: Joins & SET Operators
-- ------------------------------------------------------------

-- (# → Question | Short Answer | See)
--
-- * 40
--     - Question     : Types of joins?
--     - Short Answer : INNER, LEFT, RIGHT, FULL, CROSS, SELF, LATERAL, plus anti-joins (LEFT/RIGHT/FULL ANTI).
--     - See          : Topic 21
--
-- * 41
--     - Question     : INNER JOIN vs LEFT JOIN?
--     - Short Answer : Inner = only matching rows. Left = all rows of the left table + matches (NULL where no match).
--     - See          : Topic 21
--
-- * 42
--     - Question     : How to do a FULL JOIN in PostgreSQL?
--     - Short Answer : Directly: FROM a FULL JOIN b ON ... (MySQL needs LEFT JOIN ... UNION ... RIGHT JOIN).
--     - See          : Topic 21
--
-- * 43
--     - Question     : What is a self join?
--     - Short Answer : Joining a table to itself with aliases, e.g., employee → manager.
--     - See          : Topic 21
--
-- * 44
--     - Question     : What is a cross join?
--     - Short Answer : Every row of A × every row of B (Cartesian product), no ON.
--     - See          : Topic 21
--
-- * 45
--     - Question     : JOIN vs UNION?
--     - Short Answer : JOIN adds columns (wider result); UNION adds rows (longer result).
--     - See          : Topic 22
--
-- * 46
--     - Question     : UNION vs UNION ALL?
--     - Short Answer : UNION removes duplicates (slower); UNION ALL keeps all rows (faster).
--     - See          : Topic 22
--
-- * 47
--     - Question     : Rules for SET operators?
--     - Short Answer : Same number of columns, compatible data types, same column order; ORDER BY only once at the end; names come from the first query.
--     - See          : Topic 22
--

-- ------------------------------------------------------------
-- 53.7 Part G: Functions, NULL & CASE
-- ------------------------------------------------------------

-- (# → Question | Short Answer | See)
--
-- * 48
--     - Question     : COALESCE vs IFNULL?
--     - Short Answer : PostgreSQL has only COALESCE(a, b, c, ...) — first non-NULL value (standard SQL). IFNULL (MySQL) and ISNULL (SQL Server) don't exist.
--     - See          : Topic 25
--
-- * 49
--     - Question     : What is NULLIF used for?
--     - Short Answer : NULLIF(a, b) returns NULL if a = b. Common use: avoid divide-by-zero → x / NULLIF(qty, 0).
--     - See          : Topic 25
--
-- * 50
--     - Question     : What is CASE?
--     - Short Answer : SQL's if-then-else. It checks conditions top to bottom and returns the first match; ELSE is the default.
--     - See          : Topic 25
--
-- * 51
--     - Question     : How do you find the difference between two dates?
--     - Short Answer : date2 - date1 = days (integer); AGE(d2, d1) = years/months/days; EXTRACT(EPOCH FROM (t2 - t1)) / 3600 = hours. (MySQL: DATEDIFF / TIMESTAMPDIFF.)
--     - See          : Topic 24
--
-- * 52
--     - Question     : Single-row vs aggregate functions?
--     - Short Answer : Single-row: one input → one output per row (UPPER, ROUND). Aggregate: many rows → one result (SUM, AVG).
--     - See          : Topic 23
--

-- ------------------------------------------------------------
-- 53.8 Part H: Window Functions
-- ------------------------------------------------------------

-- (# → Question | Short Answer | See)
--
-- * 53
--     - Question     : What is a window function?
--     - Short Answer : A function used with OVER() that calculates across related rows without collapsing them (unlike GROUP BY).
--     - See          : Topic 26
--
-- * 54
--     - Question     : ROW_NUMBER vs RANK vs DENSE_RANK?
--     - Short Answer : For 100, 90, 90, 80 → 1,2,3,4 / 1,2,2,4 / 1,2,2,3.
--     - See          : Topic 26
--
-- * 55
--     - Question     : PARTITION BY vs GROUP BY?
--     - Short Answer : Both make groups, but PARTITION BY keeps every row; GROUP BY returns one row per group.
--     - See          : Topic 26
--
-- * 56
--     - Question     : What do LAG and LEAD do?
--     - Short Answer : Read the value from the previous (LAG) or next (LEAD) row — used for month-over-month comparisons.
--     - See          : Topic 26
--
-- * 57
--     - Question     : Running total vs rolling total?
--     - Short Answer : Running = from the first row up to the current row. Rolling = a fixed window, e.g., the last 3 rows.
--     - See          : Topic 26
--
-- * 58
--     - Question     : Why does LAST_VALUE give a wrong answer?
--     - Short Answer : The default frame ends at the current row. Use ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING.
--     - See          : Topic 26
--
-- * 59
--     - Question     : Can we use a window function in WHERE?
--     - Short Answer : No — wrap the query in a subquery/CTE and filter outside.
--     - See          : Topic 26
--

-- ------------------------------------------------------------
-- 53.9 Part I: Transactions & Security
-- ------------------------------------------------------------

-- (# → Question | Short Answer | See)
--
-- * 60
--     - Question     : What are ACID properties?
--     - Short Answer : Atomicity (all or nothing), Consistency (valid state), Isolation (transactions don't disturb each other), Durability (saved even after a crash).
--     - See          : 15.2
--
-- * 61
--     - Question     : Isolation levels & PostgreSQL default?
--     - Short Answer : READ UNCOMMITTED (acts as READ COMMITTED), READ COMMITTED (PostgreSQL default), REPEATABLE READ (snapshot — no phantoms), SERIALIZABLE (SSI, may need retry).
--     - See          : 15.6
--
-- * 62
--     - Question     : Dirty read / non-repeatable read / phantom read?
--     - Short Answer : Reading uncommitted data / same row gives a different value on re-read / new rows appear on re-run of a range query.
--     - See          : 15.6
--
-- * 63
--     - Question     : What is a savepoint?
--     - Short Answer : A checkpoint inside a transaction; ROLLBACK TO sp undoes only the changes after it.
--     - See          : 15.3
--
-- * 64
--     - Question     : What is a deadlock?
--     - Short Answer : Two transactions wait for each other's locks. After deadlock_timeout (1 s) PostgreSQL detects it and aborts one (deadlock detected, SQLSTATE 40P01).
--     - See          : 15.7
--
-- * 65
--     - Question     : Is autocommit on by default?
--     - Short Answer : Yes. Each statement is committed immediately unless you use BEGIN (or psql \set AUTOCOMMIT off).
--     - See          : 15.7
--
-- * 66
--     - Question     : GRANT vs REVOKE? Is any reload needed?
--     - Short Answer : GRANT ... TO gives permission; REVOKE ... FROM removes it. They work immediately — PostgreSQL has no FLUSH PRIVILEGES. To read a table a role needs CONNECT on the DB, USAGE on the schema and SELECT on the table.
--     - See          : Topic 13
--

-- ------------------------------------------------------------
-- 53.10 Part J: Query-Writing Questions (Practice These)
-- ------------------------------------------------------------

-- * Q67. Find the 2nd highest salary.
SELECT MAX(salary) AS second_highest
FROM employees
WHERE salary < (SELECT MAX(salary) FROM employees);

-- or
SELECT DISTINCT salary FROM employees ORDER BY salary DESC LIMIT 1 OFFSET 1;

-- * Q68. Find the Nth highest salary (N = 3), handling equal salaries.
SELECT DISTINCT salary
FROM (
    SELECT salary, DENSE_RANK() OVER (ORDER BY salary DESC) AS rnk
    FROM employees
) t
WHERE rnk = 3;

-- * Q69. Highest-paid employee in each department.
SELECT name, department, salary
FROM (
    SELECT name, department, salary,
           RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS rnk
    FROM employees
) t
WHERE rnk = 1;

-- * Q70. Find duplicate emails.
SELECT email, COUNT(*) AS times
FROM customers
GROUP BY email
HAVING COUNT(*) > 1;

-- * Q71. Delete duplicate rows but keep the one with the lowest id.
-- PostgreSQL uses DELETE ... USING (MySQL: DELETE c1 FROM c1 JOIN c2)
DELETE FROM customers c1
USING customers c2
WHERE c1.email = c2.email
  AND c1.id > c2.id;

-- * Q72. Customers who never placed an order.
SELECT c.id, c.first_name
FROM customers c
LEFT JOIN orders o ON c.id = o.customer_id
WHERE o.customer_id IS NULL;

-- * Q73. Employees who earn more than their manager.
SELECT e.name AS employee, e.salary, m.name AS manager, m.salary AS manager_salary
FROM employees e
JOIN employees m ON e.manager_id = m.id
WHERE e.salary > m.salary;

-- * Q74. Number of employees in each department, biggest first.
SELECT department, COUNT(*) AS total_employees
FROM employees
GROUP BY department
ORDER BY total_employees DESC;

-- * Q75. Running total of sales by date.
SELECT order_date, sales,
       SUM(sales) OVER (ORDER BY order_date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_total
FROM orders;

-- * Q76. Customers whose score is above the average score.
SELECT first_name, score
FROM customers
WHERE score > (SELECT AVG(score) FROM customers);

-- ------------------------------------------------------------
-- 53.11 Part K: Transactions, Locks & Concurrency
-- ------------------------------------------------------------

-- (# → Question | Short Answer | See)
--
-- * 77
--     - Question     : What is a transaction?
--     - Short Answer : A group of SQL statements that succeed together (COMMIT) or are undone together (ROLLBACK).
--     - See          : Topic 17
--
-- * 78
--     - Question     : Explicit vs implicit commit?
--     - Short Answer : Explicit: you write BEGIN ... COMMIT. Implicit: with autocommit ON, each statement outside BEGIN commits by itself. PostgreSQL does NOT commit automatically around DDL.
--     - See          : Topic 17
--
-- * 79
--     - Question     : What are the 5 transaction states?
--     - Short Answer : Active → Partially Committed → Committed → Terminated; or Failed → Aborted (rolled back) → Terminated.
--     - See          : Topic 17
--
-- * 80
--     - Question     : Shared (S) vs exclusive (X) lock?
--     - Short Answer : S = read lock, many transactions can hold it together; X = write lock, only one holder and it blocks S and X locks from others.
--     - See          : Topic 19
--
-- * 81
--     - Question     : SELECT ... FOR UPDATE vs FOR SHARE?
--     - Short Answer : FOR UPDATE locks the rows exclusively (others can't change or lock them); FOR SHARE lets others read-lock but not change. Plain SELECT is never blocked (MVCC). SKIP LOCKED / NOWAIT for queues.
--     - See          : Topic 19
--
-- * 82
--     - Question     : Optimistic vs pessimistic locking?
--     - Short Answer : Pessimistic: lock first (FOR UPDATE) — safe under heavy conflict. Optimistic: no lock; a version column is checked in the UPDATE ... WHERE version = ? — fast when conflicts are rare.
--     - See          : Topic 19
--
-- * 83
--     - Question     : Row lock vs table lock?
--     - Short Answer : PostgreSQL locks only the rows it changes (stored in the row itself); every statement also takes a light table lock, and DDL takes ACCESS EXCLUSIVE (blocks even SELECT). Explicit: LOCK TABLE t IN ... MODE.
--     - See          : Topic 19
--
-- * 84
--     - Question     : Does PostgreSQL use gap / next-key locks?
--     - Short Answer : No. It prevents phantoms with snapshots (REPEATABLE READ) and non-blocking predicate locks (SERIALIZABLE). (MySQL InnoDB uses gap/next-key locks.)
--     - See          : Topic 19
--
-- * 85
--     - Question     : Deadlock vs lock timeout?
--     - Short Answer : Deadlock = cycle, aborted after deadlock_timeout (40P01). Lock timeout = waited longer than lock_timeout (55P03); by default PostgreSQL waits forever, so set lock_timeout.
--     - See          : Topic 18
--
-- * 86
--     - Question     : How do you avoid lost updates when two users edit the same row?
--     - Short Answer : Lock with SELECT ... FOR UPDATE in a transaction, or use optimistic locking with a version column, or update atomically (SET stock = stock - 1 WHERE stock > 0).
--     - See          : Topic 19
--

-- ------------------------------------------------------------
-- 53.12 Part L: Indexes & Performance
-- ------------------------------------------------------------

-- (# → Question | Short Answer | See)
--
-- * 87
--     - Question     : What is an index and why use it?
--     - Short Answer : A separate structure (usually B-Tree) that lets PostgreSQL jump to rows (by CTID) instead of a Seq Scan — faster reads, slower writes.
--     - See          : Topic 41
--
-- * 88
--     - Question     : Clustered vs non-clustered index?
--     - Short Answer : Clustered = table stored in key order (SQL Server, MySQL InnoDB PK). PostgreSQL has no clustered index: tables are heaps and every index (incl. PK) is secondary, pointing to the CTID. CLUSTER sorts once only.
--     - See          : Topic 41, Topic 42
--
-- * 89
--     - Question     : What is a covering index?
--     - Short Answer : An index that holds every column the query needs (CREATE INDEX ... (a) INCLUDE (b)), so PostgreSQL can do an Index Only Scan without reading the table.
--     - See          : Topic 48
--
-- * 90
--     - Question     : Composite index (a, b, c) — which queries use it?
--     - Short Answer : Queries filtering on a, a,b or a,b,c (leftmost prefix). Filtering only on b or c usually can't.
--     - See          : Topic 41
--
-- * 91
--     - Question     : When is an index NOT used?
--     - Short Answer : Function on the column (EXTRACT(YEAR FROM d) = 2025 — use a range or an expression index), leading wildcard (LIKE '%x' — use pg_trgm), type mismatch, low selectivity, stale statistics, or the planner thinks a Seq Scan is cheaper.
--     - See          : Topic 47, Topic 48
--
-- * 92
--     - Question     : Why not index every column?
--     - Short Answer : Every index costs disk space and must be updated on each INSERT/UPDATE/DELETE, slowing writes.
--     - See          : Topic 41
--
-- * 93
--     - Question     : EXPLAIN vs EXPLAIN ANALYZE?
--     - Short Answer : EXPLAIN shows the estimated plan without running; EXPLAIN (ANALYZE, BUFFERS) runs the query and shows actual time, rows and memory/disk pages per step.
--     - See          : Topic 43
--
-- * 94
--     - Question     : What does Seq Scan mean in EXPLAIN?
--     - Short Answer : A full table scan — fine for small tables or when most rows are needed; on a big table with a selective filter it usually means a missing or unusable index.
--     - See          : Topic 43, Topic 44
--
-- * 95
--     - Question     : How do you optimize a slow query?
--     - Short Answer : Find it (pg_stat_statements), measure (EXPLAIN ANALYZE), select fewer columns, filter early, add the right index (composite/partial/expression/covering), fix joins, ANALYZE statistics, then consider partitioning / materialized views / caching.
--     - See          : Topic 47, Topic 48
--
-- * 96
--     - Question     : What is partition pruning?
--     - Short Answer : PostgreSQL scans only the partitions that can contain matching rows (e.g. only sales_2025 for a 2025 date filter).
--     - See          : Topic 46
--
-- * 97
--     - Question     : UNION vs UNION ALL performance?
--     - Short Answer : UNION ALL is faster because it skips the duplicate-removal step.
--     - See          : Topic 22, Topic 48
--
-- * 98
--     - Question     : OLTP vs OLAP?
--     - Short Answer : OLTP = many small normalized transactions (app DB). OLAP = big analytical scans on denormalized/star-schema data (warehouse).
--     - See          : Topic 49
--

-- ------------------------------------------------------------
-- 53.13 Part M: Procedures, Functions, Triggers, Events & Cursors
-- ------------------------------------------------------------

-- (# → Question | Short Answer | See)
--
-- * 99
--     - Question     : What is a stored procedure?
--     - Short Answer : A named PL/pgSQL program saved in the database and run with CALL name(...); can have IN/OUT/INOUT parameters, variables, IF/loops, exception blocks and even COMMIT. Logic that returns rows is usually a function.
--     - See          : Topic 35
--
-- * 100
--     - Question     : IN vs OUT vs INOUT?
--     - Short Answer : IN passes a value in; OUT returns a value (pass NULL in its place: CALL p(1, NULL)); INOUT goes in, is changed and comes back. No @variables needed.
--     - See          : Topic 35
--
-- * 101
--     - Question     : Is DELIMITER needed in PostgreSQL?
--     - Short Answer : No. The body is written between  ...  (dollar quoting), so ; inside it is safe.
--     - See          : Topic 35
--
-- * 102
--     - Question     : Can a parameter have a DEFAULT in PostgreSQL?
--     - Short Answer : Yes: CREATE FUNCTION f(p_country TEXT DEFAULT 'USA'); you can also pass by name: f(p_country => 'India').
--     - See          : Topic 35
--
-- * 103
--     - Question     : Procedure vs function?
--     - Short Answer : Procedure = action, CALL, OUT/INOUT params, can COMMIT. Function = returns a value or a whole table, usable inside SELECT/WHERE/FROM, no COMMIT.
--     - See          : Topic 36
--
-- * 104
--     - Question     : What is a trigger?
--     - Short Answer : A trigger function (RETURNS TRIGGER) attached with CREATE TRIGGER that runs BEFORE/AFTER/INSTEAD OF an INSERT, UPDATE, DELETE or TRUNCATE — per row (with OLD/NEW) or per statement.
--     - See          : Topic 37
--
-- * 105
--     - Question     : Give 3 real uses of triggers.
--     - Short Answer : Audit log of salary changes, validation with RAISE EXCEPTION, keeping updated_at / a derived total in sync.
--     - See          : Topic 37
--
-- * 106
--     - Question     : How do you schedule a job in PostgreSQL?
--     - Short Answer : No built-in events. Use the pg_cron extension: SELECT cron.schedule('nightly', '0 2 * * *', 'CALL cleanup()'); (or an external cron).
--     - See          : Topic 38
--
-- * 107
--     - Question     : Trigger vs scheduled job?
--     - Short Answer : Trigger fires on a data change, immediately; a pg_cron job fires on a time schedule.
--     - See          : Topic 38
--
-- * 108
--     - Question     : What is a cursor?
--     - Short Answer : A pointer to read a result set one row at a time: DECLARE → OPEN → FETCH (loop, EXIT WHEN NOT FOUND) → CLOSE — or simply FOR rec IN SELECT ... LOOP. Also usable in plain SQL inside a transaction.
--     - See          : Topic 39
--
-- * 109
--     - Question     : Why avoid cursors when possible?
--     - Short Answer : They process row by row (slow); a single set-based UPDATE/INSERT ... SELECT is usually much faster.
--     - See          : Topic 39
--
-- * 110
--     - Question     : How do you handle errors in PL/pgSQL?
--     - Short Answer : BEGIN ... EXCEPTION WHEN unique_violation / OTHERS THEN ... END;, SQLERRM / GET STACKED DIAGNOSTICS to read the message, RAISE EXCEPTION to raise and RAISE; to re-raise. An unhandled error rolls back the whole call automatically.
--     - See          : Topic 35
--

-- ------------------------------------------------------------
-- 53.14 Part N: Views, CTEs, Subqueries & Temporary Tables
-- ------------------------------------------------------------

-- (# → Question | Short Answer | See)
--
-- * 111
--     - Question     : What is a view?
--     - Short Answer : A saved SELECT used like a table; stores no data (virtual table).
--     - See          : Topic 32
--
-- * 112
--     - Question     : View vs materialized view?
--     - Short Answer : A view re-runs its query every time (always fresh); a materialized view stores the result (fast, can be indexed) and is refreshed with REFRESH MATERIALIZED VIEW [CONCURRENTLY] — supported natively in PostgreSQL.
--     - See          : Topic 32
--
-- * 113
--     - Question     : When is a view updatable?
--     - Short Answer : Simple views (one table, no GROUP BY, DISTINCT, aggregates, UNION, window functions) are automatically updatable; others need an INSTEAD OF trigger.
--     - See          : Topic 32
--
-- * 114
--     - Question     : What does WITH CHECK OPTION do?
--     - Short Answer : Blocks INSERT/UPDATE through the view that would create rows the view itself would not show.
--     - See          : Topic 32
--
-- * 115
--     - Question     : CTE vs subquery vs temporary table?
--     - Short Answer : Subquery: inline, used once. CTE: named, reusable within one query, can be recursive. Temp table: lives for the session, can be indexed and reused by many queries.
--     - See          : Topic 30, Topic 33
--
-- * 116
--     - Question     : What is a recursive CTE used for?
--     - Short Answer : Hierarchies (employee → manager), trees, and generating number/date series. Anchor + UNION ALL + recursive part.
--     - See          : Topic 31
--
-- * 117
--     - Question     : IN vs EXISTS?
--     - Short Answer : EXISTS stops at the first match and is NULL-safe — best for "does a related row exist?". IN is fine for short fixed lists. NOT IN with a NULL returns nothing, so prefer NOT EXISTS.
--     - See          : Topic 27
--
-- * 118
--     - Question     : Correlated vs non-correlated subquery?
--     - Short Answer : Correlated uses the outer row and runs per row; non-correlated runs once.
--     - See          : Topic 27, Topic 28
--
-- * 119
--     - Question     : Can you UPDATE/DELETE a table using a subquery on the same table?
--     - Short Answer : Yes in PostgreSQL — it works directly (the subquery reads a snapshot). MySQL gives error 1093 there.
--     - See          : Topic 27
--

-- ------------------------------------------------------------
-- 53.15 Part O: Database Design, Normalization & Data Warehousing
-- ------------------------------------------------------------

-- (# → Question | Short Answer | See)
--
-- * 120
--     - Question     : What is normalization and why?
--     - Short Answer : Splitting data into related tables to remove duplication and update/insert/delete anomalies.
--     - See          : Topic 49
--
-- * 121
--     - Question     : 1NF, 2NF, 3NF in one line each?
--     - Short Answer : 1NF: atomic values, no repeating groups. 2NF: no partial dependency on part of a composite key. 3NF: no transitive dependency (non-key depends only on the key).
--     - See          : Topic 49
--
-- * 122
--     - Question     : What is BCNF?
--     - Short Answer : A stricter 3NF: every determinant must be a candidate key.
--     - See          : Topic 49
--
-- * 123
--     - Question     : When would you denormalize?
--     - Short Answer : For read-heavy reporting/OLAP where joins are too slow — accept some duplication for speed.
--     - See          : Topic 49
--
-- * 124
--     - Question     : How do you model a many-to-many relationship?
--     - Short Answer : A junction table with two foreign keys and a composite primary key.
--     - See          : Topic 50
--
-- * 125
--     - Question     : Fact table vs dimension table?
--     - Short Answer : Fact = measurable events (amount, quantity) with foreign keys; dimension = descriptive attributes (product, date, customer).
--     - See          : Topic 49
--
-- * 126
--     - Question     : Star vs snowflake schema?
--     - Short Answer : Star: fact joined directly to denormalized dimensions (fewer joins, faster). Snowflake: dimensions normalized into sub-tables (less duplication, more joins).
--     - See          : Topic 49
--
-- * 127
--     - Question     : What is a Slowly Changing Dimension type 2?
--     - Short Answer : Keeping history by inserting a new row with valid_from, valid_to, is_current instead of overwriting.
--     - See          : Topic 49
--
-- * 128
--     - Question     : Natural key vs surrogate key?
--     - Short Answer : Natural key comes from the data (email, PAN); surrogate key is an artificial id (GENERATED ALWAYS AS IDENTITY / SERIAL, or UUID) — stable and small, preferred as the primary key.
--     - See          : Topic 10
--

-- ------------------------------------------------------------
-- 53.16 Part P: Security, Backup & Administration
-- ------------------------------------------------------------

-- (# → Question | Short Answer | See)
--
-- * 129
--     - Question     : What is SQL injection?
--     - Short Answer : An attack where user input is concatenated into a SQL string and changes the query (e.g. ' OR '1'='1).
--     - See          : Topic 14
--
-- * 130
--     - Question     : How do you prevent SQL injection?
--     - Short Answer : Prepared statements / parameterized queries, input validation (allow-lists), least-privilege DB users, and never building SQL with string concatenation.
--     - See          : Topic 14
--
-- * 131
--     - Question     : What is a prepared statement?
--     - Short Answer : A query sent once with placeholders (1, 2); values are sent separately and are never treated as SQL (PREPARE s(TEXT) AS ... $1; EXECUTE s('x');).
--     - See          : Topic 14
--
-- * 132
--     - Question     : Principle of least privilege?
--     - Short Answer : Give each role only the rights it needs (e.g. GRANT SELECT, INSERT ON orders TO app_user;), never the postgres superuser; use group roles and Row-Level Security when needed.
--     - See          : Topic 13
--
-- * 133
--     - Question     : Logical vs physical backup?
--     - Short Answer : Logical = pg_dump / pg_dumpall (portable, slower restore); physical = copy of the data directory (pg_basebackup, pgBackRest) + WAL for point-in-time recovery, fast for big databases.
--     - See          : Topic 51
--
-- * 134
--     - Question     : Is replication a backup?
--     - Short Answer : No — a DROP TABLE is replicated to every standby. Replication is for read scaling and high availability; you still need backups and archived WAL for point-in-time recovery.
--     - See          : Topic 51
--

-- ------------------------------------------------------------
-- 53.17 Part Q: Advanced Query-Writing Questions (with Sample Output)
-- ------------------------------------------------------------

-- * Sample `employees` table used below:

-- (emp_id → name | department | salary)
--
-- * 1
--     - name       : Amit
--     - department : IT
--     - salary     : 90000
--
-- * 2
--     - name       : Neha
--     - department : IT
--     - salary     : 85000
--
-- * 3
--     - name       : Ravi
--     - department : IT
--     - salary     : 85000
--
-- * 4
--     - name       : Sara
--     - department : IT
--     - salary     : 70000
--
-- * 5
--     - name       : John
--     - department : HR
--     - salary     : 60000
--
-- * 6
--     - name       : Mary
--     - department : HR
--     - salary     : 55000
--

-- * Q135. Top 3 salaries in each department (ties share a rank).
SELECT department, name, salary, rnk
FROM (
    SELECT department, name, salary,
           DENSE_RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS rnk
    FROM employees
) t
WHERE rnk <= 3
ORDER BY department, rnk;

--   * Output: HR → John (1), Mary (2) · IT → Amit (1), Neha (2), Ravi (2), Sara (3).

-- * Q136. Users who logged in on 3 or more consecutive days (gaps & islands).
WITH d AS (                       -- one row per user per day
    SELECT DISTINCT user_id, login_time::DATE AS login_date
    FROM logins
),
n AS (                            -- number each user's login days in order
    SELECT user_id, login_date,
           ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY login_date) AS rn
    FROM d
),
g AS (                            -- same "island" => same (date - rn)
    SELECT user_id, login_date,
           login_date - rn::INT AS grp          -- DATE minus integer = DATE
    FROM n
)
SELECT user_id, MIN(login_date) AS streak_start, MAX(login_date) AS streak_end, COUNT(*) AS days
FROM g
GROUP BY user_id, grp
HAVING COUNT(*) >= 3;

--   * Idea: for consecutive dates, `date - row_number` stays the same (1 Oct − 1, 2 Oct − 2, 3 Oct − 3 → all 30 Sep), so each streak forms one group.

--   * Output example: user 7 logged in 1, 2, 3, 5 Oct → `7 | 2025-10-01 | 2025-10-03 | 3`.

-- * Q137. Median salary.
-- PostgreSQL built-in way:
SELECT PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY salary) AS median_salary
FROM employees;

-- Manual way (works in any database):
WITH r AS (
    SELECT salary,
           ROW_NUMBER() OVER (ORDER BY salary) AS rn,
           COUNT(*) OVER () AS cnt
    FROM employees
)
SELECT AVG(salary) AS median_salary
FROM r
WHERE rn IN (FLOOR((cnt + 1) / 2), CEIL((cnt + 1) / 2));

--   * Output: sorted salaries 55000, 60000, 70000, 85000, 85000, 90000 → middle two are 70000 and 85000 → median = 77500.

-- * Q138. Pivot: sales per product with one column per year.
SELECT product,
       SUM(CASE WHEN EXTRACT(YEAR FROM order_date) = 2024 THEN sales ELSE 0 END) AS sales_2024,
       SUM(CASE WHEN EXTRACT(YEAR FROM order_date) = 2025 THEN sales ELSE 0 END) AS sales_2025
FROM orders
GROUP BY product;

-- PostgreSQL FILTER version:
SELECT product,
       COALESCE(SUM(sales) FILTER (WHERE order_date >= '2024-01-01' AND order_date < '2025-01-01'), 0) AS sales_2024,
       COALESCE(SUM(sales) FILTER (WHERE order_date >= '2025-01-01' AND order_date < '2026-01-01'), 0) AS sales_2025
FROM orders
GROUP BY product;

--   * Output shape: `Laptop | 120000 | 150000`, `Mouse | 8000 | 9500`.

-- * Q139. Latest order of every customer (and the second latest).
SELECT customer_id, order_id, order_date
FROM (
    SELECT customer_id, order_id, order_date,
           ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY order_date DESC, order_id DESC) AS rn
    FROM orders
) t
WHERE rn = 1;          -- use rn = 2 for the second latest order

-- PostgreSQL shortcut for the latest one:
SELECT DISTINCT ON (customer_id) customer_id, order_id, order_date
FROM orders
ORDER BY customer_id, order_date DESC, order_id DESC;

-- * Q140. Percentage contribution and cumulative % of each product (Pareto / 80-20).
SELECT product, total,
       ROUND(100.0 * total / SUM(total) OVER (), 2) AS pct_of_total,
       ROUND(100.0 * SUM(total) OVER (ORDER BY total DESC ROWS UNBOUNDED PRECEDING) / SUM(total) OVER (), 2) AS cumulative_pct   -- 100.0 avoids integer division
FROM (
    SELECT product, SUM(sales) AS total
    FROM orders
    GROUP BY product
) t
ORDER BY total DESC;

--   * Output shape: `Laptop | 50000 | 50.00 | 50.00`, `Phone | 30000 | 30.00 | 80.00`, `Mouse | 20000 | 20.00 | 100.00`.

-- * Q141. Delete duplicate customers (same email), keep the smallest id — using ROW_NUMBER.
DELETE FROM customers
WHERE id IN (
    SELECT id FROM (
        SELECT id, ROW_NUMBER() OVER (PARTITION BY email ORDER BY id) AS rn
        FROM customers
    ) t                       -- (in PostgreSQL the derived table is not required, but it is harmless)
    WHERE rn > 1
);

-- * Q142. Customers who bought product 'A' but never product 'B'.
SELECT customer_id
FROM orders
GROUP BY customer_id
HAVING BOOL_OR(product = 'A')
   AND NOT BOOL_OR(product = 'B');

-- or with FILTER:
-- HAVING COUNT(*) FILTER (WHERE product = 'A') > 0 AND COUNT(*) FILTER (WHERE product = 'B') = 0

-- * Q143. Employees earning more than their department's average.
SELECT name, department, salary, ROUND(dept_avg) AS dept_avg
FROM (
    SELECT name, department, salary,
           AVG(salary) OVER (PARTITION BY department) AS dept_avg
    FROM employees
) t
WHERE salary > dept_avg;

--   * Output: IT average = 82500 → Amit, Neha, Ravi · HR average = 57500 → John.

-- * Q144. Find missing ids in a sequence (gaps).
SELECT id + 1 AS gap_start,
       next_id - 1 AS gap_end
FROM (
    SELECT id, LEAD(id) OVER (ORDER BY id) AS next_id
    FROM invoices
) t
WHERE next_id - id > 1;

--   * Output example: ids 1, 2, 3, 7, 8 → `4 | 6`.

-- * Q145. Scenario: design the tables for a small e-commerce store.
CREATE TABLE customers (
    customer_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name        VARCHAR(100) NOT NULL,
    email       VARCHAR(150) NOT NULL UNIQUE,
    created_at  TIMESTAMPTZ DEFAULT now()
);
CREATE TABLE products (
    product_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name       VARCHAR(150) NOT NULL,
    price      NUMERIC(10,2) NOT NULL CHECK (price >= 0),
    stock      INT NOT NULL DEFAULT 0 CHECK (stock >= 0)
);
CREATE TABLE orders (
    order_id    INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    customer_id INT NOT NULL REFERENCES customers(customer_id),
    order_date  TIMESTAMPTZ DEFAULT now(),
    status      VARCHAR(20) NOT NULL DEFAULT 'placed'
                CHECK (status IN ('placed','shipped','delivered','cancelled'))
);
CREATE INDEX idx_orders_customer_date ON orders (customer_id, order_date);   -- also indexes the FK

CREATE TABLE order_items (
    order_id   INT,
    product_id INT,
    quantity   INT NOT NULL CHECK (quantity > 0),
    unit_price NUMERIC(10,2) NOT NULL,          -- price at the time of the order
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (order_id)   REFERENCES orders(order_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);
CREATE INDEX idx_order_items_product ON order_items (product_id);            -- PostgreSQL doesn't index FKs automatically

--   * What the interviewer checks: 1:N (customer → orders), M:N through `order_items`, keys and constraints, `DECIMAL` for money, the price copied into `order_items` (history), an index for "orders of a customer by date", and (PostgreSQL) indexes on foreign key columns.

-- ======================================================================
-- 🎯 Practice Questions (salesdb sample data) — try first, then look at the answer
-- ======================================================================
-- Run 00-Setup-Sample-Data.sql once before this section.

SET search_path TO sales;

-- Q1. (Most asked) Second highest salary.
SELECT MAX(salary) AS second_highest FROM employees WHERE salary < (SELECT MAX(salary) FROM employees);

-- Q2. (Most asked) Nth highest salary with DENSE_RANK (N = 3).
SELECT firstname, salary
FROM (SELECT firstname, salary, DENSE_RANK() OVER (ORDER BY salary DESC) AS rnk FROM employees) t
WHERE rnk = 3;

-- Q3. (Most asked) Find duplicate rows in orders_archive.
SELECT orderid, COUNT(*) FROM ordersarchive GROUP BY orderid HAVING COUNT(*) > 1;

-- Q4. (Most asked) Highest paid employee in each department.
SELECT department, firstname, salary
FROM (SELECT department, firstname, salary,
             ROW_NUMBER() OVER (PARTITION BY department ORDER BY salary DESC) AS rn
      FROM employees) t
WHERE rn = 1;

-- Q5. (Most asked) Employees earning more than their manager.
SELECT e.firstname, e.salary, m.firstname AS manager, m.salary AS manager_salary
FROM employees e JOIN employees m ON m.employeeid = e.managerid
WHERE e.salary > m.salary;
