SELECT n.nspname AS schema_name,
       c.relname AS relation_name,
       c.relkind,
       c.relpersistence,
       pg_size_pretty(pg_total_relation_size(c.oid)) AS total_size
FROM pg_class AS c
JOIN pg_namespace AS n ON n.oid = c.relnamespace
WHERE n.nspname NOT IN ('pg_catalog', 'information_schema')
  AND n.nspname NOT LIKE 'pg_toast%'
  AND c.relkind IN ('r', 'p', 'm', 'S')
ORDER BY pg_total_relation_size(c.oid) DESC NULLS LAST
LIMIT 200;

SELECT n.nspname AS schema_name,
       p.proname AS function_name,
       l.lanname AS language,
       p.prosecdef AS security_definer,
       p.provolatile,
       pg_get_userbyid(p.proowner) AS owner
FROM pg_proc AS p
JOIN pg_namespace AS n ON n.oid = p.pronamespace
JOIN pg_language AS l ON l.oid = p.prolang
WHERE n.nspname NOT IN ('pg_catalog', 'information_schema')
ORDER BY n.nspname, p.proname;

SELECT slot_name, slot_type, database, active, restart_lsn, confirmed_flush_lsn
FROM pg_replication_slots
ORDER BY active DESC, slot_name;
