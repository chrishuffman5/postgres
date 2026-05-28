WITH fk AS (
  SELECT con.oid,
         con.conname,
         con.conrelid,
         con.confrelid,
         con.conkey,
         n.nspname AS schema_name,
         rel.relname AS table_name,
         frel.relname AS referenced_table
  FROM pg_constraint AS con
  JOIN pg_class AS rel ON rel.oid = con.conrelid
  JOIN pg_class AS frel ON frel.oid = con.confrelid
  JOIN pg_namespace AS n ON n.oid = rel.relnamespace
  WHERE con.contype = 'f'
),
matching_index AS (
  SELECT fk.oid AS fk_oid,
         idx.indexrelid
  FROM fk
  JOIN pg_index AS idx ON idx.indrelid = fk.conrelid
  WHERE idx.indisvalid
    AND idx.indkey::int2[][:array_length(fk.conkey, 1)] = fk.conkey
)
SELECT fk.schema_name,
       fk.table_name,
       fk.conname AS foreign_key_name,
       fk.referenced_table,
       pg_get_constraintdef(fk.oid) AS constraint_definition
FROM fk
LEFT JOIN matching_index AS mi ON mi.fk_oid = fk.oid
WHERE mi.indexrelid IS NULL
ORDER BY fk.schema_name, fk.table_name, fk.conname;
