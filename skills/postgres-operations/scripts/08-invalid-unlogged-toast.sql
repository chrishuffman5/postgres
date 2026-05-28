SELECT n.nspname AS schema_name,
       c.relname AS table_name,
       c.relpersistence,
       c.relkind,
       pg_size_pretty(pg_total_relation_size(c.oid)) AS total_size
FROM pg_class AS c
JOIN pg_namespace AS n ON n.oid = c.relnamespace
WHERE n.nspname NOT IN ('pg_catalog', 'information_schema')
  AND c.relpersistence <> 'p'
ORDER BY pg_total_relation_size(c.oid) DESC NULLS LAST;

SELECT n.nspname AS schema_name,
       c.relname AS index_name,
       t.relname AS table_name,
       i.indisvalid,
       i.indisready,
       i.indislive,
       pg_get_indexdef(i.indexrelid) AS index_definition
FROM pg_index AS i
JOIN pg_class AS c ON c.oid = i.indexrelid
JOIN pg_class AS t ON t.oid = i.indrelid
JOIN pg_namespace AS n ON n.oid = c.relnamespace
WHERE NOT i.indisvalid OR NOT i.indisready OR NOT i.indislive
ORDER BY n.nspname, c.relname;
