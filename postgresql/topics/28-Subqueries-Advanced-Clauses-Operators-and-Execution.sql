-- ======================================================================
-- Topic 28: Subqueries Advanced (Clauses, Operators & Execution)
-- ======================================================================

-- ------------------------------------------------------------
-- 📖 In Simple Words
-- ------------------------------------------------------------

-- * Definition: Advanced subqueries use operators like IN, EXISTS, ANY and ALL. A correlated subquery uses a value from the outer row, so it runs again for each row.

-- * Real-life example: Checking each student against their own class average, not the school average.

-- * Example on salesdb (run 00-Setup-Sample-Data.sql first):
SET search_path TO sales;
SELECT c.firstname
FROM customers c
WHERE NOT EXISTS (SELECT 1 FROM orders o WHERE o.customerid = c.customerid);

-- * Example explained (step by step):
--   1. For each customer, the inner query checks if any order has that customerid (correlated).
--   2. NOT EXISTS keeps customers for whom no order is found.
--   3. Result: Anna — the only customer without orders.

-- * Diagram summary: Notebook page summarizing Subquery use cases like filtering, JOIN preparation, EXISTS, and Correlated row-by-row comparisons

-- ------------------------------------------------------------
-- 28.1 Subqueries by Location (Clauses)
-- ------------------------------------------------------------

-- * Diagram summary: Tree diagram showing subqueries in SELECT, FROM, JOIN, and WHERE. WHERE is split into Comparison and Logical operators

-- A subquery can be placed in different parts of a SQL statement. Depending on where it is placed, its behavior and rules change.

-- ------------------------------------------------------------
-- 1. In the `FROM` Clause (Derived Tables)
-- ------------------------------------------------------------

-- * Diagram summary: Shows Main Query wrapping a Subquery acting as a temporary table

-- * How it works: A subquery in the `FROM` clause acts as a temporary table (also called a Derived Table) that the main query can `SELECT` from.

-- * Rule: It MUST return a table (Multiple Rows/Columns) and MUST have an alias (e.g., `AS temp_table`).

-- * Example 1: Compare with Average:
-- Find products that have a price higher than the average price of all products.
SELECT * FROM (
    SELECT product, price, AVG(price) OVER() AS avg_price 
    FROM PRODUCTS
) AS ProdTemp
WHERE price > avg_price;

-- * Example 2: Ranking (Window Functions):
-- Rank customers based on their total amount of sales
SELECT *, RANK() OVER(ORDER BY total_sales DESC) AS sales_rank
FROM (
    SELECT customerid, SUM(sales) AS total_sales FROM ORDERS GROUP BY customerid
) AS OrderSummary;

-- ------------------------------------------------------------
-- 2. In the `SELECT` Clause
-- ------------------------------------------------------------

-- * Diagram summary: Shows Main Query with a Subquery inside the SELECT statement, requiring a scalar value

-- * How it works: Used to aggregate or calculate a value side-by-side with the main query’s normal columns, allowing for direct comparison.

-- * 👿 RULE (Very Important): ONLY Scalar Subqueries (returning exactly 1 Row and 1 Column) are allowed in the `SELECT` clause!

-- * Example:
-- Show product IDs, names, prices, and the total number of orders in the DB side-by-side
SELECT productid, product, price,
       (SELECT COUNT(*) FROM ORDERS) AS total_orders 
FROM PRODUCTS;

-- ------------------------------------------------------------
-- 3. In the `JOIN` Clause
-- ------------------------------------------------------------

-- * How it works: Used to prepare the data (filtering or aggregating) before joining it with another table.

-- * 👿 RULE: The subquery must be given an Alias and added inside the `JOIN ... ON` condition as a temporary table.

-- * Example:
-- Show all customer details and find the total orders for each customer
SELECT c.customerid, c.firstname, c.lastname, COALESCE(t.total_order, 0) AS total_orders
FROM CUSTOMERS c
LEFT JOIN (
    SELECT customerid, COUNT(orderid) AS total_order FROM ORDERS GROUP BY customerid
) AS t
ON c.customerid = t.customerid;

-- ------------------------------------------------------------
-- 28.2 Subqueries in the `WHERE` Clause (Filtering)
-- ------------------------------------------------------------

-- * Diagram summary: Compares '=' needing scalar subqueries vs 'IN' needing list/row subqueries
-- This is the most common place for a subquery. It uses two groups of operators:

-- ------------------------------------------------------------
-- A. Comparison Operators (`>`, `<`, `>=`, `<=`, `=`, `!=`)
-- ------------------------------------------------------------

-- * Diagram summary: Shows a scalar subquery used with a comparison operator

-- * Used to filter data by comparing a column to a Single Value.

-- * 👿 RULE: The subquery MUST be a Scalar Subquery (Return exactly 1 value).

-- * Example:
SELECT product, price FROM products
WHERE price > (SELECT AVG(price) FROM products);

-- ------------------------------------------------------------
-- B. Logical Operators (`IN`, `ANY`, `ALL`, `EXISTS`)
-- ------------------------------------------------------------

-- * Diagram summary: Flowchart explaining the Yes/No logic of EXISTS

-- * Diagram summary: Shows correlated subquery using Table2 from the Main Query inside the Subquery

-- * Diagram summary: Shows data flowing from Customers table subquery to intermediate array, and then to Main Query and Orders final result

-- * Used to filter data against a List of Values (Row or Table Subquery).

-- 1. **`IN` Operator:** Checks if a value exists anywhere inside the list returned by the subquery.

-- Show orders made by customers in Germany
SELECT * FROM ORDERS 
WHERE customerid IN (SELECT customerID FROM CUSTOMERS WHERE country = 'Germany');

-- Show the details of orders of customers which are NOT in Germany
SELECT * FROM ORDERS 
WHERE customerid NOT IN (SELECT customerID FROM CUSTOMERS WHERE country = 'Germany');

-- 2. **`ANY` Operator:** Checks if the condition is TRUE for at least ONE of the values in the list.

-- Find female employees whose salary is greater than ANY male employee's salary
SELECT salary, firstname, lastname FROM EMPLOYEES 
WHERE gender = 'F' AND salary > ANY (SELECT salary FROM EMPLOYEES WHERE gender = 'M');

-- 3. **`ALL` Operator:** Checks if the condition is TRUE for ALL the values in the list.
-- Find female employees whose salary is greater than ALL male employees (highest earner)
SELECT salary, firstname, lastname FROM EMPLOYEES 
WHERE gender = 'F' AND salary > ALL (SELECT salary FROM EMPLOYEES WHERE gender = 'M');

-- 4. **`EXISTS` Operator:** Checks if the subquery returns any rows at all. It does not compare values; it just checks for existence (TRUE/FALSE).

--    * Behind the scenes: For each row in the main query, it runs the subquery. If the subquery returns a result, the main query row is included in the final output. If the subquery returns nothing, the main row is excluded.
-- Show orders made by customers in Germany using EXISTS
SELECT * FROM ORDERS o 
WHERE EXISTS (
    SELECT 1 FROM CUSTOMERS c WHERE c.country = 'Germany' AND o.customerid = c.customerID
);

-- Show the details of orders made by customers NOT in Germany
SELECT * FROM ORDERS o 
WHERE NOT EXISTS (
    SELECT 1 FROM CUSTOMERS c WHERE c.country = 'Germany' AND o.customerid = c.customerID
);

-- ------------------------------------------------------------
-- 28.3 Correlated vs Non-Correlated Subqueries (Execution Behind the Scenes)
-- ------------------------------------------------------------

-- * Diagram summary: Shows Correlated looping vs Non-Correlated linear execution

-- * Diagram summary: Shows Client sending query, Database Engine fetching Subquery from Disk, caching it, and returning the Final Result

-- ------------------------------------------------------------
-- 1. Non-Correlated Subquery (Independent)
-- ------------------------------------------------------------

-- * Execution: It runs completely independently. It is executed first, stores its intermediate result in memory (cache/temporary table). Then the main query runs ONCE using that cached result.

-- * Cache Cleanup: Once the execution is done and the final result is sent to the client, the database engine cleans up the cache and destroys the subquery's temporary result so it is ready to execute another query.

-- * Performance: Very fast. It executes exactly once.

-- ------------------------------------------------------------
-- 2. Correlated Subquery (Dependent)
-- ------------------------------------------------------------

-- * Execution: The inner query depends on the outer query (it references a column from the outer query). It cannot run independently.

-- * How it works behind the scenes: 

--   1. SQL starts executing the main query.

--   2. SQL processes the main query Row by Row.

--   3. For the first row, the main query passes a value to the subquery. The subquery executes and returns a result to the main query.

--   4. The main query checks the result and decides whether to keep the row.

--   5. The cycle repeats for the second row, third row, etc.

-- * Performance: Very Slow! If the main query has 1 million rows, the subquery will be executed 1 million times! (Iteration).

-- * Example (Correlated):
SELECT *, (
    SELECT COUNT(*) FROM ORDERS o WHERE o.customerid = c.customerid
) AS order_count
FROM CUSTOMERS c;

-- ------------------------------------------------------------
-- 28.4 JOIN vs SUBQUERY (Interview Comparison)
-- ------------------------------------------------------------

-- | Feature | JOIN | SUBQUERY |
-- | :--- | :--- | :--- |
-- | Purpose | Combines data from two or more tables into a single result set. | A query inside another query, used to pass intermediate results. |
-- | Execution | Tables are combined first, then filtering/selection is applied. | Inner query executes first, result is passed to outer query. |
-- | Performance | Usually faster and more efficient for large datasets (uses Indexes and Hash/Loop algorithms). | Sometimes slower (especially Correlated subqueries which run row-by-row). |
-- | Readability | More readable when pulling columns from multiple related tables. | Easier to understand for simple filtering (e.g., finding the `MAX` or `AVG`). |
-- | Load Distribution| Maximizes the calculation burden on the database Engine. | Keeps the responsibility on calculation logic (step-by-step). |
-- | Types | INNER, LEFT, RIGHT, FULL, CROSS, SELF. | Scalar, Row, Table, Correlated, Non-Correlated. |

-- * Interview Tip: Always prefer a `JOIN` over a `Correlated Subquery` for better performance. However, modern SQL Optimizers are smart enough to automatically convert many subqueries into Joins behind the scenes!

-- ------------------------------------------------------------
-- 28.5 Key Points & Summary
-- ------------------------------------------------------------

-- * A subquery is a query inside another query that helps break complex logic into smaller, manageable queries. It makes the code easier to understand and more readable.

-- * A subquery MUST always be enclosed in parentheses `()`.

-- * Subqueries can be used in the `SELECT`, `FROM`, `WHERE`, and `HAVING` clauses.

-- * Subqueries can also use aggregate functions like `SUM()`, `AVG()`, etc.

-- * Return Types: Subqueries can return:

--   1. A Single value (Scalar Subquery)

--   2. A List of values (Row/List Subquery)

--   3. A Table / Result Set (Table Subquery)

-- ---

-- ======================================================================
-- 🎯 Practice Questions (salesdb sample data) — try first, then look at the answer
-- ======================================================================
-- Run 00-Setup-Sample-Data.sql once before this section.

SET search_path TO sales;

-- Q1. Correlated subquery: orders above that customer's own average.
SELECT orderid, customerid, sales
FROM orders o
WHERE sales > (SELECT AVG(sales) FROM orders i WHERE i.customerid = o.customerid);

-- Q2. EXISTS / NOT EXISTS: customers without orders.
SELECT firstname FROM customers c
WHERE NOT EXISTS (SELECT 1 FROM orders o WHERE o.customerid = c.customerid);

-- Q3. ANY / ALL: products more expensive than all Accessories.
SELECT product, price FROM products
WHERE price > ALL (SELECT price FROM products WHERE category = 'Accessories');
