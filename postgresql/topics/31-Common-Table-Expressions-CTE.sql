-- ======================================================================
-- Topic 31: Common Table Expressions (CTE)
-- ======================================================================

-- ------------------------------------------------------------
-- 📖 In Simple Words
-- ------------------------------------------------------------

-- * Definition: A CTE gives a name to a query with WITH so you can read complex logic step by step and reuse that step in the same query.

-- * Real-life example: Writing intermediate totals on a whiteboard before the final answer.

-- * 🧩 Syntax:
--     WITH cte1 AS (SELECT ...),
--          cte2 AS (SELECT ... FROM cte1)     -- a CTE can use the one before it
--     SELECT ... FROM cte2 JOIN cte1 ON ...;

-- * Syntax explained (each part):
--   - Standalone CTE → does not depend on another CTE
--   - Nested CTE → uses an earlier CTE
--   - Comma → separates multiple CTEs; only one WITH
--   - Scope → CTEs exist only for the one statement that follows

-- * Example on salesdb (run 00-Setup-Sample-Data.sql first):
SET search_path TO sales;
WITH customer_totals AS (
  SELECT customerid, SUM(sales) AS total_sales
  FROM orders
  GROUP BY customerid
)
SELECT c.firstname, t.total_sales
FROM customer_totals t
JOIN customers c ON c.customerid = t.customerid
ORDER BY t.total_sales DESC;

-- * Example explained (step by step):
--   1. Step 1 (the CTE customer_totals) calculates total sales per customer.
--   2. Step 2 joins those totals to customers to get names.
--   3. Result: Mary 125, Jossef 110, Mark 90, Kevin 55.

-- ------------------------------------------------------------
-- 31.1 What is a CTE? (Definition & Concept)
-- ------------------------------------------------------------

-- * CTE = Common Table Expression.

-- * In Short: It is a temporary, named result set (a "virtual table") that you can reference within a `SELECT`, `INSERT`, `UPDATE`, or `DELETE`.

-- * Purpose: It allows you to create a named, reusable subquery within your SQL statement to simplify and organize complex queries, making them much more readable.

-- * Duration: It exists only during the execution of that specific query. It is not stored permanently in the database like a regular table or view.

-- * Keyword: CTEs are defined using the `WITH` keyword.

-- Key Features of a CTE Table:

-- 1. Short-Lived: This table does not live long. Once the query ends, the temporary CTE table is destroyed.

-- 2. Not Available Later: It is not available after the query execution is done.

-- 3. Cannot Re-Query: You are not able to query it again in a separate new query.

-- ------------------------------------------------------------
-- How CTE Works (Behind the Scenes)
-- ------------------------------------------------------------

-- * Diagram summary: Compares Normal Query accessing DB vs CTE creating a virtual table first, then main query using it

--   ┌ ASCII diagram
--   │  Normal query:  [DB] ─────────────────────────► [Main Query] ► result
--   │  CTE:           [DB] ─► [WITH cte AS (...)] ─► [Main Query uses cte] ► result
--   │                           virtual table
--   └

-- * In a Normal Query: We have a database with multiple tables, and we write a simple query to retrieve data and get a result.

-- * In a CTE: We have a query inside another query. The new inner query is named the "CTE Query", and the outer query is the "Main Query". Here is exactly what happens step-by-step:

--   1. CTE Query Executes First: SQL goes and executes the CTE query first to retrieve information from the database tables.

--   2. Intermediate Virtual Table: The output is made available only to the query, shaped exactly like a table. This output is temporarily stored in high-speed cache memory.

--   3. Main Query Dual Sourcing: The Main Query can now act on this virtual table as if it were a real database table. In fact, the Main Query can pull data from two sources simultaneously:

--      * Source 1: Get data directly from the actual database tables.

--      * Source 2: Get data from the virtual table created by the CTE.

--   4. Final Result: The Main Query retrieves and processes everything (utilizing the high-speed cache memory for the CTE, which is way faster than disk storage), and the final result is presented to the user.

--   5. Destruction: Once everything is done, the CTE table has finished its task and is immediately removed/destroyed.

-- * ⚠️ Correction (how PostgreSQL really does it): "High-speed cache memory" and "Dual Sourcing" are simplified teaching words. In PostgreSQL 12+ a CTE that is referenced once (and has no side effects) is inlined into the main query — no separate table at all. A CTE referenced more than once, a recursive CTE, or one written `AS MATERIALIZED` is computed once into a work table — in memory (`work_mem`) if small, spilled to disk if large. The main query can still read both real tables and the CTE, as shown above.

-- ------------------------------------------------------------
-- 31.2 CTE vs Regular Subquery
-- ------------------------------------------------------------

-- * Diagram summary: Shows Subquery executing Bottom-Up with nesting, while CTE executes Top-Down for better readability

--   ┌ ASCII diagram
--   │  Subquery (read bottom-up)        CTE (read top-down)
--   │  SELECT ...           ③           WITH a AS (...)   ①
--   │   FROM (SELECT ...    ②                b AS (...)   ②
--   │          FROM (...)   ①           SELECT ... FROM b ③
--   └

-- ------------------------------------------------------------
-- Why use CTE instead of Subquery? (Benefits)
-- ------------------------------------------------------------

-- * Diagram summary: Shows Subquery doing redundant JOINs vs CTE doing JOIN once and reusing it

--   ┌ ASCII diagram
--   │  Subquery way:  (JOIN A+B) used in place 1
--   │                 (JOIN A+B) used in place 2   ← same JOIN written twice
--   │  CTE way:       WITH ab AS (JOIN A+B)        ← written once
--   │                 ... ab ... ab ...            ← reused
--   └

-- * Diagram summary: Shows how CTE gives Readability, Modularity, and Reusability

--   ┌ ASCII diagram
--   │               CTE
--   │    ┌───────────┼────────────┐
--   │  Readability  Modularity   Reusability
--   │  named steps  small blocks  use the same CTE many times
--   └

-- * Readability: Subqueries get messy when nested deeply. CTEs break the query into smaller, logical steps (Top-to-Bottom flow).

-- * Reusability & Avoid Redundancy: A Subquery can only be used once. A CTE can be joined and referenced multiple times in the same main query. If you need the same aggregated data in step 2 and step 4, doing it with subqueries repeats the JOINs and work. CTE does it once.

-- * Modularity & Debugging: Breaks huge queries into small, self-contained chunks. You can easily test and debug each CTE part separately.

-- * When to STILL use Subqueries: 

--   1. For very simple one-liners (e.g., `WHERE salary > (SELECT AVG(salary)...`). 

--   2. Correlated Subqueries: If the inner query depends on the outer query dynamically (row-by-row), you must use a Subquery. CTEs cannot be correlated to the main query row-by-row.

-- ------------------------------------------------------------
-- 31.3 Types of CTEs
-- ------------------------------------------------------------

-- * Diagram summary: Tree diagram showing Non-Recursive (Standalone, Nested) and Recursive CTEs

--   ┌ ASCII diagram
--   │                 CTE
--   │         ┌────────┴────────┐
--   │   Non-Recursive        Recursive
--   │    ┌────┴────┐         (calls itself,
--   │  Standalone  Nested      loops)
--   │  (alone)   (uses another CTE)
--   └

-- ------------------------------------------------------------
-- 1. Non-Recursive CTE
-- ------------------------------------------------------------
-- A Non-Recursive CTE is a query that runs independently from the main query, executing only once without any repetition or looping. There are mainly two types under this category: Standalone CTE and Nested CTE.

-- ---
-- ------------------------------------------------------------
-- A. Standalone CTE
-- ------------------------------------------------------------

-- * Diagram summary: Highlights CTE Definition vs CTE Usage

--   ┌ ASCII diagram
--   │  WITH sales_cte AS ( SELECT ... )     ◄── CTE Definition
--   │  SELECT * FROM sales_cte;             ◄── CTE Usage
--   └

-- * Diagram summary: DB -> CTE Query -> Intermediate Result -> Main Query -> Final Result

--   ┌ ASCII diagram
--   │  [DB] ─► [CTE Query] ─► (Intermediate Result) ─► [Main Query] ─► [Final Result]
--   └

-- * Definition: A Standalone CTE is defined and used independently in the query. It runs independently as a self-contained unit and doesn't rely on any other CTE or query.

-- * Explanation: If you have a CTE, it queries the database tables and outputs an intermediate result. This output is then used by the main query. The CTE itself is completely independent from anything else.

-- * Syntax & Example:
-- CTE Definition (Query)
WITH TOTAL_SALES AS (
    SELECT customerID, SUM(SALES) AS TOTAL_SALES FROM ORDERS GROUP BY customerID
)
-- Main Query (Usage)
SELECT c.FIRSTNAME, cte.TOTAL_SALES FROM customers c
LEFT JOIN TOTAL_SALES cte ON cte.customerid = c.customerid;

-- ------------------------------------------------------------
-- B. Multiple Standalone CTEs
-- ------------------------------------------------------------

-- * Diagram summary: Showing WITH CTE1, CTE2 format

--   ┌ ASCII diagram
--   │  WITH cte1 AS ( ... ),
--   │       cte2 AS ( ... )        ← one WITH, CTEs separated by commas
--   │  SELECT ... FROM cte1 JOIN cte2 ...
--   └

-- * Definition: You can define multiple independent CTEs in a single query separated by commas.

-- * Important Rule: If you have multiple CTEs, only the first CTE takes the `WITH` keyword. Subsequent CTEs are just separated by a comma `,`.

-- * Syntax & Example:
-- Q1. Find total sales and last order date per customer
WITH TOTAL_SALES AS (
    SELECT customerID, SUM(SALES) AS TOTALCUSTOMERSSALES 
    FROM ORDERS GROUP BY customerID
), -- Comma separates multiple CTEs (No second WITH)
LAST_ORDERS_DATE AS (
    SELECT customerid, MAX(ORDERDATE) AS LAST_ORDER 
    FROM ORDERS GROUP BY customerid
)
SELECT c.FIRSTNAME, c.LASTNAME, c.customerID, 
       cte.TOTALCUSTOMERSSALES, newcte.LAST_ORDER
FROM customers c
LEFT JOIN TOTAL_SALES cte ON cte.customerid = c.customerid
LEFT JOIN LAST_ORDERS_DATE newcte ON newcte.customerid = c.customerid;
--   (Note: An `ORDER BY` inside a CTE does not guarantee the order of the final result. Always sort in the final main query.)

-- ---
-- ------------------------------------------------------------
-- C. Nested CTE (Dependent)
-- ------------------------------------------------------------

-- * Diagram summary: CTE-Name2 selects from CTE-Name1

--   ┌ ASCII diagram
--   │  WITH cte1 AS ( SELECT ... FROM table ),
--   │       cte2 AS ( SELECT ... FROM cte1 )    ← cte2 uses cte1
--   │  SELECT * FROM cte2;
--   └

-- * Diagram summary: DB -> #1 CTE -> #2 CTE -> Main Query

--   ┌ ASCII diagram
--   │  [DB] ─► [#1 CTE] ─► [#2 CTE] ─► [Main Query] ─► result
--   └

-- * Definition: A Nested CTE is a CTE inside another CTE (or a query that depends on another query). 

-- * Explanation: The main query doesn't just use the result of a CTE directly; instead, another CTE can use the result of a previous CTE. This means the CTEs are dependent. You cannot run the dependent CTE independently; you must run the parent CTE first.

-- * Syntax & Example (Complex Nested Pipeline):
WITH TOTAL_SALES AS (
    -- CTE 1: Base Aggregation
    SELECT customerID, SUM(SALES) AS TOTALCUSTOMERSSALES 
    FROM ORDERS GROUP BY customerID
), 
CUSTOMER_SEGMENTS AS (
    -- CTE 2: Nested! Reads from TOTAL_SALES
    SELECT customerid, TOTALCUSTOMERSSALES,
    CASE 
        WHEN TOTALCUSTOMERSSALES > 100 THEN 'HIGH'
        WHEN TOTALCUSTOMERSSALES > 50 THEN 'MEDIUM'  
        ELSE 'LOW'
    END AS SEGMENT
    FROM TOTAL_SALES
), 
RANK_PER_CUSTOMER AS (
    -- CTE 3: Nested! Reads from TOTAL_SALES
    SELECT customerid, 
           RANK() OVER(ORDER BY TOTALCUSTOMERSSALES DESC) AS RANK_CUSTOMERS
    FROM TOTAL_SALES
)
-- Main Query brings it all together
SELECT c.FIRSTNAME, c.customerID, cs.SEGMENT, r.RANK_CUSTOMERS
FROM customers c
LEFT JOIN CUSTOMER_SEGMENTS cs ON cs.customerid = c.customerid
LEFT JOIN RANK_PER_CUSTOMER r ON r.customerid = c.customerid;
-- ---

-- ------------------------------------------------------------
-- 2. Recursive CTE (Looping)
-- ------------------------------------------------------------

-- * Diagram summary: Detailed syntax showing Anchor Query, UNION ALL, Recursive Query, and Break Condition

--   ┌ ASCII diagram
--   │  WITH RECURSIVE cte AS (
--   │      SELECT ...                     ← Anchor query (start, runs once)
--   │      UNION ALL
--   │      SELECT ... FROM cte            ← Recursive query (repeats)
--   │      WHERE <break condition>        ← stops the loop
--   │  )
--   │  SELECT * FROM cte;
--   └

-- * Diagram summary: Anchor Query flowing directly into a looping Recursive Query block

--   ┌ ASCII diagram
--   │  [Anchor Query] ─► rows ─► [Recursive Query] ─┐
--   │                               ▲               │ new rows?
--   │                               └────── yes ────┘
--   │                                      no ─► stop, return all rows
--   └

-- * Definition: A Recursive CTE is a query that repeatedly runs or loops over itself until a given condition is met.

-- * Explanation: It is widely used to navigate through hierarchical data (like Manager-Employee relations, Category trees, Graph nodes) or to generate a sequential series of numbers/dates.

-- Execution Flow (How it loops):

-- 1. Anchor Query (Start): The base query. It runs only once and provides the initial starting dataset.

-- 2. UNION ALL: Connects the Anchor to the Recursive Query. It combines the results of the two without deduplicating (which keeps performance high).

-- 3. Recursive Query (Loop): The query that refers back to the CTE itself. It keeps looping and generating new rows.

-- 4. Termination (End): The loop breaks when the Recursive Query produces an empty result set (0 rows). The final result is then passed to the Main Query.

-- ---
-- ------------------------------------------------------------
-- Example 1: Number Sequence Generation (1 to 20)
-- ------------------------------------------------------------

-- * Diagram summary: Flowchart showing the exact looping mechanism of creating numbers from 1 to 20

--   ┌ ASCII diagram
--   │  anchor: n = 1
--   │     │
--   │     ▼
--   │  n < 20 ? ── yes ──► n = n + 1 ──┐
--   │     │  ▲                         │
--   │     │  └─────────────────────────┘
--   │     no
--   │     ▼
--   │  result: 1, 2, 3, ... 20
--   └

WITH RECURSIVE SERIES AS (
    -- Anchor Query
    SELECT 1 AS MyNumber
    UNION ALL
    -- Recursive Query (Loops)
    SELECT MyNumber + 1 FROM SERIES WHERE MyNumber < 20
)
-- Main Query
SELECT * FROM SERIES; 
-- (Note: PostgreSQL has NO built-in recursion limit (MySQL stops at `cte_max_recursion_depth` = 1000, SQL Server at `MAXRECURSION` = 100). Always write a stop condition (e.g., `WHERE n < 20`), and you can protect yourself with `SET statement_timeout = '5s';`. PostgreSQL 14+ also has `CYCLE id SET is_cycle USING path` to stop loops in graph data.)

-- ---
-- ------------------------------------------------------------
-- Example 2: Employee Hierarchy Navigation
-- ------------------------------------------------------------

-- * Diagram summary: Flowchart matching the Employee-Manager table logic, generating a Top-Down Hierarchy tree: Frank -> Kevin -> Michael

--   ┌ ASCII diagram
--   │  level 1   Frank (no manager)          ← anchor
--   │              │
--   │  level 2   Kevin, Mary                 ← managerid = Frank
--   │              │
--   │  level 3   Michael (→Kevin), Carol (→Mary)
--   │  stop: no more employees found
--   └

WITH RECURSIVE CTE_Emp_Hierarchy AS (
    -- 1. Anchor Query (Find Top-Level Managers / CEO)
    SELECT EmployeeID, FirstName, ManagerID, 1 AS Level
    FROM Sales.Employees 
    WHERE ManagerID IS NULL
    
    UNION ALL
    
    -- 2. Recursive Query (Find subordinates of the managers found above)
    SELECT e.EmployeeID, e.FirstName, e.ManagerID, ceh.Level + 1
    FROM Sales.Employees AS e
    INNER JOIN CTE_Emp_Hierarchy ceh ON e.ManagerID = ceh.EmployeeID
)
-- 3. Main Query (View entire org chart)
SELECT * FROM CTE_Emp_Hierarchy;

-- ---
-- ------------------------------------------------------------
-- Recursive CTE Q&A (Interview Perspectives)
-- ------------------------------------------------------------

-- * What is the purpose of the Anchor Member?

--   1. Initialization: It defines the base result set ("Where do I start?") from which recursion starts.

--   2. Guarantees Termination: Without the anchor, the query wouldn't know where to begin and would either fail or run infinitely.

-- * Analogy: Think of recursion like climbing a ladder. The Anchor member is planting your feet on the first rung. The Recursive member is climbing up one step at a time.

-- * Why use UNION ALL instead of UNION?

--   * `UNION ALL` simply appends rows. It is much faster because no duplicate check is required.

--   * `UNION` performs a deduplication (`DISTINCT`) at every step, which requires extra work and is slower. It may also accidentally filter out valid paths (e.g., matrix management where a person reports to two managers).

-- * Can a Recursive CTE call itself more than once?

--   * Not in PostgreSQL. The recursive part may reference the CTE only once; a second reference gives `ERROR: recursive reference to query must not appear more than once`. For graph walks in two directions, put both directions in one recursive part (e.g., join to an edges table that holds both directions), or use `UNION ALL` with a single self-reference.

-- * Can we write a Recursive CTE without an Anchor Member?

--   * No. It will throw a syntax error or loop infinitely because there is no starting dataset.

-- ------------------------------------------------------------
-- 31.4 CTE vs Derived Table
-- ------------------------------------------------------------

-- (Feature → Derived Table (Subquery in FROM) | CTE (WITH Clause))
--
-- * Definition
--     - Derived Table (Subquery in FROM) : A subquery written directly inside the FROM clause.
--     - CTE (WITH Clause)                : Declared at the top using WITH. Acts like a temporary view.
--
-- * Reusability
--     - Derived Table (Subquery in FROM) : Cannot be reused. If you need it again, you must rewrite it.
--     - CTE (WITH Clause)                : Can be referenced multiple times in the main query.
--
-- * Recursion
--     - Derived Table (Subquery in FROM) : Does not support recursion.
--     - CTE (WITH Clause)                : Supports Recursive querying (Hierarchies).
--
-- * Readability
--     - Derived Table (Subquery in FROM) : Becomes very messy if nested deeply.
--     - CTE (WITH Clause)                : Clean, Top-to-Bottom logical flow.
--

-- ------------------------------------------------------------
-- 31.5 CTE Summary & Best Practices
-- ------------------------------------------------------------

-- * Diagram summary: Complete summary of CTEs, including Advantages, Rules, and Flow diagrams for Standalone, Nested, and Recursive CTEs

--   ┌ ASCII diagram
--   │  CTE = named temporary result (WITH ... AS)
--   │  Advantages: readable │ modular │ reusable in the same query
--   │  Rules     : one WITH, commas between CTEs, no ORDER BY inside (normally)
--   │  Flows     : Standalone  DB ─► CTE ─► Main
--   │              Nested      DB ─► CTE1 ─► CTE2 ─► Main
--   │              Recursive   Anchor ─► Recursive ↺ ─► Main
--   └

-- What is a CTE?

-- * Common Table Expression (CTE) is a Temporary, named result set that can be used multiple times within the query.

-- * Important Rule: The result of a CTE is like a Table, but it can't be used from multiple queries (it only exists for the duration of the query it is defined in).

-- Advantages of using CTEs:

-- 1. Readability: Breaks down Complex Queries into smaller Pieces.

-- 2. Modularity: Pieces are easy to manage, develop, and self-contained.

-- 3. Reusability: Reduce redundancy in Query by reusing the same CTE.

-- 4. Recursive: Enables iterations & looping in SQL for hierarchical data.

-- > [!TIP]
-- > Don't create more than 5 CTEs in One Query. Doing so will make the query extremely difficult to maintain and could impact performance.

--   * Behind the Scenes (Execution): 

--   * Recursive Rules & Interview Tricks: 

-- ---

-- ======================================================================
-- 🎯 Practice Questions (salesdb sample data) — try first, then look at the answer
-- ======================================================================
-- Run 00-Setup-Sample-Data.sql once before this section.

SET search_path TO sales;

-- Q1. Standalone CTE: orders per status.
WITH status_count AS (SELECT orderstatus, COUNT(*) AS total FROM orders GROUP BY orderstatus)
SELECT * FROM status_count;

-- Q2. Nested CTE: one CTE uses another — rank customers by total sales.
WITH totals AS (SELECT customerid, SUM(sales) AS total_sales FROM orders GROUP BY customerid),
     ranked AS (SELECT customerid, total_sales, RANK() OVER (ORDER BY total_sales DESC) AS rnk FROM totals)
SELECT c.firstname, r.total_sales, r.rnk
FROM ranked r JOIN customers c ON c.customerid = r.customerid;

-- Q3. Recursive CTE: generate numbers 1 to 12 (months).
WITH RECURSIVE months AS (
  SELECT 1 AS m
  UNION ALL
  SELECT m + 1 FROM months WHERE m < 12
)
SELECT m FROM months;
