-- ======================================================================
-- Topic 10: Keys & Constraints in SQL
-- ======================================================================

-- ------------------------------------------------------------
-- 📖 In Simple Words
-- ------------------------------------------------------------

-- * Definition: Keys and constraints are rules on columns that keep data correct: PRIMARY KEY (unique id), FOREIGN KEY (link to another table), UNIQUE, NOT NULL, CHECK and DEFAULT.

-- * Real-life example: Like rules at a bank: every account has a unique number, every transaction must point to a real account, and the balance cannot be negative.

-- * Example on salesdb (run 00-Setup-Sample-Data.sql first):
SET search_path TO sales;
INSERT INTO orders (orderid, productid, customerid) VALUES (1, 101, 1);    -- fails: PRIMARY KEY
-- (the course PostgreSQL salesdb has no FOREIGN KEYs, so a wrong productid would be accepted there)

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

--   * 🐘 PostgreSQL accepts any expression as a default without brackets: `DEFAULT CURRENT_DATE`, `DEFAULT now()`, `DEFAULT gen_random_uuid()`. (MySQL 8.0.13+ needs brackets: `DEFAULT (CURRENT_DATE)`.)

-- * 7. SERIAL / IDENTITY (PostgreSQL version of AUTO_INCREMENT)

--   * Properties: Automatically generates unique numbers for a column (mostly for primary keys). Behind the scenes PostgreSQL uses a sequence.

--   * Code Example:
CREATE TABLE Students (
    StudentID INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,   -- or: StudentID SERIAL PRIMARY KEY
    Name VARCHAR(50)
);

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

-- * 6. SURROGATE KEY: An artificial key created ONLY to uniquely identify a row. It has no business meaning (like a `SERIAL` / `IDENTITY` ID in PostgreSQL, `AUTO_INCREMENT` in MySQL).

-- ------------------------------------------------------------
-- 10.4 The Hierarchy of Keys (Visual Diagram)
-- ------------------------------------------------------------
-- Below is a clear representation of how these keys relate to each other:

-- ------------------------------------------------------------
-- 10.5 UUID vs SERIAL / IDENTITY Primary Key
-- ------------------------------------------------------------

-- | Point | SERIAL / IDENTITY (INT/BIGINT) | UUID (PostgreSQL `UUID` type) |
-- | :--- | :--- | :--- |
-- | Size | 4–8 bytes | 16 bytes (native binary type — no `CHAR(36)` needed) |
-- | Order | Always increasing → new index entries go at the right end of the B-Tree | Random (v4) → inserts land anywhere in the index |
-- | Insert speed | Fast | Slower on big tables (random index pages, more WAL) |
-- | Table storage | Heap table — row order does not depend on the PK | Same (PostgreSQL tables are not clustered by PK, so the cost is only in the index) |
-- | Unique across servers | ❌ Only inside one table/server | ✅ Globally unique (merge, sharding, offline clients) |
-- | Guessable in URLs | ✅ Yes (`/orders/1001` → try 1002) | ❌ Hard to guess |

-- * Storing a UUID in PostgreSQL (much simpler than MySQL — there is a real `UUID` type):
CREATE TABLE orders (
    id       UUID PRIMARY KEY DEFAULT gen_random_uuid(),   -- PostgreSQL 13+ built in
    customer VARCHAR(50)
);

INSERT INTO orders (customer) VALUES ('Asha') RETURNING id;

SELECT id, customer FROM orders;   -- shown as 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11'

--   * PostgreSQL 18 adds `uuidv7()` — time-ordered UUIDs that are index-friendly: `id UUID PRIMARY KEY DEFAULT uuidv7()`.

-- * Common design: keep a `BIGINT GENERATED ALWAYS AS IDENTITY` primary key for joins/speed and add a separate `UNIQUE` public UUID column for URLs and APIs. Time-ordered IDs (UUID v7, ULID, Snowflake IDs) combine both advantages.
CREATE TABLE orders2 (
    id        BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    public_id UUID NOT NULL UNIQUE DEFAULT gen_random_uuid(),
    customer  VARCHAR(50)
);

-- ------------------------------------------------------------
-- 10.5.1 🐘 PostgreSQL-only Constraint Features (New)
-- ------------------------------------------------------------

-- * DEFERRABLE constraints: check the rule at `COMMIT` time instead of after every statement. Useful when two rows must point at each other.
ALTER TABLE employees
    ADD CONSTRAINT fk_manager FOREIGN KEY (manager_id) REFERENCES employees(id)
    DEFERRABLE INITIALLY DEFERRED;

-- * EXCLUDE constraint: "no two rows may overlap". Classic example — no double booking of the same room:
CREATE EXTENSION IF NOT EXISTS btree_gist;

CREATE TABLE room_booking (
    room_id INT,
    during  TSRANGE,                                  -- time range
    EXCLUDE USING GIST (room_id WITH =, during WITH &&)  -- same room + overlapping time = error
);

-- * Partial unique index: unique only for some rows (e.g., one active email per user, deleted rows ignored):
CREATE UNIQUE INDEX uq_active_email ON users (email) WHERE deleted_at IS NULL;

-- * `UNIQUE NULLS NOT DISTINCT` (PG 15+): treat NULLs as equal, so only one NULL is allowed.

--   * `Students(StudentID PRIMARY KEY, Email UNIQUE, Age CHECK (Age >= 18), City DEFAULT 'Pune')` ➔ StudentID = Primary Key, Email = Alternate Key, `{StudentID, Email}` = Super Key.

-- ---

-- ======================================================================
-- 🎯 Practice Questions (salesdb sample data) — try first, then look at the answer
-- ======================================================================
-- Run 00-Setup-Sample-Data.sql once before this section.

SET search_path TO sales;

-- Q1. Which keys and constraints exist on orders?
SELECT constraint_name, constraint_type
FROM information_schema.table_constraints
WHERE table_schema = 'sales' AND table_name = 'orders';

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
