SELECT datname, state, count(*) AS sessions
FROM pg_stat_activity
GROUP BY datname, state
ORDER BY sessions DESC;

SELECT count(*) AS total_sessions,
       current_setting('max_connections')::int AS max_connections,
       round(100.0 * count(*) / current_setting('max_connections')::int, 2) AS pct_used
FROM pg_stat_activity;
