# PostgreSQL Diagnostic Workflow

Start with `pg_stat_activity` and wait events. Important wait classes include `Lock`, `LWLock`, `IO`, `Client`, `WAL`, `BufferPin`, and `Extension`.

Use `pg_stat_statements` for workload history. If it is unavailable, rely on logs with `log_min_duration_statement`, `auto_explain`, or platform query insights.

For a single query, request `EXPLAIN (ANALYZE, BUFFERS, VERBOSE)` when safe. Do not use `ANALYZE` on mutating statements unless the user understands it will execute the statement.

For blocking, find the head blocker with `pg_blocking_pids(pid)` and inspect its query, state, transaction age, and application name.
