SELECT pg_get_userbyid(d.defaclrole) AS grantor,
       n.nspname AS schema_name,
       d.defaclobjtype AS object_type,
       d.defaclacl AS default_acl
FROM pg_default_acl AS d
LEFT JOIN pg_namespace AS n ON n.oid = d.defaclnamespace
ORDER BY grantor, schema_name, object_type;

SELECT grantee,
       table_schema,
       table_name,
       privilege_type,
       is_grantable
FROM information_schema.role_table_grants
WHERE table_schema NOT IN ('pg_catalog', 'information_schema')
ORDER BY grantee, table_schema, table_name, privilege_type;
