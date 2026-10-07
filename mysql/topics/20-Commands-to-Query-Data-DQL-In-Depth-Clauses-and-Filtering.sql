-- 📘 Part 3: Querying & Combining Data (Clauses, Joins, SET Operators) (Topics 20–22)
-- ======================================================================

-- ---

-- ======================================================================
-- Topic 20: Commands to Query Data (DQL In-Depth, Clauses & Filtering)
-- ======================================================================

-- ------------------------------------------------------------
-- 📖 In Simple Words
-- ------------------------------------------------------------

-- * Definition: Query clauses tell SELECT what to read and how: FROM (table), WHERE (filter rows), GROUP BY (make groups), HAVING (filter groups), ORDER BY (sort), LIMIT (how many).

-- * Real-life example: Like filters on a shopping site: category, price range, sort by price, show top 10.

-- * Example on salesdb (run 00-Setup-Sample-Data.sql first):
USE salesdb;
SELECT customerid, SUM(sales) AS total_sales
FROM orders
WHERE orderstatus = 'Delivered'
GROUP BY customerid
HAVING SUM(sales) > 20
ORDER BY total_sales DESC;

-- * Example explained (step by step):
--   1. WHERE keeps only delivered orders.
--   2. GROUP BY customerid makes one group per customer, SUM(sales) adds up each group.
--   3. HAVING keeps groups above 20, ORDER BY sorts biggest first.
--   4. Result: customers 1 and 3 → 50 each, customer 2 → 35.

-- ------------------------------------------------------------
-- 20.1 Commands to Query Data & What is DQL?
-- ------------------------------------------------------------

-- * Definition: DQL (Data Query Language) is used to search and read data from tables, without changing the data or the table structure.

--   * It can read from one table or combine many tables.

--   * The primary and fundamental command of DQL is **`SELECT`**.

-- * Key Characteristics of DQL:

--   * 1. Read-Only Nature: DQL only reads, filters and shapes data in memory; it never inserts, changes or deletes data on disk.

--   * 2. Tabular Result Set (Virtual Table): Every `SELECT` query returns rows and columns, called a Result Set (a temporary table shown to you).

--   * 3. Extreme Flexibility: Can retrieve everything, target specific columns, filter rows (`WHERE`), eliminate duplicates (`DISTINCT`), limit row count (`LIMIT` / `TOP`), sort results (`ORDER BY`), aggregate metrics (`GROUP BY`, `COUNT`, `SUM`), filter aggregates (`HAVING`), and combine multiple related tables (`JOIN`).

-- ---

-- ------------------------------------------------------------
-- 20.2 The Core Mental Model: "Ask Your Data"
-- ------------------------------------------------------------

--   * 1. The Business Question: A user or application needs specific information (e.g., "Who are our customers from Germany?" or "What is the total sales for this month?").

--   * 2. The SQL Query: The question is translated into a structured SQL statement (`SELECT name, country FROM customers WHERE country = 'Germany';`).

--   * 3. Database Processing: The Database Management System (DBMS) locates the target table on disk, reads data blocks into memory, applies the filtering criteria, and keeps only the requested columns.

--   * 4. The Result (Answer): The engine returns a clean, structured tabular result set back to the user's screen or application API.

-- ---

-- ------------------------------------------------------------
-- 20.3 Commands (to query the data) & Essential Database/Table Setup
-- ------------------------------------------------------------

-- Before executing data queries, you need an active database context and a populated table:

-- ------------------------------------------------------------
-- 1. Show All Databases
-- ------------------------------------------------------------

-- * Concept: `show all databases`

-- * SQL Command:
Show databases;

-- * Meaning: Lists all existing databases currently hosted on the MySQL server instance.

-- ------------------------------------------------------------
-- 2. Create Database (`my_db`)
-- ------------------------------------------------------------

-- * Concept: `create database db_name`

-- * SQL Command:
Create database my_db;

-- * Meaning: Allocates a new logical database container named `my_db`.

-- ------------------------------------------------------------
-- 3. Use Selected Database
-- ------------------------------------------------------------

-- * Concept: `used selected database`

-- * SQL Command:
Use my_db ;

-- * Meaning: Switches the active session context to `my_db`. All subsequent table operations and queries run inside this selected database.

-- ------------------------------------------------------------
-- 4. Drop Database (`my_db`)
-- ------------------------------------------------------------

-- * Concept: `delete database db_name`

-- * SQL Command:
Drop database my_db;

-- * Meaning: Permanently deletes the database `my_db` along with all its tables, views, and data.

-- ------------------------------------------------------------
-- 5. Generic Table Creation Syntax
-- ------------------------------------------------------------

-- * Raw syntax (from my notes):
Create table user(column1 int notNull, column1 datatype constraint. column1 datatype constrain,....);

-- * ⚠️ Note: The raw syntax above has typos (`notNull` → `NOT NULL`, `.` → `,`, `column1` repeated). Use the formatted version below.

-- * Formatted General Blueprint:
CREATE TABLE user (
    column1 INT NOT NULL,
    column2 datatype constraint,
    column3 datatype constraint,
    ...
);

-- ------------------------------------------------------------
-- 6. Common MySQL Data Types & Attributes: The Golden Rule
-- ------------------------------------------------------------

-- * Common mySql data types & entity modeling:

-- * Inside table we have attribute:

--   * So defined that attribute we need to data type to define that attribute.

--   * In relational databases, each column represents a property or attribute (e.g., `first_name`, `dob`, `phone`, `email`).

-- * ⭐ Data types applied on the column not row:

--   * Golden Rule: Data types applied on the column not row.

--   * Every cell within a given column must strictly conform to that column's declared data type and constraints across all rows.

-- ------------------------------------------------------------
-- 7. Create Table in DB Using Following Command:
-- ------------------------------------------------------------

-- * Create table in db using following command:
CREATE TABLE Customer (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100),
    dob DATE,
    gender CHAR(1),
    phone VARCHAR(15),
    email VARCHAR(100),
    address VARCHAR(255),
    branch_id INT,
    FOREIGN KEY (branch_id) REFERENCES Branch(branch_id)
);

-- * ⚠️ Note: This table has a `FOREIGN KEY` to `Branch(branch_id)`, so the `Branch` table must be created first, otherwise MySQL gives an error.

-- * Schema Highlights:

--   * `customer_id INT PRIMARY KEY AUTO_INCREMENT`: Unique identifier for each customer that increments automatically.

--   * `first_name VARCHAR(100) NOT NULL`: Mandatory customer first name.

--   * `dob DATE`: Date of birth formatted as `YYYY-MM-DD`.

--   * `gender CHAR(1)`: Single-character code (`'M'`, `'F'`).

--   * `branch_id INT`: Foreign key linking customer to the `Branch` table.

-- ------------------------------------------------------------
-- 8. Insert Data into Table Like:
-- ------------------------------------------------------------

-- * Insert data into table like:
INSERT INTO Customer (first_name, last_name, dob, gender, phone, email, address, branch_id) VALUES
('Amit', 'Sharma', '1985-06-15', 'M', '9876543210', 'amit.sharma@example.com', 'Andheri, Mumbai', 1),
('Priya', 'Singh', '1990-08-22', 'F', '9123456780', 'priya.singh@example.com', 'Salt Lake, Kolkata', 2);

-- ------------------------------------------------------------
-- 9. Querying Data from the Database:
-- ------------------------------------------------------------

-- * Raw note: `Select * form the databaseName;` (correct keyword is `FROM`, and you select from a table, not a database)
-- Querying within active database:
SELECT * FROM Customer;

-- Querying using fully-qualified databaseName.tableName syntax:
SELECT * FROM my_db.Customer;

-- ------------------------------------------------------------
-- 10. Select Top Number of Data (Top-Most Data)
-- ------------------------------------------------------------

-- * Select only the top N rows (top-most data):
SELECT `OrderID` FROM `ORDERS` LIMIT 2;

-- * Explanation:

--   * Fetches only the first 2 rows matching the query.

--   * In SQL Server / MS Access, the equivalent keyword is `SELECT TOP 2 OrderID FROM ORDERS;`.

--   * In MySQL, PostgreSQL, and SQLite, **`LIMIT`** is the standard syntax.

-- ---

-- ------------------------------------------------------------
-- 20.4 SQL Query Clauses (The 9 Building Blocks)
-- ------------------------------------------------------------

-- * Q. What are the main clauses of an SQL query?

-- * The 9 Building Blocks of SQL Queries:

-- | # | Clause | Syntax Keyword | Core Purpose & Action |
-- | :--- | :--- | :--- | :--- |
-- | 1 | Projection | `SELECT` | Specifies which columns (attributes) to retrieve and display in the result set. |
-- | 2 | Deduplication | `DISTINCT` | Eliminates duplicate identical rows from the query output. |
-- | 3 | Row Restriction | `TOP` / `LIMIT` | Restricts the maximum number of rows returned (`LIMIT n`). |
-- | 4 | Data Source | `FROM` | Identifies the table(s) from which data must be extracted. |
-- | 5 | Relationship | `JOIN` | Merges rows from two or more tables based on related foreign key columns. |
-- | 6 | Row Filtering | `WHERE` | Filters rows based on individual boolean conditions (predicates). |
-- | 7 | Aggregation | `GROUP BY` | Groups rows sharing identical values into summary rows (e.g., per department). |
-- | 8 | Group Filtering| `HAVING` | Filters summarized groups created by `GROUP BY` using aggregate functions. |
-- | 9 | Sorting | `ORDER BY` | Sorts the final result rows in ascending (`ASC`) or descending (`DESC`) order. |

-- ---

-- ------------------------------------------------------------
-- 20.5 How SQL Works: Written Syntax (Left to Right) vs. Engine Execution Order
-- ------------------------------------------------------------

-- * How we write vs. how it runs:

--   * When writing an SQL query, the human developer types from left to right:
--     $$\text{SELECT} \longrightarrow \text{FROM} \longrightarrow \text{WHERE} \longrightarrow \text{GROUP BY} \longrightarrow \text{HAVING} \longrightarrow \text{ORDER BY} \longrightarrow \text{LIMIT}$$

--   * HOWEVER, inside the database management engine, SQL queries are NOT physically executed from left to right!

--   * The SQL execution engine follows a strict, logical pipeline order:

-- ┌── (mermaid — not SQL, shown for reference) ──
-- │ flowchart TD
-- │     A["<b>Step 1: FROM</b><br/>Locates and loads source table(s)"] --> B["<b>Step 2: WHERE</b><br/>Filters rows through a condition funnel"]
-- │     B --> C["<b>Step 3: GROUP BY & HAVING</b><br/>Aggregates rows and filters summary groups"]
-- │     C --> D["<b>Step 4: SELECT</b><br/>Evaluates expressions and projects requested columns"]
-- │     D --> E["<b>Step 5: DISTINCT</b><br/>Removes duplicate rows"]
-- │     E --> F["<b>Step 6: ORDER BY</b><br/>Sorts rows ascending or descending"]
-- │     F --> G["<b>Step 7: LIMIT / TOP</b><br/>Restricts total number of rows returned"]
-- │ 
-- │     style A fill:#0284c7,stroke:#38bdf8,stroke-width:2px,color:#fff
-- │     style B fill:#d97706,stroke:#fbbf24,stroke-width:2px,color:#fff
-- │     style C fill:#475569,stroke:#94a3b8,stroke-width:2px,color:#fff
-- │     style D fill:#059669,stroke:#34d399,stroke-width:2px,color:#fff
-- │     style E fill:#475569,stroke:#94a3b8,stroke-width:2px,color:#fff
-- │     style F fill:#7c3aed,stroke:#a78bfa,stroke-width:2px,color:#fff
-- │     style G fill:#0f172a,stroke:#e2e8f0,stroke-width:2px,color:#fff
-- └──

-- * **Why does `FROM` run first?**

--   * The database engine cannot know what columns or conditions exist until it first opens and identifies the source table! Therefore, `FROM` is always step #1.

-- ---

-- ------------------------------------------------------------
-- 20.6 Select Query / Data Retrieve Query: `SELECT *` vs. `SELECT column_name`
-- ------------------------------------------------------------

-- * Select query — two ways to read data:

--   * `Select * form` → correct spelling: `SELECT * FROM ...`

-- * Data retrieval queries:

--   * 1. Select * from tableName:

--     * Gets all columns — everything from the given table.

--   * 2. Select column name:

--     * Gets only the columns you name.

-- ------------------------------------------------------------
-- 1. Method ①: Select * from tableName
-- ------------------------------------------------------------

-- * Concept: Get all columns from the table — "Keep All Columns!".

-- * Syntax:
SELECT * FROM tableName;

-- * Step-by-Step Execution:

--   * **Step ① (`FROM Table`):** Tells SQL where to find your data.

--   * **Step ② (`SELECT *`):** The asterisk (`*`) is a wildcard that instructs the engine to keep all columns defined in the table.

-- * Q1. Retrieve all data from the customers table and the orders table.
SELECT * FROM customers;
SELECT * FROM orders;

-- ------------------------------------------------------------
-- 2. Method ②: Select column name
-- ------------------------------------------------------------

-- * Concept: Get only the columns you need — "Keep only needed columns".

-- * Syntax:
SELECT column1, column2, column3 FROM tableName;

-- * Step-by-Step Execution:

--   * **Step ① (`FROM Table`):** Locates table in the database.

--   * **Step ② (`SELECT col1, col2`):** Extracts and projects only the designated attributes, ignoring unnecessary columns.

-- * Q2. Retrieve each customer name, country, and score
SELECT first_name, country, score FROM customers;

-- ------------------------------------------------------------
-- 3. Comparison: `SELECT *` vs. Specific Column Projection
-- ------------------------------------------------------------

-- | Dimension | `SELECT *` (All Columns) | `SELECT col1, col2` (Specific Projection) |
-- | :--- | :--- | :--- |
-- | Data Returned | Returns 100% of columns in table | Returns only explicitly requested columns |
-- | Network Payload | High byte size; transfers unneeded data | Minimal byte size; transfers only required data |
-- | Performance | Slower over network; disk page scanning | Faster; can leverage memory Covering Indexes |
-- | Best Used For | Ad-hoc queries, debugging, schema exploration | Production code, web APIs, microservices, reporting |

-- ---

-- ------------------------------------------------------------
-- 20.7 Filtering Data & The WHERE Clause In-Depth
-- ------------------------------------------------------------

-- * Filtering Data (The WHERE Clause):

--   * In databases, filtering means retrieving only the rows (records) that match specific conditions instead of fetching everything.

--   * The WHERE clause is used to filter data using different types of operators.

--   * Core Definition: Filtering = Applying boolean conditions (predicates) to select only the rows you need from a database table.

--   * The `WHERE` clause acts as a sieve / gatekeeper: it evaluates a boolean test for every single row in the source table.

--     * If the condition evaluates to **`TRUE`, the row is **kept and moves to the next execution stage.

--     * If the condition evaluates to **`FALSE`** or **`UNKNOWN`** (involving `NULL`), the row is discarded.

-- ---

-- ------------------------------------------------------------
-- 20.7.1 The 5 Families of WHERE Clause Operators
-- ------------------------------------------------------------

-- * The `WHERE` clause filters data using 5 specialized families of operators:

-- | # | Operator Family | Operators / Keywords | Core Purpose & Action | SQL Syntax Example |
-- | :--- | :--- | :--- | :--- | :--- |
-- | 1 | Comparison Operators | `=`, `!=`, `<>`, `>`, `>=`, `<`, `<=` | Compares two expressions, columns, or literal values to test equality or magnitude. | `WHERE score > 500` |
-- | 2 | Logical Operators | `AND`, `OR`, `NOT` | Combines multiple conditions or negates a condition using boolean algebra. | `WHERE country = 'USA' AND score >= 500` |
-- | 3 | Range Operator | `BETWEEN ... AND ...` | Filters values falling within an inclusive lower and upper boundary range. | `WHERE score BETWEEN 500 AND 900` |
-- | 4 | Membership Operator | `IN (...)`, `NOT IN (...)` | Checks if a value matches any item within a specified discrete list or subquery set. | `WHERE country IN ('USA', 'Germany', 'UK')` |
-- | 5 | Search Operator | `LIKE` (with `%`, `_`) | Performs string pattern matching using SQL wildcards (`%` for any characters, `_` for one). | `WHERE first_name LIKE 'J%'` |

-- ---

-- ------------------------------------------------------------
-- 20.7.2 Comparison Operators: Compare Two Things!
-- ------------------------------------------------------------

-- * What is a Comparison Operator?

--   * Definition: Comparison operators are used to compare two things (values, columns, expressions, functions, or subqueries).

--   * A comparison operator evaluates the relationship between two expressions and returns a boolean state: **`TRUE`**, **`FALSE`**, or **`UNKNOWN`**.

--   * Column = Column (`first_name = last_name`), Column = Value (`first_name = 'John'`).

--   * Function(Column) = Value (`UPPER(first_name) = 'JOHN'`), Math = Value (`price * quantity = 1000`).

-- ------------------------------------------------------------
-- 1. Anatomy of a Condition
-- ------------------------------------------------------------

-- * Every comparison condition follows a strict 3-part syntax structure:
--   $$\text{Condition} \longrightarrow \mathbf{\text{Expression 1}}\;\;[\mathbf{\text{Comparison Operator}}]\;\;\mathbf{\text{Expression 2}}$$

-- ------------------------------------------------------------
-- 2. The 5 Ways to Compare Two Things in SQL
-- ------------------------------------------------------------
-- SQL allows flexible comparisons across different types of operands:

-- 1. Column1 = Column2 (Compare Two Attributes):

--    * Compares the value in one column with the value in another column within the same row.
SELECT * FROM customers WHERE first_name = last_name;

-- 2. Column1 = Value (Compare Attribute to Constant Literal):

--    * Compares a column against a literal string, number, or date.
SELECT * FROM customers WHERE first_name = 'John';
SELECT * FROM customers WHERE country = 'USA';

-- 3. Function = Value (Compare Transformed Column to Constant):

--    * Applies a built-in SQL function (e.g., `UPPER()`, `LOWER()`, `LENGTH()`) before testing the condition.
SELECT * FROM customers WHERE UPPER(first_name) = 'JOHN';

-- 4. Expression = Value (Compare Mathematical Calculation to Constant):

--    * Computes an arithmetic expression across columns and compares the calculated result.
SELECT * FROM orders WHERE price * quantity = 1000;

-- 5. Subquery = Value (Compare Scalar Subquery to Constant — Advanced):

--    * Compares a value against the single scalar output of an inner nested query.
SELECT * FROM orders WHERE (SELECT AVG(sales) FROM orders) = 1000;

-- ---

-- ------------------------------------------------------------
-- 20.7.3 Master Comparison Operators Reference (Definitions & Descriptions)
-- ------------------------------------------------------------

-- * Complete technical definitions and plain-English descriptions for all 6 comparison operators:

-- | Operator Symbol | Name / Operation | Definition & Description | SQL Query Example | Condition Evaluated | Surviving Rows |
-- | :---: | :--- | :--- | :--- | :--- | :--- |
-- | **`=`** | Equal to | Checks if two values are equal.<br/>Returns `TRUE` if the left operand has exactly the same value as the right operand; otherwise returns `FALSE`. | `SELECT * FROM customers WHERE country = 'USA';` | `country = 'USA'` | Rows where `country` is exactly `'USA'` (e.g., John, Peter). |
-- | **`!=`<br/>`<>`** | Not equal to | Checks if two values are not equal.<br/>Returns `TRUE` if the left operand is not equal to the right operand.<br/>*Note: `<>` is the official ISO/ANSI SQL standard operator, while `!=` is the widely supported industry alias.* | `SELECT * FROM customers WHERE score != 0;`<br/>`SELECT * FROM customers WHERE score <> 0;` | `score != 0`<br/>`score <> 0` | All rows where `score` is any number other than 0. |
-- | **`>`** | Greater than | Checks if a value is greater than another value.<br/>Returns `TRUE` strictly when the left operand has a numerically or alphabetically larger value than the right operand. | `SELECT * FROM customers WHERE score > 500;` | `score > 500` | Rows where `score` is strictly greater than 500 (e.g., 750, 900). Excludes 500. |
-- | **`>=`** | Greater than or equal to | Checks if a value is greater than or equal to another value.<br/>Returns `TRUE` if the left operand is either strictly larger than or exactly equal to the right operand. | `SELECT * FROM customers WHERE score >= 500;` | `score >= 500` | Rows where `score` is 500 or higher (e.g., 500, 750, 900). Includes 500. |
-- | **`<`** | Less than | Checks if a value is less than another value.<br/>Returns `TRUE` strictly when the left operand has a numerically or alphabetically smaller value than the right operand. | `SELECT * FROM customers WHERE score < 500;` | `score < 500` | Rows where `score` is strictly less than 500 (e.g., 0, 350). Excludes 500. |
-- | **`<=`** | Less than or equal to | Checks if a value is less than or equal to another value.<br/>Returns `TRUE` if the left operand is either strictly smaller than or exactly equal to the right operand. | `SELECT * FROM customers WHERE score <= 500;` | `score <= 500` | Rows where `score` is 500 or lower (e.g., 0, 350, 500). Includes 500. |

-- > [!WARNING]
-- > Technical Gotcha: Three-Valued Logic & NULL Values
-- > In SQL, `NULL` represents an unknown or missing value, not zero or an empty string.
-- > Because of this, comparing any value to `NULL` using `=` or `!=` evaluates to **`UNKNOWN`**, never `TRUE`:
-- > * `score = NULL` $\longrightarrow$ UNKNOWN (Evaluates as Falsey, returns 0 rows)
-- > * `score != NULL` $\longrightarrow$ UNKNOWN (Evaluates as Falsey, returns 0 rows)
-- > The Golden Rule: *Always use `IS NULL` or `IS NOT NULL` when checking for missing values in SQL!*

-- ---

-- ------------------------------------------------------------
-- 20.7.4 Internal Filtering Process (Row-by-Row Predicate Evaluation)
-- ------------------------------------------------------------

-- * Let us see how the database engine evaluates conditions row-by-row in memory.

-- ------------------------------------------------------------
-- Demonstration 1: String Equality Predicate (`WHERE Country = 'USA'`)
-- ------------------------------------------------------------

-- * Consider the query:
SELECT name, country, score 
FROM customers 
WHERE country = 'USA';

-- * Step-by-Step Row Evaluation:

--   1. **Row 1 (`Maria`, `Germany`, `350`):** Evaluates `'Germany' = 'USA'` $\rightarrow$ **`FALSE`** $\rightarrow$ Row Discarded ❌

--   2. **Row 2 (`John`, `USA`, `900`):** Evaluates `'USA' = 'USA'` $\rightarrow$ **`TRUE`** $\rightarrow$ Row Kept ✔️

--   3. **Row 3 (`Georg`, `UK`, `750`):** Evaluates `'UK' = 'USA'` $\rightarrow$ **`FALSE`** $\rightarrow$ Row Discarded ❌

--   4. **Row 4 (`Martin`, `Germany`, `500`):** Evaluates `'Germany' = 'USA'` $\rightarrow$ **`FALSE`** $\rightarrow$ Row Discarded ❌

--   5. **Row 5 (`Peter`, `USA`, `0`):** Evaluates `'USA' = 'USA'` $\rightarrow$ **`TRUE`** $\rightarrow$ Row Kept ✔️

-- * Output Result Set:
--   | name | country | score |
--   | :--- | :--- | :--- |
--   | John | USA | 900 |
--   | Peter | USA | 0 |

-- ---

-- ------------------------------------------------------------
-- Demonstration 2: Numeric Greater Than Predicate (`WHERE score > 500`)
-- ------------------------------------------------------------

-- * Consider the query:
SELECT name, country, score 
FROM customers 
WHERE score > 500;

-- * Step-by-Step Row Evaluation:

--   1. Row 1 (Maria, 350): $350 > 500 \rightarrow$ **`FALSE`** $\rightarrow$ Row Discarded ❌

--   2. Row 2 (John, 900): $900 > 500 \rightarrow$ **`TRUE`** $\rightarrow$ Row Kept ✔️

--   3. Row 3 (Georg, 750): $750 > 500 \rightarrow$ **`TRUE`** $\rightarrow$ Row Kept ✔️

--   4. Row 4 (Martin, 500): $500 > 500 \rightarrow$ **`FALSE`** $\rightarrow$ Row Discarded ❌ (500 is not strictly greater than 500)

--   5. Row 5 (Peter, 0): $0 > 500 \rightarrow$ **`FALSE`** $\rightarrow$ Row Discarded ❌

-- * Output Result Set:
--   | name | country | score |
--   | :--- | :--- | :--- |
--   | John | USA | 900 |
--   | Georg | UK | 750 |

-- ---

-- ------------------------------------------------------------
-- 20.7.5 Practical Practice Questions (Hands-on Comparison Queries)
-- ------------------------------------------------------------

-- * Q1. Retrieve customers where scores are not equal to zero ?
-- Standard industry syntax:
SELECT first_name, score FROM customers WHERE score != 0;

-- Official ISO/ANSI SQL standard syntax:
SELECT first_name, score FROM customers WHERE score <> 0;

--   * Key Takeaway: Both `!=` and `<>` perform identically in MySQL. `<>` is the ISO/ANSI SQL standard, while `!=` is common in modern programming languages.

-- * Q2. Retrieve all customers from Germany ?
SELECT * FROM customers WHERE country = 'Germany';

--   * With column projection (Production Best Practice):
SELECT first_name, country, score FROM customers WHERE country = 'Germany';

-- * Q3. Retrieve all customers from USA ?
SELECT first_name, country, score FROM customers WHERE country = 'USA';

-- * Q4. Retrieve customers who have scored strictly greater than 500 ?
SELECT first_name, score FROM customers WHERE score > 500;

-- * Q5. Retrieve customers who have scored 500 or higher (greater than or equal to 500) ?
SELECT first_name, score FROM customers WHERE score >= 500;

-- * Q6. Retrieve customers who have scored strictly less than 500 ?
SELECT first_name, score FROM customers WHERE score < 500;

-- * Q7. Retrieve customers who have scored 500 or lower (less than or equal to 500) ?
SELECT first_name, score FROM customers WHERE score <= 500;

-- * Q8. Retrieve customers whose first name is identical to their last name (Compare Column to Column) ?
SELECT * FROM customers WHERE first_name = last_name;

-- * Q9. Retrieve orders where total cost (price * quantity) is equal to 1000 (Compare Expression to Value) ?
SELECT order_id, product_name, price, quantity, (price * quantity) AS total_amount 
FROM orders 
WHERE price * quantity = 1000;

-- ---

-- ------------------------------------------------------------
-- 20.7.6 Logical Operators In-Depth (AND, OR, NOT)
-- ------------------------------------------------------------

-- * What are Logical Operators?

--   * *Definition: Logical operators in SQL are used to combine multiple conditions or negate a condition in the `WHERE` clause.*

--   * They evaluate individual condition predicates using formal boolean logic and determine whether a row meets the overall criteria to be included in the result set.

-- * Summary Recap of the 3 Core Logical Operators:

--   * **`AND`** : All conditions must be TRUE (Returns the row only if every single condition evaluates to `TRUE`).

--   * **`OR`**  : At least one condition must be TRUE (Returns the row if any condition evaluates to `TRUE`).

--   * **`NOT`** : Reverse the condition (Excludes matching values; inverts `TRUE` to `FALSE` and `FALSE` to `TRUE`).

-- ---

-- ------------------------------------------------------------
-- 1. The `AND` Operator
-- ------------------------------------------------------------

-- * Definition & Meaning:

--   * Combines two or more conditions.

--   * The row is returned only if all conditions are true.

--   * If even a single condition evaluates to `FALSE`, the entire combined expression evaluates to `FALSE` and the row is discarded.

-- * **Mathematical Truth Table for `AND`:**
--   | Condition 1 | Condition 2 | Combined (`Cond1 AND Cond2`) | Row Evaluation Action |
--   | :---: | :---: | :---: | :---: |
--   | **`TRUE`** | **`TRUE`** | **`TRUE`** | Row Kept in Result Set ✔️ |
--   | **`TRUE`** | `FALSE` | `FALSE` | Row Discarded ❌ |
--   | `FALSE` | **`TRUE`** | `FALSE` | Row Discarded ❌ |
--   | `FALSE` | `FALSE` | `FALSE` | Row Discarded ❌ |

-- * Hands-on Query Example:
SELECT * FROM customers 
WHERE country = 'USA' AND score > 500;

-- * Step-by-Step Row Evaluation:

--   1. Maria (`Germany`, `350`): `'Germany' = 'USA'` (❌) AND `350 > 500` (❌) $\rightarrow$ `FALSE` $\rightarrow$ Discarded ❌

--   2. John (`USA`, `900`): `'USA' = 'USA'` (✔️) AND `900 > 500` (✔️) $\rightarrow$ **`TRUE`** $\rightarrow$ Row Kept ✔️

--   3. Georg (`UK`, `750`): `'UK' = 'USA'` (❌) AND `750 > 500` (✔️) $\rightarrow$ `FALSE` $\rightarrow$ Discarded ❌

--   4. Martin (`Germany`, `500`): `'Germany' = 'USA'` (❌) AND `500 > 500` (❌) $\rightarrow$ `FALSE` $\rightarrow$ Discarded ❌

--   5. Peter (`USA`, `0`): `'USA' = 'USA'` (✔️) AND `0 > 500` (❌) $\rightarrow$ `FALSE` $\rightarrow$ Discarded ❌

-- * Surviving Result Set:
--   | name | country | score |
--   | :--- | :--- | :--- |
--   | John | USA | 900 |

-- ---

-- ------------------------------------------------------------
-- 2. The `OR` Operator
-- ------------------------------------------------------------

-- * Definition & Meaning:

--   * Combines conditions.

--   * The row is returned if at least one condition is true.

--   * Evaluates to `FALSE` only when all combined conditions evaluate to `FALSE`.

-- * **Mathematical Truth Table for `OR`:**
--   | Condition 1 | Condition 2 | Combined (`Cond1 OR Cond2`) | Row Evaluation Action |
--   | :---: | :---: | :---: | :---: |
--   | **`TRUE`** | **`TRUE`** | **`TRUE`** | Row Kept in Result Set ✔️ |
--   | **`TRUE`** | `FALSE` | **`TRUE`** | Row Kept in Result Set ✔️ |
--   | `FALSE` | **`TRUE`** | **`TRUE`** | Row Kept in Result Set ✔️ |
--   | `FALSE` | `FALSE` | `FALSE` | Row Discarded ❌ |

-- * Hands-on Query Example:
SELECT * FROM customers 
WHERE country = 'USA' OR score > 500;

-- * Step-by-Step Row Evaluation:

--   1. Maria (`Germany`, `350`): Neither condition is true $\rightarrow$ `FALSE` $\rightarrow$ Discarded ❌

--   2. John (`USA`, `900`): Both conditions are true $\rightarrow$ **`TRUE`** $\rightarrow$ Row Kept ✔️

--   3. Georg (`UK`, `750`): `score > 500` is true $\rightarrow$ **`TRUE`** $\rightarrow$ Row Kept ✔️

--   4. Martin (`Germany`, `500`): Neither condition is true (500 is not > 500) $\rightarrow$ `FALSE` $\rightarrow$ Discarded ❌

--   5. Peter (`USA`, `0`): `country = 'USA'` is true $\rightarrow$ **`TRUE`** $\rightarrow$ Row Kept ✔️

-- * Surviving Result Set:
--   | name | country | score |
--   | :--- | :--- | :--- |
--   | John | USA | 900 |
--   | Georg | UK | 750 |
--   | Peter | USA | 0 |

-- ---

-- ------------------------------------------------------------
-- 3. The `NOT` Operator
-- ------------------------------------------------------------

-- * Definition & Meaning:

--   * Negates a condition.

--   * Returns rows where the condition is false (reverses the boolean state).

--   * Excludes matching values from the result set.

-- * **Mathematical Truth Table for `NOT`:**
--   | Inner Condition Predicate | Combined State (`NOT Condition`) | Row Evaluation Action |
--   | :---: | :---: | :---: |
--   | **`TRUE`** | `FALSE` | Row Discarded ❌ (Excluded) |
--   | `FALSE` | **`TRUE`** | Row Kept in Result Set ✔️ |

-- * Hands-on Query Example:
SELECT * FROM customers 
WHERE NOT (country = 'USA');

-- * Step-by-Step Row Evaluation:

--   1. Maria (`Germany`): `'Germany' = 'USA'` is `FALSE` $\rightarrow$ `NOT FALSE` = **`TRUE`** $\rightarrow$ Row Kept ✔️

--   2. John (`USA`): `'USA' = 'USA'` is `TRUE` $\rightarrow$ `NOT TRUE` = `FALSE` $\rightarrow$ Discarded ❌

--   3. Georg (`UK`): `'UK' = 'USA'` is `FALSE` $\rightarrow$ `NOT FALSE` = **`TRUE`** $\rightarrow$ Row Kept ✔️

--   4. Martin (`Germany`): `'Germany' = 'USA'` is `FALSE` $\rightarrow$ `NOT FALSE` = **`TRUE`** $\rightarrow$ Row Kept ✔️

--   5. Peter (`USA`): `'USA' = 'USA'` is `TRUE` $\rightarrow$ `NOT TRUE` = `FALSE` $\rightarrow$ Discarded ❌

-- * Surviving Result Set:
--   | name | country | score |
--   | :--- | :--- | :--- |
--   | Maria | Germany | 350 |
--   | Georg | UK | 750 |
--   | Martin | Germany | 500 |

-- * Equivalence Note:

--   * `WHERE NOT (country = 'USA')` is functionally identical to `WHERE country != 'USA'` or `WHERE country <> 'USA'`.

-- ---

-- ------------------------------------------------------------
-- 20.7.7 Range Operator In-Depth: `BETWEEN ... AND ...`
-- ------------------------------------------------------------

-- * **What is the `BETWEEN` Operator?**

--   * Definition: The `BETWEEN … AND …` operator checks if a value is within a range or not.

--   * The `BETWEEN … AND …` operator is used in SQL to filter a range of values.

--   * It includes the lower and upper bounds (both ends are inclusive).

--   * Works with numbers, dates, or text:

--     * Numbers: Filters values within numeric boundaries (e.g., `score BETWEEN 100 AND 500`).

--     * Dates: Filters records within temporal dates (e.g., `order_date BETWEEN '2025-01-01' AND '2025-12-31'`).

--     * Text: Filters strings based on dictionary alphabetical sorting (e.g., `last_name BETWEEN 'A' AND 'M'`).

-- ------------------------------------------------------------
-- 1. Inclusive Nature (Both Ends are Inclusive)
-- ------------------------------------------------------------

-- * In SQL, `BETWEEN` is strictly inclusive on both boundaries:
--   $$\text{value} \ge \text{lower\_boundary}\quad \mathbf{AND}\quad \text{value} \le \text{upper\_boundary}$$

-- * For example, if a record's score is exactly `100` or exactly `500`, both boundary values are retained.

-- ------------------------------------------------------------
-- 2. To Achieve `BETWEEN` Operator Using `AND` & Comparison Operators
-- ------------------------------------------------------------

-- * It is very similar to explicitly declaring the lower boundary and higher boundary using comparison operators:
-- Syntax using BETWEEN operator:
SELECT * FROM customers WHERE score BETWEEN 100 AND 500;

-- Syntax using comparison operators with AND:
SELECT * FROM customers WHERE score >= 100 AND score <= 500;

-- * **Above command is also exactly the same as the `BETWEEN` command!**

-- * Inside the database engine, the SQL query optimizer evaluates both queries to the exact same execution plan.

-- ------------------------------------------------------------
-- 3. Step-by-Step Row Evaluation (`WHERE score BETWEEN 100 AND 500`)
-- ------------------------------------------------------------

-- * Let us evaluate each record from our `customers` table against the range $[100, 500]$:

--   1. Maria (`350`): $100 \le 350 \le 500$ is **`TRUE`** $\rightarrow$ Row Kept ✔️

--   2. John (`900`): $900 > 500$ (above upper boundary) is `FALSE` $\rightarrow$ Discarded ❌

--   3. Georg (`750`): $750 > 500$ (above upper boundary) is `FALSE` $\rightarrow$ Discarded ❌

--   4. Martin (`500`): $500 = 500$ (matches exact upper inclusive bound!) is **`TRUE`** $\rightarrow$ Row Kept ✔️

--   5. Peter (`0`): $0 < 100$ (below lower boundary) is `FALSE` $\rightarrow$ Discarded ❌

-- * Output Result Set:
--   | name | country | score |
--   | :--- | :--- | :--- |
--   | Maria | Germany | 350 |
--   | Martin | Germany | 500 |

-- ------------------------------------------------------------
-- 4. Negating a Range: `NOT BETWEEN … AND …`
-- ------------------------------------------------------------

-- * The `NOT BETWEEN` operator retrieves all rows that fall outside the specified range:
SELECT * FROM customers WHERE score NOT BETWEEN 100 AND 500;

--   * Equivalent Comparison Syntax:
SELECT * FROM customers WHERE score < 100 OR score > 500;

--   * Surviving Records: Peter (0), Georg (750), and John (900).

-- ---

-- ------------------------------------------------------------
-- 20.7.8 Membership Operator In-Depth: IN and NOT IN
-- ------------------------------------------------------------

-- * What is the Membership Operator?

--   * Definition: The Membership Operator (`IN` / `NOT IN`) tests whether a specific operand or column value exists within a specified list, set of discrete values, or subquery result set.

--   * It is also widely known as a set filter operator.

--   * It checks if a value exists in a list, or in a simple way, whether a value is an active member of a list.

-- * **1. List: The `IN (...)` Operator**

--   * Definition: The `IN` operator is used to filter records where a column’s value matches any value from a given list.

--   * It is like writing multiple `OR` conditions in a much shorter, cleaner, and optimized way.

--   * Standard Syntax:
column_name IN (value1, value2, value3, ...)

--   * Hands-on Query Example:
SELECT * FROM customers 
WHERE country IN ('Germany', 'USA');

--   * Crucial Best Practice Note:

--     * **Use `IN` instead of `OR` for multiple values in the same column to simplify SQL!**

--     * Verbose query using multiple `OR` conditions:
SELECT * FROM customers 
WHERE country = 'Germany' OR country = 'USA';

--     * Instead of writing multiple verbose `OR` statements, use the standardized `IN` operator:
SELECT * FROM customers 
WHERE country IN ('Germany', 'USA');

--     * Both queries produce identical results and query execution plans in the database engine, but `IN` is far cleaner, easier to read, and simpler to maintain when filtering across many items.

-- * **2. List: The `NOT IN (...)` Operator**

--   * Definition: The `NOT IN` operator is used to filter records where a column’s value is not present in a given list (or subquery).

--   * It checks that values do not exist in the list.

--   * In a simple way: it returns those records whose column value is not in the member list.

--   * It is simply the exact boolean opposite of `IN`.

--   * Standard Syntax:
column_name NOT IN (value1, value2, value3, ...)

--   * Hands-on Query Example:
SELECT * FROM customers 
WHERE country NOT IN ('Germany', 'USA');

-- * **3. Step-by-Step Row Evaluation (`IN` vs. `NOT IN`)**

--   * Target Filter List: `('Germany', 'USA')`

--   * Evaluating each record from our `customers` table:

--     1. Maria (`Germany`): `'Germany'` exists in `('Germany', 'USA')` $\rightarrow$ `IN` = **`TRUE` ✔️ (Kept)** | `NOT IN` = `FALSE` ❌ (Discarded)

--     2. John (`USA`): `'USA'` exists in `('Germany', 'USA')` $\rightarrow$ `IN` = **`TRUE` ✔️ (Kept)** | `NOT IN` = `FALSE` ❌ (Discarded)

--     3. Georg (`UK`): `'UK'` does NOT exist in `('Germany', 'USA')` $\rightarrow$ `IN` = `FALSE` ❌ (Discarded) | `NOT IN` = **`TRUE` ✔️ (Kept)**

--     4. Martin (`Germany`): `'Germany'` exists in `('Germany', 'USA')` $\rightarrow$ `IN` = **`TRUE` ✔️ (Kept)** | `NOT IN` = `FALSE` ❌ (Discarded)

--     5. Peter (`USA`): `'USA'` exists in `('Germany', 'USA')` $\rightarrow$ `IN` = **`TRUE` ✔️ (Kept)** | `NOT IN` = `FALSE` ❌ (Discarded)

-- * Output Result Set Comparison:

--   * **Result of `WHERE country IN ('Germany', 'USA')`:**
--     | name | country | score |
--     | :--- | :--- | :--- |
--     | Maria | Germany | 350 |
--     | John | USA | 900 |
--     | Martin | Germany | 500 |
--     | Peter | USA | 0 |

--   * **Result of `WHERE country NOT IN ('Germany', 'USA')`:**
--     | name | country | score |
--     | :--- | :--- | :--- |
--     | Georg | UK | 750 |

-- * **4. Critical Interview Trap: The `NOT IN` with `NULL` Trap (Three-Valued Logic Danger)**

--   * The Classic Interview Question:
-- Suppose you have customer IDs 1, 2, 3, 4, 5. What does this return?
SELECT * FROM customers 
WHERE id NOT IN (1, 2, NULL);

--   * Common Mistake: Most candidates guess it returns customers with IDs 3, 4, and 5.

--   * The True Answer: It returns ZERO rows (Empty Result Set)!

--   * Internal Boolean Mechanics (Why it fails):

--     * The SQL engine expands `id NOT IN (1, 2, NULL)` using boolean algebra into chained `AND` comparisons:
--       $$\text{id} \ne 1 \quad\mathbf{AND}\quad \text{id} \ne 2 \quad\mathbf{AND}\quad \text{id} \ne \mathbf{NULL}$$

--     * Under SQL Three-Valued Logic (3VL), comparing anything to `NULL` via `!=` produces **`UNKNOWN`** (neither `TRUE` nor `FALSE`).

--     * In boolean `AND` logic:
--       $$\text{TRUE} \quad\mathbf{AND}\quad \text{TRUE} \quad\mathbf{AND}\quad \mathbf{UNKNOWN} \quad\Longrightarrow\quad \mathbf{UNKNOWN}$$

--     * The `WHERE` clause **only emits rows where the predicate evaluates to strictly `TRUE`**. Because `UNKNOWN` is never `TRUE`, every single row in the table is discarded!

--   * Production Best Practice / Safe Solution:

--     1. Filter out `NULL`s explicitly when using subqueries or lists:
SELECT * FROM customers 
WHERE id NOT IN (SELECT customer_id FROM orders WHERE customer_id IS NOT NULL);

--     2. Or use the safer **`NOT EXISTS`** clause, which is immune to `NULL` pitfalls.

-- ---

-- ------------------------------------------------------------
-- 20.7.9 Search Operator In-Depth: LIKE and NOT LIKE (Pattern Matching)
-- ------------------------------------------------------------

-- * **What is the Search Operator (`LIKE`)?**

--   * Definition: The `LIKE` operator is used in SQL to search for a pattern in text (instead of requiring an exact equality match with `=`).

--   * It is often combined with wildcards to provide flexible string matching.

-- * Understanding SQL Wildcards:

--   * A wildcard character is a special placeholder symbol used in search strings.

--   * The two core SQL wildcards are:

--     1. **Percent (`%`) Wildcard:** Matches zero, one, or multiple characters (represents zero or more characters).

--     2. **Underscore (`_`) Wildcard:** Matches exactly one character (represents a single character at a specific position).

-- * **1. Detailed Point-Wise Explanation of `%` (Zero or More Characters):**

--   * `SELECT * FROM Customer WHERE name LIKE 'A%';`

--     * Action: Starts with "A".

--     * Point-wise Explanation: Matches any name starting with the letter 'A', followed by zero, one, or multiple characters (e.g., Alice, Albert, An, or just A).

--   * `SELECT * FROM Customer WHERE name LIKE '%a';`

--     * Action: Name ends with "a".

--     * Point-wise Explanation: Matches any name that terminates with the letter 'a', regardless of how many characters precede it (e.g., Maria, Anna, Emma).

--   * `SELECT * FROM Customer WHERE name LIKE '%it%';`

--     * Action: Find name containing "it" anywhere.

--     * Point-wise Explanation: Matches any name containing the substring "it" in any position — beginning, middle, or end (e.g., Rohit, Mohit, Martin).

-- * **2. Detailed Point-Wise Explanation of `_` (Exactly One Character):**

--   * `SELECT * FROM Customer WHERE name LIKE '_ohit';`

--     * Action: Finds names where the second to fifth characters are "ohit".

--     * Point-wise Explanation: The leading underscore represents exactly one single character, so it matches 5-letter names like Rohit or Mohit.

--   * `SELECT * FROM Customer WHERE name LIKE 'A_i_';`

--     * Action: Exact match for 4-letter names starting with "A" and having "i" as the third letter.

--     * Point-wise Explanation: The total length must be exactly 4 characters: 1st is 'A', 2nd is any character, 3rd is 'i', and 4th is any character (e.g., Amir, Abid).

--   * `SELECT * FROM Customer WHERE name LIKE 'S_ne%';`

--     * Action: Matches names starting with "S", followed by any one character, then "ne", and anything after.

--     * Point-wise Explanation: 1st letter 'S', 2nd letter is any 1 char (`_`), 3rd & 4th are 'ne', followed by zero or more characters (`%`) (e.g., Sanel, Soney, Sinead).

-- * 3. Master Pattern Reference Table:
--   | Pattern Expression | Description & Rule | Matching Examples | Non-Matching Examples |
--   | :--- | :--- | :--- | :--- |
--   | `LIKE 'a%'` | Start with "a" | `adam`, `alice`, `amber` | `maria`, `john` |
--   | `LIKE '%a'` | End with "a" | `maria`, `emma`, `anna` | `martin`, `peter` |
--   | `LIKE '%am%'` | Have "am" in any position | `sam`, `adam`, `pamela` | `georg`, `john` |
--   | `LIKE 'a%m'` | Start with "a" and Ends with "m" | `adam`, `abraham`, `am` | `alice`, `martin` |
--   | `LIKE '_a%'` | "a" in the second position | `maria`, `james`, `david` | `alice`, `georg` |
--   | `LIKE '__a%'` | "a" in the third position | `clara`, `charlie`, `brandon` | `maria`, `john` |
--   | `LIKE '_oy'` | "o" in the second and "y" in third position (exact 3 chars) | `roy`, `joy`, `boy` | `troy` (4 chars), `ray` |

-- * 4. Detailed 4-Column Visual Pattern Breakdown:

--   * **Column 1: `LIKE 'M%'` (1st Character is 'M', followed by Any characters):**

--     * ✔️ Maria (Starts with M, followed by 'aria')

--     * ✔️ Ma (Starts with M, followed by 'a')

--     * ✔️ M (Starts with M, followed by 0 characters — valid because `%` allows 0 characters!)

--     * ❌ Emma (Starts with 'E', discarded)

--   * **Column 2: `LIKE '%in'` (Any characters, ending with "in"):**

--     * ✔️ Martin (Ends with 'in')

--     * ✔️ Vin (Ends with 'in')

--     * ✔️ in (Matches exact 'in' with 0 preceding characters)

--     * ❌ Jasmine (Ends with 'e', not 'in', discarded)

--   * **Column 3: `LIKE '%r%'` (Any characters, contains "r", followed by Any characters):**

--     * ✔️ Maria (Contains 'r' in middle)

--     * ✔️ Peter (Contains 'r' at end)

--     * ✔️ Rayn (Contains 'R' at start — MySQL's default comparison is case-insensitive, so `'r'` matches `'R'`)

--     * ✔️ R (Matches single 'R')

--     * ❌ Alice (Contains no 'r', discarded)

--   * **Column 4: `LIKE '__b%'` (1st: any, 2nd: any, 3rd: must be "b", followed by Any):**

--     * ✔️ Albert (1: A, 2: l, 3: b, followed by 'ert')

--     * ✔️ Rob (1: R, 2: o, 3: b, followed by 0 chars)

--     * ❌ Abel ('b' is in 2nd position, not 3rd, discarded)

--     * ❌ An (Length is only 2 characters, discarded)

-- * **5. Using the `NOT LIKE` Operator:**

--   * Definition: The `NOT LIKE` operator is used to return rows that do not match the pattern in the given text.

--   * It excludes patterns, i.e., returns those records that do not match the pattern.

--   * Syntax Example:
SELECT * FROM Customer WHERE name NOT LIKE 'A%';

--     * Action: Returns names that do not start with 'A' (e.g., Maria, John, Georg, Martin, Peter).

-- * 6. Pattern Matching Quick Recap:

--   * `%` $\rightarrow$ Many characters (including zero or one character).

--   * `_` $\rightarrow$ Exactly one character.

--   * `LIKE` $\rightarrow$ Flexible matching.

--   * `NOT LIKE` $\rightarrow$ Exclude patterns.

-- ---

-- ------------------------------------------------------------
-- 20.7.10 NULL Check Operator In-Depth: IS NULL and IS NOT NULL
-- ------------------------------------------------------------

-- * **What is `NULL` in SQL?**

--   * Definition: `NULL` means no value / missing value (not 0, not an empty string, but literally "unknown").

--   * `IS NULL` and `IS NOT NULL` are the special operators used to check it.

--   * You cannot check `NULL` with `=` or `!=` (because in SQL, `NULL = NULL` is never true!).

--   * Instead, you **must use `IS NULL` or `IS NOT NULL`**.

-- * **Why `=` and `!=` Fail with NULL (Three-Valued Logic - 3VL):**

--   * In relational database theory, boolean logic has three distinct states:
--     $$\textbf{TRUE}, \quad \textbf{FALSE}, \quad \textbf{UNKNOWN}$$

--   * Any comparison against `NULL` (including `column = NULL` or `NULL = NULL`) evaluates to **`UNKNOWN`**.

--   * The `WHERE` clause strictly filters and passes rows only when the predicate evaluates to **`TRUE`**.

--   * Because `UNKNOWN` is not `TRUE`, queries using `= NULL` silently return 0 rows!

-- * **1. The `IS NULL` Operator:**

--   * Definition: Finds rows where the column value is missing or `NULL`.

--   * Syntax & Query Example:
SELECT * FROM Customer 
WHERE phone_number IS NULL;

--   * Action: Retrieves all customers who do not have a recorded phone number in the database.

-- * **2. The `IS NOT NULL` Operator:**

--   * Definition: Finds rows where the column value is not `NULL` (i.e., a valid value is present).

--   * Syntax & Query Example:
SELECT * FROM Customer 
WHERE email IS NOT NULL;

--   * Action: Retrieves all customers whose email address is present and recorded in the database.

-- * 3. Key Points to Remember:

--   * **`NULL ≠ 0`** (0 is a defined number; NULL is the absence of data).

--   * **`NULL ≠ ''` (empty string)** (An empty string is a valid text string of length 0; NULL is unknown/absent).

--   * **Must use `IS NULL` / `IS NOT NULL` for checking.**

-- ---

-- ------------------------------------------------------------
-- 20.7.11 Advanced Filtering: Aggregates with HAVING and Subqueries
-- ------------------------------------------------------------

-- * Beyond basic row-level filters in `WHERE`, real-world SQL relies on two advanced filtering mechanisms:

-- * **1. Aggregate Functions with `HAVING` (Filtering After Grouping):**

--   * The `WHERE` clause filters individual rows before any grouping or aggregation takes place.

--   * The `HAVING` clause filters summarized groups after `GROUP BY` has aggregated the rows.

--   * Example comparing Row Filtering vs. Group Filtering:
-- 1. Row-level filter using WHERE:
SELECT * FROM Customer 
WHERE city = 'Mumbai';

-- 2. Aggregate-level filter using HAVING:
SELECT city, COUNT(*) AS total_customers 
FROM Customer 
GROUP BY city 
HAVING COUNT(*) > 5;

--   * Crucial Rule: You cannot use aggregate functions like `COUNT()`, `SUM()`, `AVG()` inside a `WHERE` clause (e.g., `WHERE COUNT(*) > 5` will throw a syntax error). You must use `HAVING`.

-- * 2. Subqueries (Filtering Results Based on Another Query):

--   * A subquery is an inner `SELECT` query nested inside the `WHERE` clause of an outer query.

--   * Example: Filtering with Subquery and IN Operator:
-- Filter customers whose country exists in our active priority sales regions:
SELECT * FROM Customer 
WHERE country IN (
    SELECT country 
    FROM high_growth_regions 
    WHERE annual_target_met = 1
);

--   * Example: Filtering with Scalar Comparison Subquery:
-- Find all customers whose score is strictly higher than the overall average score:
SELECT name, country, score 
FROM Customer 
WHERE score > (SELECT AVG(score) FROM Customer);

-- ---

-- ------------------------------------------------------------
-- 20.8 Sorting Data & The ORDER BY Clause In-Depth
-- ------------------------------------------------------------

-- * What is Sorting in SQL?

--   * Definition: Sorting in SQL is performed using the `ORDER BY` clause. It allows us to systematically arrange the output rows of a query in ascending (`ASC`) or descending (`DESC`) order based on one or more specified columns, expressions, or aliases.

--   * Without `ORDER BY`, there is no guaranteed order — the same query can return rows in a different order next time.

-- * How ORDER BY Works (The 2 Core Directions):

--   1. **Ascending (`ASC`):**

--      * Sorts from lowest to highest (numbers: `0 ➔ 9`, alphabetical text: `A ➔ Z`, chronological dates: oldest to newest).

--      * By default, SQL sorts in ascending order!

--      * Best Practice: Always explicitly specify `ASC` in your queries for code readability and team clarity.

--   2. **Descending (`DESC`):**

--      * Sorts from highest to lowest (numbers: `9 ➔ 0`, reverse alphabetical text: `Z ➔ A`, chronological dates: newest to oldest).

-- * Single Column Sorting Practice Questions:

--   * Q1. Retrieve all customers and sort the result by the highest score first:
SELECT * FROM customers 
ORDER BY score DESC;

--   * Q2. Retrieve all customers and sort the result by the LOWEST score first:
SELECT * FROM customers 
ORDER BY score ASC;
--     *(Note: Writing `ORDER BY score;` also sorts ascending by default, but writing `ORDER BY score ASC;` is preferred).*

-- * **Step-by-Step Row Reordering Lifecycle (`ORDER BY score DESC`):**

--   * Let us trace how the database engine evaluates and sorts our sample `customers` table:

--     * **Step ① (`FROM customers`):** Retrieves the 5 raw records from disk/memory buffers.

--     * **Step ② (`SELECT *`):** Picks all columns of each row.

--     * **Step ③ (`ORDER BY score DESC`):** Sorts the rows by `score`, highest first, and returns the sorted result to the client.

--   * Reordered Result Set:
--     | id | name | country | score | Sort Position & Action |
--     | :---: | :--- | :--- | :---: | :--- |
--     | 2 | John | USA | 900 | Row 1 (Highest score in table) |
--     | 3 | Georg | UK | 750 | Row 2 |
--     | 4 | Martin | Germany | 500 | Row 3 |
--     | 1 | Maria | Germany | 350 | Row 4 |
--     | 5 | Peter | USA | 0 | Row 5 (Lowest score in table) |

-- * Nested ORDER BY: Multiple Columns Sorting (TO SORT YOUR DATA)

--   * You can sort your data using multiple columns, which is referred to as nested sorting.

--   * **The order of columns in the `ORDER BY` clause is crucial because sorting is strictly sequential!**

--   * Sequential Sorting Mechanics:

--     1. The database engine first sorts the entire dataset by the first specified column.

--     2. If two or more rows have the exact same value in the first column (a tie), the engine uses the second column as a tie-breaker to sort only those tied rows.

--     3. If ties persist, subsequent columns (3rd, 4th, etc.) are evaluated in sequence.

-- * Nested Sorting Practice Question:

--   * Q1. Retrieve all customers and sort the result by country (alphabetically) and then by highest score:
SELECT id, name, country, score 
FROM customers 
ORDER BY country ASC, score DESC;

--   * Additional Example on Customer / City Table:
SELECT name, city, score 
FROM Customer 
ORDER BY city ASC, score DESC;

--   * Detailed Execution Breakdown:

--     * **Primary Sort (`country ASC`):** First sorts by country alphabetically: `Germany ➔ UK ➔ USA`.

--     * **Secondary Tie-Breaker (`score DESC`):**

--       * Within Germany (Maria with score 350, Martin with score 500): Since Martin has the higher score, Martin (500) appears before Maria (350)!

--       * Within UK (Georg with score 750): Only one record exists.

--       * Within USA (John with score 900, Peter with score 0): Since John has the higher score, John (900) appears before Peter (0)!

--   * **Output Table for Nested Sort (`country ASC, score DESC`):**
--     | id | name | country (ASC) | score (DESC) | Tie-Breaker Observation |
--     | :---: | :--- | :--- | :---: | :--- |
--     | 4 | Martin | Germany | 500 | ▲ Higher score in Germany |
--     | 1 | Maria | Germany | 350 | ▼ Lower score in Germany |
--     | 3 | Georg | UK | 750 | Single UK record |
--     | 2 | John | USA | 900 | ▲ Higher score in USA |
--     | 5 | Peter | USA | 0 | ▼ Lower score in USA |

-- * Operators and Keywords Used in Sorting:

--   * **`ORDER BY`** $\rightarrow$ Main clause used to trigger sorting.

--   * **`ASC`** $\rightarrow$ Sorts ascending (`A ➔ Z`, `0 ➔ 9`). Default order.
SELECT name, city FROM Customer ORDER BY name ASC;

--   * **`DESC`** $\rightarrow$ Sorts descending (`Z ➔ A`, `9 ➔ 0`).
SELECT name, balance FROM Account ORDER BY balance DESC;

-- * Sorting with Dates:

--   * Dates in SQL can be sorted chronologically using `ASC` (oldest date first) or `DESC` (most recent / newest date first):
SELECT transaction_id, amount, transaction_date 
FROM Transaction 
ORDER BY transaction_date DESC;

--     * Action: Places the most recent financial transactions at the top of the report.

-- * Sorting with Expressions & Computed Columns:

--   * You can sort by calculated arithmetic expressions or column aliases defined in `SELECT`:
SELECT name, (salary * 12) AS annual_salary 
FROM Employee 
ORDER BY annual_salary DESC;

--     * Engine Execution Note: Because `SELECT` executes before `ORDER BY`, column aliases like `annual_salary` are fully recognized and valid in `ORDER BY`!

-- * Sorting with NULL Values:

--   * In relational databases, `NULL` represents an unknown/missing state. SQL handles `NULL` values deterministically in sorting:

--     * **In `ASC` order (Default):** `NULL` values appear first (treated as smaller than any real value in MySQL).

--     * **In `DESC` order:** `NULL` values appear last.

--   * Pro Tip for Custom NULL Placement:

--     * If you want `ASC` sorting but want `NULL` records placed at the very end, use an `IS NULL` boolean condition:
SELECT name, score 
FROM customers 
ORDER BY score IS NULL ASC, score ASC;

-- * Crucial Interview Concepts in ORDER BY:

--   * 1. Positional Sorting (Ordering by Column Ordinal / Index):

--     * SQL allows sorting using 1-based numerical column position indices corresponding to the `SELECT` list:
SELECT country, name, score 
FROM customers 
ORDER BY 1 ASC, 3 DESC;
--       *(Here, `1` corresponds to `country`, and `3` corresponds to `score`).*

--     * Production Warning (Antipattern): While valid SQL, positional sorting is strongly discouraged in production code! If a teammate reorders or adds columns in `SELECT` (e.g., adding `id` at position 1), the `ORDER BY 1` silently sorts on the wrong attribute and produces critical reporting bugs.

--   * 2. Deterministic vs. Non-Deterministic Sorting (The Tie-Breaker Rule):

--     * If multiple rows have the exact same values across all sorted columns (e.g., Martin and Maria both having identical scores), relational database engines do not guarantee a consistent order between queries. The order of tied rows can shift arbitrarily based on table scans, storage pages, or parallel execution threads!

--     * Interview Rule: To achieve deterministic, reproducible sorting, always append a **unique column or Primary Key (`id`)** as the final tie-breaker:
SELECT id, name, score 
FROM customers 
ORDER BY score DESC, id ASC;

-- ---

-- ------------------------------------------------------------
-- 20.9 Grouping Data & The GROUP BY Clause In-Depth (Data Aggregation)
-- ------------------------------------------------------------

-- * What is Grouping in SQL? (GROUP BY Clause: AGGREGATE YOUR DATA)

--   * Definition: Grouping in SQL means combining multiple rows that have the same values in one or more columns into summary rows.

--   * Using `GROUP BY`, you aggregate your data based on a column.

--   * `GROUP BY` puts rows with the same value into one group, then an aggregate function (`SUM`, `COUNT`, …) is calculated for each group.

--   * Each distinct group produces exactly ONE summary row in the final result set.

-- * Works with Aggregate Functions:

--   * `GROUP BY` works in tandem with SQL aggregate functions:

--     * **`SUM(column)`**: Calculates the sum total of numeric values in each group.

--     * **`COUNT(column / *)`**: Counts the number of rows or non-null values in each group.

--     * **`AVG(column)`**: Computes the arithmetic mean of values in each group.

--     * **`MIN(column)`**: Identifies the minimum value within each group.

--     * **`MAX(column)`**: Identifies the maximum value within each group.

-- * Crucial Interview Rules & Traps for Aggregate Functions:

--   * **1. Master Rules of `SUM()`:**

--     * **Rule ① (`NULL` Handling):** `SUM(column)` completely **ignores `NULL` values** during calculation.

--     * Rule ② (The Empty Table / All-NULL Trap): If all rows in a group contain `NULL`, or if the table is completely empty, `SUM()` returns **`NULL` (NOT `0`)**!

--       * Production Best Practice: To guarantee a numeric `0` for executive dashboards, wrap with `COALESCE()` or `IFNULL()`:
SELECT country, COALESCE(SUM(score), 0) AS total_score 
FROM customers 
GROUP BY country;

--     * **Rule ③ (`SUM(DISTINCT col)` vs. `SUM(col)`):**

--       * `SUM(score)` sums all values including duplicates (e.g., scores `500, 500, 200` $\rightarrow$ `1200`).

--       * `SUM(DISTINCT score)` removes duplicate numbers before calculating (e.g., `500 + 200` $\rightarrow$ `700`).

--     * **Rule ④ (Conditional Aggregation with `SUM`):**

--       * In MySQL, boolean expressions return `1` (`TRUE`) or `0` (`FALSE`). You can count specific conditions using `SUM()` without a `WHERE` clause:
-- Counts customers with score > 500 in MySQL:
SELECT SUM(score > 500) AS high_scorers FROM customers;

-- ANSI SQL Standard equivalent using CASE:
SELECT SUM(CASE WHEN score > 500 THEN 1 ELSE 0 END) AS high_scorers FROM customers;

--   * **2. The 4 Variants of `COUNT` (Top Interview Comparison):**
--     | Function | What it Counts | Counts `NULL`s? | Performance |
--     | :--- | :--- | :---: | :--- |
--     | **`COUNT(*)`** | Total rows in the table/group | YES | Highly optimized by query optimizer |
--     | **`COUNT(1)`** | Rows where constant expression `1` is generated | YES | Identical execution plan to `COUNT(*)` |
--     | **`COUNT(column)`** | Total rows where designated `column` is NOT NULL | NO (Ignores `NULL`) | Slightly slower (must check column nullability) |
--     | **`COUNT(DISTINCT col)`| Total **unique non-null values in column | NO (Ignores `NULL`) | Requires sorting/hashing in temp buffer |

--   * **3. The `AVG()` NULL Trap:**

--     * `AVG(column)` calculates mathematically as:
--       $$\text{AVG}(\text{column}) = \frac{\text{SUM}(\text{column})}{\mathbf{COUNT}(\mathbf{column})}$$

--     * The Trap: It divides by the count of non-null rows, NOT total rows!

--     * Example: If 4 employee salaries are `10000`, `20000`, `NULL`, `NULL`:

--       * `AVG(salary)` = $\frac{10000 + 20000}{2} =$ **`15000`** (NOT $\frac{30000}{4} = 7500$).

--     * Fix: If business requirements demand calculating average across the entire workforce (treating non-salaried as 0):
SELECT AVG(COALESCE(salary, 0)) AS company_wide_avg FROM employees;

-- * Standard GROUP BY Query Syntax:
SELECT column1, column2, AGGREGATE_FUNCTION(column3)
FROM table_name
[WHERE condition]
GROUP BY column1, column2
[HAVING condition]
[ORDER BY column];

-- * Practice Questions:

--   * Q1. Find the total score for each country:
SELECT country, SUM(score) AS total_score 
FROM customers 
GROUP BY country;

--     * Step-by-Step Row Calculation:

--       * Germany: Maria (`350`) + Martin (`500`) = **`850`**

--       * USA: John (`900`) + Peter (`0`) = **`900`**

--       * UK: Georg (`750`) = **`750`**

--   * Q2. Find the total score and total number of customers for each country:
SELECT country, SUM(score) AS total_score, COUNT(id) AS customer_count 
FROM customers 
GROUP BY country;

--     * Result Set:
--       | country | total_score | customer_count |
--       | :--- | :---: | :---: |
--       | Germany | 850 | 2 |
--       | USA | 900 | 2 |
--       | UK | 750 | 1 |

-- * **Note on Alias (`AS`):**

--   * **`AS` (alias):** A shorthand label or user-friendly column title assigned to an expression or table in a query (e.g., `SUM(score) AS total_score`). Improves readability in result headers.

-- * Key Rules of GROUP BY in MySQL:

--   * Rule 1: The Golden Rule of Projection:

--     * **All columns in the `SELECT` list (except aggregate functions) must appear in the `GROUP BY` clause.**

--     * I.e., every selected column must be either aggregated or included in `GROUP BY`!

--   * Rule 2: Aggregate functions can be used on non-grouped columns:
SELECT department, AVG(salary) 
FROM employees 
GROUP BY department;

--     * Here, `department` is the grouping column, and `salary` is aggregated via `AVG()`. This is 100% valid.

--   * **Rule 3: Understanding the Non-Aggregated Column Error (`ONLY_FULL_GROUP_BY`):**

--     * Suppose you execute the following query:
-- ❌ INCORRECT QUERY (Throws MySQL Error 1055):
SELECT first_name, country, SUM(score) 
FROM customers 
GROUP BY country;

--       * Why this produces an error: In the `SELECT` statement, you defined `first_name`, `country`, and `SUM(score)`. But in `GROUP BY`, you only grouped by `country`. Since Germany has two customers (Maria and Martin), MySQL does not know which `first_name` should be printed on the single summary row for Germany!

--     * The Correct Resolution:
-- ✔️ CORRECT: Include all non-aggregated columns in GROUP BY:
SELECT first_name, country, SUM(score) 
FROM customers 
GROUP BY country, first_name;

--       * Every column in `SELECT` is now either in `GROUP BY` or aggregated.

--     * Another Classic Wrong vs. Right Comparison:
-- ❌ WRONG (name is not in GROUP BY):
SELECT name, department, AVG(salary) 
FROM employees 
GROUP BY department;

-- ✔️ RIGHT (Only department and aggregate function projected):
SELECT department, AVG(salary) 
FROM employees 
GROUP BY department;

-- * Grouping on Multiple Columns:

--   * You can create multi-dimensional summary groups by grouping on two or more columns:
SELECT department, job_title, COUNT(*) AS total_employees 
FROM employees 
GROUP BY department, job_title;

--     * Explanation: Creates a unique group for every distinct combination of department and job title (e.g., IT-Developer, IT-Manager, HR-Recruiter).

-- * WHERE vs. HAVING: Crucial Distinction:

--   * **`WHERE`** is applied before grouping $\rightarrow$ `WHERE` filters individual rows.

--   * **`HAVING`** is applied after grouping $\rightarrow$ `HAVING` filters aggregated summary groups.

--   * *Example using `HAVING` to filter groups (Find departments with more than 1 employee):*
SELECT department, COUNT(*) AS total_employees
FROM employees
GROUP BY department
HAVING COUNT(*) > 1;

--   * **Critical Interview Question ①: Can we use `HAVING` without a `GROUP BY` clause?**

--     * Answer: YES!

--     * If `GROUP BY` is omitted, the query optimizer treats the entire table as a single implicit aggregate group.

--     * Valid Query Example:
-- Returns result only if the company-wide average score exceeds 500:
SELECT AVG(score) AS overall_avg 
FROM customers 
HAVING AVG(score) > 500;

--   * **Critical Interview Question ②: Performance Distinction (`WHERE` vs. `HAVING`):**

--     * Question: "If you want to report average salary for the 'IT' department only, should you filter by `WHERE department = 'IT'` or `HAVING department = 'IT'`?"

--     * Answer: **Always filter using `WHERE`!**

--     * Why:

--       * **`WHERE department = 'IT'`**: Evaluates at disk/index scan time. Non-IT records are discarded immediately before entering CPU-intensive grouping memory buffers.

--       * **`HAVING department = 'IT'`**: Forces the database engine to group all departments across millions of rows, compute unnecessary aggregate calculations, and then throw them away in the final step. Filtering late with `HAVING` causes extreme query degradation.

-- * Using ORDER BY with GROUP BY:

--   * `ORDER BY` is executed after grouping and can sort the final aggregated result set:
SELECT department, COUNT(*) AS total 
FROM employees 
GROUP BY department 
ORDER BY total DESC;

-- * Complete Clause Execution Order Example:

--   * Observe how clauses are sequenced:
-- Only IT employees considered first, then grouped, then filtered by average salary:
SELECT department, AVG(salary) AS avg_salary
FROM employees
WHERE department = 'IT'
GROUP BY department
HAVING AVG(salary) > 75000
ORDER BY avg_salary DESC;

--     * Step-by-Step Processing:

--       1. `FROM employees`: Locates table.

--       2. `WHERE department = 'IT'`: Filters out non-IT rows before grouping.

--       3. `GROUP BY department`: Groups surviving IT employees.

--       4. `HAVING AVG(salary) > 75000`: Evaluates aggregate filter on the group.

--       5. `SELECT department, AVG(salary)`: Projects columns.

--       6. `ORDER BY avg_salary DESC`: Sorts the final groups.

-- * GROUP BY with ROLLUP (Subtotals and Grand Totals):

--   * When you add `WITH ROLLUP`, MySQL generates additional hierarchical summary rows for subtotals and the grand total, where the grouped column becomes `NULL`.

--   * To make the report professional and readable, replace that `NULL` with a clean label like `'TOTAL'` using `IFNULL()`:
SELECT IFNULL(country, 'TOTAL') AS COUNTRY, SUM(score) AS GROUPsCORE 
FROM customers 
GROUP BY country WITH ROLLUP;

--   * Output Table with ROLLUP:
--     | COUNTRY | GROUPsCORE | Note |
--     | :--- | :---: | :--- |
--     | Germany | 850 | Subtotal for Germany |
--     | UK | 750 | Subtotal for UK |
--     | USA | 900 | Subtotal for USA |
--     | TOTAL | 2500 | ★ Grand Total across all customers ★ |

-- * **The `GROUP_CONCAT()` Aggregate Function:**

--   * When you want to retain details while still grouping rows, MySQL provides the specialized `GROUP_CONCAT()` function to concatenate string values from multiple rows into a single comma-separated string:
SELECT department, GROUP_CONCAT(name) AS employees
FROM employees
GROUP BY department;

--     * Example Output:
--       | department | employees |
--       | :--- | :--- |
--       | IT | Alice,Bob,Charlie |
--       | HR | David,Emma |

-- * Best Practice Rules for GROUP BY:

--   1. **Always ensure non-aggregated columns in `SELECT` are in `GROUP BY`.**

--   2. **Use `HAVING` for aggregated filters, and `WHERE` for row-level filters.**

--   3. **Use aliases (`AS`) for readability** in all aggregate expressions.

--   4. **Use `WITH ROLLUP`** whenever executive reports require subtotals and grand totals.

--   5. Be careful with SQL modes: MySQL sometimes allows non-standard `GROUP BY` when `ONLY_FULL_GROUP_BY` is disabled. This is strongly discouraged because it produces non-deterministic, unpredictable results in production.

-- * Fundamental Limitation of the GROUP BY Clause:

--   * **Using the `GROUP BY` clause, you cannot perform aggregation and preserve granular row-level details at the same time in standard queries.**

--   * Once rows are grouped by a column, individual row identity is collapsed into the group summary.

--   * To overcome this limitation and perform aggregations while preserving every individual row, modern SQL uses Window Functions (e.g., `SUM(score) OVER (PARTITION BY country)`).

-- ---

-- ------------------------------------------------------------
-- 20.10 Visual Diagrams & Architectural Reference
-- ------------------------------------------------------------

-- ------------------------------------------------------------
-- 1. ASK Your Data: The SQL Query Mental Model
-- ------------------------------------------------------------

-- * Definition: Think of the database as something you ask questions to: your business question becomes an SQL query, and the answer comes back as a table.

-- * Description: This diagram illustrates the complete closed query lifecycle across 4 distinct phases:

--   1. The Business Question: Natural human query (e.g., "Who are our customers from Germany?").

--   2. The SQL Query: Formal declarative query formulation (`SELECT name, country FROM customers WHERE country = 'Germany';`).

--   3. Database Processing: The DBMS engine reads physical disk blocks into memory, evaluates filtering predicates, and discards non-matching rows.

--   4. The Tabular Result Set: Clean virtual table returned to the application screen or API.

-- ---

-- ------------------------------------------------------------
-- 2. The 9 Essential SQL Query Clauses
-- ------------------------------------------------------------

-- * Definition: The main keywords (clauses) used to build a query: where the data comes from, how it is filtered, grouped and sorted.

-- * Description: A visual taxonomy classifying all 9 query clauses branching out from a central SQL query engine:

--   * **`SELECT`**: Specifies attributes to project and display.

--   * **`DISTINCT`**: Eliminates duplicate identical rows.

--   * **`TOP` / `LIMIT`**: Restricts the maximum number of returned rows.

--   * **`FROM`**: Identifies source table(s) on disk.

--   * **`JOIN`**: Merges records from related tables.

--   * **`WHERE`**: Filters rows using boolean conditions (predicates).

--   * **`GROUP BY`**: Summarizes rows into aggregated groups.

--   * **`HAVING`**: Filters summarized groups using aggregate functions.

--   * **`ORDER BY`**: Sorts final result rows in ascending (`ASC`) or descending (`DESC`) order.

-- ---

-- ------------------------------------------------------------
-- 3. HOW SQL WORKS: SELECT * vs. Specific Column Projection
-- ------------------------------------------------------------

-- * Definition: The difference between reading all columns (`SELECT *`) and reading only the columns you need (`SELECT col1, col2`).

-- * Description: A chalkboard-style architectural comparison showing physical query execution:

--   * **Step ① (`FROM Table`):** Identifies and locates the table on disk storage.

--   * **Method A (`SELECT *`):** Keeps all columns (100% table width), resulting in high disk I/O, heavy memory allocation, and large network payloads.

--   * **Method B (`SELECT col1, col2`):** Extracts only the designated attributes, minimizing network byte transfer and allowing MySQL to utilize fast Covering Indexes.

-- ---

-- ------------------------------------------------------------
-- 4. WHERE Clause Filtering Pipeline & Query Execution Order
-- ------------------------------------------------------------

-- * Definition: The order in which the database actually runs a query that has a `WHERE` filter.

-- * Description: Highlights that while SQL queries are written from left to right (`SELECT ... FROM ... WHERE ...`), the physical database engine executes in a strict logical order:

--   * **Step ① `FROM customers`:** Reads the raw table from storage into the buffer cache.

--   * **Step ② `WHERE score > 500`:** Funnels every row through the boolean predicate filter, discarding non-matching rows (`FALSE` / `UNKNOWN`) and keeping matching rows (`TRUE`).

--   * **Step ③ `SELECT name, country`:** Projects and outputs only the specified columns of the surviving records.

-- ---

-- ------------------------------------------------------------
-- 5. WHERE Operators Taxonomy Tree (The 5 Operator Families)
-- ------------------------------------------------------------

-- * Definition: All the kinds of operators you can use inside `WHERE`.

-- * Description: A hierarchical tree diagram mapping out the 5 specialized operator families used in row-level filtering:

--   1. Comparison Operators: `=`, `<>`, `!=`, `>`, `>=`, `<`, `<=` (compares two expressions or values).

--   2. Logical Operators: `AND`, `OR`, `NOT` (combines or negates conditions using boolean algebra).

--   3. Range Operator: `BETWEEN ... AND ...` (inclusive boundary filtering).

--   4. Membership Operator: `IN`, `NOT IN` (matches against a discrete list or subquery set).

--   5. Search Operator: `LIKE` (wildcard string pattern matching with `%` and `_`).

-- ---

-- ------------------------------------------------------------
-- 6. Comparison Operators: Condition Anatomy & Master Reference
-- ------------------------------------------------------------

-- * Definition: Operators that compare two values and return `TRUE`, `FALSE`, or `UNKNOWN`.

-- * Description: Details the tripartite anatomy of a condition (`Expression [Operator] Expression`), illustrates the 5 practical ways to compare two things in SQL (`Column=Column`, `Column=Value`, `Function=Value`, `Expression=Value`, `Subquery=Value`), and presents the master reference matrix of all 6 comparison operators with their definitions, syntax, and boolean outcomes.

-- ---

-- ------------------------------------------------------------
-- 7. Row-by-Row Predicate Filtering Demonstration (WHERE Country = 'USA')
-- ------------------------------------------------------------

-- * Definition: A step-by-step picture of how the database checks the condition on each row and keeps or drops it.

-- * Description: Step-by-step visual demonstration of applying `WHERE Country = 'USA'` to the `customers` table:

--   * Rows for Maria (`Germany`), Georg (`UK`), and Martin (`Germany`) evaluate to **`FALSE`** and are discarded ❌.

--   * Rows for John (`USA`) and Peter (`USA`) evaluate to **`TRUE`** and are kept ✔️.

--   * The resulting output virtual table contains only the surviving records (John and Peter).

-- ---

-- ------------------------------------------------------------
-- 8. Whole Table vs. Specific Column Projection Architecture
-- ------------------------------------------------------------

-- * Definition: Compares the memory, disk and network cost of `SELECT *` vs. selecting only some columns.

-- * Description: Illustrates the internal pipeline differences between `SELECT *` (reading all column blocks into the buffer pool and sending maximum bytes over the network wire) and targeted column selection (reading only required columns, enabling covering index lookups without touching table data pages, and dramatically shrinking network bandwidth).

-- ---

-- ------------------------------------------------------------
-- 9. Logical Operators Master Reference Table (AND, OR, NOT)
-- ------------------------------------------------------------

-- * Definition: A visual summary card classifying the 3 core boolean operators in SQL, their formal evaluation rules, and logical truth results.

-- * Description: Details `AND` (all conditions must be TRUE), `OR` (at least one condition must be TRUE), and `NOT` (reverses the condition / excludes matching rows) with side-by-side boolean formula pills and quick-recap reference.

-- ---

-- ------------------------------------------------------------
-- 10. Logical Operator: AND (All Conditions Must Be TRUE)
-- ------------------------------------------------------------

-- * Definition: A logical conjunction operator that links two or more conditions and evaluates to `TRUE` if and only if every condition predicate is satisfied.

-- * Description: Demonstrates the row-by-row filtering evaluation for `WHERE Country = 'USA' AND Score > 500`. Only John satisfies both condition 1 (`Country = 'USA'`) and condition 2 (`Score > 500`), while Peter and Georg fail one condition and are discarded.

-- ---

-- ------------------------------------------------------------
-- 11. Logical Operator: OR (At Least One Condition Must Be TRUE)
-- ------------------------------------------------------------

-- * Definition: A logical disjunction operator that evaluates to `TRUE` if any of the specified conditions is met, discarding records only when all conditions fail.

-- * Description: Illustrates evaluation for `WHERE Country = 'USA' OR Score > 500`. Records for John (meets both), Georg (meets score > 500), and Peter (meets Country = 'USA') all survive to form the final result set.

-- ---

-- ------------------------------------------------------------
-- 12. Logical Operator: NOT (Reverses Condition / Excludes Matches)
-- ------------------------------------------------------------

-- * Definition: A logical negation operator that inverts the truth value of a condition predicate, converting matching rows into non-matches.

-- * Description: Demonstrates the evaluation of `WHERE NOT (Country = 'USA')`. Rows matching 'USA' (John, Peter) evaluate to `FALSE` and are excluded, while non-USA customers (Maria, Georg, Martin) evaluate to `TRUE` and survive.

-- ---

-- ------------------------------------------------------------
-- 13. Range Operator: BETWEEN … AND … (Inclusive Boundaries)
-- ------------------------------------------------------------

-- * Definition: A range evaluation operator that tests whether an attribute's value falls within a specified interval, including both boundary endpoints.

-- * Description: Displays a number line with lower bound (100) and upper bound (500), showing that values within the interval (Maria: 350) and exactly on the boundary (Martin: 500) are kept, while out-of-bound records (Peter: 0, Georg: 750, John: 900) are discarded. Also highlights functional equivalence to `>= 100 AND <= 500`.

-- ---

-- ------------------------------------------------------------
-- 14. Membership Operators: IN & NOT IN (Discrete Set Evaluation)
-- ------------------------------------------------------------

-- * Definition: Checks whether a value is in a list of values (or in the result of a subquery).

-- * Description: Features a top clipboard listing allowed target countries (`'Germany'`, `'USA'`), contrasting `IN` (kept if in list) against `NOT IN` (kept if absent from list) across our 5 customer records. Highlights the recommended syntax shortcut over verbose chained `OR` statements.

-- ---

-- ------------------------------------------------------------
-- 15. Search Operator: LIKE & SQL Wildcards (Pattern Matching)
-- ------------------------------------------------------------

-- * Definition: A string pattern matching operator using wildcards (`%` for zero/multiple characters, `_` for exact single character) to filter text columns flexibly.

-- * Description: Breaks down wildcard mechanics with a central pattern search bar branching into `%` (Anything: 0, 1, Many) and `_` (Exact 1 char), supported by 4 dedicated comparison columns evaluating `LIKE 'M%'`, `LIKE '%in'`, `LIKE '%r%'`, and `LIKE '__b%'`.

-- ---

-- ------------------------------------------------------------
-- 16. NULL Check Operators: IS NULL & IS NOT NULL (Three-Valued Logic)
-- ------------------------------------------------------------

-- * Definition: Checks for missing (unknown) values, following SQL's three-valued logic (TRUE / FALSE / UNKNOWN).

-- * Description: Clarifies the core difference between `NULL` (missing/unknown), `0` (numeric value), and `''` (empty string). Illustrates why standard equality (`= NULL`) evaluates to `UNKNOWN` and silently returns 0 rows, demonstrating proper evaluation using `IS NULL` and `IS NOT NULL`.

-- ---

-- ------------------------------------------------------------
-- 17. Sorting in SQL: ORDER BY Clause Architecture
-- ------------------------------------------------------------

-- * Definition: Sorts rows in ascending (`ASC`) or descending (`DESC`) order by one or more columns.

-- * Description: Visualizes query execution order (`FROM` ➔ `SELECT` ➔ `ORDER BY`), contrasting single column sorting (highest score first) with nested sequential sorting (`country ASC, score DESC`) where ties within Germany and the USA are resolved by score magnitude.

-- ---

-- ------------------------------------------------------------
-- 18. Grouping in SQL: GROUP BY Clause & Data Aggregation
-- ------------------------------------------------------------

-- * Definition: Puts rows with the same value into groups and calculates totals (SUM, COUNT, AVG…) for each group.

-- * Description: Breaks down the 3-step physical aggregation lifecycle: reading the 5 raw customer records, bucketing into distinct countries (Germany: 350+500=850, USA: 900+0=900, UK: 750), and projecting the final 3-row summary table.

-- ---

-- ------------------------------------------------------------
-- 19. GROUP BY Rules, WITH ROLLUP & GROUP_CONCAT()
-- ------------------------------------------------------------

-- * Definition: Extra grouping rules: the `ONLY_FULL_GROUP_BY` rule, subtotals with `WITH ROLLUP`, and joining text with `GROUP_CONCAT()`.

-- * Description: Illustrates why non-aggregated columns like `first_name` fail when omitted from `GROUP BY`, demonstrates `WITH ROLLUP` grand totals paired with `IFNULL()`, and shows `GROUP_CONCAT()` merging group members into comma-separated text lists.

-- ---

--     1. `Column1 = Column2` (`first_name = last_name`)

--     2. `Column1 = Value` (`country = 'USA'`)

--     3. `Function = Value` (`UPPER(first_name) = 'JOHN'`)

--     4. `Expression = Value` (`price * quantity = 1000`)

-- * **Range Operator (`BETWEEN … AND …`):**

-- * Row-by-Row Predicate Evaluation:

-- ---

-- ------------------------------------------------------------
-- 20.12 SQL Clauses Deep Dive & Execution Order (Detailed Guide)
-- ------------------------------------------------------------

-- * What is it? The `HAVING` clause in SQL is used to filter groups of rows created by the `GROUP BY` clause.

-- * Purpose: It is used to filter the aggregated data. 

--   * `WHERE` filters individual rows (before grouping).

--   * `HAVING` filters grouped/aggregated results (after grouping).

-- * Standard Syntax:
SELECT column1, AGGREGATE_FUNCTION(column2)
FROM table_name
WHERE condition
GROUP BY column1
HAVING aggregate_condition
ORDER BY column1;

-- * Key Rules for HAVING Clause:

--   1. `HAVING` always comes after `GROUP BY`. It works on grouped results.

--   2. You can use aggregate functions inside `HAVING` (e.g., `HAVING COUNT(*) > 5;` or `HAVING AVG(salary) > 60000;`).

--   3. If there is no `GROUP BY`, `HAVING` still works. $\rightarrow$ It will treat the entire result as a single group.

--   4. `WHERE` filters rows, `HAVING` filters groups. $\rightarrow$ Often, you’ll use both together.

-- * Examples:

--   * Simple HAVING with COUNT:
SELECT department, COUNT(*) AS total_employees 
FROM employees 
GROUP BY department 
HAVING COUNT(*) > 1;

--   * HAVING with AVG:
SELECT department, AVG(salary) AS avg_salary 
FROM employees 
GROUP BY department 
HAVING AVG(salary) > 70000;

-- ------------------------------------------------------------
-- 2. WHERE + HAVING Together
-- ------------------------------------------------------------

-- * Concept: They are most commonly used together. `WHERE` filters rows before grouping, and `HAVING` filters groups after aggregation.

-- * Example Query:
SELECT country, sum(score)
FROM customers 
WHERE score > 400
GROUP BY country
HAVING sum(score) > 800;

-- * Practice Question 1: Find the average score for each country considering only customers with a score not equal to zero, and return only those countries with an average score greater than 430.
SELECT country, avg(score) as 'avg_score' 
FROM customers 
WHERE score != 0 
GROUP BY country 
HAVING avg(score) > 430 
ORDER BY country;

-- ------------------------------------------------------------
-- 3. HAVING without GROUP BY / HAVING with Multiple Conditions
-- ------------------------------------------------------------

-- * HAVING without GROUP BY: MySQL allows this. The entire table is treated as one single group.
SELECT SUM(salary) AS total_salary
FROM employees
HAVING SUM(salary) > 300000;

-- * HAVING with Multiple Conditions: You can combine conditions using `AND` / `OR`.
SELECT department, COUNT(*) AS total, AVG(salary) AS avg_salary
FROM employees
GROUP BY department
HAVING COUNT(*) > 1 AND AVG(salary) > 60000;

-- ------------------------------------------------------------
-- 4. Differences Between WHERE and HAVING (WHERE vs HAVING)
-- ------------------------------------------------------------
-- | Feature | WHERE Clause | HAVING Clause |
-- | :--- | :--- | :--- |
-- | When it works | Works on rows before grouping. Filters the rows. | Works on groups after grouping. Filters the grouped/aggregated result. |
-- | Purpose | Used to fetch data/values from the table according to the given condition. | Used to fetch data/values from the groups according to the given condition. |
-- | Without GROUP BY | Can be executed without `GROUP BY`. | Always executed with `GROUP BY` (though MySQL supports it without). |
-- | Aggregate Functions| Aggregation functions are NOT allowed (`WHERE SUM(val)` is invalid). | Aggregation functions are allowed (`HAVING AVG(salary) > 60000`). |
-- | Execution Order | Executed before `GROUP BY`. | Executed after `GROUP BY`. |
-- | Usage | Used with `SELECT`, `UPDATE`, `DELETE`. | Used only with `SELECT`. |
-- | Filter Type | Pre-filter (e.g., `WHERE salary > 1000`). | Post-filter (e.g., `HAVING AVG(salary) > 60000`). |

-- * Best Practices:

--   * Always use `WHERE` when filtering raw rows $\rightarrow$ it is much faster.

--   * Use `HAVING` only when filtering aggregated results.

--   * You can use both together (`WHERE` for the row and `HAVING` for the group).

-- ------------------------------------------------------------
-- 5. Order of Execution vs Coding Order in SQL
-- ------------------------------------------------------------

-- * Order of Coding (How we write):
--   `SELECT` $\rightarrow$ `FROM` $\rightarrow$ `WHERE` $\rightarrow$ `GROUP BY` $\rightarrow$ `HAVING` $\rightarrow$ `ORDER BY` $\rightarrow$ `LIMIT / TOP`

-- * Order of Execution (How Engine executes):

--   1. FROM: Locate the table.

--   2. WHERE: Filter rows.

--   3. GROUP BY: Make groups.

--   4. HAVING: Filter groups.

--   5. SELECT: Project columns.

--   6. ORDER BY: Sort the final result.

--   7. TOP / LIMIT: Restrict the result size.

-- ------------------------------------------------------------
-- 6. ORDER BY and GROUP BY Rules
-- ------------------------------------------------------------

-- * Can we define ORDER BY Before the GROUP BY?

--   * No. You cannot define `ORDER BY` before `GROUP BY` in SQL.

--   * `ORDER BY` always works after grouping (and after `HAVING` if used).

--   * You cannot sort the data before `GROUP BY` because SQL first creates groups, then sorts the final grouped result.

--   * Important Note: You can sort rows before grouping only inside a subquery, and even then the final order is not guaranteed. In the main query, `ORDER BY` always comes after `GROUP BY` (use `ORDER BY` on the final result).

-- * Can we use GROUP BY without WHERE?

--   * Yes. The `WHERE` clause is optional.

--   * `GROUP BY` simply groups all rows in the table.

--   * Grouping without WHERE:
SELECT loan_type, SUM(amount) AS total_amount FROM Loan GROUP BY loan_type;

--   * Grouping with WHERE (Optional):
SELECT loan_type, SUM(amount) AS total_amount FROM Loan WHERE branch_id = 1 GROUP BY loan_type;

-- ------------------------------------------------------------
-- 7. ORDER BY with or without WHERE
-- ------------------------------------------------------------

-- * Yes, you can use `ORDER BY` both with or without a `WHERE` clause.

-- * ORDER BY without WHERE:

--   * When you just want to sort all rows in a table, no filtering is needed.

--   * `SELECT * FROM Customer ORDER BY name ASC;` (Sorts all alphabetically).

-- * ORDER BY with WHERE:

--   * When you want to filter rows first, then sort only the filtered results.
SELECT * FROM Customer
WHERE city = 'Mumbai'
ORDER BY balance DESC;

-- * Notes:

--   * `ORDER BY` is always applied after filtering (`WHERE`) and grouping (`GROUP BY`).

--   * You can sort by Single column, Multiple columns, or Calculated expression.

-- ------------------------------------------------------------
-- 8. DISTINCT Keyword
-- ------------------------------------------------------------

-- * Purpose: Used to remove duplicate values from your data.

-- * Each value will appear only once in data.

-- * Example Q1: Return unique list of all the countries.
SELECT DISTINCT country FROM customers;

-- * Bad habit with DISTINCT: Do not use `DISTINCT` unless it is necessary, as it requires sorting/hashing and can slow down your query.

-- ------------------------------------------------------------
-- 9. TOP / LIMIT in SQL
-- ------------------------------------------------------------

-- * Purpose: Used to limit your data. It restricts the number of rows returned in the result (i.e., how many rows you want to see).

-- * Sorting with LIMIT and TOP:

--   * In MySQL, `TOP` is NOT supported. Instead, MySQL uses the `LIMIT` clause.

-- * Example: Show Top 5 richest accounts.
SELECT * FROM Account ORDER BY balance DESC LIMIT 5; 

-- * LIMIT with Offset: `LIMIT` also allows you to skip some rows using `LIMIT offset, count`.
SELECT * FROM Customer ORDER BY balance DESC LIMIT 5, 5; 
--   (Skips the first 5 rows, then shows the next 5 rows).

-- ------------------------------------------------------------
-- 10. Multi Queries in SQL
-- ------------------------------------------------------------

-- * You can execute multiple queries together by separating them with semicolons `;`.
SELECT * FROM customer; 
SELECT * FROM order;

-- * Both queries return results simultaneously (in their respective result sets).

-- ------------------------------------------------------------
-- 11. Static Fix (Static Value in SQL)
-- ------------------------------------------------------------

-- * You can select a fixed (static) value directly, without using any table.
SELECT 123 AS static_number;
SELECT 'VISHAL';

-- * Adding a static column: You can add a static column or fixed value to a real table result.
SELECT id, first_name, 'new_customers' AS customer_type FROM customers;
--   (Each row will now have the new column with the static value 'new_customers').

-- * Example:
SELECT id, name, 'UNKNOWN' AS record_status FROM orders;

-- ------------------------------------------------------------
-- 12. Pro-Tips / Interview Insights (Missing Points)
-- ------------------------------------------------------------

-- * 1. Column Alias in WHERE Clause (Order of Execution Rule)

--   * English: In SQL, you cannot use a column alias (created in the `SELECT` clause) inside the `WHERE` clause. This is because the database engine executes the `WHERE` clause before the `SELECT` clause, so it doesn't know the alias exists yet! However, you can use the alias in the `ORDER BY` clause because `ORDER BY` executes after `SELECT`.

--   * Example Error: 
-- ERROR! 'annual_salary' is an alias, WHERE doesn't know it yet
SELECT (salary * 12) AS annual_salary FROM employees WHERE annual_salary > 50000; 

--   * Correct Way:
SELECT (salary * 12) AS annual_salary FROM employees WHERE (salary * 12) > 50000;

-- * 2. Real-world Pagination using LIMIT and OFFSET

--   * English: In real-world applications (like e-commerce sites showing 10 products per page), SQL uses `LIMIT` with `OFFSET` to manage pages. 

--     * Page 1 (Shows first 10 products):
SELECT * FROM products LIMIT 10 OFFSET 0;

--     * Page 2 (Skips first 10, shows next 10):
SELECT * FROM products LIMIT 10 OFFSET 10;

--     * Page 3 (Skips first 20, shows next 10):
SELECT * FROM products LIMIT 10 OFFSET 20;

-- * 3. Single Quotes vs Double Quotes (String Quote Rule)

--   * English: Always use single quotes (`'...'`) for strings and dates in SQL, never double quotes (`"..."`). While MySQL might forgivingly accept double quotes depending on its SQL mode, standard SQL (like PostgreSQL, Oracle, SQL Server) strictly treats double quotes as identifiers (like table or column names), not strings.

--   * Correct Syntax:
SELECT * FROM customers WHERE country = 'India';

-- * 4. The Trailing Comma Error (Syntax Rule)

--   * English: Be very careful not to leave a trailing comma at the end of your `SELECT` list right before the `FROM` keyword. This is one of the most common beginner syntax errors.

--   * Incorrect (Syntax Error):
SELECT name, city, FROM customers; 

--   * Correct:
SELECT name, city FROM customers;

-- ---

-- ======================================================================
-- 🎯 Practice Questions (salesdb sample data) — try first, then look at the answer
-- ======================================================================
-- Run 00-Setup-Sample-Data.sql once before this section.

USE salesdb;

-- Q1. Customers with a score between 400 and 800, from any country starting with "G" or "U".
SELECT firstname, country, score
FROM customers
WHERE score BETWEEN 400 AND 800
  AND (country LIKE 'G%' OR country LIKE 'U%');

-- Q2. Total sales per customer, only customers with more than 50 total, highest first.
SELECT customerid, SUM(sales) AS total_sales
FROM orders
GROUP BY customerid
HAVING SUM(sales) > 50
ORDER BY total_sales DESC;

-- Q3. Orders with missing ship address, or shipped in February 2025.
SELECT orderid, shipaddress, shipdate
FROM orders
WHERE shipaddress IS NULL
   OR shipdate BETWEEN '2025-02-01' AND '2025-02-28';
