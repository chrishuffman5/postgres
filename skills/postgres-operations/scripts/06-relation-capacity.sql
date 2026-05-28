SELECT d.datname,
       pg_size_pretty(pg_database_size(d.datname)) AS database_size
FROM pg_database AS d
ORDER BY pg_database_size(d.datname) DESC;

SELECT spcname AS tablespace_name,
       pg_tablespace_location(oid) AS location,
       pg_size_pretty(pg_tablespace_size(oid)) AS tablespace_size
FROM pg_tablespace
ORDER BY pg_tablespace_size(oid) DESC;

SELECT n.nspname AS schema_name,
       c.relname AS relation_name,
       c.relkind,
       pg_size_pretty(pg_relation_size(c.oid)) AS main_fork,
       pg_size_pretty(pg_indexes_size(c.oid)) AS indexes,
       pg_size_pretty(pg_total_relation_size(c.oid)) AS total_size
FROM pg_class AS c
JOIN pg_namespace AS n ON n.oid = c.relnamespace
WHERE c.relkind IN ('r', 'p', 'm')
  AND n.nspname NOT IN ('pg_catalog', 'information_schema')
ORDER BY pg_total_relation_size(c.oid) DESC
LIMIT 100;
