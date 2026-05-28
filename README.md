# Postgres

Postgres is a Codex plugin and skill collection for PostgreSQL database work. It mirrors the structure of the `sqlserver` plugin, with a top-level routing skill and focused domain skills for production administration.

## Installation

### Claude Code (via Plugin Marketplace)

In Claude Code, register the marketplace first:

```text
/plugin marketplace add chrishuffman5/postgres
```

Then install the plugin from that marketplace:

```text
/plugin install postgres@chrishuffman5
```

### Claude Code (manual)

```bash
git clone https://github.com/chrishuffman5/postgres.git .claude/plugins/postgres/
```

Claude Code discovers the plugin through `.claude-plugin/plugin.json`.

### OpenAI Codex CLI

Codex discovers skills from `SKILL.md` files under `~/.codex/skills/`. Install this repository, then copy the skill folders into Codex's skills directory:

```bash
git clone https://github.com/chrishuffman5/postgres.git ~/.codex/skills/postgres-plugin/
cp -R ~/.codex/skills/postgres-plugin/skills/* ~/.codex/skills/
```

On Windows PowerShell:

```powershell
git clone https://github.com/chrishuffman5/postgres.git $env:USERPROFILE\.codex\skills\postgres-plugin
Copy-Item -Recurse -Force $env:USERPROFILE\.codex\skills\postgres-plugin\skills\* $env:USERPROFILE\.codex\skills\
```

Restart Codex after installing so the new skills are loaded.

### Verify Installation

Start a new session and ask for something that should trigger the PostgreSQL router or a domain skill:

```text
Our PostgreSQL 16 database is slow and has lock waits. Diagnose it.
Review this Postgres configuration for memory, WAL, and autovacuum issues.
Plan a migration from SQL Server to PostgreSQL 17.
Audit PostgreSQL roles, RLS, SSL, and broad grants.
```

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

## Reference Material

The top-level `postgres` router includes imported material from the [`domain-expert`](https://github.com/chrishuffman5/domain-expert) PostgreSQL section:

- architecture internals
- diagnostics and `pg_stat_*` usage
- best practices for configuration, backup, vacuum, and security
- PostgreSQL 14, 15, 16, 17, and 18 feature notes

The router also includes discovery scripts under `skills/postgres/scripts/` for catalog, settings, extensions, statistics, runtime, maintenance, and replication inventory.
