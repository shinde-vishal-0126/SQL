-- ======================================================================
-- Topic 13: DCL (Data Control Language) & Security / Access Control
-- ======================================================================

-- ------------------------------------------------------------
-- 📖 In Simple Words
-- ------------------------------------------------------------

-- * Definition: DCL (Data Control Language) decides who can do what in the database: GRANT gives a permission, REVOKE takes it back.

-- * Real-life example: Like giving an office key card: one person may only enter the reading room, another may also enter the store room.

-- * 🧩 Syntax:
--     CREATE ROLE user_name LOGIN PASSWORD 'password';
--     GRANT privilege_list ON TABLE schema.table TO user_name;
--     GRANT privilege_list ON ALL TABLES IN SCHEMA schema TO user_name;
--     REVOKE privilege_list ON TABLE schema.table FROM user_name;
--     DROP ROLE user_name;

-- * Syntax explained (each part):
--   - privilege_list → SELECT, INSERT, UPDATE, DELETE, ALL PRIVILEGES … (UPDATE (col) = only one column)
--   - ON … → where the right applies: database.* / schema / one table
--   - TO / FROM → who gets the right / who loses it

-- * Example on salesdb (run 00-Setup-Sample-Data.sql first):
SET search_path TO sales;
CREATE ROLE viewer LOGIN PASSWORD 'View@123';
GRANT SELECT ON ALL TABLES IN SCHEMA sales TO viewer;
REVOKE SELECT ON ALL TABLES IN SCHEMA sales FROM viewer;
DROP ROLE viewer;

-- * Example explained (step by step):
--   1. A new login called viewer is created.
--   2. GRANT SELECT lets viewer only read salesdb tables — no insert, update or delete.
--   3. REVOKE removes that right again, and the user is dropped.

-- ------------------------------------------------------------
-- 13.1 What is DCL (Data Control Language)?
-- ------------------------------------------------------------

-- * Definition: DCL (Data Control Language) consists of commands used for database security and access control, deciding who can access what in a database.

--   * Used to control access and permissions on database objects such as databases, schemas, tables, views, sequences, functions and procedures.

--   * DCL commands are used to grant authority/privileges to users and to take back (revoke) that authority when no longer required.

-- * Why is DCL Used? (Point-Wise Reasons):

--   * 1. To Give Permissions to Users: Authorize developers, applications, or reporting analysts to perform specific queries (e.g., read-only access).

--   * 2. To Remove Permissions from Users: Withdraw capabilities when roles change or to restrict dangerous capabilities (e.g., revoke `DELETE` or `DROP`).

--   * 3. To Maintain Database Security: Prevent unauthorized access, accidental data wiping, and enforce the Principle of Least Privilege (PoLP).

-- * 🐘 PostgreSQL idea: In PostgreSQL, users and groups are both called roles. A "user" is simply a role that has the `LOGIN` attribute (`CREATE USER` = `CREATE ROLE ... LOGIN`).

-- ---

-- ------------------------------------------------------------
-- 13.2 Core DCL Commands: GRANT and REVOKE
-- ------------------------------------------------------------

-- The two primary DCL commands in SQL:

-- | Command | Keyword | Purpose | Action Performed |
-- | :--- | :--- | :--- | :--- |
-- | `GRANT` | `TO` | Give permission | Gives specific privileges on database objects to a role/user |
-- | `REVOKE` | `FROM` | Remove permission | Removes previously granted privileges from a role/user |

-- * 1. The `GRANT` Command:

--   * Definition: GRANT is a DCL command used to provide access privileges to users.

--   * Syntax:
GRANT privilege_list ON object_name TO role_name;

--   * Example:
GRANT SELECT, INSERT ON students TO vishal;

-- * 2. The `REVOKE` Command:

--   * Definition: REVOKE is a DCL command used to withdraw or remove privileges from users.

--   * Syntax:
REVOKE privilege_list ON object_name FROM role_name;

--   * Example:
REVOKE INSERT ON students FROM vishal;

-- * Note: PostgreSQL users have no `@'host'` part (MySQL: `'user'@'localhost'`). Which machines may connect is controlled in the `pg_hba.conf` file (see 13.4).

-- ---

-- ------------------------------------------------------------
-- 13.3 Inspecting Users & Privileges in PostgreSQL
-- ------------------------------------------------------------

-- * Q. How to Show all users & their related information?

--   * psql meta-command and system catalog:
-- (psql/client command — run it in psql, not in a GUI query tool):
-- \du                                   -- list roles and their attributes

SELECT rolname, rolsuper, rolcreatedb, rolcanlogin
FROM pg_roles;                        -- MySQL: SELECT user, host FROM mysql.user;

-- * Q. How to Show all privilege types available in PostgreSQL?

--   * PostgreSQL has no `SHOW PRIVILEGES`. The object privileges are: `SELECT`, `INSERT`, `UPDATE`, `DELETE`, `TRUNCATE`, `REFERENCES`, `TRIGGER`, `CREATE`, `CONNECT`, `TEMPORARY`, `EXECUTE`, `USAGE`, `SET`, `ALTER SYSTEM`, `MAINTAIN` (PG 17).

-- * Q. How to Show a specific user's granted privileges?

--   * PostgreSQL has no `SHOW GRANTS`. Use psql or the information schema:
-- (psql/client command — run it in psql, not in a GUI query tool):
-- \dp customers                         -- privileges on one table (also \z)

SELECT grantee, table_name, privilege_type
FROM information_schema.role_table_grants
WHERE grantee = 'vishal';

-- ---

-- ------------------------------------------------------------
-- 13.4 User Management & Creation (Read-Only User Concept)
-- ------------------------------------------------------------

-- * Q. How to Create a User (Read-Only User)?
CREATE USER vishal WITH PASSWORD 'VISHAL@1234';
-- same as: CREATE ROLE vishal WITH LOGIN PASSWORD 'VISHAL@1234';

-- * Component-by-Component Explanation:

--   * `CREATE USER`: Creates a new role that is allowed to log in.

--   * `vishal`: The role (user) name. Unquoted names become lowercase in PostgreSQL. Write `"VISHAL"` with double quotes only if you really want uppercase.

--   * `WITH PASSWORD`: Sets the password (stored as a SCRAM-SHA-256 hash by default).

--   * `'VISHAL@1234'`: The login password assigned to the user.

--   * Extra role attributes: `SUPERUSER`, `CREATEDB`, `CREATEROLE`, `LOGIN`, `CONNECTION LIMIT 5`, `VALID UNTIL '2026-12-31'`.

-- * Where can the user connect from? (PostgreSQL uses `pg_hba.conf`, not `@'host'`):

--   * The file `pg_hba.conf` (host-based authentication) has one rule per line:
-- ┌── (text — not SQL, shown for reference) ──
-- │ # TYPE   DATABASE   USER     ADDRESS          METHOD
-- │ local    all        all                       peer            # local Unix socket
-- │ host     salesdb    vishal   127.0.0.1/32     scram-sha-256   # only from this machine (like 'localhost')
-- │ host     salesdb    vishal   192.168.1.0/24   scram-sha-256   # office LAN (like '192.168.1.%')
-- │ host     all        all      0.0.0.0/0        scram-sha-256   # any IP (like '%') — be careful!
-- └──

--   * After editing it, reload the config: `SELECT pg_reload_conf();`

--   * Also `listen_addresses` in `postgresql.conf` must allow remote connections (default is only `localhost`).

-- ---

-- ------------------------------------------------------------
-- 13.5 Step-by-Step Granting & Revoking Permissions
-- ------------------------------------------------------------

-- > 🐘 Important PostgreSQL rule: To read a table, a user needs 3 levels of permission: `CONNECT` on the database, `USAGE` on the schema, and `SELECT` on the table. (In MySQL one `GRANT SELECT ON db.*` is enough.)

-- ------------------------------------------------------------
-- 1. Table-Level Permissions (Read-Only Access)
-- ------------------------------------------------------------

-- * Q. How to give SELECT permission on the employees / customers table (Read-Only Permission)?
GRANT CONNECT ON DATABASE salesdb TO vishal;
GRANT USAGE ON SCHEMA public TO vishal;
GRANT SELECT ON customers TO vishal;       -- read-only on one table

-- ------------------------------------------------------------
-- 2. Database-Wide Read-Only Permissions
-- ------------------------------------------------------------

-- * Q. How to grant read permission on all tables in a database?
GRANT CONNECT ON DATABASE salesdb TO vishal;
GRANT USAGE ON SCHEMA public TO vishal;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO vishal;          -- existing tables

ALTER DEFAULT PRIVILEGES IN SCHEMA public
    GRANT SELECT ON TABLES TO vishal;                            -- tables created later

--   * Explanation:

--     * `SELECT` $\rightarrow$ Read-only permission.

--     * `ALL TABLES IN SCHEMA public` $\rightarrow$ All tables that exist now (MySQL: `database_name.*`).

--     * `ALTER DEFAULT PRIVILEGES` $\rightarrow$ Also future tables. Without this, a table created tomorrow is not readable.

--     * The user cannot perform `INSERT`, `UPDATE`, or `DELETE`.

--   * PostgreSQL 14+ shortcut: built-in role `pg_read_all_data` = read every table in every schema:
GRANT pg_read_all_data TO vishal;

-- ------------------------------------------------------------
-- 3. Specific Table in Specific Schema
-- ------------------------------------------------------------

-- * Q. How to grant read permission on a specific table in a specific schema?
GRANT USAGE ON SCHEMA sales TO vishal;
GRANT SELECT ON sales.customers TO vishal;

-- ------------------------------------------------------------
-- 4. Grant Multiple Table-Level Privileges
-- ------------------------------------------------------------

-- * Q. How to grant multiple DML privileges (INSERT, UPDATE, DELETE) on a table?
GRANT INSERT, UPDATE, DELETE ON customers TO vishal;

-- For INSERT into a SERIAL/IDENTITY table, the user also needs the sequence:
GRANT USAGE ON SEQUENCE customers_id_seq TO vishal;

-- ------------------------------------------------------------
-- 5. Revoke a Single Privilege
-- ------------------------------------------------------------

-- * Q. How to revoke INSERT privilege from user?
REVOKE INSERT ON customers FROM vishal;

-- ---

-- ------------------------------------------------------------
-- 13.6 Database-Wide Privileges & Administrative Access
-- ------------------------------------------------------------

-- ------------------------------------------------------------
-- 1. Grant Full DML Privileges Across Entire Schema
-- ------------------------------------------------------------

-- * Vishal now has full DML access (`SELECT`, `INSERT`, `UPDATE`, `DELETE`) on all tables in the schema:
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO vishal;
GRANT USAGE ON ALL SEQUENCES IN SCHEMA public TO vishal;

-- ------------------------------------------------------------
-- 2. Revoke DELETE Privilege from User
-- ------------------------------------------------------------

-- * Vishal loses `DELETE` capability, but keeps `SELECT`, `INSERT`, and `UPDATE`:
REVOKE DELETE ON ALL TABLES IN SCHEMA public FROM vishal;

-- ------------------------------------------------------------
-- 3. Grant ALL Privileges (Database Owner)
-- ------------------------------------------------------------

-- * Can perform everything on the tables:
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO vishal;
GRANT ALL PRIVILEGES ON DATABASE salesdb TO vishal;   -- CONNECT, CREATE (schemas), TEMP
GRANT CREATE ON SCHEMA public TO vishal;               -- may create tables in public

-- * Simplest way to give "full control" of a database: make the user its owner:
ALTER DATABASE salesdb OWNER TO vishal;

-- ------------------------------------------------------------
-- 4. Revoke Dangerous Privileges (`DROP` & `ALTER`)
-- ------------------------------------------------------------

-- * In PostgreSQL there are no separate `DROP` / `ALTER` privileges. Only the owner of a table (or a superuser) can `ALTER` or `DROP` it. So to protect structure, simply don't make the app user the owner:
REVOKE DELETE, TRUNCATE ON ALL TABLES IN SCHEMA public FROM vishal;
REVOKE CREATE ON SCHEMA public FROM vishal;           -- can't create new tables

-- * Security note (PostgreSQL 15+): ordinary users can no longer create tables in `public` by default. On older versions run `REVOKE CREATE ON SCHEMA public FROM PUBLIC;`.

-- ------------------------------------------------------------
-- 5. Reload Privileges — Not Needed
-- ------------------------------------------------------------

-- * PostgreSQL has no `FLUSH PRIVILEGES`. `GRANT` / `REVOKE` take effect immediately. Only changes to `pg_hba.conf` / `postgresql.conf` need `SELECT pg_reload_conf();`.

-- ------------------------------------------------------------
-- 6. Verify Updated Privileges
-- ------------------------------------------------------------

-- * Confirms active permissions:
-- (psql/client command — run it in psql, not in a GUI query tool):
-- \dp customers
-- (psql/client command — run it in psql, not in a GUI query tool):
-- \du vishal

SELECT has_table_privilege('vishal', 'customers', 'DELETE');   -- true / false

-- ------------------------------------------------------------
-- 7. Remove a User Account Completely
-- ------------------------------------------------------------

-- * A role that still owns objects or has privileges cannot be dropped. Clean up first:
REASSIGN OWNED BY vishal TO postgres;   -- give vishal's tables to another role
DROP OWNED BY vishal;                   -- remove vishal's remaining privileges
DROP USER vishal;                       -- or DROP ROLE vishal;

-- ---

-- ------------------------------------------------------------
-- 13.7 Privilege Categories in PostgreSQL
-- ------------------------------------------------------------

-- | Category | Typical Privileges / Attributes | Operational Scope & Role |
-- | :--- | :--- | :--- |
-- | 1. Data Privileges (DML) | `SELECT`, `INSERT`, `UPDATE`, `DELETE`, `TRUNCATE` | Reading and changing rows in tables / views. |
-- | 2. Structure (DDL) | `CREATE` on database / schema, table ownership | Creating schemas and tables; only owners can `ALTER` / `DROP`. |
-- | 3. Connection & Schema access | `CONNECT` (database), `USAGE` (schema, sequence), `TEMPORARY` | Logging into a database and seeing objects inside a schema. |
-- | 4. Code | `EXECUTE` (functions, procedures), `TRIGGER`, `REFERENCES` | Running functions, creating triggers or foreign keys on a table. |
-- | 5. Role attributes (admin) | `SUPERUSER`, `CREATEDB`, `CREATEROLE`, `REPLICATION`, `BYPASSRLS` | Server-wide powers given to a role. |
-- | 6. Built-in roles | `pg_read_all_data`, `pg_write_all_data`, `pg_monitor`, `pg_signal_backend` | Ready-made permission groups. |

-- ------------------------------------------------------------
-- 13.8 Advanced Interview Concepts & Gotchas in DCL / Security
-- ------------------------------------------------------------

-- ------------------------------------------------------------
-- 1. Is `FLUSH PRIVILEGES` Needed?
-- ------------------------------------------------------------

-- * Q. Do you need to reload anything after `GRANT` or `REVOKE` in PostgreSQL?

-- * Correct Technical Answer: NO. PostgreSQL has no `FLUSH PRIVILEGES` command. Privileges are stored in the system catalogs and are checked live. (Only `pg_hba.conf` edits need `pg_reload_conf()`.)

-- ------------------------------------------------------------
-- 2. `WITH GRANT OPTION` (Delegation of Authority)
-- ------------------------------------------------------------

-- * Q. How can you allow a team lead to grant their own permissions to other developers?

-- * Syntax & Example:
GRANT SELECT, INSERT ON ALL TABLES IN SCHEMA public TO team_lead WITH GRANT OPTION;

-- * Explanation:

--   * `WITH GRANT OPTION` allows `team_lead` to grant the same privileges to other roles.

--   * Security Warning: Never give `WITH GRANT OPTION` to application service accounts; keep it for DBAs.

-- ------------------------------------------------------------
-- 3. Role-Based Access Control (Group Roles)
-- ------------------------------------------------------------

-- * Q. With hundreds of developers, granting permissions user-by-user is unmanageable. How do you handle this in PostgreSQL?

-- * Solution: Create group roles (without `LOGIN`), give privileges to the group, then add users to the group:
-- Step 1: Create group roles
CREATE ROLE app_developer NOLOGIN;
CREATE ROLE data_analyst NOLOGIN;

-- Step 2: Assign privileges to each role
GRANT SELECT, INSERT, UPDATE ON ALL TABLES IN SCHEMA public TO app_developer;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO data_analyst;

-- Step 3: Add users to the role
GRANT app_developer TO vishal, amit;

-- Step 4: Nothing else needed — members inherit privileges automatically (INHERIT is default)

-- * Difference from MySQL: no `SET DEFAULT ROLE` step is needed in PostgreSQL.

-- ------------------------------------------------------------
-- 4. Column-Level Privileges (Masking Sensitive Columns)
-- ------------------------------------------------------------

-- * Q. Can you permit an intern to see employee names and departments while hiding sensitive columns like salary?

-- * Solution: Yes! PostgreSQL supports column-level privileges:
-- Intern can only access emp_id, emp_name, and department:
GRANT SELECT (emp_id, emp_name, department) ON employees TO intern;

-- If the intern runs: SELECT salary FROM employees;
-- ERROR: permission denied for table employees

-- ------------------------------------------------------------
-- 5. Row-Level Security (PostgreSQL extra — not in MySQL)
-- ------------------------------------------------------------

-- * Q. Each sales rep must see only their own customers. How?

-- * Solution: Row-Level Security (RLS) policies:
ALTER TABLE customers ENABLE ROW LEVEL SECURITY;

CREATE POLICY rep_sees_own_rows ON customers
    FOR SELECT
    USING (sales_rep = current_user);   -- each user sees only rows where sales_rep = their name

-- ------------------------------------------------------------
-- 6. Difference: `DROP USER` vs. `REVOKE ALL PRIVILEGES`
-- ------------------------------------------------------------
-- | Dimension | `REVOKE ALL PRIVILEGES` | `DROP USER` |
-- | :--- | :--- | :--- |
-- | Account Existence | Role still exists in `pg_roles` | Role is completely removed |
-- | Authentication | User can still log in (if it has `LOGIN` and `CONNECT`) | Login fails: `role "vishal" does not exist` |
-- | Access Rights | User has no table permissions | User does not exist at all |
-- | Pre-condition | None | Must not own objects (`REASSIGN OWNED` / `DROP OWNED` first) |

-- ------------------------------------------------------------
-- 7. Account Locking & Password Expiry Management
-- ------------------------------------------------------------

-- * Q. How do you temporarily suspend an employee's access without deleting their grants, or force a password change?

-- * SQL Commands:
-- Temporarily block login (MySQL: ACCOUNT LOCK):
ALTER ROLE vishal NOLOGIN;

-- Allow login again (MySQL: ACCOUNT UNLOCK):
ALTER ROLE vishal LOGIN;

-- Password valid only until a date (MySQL: PASSWORD EXPIRE):
ALTER ROLE vishal VALID UNTIL '2026-12-31';

-- Change password:
ALTER ROLE vishal WITH PASSWORD 'NewPass@2026';

-- * PostgreSQL cannot force "change password at next login" by itself; that is usually done by the app or an identity system (LDAP / SSO).

-- ------------------------------------------------------------
-- 8. Password Hashing (`scram-sha-256` vs `md5`)
-- ------------------------------------------------------------

-- * Q. Why does an old driver fail with "authentication method 10 not supported" when connecting to PostgreSQL?

-- * Cause & Fix:

--   * PostgreSQL 14+ stores passwords as `scram-sha-256` by default (older versions used `md5`).

--   * Very old client drivers only know `md5`. The right fix is to upgrade the driver (all modern JDBC, psycopg, node-postgres versions support SCRAM).

--   * Temporary workaround (not recommended): `SET password_encryption = 'md5';` then reset that user's password, and use `md5` in `pg_hba.conf`. Note: `md5` passwords are deprecated in PostgreSQL 18.

-- ---

-- ------------------------------------------------------------
-- 13.9 Visual Architecture Diagram: DCL & Privileges
-- ------------------------------------------------------------

--   * GRANT (Top Left): The Database Administrator uses `GRANT ... TO ...` to give specific privileges to a role.

--   * REVOKE (Top Center): The Administrator uses `REVOKE ... FROM ...` to remove risky permissions without deleting the user.

--   * Scope Hierarchies (Top Right): The diagram shows MySQL scopes (`*.*` → `db.*` → table → column). PostgreSQL scopes are: Database (`CONNECT`) → Schema (`USAGE`) → Table (`SELECT` …) → Column → Row (RLS policies).

--   * Privilege Categories (Bottom Grid): The diagram lists MySQL's 36+ privileges. PostgreSQL has a smaller set of object privileges plus role attributes (see 13.7).

-- ---

--     * `REVOKE DELETE ON ALL TABLES IN SCHEMA public FROM vishal;`

-- ---

-- ======================================================================
-- 🎯 Practice Questions (salesdb sample data) — try first, then look at the answer
-- ======================================================================
-- Run 00-Setup-Sample-Data.sql once before this section.

SET search_path TO sales;

-- Q1. Create a read-only user for salesdb and check its privileges.
CREATE ROLE report_user LOGIN PASSWORD 'Report@123';
GRANT USAGE ON SCHEMA sales TO report_user;
GRANT SELECT ON ALL TABLES IN SCHEMA sales TO report_user;
SELECT grantee, table_name, privilege_type FROM information_schema.role_table_grants WHERE grantee = 'report_user';

-- Q2. Allow the user to update only the score column of customers, then revoke it.
GRANT UPDATE (score) ON sales.customers TO report_user;
REVOKE UPDATE (score) ON sales.customers FROM report_user;

-- Q3. Remove the user.
REVOKE ALL ON ALL TABLES IN SCHEMA sales FROM report_user;
REVOKE USAGE ON SCHEMA sales FROM report_user;
DROP ROLE report_user;
