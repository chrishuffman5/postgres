SELECT current_setting('server_version') AS server_version,
       pg_postmaster_start_time() AS started_at,
       now() - pg_postmaster_start_time() AS uptime,
       current_database() AS database_name,
       count(*) FILTER (WHERE state = 'active') AS active_sessions,
       count(*) FILTER (WHERE state = 'idle in transaction') AS idle_in_transaction,
       count(*) FILTER (WHERE wait_event IS NOT NULL) AS waiting_sessions
FROM pg_stat_activity;

SELECT datname, numbackends, xact_commit, xact_rollback, blks_read, blks_hit,
       round(100.0 * blks_hit / NULLIF(blks_hit + blks_read, 0), 2) AS cache_hit_pct,
       deadlocks, temp_files, temp_bytes
FROM pg_stat_database
WHERE datname IS NOT NULL
ORDER BY numbackends DESC;
