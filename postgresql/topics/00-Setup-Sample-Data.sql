-- ======================================================================
-- Setup: Sample Data (salesdb + MyDatabase) — PostgreSQL
-- ======================================================================
-- Source: sql-ultimate-course-main/datasets/postgres/ (same data as the course videos).
-- pgAdmin cannot switch databases inside one script, so run it in 3 steps:
--   Step 1: open Query Tool on database "postgres" → run Step 1 block.
--   Step 2: open Query Tool on database "salesdb"  → run Step 2 block (creates schema "sales" + tables).
--   Step 3: open Query Tool on database "MyDatabase" → run Step 3 block.
-- Tables live in schema "sales", so the practice examples start with: SET search_path TO sales;
-- Run Steps again any time to reset the data after UPDATE / DELETE practice.

-- ======================================================================
-- salesdb Data Model (how the tables are related)
-- ======================================================================
--
--   (schema sales)
--   customers (customerid PK, firstname, lastname, country, score)
--        │ 1
--        │            products (productid PK, product, category, price)
--        │ N                │ 1
--        ▼                  │ N
--   orders (orderid PK, productid FK*, customerid FK*, salespersonid FK*,
--           orderdate, shipdate, orderstatus, shipaddress, billaddress,
--           quantity, sales, creationtime)
--        ▲ N
--        │ 1
--   employees (employeeid PK, firstname, lastname, department, birthdate,
--              gender, salary, managerid FK* → employees.employeeid)
--
--   ordersarchive  : same columns as orders, old orders (2024), no primary key,
--                    some orderids repeat (history of status changes).
--
--   * customers 1 ── N orders     (orders.customerid    → customers.customerid)
--   * products  1 ── N orders     (orders.productid     → products.productid)
--   * employees 1 ── N orders     (orders.salespersonid → employees.employeeid, the salesperson)
--   * employees 1 ── N employees  (employees.managerid  → employees.employeeid, self relationship)
--   * customers N ── N products   through orders (orders is the bridge table)
--
-- Data at a glance: 5 customers, 5 employees, 5 products, 10 orders (Jan–Mar 2025), 10 archive rows (2024).

-- * PostgreSQL course script has no FOREIGN KEY constraints; FK* = logical relation only.

-- ======================================================================
-- Step 1 (connected to: postgres)
-- ======================================================================
DROP DATABASE IF EXISTS salesdb;
CREATE DATABASE salesdb;
DROP DATABASE IF EXISTS "MyDatabase";
CREATE DATABASE "MyDatabase";

-- ======================================================================
-- Step 2 (connected to: salesdb)
-- ======================================================================
-- =============================================================
-- PostgreSQL Database Creation and Table Setup Script
-- =============================================================
-- WARNING:
-- This script assumes you are manually connected to the 'postgres' database
-- and have the privileges to drop/create databases and schemas.
-- It drops the 'salesdb' database if it exists.
-- 
-- DROP AND CREATE DATABASE
-- 
-- Connect to the new database (manual step in most PostgreSQL tools)
-- 
-- Now switch to the salesdb database to execute the following
-- 
-- Create schema
DROP SCHEMA IF EXISTS sales CASCADE;
CREATE SCHEMA sales;

-- ======================================================
-- Table: customers
-- ======================================================

CREATE TABLE sales.customers (
    customerid INT PRIMARY KEY,
    firstname VARCHAR(50),
    lastname VARCHAR(50),
    country VARCHAR(50),
    score INT
);

INSERT INTO sales.customers VALUES
    (1, 'Jossef', 'Goldberg', 'Germany', 350),
    (2, 'Kevin', 'Brown', 'USA', 900),
    (3, 'Mary', NULL, 'USA', 750),
    (4, 'Mark', 'Schwarz', 'Germany', 500),
    (5, 'Anna', 'Adams', 'USA', NULL);

-- ======================================================
-- Table: employees
-- ======================================================

CREATE TABLE sales.employees (
    employeeid INT PRIMARY KEY,
    firstname VARCHAR(50),
    lastname VARCHAR(50),
    department VARCHAR(50),
    birthdate DATE,
    gender CHAR(1),
    salary INT,
    managerid INT
);

INSERT INTO sales.employees VALUES
    (1, 'Frank', 'Lee', 'Marketing', '1988-12-05', 'M', 55000, NULL),
    (2, 'Kevin', 'Brown', 'Marketing', '1972-11-25', 'M', 65000, 1),
    (3, 'Mary', NULL, 'Sales', '1986-01-05', 'F', 75000, 1),
    (4, 'Michael', 'Ray', 'Sales', '1977-02-10', 'M', 90000, 2),
    (5, 'Carol', 'Baker', 'Sales', '1982-02-11', 'F', 55000, 3);

-- ======================================================
-- Table: products
-- ======================================================

CREATE TABLE sales.products (
    productid INT PRIMARY KEY,
    product VARCHAR(50),
    category VARCHAR(50),
    price INT
);

INSERT INTO sales.products VALUES
    (101, 'Bottle', 'Accessories', 10),
    (102, 'Tire', 'Accessories', 15),
    (103, 'Socks', 'Clothing', 20),
    (104, 'Caps', 'Clothing', 25),
    (105, 'Gloves', 'Clothing', 30);

-- ======================================================
-- Table: orders
-- ======================================================

CREATE TABLE sales.orders (
    orderid INT PRIMARY KEY,
    productid INT,
    customerid INT,
    salespersonid INT,
    orderdate DATE,
    shipdate DATE,
    orderstatus VARCHAR(50),
    shipaddress VARCHAR(255),
    billaddress VARCHAR(255),
    quantity INT,
    sales INT,
    creationtime TIMESTAMP
);

INSERT INTO sales.orders VALUES
    (1, 101, 2, 3, '2025-01-01', '2025-01-05', 'Delivered', '9833 Mt. Dias Blv.', '1226 Shoe St.', 1, 10, '2025-01-01 12:34:56'),
    (2, 102, 3, 3, '2025-01-05', '2025-01-10', 'Shipped', '250 Race Court', NULL, 1, 15, '2025-01-05 23:22:04'),
    (3, 101, 1, 5, '2025-01-10', '2025-01-25', 'Delivered', '8157 W. Book', '8157 W. Book', 2, 20, '2025-01-10 18:24:08'),
    (4, 105, 1, 3, '2025-01-20', '2025-01-25', 'Shipped', '5724 Victory Lane', '', 2, 60, '2025-01-20 05:50:33'),
    (5, 104, 2, 5, '2025-02-01', '2025-02-05', 'Delivered', NULL, NULL, 1, 25, '2025-02-01 14:02:41'),
    (6, 104, 3, 5, '2025-02-05', '2025-02-10', 'Delivered', '1792 Belmont Rd.', NULL, 2, 50, '2025-02-06 15:34:57'),
    (7, 102, 1, 1, '2025-02-15', '2025-02-27', 'Delivered', '136 Balboa Court', '', 2, 30, '2025-02-16 06:22:01'),
    (8, 101, 4, 3, '2025-02-18', '2025-02-27', 'Shipped', '2947 Vine Lane', '4311 Clay Rd', 3, 90, '2025-02-18 10:45:22'),
    (9, 101, 2, 3, '2025-03-10', '2025-03-15', 'Shipped', '3768 Door Way', '', 2, 20, '2025-03-10 12:59:04'),
    (10, 102, 3, 5, '2025-03-15', '2025-03-20', 'Shipped', NULL, NULL, 0, 60, '2025-03-16 23:25:15');

-- ======================================================
-- Table: orders_archive
-- ======================================================

CREATE TABLE sales.ordersarchive (
    orderid INT,
    productid INT,
    customerid INT,
    salespersonid INT,
    orderdate DATE,
    shipdate DATE,
    orderstatus VARCHAR(50),
    shipaddress VARCHAR(255),
    billaddress VARCHAR(255),
    quantity INT,
    sales INT,
    creationtime TIMESTAMP
);

INSERT INTO sales.ordersarchive VALUES
    (1, 101, 2, 3, '2024-04-01', '2024-04-05', 'Shipped', '123 Main St', '456 Billing St', 1, 10, '2024-04-01 12:34:56'),
    (2, 102, 3, 3, '2024-04-05', '2024-04-10', 'Shipped', '456 Elm St', '789 Billing St', 1, 15, '2024-04-05 23:22:04'),
    (3, 101, 1, 4, '2024-04-10', '2024-04-25', 'Shipped', '789 Maple St', '789 Maple St', 2, 20, '2024-04-10 18:24:08'),
    (4, 105, 1, 3, '2024-04-20', '2024-04-25', 'Shipped', '987 Victory Lane', '', 2, 60, '2024-04-20 05:50:33'),
    (4, 105, 1, 3, '2024-04-20', '2024-04-25', 'Delivered', '987 Victory Lane', '', 2, 60, '2024-04-20 14:50:33'),
    (5, 104, 2, 5, '2024-05-01', '2024-05-05', 'Shipped', '345 Oak St', '678 Pine St', 1, 25, '2024-05-01 14:02:41'),
    (6, 104, 3, 5, '2024-05-05', '2024-05-10', 'Delivered', '543 Belmont Rd.', NULL, 2, 50, '2024-05-06 15:34:57'),
    (6, 104, 3, 5, '2024-05-05', '2024-05-10', 'Delivered', '543 Belmont Rd.', '3768 Door Way', 2, 50, '2024-05-07 13:22:05'),
    (6, 101, 3, 5, '2024-05-05', '2024-05-10', 'Delivered', '543 Belmont Rd.', '3768 Door Way', 2, 50, '2024-05-12 20:36:55'),
    (7, 102, 3, 5, '2024-06-15', '2024-06-20', 'Shipped', '111 Main St', '222 Billing St', 0, 60, '2024-06-16 23:25:15');

SET search_path TO sales;
SELECT * FROM customers;
SELECT * FROM employees;
SELECT * FROM products;
SELECT * FROM orders;
SELECT * FROM ordersarchive;

-- ======================================================================
-- Step 3 (connected to: MyDatabase)
-- ======================================================================
-- ======================================================
-- Table: customers
-- ======================================================
DROP TABLE IF EXISTS customers;

CREATE TABLE customers (
    id INT NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    country VARCHAR(50),
    score INT,
    CONSTRAINT pk_customers PRIMARY KEY (id)
);

-- Insert customers data
INSERT INTO customers (id, first_name, country, score) VALUES
    (1, 'Maria', 'Germany', 350),
    (2, ' John', 'USA', 900),
    (3, 'Georg', 'UK', 750),
    (4, 'Martin', 'Germany', 500),
    (5, 'Peter', 'USA', 0);

-- ======================================================
-- Table: orders
-- ======================================================
DROP TABLE IF EXISTS orders;

CREATE TABLE orders (
    order_id INT NOT NULL,
    customer_id INT NOT NULL,
    order_date DATE,
    sales INT,
    CONSTRAINT pk_orders PRIMARY KEY (order_id)
);

-- Insert orders data
INSERT INTO orders (order_id, customer_id, order_date, sales) VALUES
    (1001, 1, '2021-01-11', 35),
    (1002, 2, '2021-04-05', 15),
    (1003, 3, '2021-06-18', 20),
    (1004, 6, '2021-08-31', 10);
