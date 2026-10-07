-- ======================================================================
-- Topic 19: Locks in MySQL (InnoDB Locking)
-- ======================================================================

-- ------------------------------------------------------------
-- 📖 In Simple Words
-- ------------------------------------------------------------

-- * Definition: A lock is a temporary "in use" mark the database puts on rows or tables so two transactions do not change the same data at the same time.

-- * Real-life example: Like a "Do not disturb" sign on a hotel room door.

-- * 🧩 Syntax:
--     SELECT ... FOR SHARE;                  -- shared (read) lock
--     SELECT ... FOR UPDATE [NOWAIT | SKIP LOCKED];   -- exclusive (write) lock
--     LOCK TABLES t READ | WRITE;  UNLOCK TABLES;

-- * Syntax explained (each part):
--   - FOR SHARE → others can read but not change the rows
--   - FOR UPDATE → only you can change the rows until COMMIT/ROLLBACK
--   - NOWAIT → error immediately if locked
--   - SKIP LOCKED → skip rows someone else has locked

-- * Example on salesdb (run 00-Setup-Sample-Data.sql first):
USE salesdb;
START TRANSACTION;
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

-- * A lock is a marker the database puts on data (a row, a range or a table) so that other transactions cannot change it in a conflicting way at the same time.

-- * Without locks we get problems like lost updates: two users read balance = 1000, both add 500, both write 1500 → one update is lost (correct answer 2000).

-- * Locks are the tool that implements Isolation from ACID (see Topic 16) and the isolation levels (see Topic 17).

-- * InnoDB locks are taken automatically by `UPDATE`, `DELETE`, `INSERT` and locking reads, and are held until COMMIT or ROLLBACK.

-- ------------------------------------------------------------
-- 19.2 Shared (S) vs Exclusive (X) Locks
-- ------------------------------------------------------------

-- * Shared lock (S / read lock): many transactions can hold it together; they can read but nobody can change the row.

-- * Exclusive lock (X / write lock): only one transaction can hold it; others can neither take S nor X on that row.

-- * Compatibility matrix:

-- (Requested ↓ / Held → → S (Shared) | X (Exclusive))
--
-- * S (Shared)
--     - S (Shared)    : ✅ Compatible
--     - X (Exclusive) : ❌ Wait
--
-- * X (Exclusive)
--     - S (Shared)    : ❌ Wait
--     - X (Exclusive) : ❌ Wait
--

-- * A normal `SELECT` in InnoDB takes no lock — it reads a consistent snapshot (MVCC). Only locking reads (`FOR SHARE`, `FOR UPDATE`) and writes take row locks.

-- >

-- ------------------------------------------------------------
-- 19.3 Row-Level vs Table-Level Locks
-- ------------------------------------------------------------

-- (Feature → Row-level lock | Table-level lock)
--
-- * What is locked
--     - Row-level lock   : Only the affected rows (index records)
--     - Table-level lock : The whole table
--
-- * Concurrency
--     - Row-level lock   : High — others work on other rows
--     - Table-level lock : Low — everyone waits
--
-- * Used by
--     - Row-level lock   : InnoDB (default)
--     - Table-level lock : MyISAM, LOCK TABLES, some DDL
--
-- * Overhead
--     - Row-level lock   : More locks to manage
--     - Table-level lock : Very small
--

-- * Explicit table locks:
LOCK TABLES accounts WRITE, branches READ;
-- only these tables can be used in this session now
UPDATE accounts SET balance = balance + 100 WHERE account_id = 1;
UNLOCK TABLES;

-- * ⚠️ InnoDB locks index records. If the `WHERE` column has no index, InnoDB scans and locks every row it reads — almost like a table lock. Always index columns used in `UPDATE ... WHERE`.

-- ------------------------------------------------------------
-- 19.4 Locking Reads: SELECT ... FOR UPDATE / FOR SHARE
-- ------------------------------------------------------------

-- * **`SELECT ... FOR UPDATE`** — reads rows and puts an X lock on them; use it when you will update them next (read-modify-write).

-- * **`SELECT ... FOR SHARE`** (older: `LOCK IN SHARE MODE`) — puts an S lock; others can read-lock but not change the rows.

-- * Example — safe money withdrawal:
START TRANSACTION;
SELECT balance FROM accounts WHERE account_id = 1 FOR UPDATE;  -- row locked
-- application checks balance >= 500
UPDATE accounts SET balance = balance - 500 WHERE account_id = 1;
COMMIT;                                                        -- lock released

--   * A second session running the same `SELECT ... FOR UPDATE` on account 1 waits until the first one commits, so it sees the new balance.

-- * **`NOWAIT` and `SKIP LOCKED` (MySQL 8.0+):**
-- fail immediately instead of waiting
SELECT * FROM seats WHERE seat_id = 12 FOR UPDATE NOWAIT;

-- job-queue pattern: each worker takes a different free job
START TRANSACTION;
SELECT job_id FROM jobs
WHERE status = 'PENDING'
ORDER BY job_id
LIMIT 1
FOR UPDATE SKIP LOCKED;
-- UPDATE jobs SET status = 'RUNNING' WHERE job_id = ...;
COMMIT;

-- ------------------------------------------------------------
-- 19.5 Record, Gap and Next-Key Locks (Phantom Protection)
-- ------------------------------------------------------------

-- * Record lock: locks one index record (e.g. `id = 10`).

-- * Gap lock: locks the gap between index records so no new row can be inserted there (e.g. between 10 and 20).

-- * Next-key lock: record lock + gap lock before it. This is InnoDB's default in REPEATABLE READ and it prevents phantom rows.

-- * Example: table `emp` has ids 10, 20, 30.
-- Session 1 (REPEATABLE READ)
START TRANSACTION;
SELECT * FROM emp WHERE id BETWEEN 10 AND 20 FOR UPDATE;

-- Session 2
INSERT INTO emp (id, name) VALUES (15, 'New');   -- WAITS (gap 10–20 is locked)
INSERT INTO emp (id, name) VALUES (35, 'Other'); -- runs (gap after 30 is not locked by this range)

-- * An equality search on a unique index (`WHERE id = 10`) locks only that record — no gap lock.

-- * In READ COMMITTED, gap locks are mostly turned off (fewer waits, but phantoms are possible).

-- ------------------------------------------------------------
-- 19.6 Intention Locks and Metadata Locks
-- ------------------------------------------------------------

-- * Intention locks (IS, IX): table-level flags that say "this transaction holds (or wants) S/X locks on some rows". They let MySQL quickly check whether a table lock (`LOCK TABLES ... WRITE`) can be granted without checking every row. They do not block normal row locks.

-- * Metadata lock (MDL): protects the table structure. A running transaction that has used a table holds an MDL on it, so `ALTER TABLE` / `DROP TABLE` must wait.
-- Session 1
START TRANSACTION;
SELECT * FROM orders WHERE order_id = 1;   -- holds MDL on orders until COMMIT

-- Session 2
ALTER TABLE orders ADD COLUMN note VARCHAR(100);  -- "Waiting for table metadata lock"

--   * Every new query on `orders` then queues behind the waiting `ALTER` — a common production outage. Keep transactions short, and check long-running ones before DDL.

-- ------------------------------------------------------------
-- 19.7 Optimistic vs Pessimistic Locking
-- ------------------------------------------------------------

-- (Feature → Pessimistic locking | Optimistic locking)
--
-- * Idea
--     - Pessimistic locking : "Conflict is likely — lock first"
--     - Optimistic locking  : "Conflict is rare — check at save time"
--
-- * How
--     - Pessimistic locking : SELECT ... FOR UPDATE then UPDATE
--     - Optimistic locking  : version (or updated_at) column checked in UPDATE
--
-- * Waiting
--     - Pessimistic locking : Others wait for the lock
--     - Optimistic locking  : No waiting; the loser retries
--
-- * Best for
--     - Pessimistic locking : High contention, short transactions (bank balance, seat booking)
--     - Optimistic locking  : Low contention, long user think time (editing a profile/form)
--

-- * Optimistic locking with a version column:
-- 1. read (no lock)
SELECT product_id, stock, version FROM products WHERE product_id = 7;
-- returns stock = 10, version = 3

-- 2. update only if nobody changed it meanwhile
UPDATE products
SET stock = 9, version = version + 1
WHERE product_id = 7 AND version = 3;
-- 1 row affected → success
-- 0 rows affected → someone else updated first → read again and retry

-- >

-- ------------------------------------------------------------
-- 19.8 Lock Wait Timeout and Monitoring Locks
-- ------------------------------------------------------------

-- * If a transaction waits too long for a lock, MySQL raises error 1205: `Lock wait timeout exceeded; try restarting transaction`. Default wait is `innodb_lock_wait_timeout = 50` seconds.
SET SESSION innodb_lock_wait_timeout = 10;  -- wait at most 10 seconds

--   * Error 1205 rolls back only the statement by default, not the whole transaction — the application should roll back and retry.

-- * A deadlock (error 1213) is different: two transactions wait for each other, and InnoDB rolls one back immediately (see Topic 18).

-- * Who is locking what (MySQL 8.0):
-- current locks
SELECT engine_transaction_id, object_name, index_name, lock_type, lock_mode, lock_status, lock_data
FROM performance_schema.data_locks;

-- who is waiting for whom
SELECT * FROM sys.innodb_lock_waits;

-- open transactions and how long they have run
SELECT trx_id, trx_state, trx_started, trx_mysql_thread_id, trx_query
FROM information_schema.innodb_trx;

-- last deadlock and lock details
SHOW ENGINE INNODB STATUS;

--   * To stop a blocking session: `KILL <trx_mysql_thread_id>;`

-- * Best practices: keep transactions short, index the `WHERE` columns of updates, access tables/rows in the same order, don't wait for user input inside a transaction, and prefer `SKIP LOCKED` for queues.

-- ------------------------------------------------------------
-- 19.9 MVCC (Multi-Version Concurrency Control)
-- ------------------------------------------------------------

-- * Problem: if every read took a shared lock, readers and writers would keep blocking each other.

-- * MVCC idea: InnoDB keeps old versions of changed rows (in the undo log). A normal `SELECT` reads the version that was committed at the right moment, so readers don't block writers and writers don't block readers.

-- * How it works:

--   1. Every row has hidden columns: `DB_TRX_ID` (the transaction that last changed it) and `DB_ROLL_PTR` (a pointer to its previous version in the undo log).

--   2. When a consistent read starts, InnoDB creates a read view — the list of transactions that were still uncommitted at that time.

--   3. For each row, if its version is not visible to the read view, InnoDB follows the roll pointer back through the undo log to an older committed version.

-- * Isolation level decides when the read view is made:

--   * REPEATABLE READ (default): one read view at the first read of the transaction → the same snapshot for the whole transaction.

--   * READ COMMITTED: a new read view for every statement → each SELECT sees the latest committed data.

-- * Example:
-- Session A (REPEATABLE READ)
START TRANSACTION;
SELECT balance FROM accounts WHERE account_id = 1;   -- 1000 (snapshot taken)

-- Session B
UPDATE accounts SET balance = 500 WHERE account_id = 1;
COMMIT;                                              -- no wait: A holds no lock

-- Session A
SELECT balance FROM accounts WHERE account_id = 1;   -- still 1000 (old version from undo log)
SELECT balance FROM accounts WHERE account_id = 1 FOR UPDATE;  -- 500 (locking read = latest version)
COMMIT;
SELECT balance FROM accounts WHERE account_id = 1;   -- 500

-- * Important points:

--   * MVCC works only for plain (consistent) SELECTs. `UPDATE`, `DELETE` and `SELECT ... FOR UPDATE / FOR SHARE` read the latest version and take locks.

--   * Old versions are removed by the purge thread only when no read view needs them anymore. A long-running transaction stops the purge, so the undo log grows (watch "History list length" in `SHOW ENGINE INNODB STATUS`).

--   * `READ UNCOMMITTED` does not use MVCC snapshots (dirty reads); `SERIALIZABLE` turns plain SELECTs into `FOR SHARE` when autocommit is off.

-- >

-- * Q1. Difference between shared and exclusive locks?

--   * Answer: S locks can be held by many transactions for reading; an X lock is held by one transaction for writing and blocks both S and X from others.

-- * Q2. Does a plain SELECT lock rows in InnoDB?

--   * Answer: No. It reads a consistent snapshot using MVCC. Only `FOR SHARE` / `FOR UPDATE` and DML take row locks.

-- * **Q3. What is `SELECT ... FOR UPDATE` used for?**

--   * Answer: Read-modify-write safety: it X-locks the selected rows so no one else can change them until COMMIT (bank withdrawal, seat booking, inventory).

-- * Q4. What are gap and next-key locks?

--   * Answer: A gap lock blocks inserts into a range between index records; a next-key lock is record + gap. InnoDB uses them in REPEATABLE READ to prevent phantom rows.

-- * Q5. Optimistic vs pessimistic locking?

--   * Answer: Pessimistic locks before working (`FOR UPDATE`); optimistic doesn't lock but checks a version column when saving and retries on conflict.

-- * Q6. Why can an UPDATE lock the whole table in InnoDB?

--   * Answer: When the `WHERE` column isn't indexed, InnoDB must scan and lock every row it examines.

-- * Q7. Lock wait timeout vs deadlock?

--   * Answer: Timeout (1205) = waited longer than `innodb_lock_wait_timeout`; deadlock (1213) = circular wait, detected immediately and one transaction is rolled back.

-- * Locking reads: `FOR UPDATE` (X), `FOR SHARE` (S), `NOWAIT`, `SKIP LOCKED` (job queue).

-- * Optimistic vs Pessimistic: version column vs `FOR UPDATE`.

-- * Monitoring: error 1205 (timeout), 1213 (deadlock), `performance_schema.data_locks`, `sys.innodb_lock_waits`, `SHOW ENGINE INNODB STATUS`.

-- ---

-- ======================================================================
-- 🎯 Practice Questions (salesdb sample data) — try first, then look at the answer
-- ======================================================================
-- Run 00-Setup-Sample-Data.sql once before this section.

USE salesdb;

-- Q1. Shared lock: read a row and block others from changing it.
START TRANSACTION;
SELECT * FROM products WHERE productid = 101 FOR SHARE;
ROLLBACK;

-- Q2. Skip rows that someone else has locked (job-queue style).
START TRANSACTION;
SELECT orderid FROM orders WHERE orderstatus = 'Shipped' ORDER BY orderid LIMIT 1 FOR UPDATE SKIP LOCKED;
ROLLBACK;

-- Q3. See the current locks.
SELECT object_name, lock_type, lock_mode, lock_status
FROM performance_schema.data_locks;
