---
name: postgres-monitoring
description: "PostgreSQL performance monitoring and diagnostics: wait events, pg_stat_activity, pg_stat_database, pg_stat_statements, blocking and deadlock analysis, log analysis, baselining, and health checks. Use for slow queries, high CPU, high I/O, lock waits, deadlocks, replication symptoms, query history, and general PostgreSQL troubleshooting."
---

# PostgreSQL Monitoring

Use a waits-and-evidence workflow. Start broad, then narrow to specific sessions or statements.

## Workflow

1. Check instance health and uptime.
2. Inspect active sessions and wait events.
3. Identify blockers and long transactions.
4. Use `pg_stat_statements` for recurring expensive SQL.
5. Use `EXPLAIN (ANALYZE, BUFFERS)` for one statement.
6. Correlate with logs, checkpoints, autovacuum, and I/O.

## References

- `references/diagnostic-workflow.md` - triage sequence and wait categories.

## Scripts

- `scripts/01-instance-health.sql` - core database health counters.
- `scripts/02-active-sessions.sql` - active sessions, waits, and transaction age.
- `scripts/03-blocking.sql` - lock blockers and waiters.
- `scripts/04-top-statements.sql` - top statements from `pg_stat_statements`.
