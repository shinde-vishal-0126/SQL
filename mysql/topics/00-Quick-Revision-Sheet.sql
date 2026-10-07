-- ======================================================================
-- ⚡ Quick Revision Sheet (Read This Before the Interview)
-- ======================================================================

-- > One page to revise everything fast. Each point is explained in detail in the topics below.

-- ------------------------------------------------------------
-- A. The 5 Types of SQL Commands
-- ------------------------------------------------------------

-- (Type → Full Form | Commands | Works On | Can ROLLBACK?)
--
-- * DDL
--     - Full Form     : Data Definition Language
--     - Commands      : CREATE, ALTER, DROP, TRUNCATE, RENAME
--     - Works On      : Structure (tables, databases)
--     - Can ROLLBACK? : ❌ No (auto-commit in MySQL)
--
-- * DML
--     - Full Form     : Data Manipulation Language
--     - Commands      : INSERT, UPDATE, DELETE, REPLACE
--     - Works On      : Data (rows)
--     - Can ROLLBACK? : ✅ Yes (inside a transaction)
--
-- * DQL
--     - Full Form     : Data Query Language
--     - Commands      : SELECT
--     - Works On      : Reads data only
--     - Can ROLLBACK? : — (nothing to undo)
--
-- * DCL
--     - Full Form     : Data Control Language
--     - Commands      : GRANT, REVOKE
--     - Works On      : Permissions
--     - Can ROLLBACK? : ❌ No
--
-- * TCL
--     - Full Form     : Transaction Control Language
--     - Commands      : START TRANSACTION, COMMIT, ROLLBACK, SAVEPOINT
--     - Works On      : Transactions
--     - Can ROLLBACK? : —
--

-- ------------------------------------------------------------
-- B. Query Writing Order vs. Execution Order
-- ------------------------------------------------------------

-- ┌── (text — not SQL, shown for reference) ──
-- │ We WRITE :  SELECT → FROM → WHERE → GROUP BY → HAVING → ORDER BY → LIMIT
-- │ DB RUNS  :  FROM (+JOIN) → WHERE → GROUP BY → HAVING → SELECT (+window fn) → DISTINCT → ORDER BY → LIMIT
-- └──

-- * That is why a `SELECT` alias cannot be used in `WHERE`, but can be used in `ORDER BY`.

-- ------------------------------------------------------------
-- C. Most-Asked "Difference Between" Questions
-- ------------------------------------------------------------

-- (Question → Short Answer)
--
-- * DELETE vs TRUNCATE vs DROP
--     - Short Answer : DELETE removes chosen rows (DML, can rollback). TRUNCATE empties the table fast (DDL, resets AUTO_INCREMENT). DROP removes the whole table.
--
-- * WHERE vs HAVING
--     - Short Answer : WHERE filters rows before grouping; HAVING filters groups after GROUP BY (can use SUM, COUNT…).
--
-- * UNION vs UNION ALL
--     - Short Answer : UNION removes duplicates (slower); UNION ALL keeps all rows (faster).
--
-- * CHAR vs VARCHAR
--     - Short Answer : CHAR(n) always uses n characters (padded); VARCHAR(n) uses only the actual length + 1–2 bytes.
--
-- * DATETIME vs TIMESTAMP
--     - Short Answer : DATETIME: 1000–9999, no time zone change. TIMESTAMP: 1970–2038, stored in UTC and converted to your time zone.
--
-- * PRIMARY KEY vs UNIQUE
--     - Short Answer : Primary key: only one per table, no NULL. Unique: many per table, NULL allowed.
--
-- * INNER JOIN vs LEFT JOIN
--     - Short Answer : Inner = only matching rows. Left = all rows from the left table + matches (NULL if no match).
--
-- * ROW_NUMBER vs RANK vs DENSE_RANK
--     - Short Answer : For values 100, 90, 90, 80 → ROW_NUMBER: 1,2,3,4 · RANK: 1,2,2,4 · DENSE_RANK: 1,2,2,3
--
-- * COUNT(*) vs COUNT(col)
--     - Short Answer : COUNT(*) counts all rows; COUNT(col) counts only non-NULL values.
--
-- * GROUP BY vs Window function
--     - Short Answer : GROUP BY gives one row per group; a window function keeps every row and adds the result next to it.
--
-- * Subquery vs JOIN
--     - Short Answer : A JOIN combines columns from tables; a subquery uses one query's result inside another. JOINs are usually faster and easier to read.
--
-- * Clustered vs Non-clustered index
--     - Short Answer : Clustered = table rows are stored in key order (the Primary Key in InnoDB, only one). Non-clustered (secondary) = a separate structure pointing to the rows (many allowed).
--

-- ------------------------------------------------------------
-- D. NULL Rules (Very Common Traps)
-- ------------------------------------------------------------

-- * `NULL` means unknown — it is not `0` and not `''`.

-- * `col = NULL` is never true → always use `IS NULL` / `IS NOT NULL`.

-- * `NOT IN (1, 2, NULL)` returns 0 rows → use `NOT EXISTS` instead.

-- * `SUM`, `AVG`, `COUNT(col)`, `MIN`, `MAX` ignore NULLs. `SUM` of an empty group returns `NULL`, not `0` → wrap in `COALESCE(SUM(col), 0)`.

-- * Replace NULL: `IFNULL(a, b)` (2 values) or `COALESCE(a, b, c, ...)` (first non-NULL).

-- ------------------------------------------------------------
-- E. Top 10 Things Interviewers Love to Ask
-- ------------------------------------------------------------

-- 1. Execution order of a query (section B above).

-- 2. Nth highest salary (see Topic 53, Part J).

-- 3. Find and delete duplicate rows (see Topic 53, Part J).

-- 4. Customers who never placed an order → `LEFT JOIN ... WHERE o.customer_id IS NULL` or `NOT EXISTS` (see Topic 21).

-- 5. `RANK` vs `DENSE_RANK` vs `ROW_NUMBER` (see Topic 26).

-- 6. ACID properties and isolation levels — MySQL default = `REPEATABLE READ` (see Topic 15).

-- 7. `NOT IN` with `NULL` returns 0 rows (see 20.7.8).

-- 8. `DELETE` vs `TRUNCATE` vs `DROP` (see 9.12).

-- 9. `WHERE` vs `HAVING` (see 20.12), and `UNION` vs `UNION ALL` (see Topic 22).

-- 10. Primary Key vs Unique Key, and types of keys (see Topic 10).

-- ------------------------------------------------------------
-- F. Transactions & Locks (One Look)
-- ------------------------------------------------------------

-- * `START TRANSACTION` → statements → `COMMIT` (save all) or `ROLLBACK` (undo all); `SAVEPOINT sp` + `ROLLBACK TO sp` undoes part (see Topic 17).

-- * Autocommit is ON by default; DDL (`CREATE`, `ALTER`, `DROP`, `TRUNCATE`) commits implicitly and can't be rolled back (see Topic 17).

-- * Isolation levels: READ UNCOMMITTED → READ COMMITTED → REPEATABLE READ (MySQL default) → SERIALIZABLE (see Topic 15).

-- * Locks: shared (read) vs exclusive (write); `SELECT ... FOR UPDATE` locks rows for your transaction; optimistic locking uses a `version` column (see Topic 19).

-- * Deadlock → InnoDB rolls one transaction back (error 1213); fix by same access order + short transactions + indexes (see Topic 18).

-- ------------------------------------------------------------
-- G. Indexes & Performance (One Look)
-- ------------------------------------------------------------
-- (Rule → Why)
--
-- * Index columns used in WHERE, JOIN, ORDER BY, GROUP BY
--     - Why : lets MySQL seek instead of scanning
--
-- * Composite index (a, b) works for a and a,b, not b alone
--     - Why : leftmost prefix rule
--
-- * Covering index → EXPLAIN shows Using index
--     - Why : table rows are never read
--
-- * No function on an indexed column: d >= '2025-01-01' not YEAR(d) = 2025
--     - Why : a function hides the index
--
-- * LIKE 'abc%' ✔, LIKE '%abc' ✖
--     - Why : leading wildcard can't use the index
--
-- * EXPLAIN type = ALL = full scan; ref / range / const = good
--     - Why : read the plan before changing anything
--

-- * See Topic 41 (indexing), Topic 43 (EXPLAIN), Topic 48 (optimization techniques).

-- ------------------------------------------------------------
-- H. Procedures, Functions, Triggers, Events, Cursors (One Look)
-- ------------------------------------------------------------
-- (Object → Starts when | Key syntax)
--
-- * Procedure
--     - Starts when : you run CALL
--     - Key syntax  : CREATE PROCEDURE p(IN a INT, OUT b INT) BEGIN ... END
--
-- * Function
--     - Starts when : used inside a query
--     - Key syntax  : CREATE FUNCTION f(a INT) RETURNS INT DETERMINISTIC RETURN ...
--
-- * Trigger
--     - Starts when : INSERT / UPDATE / DELETE on a table
--     - Key syntax  : CREATE TRIGGER t BEFORE INSERT ON orders FOR EACH ROW ... (OLD / NEW)
--
-- * Event
--     - Starts when : a time schedule
--     - Key syntax  : CREATE EVENT e ON SCHEDULE EVERY 1 DAY DO ... (event_scheduler ON)
--
-- * Cursor
--     - Starts when : inside a procedure, row by row
--     - Key syntax  : DECLARE c CURSOR FOR ...; OPEN; FETCH ... INTO ...; CLOSE
--

-- * MySQL: no `DEFAULT` for procedure parameters, no `CREATE OR REPLACE PROCEDURE/TRIGGER`, no COMMIT inside triggers/functions, `SIGNAL SQLSTATE '45000'` to raise an error (see Topic 35, Topic 36, Topic 37, Topic 38, Topic 39).

-- ------------------------------------------------------------
-- I. Design & Security (One Look)
-- ------------------------------------------------------------

-- * Normalization: 1NF atomic values → 2NF no partial dependency → 3NF no transitive dependency → BCNF every determinant is a key (see Topic 49).

-- * OLTP = normalized app database; OLAP = star/snowflake schema with fact + dimension tables (see Topic 49).

-- * M:N relationship → junction table with two foreign keys (see Topic 50).

-- * SQL injection → always use prepared statements / parameters, never string concatenation; give apps least privilege (see Topic 14, Topic 13).

-- * Replication is not a backup; use `mysqldump --single-transaction` or physical backups + binlogs for point-in-time recovery (see Topic 51).

-- ------------------------------------------------------------
-- J. Most-Asked Query Patterns
-- ------------------------------------------------------------
-- (Problem → Pattern)
--
-- * Nth highest / top N per group
--     - Pattern : DENSE_RANK() OVER (PARTITION BY dept ORDER BY salary DESC) then WHERE rnk <= N
--
-- * Latest row per group
--     - Pattern : ROW_NUMBER() OVER (PARTITION BY customer ORDER BY date DESC) = 1
--
-- * Duplicates
--     - Pattern : GROUP BY col HAVING COUNT(*) > 1; delete with ROW_NUMBER() ... rn > 1
--
-- * Running total / moving average
--     - Pattern : SUM(x) OVER (ORDER BY d) / AVG(x) OVER (ORDER BY d ROWS 2 PRECEDING)
--
-- * Month-over-month change
--     - Pattern : LAG(total) OVER (ORDER BY month)
--
-- * Consecutive days (gaps & islands)
--     - Pattern : group by date - ROW_NUMBER()
--
-- * Rows → columns (pivot)
--     - Pattern : SUM(CASE WHEN year = 2025 THEN sales ELSE 0 END)
--
-- * Not in other table
--     - Pattern : LEFT JOIN ... WHERE b.id IS NULL or NOT EXISTS
--

-- * Worked answers with output: Topic 53, Part J and Part Q.

-- ---
