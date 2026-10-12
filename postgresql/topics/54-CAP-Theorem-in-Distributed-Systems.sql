-- ======================================================================
-- Topic 54: CAP Theorem in Distributed Systems
-- ======================================================================

-- * Definition: CAP Theorem says a distributed data system CANNOT guarantee
--   all three of these at the same time when a network partition happens:
--   1. C — Consistency
--   2. A — Availability
--   3. P — Partition Tolerance
-- * Key point: Partitions WILL happen in real networks, so P is not optional.
--   When a partition occurs, the system must choose between C and A.

-- * Real-life example: Two bank branches share one ledger by phone.
--   The phone line goes dead. Should a branch refuse withdrawals (C)
--   or keep paying out from its possibly old copy of the ledger (A)?

-- * 🧩 Syntax (SQL tools that relate to CAP choices in PostgreSQL):
--     BEGIN;                                               -- group changes atomically
--     UPDATE table_name SET col = value WHERE condition;
--     COMMIT;                                              -- make change durable & visible
--     BEGIN ISOLATION LEVEL <level>;                       -- how "consistent" reads are
--     SELECT ... FOR UPDATE;                               -- lock row for a safe read-modify-write
--     SET LOCAL synchronous_commit = 'remote_apply';       -- wait for standby, per transaction
--     SELECT * FROM pg_stat_replication;                   -- check standby lag (stale data risk)

-- * Syntax explained (each part):
--   - BEGIN / COMMIT      → all-or-nothing change on a single node (ACID)
--   - ISOLATION LEVEL     → READ COMMITTED (default), REPEATABLE READ, SERIALIZABLE
--   - FOR UPDATE          → locks the row so no one else changes it until COMMIT
--   - synchronous_commit  → off / local / remote_write / on / remote_apply
--   - pg_stat_replication → shows write/flush/replay lag; lag > 0 means standbys may serve stale reads

-- ------------------------------------------------------------
-- 54.1 The Three Properties
-- ------------------------------------------------------------
-- * C — Consistency
--     - Every successful read returns the LATEST completed write,
--       or an error if the system cannot safely return that value.
--     - Example: Wallet balance ₹1,000 → withdraw ₹200 → ₹800.
--       A read from ANY replica must not return the stale ₹1,000.
--     - Note: "C" in CAP (linearizability) ≠ "C" in ACID (constraints/rules hold).
--
-- * A — Availability
--     - Every request received by a working (non-failed) node gets a
--       valid, non-error response — even if the data might be stale.
--     - Example: A user opens their profile while replicas cannot talk;
--       the app still answers from the reachable node.
--
-- * P — Partition Tolerance
--     - The system keeps operating even if messages between nodes are
--       lost or delayed (network split).
--     - Example: Server A in Mumbai, Server B in Singapore; the link
--       between them fails, but both servers are still running.
--
-- * Remember the difference:
--     - Consistency         → Do I get the latest correct data?
--     - Availability        → Do I get a response at all?
--     - Partition tolerance → Can the system survive broken links between nodes?

-- 📊 Diagram: CAP triangle
/*
                     Consistency (C)
                          /\
                         /  \
                   CP   /    \   CA
                       /      \
                      /________\
      Partition (P)       AP        Availability (A)

   During a partition you can pick only ONE edge that includes P:
   CP (consistent, may refuse)  or  AP (answers, may be stale)
*/

-- ------------------------------------------------------------
-- 54.2 Real-World Example: Bank Account Transfer
-- ------------------------------------------------------------
-- * Step 1: Two replicas, both hold balance ₹1,000.
-- * Step 2: Network partition — the replicas cannot exchange updates.
-- * Step 3: Server A processes a ₹200 withdrawal → ₹800.
-- * Step 4: Server B still holds ₹1,000 and receives a balance request.
-- * Decision:
--     - CP approach → Server B refuses / waits (error or timeout, but never wrong data).
--     - AP approach → Server B answers ₹1,000 (fast response, but stale).

-- 📊 Diagram: Partition scenario
/*
     ┌──────────────┐      X  link broken  X      ┌──────────────┐
     │  Server A    │ ─────────────/ /──────────── │  Server B    │
     │  ₹1000 → ₹800│                              │  ₹1000 (old) │
     └──────┬───────┘                              └──────┬───────┘
            │ withdraw ₹200                               │ "What is my balance?"
         Client 1                                      Client 2
                                                          │
                                   ┌──────────────────────┴───────────────┐
                                   │ CP: return ERROR / wait              │
                                   │ AP: return ₹1000 (stale)             │
                                   └──────────────────────────────────────┘
*/

-- ------------------------------------------------------------
-- 54.3 CP vs AP vs CA
-- ------------------------------------------------------------
-- * CP — Consistency + Partition Tolerance ("Correctness first")
--     - Replicas cannot communicate → the system cannot confirm latest data
--       → some reads/writes are rejected or delayed.
--     - Examples: Apache ZooKeeper, etcd, HBase, MongoDB (majority write/read concern).
--     - Use cases: Distributed locks, leader election, config management, payments.
--
-- * AP — Availability + Partition Tolerance ("Response first")
--     - Each reachable replica keeps serving requests.
--     - Replicas sync after the link returns (eventual consistency),
--       using conflict resolution (last-write-wins, vector clocks, CRDTs).
--     - Examples: Apache Cassandra, Riak, Amazon DynamoDB (default eventual reads), CouchDB.
--     - Use cases: Shopping carts, activity feeds, likes/views counters, catalogs.
--
-- * CA — Consistency + Availability ("Limited scope")
--     - Only possible when partitions are NOT part of the picture:
--       a single-node database, or a cluster while the network is healthy.
--     - Under a real partition, a distributed system cannot keep both C and A.
--     - Example: A single PostgreSQL server — consistent transactions and answers while it is up.
--     - Use cases: Apps where one database instance is enough.
--
-- * Important: CP / AP describe behavior DURING a partition, not permanent labels.
--   Configuration (quorums, replication mode) and the operation itself change the behavior.

-- 📊 Diagram: Choosing a side
/*
   Network partition happens
             │
             ▼
   ┌─────────────────────────┐
   │ Can this node confirm   │
   │ it has the latest data? │
   └───────┬─────────┬───────┘
          yes        no
           │          │
           ▼          ▼
     answer normally   ┌──────────────┬──────────────┐
                       │ CP           │ AP           │
                       │ reject/wait  │ answer stale │
                       └──────────────┴──────────────┘
*/

-- ------------------------------------------------------------
-- 54.4 Beyond CAP: PACELC
-- ------------------------------------------------------------
-- * PACELC extends CAP:
--     - If Partition (P) → choose Availability (A) or Consistency (C)
--     - Else (E, normal operation) → choose Latency (L) or Consistency (C)
-- * Why it matters: Even with NO partition, synchronous replication (strong C)
--   adds latency; asynchronous replication is faster but replicas may lag.
-- * Examples:
--     - Cassandra / DynamoDB → PA/EL (available & low latency)
--     - ZooKeeper / etcd      → PC/EC (consistent always)
--     - PostgreSQL async standby → behaves EL (fast, standbys can lag)

-- ------------------------------------------------------------
-- 54.5 Consistency Models (from strongest to weakest)
-- ------------------------------------------------------------
-- * Linearizable / Strong → every read sees the latest write (CAP "C").
-- * Sequential           → all nodes see operations in the same order.
-- * Causal               → cause-and-effect order preserved (reply after post).
-- * Read-your-writes     → a user always sees their own updates.
-- * Eventual             → replicas converge "eventually" if writes stop.

-- ------------------------------------------------------------
-- 54.6 Where PostgreSQL Fits
-- ------------------------------------------------------------
-- * Single PostgreSQL server → ACID, strongly consistent ("CA" in practice, no partition).
-- * Streaming replication, asynchronous (default)
--     - Primary commits without waiting for standbys → standby reads can be STALE.
--     - On failover, recently committed writes may be LOST → leans AP / EL.
-- * Synchronous replication (synchronous_standby_names + synchronous_commit)
--     - synchronous_commit = on / remote_write → standby has flushed / received the WAL
--     - synchronous_commit = remote_apply      → standby has APPLIED it (read-your-writes on standby)
--     - If the sync standby is unreachable, commits WAIT → leans CP (consistency over availability).
--     - 'ANY 1 (s1, s2)' / 'FIRST 2 (s1, s2, s3)' → quorum / priority-based sync commit.
-- * HA tools (Patroni + etcd/Consul) use a CP consensus store to elect exactly
--   one primary and avoid split-brain.

-- * Example: Consistent read-modify-write on a single node (wallet withdrawal)
DROP TABLE IF EXISTS outbox, wallet_txn, wallets;

CREATE TABLE wallets (
    wallet_id INT PRIMARY KEY,
    owner     VARCHAR(50) NOT NULL,
    balance   NUMERIC(10,2) NOT NULL CHECK (balance >= 0)
);

INSERT INTO wallets VALUES (1, 'Asha', 1000.00);

BEGIN;
SELECT balance FROM wallets WHERE wallet_id = 1 FOR UPDATE;   -- lock: no one else can change it now
UPDATE wallets SET balance = balance - 200 WHERE wallet_id = 1;
COMMIT;

SELECT * FROM wallets;   -- 800.00 → every later read on this node sees the latest write

-- * Example explained (step by step):
--   1. FOR UPDATE locks the row so two withdrawals cannot both read ₹1,000.
--   2. UPDATE subtracts ₹200; CHECK (balance >= 0) blocks overdrafts.
--   3. COMMIT makes the change durable and visible — strong consistency on ONE node.
--   4. On an async standby the row may still show 1000.00 until WAL is replayed (AP-like read).

-- * Example: Choosing an isolation level (stronger = more consistent, may need retries)
BEGIN ISOLATION LEVEL SERIALIZABLE;
SHOW transaction_isolation;
COMMIT;                                  -- PostgreSQL default is READ COMMITTED
-- SERIALIZABLE may raise SQLSTATE 40001 (serialization_failure) → the app must retry.

-- * Example: Optimistic concurrency with a version column (common in microservices)
ALTER TABLE wallets ADD COLUMN version INT NOT NULL DEFAULT 0;

UPDATE wallets
SET balance = balance - 100, version = version + 1
WHERE wallet_id = 1 AND version = 0     -- succeeds only if no one changed the row meanwhile
RETURNING wallet_id, balance, version;  -- 0 rows returned = conflict → retry with fresh data

-- * Example: Idempotent operation (safe retries after a timeout during a partition)
CREATE TABLE wallet_txn (
    txn_id    VARCHAR(64) PRIMARY KEY,   -- idempotency key sent by the client
    wallet_id INT NOT NULL,
    amount    NUMERIC(10,2) NOT NULL
);

INSERT INTO wallet_txn VALUES ('req-abc-123', 1, 50.00) ON CONFLICT (txn_id) DO NOTHING;
INSERT INTO wallet_txn VALUES ('req-abc-123', 1, 50.00) ON CONFLICT (txn_id) DO NOTHING;  -- duplicate retry ignored
SELECT * FROM wallet_txn;

-- * Example: Stronger durability for ONE critical transaction only
BEGIN;
SET LOCAL synchronous_commit = 'remote_apply';   -- only matters when sync standbys are configured
UPDATE wallets SET balance = balance - 10 WHERE wallet_id = 1;
COMMIT;

-- * Replication monitoring (need privileges / a replication setup):
-- SELECT application_name, state, sync_state, replay_lag FROM pg_stat_replication;  -- on primary
-- SELECT pg_is_in_recovery();                                     -- true on a standby
-- SELECT now() - pg_last_xact_replay_timestamp() AS replica_lag;  -- on standby
-- SHOW synchronous_standby_names;
-- SHOW synchronous_commit;

-- ------------------------------------------------------------
-- 54.7 Where Redis, Kafka, and Others Fit
-- ------------------------------------------------------------
-- * Redis
--     - Replication is asynchronous; during failover, acknowledged writes can be lost
--       and replicas can serve stale data. WAIT command reduces (not removes) this risk.
--     - Typically used as a cache → leans AP.
-- * Apache Kafka
--     - Not simply CP or AP; depends on settings:
--         acks=all + min.insync.replicas=2 + unclean.leader.election.enable=false → leans CP
--         acks=1 or unclean leader election enabled → leans AP (possible data loss)
-- * MongoDB → majority write/read concern leans CP; weaker concerns lean AP.
-- * Cassandra → tunable: QUORUM reads + QUORUM writes (R + W > N) give strong reads.
-- * Quorum rule: N replicas, W write acks, R read acks → R + W > N ⇒ reads overlap latest write.

-- ------------------------------------------------------------
-- 54.8 CAP in Node.js Microservices
-- ------------------------------------------------------------
-- * Wallet / prize deduction   → Strong consistency (prevent double deductions)
-- * User profile display       → Availability OK (slightly stale is tolerable)
-- * Notification delivery      → Availability + eventual processing (retry later)
-- * Leader election / locks    → Consistency (two leaders = corruption)
-- * Product / topic catalog    → Availability (stale catalog for seconds is fine)
-- * These are DESIGN choices, not guarantees provided automatically by any technology.

-- 📊 Diagram: Typical microservice layout
/*
                 Client / API Gateway
                          │
       ┌──────────────────┼────────────────────┐
       ▼                  ▼                    ▼
   Auth Service      Core Service      Notification Service
       │                  │                    │
       ▼                  ▼                    ▼
   PostgreSQL       Postgres primary      Kafka (events)
   users, tokens    wallets (strong C)    Redis (cache, AP-ish)
*/

-- * Patterns that help:
--     - Read critical data from the PRIMARY; read non-critical data from replicas.
--     - Idempotency keys for every money-moving request.
--     - Outbox pattern: write business row + event row in ONE transaction, then publish to Kafka.
--     - Saga pattern: chain of local transactions with compensating actions.
--     - Timeouts + retries with backoff; circuit breakers.

-- * Example: Outbox pattern table (same transaction = consistent event)
CREATE TABLE outbox (
    id         BIGSERIAL PRIMARY KEY,
    event_type VARCHAR(50) NOT NULL,
    payload    JSONB NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    published  BOOLEAN DEFAULT FALSE
);

BEGIN;
UPDATE wallets SET balance = balance - 25 WHERE wallet_id = 1;
INSERT INTO outbox (event_type, payload)
VALUES ('WALLET_DEBITED', jsonb_build_object('wallet_id', 1, 'amount', 25));
COMMIT;

SELECT * FROM outbox WHERE published = FALSE;   -- a relay process publishes these to Kafka

-- ------------------------------------------------------------
-- 54.9 Common Misconceptions
-- ------------------------------------------------------------
-- * "Pick any 2 of 3" → Wrong framing. P is mandatory in distributed systems;
--   the real choice is C vs A ONLY during a partition.
-- * "Database X is CP forever" → Behavior depends on config and operation.
-- * "AP means no consistency" → AP systems are usually eventually consistent.
-- * "CAP C = ACID C" → Different meanings (linearizability vs integrity rules).
-- * CAP ignores latency → use PACELC for normal-operation trade-offs.

-- ------------------------------------------------------------
-- 54.10 Interview Q & A
-- ------------------------------------------------------------
-- * Q. What is CAP Theorem?
--   A. In a distributed system, during a network partition you can guarantee either
--      Consistency or Availability, not both.
-- * Q. Why can't we drop P?
--   A. Network failures are unavoidable across machines; a system must handle them.
-- * Q. Is PostgreSQL CP or AP?
--   A. Single node: consistent & available (no partition). Async standbys: stale reads
--      possible (AP-like). Synchronous replication: commits wait for standby (CP-like).
-- * Q. Which side for payments?    A. CP — refuse rather than give wrong balance.
-- * Q. Which side for a like counter? A. AP — eventual consistency is fine.
-- * Q. What is eventual consistency? A. If no new writes arrive, all replicas converge.
-- * Q. What is PACELC? A. Else (no partition), trade Latency vs Consistency.

-- Cleanup (optional)
-- DROP TABLE outbox, wallet_txn, wallets;
