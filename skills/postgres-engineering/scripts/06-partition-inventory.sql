SELECT parent_ns.nspname AS parent_schema,
       parent.relname AS parent_table,
       child_ns.nspname AS child_schema,
       child.relname AS child_table,
       pg_get_expr(child.relpartbound, child.oid) AS partition_bound,
       pg_size_pretty(pg_total_relation_size(child.oid)) AS child_total_size
FROM pg_inherits AS inh
JOIN pg_class AS parent ON parent.oid = inh.inhparent
JOIN pg_namespace AS parent_ns ON parent_ns.oid = parent.relnamespace
JOIN pg_class AS child ON child.oid = inh.inhrelid
JOIN pg_namespace AS child_ns ON child_ns.oid = child.relnamespace
ORDER BY parent_ns.nspname, parent.relname, child.relname;

SELECT n.nspname AS schema_name,
       c.relname AS table_name,
       p.partstrat,
       p.partnatts,
       pg_get_partkeydef(c.oid) AS partition_key
FROM pg_partitioned_table AS p
JOIN pg_class AS c ON c.oid = p.partrelid
JOIN pg_namespace AS n ON n.oid = c.relnamespace
ORDER BY n.nspname, c.relname;
