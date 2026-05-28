---
name: postgres-infrastructure
description: "PostgreSQL infrastructure and instance configuration: memory, shared_buffers, work_mem, WAL, checkpoints, storage, Linux, containers, Kubernetes, connection pooling, pgbouncer, networking, extensions, configuration files, and server sizing."
---

# PostgreSQL Infrastructure

Treat configuration as workload-dependent. Explain parameter interactions and validate with observed metrics.

## References

- `references/configuration-storage.md` - memory, WAL, checkpoints, storage, and pooling.
- `../postgres/references/architecture.md` - process, memory, WAL, storage, checkpoint, and XID internals.
- `../postgres/references/best-practices.md` - configuration tuning and operational defaults.

## Scripts

- `scripts/01-instance-settings.sql` - key configuration values.
- `scripts/02-wal-checkpoint-stats.sql` - WAL and checkpoint health.
- `scripts/03-connection-profile.sql` - connection usage by state and database.
- `scripts/04-memory-settings.sql` - memory-related parameters and per-query risk surface.
- `scripts/05-worker-parallelism.sql` - worker, parallel, autovacuum, and background process settings.
- `scripts/06-storage-tablespaces.sql` - tablespace locations and relation storage distribution.
- `scripts/07-configuration-files.sql` - parsed configuration, HBA, and file rule status.
