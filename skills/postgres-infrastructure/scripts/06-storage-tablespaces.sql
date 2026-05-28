SELECT spcname AS tablespace_name,
       pg_get_userbyid(spcowner) AS owner,
       pg_tablespace_location(oid) AS location,
       pg_size_pretty(pg_tablespace_size(oid)) AS size,
       spcoptions
FROM pg_tablespace
ORDER BY pg_tablespace_size(oid) DESC;

SELECT COALESCE(t.spcname, 'pg_default') AS tablespace_name,
       n.nspname AS schema_name,
       c.relkind,
       count(*) AS relation_count,
       pg_size_pretty(sum(pg_total_relation_size(c.oid))) AS total_size
FROM pg_class AS c
JOIN pg_namespace AS n ON n.oid = c.relnamespace
LEFT JOIN pg_tablespace AS t ON t.oid = c.reltablespace
WHERE n.nspname NOT IN ('pg_catalog', 'information_schema')
  AND n.nspname NOT LIKE 'pg_toast%'
GROUP BY COALESCE(t.spcname, 'pg_default'), n.nspname, c.relkind
ORDER BY sum(pg_total_relation_size(c.oid)) DESC NULLS LAST;
