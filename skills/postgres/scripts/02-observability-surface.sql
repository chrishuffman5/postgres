SELECT name,
       default_version,
       installed_version,
       comment
FROM pg_available_extensions
WHERE name IN ('pg_stat_statements', 'auto_explain', 'pg_buffercache',
               'pgstattuple', 'pg_visibility', 'pageinspect', 'pg_prewarm',
               'pg_freespacemap', 'pgrowlocks', 'pgaudit', 'pg_wait_sampling',
               'pg_cron', 'pg_partman')
ORDER BY name;

SELECT name, setting, source, pending_restart
FROM pg_settings
WHERE name IN ('shared_preload_libraries', 'track_activity_query_size',
               'track_counts', 'track_io_timing', 'track_wal_io_timing',
               'compute_query_id', 'log_min_duration_statement',
               'log_lock_waits', 'log_checkpoints', 'log_temp_files',
               'log_autovacuum_min_duration')
ORDER BY name;

SELECT extname, extversion, nspname AS schema_name
FROM pg_extension AS e
JOIN pg_namespace AS n ON n.oid = e.extnamespace
ORDER BY extname;
