SELECT version() AS version,
       current_setting('server_version') AS server_version,
       current_setting('data_directory', true) AS data_directory_visible,
       current_setting('rds.extensions', true) AS rds_extensions,
       current_setting('cloudsql.iam_authentication', true) AS cloudsql_iam_authentication;

SELECT name, default_version, installed_version
FROM pg_available_extensions
WHERE installed_version IS NOT NULL
ORDER BY name;
