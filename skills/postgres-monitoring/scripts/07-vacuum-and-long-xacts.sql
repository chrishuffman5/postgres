SELECT pid, usename, datname, application_name, client_addr, state,
       backend_xmin,
       now() - xact_start AS xact_age,
       now() - query_start AS query_age,
       wait_event_type,
       wait_event,
       left(query, 700) AS query
FROM pg_stat_activity
WHERE xact_start IS NOT NULL
ORDER BY xact_start;

SELECT schemaname, relname,
       n_live_tup,
       n_dead_tup,
       last_vacuum,
       last_autovacuum,
       last_analyze,
       last_autoanalyze,
       autovacuum_count,
       vacuum_count
FROM pg_stat_user_tables
ORDER BY n_dead_tup DESC
LIMIT 50;
