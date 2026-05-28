# PostgreSQL Statistics Views

## Core Views

`pg_stat_activity` shows current sessions. It is a snapshot, not history.

`pg_stat_database` shows per-database counters: transactions, rollbacks, blocks read/hit, temp files, deadlocks, checksums, and session timing in newer versions.

`pg_stat_statements` shows normalized query history when loaded through `shared_preload_libraries` and created as an extension.

`pg_stat_user_tables` and `pg_stat_user_indexes` show table/index access, vacuum/analyze timestamps, tuple churn, and dead tuple estimates.

`pg_stat_bgwriter` shows checkpoint and background writer behavior. `checkpoints_req` growing quickly usually means checkpoints are being forced by WAL volume before `checkpoint_timeout`.

`pg_stat_wal` shows WAL records, bytes, full-page images, writes, syncs, and WAL buffer pressure.

`pg_stat_io` exists in newer PostgreSQL versions and breaks I/O down by backend type, object, context, and operation.

## Interpretation Rules

- Counters are cumulative since reset. Use deltas for rates.
- `n_dead_tup` is an estimate, not an exact bloat measurement.
- Index `idx_scan = 0` does not prove an index is useless; check constraints, uniqueness, recent reset, and rare critical queries.
- Cache hit percentage is useful only with workload and storage context.
- Temp file counters point to spills but not the exact query unless correlated with logs or `pg_stat_statements`.
