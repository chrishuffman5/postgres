SELECT line_number,
       type,
       database,
       user_name,
       address,
       netmask,
       auth_method,
       options,
       error
FROM pg_hba_file_rules
ORDER BY line_number;

SELECT name, setting, source, pending_restart
FROM pg_settings
WHERE name IN ('password_encryption', 'ssl', 'ssl_min_protocol_version',
               'krb_server_keyfile', 'db_user_namespace',
               'authentication_timeout')
ORDER BY name;
