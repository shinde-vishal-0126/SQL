-- ======================================================================
-- Topic 53: Interview Q&A Bank (Most-Asked SQL Questions)
-- ======================================================================

-- ------------------------------------------------------------
-- 📖 In Simple Words
-- ------------------------------------------------------------

-- * Definition: Interview questions test whether you can turn a business question into correct SQL — ranking, duplicates, top-N, joins and NULL handling come up again and again.

-- * Real-life example: Practice papers before the exam.

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

-- | # | Question | Short Answer | See |
-- | :---: | :--- | :--- | :---: |
-- | 1 | What is a database? | An organized collection of data stored so it can be easily saved, managed and retrieved. | 1.1 |
-- | 2 | What is a DBMS / RDBMS? | Software that manages a database (security, many users, backup). An RDBMS stores data in related tables — e.g., MySQL, PostgreSQL, Oracle. | 2.1, 2.6 |
-- | 3 | What is SQL? | Structured Query Language — the standard language to create, read, update and delete data in relational databases. | 3.1 |
-- | 4 | SQL vs MySQL? | SQL is the language; MySQL is the software (RDBMS) that understands SQL and stores the data. | Topic 8 |
-- | 5 | SQL vs NoSQL? | SQL = tables with a fixed schema and relations (MySQL). NoSQL = flexible formats: key-value, document, column, graph (Redis, MongoDB, Cassandra, Neo4j). | Topic 4 |
-- | 6 | What is a schema? | A logical folder inside a database that groups tables; also means the structure (blueprint) of the tables. | 6.4 |
-- | 7 | What is CRUD? | Create (`INSERT`), Read (`SELECT`), Update (`UPDATE`), Delete (`DELETE`). | 3.3 |

-- ------------------------------------------------------------
-- 53.2 Part B: Data Types
-- ------------------------------------------------------------

-- | # | Question | Short Answer | See |
-- | :---: | :--- | :--- | :---: |
-- | 8 | `CHAR` vs `VARCHAR`? | `CHAR(n)` is fixed length (padded with spaces); `VARCHAR(n)` stores only the actual length + 1–2 bytes. | 6.8.3 |
-- | 9 | `DATETIME` vs `TIMESTAMP`? | `DATETIME`: 1000–9999, no time zone conversion. `TIMESTAMP`: 1970–2038, stored in UTC and shown in the session time zone. | 6.8.6 |
-- | 10 | Which data type for money? | `DECIMAL(p, s)` — it is exact. Never `FLOAT`/`DOUBLE` (they are approximate). | 6.8.2 |
-- | 11 | What is `BOOLEAN` in MySQL? | Just an alias for `TINYINT(1)` — stores 0 (false) or 1 (true). | 6.8.3 |
-- | 12 | `ENUM` vs `SET`? | `ENUM` stores one value from a list; `SET` can store many values from a list. | 6.8.3 |

-- ------------------------------------------------------------
-- 53.3 Part C: DDL, DML & Command Types
-- ------------------------------------------------------------

-- | # | Question | Short Answer | See |
-- | :---: | :--- | :--- | :---: |
-- | 13 | Types of SQL commands? | DDL (`CREATE`, `ALTER`, `DROP`, `TRUNCATE`, `RENAME`), DML (`INSERT`, `UPDATE`, `DELETE`), DQL (`SELECT`), DCL (`GRANT`, `REVOKE`), TCL (`COMMIT`, `ROLLBACK`, `SAVEPOINT`). | 9.2 |
-- | 14 | `DELETE` vs `TRUNCATE` vs `DROP`? | `DELETE`: removes chosen rows, DML, can rollback. `TRUNCATE`: empties the whole table fast, DDL, resets `AUTO_INCREMENT`, no rollback. `DROP`: removes the table itself. | 9.12 |
-- | 15 | Can we rollback DDL in MySQL? | No. DDL does an implicit commit — it also commits any pending changes before it. | 9.4, 15.7 |
-- | 16 | `ALTER` vs `UPDATE`? | `ALTER` (DDL) changes the table structure; `UPDATE` (DML) changes the data in rows. | 11.9 |
-- | 17 | `MODIFY` vs `CHANGE` in `ALTER TABLE`? | `MODIFY` changes the data type only; `CHANGE` renames the column and can change its type. | 9.6 |
-- | 18 | Can we rename a database in MySQL? | No direct command. Create a new database, move tables with `RENAME TABLE old_db.t TO new_db.t`, then drop the old one. | 9.11 |
-- | 19 | What is safe update mode? | `SQL_SAFE_UPDATES = 1` blocks `UPDATE`/`DELETE` without a key column in `WHERE` or a `LIMIT`. | 11.5 |
-- | 20 | `REPLACE` vs `INSERT ... ON DUPLICATE KEY UPDATE`? | `REPLACE` deletes the old row and inserts a new one (other columns reset). `ON DUPLICATE KEY UPDATE` updates the existing row in place. | 11.8 |
-- | 21 | Soft delete vs hard delete? | Hard delete physically removes the row (`DELETE`). Soft delete only marks it (`UPDATE ... SET is_deleted = 1`), so it can be restored. | 11.6 |

-- ------------------------------------------------------------
-- 53.4 Part D: Keys & Constraints
-- ------------------------------------------------------------

-- | # | Question | Short Answer | See |
-- | :---: | :--- | :--- | :---: |
-- | 22 | What is a Primary Key? | A column (or columns) that uniquely identifies each row. Unique, not NULL, only one per table. | 6.7, Topic 10 |
-- | 23 | Primary Key vs Unique Key? | Primary: one per table, no NULL. Unique: many per table, NULL allowed. | Topic 10 |
-- | 24 | What is a Foreign Key? | A column that refers to the Primary Key of another table, so child rows always point to a real parent row (referential integrity). | 11.7, Topic 10 |
-- | 25 | `ON DELETE CASCADE` vs `RESTRICT` vs `SET NULL`? | CASCADE deletes child rows too; RESTRICT (MySQL default behaviour) blocks the delete; SET NULL keeps child rows but sets the FK to NULL. | 11.7 |
-- | 26 | Super, Candidate, Alternate, Composite, Surrogate key? | Super = any set that identifies a row; Candidate = minimal super key; Alternate = candidate not chosen as PK; Composite = key of 2+ columns; Surrogate = artificial ID like `AUTO_INCREMENT`. | Topic 10 |
-- | 27 | Name the SQL constraints. | `PRIMARY KEY`, `FOREIGN KEY`, `UNIQUE`, `NOT NULL`, `CHECK`, `DEFAULT`. | 9.7, Topic 10 |

-- ------------------------------------------------------------
-- 53.5 Part E: Querying, Filtering, Grouping
-- ------------------------------------------------------------

-- | # | Question | Short Answer | See |
-- | :---: | :--- | :--- | :---: |
-- | 28 | Execution order of a `SELECT` query? | `FROM` → `WHERE` → `GROUP BY` → `HAVING` → `SELECT` → `DISTINCT` → `ORDER BY` → `LIMIT`. | 20.5, 20.12 |
-- | 29 | Can we use a `SELECT` alias in `WHERE`? | No — `WHERE` runs before `SELECT`. But you can use it in `ORDER BY`. | 20.12 |
-- | 30 | `WHERE` vs `HAVING`? | `WHERE` filters rows before grouping (no aggregates). `HAVING` filters groups after `GROUP BY` (aggregates allowed). | 20.12 |
-- | 31 | Can we use `HAVING` without `GROUP BY`? | Yes — the whole table is treated as one group. | 20.9 |
-- | 32 | Why is `SELECT *` bad in production? | It reads and sends unneeded columns, can't use covering indexes, and breaks when columns change. | 12.2 |
-- | 33 | `BETWEEN` — inclusive or exclusive? | Inclusive: both ends are included (`>= low AND <= high`). | 20.7.7 |
-- | 34 | `%` vs `_` in `LIKE`? | `%` = zero or more characters; `_` = exactly one character. | 20.7.9 |
-- | 35 | Why does `col = NULL` return nothing? | Any comparison with NULL gives UNKNOWN, not TRUE. Use `IS NULL` / `IS NOT NULL`. | 20.7.10 |
-- | 36 | What does `NOT IN (1, 2, NULL)` return? | Zero rows, because of the NULL. Use `NOT EXISTS` or filter NULLs out. | 20.7.8 |
-- | 37 | `COUNT(*)` vs `COUNT(col)` vs `COUNT(DISTINCT col)`? | All rows / non-NULL values / unique non-NULL values. | 20.9 |
-- | 38 | What is `ONLY_FULL_GROUP_BY`? | A mode that requires every selected column to be either in `GROUP BY` or inside an aggregate function (error 1055 otherwise). | 20.9 |
-- | 39 | `LIMIT` vs `TOP`? Pagination? | MySQL uses `LIMIT`, SQL Server uses `TOP`. Page 3 with 10 rows per page: `LIMIT 10 OFFSET 20`. | 20.12 |

-- ------------------------------------------------------------
-- 53.6 Part F: Joins & SET Operators
-- ------------------------------------------------------------

-- | # | Question | Short Answer | See |
-- | :---: | :--- | :--- | :---: |
-- | 40 | Types of joins? | INNER, LEFT, RIGHT, FULL (not in MySQL), CROSS, SELF, plus anti-joins (LEFT/RIGHT/FULL ANTI). | Topic 21 |
-- | 41 | `INNER JOIN` vs `LEFT JOIN`? | Inner = only matching rows. Left = all rows of the left table + matches (NULL where no match). | Topic 21 |
-- | 42 | How to do a `FULL JOIN` in MySQL? | `LEFT JOIN ... UNION ... RIGHT JOIN`. | Topic 21 |
-- | 43 | What is a self join? | Joining a table to itself with aliases, e.g., employee → manager. | Topic 21 |
-- | 44 | What is a cross join? | Every row of A × every row of B (Cartesian product), no `ON`. | Topic 21 |
-- | 45 | JOIN vs UNION? | JOIN adds columns (wider result); UNION adds rows (longer result). | Topic 22 |
-- | 46 | `UNION` vs `UNION ALL`? | `UNION` removes duplicates (slower); `UNION ALL` keeps all rows (faster). | Topic 22 |
-- | 47 | Rules for SET operators? | Same number of columns, compatible data types, same column order; `ORDER BY` only once at the end; names come from the first query. | Topic 22 |

-- ------------------------------------------------------------
-- 53.7 Part G: Functions, NULL & CASE
-- ------------------------------------------------------------

-- | # | Question | Short Answer | See |
-- | :---: | :--- | :--- | :---: |
-- | 48 | `IFNULL` vs `COALESCE`? | `IFNULL(a, b)` takes 2 values; `COALESCE(a, b, c, ...)` returns the first non-NULL of many (and is standard SQL). | Topic 25 |
-- | 49 | What is `NULLIF` used for? | `NULLIF(a, b)` returns NULL if a = b. Common use: avoid divide-by-zero → `x / NULLIF(qty, 0)`. | Topic 25 |
-- | 50 | What is `CASE`? | SQL's if-then-else. It checks conditions top to bottom and returns the first match; `ELSE` is the default. | Topic 25 |
-- | 51 | `DATEDIFF` vs `TIMESTAMPDIFF` in MySQL? | `DATEDIFF(end, start)` gives days only; `TIMESTAMPDIFF(unit, start, end)` gives years, months, hours, etc. | Topic 24 |
-- | 52 | Single-row vs aggregate functions? | Single-row: one input → one output per row (`UPPER`, `ROUND`). Aggregate: many rows → one result (`SUM`, `AVG`). | Topic 23 |

-- ------------------------------------------------------------
-- 53.8 Part H: Window Functions
-- ------------------------------------------------------------

-- | # | Question | Short Answer | See |
-- | :---: | :--- | :--- | :---: |
-- | 53 | What is a window function? | A function used with `OVER()` that calculates across related rows without collapsing them (unlike `GROUP BY`). | Topic 26 |
-- | 54 | `ROW_NUMBER` vs `RANK` vs `DENSE_RANK`? | For 100, 90, 90, 80 → 1,2,3,4 / 1,2,2,4 / 1,2,2,3. | Topic 26 |
-- | 55 | `PARTITION BY` vs `GROUP BY`? | Both make groups, but `PARTITION BY` keeps every row; `GROUP BY` returns one row per group. | Topic 26 |
-- | 56 | What do `LAG` and `LEAD` do? | Read the value from the previous (`LAG`) or next (`LEAD`) row — used for month-over-month comparisons. | Topic 26 |
-- | 57 | Running total vs rolling total? | Running = from the first row up to the current row. Rolling = a fixed window, e.g., the last 3 rows. | Topic 26 |
-- | 58 | Why does `LAST_VALUE` give a wrong answer? | The default frame ends at the current row. Use `ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING`. | Topic 26 |
-- | 59 | Can we use a window function in `WHERE`? | No — wrap the query in a subquery/CTE and filter outside. | Topic 26 |

-- ------------------------------------------------------------
-- 53.9 Part I: Transactions & Security
-- ------------------------------------------------------------

-- | # | Question | Short Answer | See |
-- | :---: | :--- | :--- | :---: |
-- | 60 | What are ACID properties? | Atomicity (all or nothing), Consistency (valid state), Isolation (transactions don't disturb each other), Durability (saved even after a crash). | 15.2 |
-- | 61 | Isolation levels & MySQL default? | READ UNCOMMITTED, READ COMMITTED, REPEATABLE READ (MySQL default), SERIALIZABLE. | 15.6 |
-- | 62 | Dirty read / non-repeatable read / phantom read? | Reading uncommitted data / same row gives a different value on re-read / new rows appear on re-run of a range query. | 15.6 |
-- | 63 | What is a savepoint? | A checkpoint inside a transaction; `ROLLBACK TO sp` undoes only the changes after it. | 15.3 |
-- | 64 | What is a deadlock? | Two transactions wait for each other's locks. InnoDB detects it and rolls back one (error 1213). | 15.7 |
-- | 65 | Is autocommit on by default? | Yes. Each statement is committed immediately unless you use `START TRANSACTION` or `SET autocommit = 0`. | 15.7 |
-- | 66 | `GRANT` vs `REVOKE`? Is `FLUSH PRIVILEGES` needed? | `GRANT ... TO` gives permission; `REVOKE ... FROM` removes it. `FLUSH PRIVILEGES` is not needed after them. | Topic 13 |

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

-- | # | Question | Short Answer | See |
-- | :---: | :--- | :--- | :---: |
-- | 77 | What is a transaction? | A group of SQL statements that succeed together (`COMMIT`) or are undone together (`ROLLBACK`). | Topic 17 |
-- | 78 | Explicit vs implicit commit? | Explicit: you write `START TRANSACTION ... COMMIT`. Implicit: MySQL commits by itself — after each statement when autocommit is ON, and before/after every DDL. | Topic 17 |
-- | 79 | What are the 5 transaction states? | Active → Partially Committed → Committed → Terminated; or Failed → Aborted (rolled back) → Terminated. | Topic 17 |
-- | 80 | Shared (S) vs exclusive (X) lock? | S = read lock, many transactions can hold it together; X = write lock, only one holder and it blocks S and X locks from others. | Topic 19 |
-- | 81 | `SELECT ... FOR UPDATE` vs `FOR SHARE`? | `FOR UPDATE` takes X locks on the rows read (others can't change or lock them); `FOR SHARE` takes S locks (others can read but not change). Both only inside a transaction. | Topic 19 |
-- | 82 | Optimistic vs pessimistic locking? | Pessimistic: lock first (`FOR UPDATE`) — safe under heavy conflict. Optimistic: no lock; a `version` column is checked in the `UPDATE ... WHERE version = ?` — fast when conflicts are rare. | Topic 19 |
-- | 83 | Row lock vs table lock? | InnoDB locks only the index records it touches (row-level, high concurrency); `LOCK TABLES` / MyISAM lock the whole table. | Topic 19 |
-- | 84 | What are gap / next-key locks? | Locks on the gap between index records (plus the record) used by `REPEATABLE READ` to stop phantom inserts into a range. | Topic 19 |
-- | 85 | Deadlock vs lock wait timeout? | Deadlock = cycle, InnoDB rolls one back at once (error 1213). Timeout = one transaction waited longer than `innodb_lock_wait_timeout` (error 1205). | Topic 18 |
-- | 86 | How do you avoid lost updates when two users edit the same row? | Lock with `SELECT ... FOR UPDATE` in a transaction, or use optimistic locking with a version column, or update atomically (`SET stock = stock - 1 WHERE stock > 0`). | Topic 19 |

-- ------------------------------------------------------------
-- 53.12 Part L: Indexes & Performance
-- ------------------------------------------------------------

-- | # | Question | Short Answer | See |
-- | :---: | :--- | :--- | :---: |
-- | 87 | What is an index and why use it? | A B+Tree structure that lets MySQL jump to rows instead of scanning the whole table — faster reads, slower writes. | Topic 41 |
-- | 88 | Clustered vs non-clustered index? | Clustered = the table itself stored in key order (InnoDB primary key, only one). Secondary (non-clustered) = separate tree holding the primary key as the pointer (many allowed). | Topic 41, Topic 42 |
-- | 89 | What is a covering index? | An index that contains every column the query needs, so the table is never read (`EXPLAIN` → `Using index`). | Topic 48 |
-- | 90 | Composite index `(a, b, c)` — which queries use it? | Queries filtering on `a`, `a,b` or `a,b,c` (leftmost prefix). Filtering only on `b` or `c` usually can't. | Topic 41 |
-- | 91 | When is an index NOT used? | Function on the column (`YEAR(d)=2025`), leading wildcard (`LIKE '%x'`), type mismatch, `OR` on unindexed columns, low selectivity, or the optimizer thinks a full scan is cheaper. | Topic 47, Topic 48 |
-- | 92 | Why not index every column? | Every index costs disk space and must be updated on each INSERT/UPDATE/DELETE, slowing writes. | Topic 41 |
-- | 93 | `EXPLAIN` vs `EXPLAIN ANALYZE`? | EXPLAIN shows the estimated plan without running; EXPLAIN ANALYZE runs the query and shows actual time and rows per step. | Topic 43 |
-- | 94 | What does `type = ALL` mean in EXPLAIN? | Full table scan — usually a missing or unusable index. | Topic 43, Topic 44 |
-- | 95 | How do you optimize a slow query? | Measure (EXPLAIN), select fewer columns, filter early, add the right (covering/composite) index, fix joins, avoid functions on indexed columns, then consider partitioning/caching. | Topic 47, Topic 48 |
-- | 96 | What is partition pruning? | MySQL reads only the partitions that can contain matching rows (e.g. only `p2025` for a 2025 date filter). | Topic 46 |
-- | 97 | `UNION` vs `UNION ALL` performance? | `UNION ALL` is faster because it skips the duplicate-removal step. | Topic 22, Topic 48 |
-- | 98 | OLTP vs OLAP? | OLTP = many small normalized transactions (app DB). OLAP = big analytical scans on denormalized/star-schema data (warehouse). | Topic 49 |

-- ------------------------------------------------------------
-- 53.13 Part M: Procedures, Functions, Triggers, Events & Cursors
-- ------------------------------------------------------------

-- | # | Question | Short Answer | See |
-- | :---: | :--- | :--- | :---: |
-- | 99 | What is a stored procedure? | A named block of SQL saved in the database and run with `CALL name(...)`; can have IN/OUT/INOUT parameters, variables, IF/loops, handlers and transactions. | Topic 35 |
-- | 100 | IN vs OUT vs INOUT? | IN passes a value in; OUT returns a value in a `@variable`; INOUT goes in, is changed and comes back. | Topic 35 |
-- | 101 | Why is `DELIMITER` needed? | So the client doesn't end the `CREATE PROCEDURE` at the first `;` inside the body. | Topic 35 |
-- | 102 | Can a procedure parameter have a DEFAULT in MySQL? | No. Pass NULL and set the default inside with `IF p IS NULL THEN SET p = ...`. | Topic 35 |
-- | 103 | Procedure vs function? | Procedure = action, `CALL`, OUT params, transactions. Function = returns one value, usable inside SELECT/WHERE, no COMMIT. | Topic 36 |
-- | 104 | What is a trigger? | SQL that runs automatically BEFORE/AFTER an INSERT, UPDATE or DELETE on a table, once per row, with OLD/NEW values. | Topic 37 |
-- | 105 | Give 3 real uses of triggers. | Audit log of salary changes, validation with `SIGNAL`, keeping a derived total (e.g. stock or total sales) in sync. | Topic 37 |
-- | 106 | What is an event? | A scheduled job inside MySQL (`CREATE EVENT ... ON SCHEDULE AT/EVERY ... DO ...`); needs `event_scheduler = ON`. | Topic 38 |
-- | 107 | Trigger vs event? | Trigger fires on a data change, immediately; event fires on a time schedule. | Topic 38 |
-- | 108 | What is a cursor? | A pointer used inside a stored program to read a result set one row at a time: DECLARE → OPEN → FETCH (loop) → CLOSE, with a NOT FOUND handler to stop. | Topic 39 |
-- | 109 | Why avoid cursors when possible? | They process row by row (slow); a single set-based UPDATE/INSERT ... SELECT is usually much faster. | Topic 39 |
-- | 110 | How do you handle errors in a procedure? | `DECLARE CONTINUE/EXIT HANDLER FOR SQLEXCEPTION`, `GET DIAGNOSTICS` to read the message, `SIGNAL`/`RESIGNAL` to raise errors, and `ROLLBACK` in the handler for transactions. | Topic 35 |

-- ------------------------------------------------------------
-- 53.14 Part N: Views, CTEs, Subqueries & Temporary Tables
-- ------------------------------------------------------------

-- | # | Question | Short Answer | See |
-- | :---: | :--- | :--- | :---: |
-- | 111 | What is a view? | A saved SELECT used like a table; stores no data (virtual table). | Topic 32 |
-- | 112 | View vs materialized view? | A view re-runs its query every time (always fresh); a materialized view stores the result (fast, but must be refreshed). MySQL has no materialized views — use a summary table + event. | Topic 32 |
-- | 113 | When is a view updatable? | When it is based on one table without GROUP BY, DISTINCT, aggregates, UNION or window functions. | Topic 32 |
-- | 114 | What does `WITH CHECK OPTION` do? | Blocks INSERT/UPDATE through the view that would create rows the view itself would not show. | Topic 32 |
-- | 115 | CTE vs subquery vs temporary table? | Subquery: inline, used once. CTE: named, reusable within one query, can be recursive. Temp table: lives for the session, can be indexed and reused by many queries. | Topic 30, Topic 33 |
-- | 116 | What is a recursive CTE used for? | Hierarchies (employee → manager), trees, and generating number/date series. Anchor + `UNION ALL` + recursive part. | Topic 31 |
-- | 117 | `IN` vs `EXISTS`? | EXISTS stops at the first match and is NULL-safe — best for "does a related row exist?". IN is fine for short fixed lists. `NOT IN` with a NULL returns nothing, so prefer `NOT EXISTS`. | Topic 27 |
-- | 118 | Correlated vs non-correlated subquery? | Correlated uses the outer row and runs per row; non-correlated runs once. | Topic 27, Topic 28 |
-- | 119 | What causes MySQL error 1093 and how do you fix it? | Updating/deleting a table while selecting from the same table in a subquery. Wrap the subquery in a derived table or use a JOIN. | Topic 27 |

-- ------------------------------------------------------------
-- 53.15 Part O: Database Design, Normalization & Data Warehousing
-- ------------------------------------------------------------

-- | # | Question | Short Answer | See |
-- | :---: | :--- | :--- | :---: |
-- | 120 | What is normalization and why? | Splitting data into related tables to remove duplication and update/insert/delete anomalies. | Topic 49 |
-- | 121 | 1NF, 2NF, 3NF in one line each? | 1NF: atomic values, no repeating groups. 2NF: no partial dependency on part of a composite key. 3NF: no transitive dependency (non-key depends only on the key). | Topic 49 |
-- | 122 | What is BCNF? | A stricter 3NF: every determinant must be a candidate key. | Topic 49 |
-- | 123 | When would you denormalize? | For read-heavy reporting/OLAP where joins are too slow — accept some duplication for speed. | Topic 49 |
-- | 124 | How do you model a many-to-many relationship? | A junction table with two foreign keys and a composite primary key. | Topic 50 |
-- | 125 | Fact table vs dimension table? | Fact = measurable events (amount, quantity) with foreign keys; dimension = descriptive attributes (product, date, customer). | Topic 49 |
-- | 126 | Star vs snowflake schema? | Star: fact joined directly to denormalized dimensions (fewer joins, faster). Snowflake: dimensions normalized into sub-tables (less duplication, more joins). | Topic 49 |
-- | 127 | What is a Slowly Changing Dimension type 2? | Keeping history by inserting a new row with `valid_from`, `valid_to`, `is_current` instead of overwriting. | Topic 49 |
-- | 128 | Natural key vs surrogate key? | Natural key comes from the data (email, PAN); surrogate key is an artificial id (`AUTO_INCREMENT`) — stable and small, preferred as the primary key. | Topic 10 |

-- ------------------------------------------------------------
-- 53.16 Part P: Security, Backup & Administration
-- ------------------------------------------------------------

-- | # | Question | Short Answer | See |
-- | :---: | :--- | :--- | :---: |
-- | 129 | What is SQL injection? | An attack where user input is concatenated into a SQL string and changes the query (e.g. `' OR '1'='1`). | Topic 14 |
-- | 130 | How do you prevent SQL injection? | Prepared statements / parameterized queries, input validation (allow-lists), least-privilege DB users, and never building SQL with string concatenation. | Topic 14 |
-- | 131 | What is a prepared statement? | A query sent once with `?` placeholders; values are sent separately and are never treated as SQL (`PREPARE ... ; EXECUTE ... USING @v;`). | Topic 14 |
-- | 132 | Principle of least privilege? | Give each user/app only the rights it needs (e.g. `GRANT SELECT, INSERT ON shop.orders TO 'app'@'%'`), never root. | Topic 13 |
-- | 133 | Logical vs physical backup? | Logical = SQL statements (`mysqldump`), portable but slow to restore; physical = copy of data files (XtraBackup), fast for big databases. | Topic 51 |
-- | 134 | Is replication a backup? | No — a `DROP TABLE` is replicated to every replica. Replication is for read scaling and high availability; you still need backups and binlogs for point-in-time recovery. | Topic 51 |

-- ------------------------------------------------------------
-- 53.17 Part Q: Advanced Query-Writing Questions (with Sample Output)
-- ------------------------------------------------------------

-- * Sample `employees` table used below:

-- | emp_id | name | department | salary |
-- | :---: | :--- | :--- | :---: |
-- | 1 | Amit | IT | 90000 |
-- | 2 | Neha | IT | 85000 |
-- | 3 | Ravi | IT | 85000 |
-- | 4 | Sara | IT | 70000 |
-- | 5 | John | HR | 60000 |
-- | 6 | Mary | HR | 55000 |

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
