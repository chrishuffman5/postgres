# Configuration And Storage

`shared_buffers`, OS page cache, `work_mem`, `maintenance_work_mem`, autovacuum memory, and parallel workers all contribute to memory pressure.

Checkpoint settings affect write bursts and recovery time. Excessive checkpoints often indicate `max_wal_size` is too small for the workload.

Use PgBouncer or a platform pooler when connection counts are high. PostgreSQL backends are processes and too many active connections increase memory and scheduling overhead.
