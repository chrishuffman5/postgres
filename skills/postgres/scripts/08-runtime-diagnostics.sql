SELECT pid,
       backend_type,
       usename,
       datname,
       application_name,
       client_addr,
       state,
       wait_event_type,
       wait_event,
       now() - backend_start AS backend_age,
       now() - xact_start AS xact_age,
       now() - query_start AS query_age,
       backend_xmin,
       left(query, 1000) AS query
FROM pg_stat_activity
WHERE pid <> pg_backend_pid()
ORDER BY query_start NULLS LAST;

SELECT blocked.pid AS blocked_pid,
       blocker.pid AS blocker_pid,
       blocked.wait_event_type,
       blocked.wait_event,
       now() - blocked.query_start AS blocked_age,
       left(blocked.query, 500) AS blocked_query,
       left(blocker.query, 500) AS blocker_query
FROM pg_stat_activity AS blocked
JOIN LATERAL unnest(pg_blocking_pids(blocked.pid)) AS b(blocker_pid) ON true
JOIN pg_stat_activity AS blocker ON blocker.pid = b.blocker_pid
ORDER BY blocked.query_start;

SELECT gid,
       prepared,
       owner,
       database,
       transaction
FROM pg_prepared_xacts
ORDER BY prepared;
