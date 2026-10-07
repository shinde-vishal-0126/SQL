-- ======================================================================
-- Topic 38: Events in MySQL (Scheduled Jobs)
-- ======================================================================

-- ------------------------------------------------------------
-- 📖 In Simple Words
-- ------------------------------------------------------------

-- * Definition: A scheduled job (MySQL EVENT, PostgreSQL pg_cron) is SQL that the database runs automatically at a fixed time or interval.

-- * Real-life example: An alarm clock that also does a task, like "every night at 12, back up the data".

-- * 🧩 Syntax:
--     SET GLOBAL event_scheduler = ON;
--     CREATE EVENT event_name
--     ON SCHEDULE {AT timestamp | EVERY n {MINUTE|HOUR|DAY} [STARTS ts] [ENDS ts]}
--     DO sql_statement;
--     ALTER EVENT event_name DISABLE;
--     DROP EVENT [IF EXISTS] event_name;

-- * Syntax explained (each part):
--   - Schedule → AT = once at a time; EVERY = repeat (MySQL). Cron text "0 0 * * *" = every day at 00:00 (pg_cron)
--   - DO / command → the SQL that runs automatically
--   - DISABLE / unschedule → stop the job

-- * Example on salesdb (run 00-Setup-Sample-Data.sql first):
USE salesdb;
CREATE TABLE status_snapshot (taken_at DATETIME, shipped INT);
CREATE EVENT ev_snapshot
ON SCHEDULE EVERY 1 DAY
DO INSERT INTO status_snapshot SELECT NOW(), COUNT(*) FROM orders WHERE orderstatus = 'Shipped';
SHOW EVENTS;
DROP EVENT ev_snapshot;
DROP TABLE status_snapshot;

-- * Example explained (step by step):
--   1. The job counts shipped orders and saves the number with the time.
--   2. EVERY 1 DAY (or cron '0 0 * * *') means it runs automatically once a day.
--   3. Today the count is 5 shipped orders. The demo objects are dropped at the end.

-- ------------------------------------------------------------
-- 38.1 What is an Event?
-- ------------------------------------------------------------

-- * An event in SQL (MySQL / MariaDB) is a scheduled task that the database server runs automatically at a defined time or at a repeating interval.

-- * It is similar to a cron job in Linux or a scheduled task in Windows, but it runs inside the database engine.

-- * An event has two parts: its schedule (when it runs — a date/time or an interval) and its body (what SQL it runs).

-- * Triggers fire on data events (`INSERT`, `UPDATE`, `DELETE`); SQL events are totally different — they are about time.

-- * Example: like setting an alarm on your phone — at 4:30 am once, or every day at 5:30 am.

-- ------------------------------------------------------------
-- 38.2 Purpose of Events
-- ------------------------------------------------------------

-- * Automate repetitive tasks.

-- * Run queries or stored procedures at specific times.

-- * Reduce the need for external schedulers (cron, Task Scheduler, application jobs).

-- ------------------------------------------------------------
-- 38.3 Use Cases of Events
-- ------------------------------------------------------------

-- * Auto-delete old logs – e.g. delete logs older than 30 days.

-- * Daily sales summary – save the total sales of the day into a `sales_summary` table every night.

-- * Reset login attempts – reset the failed-login counter of all users every night.

-- * Auto-expire discount codes – mark expired coupon codes as inactive.

-- * Send birthday wishes (simulated) – insert a row into a wishes log for customers whose birthday is today.

CREATE EVENT ev_daily_sales_summary
ON SCHEDULE EVERY 1 DAY
STARTS '2025-10-01 23:55:00'
DO
  INSERT INTO sales_summary (summary_date, total_sales)
  SELECT CURDATE(), COALESCE(SUM(sales), 0)
  FROM orders
  WHERE DATE(orderdate) = CURDATE();

-- ------------------------------------------------------------
-- 38.4 Types of Events (One-Time vs Recurring)
-- ------------------------------------------------------------

-- * MySQL has 2 types of events:

-- * Type 1 – One-time event: runs only once at the given time.

--   * Example (run once, 1 hour from now):
CREATE EVENT event_name
ON SCHEDULE AT CURRENT_TIMESTAMP + INTERVAL 1 HOUR
DO
    SQL statement;

--   * Syntax (for a one-time event use `AT`):
CREATE EVENT event_name
ON SCHEDULE AT 'YYYY-MM-DD HH:MM:SS'
DO
    SQL statement;

-- * Type 2 – Recurring event: runs repeatedly at a given interval (e.g. send notifications every day).

--   * Example (every day, starting 1 hour from now):
CREATE EVENT event_name
ON SCHEDULE EVERY 1 DAY
STARTS CURRENT_TIMESTAMP + INTERVAL 1 HOUR
DO
    SQL statement;

--   * Syntax (for a recurring event use `EVERY`, optionally `STARTS` and `ENDS`):
CREATE EVENT event_name
ON SCHEDULE EVERY 1 DAY
STARTS '2025-09-25 10:00:00'
DO
    SQL statement;

-- ------------------------------------------------------------
-- 38.5 Why We Use Events & How to Create Them
-- ------------------------------------------------------------

-- * An event in MySQL = a scheduled database job that runs SQL statements automatically at a specified time or interval.

-- * Create a one-time event:
CREATE EVENT delete_old_logs
ON SCHEDULE AT '2025-10-01 00:00:00'
DO
    DELETE FROM logs WHERE log_date < NOW() - INTERVAL 30 DAY;

--   * This deletes log records older than 30 days, once, on October 1, 2025.

-- * Create a recurring event:
CREATE EVENT daily_cleanup
ON SCHEDULE EVERY 1 DAY
STARTS '2025-09-26 02:00:00'
DO
    DELETE FROM sessions WHERE last_activity < NOW() - INTERVAL 7 DAY;

--   * This runs every day at 2 AM and removes sessions inactive for more than 7 days.

-- * Event with several statements (use `BEGIN ... END` and `DELIMITER`, or just call a procedure):
DELIMITER $$
CREATE EVENT ev_nightly_maintenance
ON SCHEDULE EVERY 1 DAY
STARTS '2025-10-01 03:00:00'
DO
BEGIN
    DELETE FROM sessions WHERE last_activity < NOW() - INTERVAL 7 DAY;
    UPDATE users SET failed_logins = 0;
    UPDATE coupons SET is_active = 0 WHERE expiry_date < CURDATE();
END $$
DELIMITER ;

-- or keep the logic in a procedure
CREATE EVENT ev_archive_orders_nightly
ON SCHEDULE EVERY 1 DAY STARTS '2025-10-01 01:00:00'
DO CALL ArchiveOldOrders();

-- ------------------------------------------------------------
-- 38.6 Managing Events (Scheduler, Show, Alter, Enable/Disable, Drop)
-- ------------------------------------------------------------

-- * Events run only when the event scheduler is ON (it is ON by default in MySQL 8).
-- Check if event scheduler is enabled
SHOW VARIABLES LIKE 'event_scheduler';

-- Enable event scheduler
SET GLOBAL event_scheduler = ON;

-- Disable event scheduler
SET GLOBAL event_scheduler = OFF;

-- * View events (list of events):
SHOW EVENTS;                          -- events of the current database
SHOW CREATE EVENT daily_cleanup;      -- full definition of one event
SELECT event_name, status, interval_value, interval_field, last_executed
FROM information_schema.EVENTS;       -- details, incl. last run time

-- * Alter an event (MySQL does have `ALTER EVENT`):
ALTER EVENT daily_cleanup
ON SCHEDULE EVERY 12 HOUR;

-- * Disable / enable an event:
ALTER EVENT event_name DISABLE;
ALTER EVENT event_name ENABLE;

-- * Delete (drop) an event:
DROP EVENT IF EXISTS daily_cleanup;

-- * Note: You can create multiple events in the same database, each with its own schedule. You need the `EVENT` privilege to create, alter or drop events.

-- ------------------------------------------------------------
-- 38.7 Differences Between Triggers and Events
-- ------------------------------------------------------------

-- (Point → EVENT | TRIGGER)
--
-- * What it is
--     - EVENT   : A scheduled task that runs at a defined time or interval, independent of table operations
--     - TRIGGER : An automatic action that fires when a table event (INSERT, UPDATE, DELETE) occurs
--
-- * When it runs
--     - EVENT   : At a specific time or repeating interval (like a cron job)
--     - TRIGGER : Immediately, in response to a data change
--
-- * Depends on
--     - EVENT   : The event scheduler (time), not on user activity
--     - TRIGGER : DML operations on a table
--
-- * Runs for
--     - EVENT   : Once per schedule
--     - TRIGGER : Once per affected row
--
-- * Use cases
--     - EVENT   : Purge old data periodically, recalculate summary tables, send scheduled reports
--     - TRIGGER : Maintain audit logs, enforce business rules, validate data automatically
--
-- * In one line
--     - EVENT   : Event = runs scheduled jobs at specific times
--     - TRIGGER : Trigger = reacts to data changes immediately
--

-- ------------------------------------------------------------
-- 38.8 When to Use a One-Time Event vs a Recurring Event
-- ------------------------------------------------------------

-- * One-time event: runs once at the scheduled date and time, then it is dropped automatically (default `ON COMPLETION NOT PRESERVE`; add `ON COMPLETION PRESERVE` to keep it after it runs).

--   * When to use a one-time event:

--     * One-off maintenance tasks,

--     * Migrating or initializing data,

--     * Temporary cleanups after a project phase,

--     * Sending a report only once.
CREATE EVENT archive_old_orders
ON SCHEDULE AT '2025-10-01 00:00:00'
DO
  INSERT INTO order_archive
  SELECT * FROM orders WHERE order_date < NOW() - INTERVAL 1 YEAR;

--   * Runs only once, on Oct 1, 2025, to archive old orders.

--   * Runs once only · Use case: temporary task · Disappears after running · e.g. archive old data on a specific date.

-- * Recurring event: runs repeatedly at fixed intervals (every hour, day, week, …).

--   * When to use a recurring event:

--     * Regular cleanups (e.g. delete old logs daily),

--     * Scheduled updates (e.g. refresh summary tables — MySQL's way to simulate materialized views),

--     * Automated tasks (e.g. queue reminder emails every Monday),

--     * System monitoring tasks (e.g. record table sizes every hour).
CREATE EVENT daily_cleanup
ON SCHEDULE EVERY 1 DAY
STARTS '2025-09-26 02:00:00'
DO
  DELETE FROM sessions WHERE last_activity < NOW() - INTERVAL 7 DAY;

--   * Runs repeatedly · Use case: regular/ongoing task · Continues until it is dropped, disabled or reaches its `ENDS` time · e.g. daily cleanup of expired sessions.

-- * Q1. Event vs trigger vs cron job?

--   * Answer: Event = runs on a schedule inside MySQL; trigger = runs on a data change; cron = runs on a schedule outside the database (can run scripts, send emails, call APIs).

-- * Q2. My event never runs — what do you check?

--   * Answer: `SHOW VARIABLES LIKE 'event_scheduler';` must be ON; the event must be ENABLED (`SHOW EVENTS`); check `STARTS`/`ENDS`; a one-time event in the past is dropped; the definer needs the right privileges.

-- * Q3. How do you run many statements in an event?

--   * Answer: `DO BEGIN ... END` with DELIMITER, or better `DO CALL procedure_name();`.

-- * Q4. Give a real use case of an event.

--   * Answer: Nightly: delete sessions older than 7 days, refresh a summary table (MySQL's replacement for materialized views), expire coupons.

-- ---

-- ======================================================================
-- 🎯 Practice Questions (salesdb sample data) — try first, then look at the answer
-- ======================================================================
-- Run 00-Setup-Sample-Data.sql once before this section.

USE salesdb;

-- Q1. Is the event scheduler on?
SHOW VARIABLES LIKE 'event_scheduler';

-- Q2. A daily job that copies delivered orders into a summary table.
CREATE TABLE daily_delivered (run_at DATETIME, delivered_count INT);
CREATE EVENT ev_daily_delivered
ON SCHEDULE EVERY 1 DAY
DO INSERT INTO daily_delivered
   SELECT NOW(), COUNT(*) FROM orders WHERE orderstatus = 'Delivered';
SHOW EVENTS;

-- Q3. Remove the job and table.
DROP EVENT IF EXISTS ev_daily_delivered;
DROP TABLE daily_delivered;
