SELECT pubname,
       pubowner::regrole AS owner,
       puballtables,
       pubinsert,
       pubupdate,
       pubdelete,
       pubtruncate,
       pubviaroot
FROM pg_publication
ORDER BY pubname;

SELECT p.pubname,
       n.nspname AS schema_name,
       c.relname AS table_name
FROM pg_publication_rel AS pr
JOIN pg_publication AS p ON p.oid = pr.prpubid
JOIN pg_class AS c ON c.oid = pr.prrelid
JOIN pg_namespace AS n ON n.oid = c.relnamespace
ORDER BY p.pubname, n.nspname, c.relname;

SELECT subname,
       subenabled,
       subslotname,
       subsynccommit,
       subpublications
FROM pg_subscription
ORDER BY subname;

SELECT subid AS subscription_oid,
       subname,
       pid,
       relid::regclass AS relation_name,
       received_lsn,
       latest_end_lsn,
       latest_end_time
FROM pg_stat_subscription
ORDER BY subname, relid;
