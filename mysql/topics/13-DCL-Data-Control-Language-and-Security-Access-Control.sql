-- ======================================================================
-- Topic 13: DCL (Data Control Language) & Security / Access Control
-- ======================================================================

-- ------------------------------------------------------------
-- 📖 In Simple Words
-- ------------------------------------------------------------

-- * Definition: DCL (Data Control Language) decides who can do what in the database: GRANT gives a permission, REVOKE takes it back.

-- * Real-life example: Like giving an office key card: one person may only enter the reading room, another may also enter the store room.

-- * Example on salesdb (run 00-Setup-Sample-Data.sql first):
USE salesdb;
CREATE USER 'viewer'@'localhost' IDENTIFIED BY 'View@123';
GRANT SELECT ON salesdb.* TO 'viewer'@'localhost';
REVOKE SELECT ON salesdb.* FROM 'viewer'@'localhost';
DROP USER 'viewer'@'localhost';

-- * Example explained (step by step):
--   1. A new login called viewer is created.
--   2. GRANT SELECT lets viewer only read salesdb tables — no insert, update or delete.
--   3. REVOKE removes that right again, and the user is dropped.

-- ------------------------------------------------------------
-- 13.1 What is DCL (Data Control Language)?
-- ------------------------------------------------------------

-- * Definition: DCL (Data Control Language) consists of commands used for database security and access control, deciding who can access what in a database.

--   * Used to control access and permissions on database objects such as tables, views, stored procedures, functions, and schemas.

--   * DCL commands are used to grant authority/privileges to users and to take back (revoke) that authority when no longer required.

-- * Why is DCL Used? (Point-Wise Reasons):

--   * 1. To Give Permissions to Users: Authorize developers, applications, or reporting analysts to perform specific queries (e.g., read-only access).

--   * 2. To Remove Permissions from Users: Withdraw capabilities when roles change or to restrict dangerous capabilities (e.g., revoke `DELETE` or `DROP`).

--   * 3. To Maintain Database Security: Prevent unauthorized access, accidental data wiping, and enforce the Principle of Least Privilege (PoLP).

-- ---

-- ------------------------------------------------------------
-- 13.2 Core DCL Commands: GRANT and REVOKE
-- ------------------------------------------------------------

-- The two primary DCL commands in SQL:

-- | Command | Keyword | Purpose | Action Performed |
-- | :--- | :--- | :--- | :--- |
-- | **`GRANT`** | **`TO`** | Give permission | Bestows specific privileges/access on database objects to a user |
-- | **`REVOKE`** | **`FROM`** | Remove permission | Withdraws/removes previously granted access privileges from a user |

-- * **1. The `GRANT` Command:**

--   * Definition: GRANT is a DCL command used to provide access privileges to users.

--   * Syntax:
GRANT privilege_list ON object_name TO 'username'@'host';

--   * Example:
GRANT SELECT, INSERT ON Students TO 'user'@'localhost';

-- * **2. The `REVOKE` Command:**

--   * Definition: REVOKE is a DCL command used to withdraw or remove privileges from users.

--   * Syntax:
REVOKE privilege_list ON object_name FROM 'username'@'host';

--   * Example:
REVOKE INSERT ON Students FROM 'user'@'localhost';

-- ---

-- ------------------------------------------------------------
-- 13.3 Inspecting Users & Privileges in MySQL
-- ------------------------------------------------------------

-- * Q. How to Show all users & their related information?

--   * Inspect the internal MySQL authorization catalog to view all created users, hosts, and global privilege flags:
SELECT * FROM mysql.user;

-- View specific user accounts and hosts:
SELECT user, host, plugin FROM mysql.user;

-- * Q. How to Show all privilege types available in MySQL?

--   * Displays the complete list of supported server-level and object-level privilege types:
SHOW PRIVILEGES;

-- * Q. How to Show a specific user's granted privileges?

--   * Displays the exact grants currently active for a specific user account:
SHOW GRANTS FOR 'VISHAL'@'localhost';

-- ---

-- ------------------------------------------------------------
-- 13.4 User Management & Creation (Read-Only User Concept)
-- ------------------------------------------------------------

-- * Q. How to Create a User (Read-Only User)?
CREATE USER 'VISHAL'@'localhost' IDENTIFIED BY 'VISHAL@1234';

-- * Component-by-Component Explanation:

--   * **`CREATE USER`:** Command used to register a new user account in MySQL.

--   * **`'VISHAL'`:** The unique username for the account.

--   * **`'@localhost'`:** Host specification — dictates that this user can only connect from the local machine where MySQL runs.

--   * **`IDENTIFIED BY`:** Sets the password for the account.

--   * **`'VISHAL@1234'`:** The login password assigned to the user.

--   * **`'localhost'`:** Allows connections only from the local machine.

--   * **`'%'`:** Wildcard host — allows connection from any remote machine across the network/internet.

--   * **`'192.168.1.%'`:** Subnet restriction — allows connections only from IP addresses within a specific subnet (e.g., office LAN).

--   * **`'example.com'`:** Domain restriction — allows connections only originating from a specific verified domain.

-- ---

-- ------------------------------------------------------------
-- 13.5 Step-by-Step Granting & Revoking Permissions
-- ------------------------------------------------------------

-- ------------------------------------------------------------
-- 1. Table-Level Permissions (Read-Only Access)
-- ------------------------------------------------------------

-- * Q. How to give SELECT permission on the employees / customers table (Read-Only Permission)?
-- Grants read-only access on one specific table:
GRANT SELECT ON customers TO 'VISHAL'@'localhost';

-- ------------------------------------------------------------
-- 2. Database-Wide Read-Only Permissions
-- ------------------------------------------------------------

-- * Q. How to grant read permission on all tables in a database?
GRANT SELECT ON database_name.* TO 'VISHAL'@'localhost';

--   * Explanation:

--     * `SELECT` $\rightarrow$ Read-only permission.

--     * `database_name.*` $\rightarrow$ All tables inside the specified database.

--     * The user cannot perform `INSERT`, `UPDATE`, or `DELETE`.

-- ------------------------------------------------------------
-- 3. Specific Table in Specific Database
-- ------------------------------------------------------------

-- * Q. How to grant read permission on a specific table in a specific database?
GRANT SELECT ON customers.user TO 'VISHAL'@'localhost';

-- ------------------------------------------------------------
-- 4. Grant Multiple Table-Level Privileges
-- ------------------------------------------------------------

-- * Q. How to grant multiple DML privileges (INSERT, UPDATE, DELETE) on a table?
GRANT INSERT, UPDATE, DELETE ON customers TO 'VISHAL'@'localhost';

-- ------------------------------------------------------------
-- 5. Revoke a Single Privilege
-- ------------------------------------------------------------

-- * Q. How to revoke INSERT privilege from user?
REVOKE INSERT ON customers FROM 'VISHAL'@'localhost';

-- ---

-- ------------------------------------------------------------
-- 13.6 Database-Wide Privileges & Administrative Access
-- ------------------------------------------------------------

-- ------------------------------------------------------------
-- 1. Grant Full DML Privileges Across Entire Database
-- ------------------------------------------------------------

-- * Vishal now has full DML access (`SELECT`, `INSERT`, `UPDATE`, `DELETE`) on all tables in the database:
GRANT SELECT, INSERT, UPDATE, DELETE ON salesdb.* TO 'VISHAL'@'localhost';

-- ------------------------------------------------------------
-- 2. Revoke DELETE Privilege from User
-- ------------------------------------------------------------

-- * Vishal loses `DELETE` capability, but safely retains `SELECT`, `INSERT`, and `UPDATE`:
REVOKE DELETE ON salesdb.* FROM 'VISHAL'@'localhost';

-- ------------------------------------------------------------
-- 3. Grant ALL Privileges (Database Admin / Superuser on DB)
-- ------------------------------------------------------------

-- * Can perform everything inside the database (`CREATE`, `ALTER`, `DROP`, manage indexes, etc.):
GRANT ALL PRIVILEGES ON salesdb.* TO 'VISHAL'@'localhost';

-- ------------------------------------------------------------
-- 4. Revoke Dangerous Privileges (`DROP` & `ALTER`)
-- ------------------------------------------------------------

-- * Strips structural destruction and table modification permissions to protect database architecture:
REVOKE DROP, DELETE, ALTER ON salesdb.* FROM 'VISHAL'@'localhost';

-- ------------------------------------------------------------
-- 5. Reload Privileges (`FLUSH PRIVILEGES`) — Usually NOT Needed
-- ------------------------------------------------------------

-- * Reloads permissions from the `mysql` system database. ⚠️ Not needed after `GRANT` / `REVOKE` (they apply immediately) — only after editing `mysql.*` tables directly (see 13.8):
FLUSH PRIVILEGES;

-- ------------------------------------------------------------
-- 6. Verify Updated Privileges
-- ------------------------------------------------------------

-- * Confirms active permissions:
SHOW GRANTS FOR 'VISHAL'@'localhost';
SHOW GRANTS FOR 'readonly_user'@'localhost';

-- ------------------------------------------------------------
-- 7. Remove a User Account Completely
-- ------------------------------------------------------------

-- * Completely deletes the user account from the MySQL server:
DROP USER 'VISHAL'@'localhost';

-- ---

-- ------------------------------------------------------------
-- 13.7 The 6 Core Privilege Categories in MySQL
-- ------------------------------------------------------------

-- As of MySQL 8.x, there are 36+ distinct privilege types classified into 6 primary operational categories:

-- | Category | Typical Privileges | Operational Scope & Role |
-- | :--- | :--- | :--- |
-- | 1. Data Privileges (DML) | `SELECT`, `INSERT`, `UPDATE`, `DELETE` | Controls managing, querying, and updating row records inside tables. |
-- | 2. Structure Privileges (DDL) | `CREATE`, `DROP`, `ALTER`, `INDEX` | Controls creating, modifying, re-indexing, or destroying databases, tables, and views. |
-- | 3. Administrative Privileges | `GRANT OPTION`, `SUPER`, `RELOAD`, `SHUTDOWN` | Controls global MySQL server operation, user delegation, process management, and shutdowns. |
-- | 4. Replication Privileges | `REPLICATION SLAVE`, `REPLICATION CLIENT` | Used in Master-Replica high availability topologies to stream binary logs. |
-- | 5. Security & Process Privileges | `CREATE USER`, `PROCESS`, `SHOW DATABASES` | Controls user account provisioning, inspecting the server process list, and discovering databases. |
-- | 6. Proxy Privilege | `PROXY` | Allows one user account to authenticate and assume the privileges of another account. |

-- ------------------------------------------------------------
-- 13.8 Advanced Interview Concepts & Gotchas in DCL / Security
-- ------------------------------------------------------------

-- ------------------------------------------------------------
-- 1. The Classic Interview Trap: When is `FLUSH PRIVILEGES` Actually Required?
-- ------------------------------------------------------------

-- * **Q. Do you need to run `FLUSH PRIVILEGES` after every `GRANT` or `REVOKE` statement?**

-- * Correct Technical Answer: NO!

--   * When using standard SQL DCL commands (`GRANT`, `REVOKE`, `CREATE USER`, `ALTER USER`, `DROP USER`), MySQL updates its in-memory privilege hash tables automatically and immediately.

--   * `FLUSH PRIVILEGES` is only required if you bypass DCL statements and directly manipulate the internal MySQL system grant tables using DML (e.g., `UPDATE mysql.user SET ...;` or `INSERT INTO mysql.db ...;`).

-- ------------------------------------------------------------
-- 2. `WITH GRANT OPTION` (Delegation of Authority)
-- ------------------------------------------------------------

-- * Q. How can you allow a team lead or user to grant their own permissions to other developers?

-- * Syntax & Example:
GRANT SELECT, INSERT ON salesdb.* TO 'team_lead'@'localhost' WITH GRANT OPTION;

-- * Explanation:

--   * `WITH GRANT OPTION` allows `'team_lead'` to grant the exact privileges they hold to any other user account.

--   * Security Warning: Never grant `WITH GRANT OPTION` to public application service accounts; reserve strictly for DBAs.

-- ------------------------------------------------------------
-- 3. Role-Based Access Control (RBAC) in MySQL 8.0
-- ------------------------------------------------------------

-- * Q. In an enterprise with hundreds of developers, granting permissions user-by-user is unmanageable. How do you handle this efficiently in MySQL 8.0?

-- * Solution: Use Roles (grouped permissions):
-- Step 1: Create distinct roles
CREATE ROLE 'app_developer', 'data_analyst';

-- Step 2: Assign privileges to each role
GRANT SELECT, INSERT, UPDATE ON salesdb.* TO 'app_developer';
GRANT SELECT ON salesdb.* TO 'data_analyst';

-- Step 3: Grant the role to multiple individual users
GRANT 'app_developer' TO 'vishal'@'localhost', 'amit'@'localhost';

-- Step 4: Make role active by default upon user login
SET DEFAULT ROLE ALL TO 'vishal'@'localhost', 'amit'@'localhost';

-- ------------------------------------------------------------
-- 4. Column-Level Privileges (Masking Sensitive Columns)
-- ------------------------------------------------------------

-- * Q. Can you permit an intern to see employee names and departments while hiding sensitive columns like salary and SSN?

-- * Solution: Yes! MySQL supports column-level privilege projection:
-- Intern can only access emp_id, emp_name, and department:
GRANT SELECT (emp_id, emp_name, department) ON company.employees TO 'intern'@'localhost';

-- If the intern attempts: SELECT salary FROM company.employees;
-- MySQL rejects with: ERROR 1143 (42000): SELECT command denied to user for column 'salary'

-- ------------------------------------------------------------
-- 5. Difference: `DROP USER` vs. `REVOKE ALL PRIVILEGES`
-- ------------------------------------------------------------
-- | Dimension | `REVOKE ALL PRIVILEGES` | `DROP USER` |
-- | :--- | :--- | :--- |
-- | Account Existence | Account credentials remain in `mysql.user` | Account is completely purged from server |
-- | Authentication | User can still connect and log in successfully | Connection is rejected with `Access Denied` |
-- | Access Rights | User has 0 permissions (cannot access tables) | User does not exist at all |

-- ------------------------------------------------------------
-- 6. Account Locking & Password Expiry Management
-- ------------------------------------------------------------

-- * Q. How do you temporarily suspend an employee's access (e.g., during sabbatical) without deleting their grants, or force a password reset?

-- * SQL Commands:
-- Temporarily lock account (blocks authentication):
ALTER USER 'vishal'@'localhost' ACCOUNT LOCK;

-- Unlock account when employee returns:
ALTER USER 'vishal'@'localhost' ACCOUNT UNLOCK;

-- Force user to change their password on next login:
ALTER USER 'vishal'@'localhost' PASSWORD EXPIRE;

-- ------------------------------------------------------------
-- 7. Authentication Plugin Incompatibility (`caching_sha2_password` vs. `mysql_native_password`)
-- ------------------------------------------------------------

-- * Q. Why do older Python, PHP, or Node.js drivers fail with "Authentication plugin 'caching_sha2_password' cannot be loaded" when connecting to MySQL 8.0?

-- * Cause & Fix:

--   * MySQL 8.0 changed default password hashing from `mysql_native_password` to `caching_sha2_password`.

--   * Fix for legacy clients:
ALTER USER 'vishal'@'localhost' IDENTIFIED WITH mysql_native_password BY 'VISHAL@1234';

--   * ⚠️ Note (MySQL 9.x): `mysql_native_password` is disabled by default in MySQL 8.4 and removed in MySQL 9.0+ (your version is 9.1). There, the real fix is to upgrade the client driver so it supports `caching_sha2_password`.

-- ---

-- ------------------------------------------------------------
-- 13.9 Visual Architecture Diagram: DCL & Privileges
-- ------------------------------------------------------------

--   * GRANT (Top Left): The Database Administrator uses `GRANT ... TO ...` to push specific privileges down to a target user.

--   * REVOKE (Top Center): The Administrator uses `REVOKE ... FROM ...` to strip risky permissions without deleting the user.

--   * Scope Hierarchies (Top Right): Shows how privileges cascade from Global (`*.*`), to Database (`salesdb.*`), to Table (`salesdb.customers`), down to specific Columns.

--   * 6 Privilege Categories (Bottom Grid): Breaks down all 36+ MySQL privileges into their distinct roles (DML, DDL, Admin, Replication, Security, Proxy).

-- ---

-- ---

-- ======================================================================
-- 🎯 Practice Questions (salesdb sample data) — try first, then look at the answer
-- ======================================================================
-- Run 00-Setup-Sample-Data.sql once before this section.

USE salesdb;

-- Q1. Create a read-only user for salesdb and check its privileges.
CREATE USER 'report_user'@'localhost' IDENTIFIED BY 'Report@123';
GRANT SELECT ON salesdb.* TO 'report_user'@'localhost';
SHOW GRANTS FOR 'report_user'@'localhost';

-- Q2. Allow the user to update only the score column of customers, then revoke it.
GRANT UPDATE (score) ON salesdb.customers TO 'report_user'@'localhost';
SHOW GRANTS FOR 'report_user'@'localhost';
REVOKE UPDATE (score) ON salesdb.customers FROM 'report_user'@'localhost';

-- Q3. Remove the user.
DROP USER 'report_user'@'localhost';
