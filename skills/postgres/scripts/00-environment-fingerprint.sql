SELECT version() AS version,
       current_setting('server_version') AS server_version,
       current_setting('server_version_num') AS server_version_num,
       current_database() AS current_database,
       current_user AS current_user,
       session_user AS session_user,
       inet_server_addr() AS server_addr,
       inet_server_port() AS server_port,
       pg_postmaster_start_time() AS postmaster_start_time,
       now() - pg_postmaster_start_time() AS uptime,
       pg_is_in_recovery() AS is_in_recovery;

SELECT name, setting
FROM pg_settings
WHERE name IN ('data_directory', 'config_file', 'hba_file', 'ident_file',
               'external_pid_file', 'cluster_name', 'listen_addresses',
               'port', 'unix_socket_directories')
ORDER BY name;

SELECT current_setting('rds.extensions', true) AS rds_extensions,
       current_setting('rds.logical_replication', true) AS rds_logical_replication,
       current_setting('cloudsql.iam_authentication', true) AS cloudsql_iam_authentication,
       current_setting('azure.extensions', true) AS azure_extensions;
