-- ======================================================================
-- Topic 35: Stored Procedures in MySQL (Programmability)
-- ======================================================================

-- ------------------------------------------------------------
-- 📖 In Simple Words
-- ------------------------------------------------------------

-- * Definition: A stored procedure is a named set of SQL statements saved in the database. You run it with CALL and can pass input values (parameters).

-- * Real-life example: A saved recipe: write it once, then just say "make recipe X for 4 people".

-- * 🧩 Syntax:
--     DELIMITER //
--     CREATE PROCEDURE proc_name(IN p1 INT, OUT p2 INT, INOUT p3 INT)
--     BEGIN
--       DECLARE v INT DEFAULT 0;
--       -- SQL statements, IF / LOOP ...
--     END //
--     DELIMITER ;
--     CALL proc_name(10, @out, @inout);
--     DROP PROCEDURE [IF EXISTS] proc_name;

-- * Syntax explained (each part):
--   - IN / OUT / INOUT → input value / value returned / both
--   - DECLARE → local variable inside the procedure
--   - BEGIN … END → the body with the SQL statements
--   - DELIMITER // (MySQL) / $$ (PostgreSQL) → lets the body contain ; without ending the CREATE early
--   - CALL → runs the procedure

-- * Example on salesdb (run 00-Setup-Sample-Data.sql first):
USE salesdb;
DELIMITER //
CREATE PROCEDURE orders_of(IN p_customerid INT)
BEGIN
  SELECT orderid, orderdate, sales FROM orders WHERE customerid = p_customerid;
END //
DELIMITER ;
CALL orders_of(2);
DROP PROCEDURE orders_of;

-- * Example explained (step by step):
--   1. The procedure is saved once with a parameter for the customer id.
--   2. CALL runs it for customer 2 (Kevin).
--   3. Result: Kevin's 3 orders (1, 5, 9). The procedure is then dropped.

-- > In one line: A stored procedure lets us put our SQL code inside the database and add programming features like parameters, variables, `IF`/loops and error handling.

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

--   * The database then executes all the statements inside the procedure in exactly the order you defined (top to bottom), and finally returns the data from the `SELECT`s to the user.

--   * Now you simply tell your colleagues: "just execute this procedure — the database does the rest". This minimizes human errors and makes sure everything runs as you want.

-- * Summary: A stored procedure stores multiple SQL statements, in a specific order, inside the database. Each time you need them, you simply execute the procedure.

-- ------------------------------------------------------------
-- 35.2 Stored Procedure vs Normal Query
-- ------------------------------------------------------------

-- * Stored Procedure:

--   * Contains multiple SQL statements; when you execute it, there are many interactions with the database in one go (it can run multiple transactions).

--   * It is like a program in any programming language — more than one request. It can have:

--     * Looping logic (iterate over something),

--     * Control flow (`IF - ELSE`),

--     * Parameters and variables (to make the code dynamic and flexible),

--     * Error handling (to decide what happens when there is an issue).

--   * So it gives much more reusability and flexibility than a simple query.

-- * Normal Query:

--   * A normal SQL query is a one-time request: you ask the database for one thing and the database answers.

-- ------------------------------------------------------------
-- 35.3 What is a Procedure in SQL? (Definition & What It Can Contain)
-- ------------------------------------------------------------

-- * Creating a stored procedure in MySQL allows you to save a block of SQL statements that can be executed later with a single command — useful for reusability, fewer network round trips and organization.

-- * A Stored Procedure is a named block of SQL statements (code) that you save in the database and execute whenever needed. Think of it as a function in programming, but for the database.

-- * A procedure can include:

--   * SQL queries

--   * DML, DDL, DCL and TCL commands

--   * Temporary tables to hold sets of rows (Oracle PL/SQL calls these "collection types"; MySQL has no collection types, so temporary tables are used instead)

--   * Cursors

--   * Loops and `IF - ELSE` / `CASE` statements

--   * Variables

--   * Exception (error) handling with handlers and `SIGNAL`, etc.

-- * A procedure is not only used to query data from a table; we can use it to build complex logic, data validation, data cleanup and much more. That is why procedures are powerful — they can do much more than plain SQL queries.

-- ------------------------------------------------------------
-- 35.4 Key Points About Procedures
-- ------------------------------------------------------------

-- * Stored & parsed once per connection: The procedure is stored in the database. In MySQL it is parsed the first time a connection calls it and kept in that connection's cache (SQL Server / Oracle go further and cache a compiled execution plan). The biggest speed gain in MySQL comes from sending **one `CALL` instead of many queries**.

-- * Reusable: Instead of writing the same SQL again and again, you call the procedure.

-- * Takes Input & Output: You can pass parameters to procedures and get results back.

-- * Improves Security: Users can be given access to execute a procedure without direct access to the tables.

-- * Encapsulation: Business logic stays in the database instead of being scattered in application code.

-- ------------------------------------------------------------
-- 35.5 What is the Purpose of Using a Procedure?
-- ------------------------------------------------------------

-- * Procedures were introduced to give more power to the SQL language.

-- * Procedures are generally used to do things which are not possible (or not easy) with plain SQL queries.

-- * A procedure may just bundle multiple queries together, or you may build entire software logic inside it — validation checks, data processing, queuing of data and much more.

-- * In short, the purpose is to make database operations faster, reusable, secure and easier to maintain:

--   1. Encapsulation of Business Logic: Put complex SQL logic in one place (inside the DB). Applications just call the procedure instead of writing long queries.

--   2. Reusability: Write the logic once and reuse it across multiple applications/users. Example: `GetEmployeeSalary(dept_id)` can be used by the HR, Payroll and Finance apps.

--   3. Performance Optimization: Fewer network round trips and less parsing — the statements are parsed once per connection and reused on the next calls (SQL Server additionally caches the execution plan).

--   4. Reduced Network Traffic: Instead of sending many SQL statements over the network, just call the procedure. Example: `CALL TransferFunds(101, 102, 5000);`

--   5. Security and Access Control: Users can be granted permission to execute a procedure without direct access to the underlying tables. Example: `GRANT EXECUTE ON PROCEDURE bank.TransferFunds TO 'app_user'@'%';` and the app runs `CALL TransferFunds(...)` instead of getting `UPDATE` on the `accounts` table.

--   6. Maintainability: If business rules change, update the procedure once — no need to modify all applications.

--   7. Atomic Operations (Transactions): Procedures can make sure multiple queries succeed or fail together. Example: debit one account and credit another in the same procedure.

-- * Procedures centralize logic, improve performance, enhance security and simplify maintenance.

-- ------------------------------------------------------------
-- 35.6 Advantages of Procedures & Real-World Example
-- ------------------------------------------------------------

-- * Advantages:

--   * Faster execution (one call, statements already parsed in the session).

--   * Reduces network traffic (send a procedure call instead of long SQL queries).

--   * Better security (grant `EXECUTE` instead of `SELECT` on the table).

--   * Easier maintenance (update one procedure instead of many app queries).

-- * Real-world example (Bank application): A money transfer needs 3 steps:

--   1. Deduct from one account,

--   2. Add to another account,

--   3. Log the transaction.

--   * Instead of writing these 3 SQL queries every time in the app, you create a procedure `TransferFunds` and just call it.

-- ------------------------------------------------------------
-- 35.7 Use Cases of Stored Procedures
-- ------------------------------------------------------------

-- * A stored procedure is a stored block of SQL code that performs a specific task inside the database. You can call it whenever you need, using the `CALL` command.

-- * Use case 1 | Reusing Business Logic

--   * Instead of writing the same SQL code many times in your application, put it in a stored procedure.

--   * Use case: called by many parts of the app to get active users — easy to maintain and update.

--   * Ex.
DELIMITER //
CREATE PROCEDURE GetActiveUsers()
BEGIN
    SELECT * FROM users WHERE status = 'active';
END //
DELIMITER ;

CALL GetActiveUsers();

-- * Use case 2 | Improving Performance

--   * Frequently executed logic runs faster as a procedure: the app sends one short `CALL` instead of many long queries, and the statements are parsed only once per connection (SQL Server also caches the execution plan).

--   * Use case: large enterprise apps with heavy or repetitive database operations.

-- * Use case 3 | Reducing Network Traffic

--   * Instead of sending many SQL statements from your app to MySQL, you send one procedure call.

--   * Use case: update and log an order change in a single round trip.

--   * Ex
DELIMITER //
CREATE PROCEDURE UpdateOrderStatus(IN orderId INT, IN newStatus VARCHAR(20))
BEGIN
    UPDATE orders SET status = newStatus WHERE id = orderId;
    INSERT INTO order_logs (order_id, status, updated_at)
    VALUES (orderId, newStatus, NOW());
END //
DELIMITER ;

CALL UpdateOrderStatus(10, 'Shipped');

-- * Use case 4 | Enhancing Security

--   * You can limit direct table access. Users only need `EXECUTE` privileges on the procedure, not on the underlying tables.

--   * Use case: allow an application to `CALL` procedures but not directly `SELECT`, `INSERT` or `DELETE` from sensitive tables.
GRANT EXECUTE ON PROCEDURE shop.UpdateOrderStatus TO 'app_user'@'%';

-- * Use case 5 | Ensuring Data Integrity / Transactions

--   * Procedures can use transactions to ensure data consistency. If any statement fails, the handler rolls everything back.

--   * Ex
DELIMITER //
CREATE PROCEDURE TransferFunds(IN from_acc INT, IN to_acc INT, IN amount DECIMAL(10,2))
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;   -- undo the debit if the credit fails
        RESIGNAL;   -- send the original error back to the caller
    END;

    START TRANSACTION;

    UPDATE accounts SET balance = balance - amount WHERE id = from_acc;
    UPDATE accounts SET balance = balance + amount WHERE id = to_acc;

    COMMIT;
END //
DELIMITER ;

--   * Use case: banking systems — make sure debit and credit happen together or not at all.

-- * Use case 6 | Automation of Routine Tasks

--   * You can automate recurring database operations.

--   * ex
DELIMITER //
CREATE PROCEDURE ArchiveOldOrders()
BEGIN
    INSERT INTO orders_archive SELECT * FROM orders WHERE order_date < NOW() - INTERVAL 1 YEAR;
    DELETE FROM orders WHERE order_date < NOW() - INTERVAL 1 YEAR;
END //
DELIMITER ;

-- run it automatically every night (the event scheduler must be ON)
CREATE EVENT ev_archive_orders
ON SCHEDULE EVERY 1 DAY
DO CALL ArchiveOldOrders();

--   * Use case: scheduled maintenance or data cleanup.

-- * Use case 7 | Complex Reports or Aggregations

--   * Stored procedures can join multiple tables and compute results.

--   * ex
DELIMITER //
CREATE PROCEDURE SalesReport(IN startDate DATE, IN endDate DATE)
BEGIN
    SELECT category, SUM(amount) AS total_sales
    FROM sales
    WHERE sale_date BETWEEN startDate AND endDate
    GROUP BY category;
END //
DELIMITER ;

CALL SalesReport('2025-01-01', '2025-03-31');

--   * Use case: generate a sales report for a specific date range.

-- ------------------------------------------------------------
-- 35.8 How to Create a Procedure (Syntax)
-- ------------------------------------------------------------

-- * Creating a stored procedure in MySQL allows you to save a block of SQL statements that can be executed later with a single command — useful for reusability and organization.

-- * Syntax of a Stored Procedure in MySQL:
DELIMITER //
CREATE PROCEDURE procedure_name (IN parameter1 datatype, OUT parameter2 datatype, INOUT parameter3 datatype)
BEGIN
    -- SQL statements go here
END //
DELIMITER ;

-- * Then call it (pass one value/variable for every parameter):
CALL procedure_name(value1, @out_var, @inout_var);

-- * Explanation:

--   * `DELIMITER //` – changes the command delimiter from `;` to `//` temporarily, so MySQL doesn't end the procedure early.

--   * `CREATE PROCEDURE` – starts the creation of a stored procedure.

--   * `procedure_name` – the name you give your procedure.

--   * `IN`, `OUT`, `INOUT` – define the parameter types:

--     * `IN` – input only (default).

--     * `OUT` – output only.

--     * `INOUT` – both input and output.

--   * `BEGIN ... END` – block that contains one or more SQL statements.

--   * `DELIMITER ;` – resets the delimiter back to normal after creating the procedure.

-- * Q1. Write a procedure for US customers to find the total number of customers and the average score.
DELIMITER //

CREATE PROCEDURE total_customers()
BEGIN
    SELECT 
        COUNT(*) AS total_count, 
        AVG(score) AS average_score
    FROM customers 
    WHERE country = 'USA';

END //

DELIMITER ;

-- CALL THE PROCEDURE 
CALL total_customers();

-- ------------------------------------------------------------
-- 35.9 Parameters in a Stored Procedure
-- ------------------------------------------------------------

-- * What are parameters in a stored procedure?

--   * Parameters are placeholders used to pass values (information) as input from the caller to the stored procedure.

--   * Parameters allow flexible, reusable and dynamic data processing.

-- * Steps to define a parameter in the procedure declaration:

--   1. Define the parameter mode: `IN`, `OUT` or `INOUT`.

--   2. Then write the name of the parameter, and then its data type.

--   3. Once the parameter is defined, use it anywhere in the stored procedure instead of the static value.

--   4. Pass the parameter value at the time of execution (when we call the procedure).

-- * Rule: Never give a parameter the same name as a column. Inside a procedure MySQL reads such a name as the parameter, so `WHERE country = country` would compare the value with itself (always true) and return every row. Use a prefix like `p_`.

-- * Q1. For German customers find the total number of customers and the average score (create a stored procedure).
DELIMITER //

CREATE PROCEDURE TOTALSALESGERMANY(IN p_country VARCHAR(50))
BEGIN
    SELECT 
        COUNT(*)   AS total_customers,
        AVG(score) AS avg_score
    FROM customers
    WHERE country = p_country;
END //

DELIMITER ;

CALL TOTALSALESGERMANY('GERMANY');

-- * Notes:

--   * Avoid repetition – if you notice repeated code in your project, it is a sign that your code can be improved.

--   * In the example above we want the data of every country with its average score. Instead of executing the query separately for each country, we create one stored procedure and pass the country value as a parameter. This makes the procedure dynamic and flexible and improves reusability.

-- ------------------------------------------------------------
-- 35.10 Default Parameter Values
-- ------------------------------------------------------------

-- * Can we use default parameter values in MySQL?

--   * A default parameter means: if the user doesn't pass a value when calling the procedure, a default value is used automatically.

--   * **MySQL does not support a `DEFAULT` keyword for procedure parameters (in any version), and every parameter must be passed in `CALL`.** (SQL Server and PostgreSQL do allow defaults.)

--   * The MySQL way: pass `NULL` for "use the default" and set the default inside the procedure body with `IF ... IS NULL`.

-- * **Q1. Find customers of a given country with a minimum score; if you pass `NULL`, by default it runs for USA customers with score ≥ 50.**
DELIMITER //

CREATE PROCEDURE GetCustomersByCountry(
    IN p_country VARCHAR(50),
    IN p_min_score INT
)
BEGIN
    -- assign default values manually
    IF p_country IS NULL OR p_country = '' THEN
        SET p_country = 'USA';
    END IF;

    IF p_min_score IS NULL THEN
        SET p_min_score = 50;
    END IF;

    SELECT 
        first_name, 
        last_name, 
        country, 
        score
    FROM customers
    WHERE country = p_country
      AND score >= p_min_score;
END //

DELIMITER ;

-- call procedure with default values
CALL GetCustomersByCountry(NULL, NULL);        -- Uses both defaults ('USA', 50)
CALL GetCustomersByCountry('GERMANY', NULL);   -- Uses ('GERMANY', 50)
CALL GetCustomersByCountry('FRANCE', 70);      -- Uses ('FRANCE', 70)

-- ------------------------------------------------------------
-- 35.11 Multiple Statements in a Stored Procedure
-- ------------------------------------------------------------

-- * What does "multiple statements" mean? A stored procedure can contain more than one SQL statement, for example:

--   * `SELECT`, `INSERT`, `UPDATE`, `DELETE`

--   * Variable assignments

--   * Conditions (`IF`, `CASE`)

--   * Loops (`WHILE`, `REPEAT`, `LOOP`)

--   * Transactions (`START TRANSACTION`, `COMMIT`, `ROLLBACK`)

--   * All enclosed inside `BEGIN ... END`.

-- * Basic syntax:
DELIMITER //

CREATE PROCEDURE procedure_name()
BEGIN
    -- Statement 1
    -- Statement 2
    -- Statement 3
END //

DELIMITER ;

-- * Q1. For a given country (e.g. Germany) find the total number of customers and the average score, and also the total number of orders and total sales (create a stored procedure).
DELIMITER //

CREATE PROCEDURE TOTALSALESGERMANY1(
    IN p_country VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci
)
BEGIN
    -- Customers summary
    SELECT 
        COUNT(*) AS total_customers,
        AVG(score) AS avg_score
    FROM customers
    WHERE country COLLATE utf8mb4_unicode_ci = p_country;

    -- Orders summary
    SELECT 
        COUNT(*) AS total_orders,
        SUM(sales) AS total_sales
    FROM orders o
    JOIN customers c ON c.customerid = o.customerid
    WHERE c.country COLLATE utf8mb4_unicode_ci = p_country;
END //

DELIMITER ;

-- * Call it:
CALL TOTALSALESGERMANY1('GERMANY');

--   * The procedure returns two result sets (one per `SELECT`). The `CHARACTER SET ... COLLATE ...` on the parameter avoids the "Illegal mix of collations" error when the parameter and the column use different collations.

-- * Example: Multiple statements in one procedure
DELIMITER //

CREATE PROCEDURE ManageCustomer(IN p_id INT, IN p_country VARCHAR(50))
BEGIN
    -- Insert a log entry
    INSERT INTO logs(action, log_time) VALUES('Procedure Called', NOW());

    -- Update customer record
    UPDATE customers 
    SET country = p_country 
    WHERE customer_id = p_id;

    -- Display confirmation
    SELECT CONCAT('Customer ', p_id, ' updated to ', p_country) AS message;
END //

DELIMITER ;

-- call
CALL ManageCustomer(101, 'Germany');

-- * Example: Multiple queries + local variables
DELIMITER //

CREATE PROCEDURE GetSalesSummary(IN p_country VARCHAR(50))
BEGIN
    DECLARE v_total_sales DECIMAL(10,2);
    DECLARE v_avg_sales DECIMAL(10,2);

    -- Calculate total and average
    SELECT SUM(amount), AVG(amount)
    INTO v_total_sales, v_avg_sales
    FROM sales
    WHERE country = p_country;

    -- Insert summary into log table
    INSERT INTO sales_summary(country, total, average, created_at)
    VALUES(p_country, v_total_sales, v_avg_sales, NOW());

    -- Return result to user
    SELECT v_total_sales AS Total, v_avg_sales AS Average;
END //

DELIMITER ;

CALL GetSalesSummary('USA');

-- ------------------------------------------------------------
-- 35.12 Variables in MySQL (User-Defined vs Local)
-- ------------------------------------------------------------

-- * What is a variable?

--   * Variables are placeholders used to store a value and use it later in the procedure.

--   * A variable is like a value in memory that we can reuse anywhere inside the procedure.

--   * It is not like a parameter: a parameter passes a value into the procedure (and back to the caller); a variable temporarily stores and manipulates data during execution.

-- * There are two main types of variables in MySQL:

--   1. User-defined variables (start with `@`)

--   2. Local variables (declared inside stored procedures, functions or triggers)

-- * **1. User-Defined Variables (`@variable`)**

--   * Scope: session level (available until you disconnect).

--   * Prefix: always starts with `@`.

--   * No need to declare beforehand; use the `SET` keyword to assign a value.

--   * Ex. A – set and read:
SET @country = 'USA';
SELECT @country;

--   * Ex. B – use in queries:
SET @min_score = 70;
SELECT * FROM customers WHERE score > @min_score;

--   * Ex. C – assign from a query:
SELECT COUNT(*) INTO @total_customers
FROM customers
WHERE country = 'GERMANY';

SELECT @total_customers AS total_customers;

-- * 2. Local Variables (declared inside a procedure)

--   * Scope: only inside the stored procedure.

--   * Must be declared using `DECLARE` inside `BEGIN ... END` (at the top of the block, before other statements).

--   * Used for temporary storage or intermediate results.

--   * Syntax: `DECLARE variable_name datatype [DEFAULT value];`

--   * Example – using local variables (and assigning new values later, inside the same procedure):
DELIMITER //

CREATE PROCEDURE ExampleLocalVars()
BEGIN
    DECLARE total INT DEFAULT 0;
    DECLARE avg_score DECIMAL(5,2);

    SELECT COUNT(*), AVG(score)
    INTO total, avg_score
    FROM customers
    WHERE country = 'USA';

    SELECT total AS total_customers, avg_score AS average_score;

    -- assign value later (only possible inside the procedure)
    SET total = total + 10;
    SELECT COUNT(*) INTO total FROM customers;
    SELECT total AS all_customers;
END //

DELIMITER ;

CALL ExampleLocalVars();

-- * **What is `INTO` in MySQL?**

--   * `INTO` stores query results into variables: "take the value(s) returned by this query and put them into variable(s)".

--   * It is used mostly in stored procedures, functions, and with user-defined variables.

--   * The query must return one row: zero rows leaves the variable unchanged and raises a "No data" (`NOT FOUND`) condition; more than one row raises an error.

-- * Differences between user-defined and local variables:

-- (Feature → User-Defined Variable | Local Variable)
--
-- * Scope
--     - User-Defined Variable : Session (visible across statements)
--     - Local Variable        : Inside the procedure only
--
-- * Declaration
--     - User-Defined Variable : Not required
--     - Local Variable        : Must be declared with DECLARE inside the procedure
--
-- * Syntax
--     - User-Defined Variable : SET @x = 10;
--     - Local Variable        : DECLARE x INT DEFAULT 10;
--
-- * Lifetime
--     - User-Defined Variable : Until the session ends
--     - Local Variable        : Until the procedure ends
--
-- * Use case
--     - User-Defined Variable : Testing, simple queries
--     - Local Variable        : Stored procedures, functions
--

-- * Example with both:
DELIMITER //

CREATE PROCEDURE VariableDemo()
BEGIN
    -- Local variables
    DECLARE local_total INT DEFAULT 0;
    DECLARE local_country VARCHAR(20) DEFAULT 'GERMANY';

    -- User variable
    SET @user_country := 'USA';

    -- Query using local variable
    SELECT COUNT(*) INTO local_total 
    FROM customers 
    WHERE country = local_country;

    -- Display both
    SELECT local_total AS total_local_country, @user_country AS user_country;
END //

DELIMITER ;

CALL VariableDemo();

-- ------------------------------------------------------------
-- 35.13 Control Flow: IF ... ELSEIF ... ELSE
-- ------------------------------------------------------------

-- * In MySQL, the `IF ... THEN ... ELSE` structure is used inside stored programs (procedures, functions, triggers).

-- * Syntax:
IF condition THEN
    statement_list;
ELSEIF condition THEN
    statement_list;
ELSE
    statement_list;
END IF;

--   * You must end it with `END IF;`

--   * It can have multiple `ELSEIF` clauses (optional).

--   * `ELSE` is also optional.

-- * Simple IF - ELSE:
DELIMITER //

CREATE PROCEDURE checkNumber(IN num INT)
BEGIN
    IF num > 0 THEN
        SELECT 'Positive number' AS result;
    ELSEIF num = 0 THEN
        SELECT 'Zero' AS result;
    ELSE
        SELECT 'Negative number' AS result;
    END IF;
END //

DELIMITER ;

CALL checkNumber(-7);   -- Negative number

-- * With a variable (store the answer, then show it once):
DELIMITER //

CREATE PROCEDURE checkNumberVar(IN num INT)
BEGIN
    DECLARE v_result VARCHAR(20);

    IF num > 0 THEN
        SET v_result = 'Positive number';
    ELSEIF num = 0 THEN
        SET v_result = 'Zero';
    ELSE
        SET v_result = 'Negative number';
    END IF;

    SELECT num AS input_number, v_result AS result;
END //

DELIMITER ;

CALL checkNumberVar(0);   -- 0 | Zero

-- * Ex. (Money transfer with a balance check):
DELIMITER //

CREATE PROCEDURE TransferFunds(
    IN from_acc INT,
    IN to_acc INT,
    IN amount DECIMAL(10,2)
)
BEGIN
    DECLARE sender_balance DECIMAL(10,2);

    START TRANSACTION;

    -- Get sender balance and lock the row, so no other transfer can change it meanwhile
    SELECT balance INTO sender_balance
    FROM accounts
    WHERE acc_id = from_acc
    FOR UPDATE;

    IF sender_balance >= amount THEN
        UPDATE accounts SET balance = balance - amount WHERE acc_id = from_acc;
        UPDATE accounts SET balance = balance + amount WHERE acc_id = to_acc;
        COMMIT;
        SELECT 'Transfer Successful' AS message;
    ELSE
        ROLLBACK;
        SELECT 'Insufficient Balance' AS message;
    END IF;
END //

DELIMITER ;

CALL TransferFunds(1, 2, 500);

--   * Interview point: `SELECT ... FOR UPDATE` inside the transaction locks the sender's row. Without it, two transfers running at the same moment could both see enough balance and overdraw the account.

-- * **Example — inside a query (the `IF()` function):**

--   * You can also use the `IF()` function directly in SQL (outside procedures). Syntax: `IF(condition, value_if_true, value_if_false)`
SELECT 
    name,
    IF(score >= 60, 'Pass', 'Fail') AS result
FROM students;

-- * Full example (discount rules):
DELIMITER //

CREATE PROCEDURE customerDiscount(IN total_purchase DECIMAL(10,2))
BEGIN
    DECLARE discount DECIMAL(5,2);

    IF total_purchase >= 1000 THEN
        SET discount = 0.15;  -- 15%
    ELSEIF total_purchase >= 500 THEN
        SET discount = 0.10;  -- 10%
    ELSE
        SET discount = 0.05;  -- 5%
    END IF;

    SELECT CONCAT('Discount rate: ', discount * 100, '%') AS Discount;
END //

DELIMITER ;

CALL customerDiscount(750);   -- Discount rate: 10.00%

-- * Ex. real DB example of an IF - ELSE statement (customers table): check a customer's score and give them a level; handle `NULL` first.
DELIMITER //

CREATE PROCEDURE CustomerLevel(IN p_customer_id INT)
BEGIN
    DECLARE v_score INT;
    DECLARE v_name  VARCHAR(50);

    SELECT first_name, COALESCE(score, 0)   -- treat a NULL score as 0
    INTO v_name, v_score
    FROM customers
    WHERE customerid = p_customer_id;

    IF v_name IS NULL THEN
        SELECT 'Customer not found' AS message;
    ELSEIF v_score >= 750 THEN
        SELECT v_name AS customer, v_score AS score, 'GOLD' AS level;
    ELSEIF v_score >= 400 THEN
        SELECT v_name AS customer, v_score AS score, 'SILVER' AS level;
    ELSE
        SELECT v_name AS customer, v_score AS score, 'BRONZE' AS level;
    END IF;
END //

DELIMITER ;

CALL CustomerLevel(2);   -- e.g. John | 900 | GOLD

-- * Note: Handle `NULL` before aggregation or comparison to ensure accurate results (treat `NULL` as zero with `COALESCE(score, 0)`, as above).

-- ------------------------------------------------------------
-- 35.14 Loops in a Stored Procedure
-- ------------------------------------------------------------

-- * Ex. (WHILE loop):
DELIMITER //

CREATE PROCEDURE InsertNumbers()
BEGIN
    DECLARE i INT DEFAULT 1;

    WHILE i <= 5 DO
        INSERT INTO numbers_table (num) VALUES (i);
        SET i = i + 1;
    END WHILE;
END //

DELIMITER ;

CALL InsertNumbers();

-- * MySQL has 3 loop types: `WHILE ... DO ... END WHILE` (checks the condition first), `REPEAT ... UNTIL ... END REPEAT` (runs at least once), and `label: LOOP ... END LOOP` (exit with `LEAVE label;`, skip to the next round with `ITERATE label;`).

-- ------------------------------------------------------------
-- 35.15 Best-Practice Notes for Procedures
-- ------------------------------------------------------------

-- * Always enclose multi-statement logic in `BEGIN ... END`.

-- * Use `DELIMITER //` (or any symbol) while creating, and reset it back with `DELIMITER ;` at the end.

-- * Use variables (`DECLARE`, `SET`, `SELECT ... INTO`) for intermediate values.

-- * For transactions, wrap with `START TRANSACTION` and `COMMIT` / `ROLLBACK`, and add an `EXIT HANDLER` that rolls back on error.

-- * Use proper error handling logic when needed.

-- * Keep procedures modular and readable.

-- * You must use `DELIMITER //` (or any non-`;` delimiter) so that MySQL doesn't stop at the first `;` inside your procedure.

-- * Best practice: if you have multiple queries in a stored procedure, add a semicolon at the end of each query so it is easy to see where each query ends — this matters a lot in big, complex queries with CTEs, `UNION` and so on.

-- ------------------------------------------------------------
-- 35.16 What is DELIMITER in MySQL?
-- ------------------------------------------------------------

-- * `DELIMITER` just tells MySQL where the procedure definition ends; it is not part of SQL itself (it is a command of the client — the `mysql` command line and MySQL Workbench).

-- * In MySQL, the default statement delimiter is `;` (semicolon).

-- * But inside a stored procedure you often have multiple SQL statements, each ending with `;`. If MySQL sees `;`, it thinks the procedure definition is finished.

-- * To avoid this, we temporarily change the delimiter to something else (commonly `//` or `$$`) while creating the procedure.
DELIMITER //
CREATE PROCEDURE GetAllEmployees()
BEGIN
    SELECT * FROM employees;
    SELECT COUNT(*) FROM employees;
END //
DELIMITER ;

-- * Explanation:

--   * `DELIMITER //` → changes the statement delimiter from `;` to `//`.

--   * Inside the procedure you can safely use `;` for each SQL statement.

--   * `END //` → MySQL now knows the procedure ends at `//`, not at the first `;`.

--   * `DELIMITER ;` → resets it back to normal.

-- * Important notes:

--   * In MySQL we are not able to use `CREATE OR REPLACE PROCEDURE`. To change a procedure, first drop the existing one and then create the new one.

--   * If you declare variables in a procedure, you must declare them inside `BEGIN`.

--   * To print a message when the procedure runs, use `SELECT` with the message, e.g. `SELECT 'product sold';`

--   * Execute the procedure using `CALL procedure_name();`

--   * Every parameter needs a data type.

-- * How to drop a procedure: `DROP PROCEDURE IF EXISTS procedure_name;`

-- * How to see procedures: `SHOW PROCEDURE STATUS WHERE Db = 'mydb';` and `SHOW CREATE PROCEDURE procedure_name;`

-- ------------------------------------------------------------
-- 35.17 Messages in a Procedure (SIGNAL & Variables)
-- ------------------------------------------------------------

-- * **1. Using `SIGNAL` (for custom messages or errors)**

--   * If you want to raise an error with your own message, use `SIGNAL`.
DELIMITER //

CREATE PROCEDURE check_score(IN p_score INT)
BEGIN
    IF p_score < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Score cannot be negative';
    ELSE
        SELECT 'Score is valid' AS Message;
    END IF;
END //

DELIMITER ;

CALL check_score(-5);   -- Error 1644: Score cannot be negative

--   * `SQLSTATE '45000'` means "unhandled user-defined exception"; the `CALL` fails with your message.

-- * 2. Store a message in a variable

--   * Declare a variable and assign a string (message) to it using `SET` or `SELECT ... INTO`.
DELIMITER //

CREATE PROCEDURE store_message_example()
BEGIN
    DECLARE msg VARCHAR(255);
    
    -- Store message into a variable
    SET msg = 'Procedure executed successfully!';
    
    -- Display it (optional)
    SELECT msg AS Message;
END //

DELIMITER ;

-- ------------------------------------------------------------
-- 35.18 Types of Procedures & How to Execute Them
-- ------------------------------------------------------------

-- * A. By parameters

--   1. Without parameters – no input/output, just executes fixed logic. Example: `GetAllEmployees()`
DELIMITER //
CREATE PROCEDURE GetAllEmployees()
BEGIN
    SELECT * FROM employees;
END //
DELIMITER ;
--      And call it: `CALL GetAllEmployees();`

--   2. **With input parameters (`IN`)** – accept values and use them inside. Example: `GetEmployeesByDept(IN dept_id INT)`
DELIMITER //
CREATE PROCEDURE GetEmployeesByDept(IN p_dept_id INT)
BEGIN
    SELECT * 
    FROM employees
    WHERE department_id = p_dept_id;
END //
DELIMITER ;
CALL GetEmployeesByDept(2);

--   3. **With output parameters (`OUT`)** – return computed values. Example: `GetEmployeeCount(IN dept_id INT, OUT emp_count INT)`
DELIMITER //
CREATE PROCEDURE GetEmployeeCount(IN p_dept_id INT, OUT p_emp_count INT)
BEGIN
    SELECT COUNT(*) INTO p_emp_count
    FROM employees
    WHERE department_id = p_dept_id;
END //
DELIMITER ;
CALL GetEmployeeCount(2, @count);
SELECT @count;

--   4. **With input & output parameters (`INOUT`)** – accept a value, modify it and return it. Example: `CalculateBonus(INOUT salary DECIMAL(10,2))`
DELIMITER //
CREATE PROCEDURE CalculateBonus(INOUT p_salary DECIMAL(10,2))
BEGIN
    -- add a 20% bonus to the salary that was passed in
    SET p_salary = p_salary + (p_salary * 0.20);
END //
DELIMITER ;

SET @sal = 40000;
CALL CalculateBonus(@sal);
SELECT @sal;   -- 48000.00

-- * B. By functionality

--   1. Data manipulation procedures – perform `INSERT`, `UPDATE`, `DELETE`. Example: `AddEmployee()`
DELIMITER //
CREATE PROCEDURE AddEmployee(IN emp_name VARCHAR(100), IN emp_salary DECIMAL(10,2))
BEGIN
    INSERT INTO employees(name, salary)
    VALUES(emp_name, emp_salary);
END //
DELIMITER ;
--      Call it: `CALL AddEmployee('Vishal', 55000);`

--   2. Data retrieval procedures – perform complex `SELECT` queries. Example: `GetTopSellingProducts()`

--   3. Utility procedures – perform tasks like logging, auditing or transaction management.

-- * C. By transaction control

--   1. Autonomous procedures – run independently of the calling transaction. This exists in Oracle (`PRAGMA AUTONOMOUS_TRANSACTION`); MySQL has no autonomous procedures — a MySQL procedure always runs in the caller's session.

--   2. Dependent procedures – run inside the caller's session. In MySQL, `START TRANSACTION` inside the procedure first commits any transaction the caller had open, then starts a new one.
DELIMITER //

CREATE PROCEDURE TransferFunds(IN from_acc INT, IN to_acc INT, IN amt DECIMAL(10,2))
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;

    UPDATE accounts SET balance = balance - amt WHERE id = from_acc;
    UPDATE accounts SET balance = balance + amt WHERE id = to_acc;
    COMMIT;
END //
DELIMITER ;
CALL TransferFunds(101, 102, 2000);

-- * In short:

--   * Parameter-based → no parameter, `IN`, `OUT`, `INOUT`.

--   * Purpose-based → retrieval, manipulation, utility.

--   * Transaction-based → autonomous (Oracle only), dependent.

-- * How to execute a procedure: `CALL procedure_name(param1, param2, ...);`

--   * Procedure without parameters → `CALL GetAllEmployees();`

--   * Procedure with an `IN` parameter → `CALL GetEmployeesByDept(2);`

--   * Procedure with an `OUT` parameter → `CALL GetEmployeeCount(2, @emp_count);` then `SELECT @emp_count;`

-- * Important notes:

--   * Always use `CALL`.

--   * If the procedure has an `OUT` parameter, you need a variable like `@var_name`.

--   * Procedures don't return values directly (unlike functions); they return result sets (`SELECT`) and `OUT`/`INOUT` parameters.

-- ------------------------------------------------------------
-- 35.19 Creating Procedures With and Without Parameters (IN, OUT, INOUT)
-- ------------------------------------------------------------

-- * There are three kinds of parameters in MySQL procedures:

--   * `IN` → input (default; pass a value).

--   * `OUT` → output (return a value).

--   * `INOUT` → both input and output.

-- * **With an `IN` parameter:**
DELIMITER //
CREATE PROCEDURE GetEmployeesByDept(IN p_dept_id INT)
BEGIN
    SELECT * FROM employees WHERE department_id = p_dept_id;
END //
DELIMITER ;
--   Call using → `CALL GetEmployeesByDept(2);`

-- * **With an `OUT` parameter:**
DELIMITER //
CREATE PROCEDURE GetEmployeeCount(IN p_dept_id INT, OUT p_emp_count INT)
BEGIN
    SELECT COUNT(*) INTO p_emp_count
    FROM employees
    WHERE department_id = p_dept_id;
END //
DELIMITER ;
--   Call using → `CALL GetEmployeeCount(2, @count);` then `SELECT @count;` (shows the output value)

-- * **With an `INOUT` parameter:**
DELIMITER //
CREATE PROCEDURE IncreaseSalary(INOUT emp_salary DECIMAL(10,2))
BEGIN
    SET emp_salary = emp_salary * 1.10; -- increase by 10%
END //
DELIMITER ;
--   Call using → `SET @salary = 50000;` `CALL IncreaseSalary(@salary);` `SELECT @salary;` — returns 55000.

-- * Summary:

--   * Without param → fixed query, no input.

--   * With `IN` → pass a value.

--   * With `OUT` → get a value back.

--   * With `INOUT` → pass a value and get the updated value back.

-- * Without parameters:
DELIMITER //
CREATE PROCEDURE GetAllEmployees()
BEGIN
    SELECT * FROM employees;
END //
DELIMITER ;
--   Call using → `CALL GetAllEmployees();`

-- * *(The same procedure names are used in 32.18 — run `DROP PROCEDURE IF EXISTS name;` before creating one again.)*

-- ------------------------------------------------------------
-- 35.20 Error Handling in Stored Procedures
-- ------------------------------------------------------------

-- * Error handling is a very important part of writing robust MySQL stored procedures: we need to detect, handle and raise errors.

-- * Why error handling is needed: When something goes wrong inside a stored procedure (bad data, duplicate key, missing table, constraint violation), MySQL raises an error and stops execution. With error handlers you can:

--   * Catch and manage the error (instead of stopping the procedure),

--   * Log it into a table,

--   * Return a custom message.

-- * Basic syntax: `DECLARE handler_action HANDLER FOR condition_value statement;` (declare handlers after the variables, before other statements).

-- * Common handler actions:

--   1. `CONTINUE` → continue execution after handling the error.

--   2. `EXIT` → stop execution (leave the `BEGIN ... END` block) after handling the error.

-- * Common condition types:

--   * `SQLEXCEPTION` → catches all SQL errors.

--   * `SQLWARNING` → catches warnings.

--   * `NOT FOUND` → catches "no data found" (like `SELECT ... INTO` returning nothing, or a cursor reaching the end).

--   * A specific error number, e.g. `FOR 1062` (duplicate key) or `FOR 1146` (table doesn't exist).

-- * In MySQL, `SELECT 1 / 0` does not raise an error — it returns `NULL` with a warning. So the examples below use statements that really fail (a table that does not exist → error 1146).

-- * 1. CONTINUE handler example:
DELIMITER //

CREATE PROCEDURE simple_error_handling()
BEGIN
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        SELECT 'An error occurred, but procedure continued' AS message;
    END;

    -- Example of invalid query (will cause error 1146: table doesn't exist)
    SELECT * FROM table_that_does_not_exist;
    SELECT 'Procedure finished successfully' AS status;
END //

DELIMITER ;

CALL simple_error_handling();   -- shows both messages

-- * 2. EXIT handler example – if you want to stop the procedure after an error:
DELIMITER //

CREATE PROCEDURE exit_error_demo()
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SELECT 'Error occurred — procedure terminated' AS message;
    END;

    SELECT * FROM table_that_does_not_exist;  -- causes error
    SELECT 'This will NOT run' AS next;
END //

DELIMITER ;

CALL exit_error_demo();   -- shows only the error message

-- * 3. Handling "NOT FOUND" (no rows found):
DELIMITER //

CREATE PROCEDURE not_found_demo()
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE customer_name VARCHAR(50);

    DECLARE CONTINUE HANDLER FOR NOT FOUND
        SET done = 1;

    SELECT name INTO customer_name
    FROM customers
    WHERE id = 9999; -- assume doesn’t exist

    IF done = 1 THEN
        SELECT 'Customer not found' AS message;
    ELSE
        SELECT CONCAT('Customer found: ', customer_name) AS message;
    END IF;
END //

DELIMITER ;

-- * 4. Logging errors into a table:
CREATE TABLE error_log (
    id INT AUTO_INCREMENT PRIMARY KEY,
    error_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    error_message VARCHAR(255)
);
--   Now modify your procedure (it saves the real MySQL error text with `GET DIAGNOSTICS`):
DELIMITER //

CREATE PROCEDURE log_error_demo()
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1 @err_msg = MESSAGE_TEXT;
        INSERT INTO error_log (error_message)
        VALUES (CONCAT('Error in log_error_demo: ', @err_msg));
    END;

    -- This will trigger the handler
    SELECT * FROM table_that_does_not_exist;
END //

DELIMITER ;

CALL log_error_demo();
SELECT * FROM error_log;   -- Error in log_error_demo: Table 'mydb.table_that_does_not_exist' doesn't exist

-- * **5. Raising a custom error (`SIGNAL`)** – you can manually raise an error:
DELIMITER //

CREATE PROCEDURE raise_error_demo(IN amount INT)
BEGIN
    IF amount < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Amount cannot be negative';
    ELSE
        SELECT 'Valid amount' AS message;
    END IF;
END //

DELIMITER ;

-- * 6. Full example: handling + raising + logging (the error is logged and still returned to the caller with `RESIGNAL`):
DELIMITER //

CREATE PROCEDURE full_error_demo(IN amount DECIMAL(10,2))
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1 @err_msg = MESSAGE_TEXT;
        INSERT INTO error_log (error_message) VALUES (@err_msg);
        RESIGNAL;   -- pass the same error back to the caller
    END;

    IF amount < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Amount must be positive';
    ELSE
        INSERT INTO sales (amount) VALUES (amount);
        SELECT 'Transaction successful' AS status;
    END IF;
END //

DELIMITER ;

CALL full_error_demo(-10);   -- Error 1644: Amount must be positive (and a row in error_log)

-- * Syntax: `DELIMITER //` ➔ `CREATE PROCEDURE name(IN/OUT/INOUT param type)` ➔ `BEGIN ... END //` ➔ `DELIMITER ;`

-- * Control flow: `IF ... ELSEIF ... ELSE ... END IF;`, loops: `WHILE`, `REPEAT`, `LOOP` (+ `LEAVE`).

-- ---

-- ======================================================================
-- 🎯 Practice Questions (salesdb sample data) — try first, then look at the answer
-- ======================================================================
-- Run 00-Setup-Sample-Data.sql once before this section.

USE salesdb;

-- Q1. Procedure: orders of one customer.
DELIMITER //
CREATE PROCEDURE get_customer_orders(IN p_customerid INT)
BEGIN
  SELECT orderid, orderdate, sales FROM orders WHERE customerid = p_customerid;
END //
DELIMITER ;
CALL get_customer_orders(1);

-- Q2. Procedure with OUT parameter: total sales of a customer.
DELIMITER //
CREATE PROCEDURE customer_total(IN p_customerid INT, OUT p_total INT)
BEGIN
  SELECT COALESCE(SUM(sales), 0) INTO p_total FROM orders WHERE customerid = p_customerid;
END //
DELIMITER ;
CALL customer_total(2, @total);
SELECT @total;

-- Q3. Drop the procedures.
DROP PROCEDURE IF EXISTS get_customer_orders;
DROP PROCEDURE IF EXISTS customer_total;
