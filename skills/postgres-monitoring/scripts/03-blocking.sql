SELECT blocked.pid AS blocked_pid,
       blocked.usename AS blocked_user,
       now() - blocked.query_start AS blocked_duration,
       left(blocked.query, 500) AS blocked_query,
       blocker.pid AS blocker_pid,
       blocker.usename AS blocker_user,
       now() - blocker.query_start AS blocker_duration,
       left(blocker.query, 500) AS blocker_query
FROM pg_stat_activity AS blocked
JOIN LATERAL unnest(pg_blocking_pids(blocked.pid)) AS b(blocker_pid) ON true
JOIN pg_stat_activity AS blocker ON blocker.pid = b.blocker_pid
ORDER BY blocked.query_start;
