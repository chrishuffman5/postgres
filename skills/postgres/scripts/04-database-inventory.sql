SELECT d.datname,
       pg_size_pretty(pg_database_size(d.datname)) AS database_size,
       d.datallowconn,
       d.datconnlimit,
       d.datistemplate,
       pg_encoding_to_char(d.encoding) AS encoding,
       d.datcollate,
       d.datctype,
       age(d.datfrozenxid) AS xid_age,
       age(d.datminmxid) AS mxid_age,
       has_database_privilege(d.datname, 'CONNECT') AS current_user_can_connect
FROM pg_database AS d
ORDER BY pg_database_size(d.datname) DESC;

SELECT datname,
       numbackends,
       xact_commit,
       xact_rollback,
       deadlocks,
       conflicts,
       temp_files,
       pg_size_pretty(temp_bytes) AS temp_bytes,
       stats_reset
FROM pg_stat_database
WHERE datname IS NOT NULL
ORDER BY numbackends DESC, datname;
