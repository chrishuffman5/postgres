SELECT name, setting, unit, context, source, pending_restart
FROM pg_settings
WHERE name IN ('max_worker_processes', 'max_parallel_workers',
               'max_parallel_workers_per_gather', 'max_parallel_maintenance_workers',
               'max_logical_replication_workers', 'max_sync_workers_per_subscription',
               'autovacuum_max_workers', 'parallel_leader_participation',
               'min_parallel_table_scan_size', 'min_parallel_index_scan_size',
               'parallel_setup_cost', 'parallel_tuple_cost')
ORDER BY name;

SELECT backend_type, state, wait_event_type, wait_event, count(*) AS processes
FROM pg_stat_activity
GROUP BY backend_type, state, wait_event_type, wait_event
ORDER BY processes DESC, backend_type;
