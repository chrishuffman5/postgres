SELECT backend_type,
       object,
       context,
       reads,
       read_time,
       writes,
       write_time,
       writebacks,
       writeback_time,
       extends,
       extend_time,
       hits,
       evictions,
       reuses,
       fsyncs,
       fsync_time,
       stats_reset
FROM pg_stat_io
ORDER BY (COALESCE(read_time, 0) + COALESCE(write_time, 0) + COALESCE(fsync_time, 0)) DESC
LIMIT 100;
