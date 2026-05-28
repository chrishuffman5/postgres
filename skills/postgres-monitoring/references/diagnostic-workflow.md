# PostgreSQL Diagnostic Workflow

Use this sequence for vague symptoms such as "Postgres is slow", "CPU is high", "queries are timing out", or "the app is hanging".

## 1. Establish Scope

Capture:

- PostgreSQL version and platform
- affected database and application
- symptom start time and duration
- recent deploys, schema changes, vacuum changes, failovers, or data-volume changes
- whether the problem is active now

If it is active now, `pg_stat_activity` is the fastest first look. If it happened in the past, start with logs, `pg_stat_statements`, cloud telemetry, and cumulative counters.

## 2. Inspect Active Sessions

Look for:

- many sessions in `active` state with the same wait event
- `idle in transaction` sessions with old `xact_start`
- one blocker with many waiters
- application names pointing to a specific service or job
- queries with old `query_start` and no progress

High session count alone is not enough. Separate active sessions from idle pooled sessions.

## 3. Classify Waits

Important classes:

| Wait type | Meaning | Typical next step |
|---|---|---|
| `Lock` | session waits for heavyweight lock | find blocker and lock mode |
| `IO` | backend waits for storage I/O | check top block readers, storage latency, cache behavior |
| `LWLock` | lightweight internal lock | correlate with version, WAL, buffer, extension, or concurrency hotspot |
| `Client` | server waits on client | app fetch path, network, pooler, huge results |
| `WAL` | WAL write/sync path | storage latency, commit pattern, sync replication, checkpoints |
| `BufferPin` | buffer pinned by another backend | long cursor/query, vacuum conflict |
| `Extension` | extension wait | inspect extension-specific docs and workload |

## 4. Find Expensive Statements

Use `pg_stat_statements` and sort by:

- total execution time for aggregate pain
- mean or p95-like metrics when available for individually slow statements
- shared/local/temp block reads for I/O pressure
- WAL bytes for write amplification
- calls for excessive chatty SQL

Normalize by the symptom window when possible. If stats have not been reset for weeks, the top query overall may not be the query causing the current incident.

## 5. Read The Plan

For one statement, use:

```sql
EXPLAIN (ANALYZE, BUFFERS, SETTINGS, VERBOSE)
SELECT ...;
```

Only use `ANALYZE` when executing the statement is safe. For writes, use a transaction and rollback only if side effects are acceptable and all triggers/functions are understood.

Plan red flags:

- estimated rows far from actual rows
- nested loops over unexpectedly large row counts
- sequential scans on large tables for selective predicates
- external sort or hash spill to disk
- repeated index scans with high loop counts
- parallel workers planned but not launched
- filter predicates applied after a broad scan

## 6. Tie The Fix To The Evidence

Common mappings:

- lock waits -> transaction scope, lock order, missing index, DDL scheduling, retry logic
- I/O waits -> query plan, cache fit, index strategy, storage, checkpoints
- WAL waits -> batch commit pattern, synchronous commit, WAL disk, checkpoint tuning
- CPU -> inefficient SQL, missing stats, too much parallelism, JSON/regex/function cost
- temp files -> `work_mem`, plan shape, sort/hash volume, query rewrite
- bloat -> autovacuum, long transactions, fillfactor, update pattern

## 7. Preserve Evidence

Before resetting stats or killing sessions, capture the relevant rows. Do not reset `pg_stat_statements` or database stats on production unless the user explicitly accepts the loss of history.
