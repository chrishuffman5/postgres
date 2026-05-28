SELECT schemaname,
       relname,
       n_live_tup,
       n_dead_tup,
       n_mod_since_analyze,
       last_vacuum,
       last_autovacuum,
       last_analyze,
       last_autoanalyze,
       vacuum_count,
       autovacuum_count,
       analyze_count,
       autoanalyze_count
FROM pg_stat_user_tables
ORDER BY n_mod_since_analyze DESC, n_dead_tup DESC
LIMIT 200;

SELECT schemaname,
       tablename,
       attname,
       inherited,
       null_frac,
       avg_width,
       n_distinct,
       most_common_vals,
       most_common_freqs,
       histogram_bounds
FROM pg_stats
WHERE schemaname NOT IN ('pg_catalog', 'information_schema')
ORDER BY schemaname, tablename, attname
LIMIT 500;

SELECT schemaname,
       tablename,
       statistics_name,
       attnames,
       kinds,
       n_distinct,
       dependencies,
       most_common_vals
FROM pg_stats_ext
ORDER BY schemaname, tablename, statistics_name;
