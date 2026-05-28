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

When the user gives only a symptom, avoid jumping to a fix. PostgreSQL usually leaves evidence in one of five places: wait events, statistics views, execution plans, logs, or control-plane metrics. Start with the cheapest source and only ask for invasive tests when the read-only path is exhausted.

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

## Version And Feature Matrix

| Major version | Status to verify | Features that often matter |
|---|---|---|
| 12 | Old in many fleets | Generated columns, REINDEX CONCURRENTLY, SQL/JSON path, CTE inlining by default |
| 13 | Common managed baseline | B-tree deduplication, incremental sort, parallel vacuum for indexes |
| 14 | Common production version | Multirange types, better connection scaling, `pg_stat_wal`, logical replication improvements |
| 15 | Modern baseline | `MERGE`, `UNIQUE NULLS NOT DISTINCT`, logical replication row/column filters |
| 16 | Modern baseline | `pg_stat_io`, logical replication from standbys, parallel query improvements |
| 17 | Newer fleets | Incremental backup support through core tooling, memory and vacuum improvements, more SQL/JSON support |
| 18 | Current/new installs | Check exact feature set and extension support before relying on newly introduced behavior |

Always confirm the actual server with:

```sql
SELECT version();
SHOW server_version;
SHOW server_version_num;
```

Feature availability also depends on managed-service allowlists, extension versions, operating system packages, and parameter mutability.

## Deployment Matrix

| Platform | Operational model | Things to check first |
|---|---|---|
| Self-managed Linux | Full control of OS, storage, packages, config files | systemd unit, data directory, WAL/archive paths, filesystem latency, kernel limits |
| Containers/Kubernetes | Stateful workload behind orchestration | persistent volumes, pod disruption budgets, probes, operator behavior, backup sidecars |
| Amazon RDS for PostgreSQL | Managed instance, restricted superuser | parameter group, option/extension support, Performance Insights, automated backup retention |
| Aurora PostgreSQL | Distributed storage, writer/reader endpoints | cluster vs instance metrics, replica lag semantics, parameter groups, fast clone/snapshot behavior |
| Google Cloud SQL / AlloyDB | Managed Postgres family | flags, maintenance window, private networking, IAM auth, extension allowlist |
| Azure Database for PostgreSQL Flexible Server | Managed server, parameter controls | server parameters, zone redundancy, private access, Entra auth, storage autoscale |
| Supabase | Postgres with platform auth/storage/realtime | auth schemas, RLS defaults, pooler, extension policy, platform migrations |
| Neon | Serverless Postgres with branching | cold starts, branch lineage, compute/storage split, pooling, limits |

## First Questions For Ambiguous Requests

- Version and platform: `SHOW server_version;` and provider/deployment model.
- Workload: OLTP, analytics, mixed, multi-tenant, ingestion, queue-like, or geospatial/vector.
- Symptom window: when it started, whether it is constant or periodic, and recent deploy/config/data changes.
- Privilege level: superuser, managed service admin role, app role, or read-only observer.
- Safety boundary: production vs non-production; whether `EXPLAIN ANALYZE` can execute the statement.

## PostgreSQL-Specific Habits

Use PostgreSQL terms precisely:

- A database contains schemas; schemas contain objects. Cross-database queries are not native.
- Roles are both users and groups. Login ability is an attribute, not a separate principal type.
- MVCC cleanup is vacuum-driven. Updates and deletes create dead tuples; they do not update rows in place.
- WAL volume is caused by writes, full-page images, checkpoints, replication, and backup/archive strategy.
- Locks are normal. The problem is usually lock duration, incompatible mode, head blockers, or DDL.
- `work_mem` is not a server-wide allocation. A single query can use it multiple times across workers.
- `pg_stat_*` counters are cumulative since reset. Use deltas for rates.

## Domain Skills

- `postgres-monitoring` - symptom triage, waits, stats views, blocking, query history, logs.
- `postgres-operations` - backup/recovery, vacuum, bloat, wraparound, jobs, upgrades, capacity.
- `postgres-ha-replication` - streaming replication, logical replication, slots, failover, DR.
- `postgres-engineering` - SQL, plans, indexes, statistics, partitioning, schema and extension design.
- `postgres-infrastructure` - server settings, memory, WAL/checkpoints, storage, Linux, containers, pooling.
- `postgres-cloud` - RDS/Aurora, Cloud SQL, AlloyDB, Azure, Supabase, Neon, migrations.
- `postgres-security` - auth, roles, privileges, RLS, auditing, encryption, hardening.

## Imported Domain-Expert References

Use these first when the request needs deeper PostgreSQL background instead of a narrow script:

- `references/architecture.md` - process model, shared memory, heap storage, tuple headers, HOT, TOAST, FSM/VM, WAL, checkpoints, and XID management.
- `references/best-practices.md` - configuration tuning, `pg_hba.conf`, backup strategy, vacuum tuning, bloat remediation, and security hardening.
- `references/diagnostics.md` - `pg_stat_*` view usage, lock analysis, `EXPLAIN ANALYZE`, `auto_explain`, log analysis, and pgBadger.
- `references/versions/postgresql-14.md` through `references/versions/postgresql-18.md` - version-specific features, boundaries, pitfalls, and migration notes.

## Router-Level Discovery Scripts

Run these when the agent does not yet know what observability surface exists in the target environment:

- `scripts/00-environment-fingerprint.sql` - version, platform clues, recovery state, current role/database, key paths.
- `scripts/01-system-catalog-map.sql` - discover PostgreSQL catalog, information schema, and statistics views.
- `scripts/02-observability-surface.sql` - installed/available diagnostic extensions and preload requirements.
- `scripts/03-settings-inventory.sql` - full setting inventory with source, context, restart requirements, and non-defaults.
- `scripts/04-database-inventory.sql` - database size, encoding, collation, connection limits, age, and privileges.
- `scripts/05-schema-object-inventory.sql` - schemas, tables, views, materialized views, partitions, routines, and object counts.
- `scripts/06-table-index-inventory.sql` - relation sizes, persistence, access methods, reloptions, and index definitions.
- `scripts/07-statistics-inventory.sql` - table/index stats, extended stats, column stats, and stale-analyze signals.
- `scripts/08-runtime-diagnostics.sql` - current sessions, waits, blockers, prepared transactions, and background activity.
- `scripts/09-maintenance-replication-inventory.sql` - vacuum, WAL, replication, slots, archiving, and recovery posture.
