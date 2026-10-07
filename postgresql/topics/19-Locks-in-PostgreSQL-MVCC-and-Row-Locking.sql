-- ======================================================================
-- Topic 19: Locks in PostgreSQL (MVCC & Row Locking)
-- ======================================================================

-- ------------------------------------------------------------
-- 📖 In Simple Words
-- ------------------------------------------------------------

-- * Definition: A lock is a temporary "in use" mark the database puts on rows or tables so two transactions do not change the same data at the same time.

-- * Real-life example: Like a "Do not disturb" sign on a hotel room door.

-- * Example on salesdb (run 00-Setup-Sample-Data.sql first):
SET search_path TO sales;
BEGIN;
SELECT * FROM products WHERE productid = 101 FOR UPDATE;
UPDATE products SET price = price + 1 WHERE productid = 101;
ROLLBACK;

-- * Example explained (step by step):
--   1. FOR UPDATE locks the Bottle row: other sessions that try to change it must wait.
--   2. We safely change the price while holding the lock.
--   3. ROLLBACK ends the transaction, undoes the change and releases the lock.

-- ------------------------------------------------------------
-- 19.1 What is a Lock and Why Do We Need It?
-- ------------------------------------------------------------

-- * A lock is a marker the database puts on data (a row or a table) so that other transactions cannot change it in a conflicting way at the same time.

-- * Without locks we get problems like lost updates: two users read balance = 1000, both add 500, both write 1500 → one update is lost (correct answer 2000).

-- * Locks (together with MVCC snapshots) implement Isolation from ACID (see Topic 16) and the isolation levels (see Topic 15).

-- * PostgreSQL takes locks automatically for `UPDATE`, `DELETE`, `INSERT` (on unique keys), DDL and locking reads, and holds them until COMMIT or ROLLBACK.

-- ------------------------------------------------------------
-- 19.2 Shared vs Exclusive Locks (Row Lock Modes in PostgreSQL)
-- ------------------------------------------------------------

-- * Shared lock (read lock): many transactions can hold it together; they can read but nobody can change the row.

-- * Exclusive lock (write lock): only one transaction can hold it; others can neither take a shared nor an exclusive lock on that row.

-- * PostgreSQL has 4 row lock modes (from weakest to strongest):

-- | Row lock mode | Taken by | Blocks |
-- | :--- | :--- | :--- |
-- | `FOR KEY SHARE` | Foreign key checks (inserting a child row) | Only `FOR UPDATE` (deleting the parent / changing its key) |
-- | `FOR SHARE` | `SELECT ... FOR SHARE` | `UPDATE`, `DELETE`, `FOR NO KEY UPDATE`, `FOR UPDATE` |
-- | `FOR NO KEY UPDATE` | Normal `UPDATE` that does not change a key column | Other updates and `FOR SHARE` / `FOR UPDATE` |
-- | `FOR UPDATE` | `SELECT ... FOR UPDATE`, `DELETE`, `UPDATE` of a key column | Everything except plain `SELECT` |

-- * Simple compatibility matrix (Shared = `FOR SHARE`, Exclusive = `FOR UPDATE`):

-- | Requested ↓ / Held → | S (Shared) | X (Exclusive) |
-- | :--- | :--- | :--- |
-- | S (Shared) | ✅ Compatible | ❌ Wait |
-- | X (Exclusive) | ❌ Wait | ❌ Wait |

-- * A normal `SELECT` in PostgreSQL takes no row lock — it reads a snapshot (MVCC). It is never blocked by writers, and never blocks writers.

-- >

-- ------------------------------------------------------------
-- 19.3 Row-Level vs Table-Level Locks
-- ------------------------------------------------------------

-- | Feature | Row-level lock | Table-level lock |
-- | :--- | :--- | :--- |
-- | What is locked | Only the affected rows | The whole table |
-- | Concurrency | High — others work on other rows | Depends on the lock mode |
-- | Used by | `UPDATE`, `DELETE`, `SELECT ... FOR UPDATE` | Every statement (light modes), DDL, `LOCK TABLE` |
-- | Where stored | In the row itself (`xmax`), not in memory | In the shared lock table (`pg_locks`) |

-- * PostgreSQL has 8 table lock modes. Every query takes one (most are light):

-- | Table lock mode | Taken by | Conflicts with (main ones) |
-- | :--- | :--- | :--- |
-- | `ACCESS SHARE` | `SELECT` | Only `ACCESS EXCLUSIVE` |
-- | `ROW SHARE` | `SELECT ... FOR UPDATE/SHARE` | `EXCLUSIVE`, `ACCESS EXCLUSIVE` |
-- | `ROW EXCLUSIVE` | `INSERT`, `UPDATE`, `DELETE`, `MERGE` | `SHARE` and stronger |
-- | `SHARE UPDATE EXCLUSIVE` | `VACUUM`, `ANALYZE`, `CREATE INDEX CONCURRENTLY` | Itself and stronger |
-- | `SHARE` | `CREATE INDEX` (normal) | Writes (`ROW EXCLUSIVE`) |
-- | `SHARE ROW EXCLUSIVE` | `CREATE TRIGGER` | Writes and itself |
-- | `EXCLUSIVE` | `REFRESH MATERIALIZED VIEW CONCURRENTLY` | Everything except `SELECT` |
-- | `ACCESS EXCLUSIVE` | `DROP`, `TRUNCATE`, most `ALTER TABLE`, `VACUUM FULL`, `LOCK TABLE` (default) | Everything, even `SELECT` |

-- * Explicit table locks (MySQL: `LOCK TABLES ... / UNLOCK TABLES`):
BEGIN;
LOCK TABLE accounts IN SHARE ROW EXCLUSIVE MODE;   -- others can read, nobody else can write
UPDATE accounts SET balance = balance + 100 WHERE account_id = 1;
COMMIT;   -- PostgreSQL has no UNLOCK TABLE; the lock ends with the transaction

-- * Good news vs MySQL: PostgreSQL locks only the rows it actually updates. Even if the `WHERE` column has no index (full table scan), rows that don't match are not locked. (Indexes are still needed for speed.)

-- ------------------------------------------------------------
-- 19.4 Locking Reads: SELECT ... FOR UPDATE / FOR SHARE
-- ------------------------------------------------------------

-- * `SELECT ... FOR UPDATE` — reads rows and locks them exclusively; use it when you will update them next (read-modify-write).

-- * `SELECT ... FOR SHARE` — shared lock; others can also take `FOR SHARE` but cannot change the rows.

-- * `FOR NO KEY UPDATE` — a lighter exclusive lock that does not block foreign key checks from child tables. Good when you will update non-key columns only.

-- * Example — safe money withdrawal:
BEGIN;
SELECT balance FROM accounts WHERE account_id = 1 FOR UPDATE;  -- row locked
-- application checks balance >= 500
UPDATE accounts SET balance = balance - 500 WHERE account_id = 1;
COMMIT;                                                        -- lock released

--   * A second session running the same `SELECT ... FOR UPDATE` on account 1 waits until the first one commits, then it sees the new balance (in READ COMMITTED).

-- * `NOWAIT` and `SKIP LOCKED`:
-- fail immediately instead of waiting
SELECT * FROM seats WHERE seat_id = 12 FOR UPDATE NOWAIT;
-- ERROR: could not obtain lock on row in relation "seats"

-- job-queue pattern: each worker takes a different free job
BEGIN;
SELECT job_id FROM jobs
WHERE status = 'PENDING'
ORDER BY job_id
LIMIT 1
FOR UPDATE SKIP LOCKED;
-- UPDATE jobs SET status = 'RUNNING' WHERE job_id = ...;
COMMIT;

-- PostgreSQL short version: pick and mark a job in ONE statement
UPDATE jobs SET status = 'RUNNING'
WHERE job_id = (
    SELECT job_id FROM jobs WHERE status = 'PENDING'
    ORDER BY job_id LIMIT 1
    FOR UPDATE SKIP LOCKED
)
RETURNING job_id;

-- ------------------------------------------------------------
-- 19.5 Phantom Protection in PostgreSQL (No Gap Locks)
-- ------------------------------------------------------------

-- * MySQL InnoDB uses record, gap and next-key locks to stop phantom rows. PostgreSQL does NOT have gap locks.

-- * How PostgreSQL handles phantoms instead:

--   * `REPEATABLE READ`: the transaction reads from one snapshot, so new rows inserted by others are simply invisible — no phantom reads, and no waiting.

--   * `SERIALIZABLE`: PostgreSQL uses predicate locks (`SIReadLock`) that never block anybody; they only detect conflicts and abort one transaction with SQLSTATE `40001`.

-- * Example: table `emp` has ids 10, 20, 30.
-- Session 1 (REPEATABLE READ)
BEGIN ISOLATION LEVEL REPEATABLE READ;
SELECT * FROM emp WHERE id BETWEEN 10 AND 20 FOR UPDATE;   -- locks rows 10 and 20 only

-- Session 2
INSERT INTO emp (id, name) VALUES (15, 'New');   -- runs immediately (no gap lock in PostgreSQL)
COMMIT;

-- Session 1
SELECT * FROM emp WHERE id BETWEEN 10 AND 20;    -- still 2 rows (snapshot) — no phantom

-- * To really stop such inserts, use a unique constraint, an `EXCLUDE` constraint, `SERIALIZABLE`, or an explicit table/advisory lock.

-- ------------------------------------------------------------
-- 19.6 Advisory Locks and DDL Locks
-- ------------------------------------------------------------

-- * Advisory locks (PostgreSQL extra): locks on a number that your application chooses. The database doesn't attach them to any row — your code decides what the number means.
-- Only one worker may run the "daily report" job at a time:
SELECT pg_try_advisory_lock(12345);      -- true = got the lock, false = someone else has it
-- ... do the job ...
SELECT pg_advisory_unlock(12345);

-- Transaction-level version (released at COMMIT/ROLLBACK automatically):
SELECT pg_advisory_xact_lock(12345);

-- * DDL lock (like MySQL's metadata lock): `ALTER TABLE` needs `ACCESS EXCLUSIVE`. If any open transaction has read the table, the `ALTER` waits — and every new query queues behind the waiting `ALTER`.
-- Session 1
BEGIN;
SELECT * FROM orders WHERE order_id = 1;   -- holds ACCESS SHARE on orders until COMMIT

-- Session 2
ALTER TABLE orders ADD COLUMN note VARCHAR(100);  -- waits for Session 1
-- Session 3
SELECT * FROM orders;                             -- also waits (queued behind the ALTER)!

--   * Production fix: always set a lock timeout before DDL, and retry:
SET lock_timeout = '3s';
ALTER TABLE orders ADD COLUMN note VARCHAR(100);

-- ------------------------------------------------------------
-- 19.7 Optimistic vs Pessimistic Locking
-- ------------------------------------------------------------

-- | Feature | Pessimistic locking | Optimistic locking |
-- | :--- | :--- | :--- |
-- | Idea | "Conflict is likely — lock first" | "Conflict is rare — check at save time" |
-- | How | `SELECT ... FOR UPDATE` then `UPDATE` | `version` (or `updated_at`, or `xmin`) column checked in `UPDATE` |
-- | Waiting | Others wait for the lock | No waiting; the loser retries |
-- | Best for | High contention, short transactions (bank balance, seat booking) | Low contention, long user think time (editing a profile/form) |

-- * Optimistic locking with a version column:
-- 1. read (no lock)
SELECT product_id, stock, version FROM products WHERE product_id = 7;
-- returns stock = 10, version = 3

-- 2. update only if nobody changed it meanwhile
UPDATE products
SET stock = 9, version = version + 1
WHERE product_id = 7 AND version = 3;
-- UPDATE 1 → success
-- UPDATE 0 → someone else updated first → read again and retry

-- >

-- ------------------------------------------------------------
-- 19.8 Lock Timeout and Monitoring Locks
-- ------------------------------------------------------------

-- * By default PostgreSQL waits forever for a lock (`lock_timeout = 0`). Set a limit:
SET lock_timeout = '10s';            -- wait at most 10 seconds for a lock
SET statement_timeout = '30s';       -- whole statement at most 30 seconds
-- ERROR: canceling statement due to lock timeout   (SQLSTATE 55P03)

--   * The error aborts the transaction (Topic 15.5) — the application should roll back and retry.

-- * A deadlock (`40P01`) is different: two transactions wait for each other, and PostgreSQL aborts one after `deadlock_timeout` (see Topic 18).

-- * Who is locking what:
-- current locks
SELECT pid, locktype, relation::regclass AS table_name, mode, granted
FROM pg_locks
WHERE relation IS NOT NULL;

-- who is waiting for whom
SELECT pid, pg_blocking_pids(pid) AS blocked_by, state, wait_event_type, query
FROM pg_stat_activity
WHERE cardinality(pg_blocking_pids(pid)) > 0;

-- open transactions and how long they have run
SELECT pid, usename, state, xact_start, now() - xact_start AS running_for, query
FROM pg_stat_activity
WHERE xact_start IS NOT NULL
ORDER BY xact_start;

--   * To stop a blocking session: `SELECT pg_cancel_backend(pid);` (cancel the query) or `SELECT pg_terminate_backend(pid);` (close the connection). MySQL: `KILL <id>;`

-- * Best practices: keep transactions short, never leave sessions "idle in transaction", access rows in the same order, set `lock_timeout` before DDL, and prefer `SKIP LOCKED` for queues.

-- ------------------------------------------------------------
-- 19.9 MVCC (Multi-Version Concurrency Control) in PostgreSQL
-- ------------------------------------------------------------

-- * Problem: if every read took a shared lock, readers and writers would keep blocking each other.

-- * MVCC idea: PostgreSQL keeps several versions of a row in the table itself. A normal `SELECT` reads the version that is visible to its snapshot, so readers don't block writers and writers don't block readers.

-- * How it works:

--   1. Every row version (called a tuple) has hidden columns: `xmin` (the transaction that created this version) and `xmax` (the transaction that deleted/updated it, or 0).

--   2. `UPDATE` = mark the old version with `xmax` + insert a new version with a new `xmin`. `DELETE` = only set `xmax`.

--   3. When a statement starts, PostgreSQL takes a snapshot — the list of transactions that were still running. A row version is visible if its `xmin` committed before the snapshot and its `xmax` did not.

--   4. Old (dead) versions stay in the table until `VACUUM` (usually autovacuum) removes them. MySQL instead keeps old versions in a separate undo log.
SELECT xmin, xmax, * FROM accounts WHERE account_id = 1;   -- you can see the hidden columns

-- * Isolation level decides when the snapshot is taken:

--   * READ COMMITTED (PostgreSQL default): a new snapshot for every statement → each SELECT sees the latest committed data.

--   * REPEATABLE READ: one snapshot at the first statement of the transaction → the same picture for the whole transaction.

-- * Example:
-- Session A (REPEATABLE READ)
BEGIN ISOLATION LEVEL REPEATABLE READ;
SELECT balance FROM accounts WHERE account_id = 1;   -- 1000 (snapshot taken)

-- Session B
UPDATE accounts SET balance = 500 WHERE account_id = 1;
COMMIT;                                              -- no wait: A holds no lock

-- Session A
SELECT balance FROM accounts WHERE account_id = 1;   -- still 1000 (old row version)
SELECT balance FROM accounts WHERE account_id = 1 FOR UPDATE;
-- ERROR: could not serialize access due to concurrent update
-- (in READ COMMITTED this would return 500 instead)
ROLLBACK;
SELECT balance FROM accounts WHERE account_id = 1;   -- 500

-- * Important points:

--   * MVCC works for plain SELECTs. `UPDATE`, `DELETE` and `SELECT ... FOR UPDATE / FOR SHARE` must work on the latest version and take row locks.

--   * In REPEATABLE READ / SERIALIZABLE, if the row you want to lock or update was changed by a newer committed transaction, PostgreSQL raises `could not serialize access` — retry the transaction. (MySQL would silently read the latest version.)

--   * Dead row versions make tables and indexes bigger ("bloat"). A long-running transaction stops `VACUUM` from removing them. Watch `n_dead_tup` in `pg_stat_user_tables`.

--   * Transaction IDs are 32-bit; `VACUUM` also "freezes" old rows so the ids can wrap around safely. Never disable autovacuum.

-- >

-- * Q1. Difference between shared and exclusive locks?

--   * Answer: Shared locks (`FOR SHARE`) can be held by many transactions for reading; an exclusive lock (`FOR UPDATE`) is held by one transaction for writing and blocks other locks on that row.

-- * Q2. Does a plain SELECT lock rows in PostgreSQL?

--   * Answer: No. It reads a snapshot using MVCC and takes only a light `ACCESS SHARE` table lock (which conflicts only with DDL like `DROP` / `ALTER`).

-- * Q3. What is `SELECT ... FOR UPDATE` used for?

--   * Answer: Read-modify-write safety: it locks the selected rows so no one else can change them until COMMIT (bank withdrawal, seat booking, inventory).

-- * Q4. Does PostgreSQL use gap / next-key locks?

--   * Answer: No. It prevents phantom reads with snapshots (REPEATABLE READ) and with non-blocking predicate locks (SERIALIZABLE).

-- * Q5. Optimistic vs pessimistic locking?

--   * Answer: Pessimistic locks before working (`FOR UPDATE`); optimistic doesn't lock but checks a version column when saving and retries on conflict.

-- * Q6. Why can an `ALTER TABLE` take the whole app down?

--   * Answer: It needs `ACCESS EXCLUSIVE`; while it waits for an old open transaction, all new queries on that table queue behind it. Use `SET lock_timeout` before DDL.

-- * Q7. Lock timeout vs deadlock?

--   * Answer: Lock timeout (`55P03`) = waited longer than `lock_timeout` (off by default); deadlock (`40P01`) = circular wait, detected after `deadlock_timeout` and one transaction is aborted.

-- * Row lock modes: `FOR KEY SHARE` < `FOR SHARE` < `FOR NO KEY UPDATE` < `FOR UPDATE`. Shared + Shared compatible.

-- * Locking reads: `FOR UPDATE`, `FOR SHARE`, `NOWAIT`, `SKIP LOCKED` (job queue).

-- * Optimistic vs Pessimistic: version column vs `FOR UPDATE`.

-- * Monitoring: `pg_locks`, `pg_stat_activity`, `pg_blocking_pids()`, `pg_terminate_backend()`; errors `55P03` (lock timeout), `40P01` (deadlock).

-- ---

-- ======================================================================
-- 🎯 Practice Questions (salesdb sample data) — try first, then look at the answer
-- ======================================================================
-- Run 00-Setup-Sample-Data.sql once before this section.

SET search_path TO sales;

-- Q1. Shared lock: read a row and block others from changing it.
BEGIN;
SELECT * FROM products WHERE productid = 101 FOR SHARE;
ROLLBACK;

-- Q2. Skip rows that someone else has locked (job-queue style).
BEGIN;
SELECT orderid FROM orders WHERE orderstatus = 'Shipped' ORDER BY orderid LIMIT 1 FOR UPDATE SKIP LOCKED;
ROLLBACK;

-- Q3. See the current locks.
SELECT locktype, relation::regclass, mode, granted FROM pg_locks WHERE relation IS NOT NULL;
