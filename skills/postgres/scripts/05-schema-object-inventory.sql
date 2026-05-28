SELECT n.nspname AS schema_name,
       pg_get_userbyid(n.nspowner) AS owner,
       count(c.oid) FILTER (WHERE c.relkind = 'r') AS tables,
       count(c.oid) FILTER (WHERE c.relkind = 'p') AS partitioned_tables,
       count(c.oid) FILTER (WHERE c.relkind = 'i') AS indexes,
       count(c.oid) FILTER (WHERE c.relkind = 'v') AS views,
       count(c.oid) FILTER (WHERE c.relkind = 'm') AS materialized_views,
       count(c.oid) FILTER (WHERE c.relkind = 'S') AS sequences
FROM pg_namespace AS n
LEFT JOIN pg_class AS c ON c.relnamespace = n.oid
WHERE n.nspname NOT LIKE 'pg_toast%'
GROUP BY n.nspname, n.nspowner
ORDER BY n.nspname;

SELECT routine_schema,
       routine_type,
       count(*) AS routines
FROM information_schema.routines
WHERE routine_schema NOT IN ('pg_catalog', 'information_schema')
GROUP BY routine_schema, routine_type
ORDER BY routine_schema, routine_type;
