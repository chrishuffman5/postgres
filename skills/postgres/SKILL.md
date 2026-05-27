---
name: postgres
description: "Comprehensive PostgreSQL expert and router covering operations, monitoring, replication/high availability, engineering, infrastructure, cloud, and security across self-managed PostgreSQL, RDS/Aurora, Cloud SQL, Azure Database for PostgreSQL, Supabase, Neon, and common extensions. Use when Codex needs PostgreSQL, Postgres, psql, pg_dump, pg_restore, SQL tuning, DBA, database administration, or cross-cutting PostgreSQL guidance."
---

# PostgreSQL Expert Router

Act as the top-level PostgreSQL expert and route deep work to the specialized skills in this plugin. Answer broad or cross-domain questions directly; load the focused skill when the request has a clear domain.

## Approach

1. Identify PostgreSQL major version, deployment platform, and privilege level.
2. Classify the domain and load the relevant skill.
3. Prefer PostgreSQL-native evidence: catalog views, `pg_stat_*`, wait events, `EXPLAIN (ANALYZE, BUFFERS)`, logs, and extension views.
4. Give actionable SQL, shell, or configuration steps with validation.
5. Separate self-managed behavior from managed-service restrictions.

## Routing Table

| Request | Route to skill | Common triggers |
|---|---|---|
| Backups, restores, PITR, vacuum, autovacuum, bloat, jobs, upgrades, disk space | `postgres-operations` | backup, restore, pg_dump, pg_restore, pg_basebackup, WAL archive, PITR, vacuum, autovacuum, bloat |
| Slow database, wait events, blocking, locks, stats views, query history, logs | `postgres-monitoring` | slow, wait_event, pg_stat_activity, pg_stat_statements, blocking, deadlock, high CPU, high I/O |
| Streaming replication, logical replication, slots, failover, Patroni, repmgr, WAL shipping | `postgres-ha-replication` | replica, replication lag, failover, standby, slot, logical replication, publication, subscription |
| SQL, indexing, plans, statistics, partitioning, schema design, extensions | `postgres-engineering` | EXPLAIN, index, query tuning, statistics, partition, JSONB, GIN, GiST, pgvector |
| Instance settings, memory, WAL, storage, Linux, containers, pooling, networking | `postgres-infrastructure` | shared_buffers, work_mem, WAL, checkpoint, storage, Docker, Kubernetes, pgbouncer |
| RDS/Aurora, Cloud SQL, Azure, Supabase, Neon, migration, managed-service limits | `postgres-cloud` | RDS, Aurora, Cloud SQL, Azure Database for PostgreSQL, Supabase, Neon, DMS, cloud migration |
| Auth, roles, privileges, SSL/TLS, RLS, auditing, encryption, hardening | `postgres-security` | authentication, pg_hba, SCRAM, role, grant, revoke, RLS, pgaudit, SSL, TLS |

## Cross-Cutting Fundamentals

- MVCC keeps old row versions until vacuum can remove them. Long transactions, abandoned replication slots, and insufficient autovacuum cause bloat and transaction ID risk.
- WAL is the durability and replication stream. Backup, PITR, replication, and write latency all depend on WAL health.
- Query tuning starts with `EXPLAIN (ANALYZE, BUFFERS)`, not estimates alone. Compare estimated vs actual rows before adding indexes.
- `pg_stat_statements` should be enabled for production query history when allowed.
- Managed services expose PostgreSQL but restrict superuser, filesystem access, extensions, and some parameters.

## Common Anti-Patterns

1. Disabling autovacuum instead of tuning it.
2. Leaving idle-in-transaction sessions open.
3. Creating every suggested index without checking overlap and write cost.
4. Treating `work_mem` as a global memory cap; it is per operation, per worker.
5. Keeping inactive replication slots that retain WAL indefinitely.
6. Running production without tested restores and monitored WAL archiving.
7. Granting application roles owner or superuser privileges.
