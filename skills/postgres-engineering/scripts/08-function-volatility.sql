SELECT n.nspname AS schema_name,
       p.proname AS function_name,
       pg_get_function_identity_arguments(p.oid) AS arguments,
       l.lanname AS language,
       p.provolatile,
       p.proparallel,
       p.prosecdef AS security_definer,
       p.proleakproof,
       pg_get_userbyid(p.proowner) AS owner
FROM pg_proc AS p
JOIN pg_namespace AS n ON n.oid = p.pronamespace
JOIN pg_language AS l ON l.oid = p.prolang
WHERE n.nspname NOT IN ('pg_catalog', 'information_schema')
ORDER BY n.nspname, p.proname, arguments;
