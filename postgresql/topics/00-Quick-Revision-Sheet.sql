-- ======================================================================
-- ⚡ Quick Revision Sheet (Read This Before the Interview)
-- ======================================================================

-- > One page to revise everything fast. Each point is explained in detail in the topics below. 🐘 = PostgreSQL-specific point.

-- ------------------------------------------------------------
-- A. The 5 Types of SQL Commands
-- ------------------------------------------------------------

-- (Type → Full Form | Commands | Works On | Can ROLLBACK?)
--
-- * DDL
--     - Full Form     : Data Definition Language
--     - Commands      : CREATE, ALTER, DROP, TRUNCATE (rename = ALTER ... RENAME TO)
--     - Works On      : Structure (tables, databases)
--     - Can ROLLBACK? : ✅ Yes in PostgreSQL (inside BEGIN) — except CREATE/DROP DATABASE
--
-- * DML
--     - Full Form     : Data Manipulation Language
--     - Commands      : INSERT, UPDATE, DELETE, MERGE, INSERT ... ON CONFLICT
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
--     - Can ROLLBACK? : ✅ Yes in PostgreSQL (inside BEGIN)
--
-- * TCL
--     - Full Form     : Transaction Control Language
--     - Commands      : BEGIN, COMMIT, ROLLBACK, SAVEPOINT
--     - Works On      : Transactions
--     - Can ROLLBACK? : —
--

-- ------------------------------------------------------------
-- B. Query Writing Order vs. Execution Order
-- ------------------------------------------------------------

-- ┌── (text — not SQL, shown for reference) ──
-- │ We WRITE :  SELECT → FROM → WHERE → GROUP BY → HAVING → ORDER BY → LIMIT / OFFSET
-- │ DB RUNS  :  FROM (+JOIN) → WHERE → GROUP BY → HAVING → SELECT (+window fn) → DISTINCT → ORDER BY → LIMIT / OFFSET
-- └──

-- * That is why a `SELECT` alias cannot be used in `WHERE`, but can be used in `ORDER BY`.

-- ------------------------------------------------------------
-- C. Most-Asked "Difference Between" Questions
-- ------------------------------------------------------------

-- (Question → Short Answer)
--
-- * DELETE vs TRUNCATE vs DROP
--     - Short Answer : DELETE removes chosen rows (DML). TRUNCATE empties the table fast (DDL; numbering resets only with RESTART IDENTITY). DROP removes the whole table. 🐘 All three can be rolled back inside BEGIN.
--
-- * WHERE vs HAVING
--     - Short Answer : WHERE filters rows before grouping; HAVING filters groups after GROUP BY (can use SUM, COUNT…).
--
-- * UNION vs UNION ALL
--     - Short Answer : UNION removes duplicates (slower); UNION ALL keeps all rows (faster).
--
-- * CHAR vs VARCHAR vs TEXT
--     - Short Answer : 🐘 CHAR(n) is padded; VARCHAR(n) has a max length; TEXT has no limit — all equally fast, TEXT is the usual choice.
--
-- * TIMESTAMP vs TIMESTAMPTZ
--     - Short Answer : 🐘 TIMESTAMP = no time zone (like MySQL DATETIME); TIMESTAMPTZ = stored in UTC, shown in your time zone (no 2038 limit).
--
-- * PRIMARY KEY vs UNIQUE
--     - Short Answer : Primary key: only one per table, no NULL. Unique: many per table, NULL allowed.
--
-- * INNER JOIN vs LEFT JOIN
--     - Short Answer : Inner = only matching rows. Left = all rows from the left table + matches (NULL if no match). 🐘 FULL JOIN works directly.
--
-- * ROW_NUMBER vs RANK vs DENSE_RANK
--     - Short Answer : For values 100, 90, 90, 80 → ROW_NUMBER: 1,2,3,4 · RANK: 1,2,2,4 · DENSE_RANK: 1,2,2,3
--
-- * COUNT(*) vs COUNT(col)
--     - Short Answer : COUNT(*) counts all rows; COUNT(col) counts only non-NULL values. 🐘 COUNT(*) FILTER (WHERE ...) counts conditionally.
--
-- * GROUP BY vs Window function
--     - Short Answer : GROUP BY gives one row per group; a window function keeps every row and adds the result next to it.
--
-- * Subquery vs JOIN
--     - Short Answer : A JOIN combines columns from tables; a subquery uses one query's result inside another. JOINs are usually faster and easier to read.
--
-- * Clustered vs Non-clustered index
--     - Short Answer : 🐘 PostgreSQL has no clustered index: tables are heaps and every index (incl. PK) is separate, pointing to the row's CTID.
--
-- * JSON vs JSONB
--     - Short Answer : 🐘 JSONB is binary, indexable (GIN), faster to query — use it. JSON keeps the exact text.
--
-- * Function vs Procedure
--     - Short Answer : 🐘 Function returns a value/table and is used in SELECT; procedure is run with CALL, returns only OUT params, and can COMMIT.
--

-- ------------------------------------------------------------
-- D. NULL Rules (Very Common Traps)
-- ------------------------------------------------------------

-- * `NULL` means unknown — it is not `0` and not `''`.

-- * `col = NULL` is never true → always use `IS NULL` / `IS NOT NULL` (🐘 or `IS [NOT] DISTINCT FROM` for NULL-safe comparison).

-- * `NOT IN (1, 2, NULL)` returns 0 rows → use `NOT EXISTS` instead.

-- * `SUM`, `AVG`, `COUNT(col)`, `MIN`, `MAX` ignore NULLs. `SUM` of an empty group returns `NULL`, not `0` → wrap in `COALESCE(SUM(col), 0)`.

-- * Replace NULL: 🐘 only `COALESCE(a, b, c, ...)` (no `IFNULL` / `ISNULL` in PostgreSQL).

-- * 🐘 Sorting: PostgreSQL puts NULLs LAST in `ASC` and FIRST in `DESC`; control it with `NULLS FIRST` / `NULLS LAST`.

-- ------------------------------------------------------------
-- E. Top 10 Things Interviewers Love to Ask
-- ------------------------------------------------------------

-- 1. Execution order of a query (section B above).

-- 2. Nth highest salary (see Topic 53, Part J).

-- 3. Find and delete duplicate rows (see Topic 53, Part J) — 🐘 `DELETE ... USING`.

-- 4. Customers who never placed an order → `LEFT JOIN ... WHERE o.customer_id IS NULL` or `NOT EXISTS` (see Topic 21).

-- 5. `RANK` vs `DENSE_RANK` vs `ROW_NUMBER` (see Topic 26) — 🐘 and `DISTINCT ON`.

-- 6. ACID properties and isolation levels — 🐘 PostgreSQL default = `READ COMMITTED` (see Topic 15, 16).

-- 7. `NOT IN` with `NULL` returns 0 rows (see 20.7.8).

-- 8. `DELETE` vs `TRUNCATE` vs `DROP` (see 9.12) — 🐘 transactional DDL.

-- 9. `WHERE` vs `HAVING` (see 20.12), and `UNION` vs `UNION ALL` (see Topic 22).

-- 10. 🐘 PostgreSQL vs MySQL (see 8.5) — MVCC + VACUUM, `JSONB`, no clustered index, `ON CONFLICT`, `RETURNING`.

-- ------------------------------------------------------------
-- F. Transactions & Locks (One Look)
-- ------------------------------------------------------------

-- * `BEGIN` → statements → `COMMIT` (save all) or `ROLLBACK` (undo all); `SAVEPOINT sp` + `ROLLBACK TO sp` undoes part (see Topic 17).

-- * Autocommit is ON by default; 🐘 DDL does NOT commit implicitly — `BEGIN; DROP TABLE t; ROLLBACK;` works (see Topic 17).

-- * 🐘 One error inside `BEGIN` aborts the whole transaction ("current transaction is aborted") → `ROLLBACK` or use savepoints (see 15.5).

-- * Isolation levels: READ UNCOMMITTED (= READ COMMITTED) → READ COMMITTED (🐘 default) → REPEATABLE READ (no phantoms) → SERIALIZABLE (SSI, retry on 40001) (see Topic 15, 16).

-- * Locks: shared vs exclusive; `SELECT ... FOR UPDATE` locks rows; `SKIP LOCKED` for job queues; plain `SELECT` never blocks (MVCC); optimistic locking uses a `version` column (see Topic 19).

-- * Deadlock → PostgreSQL aborts one transaction after `deadlock_timeout` (`40P01`); set `lock_timeout` to avoid endless waits (see Topic 18).

-- * 🐘 MVCC: `UPDATE` writes a new row version; `VACUUM` (autovacuum) removes dead rows — long transactions cause bloat (see 19.9).

-- ------------------------------------------------------------
-- G. Indexes & Performance (One Look)
-- ------------------------------------------------------------
-- (Rule → Why)
--
-- * Index columns used in WHERE, JOIN, ORDER BY, GROUP BY
--     - Why : lets PostgreSQL use an Index Scan instead of a Seq Scan
--
-- * 🐘 Index foreign key columns yourself
--     - Why : PostgreSQL does not create them automatically
--
-- * Composite index (a, b) works for a and a,b, not b alone
--     - Why : leftmost prefix rule
--
-- * Covering index (a) INCLUDE (b) → Index Only Scan
--     - Why : table rows are not read
--
-- * 🐘 Partial index ... WHERE status = 'ACTIVE', expression index (LOWER(email))
--     - Why : smaller / function-friendly indexes
--
-- * 🐘 GIN for JSONB, arrays, full-text; BRIN for huge time-ordered tables
--     - Why : right index type for the data
--
-- * No function on an indexed column: d >= '2025-01-01' not EXTRACT(YEAR FROM d) = 2025
--     - Why : a function hides the index
--
-- * LIKE 'abc%' ✔, LIKE '%abc' ✖ (🐘 use pg_trgm)
--     - Why : leading wildcard can't use a B-Tree
--
-- * EXPLAIN (ANALYZE, BUFFERS): big Seq Scan / wrong row estimates = problem
--     - Why : read the plan before changing anything
--

-- * See Topic 41 (indexing), Topic 43 (EXPLAIN), Topic 48 (optimization techniques).

-- ------------------------------------------------------------
-- H. Procedures, Functions, Triggers, Scheduled Jobs, Cursors (One Look)
-- ------------------------------------------------------------
-- (Object → Starts when | Key syntax (PostgreSQL))
--
-- * Procedure
--     - Starts when             : you run CALL
--     - Key syntax (PostgreSQL) : CREATE OR REPLACE PROCEDURE p(a INT, OUT b INT) LANGUAGE plpgsql AS  BEGIN ... END; ;
--
-- * Function
--     - Starts when             : used inside a query
--     - Key syntax (PostgreSQL) : CREATE FUNCTION f(a INT) RETURNS INT LANGUAGE sql IMMUTABLE AS  SELECT a * 2 ; (or RETURNS TABLE (...))
--
-- * Trigger
--     - Starts when             : INSERT / UPDATE / DELETE / TRUNCATE
--     - Key syntax (PostgreSQL) : function RETURNS TRIGGER + CREATE TRIGGER t BEFORE INSERT ON orders FOR EACH ROW EXECUTE FUNCTION f(); (OLD / NEW)
--
-- * Scheduled job
--     - Starts when             : a time schedule
--     - Key syntax (PostgreSQL) : SELECT cron.schedule('job', '0 2 * * *', 'CALL p()'); (pg_cron extension)
--
-- * Cursor
--     - Starts when             : row by row
--     - Key syntax (PostgreSQL) : FOR rec IN SELECT ... LOOP ... END LOOP; or OPEN / FETCH / EXIT WHEN NOT FOUND / CLOSE
--

-- * 🐘 PostgreSQL: no `DELIMITER` (use `$$`), `CREATE OR REPLACE` works, parameters can have `DEFAULT`, procedures return rows only through functions, errors with `RAISE EXCEPTION`, handlers with `EXCEPTION WHEN ... THEN` (see Topic 35–39).

-- ------------------------------------------------------------
-- I. Design & Security (One Look)
-- ------------------------------------------------------------

-- * Normalization: 1NF atomic values → 2NF no partial dependency → 3NF no transitive dependency → BCNF every determinant is a key (see Topic 49).

-- * OLTP = normalized app database; OLAP = star/snowflake schema with fact + dimension tables (see Topic 49).

-- * M:N relationship → junction table with two foreign keys (see Topic 50).

-- * SQL injection → always use prepared statements / parameters (`$1`), never string concatenation; in PL/pgSQL use `format('%I')` + `USING`; give apps least privilege, never the `postgres` superuser (see Topic 14, Topic 13).

-- * 🐘 Security: roles, `CONNECT` + `USAGE` + `SELECT`, `ALTER DEFAULT PRIVILEGES`, Row-Level Security policies, `pg_hba.conf` (see Topic 13).

-- * Replication is not a backup; use `pg_dump` (logical) or `pg_basebackup` + WAL archiving for point-in-time recovery (see Topic 51).

-- ------------------------------------------------------------
-- J. Most-Asked Query Patterns
-- ------------------------------------------------------------
-- (Problem → Pattern)
--
-- * Nth highest / top N per group
--     - Pattern : DENSE_RANK() OVER (PARTITION BY dept ORDER BY salary DESC) then WHERE rnk <= N; 🐘 or LATERAL (... LIMIT N)
--
-- * Latest row per group
--     - Pattern : ROW_NUMBER() OVER (PARTITION BY customer ORDER BY date DESC) = 1; 🐘 or DISTINCT ON (customer)
--
-- * Duplicates
--     - Pattern : GROUP BY col HAVING COUNT(*) > 1; delete with ROW_NUMBER() ... rn > 1 or DELETE ... USING
--
-- * Running total / moving average
--     - Pattern : SUM(x) OVER (ORDER BY d) / AVG(x) OVER (ORDER BY d ROWS 2 PRECEDING)
--
-- * Month-over-month change
--     - Pattern : LAG(total) OVER (ORDER BY month)
--
-- * Consecutive days (gaps & islands)
--     - Pattern : group by date - ROW_NUMBER() (🐘 DATE minus integer)
--
-- * Rows → columns (pivot)
--     - Pattern : SUM(sales) FILTER (WHERE year = 2025) or SUM(CASE WHEN ...)
--
-- * Not in other table
--     - Pattern : LEFT JOIN ... WHERE b.id IS NULL or NOT EXISTS
--
-- * Upsert
--     - Pattern : 🐘 INSERT ... ON CONFLICT (id) DO UPDATE SET x = EXCLUDED.x
--
-- * Median
--     - Pattern : 🐘 PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY salary)
--

-- * Worked answers with output: Topic 53, Part J and Part Q.

-- ---
