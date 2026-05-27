SELECT name, setting, unit, context, vartype, source
FROM pg_settings
WHERE name IN ('shared_buffers', 'work_mem', 'maintenance_work_mem', 'effective_cache_size',
               'max_connections', 'max_worker_processes', 'max_parallel_workers',
               'wal_level', 'max_wal_size', 'min_wal_size', 'checkpoint_timeout',
               'checkpoint_completion_target', 'synchronous_commit',
               'random_page_cost', 'effective_io_concurrency')
ORDER BY name;
