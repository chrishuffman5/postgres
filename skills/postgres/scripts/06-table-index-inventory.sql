SELECT n.nspname AS schema_name,
       c.relname AS relation_name,
       c.relkind,
       am.amname AS access_method,
       pg_get_userbyid(c.relowner) AS owner,
       c.relpersistence,
       c.relpages,
       c.reltuples::bigint AS estimated_rows,
       pg_size_pretty(pg_relation_size(c.oid)) AS relation_size,
       pg_size_pretty(pg_total_relation_size(c.oid)) AS total_size,
       c.reloptions
FROM pg_class AS c
JOIN pg_namespace AS n ON n.oid = c.relnamespace
LEFT JOIN pg_am AS am ON am.oid = c.relam
WHERE n.nspname NOT IN ('pg_catalog', 'information_schema')
  AND n.nspname NOT LIKE 'pg_toast%'
  AND c.relkind IN ('r', 'p', 'm', 'i')
ORDER BY pg_total_relation_size(c.oid) DESC NULLS LAST
LIMIT 500;

SELECT schemaname,
       tablename,
       indexname,
       indexdef
FROM pg_indexes
WHERE schemaname NOT IN ('pg_catalog', 'information_schema')
ORDER BY schemaname, tablename, indexname;
