SELECT name, setting, unit, source, pending_restart
FROM pg_settings
WHERE name IN ('shared_preload_libraries', 'log_min_duration_statement',
               'track_activity_query_size', 'track_io_timing', 'max_connections',
               'max_replication_slots', 'max_wal_senders', 'rds.logical_replication',
               'azure.extensions', 'cloudsql.enable_pgaudit')
ORDER BY name;
