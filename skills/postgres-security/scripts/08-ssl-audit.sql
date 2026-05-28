SELECT name, setting, source, pending_restart
FROM pg_settings
WHERE name LIKE 'ssl%'
ORDER BY name;

SELECT a.pid,
       a.usename,
       a.datname,
       a.client_addr,
       s.ssl,
       s.version,
       s.cipher,
       s.bits,
       s.client_dn,
       s.issuer_dn
FROM pg_stat_activity AS a
LEFT JOIN pg_stat_ssl AS s ON s.pid = a.pid
WHERE a.client_addr IS NOT NULL
ORDER BY a.usename, a.client_addr;
