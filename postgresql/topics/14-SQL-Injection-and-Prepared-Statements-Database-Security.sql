-- ======================================================================
-- Topic 14: SQL Injection & Prepared Statements (Database Security)
-- ======================================================================

-- ------------------------------------------------------------
-- 📖 In Simple Words
-- ------------------------------------------------------------

-- * Definition: SQL injection is an attack where a user types SQL code into an input box and the application glues it into its query, so the attacker changes the query. Prepared statements stop it by sending the input only as data.

-- * Real-life example: Like a form where someone writes "and also give me the keys" in the name field, and the clerk obeys it — a prepared statement means the clerk only reads it as a name.

-- * Example on salesdb (run 00-Setup-Sample-Data.sql first):
SET search_path TO sales;
-- Unsafe: the input  ' OR '1'='1  turned the filter into "always true":
SELECT * FROM customers WHERE firstname = '' OR '1' = '1';
-- Safe:
PREPARE q(text) AS SELECT * FROM customers WHERE firstname = $1;
EXECUTE q('Kevin');
DEALLOCATE q;

-- * Example explained (step by step):
--   1. The first query shows what injection does: '1' = '1' is always true, so all 5 customers leak.
--   2. In the prepared statement, ? / $1 is a placeholder; the value is sent separately and can never become SQL code.
--   3. Result of the safe query: only Kevin.

-- ------------------------------------------------------------
-- 14.1 What is SQL Injection?
-- ------------------------------------------------------------

-- * SQL injection is an attack where user input is joined directly into an SQL string, so the input becomes part of the SQL code and changes what the query does.

-- * Vulnerable login code (string concatenation):
-- ┌── (python — not SQL, shown for reference) ──
-- │ # ❌ NEVER do this
-- │ username = request.form["username"]
-- │ password = request.form["password"]
-- │ sql = "SELECT * FROM users WHERE username = '" + username + "' AND password = '" + password + "'"
-- │ cursor.execute(sql)
-- └──

-- * Attack: the attacker types `admin' -- ` as the username (and anything as the password). The query becomes:
SELECT * FROM users WHERE username = 'admin' -- ' AND password = 'anything'

--   * `--` starts a comment, so the password check disappears and the attacker logs in as admin.

-- * Another classic input: `' OR '1'='1` → `WHERE username = '' OR '1'='1'` is true for every row.

-- * What an attacker can do: log in without a password, read other users' data, dump whole tables with `UNION SELECT`, change or delete data, and sometimes read server files.

-- ------------------------------------------------------------
-- 14.2 Types of SQL Injection
-- ------------------------------------------------------------

-- | Type | How it works | Example input |
-- | :--- | :--- | :--- |
-- | Tautology / classic | Makes the WHERE condition always true | `' OR '1'='1` |
-- | Comment-based | Cuts off the rest of the query | `admin' -- ` |
-- | UNION-based | Appends another SELECT to read other tables | `' UNION SELECT username, password FROM users -- ` |
-- | Error-based | Forces database errors that reveal table/column names | `' AND 1 = CAST(current_database() AS INT) -- ` (error text shows the database name) |
-- | Blind (boolean) | No output shown; attacker asks true/false questions and watches the page change | `' AND SUBSTRING(current_database(),1,1) = 's' -- ` |
-- | Blind (time-based) | Uses delays to learn data | `'; SELECT CASE WHEN 1=1 THEN pg_sleep(5) END -- ` |
-- | Second-order | Malicious text is stored first and injected later when another query reuses it | a username like `bob'; --` saved, used later in an admin report |

-- ------------------------------------------------------------
-- 14.3 How to Prevent SQL Injection
-- ------------------------------------------------------------

-- 1. Prepared statements / parameterized queries (main defence): the SQL text and the values are sent separately; values are never parsed as SQL.

-- 2. Validate input with allow-lists: for things that can't be parameters (column names in `ORDER BY`, table names, sort direction) accept only known values.

-- 3. Least privilege: the application user gets only the rights it needs (`SELECT, INSERT, UPDATE` on its own tables) — never the `postgres` superuser, never table owner, no `pg_read_server_files` / `pg_execute_server_program` (these let SQL read files or run OS commands through `COPY`).

-- 4. Stored procedures with parameters — safe only if they don't build SQL by concatenating the parameters.

-- 5. ORM / query builders (Hibernate, Sequelize, Django ORM) — they parameterize by default; raw SQL inside them still needs parameters.

-- 6. Hide database errors from users (log them on the server) so attackers learn nothing from error messages.

-- 7. Escaping (`quote_literal()` / `quote_ident()` in PostgreSQL, `PQescapeLiteral` in libpq) is only a last resort; it is easy to get wrong.

-- ------------------------------------------------------------
-- 14.4 Prepared Statements in PostgreSQL and in Application Code
-- ------------------------------------------------------------

-- * In PostgreSQL itself (server-side prepared statement):
PREPARE stmt (TEXT, TEXT) AS
    SELECT * FROM users WHERE username = $1 AND password_hash = $2;

EXECUTE stmt ('admin', encode(sha256('secret'::bytea), 'hex'));

DEALLOCATE stmt;

--   * `$1`, `$2` are placeholders (MySQL uses `?`); the values in `EXECUTE` are always treated as data, so `admin' -- ` is just a strange username that matches nobody.

--   * PostgreSQL has no `@user_variables`, so values are passed directly in `EXECUTE (...)`.

-- * Python (psycopg 3 / psycopg2):
-- ┌── (python — not SQL, shown for reference) ──
-- │ # ✅ Safe: values are passed separately
-- │ sql = "SELECT * FROM users WHERE username = %s AND password_hash = %s"
-- │ cursor.execute(sql, (username, password_hash))
-- └──

-- * Java (JDBC):
-- ┌── (java — not SQL, shown for reference) ──
-- │ // ✅ Safe
-- │ PreparedStatement ps = conn.prepareStatement(
-- │     "SELECT * FROM users WHERE username = ? AND password_hash = ?");
-- │ ps.setString(1, username);
-- │ ps.setString(2, passwordHash);
-- │ ResultSet rs = ps.executeQuery();
-- └──

-- * Node.js (node-postgres / `pg`):
-- ┌── (javascript — not SQL, shown for reference) ──
-- │ // ✅ Safe — PostgreSQL drivers use $1, $2 placeholders
-- │ const { rows } = await client.query(
-- │   "SELECT * FROM users WHERE username = $1 AND password_hash = $2",
-- │   [username, passwordHash]
-- │ );
-- └──

-- * Extra benefit: a prepared statement is parsed once and can be executed many times with different values (faster for repeated queries).

-- * Also store passwords hashed (bcrypt/argon2 in the application), never as plain text — the example above compares a hash.

-- >

-- ------------------------------------------------------------
-- 14.5 Safe Dynamic SQL Inside PL/pgSQL Functions
-- ------------------------------------------------------------

-- * Sometimes the table or column name must be dynamic (e.g. sort by a column the user picks). In PL/pgSQL use `format()` with `%I` for identifiers (safely quoted) and `USING` for values:
CREATE OR REPLACE FUNCTION search_customers(p_country TEXT, p_sort_col TEXT)
RETURNS TABLE (customer_id INT, first_name TEXT, score INT)
LANGUAGE plpgsql
AS $$
BEGIN
    -- allow-list for the column name (cannot be a $1 parameter)
    IF p_sort_col NOT IN ('first_name', 'score', 'created_at') THEN
        RAISE EXCEPTION 'Invalid sort column: %', p_sort_col;
    END IF;

    RETURN QUERY EXECUTE format(
        'SELECT customer_id, first_name::TEXT, score FROM customers WHERE country = $1 ORDER BY %I',
        p_sort_col)                 -- %I = identifier, safely quoted
    USING p_country;                -- the value is still a parameter
END;
$$;

SELECT * FROM search_customers('India', 'score');

-- * `format()` placeholders: `%I` = identifier (adds double quotes if needed), `%L` = literal value (adds single quotes and escapes), `%s` = plain text (❌ never for user input).

-- * ❌ Unsafe version (never do): `EXECUTE 'SELECT ... WHERE country = ''' || p_country || '''';` — this is SQL injection inside the database.

-- * Q1. What is SQL injection? Give an example.

--   * Answer: Injecting SQL through user input that is concatenated into a query — e.g. username `admin' -- ` removes the password check.

-- * Q2. How do prepared statements prevent it?

--   * Answer: The query structure is compiled first with placeholders; values are sent separately and bound as data, so they can never change the SQL.

-- * Q3. Can stored procedures be vulnerable?

--   * Answer: Yes, if they build dynamic SQL by joining parameters with `||`. In PL/pgSQL use `EXECUTE ... USING` for values and `format('%I')` + allow-lists for identifiers.

-- * Q4. Is escaping input enough?

--   * Answer: No — it's error-prone (character sets, numeric contexts, identifiers). Parameters are the correct fix; escaping is a last resort.

-- * Q5. Besides parameters, what else limits the damage?

--   * Answer: Least-privilege DB users, hashed passwords, hiding DB errors, input validation, WAF/monitoring, and regular security testing.

-- ---

-- ======================================================================
-- 🎯 Practice Questions (salesdb sample data) — try first, then look at the answer
-- ======================================================================
-- Run 00-Setup-Sample-Data.sql once before this section.

SET search_path TO sales;

-- Q1. Why is string-building dangerous? This is what an injected input produces — it returns every customer.
SELECT * FROM customers WHERE firstname = '' OR '1' = '1';

-- Q2. Safe version with a prepared statement (input is data, never code).
PREPARE find_customer(text) AS SELECT * FROM customers WHERE firstname = $1;
EXECUTE find_customer('Kevin');
EXECUTE find_customer(''' OR ''1''=''1');   -- treated as plain text → no rows
DEALLOCATE find_customer;

-- Q3. Prepared statement with two parameters: orders of a customer above a sales value.
PREPARE cust_orders(int, int) AS SELECT orderid, sales FROM orders WHERE customerid = $1 AND sales > $2;
EXECUTE cust_orders(1, 15);
DEALLOCATE cust_orders;
