SELECT a.name,
       a.default_version,
       a.installed_version,
       e.extversion,
       n.nspname AS installed_schema,
       a.comment
FROM pg_available_extensions AS a
LEFT JOIN pg_extension AS e ON e.extname = a.name
LEFT JOIN pg_namespace AS n ON n.oid = e.extnamespace
ORDER BY a.name;

SELECT name, setting
FROM pg_settings
WHERE name IN ('shared_preload_libraries', 'rds.extensions', 'azure.extensions',
               'cloudsql.iam_authentication', 'cloudsql.enable_pgaudit')
ORDER BY name;
