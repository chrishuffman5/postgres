SELECT schemaname,
       tablename,
       statistics_name,
       statistics_owner,
       attnames,
       exprs,
       kinds
FROM pg_stats_ext
ORDER BY schemaname, tablename, statistics_name;

SELECT stxnamespace::regnamespace AS schema_name,
       stxrelid::regclass AS table_name,
       stxname AS statistics_name,
       stxkeys,
       stxkind,
       stxexprs
FROM pg_statistic_ext
ORDER BY stxrelid::regclass::text, stxname;
