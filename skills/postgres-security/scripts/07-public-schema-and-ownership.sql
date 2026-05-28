SELECT n.nspname AS schema_name,
       pg_get_userbyid(n.nspowner) AS owner,
       n.nspacl AS acl
FROM pg_namespace AS n
WHERE n.nspname NOT LIKE 'pg_%'
  AND n.nspname <> 'information_schema'
ORDER BY n.nspname;

SELECT n.nspname AS schema_name,
       c.relname AS object_name,
       c.relkind,
       pg_get_userbyid(c.relowner) AS owner,
       c.relacl AS acl
FROM pg_class AS c
JOIN pg_namespace AS n ON n.oid = c.relnamespace
WHERE n.nspname NOT IN ('pg_catalog', 'information_schema')
  AND (c.relacl::text LIKE '%=r%' OR c.relacl::text LIKE '%PUBLIC%')
ORDER BY n.nspname, c.relname;
