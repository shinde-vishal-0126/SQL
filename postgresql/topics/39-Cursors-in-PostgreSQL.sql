-- ======================================================================
-- Topic 39: Cursors in PostgreSQL
-- ======================================================================

-- ------------------------------------------------------------
-- 📖 In Simple Words
-- ------------------------------------------------------------

-- * Definition: A cursor lets a stored program read a query result one row at a time, in a loop.

-- * Real-life example: Reading a list with your finger, line by line, instead of looking at the whole page at once.

-- * 🧩 Syntax:
--     DECLARE cur_name CURSOR FOR SELECT ...;
--     OPEN cur_name;
--     LOOP
--       FETCH cur_name INTO var1, var2;
--       EXIT WHEN NOT FOUND;
--       -- work with var1, var2
--     END LOOP;
--     CLOSE cur_name;
--     -- shortcut: FOR rec IN SELECT ... LOOP ... END LOOP;

-- * Syntax explained (each part):
--   - DECLARE … CURSOR FOR → the query whose rows will be read
--   - OPEN / CLOSE → start / finish reading
--   - FETCH … INTO → read the next row into variables
--   - NOT FOUND handler / EXIT WHEN NOT FOUND → stop when there are no more rows

-- * Example on salesdb (run 00-Setup-Sample-Data.sql first):
SET search_path TO sales;
DO $$
DECLARE
  cur CURSOR FOR SELECT sales FROM orders;
  v_sales INT;
  v_total INT := 0;
BEGIN
  OPEN cur;
  LOOP
    FETCH cur INTO v_sales;
    EXIT WHEN NOT FOUND;
    v_total := v_total + v_sales;
  END LOOP;
  CLOSE cur;
  RAISE NOTICE 'Total sales = %', v_total;
END $$;

-- * Example explained (step by step):
--   1. The cursor walks through the 10 orders one row at a time.
--   2. Each FETCH reads one sales value and adds it to v_total; the loop stops when no rows are left.
--   3. Result: 380 — the same as SELECT SUM(sales) FROM orders, which is faster. Use cursors only when row-by-row logic is really needed.

-- ------------------------------------------------------------
-- 39.1 What is a Cursor?
-- ------------------------------------------------------------

-- * A cursor is a pointer over the result set of a `SELECT`, used to process the rows one at a time.

-- * PostgreSQL has cursors in two places:

--   * In PL/pgSQL (procedures, functions, triggers, DO blocks) — like MySQL.

--   * In plain SQL inside a transaction: `DECLARE cur CURSOR FOR SELECT ...; FETCH 100 FROM cur;` — useful for apps that read a huge result in pieces. (MySQL cannot do this outside stored programs.)

-- * PostgreSQL cursors can be:

--   * Updatable — `UPDATE employees SET ... WHERE CURRENT OF emp_cur;` changes the row the cursor is on (simple single-table queries).

--   * Scrollable — with `SCROLL` you can `FETCH PRIOR`, `FETCH FIRST`, `FETCH ABSOLUTE 5`, `MOVE` (MySQL cursors are forward-only).

--   * Insensitive — a cursor sees a snapshot of the data from when it was opened (MVCC), so later changes don't confuse it.

--   * `WITH HOLD` — a SQL-level cursor can stay open after `COMMIT`.

-- * When to use: row-by-row logic that is hard to write as one statement — calling another procedure for each row, building dynamic SQL per table, complex multi-step processing, streaming a huge result to the app in batches.

-- ------------------------------------------------------------
-- 39.2 Cursor Lifecycle: DECLARE → OPEN → FETCH → CLOSE
-- ------------------------------------------------------------

-- 1. DECLARE the cursor with its `SELECT` (in the `DECLARE` section).

-- 2. OPEN — runs the `SELECT`.

-- 3. FETCH ... INTO variables inside a loop.

-- 4. Check the built-in `FOUND` variable — `EXIT WHEN NOT FOUND;` (no handler needed, unlike MySQL).

-- 5. CLOSE — frees the cursor (also closed automatically at the end of the transaction).

-- * The easy way: a `FOR rec IN cursor_or_query LOOP ... END LOOP;` does OPEN, FETCH, the end check and CLOSE for you.

-- >

-- ------------------------------------------------------------
-- 39.3 Full Working Example
-- ------------------------------------------------------------

-- * Goal: give every employee of a department a raise based on their salary band, and log each change.
CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    name   VARCHAR(50),
    dept   VARCHAR(20),
    salary NUMERIC(10,2)
);
INSERT INTO employees VALUES
(1, 'Asha',  'IT', 40000),
(2, 'Ravi',  'IT', 75000),
(3, 'Meena', 'HR', 50000),
(4, 'Kiran', 'IT', 90000);

CREATE TABLE salary_log (
    emp_id     INT,
    old_salary NUMERIC(10,2),
    new_salary NUMERIC(10,2),
    changed_at TIMESTAMPTZ DEFAULT now()
);

-- Version A: explicit cursor (same steps as MySQL)
CREATE OR REPLACE PROCEDURE give_raise(p_dept VARCHAR(20))
LANGUAGE plpgsql
AS $$
DECLARE
    v_id     INT;
    v_salary NUMERIC(10,2);
    v_new    NUMERIC(10,2);
    emp_cur CURSOR FOR
        SELECT emp_id, salary FROM employees WHERE dept = p_dept;
BEGIN
    OPEN emp_cur;

    LOOP
        FETCH emp_cur INTO v_id, v_salary;
        EXIT WHEN NOT FOUND;                    -- no handler needed

        v_new := CASE
                     WHEN v_salary < 50000 THEN v_salary * 1.10
                     WHEN v_salary < 80000 THEN v_salary * 1.05
                     ELSE v_salary * 1.02
                 END;

        UPDATE employees SET salary = v_new WHERE emp_id = v_id;
        INSERT INTO salary_log (emp_id, old_salary, new_salary) VALUES (v_id, v_salary, v_new);
    END LOOP;

    CLOSE emp_cur;
END;
$$;

CALL give_raise('IT');
SELECT emp_id, old_salary, new_salary FROM salary_log;

-- * Output:

-- | emp_id | old_salary | new_salary |
-- | :--- | :--- | :--- |
-- | 1 | 40000.00 | 44000.00 |
-- | 2 | 75000.00 | 78750.00 |
-- | 4 | 90000.00 | 91800.00 |

-- * Version B: the same procedure with a `FOR` loop (the PostgreSQL way — shorter, no OPEN/FETCH/CLOSE):
CREATE OR REPLACE PROCEDURE give_raise_for(p_dept VARCHAR(20))
LANGUAGE plpgsql
AS $$
DECLARE
    rec   RECORD;
    v_new NUMERIC(10,2);
BEGIN
    FOR rec IN SELECT emp_id, salary FROM employees WHERE dept = p_dept LOOP
        v_new := CASE
                     WHEN rec.salary < 50000 THEN rec.salary * 1.10
                     WHEN rec.salary < 80000 THEN rec.salary * 1.05
                     ELSE rec.salary * 1.02
                 END;

        UPDATE employees SET salary = v_new WHERE emp_id = rec.emp_id;
        INSERT INTO salary_log (emp_id, old_salary, new_salary) VALUES (rec.emp_id, rec.salary, v_new);
    END LOOP;
END;
$$;

-- * Meena (HR) is not touched.

-- ------------------------------------------------------------
-- 39.3.1 🐘 SQL-level Cursor (Reading a Huge Result in Batches)
-- ------------------------------------------------------------

-- * Apps can use a cursor directly in SQL (inside a transaction) to fetch big results in pieces instead of loading millions of rows into memory:
BEGIN;
DECLARE big_cur CURSOR FOR SELECT * FROM orders ORDER BY orderid;

FETCH 1000 FROM big_cur;      -- rows 1..1000
FETCH 1000 FROM big_cur;      -- rows 1001..2000
-- ... until FETCH returns 0 rows

CLOSE big_cur;
COMMIT;

-- * Drivers use this automatically (e.g. psycopg "server-side cursor", JDBC `setFetchSize`).

-- ------------------------------------------------------------
-- 39.4 Common Mistakes with Cursors
-- ------------------------------------------------------------

-- * Forgetting `EXIT WHEN NOT FOUND;` right after `FETCH` → endless loop (the variables just stay NULL).

-- * Checking `FOUND` after another statement: `FOUND` is changed by every `SELECT INTO`, `UPDATE`, `INSERT`, `FETCH`. Check it immediately after the `FETCH`.

-- * Number/types of `FETCH ... INTO` variables must match the SELECT columns (or fetch into a `RECORD`).

-- * Using a SQL-level cursor outside a transaction — in autocommit mode `DECLARE CURSOR` fails unless you add `WITH HOLD` (`cursor can only be used in transaction blocks`).

-- * Processing millions of rows one by one when one `UPDATE` would do (see 39.5).

-- ------------------------------------------------------------
-- 39.5 Cursor vs Set-Based SQL
-- ------------------------------------------------------------

-- * The same raise can be done in one statement:
UPDATE employees
SET salary = CASE
                 WHEN salary < 50000 THEN salary * 1.10
                 WHEN salary < 80000 THEN salary * 1.05
                 ELSE salary * 1.02
             END
WHERE dept = 'IT';

-- and the log in the same statement using a CTE:
WITH old AS (SELECT emp_id, salary FROM employees WHERE dept = 'IT'),
upd AS (
    UPDATE employees e
    SET salary = CASE WHEN e.salary < 50000 THEN e.salary * 1.10
                      WHEN e.salary < 80000 THEN e.salary * 1.05
                      ELSE e.salary * 1.02 END
    FROM old
    WHERE e.emp_id = old.emp_id
    RETURNING e.emp_id, old.salary AS old_salary, e.salary AS new_salary
)
INSERT INTO salary_log (emp_id, old_salary, new_salary)
SELECT emp_id, old_salary, new_salary FROM upd;

-- | Point | Cursor (row-by-row) | Set-based SQL |
-- | :--- | :--- | :--- |
-- | Speed | Slow on large data (one statement per row) | Fast — planner handles all rows together |
-- | Code | Long (declare, open, fetch, loop, close) | Short |
-- | Locks / WAL | Many small statements | One statement |
-- | Use when | Per-row procedure calls, dynamic SQL per row, batch streaming to apps | Almost everything else |

-- * Rule for interviews: "Prefer set-based SQL (`UPDATE ... CASE`, `INSERT ... SELECT`, data-modifying CTEs with `RETURNING`, JOINs, window functions); use a cursor only when row-by-row logic is really needed."

-- * Q1. What is a cursor and where can it be used in PostgreSQL?

--   * Answer: A pointer to process a SELECT's result one row at a time. In PL/pgSQL (procedures, functions, triggers, DO blocks) and also in plain SQL inside a transaction (`DECLARE ... CURSOR`, `FETCH`).

-- * Q2. What are the steps of using a cursor?

--   * Answer: DECLARE → OPEN → FETCH in a loop with `EXIT WHEN NOT FOUND` → CLOSE. Or just `FOR rec IN query LOOP`.

-- * Q3. What are the properties of PostgreSQL cursors?

--   * Answer: Forward-only by default, `SCROLL` for moving backward; can update the current row with `WHERE CURRENT OF`; see a stable snapshot; `WITH HOLD` keeps them open after commit.

-- * Q4. How do you know when all rows are fetched?

--   * Answer: The special variable `FOUND` becomes false after a `FETCH` with no row → `EXIT WHEN NOT FOUND;`. (MySQL needs a `NOT FOUND` handler.)

-- * Q5. Why are cursors discouraged?

--   * Answer: Row-by-row processing is much slower than set-based SQL and holds resources longer; most cursor logic can be rewritten with `UPDATE ... CASE`, `INSERT ... SELECT`, CTEs with `RETURNING`, JOINs or window functions.

-- ---

-- ======================================================================
-- 🎯 Practice Questions (salesdb sample data) — try first, then look at the answer
-- ======================================================================
-- Run 00-Setup-Sample-Data.sql once before this section.

SET search_path TO sales;

-- Q1. Cursor: loop over customers and build a list of names.
DO $$
DECLARE
  cur CURSOR FOR SELECT firstname FROM customers ORDER BY customerid;
  v_name VARCHAR;
  v_all TEXT := '';
BEGIN
  OPEN cur;
  LOOP
    FETCH cur INTO v_name;
    EXIT WHEN NOT FOUND;
    v_all := v_all || v_name || ', ';
  END LOOP;
  CLOSE cur;
  RAISE NOTICE 'Customers: %', v_all;
END $$;

-- Q2. The same result without a cursor (set-based — preferred).
SELECT string_agg(firstname, ', ' ORDER BY customerid) AS customer_names FROM customers;
