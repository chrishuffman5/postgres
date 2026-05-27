---
name: postgres-infrastructure
description: "PostgreSQL infrastructure and instance configuration: memory, shared_buffers, work_mem, WAL, checkpoints, storage, Linux, containers, Kubernetes, connection pooling, pgbouncer, networking, extensions, configuration files, and server sizing."
---

# PostgreSQL Infrastructure

Treat configuration as workload-dependent. Explain parameter interactions and validate with observed metrics.

## References

- `references/configuration-storage.md` - memory, WAL, checkpoints, storage, and pooling.

## Scripts

- `scripts/01-instance-settings.sql` - key configuration values.
- `scripts/02-wal-checkpoint-stats.sql` - WAL and checkpoint health.
- `scripts/03-connection-profile.sql` - connection usage by state and database.
