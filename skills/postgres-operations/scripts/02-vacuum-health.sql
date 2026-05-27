SELECT datname,
       age(datfrozenxid) AS xid_age,
       age(datminmxid) AS mxid_age
FROM pg_database
ORDER BY age(datfrozenxid) DESC;

SELECT schemaname, relname, n_live_tup, n_dead_tup,
       round(100.0 * n_dead_tup / NULLIF(n_live_tup + n_dead_tup, 0), 2) AS dead_tuple_pct,
       last_vacuum, last_autovacuum, last_analyze, last_autoanalyze
FROM pg_stat_user_tables
ORDER BY n_dead_tup DESC
LIMIT 50;
