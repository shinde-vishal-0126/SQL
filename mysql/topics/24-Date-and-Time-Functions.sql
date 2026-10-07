-- ======================================================================
-- Topic 24: Date and Time Functions
-- ======================================================================

-- ------------------------------------------------------------
-- 📖 In Simple Words
-- ------------------------------------------------------------

-- * Definition: Date and time functions read parts of a date (year, month, day), add or subtract time, find the difference between dates and format dates as text.

-- * Real-life example: Like a calendar app: "what month is it?", "how many days until delivery?".

-- * Example on salesdb (run 00-Setup-Sample-Data.sql first):
USE salesdb;
SELECT orderid, orderdate, shipdate,
       MONTH(orderdate) AS order_month,
       DATEDIFF(shipdate, orderdate) AS days_to_ship
FROM orders;

-- * Example explained (step by step):
--   1. order_month takes the month number from orderdate (1 = January).
--   2. days_to_ship = shipdate minus orderdate in days.
--   3. Example: order 3 was ordered on 10 Jan and shipped on 25 Jan → 15 days.

-- ------------------------------------------------------------
-- 24.1 Anatomy of Date & Time
-- ------------------------------------------------------------

-- * English Definition/Properties: A Date typically contains Year, Month, and Day. A Time contains Hours, Minutes, and Seconds. A Timestamp (or Datetime) combines both.

--   * DATE = Year-Month-Day (`2025-08-20`); TIME = Hour:Min:Sec (`18:55:45`).

-- ------------------------------------------------------------
-- 24.2 Sources of Dates (How to Query Dates)
-- ------------------------------------------------------------

-- * English Definition/Properties: We have three main sources to get dates in SQL:

--   1. From a Table Column: Fetching stored dates. (e.g., `SELECT HIRE_DATE FROM CUSTOMERS;`)

--   2. Hardcoded Constant String: Providing a static date directly in the query. (e.g., `SELECT '2025-08-20' AS NEWDATE;`)

--   3. System Current Date/Time Functions: Using built-in functions like `GETDATE()` (SQL Server) or `NOW()` / `CURRENT_TIMESTAMP()` (MySQL).

-- ------------------------------------------------------------
-- 24.3 Overview of Built-in Date/Time Functions (MySQL focus)
-- ------------------------------------------------------------

--   * Part Extraction: `YEAR()`, `MONTH()`, `DAY()`, `HOUR()`; Formatting: `DATE_FORMAT()`, `STR_TO_DATE()`, `CAST()`.

--   * `DATEPART` ➔ INT, `DATENAME` ➔ STRING, `DATETRUNC` ➔ DATETIME, `EOMONTH` ➔ DATE.

-- ------------------------------------------------------------
-- A. Current Date & Time Functions
-- ------------------------------------------------------------

-- * 1. NOW() & CURRENT_TIMESTAMP()

--   * English: Returns the current system date and time. `NOW()` is mostly used in `SELECT` queries, while `CURRENT_TIMESTAMP` is preferred as a default value in table definitions.

--   * Example: `SELECT NOW();` $\rightarrow$ `2025-09-03 13:30:20`

-- * 2. CURDATE() / UTC_DATE()

--   * English: `CURDATE()` returns only the current Date (no time). `UTC_DATE()` returns the current UTC date.

--   * Example: `SELECT CURDATE();` $\rightarrow$ `2025-09-03`

-- * 3. CURTIME() / UTC_TIME()

--   * English: Returns only the current Time (no date).

-- ------------------------------------------------------------
-- B. Extracting Parts of a Date
-- ------------------------------------------------------------

-- * English Definition/Properties: You can extract specific parts like year, month, or day from a full datetime. In SQL Server, `DATEPART(part, date)` is commonly used. In MySQL, direct functions are used.

-- * Examples:

--   * YEAR(date): `SELECT YEAR('2025-09-03');` $\rightarrow$ `2025`

--   * MONTH(date): `SELECT MONTH('2025-09-03');` $\rightarrow$ `9`

--   * DAY(date) / DAYOFMONTH(date): `SELECT DAY('2025-09-03');` $\rightarrow$ `3`

--   * HOUR(time): `SELECT HOUR('13:45:59');` $\rightarrow$ `13`

--   * MINUTE(time): `SELECT MINUTE('13:45:59');` $\rightarrow$ `45`

--   * SECOND(time): `SELECT SECOND('13:45:59');` $\rightarrow$ `59`

--   * MICROSECOND(time): `SELECT MICROSECOND('2025-09-03 13:45:59.123456');` $\rightarrow$ `123456`

--   * DAYOFWEEK(date): `SELECT DAYOFWEEK('2025-09-03');` $\rightarrow$ `4` (1=Sunday, 7=Saturday)

--   * DAYOFYEAR(date): `SELECT DAYOFYEAR('2025-09-03');` $\rightarrow$ `246` (1 to 366)

--   * WEEK(date): `SELECT WEEK('2025-09-03');` $\rightarrow$ `35` (Week of the year)

--   * QUARTER(date): `SELECT QUARTER('2025-09-03');` $\rightarrow$ `3` (Quarter of the year, 1-4)

--   * DATENAME() / DAYNAME() / MONTHNAME()

--     * English: In SQL Server, `DATENAME(part, date)` returns the name of a specific part as a string. (e.g., `DATENAME(WEEKDAY, date)` $\rightarrow$ `'Monday'`). MySQL doesn't support `DATENAME`, so you use `DAYNAME(date)` and `MONTHNAME(date)`.

--   * EOMONTH() / LAST_DAY()

--     * English: Returns the last day of the month for the given date. Used in SQL Server as `EOMONTH(date)`. In MySQL, use `LAST_DAY(date)`. To get the first date of the month in MySQL, use `DATE_FORMAT(date, '%Y-%m-01')`.

-- * Q1. Extract multiple parts from a table:
SELECT CREATIONTIME, YEAR(CREATIONTIME) AS YEAR, MONTH(CREATIONTIME) AS MONTH, DAY(CREATIONTIME) AS DAY, DAYNAME(CREATIONTIME) AS DAYNAME FROM ORDERS;

-- ------------------------------------------------------------
-- C. Date/Time Manipulation (Adding & Subtracting)
-- ------------------------------------------------------------

-- * English Definition: You can add or subtract time intervals (days, months, hours) to/from a specific date.

-- * 1. DATE_ADD() / ADDDATE()

--   * `SELECT DATE_ADD('2025-09-03', INTERVAL 10 DAY);` $\rightarrow$ `2025-09-13`

-- * 2. DATE_SUB() / SUBDATE()

--   * `SELECT DATE_SUB('2025-09-03', INTERVAL 2 MONTH);` $\rightarrow$ `2025-07-03`

-- * 3. ADDTIME() & SUBTIME()

--   * `SELECT ADDTIME('10:00:00', '02:30:00');` $\rightarrow$ `12:30:00`

-- ------------------------------------------------------------
-- D. Differences & Conversion
-- ------------------------------------------------------------

-- * 1. DATEDIFF() & TIMESTAMPDIFF()

--   * English: Used to find the difference between two dates. 

--     * In SQL Server: `DATEDIFF(interval, start_date, end_date)` allows you to specify the interval (YEAR, MONTH, DAY). (e.g., `SELECT DATEDIFF(MONTH, '2025-08-20', '2026-02-01');` $\rightarrow$ `6` — SQL Server counts month boundaries crossed: Aug → Feb = 6)

--     * In MySQL: `DATEDIFF(end_date, start_date)` returns the difference in Days only. For differences in Years, Months, or Hours, use `TIMESTAMPDIFF(unit, start_date, end_date)`.

--   * Q1. Calculate the Age of the Employee (Difference in Years) (MySQL):
SELECT FIRSTNAME, LASTNAME, TIMESTAMPDIFF(YEAR, BIRTHDATE, NOW()) AS AGE FROM EMPLOYEES;

--   * Difference in Hours/Minutes (MySQL):
SELECT TIMESTAMPDIFF(HOUR, '2025-09-27 10:00:00', '2025-09-28 12:30:00') AS hours_diff;

-- * 2. Conversions (Seconds / UNIX Epoch)

--   * TIME_TO_SEC(time): `SELECT TIME_TO_SEC('01:30:00');` $\rightarrow$ `5400` seconds.

--   * SEC_TO_TIME(seconds): `SELECT SEC_TO_TIME(5400);` $\rightarrow$ `01:30:00`.

--   * UNIX_TIMESTAMP(date): Converts a date into Unix epoch seconds.

--   * FROM_UNIXTIME(epoch): Converts Unix seconds back to Date.

-- ------------------------------------------------------------
-- E. Formatting Functions
-- ------------------------------------------------------------

-- * English Definition/Properties: Changing the format of a value from one presentation to another (changing how data looks) without changing the actual data value. We do this for data standardization or aggregation.

-- * 1. DATETRUNC() / DATE_TRUNC()

--   * English: Truncates a date to a specific part (like Year or Month), resetting the rest to the lowest value (01 for days/months, 00 for time). 

--     * `DATE_TRUNC()` is available in PostgreSQL and SQL Server. (e.g., `DATE_TRUNC('month', date)` $\rightarrow$ Keeps Year-Month, resets Day to 01).

--     * In MySQL, you achieve this using `DATE_FORMAT(date, '%Y-%m-01')`.

-- * 2. FORMAT() (SQL Server)

--   * English: In SQL Server, `FORMAT(value, format)` is a powerful function to convert Dates or Numbers to formatted strings.

--   * Date Specifiers: `d` (Short date), `D` (Full date), `MMMM` (Full month name), `yyyy` (4-digit year).

--   * Number Specifiers: `N` (Number with commas), `P` (Percentage), `C` (Currency).

--     * `SELECT FORMAT(1234567.89, 'C');` $\rightarrow$ `$1,234,567.89`

-- * 3. DATE_FORMAT() (MySQL)

--   * English: MySQL uses `DATE_FORMAT` to format dates.

--   * Key Format Codes:

--     * `%Y`: 4-digit year (2025)

--     * `%M`: Full month name (September)

--     * `%d`: Day of month with zero (07)

--     * `%W`: Full weekday name (Sunday)

--   * `SELECT DATE_FORMAT('2025-09-03', '%W %M %Y');` $\rightarrow$ `Wednesday September 2025`

-- * 4. STR_TO_DATE() (MySQL)

--   * English: Parses a string into a date. Used to check if a date string is valid and convert it to SQL Date format.

--   * `SELECT STR_TO_DATE('03-09-2025', '%d-%m-%Y');` $\rightarrow$ `2025-09-03`

-- ------------------------------------------------------------
-- F. Data Type Conversion (CAST & CONVERT)
-- ------------------------------------------------------------

-- * 1. CAST(expression AS data_type)

--   * English: Used to convert a value from one data type to another (e.g., String to Number, Datetime to Date). Helps ensure correct formatting and comparison in SQL.

--   * Examples (MySQL):

--     * `SELECT CAST('456' AS SIGNED);` (String to Integer)

--     * `SELECT CAST(NOW() AS DATE);` (Datetime to Date)

-- * 2. CONVERT()

--   * English: In SQL Server, `CONVERT` is used like `CAST` but supports specific format styles. In MySQL, `CONVERT` is primarily used to change the Character Set Encoding (e.g., `SELECT CONVERT('hello' USING utf8mb4);` for Emoji support).

-- ------------------------------------------------------------
-- G. Date Validation & Real-World Use Cases
-- ------------------------------------------------------------

-- * Date Validation (ISDATE)

--   * English: Used to check if a date string is valid. SQL Server uses `ISDATE()`. MySQL doesn't have it, so you use `STR_TO_DATE` with a `CASE` statement (if it returns NULL, it's invalid).

-- * Date Extraction Use Cases (Aggregation & Filtering)

--   * Q1. Find average shipping duration in days for each month:
SELECT MONTHNAME(orderdate) AS OrderMonth, ROUND(AVG(DATEDIFF(shipdate, orderdate))) AS ShippingDurationInDays
FROM orders 
GROUP BY MONTH(orderdate), MONTHNAME(orderdate)
ORDER BY MONTH(orderdate);
--     *(Note: `ROUND()` rounds to nearest integer, `FLOOR()` always rounds down).*

--   * Q2. Find the number of days between each order and the previous order (Using LAG):
-- LAG() is a window function in MySQL 8.0 that gets data from a previous row.
SELECT orderid, orderdate AS CurrentOrderDate, LAG(orderdate) OVER (ORDER BY orderdate) AS PreviousOrderDate,
DATEDIFF(orderdate, LAG(orderdate) OVER (ORDER BY orderdate)) AS NoOfDays FROM orders;

-- ---

-- ======================================================================
-- 🎯 Practice Questions (salesdb sample data) — try first, then look at the answer
-- ======================================================================
-- Run 00-Setup-Sample-Data.sql once before this section.

USE salesdb;

-- Q1. Year, month and day of each order.
SELECT orderid, orderdate, YEAR(orderdate) AS y, MONTH(orderdate) AS m, DAY(orderdate) AS d
FROM orders;

-- Q2. Shipping time in days for each order.
SELECT orderid, DATEDIFF(shipdate, orderdate) AS days_to_ship FROM orders;

-- Q3. Employee age and orders per month (formatted).
SELECT firstname, TIMESTAMPDIFF(YEAR, birthdate, CURDATE()) AS age FROM employees;
SELECT DATE_FORMAT(orderdate, '%Y-%m') AS month, COUNT(*) AS orders_count FROM orders GROUP BY month;
