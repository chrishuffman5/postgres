SELECT name, setting, unit, context, source, pending_restart
FROM pg_settings
WHERE name LIKE 'autovacuum%'
   OR name IN ('vacuum_freeze_min_age', 'vacuum_freeze_table_age',
               'vacuum_multixact_freeze_min_age', 'vacuum_multixact_freeze_table_age',
               'maintenance_work_mem')
ORDER BY name;

SELECT n.nspname AS schema_name,
       c.relname AS table_name,
       c.reloptions,
       s.n_live_tup,
       s.n_dead_tup,
       s.last_autovacuum,
       s.autovacuum_count
FROM pg_class AS c
JOIN pg_namespace AS n ON n.oid = c.relnamespace
LEFT JOIN pg_stat_user_tables AS s ON s.relid = c.oid
WHERE c.relkind IN ('r', 'p')
  AND c.reloptions IS NOT NULL
ORDER BY n.nspname, c.relname;
