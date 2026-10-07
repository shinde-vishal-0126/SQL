-- ======================================================================
-- Topic 38: Scheduled Jobs in PostgreSQL (pg_cron)
-- ======================================================================

-- ------------------------------------------------------------
-- 📖 In Simple Words
-- ------------------------------------------------------------

-- * Definition: A scheduled job (MySQL EVENT, PostgreSQL pg_cron) is SQL that the database runs automatically at a fixed time or interval.

-- * Real-life example: An alarm clock that also does a task, like "every night at 12, back up the data".

-- * 🧩 Syntax:
--     CREATE EXTENSION pg_cron;                      -- once, needs shared_preload_libraries
--     SELECT cron.schedule('job_name', 'min hour day month weekday', $$sql_statement$$);
--     SELECT * FROM cron.job;
--     SELECT cron.unschedule('job_name');

-- * Syntax explained (each part):
--   - Schedule → AT = once at a time; EVERY = repeat (MySQL). Cron text "0 0 * * *" = every day at 00:00 (pg_cron)
--   - DO / command → the SQL that runs automatically
--   - DISABLE / unschedule → stop the job

-- * Example on salesdb (run 00-Setup-Sample-Data.sql first):
SET search_path TO sales;
-- With pg_cron installed:
-- SELECT cron.schedule('snapshot', '0 0 * * *',
--   $$INSERT INTO sales.status_snapshot SELECT now(), COUNT(*) FROM sales.orders WHERE orderstatus = 'Shipped'$$);
-- What the job would do each night:
CREATE TABLE status_snapshot (taken_at TIMESTAMP, shipped INT);
INSERT INTO status_snapshot SELECT now(), COUNT(*) FROM orders WHERE orderstatus = 'Shipped';
SELECT * FROM status_snapshot;
DROP TABLE status_snapshot;

-- * Example explained (step by step):
--   1. The job counts shipped orders and saves the number with the time.
--   2. EVERY 1 DAY (or cron '0 0 * * *') means it runs automatically once a day.
--   3. Today the count is 5 shipped orders. The demo objects are dropped at the end.

-- > 🐘 Important: PostgreSQL has NO built-in `CREATE EVENT` like MySQL. Scheduled jobs are done with the `pg_cron` extension (most popular; available on AWS RDS, Azure, Google Cloud SQL, Supabase), or with an outside scheduler (Linux cron / Windows Task Scheduler running `psql`, pgAgent, or the application). This topic uses `pg_cron`.

-- ------------------------------------------------------------
-- 38.1 What is a Scheduled Job (MySQL "Event")?
-- ------------------------------------------------------------

-- * A scheduled job is a task that the database server runs automatically at a defined time or at a repeating interval.

-- * It is similar to a cron job in Linux or a scheduled task in Windows. With `pg_cron` it runs inside the PostgreSQL server, using the same cron syntax as Linux.

-- * A job has two parts: its schedule (when it runs — a cron expression) and its command (what SQL it runs).

-- * Triggers fire on data events (`INSERT`, `UPDATE`, `DELETE`); scheduled jobs are totally different — they are about time.

-- * Example: like setting an alarm on your phone — at 4:30 am once, or every day at 5:30 am.

-- ------------------------------------------------------------
-- 38.2 Purpose of Scheduled Jobs
-- ------------------------------------------------------------

-- * Automate repetitive tasks.

-- * Run queries or stored procedures at specific times.

-- * Keep the schedule next to the data (no separate server needed).

-- ------------------------------------------------------------
-- 38.3 Setup and Use Cases
-- ------------------------------------------------------------

-- * One-time setup of `pg_cron`:
-- 1. in postgresql.conf (then restart the server):
--    shared_preload_libraries = 'pg_cron'
--    cron.database_name = 'salesdb'          -- the database that stores the job list

-- 2. in that database:
CREATE EXTENSION pg_cron;

-- * Use cases:

--   * Auto-delete old logs – e.g. delete logs older than 30 days.

--   * Daily sales summary – save the total sales of the day into a `sales_summary` table every night.

--   * Reset login attempts – reset the failed-login counter of all users every night.

--   * Auto-expire discount codes – mark expired coupon codes as inactive.

--   * Refresh materialized views – `REFRESH MATERIALIZED VIEW CONCURRENTLY ...` every hour.

--   * Database maintenance – `VACUUM ANALYZE` of a busy table at night.

SELECT cron.schedule(
    'daily-sales-summary',                 -- job name
    '55 23 * * *',                         -- every day at 23:55
    $$INSERT INTO sales_summary (summary_date, total_sales)
      SELECT CURRENT_DATE, COALESCE(SUM(sales), 0)
      FROM orders
      WHERE orderdate::DATE = CURRENT_DATE$$
);

-- ------------------------------------------------------------
-- 38.4 Cron Schedule Syntax & Types (One-Time vs Recurring)
-- ------------------------------------------------------------

-- * Cron expression = 5 fields: `minute hour day-of-month month day-of-week`

-- | Expression | Meaning |
-- | :--- | :--- |
-- | `0 2 * * *` | Every day at 02:00 |
-- | `*/15 * * * *` | Every 15 minutes |
-- | `0 * * * *` | Every hour |
-- | `0 9 * * 1` | Every Monday at 09:00 |
-- | `0 0 1 * *` | First day of every month at midnight |
-- | `30 seconds` | Every 30 seconds (pg_cron 1.5+) |

-- * Times are in UTC by default (setting `cron.timezone`). India 02:00 IST = `30 20 * * *` UTC.

-- * Type 1 – Recurring job (the normal case):
SELECT cron.schedule('job-name', '0 2 * * *', 'SQL statement');

-- * Type 2 – One-time job: pg_cron has no `AT 'date'`. Schedule it for that date and let the job remove itself (or remove it manually):
-- runs at 00:00 on 1 October (it would repeat every year, so the command unschedules itself)
SELECT cron.schedule('archive-once', '0 0 1 10 *',
    $$CALL archive_old_orders(); SELECT cron.unschedule('archive-once')$$);

--   * For a real "run once at this exact time", many teams simply use an outside scheduler or `pg_cron` + a check on the date.

-- ------------------------------------------------------------
-- 38.5 Why We Use Jobs & How to Create Them
-- ------------------------------------------------------------

-- * A scheduled job = runs SQL statements automatically at a specified time or interval.

-- * One-time cleanup (MySQL example: delete logs older than 30 days on 1 Oct 2025):
SELECT cron.schedule('delete-old-logs-once', '0 0 1 10 *',
    $$DELETE FROM logs WHERE log_date < now() - INTERVAL '30 days';
      SELECT cron.unschedule('delete-old-logs-once')$$);

-- * Recurring job:
SELECT cron.schedule('daily-cleanup', '0 2 * * *',
    $$DELETE FROM sessions WHERE last_activity < now() - INTERVAL '7 days'$$);

--   * This runs every day at 02:00 (UTC) and removes sessions inactive for more than 7 days.

-- * Job with several statements → put them in a procedure and `CALL` it (cleanest):
CREATE OR REPLACE PROCEDURE nightly_maintenance()
LANGUAGE plpgsql
AS $$
BEGIN
    DELETE FROM sessions WHERE last_activity < now() - INTERVAL '7 days';
    UPDATE users SET failed_logins = 0;
    UPDATE coupons SET is_active = FALSE WHERE expiry_date < CURRENT_DATE;
END;
$$;

SELECT cron.schedule('nightly-maintenance', '0 3 * * *', 'CALL nightly_maintenance()');

-- or a procedure from Topic 35
SELECT cron.schedule('archive-orders-nightly', '0 1 * * *', 'CALL archive_old_orders()');

-- ------------------------------------------------------------
-- 38.6 Managing Jobs (List, Change, Disable, Delete, History)
-- ------------------------------------------------------------

-- * Jobs run only when `pg_cron` is loaded (`shared_preload_libraries`) and the extension is created.
SHOW shared_preload_libraries;      -- must contain pg_cron

-- * View jobs (list):
SELECT jobid, jobname, schedule, command, active FROM cron.job;

-- * Run history (last runs, status, errors — MySQL has no such table):
SELECT jobid, status, return_message, start_time, end_time
FROM cron.job_run_details
ORDER BY start_time DESC
LIMIT 20;

-- * Change a job's schedule (MySQL `ALTER EVENT ... ON SCHEDULE`):
SELECT cron.alter_job(job_id := (SELECT jobid FROM cron.job WHERE jobname = 'daily-cleanup'),
                      schedule := '0 */12 * * *');     -- every 12 hours

-- or simply schedule again with the same name (replaces it):
SELECT cron.schedule('daily-cleanup', '0 */12 * * *',
    $$DELETE FROM sessions WHERE last_activity < now() - INTERVAL '7 days'$$);

-- * Disable / enable a job:
SELECT cron.alter_job(job_id := 3, active := false);
SELECT cron.alter_job(job_id := 3, active := true);

-- * Delete a job (MySQL `DROP EVENT`):
SELECT cron.unschedule('daily-cleanup');

-- * Note: Run jobs in another database with `cron.schedule_in_database('name', 'schedule', 'SQL', 'other_db')`.

-- ------------------------------------------------------------
-- 38.7 Differences Between Triggers and Scheduled Jobs
-- ------------------------------------------------------------

-- | Point | SCHEDULED JOB (pg_cron) | TRIGGER |
-- | :--- | :--- | :--- |
-- | What it is | A task that runs at a defined time or interval, independent of table operations | An automatic action that fires when a table event (`INSERT`, `UPDATE`, `DELETE`, `TRUNCATE`) occurs |
-- | When it runs | At a specific time or repeating interval (cron) | Immediately, in response to a data change |
-- | Depends on | The pg_cron background worker (time) | DML operations on a table |
-- | Runs for | Once per schedule | Once per affected row (or per statement) |
-- | Use cases | Purge old data, refresh materialized views, nightly reports | Audit logs, business rules, validation |
-- | In one line | Job = runs at specific times | Trigger = reacts to data changes immediately |

-- ------------------------------------------------------------
-- 38.8 When to Use a One-Time Job vs a Recurring Job
-- ------------------------------------------------------------

-- * One-time job: runs once, then it should be removed (`cron.unschedule`).

--   * When to use: one-off maintenance, migrating or initializing data, temporary cleanups, sending a report only once.
SELECT cron.schedule('archive-old-orders-once', '0 0 1 10 *',
    $$INSERT INTO order_archive
      SELECT * FROM orders WHERE order_date < now() - INTERVAL '1 year';
      SELECT cron.unschedule('archive-old-orders-once')$$);

--   * Runs on Oct 1 at midnight, archives old orders, then removes itself.

--   * Tip: for a truly one-off job, it is often simpler to just run the SQL manually or from a deployment script.

-- * Recurring job: runs repeatedly at fixed intervals (every hour, day, week, …).

--   * When to use: regular cleanups, refreshing materialized views (`REFRESH MATERIALIZED VIEW CONCURRENTLY mv_monthly_sales`), weekly reminders, hourly monitoring (record table sizes with `pg_total_relation_size`).
SELECT cron.schedule('daily-cleanup', '0 2 * * *',
    $$DELETE FROM sessions WHERE last_activity < now() - INTERVAL '7 days'$$);

SELECT cron.schedule('refresh-monthly-sales', '0 * * * *',
    'REFRESH MATERIALIZED VIEW CONCURRENTLY mv_monthly_sales');

--   * Runs repeatedly until it is unscheduled or disabled.

-- * Q1. Does PostgreSQL have events like MySQL? How do you schedule jobs?

--   * Answer: No built-in events. Use the `pg_cron` extension (cron syntax, runs inside the server), pgAgent, or an external scheduler (Linux cron / Kubernetes CronJob / app scheduler) that connects with `psql`.

-- * Q2. My pg_cron job never runs — what do you check?

--   * Answer: `pg_cron` is in `shared_preload_libraries` and the server was restarted; the job exists and `active = true` in `cron.job`; the schedule is in UTC (`cron.timezone`); check `cron.job_run_details` for errors; the job runs as the user who created it — that user needs the right privileges.

-- * Q3. How do you run many statements in a job?

--   * Answer: Put them in a procedure and schedule `'CALL procedure_name()'`.

-- * Q4. Give a real use case of a scheduled job.

--   * Answer: Nightly: delete sessions older than 7 days, `REFRESH MATERIALIZED VIEW CONCURRENTLY`, expire coupons, `VACUUM ANALYZE` a big table, partition maintenance (create next month's partition).

-- * Setup: `shared_preload_libraries = 'pg_cron'` + restart + `CREATE EXTENSION pg_cron;`.

-- ---

-- ======================================================================
-- 🎯 Practice Questions (salesdb sample data) — try first, then look at the answer
-- ======================================================================
-- Run 00-Setup-Sample-Data.sql once before this section.

SET search_path TO sales;

-- Q1. Is the event scheduler on?
-- pg_cron must be installed and listed in shared_preload_libraries:
SELECT * FROM pg_available_extensions WHERE name = 'pg_cron';

-- Q2. A daily job that copies delivered orders into a summary table.
-- Needs pg_cron (CREATE EXTENSION pg_cron; in the cron database):
-- CREATE TABLE sales.daily_delivered (run_at TIMESTAMP, delivered_count INT);
-- SELECT cron.schedule('daily_delivered', '0 0 * * *',
--   $$INSERT INTO sales.daily_delivered SELECT now(), COUNT(*) FROM sales.orders WHERE orderstatus = 'Delivered'$$);
-- SELECT * FROM cron.job;
-- Same job without pg_cron, run by hand:
CREATE TABLE daily_delivered (run_at TIMESTAMP, delivered_count INT);
INSERT INTO daily_delivered SELECT now(), COUNT(*) FROM orders WHERE orderstatus = 'Delivered';
SELECT * FROM daily_delivered;

-- Q3. Remove the job and table.
-- SELECT cron.unschedule('daily_delivered');
DROP TABLE daily_delivered;
