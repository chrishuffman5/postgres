SELECT pg_is_in_recovery() AS is_standby,
       pg_last_wal_receive_lsn() AS receive_lsn,
       pg_last_wal_replay_lsn() AS replay_lsn,
       pg_last_xact_replay_timestamp() AS last_replay_timestamp,
       now() - pg_last_xact_replay_timestamp() AS replay_delay;

SELECT pid, status, receive_start_lsn, written_lsn, flushed_lsn, latest_end_lsn,
       latest_end_time, slot_name, sender_host, sender_port
FROM pg_stat_wal_receiver;
