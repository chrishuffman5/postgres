SELECT name, setting, unit, context, source, pending_restart
FROM pg_settings
WHERE name IN ('shared_buffers', 'huge_pages', 'work_mem', 'hash_mem_multiplier',
               'maintenance_work_mem', 'autovacuum_work_mem', 'temp_buffers',
               'effective_cache_size', 'logical_decoding_work_mem')
ORDER BY name;

SELECT pid, usename, datname, application_name, state,
       now() - query_start AS query_age,
       wait_event_type, wait_event,
       left(query, 700) AS query
FROM pg_stat_activity
WHERE state = 'active'
ORDER BY query_start;
