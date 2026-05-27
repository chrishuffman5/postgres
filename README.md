# Postgres

Postgres is a Codex plugin and skill collection for PostgreSQL database work. It mirrors the structure of the `sqlserver` plugin, with a top-level routing skill and focused domain skills for production administration.

## Skills

- `postgres` - top-level router for PostgreSQL questions and cross-domain work.
- `postgres-operations` - backups, restores, maintenance, vacuum, bloat, capacity, and jobs.
- `postgres-monitoring` - wait events, `pg_stat_*` views, blocking, Query Store-style extensions, and performance triage.
- `postgres-ha-replication` - streaming replication, logical replication, failover, slots, WAL shipping, and DR.
- `postgres-engineering` - SQL, indexing, query plans, statistics, partitioning, schema design, and extensions.
- `postgres-infrastructure` - instance settings, memory, WAL, storage, Linux, containers, and networking.
- `postgres-cloud` - RDS/Aurora, Cloud SQL, Azure Database for PostgreSQL, Supabase, Neon, and migrations.
- `postgres-security` - authentication, authorization, SSL/TLS, RLS, auditing, encryption, and hardening.

The SQL scripts are read-only diagnostics unless a filename or comments explicitly say otherwise.
