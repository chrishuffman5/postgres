SELECT schemaname, relname, n_live_tup, n_mod_since_analyze,
       last_analyze, last_autoanalyze,
       round(100.0 * n_mod_since_analyze / NULLIF(n_live_tup, 0), 2) AS pct_modified_since_analyze
FROM pg_stat_user_tables
ORDER BY n_mod_since_analyze DESC
LIMIT 50;
