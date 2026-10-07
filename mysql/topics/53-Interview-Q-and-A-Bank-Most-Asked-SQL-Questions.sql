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
USE salesdb;
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
--     - Short Answer : Software that manages a database (security, many users, backup). An RDBMS stores data in related tables — e.g., MySQL, PostgreSQL, Oracle.
--     - See          : 2.1, 2.6
--
-- * 3
--     - Question     : What is SQL?
--     - Short Answer : Structured Query Language — the standard language to create, read, update and delete data in relational databases.
--     - See          : 3.1
--
-- * 4
--     - Question     : SQL vs MySQL?
--     - Short Answer : SQL is the language; MySQL is the software (RDBMS) that understands SQL and stores the data.
--     - See          : Topic 8
--
-- * 5
--     - Question     : SQL vs NoSQL?
--     - Short Answer : SQL = tables with a fixed schema and relations (MySQL). NoSQL = flexible formats: key-value, document, column, graph (Redis, MongoDB, Cassandra, Neo4j).
--     - See          : Topic 4
--
-- * 6
--     - Question     : What is a schema?
--     - Short Answer : A logical folder inside a database that groups tables; also means the structure (blueprint) of the tables.
--     - See          : 6.4
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
--     - Question     : CHAR vs VARCHAR?
--     - Short Answer : CHAR(n) is fixed length (padded with spaces); VARCHAR(n) stores only the actual length + 1–2 bytes.
--     - See          : 6.8.3
--
-- * 9
--     - Question     : DATETIME vs TIMESTAMP?
--     - Short Answer : DATETIME: 1000–9999, no time zone conversion. TIMESTAMP: 1970–2038, stored in UTC and shown in the session time zone.
--     - See          : 6.8.6
--
-- * 10
--     - Question     : Which data type for money?
--     - Short Answer : DECIMAL(p, s) — it is exact. Never FLOAT/DOUBLE (they are approximate).
--     - See          : 6.8.2
--
-- * 11
--     - Question     : What is BOOLEAN in MySQL?
--     - Short Answer : Just an alias for TINYINT(1) — stores 0 (false) or 1 (true).
--     - See          : 6.8.3
--
-- * 12
--     - Question     : ENUM vs SET?
--     - Short Answer : ENUM stores one value from a list; SET can store many values from a list.
--     - See          : 6.8.3
--

-- ------------------------------------------------------------
-- 53.3 Part C: DDL, DML & Command Types
-- ------------------------------------------------------------

-- (# → Question | Short Answer | See)
--
-- * 13
--     - Question     : Types of SQL commands?
--     - Short Answer : DDL (CREATE, ALTER, DROP, TRUNCATE, RENAME), DML (INSERT, UPDATE, DELETE), DQL (SELECT), DCL (GRANT, REVOKE), TCL (COMMIT, ROLLBACK, SAVEPOINT).
--     - See          : 9.2
--
-- * 14
--     - Question     : DELETE vs TRUNCATE vs DROP?
--     - Short Answer : DELETE: removes chosen rows, DML, can rollback. TRUNCATE: empties the whole table fast, DDL, resets AUTO_INCREMENT, no rollback. DROP: removes the table itself.
--     - See          : 9.12
--
-- * 15
--     - Question     : Can we rollback DDL in MySQL?
--     - Short Answer : No. DDL does an implicit commit — it also commits any pending changes before it.
--     - See          : 9.4, 15.7
--
-- * 16
--     - Question     : ALTER vs UPDATE?
--     - Short Answer : ALTER (DDL) changes the table structure; UPDATE (DML) changes the data in rows.
--     - See          : 11.9
--
-- * 17
--     - Question     : MODIFY vs CHANGE in ALTER TABLE?
--     - Short Answer : MODIFY changes the data type only; CHANGE renames the column and can change its type.
--     - See          : 9.6
--
-- * 18
--     - Question     : Can we rename a database in MySQL?
--     - Short Answer : No direct command. Create a new database, move tables with RENAME TABLE old_db.t TO new_db.t, then drop the old one.
--     - See          : 9.11
--
-- * 19
--     - Question     : What is safe update mode?
--     - Short Answer : SQL_SAFE_UPDATES = 1 blocks UPDATE/DELETE without a key column in WHERE or a LIMIT.
--     - See          : 11.5
--
-- * 20
--     - Question     : REPLACE vs INSERT ... ON DUPLICATE KEY UPDATE?
--     - Short Answer : REPLACE deletes the old row and inserts a new one (other columns reset). ON DUPLICATE KEY UPDATE updates the existing row in place.
--     - See          : 11.8
--
-- * 21
--     - Question     : Soft delete vs hard delete?
--     - Short Answer : Hard delete physically removes the row (DELETE). Soft delete only marks it (UPDATE ... SET is_deleted = 1), so it can be restored.
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
--     - Question     : ON DELETE CASCADE vs RESTRICT vs SET NULL?
--     - Short Answer : CASCADE deletes child rows too; RESTRICT (MySQL default behaviour) blocks the delete; SET NULL keeps child rows but sets the FK to NULL.
--     - See          : 11.7
--
-- * 26
--     - Question     : Super, Candidate, Alternate, Composite, Surrogate key?
--     - Short Answer : Super = any set that identifies a row; Candidate = minimal super key; Alternate = candidate not chosen as PK; Composite = key of 2+ columns; Surrogate = artificial ID like AUTO_INCREMENT.
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
--     - Question     : What is ONLY_FULL_GROUP_BY?
--     - Short Answer : A mode that requires every selected column to be either in GROUP BY or inside an aggregate function (error 1055 otherwise).
--     - See          : 20.9
--
-- * 39
--     - Question     : LIMIT vs TOP? Pagination?
--     - Short Answer : MySQL uses LIMIT, SQL Server uses TOP. Page 3 with 10 rows per page: LIMIT 10 OFFSET 20.
--     - See          : 20.12
--

-- ------------------------------------------------------------
-- 53.6 Part F: Joins & SET Operators
-- ------------------------------------------------------------

-- (# → Question | Short Answer | See)
--
-- * 40
--     - Question     : Types of joins?
--     - Short Answer : INNER, LEFT, RIGHT, FULL (not in MySQL), CROSS, SELF, plus anti-joins (LEFT/RIGHT/FULL ANTI).
--     - See          : Topic 21
--
-- * 41
--     - Question     : INNER JOIN vs LEFT JOIN?
--     - Short Answer : Inner = only matching rows. Left = all rows of the left table + matches (NULL where no match).
--     - See          : Topic 21
--
-- * 42
--     - Question     : How to do a FULL JOIN in MySQL?
--     - Short Answer : LEFT JOIN ... UNION ... RIGHT JOIN.
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
--     - Question     : IFNULL vs COALESCE?
--     - Short Answer : IFNULL(a, b) takes 2 values; COALESCE(a, b, c, ...) returns the first non-NULL of many (and is standard SQL).
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
--     - Question     : DATEDIFF vs TIMESTAMPDIFF in MySQL?
--     - Short Answer : DATEDIFF(end, start) gives days only; TIMESTAMPDIFF(unit, start, end) gives years, months, hours, etc.
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
--     - Question     : Isolation levels & MySQL default?
--     - Short Answer : READ UNCOMMITTED, READ COMMITTED, REPEATABLE READ (MySQL default), SERIALIZABLE.
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
--     - Short Answer : Two transactions wait for each other's locks. InnoDB detects it and rolls back one (error 1213).
--     - See          : 15.7
--
-- * 65
--     - Question     : Is autocommit on by default?
--     - Short Answer : Yes. Each statement is committed immediately unless you use START TRANSACTION or SET autocommit = 0.
--     - See          : 15.7
--
-- * 66
--     - Question     : GRANT vs REVOKE? Is FLUSH PRIVILEGES needed?
--     - Short Answer : GRANT ... TO gives permission; REVOKE ... FROM removes it. FLUSH PRIVILEGES is not needed after them.
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
DELETE c1
FROM customers c1
JOIN customers c2
  ON c1.email = c2.email
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
--     - Short Answer : Explicit: you write START TRANSACTION ... COMMIT. Implicit: MySQL commits by itself — after each statement when autocommit is ON, and before/after every DDL.
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
--     - Short Answer : FOR UPDATE takes X locks on the rows read (others can't change or lock them); FOR SHARE takes S locks (others can read but not change). Both only inside a transaction.
--     - See          : Topic 19
--
-- * 82
--     - Question     : Optimistic vs pessimistic locking?
--     - Short Answer : Pessimistic: lock first (FOR UPDATE) — safe under heavy conflict. Optimistic: no lock; a version column is checked in the UPDATE ... WHERE version = ? — fast when conflicts are rare.
--     - See          : Topic 19
--
-- * 83
--     - Question     : Row lock vs table lock?
--     - Short Answer : InnoDB locks only the index records it touches (row-level, high concurrency); LOCK TABLES / MyISAM lock the whole table.
--     - See          : Topic 19
--
-- * 84
--     - Question     : What are gap / next-key locks?
--     - Short Answer : Locks on the gap between index records (plus the record) used by REPEATABLE READ to stop phantom inserts into a range.
--     - See          : Topic 19
--
-- * 85
--     - Question     : Deadlock vs lock wait timeout?
--     - Short Answer : Deadlock = cycle, InnoDB rolls one back at once (error 1213). Timeout = one transaction waited longer than innodb_lock_wait_timeout (error 1205).
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
--     - Short Answer : A B+Tree structure that lets MySQL jump to rows instead of scanning the whole table — faster reads, slower writes.
--     - See          : Topic 41
--
-- * 88
--     - Question     : Clustered vs non-clustered index?
--     - Short Answer : Clustered = the table itself stored in key order (InnoDB primary key, only one). Secondary (non-clustered) = separate tree holding the primary key as the pointer (many allowed).
--     - See          : Topic 41, Topic 42
--
-- * 89
--     - Question     : What is a covering index?
--     - Short Answer : An index that contains every column the query needs, so the table is never read (EXPLAIN → Using index).
--     - See          : Topic 48
--
-- * 90
--     - Question     : Composite index (a, b, c) — which queries use it?
--     - Short Answer : Queries filtering on a, a,b or a,b,c (leftmost prefix). Filtering only on b or c usually can't.
--     - See          : Topic 41
--
-- * 91
--     - Question     : When is an index NOT used?
--     - Short Answer : Function on the column (YEAR(d)=2025), leading wildcard (LIKE '%x'), type mismatch, OR on unindexed columns, low selectivity, or the optimizer thinks a full scan is cheaper.
--     - See          : Topic 47, Topic 48
--
-- * 92
--     - Question     : Why not index every column?
--     - Short Answer : Every index costs disk space and must be updated on each INSERT/UPDATE/DELETE, slowing writes.
--     - See          : Topic 41
--
-- * 93
--     - Question     : EXPLAIN vs EXPLAIN ANALYZE?
--     - Short Answer : EXPLAIN shows the estimated plan without running; EXPLAIN ANALYZE runs the query and shows actual time and rows per step.
--     - See          : Topic 43
--
-- * 94
--     - Question     : What does type = ALL mean in EXPLAIN?
--     - Short Answer : Full table scan — usually a missing or unusable index.
--     - See          : Topic 43, Topic 44
--
-- * 95
--     - Question     : How do you optimize a slow query?
--     - Short Answer : Measure (EXPLAIN), select fewer columns, filter early, add the right (covering/composite) index, fix joins, avoid functions on indexed columns, then consider partitioning/caching.
--     - See          : Topic 47, Topic 48
--
-- * 96
--     - Question     : What is partition pruning?
--     - Short Answer : MySQL reads only the partitions that can contain matching rows (e.g. only p2025 for a 2025 date filter).
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
--     - Short Answer : A named block of SQL saved in the database and run with CALL name(...); can have IN/OUT/INOUT parameters, variables, IF/loops, handlers and transactions.
--     - See          : Topic 35
--
-- * 100
--     - Question     : IN vs OUT vs INOUT?
--     - Short Answer : IN passes a value in; OUT returns a value in a @variable; INOUT goes in, is changed and comes back.
--     - See          : Topic 35
--
-- * 101
--     - Question     : Why is DELIMITER needed?
--     - Short Answer : So the client doesn't end the CREATE PROCEDURE at the first ; inside the body.
--     - See          : Topic 35
--
-- * 102
--     - Question     : Can a procedure parameter have a DEFAULT in MySQL?
--     - Short Answer : No. Pass NULL and set the default inside with IF p IS NULL THEN SET p = ....
--     - See          : Topic 35
--
-- * 103
--     - Question     : Procedure vs function?
--     - Short Answer : Procedure = action, CALL, OUT params, transactions. Function = returns one value, usable inside SELECT/WHERE, no COMMIT.
--     - See          : Topic 36
--
-- * 104
--     - Question     : What is a trigger?
--     - Short Answer : SQL that runs automatically BEFORE/AFTER an INSERT, UPDATE or DELETE on a table, once per row, with OLD/NEW values.
--     - See          : Topic 37
--
-- * 105
--     - Question     : Give 3 real uses of triggers.
--     - Short Answer : Audit log of salary changes, validation with SIGNAL, keeping a derived total (e.g. stock or total sales) in sync.
--     - See          : Topic 37
--
-- * 106
--     - Question     : What is an event?
--     - Short Answer : A scheduled job inside MySQL (CREATE EVENT ... ON SCHEDULE AT/EVERY ... DO ...); needs event_scheduler = ON.
--     - See          : Topic 38
--
-- * 107
--     - Question     : Trigger vs event?
--     - Short Answer : Trigger fires on a data change, immediately; event fires on a time schedule.
--     - See          : Topic 38
--
-- * 108
--     - Question     : What is a cursor?
--     - Short Answer : A pointer used inside a stored program to read a result set one row at a time: DECLARE → OPEN → FETCH (loop) → CLOSE, with a NOT FOUND handler to stop.
--     - See          : Topic 39
--
-- * 109
--     - Question     : Why avoid cursors when possible?
--     - Short Answer : They process row by row (slow); a single set-based UPDATE/INSERT ... SELECT is usually much faster.
--     - See          : Topic 39
--
-- * 110
--     - Question     : How do you handle errors in a procedure?
--     - Short Answer : DECLARE CONTINUE/EXIT HANDLER FOR SQLEXCEPTION, GET DIAGNOSTICS to read the message, SIGNAL/RESIGNAL to raise errors, and ROLLBACK in the handler for transactions.
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
--     - Short Answer : A view re-runs its query every time (always fresh); a materialized view stores the result (fast, but must be refreshed). MySQL has no materialized views — use a summary table + event.
--     - See          : Topic 32
--
-- * 113
--     - Question     : When is a view updatable?
--     - Short Answer : When it is based on one table without GROUP BY, DISTINCT, aggregates, UNION or window functions.
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
--     - Question     : What causes MySQL error 1093 and how do you fix it?
--     - Short Answer : Updating/deleting a table while selecting from the same table in a subquery. Wrap the subquery in a derived table or use a JOIN.
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
--     - Short Answer : Natural key comes from the data (email, PAN); surrogate key is an artificial id (AUTO_INCREMENT) — stable and small, preferred as the primary key.
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
--     - Short Answer : A query sent once with ? placeholders; values are sent separately and are never treated as SQL (PREPARE ... ; EXECUTE ... USING @v;).
--     - See          : Topic 14
--
-- * 132
--     - Question     : Principle of least privilege?
--     - Short Answer : Give each user/app only the rights it needs (e.g. GRANT SELECT, INSERT ON shop.orders TO 'app'@'%'), never root.
--     - See          : Topic 13
--
-- * 133
--     - Question     : Logical vs physical backup?
--     - Short Answer : Logical = SQL statements (mysqldump), portable but slow to restore; physical = copy of data files (XtraBackup), fast for big databases.
--     - See          : Topic 51
--
-- * 134
--     - Question     : Is replication a backup?
--     - Short Answer : No — a DROP TABLE is replicated to every replica. Replication is for read scaling and high availability; you still need backups and binlogs for point-in-time recovery.
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
    SELECT DISTINCT user_id, DATE(login_time) AS login_date
    FROM logins
),
n AS (                            -- number each user's login days in order
    SELECT user_id, login_date,
           ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY login_date) AS rn
    FROM d
),
g AS (                            -- same "island" => same (date - rn)
    SELECT user_id, login_date,
           DATE_SUB(login_date, INTERVAL rn DAY) AS grp
    FROM n
)
SELECT user_id, MIN(login_date) AS streak_start, MAX(login_date) AS streak_end, COUNT(*) AS days
FROM g
GROUP BY user_id, grp
HAVING COUNT(*) >= 3;

--   * Idea: for consecutive dates, `date - row_number` stays the same (1 Oct − 1, 2 Oct − 2, 3 Oct − 3 → all 30 Sep), so each streak forms one group.

--   * Output example: user 7 logged in 1, 2, 3, 5 Oct → `7 | 2025-10-01 | 2025-10-03 | 3`.

-- * Q137. Median salary (MySQL has no MEDIAN function).
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
       SUM(CASE WHEN YEAR(order_date) = 2024 THEN sales ELSE 0 END) AS sales_2024,
       SUM(CASE WHEN YEAR(order_date) = 2025 THEN sales ELSE 0 END) AS sales_2025
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

-- * Q140. Percentage contribution and cumulative % of each product (Pareto / 80-20).
SELECT product, total,
       ROUND(100 * total / SUM(total) OVER (), 2) AS pct_of_total,
       ROUND(100 * SUM(total) OVER (ORDER BY total DESC ROWS UNBOUNDED PRECEDING) / SUM(total) OVER (), 2) AS cumulative_pct
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
    ) t                       -- derived table avoids MySQL error 1093
    WHERE rn > 1
);

-- * Q142. Customers who bought product 'A' but never product 'B'.
SELECT customer_id
FROM orders
GROUP BY customer_id
HAVING SUM(product = 'A') > 0
   AND SUM(product = 'B') = 0;

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
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    name        VARCHAR(100) NOT NULL,
    email       VARCHAR(150) NOT NULL UNIQUE,
    created_at  DATETIME DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    name       VARCHAR(150) NOT NULL,
    price      DECIMAL(10,2) NOT NULL CHECK (price >= 0),
    stock      INT NOT NULL DEFAULT 0
);
CREATE TABLE orders (
    order_id    INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date  DATETIME DEFAULT CURRENT_TIMESTAMP,
    status      ENUM('placed','shipped','delivered','cancelled') DEFAULT 'placed',
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    INDEX idx_orders_customer_date (customer_id, order_date)
);
CREATE TABLE order_items (
    order_id   INT,
    product_id INT,
    quantity   INT NOT NULL CHECK (quantity > 0),
    unit_price DECIMAL(10,2) NOT NULL,          -- price at the time of the order
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (order_id)   REFERENCES orders(order_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

--   * What the interviewer checks: 1:N (customer → orders), M:N through `order_items`, keys and constraints, `DECIMAL` for money, the price copied into `order_items` (history), and an index for "orders of a customer by date".

-- ======================================================================
-- 🎯 Practice Questions (salesdb sample data) — try first, then look at the answer
-- ======================================================================
-- Run 00-Setup-Sample-Data.sql once before this section.

USE salesdb;

-- Q1. (Most asked) Second highest salary.
SELECT MAX(salary) AS second_highest FROM employees WHERE salary < (SELECT MAX(salary) FROM employees);

-- Q2. (Most asked) Nth highest salary with DENSE_RANK (N = 3).
SELECT firstname, salary
FROM (SELECT firstname, salary, DENSE_RANK() OVER (ORDER BY salary DESC) AS rnk FROM employees) t
WHERE rnk = 3;

-- Q3. (Most asked) Find duplicate rows in orders_archive.
SELECT orderid, COUNT(*) FROM orders_archive GROUP BY orderid HAVING COUNT(*) > 1;

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
