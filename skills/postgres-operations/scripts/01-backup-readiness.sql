SELECT name, setting, unit
FROM pg_settings
WHERE name IN ('archive_mode', 'archive_command', 'wal_level', 'max_wal_senders',
               'max_replication_slots', 'wal_keep_size', 'checkpoint_timeout',
               'max_wal_size', 'full_page_writes')
ORDER BY name;

SELECT archived_count, last_archived_wal, last_archived_time,
       failed_count, last_failed_wal, last_failed_time,
       stats_reset
FROM pg_stat_archiver;
