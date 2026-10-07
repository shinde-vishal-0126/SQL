-- 📘 Part 4: SQL Functions (String, Numeric, Date, NULL, CASE, Window) (Topics 23–26)
-- ======================================================================

-- ---

-- ======================================================================
-- Topic 23: SQL Built-in Functions (String & Numeric)
-- ======================================================================

-- ------------------------------------------------------------
-- 📖 In Simple Words
-- ------------------------------------------------------------

-- * Definition: Built-in functions are ready-made tools that take a value and return a new value: string functions change text (UPPER, LENGTH, TRIM), numeric functions work on numbers (ROUND, ABS).

-- * Real-life example: Kitchen tools: a peeler or a knife changes the vegetable, but the vegetable in the fridge stays the same.

-- * Example on salesdb (run 00-Setup-Sample-Data.sql first):
USE salesdb;
SELECT UPPER(product) AS product_upper,
       LENGTH(product) AS name_length,
       ROUND(price * 1.18, 2) AS price_with_gst
FROM products;

-- * Example explained (step by step):
--   1. UPPER turns "Bottle" into "BOTTLE".
--   2. LENGTH counts letters: "Bottle" → 6.
--   3. ROUND(price * 1.18, 2) adds 18% tax and keeps 2 decimals: 10 → 11.80. The stored data is not changed.

-- ------------------------------------------------------------
-- 23.1 What are SQL Functions?
-- ------------------------------------------------------------

-- * English Definition/Properties: A built-in SQL code that accepts an input value, processes it, and returns an output value. 

-- ------------------------------------------------------------
-- 23.2 Categories of Functions
-- ------------------------------------------------------------

-- * English Definition/Properties: We group functions into two main categories based on how many rows they process at a time:

--   1. Single-Row Functions: You give only one value as input, and it returns a single value as output. (e.g., converting a single name to lowercase).

--   2. Multi-Row Functions (Aggregate): Accepts multiple rows/values as input, summarizes them, and returns a single summarized output. (e.g., `SUM()` of 10 rows returns 1 total).

--   * Single-Row: 1 input ➔ 1 output (`LOWER('MARIA')` ➔ `'maria'`).

-- ------------------------------------------------------------
-- 23.3 Nested Functions
-- ------------------------------------------------------------

-- * English Definition/Properties: A function used inside another function. Multiple functions are nested together in order to manipulate a single value in stages.

-- * Example / Order of Execution: `LENGTH( LOWER( LEFT('Maria', 2) ) )`

--   * 1. `LEFT('Maria', 2)` ➔ `'Ma'`; 2. `LOWER('Ma')` ➔ `'ma'`; 3. `LENGTH('ma')` ➔ `2`.

-- ------------------------------------------------------------
-- 23.4 String Functions (Manipulation & Extraction)
-- ------------------------------------------------------------

--   * Manipulation: `CONCAT`, `UPPER`, `LOWER`, `TRIM`, `REPLACE`.

--   * Extraction: `LEFT`, `RIGHT`, `SUBSTRING`.

-- ------------------------------------------------------------
-- Manipulation Functions
-- ------------------------------------------------------------

-- * 1. CONCAT()

--   * English Definition: Combines multiple strings into one single value.

--   * Q1. Concatenate first name and country into one column with a space:
SELECT FIRSTNAME, COUNTRY, CONCAT(FIRSTNAME, ' ', COUNTRY) AS NAME_COUNTRY FROM CUSTOMERS;

-- * 2. UPPER() & LOWER()

--   * English Definition: `UPPER` converts all characters to uppercase. `LOWER` converts all characters to lowercase.

--   * Q2. Transfer the customer's first name to lowercase and last name to uppercase:
SELECT FIRSTNAME, COUNTRY, LOWER(FIRSTNAME), UPPER(LASTNAME) FROM CUSTOMERS;

-- * 3. TRIM()

--   * English Definition: Removes leading and trailing spaces (empty spaces at the start or end) from the given string.

--   * Q1. Find customers whose name contains leading or trailing spaces (Create a boolean flag 0/1):
SELECT FIRSTNAME, LENGTH(FIRSTNAME), LENGTH(TRIM(FIRSTNAME)) - LENGTH(FIRSTNAME) AS FLAG FROM CUSTOMERS;

--   * ⚠️ Note: This gives 0 or a negative number (e.g. -2), not a clean 0/1 flag. For a 0/1 flag use `FIRSTNAME != TRIM(FIRSTNAME)`.

-- * 4. REPLACE()

--   * English Definition: Replaces a specific character or substring with a new character.

--   * Q1. Remove the '-' from the phone number:
SELECT '123-456-789', REPLACE('123-456-789', '-', ''); -- Output: '123456789'

--   * Q2. Change file extension:
SELECT 'REPORT.TXT', REPLACE('REPORT.TXT', '.TXT', '.CSV'); -- Output: 'REPORT.CSV'

-- ------------------------------------------------------------
-- Calculation & Extraction Functions
-- ------------------------------------------------------------

-- * 5. LENGTH() / LEN()

--   * English Definition: Counts how many characters are in the string. (SQL Server uses `LEN()`, MySQL/pgAdmin use `LENGTH()`).

--   * Q1. Calculate the length of each customer's first name:
SELECT LENGTH(FIRSTNAME) FROM CUSTOMERS;

-- * 6. LEFT() & RIGHT()

--   * English Definition: `LEFT` extracts a specific number of characters from the start. `RIGHT` extracts from the end.

--   * Q1. Retrieve the first two characters of first name and last two of last name:
SELECT LEFT(FIRSTNAME, 2), RIGHT(LASTNAME, 2) FROM CUSTOMERS;

-- * 7. SUBSTRING()

--   * English Definition: `SUBSTRING(value, starting_position, length)` extracts a part of the string starting at a specified position. To get all remaining characters to the end, use `LENGTH()` as the third argument.

--   * Q1. Retrieve a list of customer's first names after removing the first character:
SELECT FIRSTNAME, SUBSTRING(FIRSTNAME, 2, LENGTH(FIRSTNAME)) FROM CUSTOMERS;

-- * 8. LOCATE() / CHARINDEX()

--   * English Definition: Finds the starting position (index) of a substring within a string. `LOCATE()` is for MySQL, while SQL Server uses `CHARINDEX()`.

--   * Interview Use Case: Often used with `SUBSTRING()` to dynamically split strings (e.g., splitting a full name into first and last name using the space index).

--   * Q1. Find the position of '@' in an email address:
SELECT LOCATE('@', 'vishal@gmail.com') AS position; -- Output: 7

-- ------------------------------------------------------------
-- 23.5 Numeric Functions
-- ------------------------------------------------------------

-- * English Definition/Properties: Functions that operate on numeric values for mathematical operations.

--   * `ROUND(3.516, 2)` ➔ 3.52, `ROUND(3.516, 0)` ➔ 4.

-- * 1. ROUND()

--   * English Definition: `ROUND(value, decimals)` rounds the value to the given number of decimal places. If the next digit is 5 or more, it rounds up; otherwise it rounds down.

--   * Example:
SELECT 3.516, ROUND(3.516, 2) AS ROUND2, ROUND(3.516, 1) AS ROUND1, ROUND(3.516, 0) AS ROUND0;
-- Result: 3.516 -> ROUND2: 3.52, ROUND1: 3.5, ROUND0: 4

-- * 2. ABS()

--   * English Definition: Returns the absolute (positive) value of a number, removing any negative sign.

--   * Example:
SELECT ABS(-10), ABS(10);
-- Result: 10, 10

-- * 3. CEILING() / CEIL()

--   * English Definition: Always rounds a number up to the nearest integer.

--   * Example:
SELECT CEILING(4.1), CEILING(4.9);
-- Result: 5, 5

-- * 4. MOD(x, y) / % Operator

--   * English Definition: Returns the remainder of a division operation.

--   * Interview Use Case (Even/Odd Numbers): Very frequently asked in interviews to find even or odd rows.

--   * Q1. Find all even ID numbers and odd ID numbers:
-- Even IDs
SELECT * FROM employees WHERE MOD(id, 2) = 0;
-- Odd IDs
SELECT * FROM employees WHERE MOD(id, 2) = 1;

-- ------------------------------------------------------------
-- 23.6 Pattern Matching with REGEXP (Regular Expressions)
-- ------------------------------------------------------------

-- * `LIKE` only knows `%` and `_`. For richer patterns MySQL has regular expressions: `REGEXP` / `RLIKE` operator and the functions `REGEXP_LIKE()`, `REGEXP_REPLACE()`, `REGEXP_SUBSTR()`, `REGEXP_INSTR()` (MySQL 8.0+).

-- * Common pattern symbols: `^` start, `$` end, `.` any character, `[abc]` one of, `[0-9]` a digit, `+` one or more, `*` zero or more, `{n}` exactly n times, `|` or.

-- * Examples:
-- Names starting with A or M
SELECT first_name FROM customers WHERE first_name REGEXP '^(A|M)';

-- Valid 10-digit Indian mobile numbers (start with 6-9)
SELECT phone FROM customers WHERE phone REGEXP '^[6-9][0-9]{9}$';

-- Simple email check
SELECT email FROM customers WHERE NOT REGEXP_LIKE(email, '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$');

-- Keep only digits in a phone number
SELECT REGEXP_REPLACE('+91-98765 43210', '[^0-9]', '');   -- 919876543210

-- Extract the first number from a text
SELECT REGEXP_SUBSTR('Order #4521 shipped', '[0-9]+');     -- 4521

-- * Performance note: `REGEXP` cannot use an index (like `LIKE '%x'`), so use it on already-filtered rows or for data-quality checks, not as the main filter on a huge table.

-- * String Functions:

-- * Numeric Functions: `ROUND(3.516, 2)` ➔ 3.52, `ABS(-10)` ➔ 10, `CEILING(4.1)` ➔ 5, `MOD(7, 2)` ➔ 1.

-- ---

-- ======================================================================
-- 🎯 Practice Questions (salesdb sample data) — try first, then look at the answer
-- ======================================================================
-- Run 00-Setup-Sample-Data.sql once before this section.

USE salesdb;

-- Q1. String functions: upper-case name, length, and first 3 letters of country.
SELECT UPPER(firstname) AS name_upper, LENGTH(firstname) AS name_len, LEFT(country, 3) AS cc
FROM customers;

-- Q2. Clean data: TRIM and REPLACE on addresses.
SELECT shipaddress, TRIM(shipaddress) AS trimmed, REPLACE(shipaddress, '.', '') AS no_dots
FROM orders
WHERE shipaddress IS NOT NULL;

-- Q3. Numeric functions: price with 10% tax, rounded; and sales / quantity.
SELECT product, price, ROUND(price * 1.10, 2) AS with_tax, ABS(price - 20) AS diff_from_20
FROM products;
