-- ======================================================================
-- Topic 50: Associations (Relationships Between Tables)
-- ======================================================================

-- ------------------------------------------------------------
-- 📖 In Simple Words
-- ------------------------------------------------------------

-- * Definition: Associations are the relationships between tables: one-to-one, one-to-many, many-to-many and self relationships, made with foreign keys.

-- * Real-life example: One mother – many children (1:N); students and courses (N:N, needs an enrolment list); an employee whose manager is also an employee (self).

-- * Example on salesdb (run 00-Setup-Sample-Data.sql first):
USE salesdb;
SELECT e.firstname AS employee, m.firstname AS manager
FROM employees e
LEFT JOIN employees m ON m.employeeid = e.managerid;

-- * Example explained (step by step):
--   1. employees.managerid points to another row of the same table — a self relationship.
--   2. The query joins the table to itself: e = employee, m = manager.
--   3. Result: Kevin and Mary → Frank; Michael → Kevin; Carol → Mary; Frank has no manager (NULL).

-- ------------------------------------------------------------
-- 50.1 What is an Association in SQL?
-- ------------------------------------------------------------

-- * Association in database design refers to how tables (entities) are related to each other.

-- * In simple terms: Association in SQL = Relationship between two or more tables.

-- ------------------------------------------------------------
-- 50.2 Types of Associations (Relationships)
-- ------------------------------------------------------------

-- 1. One-to-One (1:1)

--    * Each row in Table A is associated with only one row in Table B.

--    * Example: a passport belongs to exactly one person.

-- 2. One-to-Many (1:N)

--    * One row in Table A can be linked to many rows in Table B.

--    * Example: a customer can place many orders.

--    * "One-to-Many" (1:N) and "Many-to-One" (N:1) are the same relationship, just looked at from different directions:

--      * One-to-Many (1:N) → "One customer has many orders."

--      * Many-to-One (N:1) → "Many orders belong to one customer."

-- 3. Many-to-Many (M:N)

--    * Rows in Table A can be related to many rows in Table B, and vice versa.

--    * Requires a junction (association) table.

--    * Example: students enroll in many courses, and courses have many students.

-- 4. Self-Association (Recursive Relationship)

--    * A table has a relationship with itself.

--    * Example: an employee can have another employee as a manager.

-- ------------------------------------------------------------
-- 50.3 Why Associations Are Important
-- ------------------------------------------------------------

-- * They enforce referential integrity with foreign keys.

-- * They allow JOIN operations to combine related data.

-- * They reflect the real-world relationships between entities.

-- * So in SQL, association = relationship (1:1, 1:N, M:N) between tables, typically implemented with foreign keys and sometimes association tables.

-- ------------------------------------------------------------
-- 50.4 How Associations Are Implemented in SQL
-- ------------------------------------------------------------

-- * Associations between tables are implemented in two ways:

--   1. Foreign Keys — used for One-to-One (1:1) and One-to-Many (1:N / N:1).

--      * A foreign key in one table points to the primary key of another table.

--      * This enforces referential integrity (you can't insert an invalid reference).

--      * For 1:1, the foreign key column is also made `UNIQUE`, so each parent row can be linked only once.

--   2. Association (Junction / Bridge) Tables — required for Many-to-Many (M:N).

--      * Neither table can hold the relationship alone, so we create a third table that stores pairs of IDs (two foreign keys).

-- * In short:

--   * 1:1 and 1:N / N:1 → implemented using foreign keys.

--   * M:N → implemented using an association (junction) table with two foreign keys.

-- * In relational databases (MySQL, PostgreSQL, SQL Server, etc.) there is no direct way to store a many-to-many relationship between two tables. You must introduce a third table (junction table) that breaks it into two one-to-many relationships.

-- * SQL does not create the junction table automatically — you (the database designer/developer) must create it yourself.

-- * Some ORM frameworks (Hibernate, Sequelize, Django ORM, etc.) may auto-generate this third table behind the scenes when you declare a many-to-many relationship.

-- * Example (all four types):
-- 1:N  (one customer, many orders)
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name        VARCHAR(50)
);
CREATE TABLE orders (
    order_id    INT PRIMARY KEY,
    customer_id INT NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- 1:1  (one person, one passport) -> FK + UNIQUE
CREATE TABLE persons (
    person_id INT PRIMARY KEY,
    name      VARCHAR(50)
);
CREATE TABLE passports (
    passport_no VARCHAR(20) PRIMARY KEY,
    person_id   INT NOT NULL UNIQUE,
    FOREIGN KEY (person_id) REFERENCES persons(person_id)
);

-- M:N  (students <-> courses) -> junction table with two FKs
CREATE TABLE students (student_id INT PRIMARY KEY, name  VARCHAR(50));
CREATE TABLE courses  (course_id  INT PRIMARY KEY, title VARCHAR(50));
CREATE TABLE enrollments (
    student_id INT,
    course_id  INT,
    PRIMARY KEY (student_id, course_id),          -- same pair only once
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id)  REFERENCES courses(course_id)
);

-- Self-association (employee -> manager)
CREATE TABLE employees (
    emp_id     INT PRIMARY KEY,
    name       VARCHAR(50),
    manager_id INT NULL,
    FOREIGN KEY (manager_id) REFERENCES employees(emp_id)
);

-- Which courses has each student taken? (M:N through the junction table)
SELECT s.name, c.title
FROM students s
JOIN enrollments e ON e.student_id = s.student_id
JOIN courses c     ON c.course_id  = e.course_id;

-- * Q1. How do you implement a many-to-many relationship?

--   * Answer: A junction table with two foreign keys and a composite primary key, e.g. `enrollments(student_id, course_id)`.

-- * Q2. How do you enforce one-to-one?

--   * Answer: Foreign key + UNIQUE on the child column (or share the same primary key in both tables).

-- * Q3. Where does the foreign key go in one-to-many?

--   * Answer: On the 'many' side (orders.customer_id → customers.customer_id).

-- * Q4. Design tables for a library: books, members, loans.

--   * Answer: `books(book_id PK, title, author)`, `members(member_id PK, name)`, `loans(loan_id PK, book_id FK, member_id FK, loan_date, return_date)`. books ↔ members is M:N through `loans`, which also stores the loan dates.

-- * Q5. What is cardinality in an ER diagram?

--   * Answer: How many rows of one entity can relate to another (1:1, 1:N, M:N) plus optionality (must / may). Crow's-foot notation draws it on the relationship line.

-- ---

-- ======================================================================
-- 🎯 Practice Questions (salesdb sample data) — try first, then look at the answer
-- ======================================================================
-- Run 00-Setup-Sample-Data.sql once before this section.

USE salesdb;

-- Q1. One-to-many: one customer has many orders.
SELECT c.firstname, COUNT(o.orderid) AS orders_count
FROM customers c LEFT JOIN orders o ON o.customerid = c.customerid
GROUP BY c.customerid, c.firstname;

-- Q2. Self relationship: employee → manager.
SELECT e.firstname AS employee, m.firstname AS manager
FROM employees e LEFT JOIN employees m ON m.employeeid = e.managerid;

-- Q3. Many-to-many: customers ↔ products through orders (orders is the bridge table).
SELECT DISTINCT c.firstname, p.product
FROM orders o
JOIN customers c ON c.customerid = o.customerid
JOIN products  p ON p.productid  = o.productid
ORDER BY c.firstname;
