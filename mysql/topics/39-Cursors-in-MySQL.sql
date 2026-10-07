-- ======================================================================
-- Topic 39: Cursors in MySQL
-- ======================================================================

-- ------------------------------------------------------------
-- 📖 In Simple Words
-- ------------------------------------------------------------

-- * Definition: A cursor lets a stored program read a query result one row at a time, in a loop.

-- * Real-life example: Reading a list with your finger, line by line, instead of looking at the whole page at once.

-- * 🧩 Syntax:
--     DECLARE cur_name CURSOR FOR SELECT ...;
--     DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
--     OPEN cur_name;
--     loop_name: LOOP
--       FETCH cur_name INTO var1, var2;
--       IF done THEN LEAVE loop_name; END IF;
--       -- work with var1, var2
--     END LOOP;
--     CLOSE cur_name;

-- * Syntax explained (each part):
--   - DECLARE … CURSOR FOR → the query whose rows will be read
--   - OPEN / CLOSE → start / finish reading
--   - FETCH … INTO → read the next row into variables
--   - NOT FOUND handler / EXIT WHEN NOT FOUND → stop when there are no more rows

-- * Example on salesdb (run 00-Setup-Sample-Data.sql first):
USE salesdb;
DELIMITER //
CREATE PROCEDURE total_by_cursor()
BEGIN
  DECLARE done INT DEFAULT 0;
  DECLARE v_sales INT;
  DECLARE v_total INT DEFAULT 0;
  DECLARE cur CURSOR FOR SELECT sales FROM orders;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
  OPEN cur;
  read_loop: LOOP
    FETCH cur INTO v_sales;
    IF done THEN LEAVE read_loop; END IF;
    SET v_total = v_total + v_sales;
  END LOOP;
  CLOSE cur;
  SELECT v_total AS total_sales;
END //
DELIMITER ;
CALL total_by_cursor();
DROP PROCEDURE total_by_cursor;

-- * Example explained (step by step):
--   1. The cursor walks through the 10 orders one row at a time.
--   2. Each FETCH reads one sales value and adds it to v_total; the loop stops when no rows are left.
--   3. Result: 380 — the same as SELECT SUM(sales) FROM orders, which is faster. Use cursors only when row-by-row logic is really needed.

-- ------------------------------------------------------------
-- 39.1 What is a Cursor?
-- ------------------------------------------------------------

-- * A cursor is a pointer over the result set of a `SELECT`, used inside stored programs (procedures, functions, triggers, events) to process the rows one at a time.

-- * MySQL cursors are:

--   * Read-only — you cannot update rows through the cursor (use a normal `UPDATE` with the fetched key).

--   * Non-scrollable — only forward, one row at a time; no going back or jumping.

--   * Asensitive — the server may or may not make a copy of the result, so don't change the underlying table while the cursor is open and expect predictable results.

-- * When to use: row-by-row logic that is hard to write as one statement — calling another procedure for each row, building dynamic SQL per table, complex multi-step processing, generating per-row audit/notification rows.

-- ------------------------------------------------------------
-- 39.2 Cursor Lifecycle: DECLARE → OPEN → FETCH → CLOSE
-- ------------------------------------------------------------

-- 1. DECLARE the cursor with its `SELECT`.

-- 2. DECLARE a CONTINUE HANDLER FOR NOT FOUND — sets a flag when there are no more rows.

-- 3. OPEN — runs the `SELECT`.

-- 4. FETCH ... INTO variables inside a loop; LEAVE the loop when the flag is set.

-- 5. CLOSE — frees the result set (it is also closed automatically at the end of the `BEGIN ... END` block).

-- * Declaration order rule (otherwise error 1337): variables and conditions → cursors → handlers, all at the top of the `BEGIN ... END` block.

-- >

-- ------------------------------------------------------------
-- 39.3 Full Working Example
-- ------------------------------------------------------------

-- * Goal: give every employee of a department a raise based on their salary band, and log each change.
CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    name   VARCHAR(50),
    dept   VARCHAR(20),
    salary DECIMAL(10,2)
);
INSERT INTO employees VALUES
(1, 'Asha',  'IT', 40000),
(2, 'Ravi',  'IT', 75000),
(3, 'Meena', 'HR', 50000),
(4, 'Kiran', 'IT', 90000);

CREATE TABLE salary_log (
    emp_id     INT,
    old_salary DECIMAL(10,2),
    new_salary DECIMAL(10,2),
    changed_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

DELIMITER //
CREATE PROCEDURE GiveRaise(IN p_dept VARCHAR(20))
BEGIN
    -- 1. variables first
    DECLARE v_done   INT DEFAULT 0;
    DECLARE v_id     INT;
    DECLARE v_salary DECIMAL(10,2);
    DECLARE v_new    DECIMAL(10,2);

    -- 2. then the cursor
    DECLARE emp_cur CURSOR FOR
        SELECT emp_id, salary FROM employees WHERE dept = p_dept;

    -- 3. then the handler
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_done = 1;

    OPEN emp_cur;

    read_loop: LOOP
        FETCH emp_cur INTO v_id, v_salary;
        IF v_done = 1 THEN
            LEAVE read_loop;
        END IF;

        SET v_new = CASE
                        WHEN v_salary < 50000 THEN v_salary * 1.10
                        WHEN v_salary < 80000 THEN v_salary * 1.05
                        ELSE v_salary * 1.02
                    END;

        UPDATE employees SET salary = v_new WHERE emp_id = v_id;
        INSERT INTO salary_log (emp_id, old_salary, new_salary) VALUES (v_id, v_salary, v_new);
    END LOOP read_loop;

    CLOSE emp_cur;
END //
DELIMITER ;

CALL GiveRaise('IT');
SELECT emp_id, old_salary, new_salary FROM salary_log;

-- * Output:

-- (emp_id → old_salary | new_salary)
--
-- * 1
--     - old_salary : 40000.00
--     - new_salary : 44000.00
--
-- * 2
--     - old_salary : 75000.00
--     - new_salary : 78750.00
--
-- * 4
--     - old_salary : 90000.00
--     - new_salary : 91800.00
--

-- * Meena (HR) is not touched. `LEAVE` needs the loop label (`read_loop`).

-- ------------------------------------------------------------
-- 39.4 Common Mistakes with Cursors
-- ------------------------------------------------------------

-- * Checking the flag in the wrong place: check `v_done` right after FETCH; if you check at the end of the loop body, the last row is processed twice.

-- * Handler fired by an inner SELECT: a `SELECT ... INTO` inside the loop that finds no row also triggers `NOT FOUND` and ends the loop early. Reset the flag (`SET v_done = 0;`) after such a statement, or put it in a nested `BEGIN ... END` with its own handler.

-- * Wrong declaration order → error 1337 (`Variable or condition declaration after cursor or handler declaration`).

-- * Number of FETCH variables must match the SELECT columns, otherwise error 1328.

-- * Using a cursor outside a stored program — not allowed; a plain script cannot `DECLARE CURSOR`.

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

-- (Point → Cursor (row-by-row) | Set-based SQL)
--
-- * Speed
--     - Cursor (row-by-row) : Slow on large data (one statement per row)
--     - Set-based SQL       : Fast — optimizer handles all rows together
--
-- * Code
--     - Cursor (row-by-row) : Long (declare, open, fetch, loop, close)
--     - Set-based SQL       : Short
--
-- * Locks / log
--     - Cursor (row-by-row) : Many small statements
--     - Set-based SQL       : One statement
--
-- * Use when
--     - Cursor (row-by-row) : Per-row procedure calls, dynamic SQL per row, complex step-by-step logic
--     - Set-based SQL       : Almost everything else
--

-- * Rule for interviews: "Prefer set-based SQL (`UPDATE ... CASE`, `INSERT ... SELECT`, JOINs, window functions); use a cursor only when row-by-row logic is really needed."

-- * Q1. What is a cursor and where can it be used in MySQL?

--   * Answer: A pointer to process a SELECT's result one row at a time; only inside stored procedures, functions, triggers and events.

-- * Q2. What are the steps of using a cursor?

--   * Answer: DECLARE cursor → DECLARE NOT FOUND handler → OPEN → FETCH in a loop (LEAVE when done) → CLOSE.

-- * Q3. What are the properties of MySQL cursors?

--   * Answer: Read-only, non-scrollable (forward-only), asensitive.

-- * Q4. How do you know when all rows are fetched?

--   * Answer: `DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;` and check `done` right after each FETCH.

-- * Q5. Why are cursors discouraged?

--   * Answer: Row-by-row processing is much slower than set-based SQL and holds resources longer; most cursor logic can be rewritten with `UPDATE ... CASE`, `INSERT ... SELECT`, JOINs or window functions.

-- ---

-- ======================================================================
-- 🎯 Practice Questions (salesdb sample data) — try first, then look at the answer
-- ======================================================================
-- Run 00-Setup-Sample-Data.sql once before this section.

USE salesdb;

-- Q1. Cursor: loop over customers and build a list of names.
DELIMITER //
CREATE PROCEDURE list_customers()
BEGIN
  DECLARE done INT DEFAULT 0;
  DECLARE v_name VARCHAR(50);
  DECLARE v_all TEXT DEFAULT '';
  DECLARE cur CURSOR FOR SELECT firstname FROM customers ORDER BY customerid;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
  OPEN cur;
  read_loop: LOOP
    FETCH cur INTO v_name;
    IF done THEN LEAVE read_loop; END IF;
    SET v_all = CONCAT(v_all, v_name, ', ');
  END LOOP;
  CLOSE cur;
  SELECT v_all AS customer_names;
END //
DELIMITER ;
CALL list_customers();
DROP PROCEDURE list_customers;

-- Q2. The same result without a cursor (set-based — preferred).
SELECT GROUP_CONCAT(firstname ORDER BY customerid SEPARATOR ', ') AS customer_names FROM customers;
