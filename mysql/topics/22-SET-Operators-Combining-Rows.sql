-- ======================================================================
-- Topic 22: SET Operators (Combining Rows)
-- ======================================================================

-- ------------------------------------------------------------
-- 📖 In Simple Words
-- ------------------------------------------------------------

-- * Definition: SET operators combine the rows of two SELECT results: UNION (all, no duplicates), UNION ALL (all, with duplicates), INTERSECT (only common), EXCEPT (in first but not in second). Both SELECTs need the same number of columns.

-- * Real-life example: Two guest lists for a party: merged list (UNION), people on both lists (INTERSECT), people only on the first list (EXCEPT).

-- * Example on salesdb (run 00-Setup-Sample-Data.sql first):
USE salesdb;
SELECT firstname, lastname FROM customers
INTERSECT
SELECT firstname, lastname FROM employees;

-- * Example explained (step by step):
--   1. The first SELECT gives all customer names, the second all employee names.
--   2. INTERSECT keeps only names that are in both lists.
--   3. Result: Kevin Brown and Mary (NULL last name) — they are both customers and employees.

-- ------------------------------------------------------------
-- 22.1 What are SET Operators & Why Do We Need Them?
-- ------------------------------------------------------------

-- * English Definition/Properties: In SQL, SET operations are used to combine the results of two or more `SELECT` queries into a single result set. While `JOIN` combines columns side-by-side, SET operators combine rows top-to-bottom.

-- ------------------------------------------------------------
-- 22.2 The 6 Golden Rules of SET Operators
-- ------------------------------------------------------------

-- * English Definition/Properties: To successfully use a SET operator, your queries must strictly follow these rules:

--   1. SQL Clauses: You can use `WHERE`, `JOIN`, `GROUP BY`, and `HAVING` in individual queries. However, `ORDER BY` is allowed only once at the very end of the entire combined query.

--   2. Number of Columns: The number of columns in each `SELECT` query must be exactly the same.

--   3. Compatible Data Types: Columns being combined don’t have to be exactly the same data type, but they must be convertible to a common type (e.g., `INT` with `BIGINT`, or `INT` with `VARCHAR`). You cannot logically mix `INT` with `DATE`.

--   4. Order of Columns: The order of the columns in each query must be the same.

--   5. Column Aliases (Names): The column names in the final result set are determined entirely by the names specified in the first query (the base query).

--   6. Mapping Correct Columns: Even if there is no SQL error, incorrectly mapping "Age" to "Name" will lead to inaccurate results. Always make sure similar information is mapped properly.

-- ------------------------------------------------------------
-- 22.3 Types of SET Operators
-- ------------------------------------------------------------

-- * 1. UNION

--   * English Definition/Properties: Combines the results of both queries but removes duplicate rows from the final output. It is generally slower than `UNION ALL` because it performs extra steps to filter out duplicates. The order of queries does not affect the result.

--   * Q1. Combine the data from employees and customers into one table:
SELECT employeeid, firstname, lastname FROM employees
UNION
SELECT customerid, firstname, lastname FROM customers;

-- * 2. UNION ALL

--   * English Definition/Properties: Returns all rows from both queries, including duplicates. It is faster than `UNION` because it doesn't spend time removing duplicates. Use this if you are confident there are no duplicates or if you want to find duplicates/quality issues.

--   * Q1. Combine the data from employees and customers into one table including duplicates:
SELECT employeeid, firstname, lastname FROM employees
UNION ALL
SELECT customerid, firstname, lastname FROM customers;

-- * 3. EXCEPT (or MINUS in Oracle)

--   * English Definition/Properties: Returns only the distinct rows from the first query that are NOT found in the second query. In this operator, the order of queries affects the final result.

--   * Q1. Find employees who are not customers at the same time:
SELECT employeeid, firstname, lastname FROM employees
EXCEPT
SELECT customerid, firstname, lastname FROM customers;

--   * **Old MySQL Alternative (only needed before MySQL 8.0.31 — MySQL 8.0.31+ supports `EXCEPT` directly, so the query above works on your 9.1):**
SELECT e.employeeid, e.firstname, e.lastname
FROM employees e
LEFT JOIN customers c ON e.employeeid = c.customerid AND e.firstname = c.firstname AND e.lastname = c.lastname
WHERE c.customerid IS NULL;

-- * 4. INTERSECT

--   * English Definition/Properties: Returns ONLY the rows that are common (exist) in both queries. It removes duplicates from the output. It is similar to an `INNER JOIN` but combines data row-wise.

--   * Q1. Find employees who are also customers:
SELECT employeeid, firstname, lastname FROM employees
INTERSECT
SELECT customerid, firstname, lastname FROM customers;

--   * **Old MySQL Alternative (only needed before MySQL 8.0.31 — MySQL 8.0.31+ supports `INTERSECT` directly):**
SELECT e.employeeid, e.firstname, e.lastname
FROM employees e
INNER JOIN customers c ON e.employeeid = c.customerid AND e.firstname = c.firstname AND e.lastname = c.lastname;

-- ------------------------------------------------------------
-- 22.4 Advanced Scenarios & Best Practices
-- ------------------------------------------------------------

-- * English Definition/Properties: 

--   1. Source Flag: Include an additional column in your `SELECT` statements to indicate the source of each row.

--   2. Never use an asterisk (*): Always list the needed columns instead of `*` to prevent mapping errors.

--   3. Multiple Tables: You can chain `UNION`, `INTERSECT`, and `EXCEPT` across 3 or more tables sequentially.

--   4. Use Case (Delta Detection & Data Completeness): Used to compare tables to detect discrepancies between databases or daily data batches.

-- * Q1. Orders are stored in separate tables (orders and orders_archive). Combine all orders into one report without duplication:
SELECT orderid, order_date, 'orders' AS source_table FROM orders
UNION
SELECT orderid, order_date, 'orders_archive' AS destination_table FROM orders_archive
ORDER BY orderid;

--   * ⚠️ Note: The alias `destination_table` in the second query is ignored — the result column is named `source_table`, because column names always come from the first query (Rule 5).

-- * Q1. Using UNION Across Three Tables with Multiple Columns:
SELECT id, name, city FROM customers
UNION
SELECT id, name, city FROM suppliers
UNION
SELECT id, name, city FROM employees;

-- * Q1. Using INTERSECT with Multiple Tables:
SELECT id, name FROM customers
INTERSECT
SELECT id, name FROM suppliers
INTERSECT
SELECT id, name FROM employees;

-- * Q1. Using EXCEPT / MINUS with Multiple Tables:
SELECT id, name FROM customers
EXCEPT
SELECT id, name FROM blacklist
EXCEPT
SELECT id, name FROM inactive_customers;

-- * Q1. Give real-time examples of where you use SET operators in your project:

--   * 1. EXCEPT Use Case - Delta Detection:

--     * Delta detection means identifying the differences or changes (delta) between two batches of data (e.g., Day 1 vs Day 2).

--   * 2. EXCEPT Use Case - Data Completeness Check:

--     * EXCEPT operators can be used to compare tables to detect discrepancies between databases and verify that data migrated correctly (100% in sync).

-- ------------------------------------------------------------
-- 22.5 In-Depth Comparison: JOINs vs SET Operators
-- ------------------------------------------------------------

-- * English Definition/Properties: While both JOINs and SET operators combine data, they do it in completely different ways. JOINs combine columns (horizontal), and SET operators combine rows (vertical).

-- | Feature | JOIN (Horizontal Merging) | SET Operator (Vertical Stacking) |
-- | :--- | :--- | :--- |
-- | Purpose | Combine data from multiple tables based on related columns. | Combine the results of two or more independent `SELECT` queries. |
-- | Combination Type | Horizontal (Column-wise merging). The table becomes wider. | Vertical (Row-wise stacking). The table becomes longer. |
-- | Output Structure | A combined table containing columns from all joined tables. | A single result set with the same number of columns as the input queries. |
-- | Column Requirement | Corresponding columns can be completely different. | Queries MUST return the exact same number of columns with compatible datatypes. |
-- | Duplicates | Duplicates are NOT removed automatically. | Controls duplicates: `UNION`/`INTERSECT`/`EXCEPT` removes them, `UNION ALL` keeps them. |
-- | Conditions Needed | Requires a `JOIN` condition (like the `ON` clause) except for `CROSS JOIN`. | No join condition required. Combines result sets directly. |
-- | Works On | Columns based on relationships (Primary Key / Foreign Key). | Complete rows of result sets (independent queries). |
-- | Types | `INNER`, `LEFT`, `RIGHT`, `FULL`, `CROSS` | `UNION`, `UNION ALL`, `INTERSECT`, `EXCEPT / MINUS` |
-- | Use Case | Retrieve related data (e.g. Customer info with their Orders). | Append rows from similar queries (e.g. Combine Customers and Suppliers lists). |

-- * Why were Set Operators introduced in SQL?

--   * SQL is based on relational algebra and mathematics (Set Theory).

--   * 1. Combine independent query results: Sometimes tables aren't related (e.g. customers and suppliers). SET lets you merge them without needing joins.

--   * 2. Simpler and cleaner syntax: Without them, merging queries requires messy joins and `DISTINCT` logic.

--   * 3. Control over duplicates: Easy, direct control over duplicate filtering.

--   * 4. Performance advantages: Operating on pre-selected results directly is often faster and easier for the database to optimize than complex joins.

-- * What problems do SET operators solve that JOINs cannot easily handle?

--   * Combining unrelated tables:

--     * Join limitation: Joins require a relationship between tables (like `customer_id`). Without a relationship, a join produces a Cartesian product or meaningless results.

--     * Set operator solution: `UNION` or `UNION ALL` can merge results vertically without any matching column.

--   * Finding common or distinct results:

--     * Join limitation: To find common rows (like `INTERSECT`) or differences (`EXCEPT`), you need complex joins, subqueries, or `DISTINCT` clauses.

--     * Set operator solution: `INTERSECT` returns only common rows; `EXCEPT` returns rows in one query but not in another, with simple syntax.

--   * Simpler syntax for multi-query merging:

--     * Join limitation: Without set operators, combining multiple queries often requires nested queries or `DISTINCT` logic, which is messy.

--     * Set operator solution: One command (`UNION`, `INTERSECT`, `EXCEPT`) handles multiple queries cleanly.

--   * Control over duplicates:

--     * Join limitation: Joins often produce duplicate rows automatically, requiring extra work with `DISTINCT`.

--     * Set operator solution: `UNION` removes duplicates automatically, while `UNION ALL` keeps them when needed.

--   * Vertical combination of result sets:

--     * Join limitation: Joins merge horizontally (side by side) and cannot "stack" results easily.

--     * Set operator solution: Set operators stack query results vertically, perfect for combining independent query outputs.

-- * Set operators are ideal for merging independent query results, finding common or distinct rows, and controlling duplicates—tasks that are cumbersome or impossible with regular joins.

-- * Set operators overcome the limitations of joins when:

--   1. Combine the data from tables which are unrelated.

--   2. You want common or exclusive results easily.

--   3. You want a clean, simple syntax to merge multiple queries.

--   4. You want automatic duplicate handling.

--   5. You need vertical stacking of results rather than horizontal merging.

-- ------------------------------------------------------------
-- 22.6 Advanced Interview Insights (Pro-Tips)
-- ------------------------------------------------------------

-- * Q1. Interview Trick: How do SET operators handle NULL values?

--   * English: In SQL, `NULL = NULL` evaluates to `UNKNOWN` or `False`. However, when using `UNION`, the database treats two `NULL` values as equal. Therefore, if both queries return a row containing a `NULL`, `UNION` will consider them duplicates and filter one out.

-- * Q2. Performance Trap: The "UNION" vs "UNION ALL" dilemma

--   * English: Always default to `UNION ALL` in production unless you explicitly need to remove duplicates. Using `UNION` forces the database to perform a massive sorting and deduplication operation across all combined rows, which severely degrades performance on large datasets.

-- * Q3. Real-World Use Case: Unpivoting Data

--   * English: While JOINs are used to pivot data (make it wider), `UNION ALL` is frequently used in data warehousing to Unpivot data (convert columns into rows) before analytical functions are applied.

--   * `UNION` ➔ Amit, Neha, Ravi · `UNION ALL` ➔ Amit, Neha, Neha, Ravi · `EXCEPT` ➔ Amit · `INTERSECT` ➔ Neha.

-- ---

-- ======================================================================
-- 🎯 Practice Questions (salesdb sample data) — try first, then look at the answer
-- ======================================================================
-- Run 00-Setup-Sample-Data.sql once before this section.

USE salesdb;

-- Q1. UNION: all people (customers and employees), no duplicates.
SELECT firstname, lastname FROM customers
UNION
SELECT firstname, lastname FROM employees;

-- Q2. INTERSECT: people who are both customer and employee (MySQL 8.0.31+).
SELECT firstname, lastname FROM customers
INTERSECT
SELECT firstname, lastname FROM employees;

-- Q3. EXCEPT: customers who are not employees (MySQL 8.0.31+).
SELECT firstname, lastname FROM customers
EXCEPT
SELECT firstname, lastname FROM employees;

-- Q4. UNION ALL: current and archived orders together, with the source table.
SELECT 'orders' AS source, orderid, orderdate, sales FROM orders
UNION ALL
SELECT 'archive', orderid, orderdate, sales FROM orders_archive
ORDER BY orderid;
