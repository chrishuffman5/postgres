SELECT name, setting, unit, context, source, pending_restart
FROM pg_settings
WHERE name IN ('max_connections', 'superuser_reserved_connections',
               'reserved_connections', 'max_worker_processes',
               'max_parallel_workers', 'max_wal_senders',
               'max_replication_slots', 'wal_keep_size',
               'max_slot_wal_keep_size', 'idle_in_transaction_session_timeout',
               'statement_timeout', 'lock_timeout',
               'shared_preload_libraries')
ORDER BY name;

SELECT datname, numbackends, deadlocks, conflicts, temp_files,
       pg_size_pretty(temp_bytes) AS temp_bytes,
       stats_reset
FROM pg_stat_database
WHERE datname IS NOT NULL
ORDER BY numbackends DESC, datname;
