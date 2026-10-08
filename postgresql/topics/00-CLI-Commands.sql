-- ======================================================================
-- 💻 CLI Commands Cheat Sheet — MySQL (mysql) vs PostgreSQL (psql)
-- ======================================================================
/*
  The CLI (Command Line Interface) lets you work with the database from a terminal
  (cmd / PowerShell / bash) without Workbench or pgAdmin.

  ASCII Diagram:
  +------------------+    mysql -u root -p     +------------------+
  |  Terminal        | ----------------------> |  MySQL Server    |  port 3306
  |  (cmd / bash)    |                         +------------------+
  |                  |    psql -U postgres     +------------------+
  |                  | ----------------------> | PostgreSQL Server|  port 5432
  +------------------+                         +------------------+

  Three kinds of commands in this file:
    1. OS shell commands   -> typed in the terminal  (mysql, psql, mysqldump, pg_dump ...)
    2. Client meta-commands -> typed inside the client (MySQL: SHOW ..., \G   | psql: \l, \dt ...)
    3. Normal SQL           -> ends with a semicolon ;

  NOTE: the lines below are reference notes, not a script to run. Copy one command at a time.
*/

-- ======================================================================
-- 1. Install check / version / service
-- ======================================================================
/*
  Task                    | MySQL                                | PostgreSQL
  ------------------------+--------------------------------------+-------------------------------------
  Client version          | mysql --version                      | psql --version
  Server version (SQL)    | SELECT VERSION();                    | SELECT version();
  Start service (Windows) | net start MySQL80                    | net start postgresql-x64-16
  Stop service (Windows)  | net stop MySQL80                     | net stop postgresql-x64-16
  Start service (Linux)   | sudo systemctl start mysql           | sudo systemctl start postgresql
  Service status (Linux)  | sudo systemctl status mysql          | sudo systemctl status postgresql
  Is server ready?        | mysqladmin -u root -p ping           | pg_isready -h localhost -p 5432

  (Service names depend on the installed version: check with  services.msc  on Windows.)
*/

-- ======================================================================
-- 2. Connect / disconnect
-- ======================================================================
/*
  Task                    | MySQL                                     | PostgreSQL
  ------------------------+-------------------------------------------+------------------------------------------
  Connect (local)         | mysql -u root -p                          | psql -U postgres
  Connect to a database   | mysql -u root -p salesdb                  | psql -U postgres -d salesdb
  Connect to remote host  | mysql -h 10.0.0.5 -P 3306 -u root -p      | psql -h 10.0.0.5 -p 5432 -U postgres -d salesdb
  Connection URL          | mysql --host=... --user=...               | psql "postgresql://postgres@localhost:5432/salesdb"
  Run one query and exit  | mysql -u root -p -e "SHOW DATABASES;"     | psql -U postgres -c "SELECT now();"
  Run a .sql file         | mysql -u root -p salesdb < file.sql       | psql -U postgres -d salesdb -f file.sql
  Run file (inside client)| SOURCE C:/path/file.sql;                  | \i C:/path/file.sql
  Exit                    | exit;   or   quit;   or   \q              | \q
  Help                    | help;   or   \h                           | \?  (psql commands)   \h SELECT (SQL help)

  Parts explained:
    -u / -U  -> user name          -p (MySQL) -> ask for password
    -h       -> host (server)      -P (MySQL) / -p (psql) -> port   (careful: -p means different things!)
    -d       -> database (psql)    -e / -c    -> execute one command
*/

-- ======================================================================
-- 3. Databases
-- ======================================================================
/*
  Task                    | MySQL                          | PostgreSQL
  ------------------------+--------------------------------+-----------------------------------
  List databases          | SHOW DATABASES;                | \l      (or \l+ for sizes)
  Create database         | CREATE DATABASE salesdb;       | CREATE DATABASE salesdb;
  Switch database         | USE salesdb;                   | \c salesdb
  Current database        | SELECT DATABASE();             | SELECT current_database();
  Drop database           | DROP DATABASE salesdb;         | DROP DATABASE salesdb;
  Create from shell       | mysqladmin -u root -p create db| createdb -U postgres salesdb
  Drop from shell         | mysqladmin -u root -p drop db  | dropdb -U postgres salesdb
*/

-- ======================================================================
-- 4. Schemas, tables, columns, indexes
-- ======================================================================
/*
  Task                    | MySQL                               | PostgreSQL
  ------------------------+-------------------------------------+-----------------------------------
  List schemas            | SHOW DATABASES;  (schema = database)| \dn
  Set schema              | USE salesdb;                        | SET search_path TO sales;
  List tables             | SHOW TABLES;                        | \dt     (\dt sales.* for one schema)
  Describe a table        | DESCRIBE customers;                 | \d customers
  Full table details      | SHOW CREATE TABLE customers;        | \d+ customers
  List columns            | SHOW COLUMNS FROM customers;        | \d customers
  List indexes            | SHOW INDEX FROM customers;          | \di
  List views              | SHOW FULL TABLES WHERE Table_type   | \dv
                          |   = 'VIEW';                         |
  List functions/procs    | SHOW PROCEDURE STATUS;              | \df
                          | SHOW FUNCTION STATUS;               |
  List triggers           | SHOW TRIGGERS;                      | SELECT * FROM information_schema.triggers;
  Table size              | SELECT table_name, data_length      | \dt+   or  SELECT pg_size_pretty(
                          |   FROM information_schema.tables;   |   pg_total_relation_size('customers'));
*/

-- ======================================================================
-- 5. Users, roles and permissions
-- ======================================================================
/*
  Task                    | MySQL                                          | PostgreSQL
  ------------------------+------------------------------------------------+---------------------------------------------
  List users              | SELECT user, host FROM mysql.user;             | \du
  Current user            | SELECT CURRENT_USER();                         | SELECT current_user;
  Create user             | CREATE USER 'ana'@'localhost'                  | CREATE USER ana WITH PASSWORD 'Pass@123';
                          |   IDENTIFIED BY 'Pass@123';                    |
  Grant read access       | GRANT SELECT ON salesdb.* TO 'ana'@'localhost';| GRANT SELECT ON ALL TABLES IN SCHEMA sales TO ana;
  Show grants             | SHOW GRANTS FOR 'ana'@'localhost';             | \dp   (table privileges)
  Revoke                  | REVOKE SELECT ON salesdb.* FROM 'ana'@'localhost'; | REVOKE SELECT ON ALL TABLES IN SCHEMA sales FROM ana;
  Change password         | ALTER USER 'ana'@'localhost'                   | \password ana
                          |   IDENTIFIED BY 'New@123';                     |
  Drop user               | DROP USER 'ana'@'localhost';                   | DROP USER ana;
*/

-- ======================================================================
-- 6. Backup and restore (run in the OS terminal, not inside the client)
-- ======================================================================
/*
  Task                    | MySQL                                           | PostgreSQL
  ------------------------+-------------------------------------------------+-------------------------------------------------
  Backup one database     | mysqldump -u root -p salesdb > salesdb.sql      | pg_dump -U postgres -d salesdb -f salesdb.sql
  Backup one table        | mysqldump -u root -p salesdb customers > c.sql  | pg_dump -U postgres -d salesdb -t sales.customers -f c.sql
  Structure only          | mysqldump -u root -p --no-data salesdb > s.sql  | pg_dump -U postgres -d salesdb --schema-only -f s.sql
  Data only               | mysqldump -u root -p --no-create-info salesdb   | pg_dump -U postgres -d salesdb --data-only -f d.sql
  Backup all databases    | mysqldump -u root -p --all-databases > all.sql  | pg_dumpall -U postgres -f all.sql
  Compressed backup       | (pipe to gzip)                                  | pg_dump -U postgres -d salesdb -Fc -f salesdb.dump
  Restore .sql file       | mysql -u root -p salesdb < salesdb.sql          | psql -U postgres -d salesdb -f salesdb.sql
  Restore custom (-Fc)    | -                                               | pg_restore -U postgres -d salesdb salesdb.dump
*/

-- ======================================================================
-- 7. Import / export CSV
-- ======================================================================
/*
  Task                    | MySQL                                           | PostgreSQL (psql)
  ------------------------+-------------------------------------------------+-------------------------------------------------
  Export to CSV           | SELECT * FROM customers                         | \copy customers TO 'customers.csv' CSV HEADER
                          |   INTO OUTFILE '/tmp/customers.csv'             |
                          |   FIELDS TERMINATED BY ',';                     |
  Import from CSV         | LOAD DATA LOCAL INFILE 'customers.csv'          | \copy customers FROM 'customers.csv' CSV HEADER
                          |   INTO TABLE customers FIELDS TERMINATED BY ',' |
                          |   IGNORE 1 LINES;                               |
  Note                    | needs local_infile=1 / secure_file_priv folder  | \copy runs on the client; COPY runs on the server
*/

-- ======================================================================
-- 8. Server, sessions and monitoring
-- ======================================================================
/*
  Task                    | MySQL                                 | PostgreSQL
  ------------------------+---------------------------------------+---------------------------------------------
  Running connections     | SHOW PROCESSLIST;                     | SELECT pid, usename, state, query FROM pg_stat_activity;
  Kill a query/session    | KILL 25;                              | SELECT pg_terminate_backend(25);
  Server settings         | SHOW VARIABLES LIKE 'max_conn%';      | SHOW max_connections;   (SHOW ALL;)
  Server status           | SHOW STATUS;   or  \s                 | \conninfo
  Data folder             | SELECT @@datadir;                     | SHOW data_directory;
  Query plan              | EXPLAIN SELECT ...;                   | EXPLAIN ANALYZE SELECT ...;
  Locks / deadlocks       | SHOW ENGINE INNODB STATUS\G           | SELECT * FROM pg_locks;
*/

-- ======================================================================
-- 9. Client display tricks
-- ======================================================================
/*
  Task                    | MySQL                                 | PostgreSQL (psql)
  ------------------------+---------------------------------------+---------------------------------------------
  Vertical output         | SELECT * FROM customers\G             | \x   (toggle expanded display)
  Time each query         | (shown automatically)                 | \timing
  Clear current input     | \c                                    | \r
  Edit query in editor    | \e                                    | \e
  Save output to file     | tee output.txt;   (notee; to stop)    | \o output.txt     (\o to stop)
  Run shell command       | system dir   (Linux: \! ls)           | \! dir
  Command history         | arrow up / down                       | arrow up / down,  \s shows history
*/

-- ======================================================================
-- 10. Quick start (copy, paste and practise)
-- ======================================================================
/*
  MySQL:
    mysql -u root -p
    SHOW DATABASES;
    USE salesdb;
    SHOW TABLES;
    DESCRIBE customers;
    SELECT * FROM customers LIMIT 5;
    exit;

  PostgreSQL:
    psql -U postgres -d salesdb
    \l
    SET search_path TO sales;
    \dt
    \d customers
    SELECT * FROM customers LIMIT 5;
    \q
*/
