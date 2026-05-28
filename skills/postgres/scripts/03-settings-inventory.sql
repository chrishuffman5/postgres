SELECT name,
       setting,
       unit,
       category,
       short_desc,
       context,
       vartype,
       source,
       sourcefile,
       sourceline,
       pending_restart
FROM pg_settings
ORDER BY category, name;

SELECT name,
       setting,
       boot_val,
       reset_val,
       unit,
       context,
       source,
       pending_restart
FROM pg_settings
WHERE setting IS DISTINCT FROM boot_val
ORDER BY name;
