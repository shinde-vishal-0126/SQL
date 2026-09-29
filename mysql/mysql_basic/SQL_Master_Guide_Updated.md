# SQL & Database Master Notes

---

## 📑 Topic-Wise Indexing

- [⚡ Quick Revision Sheet (Read This Before the Interview)](#-quick-revision-sheet-read-this-before-the-interview)

1. [Topic 1: What is a Database?](#topic-1-what-is-a-database)
   - [1.1 Definition & Core Concept](#11-definition--core-concept)
   - [1.2 Detailed Database Structure & Components](#12-detailed-database-structure--components)
   - [1.3 Visual Concept: Without Database vs. With Database & SQL](#13-visual-concept-without-database-vs-with-database--sql)
   - [1.4 Topic 1 Summary (मराठी सारांश)](#14-topic-1-summary-मराठी-सारांश)
2. [Topic 2: What is a DBMS (Database Management System)?](#topic-2-what-is-a-dbms-database-management-system)
   - [2.1 Definition & Meaning](#21-definition--meaning)
   - [2.2 Why Do We Need a DBMS?](#22-why-do-we-need-a-dbms)
   - [2.3 Key Functions & Responsibilities](#23-key-functions--responsibilities)
   - [2.4 Step-by-Step Query Execution Lifecycle in DBMS](#24-step-by-step-query-execution-lifecycle-in-dbms)
   - [2.5 The 4 Core Pillars (Quick Reference)](#25-the-4-core-pillars-quick-reference)
   - [2.6 Popular Examples of DBMS / RDBMS](#26-popular-examples-of-dbms--rdbms)
   - [2.7 Visual Architecture: Server, Database, DBMS & Clients](#27-visual-architecture-server-database-dbms--clients)
   - [2.8 Topic 2 Summary (मराठी सारांश)](#28-topic-2-summary-मराठी-सारांश)
3. [Topic 3: What is SQL?](#topic-3-what-is-sql)
   - [3.1 Definition & Core Meaning](#31-definition--core-meaning)
   - [3.2 Communicating with the Database Brain (Asking Questions)](#32-communicating-with-the-database-brain-asking-questions)
   - [3.3 Accessing & Manipulating Data (CRUD Operations)](#33-accessing--manipulating-data-crud-operations)
   - [3.4 Real-World Applications & Use Cases of SQL](#34-real-world-applications--use-cases-of-sql)
   - [3.5 In Short: The 4 Pillars Chain](#35-in-short-the-4-pillars-chain)
   - [3.6 Visual Concept: How SQL Speaks to the Database](#36-visual-concept-how-sql-speaks-to-the-database)
   - [3.7 Topic 3 Summary (मराठी सारांश)](#37-topic-3-summary-मराठी-सारांश)
4. [Topic 4: Main 2 Types of Databases (SQL vs NO-SQL)](#topic-4-main-2-types-of-databases-sql-vs-no-sql)
   - [4.1 Overview: SQL vs NO-SQL](#41-overview-sql-vs-no-sql)
   - [4.2 Relational Database (SQL)](#42-relational-database-sql)
   - [4.3 NO-SQL Databases (Non-Relational Models)](#43-no-sql-databases-non-relational-models)
   - [4.4 Visual Concept: SQL vs NO-SQL Architecture](#44-visual-concept-sql-vs-no-sql-architecture)
   - [4.5 Topic 4 Summary (मराठी सारांश)](#45-topic-4-summary-मराठी-सारांश)
5. [Topic 5: Why SQL?](#topic-5-why-sql)
   - [5.1 Standardized Way to Interact with Databases](#51-standardized-way-to-interact-with-databases)
   - [5.2 Efficient Data Retrieval](#52-efficient-data-retrieval)
   - [5.3 Data Manipulation (CRUD Examples)](#53-data-manipulation-crud-examples)
   - [5.4 Relationships Between Data](#54-relationships-between-data)
   - [5.5 Data Integrity and Security](#55-data-integrity-and-security)
   - [5.6 Scalability and Engine Optimization](#56-scalability-and-engine-optimization)
   - [5.7 The 3 Core Drivers: Talk to Data, High Demand, Industry Standard](#57-the-3-core-drivers-talk-to-data-high-demand-industry-standard)
   - [5.8 Visual Concept: Why SQL Mind-Map](#58-visual-concept-why-sql-mind-map)
   - [5.9 Topic 5 Summary (मराठी सारांश)](#59-topic-5-summary-मराठी-सारांश)
6. [Topic 6: Database Structure & Hierarchy](#topic-6-database-structure--hierarchy)
   - [6.1 The Relational Database Hierarchy](#61-the-relational-database-hierarchy)
   - [6.2 The Starting Point: Server](#62-the-starting-point-server)
   - [6.3 The Container: Database](#63-the-container-database)
   - [6.4 The Logical Organizer: Schema](#64-the-logical-organizer-schema)
   - [6.5 Types of Schemas (Logical vs. Physical)](#65-types-of-schemas-logical-vs-physical)
   - [6.6 The Core Object: Table, Columns, Rows & Cells](#66-the-core-object-table-columns-rows--cells)
   - [6.7 The Fingerprint: Primary Key](#67-the-fingerprint-primary-key)
   - [6.8 MySQL Data Types In-Depth](#68-mysql-data-types-in-depth)
     - [6.8.1 Memory Classification: Fixed Data Types vs. Variable Data Types](#681-memory-classification-fixed-data-types-vs-variable-data-types)
     - [6.8.2 Numeric Data Types](#682-numeric-data-types)
     - [6.8.3 String, Text, Binary & Specialized Data Types](#683-string-text-binary--specialized-data-types)
     - [6.8.4 Date and Time (Temporal) Data Types](#684-date-and-time-temporal-data-types)
     - [6.8.5 What is UTC (Coordinated Universal Time) & Why Does It Matter?](#685-what-is-utc-coordinated-universal-time--why-does-it-matter)
     - [6.8.6 Differences Between DATETIME and TIMESTAMP](#686-differences-between-datetime-and-timestamp)
     - [6.8.7 Practical Code Examples for Data Types](#687-practical-code-examples-for-data-types)
     - [6.8.8 Special Data Types: JSON In-Depth](#688-special-data-types-json-in-depth)
     - [6.8.9 Special Data Types: GEOMETRY Types for GIS / Spatial Data In-Depth](#689-special-data-types-geometry-types-for-gis--spatial-data-in-depth)
     - [6.8.10 Quick Overview: JSON & Spatial GEOMETRY (Methods & Properties Master Cheat Sheet)](#6810-quick-overview-json--spatial-geometry-methods--properties-master-cheat-sheet)
   - [6.9 Visual Architectural Diagrams for Data Types & Hierarchy](#69-visual-architectural-diagrams-for-data-types--hierarchy)
   - [6.10 Topic 6 Summary (मराठी सारांश)](#610-topic-6-summary-मराठी-सारांश)
7. [Topic 7: SQL vs MySQL](#topic-7-sql-vs-mysql)
   - [7.1 What is SQL?](#71-what-is-sql)
   - [7.2 What is MySQL?](#72-what-is-mysql)
   - [7.3 Key Differences: Comparison Table](#73-key-differences-comparison-table)
   - [7.4 Visual Concept: Language vs RDBMS Software](#74-visual-concept-language-vs-rdbms-software)
   - [7.5 Topic 7 Summary (मराठी सारांश)](#75-topic-7-summary-मराठी-सारांश)
8. [Topic 8: SQL Commands & DDL (Data Definition Language) In-Depth](#topic-8-sql-commands--ddl-data-definition-language-in-depth)
   - [8.1 Check Current SQL / MySQL Version](#81-check-current-sql--mysql-version)
   - [8.2 Broad Classification of SQL Commands](#82-broad-classification-of-sql-commands)
   - [8.3 What is DDL (Data Definition Language)?](#83-what-is-ddl-data-definition-language)
   - [8.4 The Implicit Commit Rule in MySQL](#84-the-implicit-commit-rule-in-mysql)
   - [8.5 CREATE Commands (Database, Tables, Indexes & Info)](#85-create-commands-database-tables-indexes--info)
   - [8.6 ALTER Commands (Database Level & Table Level)](#86-alter-commands-database-level--table-level)
   - [8.7 Constraints Management via ALTER (Add & Drop Rules)](#87-constraints-management-via-alter-add--drop-rules)
   - [8.8 Quick Revision Cheat Sheet: ALTER Operations](#88-quick-revision-cheat-sheet-alter-operations)
   - [8.9 DROP Commands (Permanent Object Deletion)](#89-drop-commands-permanent-object-deletion)
   - [8.10 TRUNCATE Commands (Wipe Data, Keep Structure)](#810-truncate-commands-wipe-data-keep-structure)
   - [8.11 RENAME Commands (Objects & Tables)](#811-rename-commands-objects--tables)
   - [8.12 Differences Between DELETE, TRUNCATE, and DROP](#812-differences-between-delete-truncate-and-drop)
   - [8.13 Visual Diagrams & Architectural Explanations](#813-visual-diagrams--architectural-explanations)
   - [8.14 Topic 8 Summary (मराठी सारांश)](#814-topic-8-summary-मराठी-सारांश)
9. [Topic 9: DML (Data Manipulation Language) In-Depth](#topic-9-dml-data-manipulation-language-in-depth)
   - [9.1 What is DML (Data Manipulation Language)?](#91-what-is-dml-data-manipulation-language)
   - [9.2 The INSERT Command & Bulk Operations](#92-the-insert-command--bulk-operations)
   - [9.3 The UPDATE Command & Best Practices](#93-the-update-command--best-practices)
   - [9.4 The DELETE Command & Safe Execution](#94-the-delete-command--safe-execution)
   - [9.5 MySQL Safe Update Mode (SQL_SAFE_UPDATES)](#95-mysql-safe-update-mode-sql_safe_updates)
   - [9.6 Soft Delete vs Hard Delete (In-Depth Comparison)](#96-soft-delete-vs-hard-delete-in-depth-comparison)
   - [9.7 Foreign Key Referential Actions (Complete Guide)](#97-foreign-key-referential-actions-complete-guide)
   - [9.8 The REPLACE Command in SQL (MySQL Specific)](#98-the-replace-command-in-sql-mysql-specific)
   - [9.9 Comparison: ALTER Command vs UPDATE Command](#99-comparison-alter-command-vs-update-command)
   - [9.10 Visual Diagrams & Architectural Explanations](#910-visual-diagrams--architectural-explanations)
   - [9.11 Topic 9 Summary (मराठी सारांश)](#911-topic-9-summary-मराठी-सारांश)
10. [Topic 10: DQL (Data Query Language) & Data Retrieval](#topic-10-dql-data-query-language--data-retrieval)
    - [10.1 What is DQL (Data Query Language)?](#101-what-is-dql-data-query-language)
    - [10.2 Two Fundamental Ways to Retrieve Data via SELECT](#102-two-fundamental-ways-to-retrieve-data-via-select)
    - [10.3 Visual Concept: Whole Table vs. Specific Column Projection](#103-visual-concept-whole-table-vs-specific-column-projection)
    - [10.4 Topic 10 Summary (मराठी सारांश)](#104-topic-10-summary-मराठी-सारांश)
11. [Topic 11: DCL (Data Control Language) & Security / Access Control](#topic-11-dcl-data-control-language--security--access-control)
    - [11.1 What is DCL (Data Control Language)?](#111-what-is-dcl-data-control-language)
    - [11.2 Core DCL Commands: GRANT and REVOKE](#112-core-dcl-commands-grant-and-revoke)
    - [11.3 Inspecting Users & Privileges in MySQL](#113-inspecting-users--privileges-in-mysql)
    - [11.4 User Management & Creation (Read-Only User Concept)](#114-user-management--creation-read-only-user-concept)
    - [11.5 Step-by-Step Granting & Revoking Permissions](#115-step-by-step-granting--revoking-permissions)
    - [11.6 Database-Wide Privileges & Administrative Access](#116-database-wide-privileges--administrative-access)
    - [11.7 The 6 Core Privilege Categories in MySQL](#117-the-6-core-privilege-categories-in-mysql)
    - [11.8 Advanced Interview Concepts & Gotchas in DCL / Security](#118-advanced-interview-concepts--gotchas-in-dcl--security)
    - [11.9 Visual Architecture Diagram: DCL & Privileges](#119-visual-architecture-diagram-dcl--privileges)
    - [11.10 Topic 11 Summary (मराठी सारांश)](#1110-topic-11-summary-मराठी-सारांश)
12. [Topic 12: TCL (Transaction Control Language) & Transaction Management](#topic-12-tcl-transaction-control-language--transaction-management)
    - [12.1 What is TCL (Transaction Control Language)?](#121-what-is-tcl-transaction-control-language)
    - [12.2 What is a Transaction? (ACID Overview)](#122-what-is-a-transaction-acid-overview)
    - [12.3 Core TCL Commands: START, COMMIT, ROLLBACK, SAVEPOINT, SET](#123-core-tcl-commands-start-commit-rollback-savepoint-set)
    - [12.4 Real-World Banking Transaction Example (Atomic Transfer)](#124-real-world-banking-transaction-example-atomic-transfer)
    - [12.5 Critical Rules & Constraints of TCL](#125-critical-rules--constraints-of-tcl)
    - [12.6 Transaction Isolation Levels & Concurrency Anomalies](#126-transaction-isolation-levels--concurrency-anomalies)
    - [12.7 Advanced Interview Concepts & Gotchas in TCL / Transaction Management](#127-advanced-interview-concepts--gotchas-in-tcl--transaction-management)
    - [12.8 Visual Architecture Diagram: TCL Lifecycle & Isolation Levels](#128-visual-architecture-diagram-tcl-lifecycle--isolation-levels)
    - [12.9 Topic 12 Summary (मराठी सारांश)](#129-topic-12-summary-मराठी-सारांश)
13. [Topic 13: Commands to Query Data (DQL In-Depth, Clauses & Filtering)](#topic-13-commands-to-query-data-dql-in-depth-clauses--filtering)
    - [13.1 Commands to Query Data & What is DQL?](#131-commands-to-query-data--what-is-dql)
    - [13.2 The Core Mental Model: "Ask Your Data"](#132-the-core-mental-model-ask-your-data)
    - [13.3 Commands (to query the data) & Essential Database/Table Setup](#133-commands-to-query-the-data--essential-databasetable-setup)
    - [13.4 SQL Query Clauses (The 9 Building Blocks)](#134-sql-query-clauses-the-9-building-blocks)
    - [13.5 How SQL Works: Written Syntax (Left to Right) vs. Engine Execution Order](#135-how-sql-works-written-syntax-left-to-right-vs-engine-execution-order)
    - [13.6 Select Query / Data Retrieve Query: SELECT * vs. SELECT column_name](#136-select-query--data-retrieve-query-select--vs-select-column_name)
    - [13.7 Filtering Data & The WHERE Clause In-Depth](#137-filtering-data--the-where-clause-in-depth)
      - [13.7.1 The 5 Families of WHERE Clause Operators](#1371-the-5-families-of-where-clause-operators)
      - [13.7.2 Comparison Operators: Compare Two Things!](#1372-comparison-operators-compare-two-things)
      - [13.7.3 Master Comparison Operators Reference (Definitions & Descriptions)](#1373-master-comparison-operators-reference-definitions--descriptions)
      - [13.7.4 Internal Filtering Process (Row-by-Row Predicate Evaluation)](#1374-internal-filtering-process-row-by-row-predicate-evaluation)
      - [13.7.5 Practical Practice Questions (Hands-on Comparison Queries)](#1375-practical-practice-questions-hands-on-comparison-queries)
      - [13.7.6 Logical Operators In-Depth (AND, OR, NOT)](#1376-logical-operators-in-depth-and-or-not)
      - [13.7.7 Range Operator In-Depth: BETWEEN ... AND ...](#1377-range-operator-in-depth-between--and-)
      - [13.7.8 Membership Operator In-Depth: IN and NOT IN](#1378-membership-operator-in-depth-in-and-not-in)
      - [13.7.9 Search Operator In-Depth: LIKE and NOT LIKE (Pattern Matching)](#1379-search-operator-in-depth-like-and-not-like-pattern-matching)
      - [13.7.10 NULL Check Operator In-Depth: IS NULL and IS NOT NULL](#13710-null-check-operator-in-depth-is-null-and-is-not-null)
      - [13.7.11 Advanced Filtering: Aggregates with HAVING and Subqueries](#13711-advanced-filtering-aggregates-with-having-and-subqueries)
    - [13.8 Sorting Data & The ORDER BY Clause In-Depth](#138-sorting-data--the-order-by-clause-in-depth)
    - [13.9 Grouping Data & The GROUP BY Clause In-Depth (Data Aggregation)](#139-grouping-data--the-group-by-clause-in-depth-data-aggregation)
    - [13.10 Visual Diagrams & Architectural Reference](#1310-visual-diagrams--architectural-reference)
    - [13.11 Topic 13 Summary (मराठी सारांश)](#1311-topic-13-summary-मराठी-सारांश)
    - [13.12 SQL Clauses Deep Dive & Execution Order (Detailed Guide)](#1312-sql-clauses-deep-dive--execution-order-detailed-guide)
14. [Topic 14: Keys & Constraints in SQL](#topic-14-keys--constraints-in-sql)
    - [14.1 What are Key Constraints?](#141-what-are-key-constraints)
    - [14.2 SQL Constraints (Point-wise Detail)](#142-sql-constraints-point-wise-detail)
    - [14.3 Types of Keys (Database Architecture)](#143-types-of-keys-database-architecture)
    - [14.4 The Hierarchy of Keys (Visual Diagram)](#144-the-hierarchy-of-keys-visual-diagram)
15. [Topic 15: SQL Joins (Combining Data from Tables)](#topic-15-sql-joins-combining-data-from-tables)
    - [15.1 What are Joins & Why Do We Need Them?](#151-what-are-joins--why-do-we-need-them)
    - [15.2 Types of Joins (Basic to Advanced)](#152-types-of-joins-basic-to-advanced)
    - [15.3 Advanced Joins (Filtering & Special Cases)](#153-advanced-joins-filtering--special-cases)
    - [15.4 Summary: How to Choose the Right Join?](#154-summary-how-to-choose-the-right-join)
    - [15.5 Multi-Table Joins (Interview Perspective)](#155-multi-table-joins-interview-perspective)
    - [15.6 Pro-Tip: Interview Trick (Inner Join without INNER JOIN)](#156-pro-tip-interview-trick-inner-join-without-inner-join)
16. [Topic 16: SET Operators (Combining Rows)](#topic-16-set-operators-combining-rows)
    - [16.1 What are SET Operators & Why Do We Need Them?](#161-what-are-set-operators--why-do-we-need-them)
    - [16.2 The 6 Golden Rules of SET Operators](#162-the-6-golden-rules-of-set-operators)
    - [16.3 Types of SET Operators](#163-types-of-set-operators)
    - [16.4 Advanced Scenarios & Best Practices](#164-advanced-scenarios--best-practices)
    - [16.5 In-Depth Comparison: JOINs vs SET Operators](#165-in-depth-comparison-joins-vs-set-operators)
    - [16.6 Advanced Interview Insights (Pro-Tips)](#166-advanced-interview-insights-pro-tips)
17. [Topic 17: SQL Built-in Functions (String & Numeric)](#topic-17-sql-built-in-functions-string--numeric)
    - [17.1 What are SQL Functions?](#171-what-are-sql-functions)
    - [17.2 Categories of Functions](#172-categories-of-functions)
    - [17.3 Nested Functions](#173-nested-functions)
    - [17.4 String Functions (Manipulation & Extraction)](#174-string-functions-manipulation--extraction)
    - [17.5 Numeric Functions](#175-numeric-functions)
18. [Topic 18: Date and Time Functions](#topic-18-date-and-time-functions)
    - [18.1 Anatomy of Date & Time](#181-anatomy-of-date--time)
    - [18.2 Sources of Dates (How to Query Dates)](#182-sources-of-dates-how-to-query-dates)
    - [18.3 Overview of Built-in Date/Time Functions (MySQL focus)](#183-overview-of-built-in-datetime-functions-mysql-focus)
19. [Topic 19: NULL Functions & Conditional Logic (CASE)](#topic-19-null-functions--conditional-logic-case)
    - [19.1 What is NULL?](#191-what-is-null)
    - [19.2 Checking for NULL](#192-checking-for-null)
    - [19.3 Handling & Replacing NULL values](#193-handling--replacing-null-values)
    - [19.4 NULLIF()](#194-nullif)
    - [19.5 Data Policies regarding NULL, Space, and Empty](#195-data-policies-regarding-null-space-and-empty)
    - [19.6 Conditional Logic: CASE Statement](#196-conditional-logic-case-statement)
    - [19.7 IF() Function (MySQL Shorthand)](#197-if-function-mysql-shorthand)
20. [Topic 20: Aggregate & Window Functions (Analytics)](#topic-20-aggregate--window-functions-analytics)
    - [20.1 Aggregation Functions in SQL](#201-aggregation-functions-in-sql)
    - [20.2 Window Functions (Analytical Functions)](#202-window-functions-analytical-functions)
    - [20.3 Ranking Window Functions](#203-ranking-window-functions)
    - [20.4 Percentage-Based Ranking Functions](#204-percentage-based-ranking-functions)
    - [20.5 Aggregate Window Functions (SUM, AVG, MIN, MAX)](#205-aggregate-window-functions-sum-avg-min-max)
    - [20.6 Value Window Functions (Analytics Functions)](#206-value-window-functions-analytics-functions)
    - [20.7 Window Function Syntax Deep Dive (OVER Clause)](#207-window-function-syntax-deep-dive-over-clause)
    - [20.8 Window Function Limitations & Rules](#208-window-function-limitations--rules)
    - [20.9 Why Window Functions? (Advantages)](#209-why-window-functions-advantages)
    - [20.10 GROUP BY + HAVING vs Window Functions](#2010-group-by--having-vs-window-functions)
21. [Topic 21: Database Optimization & Indexing (Analytics & Performance)](#topic-21-database-optimization--indexing-analytics--performance)
    - [21.1 Introduction to Performance Optimization](#211-introduction-to-performance-optimization)
    - [21.2 Database Storage Architecture: How data is stored?](#212-database-storage-architecture-how-data-is-stored)
    - [21.3 The HEAP Structure & Full Table Scan](#213-the-heap-structure--full-table-scan)
    - [21.4 The Clustered Index (B-Tree Structure)](#214-the-clustered-index-b-tree-structure)
    - [21.5 Non-Clustered Index (Secondary Index)](#215-non-clustered-index-secondary-index)
    - [21.6 Clustered vs Non-Clustered Index Summary](#216-clustered-vs-non-clustered-index-summary)
    - [21.7 Rowstore vs Columnstore Index (Storage Architecture)](#217-rowstore-vs-columnstore-index-storage-architecture)
    - [21.8 Indexing by Function (Unique, Filtered, Composite)](#218-indexing-by-function)
    - [21.9 Indexing Best Practices in MySQL](#219-indexing-best-practices-in-mysql)
    - [21.10 Advantages & Disadvantages of Indexes](#2110-advantages--disadvantages-of-indexes)
    - [21.11 Index Management & Monitoring](#2111-index-management--monitoring)
    - [21.12 Indexing Strategies](#2112-indexing-strategies)
    - [21.13 Interview Perspective (Pro-Tips)](#2113-interview-perspective-pro-tips)
22. [Topic 22: Final Summary / निष्कर्ष](#topic-22-final-summary--निष्कर्ष)
23. [Topic 23: Interview Q&A Bank (Most-Asked SQL Questions)](#topic-23-interview-qa-bank-most-asked-sql-questions)
    - [23.1 Part A: Database Basics](#231-part-a-database-basics)
    - [23.2 Part B: Data Types](#232-part-b-data-types)
    - [23.3 Part C: DDL, DML & Command Types](#233-part-c-ddl-dml--command-types)
    - [23.4 Part D: Keys & Constraints](#234-part-d-keys--constraints)
    - [23.5 Part E: Querying, Filtering, Grouping](#235-part-e-querying-filtering-grouping)
    - [23.6 Part F: Joins & SET Operators](#236-part-f-joins--set-operators)
    - [23.7 Part G: Functions, NULL & CASE](#237-part-g-functions-null--case)
    - [23.8 Part H: Window Functions](#238-part-h-window-functions)
    - [23.9 Part I: Transactions & Security](#239-part-i-transactions--security)
    - [23.10 Part J: Query-Writing Questions (Practice These)](#2310-part-j-query-writing-questions-practice-these)
24. [Topic 24: Derived Tables in SQL](#topic-24-derived-tables-in-sql)
    - [24.1 What is a Derived Table?](#241-what-is-a-derived-table)
    - [24.2 Syntax and Example](#242-syntax-and-example)
    - [24.3 Difference Between Derived Table and Subquery](#243-difference-between-derived-table-and-subquery)
25. [Topic 25: Query Execution Plans (EXPLAIN)](#topic-25-query-execution-plans-explain)
26. [Topic 26: Scans & Seeks (Data Access Methods)](#topic-26-scans--seeks-data-access-methods)
27. [Topic 27: SQL Join Algorithms (How Joins Work Internally)](#topic-27-sql-join-algorithms-how-joins-work-internally)
28. [Topic 28: Heap vs Clustered Index (Internal Storage)](#topic-28-heap-vs-clustered-index-internal-storage)
29. [Topic 29: Table Duplication & Copying Techniques](#topic-29-table-duplication--copying-techniques)
30. [Topic 30: SQL Table Partitioning (Performance Optimization)](#topic-30-sql-table-partitioning-performance-optimization)
31. [Topic 31: CTEs (Common Table Expressions) & Recursive CTEs](#topic-31-ctes-common-table-expressions--recursive-ctes)
32. [Topic 32: ACID Properties & Transaction Isolation Levels](#topic-32-acid-properties--transaction-isolation-levels)
33. [Topic 33: Database Normalization (1NF to BCNF) & Denormalization](#topic-33-database-normalization-1nf-to-bcnf--denormalization)
34. [Topic 34: Deadlocks in SQL](#topic-34-deadlocks-in-sql)
35. [Topic 35: Query Optimization / Tuning Checklist](#topic-35-query-optimization--tuning-checklist-interview-favorite)
36. [Topic 36: Database Engine Architecture & Storage Concepts](#topic-36-database-engine-architecture--storage-concepts)
37. [Topic 37: Subqueries Deep Dive (Nested Queries)](#topic-37-subqueries-deep-dive-nested-queries)
38. [Topic 38: Subqueries Advanced (Clauses, Operators & Execution)](#topic-38-subqueries-advanced-clauses-operators--execution)
39. [Topic 39: Common Table Expressions (CTE)](#topic-39-common-table-expressions-cte)
40. [Topic 40: Database Import & Export (CSV, SQL Dumps)](#topic-40-database-import--export-csv-sql-dumps)
41. [Topic 41: SQL Server Architecture & Database Hierarchy](#topic-41-sql-server-architecture--database-hierarchy)
42. [Topic 42: SQL Views (Virtual Tables) Deep Dive](#topic-42-sql-views-virtual-tables-deep-dive)
    - [42.1 What is a View?](#421-what-is-a-view)
    - [42.2 Differences Between Table and View](#422-differences-between-table-and-view)
    - [42.3 Why Do We Need Views? (6 Major Use Cases)](#423-why-do-we-need-views-6-major-use-cases)
    - [42.4 View vs CTE](#424-view-vs-cte)
    - [42.5 Syntax & Schema Naming](#425-syntax--schema-naming)
    - [42.6 Modifying/Updating Views (CREATE OR REPLACE vs ALTER VIEW)](#426-modifyingupdating-views-create-or-replace-vs-alter-view)
    - [42.7 Updatable Views (Insert / Update / Delete through a View)](#427-updatable-views-insert--update--delete-through-a-view)
    - [42.8 Materialized Views (Performance Booster)](#428-materialized-views-performance-booster)
    - [42.9 Index vs View vs Materialized View](#429-index-vs-view-vs-materialized-view)
    - [42.10 How Database Executes a View](#4210-how-database-executes-a-view)
    - [42.11 Summary of SQL Views](#4211-summary-of-sql-views)
    - [42.12 Interview Perspective & Hindi Summary](#4212-interview-perspective--hindi-summary)
43. [Topic 43: Tables, CTAS & Temporary Tables Deep Dive](#topic-43-tables-ctas--temporary-tables-deep-dive)
    - [43.1 What are Database Tables? (Physical Storage vs Logical Grid)](#431-what-are-database-tables-physical-storage-vs-logical-grid)
    - [43.2 How to Create Permanent Tables: CREATE/INSERT vs CTAS](#432-how-to-create-permanent-tables-createinsert-vs-ctas)
    - [43.3 CTAS Use Cases](#433-ctas-use-cases)
    - [43.4 Temporary Tables (Session-Based Tables)](#434-temporary-tables-session-based-tables)
    - [43.5 How Database Executes Temporary Tables](#435-how-database-executes-temporary-tables)
    - [43.6 Use Case of Temporary Tables (ETL & Intermediate Results)](#436-use-case-of-temporary-tables-etl--intermediate-results)
    - [43.7 Ultimate Comparison: Subquery vs CTE vs Temp Table vs CTAS vs View](#437-ultimate-comparison-subquery-vs-cte-vs-temp-table-vs-ctas-vs-view)
    - [43.8 The Big Picture of SQL (How everything connects)](#438-the-big-picture-of-sql-how-everything-connects)
    - [43.9 Interview Perspective & Hindi Summary](#439-interview-perspective--hindi-summary)

---

## ⚡ Quick Revision Sheet (Read This Before the Interview)

> One page to revise everything fast. Each point is explained in detail in the topics below.

### A. The 5 Types of SQL Commands

| Type | Full Form | Commands | Works On | Can ROLLBACK? |
| :--- | :--- | :--- | :--- | :--- |
| **DDL** | Data Definition Language | `CREATE`, `ALTER`, `DROP`, `TRUNCATE`, `RENAME` | Structure (tables, databases) | ❌ No (auto-commit in MySQL) |
| **DML** | Data Manipulation Language | `INSERT`, `UPDATE`, `DELETE`, `REPLACE` | Data (rows) | ✅ Yes (inside a transaction) |
| **DQL** | Data Query Language | `SELECT` | Reads data only | — (nothing to undo) |
| **DCL** | Data Control Language | `GRANT`, `REVOKE` | Permissions | ❌ No |
| **TCL** | Transaction Control Language | `START TRANSACTION`, `COMMIT`, `ROLLBACK`, `SAVEPOINT` | Transactions | — |

### B. Query Writing Order vs. Execution Order

```
We WRITE :  SELECT → FROM → WHERE → GROUP BY → HAVING → ORDER BY → LIMIT
DB RUNS  :  FROM (+JOIN) → WHERE → GROUP BY → HAVING → SELECT (+window fn) → DISTINCT → ORDER BY → LIMIT
```
* That is why a `SELECT` alias **cannot** be used in `WHERE`, but **can** be used in `ORDER BY`.

### C. Most-Asked "Difference Between" Questions

| Question | Short Answer |
| :--- | :--- |
| `DELETE` vs `TRUNCATE` vs `DROP` | `DELETE` removes chosen rows (DML, can rollback). `TRUNCATE` empties the table fast (DDL, resets `AUTO_INCREMENT`). `DROP` removes the whole table. |
| `WHERE` vs `HAVING` | `WHERE` filters rows **before** grouping; `HAVING` filters groups **after** `GROUP BY` (can use `SUM`, `COUNT`…). |
| `UNION` vs `UNION ALL` | `UNION` removes duplicates (slower); `UNION ALL` keeps all rows (faster). |
| `CHAR` vs `VARCHAR` | `CHAR(n)` always uses n characters (padded); `VARCHAR(n)` uses only the actual length + 1–2 bytes. |
| `DATETIME` vs `TIMESTAMP` | `DATETIME`: 1000–9999, no time zone change. `TIMESTAMP`: 1970–2038, stored in UTC and converted to your time zone. |
| `PRIMARY KEY` vs `UNIQUE` | Primary key: only one per table, no NULL. Unique: many per table, NULL allowed. |
| `INNER JOIN` vs `LEFT JOIN` | Inner = only matching rows. Left = all rows from the left table + matches (NULL if no match). |
| `ROW_NUMBER` vs `RANK` vs `DENSE_RANK` | For values 100, 90, 90, 80 → `ROW_NUMBER`: 1,2,3,4 · `RANK`: 1,2,2,4 · `DENSE_RANK`: 1,2,2,3 |
| `COUNT(*)` vs `COUNT(col)` | `COUNT(*)` counts all rows; `COUNT(col)` counts only non-NULL values. |
| `GROUP BY` vs Window function | `GROUP BY` gives one row per group; a window function keeps every row and adds the result next to it. |
| Subquery vs JOIN | A JOIN combines columns from tables; a subquery uses one query's result inside another. JOINs are usually faster and easier to read. |
| Clustered vs Non-clustered index | Clustered = table rows are stored in key order (the Primary Key in InnoDB, only one). Non-clustered (secondary) = a separate structure pointing to the rows (many allowed). |

### D. NULL Rules (Very Common Traps)
* `NULL` means *unknown* — it is not `0` and not `''`.
* `col = NULL` is never true → always use `IS NULL` / `IS NOT NULL`.
* `NOT IN (1, 2, NULL)` returns **0 rows** → use `NOT EXISTS` instead.
* `SUM`, `AVG`, `COUNT(col)`, `MIN`, `MAX` **ignore** NULLs. `SUM` of an empty group returns `NULL`, not `0` → wrap in `COALESCE(SUM(col), 0)`.
* Replace NULL: `IFNULL(a, b)` (2 values) or `COALESCE(a, b, c, ...)` (first non-NULL).

### E. Top 10 Things Interviewers Love to Ask
1. Execution order of a query (section B above).
2. Nth highest salary (see Topic 22, Part J).
3. Find and delete duplicate rows (see Topic 22, Part J).
4. Customers who never placed an order → `LEFT JOIN ... WHERE o.customer_id IS NULL` or `NOT EXISTS` (see Topic 15).
5. `RANK` vs `DENSE_RANK` vs `ROW_NUMBER` (see Topic 20).
6. ACID properties and isolation levels — MySQL default = `REPEATABLE READ` (see Topic 12).
7. `NOT IN` with `NULL` returns 0 rows (see 13.7.8).
8. `DELETE` vs `TRUNCATE` vs `DROP` (see 8.12).
9. `WHERE` vs `HAVING` (see 13.12), and `UNION` vs `UNION ALL` (see Topic 16).
10. Primary Key vs Unique Key, and types of keys (see Topic 14).

* **📌 मराठी सारांश:** मुलाखतीच्या आधी हे पान वाचा — SQL कमांड्सचे ५ प्रकार, क्वेरी चालण्याचा क्रम, सर्वात जास्त विचारले जाणारे "फरक" (Difference) प्रश्न, NULL चे नियम आणि टॉप १० प्रश्न एका नजरेत.

---

## Topic 1: What is a Database?

### 1.1 Definition & Core Concept

* **Q. What is a Database?**
  * *Definition: A database is an organized collection of structured data that can be stored, managed, and retrieved efficiently using a computer system.*
  * *A database serves as a central container to store data in a systematic format that can be easily accessed and queried.*

---

### 1.2 Detailed Database Structure & Components

* **Q. What is a Database Structure and what are its core components?**
  * *Database structure means how data is arranged inside a database — which tables exist, what columns they have, and how they are linked.*

It includes the following five core building blocks:

1. **Schema**
   * *The complete blueprint or architectural design of the database (analogous to an architectural floor plan).*
   * Defines which tables exist, their fields, relational links, and integrity constraints.

2. **Tables (Relations)**
   * A grid of rows and columns where the actual data is stored.
   * Consists of *Rows* (*Tuples / Records*) representing individual entities, and *Columns* (*Attributes*) representing entity properties.

3. **Columns (Attributes / Fields)**
   * Specific attributes of an entity with strictly defined *Data Types* (e.g., `INT` for numbers, `VARCHAR` for variable text, `DATE`/`TIMESTAMP` for temporal values, `BOOLEAN` for true/false flags).

4. **Relationship Between Tables**
   * Establishes logical connections between tables using key references:
     * *One-to-One (1:1):* One user $\leftrightarrow$ One profile.
     * *One-to-Many (1:N):* One customer $\rightarrow$ Multiple placed orders.
     * *Many-to-Many (N:M):* Multiple students $\leftrightarrow$ Multiple enrolled courses.

5. **Constraints (Integrity Rules)**
   * Rules that stop wrong, empty or duplicate data from entering a table:
     * `PRIMARY KEY`: Uniquely identifies each record; neither `NULL` nor duplicate values are permitted.
     * `FOREIGN KEY`: Links a column to the primary key of another table, guaranteeing referential integrity.
     * `NOT NULL`: Requires the field to have a value (cannot be empty).
     * `UNIQUE`: Guarantees distinct values across all rows (e.g., email address, phone number).
     * `CHECK`: Validates conditions on input data (e.g., `CHECK (age >= 18)` or `CHECK (salary > 0)`).
     * `DEFAULT`: Fills in a preset value automatically when you don't give a value.

---

### 1.3 Visual Concept: Without Database vs. With Database & SQL

![Without Database vs With Database & SQL](./database_vs_sql_diagram.svg)

#### Simple Explanation of the Diagram:
1. **Left Side (Without a Database):**
   * Data is scattered across uncoordinated files like `.txt`, spreadsheets (`.xlsx`), and manual notes.
   * Asking a question like *"What is the total spending?"* requires manual, error-prone file searches across hundreds of documents.
2. **Right Side (With a Database & SQL):**
   * All data is kept together in one organized place — the database.
   * Data is structured into relational tables connected by keys.
   * Users ask questions using SQL (*Structured Query Language*).
   * The database calculates the answer (e.g., **"30M"**) in milliseconds.

* **📌 आकृतीचे मराठीत स्पष्टीकरण:**
  * *डावी बाजू (डेटाबेस नसताना):* डेटा विविध फाइल्स, स्प्रेडशीट्स व नोट्समध्ये अस्ताव्यस्त विखुरलेला असतो. सोपा हिशोब विचारल्यासही शेकडो फाइल्स मॅन्युअली तपासाव्या लागतात, ज्यामुळे वेळ वाया जातो आणि चुका होतात.
  * *उजवी बाजू (डेटाबेस व SQL सोबत):* सर्व प्रकारचा डेटा एकाच सुरक्षित डेटाबेस नावाच्या कंटेनरमध्ये नीटनेटका साठवला जातो. युजर SQL भाषेत प्रश्न विचारतो आणि डेटाबेस एका सेकंदात अचूक उत्तर (उदा. "30M") देतो.

---

### 1.4 Topic 1 Summary (मराठी सारांश)

* **डेटाबेस म्हणजे काय?** डेटा साठवण्यासाठीचा एक कंटेनर (Container). संगणक प्रणालीद्वारे डेटा सुरक्षितपणे साठवणे (store), व्यवस्थापित करणे (manage) आणि वेगाने मिळवणे (retrieve) यासाठी व्यवस्थित मांडणी केलेला डेटा संग्रह.
* **डेटाबेस रचना (Database Structure):**
  1. *Schema:* डेटाबेसचा संपूर्ण आराखडा (Blueprint).
  2. *Tables:* डेटा रो (Rows) आणि कॉलम (Columns) स्वरूपात साठवणारे टेबल्स.
  3. *Columns:* डेटाचे विशिष्ट प्रकार/फील्ड्स (Data Types: Numbers, Text, Date).
  4. *Relationship:* टेबल्समधील परस्पर संबंध ($1:1, 1:N, N:M$).
  5. *Constraints (नियम):* डेटा अचूक राहण्यासाठीचे नियम (`PRIMARY KEY`, `FOREIGN KEY`, `NOT NULL`, `UNIQUE`, `CHECK`, `DEFAULT`).
* **फायदा:** विखुरलेल्या फाईल्सऐवजी डेटाबेसमुळे सर्व डेटा एका ठिकाणी व्यवस्थित राहतो आणि SQL मुळे अचूक माहिती सेकंदात मिळते.

---

## Topic 2: What is a DBMS (Database Management System)?

### 2.1 Definition & Meaning

* **Q. What is a DBMS (Database Management System)?**
  * *DBMS stands for Database Management System.*
  * *Definition: A DBMS is software that manages a database. It lets users and applications create, read, update and delete data easily.*
  * *It also keeps the data secure and consistent (correct), even when many people use it at the same time.*
  * It powers the core CRUD operations:
    * *Create:* Insert new records (`INSERT`)
    * *Read:* Search and retrieve records (`SELECT`)
    * *Update:* Modify existing records (`UPDATE`)
    * *Delete:* Remove obsolete records (`DELETE`)

---

### 2.2 Why Do We Need a DBMS?

* **Q. Why do we need a DBMS instead of accessing raw database storage directly?**
  * *A database alone is only storage. It cannot check who the user is, decide which request runs first, or safely handle many users at the same time.*
  * Real-world applications encounter simultaneous high-volume traffic from:
    1. Multiple Developers / Database Administrators (running scripts and administration tasks)
    2. Web & Mobile Applications (concurrent read/write requests from millions of users)
    3. BI & Reporting Tools like Power BI / Tableau (generating real-time analytical dashboards)
  * So we need a smart manager in the middle that handles many requests at once, avoids crashes and protects the data — that manager is the DBMS.

---

### 2.3 Key Functions & Responsibilities

1. **Request Management & Traffic Routing:**
   * Receives requests from many applications, checks them, and passes them on for execution.
2. **Priority Handling (Query Scheduling):**
   * Decides which query runs first, so no request waits forever and queries don't block each other.
3. **Security Management & Access Control:**
   * Checks whether the user has permission to read or change the requested data.
4. **Data Integrity & Concurrency Control:**
   * Uses locks and transactions so that many users updating at the same time never corrupt the data.
5. **Backup & Disaster Recovery:**
   * Keeps a log of every change (write-ahead log, `WAL`) so data can be recovered after a power cut or crash.

---

### 2.4 Step-by-Step Query Execution Lifecycle in DBMS

![Step-by-Step Query Execution Lifecycle in DBMS](./query_execution_lifecycle.svg)

#### Detailed Step-by-Step Explanation of the Lifecycle:

1. **Step 1: Client Submits SQL Query**
   * Developers, client applications, and BI tools submit queries formatted in standard SQL (e.g., `SELECT SUM(amount) FROM sales;`).

2. **Step 2: DBMS Security & Authentication Check (Gatekeeper)**
   * Before parsing, the DBMS verifies:
     * *Is the user account authenticated?*
     * *Does the account hold permission to read or write the targeted tables?*
     * *Is the statement safe to process?*
   * Unauthorized requests are immediately blocked with an authentication error.

3. **Step 3: Query Priority & Optimization**
   * Approved queries wait in a queue. The Query Optimizer then chooses the fastest way to run each query (for example, whether to use an index and how to join tables).

4. **Step 4: Execution Engine (Storage I/O)**
   * The execution engine runs that plan: it takes the needed locks and reads/writes the data on disk.

5. **Step 5: Database Storage & Instant Result Delivery**
   * The matching rows are sent back to the client as a table (result set), usually in milliseconds.

> **💡 मराठी मध्ये समजून घ्या (Lifecycle in Marathi):**
> 1. *क्लायंट विनंती (Client Request):* युजर किंवा अ‍ॅप SQL द्वारे प्रश्न पाठवतो (उदा. Total Spending?).
> 2. *सुरक्षा तपासणी (Security Gate):* युजर अधिकृत आहे का आणि त्याला डेटा पाहण्याची परवानगी आहे का हे DBMS तपासते.
> 3. *प्राधान्यक्रम आणि ऑप्टिमायझर (Priority & Optimizer):* अनेक विनंत्यांमधून कोणती क्वेरी आधी चालवायची आणि सर्वात कमी वेळेत उत्तर कसे मिळवायचे हे ठरवले जाते.
> 4. *एक्झिक्यूशन इंजिन (Execution Engine):* डेटाबेसच्या प्रत्यक्ष स्टोरेजमधून डेटा शोधून आणला जातो.
> 5. *निकाल (Result):* अचूक उत्तर तयार करून सेकंदात क्लायंटला परत पाठवले जाते.

---

### 2.5 The 4 Core Pillars (Quick Reference)

| Component | Role in the Ecosystem | Simple Analogy |
| :--- | :--- | :--- |
| 🗄️ Database | Stores Data | The physical storage locker / container |
| 🗣️ SQL | Speaks to Database | The standardized language used to communicate |
| ⚙️ DBMS | Manages Database | The intelligent manager / security controller |
| 🖥️ Server | Hosts Database Engine | The 24/7 operating computer host (Cloud / On-Premise) |

---

### 2.6 Popular Examples of DBMS / RDBMS

> **Note on RDBMS:** Modern enterprise DBMS solutions are typically *RDBMS* (*Relational Database Management Systems*) because they structure information into related tables.

* **MySQL:** The world's most widely deployed open-source RDBMS (ideal for web architectures with PHP, Python, Java, Node.js).
* **PostgreSQL / pgAdmin:**
  * *PostgreSQL:* Highly extensible, enterprise-grade open-source relational DBMS.
  * *pgAdmin:* The official graphical management console for interacting with PostgreSQL.
* **Oracle Database:** Paid enterprise RDBMS used by large banks and big companies.
* **Microsoft SQL Server (MS SQL):** Enterprise database suite integrated with the Microsoft ecosystem and .NET.

---

### 2.7 Visual Architecture: Server, Database, DBMS & Clients

![DBMS Architecture Diagram](./dbms_architecture_diagram.svg)

#### Simple Explanation of the Diagram:
1. **The Server (Host Environment):**
   * The computer (physical or cloud) that runs the database 24/7.
2. **The Database (Data Container):**
   * The storage container containing tables, rows, columns, and relationships.
3. **The DBMS (The Manager):**
   * The software in the middle: it accepts connections, checks permissions, runs queries and reads/writes storage.
4. **Clients (Speaking via SQL):**
   * *Developers & DBAs:* Running administrative queries and migrations.
   * *Applications (App `</>`):* Web and mobile backend services processing user transactions.
   * *Analytics Tools (Power BI / Dashboards):* Running aggregate calculations for live executive reports.

* **📌 आकृतीचे मराठीत स्पष्टीकरण:**
  * *१. Server (सर्व्हर):* २४ तास चालू असणारे फिजिकल किंवा क्लाउड कॉम्प्युटर जिथे डेटाबेस प्रत्यक्ष राहतो.
  * *२. Database (डेटाबेस):* सर्व टेबल्स आणि डेटा साठवणारा मुख्य कंटेनर.
  * *३. DBMS (व्यवस्थापक सॉफ्टवेअर):* बाहेरील जग आणि डेटाबेस यांच्यातील सुरक्षा रक्षक व मॅनेजर.
  * *४. Clients (क्लायंट्स):* डेव्हलपर्स, ॲप्लिकेशन्स आणि ॲनालिटिक्स टूल्स जे SQL द्वारे DBMS कडे डेटा मागतात.

---

### 2.8 Topic 2 Summary (मराठी सारांश)

* **DBMS म्हणजे काय?**
  * *DBMS = Database Management System*. हे एक विशेष सॉफ्टवेअर आहे जे संपूर्ण डेटाबेसचे नियोजन व व्यवस्थापन करते.
  * हे युजर्सना डेटा तयार करणे (Create), वाचणे (Read), बदलणे (Update) आणि हटवणे (Delete) म्हणजेच CRUD ऑपरेशन्स करण्यास मदत करते.
* **DBMS ची गरज का असते?**
  * डेटाबेस हा केवळ डेटा साठवणारा कंटेनर असतो. एकाच वेळी हजारो युजर्स आणि ॲप्लिकेशन्सच्या विनंत्या सुरक्षितपणे हाताळण्यासाठी DBMS आवश्यक असतो.
  * *ट्रॅफिक व्यवस्थापन:* सर्व विनंत्या व्यवस्थित हाताळणे.
  * *प्राधान्यक्रम:* कोणती क्वेरी आधी चालवायची हे ठरवणे.
  * *सुरक्षा:* युजरला परवानगी आहे का हे तपासणे.
* **४ मुख्य खांब (Core Pillars):**
  1. *Database:* डेटा साठवतो.
  2. *SQL:* डेटाबेसशी बोलण्याची भाषा.
  3. *DBMS:* डेटाबेसचे व्यवस्थापन व सुरक्षा सांभाळणारे सॉफ्टवेअर.
  4. *Server:* जेथे डेटाबेस २४/७ सुरक्षितपणे चालू राहतो.
* **उदाहरणे:** MySQL, PostgreSQL (pgAdmin सह), Oracle, Microsoft SQL Server.

---

## Topic 3: What is SQL?

### 3.1 Definition & Core Meaning

* **Q. What is SQL?**
  * *SQL stands for: Structured Query Language (pronounced "Sequel" or "S-Q-L").*
  * *Definition: SQL is the standard language used to talk to relational databases — to create, read, update and delete data.*
  * *Almost every relational database (MySQL, PostgreSQL, Oracle, SQL Server) understands SQL.*

---

### 3.2 Communicating with the Database Brain (Asking Questions)

* With SQL you simply describe *what* data you want, and the database finds it for you (this is why SQL is called a *declarative* language).
* **Q. How do you query recent customer purchases in SQL?**
  * Business requirement: *"Show me all customers who completed purchases since last month."*
  * Query implementation:
    ```sql
    SELECT customer_id, first_name, last_name, email, purchase_date
    FROM customers
    WHERE purchase_date >= CURRENT_DATE - INTERVAL '1 month';
    ```
  * ⚠️ **Note:** `INTERVAL '1 month'` is PostgreSQL syntax. In MySQL write `CURRENT_DATE - INTERVAL 1 MONTH` (no quotes).

---

### 3.3 Accessing & Manipulating Data (CRUD Operations)

SQL supports all 4 basic data operations, together called **CRUD**:

| CRUD Operation | Meaning | Primary SQL Command | Example Syntax & Usage |
| :--- | :--- | :--- | :--- |
| Create | Adding new data records | `INSERT` | `INSERT INTO customers (name, email) VALUES ('Rohan', 'rohan@example.com');` |
| Read | Searching & viewing records | `SELECT` | `SELECT * FROM customers WHERE id = 101;` |
| Update | Modifying existing records | `UPDATE` | `UPDATE customers SET email = 'new_email@example.com' WHERE id = 101;` |
| Delete | Removing unwanted records | `DELETE` | `DELETE FROM customers WHERE id = 101;` |

---

### 3.4 Real-World Applications & Use Cases of SQL

SQL is used for much more than reading rows. 8 common uses:

1. **Data Integration:** Combining separate tables into unified analytical views using relational `JOIN` operations.
2. **Backup & Recovery:** Exporting database snapshots and recovering state after system failures.
3. **Big Data & Analytics:** Running aggregate analytics (`COUNT`, `SUM`, `AVG`, `GROUP BY`) to derive business metrics.
4. **Managing User Permissions:** Administering security using DCL statements (`GRANT`, `REVOKE`) to protect sensitive schemas.
5. **Creating Indexes:** Creating indexes (`CREATE INDEX`) so searches stay fast even with millions of rows.
6. **Automating Workflows:** Writing Stored Procedures, Functions, and Triggers to automate repeating database logic.
7. **Generating Reports:** Feeding clean, structured tables directly to BI dashboards, spreadsheets, and reporting engines.
8. **Powering Real-Time Applications:** Handling live transactions in e-commerce, banking, logistics and social media apps.

---

### 3.5 In Short: The 4 Pillars Chain

```
[ 🗄️ Database ] ────────► [ 🗣️ SQL ] ────────► [ ⚙️ DBMS ] ────────► [ 🖥️ Server ]
(Container to             (Language to           (Software manager      (Physical/cloud host
 store data)               speak to DB)           for database)          running 24/7)
```

1. **Database:** The container that stores organized records.
2. **SQL:** The language used to speak to the database.
3. **DBMS:** The software manager that executes queries, optimizes performance, and enforces security.
4. **Server:** The machine environment where the database services execute 24/7.

---

### 3.6 Visual Concept: How SQL Speaks to the Database

![What is SQL Diagram](./what_is_sql_diagram.svg)

#### Simple Explanation of the Diagram:
1. **Left Panel (Speaking in SQL):**
   * A human-language request (*"Show me all customers who bought items since last month!"*) translates into standard SQL (`SELECT * FROM customers WHERE ...`).
2. **Right Panel (Capabilities):**
   * Highlights the core functional roles of SQL: CRUD operations, Analytics, Permissions/Security, Indexing, Backup/Recovery, and Real-Time application support.
3. **Bottom Chain:**
   * Summarizes the foundational ecosystem formula: Database (Container) $\rightarrow$ SQL (Language) $\rightarrow$ DBMS (Manager) $\rightarrow$ Server (Host Machine).

* **📌 आकृतीचे मराठीत स्पष्टीकरण:**
  * *डावा भाग (SQL संवाद):* युझरचा साधा प्रश्न SQL क्वेरीमध्ये (`SELECT ... WHERE ...`) रूपांतरित होऊन डेटाबेसकडे पाठवला जातो.
  * *उजवा भाग (SQL ची ताकद):* SQL च्या मुख्य क्षमता दाखवतो—CRUD ऑपरेशन्स, ॲनालिटिक्स, युझर सुरक्षा, इंडेक्सिंग आणि बॅकअप.
  * *खालची साखळी (४ खांब):* डेटाबेस (कंटेनर) $\rightarrow$ SQL (भाषा) $\rightarrow$ DBMS (व्यवस्थापक) $\rightarrow$ Server (मशीन).

---

### 3.7 Topic 3 Summary (मराठी सारांश)

* **SQL म्हणजे काय?**
  * *SQL = Structured Query Language*. ही डेटाबेसशी संवाद साधण्याची अधिकृत भाषा आहे.
  * डेटाबेस नावाच्या मोठ्या संगणक मेंदूशी सहजपणे बोलण्यासाठी SQL चा वापर केला जातो.
* **प्रश्न विचारणे (Querying):**
  * SQL द्वारे आपण डेटाबेसला व्यावसायिक प्रश्न विचारून अचूक माहिती मिळवू शकतो.
* **CRUD ऑपरेशन्स:**
  * *Create:* नवीन डेटा भरणे (`INSERT`)
  * *Read:* डेटा शोधणे व पाहणे (`SELECT`)
  * *Update:* जुना डेटा बदलणे (`UPDATE`)
  * *Delete:* नको असलेला डेटा हटवणे (`DELETE`)
* **SQL चे मुख्य उपयोग:** डेटा इंटिग्रेशन (Joins), सुरक्षित बॅकअप, ॲनालिटिक्स, युझर परवानग्या, इंडेक्सिंग आणि रिअल-टाइम ॲप्लिकेशन्स.
* **थोडक्यात ४ खांब (The 4 Pillars):**
  * *Database:* डेटा साठवणारा कंटेनर.
  * *SQL:* डेटाबेसशी बोलण्याची भाषा.
  * *DBMS:* डेटाबेसचे नियंत्रण व सुरक्षा सांभाळणारे सॉफ्टवेअर.
  * *Server:* जेथे डेटाबेस २४/७ सुरक्षितपणे चालतो.

---

## Topic 4: Main 2 Types of Databases (SQL vs NO-SQL)

### 4.1 Overview: SQL vs NO-SQL

* **Q. What are the two primary classifications of modern databases?**
  * *Modern database architectures are primarily classified into two main paradigms:*
    1. **SQL** *(Relational Databases)*
    2. **NO-SQL** *(Non-Relational Databases)*

| Dimension | SQL (Relational Databases) | NO-SQL (Non-Relational Databases) |
| :--- | :--- | :--- |
| Storage Paradigm | Tables with strictly typed columns and rows | Key-Value, Document, Columnar, or Graph models |
| Schema Design | Predefined, rigid, structured schema | Flexible, dynamic, schema-less architecture |
| Primary Query Tool | Standardized SQL language | Specialized document queries, APIs, or key lookups |
| Primary Strengths | ACID compliance, data integrity, complex relations | Rapid horizontal scalability, big data, rapid prototyping |
| Typical Examples | MySQL, PostgreSQL, Oracle, SQL Server | MongoDB, Redis, Cassandra, Neo4j |

> **📌 Important Note:**
> * *Relational Database* is commonly referred to as *SQL*.
> * We group *Document*, *Graph*, *Column-based*, and *Key-value* data stores together $\rightarrow$ all those database engines are classified as NO-SQL databases.

---

### 4.2 Relational Database (SQL)

* **Q. What is a Relational Database and how does it organize data?**
  * *Definition: A relational database stores data in tables (rows and columns), and the tables are linked to each other using keys.*
  * *How it works:*
    * It works like Excel sheets.
    * Data entities are organized into *tables*, where each column represents an attribute and each row represents an individual record.
    * Data is held strictly in a *tabular format*.
    * Foreign keys create *relationships between tables*, so the same data doesn't have to be stored again and again.
* **Popular Examples:**
  * MySQL
  * PostgreSQL
  * Microsoft SQL Server

---

### 4.3 NO-SQL Databases (Non-Relational Models)

NoSQL (non-relational) databases store data that does not fit neatly into tables. There are 4 main types:

#### 1. Key-Value Pair Database
* **Q. What is a Key-Value database and where is it used?**
  * *Definition: A Key-Value database stores every item as a pair: a unique key and its value — like a dictionary.*
  * *Think of it like an indexed dictionary:*
    * The word functions as the *Key*.
    * The explanation represents the *Value*.
  * Data is stored directly as Key ➔ Value pairs in object formats.
* **Popular Examples:**
  * Redis
  * Amazon DynamoDB

#### 2. Column-Based Database
* **Q. What is a Column-Based database and why is it used for Big Data?**
  * *Definition: A Column-Based (wide-column) database stores data column by column instead of row by row, which makes reading and summarizing huge data very fast.*
  * Built for *Big Data* and data warehouses with billions of records.
  * Because data is stored by column, a query reads only the columns it needs, so much less disk reading is required.
* **Popular Examples:**
  * Apache Cassandra
  * Amazon Redshift

#### 3. Graph Database
* **Q. What is a Graph database and what problems does it solve?**
  * *Definition: A Graph database stores data as nodes (things) and edges (connections between things).*
  * Best when the *relationships between items* matter most (e.g., social network followers, fraud detection, recommendations).
* **Popular Example:**
  * Neo4j

#### 4. Document-Based Database
* **Q. What is a Document database?**
  * *Definition: A Document database stores each record as a document (usually JSON), and different documents can have different fields.*
  * Instead of splitting data into many tables, all details of one item are kept together in one document.
* **Popular Example:**
  * MongoDB

---

### 4.4 Visual Concept: SQL vs NO-SQL Architecture

![Main 2 Types of Databases: SQL vs NoSQL](./types_of_databases_diagram.svg)

#### Simple Explanation of the Diagram:
1. **Right Side (SQL - Relational):**
   * Stored in structured tables with rows and columns (analogous to spreadsheets).
   * Tables maintain explicit relationships through primary and foreign keys.
   * *Examples:* Microsoft SQL Server, MySQL, PostgreSQL.
2. **Left Side (NO-SQL Cloud):**
   * Combines four specialized non-relational storage models:
     * *Document:* Packages all related entity data inside a single JSON document (*MongoDB*).
     * *Graph:* Maps interconnected data points focusing on network relationships (*Neo4j*).
     * *Column-Based:* Organizes storage by columns for rapid big data search queries (*Cassandra, Redshift*).
     * *Key-Value:* Associative dictionary model indexing pairs (*Redis, DynamoDB*).

* **📌 आकृतीचे मराठीत स्पष्टीकरण:**
  * *उजवी बाजू (SQL - Relational):* एक्सेलसारख्या टेबल्समध्ये रो आणि कॉलम्सच्या स्वरूपात डेटा ठेवला जातो आणि टेबल्समध्ये परस्पर संबंध (Keys) जोडलेले असतात (उदा. MySQL, PostgreSQL).
  * *डावी बाजू (NO-SQL - Non-Relational):* टेबल्स नसलेले ४ आधुनिक प्रकार—(१) *Document:* सर्व माहिती एकाच JSON पानात बसवणे (MongoDB), (२) *Graph:* नोड्स आणि संबंधांवर भर (Neo4j), (३) *Column-Based:* प्रचंड डेटा वेगाने शोधण्यासाठी कॉलम्समध्ये मांडणी (Cassandra), (४) *Key-Value:* शब्दकोशासारखी `Key ➔ Value` जोडी (Redis).

---

### 4.5 Topic 4 Summary (मराठी सारांश)

* **डेटाबेसचे २ मुख्य प्रकार:**
  1. *SQL (Relational Database)*
  2. *NO-SQL (Non-Relational Database)*

* **१. Relational Database (SQL):**
  * हे एक्सेल स्प्रेडशीटसारखे सोपे असते. याला टेबल (Table) म्हणतात, ज्यामध्ये *रो (Rows)* आणि *कॉलम (Columns)* असतात.
  * डेटा टेबल्समध्ये साठवला जातो आणि या टेबल्समध्ये एकमेकांशी *संबंध (Relationship)* जोडलेले असतात.
  * *उदाहरणे:* MySQL, PostgreSQL, Microsoft SQL Server.

* **२. NO-SQL Databases (४ मुख्य प्रकार):**
  * *Key-Value Pair Database:*
    * हा एका मोठ्या शब्दकोशासारखा (Dictionary) असतो. शब्द म्हणजे *Key* आणि त्याचा अर्थ म्हणजे *Value*.
    * *उदाहरणे:* Redis, Amazon DynamoDB.
  * *Column-Based Database:*
    * डेटा रोऐवजी कॉलम्समध्ये विभागला जातो. प्रचंड मोठ्या डेटावर (Big Data) वेगाने सर्चिंग करण्यासाठी याचा वापर होतो.
    * *उदाहरणे:* Apache Cassandra, Amazon Redshift.
  * *Graph Database:*
    * या डेटाबेसचा मुख्य भर डेटा पॉईंट्स एकमेकांना कसे जोडलेले आहेत (Relationships) यावर असतो.
    * *उदाहरणे:* Neo4j.
  * *Document-Based Database:*
    * सर्व माहिती एका संपूर्ण डॉक्युमेंटमध्ये (एकाच पानावर) साठवली जाते (JSON/BSON).
    * *उदाहरणे:* MongoDB.

* **लक्षात ठेवा:** Document, Graph, Column-based आणि Key-Value या सर्वांना मिळून NO-SQL म्हणतात; तर Relational डेटाबेसला SQL म्हणतात.

---

## Topic 5: Why SQL?

### 5.1 Standardized Way to Interact with Databases

* **Q. Why is SQL considered a standardized database language?**
  * *Universal Standard: SQL is an ANSI/ISO standard language, so the same basic SQL works on MySQL, PostgreSQL, Oracle and MS SQL Server.*
  * *Cross-Platform Compatibility:* Without SQL, every database would need its own language, and moving to a new database would be hard.

---

### 5.2 Efficient Data Retrieval

* Instead of downloading the whole table, SQL lets you fetch only the rows and columns you need.
* Using these clauses:
  * `SELECT`: Chooses which columns to show.
  * `WHERE`: Keeps only the rows that match a condition (e.g., `WHERE age >= 18`).
  * `JOIN`: Combines data from two or more tables.
  * `GROUP BY`: Groups rows so you can calculate totals like `SUM` or `COUNT` per group.

---

### 5.3 Data Manipulation (CRUD Examples)

SQL can add, change and remove data:

* **Insert new data:**
  ```sql
  INSERT INTO users (name, age) VALUES ('Vishal', 25);
  ```
* **Update existing data:**
  ```sql
  UPDATE users SET age = 26 WHERE name = 'Vishal';
  ```
* **Delete data:**
  ```sql
  DELETE FROM users WHERE age < 18;
  ```

---

### 5.4 Relationships Between Data

* Relational databases keep different things in separate tables (e.g., `Customers`, `Orders`, `Products`).
* SQL links these tables using keys (`PRIMARY KEY` and `FOREIGN KEY`), so the same data is not stored twice.

---

### 5.5 Data Integrity and Security

* **Q. How does SQL enforce data integrity and database security?**
  * *SQL protects data in 3 ways:*
    1. **Constraints:** Rules like `PRIMARY KEY`, `FOREIGN KEY`, `NOT NULL`, and `UNIQUE` reject wrong or duplicate data.
    2. **ACID Transactions:** A group of queries (like a money transfer) either *fully completes or is fully undone (rollback)* if an error occurs.
    3. **Access Control (Security):** DBAs give or take away permissions with statements like `GRANT SELECT` and `REVOKE DELETE`.

---

### 5.6 Scalability and Engine Optimization

* SQL databases can handle hundreds of millions of rows and still answer in under a second.
* They use B-Tree indexes, memory caching and a query planner to stay fast.
* Filtering or joining millions of rows in application code (Python, Java, C#) is much slower than letting the database do it.

---

### 5.7 The 3 Core Drivers: Talk to Data, High Demand, Industry Standard

```
              ┌──────────────────────────────────────────────┐
              │              WHY LEARN SQL?                  │
              └──────────────────────┬───────────────────────┘
                                     │
         ┌───────────────────────────┼───────────────────────────┐
         ▼                           ▼                           ▼
  [ 💬 TALK TO DATA ]      [ 🔥 HIGH DEMAND ]         [ 🌐 INDUSTRY STANDARD ]
  Standardized queries      Required for Devs,         Native support across
  to retrieve, insert,      Data Analysts, Data        Power BI, Tableau,
  update, & delete data.    Engineers, Scientists.     Spark, Kafka, Cloud.
```

1. **💬 TALK TO DATA:**
   * Universal communication bridge between users, client apps, and relational tables.
2. **🔥 HIGH DEMAND (Core Technical Competency):**
   * Foundational skill across key engineering and analytics professions:
     * *Software Developers:* Designing application backends, ORMs, and persistence layers.
     * *Data Analysts:* Extracting data to evaluate business trends and performance.
     * *Data Engineers:* Building ETL pipelines and cloud data warehouse architectures.
     * *Data Scientists:* Querying training and validation datasets for machine learning.
3. **🌐 INDUSTRY STANDARD (Broad Ecosystem Integration):**
   * Universally supported by analytics, streaming, and enterprise big data platforms:
     * *BI & Analytics:* Power BI, Tableau, Looker
     * *Streaming & Big Data:* Apache Spark, Apache Kafka
     * *Cloud Data Warehouses:* Snowflake, Google BigQuery, AWS Redshift

---

### 5.8 Visual Concept: Why SQL Mind-Map

![Why SQL Diagram](./why_sql_diagram.svg)

#### Simple Explanation of the Diagram:
* **The "Why SQL?" Core:** Branches out into three primary real-world drivers:
  1. *Talk to Data:* Standardized commands (`SELECT`, `INSERT`, `UPDATE`, `DELETE`) addressing enterprise datasets.
  2. *High Demand:* Core skill set for developers, analysts, engineers, and data scientists.
  3. *Industry Standard:* Native execution across Power BI, Tableau, Kafka, Spark, and cloud data warehouses.
* **Engine Guarantees (Bottom Banner):** Enforces data integrity through constraints, transactional reliability via rollback mechanisms, role permissions, and scalable performance over millions of records.

* **📌 आकृतीचे मराठीत स्पष्टीकरण:**
  * *मध्यवर्ती केंद्र (Why SQL?):* SQL का वापरावे याचे ३ प्रमुख आधार दाखवतो:
    1. *Talk to Data:* कोणत्याही डेटाबेसशी समान पद्धतीने संवाद साधणे.
    2. *High Demand:* डेव्हलपर्स, डेटा अनॅलिस्ट आणि डेटा सायंटिस्टसाठी सर्वाधिक मागणी असलेले कौशल्य.
    3. *Industry Standard:* Power BI, Tableau, Spark, Kafka आणि क्लाउड वेअरहाऊसमध्ये थेट चालणारी जागतिक भाषा.
  * *खालची पट्टी (इंजिनची सुरक्षा):* डेटाचे नियम (Constraints), व्यवहार सुरक्षितता (Rollback), आणि कोट्यवधी नोंदी जलद हाताळण्याची क्षमता.

---

### 5.9 Topic 5 Summary (मराठी सारांश)

* **SQL का वापरावे? (Why SQL):**
  1. *प्रमाणित भाषा (Standardized Way):* MySQL, PostgreSQL, Oracle, SQL Server अशा सर्व डेटाबेससाठी एकच समान भाषा आहे.
  2. *वेगाने आणि अचूक डेटा शोधणे (Efficient Data Retrieval):* `SELECT`, `WHERE`, `JOIN`, `GROUP BY` वापरून कोट्यवधी रेकॉर्ड्समधून हवा तेवढाच डेटा अचूक मिळवता येतो.
  3. *डेटा बदलणे (Data Manipulation):*
     * नवीन डेटा भरणे: `INSERT INTO users (name, age) VALUES ('Vishal', 25);`
     * जुना डेटा बदलणे: `UPDATE users SET age=26 WHERE name='Vishal';`
     * डेटा हटवणे: `DELETE FROM users WHERE age < 18;`
  4. *टेबल्समधील संबंध (Relationships):* Keys (Primary Key व Foreign Key) च्या मदतीने विविध टेबल्स एकमेकांशी अचूक जोडता येतात.
  5. *डेटा सुरक्षा आणि अचूकता (Integrity & Security):*
     * *Constraints:* चुकीचा डेटा येण्यापासून रोखतात.
     * *Transactions:* चूक झाल्यास व्यवहार त्वरित Rollback (पूर्ववत) करतात.
     * *Access Control:* युजर्सना हवे तेच अधिकार (`GRANT` / `REVOKE`) देऊन डेटा सुरक्षित ठेवतात.
  6. *प्रचंड डेटा हाताळण्याची क्षमता (Scalability & Optimization):* Indexes आणि Query Planners मुळे कोट्यवधी रेकॉर्ड्स जलद गतीने प्रोसेस होतात.
* **३ मुख्य चालक (The 3 Core Drivers):**
  * *Talk to Data:* डेटाबेसशी सहजपणे संवाद साधणे.
  * *High Demand:* Software Developers, Data Analysts, Data Engineers आणि Data Scientists या सर्वांसाठी अनिवार्य कौशल्य.
  * *Industry Standard:* Power BI, Tableau, Spark, Kafka आणि Azure Synapse या सर्व प्रमुख टूल्समध्ये SQL थेट चालते.

---

## Topic 6: Database Structure & Hierarchy

### 6.1 The Relational Database Hierarchy

* **Q. What is the Relational Database Hierarchy?**
  * *Definition: The database hierarchy is the set of levels in which data is organized: Server → Database → Schema → Table.*
  * Relational databases organize data in 4 levels:

```
[ Tier 1: SERVER ] ──► [ Tier 2: DATABASES ] ──► [ Tier 3: SCHEMAS ] ──► [ Tier 4: OBJECTS / TABLES ]
```

![Relational Database Hierarchy and Schema Types](./server_database_schema_hierarchy.svg)

#### Point-Wise Breakdown of the Hierarchy:

1. **Level 1: Server (Host Machine Environment)**
   * A computer (physical or cloud) that runs the database software.
   * Runs 24/7 and can host one or many databases.
   * Accepts connections, checks logins, runs queries and manages backups.

2. **Level 2: Databases (Isolated Storage Containers)**
   * Separate containers of data that live on the server.
   * A single server instance can host multiple independent databases (e.g., `Sales_DB`, `HR_DB`, `Inventory_DB`).
   * Each database holds the data of one application or department.

3. **Level 3: Schemas (Logical Categories & Namespaces)**
   * Logical folders inside a database that group related tables together.
   * They avoid name clashes and keep hundreds of tables organized (e.g., `orders.*`, `customers.*`).

4. **Level 4: Database Objects (Functional Components)**
   * A schema contains these database objects:
     * ⭐ *Tables:* The primary object; stores physical records in rows and columns.
     * 👁️ *Views:* Virtual tables compiled from saved `SELECT` queries.
     * ⚡ *Indexes:* Search structures (B-Trees) that make lookups fast.
     * 📜 *Stored Procedures:* Saved blocks of SQL code that you run by name.
     * 🔧 *Functions:* Reusable code that returns a value.
     * 🎯 *Triggers:* Code that runs automatically when a row is inserted, updated or deleted (`INSERT`, `UPDATE`, `DELETE`).
     * 🔢 *Sequences:* Number generators used for IDs (MySQL uses `AUTO_INCREMENT` instead).

---

### 6.2 The Starting Point: Server

* **Q. What is a Database Server?**
  * *Definition: A Database Server is the computer (physical machine or cloud VM) that runs the database software. It stores the data, runs queries and handles security.*
  * *Core Functions:*
    * Provides storage for one or more databases.
    * Accepts network connections from apps, developers and reporting tools.
    * Reads, optimizes and runs incoming queries.
    * Handles user logins, encryption, backups and crash recovery.

---

### 6.3 The Container: Database

* **Q. What is a Database container?**
  * *Definition: A database is a collection of related data, stored as a separate container inside the database server.*
  * *Core Functions:*
    * Keeps business data in one secure, organized place that can be queried.
    * Keeps the data of different applications or departments separate from each other.
  * *Real-World Examples:*
    * `Employee Database` (personnel records, compensation, department assignments)
    * `Student Database` (enrollments, grades, academic transcripts)
    * `Hospital Database` (patient charts, clinician schedules, medical prescriptions)

---

### 6.4 The Logical Organizer: Schema

* **Q. What is a Schema and why are schemas essential in enterprise databases?**
  * *Definition: A schema is a logical folder inside a database that groups tables and other objects. The word also means the structure (blueprint) of those objects.*
  * *Why do we need Schemas?*
    * Big systems have hundreds of tables. Keeping all of them in one flat list causes name clashes and is hard to manage.
    * Schemas split the tables into groups:
      * Cart, checkout, payment, and invoice tables $\rightarrow$ categorized under the orders schema.
      * Authentication, profiles, and billing addresses $\rightarrow$ categorized under the customers schema.

---

### 6.5 Types of Schemas (Logical vs. Physical)

Databases are designed in two complementary layers: **Logical** and **Physical**.

| Dimension | Logical Schema | Physical Schema |
| :--- | :--- | :--- |
| **Definition** | *Design of the tables and how they are related.* | *How the data is actually stored on disk (files, partitions, indexes).* |
| **Core Focus** | *What data is stored and how tables relate.* | *How data is physically laid out, indexed, and partitioned on disk.* |
| **Key Question** | *"What data do we store and how is it connected?"* | *"How and where is the data stored on disk?"* |
| **Components** | Tables, column datatypes, relationships, constraints. | Filepaths, tablespace files (`.ibd`), partitions, B-tree block sizes. |
| **Primary Audience** | Developers, Data Analysts, Data Modelers. | Database Administrators (DBAs), Storage Engineers, DB Engines. |
| **Visibility** | Visible to developers and SQL queries. | Hidden inside the storage engine. |

#### 1. Logical Schema (The Conceptual Blueprint)
* *Definition: The Logical Schema describes the tables, columns, relationships and rules — without caring how they are stored on disk.*
* Example: every row in `Orders` must point to an existing `Customer_ID` in `Customers`.

#### 2. Physical Schema (The Hardware Storage Blueprint)
* *Definition: The Physical Schema describes how the data is actually stored — files, locations, partitions and indexes.*
* Example: keep old 2020 data on cheaper, slower disks and current 2026 data on fast NVMe SSDs.

---

### 6.6 The Core Object: Table, Columns, Rows & Cells

* **Q. What is a Table and what constitutes its anatomy?**
  * *Definition: A Table stores data in rows (horizontal) and columns (vertical), like an Excel sheet.*

| Customer_ID | Customer_Name | City |
| :--- | :--- | :--- |
| 101 | Rahul | Pune |
| 102 | Priya | Mumbai |
| 103 | Amit | Nashik |

#### 1. Columns (Fields / Attributes)
* A column stores one property (attribute) for every row, e.g. `City`.
* Each column is bound to a single, strict *Data Type* (`INT`, `VARCHAR`, `DATE`, `DECIMAL`).
* Examples: `Customer_ID`, `Customer_Name`, `City`, `Age`.

#### 2. Rows (Records / Tuples)
* A row is one complete record, e.g. one customer.
* Example: The row `[101 | Rahul | Pune]` is one complete customer.

#### 3. Cell (Single Value)
* The meeting point of one row and one column — a single value (e.g., `101` or `'Rahul'`).
* Every cell must follow the column's data type and rules (constraints).

---

### 6.7 The Fingerprint: Primary Key

* **Q. What is a Primary Key and what are its 5 essential properties?**
  * *Definition: A Primary Key is a column (or a group of columns) that uniquely identifies every row in a table.*
  * *Like a fingerprint: no two rows can ever have the same Primary Key value.*

| Customer_ID (🔑 Primary Key) | Customer_Name | City |
| :--- | :--- | :--- |
| 101 | Rahul | Pune |
| 102 | Priya | Mumbai |

* **The 5 Core Properties of a Primary Key:**
  1. Unique: Every row must hold a distinct, non-duplicate key value.
  2. Cannot be NULL: Primary keys can never contain empty or missing values.
  3. Only ONE per Table: Each table is restricted to exactly one primary key definition.
  4. Automatic Index: MySQL (InnoDB) automatically builds a clustered index on it, so lookups by key are very fast.
  5. Referential Anchor: Serves as the referenced parent key for *Foreign Keys* in child tables.

---

### 6.8 MySQL Data Types In-Depth

*Definition: A data type tells what kind of value a column can store (number, text, date…), how much space it takes, and what operations can be done on it.*

---

#### 6.8.1 Memory Classification: Fixed Data Types vs. Variable Data Types

**Q. What are the two main types of data types based on memory allocation in MySQL?**

Based on how much space they use, data types are of 2 kinds:

1. **Fixed Data Type (Fixed Storage Allocation):**
   * *Definition: Fixed data types always take the same amount of space, no matter how long the actual value is.*
   * They are best used when the size of data is known, uniform, and consistent across all rows.
   * If an inserted value is shorter than the defined length, MySQL automatically pads it with spaces to fill the entire allocated slot (e.g., in `CHAR(n)`).
   * **Key Examples:** `CHAR(n)`, `INT`, `BIGINT`, `FLOAT`, `DOUBLE`, `DECIMAL`.
   * **Performance Advantage:** Slightly faster, because MySQL always knows the exact size — it doesn't need to read a length value first.

2. **Variable Data Type (Dynamic Storage Allocation):**
   * *Definition: Variable data types take only as much space as the actual value, plus 1–2 extra bytes to store its length.*
   * If a column allows up to 255 characters but only 5 characters are stored, it consumes only 5 bytes + 1 byte overhead.
   * **Key Examples:** `VARCHAR(n)`, `TEXT` (TINYTEXT, TEXT, MEDIUMTEXT, LONGTEXT), `BLOB`, `VARBINARY(n)`.
   * **Space Advantage:** Saves a lot of space when value lengths differ a lot from row to row.

##### Comparison: Fixed vs. Variable Data Types

| Feature / Dimension | Fixed Data Types (e.g., `CHAR(10)`) | Variable Data Types (e.g., `VARCHAR(10)`) |
| :--- | :--- | :--- |
| **Storage Allocation** | Takes fixed, predetermined storage size in memory | Takes storage dynamically based on actual value length |
| **Space Utilization** | Can waste disk/RAM space if values are short (pads with spaces) | Highly space-efficient (stores actual length + 1-2 prefix bytes) |
| **Read / Write Speed** | Slightly faster (size is always known) | Slightly slower (must read the length first) |
| **Space Overhead** | 0 overhead bytes (exact allocated size is reserved) | 1 byte (for $L \le 255$) or 2 bytes (for $L > 255$) length header |
| **Space Padding** | Automatically padded with right-side spaces on disk | No space padding; stored exactly as entered |
| **Best Used When** | Length is fixed and predictable across all rows | Length varies significantly across different rows |
| **Primary Examples** | `CHAR(n)`, `INT`, `BIGINT`, `DECIMAL`, `FLOAT`, `DOUBLE` | `VARCHAR(n)`, `TEXT`, `BLOB`, `VARBINARY(n)` |

##### Practical Example to Understand Memory Storage (CHAR(10) vs. VARCHAR(10))

Suppose we create two columns: `code_fixed CHAR(10)` and `code_var VARCHAR(10)`, and store the same string values. Notice how MySQL stores them physically:

| Inserted String | Actual Length | `CHAR(10)` Physical Storage | Bytes Used (`CHAR(10)`) | `VARCHAR(10)` Physical Storage | Bytes Used (`VARCHAR(10)`) | Memory Saved by VARCHAR |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| `''` (Empty) | 0 chars | `'          '` (10 spaces) | **10 Bytes** | `[0]` (length prefix 0) | **1 Byte** | **90% Saved** (9 Bytes) |
| `'AB'` | 2 chars | `'AB        '` (2 chars + 8 spaces) | **10 Bytes** | `[2] + 'AB'` | **3 Bytes** (2 + 1) | **70% Saved** (7 Bytes) |
| `'Pune'` | 4 chars | `'Pune      '` (4 chars + 6 spaces) | **10 Bytes** | `[4] + 'Pune'` | **5 Bytes** (4 + 1) | **50% Saved** (5 Bytes) |
| `'India'` | 5 chars | `'India     '` (5 chars + 5 spaces) | **10 Bytes** | `[5] + 'India'` | **6 Bytes** (5 + 1) | **40% Saved** (4 Bytes) |
| `'0123456789'` | 10 chars | `'0123456789'` (no spaces) | **10 Bytes** | `[10] + '0123456789'` | **11 Bytes** (10 + 1) | -1 Byte (overhead) |

##### Visual Memory Layout Diagram

```text
Storing 'Pune' (4 characters) in a 10-character column:

CHAR(10) Memory Slot (Always 10 bytes):
+---+---+---+---+---+---+---+---+---+---+
| P | u | n | e |   |   |   |   |   |   |  -> Fixed 10 Bytes allocated
+---+---+---+---+---+---+---+---+---+---+
                 ^^^^^^^^^^^^^^^^^^^^^^
                 (6 padded space bytes wasted)

VARCHAR(10) Memory Slot (Dynamic 4 + 1 = 5 bytes):
+--------+---+---+---+---+
| Length | P | u | n | e |  -> Only 5 Bytes total on disk
|   04   |   |   |   |   |     (1 byte length prefix + 4 char bytes)
+--------+---+---+---+---+
```

##### Hands-On SQL Demonstration: Fixed vs Variable Storage

````sql
-- 1. Create demonstration table
CREATE TABLE storage_comparison (
    id INT AUTO_INCREMENT PRIMARY KEY,
    description VARCHAR(30),
    country_iso_fixed CHAR(10),     -- Fixed allocation
    country_name_var VARCHAR(10)    -- Dynamic allocation
);

-- 2. Insert sample rows with varying lengths
INSERT INTO storage_comparison (description, country_iso_fixed, country_name_var)
VALUES 
    ('Two characters', 'IN', 'IN'),
    ('Four characters', 'Pune', 'Pune'),
    ('Full ten characters', '0123456789', '0123456789');

-- 3. Query actual character length vs storage consumption
SELECT 
    description,
    country_iso_fixed,
    CHAR_LENGTH(country_iso_fixed) AS fixed_char_count,
    OCTET_LENGTH(country_iso_fixed) AS fixed_bytes_stored,
    country_name_var,
    CHAR_LENGTH(country_name_var) AS var_char_count,
    OCTET_LENGTH(country_name_var) AS var_bytes_stored
FROM storage_comparison;
````

> [!TIP]
> **Production Rule of Thumb:**
> * Use **Fixed Data Types (`CHAR`)** when values are guaranteed to be the exact same length in every single row — e.g., ISO Country Codes (`'IN'`, `'US'`), SHA-256 Hashes (always 64 characters), UUIDs (36 characters), Currency codes (`'INR'`, `'USD'`), or MD5 checksums.
> * Use **Variable Data Types (`VARCHAR`)** whenever data length varies — e.g., User names, email addresses, city names, URLs, and street addresses.

---

#### 6.8.2 Numeric Data Types

**Q. What are the primary Numeric Data Types in MySQL and their storage ranges?**

Numeric data types store numbers and are broadly divided into **Integers (Whole Numbers)** and **Fractional / Decimal / Floating-Point Numbers**.

##### 1. Integer Data Types (Whole Numbers)
*Stores whole numbers (no decimals).*

* **`TINYINT`:**
  - Storage Size: **1 Byte** (8 bits).
  - Signed Range: `-128` to `127`.
  - Unsigned Range: `0` to `255`.
  - Best for: Age, status codes, small quantities.

* **`SMALLINT`:**
  - Storage Size: **2 Bytes** (16 bits).
  - Signed Range: `-32,768` to `32,767`.
  - Unsigned Range: `0` to `65,535`.
  - Best for: Small inventory items, years.

* **`MEDIUMINT`:**
  - Storage Size: **3 Bytes** (24 bits).
  - Signed Range: `-8,388,608` to `8,388,607`.
  - Unsigned Range: `0` to `16,777,215`.

* **`INT` / `INTEGER`:**
  - Storage Size: **4 Bytes** (32 bits).
  - Stores whole numbers (no decimals).
  - Signed Range: `-2,147,483,648` to `2,147,483,647` (~2.14 Billion).
  - `UNSIGNED INT` Range: `0` to `4,294,967,295` (~4.29 Billion).
  - Best for: Standard table primary keys, employee IDs, customer numbers.

* **`BIGINT`:**
  - Storage Size: **8 Bytes** (64 bits).
  - Stores very large whole numbers.
  - Signed Range: `-9 quintillion` to `9 quintillion` (`-9,223,372,036,854,775,808` to `9,223,372,036,854,775,807`).
  - Best for: High-volume financial transactions, global e-commerce order tracking, social media view counts.

##### 2. Exact Numeric Data Type: `DECIMAL(p, s)`
* *Definition: DECIMAL stores exact numeric values (not approximate) with user-defined precision and scale.*
* Used for exact decimal values like prices and money.
* **Parameters:**
  - `p` = **Precision**: Total number of significant digits (both before and after the decimal point). Maximum is 65.
  - `s` = **Scale**: Number of digits after the decimal point. Maximum is 30 ($s \le p$).
* **Core Characteristics:**
  - Stores exact numbers (not approximate).
  - Does not suffer from binary floating-point rounding inaccuracies.
  - **Best for: Money, financial accounting, banking balances, product prices.**
  - *Example:* `DECIMAL(10, 2)` stores numbers up to `99,999,999.99`.

##### 3. Approximate Numeric Data Types: `FLOAT` & `DOUBLE`
*Stores approximate decimal numbers (floating-point representation).*

* **`FLOAT`:**
  - Storage Size: **4 Bytes**.
  - Less precision (~7 decimal digits of precision).
  - Used for approximate decimal values.

* **`DOUBLE`:**
  - Storage Size: **8 Bytes**.
  - More precision (~15 decimal digits of precision).
  - Used for higher-accuracy scientific calculations.

* **Core Characteristics:**
  - Store approximate decimal numbers (floating point).
  - Used in science, engineering and statistics where speed matters more than exact accuracy. ⚠️ Never use `FLOAT`/`DOUBLE` for money — use `DECIMAL`.

---

#### 6.8.3 String, Text, Binary & Specialized Data Types

**Q. What are the String, Text, Binary, and Category Data Types available in MySQL?**

##### 1. `CHAR(n)` (Fixed-Length String)
* *Definition: CHAR(n) is a fixed-length string. It always uses space for n characters, even if the value is shorter.*
* **Core Characteristics:**
  - **Fixed length string:** Pre-allocates memory for the full defined length.
  - **Storage:** Always uses full defined length. If the data is shorter than $n$, MySQL automatically pads it with spaces on the right upon storage.
  - **Performance:** Slightly faster for fixed-length values.
  - **Range:** Supports up to **255 characters** ($0 \le n \le 255$).
  - **Wastes Space:** Wastes disk and RAM space if the inserted data is shorter than the defined capacity.
  - **Best Use Cases:** Fixed-size data where length is identical across every row (e.g., Postal/ZIP codes, ISO Country codes `'IN'`, `'US'`, Currency codes `'USD'`, `'INR'`, MD5/SHA hashes, Phone extensions).

##### 2. `VARCHAR(n)` (Variable-Length String)
* *Definition: VARCHAR(n) is a variable-length string. It stores only the characters you insert, plus 1–2 bytes for the length.*
* **Core Characteristics:**
  - **Variable length string:** Uses space based on the actual string length.
  - **Storage:** Uses only the number of characters actually stored + 1 byte (for $L \le 255$) or 2 bytes (for $L > 255$) for the length prefix.
  - **Performance:** Slightly slower when an update changes the value's length (the row may need to move).
  - **Range:** Up to **65,535** in theory, but the whole row is limited to 65,535 bytes, so in practice it is less (e.g., about 16,383 characters with `utf8mb4`).
  - **Space Efficient:** Highly space-efficient; stores only the needed length without space padding.
  - **Best Use Cases:** Variable data where string length differs widely across rows (e.g., Customer names, email addresses, street addresses, descriptions, URLs).

##### Comparison: `CHAR` vs. `VARCHAR`

| Feature / Dimension | `CHAR(n)` | `VARCHAR(n)` |
| :--- | :--- | :--- |
| **String Length Type** | **Fixed-length** string | **Variable-length** string |
| **Storage Allocation** | Always uses full defined length (padded with spaces if shorter) | Uses only the actual characters stored + 1 or 2 length prefix bytes |
| **Performance** | **Faster** for fixed-length values (predictable byte offsets) | **Slightly slower** for dynamic updates (variable row sizes) |
| **Maximum Range** | Up to **255 characters** | Up to **65,535 characters** (shared across row) |
| **Space Utilization** | **Wastes space** if data is shorter than $n$ | **Highly efficient** (allocates only needed space) |
| **Trailing Spaces** | Padded with spaces on storage; stripped when retrieved | Preserves trailing spaces exactly as entered |
| **Primary Use Cases** | Fixed-size data: Postal codes, Country codes (`'IN'`, `'US'`), Hashes | Variable-size data: User names, Email addresses, Passwords, URLs |

##### 3. `TEXT` Family (Long Text Strings)
*Stores long text. (Limits are in bytes — with multi-byte characters like Marathi or emoji, fewer characters fit.)*
* **`TINYTEXT`:** Stores up to **255 bytes**.
* **`TEXT`:** Stores up to **65,535 characters** (~64 KB).
* **`MEDIUMTEXT`:** Stores up to **16,777,215 characters** (~16 MB).
* **`LONGTEXT`:** Stores up to **4,294,967,295 characters** (~4 GB).
* **Best for:** Blog articles, product descriptions, customer feedback, HTML/XML content.

##### 4. `BLOB` (Binary Large Object)
* *Definition: BLOB (Binary Large Object) stores raw binary data (files), not text.*
* Stores binary data (images, files, PDFs, audio clips, compiled code).
* **Variants:** `TINYBLOB`, `BLOB`, `MEDIUMBLOB`, `LONGBLOB`.
* **Difference from TEXT:** Unlike `TEXT`, it is intended for raw binary files and has no character set or collation.

##### 5. `BIT` & `BINARY(n)`
* **`BINARY(n)`:** Fixed-length binary string.
* **`VARBINARY(n)`:** Variable-length binary string.
* **`BIT(m)`:** Stores bit values from 1 to 64 bits.
  - Stored in format 0 and 1.
  - If you don't give a `DEFAULT`, the column is `NULL` (not 0) when no value is inserted.

##### 6. `BOOLEAN` / `BOOL`
* *Definition: In MySQL, BOOLEAN is just another name (alias) for TINYINT(1).*
* Some databases (like SQL Server) use a `BIT` type instead. In MySQL, BOOLEAN stores 0 or 1:
  - `0` means FALSE.
  - `1` means TRUE.
* Tip: add `DEFAULT FALSE` if new rows should start as 0 (otherwise the default is `NULL`).

##### 7. `ENUM('val1', 'val2', ...)`
* *Definition: ENUM is a string data type that allows you to store ONE value from a predefined list of permitted values.*
* Useful when a column should accept only specific values (like gender, status, etc.) — kind of like a controlled vocabulary.
* Useful for fixed categories.
* *Example:* `status ENUM('active', 'inactive', 'pending')`. Rejects any value not in the list.

##### 8. `SET('val1', 'val2', ...)`
* *Definition: The SET data type is similar to ENUM, but instead of storing only one value, it can store MULTIPLE values (a combination) from a predefined list.*
* Stores multiple values from a predefined list.
* Each row can contain any combination of permitted values separated by commas.
* *Example:* `hobbies SET('Reading', 'Sports', 'Coding', 'Music')`. A row can store `'Reading,Coding'`.

---

#### 6.8.4 Date and Time (Temporal) Data Types

**Q. What are the Temporal (Date and Time) Data Types in MySQL?**

It is also known as the **temporal data type** family.

* **Default Date Format:** By default, MySQL stores date in **`YYYY-MM-DD`** format.
* **Memory Allocation:** **3 bytes** of memory allocated for a single date.
* **Supported Range for Date:** `1000-01-01` to `9999-12-31`.

##### 1. `DATE`
* Stores **date only** (`YYYY-MM-DD`).
* Storage: **3 Bytes**.
* Range: `1000-01-01` to `9999-12-31`.
* *Example:* `'2026-09-21'`.

##### 2. `TIME`
* Stores **time only** (`HH:MM:SS`).
* Storage: **3 Bytes** of memory occupied by a single time value.
* Covers 24 hours, 60 minutes, 60 seconds.
* Range: `-838:59:59` to `838:59:59` (supports elapsed intervals over multiple days).
* *Example:* `'15:45:30'`.

##### 3. `YEAR`
* Stores **year in 4 digits** (`YYYY`).
* Storage: **1 Byte**.
* Range: `1901` to `2155`.

##### 4. `DATETIME`
* Stores **both date and time** in format: **`YYYY-MM-DD HH:MM:SS`**.
* Storage: Takes **5 to 8 bytes** of memory to store date and time (8 bytes originally, 5 bytes in MySQL 5.6+).
* Range: `1000-01-01 00:00:00` to `9999-12-31 23:59:59` (covers years 1000 to 9999).
* **Key Characteristics:**
  - Not auto-set by default — but you *can* add `DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP` (supported since MySQL 5.6.5), just like `TIMESTAMP`.
  - No time zone conversion.
  - Useful when the value must look the same everywhere, whatever the time zone.
  - `DATETIME` doesn't change with the server time zone.
  - It stores the exact value as inserted.

##### 5. `TIMESTAMP`
* Stores **both date and time** in format: **`YYYY-MM-DD HH:MM:SS`**.
* Storage: **4 Bytes** (compact storage).
* Range: `1970-01-01 00:00:01 UTC` to `2038-01-19 03:14:07 UTC` (based on 32-bit UNIX epoch time, i.e., 1970 to 2038).
* **Key Characteristics:**
  - Auto-updates when row changes (if defined: `DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP`).
  - Stores date and time, but it is **timezone-sensitive**.
  - MySQL automatically converts `TIMESTAMP` values from the current time zone to **UTC** for storage, and back to the session time zone when retrieved.

---

#### 6.8.5 What is UTC (Coordinated Universal Time) & Why Does It Matter?

**Q. What is UTC?**
* *Definition: UTC (Coordinated Universal Time) is the global time standard used to coordinate clocks around the world.*
* It is the base reference time zone — all other time zones are defined as offsets from UTC.
* **UTC = World's "neutral" time.**
* It does not change with location or daylight savings.
* Every local time zone is expressed as:
  $$\text{Local Time} = \text{UTC} \pm \text{offset}$$
  *(For example: IST = $\text{UTC} + 5:30$)*.

* **In MySQL (TIMESTAMP and UTC):**
  - MySQL internally stores `TIMESTAMP` values in **UTC**, then:
    1. Converts to your session time zone when you read them.
    2. Converts back to UTC when you insert them.

**Q. Why Does UTC Matter?**
1. **Keeps timestamps consistent across servers:** In multi-region deployments, servers across different continents all log events consistently.
2. **Prevents confusion between time zones:** Eliminates time-shifting bugs caused by regional Daylight Saving Time changes.
3. **Useful for global applications, scheduling, and logging:** Ensures events are sequentially ordered worldwide.
4. **Clean display to end-users:** You can always convert UTC $\rightarrow$ Local time when displaying records to users in their localized interface.

---

#### 6.8.6 Differences Between DATETIME and TIMESTAMP

**Q. What is the difference between DATETIME and TIMESTAMP?**

| Feature / Dimension | `DATETIME` | `TIMESTAMP` |
| :--- | :--- | :--- |
| **1. Display Format** | `YYYY-MM-DD HH:MM:SS` | `YYYY-MM-DD HH:MM:SS` |
| **2. Storage Size** | **5 Bytes** in MySQL 5.6.4+ (+0–3 bytes for fractional seconds); 8 bytes in older versions | **4 Bytes** (more compact) |
| **3. Supported Range** | `1000-01-01 00:00:00` to `9999-12-31 23:59:59` (Years 1000 $\rightarrow$ 9999) | `1970-01-01 00:00:01 UTC` to `2038-01-19 03:14:07 UTC` (Years 1970 $\rightarrow$ 2038) |
| **4. Time Zone Handling** | **Does NOT store time zone information.** Stores exactly what you insert; no conversion. `DATETIME` doesn't change with server time zone. | **Timezone-sensitive.** Stored in UTC internally, but converted to current session time zone when retrieved. |
| **5. Auto-Update Capability** | Not automatic by default. You *can* add `DEFAULT` / `ON UPDATE` with `CURRENT_TIMESTAMP` (MySQL 5.6.5+). | **Can automatically update:** Set current time on insert (`DEFAULT CURRENT_TIMESTAMP`) and update on modification (`ON UPDATE CURRENT_TIMESTAMP`). |
| **6. Epoch Dependency** | Independent of UNIX Epoch | Bound to **UNIX Epoch** (Seconds elapsed since Jan 1, 1970 UTC) |
| **7. Best Use Cases** | When you need to store date & time exactly as given, independent of time zones.<br>*Examples:* Birthdays, historical events, scheduled appointment times. | When you need to track events relative to the current time zone.<br>*Examples:* Logging creation/update times (`created_at`, `updated_at`), audit trails. |

##### Point-Wise Detailed Breakdown:

1. **`DATETIME` Details:**
   - Stores both date and time in the format: `YYYY-MM-DD HH:MM:SS`.
   - Storage size: 5 bytes in modern MySQL (8 bytes in very old versions).
   - Range: `1000-01-01 00:00:00` $\rightarrow$ `9999-12-31 23:59:59` (i.e. 1000 $\rightarrow$ 9999).
   - Does not store time zone information. Stores exactly what you insert, no conversion.
   - Not auto-set by default. You can add `DEFAULT` / `ON UPDATE` with `CURRENT_TIMESTAMP` (MySQL 5.6.5+) if needed.
   - When you need to store a date & time exactly as given, independent of time zones.
   - *Example:* Birthdays, historical events, schedule times.

2. **`TIMESTAMP` Details:**
   - Stores both date and time in the same format: `YYYY-MM-DD HH:MM:SS`.
   - Storage size: 4 bytes (more compact).
   - Range: `1970-01-01 00:00:01 UTC` $\rightarrow$ `2038-01-19 03:14:07 UTC` (because it is based on UNIX epoch time, i.e., 1970 $\rightarrow$ 2038).
   - Stored in UTC internally, but converted to the current time zone when retrieved.
   - Useful for tracking system-wide events.
   - Can automatically:
     - Set current time on insert (`DEFAULT CURRENT_TIMESTAMP`)
     - Update to current time on update (`ON UPDATE CURRENT_TIMESTAMP`)
   - When you need to track events relative to the current time zone.
   - *Example:* Logging creation/update times, audit trails.

---

#### 6.8.7 Practical Code Examples for Data Types

```sql
-- Production Example: Utilizing Diverse MySQL Data Types
CREATE TABLE customer_profiles (
    -- Integer Types:
    customer_id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    reward_points BIGINT DEFAULT 0,
    age TINYINT UNSIGNED,
    
    -- Exact Numeric for Currency:
    account_balance DECIMAL(10, 2) DEFAULT 0.00,
    
    -- Approximate Floating Point for Geolocation:
    latitude FLOAT(10, 6),
    longitude FLOAT(10, 6),
    
    -- Fixed String vs Variable String:
    country_code CHAR(2) NOT NULL,            -- Always 2 characters (e.g. 'IN', 'US')
    full_name VARCHAR(100) NOT NULL,           -- Dynamic length
    email VARCHAR(150) UNIQUE NOT NULL,
    
    -- Large Text:
    bio TEXT,
    
    -- Boolean Flag (TINYINT(1)):
    is_verified BOOLEAN DEFAULT FALSE,
    
    -- Category Types (ENUM & SET):
    gender ENUM('Male', 'Female', 'Other'),
    interests SET('Sports', 'Tech', 'Music', 'Travel', 'Art'),
    
    -- Temporal Types (DATETIME vs TIMESTAMP):
    date_of_birth DATE NOT NULL,              -- Date only: YYYY-MM-DD
    login_time TIME,                          -- Time only: HH:MM:SS
    birth_timestamp DATETIME,                 -- Exact literal birth time (no timezone conversion)
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- UTC converted auto-timestamp
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
```

> ⚠️ **Note:** `FLOAT(10, 6)` is deprecated since MySQL 8.0.17 (you get a warning). For latitude/longitude prefer `DECIMAL(9, 6)` or a spatial `POINT` column (see 6.8.9).

---

#### 6.8.8 Special Data Types: JSON In-Depth

* **Q. What is the JSON Data Type in MySQL and How Does It Function?**
  * *Definition: JSON (JavaScript Object Notation) is a simple text format that stores data as key-value pairs and lists.*
  * *Capability: MySQL's `JSON` data type lets you store a whole JSON document (an object or an array) in one column.*
  * *Format & Structure: In JSON format, data is stored in key-value pairs, arrays, and objects. The keys are always strings (enclosed in double quotes), and values can be of any JSON-supported type (string, number, boolean, array, object, or null).*
  * *Storage: MySQL saves JSON in a special binary format, so it can jump straight to a key without reading the whole text.*
  * *Validation: MySQL automatically validates any document inserted into a `JSON` column and raises an error if the document is not valid JSON syntax.*

* **Path Traversal Syntax & The `$` Root Symbol:**
  * *The `$` symbol represents the root (starting point) of the JSON document.*
  * `$` : Root JSON $\rightarrow$ Represents the entire JSON document/object.
  * `$.key` : Specific field $\rightarrow$ Field named "key" inside the root object (e.g., `$.age` returns the age value).
  * `$.object.key` : Nested key $\rightarrow$ Accesses a nested property inside an object (e.g., `$.address.city` accesses "city" inside "address").
  * `$.array[index]` : Array element $\rightarrow$ Accesses an element by zero-based index position (e.g., `$.skills[0]` retrieves the first element of the "skills" array).

* **JSON Extraction Operators (`->` vs. `->>`):**
  * MySQL provides two convenient inline operators for extracting values from JSON documents:

| Operator | Extraction Syntax | Output Type | Description & Purpose | Example | Result |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `->` | `column->'path'` | JSON Value (**with quotes**) | Extracts the data as a JSON value preserving double quotes. Use `->` when you need to treat the result as JSON for further JSON manipulation. | `details->'$.age'` | `"25"` |
| `->>` | `column->>'path'` | Plain Text (**unquoted**) | Inline unquoting path operator. Extracts the value as clean, unquoted plain text. Use `->>` when comparing in `WHERE` clauses or displaying in UI. | `details->>'$.age'` | `25` |

> ⚠️ **Note:** `age` is a number, so `details->'$.age'` actually returns `25` (without quotes). Quotes appear only for text values: `details->'$.email'` → `"alice@example.com"`, while `details->>'$.email'` → `alice@example.com`.

* **Core MySQL Built-in JSON Functions:**
  * `JSON_EXTRACT(json_doc, path[, path] ...)`: Extracts values from a JSON document at the specified path(s).
  * `JSON_SET(json_doc, path, val[, path, val] ...)`: Inserts or updates values in a JSON document (updates existing keys or appends new keys).
  * `JSON_ARRAY([val[, val] ...])`: Creates a valid JSON array from an argument list of values.
  * `JSON_OBJECT([key, val[, key, val] ...])`: Creates a valid JSON object from alternating key-value pairs.

* **Step-by-Step Practical SQL Implementation:**

```sql
-- 1. Create a table with a native JSON column:
CREATE TABLE users (
 id INT AUTO_INCREMENT PRIMARY KEY,
 name VARCHAR(100),
 details JSON
);

-- 2. Inserting data with structured JSON documents:
INSERT INTO users (name, details) VALUES
('Alice', '{"age": 25, "email": "alice@example.com", "skills": ["SQL", "Python", "JavaScript"]}'),
('Bob', '{"age": 30, "email": "bob@example.com", "skills": ["Java", "C++"], "isAdmin": true}');

-- 3. Extract individual fields using JSON_EXTRACT():
SELECT 
  NAME,
  JSON_EXTRACT(DETAILS, '$.FIRSTNAME') AS FirstName,
  JSON_EXTRACT(DETAILS, '$.AGE') AS Age,
  JSON_EXTRACT(DETAILS, '$.ADDREDD') AS Address
FROM USER;

-- 4. Use ->> operator to extract plain text (without quotes):
SELECT NAME, DETAILS ->> '$.AGE' AS USERAGE FROM USER;

-- 5. Use -> operator to get JSON value (with quotes):
-- GET THE JSON VALUE WITH QUOTES
SELECT NAME, DETAILS -> '$.AGE' AS ISADMIN FROM USER;

-- 6. Extract nested array values (0-indexed):
-- EXTRACT NESTED ARRAY VALUE 
SELECT DETAILS->>'$.skills[0]' AS FIRST FROM USER WHERE ID = 2;
-- $ -> root, skills -> array name, [0] -> first element in the array

-- 7. Filter rows based on JSON content in the WHERE clause:
SELECT NAME, 
       DETAILS  
FROM USER 
WHERE JSON_EXTRACT(DETAILS, '$.isAdmin') = TRUE;

-- 8. Update a JSON field (Modify existing key):
UPDATE USER
SET DETAILS = JSON_SET(DETAILS, '$.ADDREDD', 'MUMBAI')
WHERE NAME = 'VISHAL';

-- 9. Add a new JSON key into an existing document:
UPDATE USER
SET DETAILS = JSON_SET(DETAILS, '$.PHONE', '123456789')
WHERE ID = 1;

-- 10. Update or Add key using JSON_SET():
UPDATE USER
SET DETAILS = JSON_SET(DETAILS, '$.MOBILENUMBER', '9988999889')
WHERE ID = 1;

SELECT * FROM USER;

-- 11. Extract nested properties of an object:
-- GET NESTED PROPERTIES 
SELECT NAME, DETAILS, JSON_EXTRACT(DETAILS, '$.address.city') AS USERCITY FROM USER WHERE ID = 2;

-- 12. Create a JSON Array on the fly:
SELECT JSON_ARRAY('SQL', 'Node.js', 'Python') AS skills;

-- 13. Create a JSON Object on the fly:
SELECT JSON_OBJECT('name', 'Vishal', 'age', 25, 'city', 'Pune') AS user_details;

-- 14. Advanced JSON Manipulation: Create a new JSON Array inside details:
-- Use JSON_ARRAY() along with JSON_SET()
UPDATE users
SET details = JSON_SET(details, '$.skills', JSON_ARRAY('SQL', 'Node.js', 'Python'))
WHERE name = 'Vishal';

-- 15. Advanced JSON Manipulation: Add a new nested object inside existing JSON:
-- Use JSON_OBJECT() to create a nested object
UPDATE users
SET details = JSON_SET(
  details,
  '$.address',
  JSON_OBJECT('street', 'MG Road', 'city', 'Pune', 'zip', '411001')
)
WHERE name = 'Vishal';

-- 16. Advanced JSON Manipulation: Create an object inside an existing object (Deep Nesting):
-- Specify deeper nested paths like $.address.geo
UPDATE users
SET details = JSON_SET(
  details,
  '$.address.geo',
  JSON_OBJECT('lat', 18.5204, 'lng', 73.8567)
)
WHERE name = 'Vishal';
```

> ⚠️ **Note on the code above:** Steps 3–13 use the table name `USER`, but step 1 created `users` — use `users`. JSON keys are case-sensitive: `'$.AGE'` returns NULL because the stored key is `age`. `'$.FIRSTNAME'` and `'$.ADDREDD'` (typo) don't exist in the inserted data, so they also return NULL. Step 11 needs an `address` key first (it is added in step 15).

* **Summary Checklist for MySQL JSON Operations:**
  * `$` : Root of the JSON document.
  * `$.key` : Specific field in root object.
  * `$.object.key` : Nested field inside an object.
  * `$.array[index]` : Specific element from an array.
  * `->` : Shortcut for `JSON_EXTRACT()` returning quoted JSON value.
  * `->>` : Shortcut for `JSON_UNQUOTE(JSON_EXTRACT())` returning clean plain text.
  * `JSON_EXTRACT()` : Extracts values from JSON data paths.
  * `JSON_SET()` : Inserts or updates key-value pairs in a JSON document.
  * `JSON_ARRAY()` : Creates a JSON array from given values.
  * `JSON_OBJECT()` : Creates a JSON object from key-value pairs.

---

#### 6.8.9 Special Data Types: GEOMETRY Types for GIS / Spatial Data In-Depth

* **Q. What are MySQL Spatial / GIS Data Types and How Are They Used?**
  * *Definition: Spatial (GIS) data types store locations and shapes — points, lines and areas on a map.*
  * *Standards: MySQL follows the OpenGIS (OGC) standard for these types.*
  * *Primary Use Cases:*
    * Mapping applications (Google Maps, GIS portals, GPS telemetry).
    * Real-time location tracking (latitude/longitude coordinates of users or delivery fleets).
    * Geofencing, restricted zones, and delivery service coverage boundaries.
    * Spatial calculations (distance between locations, area of regions, point-in-polygon checks).

* **The 8 OpenGIS Spatial Data Types in MySQL:**

| Data Type | Structural Category | Geometric Representation | Primary Real-World Use Case |
| :--- | :--- | :--- | :--- |
| `GEOMETRY` | Generic Spatial | Any geometric shape (`POINT`, `LINESTRING`, `POLYGON`). | Flexible column capable of holding any spatial geometry per row. |
| `POINT` | Single Coordinate | Single 2D coordinate pair $(x, y)$ (longitude, latitude). | User coordinates, GPS device locations, store/branch coordinates. |
| `LINESTRING` | Connected Points | Series of connected coordinate points representing a line. | Roads, delivery routes, rivers, railway tracks, flight paths. |
| `POLYGON` | Closed Area | Closed boundary where the last coordinate connects to the first. | City limits, delivery coverage zones, lakes, property plots. |
| `MULTIPOINT` | Multi-Geometry | Collection of multiple separate `POINT` objects. | Multiple branch locations of a company, multiple check-in points. |
| `MULTILINESTRING` | Multi-Geometry | Collection of multiple separate `LINESTRING` objects. | Road networks, subway transit systems, highway networks. |
| `MULTIPOLYGON` | Multi-Geometry | Collection of multiple separate `POLYGON` objects. | Country territories with archipelagos/islands, multi-district zones. |
| `GEOMETRYCOLLECTION` | Mixed Collection | Collection containing mixed geometry types (`POINT` + `LINE` + `POLYGON`). | Mixed complex geographic zones (e.g., city with points, routes, and parks). |

* **In-Depth Breakdown of Each Geometry Type with Code Examples:**

##### 1. GEOMETRY (Any Geometric Object)
* *Definition: A generic spatial data type that can store any spatial object (`POINT`, `LINESTRING`, or `POLYGON`).*
* *Use Case: When a single column needs the flexibility to store varying geometry types across different records.*

```sql
-- CREATE TABLE WITH GEOMETRY DATA TYPE 
CREATE TABLE GEO_OBJECTS(
  ID INT AUTO_INCREMENT PRIMARY KEY,
  NAME VARCHAR(50),
  SHAP GEOMETRY
);

-- Insert a Point into GEOMETRY column:
INSERT INTO geo_objects (name, SHAP)
VALUES ('Store Location', ST_GeomFromText('POINT(72.8777 19.0760)'));

SELECT * FROM GEO_OBJECTS;
```

##### 2. POINT (Single Coordinate $(x, y)$)
* *Definition: Represents a single location in 2D space with $x$ (longitude) and $y$ (latitude) coordinates.*
* *Use Case: Track user/device live location, store physical address coordinates, pin landmarks and points of interest.*

```sql
-- CREATE TABLE TO STORE THE LOCATION OF USER
CREATE TABLE USER_LOCATION(
  ID INT AUTO_INCREMENT PRIMARY KEY,
  NAME VARCHAR(50),
  LOCATION POINT
);

-- INSERT DATA INTO USER LOCATION TABLE USING POINT GEOMETRY TYPE
INSERT INTO USER_LOCATION(NAME, LOCATION) 
VALUES('VISHAL', ST_GeomFromText('POINT(72.8777 19.0760)'));

-- Convert binary geometry to readable WKT text:
SELECT NAME, ST_AsText(location) AS location_text FROM USER_LOCATION;
```

##### 3. LINESTRING (Connected Path / Route)
* *Definition: A series of two or more connected coordinate points forming a continuous path.*
* *Use Case: Model roads, rivers, walking paths, delivery vehicle routes, and transit tracks.*

```sql
-- CREATE TABLE WITH LINESTRING
CREATE TABLE road(
  id INT AUTO_INCREMENT PRIMARY KEY,
  road_name VARCHAR(50),
  road_path LINESTRING
);

-- INSERT LINESTRING DATA INTO THE TABLE 
INSERT INTO road (road_name, road_path) 
VALUES ('pune_nashik_hiway', ST_GeomFromText('LINESTRING(77.59 12.97, 77.60 12.98, 77.62 12.99)'));

SELECT road_name, ST_AsText(road_path) FROM road;
```

##### 4. POLYGON (Closed Area / Boundary)
* *Definition: A closed surface shape formed by connecting multiple points where the last point connects back to the first point.*
* *Use Case: Define city municipal boundaries, restricted zones, delivery service radiuses, lakes, parks, and agricultural plots.*

```sql
-- CREATE TABLE WITH POLYGON 
CREATE TABLE REAGION(
  ID INT AUTO_INCREMENT PRIMARY KEY,
  REGION_NAME VARCHAR(50),
  REAGION POLYGON
);

-- INSERT POLYGON DATA 
INSERT INTO REAGION(REGION_NAME, REAGION)
VALUES('KASARSAI_DAM', ST_GEOMFROMTEXT('POLYGON((77.58 12.97, 77.60 12.97, 77.60 12.99, 77.58 12.99, 77.58 12.97))'));

SELECT * FROM REAGION;
```

##### 5. MULTIPOINT (Collection of Multiple Points)
* *Definition: A collection of multiple individual `POINT` geometries stored in a single record.*
* *Use Case: Store all branches, stores, or user check-in points within a single corporate zone.*

```sql
-- CREATE TABLE FOR MULTIPOINT 
CREATE TABLE MULTIPOINT(
  ID INT AUTO_INCREMENT PRIMARY KEY,
  NAME VARCHAR(50),
  LOCATION MULTIPOINT
);

-- INSERT MULTIPOINT DATA 
INSERT INTO MULTIPOINT (NAME, LOCATION) 
VALUES('PUNE-ZONE', ST_GEOMFROMTEXT('MULTIPOINT((77.59 12.97), (77.61 12.98), (77.63 12.99))'));

SELECT * FROM MULTIPOINT;
```

##### 6. MULTILINESTRING (Collection of Multiple Lines)
* *Definition: A collection of multiple `LINESTRING` objects grouped together in a single record.*
* *Use Case: Represent a full network of roads, train transit networks, or delivery flight paths.*

```sql
CREATE TABLE MULTLILINESTRINGDATA(
  ID INT AUTO_INCREMENT PRIMARY KEY,
  NETWORK_NAME VARCHAR(50),
  PATHS MULTILINESTRING
);

-- INSERT MULTILINE DATA 
INSERT INTO MULTLILINESTRINGDATA (NETWORK_NAME, PATHS) 
VALUES ('D-MART', ST_GEOMFROMTEXT('MULTILINESTRING((77.58 12.97, 77.60 12.98), (77.61 12.99, 77.63 13.00))'));

SELECT * FROM MULTLILINESTRINGDATA;
```

##### 7. MULTIPOLYGON (Collection of Multiple Closed Polygons)
* *Definition: A collection of multiple separate `POLYGON` closed areas grouped into a single spatial entity.*
* *Use Case: Represent non-contiguous land territories, archipelagos/islands, multi-district sales zones.*

```sql
-- CREATE TABLE MULTIPOLYGON 
CREATE TABLE MULTIPOLYGONDATA(
  ID INT AUTO_INCREMENT PRIMARY KEY, 
  NAME VARCHAR(50),
  AREAS MULTIPOLYGON
);

-- INSERT MULTIPOLYGON DATA INTO TABLE
INSERT INTO MULTIPOLYGONDATA (NAME, AREAS)
VALUES('District Zones', ST_GeomFromText('MULTIPOLYGON(((77.58 12.97, 77.60 12.97, 77.60 12.99, 77.58 12.99, 77.58 12.97)), ((77.62 13.00, 77.64 13.00, 77.64 13.02, 77.62 13.02, 77.62 13.00)))'));

SELECT * FROM MULTIPOLYGONDATA;
```

##### 8. GEOMETRYCOLLECTION (Mixed Collection of Geometries)
* *Definition: A collection container capable of storing any arbitrary combination of geometry types (`POINT`, `LINESTRING`, and `POLYGON`) within a single record.*
* *Use Case: Storing comprehensive city maps that incorporate points of interest, transit lines, and zone polygons simultaneously.*

```sql
CREATE TABLE geo_collection (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(50),
  geo_data GEOMETRYCOLLECTION
);

INSERT INTO geo_collection (name, geo_data)
VALUES ('City Example', ST_GeomFromText(
  'GEOMETRYCOLLECTION(
     POINT(77.59 12.97),
     LINESTRING(77.59 12.97, 77.61 12.98),
     POLYGON((77.62 13.00, 77.64 13.00, 77.64 13.02, 77.62 13.02, 77.62 13.00))
   )'
));
```

---

##### Detailed Comparison: `GEOMETRY` vs. `GEOMETRYCOLLECTION`

* **High-Level Analogy:**
  * `GEOMETRY` = A flexible container that can hold **one single item** of any geometry type (a single Point, a single Line, or a single Polygon).
  * `GEOMETRYCOLLECTION` = A comprehensive container that holds **multiple items** together in one record (Points + Lines + Polygons combined).

| Feature / Aspect | `GEOMETRY` Type | `GEOMETRYCOLLECTION` Type |
| :--- | :--- | :--- |
| **Storage Capacity** | Stores **only one** geometry object at a time per row. | Stores **multiple** geometry objects in a single record. |
| **Object Variation** | The type can vary across rows (Row 1 = Point, Row 2 = Polygon). | Can contain a heterogeneous mix of Points, Lines, and Polygons simultaneously. |
| **Shape Complexity** | Models **simple shapes** (individual point or single polygon). | Models **complex compound shapes** (entire city layout). |
| **Use Case** | When you want column flexibility without knowing the specific type ahead of time. | When multiple geometric elements make up a single logical geographic entity. |
| **WKT Syntax Example** | `'POINT(77.59 12.97)'` or `'POLYGON((...))'` | `'GEOMETRYCOLLECTION(POINT(...), LINESTRING(...), POLYGON(...))'` |

* **Code Demonstration: `GEOMETRY` vs `GEOMETRYCOLLECTION`:**

```sql
-- A. GEOMETRY: Storing one simple shape per row
CREATE TABLE geo_examples (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(50),
  shape GEOMETRY
);

-- Store a single point:
INSERT INTO geo_examples (name, shape)
VALUES ('Restaurant', ST_GeomFromText('POINT(77.59 12.97)'));

-- Store a single polygon:
INSERT INTO geo_examples (name, shape)
VALUES ('Park', ST_GeomFromText('POLYGON((77.58 12.96, 77.60 12.96, 77.60 12.98, 77.58 12.98, 77.58 12.96))'));

-- B. GEOMETRYCOLLECTION: Storing multiple combined shapes together
CREATE TABLE city_shapes (
  id INT AUTO_INCREMENT PRIMARY KEY,
  city_name VARCHAR(50),
  objects GEOMETRYCOLLECTION
);

-- Store multiple shapes together in one record:
INSERT INTO city_shapes (city_name, objects)
VALUES ('ExampleCity', ST_GeomFromText(
  'GEOMETRYCOLLECTION(
     POINT(77.59 12.97),
     LINESTRING(77.58 12.96, 77.61 12.99),
     POLYGON((77.62 13.00, 77.64 13.00, 77.64 13.02, 77.62 13.02, 77.62 13.00))
   )'
));
```

---

##### Special Spatial Functions in MySQL

* **1. `ST_GeomFromText('WKT')`:**
  * *Purpose: Creates a binary geometry object from Well-Known Text (WKT) string representation.*

```sql
CREATE TABLE locations (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    geom GEOMETRY
);

-- Insert a POINT using WKT:
INSERT INTO locations (name, geom)
VALUES ('User A', ST_GeomFromText('POINT(77.5946 12.9716)'));

-- Insert a POLYGON using WKT:
INSERT INTO locations (name, geom)
VALUES ('Park Area', ST_GeomFromText(
    'POLYGON((77.58 12.97, 77.60 12.97, 77.60 12.99, 77.58 12.99, 77.58 12.97))'
));
```

* **2. `ST_AsText(geometry)`:**
  * *Purpose: Converts internal binary geometry data back into human-readable WKT string format.*

```sql
SELECT name, ST_AsText(geom) AS geom_text
FROM locations;
```

* **3. `ST_Distance(geometry1, geometry2)`:**
  * *Purpose: Calculates the distance between two geometry objects.*
  * *Note: With the default SRID 0, MySQL gives a flat (planar) distance, not the real distance on Earth. For real distance in meters, use SRID 4326 or `ST_Distance_Sphere()`.*

```sql
-- Create two points:
SET @p1 = ST_GeomFromText('POINT(77.5946 12.9716)'); -- Bangalore
SET @p2 = ST_GeomFromText('POINT(77.6090 12.9721)'); -- Nearby location

-- Calculate distance:
SELECT ST_Distance(@p1, @p2) AS distance;
```

* **4. `ST_Within(geometry_a, geometry_b)`:**
  * *Purpose: Checks whether geometry `a` is completely located inside geometry `b` (e.g. Point inside a Polygon). Returns `1` (true) or `0` (false).*

```sql
-- Create a point and a polygon:
SET @point = ST_GeomFromText('POINT(77.59 12.98)');
SET @polygon = ST_GeomFromText('POLYGON((77.58 12.97, 77.60 12.97, 77.60 12.99, 77.58 12.99, 77.58 12.97))');

-- Check if point is within polygon:
SELECT ST_Within(@point, @polygon) AS is_within;
```

* **5. `ST_Contains(geometry_a, geometry_b)`:**
  * *Purpose: Checks whether geometry `a` contains geometry `b` (e.g. Polygon contains a Point). Returns `1` (true) or `0` (false).*

```sql
-- Check if polygon contains point:
SELECT ST_Contains(@polygon, @point) AS contains;
```

---

#### 6.8.10 Quick Overview: JSON & Spatial GEOMETRY (Methods & Properties Master Cheat Sheet)

* **Q. What is the Quick Reference for MySQL JSON and Spatial GEOMETRY Data Types?**
  * *A quick lookup table for JSON paths, operators and functions, and for spatial types and functions (MySQL 8.0+).*

##### Part 1: JSON Data Type — Quick Reference & Methods Matrix

![Mastering MySQL JSON Data Type](./mysql_json_guide.svg)

###### 1. JSON Path Traversal Properties
| Path Expression | Target Element | Description & Behavior | Example |
| :--- | :--- | :--- | :--- |
| `$` | Document Root | The entire JSON document / top-level object or array. | `SELECT data->'$' FROM t;` |
| `$.key` | Direct Object Key | Extracts the value of property `key` from the root object. | `data->>'$.age'` |
| `$.parent.child` | Nested Property | Traverses inside object `parent` to retrieve `child`. | `data->>'$.address.city'` |
| `$.array[i]` | Array Element | Retrieves element at 0-based index `i`. | `data->>'$.skills[0]'` |
| `$.array[*]` | Array Wildcard | Returns all elements of the array. | `JSON_EXTRACT(data, '$.skills[*]')` |
| `$.*` | Object Wildcard | Returns the values of all direct keys in the object. | `JSON_EXTRACT(data, '$.*')` |

###### 2. JSON Extraction Operators Matrix
| Operator | Name | Syntax | Return Format | Best Used For |
| :--- | :--- | :--- | :--- | :--- |
| `->` | Arrow Operator | `column->'path'` | JSON-formatted value (**with double quotes**) | Further JSON functions, preserving JSON typing |
| `->>` | Inline Unquote Operator | `column->>'path'` | Clean unquoted plain string (**without quotes**) | Displaying in UI, filtering in `WHERE`, joining |

###### 3. Complete MySQL JSON Built-in Methods
| Method / Function | Signature / Parameters | Purpose & Description | Practical SQL Example |
| :--- | :--- | :--- | :--- |
| `JSON_EXTRACT()` | `(doc, path[, path]...)` | Extracts data from a JSON document at specified path(s). | `JSON_EXTRACT(details, '$.email')` |
| `JSON_SET()` | `(doc, path, val[, path, val]...)` | Updates existing keys or adds new keys if absent. | `JSON_SET(details, '$.active', true)` |
| `JSON_INSERT()` | `(doc, path, val[, path, val]...)` | Adds new key-value pair **only** if the key does not exist. | `JSON_INSERT(details, '$.role', 'Admin')` |
| `JSON_REPLACE()` | `(doc, path, val[, path, val]...)` | Overwrites value **only** if the key already exists. | `JSON_REPLACE(details, '$.age', 31)` |
| `JSON_REMOVE()` | `(doc, path[, path]...)` | Deletes a key, property, or array element from the JSON. | `JSON_REMOVE(details, '$.skills[1]')` |
| `JSON_ARRAY()` | `([val1, val2, ...])` | Creates a JSON array on the fly from arguments. | `JSON_ARRAY('Java', 'Python', 'SQL')` |
| `JSON_OBJECT()` | `([k1, v1, k2, v2, ...])` | Creates a JSON object on the fly from key-value pairs. | `JSON_OBJECT('city', 'Pune', 'zip', 411001)` |
| `JSON_CONTAINS()` | `(target, candidate[, path])` | Checks if JSON document contains a specific value (returns 1 or 0). | `JSON_CONTAINS(details, '"SQL"', '$.skills')` |
| `JSON_SEARCH()` | `(doc, 'one'\|'all', search_str)` | Searches for a string within a document and returns its path. | `JSON_SEARCH(details, 'one', 'Python')` |
| `JSON_TYPE()` | `(json_val)` | Returns the data type string (`OBJECT`, `ARRAY`, `INTEGER`, etc.). | `JSON_TYPE(JSON_EXTRACT(details, '$.age'))` |
| `JSON_VALID()` | `(val)` | Validates whether a string has valid JSON syntax (returns 1 or 0). | `JSON_VALID('{"valid": true}')` |

---

##### Part 2: Spatial GEOMETRY Types — Quick Reference & Methods Matrix

![Understanding MySQL Spatial Data Types & GIS Geometry](./mysql_spatial_guide.svg)

###### 1. The 8 OpenGIS Spatial Data Types Matrix
| Spatial Type | Structural Geometry | Dimension | Real-World Application | WKT Syntax Pattern |
| :--- | :--- | :--- | :--- | :--- |
| `POINT` | Single 2D coordinate $(x, y)$ | 0D (Point) | GPS user locations, pin drop, branch coordinates | `POINT(77.59 12.97)` |
| `LINESTRING` | Connected series of points | 1D (Length) | Roads, delivery routes, rivers, railways, flight corridors | `LINESTRING(x1 y1, x2 y2, ...)` |
| `POLYGON` | Closed area (first = last point) | 2D (Area) | Delivery geofencing zones, lakes, city boundaries, plots | `POLYGON((x1 y1, x2 y2, ..., x1 y1))` |
| `MULTIPOINT` | Multiple distinct points | 0D Set | Multiple store branches, delivery drop points | `MULTIPOINT((x1 y1), (x2 y2))` |
| `MULTILINESTRING` | Multiple distinct line paths | 1D Set | Highway networks, subway train lines, multi-segment routes | `MULTILINESTRING((...), (...))` |
| `MULTIPOLYGON` | Multiple closed polygon zones | 2D Set | Archipelagos/islands, multi-district sales territories | `MULTIPOLYGON(((...)), ((...)))` |
| `GEOMETRYCOLLECTION` | Mixed heterogeneous collection | Mixed | Complex city models (Points + Lines + Polygons combined) | `GEOMETRYCOLLECTION(POINT(...), ...)` |
| `GEOMETRY` | Polymorphic spatial column | Any | Column that can store any single geometric object per row | Holds any single geometry object |

###### 2. Complete MySQL Spatial Analysis Methods (`ST_` Functions)
| Function Name | Input Signature | Output Type | Description & Analysis Role | Practical SQL Example |
| :--- | :--- | :--- | :--- | :--- |
| `ST_GeomFromText()` | `(wkt_string[, srid])` | Geometry Object | Converts Well-Known Text (WKT) string to internal binary geometry. | `ST_GeomFromText('POINT(72.87 19.07)')` |
| `ST_AsText()` | `(geometry_obj)` | WKT String | Converts internal binary geometry back into human-readable text. | `SELECT ST_AsText(location) FROM user_location;` |
| `ST_Distance()` | `(geom1, geom2)` | Double | Computes planar Euclidean distance between two geometries. | `ST_Distance(point1, point2)` |
| `ST_Within()` | `(geom_a, geom_b)` | Boolean (0 or 1) | Checks if geometry `A` is completely inside geometry `B`. | `ST_Within(user_point, zone_polygon)` |
| `ST_Contains()` | `(geom_a, geom_b)` | Boolean (0 or 1) | Checks if geometry `A` completely surrounds/encloses geometry `B`. | `ST_Contains(zone_polygon, user_point)` |
| `ST_Area()` | `(polygon_obj)` | Double | Calculates total surface area of a closed Polygon or MultiPolygon. | `ST_Area(region)` |
| `ST_Length()` | `(linestring_obj)` | Double | Calculates the total length of a LineString or MultiLineString. | `ST_Length(road_path)` |
| `ST_Buffer()` | `(geom, distance)` | Polygon Object | Generates a polygon buffer zone of radius $d$ around a geometry. | `ST_Buffer(store_point, 5000)` |
| `ST_Intersects()` | `(geom1, geom2)` | Boolean (0 or 1) | Returns 1 if any part of `geom1` touches or overlaps `geom2`. | `ST_Intersects(route_line, flood_zone)` |

---

### 6.9 Visual Architectural Diagrams for Data Types & Hierarchy

#### Diagram 1: Comprehensive MySQL Data Types Architecture
![MySQL Comprehensive Data Types Architecture](./mysql_data_types_comprehensive_diagram.svg)

* **Architecture & Flow Explanation (आकृतीचे सविस्तर स्पष्टीकरण):**
  * **Top Section (Memory Strategy):** Highlights the architectural difference between **Fixed Data Types** (pre-allocating memory bytes) and **Variable Data Types** (dynamically allocating based on string length + prefix byte).
  * **4 Main Taxonomy Cards:**
    1. **Numeric Types:** Explains `INT` (4B), `TINYINT` (1B), `BIGINT` (8B), exact arithmetic `DECIMAL(p,s)` for money, and `FLOAT`/`DOUBLE` for science.
    2. **String & Text Types:** Details `CHAR(n)` (fixed padding) vs `VARCHAR(n)` (dynamic), `TEXT` scaling (up to 4GB), and `BLOB` for binary assets.
    3. **Date & Time (Temporal):** Illustrates `DATE`, `TIME`, `YEAR`, `DATETIME` (independent), and `TIMESTAMP` (UTC-aware).
    4. **Specialized Types:** Outlines `BOOLEAN` (0/1), `BIT`, single-category `ENUM`, and multi-category `SET`.

* **📌 आकृतीचे मराठीत स्पष्टीकरण:**
  * **वरचा भाग (मेमरी वाटप):** फिक्स्ड (Fixed) आणि व्हेरिएबल (Variable) मेमरीमधील फरक स्पष्ट करतो.
  * **४ मुख्य स्तंभ:** न्यूमरिक (पूर्णांक व दशांश), स्ट्रिंग (अक्षरे व टेक्स्ट), तारीख व वेळ (Temporal), आणि विशिष्ट प्रकार (Boolean, Enum, Set) यांची संपूर्ण रचना दर्शवतो.

---

#### Diagram 2: DATETIME vs. TIMESTAMP In-Depth Architectural Comparison
![MySQL Comparison: DATETIME vs. TIMESTAMP](./datetime_vs_timestamp_diagram.svg)

* **Architecture & Flow Explanation (आकृतीचे सविस्तर स्पष्टीकरण):**
  * **Left Card (`DATETIME`):** 8/5 Bytes storage, 9,000-year span (`1000` to `9999`), literal storage with zero time zone conversion, best for birthdays and schedules.
  * **Right Card (`TIMESTAMP`):** 4 Bytes compact storage, bound by 32-bit UNIX Epoch (`1970` to `2038`), automatic UTC conversion, auto-update on changes (`CURRENT_TIMESTAMP`), best for audit logs.
  * **Bottom Pipeline (UTC Workflow):** Shows client in India writing in IST ($\text{UTC}+5:30$), engine storing in universal UTC ($0:00$), and client in the US reading in EST ($\text{UTC}-5:00$) seamlessly.

* **📌 आकृतीचे मराठीत स्पष्टीकरण:**
  * **DATETIME (डावीकडे):** ५ बाईट्स मेमरी (जुन्या व्हर्जनमध्ये ८), वर्ष १००० ते ९९९९ पर्यंतची मर्यादा, टाइमझोनचा कोणताही परिणाम होत नाही (जशी तारीख दिली तशीच साठवली जाते).
  * **TIMESTAMP (उजवीकडे):** ४ बाईट्स कॉम्पॅक्ट मेमरी, वर्ष १९७० ते २०३८ (Epoch) पर्यंत मर्यादा, स्वयंचलित UTC रूपांतरण आणि आपोआप अपडेट होण्याची क्षमता.
  * **खालचा भाग (UTC चक्र):** वेगवेगळ्या देशांतील सर्व्हर व युझर्स एकाच सेंट्रल डेटाबेसमध्ये अचूक वेळेसह कसे काम करतात ते दर्शवतो.

---

#### Diagram 3: Database Structure & Hierarchy Diagram
![Database Structure Hierarchy Diagram](./database_structure_hierarchy_diagram.svg)

* **Explanation:**
  * Displays the 4-tier relational structure: Server $\rightarrow$ Databases $\rightarrow$ Schemas $\rightarrow$ Tables.
  * Details table anatomy (Columns, Rows, Cells) and Primary Key indexing.

---

#### Diagram 4: MySQL JSON Data Type Architecture & Path Traversal
![MySQL JSON Data Type Architecture](./mysql_json_architecture_diagram.svg)

* **Architecture & Flow Explanation (आकृतीचे सविस्तर स्पष्टीकरण):**
  * **Header & Concept:** Highlights the internal binary format of MySQL JSON columns, distinguishing it from raw text strings for fast key-indexed lookup.
  * **The `$` Root Symbol & Path Navigation:** Shows how `$` represents the root document, `$.key` targets a specific field, `$.object.key` navigates nested objects, and `$.array[i]` indexes into arrays.
  * **Extraction Operators (`->` vs. `->>`):** Visualizes the critical difference between `->` (quoted JSON value) and `->>` (unquoted clean plain text).
  * **Core Built-in JSON Functions:** Details `JSON_EXTRACT()`, `JSON_SET()`, `JSON_ARRAY()`, and `JSON_OBJECT()`.

* **📌 आकृतीचे मराठीत स्पष्टीकरण:**
  * **बायनरी फॉरमॅट (Binary Format):** MySQL मध्ये JSON डेटा केवळ साधा टेक्स्ट म्हणून न राहता बायनरी फॉरमॅटमध्ये सेव्ह होतो, ज्यामुळे कोणत्याही की (Key) चा शोध अत्यंत वेगाने घेता येतो.
  * **`$` रूट चिन्ह व पाथ (Path):** `$` हा संपूर्ण डॉक्युमेंटचा प्रारंभ बिंदू दर्शवतो. `$.age` ने फील्ड, `$.address.city` ने नेस्टेड ऑब्जेक्ट, तर `$.skills[0]` ने अरेमधील घटक शोधता येतात.
  * **`->` आणि `->>` मधील फरक:** `->` मुळे कोट्ससहित (Quoted) JSON मूल्य मिळते, तर `->>` मुळे कोट्स नसलेले स्वच्छ टेक्स्ट मूल्य (Plain text) मिळते.
  * **JSON फंक्शन्स:** `JSON_EXTRACT` (डेटा काढणे), `JSON_SET` (नवीन की जोडणे किंवा बदलणे), `JSON_ARRAY` व `JSON_OBJECT` (नवीन अरे व ऑब्जेक्ट तयार करणे) यांचे कार्य दर्शवले आहे.

---

#### Diagram 5: MySQL Spatial / GIS Geometry Data Types & Functions Architecture
![MySQL Spatial / GIS Geometry Data Types Architecture](./mysql_spatial_geometry_diagram.svg)

* **Architecture & Flow Explanation (आकृतीचे सविस्तर स्पष्टीकरण):**
  * **OpenGIS Spatial Hierarchy:** Illustrates the OpenGIS geometry hierarchy starting from the base `GEOMETRY` class down to concrete subtypes.
  * **Core Geometry Types:** Visualizes `POINT(x y)` (locations), `LINESTRING` (routes/roads), `POLYGON` (closed boundaries/zones), and their multi-counterparts (`MULTIPOINT`, `MULTILINESTRING`, `MULTIPOLYGON`).
  * **GEOMETRY vs. GEOMETRYCOLLECTION:** Visually contrasts a flexible container holding one shape vs. a composite container holding multiple heterogeneous shapes together.
  * **Spatial Analysis Functions (`ST_`):** Summarizes `ST_GeomFromText()`, `ST_AsText()`, `ST_Distance()` (planar Euclidean), `ST_Within()`, and `ST_Contains()`.

* **📌 आकृतीचे मराठीत स्पष्टीकरण:**
  * **OpenGIS मानके व प्रकार:** नकाशे (Google Maps), GPS ट्रॅकिंग आणि डिझाइनसाठी MySQL मधील ८ मुख्य भौमितिक प्रकार दर्शवले आहेत.
  * **POINT, LINESTRING व POLYGON:** `POINT` द्वारे अचूक स्थान (अक्षांश/रेखांश), `LINESTRING` द्वारे रस्ते/मार्ग, आणि `POLYGON` द्वारे बंदिस्त क्षेत्र (उदा. शहराच्या सीमा किंवा धरण क्षेत्र) कसे साठवले जाते ते दर्शवले आहे.
  * **GEOMETRY vs GEOMETRYCOLLECTION:** `GEOMETRY` हे एका वेळी एकाच आकाराचे (Point किंवा Line किंवा Polygon) कंटेनर असते, तर `GEOMETRYCOLLECTION` मध्ये एकाच रेकॉर्डमध्ये विविध आकार एकत्र साठवले जातात.
  * **स्थानिक विश्लेषण फंक्शन्स (Spatial Functions):** `ST_GeomFromText` (टेक्स्टवरून आकार बनवणे), `ST_AsText` (वाचण्यायोग्य टेक्स्टमध्ये बदलणे), `ST_Distance` (दोन ठिकाणांमधील अंतर मोजणे), `ST_Within` व `ST_Contains` (एखादा बिंदू विशिष्ट क्षेत्रात आहे की नाही ते तपासणे) यांचे कार्य स्पष्ट केले आहे.

---

### 6.10 Topic 6 Summary (मराठी सारांश)

* **Database Structure (डेटाबेस रचना आणि उतरंड):**
  1. *Server:* जेथे डेटाबेस राहतो व चालतो ते शक्तिशाली संगणक मशीन.
  2. *Database:* विशिष्ट प्रकारचा डेटा साठवणारा मुख्य कंटेनर.
  3. *Schema (स्कीमा):* डेटाबेसच्या अंतर्गत टेबल्सचे वर्गीकरण करणारा लॉजिकल कंटेनर.
  4. *Schema चे २ प्रकार:*
     * *Logical Schema:* डेटा काय साठवला आहे व टेबल्सचे परस्पर संबंध काय आहेत (What is stored).
     * *Physical Schema:* डेटा हार्ड डिस्कवर प्रत्यक्षात कसा साठवला आहे (How it is stored on disk).
* **Table ची रचना (Anatomy of a Table):**
  * *Table:* रो आणि कॉलमच्या स्वरूपात डेटा साठवणारे मुख्य ऑब्जेक्ट.
  * *Column:* डेटाचा एक विशिष्ट गुणधर्म (उदा. Customer_ID, Name, City).
  * *Row:* एका घटकाची संपूर्ण माहिती देणारी एक आडवी ओळ.
  * *Cell:* रो आणि कॉलम एकत्र येतात तो बिंदू (एकच मूल्य).
* **Primary Key (फिंगरप्रिंट):**
  * प्रत्येक रोची अचूक ओळख पटवणारा कॉलम. हे मूल्य Unique असावे लागते, NULL असू शकत नाही, आणि एका टेबलमध्ये एकच Primary Key असते.

* **MySQL Data Types (डेटा प्रकार सविस्तर सारांश):**
  1. **मेमरीनुसार २ मुख्य प्रकार:**
     * *Fixed Data Types:* मेमरीमध्ये निश्चित आकार घेतात (उदा. `CHAR`, `INT`, `DECIMAL`, `FLOAT`). डेटाचा आकार आधीच माहीत असल्यास हे वापरतात.
     * *Variable Data Types:* प्रत्यक्ष व्हॅल्यूच्या लांबीनुसार मेमरी घेतात (उदा. `VARCHAR`, `TEXT`, `BLOB`). मेमरी वाचवण्यासाठी हे उत्तम आहेत.
  2. **Numeric Types (संख्यात्मक डेटा):**
     * `TINYINT` (1 Byte, -128 ते 127), `INT` (4 Bytes, -2.14B ते 2.14B), `BIGINT` (8 Bytes, -9 Quintillion ते +9Q).
     * `DECIMAL(p, s):` पैशांचे हिशोब, बँकिंग आणि किमतींसाठी अचूक संख्या (Exact numeric, राऊंडिंग एरर येत नाही).
     * `FLOAT` (4B) व `DOUBLE` (8B): वैज्ञानिक गणितांसाठी अंदाजे दशांश संख्या (Floating point).
  3. **String व Binary Types:**
     * `CHAR(n):` निश्चित लांबीची अक्षरे (कमी असल्यास स्पेसेस पॅड होतात; वेगाने चालते).
     * `VARCHAR(n):` बदलत्या लांबीची अक्षरे (Actual length + 1 Byte; मेमरी वाचवते).
     * `TEXT:` मोठे मजकूर (TINYTEXT, TEXT, MEDIUMTEXT, LONGTEXT - 4GB पर्यंत).
     * `BLOB:` प्रतिमा (Images), फाइल्स, PDF साठवण्यासाठी Raw Binary डेटा.
     * `BOOLEAN:` `TINYINT(1)` चा Alias; 0 म्हणजे False आणि 1 म्हणजे True.
     * `ENUM:` दिलेल्या यादीतून फक्त **एकच** पर्याय निवडणे (Controlled vocabulary).
     * `SET:` दिलेल्या यादीतून **एकापेक्षा जास्त** पर्यायांचे कॉम्बिनेशन साठवणे.
  4. **Date & Time (Temporal Types):**
     * डीफॉल्ट फॉरमॅट: `YYYY-MM-DD` (3 Bytes, Range: 1000-01-01 ते 9999-12-31).
     * `TIME:` वेळ साठवणे (`HH:MM:SS`, Range: -838:59:59 ते 838:59:59).
     * `DATETIME:` तारीख + वेळ (`YYYY-MM-DD HH:MM:SS`, 5 ते 8 Bytes, Range: 1000 ते 9999). टाइमझोनचा प्रभाव पडत नाही; जशी तारीख दिली तशीच राहते.
     * `TIMESTAMP:` तारीख + वेळ (`YYYY-MM-DD HH:MM:SS`, 4 Bytes, Range: 1970 ते 2038). **UTC मध्ये साठवली जाते** आणि आपोआप अपडेट होते (`CURRENT_TIMESTAMP`).
  5. **UTC म्हणजे काय व का महत्त्वाचे?**
     * UTC (Coordinated Universal Time) हे जगाचे 'तटस्थ' प्रमाणवेळ आहे.
     * जगभरातील सर्व्हरमध्ये वेळेचा गोंधळ होऊ नये आणि सिस्टीम लॉग्स अचूक राहावेत यासाठी MySQL मध्ये `TIMESTAMP` आपोआप UTC मध्ये सेव्ह होतो आणि वाचताना युझरच्या स्थानिक टाइमझोनमध्ये रूपांतरित होतो.
  6. **DATETIME vs TIMESTAMP मुख्य फरक:**
     * `DATETIME`: ५ बाईट्स (जुन्या व्हर्जनमध्ये ८), Range १००० ते ९९९९, टाइमझोन बदलत नाही, वाढदिवस व शेड्युलसाठी योग्य.
     * `TIMESTAMP`: ४ बाईट्स, Range १९७० ते २०३८ (UNIX Epoch), टाइमझोननुसार बदलतो, ऑडिट लॉग्ससाठी योग्य.
  7. **JSON Data Type (स्पेशल सेमी-स्ट्रक्चर्ड डेटा):**
     * MySQL मध्ये JSON डेटा बायनरी फॉरमॅटमध्ये साठवला जातो, ज्यामुळे जलद सर्च करता येतो.
     * `$` हा JSON चा मूळ (Root) असतो (`$.key`, `$.object.key`, `$.array[0]`).
     * `->` ऑपरेटर कोट्ससहित (Quoted JSON) डेटा देतो, तर `->>` ऑपरेटर कोट्स काढून प्लेन टेक्स्ट देतो.
     * `JSON_EXTRACT()` (डेटा काढणे), `JSON_SET()` (अपडेट करणे किंवा नवीन की जोडणे), `JSON_ARRAY()` व `JSON_OBJECT()` (अरे व ऑब्जेक्ट बनवणे) ही मुख्य फंक्शन्स आहेत.
  8. **Spatial / GIS Data Types (भौगोलिक व भूमितीय डेटा):**
     * OpenGIS मानकांवर आधारित नकाशे, GPS लोकेशन आणि जिओफेन्सिंगसाठी वापरले जातात.
     * मुख्य प्रकार: `POINT` (एका ठिकाणाचे $x, y$ अक्षांश-रेखांश), `LINESTRING` (रस्ते, नद्या, वाहतूक मार्ग), `POLYGON` (बंदिस्त क्षेत्र, शहराची सीमा, धरण).
     * `MULTIPOINT`, `MULTILINESTRING`, `MULTIPOLYGON` हे अनेक आकारांचे संच असतात.
     * `GEOMETRY` एका वेळी एकच भौमितिक आकार साठवतो, तर `GEOMETRYCOLLECTION` एकाच कॉलममध्ये अनेक वेगवेगळे आकार एकत्र साठवू शकतो.
     * महत्त्वाची फंक्शन्स: `ST_GeomFromText()` (WKT टेक्स्टवरून आकार तयार करणे), `ST_AsText()` (वाचण्यायोग्य टेक्स्ट करणे), `ST_Distance()` (अंतर मोजणे), `ST_Within()` व `ST_Contains()` (बिंदू क्षेत्रात आहे की नाही ते तपासणे).

---

## Topic 7: SQL vs MySQL

### 7.1 What is SQL?

* **Q. What is SQL?**
  * *SQL stands for: Structured Query Language.*
  * *Category: Domain-specific declarative query language.*
  * *Role: Serves as the universal standard language to query, manipulate, and administer relational databases.*
  * *Note: SQL does not store data on its own; it is the communication language.*

---

### 7.2 What is MySQL?

* **Q. What is MySQL?**
  * *Category: An open-source Relational Database Management System (RDBMS) software application.*
  * *Role: An executable database engine and server program that stores and manages data.*
  * *Function: Stores records in structured tables, executes SQL queries, manages storage engines (InnoDB), caching, and multi-user concurrency.*

---

### 7.3 Key Differences: Comparison Table

| Feature / Aspect | SQL (Structured Query Language) | MySQL (Relational DBMS) |
| :--- | :--- | :--- |
| **Category** | Declarative **Query Language**. | Complete **RDBMS Software Engine**. |
| **Primary Purpose** | Querying, filtering, and manipulating data. | Storing, persisting, indexing, and securing data files. |
| **Data Storage** | Does **not** store data itself. | **Stores and manages** data blocks on physical disk. |
| **Version Cycles** | Standardized language specification (ANSI SQL). | Continuously updated database software (e.g., MySQL 8.0, 8.4). |
| **Installation** | Cannot be installed (it is a language standard). | Installed as a background service/daemon on servers and cloud. |
| **Analogy** | Like the **English Language** (medium of speech). | Like a **Person** who understands and speaks English. |

---

### 7.4 Visual Concept: Language vs RDBMS Software

![SQL vs MySQL](./sql_vs_mysql_diagram.svg)

#### Simple Explanation of the Diagram:
* **Left Card (SQL):** The declarative language used to communicate instructions (`SELECT`, `INSERT`, `UPDATE`, `DELETE`).
* **Right Card (MySQL):** The database software engine that receives SQL instructions and performs disk storage, caching, and retrieval.
* **Bottom Rule:** SQL is the Language, while MySQL is the Software Engine that executes that language!

* **📌 आकृतीचे मराठीत स्पष्टीकरण:**
  * *डावे कार्ड (SQL):* डेटाबेसशी संवाद साधण्यासाठीची भाषा.
  * *उजवे कार्ड (MySQL):* प्रत्यक्षात कॉम्प्युटरवर इन्स्टॉल होणारे सॉफ्टवेअर/इंजिन.
  * *सोपे सूत्र:* SQL ही भाषा आहे, तर MySQL हे ती भाषा बोलणारे सॉफ्टवेअर आहे!

---

### 7.5 Topic 7 Summary (मराठी सारांश)

* **SQL (Structured Query Language):**
  * ही एक क्वेरी लँग्वेज आहे. Relational databases शी संवाद साधण्यासाठी ही भाषा वापरली जाते.
  * SQL स्वतः डेटा साठवत नाही; ती फक्त सूचना देण्याचे साधन आहे.
* **MySQL:**
  * हे एक **RDBMS** सॉफ्टवेअर आहे. हे SQL भाषेचा वापर करून डेटा प्रत्यक्षात टॅब्युलर फॉरमॅटमध्ये साठवण्याचे, सुरक्षित ठेवण्याचे आणि व्यवस्थापित करण्याचे काम करते.
* **थोडक्यात फरक:**
  * *SQL* ही भाषा आहे.
  * *MySQL* हे ती भाषा समजून डेटा चालवणारे सॉफ्टवेअर आहे.

---

## Topic 8: SQL Commands & DDL (Data Definition Language) In-Depth

### 8.1 Check Current SQL / MySQL Version

To verify the current installed version of your database engine:

```sql
mysql> SELECT VERSION();
+-----------+
| VERSION() |
+-----------+
| 9.1.0     |
+-----------+
1 row in set (0.00 sec)
```

---

### 8.2 Broad Classification of SQL Commands
SQL commands are used to communicate with the database, manage structures, and manipulate data. They are classified into:

1. **DDL (Data Definition Language):** Defines and modifies the structure/blueprint of database objects (`CREATE`, `ALTER`, `DROP`, `TRUNCATE`, `RENAME`).
2. **DML (Data Manipulation Language):** Manipulates actual row data (`INSERT`, `UPDATE`, `DELETE`).
3. **DQL (Data Query Language):** Searches, filters, and retrieves data (`SELECT`).

![SQL Commands Overview: DDL, DML, DQL](./ddl_dml_dql_overview_diagram.svg)

---

### 8.3 What is DDL (Data Definition Language)?
* *Definition: DDL (Data Definition Language) commands create, change and delete the **structure** of the database — databases, tables, indexes, views, etc.*
  * **Defines the structure of the database object:** It is how you create, modify, or delete the blueprint of your database.
  * **Works on structure, not on individual rows:** DDL changes tables and other objects. (`DROP` and `TRUNCATE` also remove the data, because they remove/empty the whole table.)
* **Objects It Works On:** Databases, Schemas, Tables, Views, Indexes, Stored Procedures, Triggers, and Functions.
* **Core Functions:**
  * **`CREATE`**: Creates a database or database objects inside the DB (Database / Schema, Table, Index, View, Stored Procedure, Triggers, Function).
  * **`ALTER`**: Modifies the structure of existing objects without deleting them.
  * **`DROP`**: Permanently deletes database objects and all their data.
  * **`TRUNCATE`**: Removes all records from a table while preserving the table structure.
  * **`RENAME`**: Changes the name of existing database objects.

![DDL Define Structure of Your Data](./ddl_alter_operations_diagram.svg)

---

### 8.4 The Implicit Commit Rule in MySQL
> ⚠️ **Critical Architectural Note:**
> In MySQL, most DDL statements perform an implicit commit.
> This means that when you execute a DDL command (`CREATE`, `ALTER`, `DROP`, `TRUNCATE`), MySQL commits the current transaction automatically.
> **You CANNOT use ROLLBACK to undo a DDL operation!**

---

### 8.5 CREATE Commands (Database, Tables, Indexes & Info)
The **`CREATE`** command is used to create a database or database objects inside the DB (such as Tables, Indexes, Views, Stored Procedures, Triggers, and Functions).

#### 1. How to Create a Database
* **Syntax:**
  ```sql
  CREATE DATABASE [IF NOT EXISTS] db_name;
  ```

* **Examples:**
  ```sql
  -- Basic creation:
  CREATE DATABASE company_db;

  -- Safe creation (avoids error if it already exists):
  CREATE DATABASE IF NOT EXISTS school_db;
  ```

#### 2. How to Show All Databases in the RDBMS
* **Command / Syntax:**
  ```sql
  SHOW DATABASES;
  ```

#### 3. How to Select or Use a Particular Database
* Once a database is created, you must select it before creating tables or querying:
* **Syntax:**
  ```sql
  USE db_name;
  ```
* **Example:**
  ```sql
  USE company_db;
  ```

#### 4. How to Show All Tables in the Current Database
* **Command / Syntax:**
  ```sql
  SHOW TABLES;
  ```

#### 5. How to Create a Table
* **General Syntax:**
  ```sql
  CREATE TABLE table_name (
      column1 datatype constraints,
      column2 datatype constraints,
      ...
  );
  ```

* **Basic Example (Without explicit constraints):**
  ```sql
  CREATE TABLE employees (
      id INT,
      name VARCHAR(100),
      age INT,
      email VARCHAR(150),
      salary DECIMAL(10, 2)
  );
  ```

* **Production Example (With Constraints: Primary Key, Not Null, Unique, Default):**
  ```sql
  CREATE TABLE employees (
      id INT PRIMARY KEY,
      name VARCHAR(100) NOT NULL,
      age INT,
      email VARCHAR(150) UNIQUE,
      salary DECIMAL(10, 2) DEFAULT 0
  );
  ```

#### 6. How to Show Detailed Information / Schema of a Table
* **Syntax:**
  ```sql
  DESCRIBE table_name;
  -- or shorthand:
  DESC table_name;
  ```

* **Example:**
  ```sql
  DESCRIBE employees;
  -- or
  DESC employees;
  ```

#### 7. How to Create an Index on a Table
An index makes searching on a column much faster (like the index at the back of a book):
* **Syntax:**
  ```sql
  CREATE INDEX index_name
  ON table_name (column_name);
  ```
* **Real Example:**
  ```sql
  CREATE INDEX AGE_INDEX ON STUDENT(AGE);
  ```

---

### 8.6 ALTER Commands (Database Level & Table Level)

* *Definition: ALTER is a DDL command that changes the structure of an existing table or database, without deleting and re-creating it.*
  * **Using ALTER, you can:** add, change, rename or remove columns, constraints and indexes.
  * **Existing data stays:** `ALTER` changes only the structure; data in the other columns is not touched.

* **Two Main Scopes of ALTER:**
  1. **On a Database (ALTER DATABASE / ALTER SCHEMA):**
     * You can use `ALTER DATABASE` (or `ALTER SCHEMA`) to change certain database properties.
     * Examples: Change the default **CHARACTER SET** (e.g., `utf8mb4`) or default **COLLATION** (e.g., `utf8mb4_unicode_ci`).
  2. **On Table Level (ALTER TABLE):**
     * `ALTER TABLE` changes the structure of a table.
     * If you want modification on table structure, you use `ALTER` to perform tasks such as:
       * **Add column:** Insert new columns into an existing table (at the end, `FIRST`, or `AFTER column_name`).
       * **Modify column datatype:** Change datatype, size, nullability, or default value.
       * **Rename column:** Change column names (`RENAME COLUMN` or `CHANGE`).
       * **Drop a column:** Permanently delete a column from the table.
       * **Add a constraint:** Add rules like `PRIMARY KEY`, `UNIQUE`, `FOREIGN KEY`, or `CHECK`.
       * **Drop constraint:** Remove existing constraints.
       * **Add / modify / drop indexes:** Add or remove lookup indexes for faster query performance.
       * **Rename table:** Rename an existing table entity (`RENAME TO`).
       * *(i.e., Edit, modify, and change the existing table structure and definition).*

![Scope of ALTER Commands: Database Level vs Table Level](./alter_database_and_table_hierarchy.svg)

#### 1. Database-Level Alter Operations
* **Modifying Default Character Set and Collation:**
  ```sql
  ALTER DATABASE database_name
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;
  ```

* **Q. Can we rename a database in MySQL?**
  * **Answer:** **No.** MySQL does not support a direct `RENAME DATABASE` statement (to prevent data corruption). To rename a database, you create a new database, dump/move the tables to it, and drop the old database after verification.

---

#### 2. Table-Level Alter Operations

##### A. Add a New Column
* **Syntax:**
  ```sql
  -- 1. Default (adds column at the end of the table):
  ALTER TABLE table_name ADD COLUMN column_name datatype [constraints];

  -- 2. Add column as the FIRST column:
  ALTER TABLE table_name ADD COLUMN column_name datatype [constraints] FIRST;

  -- 3. Add column AFTER a specific column:
  ALTER TABLE table_name ADD COLUMN column_name datatype [constraints] AFTER existing_column;
  ```

* **Examples:**
  * **Default (Adds column at the end of the table):**
    ```sql
    ALTER TABLE employees ADD COLUMN address VARCHAR(255);
    ```
  * **Add column as the FIRST column:**
    ```sql
    ALTER TABLE employees ADD COLUMN address VARCHAR(255) FIRST;
    ```
  * **Add column AFTER a specific column:**
    ```sql
    ALTER TABLE employees ADD COLUMN address VARCHAR(255) AFTER name;
    ```

##### B. Modify an Existing Column (Datatype, Size, Nullability)
* **Syntax:**
  ```sql
  ALTER TABLE table_name MODIFY COLUMN column_name new_datatype [new_constraints];
  ```
  *(Note: The keyword `COLUMN` is optional in MySQL: `ALTER TABLE table_name MODIFY column_name new_datatype;`)*

* **Examples:**
  * `MODIFY` is used to change column data type, size, nullability, or default without renaming:
  ```sql
  -- Increase size and make NOT NULL:
  ALTER TABLE employees MODIFY salary DECIMAL(12, 2) NOT NULL;

  -- Change student_phone size from VARCHAR(100) to VARCHAR(20):
  ALTER TABLE STUDENT MODIFY STUDENT_PHONE VARCHAR(20);
  ```

##### C. Change a Column (Rename + Modify Datatype At Once)
* **Syntax:**
  ```sql
  ALTER TABLE table_name CHANGE COLUMN old_column new_column datatype [constraints];
  ```
  *(Note: The keyword `COLUMN` is optional in MySQL)*

* **Examples:**
  ```sql
  -- Rename PHONENO to MOBILE and change datatype to VARCHAR(100):
  ALTER TABLE PERSON1 CHANGE PHONENO MOBILE VARCHAR(100);

  -- Rename PHONE to STUDENT_PHONE with VARCHAR(200):
  ALTER TABLE STUDENT CHANGE PHONE STUDENT_PHONE VARCHAR(200);

  -- Rename MOBILE to STUDENT_MOBILE with VARCHAR(50):
  ALTER TABLE STUDENT CHANGE MOBILE STUDENT_MOBILE VARCHAR(50);
  ```

##### D. Rename ONLY a Column (MySQL 8.0+)
* **Syntax:**
  ```sql
  ALTER TABLE table_name RENAME COLUMN old_column_name TO new_column_name;
  ```

* **Example:**
  ```sql
  ALTER TABLE employees RENAME COLUMN salary TO monthly_salary;
  ```

##### E. Drop a Column
* **Syntax:**
  ```sql
  ALTER TABLE table_name DROP COLUMN column_name;
  ```

* **Examples (Permanently removes column and its data):**
  ```sql
  ALTER TABLE employees DROP COLUMN phone;

  ALTER TABLE STUDENT DROP COLUMN STUDENT_PHONE;
  ```

##### F. Rename a Table
* **Syntax:**
  ```sql
  -- Method 1 (Using ALTER TABLE):
  ALTER TABLE table_name RENAME TO new_table_name;

  -- Method 2 (Using RENAME TABLE statement):
  RENAME TABLE old_table_name TO new_table_name;
  ```

* **Examples:**
  ```sql
  -- Method 1 Examples:
  ALTER TABLE employees RENAME TO staff;
  ALTER TABLE STUDENT RENAME STUDENT_INFO;

  -- Method 2 Examples:
  RENAME TABLE employee TO staff;
  RENAME TABLE STUDENT_INFO TO STUD;
  ```

##### G. Set or Drop Default Values
* **Syntax:**
  ```sql
  -- Set Default Value:
  ALTER TABLE table_name ALTER COLUMN column_name SET DEFAULT default_value;

  -- Drop Default Value:
  ALTER TABLE table_name ALTER COLUMN column_name DROP DEFAULT;
  ```
  *(Note: The keyword `COLUMN` is optional in MySQL)*

* **Examples:**
  ```sql
  -- Set Default Value:
  ALTER TABLE employees ALTER salary SET DEFAULT 5000;

  -- Drop Default Value:
  ALTER TABLE employees ALTER salary DROP DEFAULT;
  ```

##### H. Change AUTO_INCREMENT Starting Value
* **Syntax:**
  ```sql
  ALTER TABLE table_name AUTO_INCREMENT = starting_number;
  ```

* **Example:**
  ```sql
  ALTER TABLE employees AUTO_INCREMENT = 1000;
  ```

---

### 8.7 Constraints Management via ALTER (Add & Drop Rules)

Constraints enforce data integrity and business rules on table columns. Using `ALTER TABLE`, you can add or remove these constraints on existing tables without rebuilding them.

#### Quick Reference Matrix:

| Constraint | How to ADD | How to DROP |
| :--- | :--- | :--- |
| **PRIMARY KEY** | `ALTER TABLE employees ADD PRIMARY KEY (id);` | `ALTER TABLE employees DROP PRIMARY KEY;` |
| **UNIQUE** | `ALTER TABLE employees ADD CONSTRAINT unique_email UNIQUE (email);` | `ALTER TABLE employees DROP INDEX unique_email;` |
| **FOREIGN KEY** | `ALTER TABLE orders ADD CONSTRAINT fk_cust FOREIGN KEY (customer_id) REFERENCES customers(id);` | `ALTER TABLE orders DROP FOREIGN KEY fk_cust;` |
| **CHECK** | `ALTER TABLE employees ADD CONSTRAINT chk_age CHECK (age >= 18);` | `ALTER TABLE employees DROP CHECK chk_age;` |
| **NOT NULL** | `ALTER TABLE STUDENT MODIFY EDUCATION VARCHAR(255) NOT NULL;` | `ALTER TABLE STUDENT MODIFY EDUCATION VARCHAR(255) NULL;` |
| **DEFAULT** | `ALTER TABLE employees ALTER salary SET DEFAULT 5000;` | `ALTER TABLE employees ALTER salary DROP DEFAULT;` |

---

#### Detailed Breakdown & Examples for Each Constraint:

##### 1. PRIMARY KEY Constraint
* **What it does:** Uniquely identifies each record in a table. It cannot contain `NULL` values, and each table can have only one primary key.
* **Syntax:**
  ```sql
  -- To ADD a Primary Key:
  ALTER TABLE table_name ADD PRIMARY KEY (column_name);

  -- With explicit constraint name:
  ALTER TABLE table_name ADD CONSTRAINT constraint_name PRIMARY KEY (column_name);

  -- To DROP a Primary Key:
  ALTER TABLE table_name DROP PRIMARY KEY;
  ```
* **Step-by-Step Example:**
  ```sql
  -- Add PRIMARY KEY to 'id' column:
  ALTER TABLE employees ADD PRIMARY KEY (id);

  -- Drop PRIMARY KEY from employees table:
  ALTER TABLE employees DROP PRIMARY KEY;
  ```

##### 2. UNIQUE Constraint
* **What it does:** Ensures that all values in a column are distinct (different). Unlike Primary Key, it allows `NULL` values.
* **Important Note:** In MySQL, adding a `UNIQUE` constraint creates an internal unique index. Therefore, to drop it, you use `DROP INDEX`.
* **Syntax:**
  ```sql
  -- To ADD a Unique constraint:
  ALTER TABLE table_name ADD CONSTRAINT constraint_name UNIQUE (column_name);

  -- To DROP a Unique constraint (drops the underlying index):
  ALTER TABLE table_name DROP INDEX constraint_name;
  ```
* **Step-by-Step Example:**
  ```sql
  -- Add UNIQUE constraint on email:
  ALTER TABLE employees ADD CONSTRAINT unique_email UNIQUE (email);

  -- Drop UNIQUE constraint using its index name:
  ALTER TABLE employees DROP INDEX unique_email;

  -- Another Example (Dropping unique mobile number index):
  ALTER TABLE PERSONINFORMATION DROP INDEX MOBILENO;
  ```

##### 3. FOREIGN KEY Constraint
* **What it does:** Enforces referential integrity between two tables by ensuring that values in a child table correspond to valid primary key values in the parent table.
* **Syntax:**
  ```sql
  -- To ADD a Foreign Key:
  ALTER TABLE child_table
  ADD CONSTRAINT fk_name
  FOREIGN KEY (child_column) REFERENCES parent_table (parent_primary_key);

  -- To DROP a Foreign Key:
  ALTER TABLE child_table DROP FOREIGN KEY fk_name;
  ```
* **Step-by-Step Example:**
  ```sql
  -- Add FOREIGN KEY linking orders.customer_id to customers.id:
  ALTER TABLE orders
  ADD CONSTRAINT fk_cust
  FOREIGN KEY (customer_id) REFERENCES customers(id);

  -- Drop FOREIGN KEY constraint:
  ALTER TABLE orders DROP FOREIGN KEY fk_cust;
  ```

##### 4. CHECK Constraint
* **What it does:** Enforces a condition that all values inserted or updated in a column must satisfy (e.g., minimum age, positive salary).
* **Syntax:**
  ```sql
  -- To ADD a Check constraint:
  ALTER TABLE table_name ADD CONSTRAINT chk_name CHECK (condition);

  -- To DROP a Check constraint:
  ALTER TABLE table_name DROP CHECK chk_name;
  ```
* **Step-by-Step Example:**
  ```sql
  -- Add CHECK constraint ensuring employee age is 18 or older:
  ALTER TABLE employees ADD CONSTRAINT chk_age CHECK (age >= 18);

  -- Add CHECK constraint ensuring salary is greater than 0:
  ALTER TABLE employees ADD CONSTRAINT chk_salary CHECK (salary > 0);

  -- Drop CHECK constraint:
  ALTER TABLE employees DROP CHECK chk_age;
  ```

##### 5. NOT NULL Constraint
* **What it does:** Ensures that a column never accepts empty or missing (`NULL`) values.
* **Syntax:**
  ```sql
  -- To ADD NOT NULL (make column mandatory):
  ALTER TABLE table_name MODIFY column_name datatype NOT NULL;

  -- To DROP NOT NULL (allow NULL values):
  ALTER TABLE table_name MODIFY column_name datatype NULL;
  ```
* **Step-by-Step Example:**
  ```sql
  -- Make EDUCATION column mandatory:
  ALTER TABLE STUDENT MODIFY EDUCATION VARCHAR(255) NOT NULL;

  -- Allow NULL values in EDUCATION column:
  ALTER TABLE STUDENT MODIFY EDUCATION VARCHAR(255) NULL;
  ```

##### 6. DEFAULT Constraint
* **What it does:** Automatically assigns a preset value when no value is provided for the column during an `INSERT`.
* **Syntax:**
  ```sql
  -- To SET / ADD a Default value:
  ALTER TABLE table_name ALTER COLUMN column_name SET DEFAULT default_value;

  -- To DROP a Default value:
  ALTER TABLE table_name ALTER COLUMN column_name DROP DEFAULT;
  ```
  *(Note: The keyword `COLUMN` is optional in MySQL)*
* **Step-by-Step Example:**
  ```sql
  -- Set default salary of 5000:
  ALTER TABLE employees ALTER salary SET DEFAULT 5000;

  -- Set default status to 'Active':
  ALTER TABLE employees ALTER status SET DEFAULT 'Active';

  -- Drop the default salary value:
  ALTER TABLE employees ALTER salary DROP DEFAULT;
  ```

---

### 8.8 Quick Revision Cheat Sheet: ALTER Operations

| Keyword | What it Does |
| :--- | :--- |
| **`ADD`** | Adds column, constraint, or index |
| **`DROP`** | Drops column, constraint, index, or primary key |
| **`MODIFY`** | Changes column definition (datatype, null, default) without renaming |
| **`CHANGE`** | Renames + modifies column definition in one step |
| **`RENAME`** | Renames table or index (or column in MySQL 8.0+) |
| **`ALTER`** | Sets/drops default values, character sets, or `AUTO_INCREMENT` |

---

### 8.9 DROP Commands (Permanent Object Deletion)
* **What it does:** Completely and permanently removes a database object and all its stored data.
* **Automatic Commit:** In MySQL, `DROP` cannot be rolled back with `ROLLBACK`.
* **Difference from `DELETE`:** `DELETE` only removes row records; `DROP` destroys the entire table structure, indexes, and constraints.

#### 1. Drop Database
* **Syntax:**
  ```sql
  DROP DATABASE [IF EXISTS] database_name;
  ```
* **Example:**
  ```sql
  DROP DATABASE company_db;
  ```

#### 2. Drop Table
* **Syntax:**
  ```sql
  DROP TABLE [IF EXISTS] table_name;
  ```
* **Examples:**
  ```sql
  DROP TABLE employees;
  DROP TABLE person;
  ```

---

### 8.10 TRUNCATE Commands (Wipe Data, Keep Structure)
* *Definition: TRUNCATE deletes all rows from a table in one go and frees the space, but keeps the table structure.*
* **Syntax:**
  ```sql
  TRUNCATE TABLE table_name;
  ```

* **Example:**
  ```sql
  TRUNCATE TABLE Students;
  ```
* **Key Characteristics of TRUNCATE:**
  1. **Keeps the Structure:** Table name, column names, data types, primary key, unique constraints, and foreign key definitions remain 100% intact.
  2. **Resets AUTO_INCREMENT:** Resets auto-increment counters back to 1.
  3. **DDL Operation:** Much faster than `DELETE`, because it doesn't delete rows one by one — MySQL simply empties the table (internally it drops and re-creates it).
  4. **Cannot be Rolled Back:** Cannot undo with `ROLLBACK` in MySQL.
  5. **Foreign Key Rule:** You cannot truncate a table that is actively referenced by an existing foreign key constraint.

---

### 8.11 RENAME Commands (Objects & Tables)

* *Definition: RENAME is a DDL command that changes the name of a table (or a column, index or view) without touching the data.*

* **Core Characteristics & Architectural Rules:**
  * **Only the name changes:** MySQL just updates the name in its internal list (data dictionary); no data is copied.
  * **Zero Data Loss:** All column definitions, constraints (Primary Key, Foreign Key, Unique), indexes, and existing rows remain 100% intact.
  * **Implicit Commit:** In MySQL, executing `RENAME` immediately causes an implicit transaction commit. **It cannot be rolled back with ROLLBACK.**
  * **Application & View Impact:** Any application queries, views, or stored procedures that hardcode the old object name must be updated to reference the new name.

---

#### 1. Renaming Tables (Two Distinct Methods)

##### Method A: The Standalone `RENAME TABLE` Statement (Recommended)
* **Description:** MySQL provides a dedicated `RENAME TABLE` statement. Its unique superpower is that it can rename **multiple tables atomically in a single statement**.
* **Syntax:**
  ```sql
  -- Single table:
  RENAME TABLE old_table_name TO new_table_name;

  -- Multiple tables atomically (Zero-Downtime Swapping):
  RENAME TABLE old_tbl1 TO new_tbl1,
               old_tbl2 TO new_tbl2;
  ```
* **Examples:**
  ```sql
  -- 1. Standard single table rename:
  RENAME TABLE STUDENT_INFO TO STUD;

  -- 2. Renaming employee table to staff:
  RENAME TABLE employees TO staff_members;

  -- 3. Production Zero-Downtime Atomic Swap (Swapping staging table to live table):
  RENAME TABLE live_products TO backup_products,
               staging_products TO live_products;
  ```

##### Method B: Using `ALTER TABLE ... RENAME TO`
* **Description:** Part of the standard `ALTER TABLE` suite. Best used when you are already performing table-level modifications.
* **Syntax:**
  ```sql
  ALTER TABLE table_name RENAME TO new_table_name;
  -- or shorthand:
  ALTER TABLE table_name RENAME new_table_name;
  ```
* **Examples:**
  ```sql
  ALTER TABLE STUDENT RENAME TO STUDENT_INFO;
  ALTER TABLE employees RENAME TO staff;
  ```

---

#### 2. Moving Tables Across Databases (Cross-Database Move)
* **Description:** Because MySQL intentionally does not support a `RENAME DATABASE` command, the `RENAME TABLE` statement is the official, instant way to move a table from one database schema to another without copying data.
* **Syntax:**
  ```sql
  RENAME TABLE source_db.table_name TO target_db.table_name;
  ```
* **Example:**
  ```sql
  -- Instantly moves the 'orders' table from 'staging_db' to 'production_db':
  RENAME TABLE staging_db.orders TO production_db.orders;
  ```

---

#### 3. Renaming Other Database Objects

##### A. Renaming a Column Inside a Table
* **Modern Syntax (MySQL 8.0+):**
  ```sql
  ALTER TABLE table_name RENAME COLUMN old_col_name TO new_col_name;
  ```
  * *Example:*
    ```sql
    ALTER TABLE employees RENAME COLUMN phone TO mobile_number;
    ```
* **Legacy Syntax (MySQL 5.7 and earlier using `CHANGE`):**
  ```sql
  ALTER TABLE table_name CHANGE old_col_name new_col_name datatype [constraints];
  ```
  * *Example:*
    ```sql
    ALTER TABLE employees CHANGE phone mobile_number VARCHAR(20);
    ```

##### B. Renaming an Index
* **Description:** Changes the name of an existing performance index without rebuilding the B-Tree index structure.
* **Syntax:**
  ```sql
  ALTER TABLE table_name RENAME INDEX old_index_name TO new_index_name;
  ```
* **Example:**
  ```sql
  ALTER TABLE employees RENAME INDEX idx_emp_email TO idx_staff_email;
  ```

##### C. Renaming a View
* **Description:** A database view can be renamed exactly like a table using the `RENAME TABLE` command.
* **Syntax:**
  ```sql
  RENAME TABLE old_view_name TO new_view_name;
  ```
* **Example:**
  ```sql
  RENAME TABLE active_users_view TO current_users_view;
  ```

---

#### 4. **Q. Can We Directly Rename a Database in MySQL?**
* **Direct Answer:** **NO.** MySQL had an experimental `RENAME DATABASE` in MySQL 5.1.7, but it was quickly removed in 5.1.23 because it carried extreme risks of file-system data corruption.
* **Recommended Production Method to "Rename" a Database:**
  1. Create the new target database:
     ```sql
     CREATE DATABASE new_database_name;
     ```
  2. Move all tables from old database to new database using `RENAME TABLE`:
     ```sql
     RENAME TABLE old_db.table1 TO new_db.table1,
                  old_db.table2 TO new_db.table2;
     ```
  3. Verify data and drop the now-empty old database:
     ```sql
     DROP DATABASE old_database_name;
     ```

---

### 8.12 Differences Between DELETE, TRUNCATE, and DROP

In SQL, you can remove data with three commands: **`DELETE`**, **`TRUNCATE`**, and **`DROP`**. All three remove data, but they work very differently (speed, rollback, and what happens to the table).

![SQL Comparison: DELETE vs TRUNCATE vs DROP](./delete_vs_drop_vs_truncate_diagram.svg)

---

#### 1. Comprehensive 10-Point Comparison Matrix

| Feature / Dimension | `DELETE` | `TRUNCATE` | `DROP` |
| :--- | :--- | :--- | :--- |
| **1. Command Category** | **DML** (Data Manipulation Language) | **DDL** (Data Definition Language) | **DDL** (Data Definition Language) |
| **2. Core Purpose & Action** | Deletes specific rows or all rows | Wipes all rows in a table simultaneously | Completely deletes table, schema & data |
| **3. WHERE Clause Filtering** | **Supported** (`WHERE condition`) | **NOT Supported** (Cannot filter rows) | **NOT Supported** (Cannot filter rows) |
| **4. Rollback / Transactions** | **YES** (Can be undone with `ROLLBACK`) | **NO in MySQL** (Implicit Commit) | **NO in MySQL** (Implicit Commit) |
| **5. Execution Speed** | **Slower** (Logs row-by-row deletions) | **Very Fast** (Deallocates entire data pages) | **Fastest** (Removes object from catalog) |
| **6. Space Deallocation** | **NO** (Keeps disk pages allocated to table) | **YES** (Releases data pages back to engine) | **YES** (100% disk and memory space freed) |
| **7. AUTO_INCREMENT Counter** | **Preserved** (Next ID = Max ID + 1) | **RESET back to 1** (Starts numbering fresh) | **Deleted** (Table no longer exists) |
| **8. Trigger Execution** | **Fires** `ON DELETE` row triggers | **Does NOT** fire row-level triggers | **Does NOT** fire triggers (Triggers dropped) |
| **9. Foreign Key Rules** | Allowed if cascade/child rules permit | **BLOCKED** if referenced by active FK | **BLOCKED** if another table's FK points to it (drop the FK or child table first; in MySQL the `CASCADE` keyword does nothing here) |
| **10. Table Structure After Query** | **100% Intact** (Columns, keys preserved) | **100% Intact** (Columns, keys preserved) | **DESTROYED** (Table completely vanishes) |

---

#### 2. Syntax and Concrete Practical Examples

##### A. `DELETE` Command
* **Syntax:**
  ```sql
  DELETE FROM table_name [WHERE condition];
  ```
* **Examples:**
  ```sql
  -- 1. Conditional deletion (removes single row):
  DELETE FROM employees WHERE id = 101;

  -- 2. Range deletion:
  DELETE FROM employees WHERE age < 18;

  -- 3. Delete all rows (row-by-row, rollback possible):
  DELETE FROM employees;
  ```

##### B. `TRUNCATE` Command
* **Syntax:**
  ```sql
  TRUNCATE TABLE table_name;
  ```
* **Example:**
  ```sql
  -- Wipes all records, resets AUTO_INCREMENT to 1, table structure stays intact:
  TRUNCATE TABLE employees;
  ```

##### C. `DROP` Command
* **Syntax:**
  ```sql
  DROP TABLE [IF EXISTS] table_name;
  ```
* **Example:**
  ```sql
  -- Permanently deletes the table structure and its data from the database:
  DROP TABLE employees;
  ```

---

#### 3. When to Use Which? (Decision Guide)

1. **Use `DELETE` when:**
   - You need to delete **only specific rows** based on a criteria (`WHERE condition`).
   - You need the safety of **`ROLLBACK`** in case of errors.
   - You have **auditing triggers** that must execute on every deleted row.

2. **Use `TRUNCATE` when:**
   - You want to **wipe out all records from a table quickly** (e.g., staging tables, logs, testing caches).
   - You want the primary key **`AUTO_INCREMENT` counter to reset back to 1**.
   - You want to release allocated disk pages back to the database system.

3. **Use `DROP` when:**
   - You want to **completely decommission and delete an entire table** that is no longer needed.
   - You are rebuilding a table from scratch by dropping and recreating it.

---

#### 4. Focused Deep-Dive: DROP vs. TRUNCATE (Direct 6-Point Comparison)

* **`DROP TABLE` (Total Structural Elimination):**
  * **Core Action:** Removes the entire table structure (schema + data). After drop, the table no longer exists.
    ```sql
    DROP TABLE table_name;  -- Drop table completely
    ```
  * **Storage:** Frees up the storage completely from disk.
  * **Rollback:** Permanent and irreversible in MySQL (`DDL = Implicit Commit`). *(Note: In PostgreSQL, DDL can rollback inside transactions).*
  * **Speed:** Extremely fast (removes metadata entry from system catalog in one step).
  * **Objects Removed:** Removes table definition, constraints, indexes, triggers—everything.
  * **Auto-Increment Counter:** Disappears completely because the table entity is destroyed.

* **`TRUNCATE TABLE` (Fast Data Wipe, Structure Retained):**
  * **Core Action:** Clears the whole table at once without row-by-row logging. Removes all rows, but keeps the table structure intact (table becomes empty and ready for fresh use).
    ```sql
    TRUNCATE TABLE table_name;  -- Truncate table (delete all rows)
    ```
  * **Storage:** Empties the table data, but structure and table allocations stay.
  * **Rollback:** Not rollback-able in MySQL (`DDL = Implicit Commit`).
  * **Speed:** Faster than `DELETE` (deallocates pages rather than writing undo logs), but slightly slower than `DROP` because table schema must be preserved.
  * **Objects Preserved:** Only removes row records; preserves columns, data types, constraints, indexes, and triggers.
  * **Auto-Increment Counter:** Resets the `AUTO_INCREMENT` sequence counter back to `1` (fresh start).

---

### 8.13 Visual Diagrams & Architectural Explanations

#### Diagram 1: SQL Commands Overview (DDL, DML, DQL)
![SQL Commands Overview: DDL, DML, DQL](./ddl_dml_dql_overview_diagram.svg)
* **Explanation:**
  * **DDL (Left):** Used by developers to define the blueprint (`CREATE`, `ALTER`, `DROP`, `TRUNCATE`, `RENAME`). Operates with implicit commits.
  * **DML (Bottom-Right):** Used to write and modify actual rows (`INSERT`, `UPDATE`, `DELETE`).
  * **DQL (Top-Right):** Used to search and retrieve data reports (`SELECT`).
* **📌 आकृतीचे मराठीत स्पष्टीकरण:**
  * **DDL (डावा भाग):** डेटाबेस व टेबल्सचा मूळ साचा तयार करणे व बदलणे (`CREATE`, `ALTER`, `DROP`, `TRUNCATE`, `RENAME`). हे बदल तात्काळ ऑटो-कमिट होतात.
  * **DML (उजवीकडील खालचा भाग):** टेबलमधील प्रत्यक्ष डेटावर प्रक्रिया करणे (`INSERT`, `UPDATE`, `DELETE`).
  * **DQL (उजवीकडील वरचा भाग):** डेटाबेसमधून हवा तो डेटा शोधून वाचणे (`SELECT`).

---

#### Diagram 2: DDL Structure & Scope of ALTER
![DDL ALTER Operations & Structure](./ddl_alter_operations_diagram.svg)
* **Explanation:**
  * **Left Panel:** Illustrates `CREATE`, `ALTER`, and `DROP` acting upon the database container and its tables.
  * **Right Panel:** Visualizes the scope tree showing changes at the **Database Level** (Character Set, Collation) vs. **Table Level** (Columns, Datatypes, Constraints, and Indexes).
* **📌 आकृतीचे मराठीत स्पष्टीकरण:**
  * **डावा पॅनेल:** संपूर्ण डेटाबेस व टेबलवर चालणाऱ्या मुख्य DDL कमांड्स (`CREATE`, `ALTER`, `DROP`) दाखवतो.
  * **उजवा पॅनेल (ALTER चा विस्तार):** बदल दोन स्तरांवर होतात—**डेटाबेस स्तर** (कॅरेक्टर सेट व कोलेशन बदलणे) आणि **टेबल स्तर** (नवीन कॉलम जोडणे, डेटा टाईप बदलणे, कॉलम काढणे व नियम लावणे).

---

#### Diagram 3: Descriptive Summary (Database Level vs Table Level ALTER Operations)
![Descriptive Summary of Database Level and Table Level ALTER Operations](./ddl_database_and_table_alter_descriptive_summary.svg)
* **Explanation:**
  * **Database Level (Left Panel):** Focuses on schema-wide properties—modifying default `CHARACTER SET` (e.g., `utf8mb4` for complete multilingual & emoji storage) and default `COLLATION` (e.g., `utf8mb4_unicode_ci` for case-insensitive accurate comparisons), along with the safeguard that direct `RENAME DATABASE` is disallowed in MySQL.
  * **Table Level (Right Panel):** Categorizes all table structural modifications (`ADD`, `MODIFY`, `CHANGE`, `RENAME COLUMN`, `DROP COLUMN`, `RENAME TABLE`, `CONSTRAINTS`, `DEFAULT`, and `AUTO_INCREMENT`).
* **📌 आकृतीचे मराठीत स्पष्टीकरण:**
  * **डेटाबेस स्तर (डावा पॅनेल):** भाषेचा सेट (`utf8mb4` इमोटिकॉन्स व सर्व भाषांसाठी) आणि तुलना नियम (`utf8mb4_unicode_ci`) बदलणे; तसेच MySQL मध्ये थेट डेटाबेस नाव बदलता येत नाही हा नियम दाखवतो.
  * **टेबल स्तर (उजवा पॅनेल):** टेबलमधील सर्व रचनात्मक बदल (`ADD`, `MODIFY`, `CHANGE`, `RENAME COLUMN`, `DROP COLUMN`, `CONSTRAINTS`, `AUTO_INCREMENT`) एका दृष्टिक्षेपात दर्शवतो.

---

#### Diagram 4: Detailed Comparison (DELETE vs TRUNCATE vs DROP)
![Comparison: DELETE vs TRUNCATE vs DROP](./delete_vs_drop_vs_truncate_diagram.svg)
* **Explanation:**
  * **DELETE (Blue):** Shows DML row-by-row filtering via `WHERE`, with rollback capability and preserved table structure and auto-increment counter.
  * **TRUNCATE (Amber):** Shows DDL page-level instant wipe, leaving empty table structure with counter reset to 1.
  * **DROP (Red):** Shows total structural obliteration where the table definition and all data are permanently removed.
* **📌 आकृतीचे मराठीत स्पष्टीकरण:**
  * **DELETE (निळा रंग):** DML द्वारे ओळीनुसार डेटा काढतो, `WHERE` द्वारे निवडक रेकॉर्ड्स डिलीट करता येतात, आणि चूक झाल्यास `ROLLBACK` करता येतो.
  * **TRUNCATE (पिवळा/अंबर रंग):** DDL द्वारे एका झटक्यात टेबलमधील संपूर्ण डेटा साफ करतो, टेबल रिकामे राहते, आणि आयडी काऊंटर पुन्हा १ वर येतो.
  * **DROP (लाल रंग):** संपूर्ण टेबल आणि त्याचा आराखडा कायमस्वरूपी नष्ट करतो; यानंतर टेबल शिल्लक राहत नाही.

---

### 8.14 Topic 8 Summary (मराठी सारांश)

* **SQL Version तपासणे:**
  * `SELECT VERSION();` द्वारे MySQL ची चालू आवृत्ती समजते.

* **SQL Commands चे वर्गीकरण:**
  1. **DDL (Data Definition Language):** डेटाबेस आणि टेबलचा आराखडा तयार करणे आणि बदलणे (`CREATE`, `ALTER`, `DROP`, `TRUNCATE`, `RENAME`).
  2. **DML (Data Manipulation Language):** डेटा भरणे व बदलणे (`INSERT`, `UPDATE`, `DELETE`).
  3. **DQL (Data Query Language):** डेटा शोधणे व वाचणे (`SELECT`).

* **DDL Commands चे महत्त्वाचे नियम:**
  * **Implicit Commit:** MySQL मध्ये DDL कमांड्स तात्काळ ऑटोमॅटिक सेव्ह (Commit) होतात; यांना `ROLLBACK` करता येत नाही.

* **महत्त्वाच्या DDL कमांड्स:**
  * **CREATE:** डेटाबेस किंवा DB मधील ऑब्जेक्ट्स तयार करणे (जसे की Database, Tables, Indexes, Views, Stored Procedures, Triggers, Functions).
  * **ALTER:** टेबलचे डिझाइन बदलणे:
    * `ADD`: नवीन कॉलम जोडणे (शेवटी, `FIRST`, किंवा `AFTER col`).
    * `MODIFY`: कॉलमचा डेटा टाईप किंवा साईज बदलणे.
    * `CHANGE`: कॉलमचे नाव आणि डेटा टाईप एकाच वेळी बदलणे.
    * `RENAME COLUMN`: फक्त कॉलमचे नाव बदलणे (MySQL 8.0+).
    * `DROP COLUMN`: नको असलेला कॉलम हटवणे.
    * `ADD/DROP CONSTRAINT`: Primary Key, Unique, Foreign Key, Check नियम जोडणे किंवा हटवणे.
  * **DROP:** संपूर्ण टेबल किंवा डेटाबेस त्याच्या संरचनेसह कायमस्वरूपी नष्ट करणे.
  * **TRUNCATE:** टेबलचा आराखडा तसाच ठेवून आतील सर्व डेटा एका झटक्यात साफ करणे व `AUTO_INCREMENT` १ वर रिसेट करणे.
  * **RENAME:** टेबल किंवा इतर ऑब्जेक्ट्सचे नाव बदलणे (`RENAME TABLE old TO new;`, एकाच वेळी अनेक टेबल्सची अदलाबदल करणे, डेटाबेस दरम्यान टेबल्स हलवणे, आणि कॉलम/इंडेक्सचे नाव बदलणे).

* **कन्स्ट्रेंट्स (Constraints) व नियम व्यवस्थापन सारांश:**
  1. **PRIMARY KEY:** प्रत्येक रेकॉर्डची युनिक ओळख, `NULL` चालत नाही (`ADD PRIMARY KEY`, `DROP PRIMARY KEY`).
  2. **UNIQUE:** सर्व व्हॅल्यू वेगवेगळ्या असणे बंधनकारक, यात `NULL` चालतात (`ADD CONSTRAINT ... UNIQUE`, `DROP INDEX ...`).
  3. **FOREIGN KEY:** दोन टेबल्सची जोडणी, Child डेटा Parent च्या Primary Key शी जुळणारा असावा (`ADD CONSTRAINT ... FK`, `DROP FOREIGN KEY ...`).
  4. **CHECK:** कॉलम व्हॅल्यूजची अट तपासणे (`ADD CONSTRAINT ... CHECK`, `DROP CHECK ...`).
  5. **NOT NULL:** कॉलम रिकामा ठेवण्यास सक्त मनाई (`MODIFY col datatype NOT NULL`, `MODIFY col datatype NULL`).
  6. **DEFAULT:** मूल्य न दिल्यास पूर्व-निर्धारित मूल्य भरणे (`ALTER col SET DEFAULT`, `ALTER col DROP DEFAULT`).

* **DELETE vs TRUNCATE vs DROP मधील मुख्य फरक सारांश:**
  1. **DELETE (DML):** ठराविक किंवा सर्व रो हटवणे, `WHERE` क्लॉज चालतो, `ROLLBACK` करता येतो, ऑटो-इंक्रीमेंट रिसेट होत **नाही**.
  2. **TRUNCATE (DDL):** संपूर्ण डेटा एका झटक्यात साफ करणे, टेबलचा आराखडा तसाच राहतो, ऑटो-इंक्रीमेंट **१ वर रिसेट** होते, `ROLLBACK` चालत **नाही**.
  3. **DROP (DDL):** संपूर्ण टेबल आणि त्याचा आराखडा कायमस्वरूपी नष्ट करणे, यानंतर टेबल अस्तित्वात राहत **नाही**.

* **DELETE vs TRUNCATE vs DROP तुलना आकृती:**
![Comparison: DELETE vs TRUNCATE vs DROP](./delete_vs_drop_vs_truncate_diagram.svg)

* **Database Level vs Table Level ALTER सारांश आकृती:**
![Descriptive Summary of Database Level and Table Level ALTER Operations](./ddl_database_and_table_alter_descriptive_summary.svg)

* **कन्स्ट्रेंट्स सारांश आकृती:**
![Topic 8 Constraints and DDL ALTER Summary](./topic8_constraints_and_ddl_summary.svg)

---

## Topic 9: DML (Data Manipulation Language) In-Depth

### 9.1 What is DML (Data Manipulation Language)?

* *Definition: DML (Data Manipulation Language) commands work on the **data (rows)** inside tables — adding, changing and deleting rows.*
  * **Operates on Records (Rows):** DML works strictly on the rows (records) stored in tables, **not on the table structure (schema blueprint)**.
  * **Transaction Safety (Controlled with Transactions):** Unlike DDL (which performs implicit commits in MySQL), DML operations can be controlled using **`COMMIT`** (to permanently save changes) and **`ROLLBACK`** (to undo/revert changes if an error occurs).

* **Classification of Primary DML Commands:**
  1. **`INSERT`:** Adds new data (rows/records) into a table.
  2. **`UPDATE`:** Updates or modifies existing data inside a table.
  3. **`DELETE`:** Removes data records from a table.
  4. **`REPLACE` (MySQL-specific):** Replaces a row by deleting the existing row if a duplicate key exists and inserting a new row.

![DML Operations Overview](./dml_operations_overview.svg)

---

### 9.2 The INSERT Command & Bulk Operations

* *Definition: The INSERT statement is used to insert new data or rows into an existing table.*

#### 1. Syntax for INSERT
```sql
-- Single and Multi-Row Insertion:
INSERT INTO table_name (column1, column2, column3, ...)
VALUES
    (value1, value2, value3, ...),
    (value11, value12, value13, ...),
    (value21, value22, value23, ...);
```

#### 2. Critical Rules & Best Practices for INSERT
* **Match Number of Columns and Values:** The number of values in the `VALUES` clause must match the number of specified columns.
* **Column and Value Order:** At the time of insert, ensure that values appear in the exact same order as the listed columns.
* **Matching Data Types & Constraints:** Inserted values must be compatible with the column's defined data type and satisfy all constraints (Primary Key uniqueness, Foreign Key existence, Not Null rules).
* **Optional Column Names:**
  * Specifying column names is optional. If no columns are specified, SQL expects values for all columns in the exact sequence defined in the table schema.
  * *Tip: Always list column names explicitly for clarity, maintainability, and to avoid bugs when table structure evolves.*
* **Handling Unspecified Columns:** Any column omitted from the column list automatically becomes `NULL`, unless a `DEFAULT` value or an `AUTO_INCREMENT` constraint is defined on that column.

#### 3. Standard INSERT Examples
```sql
-- Explicit Column Insertion (Best Practice):
INSERT INTO Students (id, name, age)
VALUES (1, 'Vishal', 21);

-- Multi-Row Insertion in a Single Query:
INSERT INTO Students (id, name, age)
VALUES
    (2, 'Amit', 22),
    (3, 'Neha', 20),
    (4, 'Pooja', 23);

-- Omitting Column List (Must provide values for all table columns in order):
INSERT INTO Students
VALUES (5, 'Rahul', 24);
```

![Two Methods of INSERT: Manual Entry vs INSERT Using SELECT](./insert_methods_manual_vs_select_diagram.svg)

* **Architecture & Flow Explanation (आकृतीचे सविस्तर स्पष्टीकरण):**
  * **Method ①: Manual Entry (`VALUES` Clause):**
    * **User / Developer Input:** The developer specifies literal values manually from their workstation or application code using:
      ```sql
      INSERT INTO Students (id, name, age) VALUES (1, 'Vishal', 21);
      ```
    * **Execution Flow:** MySQL receives the `INSERT ... VALUES` statement, checks the rules (constraints) and saves the new row(s) into the **Target Table**.
  * **Method ②: INSERT Using `SELECT` (Automated Query-Driven Ingestion):**
    * **Source Table Query:** An inner query (`SELECT col1, col2 FROM source_table WHERE ...`) reads rows from an existing **Source Table**.
    * **Execution Flow:** Those rows go straight into the **Target Table** using `INSERT INTO target_table SELECT ...` — no need to type the values by hand.

#### 4. How to Insert Data from One Table to Another (Source to Target Table)

* **Interview Questions:**
  * **Q. How to insert data from one table to another table (from source table to target table)?**
  * **Q. Write the SQL query to get data from the source table and insert into the target table (e.g., how to copy data from `customers` to `customers2` / `orders`)?**

You can copy data from an existing source table directly into a target table using `INSERT INTO ... SELECT`.

* **Syntax:**
  ```sql
  -- Copying specific matched columns:
  INSERT INTO target_table (col1, col2, col3, ...)
  SELECT col1, col2, col3, ...
  FROM source_table
  [WHERE condition];

  -- Copying all columns directly:
  INSERT INTO target_table
  SELECT * FROM source_table;
  ```

* **Practical Concrete Examples (Copying Customers Table):**
  ```sql
  -- Example 1: Explicit column selection from source to target
  INSERT INTO customers2 (customerid, firstname, lastname, country, score)
  SELECT customerid, firstname, lastname, country, score
  FROM customers;

  -- Example 2: Copying all columns using wildcard
  INSERT INTO customers2 (customerid, firstname, lastname, country, score)
  SELECT *
  FROM customers;

  -- Example 3: Filtered copy (only customers from India with high score)
  INSERT INTO premium_customers (customerid, firstname, country, score)
  SELECT customerid, firstname, country, score
  FROM customers
  WHERE country = 'India' AND score >= 800;
  ```
* ⚠️ **Note:** Example 2 works only if `customers` has exactly these 5 columns in the same order, because `SELECT *` must return the same number of columns as the target column list.

---

### 9.3 The UPDATE Command & Best Practices

* *Definition: The UPDATE command changes values in existing rows. It does not change the table structure.*
* **Use of UPDATE & SET:** `UPDATE` specifies the target table to be modified, while `SET` specifies the column name(s) and assigns their new values.

* **Detailed Overview & Core Characteristics (सविस्तर माहिती व वैशिष्ट्ये):**
  * **1. Row-Level / Cell-Level Data Modification:**
    * `ALTER TABLE` (DDL) changes the table's structure, but `UPDATE` only changes the data inside rows — column names, data types and constraints stay the same.
  * **2. Granular Filtering via `WHERE` Clause:**
    * You can update one row, a few rows or all rows using `WHERE`. If you forget the `WHERE` clause, **every row** in the table is updated.
  * **3. Dynamic Computations, Expressions & Subqueries:**
    * You can set a fixed value (e.g., `SET status = 'Active'`), calculate from the current value (e.g., `SET salary = salary * 1.10`, `SET score = score + 50`), or even use a subquery.
  * **4. Transactional Safety (`COMMIT` & `ROLLBACK`):**
    * In InnoDB, you can run `UPDATE` inside a transaction, check the result, and use `ROLLBACK` if it was a mistake.
  * **5. Constraint & Index Integrity:**
    * Every update is checked against the constraints (`PRIMARY KEY`, `FOREIGN KEY`, `UNIQUE`, `CHECK`, `NOT NULL`). If any rule is broken, the whole statement fails. Indexes are updated automatically.

#### 1. Syntax for UPDATE
```sql
UPDATE table_name
SET
    column1 = value1,
    column2 = value2,
    ...
WHERE condition;
```

#### 2. Features & Clauses Supported by UPDATE
* **Single or Multiple Columns:** You can update one column or multiple columns simultaneously in a single statement.
* **Combine with Advanced Clauses:** `UPDATE` can be combined with `WHERE`, `LIKE`, `IN`, `JOIN`, `ORDER BY`, and `LIMIT`.

#### 3. Practical Examples

**Q. How to update the customer's score where customer id is 4?**
```sql
UPDATE CUSTOMERS
SET SCORE = 600
WHERE CUSTOMERID = 4;
```

```sql
-- Updating multiple columns at once:
UPDATE employees
SET salary = 75000, department = 'Engineering', status = 'Promoted'
WHERE employee_id = 101;

-- Conditional update using LIKE:
UPDATE customers
SET score = score + 50
WHERE country LIKE 'Ind%';

-- Conditional update using IN:
UPDATE products
SET discount = 15
WHERE category_id IN (1, 3, 5);

-- Conditional update using JOIN (Cross-Table Update):
UPDATE employees e
JOIN departments d ON e.dept_id = d.dept_id
SET e.salary = e.salary * 1.15
WHERE d.dept_name = 'Research & Development';

-- Update with ORDER BY and LIMIT (Safe Batch / Top-N Updates in MySQL):
-- Increase scores for only the bottom 5 lowest-scoring customers in India:
UPDATE customers
SET score = score + 20
WHERE country = 'India'
ORDER BY score ASC
LIMIT 5;
```

#### 4. Critical Warnings & Best Practices
> ⚠️ **CRITICAL WARNING:**
> **Always use a WHERE clause in an UPDATE statement!**
> Without a `WHERE` clause, **ALL rows in the table will be updated unconditionally**.
>
> 💡 **Industry Best Practice:**
> Always verify your criteria first by running a `SELECT` query with the exact same `WHERE` clause before executing the `UPDATE`.
> ```sql
> -- Step 1: Verify the rows to be modified:
> SELECT * FROM customers WHERE customerid = 4;
>
> -- Step 2: Once verified, execute the UPDATE:
> UPDATE customers SET score = 600 WHERE customerid = 4;
> ```

---

### 9.4 The DELETE Command & Safe Execution

* *Definition: DELETE removes some rows (or all rows) from a table. The table structure, columns, constraints and indexes stay the same.*
* **Role of DELETE FROM & WHERE:** `DELETE FROM table_name` specifies the target table, while the `WHERE condition` identifies the exact records to be deleted. By default, standard SQL `DELETE` performs a **hard delete** (physical removal from the table).

* **Detailed Overview & Core Characteristics (सविस्तर माहिती व वैशिष्ट्ये):**
  * **1. Row-by-Row Removal (Record-Level Action):**
    * `DROP` removes the whole table and `TRUNCATE` empties it in one go, but `DELETE` (a DML command) removes rows **one by one** and logs each one, so it can be rolled back.
  * **2. Granular Filtering with `WHERE` Clause:**
    * Supports fine-grained row selection using conditions (`=`, `!=`, `<`, `>`, `LIKE`, `IN`, `BETWEEN`). If the `WHERE` clause is omitted, **all records in the table will be deleted**.
  * **3. Transaction Safety & Rollback:**
    * In InnoDB, you can run `DELETE` inside a transaction (`START TRANSACTION`). If you delete something by mistake, run `ROLLBACK` before `COMMIT` to get the rows back.
  * **4. Foreign Key & Referential Integrity Enforcement:**
    * Checks related child tables before deletion (`ON DELETE RESTRICT`, `CASCADE`, or `SET NULL`). If a child table holds dependent records and is protected by `RESTRICT`, the deletion will be rejected to prevent orphan records.
  * **5. Trigger Activation:**
    * Fires `BEFORE DELETE` and `AFTER DELETE` database triggers on each affected row, which is essential for audit logging and archival workflows.
  * **6. Auto-Increment Preservation:**
    * Unlike `TRUNCATE`, running `DELETE` (even without a `WHERE` clause) does **not** reset the `AUTO_INCREMENT` sequence counter in MySQL.

#### 1. Syntax for DELETE
```sql
DELETE FROM table_name
WHERE condition;
```

#### 2. Practical Examples
```sql
-- Delete customer records where country is India:
DELETE FROM customers
WHERE country = 'India';

-- Delete customer records where score is 999:
DELETE FROM CUSTOMERS
WHERE SCORE = 999;
```

#### 3. Critical Safety Rules
* **Avoid `DELETE` without a `WHERE` clause:** Executing `DELETE FROM table_name;` without a `WHERE` clause will wipe out all records in the table.
* **Verify with `SELECT` first:** Run `SELECT * FROM table_name WHERE condition;` prior to running the delete to inspect the exact rows that will be eliminated.

---

### 9.5 MySQL Safe Update Mode (`SQL_SAFE_UPDATES`)

* *Definition: Safe update mode (SQL_SAFE_UPDATES) is a MySQL setting that blocks UPDATE and DELETE statements that could accidentally change the whole table.*
* **Enforcement Rules (कधी आणि कसे लागू होते?):**
  * When safe mode is enabled, MySQL **does not allow** an `UPDATE` or `DELETE` statement unless:
    1. The `WHERE` clause uses a **key column** (such as a **Primary Key** or an **Indexed column**).
    2. **OR** the statement includes a **`LIMIT`** clause.

#### 1. Error Analysis: Why Non-Key Deletes Fail
If you run:
```sql
DELETE FROM customers WHERE SCORE = 999;
```
MySQL triggers an error:
```
Error Code: 1175. You are using safe update mode and you tried to update a table without a WHERE that uses a KEY column.
To disable safe mode, toggle the option in Preferences -> SQL Editor and reconnect.
```
* **Why this happens:** `SCORE` is not a Primary Key or indexed column, so MySQL blocks the command to protect you from deleting many rows by mistake.

#### 2. How to Handle Safe Mode (Two Approaches)

##### Approach A: Use a Key Column in WHERE or Add LIMIT (Best Practice)
* **Example (Not Allowed in Safe Mode):**
  ```sql
  DELETE FROM employees;
  -- Reason: This statement attempts to delete all rows because it lacks both a WHERE clause and a LIMIT clause.
  ```
* **Example (Allowed in Safe Mode):**
  ```sql
  -- Allowed: Using the Primary Key / Indexed column:
  DELETE FROM employees WHERE employee_id = 101;
  DELETE FROM customers WHERE customer_id = 101;

  -- Allowed: Using a LIMIT clause:
  DELETE FROM employees LIMIT 1;
  DELETE FROM customers WHERE score = 999 LIMIT 1;
  ```

##### Approach B: Temporarily Toggle Safe Mode for Current Session
If you genuinely need to perform a bulk delete/update on a non-key column:
```sql
-- Step 1: Temporarily disable safe mode in current session (0 = Disabled / OFF)
SET SQL_SAFE_UPDATES = 0;

-- Step 2: Execute your bulk query safely
DELETE FROM customers WHERE score = 999;
DELETE FROM customers WHERE score = 350;

-- Step 3: Immediately re-enable safe mode (1 = Enabled / ON)
SET SQL_SAFE_UPDATES = 1;
```

* **Interview Answer Summary:**
  > "MySQL Safe Mode (`SQL_SAFE_UPDATES`) is a safety feature that prevents accidental mass `UPDATE` and `DELETE` operations. It requires a `WHERE` clause using a key column (such as a Primary Key or indexed column) or a `LIMIT` clause. This helps protect data from unintended modifications or deletions."

---

### 9.6 Soft Delete vs Hard Delete (In-Depth Comparison)

![Hard Delete vs Soft Delete](./soft_delete_vs_hard_delete_diagram.svg)

#### 1. Detailed 9-Point Comparison Matrix

| Feature / Dimension | Hard Delete (कठोर/भौतिक हटवणे) | Soft Delete (तार्किक हटवणे) |
| :--- | :--- | :--- |
| **1. Meaning** | Data is permanently and physically removed from disk | Data is not physically removed; it is only marked as deleted using a status flag |
| **2. Data Recovery** | Cannot be recovered unless a database backup is available | Easily restored by changing the status flag back to active |
| **3. How It Works** | Removes the actual row records from the storage pages | Updates a flag or timestamp column to indicate deletion |
| **4. SQL Command** | Executed using **`DELETE`** or **`TRUNCATE`** | Executed using **`UPDATE`** (`SET is_deleted = 1`) |
| **5. Storage Usage** | Uses less storage because deleted records are cleared | Uses more storage because deleted records remain in the table indefinitely |
| **6. Query Performance** | Generally faster; fewer records remain to scan and index | Queries may require filtering index checks (`WHERE is_deleted = 0`) |
| **7. Data History & Audit** | Historical data is permanently lost | Maintains complete audit history and allows tracking of who deleted what and when |
| **8. Implementation** | No extra table columns required | Requires additional columns like `is_deleted`, `deleted_at`, or `status` |
| **9. Common Use Cases** | Temporary data, cache tables, compliance data removal (GDPR) | Banking, e-commerce orders, user accounts, audit-heavy enterprise apps |

#### 2. Practical Implementation of Soft Delete
```sql
-- Step 1: Add soft delete tracking columns to the table
ALTER TABLE customers
ADD COLUMN is_deleted TINYINT(1) DEFAULT 0,
ADD COLUMN deleted_at DATETIME NULL;

-- Step 2: Perform a "Soft Delete" (UPDATE instead of DELETE)
UPDATE customers
SET is_deleted = 1, deleted_at = NOW()
WHERE customer_id = 101;

-- Step 3: Query active records (Exclude soft-deleted rows)
SELECT * FROM customers
WHERE is_deleted = 0;

-- Step 4: Restore / Undelete a record
UPDATE customers
SET is_deleted = 0, deleted_at = NULL
WHERE customer_id = 101;
```

---

### 9.7 Foreign Key Referential Actions (Complete Guide)

#### 1. What is Referential Integrity?
* *Definition: Referential Integrity means links between tables always stay valid — a child row can never point to a parent row that doesn't exist.*
* It prevents **child records from pointing to non-existing parent records**.
* It prevents **invalid or orphan data** (अनाथ रेकॉर्ड्स प्रतिबंध).

#### 2. What is a Referential Action?
* *Definition: A Referential Action instructs MySQL: "If a parent row is UPDATED or DELETED, what should automatically happen to the related child rows?"*
This action is defined directly inside the Foreign Key constraint clause:
```sql
FOREIGN KEY (department_id)
REFERENCES department(department_id)
ON DELETE CASCADE
ON UPDATE CASCADE;
```

#### 3. The 5 Types of Referential Actions
1. **`CASCADE`:** Automatically deletes or updates child rows when parent is deleted or updated.
2. **`RESTRICT` (MySQL Default):** Prevents deletion or modification of a parent row if matching child rows exist.
3. **`NO ACTION`:** Exactly the same as `RESTRICT` in MySQL. (Technically `NO ACTION` is the default keyword, but in MySQL both behave the same.)
4. **`SET NULL`:** Sets child foreign key columns to `NULL` when parent row is deleted or updated (requires column to be nullable).
5. **`SET DEFAULT`:** Sets child foreign key to its defined default value (*Note: MySQL's InnoDB engine does not support `SET DEFAULT` for foreign keys*).

![Foreign Key Referential Actions](./foreign_key_referential_actions_diagram.svg)

---

#### 4. Deep-Dive: `ON DELETE CASCADE`
* *Definition: ON DELETE CASCADE is a referential action used with foreign key constraints. When a row in the parent table is deleted, MySQL automatically deletes all related rows from the child table.*
* **Purpose:** Maintains referential integrity and prevents orphan records ("अनाथ (संबंध तुटलेले) रेकॉर्ड तयार होण्यापासून प्रतिबंध करते").
* **What happens WITHOUT `ON DELETE CASCADE`?**
  * If not specified, MySQL defaults to `RESTRICT`.
  * Deleting the parent row will fail with `ERROR 1451 (23000): Cannot delete or update a parent row: a foreign key constraint fails`.
  * You must first manually delete all child records before deleting the parent record.

* **Complete Executable SQL Demonstration:**
  ```sql
  -- Step 1: Create Parent Table (department)
  DROP TABLE IF EXISTS employee;
  DROP TABLE IF EXISTS department;

  CREATE TABLE department (
      department_id INT PRIMARY KEY,
      department_name VARCHAR(50) NOT NULL
  );

  -- Step 2: Create Child Table (employee) with ON DELETE CASCADE
  CREATE TABLE employee (
      emp_id INT PRIMARY KEY,
      emp_name VARCHAR(50) NOT NULL,
      department_id INT,
      CONSTRAINT fk_dept
          FOREIGN KEY (department_id) REFERENCES department(department_id)
          ON DELETE CASCADE
          ON UPDATE CASCADE
  );

  -- Step 3: Insert Sample Data
  INSERT INTO department VALUES (1, 'HR'), (2, 'Engineering');
  INSERT INTO employee VALUES (101, 'Amit', 1), (102, 'Neha', 1), (103, 'Rahul', 2);

  -- Inspect before deletion
  SELECT * FROM department;
  SELECT * FROM employee;

  -- Step 4: Delete Parent Record (department_id = 1)
  DELETE FROM department WHERE department_id = 1;

  -- Step 5: Verify Cascade Deletion
  -- Notice Amit and Neha are AUTOMATICALLY deleted from employee table!
  SELECT * FROM employee;
  ```

* **Step-by-Step Point-Wise Breakdown of the ON DELETE CASCADE Example:**
  * **Point 1 (Parent Table Definition):** Table `department` is created with `department_id` as the primary key.
  * **Point 2 (Child Foreign Key with CASCADE):** Table `employee` is created with `CONSTRAINT fk_dept FOREIGN KEY (department_id) REFERENCES department(department_id) ON DELETE CASCADE`.
  * **Point 3 (Data Seeding):** Department `1` ('HR') is created, and two employees (`101` Amit, `102` Neha) are assigned to Department `1`.
  * **Point 4 (Parent Deletion):** Running `DELETE FROM department WHERE department_id = 1;` removes the parent record.
  * **Point 5 (Automatic Cascade Purge):** Because `ON DELETE CASCADE` is active, MySQL automatically and immediately deletes Amit and Neha from `employee`. Querying `employee` confirms that no orphan records remain.
  * **Point 6 (Without Cascade Behavior):** Without `ON DELETE CASCADE` (under default `RESTRICT`), deleting department 1 fails with `ERROR 1451 (23000)`. You are required to run a manual 2-step deletion (delete child rows first, then delete parent).

* **What happens without Cascade? (Demonstration of Error 1451):**
  ```sql
  -- Suppose employee was created without ON DELETE CASCADE (Default RESTRICT):
  DELETE FROM department WHERE department_id = 1;
  -- Output: ERROR 1451 (23000): Cannot delete or update a parent row: a foreign key constraint fails

  -- To delete under RESTRICT, you MUST manually delete child records first:
  DELETE FROM employee WHERE department_id = 1;
  DELETE FROM department WHERE department_id = 1;
  ```

* **Interview Answer (ON DELETE CASCADE):**
  > "ON DELETE CASCADE is a referential action used with foreign keys. When a parent row is deleted, MySQL automatically deletes all related child rows. This maintains referential integrity and prevents orphan records (\"अनाथ (संबंध तुटलेले) रेकॉर्ड तयार होण्यापासून प्रतिबंध करते\" — Child table मधील असा डेटा ज्याचा Parent table मध्ये संबंधित रेकॉर्ड उरलेला नाही, असा डेटा तयार होऊ देत नाही). Without ON DELETE CASCADE, you must manually delete the child records before deleting the parent record."

---

#### 5. Deep-Dive: `ON UPDATE CASCADE`
* *Definition: ON UPDATE CASCADE automatically updates the foreign key values in the child table whenever the referenced primary key in the parent table is updated.*
* **Purpose:** Keeps parent and child records continuously synchronized.
* **What happens WITHOUT `ON UPDATE CASCADE`?**
  * Changing a parent's primary key would fail under default `RESTRICT` because existing child rows would point to an invalid key. You would have to manually update child tables first.

* **Complete Executable Demonstration:**
  ```sql
  -- Ensure tables are ready with ON UPDATE CASCADE:
  -- (department and employee created above)

  -- Temporarily disable safe mode if updating by name:
  SET SQL_SAFE_UPDATES = 0;

  -- Update Parent Primary Key (change HR department_id from 1 to 101):
  UPDATE department
  SET department_id = 101
  WHERE department_name = 'HR';

  SET SQL_SAFE_UPDATES = 1;

  -- Verify Child Table:
  -- Notice Amit and Neha's department_id is automatically updated to 101!
  SELECT * FROM employee;
  ```

* **Step-by-Step Point-Wise Breakdown of the ON UPDATE CASCADE Example:**
  * **Point 1 (Parent Key Modification):** Department `1` ('HR') needs to have its primary key changed from `1` to `101`.
  * **Point 2 (Automatic Key Synchronization):** MySQL detects the parent primary key modification and automatically updates `employee.department_id` from `1` to `101` for both Amit and Neha.
  * **Point 3 (Verification & Data Integrity):** Running `SELECT * FROM employee;` shows Amit and Neha now reference `department_id = 101`. No manual update on `employee` was required, and referential integrity remained unbroken.
  * **Point 4 (Without Update Cascade Behavior):** Without `ON UPDATE CASCADE`, MySQL defaults to `RESTRICT` and aborts the primary key update with `ERROR 1451 (23000)`. You would be forced to manually update the child table foreign keys before modifying the parent primary key.

* **Interview Questions & Answers (ON UPDATE CASCADE):**
  * **Q. What is ON UPDATE CASCADE?**
    * **Answer:** ON UPDATE CASCADE is a referential action used in a foreign key constraint. When the primary key value in the parent table changes, MySQL automatically updates the corresponding foreign key values in the child table, maintaining referential integrity and keeping related data synchronized.
  * **Q. Why do we use ON UPDATE CASCADE?**
    * **Answer:** We use ON UPDATE CASCADE to avoid manually updating child table records whenever a parent table's primary key changes. It ensures data consistency and prevents broken relationships between parent and child tables.

---

#### 6. Summary Matrix of Referential Actions

| Action Type | Behavior on Parent Deletion (`ON DELETE`) | Behavior on Parent Update (`ON UPDATE`) | Best Use Case |
| :--- | :--- | :--- | :--- |
| **`CASCADE`** | Automatically deletes all related child rows | Automatically updates related child foreign keys | Child data has no standalone meaning without parent (e.g., Order Items $\rightarrow$ Order) |
| **`RESTRICT` (DEFAULT)**| Blocks parent deletion if child records exist | Blocks parent primary key update if child records exist | Strong data protection required; prevents accidental loss |
| **`NO ACTION`** | Same as `RESTRICT` in MySQL (blocks deletion) | Same as `RESTRICT` in MySQL (blocks update) | Standard ANSI compliance |
| **`SET NULL`** | Sets child foreign key column to `NULL` (Child remains) | Sets child foreign key column to `NULL` | Child can exist independently (e.g., Employee retains job if Department is deleted) |
| **`SET DEFAULT`** | Sets child foreign key to default value | Sets child foreign key to default value | *Rare in MySQL; NOT supported by InnoDB engine* |

![Summary Matrix of Referential Actions in MySQL](./referential_actions_summary_matrix_diagram.svg)

* **Detailed Point-Wise Breakdown & Architectural Use Cases (सविस्तर स्पष्टीकरण व नियम):**
  * **1. `ON DELETE CASCADE`:**
    * **Behavior:** When a parent row is deleted, all related child rows are deleted automatically.
    * **Use Case:** Used when child data has no meaning without the parent (e.g., deleting an `orders` record automatically purges all corresponding `order_items`).
  * **2. `ON UPDATE CASCADE`:**
    * **Behavior:** When the parent primary key is updated, the child foreign key values are updated automatically.
    * **Use Case:** Used when parent key values may change over time and child records must remain continuously synchronized.
  * **3. `ON DELETE SET NULL`:**
    * **Behavior:** When the parent row is deleted, the child foreign key is set to `NULL` so the child record remains intact.
    * **Use Case:** Used when a child entity can exist without a parent (e.g., an `employee` retains their record when a `department` is dissolved).
    * **Prerequisite:** The child foreign key column **must allow `NULL` values** (must not be defined as `NOT NULL`).
  * **4. `ON DELETE RESTRICT` (MySQL Default):**
    * **Behavior:** Parent deletion is strictly blocked with `Error 1451` if any related child records exist.
    * **Use Case:** Used when strong data protection is required to safeguard against unintended deletions. You must manually delete child rows first before deleting the parent record.
  * **5. `ON DELETE NO ACTION`:**
    * **Behavior:** Exactly the same as `RESTRICT` in MySQL InnoDB. Deletion is prevented if child rows exist.
    * **Use Case:** Standard ANSI SQL compliance.
  * **6. `ON DELETE SET DEFAULT` (Rare in MySQL):**
    * **Behavior:** If the parent row is deleted, the child foreign key is set to its predefined default value.
    * **Critical Engine Note:** MySQL's **InnoDB storage engine does NOT support `SET DEFAULT`** for foreign keys. If specified, it is rejected with a syntax error or treated as `RESTRICT`/`NO ACTION`.

---

### 9.8 The REPLACE Command in SQL (MySQL Specific)

#### 1. What is the REPLACE Command?
* *Definition: REPLACE is a MySQL-only version of INSERT. If a row with the same key already exists, MySQL deletes that row and then inserts the new one.*
* **If a row already exists** (with the exact same `PRIMARY KEY` or `UNIQUE KEY` value), MySQL **first deletes the old row** and then **inserts the new row**.
* **If no duplicate key exists**, it behaves exactly like a standard `INSERT` statement.
* **Formula:**
  $$\text{REPLACE} = \text{DELETE (Old Row)} + \text{INSERT (New Row)}$$

#### 2. Crucial Requirements for REPLACE
* **Requires Key:** `REPLACE` works only if the table has a defined `PRIMARY KEY` or `UNIQUE INDEX`. Without keys, MySQL cannot detect conflicts and will always execute a normal insert.

#### 3. Practical Code Examples
```sql
-- Step 1: Normal Insert
INSERT INTO customers (id, first_name, country, score)
VALUES (6, 'Vishal', 'India', 999);

-- Step 2: REPLACE when duplicate key exists (id = 6 already exists):
-- Result: MySQL deletes old row (Vishal, India, 999) and inserts new row (Ram, India, 888)
REPLACE INTO customers (id, first_name, country, score)
VALUES (6, 'Ram', 'India', 888);

-- Step 3: REPLACE when key does not exist:
-- Result: Inserts as a new record
REPLACE INTO customers (id, first_name, country, score)
VALUES (7, 'Vishal', 'India', 999);
```

#### 4. Differences: UPDATE vs REPLACE INTO

| Dimension | `UPDATE` | `REPLACE INTO` |
| :--- | :--- | :--- |
| **Operation Type** | Modifies existing row in-place | **Deletes** old row, then **Inserts** new row |
| **Key Conflict** | Requires key to locate; does not delete | If key exists, deletes old record first |
| **Non-Existing Key** | Returns 0 rows affected (does not insert) | Inserts as a brand new row |
| **Trigger Execution** | Fires `UPDATE` triggers only | Fires **both `DELETE` and `INSERT` triggers** |
| **Performance** | Faster (in-place modification) | Slightly slower (two-step delete + insert cycle) |
| **AUTO_INCREMENT** | Does not affect auto_increment | May cause auto-increment counter to advance |

#### 5. **Q. What is the difference between REPLACE and INSERT ... ON DUPLICATE KEY UPDATE?**

![REPLACE INTO vs INSERT ON DUPLICATE KEY UPDATE](./replace_vs_on_duplicate_key_update.svg)

* **Key Concepts & Rules (नियम व फरक):**
  * **`ON DUPLICATE KEY UPDATE`:**
    * **When Key Exists:** If data is already present with a `PRIMARY KEY` or `UNIQUE KEY`, it **modifies the existing record in-place**.
    * **When Key Does Not Exist:** If the record is not present, it **inserts a brand new record**.
    * **No Deletion:** It does **NOT delete** any record like `REPLACE INTO`.
    * **Column Preservation:** Preserves all other existing column values that are not specified in the `UPDATE` clause.
  * **`REPLACE INTO`:**
    * **When Key Exists:** If the record is already present with a `PRIMARY KEY` or `UNIQUE KEY`, **first the old record is physically DELETED**, and then a **new record is INSERTED** into the table.
    * **Column Reset Warning:** Any column omitted from the `REPLACE INTO` statement will lose its existing value and revert to `NULL` or its column default!

* **Practical SQL Code Demonstration (From Workbench Examples):**
  ```sql
  -- =========================================================================
  -- 1. INSERT ... ON DUPLICATE KEY UPDATE
  -- If data is already present with PRIMARY KEY or UNIQUE KEY, modify existing data.
  -- If record is not present, insert new record.
  -- It does NOT delete any record like REPLACE INTO.
  -- It modifies the record if already present; otherwise creates a new record.
  -- =========================================================================
  INSERT INTO CUSTOMERS
  VALUES (8, 'DEF', 'IND', 800)
  ON DUPLICATE KEY UPDATE FIRST_NAME = 'SHINDE';

  -- =========================================================================
  -- 2. REPLACE INTO
  -- If the record is present with PRIMARY KEY,
  -- first the existing record is DELETED, and then a new record is INSERTED.
  -- =========================================================================
  REPLACE INTO CUSTOMERS
  VALUES (6, 'SHINDE...', 'UK', 890);
  ```

* **Standard Example for User Profiles:**
  ```sql
  -- Updating an existing user without wiping their profile data:
  INSERT INTO users (id, name, email)
  VALUES (1, 'Alicia', 'alicia@example.com')
  ON DUPLICATE KEY UPDATE name = 'Alicia';
  ```

---

### 9.9 Comparison: ALTER Command vs UPDATE Command

| Feature / Dimension | `ALTER` Command | `UPDATE` Command |
| :--- | :--- | :--- |
| **1. Command Category** | **DDL** (Data Definition Language) | **DML** (Data Manipulation Language) |
| **2. Target of Operation** | Works on **Table Structure / Blueprint** | Works on **Data Values / Rows** |
| **3. Core Action** | Adds, deletes, or changes columns, constraints, data types | Modifies contents of existing rows |
| **4. Default Initialization** | Initializes new columns for all existing rows as `NULL` (or default) | Sets specific fixed cell values according to `SET` clause |
| **5. Transaction Control** | **Implicit Commit** (Cannot rollback in MySQL) | **Transaction Controlled** (Can rollback before commit) |
| **6. Summary Purpose** | Alters the **definition** of the database object | Modifies the **actual data** inside the table |

---

### 9.10 Visual Diagrams & Architectural Explanations

#### Diagram 1: DML Operations Overview (INSERT, UPDATE, DELETE, REPLACE)
![DML Operations Overview](./dml_operations_overview.svg)
* **Explanation:**
  * Illustrates how DML commands interact directly with table rows inside the storage engine.
  * Demonstrates the transaction safety net (`COMMIT` vs `ROLLBACK`) available exclusively to DML operations.
* **📌 आकृतीचे मराठीत स्पष्टीकरण:**
  * DML ऑपरेशन्स (`INSERT`, `UPDATE`, `DELETE`, `REPLACE`) थेट टेबलमधील डेटा ओळींवर (Rows) काम करतात.
  * या बदलांना ट्रान्झॅक्शनची सुरक्षा असते; म्हणजे बदल कायम ठेवण्यासाठी `COMMIT` आणि चूक झाल्यास पूर्ववत करण्यासाठी `ROLLBACK` ची सुविधा मिळते.

---

#### Diagram 2: Soft Delete vs Hard Delete Architecture
![Hard Delete vs Soft Delete](./soft_delete_vs_hard_delete_diagram.svg)
* **Explanation:**
  * Compares physical record wiping from disk pages (Hard Delete) against state updates using logical flag columns like `is_deleted` or timestamps (Soft Delete).
  * Outlines recovery, storage, performance, and compliance implications.
* **📌 आकृतीचे मराठीत स्पष्टीकरण:**
  * **Hard Delete (डावी बाजू):** डेटा हार्ड डिस्कवरून कायमचा नष्ट होतो; नंतर डेटा रिकव्हर करणे अशक्य असते.
  * **Soft Delete (उजवी बाजू):** प्रत्यक्ष डेटा नष्ट न करता फक्त `is_deleted = 1` हा फ्लॅग बदलला जातो. डेटा ॲप्लिकेशनला दिसत नाही, पण डेटाबेसमध्ये सुरक्षित राहतो आणि भविष्यात रिस्टोअर करता येतो.

---

#### Diagram 3: Foreign Key Referential Actions (CASCADE, RESTRICT, SET NULL)
![Foreign Key Referential Actions](./foreign_key_referential_actions_diagram.svg)
* **Explanation:**
  * Visualizes Parent table (`department`) and Child table (`employee`) relationships.
  * Shows how `CASCADE` propagates changes automatically, `RESTRICT` blocks destructive operations to protect integrity, and `SET NULL` disassociates relationships while preserving child entities.
* **📌 आकृतीचे मराठीत स्पष्टीकरण:**
  * **CASCADE:** पालक (Parent) रेकॉर्ड डिलीट किंवा अपडेट झाल्यास बाल (Child) रेकॉर्ड्स आपोआप डिलीट/अपडेट होतात.
  * **RESTRICT (डिफॉल्ट):** जोपर्यंत संबंधित चाइल्ड रेकॉर्ड्स अस्तित्वात आहेत, तोपर्यंत पालकाला डिलीट करण्यास बंदी असते.
  * **SET NULL:** पालक डिलीट झाल्यावर चाइल्ड रेकॉर्ड्स राहतात, फक्त त्यांची फॉरेन की व्हॅल्यू `NULL` होते.

---

#### Diagram 4: Two Methods of INSERT Operations (Manual Values vs. INSERT Using SELECT)
![Two Methods of INSERT](./insert_methods_manual_vs_select_diagram.svg)
* **Explanation:**
  * Contrasts manual interactive row insertion using explicit literal values via `INSERT INTO ... VALUES` with automated, bulk query ingestion via `INSERT INTO ... SELECT`.
  * Details how the intermediate result set from a source table query is directly transformed and populated into the destination target table.
* **📌 आकृतीचे मराठीत स्पष्टीकरण:**
  * **पद्धत १ (मॅन्युअल इनसर्ट):** `VALUES (...)` द्वारे एका वेळी एक किंवा काही नोंदी हाताने भरणे.
  * **पद्धत २ (SELECT द्वारे बल्क इनसर्ट):** दुसऱ्या टेबलमधील हजारो नोंदी क्वेरी करून थेट टार्गेट टेबलमध्ये एका सेकंदात कॉपी करणे (`INSERT INTO target SELECT * FROM source`).

---

#### Diagram 5: Foreign Key Referential Actions Summary Decision Matrix
![Summary Decision Matrix](./referential_actions_summary_matrix_diagram.svg)
* **Explanation:**
  * Comprehensive 6-card visual decision matrix outlining behavioral differences and use cases for `CASCADE`, `RESTRICT`, `SET NULL`, `NO ACTION`, and `SET DEFAULT`.
  * Highlights why InnoDB rejects `SET DEFAULT` and how default `RESTRICT` guards against unintended cascading data purges.
* **📌 आकृतीचे मराठीत स्पष्टीकरण:**
  * सर्व ५ फॉरेन की नियमांचे तुलनात्मक कार्ड्स—CASCADE (स्वयंचलित पाठपुरावा), RESTRICT (डेटाचे संरक्षण), SET NULL (अनाथ न करता संबंध तोडणे), NO ACTION (RESTRICT प्रमाणेच), आणि SET DEFAULT (InnoDB द्वारे अस्वीकृत).

---

#### Diagram 6: REPLACE INTO vs. INSERT ... ON DUPLICATE KEY UPDATE
![REPLACE INTO vs ON DUPLICATE KEY UPDATE](./replace_vs_on_duplicate_key_update.svg)
* **Explanation:**
  * Visualizes the two distinct conflict-resolution pathways in MySQL.
  * Shows how `REPLACE` physically drops and reinserts entire rows versus how `ON DUPLICATE KEY UPDATE` mutates target cells in-place while keeping existing row data intact.
* **📌 आकृतीचे मराठीत स्पष्टीकरण:**
  * **REPLACE INTO (डावी बाजू):** की चा वाद झाल्यास जुनी संपूर्ण रो थेट नष्ट करून (`DELETE`) नवीन रो नव्याने टाकतो (`INSERT`), ज्यामुळे न नमूद केलेले कॉलम्स डीफॉल्ट/नुल होतात.
  * **ON DUPLICATE KEY UPDATE (उजवी बाजू):** मूळ रो तशीच ठेवून फक्त सांगितलेल्या ठराविक कॉलम्सचे मूल्य बदलतो, इतर डेटा सुरक्षित राहतो.

---

### 9.11 Topic 9 Summary (मराठी सारांश)

* **DML (Data Manipulation Language) ची व्याख्या:**
  * DML चा उपयोग टेबलच्या संरचनेवर (Structure) नाही, तर टेबलमधील **डेटा / रो (Records)** वर प्रक्रिया करण्यासाठी होतो.
  * DML ऑपरेशन्स ट्रान्झॅक्शनद्वारे नियंत्रित असतात; यामध्ये `COMMIT` करून डेटा कायम सेव्ह करता येतो किंवा चूक झाल्यास `ROLLBACK` करून पूर्ववत करता येतो.

* **महत्त्वाच्या DML कमांड्स व त्यांचे कार्य:**
  1. **INSERT:** टेबलमध्ये नवीन रो जोडणे.
      * `INSERT INTO table (cols) VALUES (...);`
      * `INSERT INTO target SELECT * FROM source;` द्वारे एका टेबलमधील डेटा दुसऱ्या टेबलमध्ये कॉपी करता येतो.
  2. **UPDATE:** अस्तित्वात असलेल्या रेकॉर्ड्समधील मूल्ये बदलणे.
      * `UPDATE table SET col = val WHERE condition;`
      * **महत्त्वाची खबरदारी:** `WHERE` क्लॉज न वापरल्यास टेबलमधील सर्वच्या सर्व रेकॉर्ड्स बदलले जातात!
  3. **DELETE:** टेबलमधील नको असलेला डेटा हटवणे.
      * `DELETE FROM table WHERE condition;`
      * हा हार्ड डिलीट (Hard Delete) करतो.

* **MySQL Safe Update Mode (`SQL_SAFE_UPDATES`):**
  * चुकून सर्व डेटा डिलीट किंवा अपडेट होण्यापासून वाचवण्यासाठी MySQL मध्ये सेफ मोड असतो.
  * यासाठी `WHERE` मध्ये Primary Key किंवा इंडेक्स कॉलम असणे आवश्यक असते.
  * सेशनपुरता बंद करण्यासाठी: `SET SQL_SAFE_UPDATES = 0;` व पुन्हा चालू करण्यासाठी: `SET SQL_SAFE_UPDATES = 1;`.

* **Soft Delete विरुद्ध Hard Delete:**
  * **Hard Delete:** डेटा कायमस्वरूपी डिस्कवरून नष्ट होतो; रिकव्हरी शक्य नसते (`DELETE`).
  * **Soft Delete:** डेटा प्रत्यक्ष नष्ट होत नाही, फक्त `is_deleted = 1` हा फ्लॅग बदलला जातो (`UPDATE`). डेटा सुरक्षित राहतो व ऑडिटसाठी वापरता येतो.

* **फॉरेन की आणि रेफरेंशियल अ‍ॅक्शन्स (Referential Actions):**
  * **Referential Integrity:** Parent आणि Child टेबल्समधील संबंध वैध ठेवणे व अनाथ रेकॉर्ड्स (Orphan Records) तयार होण्यास प्रतिबंध करणे.
  * **ON DELETE CASCADE:** Parent रो डिलीट झाल्यास Child मधील संबंधित सर्व रो आपोआप डिलीट होतात.
  * **ON UPDATE CASCADE:** Parent ची Primary Key बदलल्यास Child ची Foreign Key आपोआप बदलून सिंक्रोनाईज होते.
  * **ON DELETE RESTRICT (Default):** जोपर्यंत Child रेकॉर्ड्स अस्तित्वात आहेत, तोपर्यंत Parent डिलीट करण्यास सक्त मज्जाव (Error 1451).
  * **ON DELETE SET NULL:** Parent डिलीट झाल्यावर Child मधील Foreign Key `NULL` होते.

* **REPLACE INTO कमांड (MySQL):**
  * `REPLACE = DELETE (जुनी रो) + INSERT (नवी रो)`.
  * Primary Key किंवा Unique Key चा संघर्ष झाल्यास जुनी रो काढून नवीन रो टाकतो; संघर्ष नसल्यास सामान्य `INSERT` सारखा चालतो.
  * `INSERT ... ON DUPLICATE KEY UPDATE` मात्र जुनी रो न हटवता फक्त ठराविक कॉलम अपडेट करतो.

* **ALTER विरुद्ध UPDATE फरक:**
  * **ALTER (DDL):** टेबलची रचना, कॉलम, डेटा टाईप आणि नियम बदलतो (Implicit Commit).
  * **UPDATE (DML):** टेबलच्या संरचनेत बदल न करता फक्त आतील सेल व्हॅल्यूज/डेटा बदलतो (Rollback शक्य).

---

## Topic 10: DQL (Data Query Language) & Data Retrieval

### 10.1 What is DQL (Data Query Language)?

* *Definition: DQL (Data Query Language) is used to read data from tables. It never changes the data or the table structure.*
  * The primary command of DQL is **`SELECT`**.

* **Key Characteristics of DQL:**
  * **1. Read-Only Nature:** DQL only reads data; it never inserts, changes or deletes anything.
  * **2. Tabular Result Set (Virtual Table):** Every `SELECT` query returns results structured into rows and columns, known as a **Result Set**.
  * **3. Extreme Flexibility:** Can retrieve everything, target specific columns, filter rows (`WHERE`), sort results (`ORDER BY`), aggregate metrics (`GROUP BY`, `COUNT`, `SUM`), and join across multiple related tables (`JOIN`).

---

### 10.2 Two Fundamental Ways to Retrieve Data via SELECT

You can select or retrieve data in two primary ways:

#### 1. Method ①: Get Whole Data from the Table (All Columns via Wildcard `*`)
* **Q. How to get whole data from the customers table?**
* **SQL Query:**
  ```sql
  SELECT * FROM CUSTOMERS;
  ```
* **Detailed Explanation:**
  * The asterisk (`*`) is a **wildcard character** that instructs the SQL engine to fetch **all columns** defined in the table schema in their exact declared order.
  * **When to use:** Ideal during development, exploratory analysis, ad-hoc debugging, or schema verification.
  * **Production Caveat:** In high-traffic production APIs, avoid `SELECT *` because it retrieves unnecessary columns (including large text or BLOB columns), increases network bandwidth consumption, and prevents the database from utilizing covering indexes.

#### 2. Method ②: Get Only Required Data from the Table (Column Projection)
* **Q. How to get only the required data from the table (whatever columns are required)?**
* **SQL Query:**
  ```sql
  SELECT ID, FIRST_NAME, COUNTRY, SCORE 
  FROM CUSTOMERS;
  ```
* **Detailed Explanation:**
  * By explicitly naming columns separated by commas (`ID, FIRST_NAME, COUNTRY, SCORE`), you project **only the exact columns needed** by your application or report.
  * **When to use:** **Industry standard best practice** for all application queries, dashboards, and APIs.
  * **Key Benefits:**
    1. **Lower Network Payload:** Only relevant byte streams travel over the network between database and client.
    2. **Index Optimization (Covering Index):** If all requested columns are inside an index, MySQL can answer from the index alone, without reading the table.
    3. **Schema Change Resilience:** If new columns are later added to the table, queries with explicit column lists will not break or consume unexpected memory.

---

### 10.3 Visual Concept: Whole Table vs. Specific Column Projection

![DQL SELECT: Whole Table vs Specific Column Projection](./dql_select_whole_vs_specific_columns_diagram.svg)

* **Architecture & Flow Explanation (आकृतीचे सविस्तर स्पष्टीकरण):**
  * **Left Panel (`SELECT * FROM CUSTOMERS;`):**
    * The database engine retrieves every single column (`ID`, `FIRST_NAME`, `LAST_NAME`, `COUNTRY`, `SCORE`, `STATUS`).
    * Returns 100% of the table attributes across all records.
  * **Right Panel (`SELECT ID, FIRST_NAME, COUNTRY, SCORE FROM CUSTOMERS;`):**
    * The engine projects only the 4 requested attributes, safely filtering out unneeded columns (`LAST_NAME` and `STATUS`).
    * Produces a streamlined, lightweight result set optimized for memory and network performance.

* **📌 आकृतीचे मराठीत स्पष्टीकरण:**
  * **डावा भाग (`SELECT *`):** डेटाबेस इंजिन टेबलमधील प्रत्येक कॉलम (`ID`, `FIRST_NAME`, `LAST_NAME`, `COUNTRY`, `SCORE`, `STATUS`) शोधून आणतो. यात १००% डेटा मिळतो, पण नेटवर्क बँडविड्थ जास्त खर्च होते.
  * **उजवा भाग (कॉलम प्रोजेक्शन):** ॲप्लिकेशनला लागणारे फक्त ४ निवडक कॉलम्स आणले जातात आणि अनावश्यक कॉलम्स गाळले जातात. यामुळे मेमरी व डेटा ट्रान्सफरची मोठी बचत होते.

---

### 10.4 Topic 10 Summary (मराठी सारांश)

* **DQL (Data Query Language) ची व्याख्या:**
  * DQL चा वापर डेटाबेसमधून डेटा मिळवण्यासाठी (Retrieve / Fetch) केला जातो.
  * DQL ही पूर्णपणे **Read-Only** भाषा आहे; यामुळे डेटाबेसच्या टेबलमध्ये किंवा डेटामध्ये कोणताही बदल (Modify/Delete) होत नाही.
  * DQL मधील मुख्य आणि सर्वात महत्त्वाची कमांड म्हणजे **`SELECT`**.

* **डेटा मिळवण्याच्या दोन मुख्य पद्धती:**
  1. **संपूर्ण डेटा मिळवणे (`SELECT * FROM CUSTOMERS;`):**
     * `*` (Wildcard) चा अर्थ 'सर्व कॉलम्स' असा होतो.
     * टेबलमधील सर्वच्या सर्व कॉलम्स त्यांच्या मूळ क्रमात मिळतात. टेस्टिंग आणि अभ्यासासाठी ही उत्तम आहे.
  2. **फक्त आवश्यक डेटा मिळवणे (`SELECT ID, FIRST_NAME, COUNTRY, SCORE FROM CUSTOMERS;`):**
     * आवश्यक असलेले कॉलम्स स्वल्पविरामाने (Comma) जोडून लिहिले जातात.
     * **इंडस्ट्री बेस्ट प्रॅक्टिस:** ॲप्लिकेशनमध्ये नेहमी फक्त हवे असलेले कॉलम्सच प्रोजेक्ट करावेत; यामुळे नेटवर्क डेटा ट्रान्सफर कमी होतो आणि क्वेरी अतिशय वेगाने धावते.

---

## Topic 11: DCL (Data Control Language) & Security / Access Control

### 11.1 What is DCL (Data Control Language)?

* *Definition: DCL (Data Control Language) consists of commands used for database security and access control, deciding who can access what in a database.*
  * Used to control access and permissions on database objects such as **tables, views, stored procedures, functions, and schemas**.
  * DCL commands are used to **grant** authority/privileges to users and to **take back (revoke)** that authority when no longer required.

* **Why is DCL Used? (Point-Wise Reasons):**
  * **1. To Give Permissions to Users:** Authorize developers, applications, or reporting analysts to perform specific queries (e.g., read-only access).
  * **2. To Remove Permissions from Users:** Withdraw capabilities when roles change or to restrict dangerous capabilities (e.g., revoke `DELETE` or `DROP`).
  * **3. To Maintain Database Security:** Prevent unauthorized access, accidental data wiping, and enforce the **Principle of Least Privilege (PoLP)**.

---

### 11.2 Core DCL Commands: GRANT and REVOKE

The two primary DCL commands in SQL:

| Command | Keyword | Purpose | Action Performed |
| :--- | :--- | :--- | :--- |
| **`GRANT`** | **`TO`** | Give permission | Bestows specific privileges/access on database objects to a user |
| **`REVOKE`** | **`FROM`** | Remove permission | Withdraws/removes previously granted access privileges from a user |

* **1. The `GRANT` Command:**
  * *Definition: GRANT is a DCL command used to provide access privileges to users.*
  * **Syntax:**
    ```sql
    GRANT privilege_list ON object_name TO 'username'@'host';
    ```
  * **Example:**
    ```sql
    GRANT SELECT, INSERT ON Students TO 'user'@'localhost';
    ```

* **2. The `REVOKE` Command:**
  * *Definition: REVOKE is a DCL command used to withdraw or remove privileges from users.*
  * **Syntax:**
    ```sql
    REVOKE privilege_list ON object_name FROM 'username'@'host';
    ```
  * **Example:**
    ```sql
    REVOKE INSERT ON Students FROM 'user'@'localhost';
    ```

---

### 11.3 Inspecting Users & Privileges in MySQL

* **Q. How to Show all users & their related information?**
  * Inspect the internal MySQL authorization catalog to view all created users, hosts, and global privilege flags:
  ```sql
  SELECT * FROM mysql.user;
  
  -- View specific user accounts and hosts:
  SELECT user, host, plugin FROM mysql.user;
  ```

* **Q. How to Show all privilege types available in MySQL?**
  * Displays the complete list of supported server-level and object-level privilege types:
  ```sql
  SHOW PRIVILEGES;
  ```

* **Q. How to Show a specific user's granted privileges?**
  * Displays the exact grants currently active for a specific user account:
  ```sql
  SHOW GRANTS FOR 'VISHAL'@'localhost';
  ```

---

### 11.4 User Management & Creation (Read-Only User Concept)

* **Q. How to Create a User (Read-Only User)?**
  ```sql
  CREATE USER 'VISHAL'@'localhost' IDENTIFIED BY 'VISHAL@1234';
  ```

* **Component-by-Component Explanation:**
  * **`CREATE USER`:** Command used to register a new user account in MySQL.
  * **`'VISHAL'`:** The unique username for the account.
  * **`'@localhost'`:** Host specification — dictates that this user can **only connect from the local machine** where MySQL runs.
  * **`IDENTIFIED BY`:** Sets the password for the account.
  * **`'VISHAL@1234'`:** The login password assigned to the user.

* **Host Option Explanations (कधी कोणता Host वापरायचा?):**
  * **`'localhost'`:** Allows connections **only from the local machine**.
  * **`'%'`:** Wildcard host — allows connection from **any remote machine** across the network/internet.
  * **`'192.168.1.%'`:** Subnet restriction — allows connections only from IP addresses within a specific subnet (e.g., office LAN).
  * **`'example.com'`:** Domain restriction — allows connections only originating from a specific verified domain.

---

### 11.5 Step-by-Step Granting & Revoking Permissions

#### 1. Table-Level Permissions (Read-Only Access)
* **Q. How to give SELECT permission on the employees / customers table (Read-Only Permission)?**
  ```sql
  -- Grants read-only access on one specific table:
  GRANT SELECT ON customers TO 'VISHAL'@'localhost';
  ```

#### 2. Database-Wide Read-Only Permissions
* **Q. How to grant read permission on all tables in a database?**
  ```sql
  GRANT SELECT ON database_name.* TO 'VISHAL'@'localhost';
  ```
  * **Explanation:**
    * `SELECT` $\rightarrow$ Read-only permission.
    * `database_name.*` $\rightarrow$ All tables inside the specified database.
    * The user **cannot** perform `INSERT`, `UPDATE`, or `DELETE`.

#### 3. Specific Table in Specific Database
* **Q. How to grant read permission on a specific table in a specific database?**
  ```sql
  GRANT SELECT ON customers.user TO 'VISHAL'@'localhost';
  ```

#### 4. Grant Multiple Table-Level Privileges
* **Q. How to grant multiple DML privileges (INSERT, UPDATE, DELETE) on a table?**
  ```sql
  GRANT INSERT, UPDATE, DELETE ON customers TO 'VISHAL'@'localhost';
  ```

#### 5. Revoke a Single Privilege
* **Q. How to revoke INSERT privilege from user?**
  ```sql
  REVOKE INSERT ON customers FROM 'VISHAL'@'localhost';
  ```

---

### 11.6 Database-Wide Privileges & Administrative Access

#### 1. Grant Full DML Privileges Across Entire Database
* Vishal now has full DML access (`SELECT`, `INSERT`, `UPDATE`, `DELETE`) on all tables in the database:
  ```sql
  GRANT SELECT, INSERT, UPDATE, DELETE ON salesdb.* TO 'VISHAL'@'localhost';
  ```

#### 2. Revoke DELETE Privilege from User
* Vishal loses `DELETE` capability, but safely retains `SELECT`, `INSERT`, and `UPDATE`:
  ```sql
  REVOKE DELETE ON salesdb.* FROM 'VISHAL'@'localhost';
  ```

#### 3. Grant ALL Privileges (Database Admin / Superuser on DB)
* Can perform everything inside the database (`CREATE`, `ALTER`, `DROP`, manage indexes, etc.):
  ```sql
  GRANT ALL PRIVILEGES ON salesdb.* TO 'VISHAL'@'localhost';
  ```

#### 4. Revoke Dangerous Privileges (`DROP` & `ALTER`)
* Strips structural destruction and table modification permissions to protect database architecture:
  ```sql
  REVOKE DROP, DELETE, ALTER ON salesdb.* FROM 'VISHAL'@'localhost';
  ```

#### 5. Reload Privileges (`FLUSH PRIVILEGES`) — Usually NOT Needed
* Reloads permissions from the `mysql` system database. ⚠️ Not needed after `GRANT` / `REVOKE` (they apply immediately) — only after editing `mysql.*` tables directly (see 11.8):
  ```sql
  FLUSH PRIVILEGES;
  ```

#### 6. Verify Updated Privileges
* Confirms active permissions:
  ```sql
  SHOW GRANTS FOR 'VISHAL'@'localhost';
  SHOW GRANTS FOR 'readonly_user'@'localhost';
  ```

#### 7. Remove a User Account Completely
* Completely deletes the user account from the MySQL server:
  ```sql
  DROP USER 'VISHAL'@'localhost';
  ```

---

### 11.7 The 6 Core Privilege Categories in MySQL

As of MySQL 8.x, there are **36+ distinct privilege types** classified into 6 primary operational categories:

| Category | Typical Privileges | Operational Scope & Role |
| :--- | :--- | :--- |
| **1. Data Privileges (DML)** | `SELECT`, `INSERT`, `UPDATE`, `DELETE` | Controls managing, querying, and updating row records inside tables. |
| **2. Structure Privileges (DDL)** | `CREATE`, `DROP`, `ALTER`, `INDEX` | Controls creating, modifying, re-indexing, or destroying databases, tables, and views. |
| **3. Administrative Privileges** | `GRANT OPTION`, `SUPER`, `RELOAD`, `SHUTDOWN` | Controls global MySQL server operation, user delegation, process management, and shutdowns. |
| **4. Replication Privileges** | `REPLICATION SLAVE`, `REPLICATION CLIENT` | Used in Master-Replica high availability topologies to stream binary logs. |
| **5. Security & Process Privileges** | `CREATE USER`, `PROCESS`, `SHOW DATABASES` | Controls user account provisioning, inspecting the server process list, and discovering databases. |
| **6. Proxy Privilege** | `PROXY` | Allows one user account to authenticate and assume the privileges of another account. |

### 11.8 Advanced Interview Concepts & Gotchas in DCL / Security

#### 1. The Classic Interview Trap: When is `FLUSH PRIVILEGES` Actually Required?
* **Q. Do you need to run `FLUSH PRIVILEGES` after every `GRANT` or `REVOKE` statement?**
* **Correct Technical Answer:** **NO!**
  * When using standard SQL DCL commands (`GRANT`, `REVOKE`, `CREATE USER`, `ALTER USER`, `DROP USER`), MySQL updates its in-memory privilege hash tables **automatically and immediately**.
  * `FLUSH PRIVILEGES` is **only required** if you bypass DCL statements and directly manipulate the internal MySQL system grant tables using DML (e.g., `UPDATE mysql.user SET ...;` or `INSERT INTO mysql.db ...;`).

#### 2. `WITH GRANT OPTION` (Delegation of Authority)
* **Q. How can you allow a team lead or user to grant their own permissions to other developers?**
* **Syntax & Example:**
  ```sql
  GRANT SELECT, INSERT ON salesdb.* TO 'team_lead'@'localhost' WITH GRANT OPTION;
  ```
* **Explanation:**
  * `WITH GRANT OPTION` allows `'team_lead'` to grant the exact privileges they hold to any other user account.
  * **Security Warning:** Never grant `WITH GRANT OPTION` to public application service accounts; reserve strictly for DBAs.

#### 3. Role-Based Access Control (RBAC) in MySQL 8.0
* **Q. In an enterprise with hundreds of developers, granting permissions user-by-user is unmanageable. How do you handle this efficiently in MySQL 8.0?**
* **Solution:** Use **Roles** (grouped permissions):
  ```sql
  -- Step 1: Create distinct roles
  CREATE ROLE 'app_developer', 'data_analyst';

  -- Step 2: Assign privileges to each role
  GRANT SELECT, INSERT, UPDATE ON salesdb.* TO 'app_developer';
  GRANT SELECT ON salesdb.* TO 'data_analyst';

  -- Step 3: Grant the role to multiple individual users
  GRANT 'app_developer' TO 'vishal'@'localhost', 'amit'@'localhost';

  -- Step 4: Make role active by default upon user login
  SET DEFAULT ROLE ALL TO 'vishal'@'localhost', 'amit'@'localhost';
  ```

#### 4. Column-Level Privileges (Masking Sensitive Columns)
* **Q. Can you permit an intern to see employee names and departments while hiding sensitive columns like salary and SSN?**
* **Solution:** **Yes!** MySQL supports column-level privilege projection:
  ```sql
  -- Intern can only access emp_id, emp_name, and department:
  GRANT SELECT (emp_id, emp_name, department) ON company.employees TO 'intern'@'localhost';

  -- If the intern attempts: SELECT salary FROM company.employees;
  -- MySQL rejects with: ERROR 1143 (42000): SELECT command denied to user for column 'salary'
  ```

#### 5. Difference: `DROP USER` vs. `REVOKE ALL PRIVILEGES`
| Dimension | `REVOKE ALL PRIVILEGES` | `DROP USER` |
| :--- | :--- | :--- |
| **Account Existence** | Account credentials remain in `mysql.user` | Account is completely purged from server |
| **Authentication** | User **can still connect and log in** successfully | Connection is rejected with `Access Denied` |
| **Access Rights** | User has 0 permissions (cannot access tables) | User does not exist at all |

#### 6. Account Locking & Password Expiry Management
* **Q. How do you temporarily suspend an employee's access (e.g., during sabbatical) without deleting their grants, or force a password reset?**
* **SQL Commands:**
  ```sql
  -- Temporarily lock account (blocks authentication):
  ALTER USER 'vishal'@'localhost' ACCOUNT LOCK;

  -- Unlock account when employee returns:
  ALTER USER 'vishal'@'localhost' ACCOUNT UNLOCK;

  -- Force user to change their password on next login:
  ALTER USER 'vishal'@'localhost' PASSWORD EXPIRE;
  ```

#### 7. Authentication Plugin Incompatibility (`caching_sha2_password` vs. `mysql_native_password`)
* **Q. Why do older Python, PHP, or Node.js drivers fail with "Authentication plugin 'caching_sha2_password' cannot be loaded" when connecting to MySQL 8.0?**
* **Cause & Fix:**
  * MySQL 8.0 changed default password hashing from `mysql_native_password` to `caching_sha2_password`.
  * **Fix for legacy clients:**
    ```sql
    ALTER USER 'vishal'@'localhost' IDENTIFIED WITH mysql_native_password BY 'VISHAL@1234';
    ```
  * ⚠️ **Note (MySQL 9.x):** `mysql_native_password` is disabled by default in MySQL 8.4 and **removed in MySQL 9.0+** (your version is 9.1). There, the real fix is to upgrade the client driver so it supports `caching_sha2_password`.

---

### 11.9 Visual Architecture Diagram: DCL & Privileges

![DCL Security & Privilege Architecture in MySQL](./dcl_security_and_privileges_diagram.svg)

* **Architecture & Flow Explanation (आकृतीचे सविस्तर स्पष्टीकरण):**
  * **GRANT (Top Left):** The Database Administrator uses `GRANT ... TO ...` to push specific privileges down to a target user.
  * **REVOKE (Top Center):** The Administrator uses `REVOKE ... FROM ...` to strip risky permissions without deleting the user.
  * **Scope Hierarchies (Top Right):** Shows how privileges cascade from Global (`*.*`), to Database (`salesdb.*`), to Table (`salesdb.customers`), down to specific Columns.
  * **6 Privilege Categories (Bottom Grid):** Breaks down all 36+ MySQL privileges into their distinct roles (DML, DDL, Admin, Replication, Security, Proxy).

* **📌 आकृतीचे मराठीत स्पष्टीकरण:**
  * **GRANT (वर डावीकडे):** डेटाबेस ॲडमिनिस्ट्रेटर (DBA) द्वारे युझरला आवश्यक परवानग्या (उदा. `SELECT`, `INSERT`) बहाल करणे.
  * **REVOKE (वर मध्यभागी):** सुरक्षा धोके टाळण्यासाठी युझरकडून आधी दिलेले अधिकार परत काढून घेणे.
  * **अधिकारांची व्याप्ती (वर उजवीकडे):** अधिकारांचे ४ स्तर असतात—ग्लोबल (`*.*`), डेटाबेस (`db.*`), टेबल (`db.table`), आणि विशिष्ट कॉलम्स (`table(col1)`).
  * **६ प्रकार (खालचा भाग):** सर्व ३६+ परवानग्यांचे ६ प्रकार—DML, DDL, ॲडमिनिस्ट्रेटिव्ह, रेप्लिकेशन, सुरक्षा, आणि प्रॉक्सी.

---

### 11.10 Topic 11 Summary (मराठी सारांश)

* **DCL (Data Control Language) ची व्याख्या व महत्त्व:**
  * DCL चा वापर डेटाबेसच्या सुरक्षिततेसाठी (Security) आणि अधिकारांचे नियंत्रण (Access Control) करण्यासाठी होतो.
  * **"डेटाबेसमध्ये कोणी काय पाहावे आणि काय बदलावे हे DCL ठरवते."**
  * यासाठी मुख्य दोन कमांड्स वापरल्या जातात:
    1. **`GRANT` (`TO`):** युझरला परवानगी / अधिकार देणे.
    2. **`REVOKE` (`FROM`):** युझरकडून दिलेले अधिकार काढून घेणे.

* **महत्त्वाच्या संकल्पना व नियम:**
  * **युझर तयार करणे:** `CREATE USER 'username'@'host' IDENTIFIED BY 'password';`
    * `'localhost'` चा अर्थ फक्त त्याच कॉम्प्युटरवरून लॉगिन करता येईल.
    * `'%'` चा अर्थ कुठूनही रिमोट लॉगिन करता येईल.
  * **परवानग्या देणे व काढणे:**
    * `GRANT SELECT ON db.* TO 'user'@'localhost';` (फक्त वाचण्याची परवानगी - Read Only).
    * `REVOKE DELETE ON db.* FROM 'user'@'localhost';` (डिलीट करण्याची परवानगी काढून घेणे).
  * **`FLUSH PRIVILEGES` कधी लागतो?:** `GRANT` / `REVOKE` वापरल्यावर बदल लगेच लागू होतात, त्यामुळे `FLUSH PRIVILEGES;` ची गरज नसते. फक्त `mysql.user` सारखे सिस्टम टेबल्स थेट `UPDATE` / `INSERT` ने बदलल्यावरच तो लागतो.
  * **तपासणी करणे:** युझरचे अधिकार तपासण्यासाठी `SHOW GRANTS FOR 'user'@'host';` वापरले जाते.

---

## Topic 12: TCL (Transaction Control Language) & Transaction Management

### 12.1 What is TCL (Transaction Control Language)?

* *Definition: TCL (Transaction Control Language) commands decide whether changes are saved permanently (`COMMIT`) or undone (`ROLLBACK`).*
  * **Core Formula:**
    $$\text{TCL} = \text{Transaction Control} = \text{Save or Undo Changes}$$

---

### 12.2 What is a Transaction? (ACID Overview)

* *Definition: A Transaction is a group of one or more SQL statements executed as a single, indivisible logical unit of work.*
* **All-or-Nothing Principle:** Either **all statements succeed**, or **none of them take effect**.
* **Common Statements in Transactions:**
  * Primarily groups **DML statements** (`INSERT`, `UPDATE`, `DELETE`).
* **The 4 ACID Pillars:**
  * **Atomicity (A):** The entire transaction either completes successfully or is completely rolled back (no partial execution).
  * **Consistency (C):** Takes the database from one valid state to another, maintaining all constraints and schema rules.
  * **Isolation (I):** Intermediate transaction states are invisible to other concurrently running transactions.
  * **Durability (D):** Once committed, data changes survive permanently on disk even during system failures or power outages.

---

### 12.3 Core TCL Commands: START, COMMIT, ROLLBACK, SAVEPOINT, SET

| Command | Action / Role | Effect on Data |
| :--- | :--- | :--- |
| **`START TRANSACTION`** | Begins a new transaction block | Opens an atomic staging session |
| **`COMMIT`** | Saves changes permanently | Writes staged changes to disk; ends transaction |
| **`ROLLBACK`** | Undoes uncommitted changes | Restores database back to pre-transaction state |
| **`SAVEPOINT`** | Sets an intermediate checkpoint | Allows partial rollback to a specific marker |
| **`SET TRANSACTION`** | Sets transaction properties | Configures isolation levels and read-only modes |

#### 1. Beginning a Transaction: `START TRANSACTION` / `BEGIN`
* *Definition: START TRANSACTION (or BEGIN) instructs the database engine to open a new atomic transaction context.*
  ```sql
  START TRANSACTION;
  -- OR
  BEGIN;
  ```

#### 2. Saving Changes Permanently: `COMMIT`
* *Definition: COMMIT permanently commits and saves all staged changes to the storage engine (InnoDB) and concludes the transaction.*
  ```sql
  UPDATE customers
  SET balance = balance - 1000
  WHERE id = 1;

  COMMIT;  -- Changes are permanently written to disk!
  ```

#### 3. Undoing Changes: `ROLLBACK`
* *Definition: ROLLBACK discards all uncommitted changes made in the current transaction and restores the data to its pre-transaction state.*
* **Important:** Works **only before `COMMIT`**.
  ```sql
  DELETE FROM customers
  WHERE id = 5;

  ROLLBACK;  -- Data is restored to its previous state; row 5 is NOT deleted!
  ```

#### 4. Partial Rollback via `SAVEPOINT`
* *Definition: SAVEPOINT creates points within a group of statements to rollback to, allowing partial changes to be undone without discarding the entire transaction.*
  ```sql
  START TRANSACTION;

  -- First operation:
  UPDATE accounts SET balance = balance - 500 WHERE acc_id = 101;

  -- Create a checkpoint:
  SAVEPOINT sp1;

  -- Second operation:
  UPDATE customers SET balance = 5000 WHERE id = 2;

  -- Rollback only the second operation:
  ROLLBACK TO sp1;  -- Only changes after sp1 are undone; earlier changes remain active!

  -- Finally commit the remaining first operation:
  COMMIT;
  ```

#### 5. Setting Transaction Properties: `SET TRANSACTION`
* *Definition: SET TRANSACTION configures transaction behavior, such as access mode (READ ONLY / READ WRITE) and isolation levels.*
  ```sql
  SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
  SET SESSION TRANSACTION ISOLATION LEVEL REPEATABLE READ;
  ```

---

### 12.4 Real-World Banking Transaction Example (Atomic Transfer)

A classic banking scenario transferring \$1,000 from Account 101 to Account 102:
```sql
-- Step 1: Begin the transaction
START TRANSACTION;

-- Step 2: Debit money from Sender (Account 101)
UPDATE accounts 
SET balance = balance - 1000 
WHERE acc_id = 101;

-- Step 3: Credit money to Receiver (Account 102)
UPDATE accounts 
SET balance = balance + 1000 
WHERE acc_id = 102;

-- Step 4: Commit both operations together
COMMIT;
```
* **Why Transactions are Critical Here:**
  * If a server crash occurs right after Step 2, the money is not lost. The database automatically executes a `ROLLBACK` upon recovery, restoring the \$1,000 back to Account 101.

---

### 12.5 Critical Rules & Constraints of TCL

* **1. Works Only with DML Commands:**
  * TCL controls **`INSERT`**, **`UPDATE`**, and **`DELETE`**.
* **2. Requires Transaction-Supported Storage Engine:**
  * Requires engines like **InnoDB** in MySQL. Non-transactional engines like **MyISAM** ignore transactions!
* **3. ROLLBACK Does NOT Work After COMMIT:**
  * Once `COMMIT` is executed, the transaction is finalized. `ROLLBACK` has zero effect on committed data.
* **4. DDL Commands Trigger an Implicit Commit:**
  * Running any DDL statement (`CREATE`, `ALTER`, `DROP`, `TRUNCATE`, `RENAME`) inside a transaction **immediately commits all pending changes automatically**. You cannot rollback DDL statements in MySQL.

---

### 12.6 Transaction Isolation Levels & Concurrency Anomalies

When multiple transactions execute concurrently on the same tables, three common data anomalies can occur:

#### 1. The 3 Common Concurrency Problems
| Problem / Phenomenon | Meaning & Manifestation |
| :--- | :--- |
| **Dirty Read** | A transaction reads uncommitted data written by another ongoing transaction (which might later be rolled back). |
| **Non-Repeatable Read** | A transaction re-reads the same row and discovers the data has changed because another transaction committed an `UPDATE` or `DELETE`. |
| **Phantom Read** | A transaction re-executes a range query (`WHERE score > 500`) and finds newly inserted rows committed by another transaction. |

#### 2. The 4 ANSI SQL Isolation Levels Matrix
Isolation levels control how transactions see each other's data:

| Isolation Level | Dirty Read | Non-Repeatable Read | Phantom Read | Standard Use Case & Defaults |
| :--- | :---: | :---: | :---: | :--- |
| **`READ UNCOMMITTED`** | ❌ Allowed | ❌ Allowed | ❌ Allowed | Highest speed, zero consistency; rarely used. |
| **`READ COMMITTED`** | ✓ Prevented | ❌ Allowed | ❌ Allowed | Default in Oracle, PostgreSQL, and SQL Server. |
| **`REPEATABLE READ`** | ✓ Prevented | ✓ Prevented | ✓ Prevented* | **Default in MySQL InnoDB** *(Next-Key Locking blocks Phantoms)*. |
| **`SERIALIZABLE`** | ✓ Prevented | ✓ Prevented | ✓ Prevented | Strict table/row locking; highest consistency, slowest speed. |

---

### 12.7 Advanced Interview Concepts & Gotchas in TCL / Transaction Management

#### 1. Autocommit Mode (`@@autocommit`) & Default Session Behavior
* **Q. If you execute an UPDATE statement without running START TRANSACTION, can you roll it back?**
* **Answer & Mechanics:**
  * In MySQL, **`autocommit` is enabled by default (`1`)**.
  * Every single standalone SQL statement is treated as an independent transaction that is committed to disk immediately upon completion. Therefore, you **cannot** roll it back unless explicit transaction controls are enabled.
* **How to Inspect and Control Autocommit:**
  ```sql
  -- Check current autocommit status (1 = ON, 0 = OFF):
  SELECT @@autocommit;

  -- Disable autocommit for the current session:
  SET autocommit = 0;

  -- With autocommit disabled, every DML requires an explicit COMMIT or ROLLBACK:
  UPDATE accounts SET balance = balance - 200 WHERE acc_id = 101;
  ROLLBACK; -- Successfully rolls back!

  -- Re-enable autocommit:
  SET autocommit = 1;
  ```
  > [!WARNING]
  > **Production Gotcha:** If you set `SET autocommit = 0;` in your session and forget to call `COMMIT` or `ROLLBACK`, open row-level locks remain active indefinitely, causing application connection pools to hang and lock-wait timeouts (`ERROR 1205`) for other users!

---

#### 2. The DDL "Implicit Commit" Interview Trap
* **Q. What happens to the 20% salary hike in this transaction? Is it rolled back or saved?**
  ```sql
  START TRANSACTION;
  UPDATE employees SET salary = salary * 1.20 WHERE dept = 'IT';
  CREATE TABLE audit_log (id INT PRIMARY KEY, action VARCHAR(50));
  ROLLBACK;
  ```
* **Answer:** **It is permanently saved! It CANNOT be rolled back.**
* **Explanation:**
  * In MySQL (and most relational databases), **DDL statements** (`CREATE`, `ALTER`, `DROP`, `TRUNCATE`, `RENAME`) trigger an **Implicit Commit**.
  * The moment MySQL encounters `CREATE TABLE audit_log`, it immediately and irreversibly executes an internal `COMMIT` on all pending transactional modifications (including the preceding `UPDATE`).
  * The subsequent `ROLLBACK;` statement has nothing left to revert because the transaction was already closed and finalized by the DDL operation.

---

#### 3. Deadlocks in MySQL InnoDB (`ERROR 1213`) & Automatic Cycle Resolution
* **Q. What is a Deadlock in SQL transactions, how does MySQL detect it, and what does it do?**
* **What Causes a Deadlock:**
  * A circular dependency where two or more transactions wait for locks held by each other:
    1. **Transaction 1** locks `Row A` and requests a lock on `Row B`.
    2. **Transaction 2** locks `Row B` and requests a lock on `Row A`.
    3. Neither can advance; both are blocked waiting for the other.
* **How InnoDB Resolves Deadlocks:**
  * InnoDB features an active **Deadlock Detection Engine** that tracks a wait-for lock graph.
  * When a cycle is discovered, InnoDB automatically selects one transaction as the **victim** (the transaction that has modified fewer rows or has a smaller undo log).
  * InnoDB automatically aborts and rolls back the victim transaction, throwing:
    ```
    ERROR 1213 (40001): Deadlock found when trying to get lock; try restarting transaction
    ```
* **Production Best Practice:** Always lock tables/rows in a consistent, alphabetical or sorted order across application endpoints, and wrap database calls in retry loops with exponential backoff.

---

#### 4. `ROLLBACK TO SAVEPOINT` vs. `RELEASE SAVEPOINT`
* **Q. What is the exact difference between ROLLBACK TO SAVEPOINT and RELEASE SAVEPOINT? Does RELEASE SAVEPOINT commit changes?**
* **Comparison Table:**

| Feature / Behavior | `ROLLBACK TO SAVEPOINT name;` | `RELEASE SAVEPOINT name;` |
| :--- | :--- | :--- |
| **Data Modifications** | **Undoes (reverts)** changes made after the savepoint | **Preserves** all data modifications |
| **Commit Changes?** | No (transaction remains open) | **No** (does NOT commit changes) |
| **Savepoint Marker** | Keeps the savepoint active for further use | **Deletes the checkpoint marker** from memory |
| **Use Case** | Recovering from a failed sub-task | Freeing server memory resources when checkpoint is no longer needed |

* **Code Demonstration:**
  ```sql
  START TRANSACTION;
  INSERT INTO orders (id, item) VALUES (1, 'Laptop');
  SAVEPOINT sp1;

  INSERT INTO orders (id, item) VALUES (2, 'Mouse');

  -- Option A: Revert only row 2 (row 1 remains staged):
  -- ROLLBACK TO sp1;

  -- Option B: Delete the checkpoint marker (both row 1 and row 2 remain staged):
  RELEASE SAVEPOINT sp1;

  COMMIT; -- Permanently saves both rows!
  ```

---

#### 5. Concurrency Control: Pessimistic Locking vs. Optimistic Locking
* **Q. How do you prevent race conditions during high-volume checkout (e.g., ticket booking / inventory flash sale)?**

##### A. Pessimistic Locking (`SELECT ... FOR UPDATE`)
* **Concept:** Assumes concurrent collisions are frequent. Locks target rows immediately upon reading until the transaction finishes.
* **SQL Implementation:**
  ```sql
  START TRANSACTION;

  -- Exclusively locks row id = 101; other transactions cannot read or write with locks:
  SELECT stock FROM products WHERE id = 101 FOR UPDATE;

  -- Safely decrement stock:
  UPDATE products SET stock = stock - 1 WHERE id = 101;

  COMMIT; -- Lock is released!
  ```
* **Shared Lock Variant (`LOCK IN SHARE MODE` / `FOR SHARE`):** Allows other transactions to read, but blocks any other transaction from updating or deleting until completed.

##### B. Optimistic Locking (Version Tracking)
* **Concept:** Assumes collisions are rare. Does not acquire database-level locks. Instead, uses an integer `version` or timestamp column.
* **SQL Implementation:**
  ```sql
  -- Step 1: Read current state and version without locking:
  SELECT stock, version FROM products WHERE id = 101;
  -- Suppose version = 4, stock = 10

  -- Step 2: Update only if version has not changed:
  UPDATE products 
  SET stock = stock - 1, version = version + 1 
  WHERE id = 101 AND version = 4;

  -- Step 3: Check Rows Affected:
  -- If Rows Affected == 1 -> Success!
  -- If Rows Affected == 0 -> Another transaction modified the row concurrently; retry or abort.
  ```

---

#### 6. Under the Hood: How InnoDB Guarantees Atomicity & Durability (Undo Log vs. Redo Log)
* **Q. How does MySQL InnoDB physically implement Rollback (Atomicity) and Crash Recovery (Durability)?**
* **Direct Comparison:**

| Component | Storage Role | Guarantees | How it Works |
| :--- | :--- | :--- | :--- |
| **Undo Log** | **Before-Images** (Reverse operations) | **Atomicity & MVCC** | When you run an `UPDATE`, the old values are recorded in the undo log. If you run `ROLLBACK` or the server crashes mid-transaction, InnoDB replays the undo log in reverse to restore initial data. |
| **Redo Log (WAL)** | **After-Images** (Write-Ahead Log) | **Durability** | When you run `COMMIT`, InnoDB writes changes sequentially to the redo log buffer and flushes to disk before updating the actual tablespace `.ibd` files. If power cuts out, crash recovery replays the redo log. |

---

#### 7. Can `TRUNCATE` or `DROP` be Rolled Back? (`DELETE` vs. `TRUNCATE` in TCL)
* **Q. Can you rollback a DELETE? Can you rollback a TRUNCATE?**
* **Detailed Breakdown:**
  * **`DELETE`:**
    * Operates as a DML statement row-by-row.
    * Every individual row deletion is logged in the **Undo Log**.
    * **Can be rolled back completely** if executed inside an uncommitted transaction (`ROLLBACK;`).
  * **`TRUNCATE`:**
    * Operates as a DDL statement. It de-allocates and drops the table data pages and creates empty ones.
    * It does **not** write row-by-row before-images to the undo log.
    * It triggers an **Implicit Commit** in MySQL.
    * **CANNOT be rolled back** under any circumstances in MySQL.

---

### 12.8 Visual Architecture Diagram: TCL Lifecycle & Isolation Levels

![TCL Transaction Lifecycle and Isolation Architecture](./tcl_transaction_lifecycle_and_isolation_diagram.svg)

* **Architecture & Flow Explanation (आकृतीचे सविस्तर स्पष्टीकरण):**
  * **Left Panel (Transaction Lifecycle):**
    * Displays `START TRANSACTION` opening the atomic block.
    * Demonstrates `SAVEPOINT sp1` checkpointing.
    * Highlights the 3 resolution branches: `COMMIT` (permanent disk write), `ROLLBACK` (complete reversal), and `ROLLBACK TO sp1` (selective undo).
  * **Right Panel (Isolation Levels Matrix):**
    * Details the 3 concurrency phenomena (Dirty Read, Non-Repeatable Read, Phantom Read).
    * Summarizes the 4 ANSI isolation levels with clear visual badges, highlighting MySQL's default `REPEATABLE READ`.

* **📌 आकृतीचे मराठीत स्पष्टीकरण:**
  * **डावा पॅनेल (ट्रान्झॅक्शन जीवनचक्र):** `START TRANSACTION` ने सुरू होणाऱ्या ब्लॉकचे ३ मार्ग दाखवतो—(१) `COMMIT` (डेटा कायम सेव्ह करणे), (२) `ROLLBACK` (सर्व बदल पूर्ण रद्द करणे), आणि (३) `ROLLBACK TO sp1` (चेकपॉईंटपर्यंतचे निवडक बदल रद्द करणे).
  * **उजवा पॅनेल (आयसोलेशन लेव्हल्स):** ३ महत्त्वाचे डेटा प्रॉब्लेम्स (डर्टी रीड, नॉन-रिपीटएबल रीड, फँटम रीड) आणि ते रोखणाऱ्या ४ लेव्हल्स दाखवतो, ज्यामध्ये MySQL चे बाय-डिफॉल्ट लेव्हल **`REPEATABLE READ`** ठळकपणे दर्शवले आहे.

---

### 12.9 Topic 12 Summary (मराठी सारांश)

* **TCL (Transaction Control Language) ची व्याख्या:**
  * ट्रान्झॅक्शनचे व्यवस्थापन करण्यासाठी आणि डेटा कायम सेव्ह करायचा की पूर्ववत करायचा हे ठरवण्यासाठी TCL चा वापर होतो.
  * **ट्रान्झॅक्शन (Transaction):** अनेक SQL क्वेरीजचा मिळून बनलेला एकसंध लॉजिकल युनिट (All-or-Nothing).
* **महत्त्वाच्या कमांड्स:**
  1. **`START TRANSACTION`:** ट्रान्झॅक्शन सुरू करणे.
  2. **`COMMIT`:** केलेले बदल डेटाबेसमध्ये कायमस्वरूपी सेव्ह करणे (या नंतर `ROLLBACK` करता येत नाही).
  3. **`ROLLBACK`:** नको असलेले बदल रद्द करून आधीची मूळ स्थिती पूर्ववत करणे.
  4. **`SAVEPOINT`:** ट्रान्झॅक्शनमध्ये चेकपॉईंट तयार करणे, जेणेकरून `ROLLBACK TO savepoint_name` द्वारे फक्त काही बदल रद्द करता येतात.
  5. **`RELEASE SAVEPOINT`:** सेव्हपॉईंट मेमरीमधून काढून टाकणे (बदल रद्द न करता).
* **महत्त्वाचे नियम व मुलाखतीचे प्रश्न (Interview Gotchas):**
  * **Autocommit:** MySQL मध्ये `autocommit = 1` बाय-डिफॉल्ट असतो; `SET autocommit = 0;` केल्यास मॅन्युअल कमिट आवश्यक असतो.
  * **Implicit Commit Trap:** ट्रान्झॅक्शन दरम्यान DDL कमांड (`CREATE`, `ALTER`, `TRUNCATE`) आल्यास मागील सर्व बदल आपोआप कमिट होतात आणि नंतर `ROLLBACK` चालत नाही.
  * **Deadlock (Error 1213):** दोन ट्रान्झॅक्शन एकमेकांच्या लॉक्सची वाट पाहत अडकल्यास InnoDB स्वयंचलितपणे एका ट्रान्झॅक्शनला रोलबॅक करतो.
  * **Pessimistic Locking:** `SELECT ... FOR UPDATE` द्वारे रो लॉक करणे.
  * **Undo Log vs. Redo Log:** अंडू लॉग (Undo Log) मुळे Atomicity व Rollback शक्य होते, तर रिडू लॉग (Redo Log / WAL) मुळे Durability व क्रॅश रिकव्हरी शक्य होते.
  * **DELETE vs TRUNCATE:** `DELETE` ट्रान्झॅक्शनमध्ये रोलबॅक करता येतो, पण `TRUNCATE` (DDL असल्यामुळे) रोलबॅक करता येत नाही.
* **आयसोलेशन लेव्हल्स (Isolation Levels):**
  * MySQL चे बाय-डिफॉल्ट आयसोलेशन लेव्हल **`REPEATABLE READ`** असते, जे डर्टी रीड आणि नॉन-रिपीटएबल रीड रोखते.

---

## Topic 13: Commands to Query Data (DQL In-Depth, Clauses & Filtering)

### 13.1 Commands to Query Data & What is DQL?

* *Definition: DQL (Data Query Language) is used to search and read data from tables, without changing the data or the table structure.*
  * It can read from one table or combine many tables.
  * The primary and fundamental command of DQL is **`SELECT`**.

* **Key Characteristics of DQL:**
  * **1. Read-Only Nature:** DQL only reads, filters and shapes data in memory; it never inserts, changes or deletes data on disk.
  * **2. Tabular Result Set (Virtual Table):** Every `SELECT` query returns rows and columns, called a **Result Set** (a temporary table shown to you).
  * **3. Extreme Flexibility:** Can retrieve everything, target specific columns, filter rows (`WHERE`), eliminate duplicates (`DISTINCT`), limit row count (`LIMIT` / `TOP`), sort results (`ORDER BY`), aggregate metrics (`GROUP BY`, `COUNT`, `SUM`), filter aggregates (`HAVING`), and combine multiple related tables (`JOIN`).

---

### 13.2 The Core Mental Model: "Ask Your Data"

![ASK Your Data: The SQL Query Mental Model](./sql_query_mental_model_ask_your_data.svg)

* **Mental Model Breakdown (डेटाशी संवाद साधण्याची संकल्पना):**
  * **1. The Business Question:** A user or application needs specific information (e.g., *"Who are our customers from Germany?"* or *"What is the total sales for this month?"*).
  * **2. The SQL Query:** The question is translated into a structured SQL statement (`SELECT name, country FROM customers WHERE country = 'Germany';`).
  * **3. Database Processing:** The Database Management System (DBMS) locates the target table on disk, reads data blocks into memory, applies the filtering criteria, and keeps only the requested columns.
  * **4. The Result (Answer):** The engine returns a clean, structured tabular result set back to the user's screen or application API.
* **📌 आकृतीचे मराठीत स्पष्टीकरण (Mental Model Summary):**
  * डेटाबेसमध्ये टेबलच्या स्वरूपात कोट्यवधी रेकॉर्ड्स साठवलेले असतात.
  * युझर आपल्या मनात असलेला प्रश्न (Question) SQL क्वेरीच्या (`SELECT ... FROM ... WHERE ...`) माध्यमातून डेटाबेसला विचारतो.
  * डेटाबेस इंजिन त्या क्वेरीवर प्रक्रिया करून फक्त अपेक्षित उत्तर (Answer) एका सुटसुटीत व्हर्च्युअल टेबलच्या (Result Set) रूपात युझरला परत देतो.

---

### 13.3 Commands (to query the data) & Essential Database/Table Setup

Before executing data queries, you need an active database context and a populated table:

#### 1. Show All Databases
* **Concept:** `show all databases`
* **SQL Command:**
  ```sql
  Show databases;
  ```
* **Meaning:** Lists all existing databases currently hosted on the MySQL server instance.

#### 2. Create Database (`my_db`)
* **Concept:** `create database db_name`
* **SQL Command:**
  ```sql
  Create database my_db;
  ```
* **Meaning:** Allocates a new logical database container named `my_db`.

#### 3. Use Selected Database
* **Concept:** `used selected database`
* **SQL Command:**
  ```sql
  Use my_db ;
  ```
* **Meaning:** Switches the active session context to `my_db`. All subsequent table operations and queries run inside this selected database.

#### 4. Drop Database (`my_db`)
* **Concept:** `delete database db_name`
* **SQL Command:**
  ```sql
  Drop database my_db;
  ```
* **Meaning:** Permanently deletes the database `my_db` along with all its tables, views, and data.

#### 5. Generic Table Creation Syntax
* **Raw syntax (from my notes):**
  ```sql
  Create table user(column1 int notNull, column1 datatype constraint. column1 datatype constrain,....);
  ```
* ⚠️ **Note:** The raw syntax above has typos (`notNull` → `NOT NULL`, `.` → `,`, `column1` repeated). Use the formatted version below.
* **Formatted General Blueprint:**
  ```sql
  CREATE TABLE user (
      column1 INT NOT NULL,
      column2 datatype constraint,
      column3 datatype constraint,
      ...
  );
  ```

#### 6. Common MySQL Data Types & Attributes: The Golden Rule
* **Common mySql data types & entity modeling:**
* **Inside table we have attribute:**
  * *So defined that attribute we need to data type to define that attribute.*
  * In relational databases, each column represents a property or attribute (e.g., `first_name`, `dob`, `phone`, `email`).
* **⭐ Data types applied on the column not row:**
  * *Golden Rule: Data types applied on the column not row.*
  * Every cell within a given column must strictly conform to that column's declared data type and constraints across all rows.

#### 7. Create Table in DB Using Following Command:
* **Create table in db using following command:**
  ```sql
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
  ```
* ⚠️ **Note:** This table has a `FOREIGN KEY` to `Branch(branch_id)`, so the `Branch` table must be created first, otherwise MySQL gives an error.
* **Schema Highlights:**
  * `customer_id INT PRIMARY KEY AUTO_INCREMENT`: Unique identifier for each customer that increments automatically.
  * `first_name VARCHAR(100) NOT NULL`: Mandatory customer first name.
  * `dob DATE`: Date of birth formatted as `YYYY-MM-DD`.
  * `gender CHAR(1)`: Single-character code (`'M'`, `'F'`).
  * `branch_id INT`: Foreign key linking customer to the `Branch` table.

#### 8. Insert Data into Table Like:
* **Insert data into table like:**
  ```sql
  INSERT INTO Customer (first_name, last_name, dob, gender, phone, email, address, branch_id) VALUES
  ('Amit', 'Sharma', '1985-06-15', 'M', '9876543210', 'amit.sharma@example.com', 'Andheri, Mumbai', 1),
  ('Priya', 'Singh', '1990-08-22', 'F', '9123456780', 'priya.singh@example.com', 'Salt Lake, Kolkata', 2);
  ```

#### 9. Querying Data from the Database:
* **Raw note:** `Select * form the databaseName;` (correct keyword is `FROM`, and you select from a table, not a database)
  ```sql
  -- Querying within active database:
  SELECT * FROM Customer;

  -- Querying using fully-qualified databaseName.tableName syntax:
  SELECT * FROM my_db.Customer;
  ```

#### 10. Select Top Number of Data (Top-Most Data)
* **Select only the top N rows (top-most data):**
  ```sql
  SELECT `OrderID` FROM `ORDERS` LIMIT 2;
  ```
* **Explanation:**
  * Fetches only the first 2 rows matching the query.
  * In SQL Server / MS Access, the equivalent keyword is `SELECT TOP 2 OrderID FROM ORDERS;`.
  * In MySQL, PostgreSQL, and SQLite, **`LIMIT`** is the standard syntax.

---

### 13.4 SQL Query Clauses (The 9 Building Blocks)

* **Q. What are the main clauses of an SQL query?**

![The 9 Essential SQL Query Clauses](./sql_query_clauses_taxonomy.svg)

* **The 9 Building Blocks of SQL Queries:**

| # | Clause | Syntax Keyword | Core Purpose & Action |
| :--- | :--- | :--- | :--- |
| **1** | **Projection** | `SELECT` | Specifies which columns (attributes) to retrieve and display in the result set. |
| **2** | **Deduplication** | `DISTINCT` | Eliminates duplicate identical rows from the query output. |
| **3** | **Row Restriction** | `TOP` / `LIMIT` | Restricts the maximum number of rows returned (`LIMIT n`). |
| **4** | **Data Source** | `FROM` | Identifies the table(s) from which data must be extracted. |
| **5** | **Relationship** | `JOIN` | Merges rows from two or more tables based on related foreign key columns. |
| **6** | **Row Filtering** | `WHERE` | Filters rows based on individual boolean conditions (predicates). |
| **7** | **Aggregation** | `GROUP BY` | Groups rows sharing identical values into summary rows (e.g., per department). |
| **8** | **Group Filtering**| `HAVING` | Filters summarized groups created by `GROUP BY` using aggregate functions. |
| **9** | **Sorting** | `ORDER BY` | Sorts the final result rows in ascending (`ASC`) or descending (`DESC`) order. |

---

### 13.5 How SQL Works: Written Syntax (Left to Right) vs. Engine Execution Order

* **How we write vs. how it runs:**
  * When writing an SQL query, the human developer types from left to right:
    $$\text{SELECT} \longrightarrow \text{FROM} \longrightarrow \text{WHERE} \longrightarrow \text{GROUP BY} \longrightarrow \text{HAVING} \longrightarrow \text{ORDER BY} \longrightarrow \text{LIMIT}$$
  * **HOWEVER**, inside the database management engine, SQL queries are **NOT physically executed from left to right**!
  * The SQL execution engine follows a strict, logical pipeline order:

```mermaid
flowchart TD
    A["<b>Step 1: FROM</b><br/>Locates and loads source table(s)"] --> B["<b>Step 2: WHERE</b><br/>Filters rows through a condition funnel"]
    B --> C["<b>Step 3: GROUP BY & HAVING</b><br/>Aggregates rows and filters summary groups"]
    C --> D["<b>Step 4: SELECT</b><br/>Evaluates expressions and projects requested columns"]
    D --> E["<b>Step 5: DISTINCT</b><br/>Removes duplicate rows"]
    E --> F["<b>Step 6: ORDER BY</b><br/>Sorts rows ascending or descending"]
    F --> G["<b>Step 7: LIMIT / TOP</b><br/>Restricts total number of rows returned"]

    style A fill:#0284c7,stroke:#38bdf8,stroke-width:2px,color:#fff
    style B fill:#d97706,stroke:#fbbf24,stroke-width:2px,color:#fff
    style C fill:#475569,stroke:#94a3b8,stroke-width:2px,color:#fff
    style D fill:#059669,stroke:#34d399,stroke-width:2px,color:#fff
    style E fill:#475569,stroke:#94a3b8,stroke-width:2px,color:#fff
    style F fill:#7c3aed,stroke:#a78bfa,stroke-width:2px,color:#fff
    style G fill:#0f172a,stroke:#e2e8f0,stroke-width:2px,color:#fff
```

* **Why does `FROM` run first?**
  * The database engine cannot know what columns or conditions exist until it first opens and identifies the source table! Therefore, `FROM` is always step #1.

---

### 13.6 Select Query / Data Retrieve Query: `SELECT *` vs. `SELECT column_name`

* **Select query — two ways to read data:**
  * `Select * form` → correct spelling: `SELECT * FROM ...`
* **Data retrieval queries:**
  * **1. Select * from tableName:**
    * *Gets all columns — everything from the given table.*
  * **2. Select column name:**
    * *Gets only the columns you name.*

![HOW SQL WORKS: SELECT * vs. Specific Columns](./sql_select_all_vs_few_columns_execution.svg)

#### 1. Method ①: Select * from tableName
* *Concept: Get all columns from the table — "Keep All Columns!".*
* **Syntax:**
  ```sql
  SELECT * FROM tableName;
  ```
* **Step-by-Step Execution:**
  * **Step ① (`FROM Table`):** Tells SQL where to find your data.
  * **Step ② (`SELECT *`):** The asterisk (`*`) is a wildcard that instructs the engine to keep all columns defined in the table.

* **Q1. Retrieve all data from the customers table and the orders table.**
  ```sql
  SELECT * FROM customers;
  SELECT * FROM orders;
  ```

#### 2. Method ②: Select column name
* *Concept: Get only the columns you need — "Keep only needed columns".*
* **Syntax:**
  ```sql
  SELECT column1, column2, column3 FROM tableName;
  ```
* **Step-by-Step Execution:**
  * **Step ① (`FROM Table`):** Locates table in the database.
  * **Step ② (`SELECT col1, col2`):** Extracts and projects only the designated attributes, ignoring unnecessary columns.

* **Q2. Retrieve each customer name, country, and score**
  ```sql
  SELECT first_name, country, score FROM customers;
  ```

#### 3. Comparison: `SELECT *` vs. Specific Column Projection

| Dimension | `SELECT *` (All Columns) | `SELECT col1, col2` (Specific Projection) |
| :--- | :--- | :--- |
| **Data Returned** | Returns 100% of columns in table | Returns only explicitly requested columns |
| **Network Payload** | High byte size; transfers unneeded data | Minimal byte size; transfers only required data |
| **Performance** | Slower over network; disk page scanning | Faster; can leverage memory **Covering Indexes** |
| **Best Used For** | Ad-hoc queries, debugging, schema exploration | **Production code**, web APIs, microservices, reporting |

---

### 13.7 Filtering Data & The WHERE Clause In-Depth

* **Filtering Data (The WHERE Clause):**
  * *In databases, filtering means retrieving only the rows (records) that match specific conditions instead of fetching everything.*
  * *The WHERE clause is used to filter data using different types of operators.*
  * *Core Definition:* **Filtering = Applying boolean conditions (predicates) to select only the rows you need from a database table.**
  * The `WHERE` clause acts as a sieve / gatekeeper: it evaluates a boolean test for every single row in the source table.
    * If the condition evaluates to **`TRUE`**, the row is **kept** and moves to the next execution stage.
    * If the condition evaluates to **`FALSE`** or **`UNKNOWN`** (involving `NULL`), the row is **discarded**.

![SQL WHERE Clause: Operator Taxonomy & Classification](./sql_where_operators_taxonomy.svg)

---

#### 13.7.1 The 5 Families of WHERE Clause Operators

* The `WHERE` clause filters data using 5 specialized families of operators:

| # | Operator Family | Operators / Keywords | Core Purpose & Action | SQL Syntax Example |
| :--- | :--- | :--- | :--- | :--- |
| **1** | **Comparison Operators** | `=`, `!=`, `<>`, `>`, `>=`, `<`, `<=` | Compares two expressions, columns, or literal values to test equality or magnitude. | `WHERE score > 500` |
| **2** | **Logical Operators** | `AND`, `OR`, `NOT` | Combines multiple conditions or negates a condition using boolean algebra. | `WHERE country = 'USA' AND score >= 500` |
| **3** | **Range Operator** | `BETWEEN ... AND ...` | Filters values falling within an inclusive lower and upper boundary range. | `WHERE score BETWEEN 500 AND 900` |
| **4** | **Membership Operator** | `IN (...)`, `NOT IN (...)` | Checks if a value matches any item within a specified discrete list or subquery set. | `WHERE country IN ('USA', 'Germany', 'UK')` |
| **5** | **Search Operator** | `LIKE` (with `%`, `_`) | Performs string pattern matching using SQL wildcards (`%` for any characters, `_` for one). | `WHERE first_name LIKE 'J%'` |

---

#### 13.7.2 Comparison Operators: Compare Two Things!

* **What is a Comparison Operator?**
  * *Definition: Comparison operators are used to compare two things (values, columns, expressions, functions, or subqueries).*
  * A comparison operator evaluates the relationship between two expressions and returns a boolean state: **`TRUE`**, **`FALSE`**, or **`UNKNOWN`**.

![Comparison Operators: Anatomy & Master Reference](./sql_comparison_operators_guide.svg)

##### 1. Anatomy of a Condition
* Every comparison condition follows a strict 3-part syntax structure:
  $$\text{Condition} \longrightarrow \mathbf{\text{Expression 1}}\;\;[\mathbf{\text{Comparison Operator}}]\;\;\mathbf{\text{Expression 2}}$$

##### 2. The 5 Ways to Compare Two Things in SQL
SQL allows flexible comparisons across different types of operands:

1. **Column1 = Column2 (Compare Two Attributes):**
   * Compares the value in one column with the value in another column within the same row.
   ```sql
   SELECT * FROM customers WHERE first_name = last_name;
   ```
2. **Column1 = Value (Compare Attribute to Constant Literal):**
   * Compares a column against a literal string, number, or date.
   ```sql
   SELECT * FROM customers WHERE first_name = 'John';
   SELECT * FROM customers WHERE country = 'USA';
   ```
3. **Function = Value (Compare Transformed Column to Constant):**
   * Applies a built-in SQL function (e.g., `UPPER()`, `LOWER()`, `LENGTH()`) before testing the condition.
   ```sql
   SELECT * FROM customers WHERE UPPER(first_name) = 'JOHN';
   ```
4. **Expression = Value (Compare Mathematical Calculation to Constant):**
   * Computes an arithmetic expression across columns and compares the calculated result.
   ```sql
   SELECT * FROM orders WHERE price * quantity = 1000;
   ```
5. **Subquery = Value (Compare Scalar Subquery to Constant — Advanced):**
   * Compares a value against the single scalar output of an inner nested query.
   ```sql
   SELECT * FROM orders WHERE (SELECT AVG(sales) FROM orders) = 1000;
   ```

---

#### 13.7.3 Master Comparison Operators Reference (Definitions & Descriptions)

* Complete technical definitions and plain-English descriptions for all 6 comparison operators:

| Operator Symbol | Name / Operation | Definition & Description | SQL Query Example | Condition Evaluated | Surviving Rows |
| :---: | :--- | :--- | :--- | :--- | :--- |
| **`=`** | **Equal to** | **Checks if two values are equal.**<br/>Returns `TRUE` if the left operand has exactly the same value as the right operand; otherwise returns `FALSE`. | `SELECT * FROM customers WHERE country = 'USA';` | `country = 'USA'` | Rows where `country` is exactly `'USA'` (e.g., John, Peter). |
| **`!=`**<br/>**`<>`** | **Not equal to** | **Checks if two values are not equal.**<br/>Returns `TRUE` if the left operand is not equal to the right operand.<br/>*Note: `<>` is the official **ISO/ANSI SQL standard** operator, while `!=` is the widely supported industry alias.* | `SELECT * FROM customers WHERE score != 0;`<br/>`SELECT * FROM customers WHERE score <> 0;` | `score != 0`<br/>`score <> 0` | All rows where `score` is any number other than 0. |
| **`>`** | **Greater than** | **Checks if a value is greater than another value.**<br/>Returns `TRUE` strictly when the left operand has a numerically or alphabetically larger value than the right operand. | `SELECT * FROM customers WHERE score > 500;` | `score > 500` | Rows where `score` is strictly greater than 500 (e.g., 750, 900). **Excludes 500.** |
| **`>=`** | **Greater than or equal to** | **Checks if a value is greater than or equal to another value.**<br/>Returns `TRUE` if the left operand is either strictly larger than or exactly equal to the right operand. | `SELECT * FROM customers WHERE score >= 500;` | `score >= 500` | Rows where `score` is 500 or higher (e.g., 500, 750, 900). **Includes 500.** |
| **`<`** | **Less than** | **Checks if a value is less than another value.**<br/>Returns `TRUE` strictly when the left operand has a numerically or alphabetically smaller value than the right operand. | `SELECT * FROM customers WHERE score < 500;` | `score < 500` | Rows where `score` is strictly less than 500 (e.g., 0, 350). **Excludes 500.** |
| **`<=`** | **Less than or equal to** | **Checks if a value is less than or equal to another value.**<br/>Returns `TRUE` if the left operand is either strictly smaller than or exactly equal to the right operand. | `SELECT * FROM customers WHERE score <= 500;` | `score <= 500` | Rows where `score` is 500 or lower (e.g., 0, 350, 500). **Includes 500.** |

> [!WARNING]
> **Technical Gotcha: Three-Valued Logic & NULL Values**
> In SQL, `NULL` represents an *unknown* or *missing* value, not zero or an empty string.
> Because of this, comparing any value to `NULL` using `=` or `!=` evaluates to **`UNKNOWN`**, never `TRUE`:
> * `score = NULL` $\longrightarrow$ **UNKNOWN (Evaluates as Falsey, returns 0 rows)**
> * `score != NULL` $\longrightarrow$ **UNKNOWN (Evaluates as Falsey, returns 0 rows)**
> **The Golden Rule:** *Always use `IS NULL` or `IS NOT NULL` when checking for missing values in SQL!*

---

#### 13.7.4 Internal Filtering Process (Row-by-Row Predicate Evaluation)

* Let us see how the database engine evaluates conditions row-by-row in memory.

![Row-by-Row Predicate Filtering: WHERE Country = 'USA'](./sql_where_country_filter_evaluation.svg)

##### Demonstration 1: String Equality Predicate (`WHERE Country = 'USA'`)
* Consider the query:
  ```sql
  SELECT name, country, score 
  FROM customers 
  WHERE country = 'USA';
  ```
* **Step-by-Step Row Evaluation:**
  1. **Row 1 (`Maria`, `Germany`, `350`):** Evaluates `'Germany' = 'USA'` $\rightarrow$ **`FALSE`** $\rightarrow$ **Row Discarded ❌**
  2. **Row 2 (`John`, `USA`, `900`):** Evaluates `'USA' = 'USA'` $\rightarrow$ **`TRUE`** $\rightarrow$ **Row Kept ✔️**
  3. **Row 3 (`Georg`, `UK`, `750`):** Evaluates `'UK' = 'USA'` $\rightarrow$ **`FALSE`** $\rightarrow$ **Row Discarded ❌**
  4. **Row 4 (`Martin`, `Germany`, `500`):** Evaluates `'Germany' = 'USA'` $\rightarrow$ **`FALSE`** $\rightarrow$ **Row Discarded ❌**
  5. **Row 5 (`Peter`, `USA`, `0`):** Evaluates `'USA' = 'USA'` $\rightarrow$ **`TRUE`** $\rightarrow$ **Row Kept ✔️**

* **Output Result Set:**
  | name | country | score |
  | :--- | :--- | :--- |
  | **John** | USA | 900 |
  | **Peter** | USA | 0 |

---

##### Demonstration 2: Numeric Greater Than Predicate (`WHERE score > 500`)
* Consider the query:
  ```sql
  SELECT name, country, score 
  FROM customers 
  WHERE score > 500;
  ```
* **Step-by-Step Row Evaluation:**
  1. **Row 1 (Maria, 350):** $350 > 500 \rightarrow$ **`FALSE`** $\rightarrow$ **Row Discarded ❌**
  2. **Row 2 (John, 900):** $900 > 500 \rightarrow$ **`TRUE`** $\rightarrow$ **Row Kept ✔️**
  3. **Row 3 (Georg, 750):** $750 > 500 \rightarrow$ **`TRUE`** $\rightarrow$ **Row Kept ✔️**
  4. **Row 4 (Martin, 500):** $500 > 500 \rightarrow$ **`FALSE`** $\rightarrow$ **Row Discarded ❌** *(500 is not strictly greater than 500)*
  5. **Row 5 (Peter, 0):** $0 > 500 \rightarrow$ **`FALSE`** $\rightarrow$ **Row Discarded ❌**

* **Output Result Set:**
  | name | country | score |
  | :--- | :--- | :--- |
  | **John** | USA | 900 |
  | **Georg** | UK | 750 |

---

#### 13.7.5 Practical Practice Questions (Hands-on Comparison Queries)

* **Q1. Retrieve customers where scores are not equal to zero ?**
  ```sql
  -- Standard industry syntax:
  SELECT first_name, score FROM customers WHERE score != 0;

  -- Official ISO/ANSI SQL standard syntax:
  SELECT first_name, score FROM customers WHERE score <> 0;
  ```
  * *Key Takeaway:* Both `!=` and `<>` perform identically in MySQL. `<>` is the ISO/ANSI SQL standard, while `!=` is common in modern programming languages.

* **Q2. Retrieve all customers from Germany ?**
  ```sql
  SELECT * FROM customers WHERE country = 'Germany';
  ```
  * *With column projection (Production Best Practice):*
  ```sql
  SELECT first_name, country, score FROM customers WHERE country = 'Germany';
  ```

* **Q3. Retrieve all customers from USA ?**
  ```sql
  SELECT first_name, country, score FROM customers WHERE country = 'USA';
  ```

* **Q4. Retrieve customers who have scored strictly greater than 500 ?**
  ```sql
  SELECT first_name, score FROM customers WHERE score > 500;
  ```

* **Q5. Retrieve customers who have scored 500 or higher (greater than or equal to 500) ?**
  ```sql
  SELECT first_name, score FROM customers WHERE score >= 500;
  ```

* **Q6. Retrieve customers who have scored strictly less than 500 ?**
  ```sql
  SELECT first_name, score FROM customers WHERE score < 500;
  ```

* **Q7. Retrieve customers who have scored 500 or lower (less than or equal to 500) ?**
  ```sql
  SELECT first_name, score FROM customers WHERE score <= 500;
  ```

* **Q8. Retrieve customers whose first name is identical to their last name (Compare Column to Column) ?**
  ```sql
  SELECT * FROM customers WHERE first_name = last_name;
  ```

* **Q9. Retrieve orders where total cost (price * quantity) is equal to 1000 (Compare Expression to Value) ?**
  ```sql
  SELECT order_id, product_name, price, quantity, (price * quantity) AS total_amount 
  FROM orders 
  WHERE price * quantity = 1000;
  ```

---

#### 13.7.6 Logical Operators In-Depth (AND, OR, NOT)

* **What are Logical Operators?**
  * *Definition: Logical operators in SQL are used to combine multiple conditions or negate a condition in the `WHERE` clause.*
  * They evaluate individual condition predicates using formal boolean logic and determine whether a row meets the overall criteria to be included in the result set.

![Logical Operators Master Reference Table](./sql_logical_operators_table.svg)

* **Summary Recap of the 3 Core Logical Operators:**
  * **`AND`** : **All conditions must be TRUE** (Returns the row only if every single condition evaluates to `TRUE`).
  * **`OR`**  : **At least one condition must be TRUE** (Returns the row if any condition evaluates to `TRUE`).
  * **`NOT`** : **Reverse the condition** (Excludes matching values; inverts `TRUE` to `FALSE` and `FALSE` to `TRUE`).

---

##### 1. The `AND` Operator

* **Definition & Meaning:**
  * Combines two or more conditions.
  * The row is returned **only if all conditions are true**.
  * If even a single condition evaluates to `FALSE`, the entire combined expression evaluates to `FALSE` and the row is discarded.

![Logical Operator: AND Evaluation](./sql_logical_operators_and_evaluation.svg)

* **Mathematical Truth Table for `AND`:**
  | Condition 1 | Condition 2 | Combined (`Cond1 AND Cond2`) | Row Evaluation Action |
  | :---: | :---: | :---: | :---: |
  | **`TRUE`** | **`TRUE`** | **`TRUE`** | **Row Kept in Result Set ✔️** |
  | **`TRUE`** | `FALSE` | `FALSE` | Row Discarded ❌ |
  | `FALSE` | **`TRUE`** | `FALSE` | Row Discarded ❌ |
  | `FALSE` | `FALSE` | `FALSE` | Row Discarded ❌ |

* **Hands-on Query Example:**
  ```sql
  SELECT * FROM customers 
  WHERE country = 'USA' AND score > 500;
  ```
* **Step-by-Step Row Evaluation:**
  1. **Maria** (`Germany`, `350`): `'Germany' = 'USA'` (❌) AND `350 > 500` (❌) $\rightarrow$ `FALSE` $\rightarrow$ **Discarded ❌**
  2. **John** (`USA`, `900`): `'USA' = 'USA'` (✔️) AND `900 > 500` (✔️) $\rightarrow$ **`TRUE`** $\rightarrow$ **Row Kept ✔️**
  3. **Georg** (`UK`, `750`): `'UK' = 'USA'` (❌) AND `750 > 500` (✔️) $\rightarrow$ `FALSE` $\rightarrow$ **Discarded ❌**
  4. **Martin** (`Germany`, `500`): `'Germany' = 'USA'` (❌) AND `500 > 500` (❌) $\rightarrow$ `FALSE` $\rightarrow$ **Discarded ❌**
  5. **Peter** (`USA`, `0`): `'USA' = 'USA'` (✔️) AND `0 > 500` (❌) $\rightarrow$ `FALSE` $\rightarrow$ **Discarded ❌**
* **Surviving Result Set:**
  | name | country | score |
  | :--- | :--- | :--- |
  | **John** | USA | 900 |

---

##### 2. The `OR` Operator

* **Definition & Meaning:**
  * Combines conditions.
  * The row is returned **if at least one condition is true**.
  * Evaluates to `FALSE` only when **all** combined conditions evaluate to `FALSE`.

![Logical Operator: OR Evaluation](./sql_logical_operators_or_evaluation.svg)

* **Mathematical Truth Table for `OR`:**
  | Condition 1 | Condition 2 | Combined (`Cond1 OR Cond2`) | Row Evaluation Action |
  | :---: | :---: | :---: | :---: |
  | **`TRUE`** | **`TRUE`** | **`TRUE`** | **Row Kept in Result Set ✔️** |
  | **`TRUE`** | `FALSE` | **`TRUE`** | **Row Kept in Result Set ✔️** |
  | `FALSE` | **`TRUE`** | **`TRUE`** | **Row Kept in Result Set ✔️** |
  | `FALSE` | `FALSE` | `FALSE` | Row Discarded ❌ |

* **Hands-on Query Example:**
  ```sql
  SELECT * FROM customers 
  WHERE country = 'USA' OR score > 500;
  ```
* **Step-by-Step Row Evaluation:**
  1. **Maria** (`Germany`, `350`): Neither condition is true $\rightarrow$ `FALSE` $\rightarrow$ **Discarded ❌**
  2. **John** (`USA`, `900`): Both conditions are true $\rightarrow$ **`TRUE`** $\rightarrow$ **Row Kept ✔️**
  3. **Georg** (`UK`, `750`): `score > 500` is true $\rightarrow$ **`TRUE`** $\rightarrow$ **Row Kept ✔️**
  4. **Martin** (`Germany`, `500`): Neither condition is true (500 is not > 500) $\rightarrow$ `FALSE` $\rightarrow$ **Discarded ❌**
  5. **Peter** (`USA`, `0`): `country = 'USA'` is true $\rightarrow$ **`TRUE`** $\rightarrow$ **Row Kept ✔️**
* **Surviving Result Set:**
  | name | country | score |
  | :--- | :--- | :--- |
  | **John** | USA | 900 |
  | **Georg** | UK | 750 |
  | **Peter** | USA | 0 |

---

##### 3. The `NOT` Operator

* **Definition & Meaning:**
  * Negates a condition.
  * Returns rows where the condition is **false** (reverses the boolean state).
  * Excludes matching values from the result set.

![Logical Operator: NOT Evaluation](./sql_logical_operator_not_evaluation.svg)

* **Mathematical Truth Table for `NOT`:**
  | Inner Condition Predicate | Combined State (`NOT Condition`) | Row Evaluation Action |
  | :---: | :---: | :---: |
  | **`TRUE`** | `FALSE` | Row Discarded ❌ (Excluded) |
  | `FALSE` | **`TRUE`** | **Row Kept in Result Set ✔️** |

* **Hands-on Query Example:**
  ```sql
  SELECT * FROM customers 
  WHERE NOT (country = 'USA');
  ```
* **Step-by-Step Row Evaluation:**
  1. **Maria** (`Germany`): `'Germany' = 'USA'` is `FALSE` $\rightarrow$ `NOT FALSE` = **`TRUE`** $\rightarrow$ **Row Kept ✔️**
  2. **John** (`USA`): `'USA' = 'USA'` is `TRUE` $\rightarrow$ `NOT TRUE` = `FALSE` $\rightarrow$ **Discarded ❌**
  3. **Georg** (`UK`): `'UK' = 'USA'` is `FALSE` $\rightarrow$ `NOT FALSE` = **`TRUE`** $\rightarrow$ **Row Kept ✔️**
  4. **Martin** (`Germany`): `'Germany' = 'USA'` is `FALSE` $\rightarrow$ `NOT FALSE` = **`TRUE`** $\rightarrow$ **Row Kept ✔️**
  5. **Peter** (`USA`): `'USA' = 'USA'` is `TRUE` $\rightarrow$ `NOT TRUE` = `FALSE` $\rightarrow$ **Discarded ❌**
* **Surviving Result Set:**
  | name | country | score |
  | :--- | :--- | :--- |
  | **Maria** | Germany | 350 |
  | **Georg** | UK | 750 |
  | **Martin** | Germany | 500 |

* **Equivalence Note:**
  * `WHERE NOT (country = 'USA')` is functionally identical to `WHERE country != 'USA'` or `WHERE country <> 'USA'`.

---

#### 13.7.7 Range Operator In-Depth: `BETWEEN ... AND ...`

* **What is the `BETWEEN` Operator?**
  * *Definition:* The `BETWEEN … AND …` operator checks if a value is **within a range or not**.
  * The `BETWEEN … AND …` operator is used in SQL to filter a range of values.
  * **It includes the lower and upper bounds (both ends are inclusive).**
  * **Works with numbers, dates, or text:**
    * **Numbers:** Filters values within numeric boundaries (e.g., `score BETWEEN 100 AND 500`).
    * **Dates:** Filters records within temporal dates (e.g., `order_date BETWEEN '2025-01-01' AND '2025-12-31'`).
    * **Text:** Filters strings based on dictionary alphabetical sorting (e.g., `last_name BETWEEN 'A' AND 'M'`).

![Range Operator: BETWEEN Evaluation](./sql_range_operator_between_evaluation.svg)

##### 1. Inclusive Nature (Both Ends are Inclusive)
* In SQL, `BETWEEN` is strictly **inclusive** on both boundaries:
  $$\text{value} \ge \text{lower\_boundary}\quad \mathbf{AND}\quad \text{value} \le \text{upper\_boundary}$$
* For example, if a record's score is exactly `100` or exactly `500`, **both boundary values are retained**.

##### 2. To Achieve `BETWEEN` Operator Using `AND` & Comparison Operators
* It is very similar to explicitly declaring the lower boundary and higher boundary using comparison operators:
  ```sql
  -- Syntax using BETWEEN operator:
  SELECT * FROM customers WHERE score BETWEEN 100 AND 500;

  -- Syntax using comparison operators with AND:
  SELECT * FROM customers WHERE score >= 100 AND score <= 500;
  ```
* **Above command is also exactly the same as the `BETWEEN` command!**
* Inside the database engine, the SQL query optimizer evaluates both queries to the exact same execution plan.

##### 3. Step-by-Step Row Evaluation (`WHERE score BETWEEN 100 AND 500`)
* Let us evaluate each record from our `customers` table against the range $[100, 500]$:
  1. **Maria** (`350`): $100 \le 350 \le 500$ is **`TRUE`** $\rightarrow$ **Row Kept ✔️**
  2. **John** (`900`): $900 > 500$ (above upper boundary) is `FALSE` $\rightarrow$ **Discarded ❌**
  3. **Georg** (`750`): $750 > 500$ (above upper boundary) is `FALSE` $\rightarrow$ **Discarded ❌**
  4. **Martin** (`500`): $500 = 500$ (matches exact upper inclusive bound!) is **`TRUE`** $\rightarrow$ **Row Kept ✔️**
  5. **Peter** (`0`): $0 < 100$ (below lower boundary) is `FALSE` $\rightarrow$ **Discarded ❌**

* **Output Result Set:**
  | name | country | score |
  | :--- | :--- | :--- |
  | **Maria** | Germany | 350 |
  | **Martin** | Germany | 500 |

##### 4. Negating a Range: `NOT BETWEEN … AND …`
* The `NOT BETWEEN` operator retrieves all rows that fall **outside** the specified range:
  ```sql
  SELECT * FROM customers WHERE score NOT BETWEEN 100 AND 500;
  ```
  * *Equivalent Comparison Syntax:*
  ```sql
  SELECT * FROM customers WHERE score < 100 OR score > 500;
  ```
  * *Surviving Records:* **Peter** (0), **Georg** (750), and **John** (900).

---

#### 13.7.8 Membership Operator In-Depth: IN and NOT IN

* **What is the Membership Operator?**
  * *Definition:* The Membership Operator (`IN` / `NOT IN`) tests whether a specific operand or column value exists within a specified list, set of discrete values, or subquery result set.
  * It is also widely known as a **set filter operator**.
  * It checks if a value exists in a list, or in a simple way, whether a value is an active **member of a list**.

* **1. List: The `IN (...)` Operator**
  * *Definition:* The `IN` operator is used to filter records where a column’s value matches **any value** from a given list.
  * It is like writing multiple `OR` conditions in a much shorter, cleaner, and optimized way.
  * *Standard Syntax:*
    ```sql
    column_name IN (value1, value2, value3, ...)
    ```
  * *Hands-on Query Example:*
    ```sql
    SELECT * FROM customers 
    WHERE country IN ('Germany', 'USA');
    ```
  * *Crucial Best Practice Note:*
    * **Use `IN` instead of `OR` for multiple values in the same column to simplify SQL!**
    * Verbose query using multiple `OR` conditions:
      ```sql
      SELECT * FROM customers 
      WHERE country = 'Germany' OR country = 'USA';
      ```
    * Instead of writing multiple verbose `OR` statements, use the standardized `IN` operator:
      ```sql
      SELECT * FROM customers 
      WHERE country IN ('Germany', 'USA');
      ```
    * Both queries produce identical results and query execution plans in the database engine, but `IN` is far cleaner, easier to read, and simpler to maintain when filtering across many items.

* **2. List: The `NOT IN (...)` Operator**
  * *Definition:* The `NOT IN` operator is used to filter records where a column’s value is **not present** in a given list (or subquery).
  * It checks that values do **not exist** in the list.
  * In a simple way: it returns those records whose column value is **not in the member list**.
  * It is simply the exact boolean opposite of `IN`.
  * *Standard Syntax:*
    ```sql
    column_name NOT IN (value1, value2, value3, ...)
    ```
  * *Hands-on Query Example:*
    ```sql
    SELECT * FROM customers 
    WHERE country NOT IN ('Germany', 'USA');
    ```

![Membership Operators: IN & NOT IN Evaluation](./sql_membership_operators_in_evaluation.svg)

* **3. Step-by-Step Row Evaluation (`IN` vs. `NOT IN`)**
  * Target Filter List: `('Germany', 'USA')`
  * Evaluating each record from our `customers` table:
    1. **Maria** (`Germany`): `'Germany'` exists in `('Germany', 'USA')` $\rightarrow$ `IN` = **`TRUE` ✔️ (Kept)** | `NOT IN` = `FALSE` ❌ (Discarded)
    2. **John** (`USA`): `'USA'` exists in `('Germany', 'USA')` $\rightarrow$ `IN` = **`TRUE` ✔️ (Kept)** | `NOT IN` = `FALSE` ❌ (Discarded)
    3. **Georg** (`UK`): `'UK'` does NOT exist in `('Germany', 'USA')` $\rightarrow$ `IN` = `FALSE` ❌ (Discarded) | `NOT IN` = **`TRUE` ✔️ (Kept)**
    4. **Martin** (`Germany`): `'Germany'` exists in `('Germany', 'USA')` $\rightarrow$ `IN` = **`TRUE` ✔️ (Kept)** | `NOT IN` = `FALSE` ❌ (Discarded)
    5. **Peter** (`USA`): `'USA'` exists in `('Germany', 'USA')` $\rightarrow$ `IN` = **`TRUE` ✔️ (Kept)** | `NOT IN` = `FALSE` ❌ (Discarded)

* **Output Result Set Comparison:**
  * **Result of `WHERE country IN ('Germany', 'USA')`:**
    | name | country | score |
    | :--- | :--- | :--- |
    | **Maria** | Germany | 350 |
    | **John** | USA | 900 |
    | **Martin** | Germany | 500 |
    | **Peter** | USA | 0 |

  * **Result of `WHERE country NOT IN ('Germany', 'USA')`:**
    | name | country | score |
    | :--- | :--- | :--- |
    | **Georg** | UK | 750 |

* **4. Critical Interview Trap: The `NOT IN` with `NULL` Trap (Three-Valued Logic Danger)**
  * **The Classic Interview Question:**
    ```sql
    -- Suppose you have customer IDs 1, 2, 3, 4, 5. What does this return?
    SELECT * FROM customers 
    WHERE id NOT IN (1, 2, NULL);
    ```
  * **Common Mistake:** Most candidates guess it returns customers with IDs 3, 4, and 5.
  * **The True Answer:** **It returns ZERO rows (Empty Result Set)!**
  * **Internal Boolean Mechanics (Why it fails):**
    * The SQL engine expands `id NOT IN (1, 2, NULL)` using boolean algebra into chained `AND` comparisons:
      $$\text{id} \ne 1 \quad\mathbf{AND}\quad \text{id} \ne 2 \quad\mathbf{AND}\quad \text{id} \ne \mathbf{NULL}$$
    * Under SQL **Three-Valued Logic (3VL)**, comparing anything to `NULL` via `!=` produces **`UNKNOWN`** (neither `TRUE` nor `FALSE`).
    * In boolean `AND` logic:
      $$\text{TRUE} \quad\mathbf{AND}\quad \text{TRUE} \quad\mathbf{AND}\quad \mathbf{UNKNOWN} \quad\Longrightarrow\quad \mathbf{UNKNOWN}$$
    * The `WHERE` clause **only emits rows where the predicate evaluates to strictly `TRUE`**. Because `UNKNOWN` is never `TRUE`, **every single row in the table is discarded**!
  * **Production Best Practice / Safe Solution:**
    1. Filter out `NULL`s explicitly when using subqueries or lists:
       ```sql
       SELECT * FROM customers 
       WHERE id NOT IN (SELECT customer_id FROM orders WHERE customer_id IS NOT NULL);
       ```
    2. Or use the safer **`NOT EXISTS`** clause, which is immune to `NULL` pitfalls.

---

#### 13.7.9 Search Operator In-Depth: LIKE and NOT LIKE (Pattern Matching)

* **What is the Search Operator (`LIKE`)?**
  * *Definition:* The `LIKE` operator is used in SQL to search for a pattern in text (instead of requiring an exact equality match with `=`).
  * It is often combined with **wildcards** to provide flexible string matching.

* **Understanding SQL Wildcards:**
  * A wildcard character is a special placeholder symbol used in search strings.
  * The two core SQL wildcards are:
    1. **Percent (`%`) Wildcard:** Matches **zero, one, or multiple characters** (represents zero or more characters).
    2. **Underscore (`_`) Wildcard:** Matches **exactly one character** (represents a single character at a specific position).

![Search Operator: LIKE & SQL Wildcards](./sql_search_operator_like_wildcards.svg)

* **1. Detailed Point-Wise Explanation of `%` (Zero or More Characters):**
  * `SELECT * FROM Customer WHERE name LIKE 'A%';`
    * **Action:** Starts with "A".
    * **Point-wise Explanation:** Matches any name starting with the letter 'A', followed by zero, one, or multiple characters (e.g., *Alice*, *Albert*, *An*, or just *A*).
  * `SELECT * FROM Customer WHERE name LIKE '%a';`
    * **Action:** Name ends with "a".
    * **Point-wise Explanation:** Matches any name that terminates with the letter 'a', regardless of how many characters precede it (e.g., *Maria*, *Anna*, *Emma*).
  * `SELECT * FROM Customer WHERE name LIKE '%it%';`
    * **Action:** Find name containing "it" anywhere.
    * **Point-wise Explanation:** Matches any name containing the substring "it" in any position — beginning, middle, or end (e.g., *Rohit*, *Mohit*, *Martin*).

* **2. Detailed Point-Wise Explanation of `_` (Exactly One Character):**
  * `SELECT * FROM Customer WHERE name LIKE '_ohit';`
    * **Action:** Finds names where the second to fifth characters are "ohit".
    * **Point-wise Explanation:** The leading underscore represents exactly one single character, so it matches 5-letter names like *Rohit* or *Mohit*.
  * `SELECT * FROM Customer WHERE name LIKE 'A_i_';`
    * **Action:** Exact match for 4-letter names starting with "A" and having "i" as the third letter.
    * **Point-wise Explanation:** The total length must be exactly 4 characters: 1st is 'A', 2nd is any character, 3rd is 'i', and 4th is any character (e.g., *Amir*, *Abid*).
  * `SELECT * FROM Customer WHERE name LIKE 'S_ne%';`
    * **Action:** Matches names starting with "S", followed by any one character, then "ne", and anything after.
    * **Point-wise Explanation:** 1st letter 'S', 2nd letter is any 1 char (`_`), 3rd & 4th are 'ne', followed by zero or more characters (`%`) (e.g., *Sanel*, *Soney*, *Sinead*).

* **3. Master Pattern Reference Table:**
  | Pattern Expression | Description & Rule | Matching Examples | Non-Matching Examples |
  | :--- | :--- | :--- | :--- |
  | `LIKE 'a%'` | Start with "a" | `adam`, `alice`, `amber` | `maria`, `john` |
  | `LIKE '%a'` | End with "a" | `maria`, `emma`, `anna` | `martin`, `peter` |
  | `LIKE '%am%'` | Have "am" in any position | `sam`, `adam`, `pamela` | `georg`, `john` |
  | `LIKE 'a%m'` | Start with "a" and Ends with "m" | `adam`, `abraham`, `am` | `alice`, `martin` |
  | `LIKE '_a%'` | "a" in the **second position** | `maria`, `james`, `david` | `alice`, `georg` |
  | `LIKE '__a%'` | "a" in the **third position** | `clara`, `charlie`, `brandon` | `maria`, `john` |
  | `LIKE '_oy'` | "o" in the second and "y" in third position (exact 3 chars) | `roy`, `joy`, `boy` | `troy` (4 chars), `ray` |

* **4. Detailed 4-Column Visual Pattern Breakdown:**
  * **Column 1: `LIKE 'M%'` (1st Character is 'M', followed by Any characters):**
    * ✔️ **Maria** (Starts with M, followed by 'aria')
    * ✔️ **Ma** (Starts with M, followed by 'a')
    * ✔️ **M** (Starts with M, followed by 0 characters — valid because `%` allows 0 characters!)
    * ❌ **Emma** (Starts with 'E', discarded)
  * **Column 2: `LIKE '%in'` (Any characters, ending with "in"):**
    * ✔️ **Martin** (Ends with 'in')
    * ✔️ **Vin** (Ends with 'in')
    * ✔️ **in** (Matches exact 'in' with 0 preceding characters)
    * ❌ **Jasmine** (Ends with 'e', not 'in', discarded)
  * **Column 3: `LIKE '%r%'` (Any characters, contains "r", followed by Any characters):**
    * ✔️ **Maria** (Contains 'r' in middle)
    * ✔️ **Peter** (Contains 'r' at end)
    * ✔️ **Rayn** (Contains 'R' at start — MySQL's default comparison is case-insensitive, so `'r'` matches `'R'`)
    * ✔️ **R** (Matches single 'R')
    * ❌ **Alice** (Contains no 'r', discarded)
  * **Column 4: `LIKE '__b%'` (1st: any, 2nd: any, 3rd: must be "b", followed by Any):**
    * ✔️ **Albert** (1: A, 2: l, **3: b**, followed by 'ert')
    * ✔️ **Rob** (1: R, 2: o, **3: b**, followed by 0 chars)
    * ❌ **Abel** ('b' is in 2nd position, not 3rd, discarded)
    * ❌ **An** (Length is only 2 characters, discarded)

* **5. Using the `NOT LIKE` Operator:**
  * *Definition:* The `NOT LIKE` operator is used to return rows that do **not match** the pattern in the given text.
  * It excludes patterns, i.e., returns those records that do **not** match the pattern.
  * *Syntax Example:*
    ```sql
    SELECT * FROM Customer WHERE name NOT LIKE 'A%';
    ```
    * **Action:** Returns names that do not start with 'A' (e.g., *Maria*, *John*, *Georg*, *Martin*, *Peter*).

* **6. Pattern Matching Quick Recap:**
  * `%` $\rightarrow$ **Many characters** (including zero or one character).
  * `_` $\rightarrow$ **Exactly one character**.
  * `LIKE` $\rightarrow$ **Flexible matching**.
  * `NOT LIKE` $\rightarrow$ **Exclude patterns**.

---

#### 13.7.10 NULL Check Operator In-Depth: IS NULL and IS NOT NULL

* **What is `NULL` in SQL?**
  * *Definition:* `NULL` means **no value / missing value** (not 0, not an empty string, but literally "unknown").
  * `IS NULL` and `IS NOT NULL` are the special operators used to check it.
  * You **cannot** check `NULL` with `=` or `!=` (because in SQL, `NULL = NULL` is never true!).
  * Instead, you **must use `IS NULL` or `IS NOT NULL`**.

* **Why `=` and `!=` Fail with NULL (Three-Valued Logic - 3VL):**
  * In relational database theory, boolean logic has three distinct states:
    $$\textbf{TRUE}, \quad \textbf{FALSE}, \quad \textbf{UNKNOWN}$$
  * Any comparison against `NULL` (including `column = NULL` or `NULL = NULL`) evaluates to **`UNKNOWN`**.
  * The `WHERE` clause strictly filters and passes rows only when the predicate evaluates to **`TRUE`**.
  * Because `UNKNOWN` is not `TRUE`, queries using `= NULL` silently return **0 rows**!

![NULL Check Operators: IS NULL & IS NOT NULL](./sql_null_check_operators_evaluation.svg)

* **1. The `IS NULL` Operator:**
  * *Definition:* Finds rows where the column value is missing or `NULL`.
  * *Syntax & Query Example:*
    ```sql
    SELECT * FROM Customer 
    WHERE phone_number IS NULL;
    ```
  * *Action:* Retrieves all customers who do not have a recorded phone number in the database.

* **2. The `IS NOT NULL` Operator:**
  * *Definition:* Finds rows where the column value is not `NULL` (i.e., a valid value is present).
  * *Syntax & Query Example:*
    ```sql
    SELECT * FROM Customer 
    WHERE email IS NOT NULL;
    ```
  * *Action:* Retrieves all customers whose email address is present and recorded in the database.

* **3. Key Points to Remember:**
  * **`NULL ≠ 0`** (0 is a defined number; NULL is the absence of data).
  * **`NULL ≠ ''` (empty string)** (An empty string is a valid text string of length 0; NULL is unknown/absent).
  * **Must use `IS NULL` / `IS NOT NULL` for checking.**

---

#### 13.7.11 Advanced Filtering: Aggregates with HAVING and Subqueries

* Beyond basic row-level filters in `WHERE`, real-world SQL relies on two advanced filtering mechanisms:

* **1. Aggregate Functions with `HAVING` (Filtering After Grouping):**
  * The `WHERE` clause filters individual rows **before** any grouping or aggregation takes place.
  * The `HAVING` clause filters summarized groups **after** `GROUP BY` has aggregated the rows.
  * *Example comparing Row Filtering vs. Group Filtering:*
    ```sql
    -- 1. Row-level filter using WHERE:
    SELECT * FROM Customer 
    WHERE city = 'Mumbai';

    -- 2. Aggregate-level filter using HAVING:
    SELECT city, COUNT(*) AS total_customers 
    FROM Customer 
    GROUP BY city 
    HAVING COUNT(*) > 5;
    ```
  * **Crucial Rule:** You cannot use aggregate functions like `COUNT()`, `SUM()`, `AVG()` inside a `WHERE` clause (e.g., `WHERE COUNT(*) > 5` will throw a syntax error). You must use `HAVING`.

* **2. Subqueries (Filtering Results Based on Another Query):**
  * A subquery is an inner `SELECT` query nested inside the `WHERE` clause of an outer query.
  * *Example: Filtering with Subquery and IN Operator:*
    ```sql
    -- Filter customers whose country exists in our active priority sales regions:
    SELECT * FROM Customer 
    WHERE country IN (
        SELECT country 
        FROM high_growth_regions 
        WHERE annual_target_met = 1
    );
    ```
  * *Example: Filtering with Scalar Comparison Subquery:*
    ```sql
    -- Find all customers whose score is strictly higher than the overall average score:
    SELECT name, country, score 
    FROM Customer 
    WHERE score > (SELECT AVG(score) FROM Customer);
    ```

---

### 13.8 Sorting Data & The ORDER BY Clause In-Depth

* **What is Sorting in SQL?**
  * *Definition:* Sorting in SQL is performed using the `ORDER BY` clause. It allows us to systematically arrange the output rows of a query in ascending (`ASC`) or descending (`DESC`) order based on one or more specified columns, expressions, or aliases.
  * Without `ORDER BY`, there is **no guaranteed order** — the same query can return rows in a different order next time.

* **How ORDER BY Works (The 2 Core Directions):**
  1. **Ascending (`ASC`):**
     * Sorts from **lowest to highest** (numbers: `0 ➔ 9`, alphabetical text: `A ➔ Z`, chronological dates: oldest to newest).
     * **By default, SQL sorts in ascending order!**
     * *Best Practice:* Always explicitly specify `ASC` in your queries for code readability and team clarity.
  2. **Descending (`DESC`):**
     * Sorts from **highest to lowest** (numbers: `9 ➔ 0`, reverse alphabetical text: `Z ➔ A`, chronological dates: newest to oldest).

* **Single Column Sorting Practice Questions:**
  * **Q1. Retrieve all customers and sort the result by the highest score first:**
    ```sql
    SELECT * FROM customers 
    ORDER BY score DESC;
    ```
  * **Q2. Retrieve all customers and sort the result by the LOWEST score first:**
    ```sql
    SELECT * FROM customers 
    ORDER BY score ASC;
    ```
    *(Note: Writing `ORDER BY score;` also sorts ascending by default, but writing `ORDER BY score ASC;` is preferred).*

![Sorting in SQL: ORDER BY Clause Architecture](./sql_order_by_sorting_execution.svg)

* **Step-by-Step Row Reordering Lifecycle (`ORDER BY score DESC`):**
  * Let us trace how the database engine evaluates and sorts our sample `customers` table:
    * **Step ① (`FROM customers`):** Retrieves the 5 raw records from disk/memory buffers.
    * **Step ② (`SELECT *`):** Picks all columns of each row.
    * **Step ③ (`ORDER BY score DESC`):** Sorts the rows by `score`, highest first, and returns the sorted result to the client.
  * **Reordered Result Set:**
    | id | name | country | score | Sort Position & Action |
    | :---: | :--- | :--- | :---: | :--- |
    | **2** | **John** | USA | **900** | Row 1 (Highest score in table) |
    | **3** | **Georg** | UK | **750** | Row 2 |
    | **4** | **Martin** | Germany | **500** | Row 3 |
    | **1** | **Maria** | Germany | **350** | Row 4 |
    | **5** | **Peter** | USA | **0** | Row 5 (Lowest score in table) |

* **Nested ORDER BY: Multiple Columns Sorting (TO SORT YOUR DATA)**
  * You can sort your data using **multiple columns**, which is referred to as **nested sorting**.
  * **The order of columns in the `ORDER BY` clause is crucial because sorting is strictly sequential!**
  * **Sequential Sorting Mechanics:**
    1. The database engine first sorts the entire dataset by the **first specified column**.
    2. If two or more rows have the **exact same value** in the first column (a tie), the engine uses the **second column as a tie-breaker** to sort only those tied rows.
    3. If ties persist, subsequent columns (3rd, 4th, etc.) are evaluated in sequence.

* **Nested Sorting Practice Question:**
  * **Q1. Retrieve all customers and sort the result by country (alphabetically) and then by highest score:**
    ```sql
    SELECT id, name, country, score 
    FROM customers 
    ORDER BY country ASC, score DESC;
    ```
  * *Additional Example on Customer / City Table:*
    ```sql
    SELECT name, city, score 
    FROM Customer 
    ORDER BY city ASC, score DESC;
    ```
  * **Detailed Execution Breakdown:**
    * **Primary Sort (`country ASC`):** First sorts by country alphabetically: `Germany ➔ UK ➔ USA`.
    * **Secondary Tie-Breaker (`score DESC`):**
      * Within **Germany** (Maria with score 350, Martin with score 500): Since Martin has the higher score, **Martin (500)** appears before **Maria (350)**!
      * Within **UK** (Georg with score 750): Only one record exists.
      * Within **USA** (John with score 900, Peter with score 0): Since John has the higher score, **John (900)** appears before **Peter (0)**!
  * **Output Table for Nested Sort (`country ASC, score DESC`):**
    | id | name | country (ASC) | score (DESC) | Tie-Breaker Observation |
    | :---: | :--- | :--- | :---: | :--- |
    | **4** | **Martin** | Germany | **500** | ▲ Higher score in Germany |
    | **1** | **Maria** | Germany | **350** | ▼ Lower score in Germany |
    | **3** | **Georg** | UK | **750** | Single UK record |
    | **2** | **John** | USA | **900** | ▲ Higher score in USA |
    | **5** | **Peter** | USA | **0** | ▼ Lower score in USA |

* **Operators and Keywords Used in Sorting:**
  * **`ORDER BY`** $\rightarrow$ Main clause used to trigger sorting.
  * **`ASC`** $\rightarrow$ Sorts ascending (`A ➔ Z`, `0 ➔ 9`). Default order.
    ```sql
    SELECT name, city FROM Customer ORDER BY name ASC;
    ```
  * **`DESC`** $\rightarrow$ Sorts descending (`Z ➔ A`, `9 ➔ 0`).
    ```sql
    SELECT name, balance FROM Account ORDER BY balance DESC;
    ```

* **Sorting with Dates:**
  * Dates in SQL can be sorted chronologically using `ASC` (oldest date first) or `DESC` (most recent / newest date first):
    ```sql
    SELECT transaction_id, amount, transaction_date 
    FROM Transaction 
    ORDER BY transaction_date DESC;
    ```
    * *Action:* Places the most recent financial transactions at the top of the report.

* **Sorting with Expressions & Computed Columns:**
  * You can sort by calculated arithmetic expressions or column aliases defined in `SELECT`:
    ```sql
    SELECT name, (salary * 12) AS annual_salary 
    FROM Employee 
    ORDER BY annual_salary DESC;
    ```
    * *Engine Execution Note:* Because `SELECT` executes before `ORDER BY`, column aliases like `annual_salary` are fully recognized and valid in `ORDER BY`!

* **Sorting with NULL Values:**
  * In relational databases, `NULL` represents an unknown/missing state. SQL handles `NULL` values deterministically in sorting:
    * **In `ASC` order (Default):** `NULL` values appear **first** (treated as smaller than any real value in MySQL).
    * **In `DESC` order:** `NULL` values appear **last**.
  * *Pro Tip for Custom NULL Placement:*
    * If you want `ASC` sorting but want `NULL` records placed at the very end, use an `IS NULL` boolean condition:
      ```sql
      SELECT name, score 
      FROM customers 
      ORDER BY score IS NULL ASC, score ASC;
      ```

* **Crucial Interview Concepts in ORDER BY:**
  * **1. Positional Sorting (Ordering by Column Ordinal / Index):**
    * SQL allows sorting using 1-based numerical column position indices corresponding to the `SELECT` list:
      ```sql
      SELECT country, name, score 
      FROM customers 
      ORDER BY 1 ASC, 3 DESC;
      ```
      *(Here, `1` corresponds to `country`, and `3` corresponds to `score`).*
    * **Production Warning (Antipattern):** While valid SQL, positional sorting is strongly discouraged in production code! If a teammate reorders or adds columns in `SELECT` (e.g., adding `id` at position 1), the `ORDER BY 1` silently sorts on the wrong attribute and produces critical reporting bugs.
  * **2. Deterministic vs. Non-Deterministic Sorting (The Tie-Breaker Rule):**
    * If multiple rows have the exact same values across all sorted columns (e.g., Martin and Maria both having identical scores), relational database engines do **not** guarantee a consistent order between queries. The order of tied rows can shift arbitrarily based on table scans, storage pages, or parallel execution threads!
    * **Interview Rule:** To achieve **deterministic, reproducible sorting**, always append a **unique column or Primary Key (`id`)** as the final tie-breaker:
      ```sql
      SELECT id, name, score 
      FROM customers 
      ORDER BY score DESC, id ASC;
      ```

---

### 13.9 Grouping Data & The GROUP BY Clause In-Depth (Data Aggregation)

* **What is Grouping in SQL? (GROUP BY Clause: AGGREGATE YOUR DATA)**
  * *Definition:* Grouping in SQL means **combining multiple rows that have the same values in one or more columns into summary rows**.
  * Using `GROUP BY`, you **aggregate your data based on a column**.
  * `GROUP BY` puts rows with the same value into one group, then an aggregate function (`SUM`, `COUNT`, …) is calculated for each group.
  * **Each distinct group produces exactly ONE summary row in the final result set.**

* **Works with Aggregate Functions:**
  * `GROUP BY` works in tandem with SQL aggregate functions:
    * **`SUM(column)`**: Calculates the sum total of numeric values in each group.
    * **`COUNT(column / *)`**: Counts the number of rows or non-null values in each group.
    * **`AVG(column)`**: Computes the arithmetic mean of values in each group.
    * **`MIN(column)`**: Identifies the minimum value within each group.
    * **`MAX(column)`**: Identifies the maximum value within each group.

* **Crucial Interview Rules & Traps for Aggregate Functions:**
  * **1. Master Rules of `SUM()`:**
    * **Rule ① (`NULL` Handling):** `SUM(column)` completely **ignores `NULL` values** during calculation.
    * **Rule ② (The Empty Table / All-NULL Trap):** If all rows in a group contain `NULL`, or if the table is completely empty, `SUM()` returns **`NULL` (NOT `0`)**!
      * *Production Best Practice:* To guarantee a numeric `0` for executive dashboards, wrap with `COALESCE()` or `IFNULL()`:
        ```sql
        SELECT country, COALESCE(SUM(score), 0) AS total_score 
        FROM customers 
        GROUP BY country;
        ```
    * **Rule ③ (`SUM(DISTINCT col)` vs. `SUM(col)`):**
      * `SUM(score)` sums all values including duplicates (e.g., scores `500, 500, 200` $\rightarrow$ `1200`).
      * `SUM(DISTINCT score)` removes duplicate numbers before calculating (e.g., `500 + 200` $\rightarrow$ `700`).
    * **Rule ④ (Conditional Aggregation with `SUM`):**
      * In MySQL, boolean expressions return `1` (`TRUE`) or `0` (`FALSE`). You can count specific conditions using `SUM()` without a `WHERE` clause:
        ```sql
        -- Counts customers with score > 500 in MySQL:
        SELECT SUM(score > 500) AS high_scorers FROM customers;
        
        -- ANSI SQL Standard equivalent using CASE:
        SELECT SUM(CASE WHEN score > 500 THEN 1 ELSE 0 END) AS high_scorers FROM customers;
        ```

  * **2. The 4 Variants of `COUNT` (Top Interview Comparison):**
    | Function | What it Counts | Counts `NULL`s? | Performance |
    | :--- | :--- | :---: | :--- |
    | **`COUNT(*)`** | Total rows in the table/group | **YES** | Highly optimized by query optimizer |
    | **`COUNT(1)`** | Rows where constant expression `1` is generated | **YES** | Identical execution plan to `COUNT(*)` |
    | **`COUNT(column)`** | Total rows where designated `column` is **NOT NULL** | **NO** (Ignores `NULL`) | Slightly slower (must check column nullability) |
    | **`COUNT(DISTINCT col)`**| Total **unique non-null** values in column | **NO** (Ignores `NULL`) | Requires sorting/hashing in temp buffer |

  * **3. The `AVG()` NULL Trap:**
    * `AVG(column)` calculates mathematically as:
      $$\text{AVG}(\text{column}) = \frac{\text{SUM}(\text{column})}{\mathbf{COUNT}(\mathbf{column})}$$
    * **The Trap:** It divides by the count of **non-null rows**, NOT total rows!
    * *Example:* If 4 employee salaries are `10000`, `20000`, `NULL`, `NULL`:
      * `AVG(salary)` = $\frac{10000 + 20000}{2} =$ **`15000`** (NOT $\frac{30000}{4} = 7500$).
    * *Fix:* If business requirements demand calculating average across the entire workforce (treating non-salaried as 0):
      ```sql
      SELECT AVG(COALESCE(salary, 0)) AS company_wide_avg FROM employees;
      ```

* **Standard GROUP BY Query Syntax:**
  ```sql
  SELECT column1, column2, AGGREGATE_FUNCTION(column3)
  FROM table_name
  [WHERE condition]
  GROUP BY column1, column2
  [HAVING condition]
  [ORDER BY column];
  ```

* **Practice Questions:**
  * **Q1. Find the total score for each country:**
    ```sql
    SELECT country, SUM(score) AS total_score 
    FROM customers 
    GROUP BY country;
    ```
    * **Step-by-Step Row Calculation:**
      * **Germany:** Maria (`350`) + Martin (`500`) = **`850`**
      * **USA:** John (`900`) + Peter (`0`) = **`900`**
      * **UK:** Georg (`750`) = **`750`**
  * **Q2. Find the total score and total number of customers for each country:**
    ```sql
    SELECT country, SUM(score) AS total_score, COUNT(id) AS customer_count 
    FROM customers 
    GROUP BY country;
    ```
    * **Result Set:**
      | country | total_score | customer_count |
      | :--- | :---: | :---: |
      | **Germany** | 850 | 2 |
      | **USA** | 900 | 2 |
      | **UK** | 750 | 1 |

* **Note on Alias (`AS`):**
  * **`AS` (alias):** A shorthand label or user-friendly column title assigned to an expression or table in a query (e.g., `SUM(score) AS total_score`). Improves readability in result headers.

![Grouping in SQL: GROUP BY Clause & Data Aggregation](./sql_group_by_aggregation_execution.svg)

* **Key Rules of GROUP BY in MySQL:**
  * **Rule 1: The Golden Rule of Projection:**
    * **All columns in the `SELECT` list (except aggregate functions) must appear in the `GROUP BY` clause.**
    * I.e., every selected column must be either aggregated or included in `GROUP BY`!
  * **Rule 2: Aggregate functions can be used on non-grouped columns:**
    ```sql
    SELECT department, AVG(salary) 
    FROM employees 
    GROUP BY department;
    ```
    * Here, `department` is the grouping column, and `salary` is aggregated via `AVG()`. This is 100% valid.
  * **Rule 3: Understanding the Non-Aggregated Column Error (`ONLY_FULL_GROUP_BY`):**
    * Suppose you execute the following query:
      ```sql
      -- ❌ INCORRECT QUERY (Throws MySQL Error 1055):
      SELECT first_name, country, SUM(score) 
      FROM customers 
      GROUP BY country;
      ```
      * **Why this produces an error:** In the `SELECT` statement, you defined `first_name`, `country`, and `SUM(score)`. But in `GROUP BY`, you only grouped by `country`. Since Germany has two customers (*Maria* and *Martin*), MySQL does not know which `first_name` should be printed on the single summary row for Germany!
    * **The Correct Resolution:**
      ```sql
      -- ✔️ CORRECT: Include all non-aggregated columns in GROUP BY:
      SELECT first_name, country, SUM(score) 
      FROM customers 
      GROUP BY country, first_name;
      ```
      * Every column in `SELECT` is now either in `GROUP BY` or aggregated.
    * **Another Classic Wrong vs. Right Comparison:**
      ```sql
      -- ❌ WRONG (name is not in GROUP BY):
      SELECT name, department, AVG(salary) 
      FROM employees 
      GROUP BY department;

      -- ✔️ RIGHT (Only department and aggregate function projected):
      SELECT department, AVG(salary) 
      FROM employees 
      GROUP BY department;
      ```

* **Grouping on Multiple Columns:**
  * You can create multi-dimensional summary groups by grouping on two or more columns:
    ```sql
    SELECT department, job_title, COUNT(*) AS total_employees 
    FROM employees 
    GROUP BY department, job_title;
    ```
    * *Explanation:* Creates a unique group for every distinct combination of department and job title (e.g., IT-Developer, IT-Manager, HR-Recruiter).

* **WHERE vs. HAVING: Crucial Distinction:**
  * **`WHERE`** is applied **before** grouping $\rightarrow$ `WHERE` filters individual rows.
  * **`HAVING`** is applied **after** grouping $\rightarrow$ `HAVING` filters aggregated summary groups.
  * *Example using `HAVING` to filter groups (Find departments with more than 1 employee):*
    ```sql
    SELECT department, COUNT(*) AS total_employees
    FROM employees
    GROUP BY department
    HAVING COUNT(*) > 1;
    ```
  * **Critical Interview Question ①: Can we use `HAVING` without a `GROUP BY` clause?**
    * **Answer:** **YES!**
    * If `GROUP BY` is omitted, the query optimizer treats the **entire table as a single implicit aggregate group**.
    * *Valid Query Example:*
      ```sql
      -- Returns result only if the company-wide average score exceeds 500:
      SELECT AVG(score) AS overall_avg 
      FROM customers 
      HAVING AVG(score) > 500;
      ```
  * **Critical Interview Question ②: Performance Distinction (`WHERE` vs. `HAVING`):**
    * *Question:* "If you want to report average salary for the 'IT' department only, should you filter by `WHERE department = 'IT'` or `HAVING department = 'IT'`?"
    * *Answer:* **Always filter using `WHERE`!**
    * *Why:*
      * **`WHERE department = 'IT'`**: Evaluates at disk/index scan time. Non-IT records are discarded immediately before entering CPU-intensive grouping memory buffers.
      * **`HAVING department = 'IT'`**: Forces the database engine to group *all* departments across millions of rows, compute unnecessary aggregate calculations, and then throw them away in the final step. Filtering late with `HAVING` causes extreme query degradation.

* **Using ORDER BY with GROUP BY:**
  * `ORDER BY` is executed **after** grouping and can sort the final aggregated result set:
    ```sql
    SELECT department, COUNT(*) AS total 
    FROM employees 
    GROUP BY department 
    ORDER BY total DESC;
    ```

* **Complete Clause Execution Order Example:**
  * Observe how clauses are sequenced:
    ```sql
    -- Only IT employees considered first, then grouped, then filtered by average salary:
    SELECT department, AVG(salary) AS avg_salary
    FROM employees
    WHERE department = 'IT'
    GROUP BY department
    HAVING AVG(salary) > 75000
    ORDER BY avg_salary DESC;
    ```
    * **Step-by-Step Processing:**
      1. `FROM employees`: Locates table.
      2. `WHERE department = 'IT'`: Filters out non-IT rows before grouping.
      3. `GROUP BY department`: Groups surviving IT employees.
      4. `HAVING AVG(salary) > 75000`: Evaluates aggregate filter on the group.
      5. `SELECT department, AVG(salary)`: Projects columns.
      6. `ORDER BY avg_salary DESC`: Sorts the final groups.

![GROUP BY Rules, WITH ROLLUP & GROUP_CONCAT()](./sql_group_by_rules_and_rollup.svg)

* **GROUP BY with ROLLUP (Subtotals and Grand Totals):**
  * When you add `WITH ROLLUP`, MySQL generates additional hierarchical summary rows for **subtotals and the grand total**, where the grouped column becomes `NULL`.
  * To make the report professional and readable, replace that `NULL` with a clean label like `'TOTAL'` using `IFNULL()`:
    ```sql
    SELECT IFNULL(country, 'TOTAL') AS COUNTRY, SUM(score) AS GROUPsCORE 
    FROM customers 
    GROUP BY country WITH ROLLUP;
    ```
  * **Output Table with ROLLUP:**
    | COUNTRY | GROUPsCORE | Note |
    | :--- | :---: | :--- |
    | **Germany** | 850 | Subtotal for Germany |
    | **UK** | 750 | Subtotal for UK |
    | **USA** | 900 | Subtotal for USA |
    | **TOTAL** | **2500** | ★ Grand Total across all customers ★ |

* **The `GROUP_CONCAT()` Aggregate Function:**
  * When you want to retain details while still grouping rows, MySQL provides the specialized `GROUP_CONCAT()` function to concatenate string values from multiple rows into a single comma-separated string:
    ```sql
    SELECT department, GROUP_CONCAT(name) AS employees
    FROM employees
    GROUP BY department;
    ```
    * *Example Output:*
      | department | employees |
      | :--- | :--- |
      | **IT** | Alice,Bob,Charlie |
      | **HR** | David,Emma |

* **Best Practice Rules for GROUP BY:**
  1. **Always ensure non-aggregated columns in `SELECT` are in `GROUP BY`.**
  2. **Use `HAVING` for aggregated filters, and `WHERE` for row-level filters.**
  3. **Use aliases (`AS`) for readability** in all aggregate expressions.
  4. **Use `WITH ROLLUP`** whenever executive reports require subtotals and grand totals.
  5. **Be careful with SQL modes:** MySQL sometimes allows non-standard `GROUP BY` when `ONLY_FULL_GROUP_BY` is disabled. This is strongly discouraged because it produces non-deterministic, unpredictable results in production.

* **Fundamental Limitation of the GROUP BY Clause:**
  * **Using the `GROUP BY` clause, you cannot perform aggregation and preserve granular row-level details at the same time in standard queries.**
  * Once rows are grouped by a column, individual row identity is collapsed into the group summary.
  * To overcome this limitation and perform aggregations while preserving every individual row, modern SQL uses **Window Functions** (e.g., `SUM(score) OVER (PARTITION BY country)`).

---

### 13.10 Visual Diagrams & Architectural Reference

#### 1. ASK Your Data: The SQL Query Mental Model
* **Definition:** Think of the database as something you ask questions to: your business question becomes an SQL query, and the answer comes back as a table.
* **Description:** This diagram illustrates the complete closed query lifecycle across 4 distinct phases:
  1. **The Business Question:** Natural human query (e.g., *"Who are our customers from Germany?"*).
  2. **The SQL Query:** Formal declarative query formulation (`SELECT name, country FROM customers WHERE country = 'Germany';`).
  3. **Database Processing:** The DBMS engine reads physical disk blocks into memory, evaluates filtering predicates, and discards non-matching rows.
  4. **The Tabular Result Set:** Clean virtual table returned to the application screen or API.
* **मराठी विवरण (Marathi Summary):** ही आकृती दर्शवते की व्यवसायातील साधा प्रश्न (उदा. *"जर्मनीतील ग्राहक कोण आहेत?"*) SQL क्वेरीमध्ये कसा बदलला जातो, डेटाबेस इंजिन डिस्कमधून डेटा मेमरीमध्ये आणून कसा फिल्टर करतो आणि शेवटी ॲप्लिकेशनला टेबलच्या स्वरूपात अचूक उत्तर कसे देतो.

![ASK Your Data: The SQL Query Mental Model](./sql_query_mental_model_ask_your_data.svg)

---

#### 2. The 9 Essential SQL Query Clauses
* **Definition:** The main keywords (clauses) used to build a query: where the data comes from, how it is filtered, grouped and sorted.
* **Description:** A visual taxonomy classifying all 9 query clauses branching out from a central SQL query engine:
  * **`SELECT`**: Specifies attributes to project and display.
  * **`DISTINCT`**: Eliminates duplicate identical rows.
  * **`TOP` / `LIMIT`**: Restricts the maximum number of returned rows.
  * **`FROM`**: Identifies source table(s) on disk.
  * **`JOIN`**: Merges records from related tables.
  * **`WHERE`**: Filters rows using boolean conditions (predicates).
  * **`GROUP BY`**: Summarizes rows into aggregated groups.
  * **`HAVING`**: Filters summarized groups using aggregate functions.
  * **`ORDER BY`**: Sorts final result rows in ascending (`ASC`) or descending (`DESC`) order.
* **मराठी विवरण (Marathi Summary):** SQL मधील मुख्य ९ क्लॉजेसचे वर्गीकरण: कॉलम्स निवडणे (`SELECT`, `DISTINCT`, `LIMIT`), डेटा स्रोत व जोडणी (`FROM`, `JOIN`, `WHERE`), आणि डेटाचे गट करून क्रम लावणे (`GROUP BY`, `HAVING`, `ORDER BY`).

![The 9 Essential SQL Query Clauses](./sql_query_clauses_taxonomy.svg)

---

#### 3. HOW SQL WORKS: SELECT * vs. Specific Column Projection
* **Definition:** The difference between reading all columns (`SELECT *`) and reading only the columns you need (`SELECT col1, col2`).
* **Description:** A chalkboard-style architectural comparison showing physical query execution:
  * **Step ① (`FROM Table`):** Identifies and locates the table on disk storage.
  * **Method A (`SELECT *`):** Keeps all columns (100% table width), resulting in high disk I/O, heavy memory allocation, and large network payloads.
  * **Method B (`SELECT col1, col2`):** Extracts only the designated attributes, minimizing network byte transfer and allowing MySQL to utilize fast **Covering Indexes**.
* **मराठी विवरण (Marathi Summary):** `SELECT *` वापरल्यास टेबलचे सर्व कॉलम्स वाचले जातात ज्यामुळे डिस्क व मेमरीवर लोड वाढतो. याउलट फक्त आवश्यक कॉलम्स (`SELECT col1, col2`) निवडल्यास क्वेरी वेगवान होते आणि नेटवर्क बँडविड्थची मोठी बचत होते.

![HOW SQL WORKS: SELECT * vs. Specific Columns](./sql_select_all_vs_few_columns_execution.svg)

---

#### 4. WHERE Clause Filtering Pipeline & Query Execution Order
* **Definition:** The order in which the database actually runs a query that has a `WHERE` filter.
* **Description:** Highlights that while SQL queries are written from left to right (`SELECT ... FROM ... WHERE ...`), the physical database engine executes in a strict logical order:
  * **Step ① `FROM customers`:** Reads the raw table from storage into the buffer cache.
  * **Step ② `WHERE score > 500`:** Funnels every row through the boolean predicate filter, discarding non-matching rows (`FALSE` / `UNKNOWN`) and keeping matching rows (`TRUE`).
  * **Step ③ `SELECT name, country`:** Projects and outputs only the specified columns of the surviving records.
* **मराठी विवरण (Marathi Summary):** क्वेरी लिहिण्याचा क्रम डावीकडून उजवीकडे असला तरी इंजिन आधी **`FROM`** (टेबल शोधतो), मग **`WHERE`** (शर्तीनुसार नको असलेल्या रो गाळतो), आणि शेवटी **`SELECT`** (उरलेल्या रोमधून आवश्यक कॉलम्स दाखवतो) या क्रमाने काम करतो.

![WHERE Clause: Data Filtering & Internal Query Execution Order](./sql_where_filtering_execution_order.svg)

---

#### 5. WHERE Operators Taxonomy Tree (The 5 Operator Families)
* **Definition:** All the kinds of operators you can use inside `WHERE`.
* **Description:** A hierarchical tree diagram mapping out the 5 specialized operator families used in row-level filtering:
  1. **Comparison Operators:** `=`, `<>`, `!=`, `>`, `>=`, `<`, `<=` (compares two expressions or values).
  2. **Logical Operators:** `AND`, `OR`, `NOT` (combines or negates conditions using boolean algebra).
  3. **Range Operator:** `BETWEEN ... AND ...` (inclusive boundary filtering).
  4. **Membership Operator:** `IN`, `NOT IN` (matches against a discrete list or subquery set).
  5. **Search Operator:** `LIKE` (wildcard string pattern matching with `%` and `_`).
* **मराठी विवरण (Marathi Summary):** `WHERE` क्लॉजमधील ५ प्रमुख ऑपरेटर्सचे कुटुंब: Comparison (`=`, `<>`), Logical (`AND`, `OR`, `NOT`), Range (`BETWEEN`), Membership (`IN`, `NOT IN`), आणि Search (`LIKE`).

![SQL WHERE Clause: Operator Taxonomy & Classification](./sql_where_operators_taxonomy.svg)

---

#### 6. Comparison Operators: Condition Anatomy & Master Reference
* **Definition:** Operators that compare two values and return `TRUE`, `FALSE`, or `UNKNOWN`.
* **Description:** Details the tripartite anatomy of a condition (`Expression [Operator] Expression`), illustrates the 5 practical ways to compare two things in SQL (`Column=Column`, `Column=Value`, `Function=Value`, `Expression=Value`, `Subquery=Value`), and presents the master reference matrix of all 6 comparison operators with their definitions, syntax, and boolean outcomes.
* **मराठी विवरण (Marathi Summary):** दोन मूल्यांची तुलना करून `TRUE` किंवा `FALSE` ठरवणे. यात अटीची त्रिमितीय रचना (`कॉलम = व्हॅल्यू`), तुलना करण्याचे ५ व्यावहारिक मार्ग आणि सर्व ६ तुलनात्मक चिन्हांचा मास्टर संदर्भ समाविष्ट आहे.

![Comparison Operators: Anatomy & Master Reference](./sql_comparison_operators_guide.svg)

---

#### 7. Row-by-Row Predicate Filtering Demonstration (WHERE Country = 'USA')
* **Definition:** A step-by-step picture of how the database checks the condition on each row and keeps or drops it.
* **Description:** Step-by-step visual demonstration of applying `WHERE Country = 'USA'` to the `customers` table:
  * Rows for Maria (`Germany`), Georg (`UK`), and Martin (`Germany`) evaluate to **`FALSE`** and are **discarded ❌**.
  * Rows for John (`USA`) and Peter (`USA`) evaluate to **`TRUE`** and are **kept ✔️**.
  * The resulting output virtual table contains only the surviving records (John and Peter).
* **मराठी विवरण (Marathi Summary):** प्रत्येक रोवर `Country = 'USA'` ही अट कशी तपासली जाते ते दाखवले आहे. अमेरिका असलेले ग्राहक (जॉन, पीटर) टिकतात (`TRUE ✔️`), तर जर्मनी व युकेचे ग्राहक वगळले जातात (`FALSE ❌`).

![Row-by-Row Predicate Filtering: WHERE Country = 'USA'](./sql_where_country_filter_evaluation.svg)

---

#### 8. Whole Table vs. Specific Column Projection Architecture
* **Definition:** Compares the memory, disk and network cost of `SELECT *` vs. selecting only some columns.
* **Description:** Illustrates the internal pipeline differences between `SELECT *` (reading all column blocks into the buffer pool and sending maximum bytes over the network wire) and targeted column selection (reading only required columns, enabling covering index lookups without touching table data pages, and dramatically shrinking network bandwidth).
* **मराठी विवरण (Marathi Summary):** संपूर्ण टेबल वाचणे (`SELECT *`) विरुद्ध आवश्यक कॉलम्स वाचणे (`SELECT col1, col2`) यातील मेमरी, इंडेक्स आणि नेटवर्क ट्रान्सफर स्पीडचा अंतर्गत तांत्रिक फरक.

![Whole Table vs Specific Column Projection Architecture](./dql_select_whole_vs_specific_columns_diagram.svg)

---

#### 9. Logical Operators Master Reference Table (AND, OR, NOT)
* **Definition:** A visual summary card classifying the 3 core boolean operators in SQL, their formal evaluation rules, and logical truth results.
* **Description:** Details `AND` (all conditions must be TRUE), `OR` (at least one condition must be TRUE), and `NOT` (reverses the condition / excludes matching rows) with side-by-side boolean formula pills and quick-recap reference.
* **मराठी विवरण (Marathi Summary):** तार्किक ऑपरेटर्सचा नियम तक्ता: `AND` मध्ये सर्व अटी सत्य लागतात, `OR` मध्ये कोणतीही एक अट सत्य चालते, आणि `NOT` मूळ अट उलट करतो.

![Logical Operators Master Reference Table](./sql_logical_operators_table.svg)

---

#### 10. Logical Operator: AND (All Conditions Must Be TRUE)
* **Definition:** A logical conjunction operator that links two or more conditions and evaluates to `TRUE` if and only if every condition predicate is satisfied.
* **Description:** Demonstrates the row-by-row filtering evaluation for `WHERE Country = 'USA' AND Score > 500`. Only John satisfies both condition 1 (`Country = 'USA'`) and condition 2 (`Score > 500`), while Peter and Georg fail one condition and are discarded.
* **मराठी विवरण (Marathi Summary):** `Country = 'USA' AND Score > 500` चे प्रात्यक्षिक: देश अमेरिका आणि स्कोअर ५०० पेक्षा जास्त या दोन्ही अटी फक्त जॉन पूर्ण करतो, म्हणून केवळ तोच रिझल्टमध्ये निवडला जातो.

![Logical Operator: AND Evaluation](./sql_logical_operators_and_evaluation.svg)

---

#### 11. Logical Operator: OR (At Least One Condition Must Be TRUE)
* **Definition:** A logical disjunction operator that evaluates to `TRUE` if any of the specified conditions is met, discarding records only when all conditions fail.
* **Description:** Illustrates evaluation for `WHERE Country = 'USA' OR Score > 500`. Records for John (meets both), Georg (meets score > 500), and Peter (meets Country = 'USA') all survive to form the final result set.
* **मराठी विवरण (Marathi Summary):** `Country = 'USA' OR Score > 500` चे प्रात्यक्षिक: दोन्हीपैकी किमान एक अट पूर्ण करणारे रेकॉर्ड्स (जॉन, जॉर्ज, पीटर) रिझल्टमध्ये निवडले जातात; सर्व अटी चुकल्या तरच रेकॉर्ड वगळले जाते.

![Logical Operator: OR Evaluation](./sql_logical_operators_or_evaluation.svg)

---

#### 12. Logical Operator: NOT (Reverses Condition / Excludes Matches)
* **Definition:** A logical negation operator that inverts the truth value of a condition predicate, converting matching rows into non-matches.
* **Description:** Demonstrates the evaluation of `WHERE NOT (Country = 'USA')`. Rows matching 'USA' (John, Peter) evaluate to `FALSE` and are excluded, while non-USA customers (Maria, Georg, Martin) evaluate to `TRUE` and survive.
* **मराठी विवरण (Marathi Summary):** `NOT (Country = 'USA')` चे प्रात्यक्षिक: अट उलट केली जाते; अमेरिकेचे ग्राहक वगळले जातात आणि अमेरिकेबाहेरील (जर्मनी, युके) सर्व ग्राहक रिझल्टमध्ये राहतात.

![Logical Operator: NOT Evaluation](./sql_logical_operator_not_evaluation.svg)

---

#### 13. Range Operator: BETWEEN … AND … (Inclusive Boundaries)
* **Definition:** A range evaluation operator that tests whether an attribute's value falls within a specified interval, including both boundary endpoints.
* **Description:** Displays a number line with lower bound (100) and upper bound (500), showing that values within the interval (Maria: 350) and exactly on the boundary (Martin: 500) are kept, while out-of-bound records (Peter: 0, Georg: 750, John: 900) are discarded. Also highlights functional equivalence to `>= 100 AND <= 500`.
* **मराठी विवरण (Marathi Summary):** संख्या रेषेवरील मर्यादेची तपासणी: १०० ते ५०० या मर्यादेत असणारे (मारिया: ३५०) आणि नेमके सीमेवर असणारे (मार्टिन: ५००) समाविष्ट होतात; मर्यादेबाहेरील घटक वगळले जातात.

![Range Operator: BETWEEN Evaluation](./sql_range_operator_between_evaluation.svg)

---

#### 14. Membership Operators: IN & NOT IN (Discrete Set Evaluation)
* **Definition:** Checks whether a value is in a list of values (or in the result of a subquery).
* **Description:** Features a top clipboard listing allowed target countries (`'Germany'`, `'USA'`), contrasting `IN` (kept if in list) against `NOT IN` (kept if absent from list) across our 5 customer records. Highlights the recommended syntax shortcut over verbose chained `OR` statements.
* **मराठी विवरण (Marathi Summary):** यादीतील मूल्ये तपासणे: क्लिपबोर्डवर दिलेल्या देशांच्या यादीत ('Germany', 'USA') असणारे ग्राहक `IN` द्वारे निवडले जातात, तर यादीबाहेर असणारे (युके) `NOT IN` द्वारे निवडले जातात. अनेक `OR` लिहिण्याऐवजी हा उत्तम शॉर्टकट आहे.

![Membership Operators: IN & NOT IN Evaluation](./sql_membership_operators_in_evaluation.svg)

---

#### 15. Search Operator: LIKE & SQL Wildcards (Pattern Matching)
* **Definition:** A string pattern matching operator using wildcards (`%` for zero/multiple characters, `_` for exact single character) to filter text columns flexibly.
* **Description:** Breaks down wildcard mechanics with a central pattern search bar branching into `%` (Anything: 0, 1, Many) and `_` (Exact 1 char), supported by 4 dedicated comparison columns evaluating `LIKE 'M%'`, `LIKE '%in'`, `LIKE '%r%'`, and `LIKE '__b%'`.
* **मराठी विवरण (Marathi Summary):** वाइल्डकार्ड्स द्वारे मजकूर शोधणे: `%` (शून्य किंवा अनेक अक्षरे) आणि `_` (नेमके एक अक्षर) वापरून ४ स्वतंत्र स्तंभांमध्ये सुरू होणारे, संपणारे, समाविष्ट असणारे आणि ३ऱ्या क्रमांकावर 'b' असणारे पॅटर्न स्पष्ट केले आहेत.

![Search Operator: LIKE & SQL Wildcards](./sql_search_operator_like_wildcards.svg)

---

#### 16. NULL Check Operators: IS NULL & IS NOT NULL (Three-Valued Logic)
* **Definition:** Checks for missing (unknown) values, following SQL's three-valued logic (TRUE / FALSE / UNKNOWN).
* **Description:** Clarifies the core difference between `NULL` (missing/unknown), `0` (numeric value), and `''` (empty string). Illustrates why standard equality (`= NULL`) evaluates to `UNKNOWN` and silently returns 0 rows, demonstrating proper evaluation using `IS NULL` and `IS NOT NULL`.
* **मराठी विवरण (Marathi Summary):** `NULL` (अज्ञात), `0` (संख्या), आणि `''` (रिकामी स्ट्रिंग) यातील फरक. `= NULL` ने ० रो का येतात आणि `IS NULL` / `IS NOT NULL` द्वारे डेटा कसा अचूक शोधला जातो याचे विश्लेषण.

![NULL Check Operators: IS NULL & IS NOT NULL](./sql_null_check_operators_evaluation.svg)

---

#### 17. Sorting in SQL: ORDER BY Clause Architecture
* **Definition:** Sorts rows in ascending (`ASC`) or descending (`DESC`) order by one or more columns.
* **Description:** Visualizes query execution order (`FROM` ➔ `SELECT` ➔ `ORDER BY`), contrasting single column sorting (highest score first) with nested sequential sorting (`country ASC, score DESC`) where ties within Germany and the USA are resolved by score magnitude.
* **मराठी विवरण (Marathi Summary):** डेटाचा क्रम लावणे: चढता क्रम (`ASC`) विरुद्ध उतरता क्रम (`DESC`), आणि मल्टिपल कॉलम्स सॉर्टिंग (`country ASC, score DESC`) मध्ये देशानुसार गट करून देशांतर्गत जास्त स्कोअर आधी कसा दाखवला जातो ते स्पष्ट केले आहे.

![Sorting in SQL: ORDER BY Clause Architecture](./sql_order_by_sorting_execution.svg)

---

#### 18. Grouping in SQL: GROUP BY Clause & Data Aggregation
* **Definition:** Puts rows with the same value into groups and calculates totals (SUM, COUNT, AVG…) for each group.
* **Description:** Breaks down the 3-step physical aggregation lifecycle: reading the 5 raw customer records, bucketing into distinct countries (Germany: 350+500=850, USA: 900+0=900, UK: 750), and projecting the final 3-row summary table.
* **मराठी विवरण (Marathi Summary):** डेटाचे एकत्रीकरण: ५ मूळ ग्राहकांच्या रेकॉर्ड्सचे देशानुसार गट करून (जर्मनी: ८५०, अमेरिका: ९००, युके: ७५०) ३ सारांश रो कशा तयार केल्या जातात याची पायरी-दर-पायरी प्रक्रिया.

![Grouping in SQL: GROUP BY Clause & Data Aggregation](./sql_group_by_aggregation_execution.svg)

---

#### 19. GROUP BY Rules, WITH ROLLUP & GROUP_CONCAT()
* **Definition:** Extra grouping rules: the `ONLY_FULL_GROUP_BY` rule, subtotals with `WITH ROLLUP`, and joining text with `GROUP_CONCAT()`.
* **Description:** Illustrates why non-aggregated columns like `first_name` fail when omitted from `GROUP BY`, demonstrates `WITH ROLLUP` grand totals paired with `IFNULL()`, and shows `GROUP_CONCAT()` merging group members into comma-separated text lists.
* **मराठी विवरण (Marathi Summary):** `ONLY_FULL_GROUP_BY` चा नियम (नॉन-ॲग्रीगेट कॉलम का चालत नाही), `WITH ROLLUP` द्वारे महाबेरीज (Grand Total) तयार करणे, आणि `GROUP_CONCAT()` द्वारे एकाच रकान्यात नावे स्वल्पविरामाने एकत्र जोडणे.

![GROUP BY Rules, WITH ROLLUP & GROUP_CONCAT()](./sql_group_by_rules_and_rollup.svg)

---

### 13.11 Topic 13 Summary (मराठी सारांश)

* **DQL (Data Query Language) आणि डेटा क्वेरी करण्याचे स्वरूप:**
  * DQL चा उपयोग डेटाबेसमधून अचूक माहिती शोधण्यासाठी (Fetch / Retrieve) केला जातो.
  * ही पूर्णपणे **Read-Only** भाषा आहे; याने मूळ डेटामध्ये कोणताही फेरबदल होत नाही.
  * DQL मधील मुख्य कमांड **`SELECT`** ही आहे.
* **क्वेरी करण्यापूर्वीच्या मूलभूत कमांड्स (Prerequisites):**
  * `SHOW DATABASES;`: सर्व अस्तित्वात असलेले डेटाबेस पाहणे.
  * `CREATE DATABASE my_db;`: नवीन डेटाबेस तयार करणे.
  * `USE my_db;`: हवा असलेला डेटाबेस निवडणे (Active Database).
  * `DROP DATABASE my_db;`: नको असलेला डेटाबेस कायमचा डिलीट करणे.
* **टेबल, ॲट्रिब्यूट्स आणि डेटा टाईप्सचा सुवर्ण नियम:**
  * टेबलमधील प्रत्येक उभ्या स्तंभाला (Column) **Attribute** म्हटले जाते.
  * प्रत्येक ॲट्रिब्यूटमधील डेटा ठरवण्यासाठी **Data Type** लावला जातो.
  * **महत्त्वाचा नियम:** *डेटा टाईप हा कॉलमवर (Column) लागू होतो, रोवर (Row) नाही!*
* **SQL चे ९ महत्त्वाचे क्लॉजेस (Clauses):**
  1. `SELECT` (कॉलम्स निवडणे)
  2. `DISTINCT` (डुप्लिकेट रो गाळणे)
  3. `LIMIT` / `TOP` (रेकॉर्ड्सची संख्या मर्यादित करणे: `SELECT OrderID FROM ORDERS LIMIT 2;`)
  4. `FROM` (डेटा कुठून आणायचा तो मूळ टेबल दर्शवणे)
  5. `JOIN` (संबंध जोडणे)
  6. `WHERE` (शर्तींनुसार रो फिल्टर करणे)
  7. `GROUP BY` (गट तयार करणे)
  8. `HAVING` (गटांवर शर्ती लावणे)
  9. `ORDER BY` (डेटा चढत्या किंवा उतरत्या क्रमाने लावणे)
* **क्वेरी रन होण्याचा अंतर्गत क्रम (Internal Execution Order):**
  * आपण डावीकडून उजवीकडे क्वेरी लिहितो (`SELECT ... FROM ... WHERE ...`), परंतु डेटाबेस इंजिन मात्र सर्वात आधी **`FROM`** (टेबल शोधतो), नंतर **`WHERE`** (डेटा गाळतो), आणि शेवटी **`SELECT`** (कॉलम्स प्रोजेक्ट करतो) या क्रमाने चालते.
* **डेटा मिळवण्याच्या दोन पद्धती:**
  1. `SELECT * FROM tableName;`: सर्व कॉलम्स मिळवणे (Keep All Columns).
  2. `SELECT col1, col2 FROM tableName;`: फक्त आवश्यक कॉलम्स निवडणे (Keeps only Needed Columns - इंडस्ट्री बेस्ट प्रॅक्टिस).
* **WHERE क्लॉज द्वारे फिल्टरिंग (Filtering Data):**
  * *व्याख्या:* **Filtering = Applying conditions to select only the rows you need.**
  * नको असलेला डेटा गाळून फक्त दिलेल्या अटी पूर्ण करणारा डेटा शोधणे.
  * **WHERE क्लॉजमधील ५ प्रमुख ऑपरेटर्सचे प्रकार (5 Operator Families):**
    1. **Comparison Operators:** `=`, `<>`, `!=`, `>`, `>=`, `<`, `<=` (दोन गोष्टींची तुलना करणे).
    2. **Logical Operators:** `AND`, `OR`, `NOT` (अनेक अटी एकत्र करणे).
    3. **Range Operator:** `BETWEEN ... AND ...` (विशिष्ट मर्यादेतील डेटा निवडणे).
    4. **Membership Operator:** `IN`, `NOT IN` (यादीतील घटकांशी जुळवणी करणे).
    5. **Search Operator:** `LIKE` (अक्षरांचे नमुने / Wildcards शोधणे).
* **Comparison Operators (दोन गोष्टींची तुलना करणे):**
  * **Condition ची रचना:** `Expression [Operator] Expression`
  * **तुलना करण्याचे ५ प्रकार:**
    1. `Column1 = Column2` (`first_name = last_name`)
    2. `Column1 = Value` (`country = 'USA'`)
    3. `Function = Value` (`UPPER(first_name) = 'JOHN'`)
    4. `Expression = Value` (`price * quantity = 1000`)
    5. `Subquery = Value` (Advanced - सबक्वेरीच्या निकालाशी तुलना)
  * **६ मुख्य तुलनात्मक ऑपरेटर्सची व्याख्या (Definitions):**
    * `=` : **Equal to** - दोन्ही मूल्ये समान आहेत का ते तपासतो (`country = 'USA'`).
    * `!=` किंवा `<>` : **Not equal to** - दोन्ही मूल्ये असमान आहेत का ते तपासतो. `<>` हे ISO/ANSI अधिकृत स्टँडर्ड आहे, तर `!=` हे सर्वमान्य अलियास आहे (`score <> 0`).
    * `>` : **Greater than** - डावे मूल्य उजव्या मूल्यापेक्षा मोठे आहे का ते तपासतो (`score > 500`).
    * `>=` : **Greater than or equal to** - डावे मूल्य मोठे किंवा समान आहे का ते तपासतो (`score >= 500`).
    * `<` : **Less than** - डावे मूल्य उजव्या मूल्यापेक्षा लहान आहे का ते तपासतो (`score < 500`).
    * `<=` : **Less than or equal to** - डावे मूल्य लहान किंवा समान आहे का ते तपासतो (`score <= 500`).
* **Logical Operators (तार्किक ऑपरेटर्स):**
  * **`AND`:** दिलेल्या **सर्व अटी बरोबर (`TRUE`)** असणे अनिवार्य असते. एकही अट चुकल्यास रो वगळली जाते (`country = 'USA' AND score > 500`).
  * **`OR`:** दिलेल्या अटींपैकी **किमान एक तरी अट बरोबर (`TRUE`)** असावी लागते. सर्व अटी चुकल्या तरच रो वगळली जाते (`country = 'USA' OR score > 500`).
  * **`NOT`:** दिलेली अट **उलटी करतो (Reverse / Negate)**; म्हणजेच अटीशी जुळणारे रेकॉर्ड्स वगळतो आणि न जुळणारे रेकॉर्ड्स निवडतो (`NOT country = 'USA'`).
* **Range Operator (`BETWEEN … AND …`):**
  * मूल्य दिलेल्या मर्यादेमध्ये आहे की नाही हे तपासतो (`score BETWEEN 100 AND 500`).
  * **दोन्ही मर्यादा समाविष्ट असतात (Inclusive Boundaries):** खालची मर्यादा (Lower: 100) आणि वरची मर्यादा (Upper: 500) दोन्ही रिझल्टमध्ये धरली जातात.
  * **Comparison Operators द्वारे समतुल्यता (Equivalence):**
    * `WHERE score BETWEEN 100 AND 500` हे `WHERE score >= 100 AND score <= 500` च्या अगदी समान कार्य करते.
  * संख्या, तारखा (Dates), किंवा अक्षरांसाठी (Alphabetical Text) वापरता येतो.
* **Row-by-Row Predicate Evaluation:**
  * प्रत्येक रोवर अट तपासली जाते; ज्या रोसाठी उत्तर **`TRUE`** येते तीच रो रिझल्टमध्ये राहते, तर **`FALSE`** किंवा **`UNKNOWN`** येणारी रो वगळली (Discard) जाते.
* **NULL व्हॅल्यूजचा मूलभूत नियम:**
  * `NULL` शी तुलना करण्यासाठी कधीही `=` किंवा `!=` वापरू नये; त्याऐवजी नेहमी **`IS NULL`** किंवा **`IS NOT NULL`** वापरावे.
* **Membership Operators (`IN` आणि `NOT IN`):**
  * **`IN (...)` ऑपरेटर:**
    * कॉलमचे मूल्य दिलेल्या यादीतील (List) कोणत्याही एका मूल्याशी जुळते का ते तपासतो.
    * अनेक `OR` अटी एकत्र लिहिण्याचा हा अत्यंत सोपा, स्वच्छ आणि शॉर्टकट मार्ग आहे (`WHERE country IN ('Germany', 'USA')`).
    * *महत्त्वाचा नियम:* एकाच कॉलमवर वारंवार `OR` लिहिण्याऐवजी नेहमी `IN` वापरावे (उदा. `WHERE country = 'Germany' OR country = 'USA'` ऐवजी `WHERE country IN ('Germany', 'USA')`).
  * **`NOT IN (...)` ऑपरेटर:**
    * कॉलमचे मूल्य दिलेल्या यादीत **नाही** (Not Member) ते तपासतो. हा `IN` च्या बरोबर उलट कार्य करतो.
    * यादीतील मूल्ये वगळून उर्वरित सर्व रेकॉर्ड्स रिझल्टमध्ये आणतो (`WHERE country NOT IN ('Germany', 'USA')`).
* **Search Operator (`LIKE` आणि `NOT LIKE` - पॅटर्न मॅचिंग):**
  * मजकुरामध्ये (Text Columns) विशिष्ट नमुना किंवा पॅटर्न शोधण्यासाठी `LIKE` ऑपरेटर वापरला जातो (इथे अचूक समानता `=` ऐवजी नमुन्याशी जुळवणी केली जाते).
  * **२ प्रमुख वाइल्डकार्ड्स (Wildcards):**
    1. **`%` (Percent Wildcard):** शून्य, एक किंवा अनेक अक्षरांशी (Zero or More Characters) जुळतो.
       * `LIKE 'A%'`: नाव 'A' ने सुरू होणारे (उदा. *Alice*, *Albert*, *An*, *A*).
       * `LIKE '%a'`: नाव 'a' ने संपणारे (उदा. *Maria*, *Anna*, *Emma*).
       * `LIKE '%it%'`: नावात कुठेही "it" असणारे (उदा. *Rohit*, *Mohit*, *Martin*).
    2. **`_` (Underscore Wildcard):** बरोबर **एकच अक्षर (Exactly One Single Character)** दर्शवतो.
       * `LIKE '_ohit'`: ५ अक्षरी नाव ज्यामध्ये दुसरे ते पाचवे अक्षर "ohit" आहे (उदा. *Rohit*, *Mohit*).
       * `LIKE 'A_i_'`: नेमके ४ अक्षरी नाव, पहिले 'A' आणि तिसरे 'i' असणारे (उदा. *Amir*, *Abid*).
       * `LIKE 'S_ne%'`: 'S' ने सुरू, नंतर कोणतेही १ अक्षर, मग 'ne', आणि शेवटी काहीही (उदा. *Sanel*, *Soney*).
  * **`NOT LIKE`:** दिलेल्या पॅटर्नशी न जुळणारे रेकॉर्ड्स शोधून काढतो (`WHERE name NOT LIKE 'A%'` ➔ 'A' ने सुरू न होणारी सर्व नावे).
* **NULL Check Operators (`IS NULL` आणि `IS NOT NULL` - त्रिमूल्य तर्कशास्त्र):**
  * **`NULL` म्हणजे काय?:** डेटाबेसमध्ये `NULL` म्हणजे **अज्ञात (Unknown) किंवा डेटा नसणे (Missing Value)**.
  * **महत्त्वाचा फरक:**
    * `NULL ≠ 0` (0 ही एक निश्चित संख्या आहे; NULL म्हणजे डेटाच नाही).
    * `NULL ≠ ''` (रिकामी स्ट्रिंग ही ० लांबीचा मजकूर आहे; NULL ला कोणतीही लांबी नसते).
  * **Three-Valued Logic (3VL):** SQL मध्ये `NULL = NULL` किंवा `col = NULL` हे कधीही `TRUE` येत नाही, तर त्याचे उत्तर **`UNKNOWN`** येते. `WHERE` क्लॉज फक्त `TRUE` रेकॉर्ड्स दाखवतो, म्हणून `= NULL` वापरल्यास क्वेरी शून्य रो रिझल्ट देते!
  * **योग्य पद्धत:** `NULL` तपासण्यासाठी नेहमी **`IS NULL`** (डेटा नसलेले शोधणे) किंवा **`IS NOT NULL`** (डेटा असलेले शोधणे) वापरावे.
* **Advanced Filtering (प्रगत फिल्टरिंग - HAVING आणि Subqueries):**
  * **`HAVING` क्लॉज:** गट तयार झाल्यानंतर (After `GROUP BY`) ॲग्रीगेट निकालांवर अट लावण्यासाठी `HAVING` वापरला जातो (`HAVING COUNT(*) > 5`).
  * `WHERE` क्लॉज रो-पातळीवर काम करत असल्याने त्यात `COUNT()`, `SUM()` वापरता येत नाही; तिथे `HAVING` अनिवार्य आहे.
  * **Subqueries (पोट-क्वेरी):** एका क्वेरीच्या `WHERE` अटीमध्ये दुसरी अंतर्गत `SELECT` क्वेरी वापरून गतिमान पद्धतीने डेटा फिल्टर करणे (`WHERE country IN (SELECT country FROM top_sales)`).
* **Sorting Data & The `ORDER BY` Clause (डेटाचा क्रम लावणे):**
  * `ORDER BY` क्लॉजचा वापर क्वेरीच्या निकालातील रो चढत्या किंवा उतरत्या क्रमाने लावण्यासाठी केला जातो.
  * **२ मुख्य दिशा (Sort Directions):**
    * **`ASC` (Ascending - चढता क्रम):** लहानापासून मोठे (`0 ➔ 9`, `A ➔ Z`). हा **डिफॉल्ट (Default)** क्रम असतो; तरीही स्पष्टतेसाठी क्वेरीमध्ये `ASC` लिहिणे योग्य मानले जाते.
    * **`DESC` (Descending - उतरता क्रम):** मोठ्यापासून लहान (`9 ➔ 0`, `Z ➔ A`). सर्वोच्च स्कोअर आधी आणण्यासाठी `ORDER BY score DESC;` वापरतात.
  * **Nested / Multiple Columns Sorting (अनेक कॉलम्सनुसार क्रम):**
    * एकापेक्षा जास्त कॉलम्सवर क्रम लावताना क्रमवारी अत्यंत महत्त्वाची असते (`ORDER BY country ASC, score DESC;`).
    * इंजिन आधी पहिल्या कॉलमने (`country`) क्रम लावतो; जेव्हा दोन ग्राहकांचा देश सारखा असतो (Tie), तेव्हाच दुसऱ्या कॉलमने (`score`) निर्णय घेऊन जास्त स्कोअर आधी दाखवतो (उदा. जर्मनीमध्ये मार्टिनचा स्कोअर ५०० असल्याने तो मारियाच्या ३५० आधी येतो).
  * **तारीख, गणित आणि NULL चे सॉर्टिंग:**
    * तारखांवर `ORDER BY transaction_date DESC` वापरल्यास सर्वात नवीन व्यवहार आधी दिसतात.
    * `ORDER BY (salary * 12) DESC` किंवा कॉलम अलियासने थेट क्रम लावता येतो.
    * `ASC` मध्ये `NULL` सर्वात आधी येतो, तर `DESC` मध्ये `NULL` सर्वात शेवटी येतो.
* **Grouping Data & The `GROUP BY` Clause (डेटाचे गट करणे व एकत्रीकरण):**
  * **गट करण्याची संकल्पना (Concept):** एका कॉलममधील समान मूल्ये असलेल्या अनेक रो एकत्र करून त्यांचा **एक सारांश रो (Single Summary Row)** तयार करणे.
  * **ॲग्रीगेट फंक्शन्स सोबत कार्य:** `SUM()` (बेरीज), `COUNT()` (संख्या), `AVG()` (सरासरी), `MIN()` (किमान), `MAX()` (कमाल).
  * **MySQL मधील सुवर्ण नियम (`ONLY_FULL_GROUP_BY`):**
    * `SELECT` मध्ये लिहिलेला प्रत्येक कॉलम हा एकतर **`GROUP BY` मध्ये असावा लागतो किंवा ॲग्रीगेट फंक्शनमध्ये असावा लागतो!**
    * जर `SELECT first_name, country, SUM(score) FROM customers GROUP BY country;` लिहिले तर एरर (Error 1055) येतो, कारण एका देशात अनेक नावे असतात आणि इंजिनला एका रोवर कोणते नाव दाखवायचे हे समजत नाही. उपाय: `first_name` सुद्धा `GROUP BY` मध्ये टाका किंवा `SELECT` मधून काढा.
  * **`WHERE` vs. `HAVING` मधील मुख्य फरक:**
    * `WHERE` ➔ गट बनवण्यापूर्वी (Before Grouping) मूळ रो फिल्टर करतो.
    * `HAVING` ➔ गट बनवल्यानंतर (After Grouping) ॲग्रीगेट मूल्यांवर फिल्टर लावतो.
  * **`WITH ROLLUP` (पदानुक्रम उपबेरीज आणि महाबेरीज):**
    * `GROUP BY country WITH ROLLUP` वापरल्यास प्रत्येक देशाच्या बेरजेसोबतच शेवटी सर्व देशांची मिळून **Grand Total** रो आपोआप तयार होते (जिथे देश `NULL` येतो). त्याला वाचनीय करण्यासाठी `IFNULL(country, 'TOTAL')` वापरतात.
  * **`GROUP_CONCAT()` फंक्शन:**
    * गटातील सर्व ग्राहकांची किंवा कर्मचाऱ्यांची नावे स्वल्पविरामाने (Comma-separated) एकाच रकान्यात एकत्र आणण्यासाठी वापरले जाते (`GROUP_CONCAT(name)`).
  * **`GROUP BY` ची मुख्य मर्यादा (Limitation):**
    * `GROUP BY` वापरल्यास मूळ रोचे स्वतंत्र अस्तित्व संपुष्टात येते आणि फक्त सारांश उरतो. जर मूळ रो देखील जशाच्या तशा ठेवायच्या असतील आणि सोबतच एकूण बेरीजही दाखवायची असेल, तर SQL मधील **Window Functions (`OVER (PARTITION BY ...)`)** वापरावी लागतात.
* **इंटरव्ह्यूच्या दृष्टीने अत्यंत महत्त्वाचे सुवर्ण नियम आणि सापळे (Critical Interview Rules & Traps):**
  1. **`NOT IN` सह `NULL` चा महा-सापळा (Three-Valued Logic Trap):**
     * `WHERE id NOT IN (1, 2, NULL)` चे उत्तर **शून्य रो (0 Rows)** येते!
     * कारण `id != NULL` चे उत्तर `UNKNOWN` येते, आणि `AND` अटीमध्ये एकही `UNKNOWN` आल्यास संपूर्ण अट कधीही `TRUE` होऊ शकत नाही. (उपाय: `IS NOT NULL` फिल्टर करा किंवा `NOT EXISTS` वापरा).
  2. **`SUM()` आणि `NULL` चा व्यवहार:**
     * `SUM()` कॅल्क्युलेशन करताना कॉलममधील सर्व `NULL` दुर्लक्ष (Ignore) करतो.
     * परंतु जर **टेबल रिकामे असेल किंवा सर्व व्हॅल्यूज `NULL` असतील**, तर `SUM()` चे उत्तर `0` येत नाही तर **`NULL`** येते! म्हणूनच डॅशबोर्डमध्ये `0` आणण्यासाठी नेहमी **`COALESCE(SUM(col), 0)`** किंवा **`IFNULL(SUM(col), 0)`** वापरावे.
  3. **`SUM(DISTINCT)` विरुद्ध `SUM()`:**
     * `SUM(score)` सर्व मूल्यांची बेरीज करतो (उदा. ५०० + ५०० + २०० = १२००).
     * `SUM(DISTINCT score)` डुप्लिकेट्स वगळून फक्त युनिक मूल्यांची एकदाच बेरीज करतो (उदा. ५०० + २०० = ७००).
  4. **`SUM()` द्वारे Conditional Counting:**
     * MySQL मध्ये `WHERE` न वापरता थेट विशिष्ट अटी मोजण्यासाठी `SUM(score > 500)` किंवा `SUM(CASE WHEN score > 500 THEN 1 ELSE 0 END)` वापरता येते.
  5. **`COUNT(*)` विरुद्ध `COUNT(col)` मधील फरक:**
     * `COUNT(*)` आणि `COUNT(1)` टेबलमधील सर्व रो मोजतात (ज्यात रो पूर्ण NULL असली तरी मोजली जाते).
     * `COUNT(column)` फक्त त्या कॉलममधील **Non-NULL** मूल्ये मोजतो.
  6. **`AVG()` मधील `NULL` चा ट्रॅप:**
     * `AVG(salary)` हे एकूण रोने न भागता फक्त ज्यांचा पगार **Non-NULL** आहे त्याच रोने भागते (उदा. १००००, २००००, NULL, NULL ची सरासरी १५००० येते, ७५०० नाही). जर सर्वांची सरासरी हवी असेल तर `AVG(COALESCE(salary, 0))` वापरावे.
  7. **`GROUP BY` विना `HAVING` चा वापर:**
     * `GROUP BY` नसतानाही `HAVING` वापरता येतो (उदा. `SELECT AVG(score) FROM customers HAVING AVG(score) > 500;`). अशा वेळी संपूर्ण टेबल हा एकच ग्रुप मानला जातो.
  8. **`WHERE` vs. `HAVING` परफॉर्मन्स नियम:**
     * ग्रुपिंग होण्यापूर्वीच अनावश्यक रो गाळण्यासाठी नेहमी **`WHERE`** वापरावे (`WHERE dept = 'IT'`), कारण `HAVING` मध्ये फिल्टर केल्यास इंजिन आधी विनाकारण सर्व डेटा ग्रुप करतो आणि मग गाळतो, ज्यामुळे क्वेरी स्लो होते.
  9. **`ORDER BY` मधील Positional Sorting आणि Deterministic Sort:**
     * `ORDER BY 1, 2` (कॉलम नंबरने क्रम लावणे) तांत्रिकदृष्ट्या चालते, पण प्रॉडक्शनमध्ये हा **Antipattern** आहे कारण भविष्यात `SELECT` चे कॉलम्स बदलल्यास निकाल चुकू शकतो.
     * दोन रोचे मूल्य समान असल्यास (Tie) क्रम अनपेक्षित बदलू नये म्हणून शेवटी नेहमी युनिक कॉलम किंवा Primary Key (`id`) टाई-ब्रेकर म्हणून जोडावा (`ORDER BY score DESC, id ASC`).

---

### 13.12 SQL Clauses Deep Dive & Execution Order (Detailed Guide)

#### 1. HAVING Clause (हॅविंग क्लॉज)
* **What is it?** The `HAVING` clause in SQL is used to filter groups of rows created by the `GROUP BY` clause.
* **Purpose:** It is used to filter the aggregated data. 
  * `WHERE` filters individual rows (before grouping).
  * `HAVING` filters grouped/aggregated results (after grouping).
* `HAVING` क्लॉज `GROUP BY` ने तयार झालेल्या ग्रुप्सना (groups) फिल्टर करण्यासाठी वापरला जातो. `WHERE` फक्त वैयक्तिक rows फिल्टर करतो, तर `HAVING` संपूर्ण ग्रुपच्या aggregated डेटावर फिल्टर लावतो.

* **Standard Syntax:**
  ```sql
  SELECT column1, AGGREGATE_FUNCTION(column2)
  FROM table_name
  WHERE condition
  GROUP BY column1
  HAVING aggregate_condition
  ORDER BY column1;
  ```
* **Key Rules for HAVING Clause:**
  1. `HAVING` always comes **after** `GROUP BY`. It works on grouped results.
  2. You **can use aggregate functions** inside `HAVING` (e.g., `HAVING COUNT(*) > 5;` or `HAVING AVG(salary) > 60000;`).
  3. If there is no `GROUP BY`, `HAVING` still works. $\rightarrow$ It will treat the entire result as a single group.
  4. `WHERE` filters rows, `HAVING` filters groups. $\rightarrow$ Often, you’ll use both together.

* **Examples:**
  * **Simple HAVING with COUNT:**
    ```sql
    SELECT department, COUNT(*) AS total_employees 
    FROM employees 
    GROUP BY department 
    HAVING COUNT(*) > 1;
    ```
  * **HAVING with AVG:**
    ```sql
    SELECT department, AVG(salary) AS avg_salary 
    FROM employees 
    GROUP BY department 
    HAVING AVG(salary) > 70000;
    ```

![Grouping and Aggregation Diagram](./sql_group_by_aggregation_execution.svg)

#### 2. WHERE + HAVING Together
* **Concept:** They are most commonly used together. `WHERE` filters rows before grouping, and `HAVING` filters groups after aggregation.
* `WHERE` आणि `HAVING` एकत्र वापरता येतात. आधी `WHERE` मूळ rows फिल्टर करतो, मग उरलेल्या डेटावर `GROUP BY` ग्रुप बनवतो, आणि शेवटी `HAVING` त्या ग्रुप्सना फिल्टर करतो.
* **Example Query:**
  ```sql
  SELECT country, sum(score)
  FROM customers 
  WHERE score > 400
  GROUP BY country
  HAVING sum(score) > 800;
  ```
* **Practice Question 1:** Find the average score for each country considering only customers with a score not equal to zero, and return only those countries with an average score greater than 430.
  ```sql
  SELECT country, avg(score) as 'avg_score' 
  FROM customers 
  WHERE score != 0 
  GROUP BY country 
  HAVING avg(score) > 430 
  ORDER BY country;
  ```

![WHERE Filtering Execution Diagram](./sql_where_filtering_execution_order.svg)

#### 3. HAVING without GROUP BY / HAVING with Multiple Conditions
* **HAVING without GROUP BY:** MySQL allows this. The entire table is treated as one single group.
  ```sql
  SELECT SUM(salary) AS total_salary
  FROM employees
  HAVING SUM(salary) > 300000;
  ```
* **HAVING with Multiple Conditions:** You can combine conditions using `AND` / `OR`.
  ```sql
  SELECT department, COUNT(*) AS total, AVG(salary) AS avg_salary
  FROM employees
  GROUP BY department
  HAVING COUNT(*) > 1 AND AVG(salary) > 60000;
  ```

#### 4. Differences Between WHERE and HAVING (WHERE vs HAVING)
| Feature | WHERE Clause | HAVING Clause |
| :--- | :--- | :--- |
| **When it works** | Works on rows **before grouping**. Filters the rows. | Works on groups **after grouping**. Filters the grouped/aggregated result. |
| **Purpose** | Used to fetch data/values from the table according to the given condition. | Used to fetch data/values from the groups according to the given condition. |
| **Without GROUP BY** | Can be executed without `GROUP BY`. | Always executed with `GROUP BY` (though MySQL supports it without). |
| **Aggregate Functions**| Aggregation functions are **NOT allowed** (`WHERE SUM(val)` is invalid). | Aggregation functions are **allowed** (`HAVING AVG(salary) > 60000`). |
| **Execution Order** | Executed **before** `GROUP BY`. | Executed **after** `GROUP BY`. |
| **Usage** | Used with `SELECT`, `UPDATE`, `DELETE`. | Used **only** with `SELECT`. |
| **Filter Type** | Pre-filter (e.g., `WHERE salary > 1000`). | Post-filter (e.g., `HAVING AVG(salary) > 60000`). |

* **Best Practices:**
  * Always use `WHERE` when filtering raw rows $\rightarrow$ it is much faster.
  * Use `HAVING` only when filtering aggregated results.
  * You can use both together (`WHERE` for the row and `HAVING` for the group).
* `WHERE` टेबलच्या rows वर काम करतो आणि `GROUP BY` शिवायही चालतो; त्यात aggregate functions वापरता येत नाहीत (हा pre-filter आहे). तर `HAVING` ग्रुप्सवर काम करतो, aggregate functions वापरू देतो आणि हा post-filter आहे.

#### 5. Order of Execution vs Coding Order in SQL
* **Order of Coding (How we write):**
  `SELECT` $\rightarrow$ `FROM` $\rightarrow$ `WHERE` $\rightarrow$ `GROUP BY` $\rightarrow$ `HAVING` $\rightarrow$ `ORDER BY` $\rightarrow$ `LIMIT / TOP`
* **Order of Execution (How Engine executes):**
  1. **FROM:** Locate the table.
  2. **WHERE:** Filter rows.
  3. **GROUP BY:** Make groups.
  4. **HAVING:** Filter groups.
  5. **SELECT:** Project columns.
  6. **ORDER BY:** Sort the final result.
  7. **TOP / LIMIT:** Restrict the result size.
* आपण SQL लिहिताना `SELECT` आधी लिहितो, पण डेटाबेस इंजिन सर्वात आधी `FROM` (टेबल शोधणे) चालवते, मग `WHERE` ने डेटा फिल्टर करते, मग ग्रुप बनवते, आणि शेवटी `SELECT` व `ORDER BY` चालवते.

![Query Execution Lifecycle Diagram](./query_execution_lifecycle.svg)

#### 6. ORDER BY and GROUP BY Rules
* **Can we define ORDER BY Before the GROUP BY?**
  * **No.** You cannot define `ORDER BY` before `GROUP BY` in SQL.
  * `ORDER BY` always works after grouping (and after `HAVING` if used).
  * You cannot sort the data before `GROUP BY` because SQL first creates groups, then sorts the final grouped result.
  * *Important Note:* You can sort rows before grouping only inside a subquery, and even then the final order is not guaranteed. In the main query, `ORDER BY` always comes after `GROUP BY` (use `ORDER BY` on the final result).
* **Can we use GROUP BY without WHERE?**
  * **Yes.** The `WHERE` clause is optional.
  * `GROUP BY` simply groups all rows in the table.
  * Grouping without WHERE:
    ```sql
    SELECT loan_type, SUM(amount) AS total_amount FROM Loan GROUP BY loan_type;
    ```
  * Grouping with WHERE (Optional):
    ```sql
    SELECT loan_type, SUM(amount) AS total_amount FROM Loan WHERE branch_id = 1 GROUP BY loan_type;
    ```

#### 7. ORDER BY with or without WHERE
* **Yes**, you can use `ORDER BY` both with or without a `WHERE` clause.
* **ORDER BY without WHERE:**
  * When you just want to sort all rows in a table, no filtering is needed.
  * `SELECT * FROM Customer ORDER BY name ASC;` (Sorts all alphabetically).
* **ORDER BY with WHERE:**
  * When you want to filter rows first, then sort only the filtered results.
  * ```sql
    SELECT * FROM Customer
    WHERE city = 'Mumbai'
    ORDER BY balance DESC;
    ```
* **Notes:**
  * `ORDER BY` is always applied after filtering (`WHERE`) and grouping (`GROUP BY`).
  * You can sort by Single column, Multiple columns, or Calculated expression.

#### 8. DISTINCT Keyword
* **Purpose:** Used to remove duplicate values from your data.
* Each value will appear only once in data.
* **Example Q1:** Return unique list of all the countries.
  ```sql
  SELECT DISTINCT country FROM customers;
  ```
* **Bad habit with DISTINCT:** Do not use `DISTINCT` unless it is necessary, as it requires sorting/hashing and can slow down your query.
* `DISTINCT` चा वापर डुप्लिकेट (duplicate) डेटा काढण्यासाठी होतो. गरज असेल तेव्हाच वापरा, नाहीतर क्वेरी हळू (slow) होऊ शकते.

#### 9. TOP / LIMIT in SQL
* **Purpose:** Used to limit your data. It restricts the number of rows returned in the result (i.e., how many rows you want to see).
* **Sorting with LIMIT and TOP:**
  * In MySQL, `TOP` is **NOT supported**. Instead, MySQL uses the `LIMIT` clause.
* **Example:** Show Top 5 richest accounts.
  ```sql
  SELECT * FROM Account ORDER BY balance DESC LIMIT 5; 
  ```
* **LIMIT with Offset:** `LIMIT` also allows you to skip some rows using `LIMIT offset, count`.
  ```sql
  SELECT * FROM Customer ORDER BY balance DESC LIMIT 5, 5; 
  ```
  *(Skips the first 5 rows, then shows the next 5 rows).*
* `TOP` (SQL Server) किंवा `LIMIT` (MySQL) आउटपुटमध्ये किती rows दिसाव्यात ते मर्यादित करतात. हवे असल्यास काही rows सोडून (skip करून) पुढच्या rows सुद्धा दाखवता येतात.

#### 10. Multi Queries in SQL
* You can execute multiple queries together by separating them with semicolons `;`.
  ```sql
  SELECT * FROM customer; 
  SELECT * FROM order;
  ```
* Both queries return results simultaneously (in their respective result sets).

#### 11. Static Fix (Static Value in SQL)
* You can select a fixed (static) value directly, without using any table.
  ```sql
  SELECT 123 AS static_number;
  SELECT 'VISHAL';
  ```
* **Adding a static column:** You can add a static column or fixed value to a real table result.
  ```sql
  SELECT id, first_name, 'new_customers' AS customer_type FROM customers;
  ```
  *(Each row will now have the new column with the static value 'new_customers').*
* **Example:**
  ```sql
  SELECT id, name, 'UNKNOWN' AS record_status FROM orders;
  ```
* क्वेरीच्या आउटपुटमध्ये स्वतःहून एखादे fixed (static) मूल्य दाखवायचे असल्यास ते थेट `SELECT` मध्ये लिहा. ते प्रत्येक row सोबत दिसेल.

#### 12. Pro-Tips / Interview Insights (Missing Points)

* **1. Column Alias in WHERE Clause (Order of Execution Rule)**
  * **English:** In SQL, you cannot use a column alias (created in the `SELECT` clause) inside the `WHERE` clause. This is because the database engine executes the `WHERE` clause *before* the `SELECT` clause, so it doesn't know the alias exists yet! However, you can use the alias in the `ORDER BY` clause because `ORDER BY` executes *after* `SELECT`.
  * **Example Error:** 
    ```sql
    -- ERROR! 'annual_salary' is an alias, WHERE doesn't know it yet
    SELECT (salary * 12) AS annual_salary FROM employees WHERE annual_salary > 50000; 
    ```
  * **Correct Way:**
    ```sql
    SELECT (salary * 12) AS annual_salary FROM employees WHERE (salary * 12) > 50000;
    ```
  * इंटरव्ह्यूमधील सर्वात प्रसिद्ध प्रश्न: "SELECT मध्ये बनवलेला Alias आपण WHERE मध्ये वापरू शकतो का?" उत्तर आहे **नाही!** कारण SQL इंजिन आधी `WHERE` चालवते आणि नंतर `SELECT`. `WHERE` चालत असताना इंजिनला तुम्ही बनवलेले नवीन नाव (Alias) माहीतच नसते. पण Alias `ORDER BY` मध्ये वापरता येतो, कारण तो `SELECT` नंतर चालतो.

* **2. Real-world Pagination using LIMIT and OFFSET**
  * **English:** In real-world applications (like e-commerce sites showing 10 products per page), SQL uses `LIMIT` with `OFFSET` to manage pages. 
    * **Page 1** (Shows first 10 products):
      ```sql
      SELECT * FROM products LIMIT 10 OFFSET 0;
      ```
    * **Page 2** (Skips first 10, shows next 10):
      ```sql
      SELECT * FROM products LIMIT 10 OFFSET 10;
      ```
    * **Page 3** (Skips first 20, shows next 10):
      ```sql
      SELECT * FROM products LIMIT 10 OFFSET 20;
      ```
  * खऱ्या वेबसाइट्सवर (जसे Amazon) तुम्ही "Page 2" किंवा "Page 3" वर क्लिक करता, तेव्हा मागे SQL क्वेरीमध्ये `LIMIT` आणि `OFFSET` बदलत असतात. `OFFSET` सांगतो किती rows सोडायच्या (skip) आणि `LIMIT` सांगतो किती नवीन rows दाखवायच्या.

* **3. Single Quotes vs Double Quotes (String Quote Rule)**
  * **English:** Always use single quotes (`'...'`) for strings and dates in SQL, never double quotes (`"..."`). While MySQL might forgivingly accept double quotes depending on its SQL mode, standard SQL (like PostgreSQL, Oracle, SQL Server) strictly treats double quotes as identifiers (like table or column names), not strings.
  * **Correct Syntax:**
    ```sql
    SELECT * FROM customers WHERE country = 'India';
    ```
  * SQL मध्ये मजकूर (String) आणि तारीख (Date) साठी नेहमी **Single Quotes (`'...'`)** वापरा. Double Quotes MySQL मध्ये कधी कधी चालतात, पण PostgreSQL / SQL Server सारख्या इतर डेटाबेसमध्ये एरर येतो!

* **4. The Trailing Comma Error (Syntax Rule)**
  * **English:** Be very careful not to leave a trailing comma at the end of your `SELECT` list right before the `FROM` keyword. This is one of the most common beginner syntax errors.
  * **Incorrect (Syntax Error):**
    ```sql
    SELECT name, city, FROM customers; 
    ```
  * **Correct:**
    ```sql
    SELECT name, city FROM customers;
    ```
  * अनेकदा क्वेरी लिहिताना शेवटच्या कॉलमनंतर चुकून `,` (कॉमा) राहतो (जसे `city, FROM`). लक्षात ठेवा, शेवटच्या कॉलमनंतर कधीही कॉमा देऊ नका, नाहीतर संपूर्ण क्वेरी एरर देते.

---

## Topic 14: Keys & Constraints in SQL

### 14.1 What are Key Constraints?
* **English:** Key constraints are rules applied to columns in a table to ensure data correctness, integrity, uniqueness, and proper identification of rows.
* की कंस्ट्रेंट्स (Key Constraints) म्हणजे टेबलच्या कॉलम्सवर लावलेले नियम, ज्यामुळे डेटा बरोबर राहतो, डुप्लिकेट तयार होत नाही आणि दोन टेबल्समधील संबंध (relationship) योग्य राहतो.

### 14.2 SQL Constraints (Point-wise Detail)

* **1. PRIMARY KEY**
  * **Properties:** Uniquely identifies each record. Unique for each row, CANNOT be NULL. A table can have only ONE primary key. Can be single or multiple columns (composite).
  * प्रायमरी की (Primary Key) ही टेबलमधील प्रत्येक रेकॉर्डची युनिक (Unique) ओळख असते. ती कधीही रिकामी (NULL) असू शकत नाही आणि एका टेबलमध्ये फक्त एकच प्रायमरी की असते.
  * **Code Example:**
    ```sql
    CREATE TABLE Students (
        StudentID INT PRIMARY KEY,
        Name VARCHAR(50),
        Age INT
    );
    ```

* **2. FOREIGN KEY**
  * **Properties:** Ensures referential integrity. References the primary key of another table. Can contain duplicate values and can be NULL.
  * **ON DELETE CASCADE / ON UPDATE CASCADE:** Deletes or updates child rows automatically when the parent row is modified.
  * फॉरेन की (Foreign Key) दोन टेबल्सना जोडते. ती दुसऱ्या (Parent) टेबलच्या Primary Key ला रेफर करते. Parent टेबलमधील डेटा डिलीट झाल्यास CASCADE नियमामुळे Child टेबलमधील संबंधित डेटाही आपोआप डिलीट होतो.
  * **Code Example:**
    ```sql
    CREATE TABLE Orders (
        OrderID INT PRIMARY KEY,
        CustomerID INT,
        FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID) ON DELETE CASCADE
    );
    ```

* **3. UNIQUE KEY**
  * **Properties:** Prevents duplicate values. Ensures all values in a column are unique. Unlike primary key, a table can have MULTIPLE unique keys. Can allow NULL values.
  * युनिक की (Unique Key) डुप्लिकेट डेटा थांबवते. प्रायमरी की आणि हिच्यातील फरक: एका टेबलमध्ये अनेक युनिक की असू शकतात आणि यात NULL व्हॅल्यू ठेवता येते.
  * **Code Example:**
    ```sql
    CREATE TABLE Employees (
        EmployeeID INT PRIMARY KEY,
        Email VARCHAR(100) UNIQUE
    );
    ```

* **4. NOT NULL**
  * **Properties:** Ensures that a column cannot have a NULL value. Often used alongside Primary Key.
  * कॉलममध्ये कोणतीही रिकामी जागा (NULL) राहू नये याची खात्री करते; म्हणजे डेटा भरणे अनिवार्य (Mandatory) होते.
  * **Code Example:** `ProductName VARCHAR(50) NOT NULL`

* **5. CHECK Constraint**
  * **Properties:** Ensures that values in a column meet a specific logical condition (e.g., Age >= 18).
  * CHECK चा वापर कॉलमवर अट लावण्यासाठी होतो (उदा. वय 18 पेक्षा कमी नसावे). अट न पाळणारा डेटा टेबलमध्ये सेव्ह होत नाही.
  * **Code Example:**
    ```sql
    CREATE TABLE Employees (
        EmployeeID INT PRIMARY KEY,
        Age INT CHECK (Age >= 18)
    );
    ```

* **6. DEFAULT Constraint**
  * **Properties:** Fills a column with a default fixed value if no value is specified during insertion.
  * डेटा टाकताना एखादा कॉलम रिकामा सोडल्यास DEFAULT नियम तिथे आधीच ठरवलेली व्हॅल्यू आपोआप भरतो.
  * **Code Example:** `OrderDate DATE DEFAULT CURRENT_DATE`
  * ⚠️ **Note:** In MySQL 8.0.13+ an expression default must be in brackets: `OrderDate DATE DEFAULT (CURRENT_DATE)`.

* **7. AUTO_INCREMENT (or IDENTITY)**
  * **Properties:** Automatically generates unique numbers for a column (mostly for primary keys).
  * हे आपोआप वाढणारा नंबर (1, 2, 3...) तयार करते. प्रायमरी की साठी वापरले जाते, जेणेकरून प्रत्येक वेळी नवीन ID आपोआप तयार होईल.

* **8. INDEX**
  * **Properties:** Technically not a constraint, but used to enforce uniqueness (Unique Index) and massively improve query performance.
  * इंडेक्स (Index) क्वेरी वेगवान (Fast) करतो — अगदी पुस्तकाच्या अनुक्रमणिकेसारखा (Index), ज्यामुळे डेटा पटकन सापडतो.

### 14.3 Types of Keys (Database Architecture)
Here is the detailed taxonomy of keys in a relational database:

* **1. SUPER KEY:** Any set of columns that uniquely identifies a row in a table. It may include extra unnecessary columns. (e.g., `{StudentID, Name, Email}`).
* **2. CANDIDATE KEY:** A *minimal* super key. It uniquely identifies a row without any extra columns. (e.g., `{StudentID}` or `{Email}`). Both can identify a row, but we must choose one.
* **3. PRIMARY KEY:** The one Candidate Key chosen by the database designer to uniquely identify records. (e.g., `{StudentID}`).
* **4. ALTERNATE KEY:** A candidate key that was *not* chosen as the primary key. Usually enforced with a UNIQUE constraint. (e.g., `{Email}`).
* **5. COMPOSITE KEY:** A primary key made of two or more columns together. (e.g., `PRIMARY KEY (StudentID, CourseID)`). Individually they might not be unique, but the combination is unique. Used for Many-to-Many relationships.
* **6. SURROGATE KEY:** An artificial key created ONLY to uniquely identify a row. It has no business meaning (like an `AUTO_INCREMENT` ID).

### 14.4 The Hierarchy of Keys (Visual Diagram)
Below is a clear representation of how these keys relate to each other:

![Hierarchy of Keys Diagram](./keys_hierarchy.svg)

* **मराठी सारांश (Keys):**
  * **Super Key:** कॉलम्सचा कोणताही ग्रुप जो row ओळखू शकतो (भले त्यात जास्तीचे कॉलम्स असले तरी).
  * **Candidate Key:** Super key मधून जास्तीचे (अनावश्यक) कॉलम्स काढले की ती Candidate Key बनते.
  * **Primary Key:** Candidate Keys पैकी जी सर्वात योग्य असते, तिला आपण Primary Key बनवतो.
  * **Alternate Key:** ज्या Candidate Keys, Primary Key बनल्या नाहीत, त्यांना Alternate Key म्हणतात.
  * **Composite Key:** एका कॉलमने काम होत नसेल तर दोन-तीन कॉलम्स मिळून बनवलेली Key.
  * **Surrogate Key:** आपोआप तयार होणारा नंबर (`AUTO_INCREMENT`), ज्याचा खऱ्या जगातील माहितीशी काही संबंध नसतो.

---

## Topic 15: SQL Joins (Combining Data from Tables)

### 15.1 What are Joins & Why Do We Need Them?
* JOINs are used in SQL to combine data (columns) from two or more tables based on a related column between them (usually Primary Key $\leftrightarrow$ Foreign Key). They append columns side-by-side to give a wider table result.
* **Rows vs Columns (SET Operators vs JOINs):**
  * If you want to combine **Rows** (putting rows below each other to make the table longer) $\rightarrow$ Use **SET Operators** (like `UNION`).
  * If you want to combine **Columns** (putting columns side-by-side to make the table wider) $\rightarrow$ Use **JOINs**.
* **Important Note:** JOINs are mostly used with the `SELECT` statement, but MySQL also allows them in `UPDATE` and `DELETE` (see 9.3).
* **Why do we need JOINs?**
  1. **Recombine Data:** Get related data that was split into multiple tables (e.g., Customer Name + Order Details).
  2. **Avoid Duplication:** We keep data normalized in separate tables and connect them only when needed using JOINs.
  3. **Query Across Entities:** (e.g., `Employees` $\rightarrow$ `Departments` $\rightarrow$ `Salaries`).
  4. **Performance:** Small, well-structured tables are faster than one giant denormalized table.
  5. **Data Enrichment:** "Getting the extra data" (e.g., joining a Zip Code reference table to enhance Customer data).
  6. **Check for Existence (Filtering):** Checking if data exists in another table (Anti Joins).
* **Best Practice:** Always add the **Table Name or Alias** before the column name (e.g., `customers.id`) to avoid **Column Ambiguity** (confusion when both tables have a column with the same name).
* **The 3 Core Scenarios for JOINs:**
  1. Matching data
  2. All data
  3. Unmatched data
* JOIN चा वापर दोन किंवा अधिक टेबल्सचा डेटा (कॉलम्स) एकत्र जोडण्यासाठी होतो. डेटा खाली-खाली (Rows) जोडायचा असेल तर `SET Operators` (जसे UNION) वापरा, पण डेटा शेजारी-शेजारी (Columns) जोडायचा असेल तर `JOIN` वापरा. वेगवेगळ्या टेबल्समध्ये विभागलेला (Normalized) डेटा पुन्हा एकत्र पाहण्यासाठी (Recombine) आणि डेटा समृद्ध (Enrich) करण्यासाठी हे उपयोगी आहे.
* Visual comparison showing how SET Operators (UNION) make a table LONGER by appending rows, while JOINs make a table WIDER by appending columns.

![Rows vs Columns](./svg_rows_vs_cols.svg)


### 15.2 Types of Joins (Basic to Advanced)
* A complete mindmap showing all 6 major types of SQL Joins and their logical connections.
* या आकृतीत SQL Joins चे सर्व मुख्य प्रकार (Inner, Left, Right, Full, Anti, Cross) दाखवले आहेत.

![Types of Joins](./svg_joins_types.svg)


* **1. Basic Join (No Condition)**
  * **English Definition/Properties:** Not really a join — just two separate queries that give two separate results.
  * **मराठी सारांश:** हा सर्वात बेसिक प्रकार आहे — दोन टेबल्सचा डेटा फक्त स्वतंत्रपणे आणतो, त्यांना एकमेकांशी जोडत नाही. कोणतीही अट (Condition) न लावता दोन वेगळे रिझल्ट हवे असतील तेव्हा वापरतात.
  * **Q1. Retrieve all data from customers and orders in two different results:**
    ```sql
    SELECT * FROM customers; 
    SELECT * FROM orders;
    ```

* **2. INNER JOIN (The Default Join)**
  * **English Definition/Properties:** Returns ONLY the matching rows from both tables. It gives you the "common part" or intersection. If you simply write `JOIN`, it defaults to `INNER JOIN`. The order of tables in the query does **not** matter.
  * **मराठी सारांश:** **काय आहे?** दोन्ही टेबल्समध्ये कॉमन (मॅच) असलेला डेटाच आणतो. **का वापरायचे?** जेव्हा दोन्ही ठिकाणी असलेले रेकॉर्ड्सच हवे असतात (उदा. फक्त ज्या ग्राहकांनी खरंच ऑर्डर दिली आहे ते). **महत्त्वाचा मुद्दा:** SQL मध्ये फक्त `JOIN` लिहिले तर ते डिफॉल्टने `INNER JOIN` मानले जाते.
  * **Q1. Get all customers along with their orders but only for customers who have placed an order:**
    ```sql
    SELECT c.id, c.first_name, o.order_id
    FROM customers AS c
    INNER JOIN orders AS o ON c.id = o.customer_id;
    ```
  * हे फक्त दोन्ही टेबल्समध्ये कॉमन (मॅचिंग) असलेला डेटा दाखवते. टेबल्स कोणत्या क्रमाने लिहिल्या याने फरक पडत नाही.
  * Inner Join returns ONLY the matching rows that exist in both tables.
  * ![Inner Join Concept](./svg_inner_join.svg)

* **3. LEFT JOIN (or LEFT OUTER JOIN)**
  * **English Definition/Properties:** Returns ALL rows from the Left table + only matching rows from the Right table. If there is no match on the right, it returns `NULL` for those columns. The **order of tables is highly important**.
  * **मराठी सारांश:** **काय आहे?** लेफ्ट (मुख्य) टेबलचा सर्व डेटा आणि राइट टेबलचा फक्त मॅच होणारा डेटा आणतो. **का वापरायचे?** जेव्हा मुख्य डेटा पूर्ण हवा असतो, समोरच्या टेबलमध्ये माहिती असो वा नसो (उदा. सर्व ग्राहक दाखवा, त्यांनी ऑर्डर दिली असो वा नसो). **महत्त्वाचा मुद्दा:** यात टेबल्स लिहिण्याचा क्रम (Order) खूप महत्त्वाचा असतो.
  * **Q1. Get all customers along with their orders, including those without an order:**
    ```sql
    SELECT c.id, c.first_name, o.order_id
    FROM customers AS c
    LEFT JOIN orders AS o ON c.id = o.customer_id;
    ```
  * हे Left टेबलचा सर्व डेटा आणि Right टेबलचा फक्त मॅच होणारा डेटा दाखवते. जिथे मॅच होत नाही तिथे `NULL` येते.
  * Left Join returns **All Rows** from the Primary (Left) table, and **Only Matching Data** from the Secondary (Right) table. The order of tables is highly important.
  * Execution flow showing how non-matching right table rows automatically get assigned `NULL` values.
  * ![Left Join Concept](./svg_left_join.svg)

* **4. RIGHT JOIN (or RIGHT OUTER JOIN)**
  * **English Definition/Properties:** Returns ALL rows from the Right table + only matching rows from the Left table. If no match, it returns `NULL` for left table columns.
  * **मराठी सारांश:** **काय आहे?** हे Left Join च्या अगदी उलट आहे (राइटचा सर्व डेटा + लेफ्टचा मॅचिंग डेटा). **का वापरायचे?** जेव्हा राइट टेबल मुख्य (Primary Focus) असते. **महत्त्वाचा मुद्दा:** इंडस्ट्रीमध्ये Right Join कमी वापरतात; टेबल्सची जागा बदलून Left Join च वापरतात.
  * **Q1. Get all customers along with their orders, including orders without matching customers:**
    ```sql
    SELECT c.id, c.first_name, o.order_id
    FROM customers AS c
    RIGHT JOIN orders AS o ON c.id = o.customer_id;
    ```
  * *Pro-Tip:* You can achieve the EXACT same result using `LEFT JOIN` just by swapping the tables (`FROM orders LEFT JOIN customers`).
  * हे Left Join च्या अगदी उलट आहे. यात Right टेबलचा सर्व डेटा येतो. इंडस्ट्रीमध्ये Right Join ऐवजी टेबल्सची जागा बदलून Left Join वापरणे जास्त पसंत केले जाते.
  * Right Join returns **All Rows** from the Secondary (Right) table and only matching rows from the Left table.
  * Industry Best Practice: You can achieve the exact same results by simply swapping the tables and using a `LEFT JOIN` instead of a `RIGHT JOIN`.
  * ![Right Join Concept](./svg_right_join.svg)
  * ![Alternative to Right Join](./svg_right_alt.svg)

* **5. FULL JOIN (or FULL OUTER JOIN)**
  * **English Definition/Properties:** Returns ALL rows from both the Left and Right tables (everything: matching and unmatching). Unmatched sides get `NULL`. Order of tables does not matter.
  * **मराठी सारांश:** **काय आहे?** दोन्ही टेबल्सचा संपूर्ण डेटा आणतो (मॅचिंग आणि नॉन-मॅचिंग दोन्ही). **का वापरायचे?** जेव्हा काहीही सुटू नये आणि पूर्ण डेटा हवा असतो. **महत्त्वाचा मुद्दा:** MySQL मध्ये हे थेट चालत नाही; `UNION` वापरून बनवावे लागते.
  * *Note:* **MySQL DOES NOT support FULL JOIN directly!** You have to simulate it using a `UNION` of `LEFT JOIN` and `RIGHT JOIN`.
  * **Q1. Get all the customers and all orders even if there is no match:**
  * **MySQL Code Simulation:**
    ```sql
    SELECT c.id, o.order_id FROM customers AS c LEFT JOIN orders AS o ON c.id = o.customer_id
    UNION
    SELECT c.id, o.order_id FROM customers AS c RIGHT JOIN orders AS o ON c.id = o.customer_id;
    ```
  * हे दोन्ही टेबल्समधील सर्व डेटा (मॅच होणारा आणि न होणारा) आणते. MySQL मध्ये हे थेट चालत नाही, म्हणून Left आणि Right Join मध्ये UNION लावावा लागतो.
  * Full Join returns **Everything** (All Rows) from both tables. Unmatched rows are padded with `NULL`s. The order of the tables does not matter.
  * ![Full Join Concept](./svg_full_join.svg)
  * ![Data Enrichment Visualization](./svg_data_enrich.svg)


### 15.3 Advanced Joins (Filtering & Special Cases)

* **1. LEFT ANTI JOIN**
  * **Properties:** Returns rows from the Left table that have NO match in the Right table. It uses the Right table strictly for filtering (checking for existence).
  * **Q1. Get all customers who have not placed any order:**
    ```sql
    SELECT c.id, c.first_name, o.order_id
    FROM customers AS c
    LEFT JOIN orders AS o ON c.id = o.customer_id
    WHERE o.customer_id IS NULL; -- The Anti-Join Filter
    ```
  * हे फक्त तो डेटा आणते जो Left मध्ये आहे पण Right मध्ये अजिबात नाही. यासाठी Left Join लावून WHERE मध्ये Right टेबलची key `IS NULL` तपासतात.
  * Left Anti Join returns ONLY the unmatching rows from the primary (Left) table.
  * The secondary (Right) table is used strictly for filtering data, not for combining. Achieved by adding `WHERE B.key IS NULL`.
  * ![Left Anti Join Concept](./svg_left_anti.svg)
  * ![Left Anti Join Execution](./svg_left_anti_exec.svg)

* **2. RIGHT ANTI JOIN**
  * **Properties:** The opposite of Left Anti Join. Returns rows from the Right table that have NO match in the Left table.
  * **Q1. Get all records without matching customers:**
    ```sql
    SELECT c.id, c.first_name, o.order_id
    FROM customers AS c
    RIGHT JOIN orders AS o ON c.id = o.customer_id
    WHERE c.id IS NULL; 
    ```
  * *Pro-Tip (Alternative Approach):* Just like Right Join, you can achieve a Right Anti Join by simply swapping the tables and using a `LEFT JOIN` (Left Anti Join structure).
    * **Syntax:**
      ```sql
      SELECT c.id, c.first_name, o.order_id
      FROM orders AS o
      LEFT JOIN customers AS c ON o.customer_id = c.id
      WHERE c.id IS NULL; 
      ```
  * हे Left Anti Join च्या उलट आहे. फक्त Right टेबलमधील तो डेटा आणते जो Left मध्ये मॅच होत नाही. (फिल्टरसाठी `c.id IS NULL` वापरतात).
  * Right Anti Join returns ONLY the unmatching rows from the secondary (Right) table.
  * The primary (Left) table acts as a filter (Lookup). Achieved by adding `WHERE A.key IS NULL`.
  * ![Right Anti Join Concept](./svg_right_anti.svg)

* **3. FULL ANTI JOIN**
  * **Properties:** Returns rows that do NOT match in either table (exclusive data from both sides).
  * **Q1. Find the customers without orders and orders without customers:**
    ```sql
    SELECT * FROM (
        SELECT c.id AS customer_id, c.first_name, o.customer_id AS order_customer_id, o.order_id 
        FROM customers c LEFT JOIN orders o ON c.id = o.customer_id
        UNION
        SELECT c.id AS customer_id, c.first_name, o.customer_id AS order_customer_id, o.order_id
        FROM customers c RIGHT JOIN orders o ON c.id = o.customer_id
    ) AS full_join
    WHERE full_join.customer_id IS NULL OR full_join.order_customer_id IS NULL;
    ```
  * हे दोन्ही टेबल्समधून असा सर्व डेटा आणते जो एकमेकांशी अजिबात मॅच होत नाही (फक्त Unmatching Data).
  * Full Anti Join returns ONLY rows that don't match in either tables. Achieved by checking if either `A.key IS NULL` OR `B.key IS NULL`.
  * ![Full Anti Join Concept](./svg_full_anti.svg)

* **4. SELF JOIN**
  * **Properties:** When a table is joined with ITSELF. It's used for hierarchical data (like Employees and their Managers) or comparing rows within the same table. You MUST use table aliases to treat it as two separate tables.
  * **Code Example (Employee and their Manager Name):**
    ```sql
    SELECT e.name AS EmployeeName, m.name AS ManagerName
    FROM employees AS e
    JOIN employees AS m ON e.manager_id = m.id;
    ```
  * **Table Setup (Real-World Hierarchy):**
    ```sql
    CREATE TABLE employees (
        id INT PRIMARY KEY AUTO_INCREMENT,
        name VARCHAR(50) NOT NULL,
        manager_id INT,
        FOREIGN KEY (manager_id) REFERENCES employees(id)
    );
    INSERT INTO employees (name, manager_id) VALUES
    ('Alice', NULL), -- Top-level Boss (No manager)
    ('Bob', 1),      -- Bob's manager is Alice
    ('Carol', 1);    -- Carol's manager is Alice
    ```
  * जेव्हा एखादे टेबल स्वतःशीच जोडले जाते. उदा. एकाच employee टेबलमध्ये कर्मचारी आहेत आणि त्यांचे मॅनेजरही आहेत.

* **5. CROSS JOIN (Cartesian Product)**
  * **Properties:** Combines EVERY row from the Left table with EVERY row from the Right table. There is NO `ON` condition. If Table A has 3 rows and Table B has 4 rows, the result has 12 rows.
  * **Q1. Generate all possible combinations of customers and orders:**
    ```sql
    SELECT * FROM customers CROSS JOIN orders;
    ```
  * हे दोन्ही टेबल्सच्या प्रत्येक रेकॉर्डची एकमेकांशी जोडी (गुणाकार) करते. हे `ON` अटीशिवाय लिहिले जाते.
  * Cross Join returns the Cartesian Product. It combines every row from table A with every row from table B.
  * If Table A has 2 rows and Table B has 3 rows, the total output will be exactly $2 \times 3 = 6$ Total Rows. No `ON` condition is needed.
  * ⚠️ **Interview Warning (The Cross Join Danger):** In MySQL, if you write an `INNER JOIN` without the `ON` condition, it silently works as a `CROSS JOIN` (most other databases give a syntax error). With two tables of 1 million rows each, the result has $1,000,000 \times 1,000,000$ (1 trillion) rows — the query can hang or crash the server!
  * ⚠️ **चेतावणी (Warning):** इंटरव्ह्यूमध्ये नेहमी विचारतात: INNER JOIN मध्ये `ON` लावायला विसरलो तर काय होईल? उत्तर: MySQL मध्ये ते Cross Join बनते. टेबल्समध्ये लाखो rows असतील तर सर्व्हर हँग होऊ शकतो.
  * Cross Join returns the Cartesian Product. It combines every row from table A with every row from table B without any `ON` condition.
  * ![Cross Join Concept](./svg_cross_join.svg)


### 15.4 Summary: How to Choose the Right Join?
1. Want **Matching** Data only? $\rightarrow$ `INNER JOIN`
2. Want **All Data** (Focus on primary table)? $\rightarrow$ `LEFT JOIN`
3. Want **Everything** from both tables? $\rightarrow$ `FULL OUTER JOIN`
4. Want **Unmatched** Data from primary table? $\rightarrow$ `LEFT ANTI JOIN`
5. Want **Unmatched** Data from both tables? $\rightarrow$ `FULL ANTI JOIN`

Master decision tree for selecting the correct SQL Join based on whether you want Matching, All, or Unmatching rows.

![How to Choose Right Join](./svg_decision_tree.svg)

### 15.5 Multi-Table Joins (Interview Perspective)
In real-world applications, you often join more than 2 tables. The pattern is sequential: Table A joins to Table B, Table B joins to Table C.
* **Q1. Using SalesDB, retrieve a list of all orders along with related customers, product, and employee details:**
  ```sql
  SELECT o.order_id, c.first_name, p.product_name, e.first_name AS Salesperson
  FROM orders AS o
  LEFT JOIN customers AS c ON o.customer_id = c.id
  LEFT JOIN products AS p ON o.product_id = p.id
  LEFT JOIN employees AS e ON o.salesperson_id = e.id;
  ```
* Concept showing one Starting Master Table iteratively joining to multiple secondary tables (B, C, D) using `LEFT JOIN` to keep all primary data.
* Example using a real Entity Relationship diagram (SalesDB). You start from `Orders` and join `Products`, `Customers`, and `Employees` to get a complete flat view.
* इंडस्ट्रीमध्ये नेहमी एक मुख्य टेबल (उदा. Orders) इतर रेफरन्स टेबल्सशी (Products, Customers) Left Join करून एक पूर्ण flat डेटा सेट तयार केला जातो.
* ![Multi-Table Concept](./svg_multi_table.svg)
* ![Multi-Table Schema](./svg_schema.svg)

### 15.6 Pro-Tip: Interview Trick (Inner Join without INNER JOIN)
* **Question:** How do you get matching data from two tables *without* using the `INNER JOIN` keyword?
* **Answer:** You can use a `LEFT JOIN` and then filter out the unmatching data using the `WHERE` clause.
* **Code Example:**
  ```sql
  SELECT c.id, c.first_name, o.order_id
  FROM customers AS c
  LEFT JOIN orders AS o ON c.id = o.customer_id
  WHERE o.customer_id IS NOT NULL;
  ```
* **इंटरव्ह्यू ट्रिक:** कोणी विचारले की "Inner Join" न लिहिता कॉमन डेटा कसा काढाल? तर Left Join लावा आणि `WHERE` मध्ये `RightTable.key IS NOT NULL` लिहा. यामुळे न जुळणारा (Unmatched) डेटा निघून जाईल आणि फक्त कॉमन डेटा राहील.

---

## Topic 16: SET Operators (Combining Rows)

### 16.1 What are SET Operators & Why Do We Need Them?
* **English Definition/Properties:** In SQL, SET operations are used to combine the results of two or more `SELECT` queries into a single result set. While `JOIN` combines columns side-by-side, SET operators combine rows top-to-bottom.
* **मराठी सारांश:** **काय आहे?** SET ऑपरेटर्स दोन किंवा अधिक `SELECT` क्वेरीजचे रिझल्ट एकाखाली एक (Rows मध्ये) जोडतात. **का वापरायचे?** जेव्हा वेगवेगळ्या टेबल्स किंवा क्वेरीजचा डेटा एकाच यादीत दाखवायचा असतो.

![Types of SET Operators](./svg_set_types.svg)
![Execution Flow](./svg_set_execution.svg)

### 16.2 The 6 Golden Rules of SET Operators
* **English Definition/Properties:** To successfully use a SET operator, your queries must strictly follow these rules:
  1. **SQL Clauses:** You can use `WHERE`, `JOIN`, `GROUP BY`, and `HAVING` in individual queries. However, `ORDER BY` is allowed **only once** at the very end of the entire combined query.
  2. **Number of Columns:** The number of columns in each `SELECT` query must be exactly the same.
  3. **Compatible Data Types:** Columns being combined don’t have to be exactly the same data type, but they must be convertible to a common type (e.g., `INT` with `BIGINT`, or `INT` with `VARCHAR`). You cannot logically mix `INT` with `DATE`.
  4. **Order of Columns:** The order of the columns in each query must be the same.
  5. **Column Aliases (Names):** The column names in the final result set are determined entirely by the names specified in the **first query** (the base query).
  6. **Mapping Correct Columns:** Even if there is no SQL error, incorrectly mapping "Age" to "Name" will lead to inaccurate results. Always make sure similar information is mapped properly.
* **मराठी सारांश:** SET ऑपरेटर वापरण्याचे नियम: दोन्ही क्वेरीजमध्ये कॉलम्सची संख्या सारखी हवी, डेटा टाइप जुळणारा (Compatible) हवा आणि कॉलम्सचा क्रम (Order) सारखा हवा. रिझल्टमधील कॉलम्सची नावे नेहमी पहिली क्वेरी ठरवते, आणि `ORDER BY` फक्त शेवटी एकदाच लावता येतो.

![Rules of SET Operators](./svg_set_rules.svg)

### 16.3 Types of SET Operators

* **1. UNION**
  * **English Definition/Properties:** Combines the results of both queries but **removes duplicate rows** from the final output. It is generally slower than `UNION ALL` because it performs extra steps to filter out duplicates. The order of queries does not affect the result.
  * **मराठी सारांश:** **काय आहे?** दोन टेबल्सचा डेटा जोडतो पण डुप्लिकेट (Duplicate) डेटा काढून टाकतो, फक्त युनिक (Unique) डेटा दाखवतो. डुप्लिकेट काढण्यामुळे हा थोडा हळू (Slow) चालतो.
  * **Q1. Combine the data from employees and customers into one table:**
    ```sql
    SELECT employeeid, firstname, lastname FROM employees
    UNION
    SELECT customerid, firstname, lastname FROM customers;
    ```
  * ![UNION Concept](./svg_union.svg)

* **2. UNION ALL**
  * **English Definition/Properties:** Returns **all rows** from both queries, including duplicates. It is faster than `UNION` because it doesn't spend time removing duplicates. Use this if you are confident there are no duplicates or if you want to find duplicates/quality issues.
  * **मराठी सारांश:** **काय आहे?** कोणतीही छाननी (Filtering) न करता दोन्ही टेबल्सचा सर्व डेटा जोडतो, डुप्लिकेट असला तरीही. हा `UNION` पेक्षा वेगवान (Fast) आहे.
  * **Q1. Combine the data from employees and customers into one table including duplicates:**
    ```sql
    SELECT employeeid, firstname, lastname FROM employees
    UNION ALL
    SELECT customerid, firstname, lastname FROM customers;
    ```
  * ![UNION ALL Concept](./svg_union_all.svg)

* **3. EXCEPT (or MINUS in Oracle)**
  * **English Definition/Properties:** Returns only the distinct rows from the **first query** that are NOT found in the second query. In this operator, the **order of queries affects the final result**.
  * **मराठी सारांश:** **काय आहे?** पहिल्या क्वेरीमध्ये आहे पण दुसऱ्या क्वेरीमध्ये नाही असा डेटाच दाखवतो. (Delta Detection म्हणजे डेटामधील फरक शोधण्यासाठी वापरतात). यात क्वेरीजचा क्रम बदलला तर उत्तर बदलते.
  * **Q1. Find employees who are not customers at the same time:**
    ```sql
    SELECT employeeid, firstname, lastname FROM employees
    EXCEPT
    SELECT customerid, firstname, lastname FROM customers;
    ```
  * **Old MySQL Alternative (only needed before MySQL 8.0.31 — MySQL 8.0.31+ supports `EXCEPT` directly, so the query above works on your 9.1):**
    ```sql
    SELECT e.employeeid, e.firstname, e.lastname
    FROM employees e
    LEFT JOIN customers c ON e.employeeid = c.customerid AND e.firstname = c.firstname AND e.lastname = c.lastname
    WHERE c.customerid IS NULL;
    ```
  * ![EXCEPT Concept](./svg_except.svg)

* **4. INTERSECT**
  * **English Definition/Properties:** Returns ONLY the rows that are **common** (exist) in both queries. It removes duplicates from the output. It is similar to an `INNER JOIN` but combines data row-wise.
  * **मराठी सारांश:** **काय आहे?** दोन्ही क्वेरीजमध्ये असलेला कॉमन (Common) डेटाच दाखवतो. (हे INNER JOIN सारखे आहे, पण Rows वर काम करते).
  * **Q1. Find employees who are also customers:**
    ```sql
    SELECT employeeid, firstname, lastname FROM employees
    INTERSECT
    SELECT customerid, firstname, lastname FROM customers;
    ```
  * **Old MySQL Alternative (only needed before MySQL 8.0.31 — MySQL 8.0.31+ supports `INTERSECT` directly):**
    ```sql
    SELECT e.employeeid, e.firstname, e.lastname
    FROM employees e
    INNER JOIN customers c ON e.employeeid = c.customerid AND e.firstname = c.firstname AND e.lastname = c.lastname;
    ```
  * ![INTERSECT Concept](./svg_intersect.svg)

### 16.4 Advanced Scenarios & Best Practices
* **English Definition/Properties:** 
  1. **Source Flag:** Include an additional column in your `SELECT` statements to indicate the source of each row.
  2. **Never use an asterisk (*):** Always list the needed columns instead of `*` to prevent mapping errors.
  3. **Multiple Tables:** You can chain `UNION`, `INTERSECT`, and `EXCEPT` across 3 or more tables sequentially.
  4. **Use Case (Delta Detection & Data Completeness):** Used to compare tables to detect discrepancies between databases or daily data batches.
* **मराठी सारांश:** SET ऑपरेटर वापरताना कधीही `*` (Asterisk) वापरू नका, नेहमी कॉलम्सची नावे लिहा, म्हणजे चुकीचा डेटा मॅप होणार नाही. तसेच एक जास्तीचा "Source" कॉलम नक्की बनवा, म्हणजे रिझल्टमध्ये डेटा कोणत्या टेबलमधून आला ते कळेल.
* **Q1. Orders are stored in separate tables (orders and orders_archive). Combine all orders into one report without duplication:**
  ```sql
  SELECT orderid, order_date, 'orders' AS source_table FROM orders
  UNION
  SELECT orderid, order_date, 'orders_archive' AS destination_table FROM orders_archive
  ORDER BY orderid;
  ```
* ![Combine Similar Info](./svg_combine_similar.svg)
* **Q1. Using UNION Across Three Tables with Multiple Columns:**
  ```sql
  SELECT id, name, city FROM customers
  UNION
  SELECT id, name, city FROM suppliers
  UNION
  SELECT id, name, city FROM employees;
  ```
* **Q1. Using INTERSECT with Multiple Tables:**
  ```sql
  SELECT id, name FROM customers
  INTERSECT
  SELECT id, name FROM suppliers
  INTERSECT
  SELECT id, name FROM employees;
  ```
* **Q1. Using EXCEPT / MINUS with Multiple Tables:**
  ```sql
  SELECT id, name FROM customers
  EXCEPT
  SELECT id, name FROM blacklist
  EXCEPT
  SELECT id, name FROM inactive_customers;
  ```

* **Q1. Give real-time examples of where you use SET operators in your project:**
  * **1. EXCEPT Use Case - Delta Detection:**
    * Delta detection means identifying the differences or changes (delta) between two batches of data (e.g., Day 1 vs Day 2).
    * ![Delta Detection Concept](./svg_delta_detection.svg)
  * **2. EXCEPT Use Case - Data Completeness Check:**
    * EXCEPT operators can be used to compare tables to detect discrepancies between databases and verify that data migrated correctly (100% in sync).
    * ![Data Completeness Concept](./svg_data_completeness.svg)

### 16.5 In-Depth Comparison: JOINs vs SET Operators

* **English Definition/Properties:** While both JOINs and SET operators combine data, they do it in completely different ways. JOINs combine columns (horizontal), and SET operators combine rows (vertical).
* **मराठी सारांश:** **काय आहे?** JOIN आणि SET दोघेही डेटा जोडतात, पण वेगळ्या पद्धतीने. JOIN कॉलम्स शेजारी-शेजारी जोडून टेबल रुंद (Wider) करतो, तर SET ऑपरेटर Rows वर-खाली जोडून टेबल लांब (Longer) करतो.

![JOIN vs SET Comparison](./svg_join_vs_set.svg)

| Feature | JOIN (Horizontal Merging) | SET Operator (Vertical Stacking) |
| :--- | :--- | :--- |
| **Purpose** | Combine data from multiple tables based on related columns. | Combine the results of two or more independent `SELECT` queries. |
| **Combination Type** | **Horizontal** (Column-wise merging). The table becomes wider. | **Vertical** (Row-wise stacking). The table becomes longer. |
| **Output Structure** | A combined table containing columns from all joined tables. | A single result set with the *same number of columns* as the input queries. |
| **Column Requirement** | Corresponding columns can be completely different. | Queries MUST return the exact same number of columns with compatible datatypes. |
| **Duplicates** | Duplicates are NOT removed automatically. | Controls duplicates: `UNION`/`INTERSECT`/`EXCEPT` removes them, `UNION ALL` keeps them. |
| **Conditions Needed** | Requires a `JOIN` condition (like the `ON` clause) except for `CROSS JOIN`. | **No join condition required.** Combines result sets directly. |
| **Works On** | Columns based on relationships (Primary Key / Foreign Key). | Complete rows of result sets (independent queries). |
| **Types** | `INNER`, `LEFT`, `RIGHT`, `FULL`, `CROSS` | `UNION`, `UNION ALL`, `INTERSECT`, `EXCEPT / MINUS` |
| **Use Case** | Retrieve related data (e.g. Customer info with their Orders). | Append rows from similar queries (e.g. Combine Customers and Suppliers lists). |

* **Why were Set Operators introduced in SQL?**
  * SQL is based on relational algebra and mathematics (Set Theory).
  * **1. Combine independent query results:** Sometimes tables aren't related (e.g. customers and suppliers). SET lets you merge them without needing joins.
  * **2. Simpler and cleaner syntax:** Without them, merging queries requires messy joins and `DISTINCT` logic.
  * **3. Control over duplicates:** Easy, direct control over duplicate filtering.
  * **4. Performance advantages:** Operating on pre-selected results directly is often faster and easier for the database to optimize than complex joins.

* **What problems do SET operators solve that JOINs cannot easily handle?**
  * **Combining unrelated tables:**
    * **Join limitation:** Joins require a relationship between tables (like `customer_id`). Without a relationship, a join produces a Cartesian product or meaningless results.
    * **Set operator solution:** `UNION` or `UNION ALL` can merge results vertically without any matching column.
  * **Finding common or distinct results:**
    * **Join limitation:** To find common rows (like `INTERSECT`) or differences (`EXCEPT`), you need complex joins, subqueries, or `DISTINCT` clauses.
    * **Set operator solution:** `INTERSECT` returns only common rows; `EXCEPT` returns rows in one query but not in another, with simple syntax.
  * **Simpler syntax for multi-query merging:**
    * **Join limitation:** Without set operators, combining multiple queries often requires nested queries or `DISTINCT` logic, which is messy.
    * **Set operator solution:** One command (`UNION`, `INTERSECT`, `EXCEPT`) handles multiple queries cleanly.
  * **Control over duplicates:**
    * **Join limitation:** Joins often produce duplicate rows automatically, requiring extra work with `DISTINCT`.
    * **Set operator solution:** `UNION` removes duplicates automatically, while `UNION ALL` keeps them when needed.
  * **Vertical combination of result sets:**
    * **Join limitation:** Joins merge horizontally (side by side) and cannot "stack" results easily.
    * **Set operator solution:** Set operators stack query results vertically, perfect for combining independent query outputs.

* **Set operators are ideal for merging independent query results, finding common or distinct rows, and controlling duplicates—tasks that are cumbersome or impossible with regular joins.**

* **Set operators overcome the limitations of joins when:**
  1. Combine the data from tables which are unrelated.
  2. You want common or exclusive results easily.
  3. You want a clean, simple syntax to merge multiple queries.
  4. You want automatic duplicate handling.
  5. You need vertical stacking of results rather than horizontal merging.

### 16.6 Advanced Interview Insights (Pro-Tips)
* **Q1. Interview Trick: How do SET operators handle NULL values?**
  * **English:** In SQL, `NULL = NULL` evaluates to `UNKNOWN` or `False`. However, when using `UNION`, the database treats two `NULL` values as **equal**. Therefore, if both queries return a row containing a `NULL`, `UNION` will consider them duplicates and filter one out.
  * **मराठी सारांश:** साध्या SQL मध्ये `NULL` आणि `NULL` समान नसतात. पण `UNION` करताना डेटाबेस दोन `NULL` ना समान (Equal) मानतो आणि डुप्लिकेट समजून एक काढून टाकतो!

* **Q2. Performance Trap: The "UNION" vs "UNION ALL" dilemma**
  * **English:** Always default to `UNION ALL` in production unless you explicitly need to remove duplicates. Using `UNION` forces the database to perform a massive sorting and deduplication operation across all combined rows, which severely degrades performance on large datasets.
  * **मराठी सारांश:** इंडस्ट्रीमध्ये `UNION ALL` वापरण्याची सवय लावा. डुप्लिकेट काढायचेच आहेत याची खात्री असल्याशिवाय `UNION` वापरू नका, कारण तो डेटाबेसवर जास्तीचा लोड (Sorting & Filtering) वाढवतो.

* **Q3. Real-World Use Case: Unpivoting Data**
  * **English:** While JOINs are used to pivot data (make it wider), `UNION ALL` is frequently used in data warehousing to **Unpivot** data (convert columns into rows) before analytical functions are applied.
  * **मराठी सारांश:** डेटा वेअरहाउसिंगमध्ये रुंद डेटा (Columns) लांब (Rows) करण्यासाठी म्हणजेच **Unpivot** करण्यासाठी `UNION ALL` खूप वापरला जातो.

---

## Topic 17: SQL Built-in Functions (String & Numeric)

### 17.1 What are SQL Functions?
* **English Definition/Properties:** A built-in SQL code that accepts an input value, processes it, and returns an output value. 
* **मराठी सारांश:** **काय आहे?** फंक्शन म्हणजे तयार SQL कोड. त्याला आपण इनपुट (Input) देतो, तो त्यावर प्रक्रिया (Process) करतो आणि आउटपुट (Output) देतो (जसे मशीनमध्ये ऊस टाका आणि रस मिळवा).
* ![Functions Intro](./svg_functions_intro.svg)

### 17.2 Categories of Functions
* **English Definition/Properties:** We group functions into two main categories based on how many rows they process at a time:
  1. **Single-Row Functions:** You give only one value as input, and it returns a single value as output. (e.g., converting a single name to lowercase).
  2. **Multi-Row Functions (Aggregate):** Accepts multiple rows/values as input, summarizes them, and returns a single summarized output. (e.g., `SUM()` of 10 rows returns 1 total).
* **मराठी सारांश:** फंक्शन्स 2 प्रकारचे असतात: **Single-Row** (एक row द्या, एकच रिझल्ट मिळवा) आणि **Multi-Row** (अनेक rows द्या आणि त्यांचा एकत्रित एक रिझल्ट मिळवा).
* ![Single vs Multi Row](./svg_single_vs_multi.svg)

### 17.3 Nested Functions
* **English Definition/Properties:** A function used inside another function. Multiple functions are nested together in order to manipulate a single value in stages.
* **मराठी सारांश:** **काय आहे?** एका फंक्शनच्या आत दुसरे फंक्शन वापरले की त्याला Nested Function म्हणतात. (कांद्याच्या पापुद्र्यांसारखे — काम आतून बाहेर होते).
* **Example / Order of Execution:** `LENGTH( LOWER( LEFT('Maria', 2) ) )`
* ![Nested Functions](./svg_nested_functions.svg)

### 17.4 String Functions (Manipulation & Extraction)
![String Functions Mastery](./svg_string_functions.svg)

#### Manipulation Functions
* **1. CONCAT()**
  * **English Definition:** Combines multiple strings into one single value.
  * **मराठी सारांश:** वेगवेगळे मजकूर (Strings) जोडून एक मजकूर बनवतो.
  * **Q1. Concatenate first name and country into one column with a space:**
    ```sql
    SELECT FIRSTNAME, COUNTRY, CONCAT(FIRSTNAME, ' ', COUNTRY) AS NAME_COUNTRY FROM CUSTOMERS;
    ```

* **2. UPPER() & LOWER()**
  * **English Definition:** `UPPER` converts all characters to uppercase. `LOWER` converts all characters to lowercase.
  * **मराठी सारांश:** मजकूर कॅपिटल (Uppercase) किंवा स्मॉल अक्षरांमध्ये (Lowercase) बदलण्यासाठी वापरतात.
  * **Q2. Transfer the customer's first name to lowercase and last name to uppercase:**
    ```sql
    SELECT FIRSTNAME, COUNTRY, LOWER(FIRSTNAME), UPPER(LASTNAME) FROM CUSTOMERS;
    ```

* **3. TRIM()**
  * **English Definition:** Removes leading and trailing spaces (empty spaces at the start or end) from the given string.
  * **मराठी सारांश:** मजकुराच्या सुरुवातीला आणि शेवटी असलेल्या जास्तीच्या रिकाम्या जागा (Spaces) काढून टाकतो.
  * **Q1. Find customers whose name contains leading or trailing spaces (Create a boolean flag 0/1):**
    ```sql
    SELECT FIRSTNAME, LENGTH(FIRSTNAME), LENGTH(TRIM(FIRSTNAME)) - LENGTH(FIRSTNAME) AS FLAG FROM CUSTOMERS;
    ```
  * ⚠️ **Note:** This gives 0 or a **negative** number (e.g. -2), not a clean 0/1 flag. For a 0/1 flag use `FIRSTNAME != TRIM(FIRSTNAME)`.

* **4. REPLACE()**
  * **English Definition:** Replaces a specific character or substring with a new character.
  * **मराठी सारांश:** मजकुरातील एखादा ठराविक भाग शोधून त्याच्या जागी नवीन काहीतरी टाकणे (किंवा रिकामे करणे).
  * **Q1. Remove the '-' from the phone number:**
    ```sql
    SELECT '123-456-789', REPLACE('123-456-789', '-', ''); -- Output: '123456789'
    ```
  * **Q2. Change file extension:**
    ```sql
    SELECT 'REPORT.TXT', REPLACE('REPORT.TXT', '.TXT', '.CSV'); -- Output: 'REPORT.CSV'
    ```

#### Calculation & Extraction Functions
* **5. LENGTH() / LEN()**
  * **English Definition:** Counts how many characters are in the string. (SQL Server uses `LEN()`, MySQL/pgAdmin use `LENGTH()`).
  * **मराठी सारांश:** मजकुरात किती अक्षरे (Characters) आहेत ते मोजून सांगतो.
  * **Q1. Calculate the length of each customer's first name:**
    ```sql
    SELECT LENGTH(FIRSTNAME) FROM CUSTOMERS;
    ```

* **6. LEFT() & RIGHT()**
  * **English Definition:** `LEFT` extracts a specific number of characters from the start. `RIGHT` extracts from the end.
  * **मराठी सारांश:** `LEFT` सुरुवातीपासून आणि `RIGHT` शेवटापासून तुम्ही सांगितलेली अक्षरे काढून देतो.
  * **Q1. Retrieve the first two characters of first name and last two of last name:**
    ```sql
    SELECT LEFT(FIRSTNAME, 2), RIGHT(LASTNAME, 2) FROM CUSTOMERS;
    ```

* **7. SUBSTRING()**
  * **English Definition:** `SUBSTRING(value, starting_position, length)` extracts a part of the string starting at a specified position. To get all remaining characters to the end, use `LENGTH()` as the third argument.
  * **मराठी सारांश:** मजकुराच्या मधून एखाद्या ठराविक जागेपासून (Position) भाग काढण्यासाठी वापरतात.
  * **Q1. Retrieve a list of customer's first names after removing the first character:**
    ```sql
    SELECT FIRSTNAME, SUBSTRING(FIRSTNAME, 2, LENGTH(FIRSTNAME)) FROM CUSTOMERS;
    ```

* **8. LOCATE() / CHARINDEX()**
  * ![LOCATE Concept](./svg_locate.svg)
  * **English Definition:** Finds the starting position (index) of a substring within a string. `LOCATE()` is for MySQL, while SQL Server uses `CHARINDEX()`.
  * **मराठी सारांश:** मजकुरात एखादे अक्षर (character) किंवा शब्द कुठे आहे, त्याची पोझिशन (Index) शोधतो.
  * **Interview Use Case:** Often used with `SUBSTRING()` to dynamically split strings (e.g., splitting a full name into first and last name using the space index).
  * **Q1. Find the position of '@' in an email address:**
    ```sql
    SELECT LOCATE('@', 'vishal@gmail.com') AS position; -- Output: 7
    ```

### 17.5 Numeric Functions
* **English Definition/Properties:** Functions that operate on numeric values for mathematical operations.
* **मराठी सारांश:** संख्या आणि गणिताच्या (Math) क्रियांसाठी वापरली जाणारी फंक्शन्स.
* ![Numeric Functions](./svg_numeric_functions.svg)

* **1. ROUND()**
  * **English Definition:** `ROUND(value, decimals)` rounds the value to the given number of decimal places. If the next digit is 5 or more, it rounds up; otherwise it rounds down.
  * **मराठी सारांश:** संख्या राउंड ऑफ (Round off) करतो. 2 दशांशांपर्यंत राउंड करताना तिसरा अंक 5 किंवा जास्त असेल तर दुसरा अंक एकने वाढतो.
  * **Example:**
    ```sql
    SELECT 3.516, ROUND(3.516, 2) AS ROUND2, ROUND(3.516, 1) AS ROUND1, ROUND(3.516, 0) AS ROUND0;
    -- Result: 3.516 -> ROUND2: 3.52, ROUND1: 3.5, ROUND0: 4
    ```

* **2. ABS()**
  * **English Definition:** Returns the absolute (positive) value of a number, removing any negative sign.
  * **मराठी सारांश:** कोणतीही नेगेटिव्ह (-) संख्या पॉझिटिव्ह (+) करतो.
  * **Example:**
    ```sql
    SELECT ABS(-10), ABS(10);
    -- Result: 10, 10
    ```

* **3. CEILING() / CEIL()**
  * **English Definition:** Always rounds a number *up* to the nearest integer.
  * **मराठी सारांश:** संख्या नेहमी पुढच्या मोठ्या पूर्णांकावर राउंड करतो.
  * **Example:**
    ```sql
    SELECT CEILING(4.1), CEILING(4.9);
    -- Result: 5, 5
    ```

* **4. MOD(x, y) / % Operator**
  * ![MOD Concept](./svg_mod_even_odd.svg)
  * **English Definition:** Returns the remainder of a division operation.
  * **मराठी सारांश:** भागाकार केल्यावर उरणारी बाकी (Remainder) काढतो.
  * **Interview Use Case (Even/Odd Numbers):** Very frequently asked in interviews to find even or odd rows.
  * **Q1. Find all even ID numbers and odd ID numbers:**
    ```sql
    -- Even IDs
    SELECT * FROM employees WHERE MOD(id, 2) = 0;
    -- Odd IDs
    SELECT * FROM employees WHERE MOD(id, 2) = 1;
    ```

---

## Topic 18: Date and Time Functions

### 18.1 Anatomy of Date & Time
* **English Definition/Properties:** A Date typically contains Year, Month, and Day. A Time contains Hours, Minutes, and Seconds. A Timestamp (or Datetime) combines both.
* **मराठी सारांश:** Date मध्ये वर्ष, महिना आणि दिवस असतो. Time मध्ये तास, मिनिटे आणि सेकंद असतात. Timestamp (Datetime) म्हणजे दोन्ही एकत्र.
* ![Anatomy of Date & Time](./svg_datetime_anatomy.svg)

### 18.2 Sources of Dates (How to Query Dates)
* **English Definition/Properties:** We have three main sources to get dates in SQL:
  1. **From a Table Column:** Fetching stored dates. (e.g., `SELECT HIRE_DATE FROM CUSTOMERS;`)
  2. **Hardcoded Constant String:** Providing a static date directly in the query. (e.g., `SELECT '2025-08-20' AS NEWDATE;`)
  3. **System Current Date/Time Functions:** Using built-in functions like `GETDATE()` (SQL Server) or `NOW()` / `CURRENT_TIMESTAMP()` (MySQL).
* **मराठी सारांश:** SQL मध्ये तारीख 3 प्रकारे मिळते: (1) टेबलच्या कॉलममधून, (2) स्वतः लिहून (hardcode/static), (3) सिस्टमची सध्याची तारीख देणारी फंक्शन्स वापरून.

### 18.3 Overview of Built-in Date/Time Functions (MySQL focus)
![Date & Time Overview](./svg_datetime_overview.svg)
![Function Return Types](./svg_func_comparison_datatype.svg)

#### A. Current Date & Time Functions
* **1. NOW() & CURRENT_TIMESTAMP()**
  * **English:** Returns the current system date and time. `NOW()` is mostly used in `SELECT` queries, while `CURRENT_TIMESTAMP` is preferred as a default value in table definitions.
  * **मराठी सारांश:** हे दोन्ही सिस्टमची आजची तारीख आणि आत्ताची वेळ सांगतात.
  * **Example:** `SELECT NOW();` $\rightarrow$ `2025-09-03 13:30:20`
* **2. CURDATE() / UTC_DATE()**
  * **English:** `CURDATE()` returns only the current Date (no time). `UTC_DATE()` returns the current UTC date.
  * **मराठी सारांश:** फक्त आजची तारीख हवी असेल (वेळेशिवाय) तर `CURDATE()` वापरतात.
  * **Example:** `SELECT CURDATE();` $\rightarrow$ `2025-09-03`
* **3. CURTIME() / UTC_TIME()**
  * **English:** Returns only the current Time (no date).
  * **मराठी सारांश:** फक्त आत्ताची वेळ हवी असेल तर `CURTIME()`.

#### B. Extracting Parts of a Date
* ![Date Extraction](./svg_date_extraction.svg)
* **English Definition/Properties:** You can extract specific parts like year, month, or day from a full datetime. In SQL Server, `DATEPART(part, date)` is commonly used. In MySQL, direct functions are used.
* **मराठी सारांश:** पूर्ण तारखेतून फक्त वर्ष, महिना किंवा दिवस वेगळा काढण्यासाठी ही फंक्शन्स वापरतात.

* **Examples:**
  * **YEAR(date):** `SELECT YEAR('2025-09-03');` $\rightarrow$ `2025`
  * **MONTH(date):** `SELECT MONTH('2025-09-03');` $\rightarrow$ `9`
  * **DAY(date) / DAYOFMONTH(date):** `SELECT DAY('2025-09-03');` $\rightarrow$ `3`
  * **HOUR(time):** `SELECT HOUR('13:45:59');` $\rightarrow$ `13`
  * **MINUTE(time):** `SELECT MINUTE('13:45:59');` $\rightarrow$ `45`
  * **SECOND(time):** `SELECT SECOND('13:45:59');` $\rightarrow$ `59`
  * **MICROSECOND(time):** `SELECT MICROSECOND('2025-09-03 13:45:59.123456');` $\rightarrow$ `123456`
  * **DAYOFWEEK(date):** `SELECT DAYOFWEEK('2025-09-03');` $\rightarrow$ `4` (1=Sunday, 7=Saturday)
  * **DAYOFYEAR(date):** `SELECT DAYOFYEAR('2025-09-03');` $\rightarrow$ `246` (1 to 366)
  * **WEEK(date):** `SELECT WEEK('2025-09-03');` $\rightarrow$ `35` (Week of the year)
  * **QUARTER(date):** `SELECT QUARTER('2025-09-03');` $\rightarrow$ `3` (Quarter of the year, 1-4)
  
  * **DATENAME() / DAYNAME() / MONTHNAME()**
    * ![DATENAME Concept](./svg_datename.svg)
    * **English:** In SQL Server, `DATENAME(part, date)` returns the name of a specific part as a string. (e.g., `DATENAME(WEEKDAY, date)` $\rightarrow$ `'Monday'`). MySQL doesn't support `DATENAME`, so you use `DAYNAME(date)` and `MONTHNAME(date)`.
    * **मराठी सारांश:** दिवसाचे किंवा महिन्याचे नाव हवे असल्यास (जसे Monday किंवा September) SQL Server मध्ये `DATENAME` आणि MySQL मध्ये `DAYNAME` / `MONTHNAME` वापरतात.

  * **EOMONTH() / LAST_DAY()**
    * ![EOMONTH Concept](./svg_eomonth.svg)
    * **English:** Returns the last day of the month for the given date. Used in SQL Server as `EOMONTH(date)`. In MySQL, use `LAST_DAY(date)`. To get the *first* date of the month in MySQL, use `DATE_FORMAT(date, '%Y-%m-01')`.
    * **मराठी सारांश:** कोणत्याही महिन्याची शेवटची तारीख (30/31/28) काढण्यासाठी SQL Server मध्ये `EOMONTH` आणि MySQL मध्ये `LAST_DAY` वापरतात.

* **Q1. Extract multiple parts from a table:**
  ```sql
  SELECT CREATIONTIME, YEAR(CREATIONTIME) AS YEAR, MONTH(CREATIONTIME) AS MONTH, DAY(CREATIONTIME) AS DAY, DAYNAME(CREATIONTIME) AS DAYNAME FROM ORDERS;
  ```

#### C. Date/Time Manipulation (Adding & Subtracting)
* ![Date Manipulation](./svg_date_manipulation.svg)
* **English Definition:** You can add or subtract time intervals (days, months, hours) to/from a specific date.
* **मराठी सारांश:** एखाद्या तारखेत काही दिवस, महिने किंवा वर्षे मिळवण्यासाठी (Add) किंवा वजा करण्यासाठी (Subtract) ही फंक्शन्स वापरतात.
* **1. DATE_ADD() / ADDDATE()**
  * `SELECT DATE_ADD('2025-09-03', INTERVAL 10 DAY);` $\rightarrow$ `2025-09-13`
* **2. DATE_SUB() / SUBDATE()**
  * `SELECT DATE_SUB('2025-09-03', INTERVAL 2 MONTH);` $\rightarrow$ `2025-07-03`
* **3. ADDTIME() & SUBTIME()**
  * `SELECT ADDTIME('10:00:00', '02:30:00');` $\rightarrow$ `12:30:00`

#### D. Differences & Conversion
* **1. DATEDIFF() & TIMESTAMPDIFF()**
  * ![DATEDIFF Concept](./svg_datediff_concept.svg)
  * **English:** Used to find the difference between two dates. 
    * **In SQL Server:** `DATEDIFF(interval, start_date, end_date)` allows you to specify the interval (YEAR, MONTH, DAY). (e.g., `SELECT DATEDIFF(MONTH, '2025-08-20', '2026-02-01');` $\rightarrow$ `6` — SQL Server counts month boundaries crossed: Aug → Feb = 6)
    * **In MySQL:** `DATEDIFF(end_date, start_date)` returns the difference in **Days only**. For differences in Years, Months, or Hours, use `TIMESTAMPDIFF(unit, start_date, end_date)`.
  * **मराठी सारांश:** दोन तारखांमधील फरक काढण्यासाठी. SQL Server मध्ये `YEAR`, `MONTH`, `DAY` सांगता येते, पण MySQL मध्ये `DATEDIFF` फक्त दिवस सांगतो; बाकीसाठी `TIMESTAMPDIFF` वापरतात.
  * **Q1. Calculate the Age of the Employee (Difference in Years) (MySQL):**
    ```sql
    SELECT FIRSTNAME, LASTNAME, TIMESTAMPDIFF(YEAR, BIRTHDATE, NOW()) AS AGE FROM EMPLOYEES;
    ```
  * **Difference in Hours/Minutes (MySQL):**
    ```sql
    SELECT TIMESTAMPDIFF(HOUR, '2025-09-27 10:00:00', '2025-09-28 12:30:00') AS hours_diff;
    ```
* **2. Conversions (Seconds / UNIX Epoch)**
  * **TIME_TO_SEC(time):** `SELECT TIME_TO_SEC('01:30:00');` $\rightarrow$ `5400` seconds.
  * **SEC_TO_TIME(seconds):** `SELECT SEC_TO_TIME(5400);` $\rightarrow$ `01:30:00`.
  * **UNIX_TIMESTAMP(date):** Converts a date into Unix epoch seconds.
  * **FROM_UNIXTIME(epoch):** Converts Unix seconds back to Date.

#### E. Formatting Functions
* ![Formatting Concept](./svg_formatting_concept.svg)
* **English Definition/Properties:** Changing the format of a value from one presentation to another (changing how data looks) without changing the actual data value. We do this for data standardization or aggregation.
* **मराठी सारांश:** मूल्य दिसण्याची पद्धत (Format) बदलणे (जसे Date किंवा Number ला String मध्ये बदलणे).

* **1. DATETRUNC() / DATE_TRUNC()**
  * ![DATETRUNC Concept](./svg_datetrunc_concept.svg)
  * **English:** Truncates a date to a specific part (like Year or Month), resetting the rest to the lowest value (01 for days/months, 00 for time). 
    * `DATE_TRUNC()` is available in PostgreSQL and SQL Server. (e.g., `DATE_TRUNC('month', date)` $\rightarrow$ Keeps Year-Month, resets Day to 01).
    * In **MySQL**, you achieve this using `DATE_FORMAT(date, '%Y-%m-01')`.
  * **मराठी सारांश:** तारखेचा एखादा भाग तसाच ठेवणे आणि बाकीचे भाग 01 किंवा 00 करणे (Reset करणे).

* **2. FORMAT() (SQL Server)**
  * **English:** In SQL Server, `FORMAT(value, format)` is a powerful function to convert Dates or Numbers to formatted strings.
  * **Date Specifiers:** `d` (Short date), `D` (Full date), `MMMM` (Full month name), `yyyy` (4-digit year).
  * **Number Specifiers:** `N` (Number with commas), `P` (Percentage), `C` (Currency).
    * `SELECT FORMAT(1234567.89, 'C');` $\rightarrow$ `$1,234,567.89`

* **3. DATE_FORMAT() (MySQL)**
  * **English:** MySQL uses `DATE_FORMAT` to format dates.
  * **Key Format Codes:**
    * `%Y`: 4-digit year (2025)
    * `%M`: Full month name (September)
    * `%d`: Day of month with zero (07)
    * `%W`: Full weekday name (Sunday)
  * `SELECT DATE_FORMAT('2025-09-03', '%W %M %Y');` $\rightarrow$ `Wednesday September 2025`

* **4. STR_TO_DATE() (MySQL)**
  * **English:** Parses a string into a date. Used to check if a date string is valid and convert it to SQL Date format.
  * `SELECT STR_TO_DATE('03-09-2025', '%d-%m-%Y');` $\rightarrow$ `2025-09-03`

#### F. Data Type Conversion (CAST & CONVERT)
* ![CAST CONVERT Concept](./svg_cast_convert.svg)
* ![CAST vs FORMAT Concept](./svg_cast_vs_format.svg)
* **1. CAST(expression AS data_type)**
  * **English:** Used to convert a value from one data type to another (e.g., String to Number, Datetime to Date). Helps ensure correct formatting and comparison in SQL.
  * **मराठी सारांश:** एक डेटा टाइप दुसऱ्या डेटा टाइपमध्ये बदलण्यासाठी (जसे टेक्स्टला नंबरमध्ये).
  * **Examples (MySQL):**
    * `SELECT CAST('456' AS SIGNED);` (String to Integer)
    * `SELECT CAST(NOW() AS DATE);` (Datetime to Date)
* **2. CONVERT()**
  * **English:** In SQL Server, `CONVERT` is used like `CAST` but supports specific format styles. In MySQL, `CONVERT` is primarily used to change the Character Set Encoding (e.g., `SELECT CONVERT('hello' USING utf8mb4);` for Emoji support).

#### G. Date Validation & Real-World Use Cases
* **Date Validation (ISDATE)**
  * ![ISDATE Concept](./svg_isdate.svg)
  * **English:** Used to check if a date string is valid. SQL Server uses `ISDATE()`. MySQL doesn't have it, so you use `STR_TO_DATE` with a `CASE` statement (if it returns NULL, it's invalid).
* **Date Extraction Use Cases (Aggregation & Filtering)**
  * **Q1. Find average shipping duration in days for each month:**
    ```sql
    SELECT MONTHNAME(orderdate) AS OrderMonth, ROUND(AVG(DATEDIFF(shipdate, orderdate))) AS ShippingDurationInDays
    FROM orders 
    GROUP BY MONTH(orderdate), MONTHNAME(orderdate)
    ORDER BY MONTH(orderdate);
    ```
    *(Note: `ROUND()` rounds to nearest integer, `FLOOR()` always rounds down).*
  * **Q2. Find the number of days between each order and the previous order (Using LAG):**
    ```sql
    -- LAG() is a window function in MySQL 8.0 that gets data from a previous row.
    SELECT orderid, orderdate AS CurrentOrderDate, LAG(orderdate) OVER (ORDER BY orderdate) AS PreviousOrderDate,
    DATEDIFF(orderdate, LAG(orderdate) OVER (ORDER BY orderdate)) AS NoOfDays FROM orders;
    ```

---

## Topic 19: NULL Functions & Conditional Logic (CASE)
![NULL Functions Overview](./svg_null_overview.svg)

### 19.1 What is NULL?
* **English Definition/Properties:** NULL means nothing or unknown. 
  * NULL is **not equal to anything** (not even another NULL).
  * NULL is **not zero** (0).
  * NULL is **not an empty string** (`''`).
  * NULL is **not a blank space** (`' '`).
* **मराठी सारांश:** NULL म्हणजे "काहीच नाही" (Unknown). ते 0 नाही आणि रिकामी जागा (Space) पण नाही.

### 19.2 Checking for NULL
* ![IS NOT NULL Logic](./svg_is_not_null.svg)
* **English:** To check if a value is NULL, you must use `IS NULL` or `IS NOT NULL`. Normal operators like `=` do not work with NULL.
  * *MySQL vs SQL Server:* In SQL Server, `ISNULL()` **replaces** NULL with another value: `ISNULL(value, replacement)` (like MySQL's `IFNULL()`). In MySQL, `ISNULL(expr)` only **checks** for NULL (returns 1 or 0). To filter rows, use `IS NULL`.
* **मराठी सारांश:** आपण `WHERE column = NULL` लिहू शकत नाही. नेहमी `IS NULL` किंवा `IS NOT NULL` लिहावे लागते.

**Anti-Joins Recap (Using IS NULL)**
* ![Joins & Anti-Joins Recap](./svg_anti_join_recap.svg)
* **English:** You can use `IS NULL` with a `LEFT JOIN` or `RIGHT JOIN` to find unmatching rows between two tables (this is known as an Anti-Join).
* **Q1. List all details for customers who have not placed any order:**
  ```sql
  SELECT c.*, o.orderid 
  FROM customers c 
  LEFT JOIN orders o ON c.customerid = o.customerid 
  WHERE o.customerid IS NULL;
  ```

### 19.3 Handling & Replacing NULL values
* **1. IFNULL() (MySQL)**
  * **English:** Replaces NULL with a specified default value. Works for a single expression.
  * **Syntax:** `IFNULL(value, replace_value)`
  * **Q1. Sort customers with null scores appearing last:**
    ```sql
    SELECT customerId, score, CASE WHEN score IS NULL THEN 1 ELSE 0 END AS flag 
    FROM customers 
    ORDER BY IFNULL(score, 999999) DESC;
    ```
  * ⚠️ **Note:** With `DESC`, 999999 is the biggest value, so NULL scores come **first**, not last. For "NULLs last" with the highest score first, use `ORDER BY score IS NULL, score DESC`.
* **2. COALESCE(expr1, expr2, ...)**
  * ![ISNULL vs COALESCE](./svg_isnull_vs_coalesce.svg)
  * **English:** Returns the **first non-null value** from a list of expressions. If the first value is NULL, it moves to the next (like a fallback system).
  * **Why use COALESCE instead of IFNULL?** `IFNULL()` only checks one expression. `COALESCE()` checks multiple fields in order.
  * **मराठी सारांश:** `COALESCE` यादीतील पहिले असे मूल्य शोधतो जे NULL नाही. (जसे ईमेल नसेल तर फोन नंबर घ्या, फोन नसेल तर पत्ता घ्या).
  * **Use Cases for COALESCE:**
    1. **In Aggregations:** Handle NULL before mathematical operations (e.g., `SUM(COALESCE(score, 0))`).
    2. **In Joins:** Handle NULLs before joining tables.
       * ![COALESCE in JOIN](./svg_coalesce_join.svg)
    3. **In Sorting:** Handle NULLs before sorting data.
  * **Q1. Sort the customers from lowest to highest score with null appearing last:**
    ```sql
    SELECT customerId, score, CASE WHEN score IS NULL THEN 1 ELSE 0 END AS flag 
    FROM customers 
    ORDER BY COALESCE(score, 999999) DESC;
    ```
  * ⚠️ **Note:** The question says *lowest to highest*, so it should be `ORDER BY COALESCE(score, 999999) ASC`. With `DESC`, NULL rows come first.
  * **Q2. Find the average score of the customers:**
    ```sql
    SELECT customerid, score, COALESCE(score, 0) AS score_2, AVG(score) OVER() AS avgScore2 
    FROM customers;
    ```
  * **Q3. Display the full name of customers in a single field by merging their first and last name and add 10 bonus points to each customer's score:**
    ```sql
    SELECT CONCAT(firstname, ' ', lastname) AS fullname, (COALESCE(score, 0) + 10) AS adjusted_score 
    FROM customers;
    ```

### 19.4 NULLIF()
* ![NULLIF Flowchart](./svg_nullif_flowchart.svg)
* **English Definition/Properties:** `NULLIF(expr1, expr2)` compares two expressions. If they are equal, it returns NULL. If they are not equal, it returns the first expression.
* **मराठी सारांश:** दोन्ही मूल्ये सारखी असतील तर हे NULL देते, नाहीतर पहिलेच मूल्य परत देते.
* **Use Case (Avoiding Divide by Zero Error):**
  * **Q1. Find the sales price for each order dividing by its quantity:**
    ```sql
    -- If quantity is 0, NULLIF makes it NULL, preventing a crash.
    SELECT orderid, sales, sales / NULLIF(quantity, 0) AS price_per_unit FROM orders;
    
    -- Another example avoiding divide by zero error:
    SELECT 100 / NULLIF(column_value, 0) AS result FROM your_table;
    ```

### 19.5 Data Policies regarding NULL, Space, and Empty
* ![NULL vs Empty String vs Blank Space](./svg_null_vs_empty.svg)
* **Example showing the difference between NULL, Empty String, and Space:**
  ```sql
  WITH orders AS (
      SELECT 1 AS id, 'A' AS categories
      UNION
      SELECT 2, NULL
      UNION
      SELECT 3, ''
      UNION
      SELECT 4, ' '
  )
  SELECT *, LENGTH(categories) AS categoriesLength FROM orders;
  ```
* **English:** Data policies are sets of rules that define how data should be handled:
  1. Use only NULL and empty strings, but avoid blank spaces (use `TRIM()`).
  2. Use only NULL and avoid empty strings and blank spaces.
  3. Use a default value like `'unknown'` and avoid NULL, empty strings, and blank spaces entirely.

### 19.6 Conditional Logic: CASE Statement
* ![CASE Summary](./svg_case_summary.svg)
* **English Definition/Properties:** The `CASE` statement is SQL's way of handling "If-Then-Else" logic. It evaluates a list of conditions from top to bottom and returns a value when the first condition is met. Used heavily for data transformation.
* **मराठी सारांश:** हे प्रोग्रामिंगमधील `If-Else` सारखे काम करते. याने डेटाची कॅटेगरी बदलता येते किंवा अटी लावता येतात.

#### How does it work?
* ![CASE Execution Flow](./svg_case_execution.svg)
* **English:** How does SQL execute the CASE statement behind the scenes? In a CASE statement, SQL stops execution once the first condition is met for the current row. Then it does not check with another condition.
* **मराठी सारांश:** SQL वरून खाली तपासते. पहिली खरी (TRUE) अट मिळताच ते तिथेच थांबते आणि पुढच्या अटी तपासत नाही.

#### CASE Statement Rules
1. **The data type of the result must be matching:** The result of each condition must have a compatible data type (e.g., all strings like 'HIGH', 'LOW', 'MEDIUM').
2. **Can be used anywhere in the query:** A CASE statement can be used in `SELECT`, `WHERE`, `ORDER BY`, `GROUP BY`, etc.

#### Quick Form vs Full Form
* ![CASE Quick vs Full](./svg_case_full_vs_quick.svg)
* **Another way to write case statement:**
  * **Full Form (Searched CASE):** `CASE WHEN Country = 'Germany' THEN 'DE'` (Allows complex conditions like `>`, `<`, `BETWEEN`).
  * **Quick Form (Simple CASE):** `CASE Country WHEN 'Germany' THEN 'DE'` (Evaluates a single column against static values).

#### Syntax Breakdown
* `CASE` $\rightarrow$ Starts the logical block.
* `WHEN condition1 THEN result1` $\rightarrow$ Condition to evaluate, and what to return if True.
* `ELSE default_result` $\rightarrow$ (Optional) Returned if all WHEN conditions are False.
* `END` $\rightarrow$ Ends the CASE block.

#### Use Cases of CASE Statement

**Use Case 1: Categorizing Data**
* **English:** Group the data into different categories based on certain conditions. Classifying and grouping the data makes it easy to understand and helps in aggregating data based on categories.
* **Q1. Generate a report showing the total sales for each category (HIGH > 50, MEDIUM 20-50, LOW <= 20) and sort from lowest to highest:**
  ```sql
  SELECT Category, SUM(SALES) AS totalsales FROM (
      SELECT ORDERID, CUSTOMERID, sales,
      CASE
          WHEN sales > 50 THEN 'HIGH'
          WHEN sales BETWEEN 20 AND 50 THEN 'MEDIUM'
          WHEN sales <= 20 THEN 'LOW'
          ELSE 'NO DATA'
      END AS Category
      FROM orders 
  ) AS derived_table
  GROUP BY Category
  ORDER BY totalsales ASC;
  ```
  *(Make sure to always give the name of the derived table. In the above example, we used `derived_table`).*

**Use Case 2: Data Transformation**
* **English:** Main purpose is data transformation - deriving new information (creating new columns based on existing data).

**Use Case 3: Mapping Values**
* **English:** Transform the value from one form to another to make it more readable for analysis.
* **Q1. Retrieve employee details where gender displays as full text:**
  ```sql
  SELECT firstname, lastname, gender,
  CASE
      WHEN gender = 'f' THEN 'Female'
      WHEN gender = 'm' THEN 'Male'
      ELSE 'NO MATCH'
  END AS GENDERTABLE
  FROM EMPLOYEES;
  ```
* **Q2. Retrieve customer details with abbreviated country code:**
  ```sql
  SELECT firstname, lastname, country,
  CASE
      WHEN country = 'Germany' THEN 'GE'
      WHEN country = 'USA' THEN 'US'
      ELSE 'NOT MATCH'
  END AS abbreviatedName
  FROM customers;
  ```

**Use Case 4: Handling NULLs**
* **English:** Handling NULL means replacing NULL with a specific value. Sometimes NULLs can lead to inaccurate results which can lead to wrong decision making.
* **Q1. Find the average score of customers and treat NULL as zero:**
  ```sql
  SELECT CUSTOMERID, FIRSTNAME, LASTNAME, SCORE, AVG(SCORE) OVER() AS AVG_SCORE,
  AVG(CASE
      WHEN SCORE IS NULL THEN 0
      ELSE SCORE
  END) OVER() AS AVGSCORE
  FROM CUSTOMERS;
  ```

**Use Case 5: Conditional Aggregation**
* **English:** Apply aggregation functions only on a subset of data that fulfills certain conditions. (Using a binary indicator 1/0 to summarize how many times the condition is true).
* **Q1. Count how many times each customer has made an order with sales greater than 30:**
  ```sql
  SELECT customerid,
  SUM(CASE
      WHEN SALES > 30 THEN 1
      ELSE 0
  END) AS SALES_FLAG,
  COUNT(*) AS TOTALORDERS
  FROM orders  
  GROUP BY customerid;
  ```


### 19.7 IF() Function (MySQL Shorthand)
* ![IF Function](./svg_if_function.svg)
* **English Definition:** In MySQL, the `IF(condition, true_value, false_value)` function is a shorter, inline alternative to simple `CASE` statements.
* **मराठी सारांश:** अट छोटी असेल (जसे Excel मधील IF), तर MySQL मध्ये पूर्ण CASE लिहिण्याऐवजी थेट `IF()` फंक्शन वापरता येते. हे लहान आणि वाचायला सोपे आहे.
* **Q1. Mark students as Pass or Fail based on score:**
  ```sql
  SELECT 
    studentid, 
    score, 
    IF(score >= 50, 'Pass', 'Fail') AS result 
  FROM students;
  ```

---

## Topic 20: Aggregate & Window Functions (Analytics)

### 20.1 Aggregation Functions in SQL
* ![Aggregation Overview](./svg_aggregation_overview.svg)
* **English Definition/Properties:** Aggregation functions accept multiple rows as input and perform calculations on a set of values to return a **single summarized value** as output. They are often used with the `GROUP BY` clause.
* **मराठी सारांश:** ॲग्रीगेशन फंक्शन्स अनेक rows चा डेटा घेतात, त्यावर गणित करतात आणि शेवटी एकच मूल्य देतात (जसे सर्वांची बेरीज, सरासरी).

* **1. COUNT()**
  * `COUNT(*)`: Counts **all** rows inside the table (including NULLs).
  * `COUNT(column)`: Counts only non-NULL values in the specified column.
  * **Q1. Find the total number of orders:** `SELECT COUNT(*) FROM orders;`

* **2. SUM()**
  * **Definition:** Adds up all numeric values in a column.
  * **Q1. Find the total sales of all orders:** `SELECT SUM(sales) AS totalSales FROM orders;`

* **3. AVG()**
  * **Definition:** Returns the mathematical average of numeric values.
  * **Q1. Find the average sales of all orders:** `SELECT AVG(sales) AS avgSales FROM orders;`

* **4. MIN() & MAX()**
  * **Definition:** `MIN()` starts searching and returns the lowest value. `MAX()` searches and returns the highest value in the column.
  * **Q1. Find the lowest and highest sales:** 
    `SELECT MIN(sales) AS minSales, MAX(sales) AS maxSales FROM orders;`

* **5. GROUP_CONCAT() (MySQL Specific)**
  * **Definition:** Concatenates (joins) values from a group into a single string.
  * **Example:** `SELECT department, GROUP_CONCAT(name) AS employee_names FROM employees GROUP BY department;`
  * **Result:** Returns data like `'Frank,Kevin,Mary'` (all first names as a single comma-separated string).

* **6. STD() / STDDEV() & VARIANCE()**
  * **Definition:** Returns the standard deviation and variance of numeric values (statistical functions).
  * **Example:** `SELECT STD(salary), VARIANCE(salary) FROM employees;`

---

### 20.2 Window Functions (Analytical Functions)
* **English Definition/Properties:** Window Functions are one of the most powerful features in SQL. They allow you to perform calculations (e.g. aggregations) on a specific subset of data, **without losing the level of detail of the rows.**
* **मराठी सारांश:** हे SQL चे खूप पॉवरफुल साधन आहे. हे `GROUP BY` सारखे गणित करते, पण टेबलच्या rows कमी (Squash) करत नाही. मूळ rows तशाच राहतात, फक्त शेजारी एक नवीन गणित केलेला कॉलम जोडला जातो.

#### The OVER() Clause
* **English:** Tells SQL that the function used is a window function. It defines a "window" or subset of data (the scope of rows the function operates on).
* `OVER()` is basically the "GROUP BY" of window functions. Without it, functions like `ROW_NUMBER()` cannot work because they need to know how to group and order the rows.
* *Note: Window functions cannot be used in the `WHERE` clause, but they can be used in `SELECT` or `ORDER BY`.*

#### GROUP BY vs WINDOW FUNCTION
* ![Window vs GroupBy](./svg_window_vs_groupby.svg)
* **GROUP BY (Simple Data Analysis - Aggregations):** Squashes/collapses the result. If you have 4 rows of sales for 2 products, it smashes them into 2 rows. **You lose the row-level details** (granularity changes). Returns a single row for each group.
* **WINDOW FUNCTION (Advanced Data Analysis - Aggregations + Details):** Evaluates each row individually. It starts with the first row, adds a total sales column, moves to the next, and keeps the original 4 rows intact. **The granularity stays the same.** Returns a result for each row.
* **Q1. Find total sales across all orders (Simple Aggregation):** 
  `SELECT SUM(sales) FROM orders;`
* **Q2. Find total sales for each product (GROUP BY):** 
  `SELECT productid, SUM(sales) FROM orders GROUP BY productid;`
* **Q3. Find total sales for each product, BUT ALSO provide orderID and orderDate (WINDOW FUNCTION):**
  ```sql
  SELECT productid, orderid, orderdate,
         SUM(sales) OVER(PARTITION BY productid) AS totalSales, 
         AVG(sales) OVER() AS averageSales 
  FROM orders;
  ```

---

### 20.3 Ranking Window Functions
* **English Definition/Properties:** Used to rank data. SQL always sorts the data as a first step before ranking your data.
* **मराठी सारांश:** डेटाला रँक (Rank 1, 2, 3...) देण्यासाठी.
* ![Rank vs Dense Rank](./svg_rank_vs_dense_rank.svg)

#### Window Rank Functions Syntax
* ![Window Rank Syntax](./svg_window_syntax.svg)
* **1st Rule (About RANK function syntax):**
  * **Expression:** In syntax, start with a function like `RANK()`, but we don't use any argument inside it. It must be **empty**. (It doesn't allow you to use any argument inside it).
  * **Partition By:** The `PARTITION BY` clause is **optional**.
  * **Order By:** The `ORDER BY` clause is **required**. You cannot leave it empty because the ranking function needs to know how to sort data before ranking.

* **1. ROW_NUMBER()**
  * **Definition:** Assigns a unique, sequential number to each row in the result set (1, 2, 3, 4...).
  * **Handling Ties:** It does **NOT** handle ties. If two rows share the same value, they will **not** share the same rank. It always gives a distinct, unique rank for each row. (e.g. Top 1 order per customer).
  * **Q1. Rank the orders based on their sales from highest to lowest:**
    ```sql
    SELECT 
      OrderID,
      ProductID,
      Sales,
      ROW_NUMBER() OVER(ORDER BY Sales DESC) AS SalesRank_Row
    FROM Sales.Orders;
    ```

* **2. RANK()**
  * **Definition:** Assigns a rank to rows in a window, with gaps.
  * **Handling Ties:** It **handles ties**. If two rows have the same value, they share the same rank (e.g., 1, 1). 
  * **The Gap:** The next rank is **skipped** (Leaves a gap). After 1, 1, the next rank will be 3.

* **3. DENSE_RANK()**
  * **Definition:** Assigns a rank to each row in a window, without gaps.
  * **Handling Ties:** It handles ties just like `RANK()` (e.g., 1, 1), but does **NOT** skip the next rank. The next rank will be 2. (Leaves NO gaps).

* **4. NTILE(n)**
  * **Definition:** Divides the rows into a specified number of approximately equal groups (Buckets).
  * **Argument:** The `NTILE` function always gets its argument as a number (`n`), representing the number of buckets.
  * **Bucket Size Calculation:** `Bucket size = Total number of rows / number of buckets (n)`.
  * **SQL Rule for Buckets:** If the division is not perfectly equal, the **larger groups come first**, then smaller.
  * ![NTILE function details](./svg_ntile.svg)

#### Integer-based vs Percentage-based Ranking
* ![Percentage vs Integer](./svg_percentage_vs_integer.svg)
* **Integer-Based Ranking (`ROW_NUMBER`, `RANK`, `DENSE_RANK`, `NTILE`):**
  * Assigns discrete values (1, 2, 3, 4, 5).
  * Primarily used for **Top / Bottom N Analysis**.
* **Percentage-Based Ranking (`CUME_DIST`, `PERCENT_RANK`):**
  * Assigns continuous values (0, 0.25, 0.5, 0.75, 1).
  * Primarily used for **Distribution Analysis**.

#### Use Cases for Ranking Functions
1. **Use Case 1 | Top-N Analysis:** 
   * **English:** Help analyze the top performers to do targeted marketing. Find the top highest sales for each product.
   * *(Note: In window function we cannot use WHERE clause, so we use a subquery to filter the highest sales).*
   ```sql
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
   ```

2. **Use Case 2 | Bottom-N Analysis:** 
   * **English:** Help analyze underperformance to manage risks and to do optimizations. Find out the lowest performance sales.
   ```sql
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
   ```

3. **Use Case 3 | Assigning Unique IDs (Pagination):** 
   * **English:** Help to assign a unique identifier for each row to help pagination. The process of breaking down large data into smaller, and more manageable chunks.

4. **Use Case 4 | Identify the Duplicates (Quality Checks):** 
   * **English:** Used for data cleansing. Identify and remove duplicate rows to improve data quality. If you want to remove duplicate rows, use `PARTITION BY` with the primary_key column inside the `OVER()` window function.
   ```sql
   -- Identify duplicate rows in the table 'OrdersArchive'
   -- and return a clean result without any duplicates
   SELECT * FROM (
     SELECT
       *,
       ROW_NUMBER() OVER(PARTITION BY OrderID ORDER BY CreationTime DESC) AS rn
     FROM Sales.OrdersArchive
   ) t 
   WHERE rn = 1;
   ```

5. **Use Case 5 | Data Segmentation (NTILE):** 
   * **English (Data Analyst):** Data segmentation means dividing the dataset into distinct subsets based on certain criteria. For example, segmenting customers into different groups based on behaviors like total sales into 'High', 'Medium', and 'Low' buckets.
   * *(Note: The subquery makes this easier to read. You can also put the window function directly inside CASE: `CASE NTILE(3) OVER (ORDER BY Sales DESC) WHEN 1 THEN 'High' ... END`.)*
   ```sql
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
   ```

6. **Use Case 6 | Equalizing Load Processing (NTILE):** 
   * **English (Data Engineer):** Used for load balancing. If you want to distribute data evenly across multiple databases (e.g., divide orders into 4 equal groups to export them to 4 different databases).
   ```sql
   -- In order to export the data, divide the orders into 4 groups.
   SELECT
     OrderID, ProductID, CustomerID, Sales, OrderDate,
     NTILE(4) OVER (ORDER BY OrderID) AS Buckets
   FROM Sales.Orders;
   ```

#### Window Rank Functions Summary
* ![Window Rank Summary](./svg_window_rank_summary.svg)
* **Summary Points:**
  * **Types:** Integer-based (`ROW_NUMBER`, `RANK`, `DENSE_RANK`, `NTILE`) vs Percentage-based (`PERCENT_RANK`, `CUME_DIST`).
  * **Rules:** Expression is Empty (except NTILE which takes `n`), `ORDER BY` is Required, `FRAME` clause is Not Allowed.
  * **Use Cases:** Top N Analysis, Bottom N Analysis, Identify/Remove Duplicates, Assign Unique IDs (Pagination), Data Segmentation, Data Distribution Analysis, Equalizing Load Processing.

---

### 20.4 Percentage-Based Ranking Functions
* **English Definition/Properties:** In order for SQL to generate and calculate percentages, we have 2 different formulas or functions. Instead of integer ranking, SQL computes the relative position of the row compared to others and assigns a percentage to each row. 
* **मराठी सारांश:** हे 1, 2, 3 अशी रँक देण्याऐवजी टक्केवारीत (0.1, 0.5, 1.0) रँक देते, ज्यामुळे एखादे मूल्य पूर्ण डेटामध्ये कुठे आहे ते कळते.

* ![Percentage Formulas](./svg_percent_formulas.svg)
* ![CUME_DIST vs PERCENT_RANK Comparison](./svg_cumedist_vs_percentrank_table.svg)

* **Key Difference (Inclusive vs Exclusive):**
  * `CUME_DIST` is **Inclusive** (The current row is included).
  * `PERCENT_RANK` is **Exclusive** (The current row is excluded).

* **1. PERCENT_RANK()**
  * **Use Case:** If you want to focus on the relative position of each row, then go with `PERCENT_RANK`. It calculates the relative rank of a row as a percentage of the result set.
  * Computes the relative rank of a row on a continuous 0 to 1 scale (e.g., 0 as 0, 10% as 0.1, 30% as 0.3, etc.).
  * `PERCENT_RANK` goes and calculates the relative position as a percentage and assigns it to each row. The output can be a continuous normalized scale from 0 to 1.
  * Basically used for distribution analyzation. Calculate the relative position of each row overall.

* **2. CUME_DIST() (Cumulative Distribution)**
  * **Use Case:** If you want to focus on cumulative distribution calculation of data points, use cumulative distribution. This is the Cumulative Distribution Function (CDF) in action. It calculates a percentage (between 0 and 1) that shows how far up the distribution a given value is.
  * It stands for cumulative distribution. Calculates the distribution of data points within the window.
  * Formula: `Position_Number / Number_of_Rows`.
  * **Tie Rule:** If two values are the same (Tie), `CUME_DIST` takes the position of the *last* occurrence of the same value. It means it calculates the percentage for the first value and assigns the exact same percentage for the second same value.

* **Comparison Example:**
  * For Sales (100, 80, 80, 50, 30): Both functions generate output based on percentage ranking.
  * Both of them are handling the ties perfectly, so they **share the same percentage rank** (e.g. both 80s get DIST 0.6 and PER 0.25).
  * Based on the formulas, we have to find out the percentage value of the relative position of each row overall. So it is very important to measure the contribution of each value to the overall distribution.


### 20.5 Aggregate Window Functions (SUM, AVG, MIN, MAX, COUNT)
* **English Definition:** In window aggregation, functions like `SUM`, `AVG`, `MIN`, `MAX`, and `COUNT` calculate their values for each window separately (or the entire dataset if no partition is given), but unlike `GROUP BY`, they do not collapse the rows.
* **मराठी सारांश:** इथे ॲग्रीगेशन फंक्शन्स प्रत्येक विंडोसाठी (ग्रुप) वेगळे गणित करतात, पण `GROUP BY` प्रमाणे rows कमी होत नाहीत; प्रत्येक मूळ row सोबत ॲग्रीगेट मूल्य जोडले जाते.

#### The `COUNT()` Function Details (Data Quality & Duplicates)
* **English:** The `COUNT()` function returns the number of rows in each window (i.e., how many rows are in a subset of data). It counts the number of values regardless of their data type.
  * `COUNT(*)` or `COUNT(1)`: Counts **all** rows, regardless of NULLs. (`COUNT(1)` works because 1 is a constant and never NULL).
  * `COUNT(column)`: Counts the number of **non-NULL** values in that specific column.
* **Note on Duplicates:** The `COUNT()` function counts the total number of rows **including duplicates**, not just unique values.
* **Data Quality Issue:** Duplicates lead to inaccuracies in analysis. `COUNT()` can be used to identify duplicates. For example, if you partition by a unique ID and `COUNT() > 1`, you have duplicate rows!

#### Use Cases for Aggregate Window Functions
* ![Aggregate Window Use Cases](./svg_window_agg_usecases.svg)

1. **Use Case 1 | OVERALL ANALYSIS (Quick Summary)**
   * **English:** Quick summary or snapshot of the entire dataset. (e.g. Find the total sales across all orders).
   ```sql
   -- Find the total sales across all orders
   -- And the total sales for each product
   -- Additionally provide details such order Id, order date
   SELECT
     OrderID, OrderDate, Sales,
     SUM(Sales) OVER () AS TotalSales,
     SUM(Sales) OVER (PARTITION BY ProductID) AS SalesByProducts
   FROM Sales.Orders;
   ```
   * **Rule 1:** `SUM()` accepts only numbers.

2. **Use Case 2 | TOTAL PER GROUPS (Group-wise Analysis)**
   * **English:** Group-wise analysis, to understand patterns within different categories.
   ```sql
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
   ```
   * **Note on filtering with Window Functions:**
     * You cannot use the `WHERE` clause directly on the window function in the same query level. You must use a subquery.
     ```sql
     -- Find all orders where sales are higher than the average sales across all orders
     SELECT * FROM (
       SELECT
         OrderID, ProductID, Sales,
         AVG(Sales) OVER() AS AvgSales
       FROM Sales.Orders
     ) t 
     WHERE Sales > AvgSales;
     ```

3. **Use Case 3 | COMPARISON (Compare Current vs Aggregated)**
   * **English:** Compare the current value and aggregated value of window functions (e.g. Help to evaluate whether a value is above or below the average, or find percentage contribution).
   ```sql
   -- Find the percentage contribution of each product's sales to the total sales
   SELECT
     OrderID, ProductID, Sales,
     SUM(Sales) OVER () AS TotalSales,
     ROUND(CAST(Sales AS Float) / SUM(Sales) OVER () * 100, 2) AS PercentageOfTotal
   FROM Sales.Orders;
   ```
   ```sql
   -- Find the deviation of each sales from the minimum and maximum sales amounts
   SELECT
     OrderID, OrderDate, ProductID, Sales,
     MAX(Sales) OVER() AS HighestSales,
     MIN(Sales) OVER() AS LowestSales,
     Sales - MIN(Sales) OVER() AS DeviationFromMin,
     MAX(Sales) OVER() - Sales AS DeviationFromMax
   FROM Sales.Orders;
   ```

#### COUNT() Window Function
* **English:** The `COUNT()` function returns the number of rows in each window (i.e. how many rows are in a subset of data). It works on any data type (numbers, text, dates). `MIN()` and `MAX()` also accept text and dates, but `SUM()` and `AVG()` need numbers.
* **मराठी सारांश:** हे फंक्शन विंडोमधील (ग्रुपमधील) rows मोजते.
* **Types of COUNT:**
  * `COUNT(*)`: Counts **all** rows in the table/window, regardless of whether any value is NULL.
  * `COUNT(1)`: Exactly equal to `COUNT(*)`, because 1 is a constant and never NULL.
  * `COUNT(column)`: Counts the number of **non-NULL** values in that specific column.
  * *Note:* Count function counts the total number of rows including duplicates, not just the unique values.

**Use Cases for COUNT():**
1. **#1 Overall Analysis:** Quick summary or snapshot of the entire dataset.
   ```sql
   -- Find the total number of orders for each product
   SELECT 
     Product, Sales,
     COUNT(*) OVER(PARTITION BY Product) AS Count_Orders
   FROM SalesData;
   ```
2. **#2 Category Analysis (Total per Group):** Group-wise analysis to understand patterns with different categories.
   ```sql
   -- Find the total number of Orders for each customer
   -- Additionally provide details such as OrderID, OrderDate
   SELECT
     OrderID, OrderDate, CustomerID,
     COUNT(*) OVER() AS TotalOrders,
     COUNT(*) OVER(PARTITION BY CustomerID) AS OrdersByCustomers
   FROM Sales.Orders;
   ```
3. **#3 Quality Checks: Identify NULLs:** Detecting number of NULLs by comparing `COUNT(column)` to `COUNT(*)`.
   ```sql
   -- Find the total number of Customers and total number of Scores
   -- Difference between these counts reveals how many NULL scores exist
   SELECT
     CustomerID, FirstName, LastName, Country, Score,
     COUNT(*) OVER() AS TotalCustomers,
     COUNT(Score) OVER() AS TotalScores
   FROM Sales.Customers;
   ```
4. **#4 Quality Checks: Identify Duplicates:** Duplicate rows lead to inaccuracies. `COUNT()` can be used to identify them.
   ```sql
   -- Check whether the table 'orders' contains any duplicate rows
   SELECT * FROM (
     SELECT
       OrderID,
       COUNT(*) OVER(PARTITION BY OrderID) AS CheckPK
     FROM Sales.OrdersArchive
   ) t
   WHERE CheckPK > 1;
   ```

#### Handling NULLs in Aggregate Window Functions
* **English:** Functions like `AVG()` ignore `NULL` values. If a `NULL` implies zero (e.g., no sales), ignoring it will skew the average. We use `COALESCE()` to handle nullish values.
* **मराठी सारांश:** `AVG` फंक्शन `NULL` मोजतच नाही. एखाद्या ग्राहकाचा स्कोअर `NULL` असेल आणि तो `0` धरून सरासरी काढायची असेल, तर `COALESCE()` वापरतो.
   ```sql
   -- Find the average scores of customers
   -- Additionally provide details such CustomerID and LastName
   SELECT
     CustomerID, LastName, Score,
     COALESCE(Score, 0) AS CustomerScore,
     AVG(Score) OVER () AS AvgScore,
     AVG(COALESCE(Score, 0)) OVER () AS AvgScoreWithoutNull
   FROM Sales.Customers;
   ```


#### Running Total vs Rolling Total (Analysis Over Time)
* **English:** Used for tracking sequence of members, and the aggregation is updated each time a new member is added (e.g. tracking current sales with target sales over time).
* **मराठी सारांश:** वेळेनुसार डेटा ट्रॅक करण्यासाठी वापरतात (जसे दर महिन्याला विक्री किती वाढत आहे). नवीन डेटा आला की ॲग्रीगेशन अपडेट होते.
* ![Running vs Rolling](./svg_running_vs_rolling.svg)

1. **Running Total:**
   * **English:** Aggregates all values from the beginning up to the current point without dropping off older data.
   * **मराठी सारांश:** सुरुवातीपासून सध्याच्या row पर्यंत सर्व बेरीज करत जातो (जुना डेटा न सोडता).
   ```sql
   -- Default frame: ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
   SELECT Month, Sales, SUM(Sales) OVER (ORDER BY Month) AS RunningTotal 
   FROM SalesData;
   ```
   * ⚠️ **Note:** The comment above is slightly wrong: when `ORDER BY` is used without a frame, the default is `RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW` (not `ROWS`). With `RANGE`, rows having the same `Month` are added together in one step.

2. **Rolling Total (Shifting Window):**
   * **English:** Aggregates all values within a fixed time window (e.g., 30 days or last 2 rows). As new data is added, the oldest data point will be dropped.
   * **मराठी सारांश:** ठराविक विंडोची (उदा. मागील 2 महिने) बेरीज करतो. नवीन डेटा आला की सर्वात जुना डेटा यादीतून निघून जातो.
   ```sql
   -- Rolling Total for current and 2 preceding rows
   SELECT Month, Sales, 
     SUM(Sales) OVER (ORDER BY Month ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS RollingTotal 
   FROM SalesData;
   ```

#### Moving Average
* **English:** Moving average is very similar to running/rolling total, but here we do average instead of sum.
* **मराठी सारांश:** हे रनिंग/रोलिंग टोटल सारखेच आहे, फक्त इथे बेरीज (SUM) ऐवजी सरासरी (AVG) काढली जाते.
   ```sql
   -- Calculate running average of sales for each product over time
   SELECT
     OrderID, ProductID, OrderDate, Sales,
     AVG(Sales) OVER (PARTITION BY ProductID) AS AvgByProduct,
     AVG(Sales) OVER (PARTITION BY ProductID ORDER BY OrderDate) AS RunningAvg
   FROM Sales.Orders;
   ```
   ```sql
   -- Calculate rolling average of sales for each product over time (Including only the next order)
   SELECT
     OrderID, ProductID, OrderDate, Sales,
     AVG(Sales) OVER (PARTITION BY ProductID) AS AvgByProduct,
     AVG(Sales) OVER (PARTITION BY ProductID ORDER BY OrderDate) AS RunningAvg,
     AVG(Sales) OVER (PARTITION BY ProductID ORDER BY OrderDate ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING) AS RollingAvg
   FROM Sales.Orders;
   ```

---

### 20.6 Value Window Functions (Analytics Functions)
* **English Definition:** These are used to access data from other rows (in the result set) without using `JOIN`s or subqueries. They help compare current row values with previous, next, first, or last values in the window.
* **मराठी सारांश:** JOIN किंवा Subquery न वापरता दुसऱ्या row चा डेटा पाहण्यासाठी ही फंक्शन्स वापरतात (जसे मागील row ची किंवा पुढील row ची व्हॅल्यू).

* ![Value Functions Concepts](./svg_value_functions.svg)

#### Syntax Rules for Value Functions
* **Expression:** Can be any data type.
* **ORDER BY Clause:** **Required** (You must order the window so SQL knows what 'next' or 'previous' means).
* **PARTITION BY Clause:** Optional.
* **FRAME Clause:**
  * `LEAD()` & `LAG()` $\rightarrow$ **Not Allowed**.
  * `FIRST_VALUE()` $\rightarrow$ **Optional**.
  * `LAST_VALUE()` $\rightarrow$ **Should be used** (Because default frame stops at CURRENT ROW, which defeats the purpose of LAST_VALUE).


* **1. LEAD(expr, offset, default)**
  * **English:** Access data from the **next row** (subsequent row) within a window.
  * **मराठी सारांश:** हे फंक्शन त्याच विंडोमधील पुढच्या (Next) row चा डेटा आणते.

* **2. LAG(expr, offset, default)**
  * **English:** Access data from the **previous row** within a window.
  * **मराठी सारांश:** हे फंक्शन त्याच विंडोमधील मागच्या (Previous) row चा डेटा आणते.
  
  * **Arguments Details (For LEAD & LAG):**
    * `Expression` (Required): The column or value to access.
    * `Offset` (Optional): Number of rows forward/backward from the current row (Default = 1).
    * `Default` (Optional): Returns this value if the next/previous row is not available (Default = `NULL`).

#### Use Cases for LEAD & LAG (Comparison Analysis)
1. **Time Series Analysis (MOM - Month-over-Month):**
   * **English:** Analyze short-term trends and discover patterns in seasonality by comparing current month to previous month.
   ```sql
   -- Analyze the month-over-month performance by finding the percentage change
   -- in sales between the current and previous months
   SELECT 
     OrderMonth, 
     CurrentMonthSales, 
     PreviousMonthSales,
     CurrentMonthSales - PreviousMonthSales AS MoM_Change,
     ROUND((CurrentMonthSales - PreviousMonthSales) / PreviousMonthSales * 100, 1) AS MoM_Perc
   FROM (
     SELECT
       MONTH(OrderDate) AS OrderMonth,
       SUM(Sales) AS CurrentMonthSales,
       LAG(SUM(Sales)) OVER(ORDER BY MONTH(OrderDate)) AS PreviousMonthSales
     FROM Sales.Orders
     GROUP BY MONTH(OrderDate)
   ) t;
   ```

2. **Customer Loyalty Analysis:**
   * **English:** Compare current order date with the next order date using `LEAD` to find the average days between orders.
   * *(Note: Adapted `DATEDIFF` to MySQL syntax: `DATEDIFF(date1, date2)` where date1 is later than date2).*
   ```sql
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
       DATEDIFF(
         LEAD(OrderDate) OVER(PARTITION BY CustomerID ORDER BY OrderDate), 
         OrderDate
       ) AS DaysUntilNextOrder
     FROM Sales.Orders
   ) t
   GROUP BY CustomerID;
   ```

* **3. FIRST_VALUE(expr)**
  * **English:** Access a value from the **first row** within a window.
  * **मराठी सारांश:** हे विंडोमधील सर्वात पहिल्या (First) row चा डेटा आणते.

* **4. LAST_VALUE(expr)**
  * **English:** Access a value from the **last row** within a window.
  * **मराठी सारांश:** हे विंडोमधील सर्वात शेवटच्या (Last) row चा डेटा आणते.
  * **Critical Rule for LAST_VALUE Frame:**
    * By default, the window frame is `RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW`. This means the "last" value it sees is just the current row.
    * To truly get the last value of the entire partition/window, you **MUST** change the frame to: `ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING` (or `UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING`).
    ```sql
    -- Correct way to use LAST_VALUE
    SELECT 
      Month, Sales,
      LAST_VALUE(Sales) OVER (
        ORDER BY Month 
        ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING
      ) AS LastSalesValue
    FROM SalesData;
    ```


#### Use Case for FIRST_VALUE & LAST_VALUE (Compare to Extremes)
1. **Compare to Extremes:**
   * **English:** Find how well a value is performing relative to extremes (highest and lowest).
   ```sql
   -- Find the lowest and highest sales for each product
   SELECT
     OrderID, ProductID, Sales,
     FIRST_VALUE(Sales) OVER (PARTITION BY ProductID ORDER BY Sales) AS LowestSales,
     LAST_VALUE(Sales) OVER (PARTITION BY ProductID ORDER BY Sales
       ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) AS HighestSales
   FROM Sales.Orders;
   ```

* **5. NTH_VALUE(expr, n)**
  * **English:** The `NTH_VALUE()` function is a window function used to fetch the n-th value (e.g., 1st, 2nd, 3rd) within a window frame.
  * **मराठी सारांश:** हे फंक्शन विंडोमधील n-वी row (जसे दुसरी, तिसरी) चा डेटा आणते.
  * **Key Points:**
    * `n`: which value to fetch (e.g. 2 for the second).
    * `ORDER BY` is mandatory to define what "n-th" means.
    * **Frame Default:** By default, it's `RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW`, which won't work for `n > 1` if the current row hasn't reached it. Always explicitly define frame as `ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING`.
    * Returns `NULL` if there aren't enough rows in the partition.
  * **Example:**
    ```sql
    -- Fetch the second highest salary for each department
    SELECT
      employee_id, department, salary,
      NTH_VALUE(salary, 2) OVER (
        PARTITION BY department
        ORDER BY salary DESC
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
      ) AS second_highest_salary
    FROM employees;
    ```

---

### 20.7 Window Function Syntax Deep Dive (OVER Clause)
* **English Definition:** A Window function query mainly has two parts: The **Function** (performs calculation on top of window) and the **OVER()** clause (defines the window/subset of data). The `OVER` clause has three sub-clauses: `PARTITION BY`, `ORDER BY`, and `FRAME`.
* **मराठी सारांश:** Window function चे 2 मुख्य भाग असतात: 1. फंक्शन (जसे AVG, SUM), 2. `OVER()` क्लॉज (कोणत्या डेटावर गणित करायचे ते ठरवतो).

* ![OVER Clause Syntax](./svg_over_clause.svg)

1. **PARTITION BY Clause:**
   * **English:** Divides the rows into groups based on column(s). If empty (no partition), calculation is done on the entire dataset. It is optional for all window functions (aggregation, ranking, value).
   * **मराठी सारांश:** हे डेटाला वेगवेगळ्या ग्रुप्समध्ये (विंडो) विभागते. लिहिले नाही तर पूर्ण डेटा एकच ग्रुप मानला जातो.
   * Example: `SUM(Sales) OVER()` (entire dataset), `SUM(Sales) OVER(PARTITION BY ProductID)` (group by product).

2. **ORDER BY Clause:**
   * **English:** Sorts data within a window. Default is ascending `ASC`. It is **Required** for Ranking functions and Value functions. Optional for Aggregation functions.
   * **मराठी सारांश:** हे विंडोमधील डेटा क्रमाने (sort) लावते. Ranking आणि Value फंक्शन्ससाठी हे आवश्यक (required) आहे.
   ```sql
   -- Order By is required for RANK()
   SELECT
     OrderID, OrderDate, Sales,
     RANK() OVER (ORDER BY Sales DESC) AS RankSales
   FROM Sales.Orders;
   ```


3. **FRAME Clause:**
   * **English:** Defines a specific subset of rows within each window that is relevant for the calculation. It is used when you don't want to consider all rows in the partition.
   * **मराठी सारांश:** हे विंडोच्या आतही एक छोटा भाग (subset) बनवते (जसे फक्त मागील 2 rows आणि सध्याची row यांची बेरीज).
   * **Syntax:** `ROWS BETWEEN <Lower_Bound> AND <Upper_Bound>`
   * **Boundary Values:**
     * `CURRENT ROW`: The current row being evaluated.
     * `UNBOUNDED PRECEDING`: The first possible row within a window.
     * `UNBOUNDED FOLLOWING`: The last possible row within a window.
     * `N PRECEDING`: N rows before the current row.
     * `N FOLLOWING`: N rows after the current row.
   * **Important Frame Rules:**
     1. Frame clause is used together with the `ORDER BY` clause (in SQL Server it is required; MySQL allows a frame without `ORDER BY`, but it is rarely useful).
     2. Lower Value must be **BEFORE** the higher value logically (e.g. `2 PRECEDING` to `1 FOLLOWING` is valid, but `1 FOLLOWING` to `2 PRECEDING` is invalid).
   * **Default Frame vs Compact Frame:**
     * **Default:** If `ORDER BY` is used but `FRAME` is not specified, SQL uses the default frame: `RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW`.
     * **Compact (short form):** If you only need `PRECEDING` rows up to the current row, you can write just the start: `ROWS 2 PRECEDING` is short for `ROWS BETWEEN 2 PRECEDING AND CURRENT ROW`. ⚠️ `ROWS 2 FOLLOWING` is **not** a valid short form — for `FOLLOWING` rows always write the full `ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING`.

---

### 20.8 Window Function Limitations & Rules
* **Rule 1: Allowed Clauses Only**
  * **English:** Window functions can only be used in the `SELECT` and `ORDER BY` clauses. You **cannot** use them directly in `WHERE`, `GROUP BY`, or `HAVING` clauses.
  * **मराठी सारांश:** Window Function फक्त `SELECT` किंवा `ORDER BY` मध्ये लिहिता येते. `WHERE` मध्ये थेट वापरता येत नाही (त्यासाठी Subquery बनवावी लागते).
* **Rule 2: No Nesting**
  * **English:** Nesting window functions inside another window function is **not allowed** (e.g., `SUM(SUM(Sales) OVER(...)) OVER(...)` will throw an error).
  * **मराठी सारांश:** एका Window Function च्या आत दुसरे Window Function (Nesting) लिहिता येत नाही.
* **Rule 3: Execution Order**
  * **English:** SQL executes window functions **after** the `WHERE` clause. It first filters the data, and then aggregates/ranks it.
  * **मराठी सारांश:** SQL आधी `WHERE` ने डेटा फिल्टर करते आणि मग उरलेल्या डेटावर Window Function चालवते.
* **Rule 4: With GROUP BY**
  * **English:** Window functions can be used together with `GROUP BY` in the same query, **only if** the window function uses the exact same columns/aggregations.
  * **मराठी सारांश:** एकाच क्वेरीत `GROUP BY` आणि Window Function दोन्ही वापरता येतात, पण Window Function मध्ये फक्त तेच कॉलम्स हवेत जे `GROUP BY` मध्ये आहेत किंवा ॲग्रीगेट होऊन येत आहेत.
   ```sql
   -- First build the query using group by function, then next step you define the window function
   -- Rank Customers based on their total sales
   SELECT 
     CustomerID,
     SUM(Sales) AS TotalSales,
     RANK() OVER(ORDER BY SUM(Sales) DESC) AS RankCustomers
   FROM Sales.Orders
   GROUP BY CustomerID;
   ```

---

### 20.9 Why Window Functions? (Advantages)
1. **Advance Analytics Without Aggregation:** Unlike `GROUP BY`, window functions do not reduce/collapse rows. You can calculate running totals, rankings, and moving averages while still keeping each row intact.
2. **Simplify Complex Queries:** Allows you to avoid complex self-joins or subqueries when doing cumulative and comparative analysis.
3. **Performance:** They are often much more efficient than writing equivalent subqueries or self-joins.
4. **Better Readability:** Clear and declarative syntax for ranking, partitioning, and ordering operations.

### 20.10 GROUP BY + HAVING vs Window Functions
Window Functions are often confused with `GROUP BY` and `HAVING`, but they are fundamentally different:

1. **GROUP BY + HAVING**
   * **Purpose:** `GROUP BY` collapses rows into groups. `HAVING` filters those groups (like `WHERE`, but for grouped results).
   * **Rows Returned:** One row per group (collapses data).
   * **When to use:** When you only care about the summarized totals and don't need the individual row details.
   * **Example:**
     ```sql
     SELECT dept_id, AVG(salary) AS avg_salary
     FROM employees
     GROUP BY dept_id
     HAVING AVG(salary) > 60000;
     ```
     *(Output: One row per department).*

2. **Window Functions**
   * **Purpose:** They calculate aggregates but keep every row. (Use `OVER()` with optional `PARTITION BY` and `ORDER BY`).
   * **Rows Returned:** All original rows are returned (no collapsing).
   * **When to use:** Used for running totals, ranking, moving averages, and comparisons where you want to see both the detail and the summary.
   * **Example:**
     ```sql
     SELECT emp_id, emp_name, dept_id, salary,
            AVG(salary) OVER (PARTITION BY dept_id) AS avg_salary_in_dept
     FROM employees;
     ```
     *(Output: Every employee stays visible, but you also see department averages next to each row).*


---

## Topic 21: Database Optimization & Indexing (Analytics & Performance)

### 21.1 Introduction to Performance Optimization
**English:** The first and most famous way to optimize database performance is by building indexes. An index in SQL is a data structure (similar to an index in a book) that improves the speed of data retrieval operations on a database table. It acts as a guide for your database to speed up the process of searching for data, especially in large tables.
**Hindi:** डेटाबेस की परफॉरमेंस को ऑप्टिमाइज़ करने का पहला और सबसे प्रसिद्ध तरीका इंडेक्स (Index) बनाना है। SQL में इंडेक्स एक डेटा स्ट्रक्चर है (जैसे किसी किताब का इंडेक्स) जो डेटाबेस टेबल से डेटा खोजने की स्पीड को बढ़ाता है। यह डेटाबेस के लिए एक गाइड की तरह काम करता है, ताकि बड़े टेबल में भी डेटा तेज़ी से खोजा जा सके।

**Trade-offs (नुकसान):**
While indexes speed up reads, they slow down writes (INSERT, UPDATE, DELETE) because the index must be updated every time data changes.
*(इंडेक्स से डेटा पढ़ने की स्पीड बढ़ती है, लेकिन लिखते समय (INSERT, UPDATE, DELETE) स्पीड कम हो जाती है क्योंकि हर बदलाव के साथ इंडेक्स को भी अपडेट करना पड़ता है।)*

* **Pros:** Faster `SELECT`, `WHERE`, `JOIN`, `ORDER BY`, `GROUP BY`.
* **Without an index:** MySQL scans the entire table row by row (Full Table Scan) ➔ **Slow for large tables.**
* **With an index:** MySQL can directly jump to the location of the data ➔ **Much faster.**

**Types of Indexes in MySQL (Engines):**
MySQL uses B-Tree or Hash indexes depending on the storage engine:
* **InnoDB Engine (Default):** Uses **B+Tree** indexes (balanced tree structure). **Supports Clustered Indexes** (The Primary Key is always the Clustered Index, and all others are Non-Clustered / Secondary).
* **MyISAM Engine:** **Does not support Clustered Indexes**. All indexes in MyISAM are Non-Clustered.
* **Memory Engine:** Uses **Hash** indexes (excellent for exact equality lookups like `WHERE id = 5`, but bad for range queries like `>`, `<`).

### 21.2 Database Storage Architecture: How data is stored?

Before understanding indexes, we must understand how a database stores data on a hard drive.
**English:** Databases store data in fixed-size blocks called **Pages** (typically 8KB or 16KB). A table's data is split across multiple data pages inside a physical file (like `.mdf` or `.ibd`).
**Hindi:** डेटाबेस डेटा को एक फिक्स साइज़ के ब्लॉक में स्टोर करता है जिसे **Page** कहते हैं (आमतौर पर 8KB या 16KB)। एक टेबल का पूरा डेटा कई पेजों (Data Pages) में बंट कर एक फिजिकल फाइल (.mdf या .ibd) में सेव होता है।

![Data Pages Overview](./svg_db_pages_overview.svg)
*Description: Overview of a Data File containing Data Pages (actual table rows) and Index Pages (B-Tree pointers).*

**Anatomy of a Data Page:**
* **Page Header:** 96 Bytes. Stores metadata (Page ID, next/previous page pointers, free space info).
* **Data Rows:** Actual rows inserted into the database.
* **Free Space:** Empty space for new rows.
* **Offset Array (Row Locator):** Located at the bottom. It contains pointers (memory addresses) to the exact location of each row in the page. When SQL reads a page, it uses the offset array to find rows instantly without scanning the whole page.

![Data Page Anatomy](./svg_data_page_anatomy.svg)
*Description: Anatomy of an 8KB Data Page showing Header, Rows, Free Space, and the Offset Array.*

### 21.3 The HEAP Structure & Full Table Scan

**What happens when a table has NO Clustered Index?**
Such a table is called a **HEAP**.

**English:** In a Heap structure, data is stored in no particular order. New rows are just appended wherever there is free space.
**Hindi:** Heap स्ट्रक्चर में डेटा किसी विशेष क्रम (order) में स्टोर नहीं होता। नई रो (row) जहाँ भी खाली जगह मिलती है, वहाँ जोड़ दी जाती है।

* **Fast Write:** Because the database doesn't need to sort the data, inserts are extremely fast. (Just toss the data anywhere).
* **Slow Read:** Because data is random, finding a specific row requires scanning every single page and row. This is called a **Full Table Scan**.

![Heap Structure](./svg_heap_structure.svg)
*Description: HEAP Structure showing randomly ordered rows across pages.*

![Full Table Scan](./svg_full_table_scan.svg)
*Description: Full Table Scan searching for ID=14. SQL must read every row across every page to find it.*

### 21.4 The Clustered Index (B-Tree Structure) & Reading Speed

To fix the Full Table Scan problem, SQL uses a **Clustered Index**, usually created automatically when you define a `PRIMARY KEY`. You can think of the clustered index like the table of contents at the front of a book, telling you exactly where to find each chapter.

**English:** A Clustered Index physically sorts the data in the table based on the indexed column (e.g., Customer ID). It uses a **B-Tree** (Balanced Tree) structure. In a clustered index, the leaf nodes (the bottom level of the tree) are the actual Data Pages themselves.
**Hindi:** Clustered Index टेबल के डेटा को इंडेक्स किए गए कॉलम (जैसे ID) के आधार पर फिजिकली सॉर्ट (क्रमबद्ध) कर देता है। यह **B-Tree** स्ट्रक्चर का उपयोग करता है। Clustered Index में सबसे नीचे (Leaf level) असल डेटा पेज (Data Pages) ही होते हैं।

**Structure of a B-Tree:**
1. **Root Node:** The starting point. It contains high-level ranges and points to Intermediate nodes.
2. **Intermediate Nodes:** Act as signboards, narrowing down the search and pointing to the correct Leaf nodes.
3. **Leaf Nodes (Base Data Pages):** For a Clustered Index, the leaf node *is* the actual data page containing your rows.

**Detailed Execution Example (Searching for ID 14):**
If you query `WHERE customer_id = 14`, SQL does not scan all pages. Instead, it navigates the B-Tree:
1. **Step 1 (Root Node):** SQL checks the root node. Since 14 is between 11 and 20, it uses the 2nd pointer to jump to the intermediate index page `1:201`.
2. **Step 2 (Intermediate Node):** SQL checks the pointers in page `1:201`. Since 14 is between 11 and 15, it uses the pointer pointing to data page `1:102`.
3. **Step 3 (Leaf Node):** SQL locates the correct data page (`1:102`), opens it, and instantly finds customer ID 14.
*(Hindi: SQL सीधा Root Node से Intermediate Node होते हुए सीधे सही Data Page तक पहुँचता है, बिना फालतू पेजों को पढ़े।)*

**Why is this so fast?**
It only took 3 jumps! You might think, "Well, we still read 3 pages (Root, Intermediate, Leaf), how is this faster than a HEAP?"
The secret is: **Reading an index page is extremely fast** compared to reading a large data page. The B-Tree structure allows the database to locate the exact row without scanning irrelevant data. 

![Clustered B-Tree](./svg_clustered_btree.svg)
*Description: Clustered Index B-Tree. The search for ID=14 traverses the Root (Step 1), then Intermediate (Step 2), directly landing on the correct Data Page (Step 3).*

### 21.5 Non-Clustered Index (Secondary Index)

If we already have a Heap or a Clustered Index, what happens when we create an index on another column (e.g., `Customer Name`)? SQL immediately builds a new, separate B-Tree structure. This is called a **Non-Clustered Index** (or Secondary Index).

* **Definition:** Any index that is not the Primary Key. It logically sorts the indexed column without changing the physical order of the actual table.

**English:** A Non-Clustered Index is a completely separate structure from the data pages. The B-Tree contains a sorted copy of the indexed column. However, the Leaf Nodes do **not** contain the full row data. Instead, they contain a **pointer** back to the actual data page where the rest of the row is stored.
**Hindi:** Non-Clustered Index डेटा पेजों से एक अलग स्ट्रक्चर होता है। इसके B-Tree में इंडेक्स किए गए कॉलम की सॉर्ट की गई कॉपी होती है। लेकिन, Leaf Nodes में पूरा डेटा नहीं होता, बल्कि एक **पॉइंटर (Pointer)** होता है जो असल डेटा पेज का एड्रेस बताता है।

**What exactly is this Pointer?**
The value of the pointer depends on the base table structure:
1. **If the base table is a HEAP:** The pointer is a **Row ID (RID)**. It looks like `Page Number : Row Offset` (e.g., `1:102:96`). SQL uses this RID to jump straight to the exact byte in the heap.
2. **If the base table has a Clustered Index:** The pointer is the **Primary Key** (e.g., `EmpID = 1`). SQL takes this primary key and traverses the Clustered Index B-Tree to find the row.

**The "Extra Lookup" Process (Key Lookup):**
When you query `WHERE name = 'Vishal'`:
1. MySQL scans the Non-Clustered B-Tree to find the name 'Vishal'.
2. It reaches the Leaf Node and finds the pointer (e.g., `Primary Key = 1`).
3. MySQL must now do **one extra jump** (an Extra Lookup) using the Clustered Index to find the rest of the row for `EmpID = 1`.
*(Hindi: Non-Clustered Index सिर्फ पता (address) बताता है। पूरा डेटा लाने के लिए SQL को एक अतिरिक्त छलांग (Extra Lookup) लगानी पड़ती है।)*

![Non-Clustered B-Tree](./svg_non_clustered_btree.svg)
*Description: Non-Clustered Index B-Tree. The leaf nodes contain pointers. SQL must perform an extra jump to fetch the full row from the physically separate Data Pages.*

### 21.6 Clustered vs Non-Clustered Index Summary

**English:** Here is a quick comparison summarizing the differences between a Clustered and Non-Clustered Index.
**Hindi:** Clustered और Non-Clustered इंडेक्स के बीच का मुख्य अंतर नीचे दिया गया है।

| Feature | Clustered Index (Primary Key) | Non-Clustered Index (Secondary Index) |
| :--- | :--- | :--- |
| **Definition** | Physically sorts and stores rows. | Separate structure with pointers to the data. |
| **Number of Indexes** | **One** Index per Table. | **Multiple** indexes are allowed. |
| **Read Performance** | **Faster** (data is right there). | **Slower** (requires an extra pointer lookup). |
| **Write Performance** | **Slower**, due to potential data row reordering. | **Faster**, since physical data order is unaffected. |
| **Storage Efficiency** | More **storage-efficient**. | Requires **additional** storage space for the B-Tree. |
| **Use Case** | Unique Column, Not frequently modified, Range queries. | Columns frequently used in search conditions and exact match queries. |

**Syntax to Create Indexes:**
```sql
-- Default is NONCLUSTERED
CREATE [CLUSTERED | NONCLUSTERED] INDEX index_name ON table_name (column1, column2, ...)

CREATE CLUSTERED INDEX IX_Customers_ID ON Customers (ID)

CREATE NONCLUSTERED INDEX IX_Customers_City ON Customers (City)

CREATE INDEX IX_Customers_Name ON Customers (LastName ASC, FirstName DESC)
```

### 21.7 Rowstore vs Columnstore Index (Storage Architecture)

Indexes can also be categorized by how they physically store data on the disk (By Storage).

#### 1. Rowstore Index (The Default)
**English:** Organizes and stores data row by row. This is the traditional RDBMS structure. If you fetch a single row, the database pulls the entire row together.
**Hindi:** इसमें डेटा रो (row) के अनुसार स्टोर होता है। यह डिफ़ॉल्ट तरीका है।
* **Note:** By default, a table is built as a Heap structure where rows are stored row by row inside the data pages.

![Rowstore vs Columnstore](./svg_rowstore_vs_columnstore.svg)
*Description: Rowstore stores complete rows in pages. Columnstore stores each column separately in its own pages.*

#### 2. Columnstore Index (For Analytics)
**English:** Organizes and stores data column by column. This is highly optimized for analytical queries (OLAP) where you might need to sum up a single column (e.g., Sales) across millions of rows without reading the rest of the columns.
**Hindi:** इसमें डेटा कॉलम (column) के अनुसार स्टोर होता है। यह डेटा एनालिसिस (Analytics) के लिए बहुत तेज़ है।

**The Columnstore Creation Process:**
![Columnstore Process](./svg_columnstore_process.svg)
*Description: The three steps of creating a Columnstore index.*

1. **#1 Row Groups:** The table is first divided horizontally into Row Groups (up to 1 million rows per group).
2. **#2 Column Segments:** Each Row Group is then divided vertically into independent Column Segments.
3. **#3 Compression (Dictionary):** Each Column Segment is heavily compressed. For example, if a `Status` column has 'Active' and 'Inactive' repeating thousands of times, it creates a Dictionary (`'Active' -> 1`, `'Inactive' -> 2`) and stores tiny numbers instead of large strings. This saves massive amounts of space and memory.

#### Comparison: Rowstore vs Columnstore

| Feature | Rowstore Index | Columnstore Index |
| :--- | :--- | :--- |
| **Definition** | Organizes and stores data **row by row** | Organizes and stores data **column by column** |
| **Storage Efficiency** | **Less efficient** in storage | **Highly efficient** with Compression |
| **Read/Write Optimization** | **Fair** speed for read & write operations | **Fast** read performance, **Slow** write performance |
| **I/O Efficiency** | **Lower** (retrieves all columns) | **Higher** (retrieves specific columns) |
| **Best for** | **OLTP (Transactional)** commerce, banking, order processing | **OLAP (Analytical)** Data Warehouse, Business intelligence, Analytics |
| **Use Case** | High-frequency transaction applications, Quick access to complete records | Big Data Analytics, Scanning large datasets, Fast aggregation |

**Columnstore Index Syntax:**
```sql
-- Default is ROWSTORE
CREATE [CLUSTERED | NONCLUSTERED] [COLUMNSTORE] INDEX index_name ON table_name (column1, column2, ...)

-- Rowstore
CREATE NONCLUSTERED INDEX IX_Customers_Country ON Customers (Country)
CREATE CLUSTERED INDEX IX_Customers_ID ON Customers (ID)

-- Columnstore
CREATE NONCLUSTERED COLUMNSTORE INDEX IX_Customers_Country ON Customers (Country)
CREATE CLUSTERED COLUMNSTORE INDEX IX_Customers ON Customers ❌ -- NOT ALLOWED TO USE COLUMNS

-- Rules: You can't specify columns in Clustered Index Columnstore
```

### 21.8 Indexing by Function (Unique, Filtered, Composite)

**1. Unique Index (यूनिक इंडेक्स)**
* **Definition:** A Unique Index ensures that all values in a specific column are distinct (no duplicate values exist).
* **Why it is important:** 
  * **Data Integrity:** Enforces uniqueness of data at the database level.
  * **Improved Performance:** Slightly increases query performance as the database engine knows there's only one match.
* **Important Note:** 
  * Writing to a unique index is slower than a non-unique index (normal clustered index).
  * Reading from a unique index is faster than a non-unique index.
  * If a duplicate exists in the column, it will prevent you from creating a unique index.
* **Hindi (मराठी/हिंदी सारांश):** यह इंडेक्स सुनिश्चित करता है कि कॉलम में कोई डुप्लीकेट (Duplicate) डेटा न हो। इससे डेटा सुरक्षित रहता है (Data Integrity) और पढ़ने (Read) की स्पीड बढ़ती है, लेकिन नया डेटा डालने (Write) की स्पीड थोड़ी कम हो जाती है।
* **Example / Syntax:** 
  ```sql
  CREATE UNIQUE INDEX idx_email ON employees(email);
  ```
* **Image Reference:** ![Index Syntax vs Unique Index](./svg_index_syntax.svg) *(Description: Compares default index syntax which allows duplicates vs unique index syntax which enforces uniqueness).*

**2. Filtered Index (फिल्टर्ड इंडेक्स)**
* **Definition:** An index that includes only a specific subset of rows meeting a defined condition.
* **Benefits:** 
  * **Targeted Optimization:** Optimizes queries for a specific subset of data.
  * **Reduced Storage:** Stores less data in the index, which saves space and improves overall index maintenance performance.
* **When to use:** Use when a query frequently targets a specific category (e.g., Active employees, unpaid invoices).
* **Hindi (मराठी/हिंदी सारांश):** यह इंडेक्स पूरे टेबल के बजाय सिर्फ एक खास कंडीशन (जैसे Status = 'Active') वाले डेटा पर बनता है। इससे इंडेक्स का साइज छोटा रहता है और स्पीड बहुत तेज होती है।
* **Syntax:** 
  ```sql
  CREATE NONCLUSTERED INDEX idx_active_users ON users(status) WHERE status = 'ACTIVE';
  ```
* **Image Reference:** ![Filtered Index & When to Use](./svg_filtered_index.svg) *(Description: Shows Filtered Index syntax with WHERE condition and a flowchart on When To Use different indexes: Heap for staging, Clustered for PK/OLTP, Columnstore for OLAP, Non-Clustered for Joins/Filters).*

**3. Simple (Single-Column) Index**
* **Definition:** An index created on just one column.
* **Hindi (मराठी/हिंदी सारांश):** यह इंडेक्स केवल एक ही कॉलम पर बनाया जाता है। इसका उपयोग तब होता है जब हम किसी एक स्पेसिफिक कॉलम (जैसे Salary या Age) के आधार पर डेटा सर्च करते हैं।
* **Example:** 
  ```sql
  CREATE INDEX idx_salary ON employees(salary);
  ```

**4. Composite (Multi-Column) Index**
* **Definition:** An index created on multiple columns.
* **Leftmost Prefix Rule:** The index works **only** if your query filters start from the first column in the index and follow its exact order.
  * If the index is `(col1, col2, col3)`, it works for: `col1` | `col1, col2` | `col1, col2, col3`.
  * It will **NOT** work for only `col2` without `col1`. Always start with the leftmost column!
* **Hindi (मराठी/हिंदी सारांश):** यह इंडेक्स एक से ज्यादा कॉलम्स को मिलाकर बनाया जाता है। इसमें लेफ्ट-मोस्ट प्रिफिक्स रूल (Leftmost Prefix Rule) का पालन करना जरूरी है, जिसका मतलब है कि क्वेरी में हमेशा पहला कॉलम शामिल होना चाहिए, तभी इंडेक्स काम करेगा।
* **Example:** 
  ```sql
  CREATE INDEX idx_name_salary ON employees(name, salary);
  ```

**5. Full-Text Index**
* **Definition:** Used for searching text efficiently within large text columns. Allows usage of `MATCH() AGAINST()` functions.
* **Hindi (मराठी/हिंदी सारांश):** यह इंडेक्स बड़े टेक्स्ट या आर्टिकल्स के अंदर शब्दों (Keywords) को तेजी से खोजने के लिए इस्तेमाल किया जाता है। इसके लिए हम `MATCH() AGAINST()` फंक्शन का उपयोग करते हैं।
* **Example:** 
  ```sql
  CREATE FULLTEXT INDEX idx_desc ON products(description);
  ```

**6. Spatial Index**
* **Definition:** Used for geometry or GIS (Geographic Information System) data. (MySQL supports SPATIAL indexes with MyISAM and InnoDB since 5.7).
* **Hindi (मराठी/हिंदी सारांश):** इस इंडेक्स का उपयोग जियोग्राफिक डेटा (जैसे लोकेशन, मैप्स, GPS निर्देशांक) को स्टोर और सर्च करने के लिए किया जाता है। यह स्थानों के बीच की दूरी या एरिया को तेजी से कैलकुलेट करने में मदद करता है।
* **Example:** 
  ```sql
  CREATE SPATIAL INDEX idx_location ON places(location);
  ```

#### Summary of Index Types: When & How to Use

* **Image Reference:** ![Index Types Summary Overview](./svg_index_types_summary.svg) *(Description: A visual summary of index types, showing when to use them and what their primary purpose is).*

| Index Type | When To Use (Scenario) | How It Helps |
| :--- | :--- | :--- |
| **Clustered Index** | For Primary Keys and ranges. | Sorts physical data. (1 per table). |
| **Non-Clustered** | For Foreign keys, WHERE filters, Joins. | Creates secondary pointers. (Many allowed). |
| **Unique Index** | When a column must not have duplicates. | Enforces data integrity & speeds up exact matches. |
| **Filtered Index** | When querying a specific subset (e.g., Active only). | Reduces index size & increases speed. |
| **Composite Index** | When queries filter by multiple columns often. | Avoids multiple index lookups (respects Leftmost Rule). |
| **Columnstore Index**| When aggregating massive data (Data Warehouse).| Reads specific columns efficiently (OLAP). |
| **Full-Text Index** | When searching for words inside large text/articles. | Enables fast keyword searches (`MATCH AGAINST`). |
| **Spatial Index** | When dealing with maps, GPS, geometry. | Fast spatial queries on polygon/point data. |

### 21.9 Indexing Best Practices in MySQL
* **Do Use Indexes For:**
  * Columns frequently used in `WHERE`, `JOIN`, `ORDER BY`, and `GROUP BY` clauses.
  * Frequently searched columns.
  * Foreign keys (MySQL automatically indexes foreign keys).
* **Avoid Indexing (Do Not Use For):**
  * **Avoid Over-Indexing:** Indexing slows down write performance. When data is inserted, updated, or deleted, the database has to update the indexes.
  * Columns with low selectivity (e.g., `Gender` with only 'M'/'F' values).
  * Very small tables (indexes have overhead and don't help much).
  * Columns that are updated frequently (high index maintenance overhead).
* **Useful Commands:**
  * See existing indexes: `SHOW INDEX FROM employees;`
  * Check if a query uses an index: `EXPLAIN SELECT * FROM employees WHERE name = 'Vishal';`
* **Hindi (मराठी/हिंदी सारांश):** हमेशा उन कॉलम्स पर इंडेक्स बनाएं जो `WHERE`, `JOIN` या `GROUP BY` में बार-बार इस्तेमाल होते हैं। गैर-जरूरी (Over-indexing) या छोटे टेबल्स पर इंडेक्स बनाने से बचें क्योंकि इससे इंसर्ट (Insert) और अपडेट (Update) की स्पीड धीमी हो जाती है।

### 21.10 Advantages & Disadvantages of Indexes
* **Advantages:**
  * Faster `SELECT` queries (Reading).
  * Efficient `JOIN` operations.
  * Enforces uniqueness (via `PRIMARY` / `UNIQUE` constraints).
  * Helps with faster sorting (`ORDER BY`) and grouping (`GROUP BY`).
  * **Summary:** Indexes in MySQL = Speed for reads.
* **Disadvantages:**
  * Requires extra disk space.
  * Slower writes (`INSERT`, `UPDATE`, `DELETE`).
  * Poorly chosen or over-indexed tables can severely hurt performance.
  * **Summary:** Indexes in MySQL = Cost for writes.
* **Hindi (मराठी/हिंदी सारांश):** 
  * **फायदे (Advantages):** डेटा पढ़ने (SELECT) और जॉइन (JOIN) करने की स्पीड बहुत बढ़ जाती है।
  * **नुकसान (Disadvantages):** नया डेटा डालने (INSERT, UPDATE) में समय लगता है और इंडेक्स डिस्क स्पेस (Disk Space) ज्यादा घेरते हैं।

### 21.11 Index Management & Monitoring
* **Definition:** Building an index is not the final step. Over time, indexes get fragmented, outdated, and unused. This can lead to poor query performance, increased storage costs, and a drop in overall database speed.
* **Key Maintenance Steps:**
  1. **Monitor Index Usage:** Identify if the created indexes are actually being used by queries. Unused indexes consume unnecessary storage and slow down writes.
  2. **Monitor Missing Indexes:** Find queries that are slow because an index is missing.
  3. **Monitor Duplicate Indexes:** Remove redundant indexes that cover the same columns.
  4. **Update Statistics:** The Query Optimizer relies on statistics to choose the best index. Keep them updated.
  5. **Monitor Fragmentation:** As data is added or deleted, indexes become fragmented (scattered). Rebuild or reorganize them to maintain speed.
* **Hindi (मराठी/हिंदी सारांश):** इंडेक्स बनाने के बाद उसे मेन्टेन (Maintain) करना भी जरूरी है। समय के साथ बिना इस्तेमाल वाले (Unused) या डुप्लीकेट इंडेक्स को डिलीट करें। जैसे-जैसे डेटा बदलता है, इंडेक्स फ्रैगमेंट (Fragment) हो जाते हैं, इसलिए उन्हें बीच-बीच में रीबिल्ड (Rebuild) करना पड़ता है।

### 21.12 Indexing Strategies
* **Image Reference:** ![Indexing Strategy Overview](./svg_indexing_strategy.svg) *(Description: 4-step Indexing Strategy flowchart: 1. Initial Strategy (OLAP vs OLTP), 2. Usage Patterns Indexing, 3. Scenario-Based Indexing, 4. Monitoring & Maintenance).*
* **Point-Wise Explanation:**
  1. **Initial Indexing Strategy (OLAP vs OLTP):**
     * **OLAP (Analytical):** Goal is to optimize READ performance (e.g., Data Warehouses). Switch large frequently used tables to **ColumnStore** Index.
     * **OLTP (Transactional):** Goal is to optimize WRITE performance (e.g., Apps, Web). Use **Clustered Index** for Primary Keys.
  2. **Usage Patterns Indexing:**
     * Identify frequently used tables & columns.
     * Choose the right index (Unique, Composite, Filtered).
     * Test the index performance.
  3. **Scenario-Based Indexing:**
     * Identify slow queries using logs.
     * Check the execution plan using `EXPLAIN`.
     * Choose the right index and compare the execution plans before and after.
  4. **Monitoring & Maintenance:**
     * Continuously monitor usage, missing indexes, duplicates, statistics, and fragmentation.
* **Hindi (मराठी/हिंदी सारांश):** सही इंडेक्स चुनने के लिए 4 स्टेप्स होते हैं: (1) पहले तय करें कि आपको रीड स्पीड चाहिए या राइट। (2) सबसे ज्यादा इस्तेमाल होने वाले कॉलम्स को पहचानें। (3) `EXPLAIN` कमांड का इस्तेमाल करके चेक करें कि क्या क्वेरी सच में इंडेक्स का उपयोग कर रही है या नहीं। (4) अंत में हमेशा उनका रखरखाव (Maintenance) करें।

### 21.13 Interview Perspective (Pro-Tips)

* **Q: Why not put an index on every column?**
  * **A:** Avoid over-indexing! Indexes require disk space. More importantly, every `INSERT`, `UPDATE`, or `DELETE` requires the database to update the index. Too many indexes will kill write performance.
* **Q: What is an Execution Plan (`EXPLAIN`)?**
  * **A:** You can write `EXPLAIN SELECT ...` in MySQL to see if the database is using your index (Index Seek) or doing a Full Table Scan.
* **Q: Heap vs Clustered vs Non-Clustered Index?**
  * **A:** A Heap is a table without a primary key (reads are full scans). A Clustered Index stores data in physical sorted order (only 1 allowed). Non-Clustered Indexes are secondary pointers (many allowed). Choose wisely → help reads, hurt writes.

---

## Topic 22: Final Summary / निष्कर्ष
* **English Summary:**
  * **HAVING vs WHERE:** `WHERE` filters individual rows before grouping, while `HAVING` filters aggregated data after `GROUP BY`.
  * **Order of Execution:** The database engine processes SQL in this order: `FROM` $\rightarrow$ `WHERE` $\rightarrow$ `GROUP BY` $\rightarrow$ `HAVING` $\rightarrow$ `SELECT` $\rightarrow$ `ORDER BY` $\rightarrow$ `LIMIT`.
  * **Sorting:** `ORDER BY` sorts the final result and must come after `GROUP BY`. It works with or without `WHERE`.
  * **Other Clauses:** `DISTINCT` removes duplicates (use carefully to avoid slow queries). `LIMIT` restricts the number of rows output. Static values (like `123` or `'new_customers'`) can be added directly to the `SELECT` statement.

* **मराठी सारांश (Marathi Summary):**
  * **HAVING आणि WHERE:** `WHERE` ग्रुप बनण्यापूर्वी मूळ rows फिल्टर करतो, तर `HAVING` `GROUP BY` नंतर बनलेल्या ग्रुप्सचा डेटा फिल्टर करतो.
  * **क्वेरी चालण्याचा क्रम (Execution Order):** डेटाबेस या क्रमाने काम करतो: आधी `FROM` (टेबल), मग `WHERE` (फिल्टर), मग `GROUP BY` (ग्रुप), मग `HAVING`, त्यानंतर `SELECT` (कॉलम निवडणे), मग `ORDER BY` (क्रम), आणि शेवटी `LIMIT`.
  * **सॉर्टिंग (Sorting):** `ORDER BY` नेहमी शेवटी रिझल्ट सॉर्ट करतो, म्हणून तो `GROUP BY` नंतरच चालतो.
  * **इतर कीवर्ड्स:** `DISTINCT` डुप्लिकेट डेटा काढतो. `LIMIT` आउटपुटमधील rows ची संख्या ठरवतो (जसे टॉप 5). `SELECT` मध्ये थेट कोणतेही fixed मूल्य (जसे `123`) जोडता येते, जे प्रत्येक row सोबत दिसेल.

---

## Topic 23: Interview Q&A Bank (Most-Asked SQL Questions)

> Short, simple answers you can say in an interview. The **See** column tells you where the full explanation is in these notes.

### 23.1 Part A: Database Basics

| # | Question | Short Answer | See |
| :---: | :--- | :--- | :---: |
| 1 | What is a database? | An organized collection of data stored so it can be easily saved, managed and retrieved. | 1.1 |
| 2 | What is a DBMS / RDBMS? | Software that manages a database (security, many users, backup). An RDBMS stores data in related tables — e.g., MySQL, PostgreSQL, Oracle. | 2.1, 2.6 |
| 3 | What is SQL? | Structured Query Language — the standard language to create, read, update and delete data in relational databases. | 3.1 |
| 4 | SQL vs MySQL? | SQL is the **language**; MySQL is the **software (RDBMS)** that understands SQL and stores the data. | Topic 7 |
| 5 | SQL vs NoSQL? | SQL = tables with a fixed schema and relations (MySQL). NoSQL = flexible formats: key-value, document, column, graph (Redis, MongoDB, Cassandra, Neo4j). | Topic 4 |
| 6 | What is a schema? | A logical folder inside a database that groups tables; also means the structure (blueprint) of the tables. | 6.4 |
| 7 | What is CRUD? | Create (`INSERT`), Read (`SELECT`), Update (`UPDATE`), Delete (`DELETE`). | 3.3 |

### 23.2 Part B: Data Types

| # | Question | Short Answer | See |
| :---: | :--- | :--- | :---: |
| 8 | `CHAR` vs `VARCHAR`? | `CHAR(n)` is fixed length (padded with spaces); `VARCHAR(n)` stores only the actual length + 1–2 bytes. | 6.8.3 |
| 9 | `DATETIME` vs `TIMESTAMP`? | `DATETIME`: 1000–9999, no time zone conversion. `TIMESTAMP`: 1970–2038, stored in UTC and shown in the session time zone. | 6.8.6 |
| 10 | Which data type for money? | `DECIMAL(p, s)` — it is exact. Never `FLOAT`/`DOUBLE` (they are approximate). | 6.8.2 |
| 11 | What is `BOOLEAN` in MySQL? | Just an alias for `TINYINT(1)` — stores 0 (false) or 1 (true). | 6.8.3 |
| 12 | `ENUM` vs `SET`? | `ENUM` stores **one** value from a list; `SET` can store **many** values from a list. | 6.8.3 |

### 23.3 Part C: DDL, DML & Command Types

| # | Question | Short Answer | See |
| :---: | :--- | :--- | :---: |
| 13 | Types of SQL commands? | DDL (`CREATE`, `ALTER`, `DROP`, `TRUNCATE`, `RENAME`), DML (`INSERT`, `UPDATE`, `DELETE`), DQL (`SELECT`), DCL (`GRANT`, `REVOKE`), TCL (`COMMIT`, `ROLLBACK`, `SAVEPOINT`). | 8.2 |
| 14 | `DELETE` vs `TRUNCATE` vs `DROP`? | `DELETE`: removes chosen rows, DML, can rollback. `TRUNCATE`: empties the whole table fast, DDL, resets `AUTO_INCREMENT`, no rollback. `DROP`: removes the table itself. | 8.12 |
| 15 | Can we rollback DDL in MySQL? | No. DDL does an **implicit commit** — it also commits any pending changes before it. | 8.4, 12.7 |
| 16 | `ALTER` vs `UPDATE`? | `ALTER` (DDL) changes the table **structure**; `UPDATE` (DML) changes the **data** in rows. | 9.9 |
| 17 | `MODIFY` vs `CHANGE` in `ALTER TABLE`? | `MODIFY` changes the data type only; `CHANGE` renames the column **and** can change its type. | 8.6 |
| 18 | Can we rename a database in MySQL? | No direct command. Create a new database, move tables with `RENAME TABLE old_db.t TO new_db.t`, then drop the old one. | 8.11 |
| 19 | What is safe update mode? | `SQL_SAFE_UPDATES = 1` blocks `UPDATE`/`DELETE` without a key column in `WHERE` or a `LIMIT`. | 9.5 |
| 20 | `REPLACE` vs `INSERT ... ON DUPLICATE KEY UPDATE`? | `REPLACE` deletes the old row and inserts a new one (other columns reset). `ON DUPLICATE KEY UPDATE` updates the existing row in place. | 9.8 |
| 21 | Soft delete vs hard delete? | Hard delete physically removes the row (`DELETE`). Soft delete only marks it (`UPDATE ... SET is_deleted = 1`), so it can be restored. | 9.6 |

### 23.4 Part D: Keys & Constraints

| # | Question | Short Answer | See |
| :---: | :--- | :--- | :---: |
| 22 | What is a Primary Key? | A column (or columns) that uniquely identifies each row. Unique, not NULL, only one per table. | 6.7, Topic 14 |
| 23 | Primary Key vs Unique Key? | Primary: one per table, no NULL. Unique: many per table, NULL allowed. | Topic 14 |
| 24 | What is a Foreign Key? | A column that refers to the Primary Key of another table, so child rows always point to a real parent row (referential integrity). | 9.7, Topic 14 |
| 25 | `ON DELETE CASCADE` vs `RESTRICT` vs `SET NULL`? | CASCADE deletes child rows too; RESTRICT (MySQL default behaviour) blocks the delete; SET NULL keeps child rows but sets the FK to NULL. | 9.7 |
| 26 | Super, Candidate, Alternate, Composite, Surrogate key? | Super = any set that identifies a row; Candidate = minimal super key; Alternate = candidate not chosen as PK; Composite = key of 2+ columns; Surrogate = artificial ID like `AUTO_INCREMENT`. | Topic 14 |
| 27 | Name the SQL constraints. | `PRIMARY KEY`, `FOREIGN KEY`, `UNIQUE`, `NOT NULL`, `CHECK`, `DEFAULT`. | 8.7, Topic 14 |

### 23.5 Part E: Querying, Filtering, Grouping

| # | Question | Short Answer | See |
| :---: | :--- | :--- | :---: |
| 28 | Execution order of a `SELECT` query? | `FROM` → `WHERE` → `GROUP BY` → `HAVING` → `SELECT` → `DISTINCT` → `ORDER BY` → `LIMIT`. | 13.5, 13.12 |
| 29 | Can we use a `SELECT` alias in `WHERE`? | No — `WHERE` runs before `SELECT`. But you **can** use it in `ORDER BY`. | 13.12 |
| 30 | `WHERE` vs `HAVING`? | `WHERE` filters rows before grouping (no aggregates). `HAVING` filters groups after `GROUP BY` (aggregates allowed). | 13.12 |
| 31 | Can we use `HAVING` without `GROUP BY`? | Yes — the whole table is treated as one group. | 13.9 |
| 32 | Why is `SELECT *` bad in production? | It reads and sends unneeded columns, can't use covering indexes, and breaks when columns change. | 10.2 |
| 33 | `BETWEEN` — inclusive or exclusive? | Inclusive: both ends are included (`>= low AND <= high`). | 13.7.7 |
| 34 | `%` vs `_` in `LIKE`? | `%` = zero or more characters; `_` = exactly one character. | 13.7.9 |
| 35 | Why does `col = NULL` return nothing? | Any comparison with NULL gives UNKNOWN, not TRUE. Use `IS NULL` / `IS NOT NULL`. | 13.7.10 |
| 36 | What does `NOT IN (1, 2, NULL)` return? | Zero rows, because of the NULL. Use `NOT EXISTS` or filter NULLs out. | 13.7.8 |
| 37 | `COUNT(*)` vs `COUNT(col)` vs `COUNT(DISTINCT col)`? | All rows / non-NULL values / unique non-NULL values. | 13.9 |
| 38 | What is `ONLY_FULL_GROUP_BY`? | A mode that requires every selected column to be either in `GROUP BY` or inside an aggregate function (error 1055 otherwise). | 13.9 |
| 39 | `LIMIT` vs `TOP`? Pagination? | MySQL uses `LIMIT`, SQL Server uses `TOP`. Page 3 with 10 rows per page: `LIMIT 10 OFFSET 20`. | 13.12 |

### 23.6 Part F: Joins & SET Operators

| # | Question | Short Answer | See |
| :---: | :--- | :--- | :---: |
| 40 | Types of joins? | INNER, LEFT, RIGHT, FULL (not in MySQL), CROSS, SELF, plus anti-joins (LEFT/RIGHT/FULL ANTI). | Topic 15 |
| 41 | `INNER JOIN` vs `LEFT JOIN`? | Inner = only matching rows. Left = all rows of the left table + matches (NULL where no match). | Topic 15 |
| 42 | How to do a `FULL JOIN` in MySQL? | `LEFT JOIN ... UNION ... RIGHT JOIN`. | Topic 15 |
| 43 | What is a self join? | Joining a table to itself with aliases, e.g., employee → manager. | Topic 15 |
| 44 | What is a cross join? | Every row of A × every row of B (Cartesian product), no `ON`. | Topic 15 |
| 45 | JOIN vs UNION? | JOIN adds **columns** (wider result); UNION adds **rows** (longer result). | Topic 16 |
| 46 | `UNION` vs `UNION ALL`? | `UNION` removes duplicates (slower); `UNION ALL` keeps all rows (faster). | Topic 16 |
| 47 | Rules for SET operators? | Same number of columns, compatible data types, same column order; `ORDER BY` only once at the end; names come from the first query. | Topic 16 |

### 23.7 Part G: Functions, NULL & CASE

| # | Question | Short Answer | See |
| :---: | :--- | :--- | :---: |
| 48 | `IFNULL` vs `COALESCE`? | `IFNULL(a, b)` takes 2 values; `COALESCE(a, b, c, ...)` returns the first non-NULL of many (and is standard SQL). | Topic 19 |
| 49 | What is `NULLIF` used for? | `NULLIF(a, b)` returns NULL if a = b. Common use: avoid divide-by-zero → `x / NULLIF(qty, 0)`. | Topic 19 |
| 50 | What is `CASE`? | SQL's if-then-else. It checks conditions top to bottom and returns the first match; `ELSE` is the default. | Topic 19 |
| 51 | `DATEDIFF` vs `TIMESTAMPDIFF` in MySQL? | `DATEDIFF(end, start)` gives days only; `TIMESTAMPDIFF(unit, start, end)` gives years, months, hours, etc. | Topic 18 |
| 52 | Single-row vs aggregate functions? | Single-row: one input → one output per row (`UPPER`, `ROUND`). Aggregate: many rows → one result (`SUM`, `AVG`). | Topic 17 |

### 23.8 Part H: Window Functions

| # | Question | Short Answer | See |
| :---: | :--- | :--- | :---: |
| 53 | What is a window function? | A function used with `OVER()` that calculates across related rows **without collapsing them** (unlike `GROUP BY`). | Topic 20 |
| 54 | `ROW_NUMBER` vs `RANK` vs `DENSE_RANK`? | For 100, 90, 90, 80 → 1,2,3,4 / 1,2,2,4 / 1,2,2,3. | Topic 20 |
| 55 | `PARTITION BY` vs `GROUP BY`? | Both make groups, but `PARTITION BY` keeps every row; `GROUP BY` returns one row per group. | Topic 20 |
| 56 | What do `LAG` and `LEAD` do? | Read the value from the previous (`LAG`) or next (`LEAD`) row — used for month-over-month comparisons. | Topic 20 |
| 57 | Running total vs rolling total? | Running = from the first row up to the current row. Rolling = a fixed window, e.g., the last 3 rows. | Topic 20 |
| 58 | Why does `LAST_VALUE` give a wrong answer? | The default frame ends at the current row. Use `ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING`. | Topic 20 |
| 59 | Can we use a window function in `WHERE`? | No — wrap the query in a subquery/CTE and filter outside. | Topic 20 |

### 23.9 Part I: Transactions & Security

| # | Question | Short Answer | See |
| :---: | :--- | :--- | :---: |
| 60 | What are ACID properties? | Atomicity (all or nothing), Consistency (valid state), Isolation (transactions don't disturb each other), Durability (saved even after a crash). | 12.2 |
| 61 | Isolation levels & MySQL default? | READ UNCOMMITTED, READ COMMITTED, REPEATABLE READ (**MySQL default**), SERIALIZABLE. | 12.6 |
| 62 | Dirty read / non-repeatable read / phantom read? | Reading uncommitted data / same row gives a different value on re-read / new rows appear on re-run of a range query. | 12.6 |
| 63 | What is a savepoint? | A checkpoint inside a transaction; `ROLLBACK TO sp` undoes only the changes after it. | 12.3 |
| 64 | What is a deadlock? | Two transactions wait for each other's locks. InnoDB detects it and rolls back one (error 1213). | 12.7 |
| 65 | Is autocommit on by default? | Yes. Each statement is committed immediately unless you use `START TRANSACTION` or `SET autocommit = 0`. | 12.7 |
| 66 | `GRANT` vs `REVOKE`? Is `FLUSH PRIVILEGES` needed? | `GRANT ... TO` gives permission; `REVOKE ... FROM` removes it. `FLUSH PRIVILEGES` is **not** needed after them. | Topic 11 |

### 23.10 Part J: Query-Writing Questions (Practice These)

* **Q67. Find the 2nd highest salary.**
  ```sql
  SELECT MAX(salary) AS second_highest
  FROM employees
  WHERE salary < (SELECT MAX(salary) FROM employees);

  -- or
  SELECT DISTINCT salary FROM employees ORDER BY salary DESC LIMIT 1 OFFSET 1;
  ```

* **Q68. Find the Nth highest salary (N = 3), handling equal salaries.**
  ```sql
  SELECT DISTINCT salary
  FROM (
      SELECT salary, DENSE_RANK() OVER (ORDER BY salary DESC) AS rnk
      FROM employees
  ) t
  WHERE rnk = 3;
  ```

* **Q69. Highest-paid employee in each department.**
  ```sql
  SELECT name, department, salary
  FROM (
      SELECT name, department, salary,
             RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS rnk
      FROM employees
  ) t
  WHERE rnk = 1;
  ```

* **Q70. Find duplicate emails.**
  ```sql
  SELECT email, COUNT(*) AS times
  FROM customers
  GROUP BY email
  HAVING COUNT(*) > 1;
  ```

* **Q71. Delete duplicate rows but keep the one with the lowest id.**
  ```sql
  DELETE c1
  FROM customers c1
  JOIN customers c2
    ON c1.email = c2.email
   AND c1.id > c2.id;
  ```

* **Q72. Customers who never placed an order.**
  ```sql
  SELECT c.id, c.first_name
  FROM customers c
  LEFT JOIN orders o ON c.id = o.customer_id
  WHERE o.customer_id IS NULL;
  ```

* **Q73. Employees who earn more than their manager.**
  ```sql
  SELECT e.name AS employee, e.salary, m.name AS manager, m.salary AS manager_salary
  FROM employees e
  JOIN employees m ON e.manager_id = m.id
  WHERE e.salary > m.salary;
  ```

* **Q74. Number of employees in each department, biggest first.**
  ```sql
  SELECT department, COUNT(*) AS total_employees
  FROM employees
  GROUP BY department
  ORDER BY total_employees DESC;
  ```

* **Q75. Running total of sales by date.**
  ```sql
  SELECT order_date, sales,
         SUM(sales) OVER (ORDER BY order_date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_total
  FROM orders;
  ```

* **Q76. Customers whose score is above the average score.**
  ```sql
  SELECT first_name, score
  FROM customers
  WHERE score > (SELECT AVG(score) FROM customers);
  ```

* **📌 मराठी सारांश:**
  * मुलाखतीत सर्वात जास्त विचारले जाणारे ७६ प्रश्न, भागांनुसार (Basics, Data Types, DDL/DML, Keys, Querying, Joins, Functions, Window Functions, Transactions, Query-writing).
  * प्रत्येक उत्तर लहान आणि सोपे आहे; सविस्तर माहितीसाठी **See** कॉलममधील विभाग वाचा.
  * **Part J** मधील queries (2nd / Nth highest salary, डुप्लिकेट शोधणे व डिलीट करणे, ऑर्डर न दिलेले ग्राहक, मॅनेजरपेक्षा जास्त पगार, running total) स्वतः लिहून सराव करा.

---

## Topic 24: Derived Tables in SQL

### 24.1 What is a Derived Table?
* **Definition:** A derived table is a subquery inside the `FROM` clause that acts like a temporary table for the duration of the main query.
* **Key Properties:**
  * It is **not stored permanently** (unlike normal tables or views).
  * It **only exists** while the query is running.
  * It is primarily used to simplify complex queries and break down logic into simpler steps.
  * **Important Rule:** You **MUST** give the derived table an alias (a name).
* **Hindi (मराठी/हिंदी सारांश):** Derived Table एक Subquery होती है जो `FROM` क्लॉज के अंदर लिखी जाती है। यह एक टेम्परेरी (Temporary) टेबल की तरह काम करती है और केवल क्वेरी के चलने तक ही रहती है। इसे हमेशा एक Alias (नाम) देना ज़रूरी है।

### 24.2 Syntax and Example
* **Syntax:**
  ```sql
  SELECT columns
  FROM (subquery) AS alias_name;
  ```
* **Example (Derived Table with Aggregation):**
  Suppose you want the average salary of **active** employees by department.
  ```sql
  SELECT dept_id, AVG(salary) AS avg_salary
  FROM (
      -- This is the Derived Table (Subquery in FROM clause)
      SELECT dept_id, salary
      FROM employees
      WHERE status = 'ACTIVE'
  ) AS active_emps
  GROUP BY dept_id;
  ```
  * *Explanation:* The subquery `(SELECT dept_id, salary FROM employees WHERE status = 'ACTIVE')` acts like a temporary table named `active_emps`. The main query then groups this temporary table.

### 24.3 Difference Between Derived Table and Subquery
| Feature | Subquery (in WHERE / SELECT) | Derived Table (in FROM) |
| :--- | :--- | :--- |
| **Placement** | Written inside `WHERE`, `HAVING`, or `SELECT` clauses. | Written **only** inside the `FROM` clause. |
| **Output Type** | Returns a single value or a list of values (1 column). | Acts like a full virtual table (Rows & Columns). |
| **Usage** | Used for filtering or returning a single calculated column. | Used so you can `JOIN`, `GROUP BY`, or filter on its result like a real table. |

---

## Topic 25: Query Execution Plans (EXPLAIN)

### 25.1 What is an Execution Plan?
* **Definition:** An execution plan (also called a query plan or roadmap) is a detailed map or blueprint generated by the database engine that shows **exactly how it processes your query step-by-step**. 
* **Uses:** It is used to understand how the database retrieves data, which indexes it uses, what joins are performed, and how efficient your query is. It shows exactly where you might have performance issues.
* **How it works:** 
  1. Before executing the query, the database plans how to execute it based on statistics (e.g., Scan index vs full table scan).
  2. It decides which type of joins to use (e.g., hash join vs nested loop join).
  3. Finally, it executes the `SELECT` statement.
  4. Once ready, the database engine implements the steps, reads tables from disk, joins them, and sends the result.
  5. **Caching:** The database engine stores this execution plan in the cache. If you run the exact same query again, it reuses the cached plan instantly instead of building it from scratch!
* **Hindi (मराठी/हिंदी सारांश):** Execution Plan एक ब्लूप्रिंट (Blueprint) की तरह है जो बताता है कि डेटाबेस आपकी क्वेरी को स्टेप-बाय-स्टेप कैसे चलाएगा। यह बताता है कि डेटाबेस कौन सा इंडेक्स यूज़ करेगा और जॉइन कैसे करेगा। एक बार प्लान बन जाने पर डेटाबेस उसे 'Cache' में सेव कर लेता है ताकि अगली बार सेम क्वेरी तेज़ी से चल सके।

### 25.2 Types of Execution Plans

* **Image Reference:** ![Execution Plan Types](./svg_execution_plan_types.svg) *(Description: Compares Estimated vs Actual vs Live execution plans).*

**1. Estimated Execution Plan (What MySQL plans to do)**
* **Definition:** The optimizer’s prediction of how it plans to execute the query without actually running it.
* **Key Points:**
  * **Query is NOT executed.**
  * Shows the optimizer’s guess about: which indexes it will use, join types, estimated rows to read, and query cost.
  * Helps you preview performance before running a heavy query.
* **Example:** `EXPLAIN SELECT * FROM employees WHERE department = 'Sales';`
* **Hindi (मराठी/हिंदी सारांश):** यह सिर्फ एक अनुमान (Estimate) होता है। इसमें क्वेरी असल में रन नहीं होती, बस डेटाबेस बताता है कि वह इसे कैसे चलाने वाला है।

**2. Actual Execution Plan (What MySQL really did)**
* **Definition:** The real plan showing how the query actually executed, including real row counts, time taken, and runtime statistics.
* **Key Points:**
  * **Query IS executed.**
  * Shows what actually happened: real number of rows read, actual execution time per step, and whether the optimizer’s estimates were correct.
* **Example:** `EXPLAIN ANALYZE SELECT * FROM employees WHERE department = 'Sales';`
* **Hindi (मराठी/हिंदी सारांश):** यह तब बनता है जब क्वेरी पूरी तरह से रन हो जाती है। यह असल डेटा (Actual Data) दिखाता है कि क्वेरी चलने में कितना समय लगा और कितनी रोज़ (Rows) प्रोसेस हुईं।

**3. Live Execution Plan (with Live Statistics)**
* **Definition:** Shows query execution in real-time (mainly in tools like SQL Server Management Studio or MySQL Workbench 8+).
* **Key Points:**
  * Used for long-running queries to identify bottlenecks while the query is executing.
  * Shows live progress (% completion) and live row counts.

### 25.3 Estimated vs Actual Execution Plan Match
* If the prediction **does not match** the actual plan, it indicates issues like inaccurate statistics or outdated indexes leading to poor performance.
* If the estimated and actual execution plan **match**, then your statistics are up-to-date and performance is optimal.

---

## Topic 26: Scans & Seeks (Data Access Methods)

* **Image Reference:** ![Scan vs Seek](./svg_scan_vs_seek.svg) *(Description: Visual comparison of Full Table Scan vs Index Scan vs Index Seek).*

### 26.1 What is a Table Scan?
* **Definition:** Reading the entire table page by page and row by row.
* **Impact:** Leads to very slow query performance on large datasets.
* **Example:** Like reading every single page of a book to find a name.
* **Hindi (मराठी/हिंदी सारांश):** टेबल स्कैन का मतलब है टेबल की हर एक लाइन (Row) को शुरू से अंत तक पढ़ना। यह बहुत धीमा होता है।

### 26.2 What is an Index Scan?
* **Definition:** Scanning all data inside an index to find matching rows (or only scanning the data which is part of the index).
* **Impact:** Faster than a table scan, but still reads a lot of entries.
* **Example:** Like reading every entry in the index section at the back of a book.

### 26.3 What is an Index Seek?
* **Definition:** A targeted search within an index, retrieving only specific rows. MySQL directly looks up the specific rows it needs using the index key.
* **Impact:** Extremely fast (Targeted lookup).
* **Example:** Looking up the name "John Smith" in an index and jumping directly to that exact page.
* **Hindi (मराठी/हिंदी सारांश):** इंडेक्स सीक सबसे तेज़ होता है क्योंकि इसमें डेटाबेस सीधा उसी रो (Row) पर जंप करता है जो आपको चाहिए, बिना फालतू डेटा पढ़े।

### 26.4 Best Practices to Ensure Index Seek
1. Use `WHERE` filters on indexed columns.
2. Prefer equality (`=`) or range conditions (`>`, `<`).
3. Create composite indexes for multi-column filters.

---

## Topic 27: SQL Join Algorithms (How Joins Work Internally)

* **Image Reference:** ![Join Algorithms](./svg_join_algorithms.svg) *(Description: Shows Nested Loop Join, Hash Join, and Block Nested Loop Join concepts).*

* **Definition:** A join algorithm is the method the SQL engine uses under the hood to combine rows from two (or more) tables. Even though you just write `JOIN`, MySQL must decide exactly how to perform that match.

### 27.1 Nested Loop Join (NLJ)
* **Definition:** For each row in the first (outer) table, MySQL looks up matching rows in the second (inner) table.
* **Details:** This is the most common (default) algorithm. If there is an index on the join column, it is an **Index Nested Loop Join** (Very Fast). If there is no index, it becomes very slow.
* **Hindi (मराठी/हिंदी सारांश):** इसमें डेटाबेस पहले टेबल की हर एक रो (Row) को उठाता है और दूसरे टेबल में जाकर मैच ढूंढता है। (For loop के अंदर For loop की तरह)।

### 27.2 Hash Join (MySQL 8.0.18+)
* **Definition:** Builds a hash table in memory from one table, then probes (checks) it with rows from the other table.
* **Details:** Used for large, non-indexed joins. It is much faster than nested loops when indexes are missing.

### 27.3 Block Nested Loop Join (BNLJ)
* **Definition:** Uses blocks of rows (chunks) instead of one-by-one row comparisons.
* **Details:** Improves performance when indexes aren't helpful, reducing the number of times the inner table needs to be scanned.

* **Interview Perspective (SQL Server specific):** 
  * **Merge Join Algorithm:** Used when both tables are already sorted on the join keys. It merges them extremely efficiently. (Popular in SQL Server).

---

## Topic 28: Heap vs Clustered Index (Internal Storage)

### 28.1 What is a Heap Table?
* **Definition:** A Heap is a table without a clustered index (no Primary Key). The data is not stored in any specific order — it’s just a collection of rows stored randomly wherever space is available.
* **Characteristics:**
  * **No clustered index:** Data has no defined physical order.
  * **Storage:** Rows are appended randomly.
  * **Access Method:** Usually requires a Full Table Scan (unless non-clustered indexes exist).
  * **Pros:** Faster inserts (data goes anywhere).
  * **Cons:** Slower lookups.
* **Hindi (मराठी/हिंदी सारांश):** हीप एक ऐसा टेबल है जिसमें कोई प्राइमरी की (Primary Key) नहीं होती। डेटा बिना किसी क्रम (Order) के सेव होता है। इसमें नया डेटा डालना तेज़ होता है, लेकिन ढूँढना बहुत धीमा।

### 28.2 What is a Clustered Index?
* **Definition:** A Clustered Index determines the physical order of data in the table. The table’s rows are stored on disk in the exact order of the clustered index key. (In InnoDB MySQL, the primary key is always the clustered index).
* **Characteristics:**
  * **One per table:** You can have only ONE clustered index.
  * **Data stored in order:** Physically arranged by the key.
  * **Pros:** Extremely fast range queries and exact match lookups.
  * **Cons:** Slower inserts if the key order changes (can cause page splits).
  * **Note:** Non-clustered indexes store this clustered key as a pointer to find the actual data row.

---

## Topic 29: Table Duplication & Copying Techniques

* **Image Reference:** ![Table Copying Techniques](./svg_table_copying.svg) *(Description: Compares CREATE TABLE AS vs CREATE TABLE LIKE).*

### 29.1 Copying Table Data WITHOUT Constraints
* **Definition:** You can create a new table from an existing one that contains the structure and the data, but **does NOT** copy constraints (Indexes, Primary Keys, Foreign Keys, Triggers, or Auto-increment properties).
* **Syntax / Example:**
  ```sql
  CREATE TABLE SALESDB_CUSTOMERS_HP AS
  SELECT * FROM CUSTOMERS;
  ```
* **Hindi (मराठी/हिंदी सारांश):** इस तरीके से टेबल का स्ट्रक्चर और डेटा तो कॉपी हो जाता है, लेकिन प्राइमरी की (Primary Key) और इंडेक्स (Indexes) कॉपी नहीं होते।

### 29.2 Copying Table Data WITH Constraints (Exact Clone)
* **Definition:** If you want an exact clone of the table structure (including all indexes, primary keys, and auto-increments), you must use `LIKE`. After creating the empty clone, you copy the data using `INSERT INTO ... SELECT`.
* **Step 1: Copy Structure & Constraints**
  ```sql
  CREATE TABLE CUSTOMERS2 LIKE CUSTOMERS;
  ```
* **Step 2: Copy the Data**
  ```sql
  INSERT INTO CUSTOMERS2 
  SELECT * FROM CUSTOMERS;
  ```
  ```sql
  -- Verify the copy
  SELECT * FROM CUSTOMERS2;
  ```
* **Hindi (मराठी/हिंदी सारांश):** अगर आपको टेबल का पूरा स्ट्रक्चर (प्राइमरी की, इंडेक्स के साथ) कॉपी करना है, तो पहले `LIKE` का उपयोग करके खाली टेबल बनाएं, और फिर `INSERT INTO` का इस्तेमाल करके उसमें डेटा डालें।

---

## Topic 30: SQL Table Partitioning (Performance Optimization)

### 30.1 What is Partitioning?
* **Definition:** Partitioning is the process of splitting one large, big table into smaller, manageable physical pieces (called partitions) while keeping it logically as **one single table** for queries.
* **How it works:** MySQL automatically decides which partition(s) to read based on your query. You don't have to manually select from different tables; the database engine handles the routing for you.
* **Hindi (मराठी/हिंदी सारांश):** पार्टीशनिंग का मतलब है एक बहुत बड़ी टेबल को छोटे-छोटे टुकड़ों (Partitions) में बाँटना। बाहर से देखने पर यह एक ही टेबल लगती है, लेकिन अंदर डेटाबेस इसे अलग-अलग फाइल्स में सेव करता है। इससे डेटा ढूँढना और मैनेज करना बहुत तेज़ हो जाता है।

### 30.2 The Problem: Why Do We Need Partitioning?
* **Image Reference:** ![Big Table Problem](./svg_big_table_problem.svg) *(Description: A massive 100M+ row table causes full table scans to be extremely slow. Trying to fix it with a massive single index also fails because inserting, updating, and deleting rows in a huge index takes a long time).*
* **Scenario:** Imagine a table with 100 million rows that grows every year (e.g., 2023, 2024, 2025). 
  * If you do a full table scan, it takes forever.
  * If you add a massive index, reading is faster, but `INSERT`, `UPDATE`, and `DELETE` operations become extremely slow because updating a massive index tree takes heavy processing.
  * Usually, you only query **new data** (e.g., 2025) heavily, and rarely need old data (e.g., 2023).

### 30.3 The Solution: Partitioning & Scalability
* **Image Reference:** ![Partition Solution](./svg_partition_solution.svg) *(Description: The big table is split by year. A query for 2025 ONLY scans the 2025 partition).*
* **Targeted Scanning:** We split the table by year. When you run `SELECT * FROM table WHERE year = 2025`, MySQL will **only scan the 2025 partition** and completely ignore 2023 and 2024.
* **Parallel Processing:** Modern databases can process each partition independently and in parallel. This drastically reduces overall execution time.
* **Smaller Indexes:** 
  * **Image Reference:** ![Partition Indexing](./svg_partition_indexing.svg) *(Description: Each partition gets its own small index instead of one giant index for the whole table).*
  * Instead of one giant index, each partition gets its own smaller index. When you insert data in 2025, it only updates the small index for 2025 without touching the 2023/2024 indexes. This makes indexing **highly efficient**.

### 30.4 Advantages & Limitations of Partitioning
* **Advantages:**
  * **Speeds up queries:** Targeted partition scanning is incredibly fast.
  * **Maintenance:** Archiving is trivial.
  * **Fast Deletions:** You can drop old data instantly: `ALTER TABLE sales DROP PARTITION p2022;` (This is much faster than running a massive `DELETE` query).
  * **Parallelism:** Supports parallel processing for big data.
* **Limitations (MySQL):**
  * Works mostly with `InnoDB` or `NDB` engines.
  * The Primary Key (or Unique Key) **MUST** include the partition key column(s).
  * Too many partitions can actually hurt performance.

### 30.5 Partition Boundaries (LEFT vs RIGHT)
* **Image Reference:** ![Partition Boundaries](./svg_partition_boundaries.svg) *(Description: LEFT partitioning includes the boundary in the left partition, while RIGHT includes it in the right partition).*
* When using `RANGE` partitioning, we define boundaries (e.g., the last day of the year). But where does the exact boundary value go?
* **1. LEFT Partitioning (MySQL Default):**
  * The boundary value is included in the partition to the **LEFT** of the boundary.
  * Example: A row exactly on `2023-12-31` belongs to Partition 1 (2023). 
* **2. RIGHT Partitioning (SQL Server):**
  * The boundary value is included in the partition to the **RIGHT** of the boundary.
  * Example: A row exactly on `2023-12-31` belongs to Partition 2 (Next year).
  * *Note: MySQL does not natively support RIGHT partitioning syntax, it is always LEFT-inclusive.*

### 30.6 Building Partitions in MySQL (4 Steps)

**1. Create a Partitioned Table (Inline Creation)**
In MySQL, partitioning logic is defined inline with the table creation.
```sql
CREATE TABLE person_data (
    sales_id INT AUTO_INCREMENT,
    amount INT,
    order_date DATE,
    -- The partition column (order_date) MUST be part of the Primary Key
    PRIMARY KEY(sales_id, order_date)
)
PARTITION BY RANGE(YEAR(order_date)) (
    PARTITION p2022 VALUES LESS THAN (2023),
    PARTITION p2023 VALUES LESS THAN (2024),
    PARTITION p2024 VALUES LESS THAN (2025),
    PARTITION pmax VALUES LESS THAN MAXVALUE
);
```
* **Hindi (मराठी/हिंदी सारांश):** टेबल बनाते समय ही `PARTITION BY RANGE` का इस्तेमाल करके हम अलग-अलग सालों (Years) के लिए पार्टीशन बना सकते हैं। जो कॉलम पार्टीशन के लिए यूज़ हो रहा है, उसका Primary Key में होना जरूरी है।

**2. View All Partitions**
* Check table structure:
  ```sql
  SHOW CREATE TABLE person_data;
  ```
* Best way to check partition metadata (Detailed):
  ```sql
  SELECT 
      TABLE_SCHEMA,
      TABLE_NAME,
      PARTITION_NAME,
      PARTITION_ORDINAL_POSITION AS position,
      PARTITION_METHOD,
      PARTITION_DESCRIPTION AS range_value,
      TABLE_ROWS
  FROM INFORMATION_SCHEMA.PARTITIONS
  WHERE TABLE_NAME = 'person_data';
  ```

**3. Adding Partitions to an Existing Empty Table**
If the table is completely empty, you can alter it directly:
```sql
ALTER TABLE sales
PARTITION BY RANGE (YEAR(order_date)) (
    PARTITION p2022 VALUES LESS THAN (2023),
    PARTITION p2023 VALUES LESS THAN (2024),
    PARTITION pmax VALUES LESS THAN MAXVALUE
);
```

**4. Adding Partitions to a Table WITH Existing Data (Recommended Safe Way)**
MySQL doesn’t easily let you add partitions to a huge table full of data. The safest way is to clone it.
* **Step 1:** Rename the old table.
  ```sql
  RENAME TABLE sales TO sales_old;
  ```
* **Step 2:** Create a new partitioned table with the exact same structure (Ensure the partition key is in the PK).
* **Step 3:** Copy data back.
  ```sql
  INSERT INTO sales SELECT * FROM sales_old;
  ```

### 30.7 Interview Perspective (Pro-Tips)
* **Q: Indexing vs Partitioning?**
  * **A:** Indexing optimizes search by creating a sorted tree of pointers. Partitioning optimizes search by physically dividing the table into smaller chunks. Combining both (Partitioned Indexing) gives maximum performance for massive data.
* **Q: Why is dropping a partition better than deleting old rows?**
  * **A:** Running `DELETE FROM table WHERE year = 2022` removes rows one-by-one, logging every deletion and heavily fragmenting the index. Running `ALTER TABLE table DROP PARTITION p2022` just deletes the physical file from the disk instantly, saving hours of processing time!

---

## Topic 31: CTEs (Common Table Expressions) & Recursive CTEs

### 31.1 What is a CTE?
* **Definition:** A CTE (Common Table Expression) is a temporary result set that you can reference within another `SELECT`, `INSERT`, `UPDATE`, or `DELETE` statement. It exists only for the duration of the query.
* **Syntax:**
  ```sql
  WITH EmployeeCTE AS (
      SELECT id, name, salary FROM employees WHERE salary > 50000
  )
  SELECT * FROM EmployeeCTE;
  ```
* **Hindi (मराठी/हिंदी सारांश):** CTE एक टेम्परेरी (Temporary) टेबल की तरह है जो केवल एक क्वेरी के चलने तक रहता है। यह कॉम्प्लेक्स क्वेरीज को छोटे और पढ़ने लायक (Readable) हिस्सों में तोड़ने के काम आता है।

### 31.2 CTE vs Subquery vs Temp Table (Interview Favorite)
| Feature | Subquery | CTE | Temp Table (`#Temp`) |
| :--- | :--- | :--- | :--- |
| **Readability** | Hard to read if nested deeply. | Very easy to read (Top-down logic). | Easy to read. |
| **Reusability** | Cannot be reused in the same query. | Can be referenced multiple times in the same query. | Can be used across multiple queries in the same session. |
| **Storage** | Lives in memory (usually). | Lives in memory. | Lives physically in `tempdb` (on disk). |
| **Performance** | Optimizer treats it similarly to a CTE. | Optimizer treats it similarly to a Subquery. | Good for massive data (supports indexing). |

### 31.3 Recursive CTEs
* **Definition:** A Recursive CTE is a CTE that references itself. It is primarily used for querying hierarchical data, such as Employee-Manager relationships, category trees, or organization charts.
* **How it works:** It has an **Anchor Member** (the starting point) and a **Recursive Member** (which loops until a condition is met), connected by `UNION ALL`.
* **Hindi (मराठी/हिंदी सारांश):** Recursive CTE अपने आप को ही बार-बार कॉल करता है। यह ट्री (Tree) जैसे डेटा (जैसे बॉस और उसके नीचे काम करने वाले कर्मचारी) को निकालने के लिए बेस्ट है।

---

## Topic 32: ACID Properties & Transaction Isolation Levels

### 32.1 What are ACID Properties?
ACID guarantees that database transactions are processed reliably.
1. **Atomicity (All or Nothing):** A transaction is a single unit. Either all statements in the transaction succeed, or none do (Rollback).
2. **Consistency:** A transaction must take the database from one valid state to another. (e.g., constraints and rules are never violated).
3. **Isolation:** Concurrent transactions execute independently without interfering with each other.
4. **Durability:** Once a transaction is committed, it remains saved even if the system crashes or loses power.
* **Hindi (मराठी/हिंदी सारांश):** ACID मतलब: 1. काम पूरा होगा या बिल्कुल नहीं होगा (A), 2. रूल्स कभी नहीं टूटेंगे (C), 3. दो ट्रांसक्शन्स एक-दूसरे से भिड़ेंगे नहीं (I), 4. एक बार सेव हो गया तो डेटा उड़ेगा नहीं (D)।

### 32.2 Concurrency Problems (Read Phenomena)
1. **Dirty Read:** Reading uncommitted data from another transaction (which might get rolled back later).
2. **Non-Repeatable Read:** Reading the same row twice in a transaction, but getting different data because someone else UPDATED it in between.
3. **Phantom Read:** Running the same query twice, but getting a different number of rows because someone else INSERTED/DELETED rows in between.

### 32.3 Transaction Isolation Levels (MySQL InnoDB)
* Isolation levels determine how strictly a database handles concurrency problems.
1. **READ UNCOMMITTED:** No isolation. Allows Dirty, Non-Repeatable, and Phantom reads. (Fastest, but dangerous).
2. **READ COMMITTED:** Fixes Dirty Reads. (You only read committed data).
3. **REPEATABLE READ (MySQL Default):** Fixes Dirty & Non-Repeatable reads. If you read a row, it stays exactly the same for your entire transaction.
4. **SERIALIZABLE:** Fixes all problems. Transactions wait in line (lock the tables). (Safest, but slowest).

---

## Topic 33: Database Normalization (1NF to BCNF)

### 33.1 What is Normalization?
* **Definition:** The process of organizing data in a database to eliminate redundancy (data duplication) and ensure data integrity.
* **Hindi (मराठी/हिंदी सारांश):** डेटाबेस डिज़ाइन करते समय एक ही डेटा को बार-बार लिखने (Duplication) से बचने और टेबल को सही हिस्सों में तोड़ने के तरीके को नार्मलाइज़ेशन कहते हैं।

### 33.2 The Normal Forms (Step-by-Step)
1. **1NF (First Normal Form):**
   * Rule: Each column must have atomic (single) values. No comma-separated lists in one column!
2. **2NF (Second Normal Form):**
   * Rule: Must be in 1NF. AND all non-key columns must depend on the **entire** Primary Key (Removes partial dependency). Usually solved by moving data to a new table with a Foreign Key.
3. **3NF (Third Normal Form):**
   * Rule: Must be in 2NF. AND no non-key column should depend on another non-key column (Removes transitive dependency). "Every non-key attribute must provide a fact about the key, the whole key, and nothing but the key."
4. **BCNF (Boyce-Codd Normal Form):**
   * Rule: A stricter version of 3NF. Every determinant must be a candidate key.

### 33.3 What is Denormalization?
* **Definition:** Intentionally adding redundancy back to a normalized database to speed up heavy read queries (avoiding complex Joins). Common in Data Warehouses (OLAP).

---

## Topic 34: Deadlocks in SQL

### 34.1 What is a Deadlock?
* **Definition:** A deadlock occurs when two or more transactions are waiting for each other to release locks. They get stuck in an infinite wait, and neither can proceed.
* **Example:** 
  * Transaction A locks Table 1 and needs Table 2.
  * Transaction B locks Table 2 and needs Table 1.
  * *Result:* Deadlock! The Database Engine steps in, kills one transaction (the "victim"), and lets the other finish.
* **Hindi (मराठी/हिंदी सारांश):** डेडलॉक तब होता है जब दो ट्रांज़ैक्शन एक-दूसरे का रास्ता रोक कर खड़े हो जाते हैं और दोनों आगे नहीं बढ़ पाते। डेटाबेस को मज़बूरी में एक को किल (Kill) करना पड़ता है।

### 34.2 How to Prevent Deadlocks?
1. Always access tables in the **same order** across all transactions.
2. Keep transactions as **short** and fast as possible.
3. Add proper **Indexes** so queries run faster and release locks quicker.
4. Use a lower **Isolation Level** if appropriate (e.g., READ COMMITTED).

---

## Topic 35: Query Optimization / Tuning Checklist (Interview Favorite)

If an interviewer asks: *"You have a slow query, how do you optimize it?"*, follow this checklist:

1. **Check the Execution Plan (`EXPLAIN`):** Look for "Full Table Scans". Are indexes being used properly (Index Seek vs Scan)?
2. **Avoid `SELECT *`:** Only select the columns you actually need. Less data transferred = faster query.
3. **Analyze `WHERE` clauses:** 
   * Avoid functions on indexed columns in the `WHERE` clause (e.g., `WHERE YEAR(date) = 2023` breaks the index. Use `WHERE date >= '2023-01-01'`).
   * Avoid leading wildcards in `LIKE` (e.g., `LIKE '%name'` prevents index usage. Use `LIKE 'name%'`).
4. **Optimize Joins:** 
   * Join on indexed columns (Foreign Keys / Primary Keys).
   * Filter data *before* joining by using subqueries or CTEs to reduce the dataset size early on.
5. **Add or Rebuild Indexes:** If a query filters on a column frequently, add an index. If the index is fragmented, rebuild it.
6. **Consider Partitioning:** If the table is massive (millions of rows), partition it by Date/Year.

---

## Topic 36: Database Engine Architecture & Storage Concepts

### 36.1 What is a Data Warehouse?
* **Definition:** A special database that collects data from different sources and integrates it into one centralized place. It enables heavy analytics and supports business decision-making.
* **Hindi (मराठी/हिंदी सारांश):** डेटा वेयरहाउस एक स्पेशल डेटाबेस है जो अलग-अलग सोर्सेज से डेटा को एक जगह पर इकट्ठा करता है, ताकि उस पर बड़े-बड़े एनालिसिस (Analytics) किये जा सकें और बिज़नेस के डिसीजन्स लिए जा सकें।

### 36.2 The Database Engine
* **Definition:** The Database Engine is the "brain" of the database. It is responsible for executing multiple operations such as storing, retrieving, and managing data within the database.
* Every time you execute a query, the Database Engine takes care of processing it.
* **Hindi (मराठी/हिंदी सारांश):** डेटाबेस इंजन डेटाबेस का "दिमाग" होता है। आप जो भी क्वेरी लिखते हैं, यह इंजन ही उसे चलाता है, डेटा सेव करता है और ढूँढकर लाता है।

### 36.3 Database Storage Types (Disk vs Cache)
* **Image Reference:** ![DB Engine Architecture](./svg_db_engine_architecture.svg) *(Description: Shows Client sending query to Server. Database Engine checks Cache first, then checks Disk [Temp, Catalog, User]).*
* In a database, there are two main types of data storage:

#### 1. Disk Storage (Long-term Memory)
* **Definition:** Disk storage is where data is stored permanently. 
* **Pros/Cons:** It has a very high capacity to hold massive amounts of data, but it is slow to read and write compared to cache.
* Disk storage is divided into 3 main areas depending on their purpose:
  1. **User Data Storage:** This is the main content of the database. It stores the actual data that the user cares about (e.g., all the information in your `customer` or `orders` tables). This is the storage the user actively interacts with.
  2. **System Catalog Storage (Metadata):** This is the database's internal storage for its own information. It is a blueprint that keeps track of everything about the database itself (not the user data). Its main purpose is to hold the **Metadata** (Data about Data). 
     * *Example:* If you create a `customer` table, the Database doesn't just store the user data. It also stores metadata like `tableName`, `columnName`, `dataTypes`, length, and constraints in the System Catalog.
     * *Information Schema:* All this metadata is stored in a special, built-in schema called the **`INFORMATION_SCHEMA`**. It contains views that help us find information about our tables. (e.g., `SELECT * FROM INFORMATION_SCHEMA.COLUMNS;`).
  3. **Temporary Data Storage:** Temporary space used by the database for short-term tasks like processing complex queries or sorting data. Once the task is done, this storage is cleared.

#### 2. Cache Storage (Short-term Memory)
* **Definition:** Cache is fast, short-term memory (like RAM) where data is stored temporarily.
* **Pros/Cons:** It can only store smaller amounts of data (lower capacity), but it is extremely fast to read and write.

### 36.4 How a Simple Query Works (Step-by-Step)
* **Image Reference:** ![Query Execution Flow](./svg_query_execution_flow.svg) *(Description: Shows the flow of a query: Client -> Engine -> Cache [MISS] -> Disk -> Return Result & Store in Cache).*

When a Data Engineer writes a query like `SELECT * FROM orders`:
1. **Send Query:** The query is sent from the Client side to the Database Server.
2. **Check Cache (Fast Path):** The Database Engine takes the query and first checks the **Cache Storage**. Because cache is extremely fast, if the information is already there, the engine solves the task instantly.
3. **Check Disk (Slow Path):** If the query information is NOT in the cache, the Database Engine says, *"Query data is not in cache, let's check Disk Storage."* It finds the relevant table in the User Data Storage and executes the query.
4. **Return Result:** The result of the query is sent back to the Client side. 
* *Note:* Once the result is fetched from the disk, the Database Engine will also store it in the Cache so that if someone runs the exact same query again, it returns instantly!
* **Hindi (मराठी/हिंदी सारांश):** जब आप कोई क्वेरी चलाते हैं, तो डेटाबेस इंजन सबसे पहले "Cache" (रैम) में डेटा ढूंढता है क्योंकि वह बहुत तेज़ होता है। अगर डेटा Cache में नहीं मिलता, तो वह "Disk" (हार्ड ड्राइव) में जाता है, डेटा लाता है, क्लाइंट को आउटपुट दिखाता है, और फिर उसे Cache में सेव कर लेता है ताकि अगली बार वो तुरंत मिल जाए!

---

## Topic 37: Subqueries Deep Dive (Nested Queries)

### 37.1 What is a Subquery?
* **Definition:** A subquery is a SQL query that is written *inside* another query. It is also known as an **Inner Query** or a **Nested Query**. 
* **The Structure:**
  1. The outer query is called the **Main Query**.
  2. The inside query is called the **Subquery** (or Nested Query).
* **Hindi (मराठी/हिंदी सारांश):** सबक्वेरी (Subquery) का मतलब है "एक क्वेरी के अंदर दूसरी क्वेरी"। जो क्वेरी बाहर होती है उसे Main Query कहते हैं, और जो अंदर होती है उसे Subquery कहते हैं।

### 37.2 How Subqueries Work (The Execution Flow)
* **Image Reference:** ![Subquery Flow](./svg_subquery_flow.svg) *(Description: Shows the DB Tables sending data to the Inner SubQuery, which creates an intermediate result, which is then used by the Main Query to produce the Final Result).*
* Subqueries act as an embedded query. SQL executes them in a specific order (Usually from Right to Left, or Innermost to Outermost).
* **Step-by-step Flow:**
  1. **Inner Query Runs First:** SQL executes the subquery first. It retrieves data from the database.
  2. **Intermediate Result:** The result of the subquery is NOT shown directly to the user. Instead, it becomes a temporary (intermediate) dataset stored in memory.
  3. **Main Query Takes Over:** The main query uses this intermediate result to perform operations like Filtering (`WHERE`), Joining, Ordering, or Aggregation.
  4. **Final Output:** The main query merges its own table data with the subquery's result to produce the final output for the user.

### 37.3 Why are Subqueries Important? (When to use them)
* **Image Reference:** ![Subquery Nesting](./svg_subquery_nesting.svg) *(Description: Shows Main Query, SubQuery, and Nested Subquery wrapped like Russian Dolls).*
* **Use Cases:**
  * To filter data based on values calculated from another table.
  * To perform aggregations (like `MAX`, `AVG`) and use that aggregated value in a `WHERE` condition.
  * To simplify complex logic step-by-step and avoid confusing `JOIN` operations.
* **Importance:**
  * They break down complex problems into smaller, manageable chunks.
  * They allow writing cleaner and more readable SQL.
  * They prevent the need for creating physical Temporary Tables.
* **Where can they be used?**
  * In the `SELECT` clause (to return a calculated value).
  * In the `FROM` clause (used as a temporary table/derived table).
  * In the `WHERE` clause (to filter based on another query).
  * In the `HAVING` clause (to filter after a `GROUP BY`).

### 37.4 The Golden Rules of Subqueries
1. The **inner query** runs first, and its result is passed to the **outer query**.
2. A subquery must be enclosed in parentheses `()`.
3. **No DML Inside:** By design, a subquery **cannot** perform DML (`INSERT`, `UPDATE`, `DELETE`) operations inside it. It must produce a result set (rows/columns or a single value). *Example of what NOT to do: `SELECT * FROM (DELETE FROM employees);` (This will fail).*
4. The **outer query** depends on the result of the inner query. The outer query *can* be an `INSERT`, `UPDATE`, or `DELETE` statement.

#### Using Subqueries with DML (Outer Query)
* **INSERT with Subquery:**
  ```sql
  INSERT INTO high_salary_emps (emp_id, name, salary)
  SELECT id, name, salary FROM employees 
  WHERE salary > (SELECT AVG(salary) FROM employees);
  ```
* **UPDATE with Subquery:**
  ```sql
  UPDATE employees SET bonus = 1000 
  WHERE dept_id IN (SELECT id FROM departments WHERE location = 'New York');
  ```
* **DELETE with Subquery:**
  ```sql
  DELETE FROM employees 
  WHERE dept_id = (SELECT id FROM departments WHERE dept_name = 'ClosedDept');
  ```
* **Hindi (मराठी/हिंदी सारांश):** सबक्वेरी हमेशा पहले रन होती है (अंदर से बाहर की तरफ)। सबक्वेरी के अंदर आप `INSERT/UPDATE/DELETE` नहीं चला सकते, क्योंकि उसे सिर्फ एक डेटा/वैल्यू वापस (Return) करनी होती है। हाँ, आप Main (Outer) क्वेरी में `UPDATE` या `DELETE` यूज़ कर सकते हैं!

### 37.5 Subquery Classification (Types of Subqueries)
* **Image Reference:** ![Subquery Classification](./svg_subquery_classification.svg) *(Description: Shows the classification by Result Types, Dependency, and Location).*

Subqueries can be categorized in three different ways:

#### A. Based on DEPENDENCY (Connection to Main Query)
1. **Non-Correlated Subquery:** 
   * The subquery is completely independent of the outer query. It executes only **ONCE**, and the result is passed to the outer query. This is the most common type.
2. **Correlated Subquery:** 
   * The subquery totally depends on the main query. It is executed **ONCE FOR EACH ROW** processed by the outer query. It is used when comparing values within a group or partition.

#### B. Based on RESULT TYPE (What the Inner Query Returns)
1. **Scalar Subquery (Single-Row, Single-Column):**
   * Returns exactly **one single value** (one row and one column). Often used in `SELECT` or `WHERE` with operators like `=`, `<`, `>`.
   * *Example:* Find all employees who earn more than the average salary.
     ```sql
     SELECT name, salary FROM employees
     WHERE salary > (SELECT AVG(salary) FROM employees);
     ```
2. **Row Subquery (Single-Row, Multiple-Columns):**
   * Returns a **single row but multiple columns**. Used with operators like `=`, `IN`, or row-value comparison.
   * *Example:* `WHERE (col1, col2) = (SELECT col1, col2 FROM table LIMIT 1);`
3. **Table Subquery (Multiple-Rows, Multiple-Columns):**
   * Returns multiple rows and columns (looks like a table). It is heavily used in the `FROM` clause (also known as a Derived Table) or with the `IN` operator.
   * *Example:* `SELECT * FROM (SELECT id, name FROM employees) AS temp_table;`

#### C. Based on LOCATION / CLAUSES
1. **SELECT clause**
2. **FROM clause** (Creates a derived table)
3. **JOIN clause**
4. **WHERE clause:** This is the most common place. Operations here are split into two types:
   * **Comparison Operators:** `<`, `>`, `=`, `!=`, `<=`, `>=` (Used with Scalar subqueries).
   * **Logical Operators:** `IN`, `ANY`, `ALL`, `EXISTS` (Used with Row or Table subqueries).

---

## Topic 38: Subqueries Advanced (Clauses, Operators & Execution)
* **Image Reference (Notebook Summary):** ![Subquery Summary](./svg_subquery_summary_notebook.svg) *(Description: Notebook page summarizing Subquery use cases like filtering, JOIN preparation, EXISTS, and Correlated row-by-row comparisons).*

### 38.1 Subqueries by Location (Clauses)
* **Image Reference:** ![Location Clauses](./svg_subquery_location_clauses.svg) *(Description: Tree diagram showing subqueries in SELECT, FROM, JOIN, and WHERE. WHERE is split into Comparison and Logical operators).*

A subquery can be placed in different parts of a SQL statement. Depending on where it is placed, its behavior and rules change.

#### 1. In the `FROM` Clause (Derived Tables)
* **Image Reference:** ![FROM Clause Execution](./svg_subquery_from_execution.svg) *(Description: Shows Main Query wrapping a Subquery acting as a temporary table).*
* **How it works:** A subquery in the `FROM` clause acts as a **temporary table** (also called a Derived Table) that the main query can `SELECT` from.
* **Rule:** It MUST return a table (Multiple Rows/Columns) and MUST have an alias (e.g., `AS temp_table`).
* **Example 1: Compare with Average:**
  ```sql
  -- Find products that have a price higher than the average price of all products.
  SELECT * FROM (
      SELECT product, price, AVG(price) OVER() AS avg_price 
      FROM PRODUCTS
  ) AS ProdTemp
  WHERE price > avg_price;
  ```
* **Example 2: Ranking (Window Functions):**
  ```sql
  -- Rank customers based on their total amount of sales
  SELECT *, RANK() OVER(ORDER BY total_sales DESC) AS sales_rank
  FROM (
      SELECT customerid, SUM(sales) AS total_sales FROM ORDERS GROUP BY customerid
  ) AS OrderSummary;
  ```

#### 2. In the `SELECT` Clause
* **Image Reference:** ![SELECT Clause Execution](./svg_subquery_select_execution.svg) *(Description: Shows Main Query with a Subquery inside the SELECT statement, requiring a scalar value).*
* **How it works:** Used to aggregate or calculate a value side-by-side with the main query’s normal columns, allowing for direct comparison.
* **👿 RULE (Very Important):** **ONLY Scalar Subqueries** (returning exactly 1 Row and 1 Column) are allowed in the `SELECT` clause!
* **Example:**
  ```sql
  -- Show product IDs, names, prices, and the total number of orders in the DB side-by-side
  SELECT productid, product, price,
         (SELECT COUNT(*) FROM ORDERS) AS total_orders 
  FROM PRODUCTS;
  ```

#### 3. In the `JOIN` Clause
* **How it works:** Used to prepare the data (filtering or aggregating) *before* joining it with another table.
* **👿 RULE:** The subquery must be given an Alias and added inside the `JOIN ... ON` condition as a temporary table.
* **Example:**
  ```sql
  -- Show all customer details and find the total orders for each customer
  SELECT c.customerid, c.firstname, c.lastname, COALESCE(t.total_order, 0) AS total_orders
  FROM CUSTOMERS c
  LEFT JOIN (
      SELECT customerid, COUNT(orderid) AS total_order FROM ORDERS GROUP BY customerid
  ) AS t
  ON c.customerid = t.customerid;
  ```

### 38.2 Subqueries in the `WHERE` Clause (Filtering)
This is the most common place for a subquery. It uses two groups of operators:
* **Image Reference:** ![Where Filtering](./svg_subquery_where_filtering.svg) *(Description: Compares '=' needing scalar subqueries vs 'IN' needing list/row subqueries).*

#### A. Comparison Operators (`>`, `<`, `>=`, `<=`, `=`, `!=`)
* **Image Reference:** ![WHERE Comparison](./svg_subquery_where_comparison.svg) *(Description: Shows a scalar subquery used with a comparison operator).*
* Used to filter data by comparing a column to a **Single Value**.
* **👿 RULE:** The subquery MUST be a **Scalar Subquery** (Return exactly 1 value).
* **Example:**
  ```sql
  SELECT product, price FROM products
  WHERE price > (SELECT AVG(price) FROM products);
  ```

#### B. Logical Operators (`IN`, `ANY`, `ALL`, `EXISTS`)
* Used to filter data against a **List of Values** (Row or Table Subquery).

1. **`IN` Operator:** Checks if a value exists anywhere inside the list returned by the subquery.
   * **Image Reference (Syntax):** ![WHERE IN Syntax](./svg_subquery_where_in.svg)
   * **Image Reference (Execution Flow):** ![WHERE IN Flow](./svg_subquery_where_in_flow.svg) *(Description: Shows data flowing from Customers table subquery to intermediate array, and then to Main Query and Orders final result).*
   ```sql
   -- Show orders made by customers in Germany
   SELECT * FROM ORDERS 
   WHERE customerid IN (SELECT customerID FROM CUSTOMERS WHERE country = 'Germany');

   -- Show the details of orders of customers which are NOT in Germany
   SELECT * FROM ORDERS 
   WHERE customerid NOT IN (SELECT customerID FROM CUSTOMERS WHERE country = 'Germany');
   ```
2. **`ANY` Operator:** Checks if the condition is TRUE for **at least ONE** of the values in the list.
   * **Image Reference:** ![WHERE ANY Syntax](./svg_subquery_where_any.svg)
   ```sql
   -- Find female employees whose salary is greater than ANY male employee's salary
   SELECT salary, firstname, lastname FROM EMPLOYEES 
   WHERE gender = 'F' AND salary > ANY (SELECT salary FROM EMPLOYEES WHERE gender = 'M');
   ```
3. **`ALL` Operator:** Checks if the condition is TRUE for **ALL** the values in the list.
   ```sql
   -- Find female employees whose salary is greater than ALL male employees (highest earner)
   SELECT salary, firstname, lastname FROM EMPLOYEES 
   WHERE gender = 'F' AND salary > ALL (SELECT salary FROM EMPLOYEES WHERE gender = 'M');
   ```
4. **`EXISTS` Operator:** Checks if the subquery returns **any rows at all**. It does not compare values; it just checks for *existence* (TRUE/FALSE).
   * **Image Reference:** ![WHERE EXISTS Syntax](./svg_subquery_where_exists.svg) *(Description: Shows correlated subquery using Table2 from the Main Query inside the Subquery).*
   * **Image Reference (Flowchart):** ![How EXISTS Works](./svg_subquery_exists_flowchart.svg) *(Description: Flowchart explaining the Yes/No logic of EXISTS).*
   * **Behind the scenes:** For each row in the main query, it runs the subquery. If the subquery returns a result, the main query row is included in the final output. If the subquery returns nothing, the main row is excluded.
   ```sql
   -- Show orders made by customers in Germany using EXISTS
   SELECT * FROM ORDERS o 
   WHERE EXISTS (
       SELECT 1 FROM CUSTOMERS c WHERE c.country = 'Germany' AND o.customerid = c.customerID
   );

   -- Show the details of orders made by customers NOT in Germany
   SELECT * FROM ORDERS o 
   WHERE NOT EXISTS (
       SELECT 1 FROM CUSTOMERS c WHERE c.country = 'Germany' AND o.customerid = c.customerID
   );
   ```

### 38.3 Correlated vs Non-Correlated Subqueries (Execution Behind the Scenes)
* **Image Reference:** ![Server Execution](./svg_subquery_server_execution.svg) *(Description: Shows Client sending query, Database Engine fetching Subquery from Disk, caching it, and returning the Final Result).*
* **Image Reference (Dependency):** ![Dependency Tree](./svg_subquery_dependency_tree.svg)
* **Image Reference (Execution Loop):** ![Execution Loop](./svg_subquery_execution_loop.svg) *(Description: Shows Correlated looping vs Non-Correlated linear execution).*

#### 1. Non-Correlated Subquery (Independent)
* **Execution:** It runs completely independently. It is executed **first**, stores its intermediate result in memory (cache/temporary table). Then the main query runs **ONCE** using that cached result.
* **Cache Cleanup:** Once the execution is done and the final result is sent to the client, the database engine cleans up the cache and destroys the subquery's temporary result so it is ready to execute another query.
* **Performance:** Very fast. It executes exactly once.

#### 2. Correlated Subquery (Dependent)
* **Execution:** The inner query depends on the outer query (it references a column from the outer query). It cannot run independently.
* **How it works behind the scenes:** 
  1. SQL starts executing the main query.
  2. SQL processes the main query **Row by Row**.
  3. For the **first row**, the main query passes a value to the subquery. The subquery executes and returns a result to the main query.
  4. The main query checks the result and decides whether to keep the row.
  5. The cycle repeats for the **second row**, **third row**, etc.
* **Performance:** Very Slow! If the main query has 1 million rows, the subquery will be executed 1 million times! (Iteration).
* **Example (Correlated):**
  ```sql
  SELECT *, (
      SELECT COUNT(*) FROM ORDERS o WHERE o.customerid = c.customerid
  ) AS order_count
  FROM CUSTOMERS c;
  ```

### 38.4 JOIN vs SUBQUERY (Interview Comparison)

| Feature | JOIN | SUBQUERY |
| :--- | :--- | :--- |
| **Purpose** | Combines data from two or more tables into a single result set. | A query inside another query, used to pass intermediate results. |
| **Execution** | Tables are combined first, then filtering/selection is applied. | Inner query executes first, result is passed to outer query. |
| **Performance** | Usually **faster** and more efficient for large datasets (uses Indexes and Hash/Loop algorithms). | Sometimes **slower** (especially Correlated subqueries which run row-by-row). |
| **Readability** | More readable when pulling columns from multiple related tables. | Easier to understand for simple filtering (e.g., finding the `MAX` or `AVG`). |
| **Load Distribution**| Maximizes the calculation burden on the database Engine. | Keeps the responsibility on calculation logic (step-by-step). |
| **Types** | INNER, LEFT, RIGHT, FULL, CROSS, SELF. | Scalar, Row, Table, Correlated, Non-Correlated. |

* **Interview Tip:** Always prefer a `JOIN` over a `Correlated Subquery` for better performance. However, modern SQL Optimizers are smart enough to automatically convert many subqueries into Joins behind the scenes!

### 38.5 Key Points & Summary
* A subquery is a query inside another query that helps break complex logic into smaller, manageable queries. It makes the code easier to understand and more readable.
* A subquery **MUST** always be enclosed in parentheses `()`.
* Subqueries can be used in the `SELECT`, `FROM`, `WHERE`, and `HAVING` clauses.
* Subqueries can also use aggregate functions like `SUM()`, `AVG()`, etc.
* **Return Types:** Subqueries can return:
  1. A Single value (Scalar Subquery)
  2. A List of values (Row/List Subquery)
  3. A Table / Result Set (Table Subquery)

* **Hindi (मराठी/हिंदी सारांश):** 
  * **Location Rules:** `SELECT` में सिर्फ़ 1 वैल्यू वाली सबक्वेरी चलेगी। `FROM` में टेबल वाली सबक्वेरी चलेगी जिसे Alias देना ज़रूरी है। 
  * **Operators:** `=` या `>` के साथ 1 वैल्यू आनी चाहिए। `IN`, `ANY`, `ALL` के साथ लिस्ट आ सकती है। `EXISTS` सिर्फ़ ये चेक करता है कि अंदर से डेटा मिला या नहीं (True/False)।
  * **Correlated vs Non-Correlated:** Non-Correlated एक ही बार रन होती है (फ़ास्ट)। Correlated हर एक रो (Row) के लिए बार-बार रन होती है (स्लो)। इसलिए इंटरव्यू में हमेशा `JOIN` को बेहतर परफॉरमेंस वाला माना जाता है!

---

## Topic 39: Common Table Expressions (CTE)

### 39.1 What is a CTE? (Definition & Concept)
* **CTE = Common Table Expression**.
* **In Short:** It is a temporary, named result set (a "virtual table") that you can reference within a `SELECT`, `INSERT`, `UPDATE`, or `DELETE`.
* **Purpose:** It allows you to create a named, reusable subquery within your SQL statement to simplify and organize complex queries, making them much more readable.
* **Duration:** It exists **only** during the execution of that specific query. It is not stored permanently in the database like a regular table or view.
* **Keyword:** CTEs are defined using the `WITH` keyword.

**Key Features of a CTE Table:**
1. **Short-Lived:** This table does not live long. Once the query ends, the temporary CTE table is destroyed.
2. **Not Available Later:** It is not available after the query execution is done.
3. **Cannot Re-Query:** You are not able to query it again in a separate new query.

#### How CTE Works (Behind the Scenes)
* **Image Reference:** ![Simple vs CTE Execution](./svg_cte_architecture.svg) *(Description: Compares Normal Query accessing DB vs CTE creating a virtual table first, then main query using it).*

* **In a Normal Query:** We have a database with multiple tables, and we write a simple query to retrieve data and get a result.
* **In a CTE:** We have a query inside another query. The new inner query is named the "CTE Query", and the outer query is the "Main Query". Here is exactly what happens step-by-step:
  1. **CTE Query Executes First:** SQL goes and executes the CTE query first to retrieve information from the database tables.
  2. **Intermediate Virtual Table:** The output is made available only to the query, shaped exactly like a table. This output is temporarily stored in **high-speed cache memory**.
  3. **Main Query Dual Sourcing:** The Main Query can now act on this virtual table as if it were a real database table. In fact, the Main Query can pull data from **two sources simultaneously**:
     * **Source 1:** Get data directly from the actual database tables.
     * **Source 2:** Get data from the virtual table created by the CTE.
  4. **Final Result:** The Main Query retrieves and processes everything (utilizing the high-speed cache memory for the CTE, which is way faster than disk storage), and the final result is presented to the user.
  5. **Destruction:** Once everything is done, the CTE table has finished its task and is immediately removed/destroyed.

### 39.2 CTE vs Regular Subquery
* **Image Reference:** ![Subquery vs CTE](./svg_cte_vs_subquery.svg) *(Description: Shows Subquery executing Bottom-Up with nesting, while CTE executes Top-Down for better readability).*

#### Why use CTE instead of Subquery? (Benefits)
* **Image Reference (Benefits):** ![CTE Benefits](./svg_cte_benefits.svg) *(Description: Shows how CTE gives Readability, Modularity, and Reusability).*
* **Image Reference (Execution Steps):** ![Subquery vs CTE Steps](./svg_cte_steps_comparison.svg) *(Description: Shows Subquery doing redundant JOINs vs CTE doing JOIN once and reusing it).*
* **Readability:** Subqueries get messy when nested deeply. CTEs break the query into smaller, logical steps (Top-to-Bottom flow).
* **Reusability & Avoid Redundancy:** A Subquery can only be used once. A CTE can be joined and referenced multiple times in the same main query. If you need the same aggregated data in step 2 and step 4, doing it with subqueries repeats the JOINs and work. CTE does it once.
* **Modularity & Debugging:** Breaks huge queries into small, self-contained chunks. You can easily test and debug each CTE part separately.
* **When to STILL use Subqueries:** 
  1. For very simple one-liners (e.g., `WHERE salary > (SELECT AVG(salary)...`). 
  2. **Correlated Subqueries:** If the inner query depends on the outer query dynamically (row-by-row), you *must* use a Subquery. CTEs cannot be correlated to the main query row-by-row.

### 39.3 Types of CTEs
* **Image Reference:** ![CTE Types](./svg_cte_types_tree.svg) *(Description: Tree diagram showing Non-Recursive (Standalone, Nested) and Recursive CTEs).*

#### 1. Non-Recursive CTE
A Non-Recursive CTE is a query that runs independently from the main query, executing **only once** without any repetition or looping. There are mainly two types under this category: Standalone CTE and Nested CTE.

---
##### A. Standalone CTE
* **Definition:** A Standalone CTE is defined and used independently in the query. It runs independently as a self-contained unit and doesn't rely on any other CTE or query.
* **Explanation:** If you have a CTE, it queries the database tables and outputs an intermediate result. This output is then used by the main query. The CTE itself is completely independent from anything else.
* **Image References:** 
  * ![Standalone Flow](./svg_cte_standalone_flow.svg) *(Description: DB -> CTE Query -> Intermediate Result -> Main Query -> Final Result)*
  * ![CTE Syntax](./svg_cte_syntax.svg) *(Description: Highlights CTE Definition vs CTE Usage)*

* **Syntax & Example:**
  ```sql
  -- CTE Definition (Query)
  WITH TOTAL_SALES AS (
      SELECT customerID, SUM(SALES) AS TOTAL_SALES FROM ORDERS GROUP BY customerID
  )
  -- Main Query (Usage)
  SELECT c.FIRSTNAME, cte.TOTAL_SALES FROM customers c
  LEFT JOIN TOTAL_SALES cte ON cte.customerid = c.customerid;
  ```

##### B. Multiple Standalone CTEs
* **Definition:** You can define multiple independent CTEs in a single query separated by commas.
* **Important Rule:** If you have multiple CTEs, only the **first** CTE takes the `WITH` keyword. Subsequent CTEs are just separated by a comma `,`.
* **Image Reference:** ![Multiple CTE Syntax](./svg_cte_multiple_syntax.svg) *(Description: Showing WITH CTE1, CTE2 format)*

* **Syntax & Example:**
  ```sql
  -- Q1. Find total sales and last order date per customer
  WITH TOTAL_SALES AS (
      SELECT customerID, SUM(SALES) AS TOTALCUSTOMERSSALES 
      FROM ORDERS GROUP BY customerID
  ), -- Comma separates multiple CTEs (No second WITH)
  LAST_ORDERS_DATE AS (
      SELECT customerid, MAX(ORDERDATE) AS LAST_ORDER 
      FROM ORDERS GROUP BY customerid
  )
  SELECT c.FIRSTNAME, c.LASTNAME, c.customerID, 
         cte.TOTALCUSTOMERSSALES, newcte.LAST_ORDER
  FROM customers c
  LEFT JOIN TOTAL_SALES cte ON cte.customerid = c.customerid
  LEFT JOIN LAST_ORDERS_DATE newcte ON newcte.customerid = c.customerid;
  ```
  *(Note: `ORDER BY` inside a CTE is ignored in MySQL unless combined with a `LIMIT` clause. Always sort in the final main query instead).*

---
##### C. Nested CTE (Dependent)
* **Definition:** A Nested CTE is a CTE inside another CTE (or a query that depends on another query). 
* **Explanation:** The main query doesn't just use the result of a CTE directly; instead, **another CTE** can use the result of a previous CTE. This means the CTEs are dependent. You cannot run the dependent CTE independently; you must run the parent CTE first.
* **Image References:** 
  * ![Nested Flow](./svg_cte_nested_flow.svg) *(Description: DB -> #1 CTE -> #2 CTE -> Main Query)*
  * ![Nested Syntax](./svg_cte_nested_syntax.svg) *(Description: CTE-Name2 selects from CTE-Name1)*

* **Syntax & Example (Complex Nested Pipeline):**
  ```sql
  WITH TOTAL_SALES AS (
      -- CTE 1: Base Aggregation
      SELECT customerID, SUM(SALES) AS TOTALCUSTOMERSSALES 
      FROM ORDERS GROUP BY customerID
  ), 
  CUSTOMER_SEGMENTS AS (
      -- CTE 2: Nested! Reads from TOTAL_SALES
      SELECT customerid, TOTALCUSTOMERSSALES,
      CASE 
          WHEN TOTALCUSTOMERSSALES > 100 THEN 'HIGH'
          WHEN TOTALCUSTOMERSSALES > 50 THEN 'MEDIUM'  
          ELSE 'LOW'
      END AS SEGMENT
      FROM TOTAL_SALES
  ), 
  RANK_PER_CUSTOMER AS (
      -- CTE 3: Nested! Reads from TOTAL_SALES
      SELECT customerid, 
             RANK() OVER(ORDER BY TOTALCUSTOMERSSALES DESC) AS RANK_CUSTOMERS
      FROM TOTAL_SALES
  )
  -- Main Query brings it all together
  SELECT c.FIRSTNAME, c.customerID, cs.SEGMENT, r.RANK_CUSTOMERS
  FROM customers c
  LEFT JOIN CUSTOMER_SEGMENTS cs ON cs.customerid = c.customerid
  LEFT JOIN RANK_PER_CUSTOMER r ON r.customerid = c.customerid;
  ```
---

#### 2. Recursive CTE (Looping)
* **Definition:** A Recursive CTE is a query that repeatedly runs or loops over itself until a given condition is met.
* **Explanation:** It is widely used to navigate through hierarchical data (like Manager-Employee relations, Category trees, Graph nodes) or to generate a sequential series of numbers/dates.
* **Image References:** 
  * ![Recursive Flow Concept](./svg_cte_recursive_concept.svg) *(Description: Anchor Query flowing directly into a looping Recursive Query block).*
  * ![Recursive Syntax Breakdown](./svg_cte_recursive_syntax2.svg) *(Description: Detailed syntax showing Anchor Query, UNION ALL, Recursive Query, and Break Condition).*

**Execution Flow (How it loops):**
1. **Anchor Query (Start):** The base query. It runs only once and provides the initial starting dataset.
2. **UNION ALL:** Connects the Anchor to the Recursive Query. It combines the results of the two without deduplicating (which keeps performance high).
3. **Recursive Query (Loop):** The query that refers back to the CTE itself. It keeps looping and generating new rows.
4. **Termination (End):** The loop breaks when the Recursive Query produces an empty result set (0 rows). The final result is then passed to the Main Query.

---
##### Example 1: Number Sequence Generation (1 to 20)
* **Image Reference:** ![Number Flowchart](./svg_cte_recursive_number_flow.svg) *(Description: Flowchart showing the exact looping mechanism of creating numbers from 1 to 20).*

```sql
WITH RECURSIVE SERIES AS (
    -- Anchor Query
    SELECT 1 AS MyNumber
    UNION ALL
    -- Recursive Query (Loops)
    SELECT MyNumber + 1 FROM SERIES WHERE MyNumber < 20
)
-- Main Query
SELECT * FROM SERIES; 
```
*(Note: MySQL handles recursion limits using the `cte_max_recursion_depth` variable, default is 1000. SQL Server uses `OPTION (MAXRECURSION n)`).*

---
##### Example 2: Employee Hierarchy Navigation
* **Image Reference:** ![Hierarchy Flow](./svg_cte_recursive_hierarchy.svg) *(Description: Flowchart matching the Employee-Manager table logic, generating a Top-Down Hierarchy tree: Frank -> Kevin -> Michael).*

```sql
WITH RECURSIVE CTE_Emp_Hierarchy AS (
    -- 1. Anchor Query (Find Top-Level Managers / CEO)
    SELECT EmployeeID, FirstName, ManagerID, 1 AS Level
    FROM Sales.Employees 
    WHERE ManagerID IS NULL
    
    UNION ALL
    
    -- 2. Recursive Query (Find subordinates of the managers found above)
    SELECT e.EmployeeID, e.FirstName, e.ManagerID, ceh.Level + 1
    FROM Sales.Employees AS e
    INNER JOIN CTE_Emp_Hierarchy ceh ON e.ManagerID = ceh.EmployeeID
)
-- 3. Main Query (View entire org chart)
SELECT * FROM CTE_Emp_Hierarchy;
```

---
##### Recursive CTE Q&A (Interview Perspectives)
* **What is the purpose of the Anchor Member?**
  1. **Initialization:** It defines the base result set ("Where do I start?") from which recursion starts.
  2. **Guarantees Termination:** Without the anchor, the query wouldn't know where to begin and would either fail or run infinitely.
* **Analogy:** Think of recursion like **climbing a ladder**. The Anchor member is planting your feet on the first rung. The Recursive member is climbing up one step at a time.
* **Why use UNION ALL instead of UNION?**
  * `UNION ALL` simply appends rows. It is much **faster** because no duplicate check is required.
  * `UNION` performs a deduplication (`DISTINCT`) at every step, which requires extra work and is **slower**. It may also accidentally filter out valid paths (e.g., matrix management where a person reports to two managers).
* **Can a Recursive CTE call itself more than once?**
  * **Yes.** While normally it calls itself once, in complex graph traversals (like walking forward and backward), you can reference the CTE multiple times using multiple `UNION ALL` statements.
* **Can we write a Recursive CTE without an Anchor Member?**
  * **No.** It will throw a syntax error or loop infinitely because there is no starting dataset.

### 39.4 CTE vs Derived Table

| Feature | Derived Table (Subquery in FROM) | CTE (WITH Clause) |
| :--- | :--- | :--- |
| **Definition** | A subquery written directly inside the `FROM` clause. | Declared at the top using `WITH`. Acts like a temporary view. |
| **Reusability** | Cannot be reused. If you need it again, you must rewrite it. | Can be referenced multiple times in the main query. |
| **Recursion** | Does not support recursion. | Supports Recursive querying (Hierarchies). |
| **Readability** | Becomes very messy if nested deeply. | Clean, Top-to-Bottom logical flow. |

### 39.5 CTE Summary & Best Practices
* **Image Reference:** ![CTE Summary Diagram](./svg_cte_summary.svg) *(Description: Complete summary of CTEs, including Advantages, Rules, and Flow diagrams for Standalone, Nested, and Recursive CTEs).*

**What is a CTE?**
* Common Table Expression (CTE) is a **Temporary, named result set** that can be used **multiple times** within the query.
* **Important Rule:** The result of a CTE is like a Table, **but it can't be used from multiple queries** (it only exists for the duration of the query it is defined in).

**Advantages of using CTEs:**
1. **Readability:** Breaks down Complex Queries into smaller Pieces.
2. **Modularity:** Pieces are easy to manage, develop, and self-contained.
3. **Reusability:** Reduce redundancy in Query by reusing the same CTE.
4. **Recursive:** Enables iterations & looping in SQL for hierarchical data.

> [!TIP]
> **Don't** create more than **5** CTEs in One Query. Doing so will make the query extremely difficult to maintain and could impact performance.

* **Hindi (मराठी/हिंदी सारांश) & Interview Pointers:** 
  * **CTE क्या है?:** CTE (Common Table Expression) एक वर्चुअल (Temporary) टेबल है। यह सिर्फ उसी क्वेरी के रन होने तक हाई-स्पीड (High-speed cache) मेमोरी में रहता है। इसे `WITH` कीवर्ड से लिखते हैं। 
  * **Behind the Scenes (Execution):** 
    - CTE पहले रन होकर अपना रिजल्ट हाई-स्पीड कैश (cache) में स्टोर करता है।
    - फिर Main Query दो जगह से डेटा उठाती है: **Database Table (Slow)** + **CTE Cache (Fast)**। इसे **Dual Sourcing** कहते हैं।
  * **फायदा:** एक ही सबक्वेरी को बार-बार लिखने (Redundancy) से बचाता है। Subquery हर बार रन होकर स्लो होती है, लेकिन CTE एक बार रन होकर आप उसे Main Query में कई बार अलग-अलग जगह JOIN कर सकते हैं।
  * **Types (प्रकार):** 
    1) **Non-Recursive:** जो एक बार रन होता है।
       - **Standalone CTE:** जो अकेला हो, सीधा डेटाबेस से डेटा लाता हो।
       - **Multiple Standalone CTE:** एक ही क्वेरी में कॉमा (`,`) लगाकर कई आज़ाद CTEs बनाना (सिर्फ पहले वाले में `WITH` लगता है)।
       - **Nested CTE:** जब एक CTE दूसरे CTE के डेटा पर डिपेंड हो। (जैसे Pipeline: Sales -> Segments -> Rank)।
    2) **Recursive (Looping):** जो लूप में तब तक रन होता है जब तक कंडीशन ख़त्म न हो जाए (जैसे एम्प्लोयी-मैनेजर ट्री या Number Sequence)।
  * **Recursive Rules & Interview Tricks:** 
    - **Anchor Member:** यह सीढ़ी (Ladder) का पहला कदम (First Rung) है। यह स्टार्टिंग पॉइंट सेट करता है, वरना क्वेरी infinite loop में फँस जाएगी।
    - **UNION ALL:** हम Anchor और Recursive को जोड़ने के लिए हमेशा `UNION ALL` यूज़ करते हैं। अगर `UNION` यूज़ किया, तो वह हर स्टेप पर डुप्लीकेट चेक करेगा (DISTINCT) और बहुत स्लो हो जाएगा!
    - **Can it call itself multiple times?:** हाँ! कॉम्प्लेक्स ग्राफ के लिए एक CTE खुद को कई बार कॉल कर सकता है (Forward and Backward)।

---

## Topic 40: Database Import & Export (CSV, SQL Dumps)

### 40.1 Working with CSV Files
* **CSV:** Stands for **Comma Separated Value**.
* **Rule of CSV Imports:** The table schema must exactly match the CSV file. Columns in the table must correspond (in number, order, and data type) to the values in the CSV. (e.g., If CSV has `id, name, salary`, the table must have the exact same structure).

#### CSV Format Rules
1. **Delimiter:** Usually a comma (`,`), but it could be `;` or `\t` (Tab). You must specify it.
2. **Quotes:** Text values may be enclosed in double-quotes `"`.
3. **Header Row:** If the file has column headers at the top, you must use `IGNORE 1 ROWS` during the import.
4. **Line Endings:** Should match the operating system (`\n` for Linux/Mac, `\r\n` for Windows).

#### File Location Rules & Privileges
* **Server Machine (`LOAD DATA INFILE`):** If you omit the word `LOCAL`, MySQL expects the file to be on the server. The file must be placed in a directory allowed by the MySQL variable `secure_file_priv`. You also need the `FILE` privilege (`GRANT FILE ON *.* TO 'username'@'localhost';`).
* **Local Machine (`LOAD DATA LOCAL INFILE`):** If the file is on your personal client machine (your laptop), you use `LOCAL`. 
* **Handling NULL & Constraints:** Empty fields in CSV may become `NULL` if allowed. If the table has a Primary Key or Unique constraint, duplicates in the CSV will cause errors (unless the `IGNORE` keyword is used in the query).

### 40.2 Importing Data into MySQL
#### Method 1: Using `LOAD DATA INFILE` (Fastest Way)
MySQL has a built-in command to directly import CSV into a table extremely fast.

* **Scenario:** You have a file `employees.csv` (`id, name, salary, dept_id`).
```sql
CREATE TABLE employees (
  id INT,
  name VARCHAR(100),
  salary DECIMAL(10,2),
  dept_id INT
);

-- Importing the file
LOAD DATA INFILE '/path/to/employees.csv'
INTO TABLE employees
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
```
* **Explanation:**
  * `FIELDS TERMINATED BY ','` $\rightarrow$ The CSV delimiter.
  * `ENCLOSED BY '"'` $\rightarrow$ Handles text values wrapped in quotes.
  * `IGNORE 1 ROWS` $\rightarrow$ Skips the header row in the CSV file.
  * *(If the file is on your local machine, change it to `LOAD DATA LOCAL INFILE 'C:/path/employees.csv'`)*.

#### Method 2: Using `mysqlimport` Command-Line Tool
You can run this directly from your terminal (CMD/Bash) without logging into the MySQL shell.
```bash
mysqlimport --local -u root -p --fields-terminated-by=',' --lines-terminated-by='\n' --ignore-lines=1 my_database employees.csv
```
* `--local` $\rightarrow$ File is on the client machine.
* `my_database` $\rightarrow$ The target database name.
* `employees.csv` $\rightarrow$ **Important:** The filename must exactly match the table name (i.e., `employees` table).

#### Method 3: Using GUI Tools (MySQL Workbench / phpMyAdmin)
* **Workbench:** Right-click table $\rightarrow$ `Table Data Import Wizard` $\rightarrow$ Select CSV file $\rightarrow$ Map columns $\rightarrow$ Finish.

### 40.3 Exporting Data from MySQL
#### 1. Export Query Results to CSV (`INTO OUTFILE`)
```sql
SELECT id, name, salary
FROM employees
INTO OUTFILE '/var/lib/mysql-files/employees.csv'
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n';
```
* **Note:** This creates the `employees.csv` file on the *server*. You require write access to that directory and the `FILE` privilege in MySQL.

#### 2. Export via GUI (MySQL Workbench)
* Right-click a table $\rightarrow$ `Table Data Export Wizard` $\rightarrow$ Choose CSV, JSON, or SQL format.

### 40.4 Database Backups & Dumps (`mysqldump`)
`mysqldump` is a powerful command-line tool provided by MySQL to create a full backup (SQL Dump) of your schema and data.

* **Export Full Database:** 
  ```bash
  mysqldump -u root -p mydb > mydb.sql
  ```
  *(Creates a `.sql` file with schema + data. `>` redirects output into the file).*

* **Export Single Table:**
  ```bash
  mysqldump -u root -p mydb employees > employees.sql
  ```

* **Export Only Schema (Without Data):**
  ```bash
  mysqldump -u root -p --no-data mydb > schema.sql
  ```

* **Export Only Data (No Table Structure):**
  ```bash
  mysqldump -u root -p --no-create-info mydb > data.sql
  ```

* **Export with Conditions (`WHERE` clause):**
  ```bash
  mysqldump -u root -p mydb employees --where="salary > 5000" > high_salary.sql
  ```

#### How to Import a Dump file back to MySQL:
```bash
mysql -u root -p mydb < mydb.sql
```
*(This executes all the `CREATE TABLE` and `INSERT` statements inside the `.sql` file, restoring your database completely).*

### 40.5 Exporting/Importing Other File Types (XML & JSON)

#### 1. XML Files
MySQL natively supports XML exports and imports.
* **Exporting to XML:**
  ```bash
  mysql -u root -p --xml -e "SELECT * FROM mydb.employees" > employees.xml
  ```
* **Importing XML (`LOAD XML INFILE`):**
  ```sql
  LOAD XML INFILE '/path/to/employees.xml'
  INTO TABLE employees
  ROWS IDENTIFIED BY '<row>';
  ```

#### 2. JSON Files
* **Exporting to JSON (MySQL 8.0+):**
  You can use MySQL Workbench GUI (Export to JSON) or write a query using JSON functions:
  ```sql
  SELECT JSON_ARRAYAGG(JSON_OBJECT('id', id, 'name', name, 'salary', salary)) 
  FROM employees 
  INTO OUTFILE '/path/to/employees.json';
  ```
* **Importing JSON:**
  MySQL doesn't have a direct `LOAD JSON INFILE` command. Instead, you read it using `LOAD DATA` into a single text column and parse it using `JSON_TABLE()`. For bulk JSON imports, **GUI Tools (MySQL Workbench) or scripts (Python/Node.js)** are highly recommended over raw SQL.

### 40.6 Advanced `mysqldump` (Routines, Triggers, Events)
By default, `mysqldump` exports tables and data. If you have Stored Procedures, Functions, Triggers, or Scheduled Events, you **MUST** include specific flags; otherwise, they will be left behind in the backup!

* **Export everything including Routines, Triggers, and Events:**
  ```bash
  mysqldump -u root -p --routines --triggers --events mydb > full_backup.sql
  ```
  *(Note: `--routines` exports Procedures & Functions. `--triggers` is usually on by default, but it's good practice to specify it).*

### 40.7 Performance Tip: Importing HUGE SQL Files
When you import a massive `.sql` dump (e.g., 50GB file), running `mysql < dump.sql` can take hours. To drastically speed it up, log into MySQL and temporarily disable constraint checks:

```sql
SET autocommit=0;
SET unique_checks=0;
SET foreign_key_checks=0;

-- In the MySQL command line, use the 'source' command (Faster than < in terminal)
SOURCE C:/path/to/huge_backup.sql;

-- After import completes, turn them back on and commit
COMMIT;
SET autocommit=1;
SET unique_checks=1;
SET foreign_key_checks=1;
```
*(This prevents MySQL from verifying constraints and writing transaction logs for every single row inserted, making bulk imports extremely fast).*

---

## Topic 41: SQL Server Architecture & Database Hierarchy

### 41.1 What is a SQL Server and Database Hierarchy?
* **Image Reference:** ![Database Hierarchy](./svg_db_hierarchy.svg) *(Description: Shows the top-down hierarchy: SQL Server -> Database -> Schema -> Table / View).*

1. **SQL Server (DBMS):** It allows us to store, manage, and provide access to databases for users or applications.
2. **Database:** Inside a SQL Server, there are multiple databases. A database is a collection of information stored in a structured way where all your data is kept and organized into different tables and objects. Each database is separated from the others and has its own data.
3. **Schema:** Inside each database, you will find multiple schemas. A schema is a logical layer that groups up related objects (like tables and views) together.
4. **Table:** Inside the schema, we find tables. A table is the place where your data actually lives physically, organized into rows and columns.
5. **View:** Inside the schema, there is another object called a View.
   - A View is like a **virtual table** that has a structure (columns and data types) but does not store data physically.
   - It shows data without storing it. To see the data, the query behind the view must execute.
   - Unlike a table, it does not store data permanently.

---

### 41.2 The 3-Tier Database Architecture (Three Levels of Abstraction)
* **Image Reference:** ![Database Abstraction Layers](./svg_db_abstraction_layers.svg) *(Description: Shows the High to Low Abstraction levels involving Business Analysts, Power BI, App Developers, and DBAs).*

The architecture of a database is divided into three distinct levels:

#### 1. Physical Level (Internal Layer)
* **What is it?** This is the lowest level of the database. It is where data is actually stored in physical storage (Disk).
* **Who uses it?** **Database Administrators (DBA)**. They are experts who manage access, security, performance optimization, backups, recovery, and configuration.
* **What it deals with:** Data files, partitions, logs, catalogs, blocks, cache, and everything a database needs to physically store data.
* **Complexity:** This is the most complicated layer.

#### 2. Logical Level (Conceptual Layer)
* **What is it?** This level describes *what* data is stored in the database and the relationships among those data. It focuses on how to structure the data rather than how it is physically stored.
* **Who uses it?** **Application Developers**. They interact with this layer to build the data model for their projects.
* **What it deals with:** Creating tables, defining relationships, views, indexing for performance optimization, and writing stored procedures/functions. 
* **Complexity:** Less complicated than the physical layer. It provides a perfect abstraction for developers, so they don't have to worry about physical storage.

#### 3. View Level (External Layer)
* **What is it?** This is the highest level of abstraction. It only holds the relevant data or information needed for a specific use case.
* **Who uses it?** **End Users** and **Applications**. They access and see the data through different views tailored to their perspectives.
* **What it deals with:** Users at this level only deal with Views. They don't have to deal with complex tables, indexes, stored procedures, data files, or partitions.
* **Complexity:** The least complicated. Its focus is to make data friendly and easy to consume for end users.

---

### 41.3 Interview Perspective & Key Takeaways
* **Abstraction:** The 3-tier architecture exists to provide **Data Abstraction**. End-users don't need to know how data is logically structured, and developers don't need to know how data is physically stored on the hard drive.
* **Security:** Views (External Layer) provide a massive security benefit because you can hide sensitive columns (like passwords or salaries) from end-users by simply not including them in the view.

* **Hindi (मराठी/हिंदी सारांश) with Real-Life Example (ई-कॉमर्स/Amazon):** 
  * **Database Hierarchy:** सबसे ऊपर **SQL Server** होता है $\rightarrow$ उसके अंदर कई **Databases** होते हैं $\rightarrow$ Database के अंदर **Schema** (जो टेबल्स को लॉजिकली ग्रुप करता है) होता है $\rightarrow$ और Schema के अंदर **Table** (जहाँ असली डेटा फिजिकली स्टोर होता है) और **View** (Virtual टेबल, जिसमें डेटा स्टोर नहीं होता, बस दिखता है) होते हैं।
  * **3-Tier Architecture (3 लेवल्स):**
    1) **Physical Level (सबसे नीचे - Internal Layer):** 
       - **Ex:** Amazon का असली डेटा सर्वर की हार्ड डिस्क (HDD/SSD) पर किस फॉर्मेट (Blocks, Logs, Partitions) में सेव है।
       - इसे **DBA (Database Administrators)** हैंडल करते हैं। यूज़र्स या डेवलपर्स को इससे कोई मतलब नहीं होता। यह सबसे कॉम्प्लिकेटेड लेयर है।
    2) **Logical Level (बीच में - Conceptual Layer):** 
       - **Ex:** Amazon के सॉफ्टवेयर डेवलपर्स `Users` टेबल, `Orders` टेबल बनाते हैं और उनमें रिलेशनशिप (Foreign Keys) सेट करते हैं। 
       - यहाँ **Application Developers** काम करते हैं। उन्हें मतलब नहीं होता कि हार्ड डिस्क पर डेटा कैसे सेव है, वो बस टेबल्स और डेटाबेस का स्ट्रक्चर डिज़ाइन करते हैं।
    3) **View Level (सबसे ऊपर - External Layer):** 
       - **Ex:** जब आप (End User) Amazon ऐप खोलते हैं, तो आपको सिर्फ आपका 'My Orders' या 'Cart' दिखता है। आपको पीछे के करोड़ों यूज़र्स के टेबल्स, कोडिंग या हार्ड डिस्क से कोई मतलब नहीं होता। 
       - यह सबसे हाईएस्ट एब्स्ट्रैक्शन (Highest Abstraction) है, ताकि **End Users** के लिए सिस्टम एकदम सिंपल और सेफ (Secure) रहे। 
---

## Topic 42: SQL Views (Virtual Tables) Deep Dive

### 42.1 What is a View?
* **Definition:** A View is a database object that acts like a **Virtual Table**. It is based on the result set of an SQL query.
* **Types of Views:**
  1. **Simple View:** Based on only *one* table, contains no functions or joins.
  2. **Complex View:** Based on *multiple* tables, uses joins, `GROUP BY`, aggregate functions, etc.
* **No Persistence:** A View **does not store any data physically** (by default). It only stores the SQL query structure (metadata) in the database system catalog.
* **Execution Flow (How it works behind the scenes):**
  1. Real data is stored inside physical database tables.
  2. The View acts as an **Abstraction Layer** between the user and the real data.
  3. When a user queries a view (`SELECT * FROM my_view`), SQL retrieves the query attached to the view from the catalog.
  4. The View's query then executes against the physical table, fills the virtual structure with results, and returns it to the user.
  *(You are directly querying the view, but indirectly querying the physical table).*

* **Image Reference:** ![View vs Table](./svg_view_vs_table.svg) *(Description: Shows the flow of execution and the differences between Physical Tables and Views).*

### 42.2 Differences Between Table and View

| Feature | Physical Table | Virtual Table (View) |
| :--- | :--- | :--- |
| **Storage** | Persists actual data physically on disk. | No persistence. Stores only the SQL query logic. |
| **Maintenance & Flexibility** | Hard to maintain/change. Modifying large tables (adding/moving columns) takes huge effort. | Easy to maintain & flexible. You just update the underlying query without touching physical data. |
| **Performance** | **Fast Response.** (1 Query execution). | **Slow Response.** (2 Queries execute: User's query + View's query). |
| **Operations** | Read and Write. | Mostly Read-Only (some exceptions apply for simple views). |

> **Does a View improve performance?**
> **No.** By themselves, views do NOT automatically improve performance. A view is just a saved SELECT query. Executing it 100 times executes the base query 100 times. No extra indexes are created just because it’s a view.

### 42.3 Why Do We Need Views? (6 Major Use Cases)

**1. Central Query Logic (Reusability & Reducing Redundancy)**
* **Image Reference:** ![View Central Logic](./svg_view_central_logic.svg) *(Description: Shows 3 analysts writing redundant CTEs vs using a central View).*
* **Scenario without View (CTE Issue):** If 3 analysts need to rank, get min/max, or compare sales, they all write the same `SUM` & `JOIN` logic in their own CTEs. This is redundant and wastes time.
* **Solution:** Create a View for the `SUM` & `JOIN` logic. Now, it is centralized in the database. All analysts just `SELECT` from the view and apply their specific `RANK` or `MIN/MAX` logic.

**2. Hide Complexity (Abstraction)**
* **Image Reference:** ![Hide Complexity](./svg_view_hide_complexity.svg) *(Description: Shows how multiple complex tables are joined and abstracted into one simple view for the user).*
* Large databases have complex, cryptic table names and relationships. Asking an end-user to do 5 `JOIN`s just to get customer details is a nightmare.
* **Solution:** A developer creates a View that pre-joins all tables into one clean, friendly virtual table.

**3. Data Security (Column & Row-Level Protection)**
* **Image Reference:** ![View Security](./svg_view_security.svg) *(Description: Demonstrates how Manager, Data Analyst, and Student get different views with column/row level security).*
* **Column-Level Security:** A table has a sensitive `salary` column. You create a view that selects everything *except* the salary column, and give data analysts access only to the view.
* **Row-Level Security:** You want the EU Sales team to only see EU data. You create a view with `WHERE Country != 'USA'`. They can never access USA data.

**4. Flexibility and Dynamic Changes**
* **Image Reference:** ![View Flexibility](./svg_view_flexibility.svg) *(Description: Shows how changing a physical table breaks queries, but a view absorbs the impact).*
* If you rename a physical table column or split a table, 100 users' queries will break.
* **Solution:** Instead, users query the View. If you rename the physical column, you just update the View's query to alias it back. Users won't notice a thing!

**5. Multiple Languages Support**
* **Image Reference:** ![Multiple Languages](./svg_view_multiple_languages.svg) *(Description: Shows one base table connected to multiple views, each translated for a specific region's users).*
* You can create separate views to display column aliases in different languages for different regions. For example, a German user gets a view called `BESTELLUNG`, and an Indian user gets a view called `आदेश`, both pointing to the same underlying `ORDERS` table.

**6. Virtual Data Marts (DWH)**
* **Image Reference:** ![Virtual Data Marts](./svg_view_data_marts.svg) *(Description: Shows data flowing from Source Systems to a Physical Data Warehouse, then abstracted into Virtual Data Marts for Reporting).*
* Used in Data Warehousing to provide flexible, efficient presentation layers (Data Marts). Instead of creating physical tables for every mart, you create Virtual Data Marts using views, which connect directly to BI Tools/Reporting Dashboards.

### 42.4 View vs CTE
* **Image Reference:** ![View vs CTE](./svg_view_vs_cte.svg) *(Description: Comparison chart showing Redundancy, Reusability, Persistence, and Maintenance differences).*

| Feature | View | CTE (Common Table Expression) |
| :--- | :--- | :--- |
| **Purpose** | Reduces redundancy across **Multiple Queries / Entire Project**. | Reduces redundancy within **One Single Query**. |
| **Persistence** | Logic is saved permanently in the database as an object. | Logic is temporary, calculated on the fly, and destroyed when query ends. |
| **Maintenance** | Requires manual maintenance (`CREATE`, `ALTER`, `DROP`). | No maintenance. Cleaned up automatically. |

### 42.5 Syntax & Schema Naming
* **Image Reference:** ![View Syntax](./svg_view_syntax.svg) *(Description: Basic DDL syntax showing CREATE VIEW view-name AS query).*
* **Create View:**
  ```sql
  CREATE VIEW view_name AS
  SELECT column1, column2 FROM table_name WHERE condition;
  ```
* **Schema Qualification:** If you don't specify a schema, it goes to default (like `dbo`). To place it in a specific schema: `CREATE VIEW SALES.V_total_sales AS (...)`
* **Drop View:** `DROP VIEW view_name;`

### 42.6 Modifying/Updating Views (`CREATE OR REPLACE` vs `ALTER VIEW`)

**1. `CREATE OR REPLACE VIEW` (Best & Most Common - MySQL/PostgreSQL)**
* Replaces the existing view definition automatically without dropping it first. Keeps existing permissions safe. Works even if the view doesn't exist yet.

**2. `ALTER VIEW` (SQL Server/Oracle/MySQL)**
* Similar effect, but only works if the view *already exists*.

**3. Drop & Recreate (Two-step method)**
* `DROP VIEW IF EXISTS...` then `CREATE VIEW...`. **Warning:** Loses permissions assigned to the view.

**Rules for Modifying a View:**
* **Allowed:** Add new columns (they must be added at the end), remove columns, change/add joins, modify `WHERE`, `GROUP BY`, `ORDER BY`.
* **Not Allowed:** You **cannot change the order of existing columns**, you **cannot insert a new column in the middle**, and you cannot change underlying data types without breaking dependencies.
* **Note:** If you add a new column to the *underlying physical table*, the view won't show it automatically because the view only stores the old query structure. You must use `CREATE OR REPLACE VIEW` to refresh it.

**Renaming Columns and Views:**
* **Rename a Column in a View (MySQL 8.0+):** `ALTER VIEW view_name RENAME COLUMN old_col TO new_col;` *(This does NOT affect the base table, only the view).*
* **Rename the View Itself:** `ALTER VIEW old_view_name RENAME TO new_view_name;`

### 42.7 Updatable Views (Insert / Update / Delete through a View)
Normally views are read-only, but you *can* update the base table through a view **only if** the view meets strict criteria:
1. It must reference **only one base table** (No Joins).
2. Cannot contain `GROUP BY`, `HAVING`, `DISTINCT`, Aggregate functions (`SUM`, `COUNT`), Window functions, or `WITH` (CTE) clauses.
3. Must include primary keys/NOT NULL columns of the base table for inserts.

**WITH CHECK OPTION:**
* A security feature for updatable views. It ensures that any `INSERT` or `UPDATE` through the view satisfies the view's `WHERE` condition.
* Example: View filters `WHERE salary > 5000 WITH CHECK OPTION;`. If you try to update a salary to `4000` via the view, it will fail because the new row wouldn't be visible in the view anymore.

### 42.8 Materialized Views (Performance Booster)
* **What is it?** A normal view just stores the query. A **Materialized View** (MV) stores the query **AND** physically stores the precomputed data (snapshot) on the disk.
* **Why do we need it?** For complex joins and aggregations (Data Warehousing/Dashboards) that take too long to compute every time. Querying an MV is instant because data is precomputed.
* **Indexes:** Because data is physically stored, you **can add Indexes** to an MV (unlike normal views).
* **Refresh Strategies:** Because data is stored, it gets stale. You must refresh it:
  1. **ON DEMAND (Manual):** `REFRESH MATERIALIZED VIEW view_name;`
  2. **SCHEDULED:** Auto-refreshes daily/hourly.
  3. **ON COMMIT:** Refreshes immediately when base table changes.
* **Note:** MySQL does not support native Materialized Views. You simulate them by creating a real summary table and updating it via Events or Triggers.

### 42.9 Index vs View vs Materialized View
| Feature | Index | View | Materialized View |
| :--- | :--- | :--- | :--- |
| **Purpose** | **Fast Search** (Lookups) | **Query Shortcut / Security** | **Precomputed Result for Speed** |
| **Data Storage** | Stores a lookup structure (B-Tree). | No data storage (Virtual). | Stores actual precomputed query results. |
| **Data Freshness**| Auto-updates instantly. | Always 100% fresh (queries base table). | Stale until Refreshed (Manual/Auto). |

---

### 42.10 How Database Executes a View
* **Image Reference:** ![View Execution](./svg_view_execution.svg) *(Description: Shows the DB Engine interacting with the Catalog (Disk) to fetch the View's query, and then executing it against the Physical Table).*

**Step-by-Step Execution Flow:**
1. **Creation:** When a Data Engineer creates a view (`CREATE VIEW TOPN AS...`), the database engine **does not store any actual data**. It stores the metadata and the SQL statement inside the **System Catalog (Disk)**.
2. **Querying:** A Data Analyst executes a query against the view (`SELECT * FROM TOPN`).
3. **Execution Query 1 (Metadata Lookup):** The database engine realizes it's a view, not a table. It goes to the System Catalog, retrieves the stored SQL query attached to that view, and prepares it.
4. **Execution Query 2 (Physical Table):** The database engine then executes that retrieved query against the actual underlying **Physical Table** (e.g., `ORDERS`), fetches the physical data, and returns the result back to the analyst.
* **Conclusion:** Querying a view always results in executing **two steps/queries** internally (fetching the definition from the catalog + querying the base table).

### 42.11 Summary of SQL Views
* **Image Reference:** ![View Summary](./svg_view_summary.svg) *(Description: A quick cheat-sheet summarizing that a View is a virtual table used to persist complex logic, better than CTEs for reusability, and outlining the 6 core use cases).*

---

### 42.12 Interview Perspective & Hindi Summary

* **Hindi (मराठी/हिंदी सारांश) with Examples:**
  * **View (Virtual Table) क्या है?:** View कोई असली टेबल नहीं है, इसमें कोई डेटा सेव नहीं होता। यह सिर्फ एक सेवड क्वेरी (Saved Query) है। 
  * **Ex:** अगर आप `SELECT * FROM View` करते हैं, तो डेटाबेस पहले व्यू की क्वेरी रन करता है, फिर असली टेबल (Physical table) से डेटा लाकर आपको दिखाता है।
  * **फायदे (6 Use Cases):**
    1. **Security:** अगर किसी टेबल में Employee की Salary है और आप उसे छिपाना चाहते हैं, तो एक व्यू बनाओ जिसमें Salary कॉलम न हो और यूज़र्स को सिर्फ व्यू का एक्सेस दो। इसे (Column-Level Security) कहते हैं।
    2. **Central Logic:** अगर कोई `JOIN` या `SUM` वाली मुश्किल क्वेरी पूरी टीम बार-बार लिख रही है, तो उसका एक View बना दो। सब उसे सीधा यूज़ कर लेंगे (CTE की तरह बार-बार नहीं लिखना पड़ेगा)।
    3. **Flexibility:** कल को असली टेबल का नाम बदलना हो तो यूज़र्स का कोड नहीं फटेगा (Break नहीं होगा), क्योंकि वो व्यू यूज़ कर रहे हैं।
    4. **Hide Complexity:** बहुत सारे टेबल्स को `JOIN` करके एक सिंपल व्यू बना देना।
    5. **Multiple Languages:** अलग-अलग देशों के यूज़र्स के लिए उनकी भाषा में कॉलम नाम वाला व्यू बनाना।
    6. **Virtual Data Marts:** Data Warehouse में बिना एक्स्ट्रा स्पेस लिए रिपोर्टिंग के लिए वर्चुअल टेबल्स बनाना।
  * **Database View को Execute कैसे करता है?:** 
    - जब आप View बनाते हैं, तो डेटाबेस सिर्फ उसकी क्वेरी को अपनी **Catalog (Disk)** में सेव करता है, असली डेटा नहीं।
    - जब यूज़र `SELECT * FROM View` रन करता है, तो डेटाबेस पहले Catalog से वो क्वेरी निकालता है (Query 1), और फिर उस क्वेरी को असली टेबल (Physical Table) पर रन करके डेटा लाता है (Query 2)।
  * **View vs Materialized View:** View स्लो होता है क्योंकि वह हर बार कैलकुलेट होता है। Materialized View फास्ट होता है क्योंकि वह रिजल्ट को डिस्क (Disk) पर सेव कर लेता है। (लेकिन इसे रिफ्रेश - Refresh करना पड़ता है)।
  * **Updatable View:** आप व्यू के ज़रिये डेटाबेस में इंसर्ट (Insert) भी कर सकते हैं, लेकिन शर्त यह है कि व्यू में `JOIN`, `GROUP BY`, या `SUM` नहीं होना चाहिए। 
  * **WITH CHECK OPTION:** यह चेक करता है कि आप व्यू की `WHERE` कंडीशन के खिलाफ जाकर कुछ इंसर्ट या अपडेट न करें।

---

## Topic 43: Tables, CTAS & Temporary Tables Deep Dive

### 43.1 What are Database Tables? (Physical Storage vs Logical Grid)
* **Image Reference:** ![Table Structure](./svg_table_structure.svg) *(Description: Shows the connection between physical database files on disk and the logical grid of rows, columns, and cells).*
* **Definition:** A database table is a structured collection of data. It is similar to a simple grid or spreadsheet (like Excel).
* **Logical Structure:**
  * **Columns:** Represent different fields (e.g., `ID`, `Name`, `Score`).
  * **Rows:** Represent a single record or entry (e.g., one employee's complete data).
  * **Cells:** The intersection of a row and a column, holding a single piece of data.
* **Physical Storage:** 
  * While they look like spreadsheets to us, tables are **physically stored as database files on the disk**.
  * Users and developers usually do not have direct access to these files. The "Table" we see is an abstraction. Every time you query a table, the database engine goes to these files on the disk, fetches the data, and presents it to you.
* **Types of Tables:**
  1. **Permanent Tables:** Stay in the database permanently until you drop them.
  2. **Temporary Tables:** Session-specific tables that are automatically deleted when the session ends.

### 43.2 How to Create Permanent Tables: CREATE/INSERT vs CTAS
There are two main ways to create and populate a permanent table in SQL.

* **Image Reference:** ![CREATE vs CTAS](./svg_create_vs_ctas.svg) *(Description: Compares the 2-step CREATE/INSERT process vs the 1-step CTAS process).*
* **Image Reference:** ![CTAS Syntax](./svg_ctas_syntax.svg) *(Description: Shows the syntax differences between the two methods).*

**1. The Classical Way: CREATE / INSERT (2 Steps)**
* **Step 1 (CREATE):** You define the structure of the table from scratch using a DDL statement.
  ```sql
  CREATE TABLE Table_Name (
      ID INT,
      Name VARCHAR(50)
  );
  ```
* **Step 2 (INSERT):** You insert data into the newly created structure (from a CSV, manual input, or another query).
  ```sql
  INSERT INTO Table_Name VALUES (1, 'Frank');
  ```

**2. CTAS (Create Table As Select) - (1 Step)**
* **Definition:** Creates a brand new table based on the result of an SQL query.
* **How it works:** You define a query. The database executes it, retrieves the data, and creates a new table whose structure (columns/datatypes) and data come **one-to-one** directly from the query's result. You don't need to manually define data types.
  ```sql
  CREATE TABLE new_table_name AS 
  SELECT * FROM source_table WHERE condition;
  ```

---

### 43.3 CTAS Use Cases

#### Use Case 1: Optimizing Performance (Storing Complex Logic)
* **Image Reference:** ![CTAS Optimize](./svg_ctas_optimize.svg) *(Description: Shows a 30-min complex query saved into a CTAS table, allowing multiple analysts to query it instantly).*
* **The Problem with Views:** If you put a very complex, heavy query (e.g., massive joins and aggregations) inside a View, the database has to execute that 30-minute query *every time* an analyst queries the view. This makes the system incredibly slow.
* **The CTAS Solution:** Instead of a view, you run a **CTAS** query at night. The database takes the 30 minutes to generate the intermediate result, but it saves it as a **Physical Table**.
* **Result:** In the morning, when analysts query the CTAS table, the response time is fast and instant, because the data is already computed and prepared.

**Example: Total Orders by Month**
```sql
DROP TABLE IF EXISTS TOTAL_ORDERS;

-- CREATE TABLE AS SELECT
CREATE TABLE TOTAL_ORDERS AS (
    SELECT 
        COUNT(*) AS total_count,
        MONTHNAME(ORDERDATE) AS MONTH,
        SUM(SALES) AS TOTAL_SALES
    FROM ORDERS
    GROUP BY MONTHNAME(ORDERDATE)
);

-- Query the prepared data instantly
SELECT * FROM TOTAL_ORDERS;
```

> **How to Refresh a CTAS Table (MySQL)?**
> CTAS tables do not auto-refresh. If the source data changes, the CTAS table becomes stale.
> 1. **Option 1 (Full Refresh):** `DROP TABLE IF EXISTS` and run CTAS again. (Warning: loses indexes/constraints).
> 2. **Option 2 (Best Practice):** `TRUNCATE TABLE total_orders;` followed by `INSERT INTO total_orders SELECT ...`. (Preserves table structure and indexes).
> 3. **Option 3 (Incremental):** `REPLACE INTO` or `INSERT ... ON DUPLICATE KEY UPDATE` (if primary keys exist).

#### Use Case 2: Creating a Persistent Snapshot (Debugging)
* **Image Reference:** ![CTAS Snapshot](./svg_ctas_snapshot.svg) *(Description: Shows live orders changing, and a static CTAS snapshot being extracted for analysis).*
* **The Problem:** You have a data quality issue to investigate, but the live table is constantly receiving updates and new records. It is impossible to analyze a moving target.
* **The Solution:** Use CTAS to create a fixed, persistent snapshot of the data at a specific moment in time. You can safely run your analysis on this static snapshot table without worrying about live updates messing up your debugging.

#### Use Case 3: Physical Data Marts in Data Warehouses
* **Image Reference:** ![CTAS Data Marts](./svg_ctas_data_marts.svg) *(Description: Shows Source Systems feeding a Data Warehouse, and CTAS creating fast Physical Data Marts for Reporting).*
* **Definition:** A data mart is a subset of a data warehouse that focuses on a specific business area, department, or function (for example: sales, finance, marketing, or HR).
* **The Performance Issue:** If you create Data Marts as Views (Virtual Layer), performance can be slow because the view has to waste time waiting for the data mart to get the data from the warehouse every single time.
* **The CTAS Solution:** Using CTAS (e.g., taking 30 mins to run), you convert the Virtual Data Mart into a **Physical Data Mart**. Parsing a physical data mart improves the speed of data retrieval dramatically compared to using a view. The response time from a table is always much faster.
* **Important Note (Best Practice):** You have to use CTAS for performance. But the recommendation is that you start first with a view (Virtual Table). Why? Because view implementation is very dynamic, fast to set up, and you are always getting fresh data. Once performance drops, convert it to a CTAS physical table.

---

### 43.4 Temporary Tables (Session-Based Tables)
* **Definition:** Temporary tables are used to store intermediate results during a specific database session.
* **Lifecycle:** The database **automatically drops (deletes) all temporary tables once the session ends** (i.e., when you close your connection/client).

**Syntax:**
```sql
CREATE TEMPORARY TABLE temp_users (
    id INT PRIMARY KEY,
    name VARCHAR(100)
);

-- Or using CTAS logic:
CREATE TEMPORARY TABLE temp_orders AS
SELECT * FROM orders WHERE order_date >= '2025-01-01';
```

* **Visibility:** Temporary tables are visible **only within the current session**. Other users/sessions cannot see them. You can even have a temp table with the exact same name as a permanent table (the temp one takes precedence in your session).
* **Storage:** They are not stored in regular database files. They are stored in special format files in memory or a special temporary directory (check `SHOW VARIABLES LIKE 'tmpdir';`). You will not find them in `information_schema.tables`.
* **How to check if a temp table exists:** You can use `SHOW TABLES LIKE 'temp_users';`

> **What does a session mean?**
> The time between connecting and disconnecting from the database is called a session. 
> Once you open a client (like SQL Workbench), connect, and start doing queries, the session begins. When you close the client or shut down your PC, you disconnect. At that exact moment, the database goes and destroys all the temporary tables you created during that session. They live only as long as you have the session open.

### 43.5 How Database Executes Temporary Tables
* **Image Reference:** ![Temp Table Execution](./svg_temp_execution.svg) *(Description: Shows the Database Engine linking a client session to temporary storage on disk).*
1. **Creation:** When you execute `CREATE TEMPORARY TABLE AS SELECT...`, the engine runs the query and gets the data from the source table.
2. **Storage:** The engine stores the metadata in the system catalog and stores the actual physical table inside the **temporary storage (TEMP partition) on the Server's disk**.
3. **Usage:** A Data Engineer or Analyst can write multiple SQL queries to analyze this temp table while the session is active.
4. **Automatic Cleanup:** Once you close your client or disconnect (session ends), the database engine realizes the connection is gone. That means the database automatically cleans up the storage (making room for other sessions). This is how database engines work with temporary tables.

### 43.6 Use Case of Temporary Tables (ETL & Intermediate Results)
* **Image Reference:** ![Temp Table ETL](./svg_temp_etl_intermediate.svg) *(Description: Shows Extraction from a Source DB to an Intermediate Temp Table, Transformations like Filtering and Aggregation, Loading to a DWH, and automatic Dropping).*
* **Why do we need temporary tables?** In your source database, you have an `orders` table. Now you would like to load the table into your data warehouse. We have to do several transformations in order to prepare the data for analysis.
* You cannot run these heavy transformations directly on the source database. Of course it is not allowed! That's why in data warehousing we have to go and get our own copy of the data, and then on top of this data we can do our transformation.

**ETL (Extract, Transform, Load) flow using Temp Tables:**
  1. **Extraction (Query):** You have one script in order to extract the data from the table `orders` and put it into a **Temporary Table** to act as an intermediate result.
  2. **Transformation (Query):** You safely perform operations like *Filtering*, *Handling Nulls*, *Removing Duplicates*, and *Aggregation* on this intermediate copy without affecting live data.
  3. **Load (Query):** Once transformed and clean, you load the final data into the target DWH Database Table.
  4. **Drop (Auto):** The temp table handles its own cleanup. Once the ETL script finishes and the session closes, the database automatically runs the equivalent of a `DROP` query, deleting the junk intermediate data.

> **Important Note on Debugging ETLs:**
> While automatic cleanup is amazing, if there is something wrong with your loaded data in the Data Warehouse, you might want to check the intermediate copy (where the transformations were done) in order to debug and find the issue. If you use a temporary table, the data is gone the moment the script ends. Therefore, in scenarios where debugging is critical, developers often avoid temporary tables and just use normal permanent tables to store intermediate results.

---

* **Image Reference:** ![Tables Summary](./svg_tables_summary.svg) *(Description: Summary sheet of Tables, separating Permanent and Temporary types, defining CTAS use cases, and highlighting the auto-cleanup advantage of temp tables).*

---

### 43.7 Ultimate Comparison: Subquery vs CTE vs Temp Table vs CTAS vs View

| Feature | Subquery | CTE | Temp Table | CTAS (Permanent) | View |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **Storage Type** | Memory / Cache | Memory / Cache | Temp Disk Storage | Physical Disk Storage | No Storage (Only Metadata) |
| **Lifetime** | Ends when Query ends | Ends when Query ends | Ends when Session ends | Permanent (Until Dropped) | Permanent (Until Dropped) |
| **Scope (Access)** | One specific Query | One specific Query | Multiple Queries (Same Session) | Global (All Users/Sessions) | Global (All Users/Sessions) |
| **Reusability** | Worst (Repeated logic) | Low (Reused in 1 query) | Medium (Reused in 1 session) | High (Reused globally) | High (Reused globally) |
| **Data Freshness**| 100% Fresh (On-the-fly) | 100% Fresh (On-the-fly)| Stale (Snapshot at creation) | Stale (Snapshot at creation) | 100% Fresh (Queries base table) |
| **Performance** | Slow for complex logic | Slow for complex logic | Fast for session analysis | Fastest (Precomputed) | Slowest (Executes every time) |

* **Image Reference:** ![View vs CTAS Freshness](./svg_view_vs_ctas_freshness.svg) *(Description: Comparison showing how a View fetches fresh data directly from the updated base table, whereas a CTAS returns old, snapshot data from the time it was physically created).*

---

### 43.8 The Big Picture of SQL (How everything connects)

* **Image Reference:** ![SQL Big Picture](./svg_sql_big_picture.svg) *(Description: Visual flow showing how Tables, Views, Subqueries, CTEs, and CTAS connect from the Database Admin level to the Data Scientist's final query).*

**The Complete Story (Only for overview):**
1. **Creation (DDL):** So we have a database, and a developer or data engineer creates a new table from scratch. They are going to write a DDL (`CREATE TABLE`) statement in order to create one physical table in our database. Since the database table is empty, we move to the 2nd step.
2. **Insertion (DML):** They go and write an `INSERT INTO VALUES` statement in order to fill our new table with data. 
3. **Access:** Now once we have the table, we're going to give access to a Data Scientist or Data Analyst in order to start writing SQL queries.
4. **Subquery:** The first thing that could happen is that the logic is complex, and the analyst has to do it in two steps. The first step is a query that prepares data in order to execute the 2nd step. That is why they are going to use a **Subquery**. The main query is going to retrieve the data from the intermediate result in order to prepare the final result for the analyst.
5. **CTE (Common Table Expression):** Now, what could happen is that there will be SQL logic in the query that keeps repeating in the script. So instead of writing another subquery for that, she goes and puts this logic in a **CTE (Temp Set)**. Now she is going to the main query and using the result of the CTE in multiple places in the same single script. So all those subqueries, CTE queries, and main queries happen in one single query window.
6. **View:** And now what could happen is she is writing an amazing code that everyone can benefit from! Instead of keeping it just in her query, she is going to go and persist the logic in the database. She puts it as a **VIEW** in the database so all users can benefit from the logic and they don't have to write it again. Instead, they're going to go and query the view directly, making life easier. (The end user uses this view in the main query).
7. **CTAS (Physical Table):** And one more thing: she has another piece of logic that is really complex and everyone can benefit from it, but the issue is this query is *very slow*. She has to decide: "Do I put it in a view, or do I create a new table based on the query using CTAS?". Because of performance (the view takes around 30 minutes to execute), she decides to execute the query using **CTAS** where she generates a physical table so end users can access those tables in order to reuse the result instantly.
8. **Conclusion:** And of course, she can use the CTAS table in her main query. With that, now you have experience on how things progress. It is not just a simple query from a table; it is understanding how and why most people create Sub-queries, CTEs, Temporary Tables, and CTAS for different purposes.

---

### 43.9 Interview Perspective & Hindi Summary

* **Hindi (मराठी/हिंदी सारांश) with Examples:**
  * **Table क्या है?:** Table डेटाबेस की फाइल्स में हार्ड डिस्क पर सेव होता है। ये एक्सेल (Excel) की तरह rows और columns का ग्रिड होता है जहाँ असली डेटा (Cells में) रखा जाता है।
  * **Create Table के 2 तरीके:** 
    1. **Classical (CREATE/INSERT):** पहले टेबल का स्ट्रक्चर बनाओ, फिर उसमें एक-एक करके डेटा डालो।
    2. **CTAS (Create Table As Select):** एक ही झटके में क्वेरी रन करो, और उस क्वेरी के रिजल्ट से एक नया टेबल अपने आप बन जाएगा (स्ट्रक्चर और डेटा दोनों)।
  * **CTAS का फायदा (Performance):** अगर आपका कोई View बहुत स्लो है (30 मिनट लेता है), तो आप रात में एक CTAS चला दो। वो 30 मिनट लेकर एक असली (Physical) टेबल बना देगा। सुबह जब analysts आएंगे, तो उन्हें डेटा तुरंत (Fast) मिल जाएगा क्योंकि डेटा पहले से तैयार है।
  * **CTAS (Snapshot):** अगर लाइव टेबल में लगातार डेटा बदल रहा है और आपको कोई बग (Bug) ढूँढना है, तो CTAS से उस पल का एक "Snapshot" (कॉपी) बना लो। अब आप आराम से शांति में एनालिसिस कर सकते हो।
  * **Temporary Table क्या है?:** यह एक कच्चा (Temp) टेबल होता है। यह सिर्फ आपके करंट सेशन (Connection) तक ही ज़िंदा रहता है। जैसे ही आप डेटाबेस क्लाइंट बंद करोगे (Session ends), डेटाबेस इसे खुद-ब-खुद डिलीट कर देगा।
  * **Temporary Table का फायदा (ETL):** जब हमें डेटा को साफ़ (Clean/Transform) करना होता है, तो हम उसे Temp table में डालते हैं। सारा काम ख़त्म होने के बाद हमें इसे मैन्युअली ड्रॉप (Drop) करने की टेंशन नहीं होती, डेटाबेस खुद डिलीट कर देता है।

* **Pro-Tip for Interviews:** Always remember the difference in **Data Freshness**. Views are always fresh but slow. CTAS is extremely fast but the data is stale (snapshot) and needs to be truncated/re-inserted to refresh. Temporary tables are amazing for ETL pipelines to avoid dropping intermediate tables manually.
