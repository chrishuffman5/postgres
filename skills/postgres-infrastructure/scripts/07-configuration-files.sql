SELECT name, setting
FROM pg_settings
WHERE name IN ('config_file', 'hba_file', 'ident_file', 'data_directory')
ORDER BY name;

SELECT sourcefile,
       sourceline,
       seqno,
       name,
       setting,
       applied,
       error
FROM pg_file_settings
ORDER BY sourcefile, sourceline, seqno;

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
