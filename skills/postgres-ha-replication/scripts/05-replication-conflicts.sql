SELECT datname,
       confl_tablespace,
       confl_lock,
       confl_snapshot,
       confl_bufferpin,
       confl_deadlock
FROM pg_stat_database_conflicts
WHERE datname IS NOT NULL
ORDER BY datname;

SELECT name, setting, unit, source, pending_restart
FROM pg_settings
WHERE name IN ('hot_standby', 'hot_standby_feedback', 'max_standby_archive_delay',
               'max_standby_streaming_delay', 'vacuum_defer_cleanup_age',
               'primary_conninfo', 'primary_slot_name', 'recovery_target_timeline')
ORDER BY name;
