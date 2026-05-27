SELECT rolname, rolsuper, rolcreaterole, rolcreatedb, rolreplication, rolbypassrls,
       rolcanlogin, rolconnlimit, rolvaliduntil
FROM pg_roles
ORDER BY rolsuper DESC, rolcreaterole DESC, rolcreatedb DESC, rolname;
