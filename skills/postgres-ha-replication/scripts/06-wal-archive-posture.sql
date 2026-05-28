SELECT name, setting, unit, context, source, pending_restart
FROM pg_settings
WHERE name IN ('wal_level', 'archive_mode', 'archive_command', 'archive_library',
               'max_wal_senders', 'max_replication_slots', 'wal_keep_size',
               'max_slot_wal_keep_size', 'synchronous_commit',
               'synchronous_standby_names', 'full_page_writes')
ORDER BY name;

SELECT archived_count,
       last_archived_wal,
       last_archived_time,
       failed_count,
       last_failed_wal,
       last_failed_time,
       stats_reset
FROM pg_stat_archiver;
