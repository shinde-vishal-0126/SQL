# SQL Study Tracker

> Notes: [SQL_Master_Guide_Updated.md](SQL_Master_Guide_Updated.md) · Online tracker: https://claude.ai/artifact/KVWETXN6yR5Bz4Kb2jVoNh

**कसे वापरायचे:**
- एखादा sub-topic वाचून झाला की `- [ ]` चे `- [x]` करा आणि शेवटी तारीख लिहा, उदा. `- [x] 16.4 ... ✅ 2026-09-30`.
- पुन्हा वाचायचा असेल तर ओळीच्या शेवटी `⭐` लावा.
- Topic चे नाव click केले की notes मधील तोच भाग उघडतो.
- दिवसाचा अभ्यास झाला की commit करा: `git add mysql/mysql_basic/STUDY_TRACKER.md` आणि `git commit -m "study: 30 Sep"`.
- VS Code मध्ये `Ctrl+Shift+V` ने preview उघडला की किती ✓ झाले ते दिसते; GitHub वर checkbox सह दिसते.

**एकूण:** 8 Parts · 53 Topics · 413 sub-topics

| Part | विषय | Topics | Sub-topics |
| :---: | :--- | :---: | :---: |
| 1 | Database Fundamentals | 1–8 | 52 |
| 2 | SQL Commands, Keys & Transactions (DDL, DML, DQL, DCL, TCL) | 9–19 | 89 |
| 3 | Querying & Combining Data (Clauses, Joins, SET Operators) | 20–22 | 26 |
| 4 | SQL Functions (String, Numeric, Date, NULL, CASE, Window) | 23–26 | 32 |
| 5 | Advanced Querying (Subqueries, CTEs, Views, Tables) | 27–39 | 114 |
| 6 | Performance, Indexing & Database Internals | 40–48 | 61 |
| 7 | Database Design & Data Management | 49–51 | 20 |
| 8 | Final Revision & Interview Preparation | 52–53 | 19 |

---

## Part 1: Database Fundamentals

### [Topic 1: What is a Database?](SQL_Master_Guide_Updated.md#topic-1-what-is-a-database)

- [ ] 1.1 Definition & Core Concept
- [ ] 1.2 Detailed Database Structure & Components
- [ ] 1.3 Visual Concept: Without Database vs. With Database & SQL
- [ ] 1.4 Topic 1 Summary (मराठी सारांश)

### [Topic 2: What is a DBMS (Database Management System)?](SQL_Master_Guide_Updated.md#topic-2-what-is-a-dbms-database-management-system)

- [ ] 2.1 Definition & Meaning
- [ ] 2.2 Why Do We Need a DBMS?
- [ ] 2.3 Key Functions & Responsibilities
- [ ] 2.4 Step-by-Step Query Execution Lifecycle in DBMS
- [ ] 2.5 The 4 Core Pillars (Quick Reference)
- [ ] 2.6 Popular Examples of DBMS / RDBMS
- [ ] 2.7 Visual Architecture: Server, Database, DBMS & Clients
- [ ] 2.8 Topic 2 Summary (मराठी सारांश)

### [Topic 3: What is SQL?](SQL_Master_Guide_Updated.md#topic-3-what-is-sql)

- [ ] 3.1 Definition & Core Meaning
- [ ] 3.2 Communicating with the Database Brain (Asking Questions)
- [ ] 3.3 Accessing & Manipulating Data (CRUD Operations)
- [ ] 3.4 Real-World Applications & Use Cases of SQL
- [ ] 3.5 In Short: The 4 Pillars Chain
- [ ] 3.6 Visual Concept: How SQL Speaks to the Database
- [ ] 3.7 Topic 3 Summary (मराठी सारांश)

### [Topic 4: Main 2 Types of Databases (SQL vs NO-SQL)](SQL_Master_Guide_Updated.md#topic-4-main-2-types-of-databases-sql-vs-no-sql)

- [ ] 4.1 Overview: SQL vs NO-SQL
- [ ] 4.2 Relational Database (SQL)
- [ ] 4.3 NO-SQL Databases (Non-Relational Models)
- [ ] 4.4 Visual Concept: SQL vs NO-SQL Architecture
- [ ] 4.5 Topic 4 Summary (मराठी सारांश)

### [Topic 5: Why SQL?](SQL_Master_Guide_Updated.md#topic-5-why-sql)

- [ ] 5.1 Standardized Way to Interact with Databases
- [ ] 5.2 Efficient Data Retrieval
- [ ] 5.3 Data Manipulation (CRUD Examples)
- [ ] 5.4 Relationships Between Data
- [ ] 5.5 Data Integrity and Security
- [ ] 5.6 Scalability and Engine Optimization
- [ ] 5.7 The 3 Core Drivers: Talk to Data, High Demand, Industry Standard
- [ ] 5.8 Visual Concept: Why SQL Mind-Map
- [ ] 5.9 Topic 5 Summary (मराठी सारांश)

### [Topic 6: Database Structure & Hierarchy](SQL_Master_Guide_Updated.md#topic-6-database-structure--hierarchy)

- [ ] 6.1 The Relational Database Hierarchy
- [ ] 6.2 The Starting Point: Server
- [ ] 6.3 The Container: Database
- [ ] 6.4 The Logical Organizer: Schema
- [ ] 6.5 Types of Schemas (Logical vs. Physical)
- [ ] 6.6 The Core Object: Table, Columns, Rows & Cells
- [ ] 6.7 The Fingerprint: Primary Key
- [ ] 6.8 MySQL Data Types In-Depth
- [ ] 6.9 Visual Architectural Diagrams for Data Types & Hierarchy
- [ ] 6.10 Topic 6 Summary (मराठी सारांश)

### [Topic 7: SQL Server Architecture & Database Hierarchy](SQL_Master_Guide_Updated.md#topic-7-sql-server-architecture--database-hierarchy)

- [ ] 7.1 What is a SQL Server and Database Hierarchy?
- [ ] 7.2 The 3-Tier Database Architecture (Three Levels of Abstraction)
- [ ] 7.3 Interview Perspective & Key Takeaways
- [ ] 7.4 Topic 7 Summary (मराठी सारांश)

### [Topic 8: SQL vs MySQL](SQL_Master_Guide_Updated.md#topic-8-sql-vs-mysql)

- [ ] 8.1 What is SQL?
- [ ] 8.2 What is MySQL?
- [ ] 8.3 Key Differences: Comparison Table
- [ ] 8.4 Visual Concept: Language vs RDBMS Software
- [ ] 8.5 Topic 8 Summary (मराठी सारांश)

---

## Part 2: SQL Commands, Keys & Transactions (DDL, DML, DQL, DCL, TCL)

### [Topic 9: SQL Commands & DDL (Data Definition Language) In-Depth](SQL_Master_Guide_Updated.md#topic-9-sql-commands--ddl-data-definition-language-in-depth)

- [ ] 9.1 Check Current SQL / MySQL Version
- [ ] 9.2 Broad Classification of SQL Commands
- [ ] 9.3 What is DDL (Data Definition Language)?
- [ ] 9.4 The Implicit Commit Rule in MySQL
- [ ] 9.5 CREATE Commands (Database, Tables, Indexes & Info)
- [ ] 9.6 ALTER Commands (Database Level & Table Level)
- [ ] 9.7 Constraints Management via ALTER (Add & Drop Rules)
- [ ] 9.8 Quick Revision Cheat Sheet: ALTER Operations
- [ ] 9.9 DROP Commands (Permanent Object Deletion)
- [ ] 9.10 TRUNCATE Commands (Wipe Data, Keep Structure)
- [ ] 9.11 RENAME Commands (Objects & Tables)
- [ ] 9.12 Differences Between DELETE, TRUNCATE, and DROP
- [ ] 9.13 Visual Diagrams & Architectural Explanations
- [ ] 9.14 Topic 9 Summary (मराठी सारांश)

### [Topic 10: Keys & Constraints in SQL](SQL_Master_Guide_Updated.md#topic-10-keys--constraints-in-sql)

- [ ] 10.1 What are Key Constraints?
- [ ] 10.2 SQL Constraints (Point-wise Detail)
- [ ] 10.3 Types of Keys (Database Architecture)
- [ ] 10.4 The Hierarchy of Keys (Visual Diagram)
- [ ] 10.5 Topic 10 Summary (मराठी सारांश)

### [Topic 11: DML (Data Manipulation Language) In-Depth](SQL_Master_Guide_Updated.md#topic-11-dml-data-manipulation-language-in-depth)

- [ ] 11.1 What is DML (Data Manipulation Language)?
- [ ] 11.2 The INSERT Command & Bulk Operations
- [ ] 11.3 The UPDATE Command & Best Practices
- [ ] 11.4 The DELETE Command & Safe Execution
- [ ] 11.5 MySQL Safe Update Mode (SQL_SAFE_UPDATES)
- [ ] 11.6 Soft Delete vs Hard Delete (In-Depth Comparison)
- [ ] 11.7 Foreign Key Referential Actions (Complete Guide)
- [ ] 11.8 The REPLACE Command in SQL (MySQL Specific)
- [ ] 11.9 Comparison: ALTER Command vs UPDATE Command
- [ ] 11.10 Visual Diagrams & Architectural Explanations
- [ ] 11.11 Topic 11 Summary (मराठी सारांश)

### [Topic 12: DQL (Data Query Language) & Data Retrieval](SQL_Master_Guide_Updated.md#topic-12-dql-data-query-language--data-retrieval)

- [ ] 12.1 What is DQL (Data Query Language)?
- [ ] 12.2 Two Fundamental Ways to Retrieve Data via SELECT
- [ ] 12.3 Visual Concept: Whole Table vs. Specific Column Projection
- [ ] 12.4 Topic 12 Summary (मराठी सारांश)

### [Topic 13: DCL (Data Control Language) & Security / Access Control](SQL_Master_Guide_Updated.md#topic-13-dcl-data-control-language--security--access-control)

- [ ] 13.1 What is DCL (Data Control Language)?
- [ ] 13.2 Core DCL Commands: GRANT and REVOKE
- [ ] 13.3 Inspecting Users & Privileges in MySQL
- [ ] 13.4 User Management & Creation (Read-Only User Concept)
- [ ] 13.5 Step-by-Step Granting & Revoking Permissions
- [ ] 13.6 Database-Wide Privileges & Administrative Access
- [ ] 13.7 The 6 Core Privilege Categories in MySQL
- [ ] 13.8 Advanced Interview Concepts & Gotchas in DCL / Security
- [ ] 13.9 Visual Architecture Diagram: DCL & Privileges
- [ ] 13.10 Topic 13 Summary (मराठी सारांश)

### [Topic 14: SQL Injection & Prepared Statements (Database Security)](SQL_Master_Guide_Updated.md#topic-14-sql-injection--prepared-statements-database-security)

- [ ] 14.1 What is SQL Injection?
- [ ] 14.2 Types of SQL Injection
- [ ] 14.3 How to Prevent SQL Injection
- [ ] 14.4 Prepared Statements in MySQL and in Application Code
- [ ] 14.5 Safe Dynamic SQL Inside Stored Procedures
- [ ] 14.6 Interview Perspective (नेहमी विचारले जाणारे प्रश्न)
- [ ] 14.7 Topic 14 Summary (मराठी सारांश)

### [Topic 15: TCL (Transaction Control Language) & Transaction Management](SQL_Master_Guide_Updated.md#topic-15-tcl-transaction-control-language--transaction-management)

- [ ] 15.1 What is TCL (Transaction Control Language)?
- [ ] 15.2 What is a Transaction? (ACID Overview)
- [ ] 15.3 Core TCL Commands: START, COMMIT, ROLLBACK, SAVEPOINT, SET
- [ ] 15.4 Real-World Banking Transaction Example (Atomic Transfer)
- [ ] 15.5 Critical Rules & Constraints of TCL
- [ ] 15.6 Transaction Isolation Levels & Concurrency Anomalies
- [ ] 15.7 Advanced Interview Concepts & Gotchas in TCL / Transaction Management
- [ ] 15.8 Visual Architecture Diagram: TCL Lifecycle & Isolation Levels
- [ ] 15.9 Topic 15 Summary (मराठी सारांश)

### [Topic 16: ACID Properties & Transaction Isolation Levels](SQL_Master_Guide_Updated.md#topic-16-acid-properties--transaction-isolation-levels)

- [ ] 16.1 What are ACID Properties?
- [ ] 16.2 Concurrency Problems (Read Phenomena)
- [ ] 16.3 Transaction Isolation Levels (MySQL InnoDB)
- [ ] 16.4 Interview Perspective (नेहमी विचारले जाणारे प्रश्न)
- [ ] 16.5 Topic 16 Summary (मराठी सारांश)

### [Topic 17: Transactions in SQL (Complete Guide)](SQL_Master_Guide_Updated.md#topic-17-transactions-in-sql-complete-guide)

- [ ] 17.1 What is a Transaction?
- [ ] 17.2 Why Do We Use Transactions?
- [ ] 17.3 Transaction Properties (ACID)
- [ ] 17.4 Transaction Control Commands (How to Start a Transaction)
- [ ] 17.5 Transaction States (5 States in DBMS)
- [ ] 17.6 What is Autocommit in SQL?
- [ ] 17.7 Explicit vs Implicit Commit
- [ ] 17.8 Transactions with Stored Procedures
- [ ] 17.9 Interview Perspective (नेहमी विचारले जाणारे प्रश्न)
- [ ] 17.10 Topic 17 Summary (मराठी सारांश)

### [Topic 18: Deadlocks in SQL](SQL_Master_Guide_Updated.md#topic-18-deadlocks-in-sql)

- [ ] 18.1 What is a Deadlock?
- [ ] 18.2 How to Prevent Deadlocks?
- [ ] 18.3 Interview Perspective (नेहमी विचारले जाणारे प्रश्न)
- [ ] 18.4 Topic 18 Summary (मराठी सारांश)

### [Topic 19: Locks in MySQL (InnoDB Locking)](SQL_Master_Guide_Updated.md#topic-19-locks-in-mysql-innodb-locking)

- [ ] 19.1 What is a Lock and Why Do We Need It?
- [ ] 19.2 Shared (S) vs Exclusive (X) Locks
- [ ] 19.3 Row-Level vs Table-Level Locks
- [ ] 19.4 Locking Reads: SELECT ... FOR UPDATE / FOR SHARE
- [ ] 19.5 Record, Gap and Next-Key Locks (Phantom Protection)
- [ ] 19.6 Intention Locks and Metadata Locks
- [ ] 19.7 Optimistic vs Pessimistic Locking
- [ ] 19.8 Lock Wait Timeout and Monitoring Locks
- [ ] 19.9 Interview Perspective (नेहमी विचारले जाणारे प्रश्न)
- [ ] 19.10 Topic 19 Summary (मराठी सारांश)

---

## Part 3: Querying & Combining Data (Clauses, Joins, SET Operators)

### [Topic 20: Commands to Query Data (DQL In-Depth, Clauses & Filtering)](SQL_Master_Guide_Updated.md#topic-20-commands-to-query-data-dql-in-depth-clauses--filtering)

- [ ] 20.1 Commands to Query Data & What is DQL?
- [ ] 20.2 The Core Mental Model: "Ask Your Data"
- [ ] 20.3 Commands (to query the data) & Essential Database/Table Setup
- [ ] 20.4 SQL Query Clauses (The 9 Building Blocks)
- [ ] 20.5 How SQL Works: Written Syntax (Left to Right) vs. Engine Execution Order
- [ ] 20.6 Select Query / Data Retrieve Query: SELECT * vs. SELECT column_name
- [ ] 20.7 Filtering Data & The WHERE Clause In-Depth
- [ ] 20.8 Sorting Data & The ORDER BY Clause In-Depth
- [ ] 20.9 Grouping Data & The GROUP BY Clause In-Depth (Data Aggregation)
- [ ] 20.10 Visual Diagrams & Architectural Reference
- [ ] 20.11 Topic 20 Summary (मराठी सारांश)
- [ ] 20.12 SQL Clauses Deep Dive & Execution Order (Detailed Guide)

### [Topic 21: SQL Joins (Combining Data from Tables)](SQL_Master_Guide_Updated.md#topic-21-sql-joins-combining-data-from-tables)

- [ ] 21.1 What are Joins & Why Do We Need Them?
- [ ] 21.2 Types of Joins (Basic to Advanced)
- [ ] 21.3 Advanced Joins (Filtering & Special Cases)
- [ ] 21.4 Summary: How to Choose the Right Join?
- [ ] 21.5 Multi-Table Joins (Interview Perspective)
- [ ] 21.6 Pro-Tip: Interview Trick (Inner Join without INNER JOIN)
- [ ] 21.7 Topic 21 Summary (मराठी सारांश)

### [Topic 22: SET Operators (Combining Rows)](SQL_Master_Guide_Updated.md#topic-22-set-operators-combining-rows)

- [ ] 22.1 What are SET Operators & Why Do We Need Them?
- [ ] 22.2 The 6 Golden Rules of SET Operators
- [ ] 22.3 Types of SET Operators
- [ ] 22.4 Advanced Scenarios & Best Practices
- [ ] 22.5 In-Depth Comparison: JOINs vs SET Operators
- [ ] 22.6 Advanced Interview Insights (Pro-Tips)
- [ ] 22.7 Topic 22 Summary (मराठी सारांश)

---

## Part 4: SQL Functions (String, Numeric, Date, NULL, CASE, Window)

### [Topic 23: SQL Built-in Functions (String & Numeric)](SQL_Master_Guide_Updated.md#topic-23-sql-built-in-functions-string--numeric)

- [ ] 23.1 What are SQL Functions?
- [ ] 23.2 Categories of Functions
- [ ] 23.3 Nested Functions
- [ ] 23.4 String Functions (Manipulation & Extraction)
- [ ] 23.5 Numeric Functions
- [ ] 23.6 Pattern Matching with REGEXP (Regular Expressions)
- [ ] 23.7 Topic 23 Summary (मराठी सारांश)

### [Topic 24: Date and Time Functions](SQL_Master_Guide_Updated.md#topic-24-date-and-time-functions)

- [ ] 24.1 Anatomy of Date & Time
- [ ] 24.2 Sources of Dates (How to Query Dates)
- [ ] 24.3 Overview of Built-in Date/Time Functions (MySQL focus)
- [ ] 24.4 Topic 24 Summary (मराठी सारांश)

### [Topic 25: NULL Functions & Conditional Logic (CASE)](SQL_Master_Guide_Updated.md#topic-25-null-functions--conditional-logic-case)

- [ ] 25.1 What is NULL?
- [ ] 25.2 Checking for NULL
- [ ] 25.3 Handling & Replacing NULL values
- [ ] 25.4 NULLIF()
- [ ] 25.5 Data Policies regarding NULL, Space, and Empty
- [ ] 25.6 Conditional Logic: CASE Statement
- [ ] 25.7 IF() Function (MySQL Shorthand)
- [ ] 25.8 Interview Perspective (नेहमी विचारले जाणारे प्रश्न)
- [ ] 25.9 Topic 25 Summary (मराठी सारांश)

### [Topic 26: Aggregate & Window Functions (Analytics)](SQL_Master_Guide_Updated.md#topic-26-aggregate--window-functions-analytics)

- [ ] 26.1 Aggregation Functions in SQL
- [ ] 26.2 Window Functions (Analytical Functions)
- [ ] 26.3 Ranking Window Functions
- [ ] 26.4 Percentage-Based Ranking Functions
- [ ] 26.5 Aggregate Window Functions (SUM, AVG, MIN, MAX, COUNT)
- [ ] 26.6 Value Window Functions (Analytics Functions)
- [ ] 26.7 Window Function Syntax Deep Dive (OVER Clause)
- [ ] 26.8 Window Function Limitations & Rules
- [ ] 26.9 Why Window Functions? (Advantages)
- [ ] 26.10 GROUP BY + HAVING vs Window Functions
- [ ] 26.11 Interview Perspective (नेहमी विचारले जाणारे प्रश्न)
- [ ] 26.12 Topic 26 Summary (मराठी सारांश)

---

## Part 5: Advanced Querying (Subqueries, CTEs, Views, Tables)

### [Topic 27: Subqueries Deep Dive (Nested Queries)](SQL_Master_Guide_Updated.md#topic-27-subqueries-deep-dive-nested-queries)

- [ ] 27.1 What is a Subquery?
- [ ] 27.2 How Subqueries Work (The Execution Flow)
- [ ] 27.3 Why are Subqueries Important? (When to use them)
- [ ] 27.4 The Golden Rules of Subqueries
- [ ] 27.5 Subquery Classification (Types of Subqueries)
- [ ] 27.6 Interview Perspective (नेहमी विचारले जाणारे प्रश्न)
- [ ] 27.7 Topic 27 Summary (मराठी सारांश)

### [Topic 28: Subqueries Advanced (Clauses, Operators & Execution)](SQL_Master_Guide_Updated.md#topic-28-subqueries-advanced-clauses-operators--execution)

- [ ] 28.1 Subqueries by Location (Clauses)
- [ ] 28.2 Subqueries in the WHERE Clause (Filtering)
- [ ] 28.3 Correlated vs Non-Correlated Subqueries (Execution Behind the Scenes)
- [ ] 28.4 JOIN vs SUBQUERY (Interview Comparison)
- [ ] 28.5 Key Points & Summary
- [ ] 28.6 Topic 28 Summary (मराठी सारांश)

### [Topic 29: Derived Tables in SQL](SQL_Master_Guide_Updated.md#topic-29-derived-tables-in-sql)

- [ ] 29.1 What is a Derived Table?
- [ ] 29.2 Syntax and Example
- [ ] 29.3 Difference Between Derived Table and Subquery
- [ ] 29.4 Topic 29 Summary (मराठी सारांश)

### [Topic 30: CTEs (Common Table Expressions) & Recursive CTEs](SQL_Master_Guide_Updated.md#topic-30-ctes-common-table-expressions--recursive-ctes)

- [ ] 30.1 What is a CTE?
- [ ] 30.2 CTE vs Subquery vs Temp Table (Interview Favorite)
- [ ] 30.3 Recursive CTEs
- [ ] 30.4 Topic 30 Summary (मराठी सारांश)

### [Topic 31: Common Table Expressions (CTE)](SQL_Master_Guide_Updated.md#topic-31-common-table-expressions-cte)

- [ ] 31.1 What is a CTE? (Definition & Concept)
- [ ] 31.2 CTE vs Regular Subquery
- [ ] 31.3 Types of CTEs
- [ ] 31.4 CTE vs Derived Table
- [ ] 31.5 CTE Summary & Best Practices
- [ ] 31.6 Topic 31 Summary (मराठी सारांश)

### [Topic 32: SQL Views (Virtual Tables) Deep Dive](SQL_Master_Guide_Updated.md#topic-32-sql-views-virtual-tables-deep-dive)

- [ ] 32.1 What is a View?
- [ ] 32.2 Differences Between Table and View
- [ ] 32.3 Why Do We Need Views? (6 Major Use Cases)
- [ ] 32.4 View vs CTE
- [ ] 32.5 Syntax & Schema Naming
- [ ] 32.6 Modifying/Updating Views (CREATE OR REPLACE vs ALTER VIEW)
- [ ] 32.7 Updatable Views (Insert / Update / Delete through a View)
- [ ] 32.8 Materialized Views (Performance Booster)
- [ ] 32.9 Index vs View vs Materialized View
- [ ] 32.10 How Database Executes a View
- [ ] 32.11 Summary of SQL Views
- [ ] 32.12 Interview Perspective & Marathi Summary
- [ ] 32.13 Topic 32 Summary (मराठी सारांश)

### [Topic 33: Tables, CTAS & Temporary Tables Deep Dive](SQL_Master_Guide_Updated.md#topic-33-tables-ctas--temporary-tables-deep-dive)

- [ ] 33.1 What are Database Tables? (Physical Storage vs Logical Grid)
- [ ] 33.2 How to Create Permanent Tables: CREATE/INSERT vs CTAS
- [ ] 33.3 CTAS Use Cases
- [ ] 33.4 Temporary Tables (Session-Based Tables)
- [ ] 33.5 How Database Executes Temporary Tables
- [ ] 33.6 Use Case of Temporary Tables (ETL & Intermediate Results)
- [ ] 33.7 Ultimate Comparison: Subquery vs CTE vs Temp Table vs CTAS vs View
- [ ] 33.8 The Big Picture of SQL (How everything connects)
- [ ] 33.9 Interview Perspective & Marathi Summary
- [ ] 33.10 Topic 33 Summary (मराठी सारांश)

### [Topic 34: Table Duplication & Copying Techniques](SQL_Master_Guide_Updated.md#topic-34-table-duplication--copying-techniques)

- [ ] 34.1 Copying Table Data WITHOUT Constraints
- [ ] 34.2 Copying Table Data WITH Constraints (Exact Clone)
- [ ] 34.3 Topic 34 Summary (मराठी सारांश)

### [Topic 35: Stored Procedures in MySQL (Programmability)](SQL_Master_Guide_Updated.md#topic-35-stored-procedures-in-mysql-programmability)

- [ ] 35.1 What Exactly is a Stored Procedure and Why Do We Use It?
- [ ] 35.2 Stored Procedure vs Normal Query
- [ ] 35.3 What is a Procedure in SQL? (Definition & What It Can Contain)
- [ ] 35.4 Key Points About Procedures
- [ ] 35.5 What is the Purpose of Using a Procedure?
- [ ] 35.6 Advantages of Procedures & Real-World Example
- [ ] 35.7 Use Cases of Stored Procedures
- [ ] 35.8 How to Create a Procedure (Syntax)
- [ ] 35.9 Parameters in a Stored Procedure
- [ ] 35.10 Default Parameter Values
- [ ] 35.11 Multiple Statements in a Stored Procedure
- [ ] 35.12 Variables in MySQL (User-Defined vs Local)
- [ ] 35.13 Control Flow: IF ... ELSEIF ... ELSE
- [ ] 35.14 Loops in a Stored Procedure
- [ ] 35.15 Best-Practice Notes for Procedures
- [ ] 35.16 What is DELIMITER in MySQL?
- [ ] 35.17 Messages in a Procedure (SIGNAL & Variables)
- [ ] 35.18 Types of Procedures & How to Execute Them
- [ ] 35.19 Creating Procedures With and Without Parameters (IN, OUT, INOUT)
- [ ] 35.20 Error Handling in Stored Procedures
- [ ] 35.21 Topic 35 Summary (मराठी सारांश)

### [Topic 36: Stored Functions (User-Defined Functions) in MySQL](SQL_Master_Guide_Updated.md#topic-36-stored-functions-user-defined-functions-in-mysql)

- [ ] 36.1 What is a Function in SQL?
- [ ] 36.2 Why Use Functions?
- [ ] 36.3 Syntax in MySQL
- [ ] 36.4 Function Examples
- [ ] 36.5 How to Manage & Drop Functions
- [ ] 36.6 Differences Between Function and Procedure
- [ ] 36.7 Interview Perspective (नेहमी विचारले जाणारे प्रश्न)
- [ ] 36.8 Topic 36 Summary (मराठी सारांश)

### [Topic 37: Triggers in MySQL](SQL_Master_Guide_Updated.md#topic-37-triggers-in-mysql)

- [ ] 37.1 Why Triggers? (From Procedures to Automatic Actions)
- [ ] 37.2 What are Triggers?
- [ ] 37.3 Trigger Levels (Row-level vs Statement-level)
- [ ] 37.4 Key Points About Triggers
- [ ] 37.5 Syntax of a Trigger
- [ ] 37.6 Types of Triggers (and Which Databases Support Them)
- [ ] 37.7 Trigger Timing in MySQL (BEFORE vs AFTER)
- [ ] 37.8 Managing Triggers in MySQL
- [ ] 37.9 How to Modify / Update a Trigger
- [ ] 37.10 Use Cases of Triggers (15 Practical Examples)
- [ ] 37.11 Summary of Trigger Use Cases
- [ ] 37.12 Important Key Points About Triggers in MySQL
- [ ] 37.13 Triggers with Programming Logic (Variables, IF, CASE, Loops)
- [ ] 37.14 Interview Perspective (नेहमी विचारले जाणारे प्रश्न)
- [ ] 37.15 Topic 37 Summary (मराठी सारांश)

### [Topic 38: Events in MySQL (Scheduled Jobs)](SQL_Master_Guide_Updated.md#topic-38-events-in-mysql-scheduled-jobs)

- [ ] 38.1 What is an Event?
- [ ] 38.2 Purpose of Events
- [ ] 38.3 Use Cases of Events
- [ ] 38.4 Types of Events (One-Time vs Recurring)
- [ ] 38.5 Why We Use Events & How to Create Them
- [ ] 38.6 Managing Events (Scheduler, Show, Alter, Enable/Disable, Drop)
- [ ] 38.7 Differences Between Triggers and Events
- [ ] 38.8 When to Use a One-Time Event vs a Recurring Event
- [ ] 38.9 Interview Perspective (नेहमी विचारले जाणारे प्रश्न)
- [ ] 38.10 Topic 38 Summary (मराठी सारांश)

### [Topic 39: Cursors in MySQL](SQL_Master_Guide_Updated.md#topic-39-cursors-in-mysql)

- [ ] 39.1 What is a Cursor?
- [ ] 39.2 Cursor Lifecycle: DECLARE → OPEN → FETCH → CLOSE
- [ ] 39.3 Full Working Example
- [ ] 39.4 Common Mistakes with Cursors
- [ ] 39.5 Cursor vs Set-Based SQL
- [ ] 39.6 Interview Perspective (नेहमी विचारले जाणारे प्रश्न)
- [ ] 39.7 Topic 39 Summary (मराठी सारांश)

---

## Part 6: Performance, Indexing & Database Internals

### [Topic 40: Database Engine Architecture & Storage Concepts](SQL_Master_Guide_Updated.md#topic-40-database-engine-architecture--storage-concepts)

- [ ] 40.1 What is a Data Warehouse?
- [ ] 40.2 The Database Engine
- [ ] 40.3 Database Storage Types (Disk vs Cache)
- [ ] 40.4 How a Simple Query Works (Step-by-Step)
- [ ] 40.5 Topic 40 Summary (मराठी सारांश)

### [Topic 41: Database Optimization & Indexing (Analytics & Performance)](SQL_Master_Guide_Updated.md#topic-41-database-optimization--indexing-analytics--performance)

- [ ] 41.1 Introduction to Performance Optimization
- [ ] 41.2 Database Storage Architecture: How data is stored?
- [ ] 41.3 The HEAP Structure & Full Table Scan
- [ ] 41.4 The Clustered Index (B-Tree Structure) & Reading Speed
- [ ] 41.5 Non-Clustered Index (Secondary Index)
- [ ] 41.6 Clustered vs Non-Clustered Index Summary
- [ ] 41.7 Rowstore vs Columnstore Index (Storage Architecture)
- [ ] 41.8 Indexing by Function (Unique, Filtered, Composite)
- [ ] 41.9 Indexing Best Practices in MySQL
- [ ] 41.10 Advantages & Disadvantages of Indexes
- [ ] 41.11 Index Management & Monitoring
- [ ] 41.12 Indexing Strategies
- [ ] 41.13 Interview Perspective (Pro-Tips)
- [ ] 41.14 Topic 41 Summary (मराठी सारांश)

### [Topic 42: Heap vs Clustered Index (Internal Storage)](SQL_Master_Guide_Updated.md#topic-42-heap-vs-clustered-index-internal-storage)

- [ ] 42.1 What is a Heap Table?
- [ ] 42.2 What is a Clustered Index?
- [ ] 42.3 Topic 42 Summary (मराठी सारांश)

### [Topic 43: Query Execution Plans (EXPLAIN)](SQL_Master_Guide_Updated.md#topic-43-query-execution-plans-explain)

- [ ] 43.1 What is an Execution Plan?
- [ ] 43.2 Types of Execution Plans
- [ ] 43.3 Estimated vs Actual Execution Plan Match
- [ ] 43.4 Interview Perspective (नेहमी विचारले जाणारे प्रश्न)
- [ ] 43.5 Topic 43 Summary (मराठी सारांश)

### [Topic 44: Scans & Seeks (Data Access Methods)](SQL_Master_Guide_Updated.md#topic-44-scans--seeks-data-access-methods)

- [ ] 44.1 What is a Table Scan?
- [ ] 44.2 What is an Index Scan?
- [ ] 44.3 What is an Index Seek?
- [ ] 44.4 Best Practices to Ensure Index Seek
- [ ] 44.5 Topic 44 Summary (मराठी सारांश)

### [Topic 45: SQL Join Algorithms (How Joins Work Internally)](SQL_Master_Guide_Updated.md#topic-45-sql-join-algorithms-how-joins-work-internally)

- [ ] 45.1 Nested Loop Join (NLJ)
- [ ] 45.2 Hash Join (MySQL 8.0.18+)
- [ ] 45.3 Block Nested Loop Join (BNLJ)
- [ ] 45.4 Topic 45 Summary (मराठी सारांश)

### [Topic 46: SQL Table Partitioning (Performance Optimization)](SQL_Master_Guide_Updated.md#topic-46-sql-table-partitioning-performance-optimization)

- [ ] 46.1 What is Partitioning?
- [ ] 46.2 The Problem: Why Do We Need Partitioning?
- [ ] 46.3 The Solution: Partitioning & Scalability
- [ ] 46.4 Advantages & Limitations of Partitioning
- [ ] 46.5 Partition Boundaries (LEFT vs RIGHT)
- [ ] 46.6 Building Partitions in MySQL (4 Steps)
- [ ] 46.7 Interview Perspective (Pro-Tips)
- [ ] 46.8 Topic 46 Summary (मराठी सारांश)

### [Topic 47: Query Optimization / Tuning Checklist (Interview Favorite)](SQL_Master_Guide_Updated.md#topic-47-query-optimization--tuning-checklist-interview-favorite)

- [ ] 47.1 Topic 47 Summary (मराठी सारांश)

### [Topic 48: Query Optimization Techniques in SQL (Detailed Guide)](SQL_Master_Guide_Updated.md#topic-48-query-optimization-techniques-in-sql-detailed-guide)

- [ ] 48.1 What is Query Optimization?
- [ ] 48.2 Step 1: Measure First — EXPLAIN, EXPLAIN FORMAT=JSON, EXPLAIN ANALYZE
- [ ] 48.3 Optimize Data Retrieval
- [ ] 48.4 Indexing Strategies
- [ ] 48.5 Join Optimization
- [ ] 48.6 Avoid Costly Operations
- [ ] 48.7 Data Type Optimization
- [ ] 48.8 Stored Procedures for Optimization
- [ ] 48.9 Avoid != / <> in WHERE Clauses
- [ ] 48.10 Subquery Optimization
- [ ] 48.11 Batch & Parallel Processing
- [ ] 48.12 Partitioning & Sharding (Advanced)
- [ ] 48.13 Caching
- [ ] 48.14 Use Window Functions
- [ ] 48.15 Connection & Transaction Management
- [ ] 48.16 In Short & Topic 48 Summary (मराठी सारांश)

---

## Part 7: Database Design & Data Management

### [Topic 49: Database Normalization (1NF to BCNF)](SQL_Master_Guide_Updated.md#topic-49-database-normalization-1nf-to-bcnf)

- [ ] 49.1 What is Normalization?
- [ ] 49.2 The Normal Forms (Step-by-Step)
- [ ] 49.3 What is Denormalization?
- [ ] 49.4 Data Warehouse Modeling: OLTP vs OLAP, Star & Snowflake Schema
- [ ] 49.5 Topic 49 Summary (मराठी सारांश)

### [Topic 50: Associations (Relationships Between Tables)](SQL_Master_Guide_Updated.md#topic-50-associations-relationships-between-tables)

- [ ] 50.1 What is an Association in SQL?
- [ ] 50.2 Types of Associations (Relationships)
- [ ] 50.3 Why Associations Are Important
- [ ] 50.4 How Associations Are Implemented in SQL
- [ ] 50.5 Interview Perspective (नेहमी विचारले जाणारे प्रश्न)
- [ ] 50.6 Topic 50 Summary (मराठी सारांश)

### [Topic 51: Database Import & Export (CSV, SQL Dumps)](SQL_Master_Guide_Updated.md#topic-51-database-import--export-csv-sql-dumps)

- [ ] 51.1 Working with CSV Files
- [ ] 51.2 Importing Data into MySQL
- [ ] 51.3 Exporting Data from MySQL
- [ ] 51.4 Database Backups & Dumps (mysqldump)
- [ ] 51.5 Exporting/Importing Other File Types (XML & JSON)
- [ ] 51.6 Advanced mysqldump (Routines, Triggers, Events)
- [ ] 51.7 Performance Tip: Importing HUGE SQL Files
- [ ] 51.8 Backup Strategy & Replication
- [ ] 51.9 Topic 51 Summary (मराठी सारांश)

---

## Part 8: Final Revision & Interview Preparation

### [Topic 52: Final Summary / निष्कर्ष](SQL_Master_Guide_Updated.md#topic-52-final-summary--निष्कर्ष)

- [ ] 52.0 संपूर्ण topic वाचा

### [Topic 53: Interview Q&A Bank (Most-Asked SQL Questions)](SQL_Master_Guide_Updated.md#topic-53-interview-qa-bank-most-asked-sql-questions)

- [ ] 53.1 Part A: Database Basics
- [ ] 53.2 Part B: Data Types
- [ ] 53.3 Part C: DDL, DML & Command Types
- [ ] 53.4 Part D: Keys & Constraints
- [ ] 53.5 Part E: Querying, Filtering, Grouping
- [ ] 53.6 Part F: Joins & SET Operators
- [ ] 53.7 Part G: Functions, NULL & CASE
- [ ] 53.8 Part H: Window Functions
- [ ] 53.9 Part I: Transactions & Security
- [ ] 53.10 Part J: Query-Writing Questions (Practice These)
- [ ] 53.11 Part K: Transactions, Locks & Concurrency
- [ ] 53.12 Part L: Indexes & Performance
- [ ] 53.13 Part M: Procedures, Functions, Triggers, Events & Cursors
- [ ] 53.14 Part N: Views, CTEs, Subqueries & Temporary Tables
- [ ] 53.15 Part O: Database Design, Normalization & Data Warehousing
- [ ] 53.16 Part P: Security, Backup & Administration
- [ ] 53.17 Part Q: Advanced Query-Writing Questions (with Sample Output)
- [ ] 53.18 Topic 53 Summary (मराठी सारांश)
