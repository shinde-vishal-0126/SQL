-- ======================================================================
-- Topic 24: Date and Time Functions
-- ======================================================================

-- ------------------------------------------------------------
-- 📖 In Simple Words
-- ------------------------------------------------------------

-- * Definition: Date and time functions read parts of a date (year, month, day), add or subtract time, find the difference between dates and format dates as text.

-- * Real-life example: Like a calendar app: "what month is it?", "how many days until delivery?".

-- * Example on salesdb (run 00-Setup-Sample-Data.sql first):
SET search_path TO sales;
SELECT orderid, orderdate, shipdate,
       EXTRACT(MONTH FROM orderdate) AS order_month,
       shipdate - orderdate AS days_to_ship
FROM orders;

-- * Example explained (step by step):
--   1. order_month takes the month number from orderdate (1 = January).
--   2. days_to_ship = shipdate minus orderdate in days.
--   3. Example: order 3 was ordered on 10 Jan and shipped on 25 Jan → 15 days.

-- ------------------------------------------------------------
-- 24.1 Anatomy of Date & Time
-- ------------------------------------------------------------

-- * English Definition/Properties: A Date typically contains Year, Month, and Day. A Time contains Hours, Minutes, and Seconds. A Timestamp combines both. PostgreSQL also has `INTERVAL` — a length of time (e.g., `3 days 04:00:00`).

--   * DATE = Year-Month-Day (`2025-08-20`); TIME = Hour:Min:Sec (`18:55:45`).

-- ------------------------------------------------------------
-- 24.2 Sources of Dates (How to Query Dates)
-- ------------------------------------------------------------

-- * English Definition/Properties: We have three main sources to get dates in SQL:

--   1. From a Table Column: Fetching stored dates. (e.g., `SELECT hire_date FROM customers;`)

--   2. Hardcoded Constant String: Providing a static date directly in the query. In PostgreSQL a plain `'2025-08-20'` is just text until it is used as a date, so write it as a typed literal: `SELECT DATE '2025-08-20' AS new_date;` or `SELECT '2025-08-20'::DATE;`

--   3. System Current Date/Time Functions: Using built-in functions like `GETDATE()` (SQL Server) or `now()` / `CURRENT_TIMESTAMP` / `CURRENT_DATE` (PostgreSQL).

-- * 🐘 `::` is PostgreSQL's short cast operator: `'2025-08-20'::DATE` = `CAST('2025-08-20' AS DATE)`.

-- ------------------------------------------------------------
-- 24.3 Overview of Built-in Date/Time Functions (PostgreSQL focus)
-- ------------------------------------------------------------

--   * Part Extraction: MySQL `YEAR()`, `MONTH()`, `DAY()` ➔ PostgreSQL `EXTRACT(YEAR FROM d)` / `DATE_PART('year', d)`. Formatting: `DATE_FORMAT()` ➔ `TO_CHAR()`, `STR_TO_DATE()` ➔ `TO_DATE()` / `TO_TIMESTAMP()`, `CAST()` / `::`.

--   * Calculations: `DATE_ADD()` / `DATE_SUB()` ➔ `+ INTERVAL '...'` / `- INTERVAL '...'`, `DATEDIFF()` ➔ `date2 - date1` / `AGE()`. Source: `now()`, `CURRENT_DATE`.

--   * `DATEPART` ➔ INT, `DATENAME` ➔ STRING, `DATETRUNC` ➔ DATETIME, `EOMONTH` ➔ DATE.

-- ------------------------------------------------------------
-- Quick Map: MySQL → PostgreSQL Date Functions
-- ------------------------------------------------------------

-- | Task | MySQL | PostgreSQL |
-- | :--- | :--- | :--- |
-- | Current date + time | `NOW()` | `now()` / `CURRENT_TIMESTAMP` |
-- | Current date | `CURDATE()` | `CURRENT_DATE` |
-- | Current time | `CURTIME()` | `CURRENT_TIME` / `LOCALTIME` |
-- | Year / month / day | `YEAR(d)`, `MONTH(d)`, `DAY(d)` | `EXTRACT(YEAR FROM d)` / `DATE_PART('year', d)` |
-- | Day / month name | `DAYNAME(d)`, `MONTHNAME(d)` | `TO_CHAR(d, 'FMDay')`, `TO_CHAR(d, 'FMMonth')` |
-- | Add 10 days | `DATE_ADD(d, INTERVAL 10 DAY)` | `d + INTERVAL '10 days'` (or `d + 10` for a DATE) |
-- | Subtract 2 months | `DATE_SUB(d, INTERVAL 2 MONTH)` | `d - INTERVAL '2 months'` |
-- | Days between | `DATEDIFF(d2, d1)` | `d2 - d1` (DATE minus DATE = integer days) |
-- | Years between (age) | `TIMESTAMPDIFF(YEAR, b, NOW())` | `EXTRACT(YEAR FROM AGE(now(), b))` |
-- | First day of month | `DATE_FORMAT(d, '%Y-%m-01')` | `DATE_TRUNC('month', d)` |
-- | Last day of month | `LAST_DAY(d)` | `(DATE_TRUNC('month', d) + INTERVAL '1 month - 1 day')::DATE` |
-- | Format date as text | `DATE_FORMAT(d, '%d-%m-%Y')` | `TO_CHAR(d, 'DD-MM-YYYY')` |
-- | Text to date | `STR_TO_DATE('03-09-2025', '%d-%m-%Y')` | `TO_DATE('03-09-2025', 'DD-MM-YYYY')` |
-- | Unix seconds | `UNIX_TIMESTAMP(d)` / `FROM_UNIXTIME(n)` | `EXTRACT(EPOCH FROM d)` / `TO_TIMESTAMP(n)` |

-- ------------------------------------------------------------
-- A. Current Date & Time Functions
-- ------------------------------------------------------------

-- * 1. now() & CURRENT_TIMESTAMP

--   * English: Return the current date and time with time zone (`TIMESTAMPTZ`). Both give the time when the transaction started — the value stays the same for the whole transaction. Use `clock_timestamp()` for the real current moment.

--   * Example: `SELECT now();` $\rightarrow$ `2025-09-03 13:30:20.123456+05:30`

--   * Without time zone: `SELECT LOCALTIMESTAMP;` $\rightarrow$ `2025-09-03 13:30:20.123456`

-- * 2. CURRENT_DATE

--   * English: Returns only the current Date (no time). Note: no brackets — `CURRENT_DATE`, not `CURRENT_DATE()`. (MySQL: `CURDATE()`.)

--   * Example: `SELECT CURRENT_DATE;` $\rightarrow$ `2025-09-03`

--   * UTC date: `SELECT (now() AT TIME ZONE 'UTC')::DATE;`

-- * 3. CURRENT_TIME / LOCALTIME

--   * English: Returns only the current Time (no date). `CURRENT_TIME` includes the time zone offset; `LOCALTIME` does not. (MySQL: `CURTIME()`.)

-- ------------------------------------------------------------
-- B. Extracting Parts of a Date
-- ------------------------------------------------------------

-- * English Definition/Properties: You can extract specific parts like year, month, or day from a full date/time. PostgreSQL uses the SQL-standard `EXTRACT(field FROM source)` or `DATE_PART('field', source)`. There are no separate `YEAR()` / `MONTH()` functions.

-- * Examples:

--   * Year: `SELECT EXTRACT(YEAR FROM DATE '2025-09-03');` $\rightarrow$ `2025`

--   * Month: `SELECT EXTRACT(MONTH FROM DATE '2025-09-03');` $\rightarrow$ `9`

--   * Day: `SELECT EXTRACT(DAY FROM DATE '2025-09-03');` $\rightarrow$ `3`

--   * Hour: `SELECT EXTRACT(HOUR FROM TIME '13:45:59');` $\rightarrow$ `13`

--   * Minute: `SELECT EXTRACT(MINUTE FROM TIME '13:45:59');` $\rightarrow$ `45`

--   * Second: `SELECT EXTRACT(SECOND FROM TIME '13:45:59');` $\rightarrow$ `59`

--   * Microseconds: `SELECT EXTRACT(MICROSECONDS FROM TIMESTAMP '2025-09-03 13:45:59.123456');` $\rightarrow$ `59123456` (includes the seconds × 1,000,000)

--   * Day of week: `SELECT EXTRACT(DOW FROM DATE '2025-09-03');` $\rightarrow$ `3` (0 = Sunday, 6 = Saturday). `ISODOW` gives 1 = Monday … 7 = Sunday. (MySQL `DAYOFWEEK` uses 1 = Sunday.)

--   * Day of year: `SELECT EXTRACT(DOY FROM DATE '2025-09-03');` $\rightarrow$ `246` (1 to 366)

--   * Week: `SELECT EXTRACT(WEEK FROM DATE '2025-09-03');` $\rightarrow$ `36` (ISO week number; MySQL `WEEK()` uses a different rule, so numbers can differ)

--   * Quarter: `SELECT EXTRACT(QUARTER FROM DATE '2025-09-03');` $\rightarrow$ `3` (1-4)

--   * Day name / Month name (`TO_CHAR`)

--     * English: In SQL Server, `DATENAME(part, date)` returns the name of a part as a string. PostgreSQL has no `DATENAME` / `DAYNAME`; use `TO_CHAR(date, 'Day')` and `TO_CHAR(date, 'Month')`. The `FM` prefix removes the extra spaces PostgreSQL adds to pad names to 9 characters. Short names: `'Dy'` → `Wed`, `'Mon'` → `Aug`.

--   * Last day of month (MySQL `LAST_DAY()`, SQL Server `EOMONTH()`)

--     * English: Returns the last day of the month for the given date. In PostgreSQL: `(DATE_TRUNC('month', d) + INTERVAL '1 month - 1 day')::DATE`. The first day of the month is simply `DATE_TRUNC('month', d)::DATE`.

-- * Q1. Extract multiple parts from a table:
SELECT creationtime,
       EXTRACT(YEAR  FROM creationtime) AS year,
       EXTRACT(MONTH FROM creationtime) AS month,
       EXTRACT(DAY   FROM creationtime) AS day,
       TO_CHAR(creationtime, 'FMDay')   AS dayname
FROM orders;

-- * Note: `EXTRACT` returns a `NUMERIC` value (e.g., `2025`). Cast with `::INT` if you need an integer.

-- ------------------------------------------------------------
-- C. Date/Time Manipulation (Adding & Subtracting with INTERVAL)
-- ------------------------------------------------------------

-- * English Definition: You can add or subtract time intervals (days, months, hours) to/from a specific date. PostgreSQL has no `DATE_ADD` / `DATE_SUB`; you use the `+` and `-` operators with an `INTERVAL`.

-- * 1. Add (`+ INTERVAL`)

--   * `SELECT DATE '2025-09-03' + INTERVAL '10 days';` $\rightarrow$ `2025-09-13 00:00:00` (result is a timestamp)

--   * DATE + integer = DATE: `SELECT DATE '2025-09-03' + 10;` $\rightarrow$ `2025-09-13`

-- * 2. Subtract (`- INTERVAL`)

--   * `SELECT DATE '2025-09-03' - INTERVAL '2 months';` $\rightarrow$ `2025-07-03 00:00:00`

--   * Keep it a DATE: `SELECT (DATE '2025-09-03' - INTERVAL '2 months')::DATE;` $\rightarrow$ `2025-07-03`

-- * 3. Time arithmetic

--   * `SELECT TIME '10:00:00' + INTERVAL '2 hours 30 minutes';` $\rightarrow$ `12:30:00` (MySQL: `ADDTIME`)

--   * Multiply an interval: `SELECT INTERVAL '1 day' * 7;` $\rightarrow$ `7 days`

--   * Interval from a column: `SELECT order_date + (delivery_days || ' days')::INTERVAL FROM orders;` or simply `order_date + delivery_days` when it is a `DATE` and an integer. PostgreSQL 14+: `make_interval(days => delivery_days)`.

-- * 4. Generate a list of dates (PostgreSQL extra)

--   * `generate_series` creates rows — very useful for calendars and reports with no missing days:
SELECT d::DATE AS day
FROM generate_series(DATE '2025-09-01', DATE '2025-09-07', INTERVAL '1 day') AS d;

-- ------------------------------------------------------------
-- D. Differences & Conversion
-- ------------------------------------------------------------

-- * 1. Date difference: `-` operator and `AGE()`

--   * English: Used to find the difference between two dates.

--     * In SQL Server: `DATEDIFF(interval, start_date, end_date)` counts boundaries crossed (Aug → Feb = 6 months).

--     * In PostgreSQL:

--       * `date2 - date1` (both `DATE`) → whole number of days. (MySQL: `DATEDIFF(d2, d1)`.)

--       * `timestamp2 - timestamp1` → an `INTERVAL` like `1 day 02:30:00`.

--       * `AGE(later, earlier)` → interval in years, months and days (`2 years 3 mons 5 days`). `AGE(d)` alone = age from `d` until today.

--       * Total hours/minutes: `EXTRACT(EPOCH FROM (t2 - t1)) / 3600` (EPOCH = seconds).

--   * Q1. Calculate the Age of the Employee (Difference in Years):
SELECT firstname, lastname,
       EXTRACT(YEAR FROM AGE(CURRENT_DATE, birthdate)) AS age
FROM employees;

--   * Difference in Hours/Minutes:
SELECT EXTRACT(EPOCH FROM (TIMESTAMP '2025-09-28 12:30:00' - TIMESTAMP '2025-09-27 10:00:00')) / 3600 AS hours_diff;
-- 26.5

-- * 2. Conversions (Seconds / UNIX Epoch)

--   * Interval/time to seconds: `SELECT EXTRACT(EPOCH FROM INTERVAL '01:30:00');` $\rightarrow$ `5400` seconds. (MySQL: `TIME_TO_SEC`.)

--   * Seconds to time: `SELECT make_interval(secs => 5400);` $\rightarrow$ `01:30:00` (or `5400 * INTERVAL '1 second'`). (MySQL: `SEC_TO_TIME`.)

--   * Date to Unix epoch seconds: `SELECT EXTRACT(EPOCH FROM TIMESTAMPTZ '2025-09-03 00:00:00+00');` (MySQL: `UNIX_TIMESTAMP`.)

--   * Unix seconds back to date: `SELECT TO_TIMESTAMP(1756857600);` (MySQL: `FROM_UNIXTIME`.)

-- ------------------------------------------------------------
-- E. Formatting Functions
-- ------------------------------------------------------------

-- * English Definition/Properties: Changing the format of a value from one presentation to another (changing how data looks) without changing the actual data value. We do this for data standardization or aggregation.

-- * 1. DATE_TRUNC()

--   * English: Truncates a date to a specific part (like year, quarter, month, week, day, hour), resetting the rest to the lowest value.

--     * `DATE_TRUNC('month', d)` → keeps Year-Month, resets Day to 01 and time to 00:00:00.

--     * Perfect for monthly reports: `GROUP BY DATE_TRUNC('month', order_date)`.

--   * Example:
SELECT DATE_TRUNC('month', order_date) AS month, SUM(sales) AS total_sales
FROM orders
GROUP BY DATE_TRUNC('month', order_date)
ORDER BY month;

-- * 2. FORMAT() (SQL Server) vs TO_CHAR() for numbers (PostgreSQL)

--   * English: In SQL Server, `FORMAT(value, format)` converts dates or numbers to formatted strings. PostgreSQL's `FORMAT()` is different — it builds strings like `printf` (`FORMAT('Hello %s', name)`). For number formatting use `TO_CHAR`.

--   * Number patterns in `TO_CHAR`: `9` (digit), `0` (digit with leading zero), `,` (thousands separator), `.` (decimal point), `FM` (remove padding), `L` (currency symbol).

--   * Examples:

--     * `SELECT TO_CHAR(1234567.89, 'FM9,999,999.00');` $\rightarrow$ `1,234,567.89`

--     * `SELECT '₹' || TO_CHAR(1234567.89, 'FM99,99,99,999.00');` $\rightarrow$ `₹12,34,567.89` (Indian grouping)

-- * 3. TO_CHAR() for dates (MySQL: DATE_FORMAT)

--   * English: PostgreSQL uses `TO_CHAR(date, pattern)` to format dates.

--   * Key Format Codes (PostgreSQL vs MySQL):

--     * `YYYY`: 4-digit year (2025) — MySQL `%Y`

--     * `Month` / `FMMonth`: Full month name (September) — MySQL `%M`

--     * `MM`: Month number with zero (09) — MySQL `%m`

--     * `DD`: Day of month with zero (07) — MySQL `%d`

--     * `Day` / `FMDay`: Full weekday name (Sunday) — MySQL `%W`

--     * `HH24:MI:SS`: 24-hour time — MySQL `%H:%i:%s`

--     * `HH12 AM`: 12-hour time with AM/PM — MySQL `%h %p`

--   * `SELECT TO_CHAR(DATE '2025-09-03', 'FMDay FMMonth YYYY');` $\rightarrow$ `Wednesday September 2025`

--   * `SELECT TO_CHAR(now(), 'DD/MM/YYYY HH24:MI');` $\rightarrow$ `03/09/2025 13:30`

-- * 4. TO_DATE() / TO_TIMESTAMP() (MySQL: STR_TO_DATE)

--   * English: Parses a string into a date using a pattern.

--   * `SELECT TO_DATE('03-09-2025', 'DD-MM-YYYY');` $\rightarrow$ `2025-09-03`

--   * `SELECT TO_TIMESTAMP('03-09-2025 14:05', 'DD-MM-YYYY HH24:MI');` $\rightarrow$ `2025-09-03 14:05:00+05:30`

--   * ⚠️ For an impossible date like `'31-02-2025'`, PostgreSQL raises an error (`date/time field value out of range`) instead of returning NULL like MySQL.

-- ------------------------------------------------------------
-- F. Data Type Conversion (CAST & ::)
-- ------------------------------------------------------------

-- * 1. CAST(expression AS data_type) and `::`

--   * English: Used to convert a value from one data type to another (e.g., String to Number, Timestamp to Date). Helps ensure correct comparison in SQL. PostgreSQL is strict, so you need casts more often than in MySQL.

--   * Examples (PostgreSQL):

--     * `SELECT CAST('456' AS INTEGER);` or `SELECT '456'::INT;` (String to Integer — MySQL uses `SIGNED`)

--     * `SELECT CAST(now() AS DATE);` or `SELECT now()::DATE;` (Timestamp to Date)

--     * `SELECT 'abc'::INT;` → ERROR: invalid input syntax for type integer (MySQL would return 0 with a warning)

-- * 2. CONVERT()

--   * English: SQL Server uses `CONVERT` like `CAST` with format styles. PostgreSQL has no general `CONVERT`; use `CAST` / `::` for types, `TO_CHAR` for formatting, and `convert_to(text, 'UTF8')` / `convert_from(bytea, 'UTF8')` for encodings. PostgreSQL databases are usually `UTF8`, which already supports emoji.

-- ------------------------------------------------------------
-- G. Date Validation & Real-World Use Cases
-- ------------------------------------------------------------

-- * Date Validation (ISDATE)

--   * English: Used to check if a date string is valid. SQL Server uses `ISDATE()`. In PostgreSQL 16+ use `pg_input_is_valid(text, 'date')`. On older versions, write a small PL/pgSQL function that tries the cast and catches the error.

-- * Date Extraction Use Cases (Aggregation & Filtering)

--   * Q1. Find average shipping duration in days for each month:
SELECT TO_CHAR(orderdate, 'FMMonth') AS order_month,
       ROUND(AVG(shipdate - orderdate)) AS shipping_duration_in_days
FROM orders
GROUP BY EXTRACT(MONTH FROM orderdate), TO_CHAR(orderdate, 'FMMonth')
ORDER BY EXTRACT(MONTH FROM orderdate);
--     (Note: `shipdate - orderdate` gives days when both are `DATE`. `ROUND()` rounds to nearest integer, `FLOOR()` always rounds down.)

--   * Q2. Find the number of days between each order and the previous order (Using LAG):
-- LAG() is a window function that gets data from a previous row.
SELECT orderid,
       orderdate AS current_order_date,
       LAG(orderdate) OVER (ORDER BY orderdate) AS previous_order_date,
       orderdate - LAG(orderdate) OVER (ORDER BY orderdate) AS no_of_days
FROM orders;

--   * Q3. Orders of the last 30 days (index-friendly — don't wrap the column in a function):
SELECT * FROM orders
WHERE orderdate >= CURRENT_DATE - INTERVAL '30 days';

-- * MySQL vs PostgreSQL: `NOW()` = `now()`, `CURDATE()` = `CURRENT_DATE`, `YEAR()` = `EXTRACT(YEAR FROM)`, `DAYNAME()` = `TO_CHAR(d,'FMDay')`, `DATE_ADD` = `+ INTERVAL`, `DATEDIFF` = `-`, `TIMESTAMPDIFF(YEAR…)` = `AGE()`, `LAST_DAY` = `DATE_TRUNC + INTERVAL '1 month - 1 day'`, `DATE_FORMAT` = `TO_CHAR`, `STR_TO_DATE` = `TO_DATE`.

-- ---

-- ======================================================================
-- 🎯 Practice Questions (salesdb sample data) — try first, then look at the answer
-- ======================================================================
-- Run 00-Setup-Sample-Data.sql once before this section.

SET search_path TO sales;

-- Q1. Year, month and day of each order.
SELECT orderid, orderdate, EXTRACT(YEAR FROM orderdate) AS y, EXTRACT(MONTH FROM orderdate) AS m, EXTRACT(DAY FROM orderdate) AS d
FROM orders;

-- Q2. Shipping time in days for each order.
SELECT orderid, shipdate - orderdate AS days_to_ship FROM orders;

-- Q3. Employee age and orders per month (formatted).
SELECT firstname, EXTRACT(YEAR FROM age(birthdate)) AS age FROM employees;
SELECT TO_CHAR(orderdate, 'YYYY-MM') AS month, COUNT(*) AS orders_count FROM orders GROUP BY month;
