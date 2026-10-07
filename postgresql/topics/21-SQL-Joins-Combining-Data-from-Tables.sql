-- ======================================================================
-- Topic 21: SQL Joins (Combining Data from Tables)
-- ======================================================================

-- ------------------------------------------------------------
-- 📖 In Simple Words
-- ------------------------------------------------------------

-- * Definition: A JOIN combines columns from two or more tables by matching a common column. INNER JOIN keeps only matches; LEFT JOIN keeps all rows from the left table even without a match.

-- * Real-life example: Matching a class list with an exam result list by roll number.

-- * 🧩 Syntax:
--     SELECT a.col, b.col
--     FROM table_a a
--     [INNER | LEFT | RIGHT | FULL | CROSS] JOIN table_b b
--       ON a.key = b.key;

-- * Syntax explained (each part):
--   - INNER JOIN → only matching rows from both tables
--   - LEFT JOIN → all rows of the left table + matches (NULL when no match)
--   - RIGHT / FULL JOIN → all rows of the right table / of both tables
--   - ON → the matching condition (usually key = key)
--   - a, b → table aliases (short names)

-- * Example on salesdb (run 00-Setup-Sample-Data.sql first):
SET search_path TO sales;
SELECT c.firstname, o.orderid
FROM customers c
LEFT JOIN orders o ON o.customerid = c.customerid
ORDER BY c.customerid;

-- * Example explained (step by step):
--   1. Every customer is matched with their orders using customerid.
--   2. LEFT JOIN keeps all customers, even those with no order.
--   3. Anna has no orders, so her orderid shows NULL. With INNER JOIN she would disappear.

-- ------------------------------------------------------------
-- 21.1 What are Joins & Why Do We Need Them?
-- ------------------------------------------------------------

-- * JOINs are used in SQL to combine data (columns) from two or more tables based on a related column between them (usually Primary Key $\leftrightarrow$ Foreign Key). They append columns side-by-side to give a wider table result.

-- * Rows vs Columns (SET Operators vs JOINs):

--   * If you want to combine Rows (putting rows below each other to make the table longer) $\rightarrow$ Use SET Operators (like `UNION`).

--   * If you want to combine Columns (putting columns side-by-side to make the table wider) $\rightarrow$ Use JOINs.

-- * Important Note: JOINs are mostly used with the `SELECT` statement. PostgreSQL also joins other tables in `UPDATE ... FROM` and `DELETE ... USING` (see 11.3 and 11.4).

-- * Why do we need JOINs?

--   1. Recombine Data: Get related data that was split into multiple tables (e.g., Customer Name + Order Details).

--   2. Avoid Duplication: We keep data normalized in separate tables and connect them only when needed using JOINs.

--   3. Query Across Entities: (e.g., `Employees` $\rightarrow$ `Departments` $\rightarrow$ `Salaries`).

--   4. Performance: Small, well-structured tables are faster than one giant denormalized table.

--   5. Data Enrichment: "Getting the extra data" (e.g., joining a Zip Code reference table to enhance Customer data).

--   6. Check for Existence (Filtering): Checking if data exists in another table (Anti Joins).

-- * Best Practice: Always add the Table Name or Alias before the column name (e.g., `customers.id`) to avoid Column Ambiguity (confusion when both tables have a column with the same name).

-- * The 3 Core Scenarios for JOINs:

--   1. Matching data

--   2. All data

--   3. Unmatched data

-- * Visual comparison showing how SET Operators (UNION) make a table LONGER by appending rows, while JOINs make a table WIDER by appending columns.

-- ------------------------------------------------------------
-- 21.2 Types of Joins (Basic to Advanced)
-- ------------------------------------------------------------

-- * A complete mindmap showing all 6 major types of SQL Joins and their logical connections.

-- * 1. Basic Join (No Condition)

--   * English Definition/Properties: Not really a join — just two separate queries that give two separate results.

--   * Q1. Retrieve all data from customers and orders in two different results:
SELECT * FROM customers; 
SELECT * FROM orders;

-- * 2. INNER JOIN (The Default Join)

--   * English Definition/Properties: Returns ONLY the matching rows from both tables. It gives you the "common part" or intersection. If you simply write `JOIN`, it defaults to `INNER JOIN`. The order of tables in the query does not matter.

--   * Q1. Get all customers along with their orders but only for customers who have placed an order:
SELECT c.id, c.first_name, o.order_id
FROM customers AS c
INNER JOIN orders AS o ON c.id = o.customer_id;

--   * Inner Join returns ONLY the matching rows that exist in both tables.

-- * 3. LEFT JOIN (or LEFT OUTER JOIN)

--   * English Definition/Properties: Returns ALL rows from the Left table + only matching rows from the Right table. If there is no match on the right, it returns `NULL` for those columns. The order of tables is highly important.

--   * Q1. Get all customers along with their orders, including those without an order:
SELECT c.id, c.first_name, o.order_id
FROM customers AS c
LEFT JOIN orders AS o ON c.id = o.customer_id;

--   * Left Join returns All Rows from the Primary (Left) table, and Only Matching Data from the Secondary (Right) table. The order of tables is highly important.

--   * Execution flow showing how non-matching right table rows automatically get assigned `NULL` values.

-- * 4. RIGHT JOIN (or RIGHT OUTER JOIN)

--   * English Definition/Properties: Returns ALL rows from the Right table + only matching rows from the Left table. If no match, it returns `NULL` for left table columns.

--   * Q1. Get all customers along with their orders, including orders without matching customers:
SELECT c.id, c.first_name, o.order_id
FROM customers AS c
RIGHT JOIN orders AS o ON c.id = o.customer_id;

--   * Pro-Tip: You can achieve the EXACT same result using `LEFT JOIN` just by swapping the tables (`FROM orders LEFT JOIN customers`).

--   * Right Join returns All Rows from the Secondary (Right) table and only matching rows from the Left table.

--   * Industry Best Practice: You can achieve the exact same results by simply swapping the tables and using a `LEFT JOIN` instead of a `RIGHT JOIN`.

-- * 5. FULL JOIN (or FULL OUTER JOIN)

--   * English Definition/Properties: Returns ALL rows from both the Left and Right tables (everything: matching and unmatching). Unmatched sides get `NULL`. Order of tables does not matter.

--   * Note: 🐘 PostgreSQL supports `FULL JOIN` directly. (MySQL does not — there you simulate it with `LEFT JOIN ... UNION ... RIGHT JOIN`.)

--   * Q1. Get all the customers and all orders even if there is no match:

--   * PostgreSQL Code:
SELECT c.id, c.first_name, o.order_id
FROM customers AS c
FULL JOIN orders AS o ON c.id = o.customer_id;

--   * For comparison, the MySQL workaround (also valid in PostgreSQL, but not needed):
SELECT c.id, o.order_id FROM customers AS c LEFT JOIN orders AS o ON c.id = o.customer_id
UNION
SELECT c.id, o.order_id FROM customers AS c RIGHT JOIN orders AS o ON c.id = o.customer_id;

--   * Full Join returns Everything (All Rows) from both tables. Unmatched rows are padded with `NULL`s. The order of the tables does not matter.

-- ------------------------------------------------------------
-- 21.3 Advanced Joins (Filtering & Special Cases)
-- ------------------------------------------------------------

-- * 1. LEFT ANTI JOIN

--   * Properties: Returns rows from the Left table that have NO match in the Right table. It uses the Right table strictly for filtering (checking for existence).

--   * Q1. Get all customers who have not placed any order:
SELECT c.id, c.first_name, o.order_id
FROM customers AS c
LEFT JOIN orders AS o ON c.id = o.customer_id
WHERE o.customer_id IS NULL; -- The Anti-Join Filter

--   * Left Anti Join returns ONLY the unmatching rows from the primary (Left) table.

--   * The secondary (Right) table is used strictly for filtering data, not for combining. Achieved by adding `WHERE B.key IS NULL`.

-- * 2. RIGHT ANTI JOIN

--   * Properties: The opposite of Left Anti Join. Returns rows from the Right table that have NO match in the Left table.

--   * Q1. Get all records without matching customers:
SELECT c.id, c.first_name, o.order_id
FROM customers AS c
RIGHT JOIN orders AS o ON c.id = o.customer_id
WHERE c.id IS NULL; 

--   * Pro-Tip (Alternative Approach): Just like Right Join, you can achieve a Right Anti Join by simply swapping the tables and using a `LEFT JOIN` (Left Anti Join structure).

--     * Syntax:
SELECT c.id, c.first_name, o.order_id
FROM orders AS o
LEFT JOIN customers AS c ON o.customer_id = c.id
WHERE c.id IS NULL; 

--   * Right Anti Join returns ONLY the unmatching rows from the secondary (Right) table.

--   * The primary (Left) table acts as a filter (Lookup). Achieved by adding `WHERE A.key IS NULL`.

-- * 3. FULL ANTI JOIN

--   * Properties: Returns rows that do NOT match in either table (exclusive data from both sides).

--   * Q1. Find the customers without orders and orders without customers (PostgreSQL — simple with `FULL JOIN`):
SELECT c.id AS customer_id, c.first_name, o.customer_id AS order_customer_id, o.order_id
FROM customers AS c
FULL JOIN orders AS o ON c.id = o.customer_id
WHERE c.id IS NULL OR o.customer_id IS NULL;

--   * Full Anti Join returns ONLY rows that don't match in either tables. Achieved by checking if either `A.key IS NULL` OR `B.key IS NULL`.

-- * 4. SELF JOIN

--   * Properties: When a table is joined with ITSELF. It's used for hierarchical data (like Employees and their Managers) or comparing rows within the same table. You MUST use table aliases to treat it as two separate tables.

--   * Code Example (Employee and their Manager Name):
SELECT e.name AS EmployeeName, m.name AS ManagerName
FROM employees AS e
JOIN employees AS m ON e.manager_id = m.id;

--   * Table Setup (Real-World Hierarchy):
CREATE TABLE employees (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    manager_id INT,
    FOREIGN KEY (manager_id) REFERENCES employees(id)
);
INSERT INTO employees (name, manager_id) VALUES
('Alice', NULL), -- Top-level Boss (No manager)
('Bob', 1),      -- Bob's manager is Alice
('Carol', 1);    -- Carol's manager is Alice

-- * 5. CROSS JOIN (Cartesian Product)

--   * Properties: Combines EVERY row from the Left table with EVERY row from the Right table. There is NO `ON` condition. If Table A has 3 rows and Table B has 4 rows, the result has 12 rows.

--   * Q1. Generate all possible combinations of customers and orders:
SELECT * FROM customers CROSS JOIN orders;

--   * Cross Join returns the Cartesian Product. It combines every row from table A with every row from table B.

--   * If Table A has 2 rows and Table B has 3 rows, the total output will be exactly $2 \times 3 = 6$ Total Rows. No `ON` condition is needed.

--   * ⚠️ Interview Warning (The Cross Join Danger): In PostgreSQL, `JOIN` without `ON` is a syntax error (good!), so you can't do it by accident that way. But the old comma style `FROM customers, orders` with a forgotten `WHERE` is still a cross join. (In MySQL, `INNER JOIN` without `ON` silently works as a `CROSS JOIN`.) With two tables of 1 million rows each, the result has $1,000,000 \times 1,000,000$ (1 trillion) rows — the query can hang the server!

--   * Cross Join returns the Cartesian Product. It combines every row from table A with every row from table B without any `ON` condition.

-- ------------------------------------------------------------
-- 21.3.1 🐘 PostgreSQL Join Extras (New)
-- ------------------------------------------------------------

-- * `USING` and `NATURAL JOIN`: when both tables have a column with the same name.
-- USING: shorter ON, and the column appears only once in SELECT *
SELECT * FROM orders JOIN customers USING (customer_id);

-- NATURAL JOIN: joins on ALL same-named columns (risky — avoid in production)
SELECT * FROM orders NATURAL JOIN customers;

-- * `LATERAL` join: the right side can use columns of the left side (like a "for each row" subquery). Great for "top N per group":
-- Last 2 orders of every customer
SELECT c.first_name, o.order_id, o.order_date
FROM customers AS c
CROSS JOIN LATERAL (
    SELECT order_id, order_date
    FROM orders
    WHERE orders.customer_id = c.id
    ORDER BY order_date DESC
    LIMIT 2
) AS o;

--   * Use `LEFT JOIN LATERAL (...) ON TRUE` to also keep customers with no orders. (MySQL 8.0.14+ also has `LATERAL`.)

-- * Anti join with `NOT EXISTS` (often the clearest and fastest in PostgreSQL — the planner turns it into a "Hash Anti Join"):
SELECT c.id, c.first_name
FROM customers AS c
WHERE NOT EXISTS (SELECT 1 FROM orders AS o WHERE o.customer_id = c.id);

-- ------------------------------------------------------------
-- 21.4 Summary: How to Choose the Right Join?
-- ------------------------------------------------------------

-- 1. Want Matching Data only? $\rightarrow$ `INNER JOIN`

-- 2. Want All Data (Focus on primary table)? $\rightarrow$ `LEFT JOIN`

-- 3. Want Everything from both tables? $\rightarrow$ `FULL OUTER JOIN`

-- 4. Want Unmatched Data from primary table? $\rightarrow$ `LEFT ANTI JOIN`

-- 5. Want Unmatched Data from both tables? $\rightarrow$ `FULL ANTI JOIN`

-- Master decision tree for selecting the correct SQL Join based on whether you want Matching, All, or Unmatching rows.

-- ------------------------------------------------------------
-- 21.5 Multi-Table Joins (Interview Perspective)
-- ------------------------------------------------------------
-- In real-world applications, you often join more than 2 tables. The pattern is sequential: Table A joins to Table B, Table B joins to Table C.

-- * Q1. Using SalesDB, retrieve a list of all orders along with related customers, product, and employee details:
SELECT o.order_id, c.first_name, p.product_name, e.first_name AS Salesperson
FROM orders AS o
LEFT JOIN customers AS c ON o.customer_id = c.id
LEFT JOIN products AS p ON o.product_id = p.id
LEFT JOIN employees AS e ON o.salesperson_id = e.id;

-- * Concept showing one Starting Master Table iteratively joining to multiple secondary tables (B, C, D) using `LEFT JOIN` to keep all primary data.

-- * Example using a real Entity Relationship diagram (SalesDB). You start from `Orders` and join `Products`, `Customers`, and `Employees` to get a complete flat view.

-- ------------------------------------------------------------
-- 21.6 Pro-Tip: Interview Trick (Inner Join without INNER JOIN)
-- ------------------------------------------------------------

-- * Question: How do you get matching data from two tables without using the `INNER JOIN` keyword?

-- * Answer: You can use a `LEFT JOIN` and then filter out the unmatching data using the `WHERE` clause.

-- * Code Example:
SELECT c.id, c.first_name, o.order_id
FROM customers AS c
LEFT JOIN orders AS o ON c.id = o.customer_id
WHERE o.customer_id IS NOT NULL;

-- * Basic Joins:

--   * INNER JOIN ➔ Amit (2 orders), Neha (1 order) = 3 rows.

-- ---

-- ======================================================================
-- 🎯 Practice Questions (salesdb sample data) — try first, then look at the answer
-- ======================================================================
-- Run 00-Setup-Sample-Data.sql once before this section.

SET search_path TO sales;

-- Q1. INNER JOIN: orders with customer names.
SELECT o.orderid, c.firstname, o.sales
FROM orders o
INNER JOIN customers c ON c.customerid = o.customerid;

-- Q2. LEFT JOIN: all customers, even without orders (Anna has none).
SELECT c.firstname, o.orderid
FROM customers c
LEFT JOIN orders o ON o.customerid = c.customerid
ORDER BY c.customerid;

-- Q3. Anti join: products that were never ordered.
SELECT p.product
FROM products p
LEFT JOIN orders o ON o.productid = p.productid
WHERE o.orderid IS NULL;

-- Q4. Multi-table join: order, customer, product and salesperson.
SELECT o.orderid, c.firstname AS customer, p.product, e.firstname AS salesperson
FROM orders o
JOIN customers c ON c.customerid = o.customerid
JOIN products  p ON p.productid  = o.productid
JOIN employees e ON e.employeeid = o.salespersonid;
