SELECT pg_is_in_recovery() AS is_standby,
       pg_current_wal_lsn() AS current_wal_lsn,
       pg_last_wal_receive_lsn() AS last_receive_lsn,
       pg_last_wal_replay_lsn() AS last_replay_lsn,
       pg_last_xact_replay_timestamp() AS last_replay_timestamp;

SELECT application_name,
       client_addr,
       state,
       sync_state,
       sync_priority,
       write_lag,
       flush_lag,
       replay_lag,
       pg_size_pretty(pg_wal_lsn_diff(pg_current_wal_lsn(), replay_lsn)) AS replay_lag_bytes
FROM pg_stat_replication
ORDER BY sync_priority, application_name;

SELECT slot_name,
       slot_type,
       active,
       temporary,
       restart_lsn,
       wal_status,
       safe_wal_size
FROM pg_replication_slots
ORDER BY active DESC, slot_name;
