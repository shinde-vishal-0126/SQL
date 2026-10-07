-- ======================================================================
-- Topic 35: Stored Procedures in PostgreSQL (Programmability)
-- ======================================================================

-- ------------------------------------------------------------
-- 📖 In Simple Words
-- ------------------------------------------------------------

-- * Definition: A stored procedure is a named set of SQL statements saved in the database. You run it with CALL and can pass input values (parameters).

-- * Real-life example: A saved recipe: write it once, then just say "make recipe X for 4 people".

-- * 🧩 Syntax:
--     CREATE [OR REPLACE] PROCEDURE proc_name(p1 INT, INOUT p2 INT DEFAULT NULL)
--     LANGUAGE plpgsql AS $$
--     DECLARE v INT := 0;
--     BEGIN
--       -- SQL statements, IF / LOOP, RAISE NOTICE ...
--     END $$;
--     CALL proc_name(10);
--     DROP PROCEDURE [IF EXISTS] proc_name(INT, INT);

-- * Syntax explained (each part):
--   - IN / OUT / INOUT → input value / value returned / both
--   - DECLARE → local variable inside the procedure
--   - BEGIN … END → the body with the SQL statements
--   - DELIMITER // (MySQL) / $$ (PostgreSQL) → lets the body contain ; without ending the CREATE early
--   - CALL → runs the procedure

-- * Example on salesdb (run 00-Setup-Sample-Data.sql first):
SET search_path TO sales;
CREATE OR REPLACE PROCEDURE count_orders(p_customerid INT)
LANGUAGE plpgsql AS $$
DECLARE n INT;
BEGIN
  SELECT COUNT(*) INTO n FROM orders WHERE customerid = p_customerid;
  RAISE NOTICE 'Customer % has % orders', p_customerid, n;
END $$;
CALL count_orders(2);
DROP PROCEDURE count_orders(INT);

-- * Example explained (step by step):
--   1. The procedure is saved once with a parameter for the customer id.
--   2. CALL runs it for customer 2 (Kevin).
--   3. Result: Kevin's 3 orders (1, 5, 9). The procedure is then dropped.

-- > In one line: A stored procedure lets us put our SQL code inside the database and add programming features like parameters, variables, `IF`/loops and error handling. In PostgreSQL this code is usually written in PL/pgSQL.

-- > 🐘 Read this first — 5 big differences from MySQL:
-- > 1. No `DELIMITER`. The body is written between `$$ ... $$` (dollar quoting).
-- > 2. `CREATE OR REPLACE PROCEDURE` works (MySQL needs `DROP` first).
-- > 3. Variables are declared in a `DECLARE` section before `BEGIN`, and assigned with `:=`. There are no `@session_variables`.
-- > 4. A plain `SELECT` inside a procedure does NOT send rows to the caller (error: `query has no destination for result data`). To return rows, use a FUNCTION `RETURNS TABLE` (Topic 36) — that is the normal PostgreSQL way. Procedures return values through `OUT` / `INOUT` parameters, and show messages with `RAISE NOTICE`.
-- > 5. Procedures exist since PostgreSQL 11. Before that, everything was a function. Procedures are mainly used when you need `COMMIT` / `ROLLBACK` inside the code.

-- ------------------------------------------------------------
-- 35.1 What Exactly is a Stored Procedure and Why Do We Use It?
-- ------------------------------------------------------------

-- * Client side vs Server side:

--   * As a user (client side), we write different SQL statements to interact with the database: a `SELECT` to retrieve data, an `INSERT` to add data, an `UPDATE` to change the content of a table, and so on.

-- * The problem (repeating the same steps):

--   * Suppose this is not a one-time job: every day you run an `INSERT`, then an `UPDATE`, then a `SELECT` — again and again.

--   * Now imagine you go on vacation, but the job must still be done. You hand over all these SQL scripts to your colleagues and tell them: "execute the first query, then the second, then the third".

--   * This is not a good way of working, because human errors happen — someone runs the scripts in the wrong order (e.g. the `UPDATE` before the `INSERT`) and things go wrong. That is exactly why we have stored procedures.

-- * The solution (Stored Procedure):

--   * We put all those SQL statements together in one frame / one program and call it a stored procedure.

--   * The SQL statements no longer stay on the client side; they are stored on the server side, inside the database. So you don't need to hand over your scripts to anyone.

--   * To run them, you just execute the procedure with one simple command: `CALL sp_name();` (in SQL Server the command is `EXEC sp_name`).

--   * The database then executes all the statements inside the procedure in exactly the order you defined (top to bottom).

--   * Now you simply tell your colleagues: "just execute this procedure — the database does the rest". This minimizes human errors and makes sure everything runs as you want.

-- * Summary: A stored procedure stores multiple SQL statements, in a specific order, inside the database. Each time you need them, you simply execute the procedure.

-- ------------------------------------------------------------
-- 35.2 Stored Procedure vs Normal Query
-- ------------------------------------------------------------

-- * Stored Procedure:

--   * Contains multiple SQL statements; when you execute it, there are many interactions with the database in one go (a PostgreSQL procedure can even commit several transactions).

--   * It is like a program in any programming language — more than one request. It can have:

--     * Looping logic (iterate over something),

--     * Control flow (`IF - ELSE`),

--     * Parameters and variables (to make the code dynamic and flexible),

--     * Error handling (to decide what happens when there is an issue).

--   * So it gives much more reusability and flexibility than a simple query.

-- * Normal Query:

--   * A normal SQL query is a one-time request: you ask the database for one thing and the database answers.

-- ------------------------------------------------------------
-- 35.3 What is a Procedure in PostgreSQL? (Definition & What It Can Contain)
-- ------------------------------------------------------------

-- * Creating a stored procedure in PostgreSQL allows you to save a block of SQL statements that can be executed later with a single command — useful for reusability, fewer network round trips and organization.

-- * A Stored Procedure is a named block of code that you save in the database and execute whenever needed. Think of it as a function in programming, but for the database.

-- * A PostgreSQL procedure can include:

--   * SQL queries

--   * DML, DDL, DCL and TCL commands (`COMMIT` / `ROLLBACK` are allowed in procedures, not in functions)

--   * Temporary tables and arrays (PostgreSQL has array types like `INT[]` and record types — no need for Oracle-style collections)

--   * Cursors and `FOR row IN query LOOP`

--   * Loops and `IF - ELSE` / `CASE` statements

--   * Variables (`DECLARE` section)

--   * Exception (error) handling with `EXCEPTION WHEN ... THEN` and `RAISE`

-- * Languages: besides `LANGUAGE plpgsql`, PostgreSQL supports `LANGUAGE sql` (plain SQL body) and extensions like PL/Python, PL/Perl, PL/v8 (JavaScript).

-- * A procedure is not only used to query data from a table; we can use it to build complex logic, data validation, data cleanup and much more.

-- ------------------------------------------------------------
-- 35.4 Key Points About Procedures
-- ------------------------------------------------------------

-- * Stored & cached per connection: The procedure is stored in the database. PostgreSQL parses the PL/pgSQL code the first time a connection calls it, and caches query plans for the statements inside (for that connection). The biggest speed gain comes from sending one `CALL` instead of many queries.

-- * Reusable: Instead of writing the same SQL again and again, you call the procedure.

-- * Takes Input & Output: You can pass parameters to procedures and get values back (`OUT` / `INOUT`).

-- * Improves Security: Users can be given access to execute a procedure without direct access to the tables (with `SECURITY DEFINER`, see 35.7).

-- * Encapsulation: Business logic stays in the database instead of being scattered in application code.

-- ------------------------------------------------------------
-- 35.5 What is the Purpose of Using a Procedure?
-- ------------------------------------------------------------

-- * Procedures were introduced to give more power to the SQL language.

-- * Procedures are generally used to do things which are not possible (or not easy) with plain SQL queries.

-- * A procedure may just bundle multiple queries together, or you may build entire software logic inside it — validation checks, data processing, queuing of data and much more.

-- * In short, the purpose is to make database operations faster, reusable, secure and easier to maintain:

--   1. Encapsulation of Business Logic: Put complex SQL logic in one place (inside the DB). Applications just call the procedure instead of writing long queries.

--   2. Reusability: Write the logic once and reuse it across multiple applications/users. Example: `get_employee_salary(dept_id)` can be used by the HR, Payroll and Finance apps.

--   3. Performance Optimization: Fewer network round trips and less parsing — plans of the statements inside are cached per connection.

--   4. Reduced Network Traffic: Instead of sending many SQL statements over the network, just call the procedure. Example: `CALL transfer_funds(101, 102, 5000);`

--   5. Security and Access Control: Users can be granted permission to execute a procedure without direct access to the underlying tables. Example: `GRANT EXECUTE ON PROCEDURE transfer_funds(INT, INT, NUMERIC) TO app_user;` and the app runs `CALL transfer_funds(...)` instead of getting `UPDATE` on the `accounts` table.

--   6. Maintainability: If business rules change, update the procedure once (`CREATE OR REPLACE`) — no need to modify all applications.

--   7. Atomic Operations (Transactions): Procedures can make sure multiple queries succeed or fail together. Example: debit one account and credit another in the same procedure.

-- * Procedures centralize logic, improve performance, enhance security and simplify maintenance.

-- ------------------------------------------------------------
-- 35.6 Advantages of Procedures & Real-World Example
-- ------------------------------------------------------------

-- * Advantages:

--   * Faster execution (one call, plans cached in the session).

--   * Reduces network traffic (send a procedure call instead of long SQL queries).

--   * Better security (grant `EXECUTE` instead of `UPDATE` on the table).

--   * Easier maintenance (update one procedure instead of many app queries).

-- * Real-world example (Bank application): A money transfer needs 3 steps:

--   1. Deduct from one account,

--   2. Add to another account,

--   3. Log the transaction.

--   * Instead of writing these 3 SQL queries every time in the app, you create a procedure `transfer_funds` and just call it.

-- ------------------------------------------------------------
-- 35.7 Use Cases of Stored Procedures
-- ------------------------------------------------------------

-- * A stored procedure is a stored block of code that performs a specific task inside the database. You can call it whenever you need, using the `CALL` command.

-- * Use case 1 | Reusing Business Logic (returning rows → use a function)

--   * Instead of writing the same SQL code many times in your application, put it in the database.

--   * Use case: called by many parts of the app to get active users — easy to maintain and update.

--   * Ex. In PostgreSQL, logic that returns rows is written as a function `RETURNS TABLE` / `RETURNS SETOF` and read with `SELECT`:
CREATE OR REPLACE FUNCTION get_active_users()
RETURNS SETOF users            -- returns full rows of the users table
LANGUAGE sql
AS $$
    SELECT * FROM users WHERE status = 'active';
$$;

SELECT * FROM get_active_users();

-- * Use case 2 | Improving Performance

--   * Frequently executed logic runs faster inside the database: the app sends one short `CALL` instead of many long queries, and the plans of the statements inside are cached per connection.

--   * Use case: large enterprise apps with heavy or repetitive database operations.

-- * Use case 3 | Reducing Network Traffic

--   * Instead of sending many SQL statements from your app to PostgreSQL, you send one procedure call.

--   * Use case: update and log an order change in a single round trip.

--   * Ex
CREATE OR REPLACE PROCEDURE update_order_status(p_order_id INT, p_new_status VARCHAR(20))
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE orders SET status = p_new_status WHERE id = p_order_id;
    INSERT INTO order_logs (order_id, status, updated_at)
    VALUES (p_order_id, p_new_status, now());
END;
$$;

CALL update_order_status(10, 'Shipped');

-- * Use case 4 | Enhancing Security

--   * You can limit direct table access. Users only need `EXECUTE` on the procedure, not privileges on the underlying tables — if the procedure is created with `SECURITY DEFINER`.

--   * Use case: allow an application to `CALL` procedures but not directly `SELECT`, `INSERT` or `DELETE` from sensitive tables.
ALTER PROCEDURE update_order_status(INT, VARCHAR) SECURITY DEFINER;   -- run with the owner's rights
REVOKE ALL ON PROCEDURE update_order_status(INT, VARCHAR) FROM PUBLIC;
GRANT EXECUTE ON PROCEDURE update_order_status(INT, VARCHAR) TO app_user;

--   * ⚠️ Difference from MySQL: MySQL procedures run as the DEFINER by default. PostgreSQL procedures and functions run as the INVOKER (the caller) by default — so the caller would need table rights. Add `SECURITY DEFINER` (and `SET search_path = public` for safety) when the procedure should use the owner's rights.

-- * Use case 5 | Ensuring Data Integrity / Transactions

--   * In PostgreSQL, if any statement inside the procedure fails, the whole `CALL` is rolled back automatically — no handler needed for "all or nothing".

--   * Ex
CREATE OR REPLACE PROCEDURE transfer_funds(p_from_acc INT, p_to_acc INT, p_amount NUMERIC(10,2))
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE accounts SET balance = balance - p_amount WHERE id = p_from_acc;
    UPDATE accounts SET balance = balance + p_amount WHERE id = p_to_acc;
    -- if the second UPDATE fails, the first one is undone automatically
END;
$$;

CALL transfer_funds(101, 102, 5000);

--   * Use case: banking systems — make sure debit and credit happen together or not at all.

-- * Use case 6 | Automation of Routine Tasks

--   * You can automate recurring database operations.

--   * ex
CREATE OR REPLACE PROCEDURE archive_old_orders()
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO orders_archive SELECT * FROM orders WHERE order_date < now() - INTERVAL '1 year';
    DELETE FROM orders WHERE order_date < now() - INTERVAL '1 year';
END;
$$;

-- run it automatically every night at 02:00 (needs the pg_cron extension — Topic 38)
SELECT cron.schedule('archive-orders', '0 2 * * *', 'CALL archive_old_orders()');

--   * Use case: scheduled maintenance or data cleanup.

-- * Use case 7 | Complex Reports or Aggregations (function returning a table)

--   * Report logic that returns rows is written as a function:

--   * ex
CREATE OR REPLACE FUNCTION sales_report(p_start DATE, p_end DATE)
RETURNS TABLE (category TEXT, total_sales NUMERIC)
LANGUAGE sql
AS $$
    SELECT s.category, SUM(s.amount)
    FROM sales s
    WHERE s.sale_date BETWEEN p_start AND p_end
    GROUP BY s.category;
$$;

SELECT * FROM sales_report('2025-01-01', '2025-03-31');

--   * Use case: generate a sales report for a specific date range.

-- ------------------------------------------------------------
-- 35.8 How to Create a Procedure (Syntax)
-- ------------------------------------------------------------

-- * Syntax of a Stored Procedure in PostgreSQL:
CREATE [OR REPLACE] PROCEDURE procedure_name (
    parameter1 datatype,                 -- IN is the default mode
    INOUT parameter2 datatype,
    OUT parameter3 datatype              -- OUT allowed in procedures from PostgreSQL 14
)
LANGUAGE plpgsql
AS $$
DECLARE
    -- local variables go here
BEGIN
    -- statements go here
END;
$$;

-- * Then call it:
CALL procedure_name(value1, value2, NULL);   -- pass NULL for OUT parameters

-- * Explanation:

--   * `CREATE OR REPLACE PROCEDURE` – creates the procedure, or replaces it if it already exists (same parameter types).

--   * `procedure_name` – the name you give your procedure (lowercase with `_` is the PostgreSQL style).

--   * `IN`, `OUT`, `INOUT` – parameter modes (`IN` is the default).

--   * `LANGUAGE plpgsql` – the language of the body.

--   * `AS $$ ... $$` – the body is a string written between two `$$` markers (dollar quoting). Inside it you can freely use `;` and single quotes. This replaces MySQL's `DELIMITER //`.

--   * `DECLARE` – (optional) section for local variables, before `BEGIN`.

--   * `BEGIN ... END;` – the block with the statements.

-- * Q1. Write a procedure for US customers to find the total number of customers and the average score.
-- PostgreSQL way 1: procedure with OUT parameters (PostgreSQL 14+)
CREATE OR REPLACE PROCEDURE total_customers(
    OUT p_total_count BIGINT,
    OUT p_average_score NUMERIC
)
LANGUAGE plpgsql
AS $$
BEGIN
    SELECT COUNT(*), AVG(score)
    INTO p_total_count, p_average_score
    FROM customers
    WHERE country = 'USA';
END;
$$;

-- CALL THE PROCEDURE (pass NULL for each OUT parameter)
CALL total_customers(NULL, NULL);
--  p_total_count | p_average_score
-- ---------------+-----------------
--              2 |           450.0

-- PostgreSQL way 2 (most common): a function that returns a table
CREATE OR REPLACE FUNCTION total_customers_fn()
RETURNS TABLE (total_count BIGINT, average_score NUMERIC)
LANGUAGE sql
AS $$
    SELECT COUNT(*), AVG(score) FROM customers WHERE country = 'USA';
$$;

SELECT * FROM total_customers_fn();

-- ------------------------------------------------------------
-- 35.9 Parameters in a Stored Procedure
-- ------------------------------------------------------------

-- * What are parameters in a stored procedure?

--   * Parameters are placeholders used to pass values (information) as input from the caller to the stored procedure.

--   * Parameters allow flexible, reusable and dynamic data processing.

-- * Steps to define a parameter in the procedure declaration:

--   1. (Optional) Define the parameter mode: `IN` (default), `OUT` or `INOUT`.

--   2. Then write the name of the parameter, and then its data type.

--   3. Once the parameter is defined, use it anywhere in the procedure instead of the static value.

--   4. Pass the parameter value at the time of execution (when we call the procedure).

-- * Rule: Never give a parameter the same name as a column. In PL/pgSQL, `WHERE country = country` gives an error: `column reference "country" is ambiguous`. Use a prefix like `p_`.

-- * Q1. For German customers find the total number of customers and the average score (create a stored procedure).
CREATE OR REPLACE PROCEDURE total_sales_country(
    p_country VARCHAR(50),
    OUT p_total_customers BIGINT,
    OUT p_avg_score NUMERIC
)
LANGUAGE plpgsql
AS $$
BEGIN
    SELECT COUNT(*), AVG(score)
    INTO p_total_customers, p_avg_score
    FROM customers
    WHERE country = p_country;
END;
$$;

CALL total_sales_country('Germany', NULL, NULL);

-- * Notes:

--   * Avoid repetition – if you notice repeated code in your project, it is a sign that your code can be improved.

--   * In the example above we want the data of every country with its average score. Instead of executing the query separately for each country, we create one stored procedure and pass the country value as a parameter. This makes the procedure dynamic and flexible and improves reusability.

--   * ⚠️ PostgreSQL compares text case-sensitively: `'GERMANY'` does not match `'Germany'`. Pass the exact value, or compare with `UPPER(country) = UPPER(p_country)`.

-- ------------------------------------------------------------
-- 35.10 Default Parameter Values
-- ------------------------------------------------------------

-- * Can we use default parameter values in PostgreSQL?

--   * A default parameter means: if the user doesn't pass a value when calling the procedure, a default value is used automatically.

--   * ✅ Yes. PostgreSQL supports `DEFAULT` (or `=`) for procedure and function parameters. (MySQL does not.)

--   * Parameters with defaults must come after parameters without defaults. You can also pass values by name: `CALL p(p_min_score => 70);`

-- * Q1. Find customers of a given country with a minimum score; by default it runs for USA customers with score ≥ 50.
-- Returning rows → function with defaults
CREATE OR REPLACE FUNCTION get_customers_by_country(
    p_country   VARCHAR(50) DEFAULT 'USA',
    p_min_score INT         DEFAULT 50
)
RETURNS TABLE (first_name VARCHAR, last_name VARCHAR, country VARCHAR, score INT)
LANGUAGE sql
AS $$
    SELECT c.first_name, c.last_name, c.country, c.score
    FROM customers c
    WHERE c.country = p_country
      AND c.score >= p_min_score;
$$;

-- call with default values
SELECT * FROM get_customers_by_country();                        -- Uses both defaults ('USA', 50)
SELECT * FROM get_customers_by_country('Germany');               -- Uses ('Germany', 50)
SELECT * FROM get_customers_by_country('France', 70);            -- Uses ('France', 70)
SELECT * FROM get_customers_by_country(p_min_score => 80);       -- Named: ('USA', 80)

-- ------------------------------------------------------------
-- 35.11 Multiple Statements in a Stored Procedure
-- ------------------------------------------------------------

-- * What does "multiple statements" mean? A stored procedure can contain more than one statement, for example:

--   * `SELECT ... INTO`, `INSERT`, `UPDATE`, `DELETE`

--   * Variable assignments (`:=`)

--   * Conditions (`IF`, `CASE`)

--   * Loops (`LOOP`, `WHILE`, `FOR`)

--   * Transactions (`COMMIT`, `ROLLBACK` — only in procedures)

--   * All enclosed inside `BEGIN ... END;`.

-- * Basic syntax:
CREATE OR REPLACE PROCEDURE procedure_name()
LANGUAGE plpgsql
AS $$
BEGIN
    -- Statement 1
    -- Statement 2
    -- Statement 3
END;
$$;

-- * Q1. For a given country (e.g. Germany) find the total number of customers and the average score, and also the total number of orders and total sales (create a stored procedure).
CREATE OR REPLACE PROCEDURE country_summary(
    p_country VARCHAR(50),
    OUT p_total_customers BIGINT,
    OUT p_avg_score NUMERIC,
    OUT p_total_orders BIGINT,
    OUT p_total_sales NUMERIC
)
LANGUAGE plpgsql
AS $$
BEGIN
    -- Customers summary
    SELECT COUNT(*), AVG(score)
    INTO p_total_customers, p_avg_score
    FROM customers
    WHERE country = p_country;

    -- Orders summary
    SELECT COUNT(*), SUM(o.sales)
    INTO p_total_orders, p_total_sales
    FROM orders o
    JOIN customers c ON c.customerid = o.customerid
    WHERE c.country = p_country;
END;
$$;

-- * Call it:
CALL country_summary('Germany', NULL, NULL, NULL, NULL);

--   * PostgreSQL returns one row with all 4 OUT values (MySQL returned two separate result sets). No collation tricks are needed — PostgreSQL text comparison has no "illegal mix of collations" error in normal databases.

-- * Example: Multiple statements in one procedure
CREATE OR REPLACE PROCEDURE manage_customer(p_id INT, p_country VARCHAR(50))
LANGUAGE plpgsql
AS $$
BEGIN
    -- Insert a log entry
    INSERT INTO logs(action, log_time) VALUES ('Procedure Called', now());

    -- Update customer record
    UPDATE customers
    SET country = p_country
    WHERE customer_id = p_id;

    -- Display confirmation (as a message, not a result set)
    RAISE NOTICE 'Customer % updated to %', p_id, p_country;
END;
$$;

-- call
CALL manage_customer(101, 'Germany');
-- NOTICE:  Customer 101 updated to Germany

-- * Example: Multiple queries + local variables
CREATE OR REPLACE PROCEDURE get_sales_summary(
    p_country VARCHAR(50),
    OUT p_total NUMERIC(10,2),
    OUT p_average NUMERIC(10,2)
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_total_sales NUMERIC(10,2);
    v_avg_sales   NUMERIC(10,2);
BEGIN
    -- Calculate total and average
    SELECT SUM(amount), AVG(amount)
    INTO v_total_sales, v_avg_sales
    FROM sales
    WHERE country = p_country;

    -- Insert summary into log table
    INSERT INTO sales_summary(country, total, average, created_at)
    VALUES (p_country, v_total_sales, v_avg_sales, now());

    -- Return result to user (through OUT parameters)
    p_total   := v_total_sales;
    p_average := v_avg_sales;
END;
$$;

CALL get_sales_summary('USA', NULL, NULL);

-- ------------------------------------------------------------
-- 35.12 Variables in PostgreSQL (Session Settings vs Local Variables)
-- ------------------------------------------------------------

-- * What is a variable?

--   * Variables are placeholders used to store a value and use it later in the procedure.

--   * A variable is like a value in memory that we can reuse anywhere inside the procedure.

--   * It is not like a parameter: a parameter passes a value into the procedure (and back to the caller); a variable temporarily stores and manipulates data during execution.

-- * PostgreSQL has no MySQL-style `@user_variables`. There are 3 options:

--   1. Local variables in PL/pgSQL (`DECLARE` section) — the normal way.

--   2. psql client variables (`\set name value`, used as `:name` / `:'name'`) — only in the psql tool.

--   3. Custom session settings (`SET my.var = '...'`, read with `current_setting('my.var')`) — text only, rarely needed.

-- * 1. psql client variables (closest to MySQL `@variable` for testing)

--   * Scope: the psql session (they are replaced by psql before the query is sent).

--   * Ex. A – set and read:
-- (psql/client command — run it in psql, not in a GUI query tool):
-- \set country 'USA'
SELECT :'country';                 -- 'USA'

--   * Ex. B – use in queries:
-- (psql/client command — run it in psql, not in a GUI query tool):
-- \set min_score 70
SELECT * FROM customers WHERE score > :min_score;

--   * Ex. C – assign from a query (psql `\gset` stores the result columns into variables):
SELECT COUNT(*) AS total_customers
FROM customers
WHERE country = 'Germany' \gset

SELECT :total_customers AS total_customers;

--   * Custom session setting (works from any client):
SET my.country = 'USA';
SELECT current_setting('my.country');   -- 'USA'

-- * 2. Local Variables (declared inside a procedure / function / DO block)

--   * Scope: only inside the block.

--   * Must be declared in the `DECLARE` section, before `BEGIN`.

--   * Used for temporary storage or intermediate results.

--   * Syntax: `variable_name datatype [:= value];` (or `DEFAULT value`). Assign later with `:=` (or `=`).

--   * Handy types: `v_row customers%ROWTYPE` (a whole row), `v_name customers.first_name%TYPE` (same type as a column), `v_rec RECORD` (any row).

--   * Example – using local variables (and assigning new values later). A `DO` block runs code once without creating anything — great for testing:
DO $$
DECLARE
    v_total     INT := 0;
    v_avg_score NUMERIC(5,2);
BEGIN
    SELECT COUNT(*), AVG(score)
    INTO v_total, v_avg_score
    FROM customers
    WHERE country = 'USA';

    RAISE NOTICE 'USA customers: %, average score: %', v_total, v_avg_score;

    -- assign value later
    v_total := v_total + 10;
    SELECT COUNT(*) INTO v_total FROM customers;
    RAISE NOTICE 'All customers: %', v_total;
END;
$$;

-- * What is `INTO` in PL/pgSQL?

--   * `SELECT ... INTO var` stores the query result into variables: "take the value(s) returned by this query and put them into variable(s)".

--   * If the query returns no row, the variables become `NULL` and the special variable `FOUND` is `false` (no error). If it returns several rows, the first row is used.

--   * Add `STRICT` (`SELECT ... INTO STRICT var`) to get an error for 0 rows (`NO_DATA_FOUND`) or more than 1 row (`TOO_MANY_ROWS`).

--   * ⚠️ Outside PL/pgSQL, `SELECT ... INTO new_table FROM ...` means "create a new table" (like CTAS) — a different thing.

-- * Differences between psql variables and local variables:

-- (Feature → psql variable (\set) | Local Variable (PL/pgSQL))
--
-- * Scope
--     - psql variable (\set)      : The psql session (client side)
--     - Local Variable (PL/pgSQL) : Inside the block only
--
-- * Declaration
--     - psql variable (\set)      : \set x 10
--     - Local Variable (PL/pgSQL) : DECLARE x INT := 10;
--
-- * Use
--     - psql variable (\set)      : :x / :'x' in a query
--     - Local Variable (PL/pgSQL) : x
--
-- * Lifetime
--     - psql variable (\set)      : Until psql closes
--     - Local Variable (PL/pgSQL) : Until the block ends
--
-- * Use case
--     - psql variable (\set)      : Testing, scripts
--     - Local Variable (PL/pgSQL) : Procedures, functions, triggers
--

-- * Example with both (psql variable passed into a procedure parameter):
CREATE OR REPLACE PROCEDURE variable_demo(p_user_country TEXT, OUT p_total_local BIGINT, OUT p_user_country_out TEXT)
LANGUAGE plpgsql
AS $$
DECLARE
    v_local_country VARCHAR(20) := 'Germany';
BEGIN
    SELECT COUNT(*) INTO p_total_local
    FROM customers
    WHERE country = v_local_country;

    p_user_country_out := p_user_country;
END;
$$;

-- (psql/client command — run it in psql, not in a GUI query tool):
-- \set user_country 'USA'
CALL variable_demo(:'user_country', NULL, NULL);

-- ------------------------------------------------------------
-- 35.13 Control Flow: IF ... ELSIF ... ELSE
-- ------------------------------------------------------------

-- * In PL/pgSQL, the `IF ... THEN ... ELSE` structure is used inside procedures, functions, triggers and DO blocks.

-- * Syntax:
IF condition THEN
    statements;
ELSIF condition THEN          -- PostgreSQL spells it ELSIF (ELSEIF also accepted)
    statements;
ELSE
    statements;
END IF;

--   * You must end it with `END IF;`

--   * It can have multiple `ELSIF` clauses (optional).

--   * `ELSE` is also optional.

-- * Simple IF - ELSE:
CREATE OR REPLACE PROCEDURE check_number(num INT)
LANGUAGE plpgsql
AS $$
BEGIN
    IF num > 0 THEN
        RAISE NOTICE 'Positive number';
    ELSIF num = 0 THEN
        RAISE NOTICE 'Zero';
    ELSE
        RAISE NOTICE 'Negative number';
    END IF;
END;
$$;

CALL check_number(-7);   -- NOTICE: Negative number

-- * With a variable (store the answer, then return it):
CREATE OR REPLACE PROCEDURE check_number_var(num INT, OUT p_result VARCHAR(20))
LANGUAGE plpgsql
AS $$
BEGIN
    IF num > 0 THEN
        p_result := 'Positive number';
    ELSIF num = 0 THEN
        p_result := 'Zero';
    ELSE
        p_result := 'Negative number';
    END IF;
END;
$$;

CALL check_number_var(0, NULL);   -- p_result = Zero

-- * Ex. (Money transfer with a balance check):
CREATE OR REPLACE PROCEDURE transfer_funds_checked(
    p_from_acc INT,
    p_to_acc   INT,
    p_amount   NUMERIC(10,2),
    OUT p_message TEXT
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_sender_balance NUMERIC(10,2);
BEGIN
    -- Get sender balance and lock the row, so no other transfer can change it meanwhile
    SELECT balance INTO v_sender_balance
    FROM accounts
    WHERE acc_id = p_from_acc
    FOR UPDATE;

    IF v_sender_balance >= p_amount THEN
        UPDATE accounts SET balance = balance - p_amount WHERE acc_id = p_from_acc;
        UPDATE accounts SET balance = balance + p_amount WHERE acc_id = p_to_acc;
        p_message := 'Transfer Successful';
    ELSE
        p_message := 'Insufficient Balance';
    END IF;
END;
$$;

CALL transfer_funds_checked(1, 2, 500, NULL);

--   * Interview point: `SELECT ... FOR UPDATE` locks the sender's row until the `CALL` finishes. Without it, two transfers running at the same moment could both see enough balance and overdraw the account. The whole `CALL` is one transaction, so no `START TRANSACTION` is needed.

-- * Example — inside a query: PostgreSQL has no `IF()` function. Use `CASE`:
SELECT
    name,
    CASE WHEN score >= 60 THEN 'Pass' ELSE 'Fail' END AS result
FROM students;

-- * Full example (discount rules):
CREATE OR REPLACE PROCEDURE customer_discount(p_total_purchase NUMERIC(10,2))
LANGUAGE plpgsql
AS $$
DECLARE
    v_discount NUMERIC(5,2);
BEGIN
    IF p_total_purchase >= 1000 THEN
        v_discount := 0.15;  -- 15%
    ELSIF p_total_purchase >= 500 THEN
        v_discount := 0.10;  -- 10%
    ELSE
        v_discount := 0.05;  -- 5%
    END IF;

    RAISE NOTICE 'Discount rate: %%%', v_discount * 100;   -- %% prints a real % sign
END;
$$;

CALL customer_discount(750);   -- NOTICE: Discount rate: 10.00%

-- * Ex. real DB example of an IF - ELSE statement (customers table): check a customer's score and give them a level; handle `NULL` first. (Returns a row → function.)
CREATE OR REPLACE FUNCTION customer_level(p_customer_id INT)
RETURNS TABLE (customer TEXT, score INT, level TEXT)
LANGUAGE plpgsql
AS $$
DECLARE
    v_score INT;
    v_name  VARCHAR(50);
BEGIN
    SELECT c.first_name, COALESCE(c.score, 0)   -- treat a NULL score as 0
    INTO v_name, v_score
    FROM customers c
    WHERE c.customerid = p_customer_id;

    IF NOT FOUND THEN
        RAISE NOTICE 'Customer not found';
        RETURN;                                -- returns 0 rows
    ELSIF v_score >= 750 THEN
        RETURN QUERY SELECT v_name::TEXT, v_score, 'GOLD'::TEXT;
    ELSIF v_score >= 400 THEN
        RETURN QUERY SELECT v_name::TEXT, v_score, 'SILVER'::TEXT;
    ELSE
        RETURN QUERY SELECT v_name::TEXT, v_score, 'BRONZE'::TEXT;
    END IF;
END;
$$;

SELECT * FROM customer_level(2);   -- e.g. John | 900 | GOLD

-- * Note: Handle `NULL` before aggregation or comparison to ensure accurate results (treat `NULL` as zero with `COALESCE(score, 0)`, as above). Use the built-in `FOUND` variable to check whether `SELECT INTO` found a row.

-- ------------------------------------------------------------
-- 35.14 Loops in a Stored Procedure
-- ------------------------------------------------------------

-- * Ex. (WHILE loop):
CREATE OR REPLACE PROCEDURE insert_numbers()
LANGUAGE plpgsql
AS $$
DECLARE
    i INT := 1;
BEGIN
    WHILE i <= 5 LOOP
        INSERT INTO numbers_table (num) VALUES (i);
        i := i + 1;
    END LOOP;
END;
$$;

CALL insert_numbers();

-- * PostgreSQL loop types:

--   * `LOOP ... END LOOP;` — endless loop; leave with `EXIT WHEN condition;` (MySQL `LEAVE`), skip to next round with `CONTINUE WHEN condition;` (MySQL `ITERATE`).

--   * `WHILE condition LOOP ... END LOOP;` — checks the condition first.

--   * `FOR i IN 1..5 LOOP ... END LOOP;` — counting loop (the variable `i` is declared automatically). `FOR i IN REVERSE 5..1` counts down; `BY 2` changes the step.

--   * `FOR rec IN SELECT ... LOOP ... END LOOP;` — loop over query rows (an easy cursor, Topic 39).

--   * `FOREACH x IN ARRAY my_array LOOP ... END LOOP;` — loop over an array.

--   * There is no `REPEAT ... UNTIL`; use `LOOP ... EXIT WHEN ...; END LOOP;`.

-- * The same job with a `FOR` loop (shortest):
CREATE OR REPLACE PROCEDURE insert_numbers_for()
LANGUAGE plpgsql
AS $$
BEGIN
    FOR i IN 1..5 LOOP
        INSERT INTO numbers_table (num) VALUES (i);
    END LOOP;
END;
$$;

-- Even shorter in plain SQL (no loop at all):
INSERT INTO numbers_table (num) SELECT generate_series(1, 5);

-- ------------------------------------------------------------
-- 35.15 Best-Practice Notes for Procedures
-- ------------------------------------------------------------

-- * Always put the body between `$$ ... $$` and end it with `END;` and `$$;`.

-- * Use `CREATE OR REPLACE` so you can change the code without dropping it.

-- * Use variables (`DECLARE`, `:=`, `SELECT ... INTO`) for intermediate values; prefix them (`v_`, `p_`) to avoid clashes with column names.

-- * Any unhandled error rolls back the whole call automatically. Use `EXCEPTION` blocks only when you really need to handle an error (they cost a little performance, because each one creates a savepoint).

-- * Return rows with a FUNCTION (`RETURNS TABLE`), values with `OUT` parameters, and messages with `RAISE NOTICE`.

-- * Keep procedures modular and readable. Prefer one set-based SQL statement over a row-by-row loop.

-- * For permission-wrapping procedures, use `SECURITY DEFINER` together with `SET search_path = public, pg_temp` (prevents search_path attacks).

-- * Best practice: if you have multiple statements, end each one with `;` so it is easy to see where each statement ends.

-- ------------------------------------------------------------
-- 35.16 Dollar Quoting `$$` (PostgreSQL's Answer to MySQL `DELIMITER`)
-- ------------------------------------------------------------

-- * MySQL needs `DELIMITER //` because the client would stop at the first `;` inside the procedure. PostgreSQL solves this differently: the whole body is one string literal, written between `$$` markers.
CREATE OR REPLACE PROCEDURE log_two_rows()
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO logs(action, log_time) VALUES ('first', now());
    INSERT INTO logs(action, log_time) VALUES ('second', now());
END;
$$;

-- * Explanation:

--   * `AS $$` → the body string starts.

--   * Inside, you can safely use `;` and even single quotes (`'first'`) without escaping.

--   * `$$;` → the body string ends, and the `;` ends the `CREATE` statement.

--   * If the body itself contains `$$`, use a tag: `AS $body$ ... $body$;`

-- * Important notes:

--   * `CREATE OR REPLACE PROCEDURE` works in PostgreSQL. (To change the parameter list, drop it first — procedures are identified by name + parameter types.)

--   * Local variables go in the `DECLARE` section, before `BEGIN`.

--   * To print a message when the procedure runs, use `RAISE NOTICE 'product sold';` (MySQL used `SELECT 'product sold';`).

--   * Execute the procedure using `CALL procedure_name();`

--   * Every parameter needs a data type.

-- * How to drop a procedure: `DROP PROCEDURE IF EXISTS procedure_name;` (add the parameter types if there are several procedures with the same name: `DROP PROCEDURE transfer_funds(INT, INT, NUMERIC);`)

-- * How to see procedures:
-- (psql/client command — run it in psql, not in a GUI query tool):
-- \df                                     -- list functions and procedures (psql)
-- (psql/client command — run it in psql, not in a GUI query tool):
-- \sf transfer_funds                      -- show the source code (psql)

SELECT pg_get_functiondef('transfer_funds'::regproc);   -- source code (any client)

SELECT routine_name, routine_type
FROM information_schema.routines
WHERE routine_schema = 'public';

-- ------------------------------------------------------------
-- 35.17 Messages in a Procedure (RAISE)
-- ------------------------------------------------------------

-- * 1. Using `RAISE EXCEPTION` (custom errors — MySQL `SIGNAL`)

--   * If you want to stop with an error and your own message, use `RAISE EXCEPTION`.
CREATE OR REPLACE PROCEDURE check_score(p_score INT)
LANGUAGE plpgsql
AS $$
BEGIN
    IF p_score < 0 THEN
        RAISE EXCEPTION 'Score cannot be negative'
            USING ERRCODE = 'P0001', HINT = 'Pass a value of 0 or more';
    ELSE
        RAISE NOTICE 'Score is valid';
    END IF;
END;
$$;

CALL check_score(-5);   -- ERROR: Score cannot be negative

--   * `RAISE EXCEPTION` without `ERRCODE` uses SQLSTATE `P0001` (`raise_exception`). MySQL's equivalent is `SIGNAL SQLSTATE '45000'`.

-- * 2. `RAISE` levels (messages without stopping)

--   * `RAISE DEBUG`, `LOG`, `INFO`, `NOTICE`, `WARNING` — print a message and continue. `EXCEPTION` — stop with an error.

--   * `%` in the message is replaced by the next value: `RAISE NOTICE 'Customer % has score %', v_name, v_score;`

-- * 3. Store a message in a variable and return it
CREATE OR REPLACE PROCEDURE store_message_example(OUT p_message VARCHAR(255))
LANGUAGE plpgsql
AS $$
DECLARE
    v_msg VARCHAR(255);
BEGIN
    -- Store message into a variable
    v_msg := 'Procedure executed successfully!';

    -- Return it
    p_message := v_msg;
END;
$$;

CALL store_message_example(NULL);

-- ------------------------------------------------------------
-- 35.18 Types of Procedures & How to Execute Them
-- ------------------------------------------------------------

-- * A. By parameters

--   1. Without parameters – no input/output, just executes fixed logic. Example: `get_all_employees()` — returns rows, so in PostgreSQL it is a function:
CREATE OR REPLACE FUNCTION get_all_employees()
RETURNS SETOF employees
LANGUAGE sql
AS $$
    SELECT * FROM employees;
$$;
--      And call it: `SELECT * FROM get_all_employees();`

--   2. With input parameters (`IN`) – accept values and use them inside. Example: `get_employees_by_dept(p_dept_id INT)`
CREATE OR REPLACE FUNCTION get_employees_by_dept(p_dept_id INT)
RETURNS SETOF employees
LANGUAGE sql
AS $$
    SELECT * FROM employees WHERE department_id = p_dept_id;
$$;

SELECT * FROM get_employees_by_dept(2);

--   3. With output parameters (`OUT`) – return computed values. Example: `get_employee_count(p_dept_id INT, OUT p_emp_count INT)`
CREATE OR REPLACE PROCEDURE get_employee_count(p_dept_id INT, OUT p_emp_count INT)
LANGUAGE plpgsql
AS $$
BEGIN
    SELECT COUNT(*) INTO p_emp_count
    FROM employees
    WHERE department_id = p_dept_id;
END;
$$;

CALL get_employee_count(2, NULL);   -- shows p_emp_count

--   4. With input & output parameters (`INOUT`) – accept a value, modify it and return it. Example: `calculate_bonus(INOUT p_salary NUMERIC)`
CREATE OR REPLACE PROCEDURE calculate_bonus(INOUT p_salary NUMERIC(10,2))
LANGUAGE plpgsql
AS $$
BEGIN
    -- add a 20% bonus to the salary that was passed in
    p_salary := p_salary + (p_salary * 0.20);
END;
$$;

CALL calculate_bonus(40000);   -- p_salary = 48000.00

-- * B. By functionality

--   1. Data manipulation procedures – perform `INSERT`, `UPDATE`, `DELETE`. Example: `add_employee()`
CREATE OR REPLACE PROCEDURE add_employee(p_emp_name VARCHAR(100), p_emp_salary NUMERIC(10,2))
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO employees(name, salary)
    VALUES (p_emp_name, p_emp_salary);
END;
$$;
--      Call it: `CALL add_employee('Vishal', 55000);`

--   2. Data retrieval routines – perform complex `SELECT` queries. In PostgreSQL these are functions: `SELECT * FROM get_top_selling_products();`

--   3. Utility procedures – perform tasks like logging, auditing, batch processing with `COMMIT` in between.

-- * C. By transaction control

--   1. Autonomous procedures – run independently of the calling transaction (Oracle `PRAGMA AUTONOMOUS_TRANSACTION`). PostgreSQL has no autonomous transactions; the `dblink` extension can be used as a workaround.

--   2. Procedures that control transactions – a PostgreSQL procedure called with `CALL` (not inside an outer `BEGIN`) may run `COMMIT` and `ROLLBACK` itself. This is useful for big batch jobs that commit every N rows:
CREATE OR REPLACE PROCEDURE archive_in_batches()
LANGUAGE plpgsql
AS $$
DECLARE
    v_moved INT;
BEGIN
    LOOP
        WITH moved AS (
            DELETE FROM orders
            WHERE id IN (SELECT id FROM orders
                         WHERE order_date < now() - INTERVAL '1 year'
                         LIMIT 10000)
            RETURNING *
        )
        INSERT INTO orders_archive SELECT * FROM moved;

        GET DIAGNOSTICS v_moved = ROW_COUNT;
        EXIT WHEN v_moved = 0;
        COMMIT;                       -- free locks and WAL after every batch
    END LOOP;
END;
$$;

CALL archive_in_batches();

--   3. Dependent routines – everything else: a function, or a procedure called inside an outer transaction, runs in the caller's transaction and cannot commit.

-- * In short:

--   * Parameter-based → no parameter, `IN`, `OUT`, `INOUT`.

--   * Purpose-based → retrieval (functions), manipulation, utility.

--   * Transaction-based → procedures that `COMMIT` inside (PostgreSQL 11+), dependent (functions / nested calls). No autonomous transactions.

-- * How to execute:

--   * Procedure → `CALL procedure_name(param1, param2, ...);`

--   * Procedure with an `OUT` parameter → pass `NULL` in its place: `CALL get_employee_count(2, NULL);` (PostgreSQL 14+). In PostgreSQL 11–13 only `INOUT` existed.

--   * Function → `SELECT function_name(...);` or `SELECT * FROM function_name(...);`

-- * Important notes:

--   * Use `CALL` for procedures, `SELECT` for functions.

--   * No `@variables` are needed for OUT parameters — PostgreSQL shows them as a result row.

--   * Procedures don't have a return value; they return `OUT`/`INOUT` parameters. Functions return a value or a table.

-- ------------------------------------------------------------
-- 35.19 Creating Procedures With and Without Parameters (IN, OUT, INOUT)
-- ------------------------------------------------------------

-- * There are three kinds of parameters in PostgreSQL procedures:

--   * `IN` → input (default; pass a value).

--   * `OUT` → output (return a value) — procedures from PostgreSQL 14.

--   * `INOUT` → both input and output.

-- * With an `IN` parameter (returns rows → function):
CREATE OR REPLACE FUNCTION get_employees_by_dept(p_dept_id INT)
RETURNS SETOF employees
LANGUAGE sql
AS $$
    SELECT * FROM employees WHERE department_id = p_dept_id;
$$;
--   Call using → `SELECT * FROM get_employees_by_dept(2);`

-- * With an `OUT` parameter:
CREATE OR REPLACE PROCEDURE get_employee_count(p_dept_id INT, OUT p_emp_count INT)
LANGUAGE plpgsql
AS $$
BEGIN
    SELECT COUNT(*) INTO p_emp_count
    FROM employees
    WHERE department_id = p_dept_id;
END;
$$;
--   Call using → `CALL get_employee_count(2, NULL);` (the output value is shown as a column `p_emp_count`)

-- * With an `INOUT` parameter:
CREATE OR REPLACE PROCEDURE increase_salary(INOUT p_emp_salary NUMERIC(10,2))
LANGUAGE plpgsql
AS $$
BEGIN
    p_emp_salary := p_emp_salary * 1.10; -- increase by 10%
END;
$$;
--   Call using → `CALL increase_salary(50000);` — returns 55000.00.

--   * Inside another PL/pgSQL block you can pass a variable and get it back:
DO $$
DECLARE
    v_salary NUMERIC(10,2) := 50000;
BEGIN
    CALL increase_salary(v_salary);
    RAISE NOTICE 'New salary: %', v_salary;   -- 55000.00
END;
$$;

-- * Summary:

--   * Without param → fixed query, no input.

--   * With `IN` → pass a value.

--   * With `OUT` → get a value back.

--   * With `INOUT` → pass a value and get the updated value back.

-- * Without parameters (returns rows → function):
CREATE OR REPLACE FUNCTION get_all_employees()
RETURNS SETOF employees
LANGUAGE sql
AS $$
    SELECT * FROM employees;
$$;
--   Call using → `SELECT * FROM get_all_employees();`

-- * (The same routine names are used in 35.18 — `CREATE OR REPLACE` simply replaces them.)

-- ------------------------------------------------------------
-- 35.20 Error Handling in PL/pgSQL (EXCEPTION Blocks)
-- ------------------------------------------------------------

-- * Error handling is a very important part of writing robust PostgreSQL code: we need to detect, handle and raise errors.

-- * Why error handling is needed: When something goes wrong (bad data, duplicate key, missing table, constraint violation), PostgreSQL raises an error, stops, and rolls back the current block. With an `EXCEPTION` section you can:

--   * Catch and manage the error (instead of failing the whole call),

--   * Log it into a table,

--   * Return a custom message.

-- * Basic syntax:
BEGIN
    -- statements that might fail
EXCEPTION
    WHEN condition_name [OR condition_name ...] THEN
        -- handler statements
    WHEN OTHERS THEN
        -- any other error
END;

-- * How it behaves (very important):

--   1. When an error happens inside the `BEGIN` part, all changes made in that `BEGIN` part are rolled back (the block works like a savepoint), and the matching `WHEN` runs.

--   2. After the handler, execution continues after the `END;` of that block — so the block itself is "EXIT", and the code after it is "CONTINUE".

--   3. If no `WHEN` matches, the error goes up to the caller.

-- * Common condition names (full list: "PostgreSQL Error Codes" in the docs):

--   * `OTHERS` → catches all errors (MySQL `SQLEXCEPTION`).

--   * `unique_violation` (23505) → duplicate key (MySQL error 1062).

--   * `foreign_key_violation` (23503), `not_null_violation` (23502), `check_violation` (23514).

--   * `undefined_table` (42P01) → table doesn't exist (MySQL 1146).

--   * `division_by_zero` (22012).

--   * `no_data_found` / `too_many_rows` → only with `SELECT ... INTO STRICT`.

--   * Warnings are not errors in PostgreSQL, so there is nothing like `SQLWARNING` handlers.

-- * Useful variables inside a handler: `SQLSTATE` (error code) and `SQLERRM` (error message). More details with `GET STACKED DIAGNOSTICS`.

-- * 1. "CONTINUE"-style example (catch the error and keep going):
CREATE OR REPLACE PROCEDURE simple_error_handling()
LANGUAGE plpgsql
AS $$
BEGIN
    BEGIN
        PERFORM 1 / 0;                          -- division_by_zero (PERFORM = run a SELECT and ignore the result)
    EXCEPTION
        WHEN division_by_zero THEN
            RAISE NOTICE 'An error occurred, but procedure continued';
    END;

    RAISE NOTICE 'Procedure finished successfully';
END;
$$;

CALL simple_error_handling();   -- shows both messages

-- * 2. "EXIT"-style example – stop the procedure after an error:
CREATE OR REPLACE PROCEDURE exit_error_demo()
LANGUAGE plpgsql
AS $$
BEGIN
    EXECUTE 'SELECT * FROM table_that_does_not_exist';   -- causes undefined_table
    RAISE NOTICE 'This will NOT run';
EXCEPTION
    WHEN undefined_table THEN
        RAISE NOTICE 'Error occurred — procedure terminated';
END;
$$;

CALL exit_error_demo();   -- shows only the error message

--   * Why `EXECUTE '...'`? PL/pgSQL checks static SQL when the procedure runs, but a missing table in plain SQL may already fail at plan time. Dynamic SQL (`EXECUTE`) makes the example fail exactly at that line.

-- * 3. Handling "no rows found":
CREATE OR REPLACE PROCEDURE not_found_demo()
LANGUAGE plpgsql
AS $$
DECLARE
    v_customer_name VARCHAR(50);
BEGIN
    SELECT name INTO v_customer_name
    FROM customers
    WHERE id = 9999;    -- assume it doesn't exist

    IF NOT FOUND THEN
        RAISE NOTICE 'Customer not found';
    ELSE
        RAISE NOTICE 'Customer found: %', v_customer_name;
    END IF;
END;
$$;

-- Same thing with STRICT + exception:
--   SELECT name INTO STRICT v_customer_name FROM customers WHERE id = 9999;
-- EXCEPTION WHEN no_data_found THEN RAISE NOTICE 'Customer not found';

-- * 4. Logging errors into a table:
CREATE TABLE error_log (
    id SERIAL PRIMARY KEY,
    error_time TIMESTAMPTZ DEFAULT now(),
    error_message TEXT
);
--   Now write the procedure (it saves the real PostgreSQL error text):
CREATE OR REPLACE PROCEDURE log_error_demo()
LANGUAGE plpgsql
AS $$
DECLARE
    v_err_msg   TEXT;
    v_err_state TEXT;
BEGIN
    -- This will trigger the handler
    EXECUTE 'SELECT * FROM table_that_does_not_exist';
EXCEPTION
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS v_err_msg = MESSAGE_TEXT,
                                v_err_state = RETURNED_SQLSTATE;
        INSERT INTO error_log (error_message)
        VALUES ('Error in log_error_demo: ' || v_err_msg || ' (' || v_err_state || ')');
END;
$$;

CALL log_error_demo();
SELECT * FROM error_log;   -- Error in log_error_demo: relation "table_that_does_not_exist" does not exist (42P01)

--   * ⚠️ If the handler re-raises the error (`RAISE;`), the `INSERT INTO error_log` is rolled back too (same transaction). To keep a log even when you re-raise, use `RAISE NOTICE`/`RAISE LOG` (goes to the server log) or the `dblink` extension.

-- * 5. Raising a custom error (`RAISE EXCEPTION`) – you can manually raise an error:
CREATE OR REPLACE PROCEDURE raise_error_demo(p_amount INT)
LANGUAGE plpgsql
AS $$
BEGIN
    IF p_amount < 0 THEN
        RAISE EXCEPTION 'Amount cannot be negative';
    ELSE
        RAISE NOTICE 'Valid amount';
    END IF;
END;
$$;

-- * 6. Full example: handling + raising (the error is reported to the server log and still returned to the caller with `RAISE;`):
CREATE OR REPLACE PROCEDURE full_error_demo(p_amount NUMERIC(10,2))
LANGUAGE plpgsql
AS $$
BEGIN
    IF p_amount < 0 THEN
        RAISE EXCEPTION 'Amount must be positive' USING ERRCODE = '22023';   -- invalid_parameter_value
    END IF;

    INSERT INTO sales (amount) VALUES (p_amount);
    RAISE NOTICE 'Transaction successful';
EXCEPTION
    WHEN OTHERS THEN
        RAISE LOG 'full_error_demo failed: % (%)', SQLERRM, SQLSTATE;   -- written to the server log
        RAISE;   -- pass the same error back to the caller (MySQL RESIGNAL)
END;
$$;

CALL full_error_demo(-10);   -- ERROR: Amount must be positive

-- * Control flow: `IF ... ELSIF ... ELSE ... END IF;`, loops: `LOOP` + `EXIT WHEN`, `WHILE`, `FOR i IN 1..n`, `FOR rec IN query`, `FOREACH ... IN ARRAY`.

-- ---

-- ======================================================================
-- 🎯 Practice Questions (salesdb sample data) — try first, then look at the answer
-- ======================================================================
-- Run 00-Setup-Sample-Data.sql once before this section.

SET search_path TO sales;

-- Q1. Procedure: orders of one customer.
CREATE OR REPLACE PROCEDURE log_customer_orders(p_customerid INT)
LANGUAGE plpgsql AS $$
DECLARE n INT;
BEGIN
  SELECT COUNT(*) INTO n FROM orders WHERE customerid = p_customerid;
  RAISE NOTICE 'Customer % has % orders', p_customerid, n;
END $$;
CALL log_customer_orders(1);

-- Q2. Procedure with OUT parameter: total sales of a customer.
CREATE OR REPLACE PROCEDURE customer_total(p_customerid INT, INOUT p_total INT DEFAULT NULL)
LANGUAGE plpgsql AS $$
BEGIN
  SELECT COALESCE(SUM(sales), 0) INTO p_total FROM orders WHERE customerid = p_customerid;
END $$;
CALL customer_total(2);

-- Q3. Drop the procedures.
DROP PROCEDURE IF EXISTS log_customer_orders(INT);
DROP PROCEDURE IF EXISTS customer_total(INT, INT);
