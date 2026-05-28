SELECT wait_event_type,
       wait_event,
       state,
       count(*) AS sessions,
       min(now() - query_start) AS shortest_query_age,
       max(now() - query_start) AS longest_query_age
FROM pg_stat_activity
WHERE pid <> pg_backend_pid()
  AND wait_event IS NOT NULL
GROUP BY wait_event_type, wait_event, state
ORDER BY sessions DESC, longest_query_age DESC;
