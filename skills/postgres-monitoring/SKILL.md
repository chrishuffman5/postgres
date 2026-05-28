---
name: postgres-monitoring
description: "PostgreSQL performance monitoring and diagnostics: wait events, pg_stat_activity, pg_stat_database, pg_stat_statements, blocking and deadlock analysis, log analysis, baselining, and health checks. Use for slow queries, high CPU, high I/O, lock waits, deadlocks, replication symptoms, query history, and general PostgreSQL troubleshooting."
---

# PostgreSQL Monitoring

Use a waits-and-evidence workflow. Start broad, then narrow to specific sessions or statements.

## How To Approach A Monitoring Request

1. Identify the affected database, time window, version, platform, and whether the issue is active now.
2. Start with `pg_stat_activity`: active sessions, wait events, blocking, transaction age, and application names.
3. Use database and system counters for scope: `pg_stat_database`, `pg_stat_bgwriter`, `pg_stat_wal`, `pg_stat_io` when available.
4. Use `pg_stat_statements` for repeated query cost and regression clues. Ask whether it is installed if absent.
5. For a single statement, request `EXPLAIN (ANALYZE, BUFFERS, SETTINGS)` only when it is safe to execute.
6. Correlate with logs: slow query logging, autovacuum messages, checkpoint logs, deadlock messages, and connection churn.
7. If the platform is managed, include cloud telemetry: Performance Insights, Query Insights, Azure metrics, or provider logs.

## Wait-First Workflow

```
1. Active sessions and waits
        |
2. Blocking / long transactions
        |
3. Top statements and database counters
        |
4. Plan-level analysis
        |
5. Config, vacuum, storage, or application fix
```

`wait_event_type` gives the class; `wait_event` gives the specific object or subsystem. A wait event is not automatically bad. It matters when many sessions are waiting, waits align with the symptom window, or a head blocker is holding everyone behind it.

## Wait Category Quick Reference

| Category | Common signs | First drill-down |
|---|---|---|
| Lock | `wait_event_type = 'Lock'`, blocked sessions | `pg_blocking_pids(pid)`, head blocker query, transaction age |
| IO | `IO` waits, high read time, low cache hit, high disk latency | `pg_stat_io` or provider I/O metrics, top statements by block reads |
| WAL | WAL writes/sync waits, commit latency, replica lag | `pg_stat_wal`, checkpoint settings, synchronous replication |
| Client | `ClientRead` or `ClientWrite` | application fetch behavior, network, connection pool, huge result sets |
| LWLock | buffer mapping, WAL insert, extension-specific contention | active query mix, version-specific known bottlenecks |
| BufferPin | vacuum or DDL blocked by a cursor/session pinning a buffer | long transactions, cursors, active query age |
| Timeout | statement timeout, lock timeout, deadlock timeout | logs and application timeouts |

## Query History

`pg_stat_statements` is the core query-history extension. It normalizes statements and tracks calls, total time, mean time, rows, block activity, WAL, and planning metrics depending on version. Use it to distinguish a query that is slow once from a query that dominates the workload by frequency.

If `pg_stat_statements` is unavailable:

- Use slow-query logs with `log_min_duration_statement`.
- Use `auto_explain` carefully for sampled plans.
- Use provider tools such as RDS Performance Insights or Cloud SQL Query Insights.
- Use `pg_stat_activity` snapshots for the active issue, but do not pretend they provide history.

## Blocking And Deadlocks

For live blocking, identify the head blocker, not just the waiters. Inspect:

- blocker `state`, `query_start`, `xact_start`, `backend_xmin`, and application name
- lock mode requested and held
- whether the blocker is `idle in transaction`
- whether DDL is waiting on ordinary DML or vice versa

For deadlocks, the database already chose a victim. Use logs to read the deadlock graph and fix lock acquisition order, missing indexes that broaden lock footprints, long transactions, or application retry behavior.

## Baselining

Most PostgreSQL statistics are cumulative since last reset. Use deltas for rates and compare to a known good window:

- `pg_stat_database` for commits, rollbacks, block hits/reads, deadlocks, temp files
- `pg_stat_bgwriter` and `pg_stat_wal` for checkpoints and WAL pressure
- `pg_stat_statements` for query mix
- `pg_stat_user_tables` for vacuum/analyze behavior
- `pg_stat_replication` for lag and send/replay state

## Common Pitfalls

1. Treating cache hit ratio as the whole performance story. Good systems still read from disk.
2. Running `EXPLAIN ANALYZE` on a write query in production without realizing it executes.
3. Tuning a query from estimated plans only when actual row counts are wrong.
4. Ignoring `idle in transaction` sessions because they are not actively burning CPU.
5. Resetting statistics on production before preserving evidence.
6. Assuming `pg_stat_activity` snapshots explain yesterday's incident.
7. Diagnosing Aurora or managed storage with only PostgreSQL internal counters.

## References

- `references/diagnostic-workflow.md` - triage sequence and wait categories.
- `references/stat-views.md` - important `pg_stat_*` views and interpretation notes.
- `references/logging-and-explain.md` - slow logs, `auto_explain`, and plan capture.

## Scripts

- `scripts/01-instance-health.sql` - core database health counters.
- `scripts/02-active-sessions.sql` - active sessions, waits, and transaction age.
- `scripts/03-blocking.sql` - lock blockers and waiters.
- `scripts/04-top-statements.sql` - top statements from `pg_stat_statements`.
- `scripts/05-wait-event-summary.sql` - grouped active waits.
- `scripts/06-database-counters.sql` - per-database cumulative counters.
- `scripts/07-vacuum-and-long-xacts.sql` - long transactions, xmin, vacuum blockers.
- `scripts/08-io-and-wal.sql` - WAL/checkpoint signals available on the supported baseline.
- `scripts/09-pg-stat-io-pg16.sql` - detailed I/O view for PostgreSQL 16+.

## Cross-Skill Routing

- Fixing one SQL statement or index design goes to `postgres-engineering`.
- Autovacuum, bloat, backup, and wraparound remediation goes to `postgres-operations`.
- Replication lag, slots, and failover goes to `postgres-ha-replication`.
- Memory, WAL/checkpoint, storage, and pooling configuration goes to `postgres-infrastructure`.
- Provider-specific metrics and limits go to `postgres-cloud`.
