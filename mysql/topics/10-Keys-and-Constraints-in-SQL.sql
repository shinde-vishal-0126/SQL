-- ======================================================================
-- Topic 10: Keys & Constraints in SQL
-- ======================================================================

-- ------------------------------------------------------------
-- 📖 In Simple Words
-- ------------------------------------------------------------

-- * Definition: Keys and constraints are rules on columns that keep data correct: PRIMARY KEY (unique id), FOREIGN KEY (link to another table), UNIQUE, NOT NULL, CHECK and DEFAULT.

-- * Real-life example: Like rules at a bank: every account has a unique number, every transaction must point to a real account, and the balance cannot be negative.

-- * 🧩 Syntax:
--     CREATE TABLE child (
--       id        INT PRIMARY KEY,                 -- unique + not null
--       code      VARCHAR(20) NOT NULL UNIQUE,     -- required, no duplicates
--       qty       INT CHECK (qty >= 0),            -- custom rule
--       status    VARCHAR(10) DEFAULT 'new',       -- value when none is given
--       parent_id INT,
--       CONSTRAINT fk_name FOREIGN KEY (parent_id)
--         REFERENCES parent (id) ON DELETE CASCADE -- link to another table
--     );
--     ALTER TABLE t ADD CONSTRAINT name UNIQUE (col);

-- * Syntax explained (each part):
--   - PRIMARY KEY → unique id of each row; never NULL; one per table
--   - FOREIGN KEY … REFERENCES → value must exist in the parent table
--   - ON DELETE CASCADE / SET NULL → what happens to child rows when the parent row is deleted
--   - UNIQUE / NOT NULL / CHECK / DEFAULT → no duplicates / value required / custom condition / automatic value

-- * Example on salesdb (run 00-Setup-Sample-Data.sql first):
USE salesdb;
INSERT INTO orders (orderid, productid, customerid) VALUES (1, 101, 1);    -- fails: PRIMARY KEY
INSERT INTO orders (orderid, productid, customerid) VALUES (50, 999, 1);  -- fails: FOREIGN KEY

-- * Example explained (step by step):
--   1. orderid 1 already exists, so the PRIMARY KEY rule rejects the first insert.
--   2. Product 999 does not exist in products, so the FOREIGN KEY rule rejects the second insert (MySQL salesdb).
--   3. Constraints stop bad data before it is saved.

-- ------------------------------------------------------------
-- 10.1 What are Key Constraints?
-- ------------------------------------------------------------

-- * English: Key constraints are rules applied to columns in a table to ensure data correctness, integrity, uniqueness, and proper identification of rows.

-- ------------------------------------------------------------
-- 10.2 SQL Constraints (Point-wise Detail)
-- ------------------------------------------------------------

-- * 1. PRIMARY KEY

--   * Properties: Uniquely identifies each record. Unique for each row, CANNOT be NULL. A table can have only ONE primary key. Can be single or multiple columns (composite).

--   * Code Example:
CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    Name VARCHAR(50),
    Age INT
);

-- * 2. FOREIGN KEY

--   * Properties: Ensures referential integrity. References the primary key of another table. Can contain duplicate values and can be NULL.

--   * ON DELETE CASCADE / ON UPDATE CASCADE: Deletes or updates child rows automatically when the parent row is modified.

--   * Code Example:
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID) ON DELETE CASCADE
);

-- * 3. UNIQUE KEY

--   * Properties: Prevents duplicate values. Ensures all values in a column are unique. Unlike primary key, a table can have MULTIPLE unique keys. Can allow NULL values.

--   * Code Example:
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    Email VARCHAR(100) UNIQUE
);

-- * 4. NOT NULL

--   * Properties: Ensures that a column cannot have a NULL value. Often used alongside Primary Key.

--   * Code Example: `ProductName VARCHAR(50) NOT NULL`

-- * 5. CHECK Constraint

--   * Properties: Ensures that values in a column meet a specific logical condition (e.g., Age >= 18).

--   * Code Example:
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    Age INT CHECK (Age >= 18)
);

-- * 6. DEFAULT Constraint

--   * Properties: Fills a column with a default fixed value if no value is specified during insertion.

--   * Code Example: `OrderDate DATE DEFAULT CURRENT_DATE`

--   * ⚠️ Note: In MySQL 8.0.13+ an expression default must be in brackets: `OrderDate DATE DEFAULT (CURRENT_DATE)`.

-- * 7. AUTO_INCREMENT (or IDENTITY)

--   * Properties: Automatically generates unique numbers for a column (mostly for primary keys).

-- * 8. INDEX

--   * Properties: Technically not a constraint, but used to enforce uniqueness (Unique Index) and massively improve query performance.

-- ------------------------------------------------------------
-- 10.3 Types of Keys (Database Architecture)
-- ------------------------------------------------------------
-- Here is the detailed taxonomy of keys in a relational database:

-- * 1. SUPER KEY: Any set of columns that uniquely identifies a row in a table. It may include extra unnecessary columns. (e.g., `{StudentID, Name, Email}`).

-- * 2. CANDIDATE KEY: A minimal super key. It uniquely identifies a row without any extra columns. (e.g., `{StudentID}` or `{Email}`). Both can identify a row, but we must choose one.

-- * 3. PRIMARY KEY: The one Candidate Key chosen by the database designer to uniquely identify records. (e.g., `{StudentID}`).

-- * 4. ALTERNATE KEY: A candidate key that was not chosen as the primary key. Usually enforced with a UNIQUE constraint. (e.g., `{Email}`).

-- * 5. COMPOSITE KEY: A primary key made of two or more columns together. (e.g., `PRIMARY KEY (StudentID, CourseID)`). Individually they might not be unique, but the combination is unique. Used for Many-to-Many relationships.

-- * 6. SURROGATE KEY: An artificial key created ONLY to uniquely identify a row. It has no business meaning (like an `AUTO_INCREMENT` ID).

-- ------------------------------------------------------------
-- 10.4 The Hierarchy of Keys (Visual Diagram)
-- ------------------------------------------------------------
-- Below is a clear representation of how these keys relate to each other:

-- ------------------------------------------------------------
-- 10.5 UUID vs AUTO_INCREMENT Primary Key
-- ------------------------------------------------------------

-- | Point | AUTO_INCREMENT (INT/BIGINT) | UUID (CHAR(36) / BINARY(16)) |
-- | :--- | :--- | :--- |
-- | Size | 4–8 bytes | 36 bytes as text, 16 bytes as binary |
-- | Order | Always increasing → new rows go at the end of the clustered index | Random (v4) → inserts land anywhere, causing page splits |
-- | Insert speed (InnoDB) | Fast | Slower on big tables (random I/O, fragmentation) |
-- | Secondary indexes | Small (each stores the PK) | Bigger (every secondary index carries the 16/36-byte PK) |
-- | Unique across servers | ❌ Only inside one table/server | ✅ Globally unique (merge, sharding, offline clients) |
-- | Guessable in URLs | ✅ Yes (`/orders/1001` → try 1002) | ❌ Hard to guess |

-- * Best way to store a UUID in MySQL 8:
CREATE TABLE orders (
    id       BINARY(16) PRIMARY KEY,
    customer VARCHAR(50)
);

-- 1 = swap the time parts so values are roughly increasing (index-friendly)
INSERT INTO orders VALUES (UUID_TO_BIN(UUID(), 1), 'Asha');

SELECT BIN_TO_UUID(id, 1) AS id, customer FROM orders;

-- * Common design: keep a `BIGINT AUTO_INCREMENT` primary key for joins/speed and add a separate `UNIQUE` public UUID column for URLs and APIs. Time-ordered IDs (UUID v7, ULID, Snowflake IDs) combine both advantages.

--   * `Students(StudentID PRIMARY KEY, Email UNIQUE, Age CHECK (Age >= 18), City DEFAULT 'Pune')` ➔ StudentID = Primary Key, Email = Alternate Key, `{StudentID, Email}` = Super Key.

-- ---

-- ======================================================================
-- 🎯 Practice Questions (salesdb sample data) — try first, then look at the answer
-- ======================================================================
-- Run 00-Setup-Sample-Data.sql once before this section.

USE salesdb;

-- Q1. Which keys and constraints exist on orders?
SELECT constraint_name, constraint_type
FROM information_schema.table_constraints
WHERE table_schema = 'salesdb' AND table_name = 'orders';

-- Q2. Create a table with PRIMARY KEY, NOT NULL, UNIQUE, CHECK and DEFAULT, then test a CHECK violation.
CREATE TABLE coupons (
  couponid   INT PRIMARY KEY,
  code       VARCHAR(20) NOT NULL UNIQUE,
  discount   INT CHECK (discount BETWEEN 1 AND 50),
  productid  INT,
  active     CHAR(1) DEFAULT 'Y',
  FOREIGN KEY (productid) REFERENCES products (productid)
);
INSERT INTO coupons (couponid, code, discount, productid) VALUES (1, 'SAVE10', 10, 101);
INSERT INTO coupons (couponid, code, discount, productid) VALUES (2, 'BIG90', 90, 101);   -- fails: CHECK
INSERT INTO coupons (couponid, code, discount, productid) VALUES (3, 'BAD', 5, 999);      -- fails: FOREIGN KEY
SELECT * FROM coupons;
DROP TABLE coupons;

-- Q3. Self-referencing foreign key: who is the manager of each employee?
SELECT e.firstname AS employee, m.firstname AS manager
FROM employees e
LEFT JOIN employees m ON m.employeeid = e.managerid;
