# Logging And Explain

## Useful Logging Settings

- `log_min_duration_statement` captures slow statements. Use a threshold that will not flood logs.
- `log_lock_waits = on` records waits longer than `deadlock_timeout`.
- `log_checkpoints = on` helps identify checkpoint pressure.
- `log_autovacuum_min_duration` captures expensive autovacuum activity.
- `log_temp_files` captures sorts and hashes spilling to disk.

## auto_explain

`auto_explain` can capture plans for slow statements, optionally with buffers and analyze. It is powerful but can add overhead, especially with `log_analyze = on`.

Use it for narrow windows, targeted databases, or managed-platform sessions where supported.

## EXPLAIN Safety

`EXPLAIN` without `ANALYZE` estimates only. `EXPLAIN ANALYZE` executes. For data-changing statements, that means side effects happen unless controlled in a transaction and rolled back.

Prefer `EXPLAIN (ANALYZE, BUFFERS, SETTINGS)` for SELECT statements that are safe to run. Add `VERBOSE` when table aliases, output columns, partition pruning, or function calls matter.
