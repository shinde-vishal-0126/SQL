-- ======================================================================
-- Topic 14: SQL Injection & Prepared Statements (Database Security)
-- ======================================================================

-- ------------------------------------------------------------
-- 📖 In Simple Words
-- ------------------------------------------------------------

-- * Definition: SQL injection is an attack where a user types SQL code into an input box and the application glues it into its query, so the attacker changes the query. Prepared statements stop it by sending the input only as data.

-- * Real-life example: Like a form where someone writes "and also give me the keys" in the name field, and the clerk obeys it — a prepared statement means the clerk only reads it as a name.

-- * 🧩 Syntax:
--     PREPARE stmt_name FROM 'SELECT ... WHERE col = ?';
--     SET @var = value;
--     EXECUTE stmt_name USING @var;
--     DEALLOCATE PREPARE stmt_name;

-- * Syntax explained (each part):
--   - ? / $1 → placeholder: the value is sent separately, never mixed into the SQL text
--   - PREPARE → database parses the query once
--   - EXECUTE … USING → runs it with the given values
--   - DEALLOCATE → frees the prepared statement

-- * Example on salesdb (run 00-Setup-Sample-Data.sql first):
USE salesdb;
-- Unsafe: the input  ' OR '1'='1  turned the filter into "always true":
SELECT * FROM customers WHERE firstname = '' OR '1' = '1';
-- Safe:
PREPARE q FROM 'SELECT * FROM customers WHERE firstname = ?';
SET @name = 'Kevin';
EXECUTE q USING @name;
DEALLOCATE PREPARE q;

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

-- (Type → How it works | Example input)
--
-- * Tautology / classic
--     - How it works  : Makes the WHERE condition always true
--     - Example input : ' OR '1'='1
--
-- * Comment-based
--     - How it works  : Cuts off the rest of the query
--     - Example input : admin' --
--
-- * UNION-based
--     - How it works  : Appends another SELECT to read other tables
--     - Example input : ' UNION SELECT username, password FROM users --
--
-- * Error-based
--     - How it works  : Forces database errors that reveal table/column names
--     - Example input : ' AND extractvalue(1, concat(0x7e, database())) --
--
-- * Blind (boolean)
--     - How it works  : No output shown; attacker asks true/false questions and watches the page change
--     - Example input : ' AND SUBSTRING(database(),1,1) = 's' --
--
-- * Blind (time-based)
--     - How it works  : Uses delays to learn data
--     - Example input : ' AND IF(1=1, SLEEP(5), 0) --
--
-- * Second-order
--     - How it works  : Malicious text is stored first and injected later when another query reuses it
--     - Example input : a username like bob'; -- saved, used later in an admin report
--

-- ------------------------------------------------------------
-- 14.3 How to Prevent SQL Injection
-- ------------------------------------------------------------

-- 1. Prepared statements / parameterized queries (main defence): the SQL text and the values are sent separately; values are never parsed as SQL.

-- 2. Validate input with allow-lists: for things that can't be parameters (column names in `ORDER BY`, table names, sort direction) accept only known values.

-- 3. Least privilege: the application user gets only the rights it needs (`SELECT, INSERT, UPDATE` on its own tables) — never `root`, never `FILE`, `DROP` or `GRANT`.

-- 4. Stored procedures with parameters — safe only if they don't build SQL by concatenating the parameters.

-- 5. ORM / query builders (Hibernate, Sequelize, Django ORM) — they parameterize by default; raw SQL inside them still needs parameters.

-- 6. Hide database errors from users (log them on the server) so attackers learn nothing from error messages.

-- 7. Escaping (`mysqli_real_escape_string`) is only a last resort; it is easy to get wrong.

-- ------------------------------------------------------------
-- 14.4 Prepared Statements in MySQL and in Application Code
-- ------------------------------------------------------------

-- * In MySQL itself (server-side prepared statement):
PREPARE stmt FROM 'SELECT * FROM users WHERE username = ? AND password_hash = ?';
SET @u = 'admin', @p = SHA2('secret', 256);
EXECUTE stmt USING @u, @p;
DEALLOCATE PREPARE stmt;

--   * `?` is a placeholder; the values in `USING` are always treated as data, so `admin' -- ` is just a strange username that matches nobody.

-- * Python (mysql-connector):
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

-- * Node.js (mysql2):
-- ┌── (javascript — not SQL, shown for reference) ──
-- │ // ✅ Safe
-- │ const [rows] = await conn.execute(
-- │   "SELECT * FROM users WHERE username = ? AND password_hash = ?",
-- │   [username, passwordHash]
-- │ );
-- └──

-- * Extra benefit: a prepared statement is parsed once and can be executed many times with different values (faster for repeated queries).

-- * Also store passwords hashed (bcrypt/argon2 in the application), never as plain text — the example above compares a hash.

-- >

-- ------------------------------------------------------------
-- 14.5 Safe Dynamic SQL Inside Stored Procedures
-- ------------------------------------------------------------

-- * Sometimes the table or column name must be dynamic (e.g. sort by a column the user picks). Identifiers cannot be `?` parameters, so check them against an allow-list first, and still pass values with `USING`:
DELIMITER //
CREATE PROCEDURE SearchCustomers(IN p_country VARCHAR(50), IN p_sort_col VARCHAR(20))
BEGIN
    -- allow-list for the column name (cannot be a ? parameter)
    IF p_sort_col NOT IN ('first_name', 'score', 'created_at') THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid sort column';
    END IF;

    SET @sql = CONCAT('SELECT customer_id, first_name, score FROM customers ',
                      'WHERE country = ? ORDER BY ', p_sort_col);
    SET @country = p_country;
    PREPARE stmt FROM @sql;
    EXECUTE stmt USING @country;   -- the value is still a parameter
    DEALLOCATE PREPARE stmt;
END //
DELIMITER ;

CALL SearchCustomers('India', 'score');

-- * ❌ Unsafe version (never do): `SET @sql = CONCAT('... WHERE country = ''', p_country, '''');` — this is SQL injection inside the database.

-- * Q1. What is SQL injection? Give an example.

--   * Answer: Injecting SQL through user input that is concatenated into a query — e.g. username `admin' -- ` removes the password check.

-- * Q2. How do prepared statements prevent it?

--   * Answer: The query structure is compiled first with placeholders; values are sent separately and bound as data, so they can never change the SQL.

-- * Q3. Can stored procedures be vulnerable?

--   * Answer: Yes, if they build dynamic SQL with `CONCAT` of parameters. Use `PREPARE ... EXECUTE ... USING` and allow-lists for identifiers.

-- * Q4. Is escaping input enough?

--   * Answer: No — it's error-prone (character sets, numeric contexts, identifiers). Parameters are the correct fix; escaping is a last resort.

-- * Q5. Besides parameters, what else limits the damage?

--   * Answer: Least-privilege DB users, hashed passwords, hiding DB errors, input validation, WAF/monitoring, and regular security testing.

-- ---

-- ======================================================================
-- 🎯 Practice Questions (salesdb sample data) — try first, then look at the answer
-- ======================================================================
-- Run 00-Setup-Sample-Data.sql once before this section.

USE salesdb;

-- Q1. Why is string-building dangerous? This is what an injected input produces — it returns every customer.
SELECT * FROM customers WHERE firstname = '' OR '1' = '1';

-- Q2. Safe version with a prepared statement (input is data, never code).
PREPARE find_customer FROM 'SELECT * FROM customers WHERE firstname = ?';
SET @name = 'Kevin';
EXECUTE find_customer USING @name;
SET @name = ''' OR ''1''=''1';          -- injection attempt is treated as a plain string
EXECUTE find_customer USING @name;     -- returns no rows
DEALLOCATE PREPARE find_customer;

-- Q3. Prepared statement with two parameters: orders of a customer above a sales value.
PREPARE cust_orders FROM 'SELECT orderid, sales FROM orders WHERE customerid = ? AND sales > ?';
SET @cid = 1, @min = 15;
EXECUTE cust_orders USING @cid, @min;
DEALLOCATE PREPARE cust_orders;
