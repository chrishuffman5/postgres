SELECT n.nspname AS schema_name,
       t.relname AS table_name,
       i1.relname AS index_a,
       i2.relname AS index_b,
       pg_get_indexdef(i1.oid) AS index_a_def,
       pg_get_indexdef(i2.oid) AS index_b_def
FROM pg_index AS x1
JOIN pg_index AS x2
  ON x1.indrelid = x2.indrelid
 AND x1.indexrelid < x2.indexrelid
 AND x1.indkey = x2.indkey
 AND x1.indclass = x2.indclass
 AND x1.indcollation = x2.indcollation
 AND x1.indoption = x2.indoption
 AND COALESCE(pg_get_expr(x1.indpred, x1.indrelid), '') = COALESCE(pg_get_expr(x2.indpred, x2.indrelid), '')
JOIN pg_class AS i1 ON i1.oid = x1.indexrelid
JOIN pg_class AS i2 ON i2.oid = x2.indexrelid
JOIN pg_class AS t ON t.oid = x1.indrelid
JOIN pg_namespace AS n ON n.oid = t.relnamespace
WHERE n.nspname NOT IN ('pg_catalog', 'information_schema')
ORDER BY n.nspname, t.relname, i1.relname;
