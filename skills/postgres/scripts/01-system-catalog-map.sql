SELECT table_schema,
       table_name,
       table_type
FROM information_schema.tables
WHERE table_schema IN ('pg_catalog', 'information_schema')
  AND (table_name LIKE 'pg_stat%'
       OR table_name LIKE 'pg_statio%'
       OR table_name LIKE 'pg_%settings%'
       OR table_name LIKE 'pg_%locks%'
       OR table_name LIKE 'pg_%replication%'
       OR table_name LIKE 'pg_%subscription%'
       OR table_name LIKE 'pg_%publication%'
       OR table_name LIKE 'pg_%roles%'
       OR table_name LIKE 'pg_%database%'
       OR table_name LIKE 'pg_%tables%'
       OR table_name LIKE 'pg_%indexes%')
ORDER BY table_schema, table_name;

SELECT n.nspname AS schema_name,
       c.relname AS relation_name,
       c.relkind,
       pg_catalog.obj_description(c.oid, 'pg_class') AS description
FROM pg_class AS c
JOIN pg_namespace AS n ON n.oid = c.relnamespace
WHERE n.nspname = 'pg_catalog'
  AND c.relkind IN ('r', 'v', 'm')
  AND c.relname LIKE 'pg_%'
ORDER BY c.relname;
