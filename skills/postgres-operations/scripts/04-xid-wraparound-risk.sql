SELECT datname,
       age(datfrozenxid) AS xid_age,
       2000000000 - age(datfrozenxid) AS xids_until_wraparound,
       age(datminmxid) AS mxid_age
FROM pg_database
ORDER BY age(datfrozenxid) DESC;

SELECT n.nspname AS schema_name,
       c.relname AS table_name,
       age(c.relfrozenxid) AS xid_age,
       age(c.relminmxid) AS mxid_age,
       pg_size_pretty(pg_total_relation_size(c.oid)) AS total_size,
       s.last_autovacuum,
       s.last_vacuum
FROM pg_class AS c
JOIN pg_namespace AS n ON n.oid = c.relnamespace
LEFT JOIN pg_stat_user_tables AS s ON s.relid = c.oid
WHERE c.relkind IN ('r', 'm', 't')
  AND n.nspname NOT IN ('pg_catalog', 'information_schema')
ORDER BY age(c.relfrozenxid) DESC
LIMIT 100;
