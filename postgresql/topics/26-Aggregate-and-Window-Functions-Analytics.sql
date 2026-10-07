-- ======================================================================
-- Topic 26: Aggregate & Window Functions (Analytics)
-- ======================================================================

-- ------------------------------------------------------------
-- 📖 In Simple Words
-- ------------------------------------------------------------

-- * Definition: Aggregate functions (SUM, COUNT, AVG, MIN, MAX) turn many rows into one value. Window functions do the same calculation but keep every row, adding the result next to it.

-- * Real-life example: Aggregate = the class average on one line. Window = each student's mark with the class average written next to it.

-- * Example on salesdb (run 00-Setup-Sample-Data.sql first):
SET search_path TO sales;
SELECT orderid, customerid, sales,
       SUM(sales) OVER (PARTITION BY customerid) AS customer_total,
       RANK() OVER (ORDER BY sales DESC) AS sales_rank
FROM orders;

-- * Example explained (step by step):
--   1. SUM(...) OVER (PARTITION BY customerid) adds the sales of each customer but still shows every order.
--   2. Customer 1 has orders 20 + 60 + 30, so all three rows show 110.
--   3. RANK() OVER (ORDER BY sales DESC) numbers orders from biggest sale (order 8 = 90 → rank 1).

-- ------------------------------------------------------------
-- 26.1 Aggregation Functions in SQL
-- ------------------------------------------------------------

-- * English Definition/Properties: Aggregation functions accept multiple rows as input and perform calculations on a set of values to return a single summarized value as output. They are often used with the `GROUP BY` clause.

-- * 1. COUNT()

--   * `COUNT(*)`: Counts all rows inside the table (including NULLs).

--   * `COUNT(column)`: Counts only non-NULL values in the specified column.

--   * Q1. Find the total number of orders: `SELECT COUNT(*) FROM orders;`

-- * 2. SUM()

--   * Definition: Adds up all numeric values in a column.

--   * Q1. Find the total sales of all orders: `SELECT SUM(sales) AS totalSales FROM orders;`

-- * 3. AVG()

--   * Definition: Returns the mathematical average of numeric values.

--   * Q1. Find the average sales of all orders: `SELECT AVG(sales) AS avgSales FROM orders;`

-- * 4. MIN() & MAX()

--   * Definition: `MIN()` starts searching and returns the lowest value. `MAX()` searches and returns the highest value in the column.

--   * Q1. Find the lowest and highest sales: 
--     `SELECT MIN(sales) AS minSales, MAX(sales) AS maxSales FROM orders;`

-- * 5. STRING_AGG() / ARRAY_AGG() (PostgreSQL — instead of MySQL GROUP_CONCAT)

--   * Definition: Concatenates (joins) values from a group into a single string. The separator is required.

--   * Example: `SELECT department, STRING_AGG(name, ',' ORDER BY name) AS employee_names FROM employees GROUP BY department;`

--   * `ARRAY_AGG(name)` returns a PostgreSQL array `{Frank,Kevin,Mary}` instead of a string. `JSON_AGG(row)` returns a JSON array.

--   * Result: Returns data like `'Frank,Kevin,Mary'` (all first names as a single comma-separated string).

-- * 6. STDDEV() & VARIANCE()

--   * Definition: Returns the standard deviation and variance of numeric values (statistical functions). PostgreSQL has `STDDEV` / `STDDEV_SAMP` (sample), `STDDEV_POP` (population), `VARIANCE` / `VAR_SAMP`, `VAR_POP`. (MySQL's `STD()` = population; PostgreSQL's `STDDEV()` = sample.)

--   * Example: `SELECT STDDEV(salary), VARIANCE(salary) FROM employees;`

-- * 7. PostgreSQL extra aggregates

--   * `BOOL_AND(cond)` / `BOOL_OR(cond)`: are all / any rows true? e.g. `SELECT BOOL_AND(paid) FROM invoices;`

--   * `PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY salary)`: the median salary (MySQL has no built-in median).

--   * `MODE() WITHIN GROUP (ORDER BY city)`: the most common value.

--   * `FILTER (WHERE ...)` works on any aggregate: `SUM(sales) FILTER (WHERE country = 'India')`.

-- ---

-- ------------------------------------------------------------
-- 26.2 Window Functions (Analytical Functions)
-- ------------------------------------------------------------

-- * English Definition/Properties: Window Functions are one of the most powerful features in SQL. They allow you to perform calculations (e.g. aggregations) on a specific subset of data, without losing the level of detail of the rows.

-- ------------------------------------------------------------
-- The OVER() Clause
-- ------------------------------------------------------------

-- * English: Tells SQL that the function used is a window function. It defines a "window" or subset of data (the scope of rows the function operates on).

-- * `OVER()` is basically the "GROUP BY" of window functions. Without it, functions like `ROW_NUMBER()` cannot work because they need to know how to group and order the rows.

-- * *Note: Window functions cannot be used in the `WHERE` clause, but they can be used in `SELECT` or `ORDER BY`.*

-- ------------------------------------------------------------
-- GROUP BY vs WINDOW FUNCTION
-- ------------------------------------------------------------

-- * GROUP BY (Simple Data Analysis - Aggregations): Squashes/collapses the result. If you have 4 rows of sales for 2 products, it smashes them into 2 rows. You lose the row-level details (granularity changes). Returns a single row for each group.

-- * WINDOW FUNCTION (Advanced Data Analysis - Aggregations + Details): Evaluates each row individually. It starts with the first row, adds a total sales column, moves to the next, and keeps the original 4 rows intact. The granularity stays the same. Returns a result for each row.

-- * Q1. Find total sales across all orders (Simple Aggregation): 
--   `SELECT SUM(sales) FROM orders;`

-- * Q2. Find total sales for each product (GROUP BY): 
--   `SELECT productid, SUM(sales) FROM orders GROUP BY productid;`

-- * Q3. Find total sales for each product, BUT ALSO provide orderID and orderDate (WINDOW FUNCTION):
SELECT productid, orderid, orderdate,
       SUM(sales) OVER(PARTITION BY productid) AS totalSales, 
       AVG(sales) OVER() AS averageSales 
FROM orders;

-- ---

-- ------------------------------------------------------------
-- 26.3 Ranking Window Functions
-- ------------------------------------------------------------

-- * English Definition/Properties: Used to rank data. SQL always sorts the data as a first step before ranking your data.

-- ------------------------------------------------------------
-- Window Rank Functions Syntax
-- ------------------------------------------------------------

-- * 1st Rule (About RANK function syntax):

--   * Expression: In syntax, start with a function like `RANK()`, but we don't use any argument inside it. It must be empty. (It doesn't allow you to use any argument inside it).

--   * Partition By: The `PARTITION BY` clause is optional.

--   * Order By: The `ORDER BY` clause is required. You cannot leave it empty because the ranking function needs to know how to sort data before ranking.

-- * 1. ROW_NUMBER()

--   * Definition: Assigns a unique, sequential number to each row in the result set (1, 2, 3, 4...).

--   * Handling Ties: It does NOT handle ties. If two rows share the same value, they will not share the same rank. It always gives a distinct, unique rank for each row. (e.g. Top 1 order per customer).

--   * Q1. Rank the orders based on their sales from highest to lowest:
SELECT 
  OrderID,
  ProductID,
  Sales,
  ROW_NUMBER() OVER(ORDER BY Sales DESC) AS SalesRank_Row
FROM Sales.Orders;

-- * 2. RANK()

--   * Definition: Assigns a rank to rows in a window, with gaps.

--   * Handling Ties: It handles ties. If two rows have the same value, they share the same rank (e.g., 1, 1). 

--   * The Gap: The next rank is skipped (Leaves a gap). After 1, 1, the next rank will be 3.

-- * 3. DENSE_RANK()

--   * Definition: Assigns a rank to each row in a window, without gaps.

--   * Handling Ties: It handles ties just like `RANK()` (e.g., 1, 1), but does NOT skip the next rank. The next rank will be 2. (Leaves NO gaps).

-- * 4. NTILE(n)

--   * Definition: Divides the rows into a specified number of approximately equal groups (Buckets).

--   * Argument: The `NTILE` function always gets its argument as a number (`n`), representing the number of buckets.

--   * Bucket Size Calculation: `Bucket size = Total number of rows / number of buckets (n)`.

--   * SQL Rule for Buckets: If the division is not perfectly equal, the larger groups come first, then smaller.

-- ------------------------------------------------------------
-- Integer-based vs Percentage-based Ranking
-- ------------------------------------------------------------

-- * **Integer-Based Ranking (`ROW_NUMBER`, `RANK`, `DENSE_RANK`, `NTILE`):**

--   * Assigns discrete values (1, 2, 3, 4, 5).

--   * Primarily used for Top / Bottom N Analysis.

-- * **Percentage-Based Ranking (`CUME_DIST`, `PERCENT_RANK`):**

--   * Assigns continuous values (0, 0.25, 0.5, 0.75, 1).

--   * Primarily used for Distribution Analysis.

-- ------------------------------------------------------------
-- Use Cases for Ranking Functions
-- ------------------------------------------------------------

-- 1. Use Case 1 | Top-N Analysis: 

--    * English: Help analyze the top performers to do targeted marketing. Find the top highest sales for each product.

--    * (Note: In window function we cannot use WHERE clause, so we use a subquery to filter the highest sales).
-- Find the top highest sales for each product
SELECT *
FROM (
  SELECT
    OrderID, 
    ProductID, 
    Sales,
    ROW_NUMBER() OVER(PARTITION BY ProductID ORDER BY Sales DESC) AS RankByProduct
  FROM Sales.Orders
) t 
WHERE RankByProduct = 1;

-- 2. Use Case 2 | Bottom-N Analysis: 

--    * English: Help analyze underperformance to manage risks and to do optimizations. Find out the lowest performance sales.
-- Find the lowest 2 customers based on their total sales
SELECT *
FROM (
  SELECT
    CustomerID,
    SUM(Sales) AS TotalSales,
    ROW_NUMBER() OVER (ORDER BY SUM(Sales)) AS RankCustomers
  FROM Sales.Orders
  GROUP BY CustomerID
) t 
WHERE RankCustomers <= 2;

-- 3. Use Case 3 | Assigning Unique IDs (Pagination): 

--    * English: Help to assign a unique identifier for each row to help pagination. The process of breaking down large data into smaller, and more manageable chunks.

-- 4. Use Case 4 | Identify the Duplicates (Quality Checks): 

--    * English: Used for data cleansing. Identify and remove duplicate rows to improve data quality. If you want to remove duplicate rows, use `PARTITION BY` with the primary_key column inside the `OVER()` window function.
-- Identify duplicate rows in the table 'OrdersArchive'
-- and return a clean result without any duplicates
SELECT * FROM (
  SELECT
    *,
    ROW_NUMBER() OVER(PARTITION BY OrderID ORDER BY CreationTime DESC) AS rn
  FROM Sales.OrdersArchive
) t 
WHERE rn = 1;

-- 5. Use Case 5 | Data Segmentation (NTILE): 

--    * English (Data Analyst): Data segmentation means dividing the dataset into distinct subsets based on certain criteria. For example, segmenting customers into different groups based on behaviors like total sales into 'High', 'Medium', and 'Low' buckets.

--    * *(Note: The subquery makes this easier to read. You can also put the window function directly inside CASE: `CASE NTILE(3) OVER (ORDER BY Sales DESC) WHEN 1 THEN 'High' ... END`.)*
-- Segment all orders into 3 categories: High, Medium, and Low sales.
SELECT 
  OrderID, Sales, Buckets,
  CASE 
    WHEN Buckets = 1 THEN 'High'
    WHEN Buckets = 2 THEN 'Medium'
    WHEN Buckets = 3 THEN 'Low'
  END AS SalesSegmentations
FROM (
  SELECT
    OrderID,
    Sales,
    NTILE(3) OVER (ORDER BY Sales DESC) AS Buckets
  FROM Sales.Orders
) t;

-- 6. Use Case 6 | Equalizing Load Processing (NTILE): 

--    * English (Data Engineer): Used for load balancing. If you want to distribute data evenly across multiple databases (e.g., divide orders into 4 equal groups to export them to 4 different databases).
-- In order to export the data, divide the orders into 4 groups.
SELECT
  OrderID, ProductID, CustomerID, Sales, OrderDate,
  NTILE(4) OVER (ORDER BY OrderID) AS Buckets
FROM Sales.Orders;

-- ------------------------------------------------------------
-- Window Rank Functions Summary
-- ------------------------------------------------------------

-- * Summary Points:

--   * Types: Integer-based (`ROW_NUMBER`, `RANK`, `DENSE_RANK`, `NTILE`) vs Percentage-based (`PERCENT_RANK`, `CUME_DIST`).

--   * Rules: Expression is Empty (except NTILE which takes `n`), `ORDER BY` is Required, `FRAME` clause is Not Allowed.

--   * Use Cases: Top N Analysis, Bottom N Analysis, Identify/Remove Duplicates, Assign Unique IDs (Pagination), Data Segmentation, Data Distribution Analysis, Equalizing Load Processing.

-- ---

-- ------------------------------------------------------------
-- 26.4 Percentage-Based Ranking Functions
-- ------------------------------------------------------------

-- * English Definition/Properties: In order for SQL to generate and calculate percentages, we have 2 different formulas or functions. Instead of integer ranking, SQL computes the relative position of the row compared to others and assigns a percentage to each row. 

-- * Key Difference (Inclusive vs Exclusive):

--   * `CUME_DIST` is Inclusive (The current row is included).

--   * `PERCENT_RANK` is Exclusive (The current row is excluded).

-- * 1. PERCENT_RANK()

--   * Use Case: If you want to focus on the relative position of each row, then go with `PERCENT_RANK`. It calculates the relative rank of a row as a percentage of the result set.

--   * Computes the relative rank of a row on a continuous 0 to 1 scale (e.g., 0 as 0, 10% as 0.1, 30% as 0.3, etc.).

--   * `PERCENT_RANK` goes and calculates the relative position as a percentage and assigns it to each row. The output can be a continuous normalized scale from 0 to 1.

--   * Basically used for distribution analyzation. Calculate the relative position of each row overall.

-- * 2. CUME_DIST() (Cumulative Distribution)

--   * Use Case: If you want to focus on cumulative distribution calculation of data points, use cumulative distribution. This is the Cumulative Distribution Function (CDF) in action. It calculates a percentage (between 0 and 1) that shows how far up the distribution a given value is.

--   * It stands for cumulative distribution. Calculates the distribution of data points within the window.

--   * Formula: `Position_Number / Number_of_Rows`.

--   * Tie Rule: If two values are the same (Tie), `CUME_DIST` takes the position of the last occurrence of the same value. It means it calculates the percentage for the first value and assigns the exact same percentage for the second same value.

-- * Comparison Example:

--   * For Sales (100, 80, 80, 50, 30): Both functions generate output based on percentage ranking.

--   * Both of them are handling the ties perfectly, so they share the same percentage rank (e.g. both 80s get DIST 0.6 and PER 0.25).

--   * Based on the formulas, we have to find out the percentage value of the relative position of each row overall. So it is very important to measure the contribution of each value to the overall distribution.

-- ------------------------------------------------------------
-- 26.5 Aggregate Window Functions (SUM, AVG, MIN, MAX, COUNT)
-- ------------------------------------------------------------

-- * English Definition: In window aggregation, functions like `SUM`, `AVG`, `MIN`, `MAX`, and `COUNT` calculate their values for each window separately (or the entire dataset if no partition is given), but unlike `GROUP BY`, they do not collapse the rows.

-- ------------------------------------------------------------
-- The `COUNT()` Function Details (Data Quality & Duplicates)
-- ------------------------------------------------------------

-- * English: The `COUNT()` function returns the number of rows in each window (i.e., how many rows are in a subset of data). It counts the number of values regardless of their data type.

--   * `COUNT(*)` or `COUNT(1)`: Counts all rows, regardless of NULLs. (`COUNT(1)` works because 1 is a constant and never NULL).

--   * `COUNT(column)`: Counts the number of non-NULL values in that specific column.

-- * Note on Duplicates: The `COUNT()` function counts the total number of rows including duplicates, not just unique values.

-- * Data Quality Issue: Duplicates lead to inaccuracies in analysis. `COUNT()` can be used to identify duplicates. For example, if you partition by a unique ID and `COUNT() > 1`, you have duplicate rows!

-- ------------------------------------------------------------
-- Use Cases for Aggregate Window Functions
-- ------------------------------------------------------------

-- 1. Use Case 1 | OVERALL ANALYSIS (Quick Summary)

--    * English: Quick summary or snapshot of the entire dataset. (e.g. Find the total sales across all orders).
-- Find the total sales across all orders
-- And the total sales for each product
-- Additionally provide details such order Id, order date
SELECT
  OrderID, OrderDate, Sales,
  SUM(Sales) OVER () AS TotalSales,
  SUM(Sales) OVER (PARTITION BY ProductID) AS SalesByProducts
FROM Sales.Orders;

--    * Rule 1: `SUM()` accepts only numbers.

-- 2. Use Case 2 | TOTAL PER GROUPS (Group-wise Analysis)

--    * English: Group-wise analysis, to understand patterns within different categories.
-- Find the highest and lowest sales of all orders
-- Find the highest and lowest sales for each product
-- Additionally provide details such order Id, order date
SELECT
  OrderID, OrderDate, ProductID, Sales,
  MAX(Sales) OVER() AS HighestSales,
  MIN(Sales) OVER() AS LowestSales,
  MAX(Sales) OVER(PARTITION BY ProductID) AS HighestSalesByProduct,
  MIN(Sales) OVER(PARTITION BY ProductID) AS LowestSalesByProduct
FROM Sales.Orders;

--    * Note on filtering with Window Functions:

--      * You cannot use the `WHERE` clause directly on the window function in the same query level. You must use a subquery.
-- Find all orders where sales are higher than the average sales across all orders
SELECT * FROM (
  SELECT
    OrderID, ProductID, Sales,
    AVG(Sales) OVER() AS AvgSales
  FROM Sales.Orders
) t 
WHERE Sales > AvgSales;

-- 3. Use Case 3 | COMPARISON (Compare Current vs Aggregated)

--    * English: Compare the current value and aggregated value of window functions (e.g. Help to evaluate whether a value is above or below the average, or find percentage contribution).
-- Find the percentage contribution of each product's sales to the total sales
SELECT
  OrderID, ProductID, Sales,
  SUM(Sales) OVER () AS TotalSales,
  ROUND(Sales::NUMERIC / SUM(Sales) OVER () * 100, 2) AS PercentageOfTotal   -- PostgreSQL: ROUND(x, 2) needs NUMERIC, not FLOAT
FROM Sales.Orders;
-- Find the deviation of each sales from the minimum and maximum sales amounts
SELECT
  OrderID, OrderDate, ProductID, Sales,
  MAX(Sales) OVER() AS HighestSales,
  MIN(Sales) OVER() AS LowestSales,
  Sales - MIN(Sales) OVER() AS DeviationFromMin,
  MAX(Sales) OVER() - Sales AS DeviationFromMax
FROM Sales.Orders;

-- ------------------------------------------------------------
-- COUNT() Window Function
-- ------------------------------------------------------------

-- * English: The `COUNT()` function returns the number of rows in each window (i.e. how many rows are in a subset of data). It works on any data type (numbers, text, dates). `MIN()` and `MAX()` also accept text and dates, but `SUM()` and `AVG()` need numbers.

-- * Types of COUNT:

--   * `COUNT(*)`: Counts all rows in the table/window, regardless of whether any value is NULL.

--   * `COUNT(1)`: Exactly equal to `COUNT(*)`, because 1 is a constant and never NULL.

--   * `COUNT(column)`: Counts the number of non-NULL values in that specific column.

--   * Note: Count function counts the total number of rows including duplicates, not just the unique values.

-- Use Cases for COUNT():

-- 1. #1 Overall Analysis: Quick summary or snapshot of the entire dataset.
-- Find the total number of orders for each product
SELECT 
  Product, Sales,
  COUNT(*) OVER(PARTITION BY Product) AS Count_Orders
FROM SalesData;

-- 2. #2 Category Analysis (Total per Group): Group-wise analysis to understand patterns with different categories.
-- Find the total number of Orders for each customer
-- Additionally provide details such as OrderID, OrderDate
SELECT
  OrderID, OrderDate, CustomerID,
  COUNT(*) OVER() AS TotalOrders,
  COUNT(*) OVER(PARTITION BY CustomerID) AS OrdersByCustomers
FROM Sales.Orders;

-- 3. #3 Quality Checks: Identify NULLs: Detecting number of NULLs by comparing `COUNT(column)` to `COUNT(*)`.
-- Find the total number of Customers and total number of Scores
-- Difference between these counts reveals how many NULL scores exist
SELECT
  CustomerID, FirstName, LastName, Country, Score,
  COUNT(*) OVER() AS TotalCustomers,
  COUNT(Score) OVER() AS TotalScores
FROM Sales.Customers;

-- 4. #4 Quality Checks: Identify Duplicates: Duplicate rows lead to inaccuracies. `COUNT()` can be used to identify them.
-- Check whether the table 'orders' contains any duplicate rows
SELECT * FROM (
  SELECT
    OrderID,
    COUNT(*) OVER(PARTITION BY OrderID) AS CheckPK
  FROM Sales.OrdersArchive
) t
WHERE CheckPK > 1;

-- ------------------------------------------------------------
-- Handling NULLs in Aggregate Window Functions
-- ------------------------------------------------------------

-- * English: Functions like `AVG()` ignore `NULL` values. If a `NULL` implies zero (e.g., no sales), ignoring it will skew the average. We use `COALESCE()` to handle nullish values.

-- Find the average scores of customers
-- Additionally provide details such CustomerID and LastName
SELECT
  CustomerID, LastName, Score,
  COALESCE(Score, 0) AS CustomerScore,
  AVG(Score) OVER () AS AvgScore,
  AVG(COALESCE(Score, 0)) OVER () AS AvgScoreWithoutNull
FROM Sales.Customers;

-- ------------------------------------------------------------
-- Running Total vs Rolling Total (Analysis Over Time)
-- ------------------------------------------------------------

-- * English: Used for tracking sequence of members, and the aggregation is updated each time a new member is added (e.g. tracking current sales with target sales over time).

-- 1. Running Total:

--    * English: Aggregates all values from the beginning up to the current point without dropping off older data.

-- Default frame: ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
SELECT Month, Sales, SUM(Sales) OVER (ORDER BY Month) AS RunningTotal 
FROM SalesData;

--    * ⚠️ Note: The comment above is slightly wrong: when `ORDER BY` is used without a frame, the default is `RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW` (not `ROWS`). With `RANGE`, rows having the same `Month` are added together in one step.

-- 2. Rolling Total (Shifting Window):

--    * English: Aggregates all values within a fixed time window (e.g., 30 days or last 2 rows). As new data is added, the oldest data point will be dropped.

-- Rolling Total for current and 2 preceding rows
SELECT Month, Sales, 
  SUM(Sales) OVER (ORDER BY Month ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS RollingTotal 
FROM SalesData;

-- ------------------------------------------------------------
-- Moving Average
-- ------------------------------------------------------------

-- * English: Moving average is very similar to running/rolling total, but here we do average instead of sum.

-- Calculate running average of sales for each product over time
SELECT
  OrderID, ProductID, OrderDate, Sales,
  AVG(Sales) OVER (PARTITION BY ProductID) AS AvgByProduct,
  AVG(Sales) OVER (PARTITION BY ProductID ORDER BY OrderDate) AS RunningAvg
FROM Sales.Orders;
-- Calculate rolling average of sales for each product over time (Including only the next order)
SELECT
  OrderID, ProductID, OrderDate, Sales,
  AVG(Sales) OVER (PARTITION BY ProductID) AS AvgByProduct,
  AVG(Sales) OVER (PARTITION BY ProductID ORDER BY OrderDate) AS RunningAvg,
  AVG(Sales) OVER (PARTITION BY ProductID ORDER BY OrderDate ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING) AS RollingAvg
FROM Sales.Orders;

-- ---

-- ------------------------------------------------------------
-- 26.6 Value Window Functions (Analytics Functions)
-- ------------------------------------------------------------

-- * English Definition: These are used to access data from other rows (in the result set) without using `JOIN`s or subqueries. They help compare current row values with previous, next, first, or last values in the window.

-- ------------------------------------------------------------
-- Syntax Rules for Value Functions
-- ------------------------------------------------------------

-- * Expression: Can be any data type.

-- * ORDER BY Clause: Required (You must order the window so SQL knows what 'next' or 'previous' means).

-- * PARTITION BY Clause: Optional.

-- * FRAME Clause:

--   * `LEAD()` & `LAG()` $\rightarrow$ Not Allowed.

--   * `FIRST_VALUE()` $\rightarrow$ Optional.

--   * `LAST_VALUE()` $\rightarrow$ Should be used (Because default frame stops at CURRENT ROW, which defeats the purpose of LAST_VALUE).

-- * 1. LEAD(expr, offset, default)

--   * English: Access data from the next row (subsequent row) within a window.

-- * 2. LAG(expr, offset, default)

--   * English: Access data from the previous row within a window.

--   * Arguments Details (For LEAD & LAG):

--     * `Expression` (Required): The column or value to access.

--     * `Offset` (Optional): Number of rows forward/backward from the current row (Default = 1).

--     * `Default` (Optional): Returns this value if the next/previous row is not available (Default = `NULL`).

-- ------------------------------------------------------------
-- Use Cases for LEAD & LAG (Comparison Analysis)
-- ------------------------------------------------------------

-- 1. Time Series Analysis (MOM - Month-over-Month):

--    * English: Analyze short-term trends and discover patterns in seasonality by comparing current month to previous month.
-- Analyze the month-over-month performance by finding the percentage change
-- in sales between the current and previous months
SELECT 
  OrderMonth, 
  CurrentMonthSales, 
  PreviousMonthSales,
  CurrentMonthSales - PreviousMonthSales AS MoM_Change,
  ROUND((CurrentMonthSales - PreviousMonthSales)::NUMERIC / PreviousMonthSales * 100, 1) AS MoM_Perc   -- ::NUMERIC avoids integer division
FROM (
  SELECT
    EXTRACT(MONTH FROM OrderDate) AS OrderMonth,
    SUM(Sales) AS CurrentMonthSales,
    LAG(SUM(Sales)) OVER(ORDER BY EXTRACT(MONTH FROM OrderDate)) AS PreviousMonthSales
  FROM Sales.Orders
  GROUP BY EXTRACT(MONTH FROM OrderDate)
) t;

-- 2. Customer Loyalty Analysis:

--    * English: Compare current order date with the next order date using `LEAD` to find the average days between orders.

--    * (Note: PostgreSQL has no `DATEDIFF`; subtracting two `DATE` values gives the number of days. If `OrderDate` is a `TIMESTAMP`, cast it with `::DATE` first.)
-- In order to analyze customer loyalty,
-- rank customers based on the average days between their orders
SELECT
  CustomerID,
  AVG(DaysUntilNextOrder) AS AvgDays,
  RANK() OVER(ORDER BY COALESCE(AVG(DaysUntilNextOrder), 9999999)) AS RankAvg
FROM (
  SELECT
    OrderID,
    CustomerID,
    OrderDate AS CurrentOrder,
    LEAD(OrderDate) OVER(PARTITION BY CustomerID ORDER BY OrderDate) AS NextOrder,
    LEAD(OrderDate::DATE) OVER(PARTITION BY CustomerID ORDER BY OrderDate)
      - OrderDate::DATE AS DaysUntilNextOrder
  FROM Sales.Orders
) t
GROUP BY CustomerID;

-- * 3. FIRST_VALUE(expr)

--   * English: Access a value from the first row within a window.

-- * 4. LAST_VALUE(expr)

--   * English: Access a value from the last row within a window.

--   * Critical Rule for LAST_VALUE Frame:

--     * By default, the window frame is `RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW`. This means the "last" value it sees is just the current row.

--     * To truly get the last value of the entire partition/window, you MUST change the frame to: `ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING` (or `UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING`).
-- Correct way to use LAST_VALUE
SELECT 
  Month, Sales,
  LAST_VALUE(Sales) OVER (
    ORDER BY Month 
    ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING
  ) AS LastSalesValue
FROM SalesData;

-- ------------------------------------------------------------
-- Use Case for FIRST_VALUE & LAST_VALUE (Compare to Extremes)
-- ------------------------------------------------------------

-- 1. Compare to Extremes:

--    * English: Find how well a value is performing relative to extremes (highest and lowest).
-- Find the lowest and highest sales for each product
SELECT
  OrderID, ProductID, Sales,
  FIRST_VALUE(Sales) OVER (PARTITION BY ProductID ORDER BY Sales) AS LowestSales,
  LAST_VALUE(Sales) OVER (PARTITION BY ProductID ORDER BY Sales
    ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) AS HighestSales
FROM Sales.Orders;

-- * 5. NTH_VALUE(expr, n)

--   * English: The `NTH_VALUE()` function is a window function used to fetch the n-th value (e.g., 1st, 2nd, 3rd) within a window frame.

--   * Key Points:

--     * `n`: which value to fetch (e.g. 2 for the second).

--     * `ORDER BY` is mandatory to define what "n-th" means.

--     * Frame Default: By default, it's `RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW`, which won't work for `n > 1` if the current row hasn't reached it. Always explicitly define frame as `ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING`.

--     * Returns `NULL` if there aren't enough rows in the partition.

--   * Example:
-- Fetch the second highest salary for each department
SELECT
  employee_id, department, salary,
  NTH_VALUE(salary, 2) OVER (
    PARTITION BY department
    ORDER BY salary DESC
    ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
  ) AS second_highest_salary
FROM employees;

-- ---

-- ------------------------------------------------------------
-- 26.7 Window Function Syntax Deep Dive (OVER Clause)
-- ------------------------------------------------------------

-- * English Definition: A Window function query mainly has two parts: The Function (performs calculation on top of window) and the OVER() clause (defines the window/subset of data). The `OVER` clause has three sub-clauses: `PARTITION BY`, `ORDER BY`, and `FRAME`.

-- 1. PARTITION BY Clause:

--    * English: Divides the rows into groups based on column(s). If empty (no partition), calculation is done on the entire dataset. It is optional for all window functions (aggregation, ranking, value).

--    * Example: `SUM(Sales) OVER()` (entire dataset), `SUM(Sales) OVER(PARTITION BY ProductID)` (group by product).

-- 2. ORDER BY Clause:

--    * English: Sorts data within a window. Default is ascending `ASC`. It is Required for Ranking functions and Value functions. Optional for Aggregation functions.

-- Order By is required for RANK()
SELECT
  OrderID, OrderDate, Sales,
  RANK() OVER (ORDER BY Sales DESC) AS RankSales
FROM Sales.Orders;

-- 3. FRAME Clause:

--    * English: Defines a specific subset of rows within each window that is relevant for the calculation. It is used when you don't want to consider all rows in the partition.

--    * Syntax: `ROWS BETWEEN <Lower_Bound> AND <Upper_Bound>`

--    * Boundary Values:

--      * `CURRENT ROW`: The current row being evaluated.

--      * `UNBOUNDED PRECEDING`: The first possible row within a window.

--      * `UNBOUNDED FOLLOWING`: The last possible row within a window.

--      * `N PRECEDING`: N rows before the current row.

--      * `N FOLLOWING`: N rows after the current row.

--    * Important Frame Rules:

--      1. Frame clause is used together with the `ORDER BY` clause (in SQL Server it is required; PostgreSQL allows a frame without `ORDER BY`, but then all rows are peers, so it is rarely useful).

--      2. Lower Value must be BEFORE the higher value logically (e.g. `2 PRECEDING` to `1 FOLLOWING` is valid, but `1 FOLLOWING` to `2 PRECEDING` is invalid).

--    * Default Frame vs Compact Frame:

--      * Default: If `ORDER BY` is used but `FRAME` is not specified, SQL uses the default frame: `RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW`.

--      * Compact (short form): If you only need `PRECEDING` rows up to the current row, you can write just the start: `ROWS 2 PRECEDING` is short for `ROWS BETWEEN 2 PRECEDING AND CURRENT ROW`. ⚠️ `ROWS 2 FOLLOWING` is not a valid short form — for `FOLLOWING` rows always write the full `ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING`.

-- ---

-- ------------------------------------------------------------
-- 26.8 Window Function Limitations & Rules
-- ------------------------------------------------------------

-- * Rule 1: Allowed Clauses Only

--   * English: Window functions can only be used in the `SELECT` and `ORDER BY` clauses. You cannot use them directly in `WHERE`, `GROUP BY`, or `HAVING` clauses.

-- * Rule 2: No Nesting

--   * English: Nesting window functions inside another window function is not allowed (e.g., `SUM(SUM(Sales) OVER(...)) OVER(...)` will throw an error).

-- * Rule 3: Execution Order

--   * English: SQL executes window functions after the `WHERE` clause. It first filters the data, and then aggregates/ranks it.

-- * Rule 4: With GROUP BY

--   * English: Window functions can be used together with `GROUP BY` in the same query, only if the window function uses the exact same columns/aggregations.

-- First build the query using group by function, then next step you define the window function
-- Rank Customers based on their total sales
SELECT 
  CustomerID,
  SUM(Sales) AS TotalSales,
  RANK() OVER(ORDER BY SUM(Sales) DESC) AS RankCustomers
FROM Sales.Orders
GROUP BY CustomerID;

-- ---

-- ------------------------------------------------------------
-- 26.9 Why Window Functions? (Advantages)
-- ------------------------------------------------------------

-- 1. Advance Analytics Without Aggregation: Unlike `GROUP BY`, window functions do not reduce/collapse rows. You can calculate running totals, rankings, and moving averages while still keeping each row intact.

-- 2. Simplify Complex Queries: Allows you to avoid complex self-joins or subqueries when doing cumulative and comparative analysis.

-- 3. Performance: They are often much more efficient than writing equivalent subqueries or self-joins.

-- 4. Better Readability: Clear and declarative syntax for ranking, partitioning, and ordering operations.

-- ------------------------------------------------------------
-- 26.10 GROUP BY + HAVING vs Window Functions
-- ------------------------------------------------------------
-- Window Functions are often confused with `GROUP BY` and `HAVING`, but they are fundamentally different:

-- 1. GROUP BY + HAVING

--    * Purpose: `GROUP BY` collapses rows into groups. `HAVING` filters those groups (like `WHERE`, but for grouped results).

--    * Rows Returned: One row per group (collapses data).

--    * When to use: When you only care about the summarized totals and don't need the individual row details.

--    * Example:
SELECT dept_id, AVG(salary) AS avg_salary
FROM employees
GROUP BY dept_id
HAVING AVG(salary) > 60000;
--      (Output: One row per department).

-- 2. Window Functions

--    * Purpose: They calculate aggregates but keep every row. (Use `OVER()` with optional `PARTITION BY` and `ORDER BY`).

--    * Rows Returned: All original rows are returned (no collapsing).

--    * When to use: Used for running totals, ranking, moving averages, and comparisons where you want to see both the detail and the summary.

--    * Example:
SELECT emp_id, emp_name, dept_id, salary,
       AVG(salary) OVER (PARTITION BY dept_id) AS avg_salary_in_dept
FROM employees;
--      (Output: Every employee stays visible, but you also see department averages next to each row).

-- * **Q1. `ROW_NUMBER` vs `RANK` vs `DENSE_RANK` for 100, 90, 90, 80?**

--   * Answer: 1,2,3,4 / 1,2,2,4 / 1,2,2,3. Use DENSE_RANK for 'Nth highest' when ties should share a rank.

-- * Q2. Why can't you use a window function in WHERE? How do you filter on it?

--   * Answer: WHERE runs before window functions are computed. Put the window function in a subquery or CTE and filter outside: `SELECT * FROM (SELECT ..., ROW_NUMBER() OVER (...) rn FROM t) x WHERE rn = 1;`

-- * **Q3. `ROWS` vs `RANGE` frame?**

--   * Answer: `ROWS` counts physical rows; `RANGE` groups rows with the same ORDER BY value (ties are added together). The default frame with ORDER BY is `RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW`, which is why running totals 'jump' on duplicate dates.

-- * Q4. How do you compute month-over-month growth?

--   * Answer: Aggregate by month, then `LAG(total) OVER (ORDER BY month)` and `(total - prev) / prev * 100`.

-- * **Q5. `GROUP BY` vs `PARTITION BY`?**

--   * Answer: GROUP BY collapses rows (one per group); PARTITION BY keeps every row and adds the group result next to it.

-- * Q6. Top 3 earners per department? → see Q135 in the Interview Q&A Bank (Topic 53).

-- ------------------------------------------------------------
-- 26.11.1 🐘 PostgreSQL Window Extras (New)
-- ------------------------------------------------------------

-- * `DISTINCT ON` — the easiest "first row per group" (PostgreSQL only):
-- Latest order of every customer
SELECT DISTINCT ON (customer_id) customer_id, order_id, order_date
FROM orders
ORDER BY customer_id, order_date DESC;

--   * Rule: the `DISTINCT ON (...)` columns must come first in `ORDER BY`. The rest of `ORDER BY` decides which row is kept.

--   * Same result with a window function (works everywhere): `ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY order_date DESC) = 1` in an outer query.

-- * Named windows with the `WINDOW` clause (avoid repeating the same `OVER (...)`):
SELECT order_id, sales,
       SUM(sales) OVER w AS running_total,
       AVG(sales) OVER w AS running_avg
FROM orders
WINDOW w AS (PARTITION BY customer_id ORDER BY order_date);

-- * Extra frame options in PostgreSQL: `GROUPS BETWEEN 1 PRECEDING AND CURRENT ROW` (count peer groups, not rows), `RANGE BETWEEN INTERVAL '7 days' PRECEDING AND CURRENT ROW` (last 7 days by date value), and `EXCLUDE CURRENT ROW`.

-- * `FILTER` inside a window aggregate: `COUNT(*) FILTER (WHERE status = 'Delivered') OVER (PARTITION BY customer_id)`.

--   * `SELECT * FROM (SELECT name, dept, salary, RANK() OVER (PARTITION BY dept ORDER BY salary DESC) r FROM employees) t WHERE r = 1;`

-- ---

-- ======================================================================
-- 🎯 Practice Questions (salesdb sample data) — try first, then look at the answer
-- ======================================================================
-- Run 00-Setup-Sample-Data.sql once before this section.

SET search_path TO sales;

-- Q1. Aggregates: count, sum, avg, min, max of sales.
SELECT COUNT(*) AS orders_count, SUM(sales) AS total, AVG(sales) AS avg_sales, MIN(sales) AS min_sales, MAX(sales) AS max_sales FROM orders;

-- Q2. Window: each order with the customer total next to it.
SELECT orderid, customerid, sales,
       SUM(sales) OVER (PARTITION BY customerid) AS customer_total
FROM orders;

-- Q3. Ranking: rank products by price; running total of sales by date.
SELECT product, price, RANK() OVER (ORDER BY price DESC) AS price_rank FROM products;
SELECT orderid, orderdate, sales, SUM(sales) OVER (ORDER BY orderdate) AS running_total FROM orders;

-- Q4. LAG: sales difference from the previous order.
SELECT orderid, sales, LAG(sales) OVER (ORDER BY orderid) AS prev_sales,
       sales - LAG(sales) OVER (ORDER BY orderid) AS diff
FROM orders;
