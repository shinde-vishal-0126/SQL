-- 📘 Part 8: Final Revision & Interview Preparation (Topics 52–53)

-- ------------------------------------------------------------
-- 📖 In Simple Words
-- ------------------------------------------------------------

-- * Definition: This topic is a summary of everything: DDL builds tables, DML changes data, DQL reads data, DCL controls access, TCL controls transactions, and indexes / plans make it fast.

-- * Real-life example: The last-page revision notes of a textbook.

-- * Example on salesdb (run 00-Setup-Sample-Data.sql first):
USE salesdb;
SELECT c.country, p.category, SUM(o.sales) AS total_sales
FROM orders o
JOIN customers c ON c.customerid = o.customerid
JOIN products  p ON p.productid  = o.productid
GROUP BY c.country, p.category
ORDER BY total_sales DESC;

-- * Example explained (step by step):
--   1. Three tables are joined (JOIN), grouped (GROUP BY) and summed (SUM), then sorted (ORDER BY).
--   2. It answers: "which country buys how much of each category?".
--   3. One query uses most of the DQL ideas from the notes.

-- ======================================================================

-- ---

-- * English Summary:

--   * HAVING vs WHERE: `WHERE` filters individual rows before grouping, while `HAVING` filters aggregated data after `GROUP BY`.

--   * Order of Execution: The database engine processes SQL in this order: `FROM` $\rightarrow$ `WHERE` $\rightarrow$ `GROUP BY` $\rightarrow$ `HAVING` $\rightarrow$ `SELECT` $\rightarrow$ `ORDER BY` $\rightarrow$ `LIMIT`. *(Full order: `FROM`/`JOIN` → `WHERE` → `GROUP BY` → `HAVING` → `SELECT` (+ window functions) → `DISTINCT` → `ORDER BY` → `LIMIT`.)*

--   * Sorting: `ORDER BY` sorts the final result and must come after `GROUP BY`. It works with or without `WHERE`.

--   * Other Clauses: `DISTINCT` removes duplicates (use carefully to avoid slow queries). `LIMIT` restricts the number of rows output. Static values (like `123` or `'new_customers'`) can be added directly to the `SELECT` statement.

-- ---

-- ======================================================================
-- 🧪 Practice Examples (salesdb sample data)
-- ======================================================================
-- First run 00-Setup-Sample-Data.sql once. Then run these one by one (select a statement → execute).
USE salesdb;

-- One query per big area of the notes, all on salesdb:

-- DDL: create, alter, drop
CREATE TABLE practice_notes (id INT PRIMARY KEY, note VARCHAR(100));
ALTER TABLE practice_notes ADD created_at DATETIME DEFAULT CURRENT_TIMESTAMP;
DROP TABLE practice_notes;

-- DML in a transaction (TCL)
START TRANSACTION;
UPDATE orders SET orderstatus = 'Delivered' WHERE orderid = 10;
SELECT orderid, orderstatus FROM orders WHERE orderid = 10;
ROLLBACK;

-- DQL: filter, sort
SELECT firstname, country, score FROM customers WHERE score > 400 ORDER BY score DESC;

-- JOIN + aggregation
SELECT p.category, SUM(o.sales) AS total_sales
FROM orders o
JOIN products p ON p.productid = o.productid
GROUP BY p.category;

-- Window function: rank customers by score
SELECT firstname, score, RANK() OVER (ORDER BY score DESC) AS score_rank
FROM customers;

-- CTE: employees with their manager
WITH emp AS (SELECT employeeid, firstname, managerid FROM employees)
SELECT e.firstname AS employee, m.firstname AS manager
FROM emp e
LEFT JOIN emp m ON m.employeeid = e.managerid;

-- Performance: read the plan
EXPLAIN SELECT * FROM orders WHERE customerid = 1;

-- ======================================================================
-- 🎯 Practice Questions (salesdb sample data) — try first, then look at the answer
-- ======================================================================
-- Run 00-Setup-Sample-Data.sql once before this section.

USE salesdb;

-- Q1. Top customer by total sales with name and country.
SELECT c.firstname, c.country, SUM(o.sales) AS total_sales
FROM orders o JOIN customers c ON c.customerid = o.customerid
GROUP BY c.customerid, c.firstname, c.country
ORDER BY total_sales DESC
LIMIT 1;

-- Q2. Best salesperson (employee) by sales.
SELECT e.firstname, SUM(o.sales) AS total_sales
FROM orders o JOIN employees e ON e.employeeid = o.salespersonid
GROUP BY e.employeeid, e.firstname
ORDER BY total_sales DESC;

-- Q3. Monthly sales with month-over-month change.
WITH m AS (SELECT DATE_FORMAT(orderdate, '%Y-%m') AS month, SUM(sales) AS total FROM orders GROUP BY month)
SELECT month, total, total - LAG(total) OVER (ORDER BY month) AS change_vs_prev FROM m;
