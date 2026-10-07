-- ======================================================================
-- Topic 25: NULL Functions & Conditional Logic (CASE)
-- ======================================================================

-- ------------------------------------------------------------
-- 📖 In Simple Words
-- ------------------------------------------------------------

-- * Definition: NULL means "no value / unknown". NULL functions (COALESCE, IFNULL, NULLIF) handle missing values, and CASE adds if-then-else logic inside a query.

-- * Real-life example: A blank field on a form — you decide what to show instead ("not given"), and CASE is like grading: above 80 = A, above 60 = B…

-- * 🧩 Syntax:
--     COALESCE(v1, v2, ...)        -- first non-NULL value
--     IFNULL(v, replacement)       -- MySQL: NULL → replacement
--     NULLIF(a, b)                 -- NULL when a = b
--     col IS NULL / IS NOT NULL    -- test for NULL (never use = NULL)
--     CASE WHEN condition1 THEN result1
--          WHEN condition2 THEN result2
--          ELSE default_result
--     END

-- * Syntax explained (each part):
--   - COALESCE → replace NULL with a value
--   - NULLIF → turn a value into NULL (e.g. avoid divide by 0)
--   - CASE … WHEN … THEN … ELSE … END → if / else-if / else; the first TRUE condition wins

-- * Example on salesdb (run 00-Setup-Sample-Data.sql first):
USE salesdb;
SELECT firstname,
       COALESCE(score, 0) AS score,
       CASE WHEN score >= 800 THEN 'High'
            WHEN score >= 400 THEN 'Medium'
            WHEN score IS NULL THEN 'No score'
            ELSE 'Low' END AS level
FROM customers;

-- * Example explained (step by step):
--   1. COALESCE(score, 0) shows 0 when score is NULL (Anna).
--   2. CASE checks the conditions top to bottom and returns the first one that matches.
--   3. Result: Kevin High, Mary Medium, Mark Medium, Jossef Low, Anna No score.

-- ------------------------------------------------------------
-- 25.1 What is NULL?
-- ------------------------------------------------------------

-- * English Definition/Properties: NULL means nothing or unknown. 

--   * NULL is not equal to anything (not even another NULL).

--   * NULL is not zero (0).

--   * NULL is not an empty string (`''`).

--   * NULL is not a blank space (`' '`).

-- ------------------------------------------------------------
-- 25.2 Checking for NULL
-- ------------------------------------------------------------

-- * English: To check if a value is NULL, you must use `IS NULL` or `IS NOT NULL`. Normal operators like `=` do not work with NULL.

--   * MySQL vs SQL Server: In SQL Server, `ISNULL()` replaces NULL with another value: `ISNULL(value, replacement)` (like MySQL's `IFNULL()`). In MySQL, `ISNULL(expr)` only checks for NULL (returns 1 or 0). To filter rows, use `IS NULL`.

-- Anti-Joins Recap (Using IS NULL)

-- * English: You can use `IS NULL` with a `LEFT JOIN` or `RIGHT JOIN` to find unmatching rows between two tables (this is known as an Anti-Join).

-- * Q1. List all details for customers who have not placed any order:
SELECT c.*, o.orderid 
FROM customers c 
LEFT JOIN orders o ON c.customerid = o.customerid 
WHERE o.customerid IS NULL;

-- ------------------------------------------------------------
-- 25.3 Handling & Replacing NULL values
-- ------------------------------------------------------------

-- * 1. IFNULL() (MySQL)

--   * English: Replaces NULL with a specified default value. Works for a single expression.

--   * Syntax: `IFNULL(value, replace_value)`

--   * Q1. Sort customers with null scores appearing last:
SELECT customerId, score, CASE WHEN score IS NULL THEN 1 ELSE 0 END AS flag 
FROM customers 
ORDER BY IFNULL(score, 999999) DESC;

--   * ⚠️ Note: With `DESC`, 999999 is the biggest value, so NULL scores come first, not last. For "NULLs last" with the highest score first, use `ORDER BY score IS NULL, score DESC`.

-- * 2. COALESCE(expr1, expr2, ...)

--   * English: Returns the first non-null value from a list of expressions. If the first value is NULL, it moves to the next (like a fallback system).

--   * Why use COALESCE instead of IFNULL? `IFNULL()` only checks one expression. `COALESCE()` checks multiple fields in order.

--   * Use Cases for COALESCE:

--     1. In Aggregations: Handle NULL before mathematical operations (e.g., `SUM(COALESCE(score, 0))`).

--     2. In Joins: Handle NULLs before joining tables.

--     3. In Sorting: Handle NULLs before sorting data.

--   * Q1. Sort the customers from lowest to highest score with null appearing last:
SELECT customerId, score, CASE WHEN score IS NULL THEN 1 ELSE 0 END AS flag 
FROM customers 
ORDER BY COALESCE(score, 999999) DESC;

--   * ⚠️ Note: The question says lowest to highest, so it should be `ORDER BY COALESCE(score, 999999) ASC`. With `DESC`, NULL rows come first.

--   * Q2. Find the average score of the customers:
SELECT customerid, score, COALESCE(score, 0) AS score_2, AVG(score) OVER() AS avgScore2 
FROM customers;

--   * Q3. Display the full name of customers in a single field by merging their first and last name and add 10 bonus points to each customer's score:
SELECT CONCAT(firstname, ' ', lastname) AS fullname, (COALESCE(score, 0) + 10) AS adjusted_score 
FROM customers;

-- ------------------------------------------------------------
-- 25.4 NULLIF()
-- ------------------------------------------------------------

-- * English Definition/Properties: `NULLIF(expr1, expr2)` compares two expressions. If they are equal, it returns NULL. If they are not equal, it returns the first expression.

-- * Use Case (Avoiding Divide by Zero Error):

--   * Q1. Find the sales price for each order dividing by its quantity:
-- If quantity is 0, NULLIF makes it NULL, preventing a crash.
SELECT orderid, sales, sales / NULLIF(quantity, 0) AS price_per_unit FROM orders;

-- Another example avoiding divide by zero error:
SELECT 100 / NULLIF(column_value, 0) AS result FROM your_table;

-- ------------------------------------------------------------
-- 25.5 Data Policies regarding NULL, Space, and Empty
-- ------------------------------------------------------------

-- * Example showing the difference between NULL, Empty String, and Space:
WITH orders AS (
    SELECT 1 AS id, 'A' AS categories
    UNION
    SELECT 2, NULL
    UNION
    SELECT 3, ''
    UNION
    SELECT 4, ' '
)
SELECT *, LENGTH(categories) AS categoriesLength FROM orders;

-- * English: Data policies are sets of rules that define how data should be handled:

--   1. Use only NULL and empty strings, but avoid blank spaces (use `TRIM()`).

--   2. Use only NULL and avoid empty strings and blank spaces.

--   3. Use a default value like `'unknown'` and avoid NULL, empty strings, and blank spaces entirely.

-- ------------------------------------------------------------
-- 25.6 Conditional Logic: CASE Statement
-- ------------------------------------------------------------

-- * English Definition/Properties: The `CASE` statement is SQL's way of handling "If-Then-Else" logic. It evaluates a list of conditions from top to bottom and returns a value when the first condition is met. Used heavily for data transformation.

-- ------------------------------------------------------------
-- How does it work?
-- ------------------------------------------------------------

-- * English: How does SQL execute the CASE statement behind the scenes? In a CASE statement, SQL stops execution once the first condition is met for the current row. Then it does not check with another condition.

-- ------------------------------------------------------------
-- CASE Statement Rules
-- ------------------------------------------------------------

-- 1. The data type of the result must be matching: The result of each condition must have a compatible data type (e.g., all strings like 'HIGH', 'LOW', 'MEDIUM').

-- 2. Can be used anywhere in the query: A CASE statement can be used in `SELECT`, `WHERE`, `ORDER BY`, `GROUP BY`, etc.

-- ------------------------------------------------------------
-- Quick Form vs Full Form
-- ------------------------------------------------------------

-- * Another way to write case statement:

--   * Full Form (Searched CASE): `CASE WHEN Country = 'Germany' THEN 'DE'` (Allows complex conditions like `>`, `<`, `BETWEEN`).

--   * Quick Form (Simple CASE): `CASE Country WHEN 'Germany' THEN 'DE'` (Evaluates a single column against static values).

-- ------------------------------------------------------------
-- Syntax Breakdown
-- ------------------------------------------------------------

-- * `CASE` $\rightarrow$ Starts the logical block.

-- * `WHEN condition1 THEN result1` $\rightarrow$ Condition to evaluate, and what to return if True.

-- * `ELSE default_result` $\rightarrow$ (Optional) Returned if all WHEN conditions are False.

-- * `END` $\rightarrow$ Ends the CASE block.

-- ------------------------------------------------------------
-- Use Cases of CASE Statement
-- ------------------------------------------------------------

-- Use Case 1: Categorizing Data

-- * English: Group the data into different categories based on certain conditions. Classifying and grouping the data makes it easy to understand and helps in aggregating data based on categories.

-- * Q1. Generate a report showing the total sales for each category (HIGH > 50, MEDIUM 20-50, LOW <= 20) and sort from lowest to highest:
SELECT Category, SUM(SALES) AS totalsales FROM (
    SELECT ORDERID, CUSTOMERID, sales,
    CASE
        WHEN sales > 50 THEN 'HIGH'
        WHEN sales BETWEEN 20 AND 50 THEN 'MEDIUM'
        WHEN sales <= 20 THEN 'LOW'
        ELSE 'NO DATA'
    END AS Category
    FROM orders 
) AS derived_table
GROUP BY Category
ORDER BY totalsales ASC;
--   *(Make sure to always give the name of the derived table. In the above example, we used `derived_table`).*

-- Use Case 2: Data Transformation

-- * English: Main purpose is data transformation - deriving new information (creating new columns based on existing data).

-- Use Case 3: Mapping Values

-- * English: Transform the value from one form to another to make it more readable for analysis.

-- * Q1. Retrieve employee details where gender displays as full text:
SELECT firstname, lastname, gender,
CASE
    WHEN gender = 'f' THEN 'Female'
    WHEN gender = 'm' THEN 'Male'
    ELSE 'NO MATCH'
END AS GENDERTABLE
FROM EMPLOYEES;

-- * Q2. Retrieve customer details with abbreviated country code:
SELECT firstname, lastname, country,
CASE
    WHEN country = 'Germany' THEN 'GE'
    WHEN country = 'USA' THEN 'US'
    ELSE 'NOT MATCH'
END AS abbreviatedName
FROM customers;

-- Use Case 4: Handling NULLs

-- * English: Handling NULL means replacing NULL with a specific value. Sometimes NULLs can lead to inaccurate results which can lead to wrong decision making.

-- * Q1. Find the average score of customers and treat NULL as zero:
SELECT CUSTOMERID, FIRSTNAME, LASTNAME, SCORE, AVG(SCORE) OVER() AS AVG_SCORE,
AVG(CASE
    WHEN SCORE IS NULL THEN 0
    ELSE SCORE
END) OVER() AS AVGSCORE
FROM CUSTOMERS;

-- Use Case 5: Conditional Aggregation

-- * English: Apply aggregation functions only on a subset of data that fulfills certain conditions. (Using a binary indicator 1/0 to summarize how many times the condition is true).

-- * Q1. Count how many times each customer has made an order with sales greater than 30:
SELECT customerid,
SUM(CASE
    WHEN SALES > 30 THEN 1
    ELSE 0
END) AS SALES_FLAG,
COUNT(*) AS TOTALORDERS
FROM orders  
GROUP BY customerid;

-- ------------------------------------------------------------
-- 25.7 IF() Function (MySQL Shorthand)
-- ------------------------------------------------------------

-- * English Definition: In MySQL, the `IF(condition, true_value, false_value)` function is a shorter, inline alternative to simple `CASE` statements.

-- * Q1. Mark students as Pass or Fail based on score:
SELECT 
  studentid, 
  score, 
  IF(score >= 50, 'Pass', 'Fail') AS result 
FROM students;

-- * **Q1. `IFNULL` vs `COALESCE` vs `NULLIF` vs `ISNULL`?**

--   * Answer: `IFNULL(a,b)` → b when a is NULL (2 args, MySQL). `COALESCE(a,b,c…)` → first non-NULL (standard, many args). `NULLIF(a,b)` → NULL when a = b (used to avoid divide-by-zero). In MySQL `ISNULL(x)` only returns 1/0; in SQL Server `ISNULL(a,b)` replaces like IFNULL.

-- * **Q2. Why does `WHERE col = NULL` return nothing?**

--   * Answer: Any comparison with NULL is UNKNOWN (three-valued logic), and WHERE keeps only TRUE rows. Use `IS NULL`.

-- * **Q3. What does `AVG(score)` do with NULLs, and how do you count them as 0?**

--   * Answer: Aggregates ignore NULLs, so AVG divides by non-NULL rows only. Use `AVG(COALESCE(score, 0))`.

-- * Q4. Write a query that shows 'High' / 'Medium' / 'Low' by sales and counts each group (pivot-style).

--   * Answer: `SELECT SUM(CASE WHEN sales > 50 THEN 1 ELSE 0 END) AS high, SUM(CASE WHEN sales BETWEEN 20 AND 50 THEN 1 ELSE 0 END) AS medium, SUM(CASE WHEN sales < 20 THEN 1 ELSE 0 END) AS low FROM orders;`

-- * **Q5. Can CASE be used in `ORDER BY` / `GROUP BY`?**

--   * Answer: Yes. Example — custom sort order: `ORDER BY CASE status WHEN 'Pending' THEN 1 WHEN 'Shipped' THEN 2 ELSE 3 END`.

-- ---

-- ======================================================================
-- 🎯 Practice Questions (salesdb sample data) — try first, then look at the answer
-- ======================================================================
-- Run 00-Setup-Sample-Data.sql once before this section.

USE salesdb;

-- Q1. Replace NULL lastname and NULL score.
SELECT firstname, COALESCE(lastname, 'n/a') AS lastname, COALESCE(score, 0) AS score FROM customers;

-- Q2. Average score with and without treating NULL as 0.
SELECT AVG(score) AS avg_ignore_null, AVG(COALESCE(score, 0)) AS avg_null_as_0 FROM customers;

-- Q3. CASE: label customers by score.
SELECT firstname, score,
       CASE WHEN score >= 800 THEN 'High'
            WHEN score >= 400 THEN 'Medium'
            WHEN score IS NULL THEN 'Unknown'
            ELSE 'Low' END AS category
FROM customers;

-- Q4. NULLIF: avoid divide-by-zero (order 10 has quantity 0).
SELECT orderid, sales, quantity, sales / NULLIF(quantity, 0) AS price_per_unit FROM orders;
