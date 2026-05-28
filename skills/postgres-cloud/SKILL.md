---
name: postgres-cloud
description: "Managed PostgreSQL cloud platforms: Amazon RDS for PostgreSQL, Aurora PostgreSQL, Google Cloud SQL, AlloyDB, Azure Database for PostgreSQL Flexible Server, Supabase, Neon, migrations, cloud limits, backups, monitoring, HA, read replicas, and parameter groups."
---

# PostgreSQL Cloud

Map the managed service to its control-plane limits before giving operational advice. Superuser, filesystem access, extensions, replication, parameters, and backup controls differ by provider.

## References

- `references/managed-postgres.md` - provider-specific constraints and migration notes.
- `../postgres/references/best-practices.md` - imported domain-expert managed-relevant backup, tuning, auth, and vacuum guidance.
- `../postgres/references/versions/` - version-specific compatibility checks during migrations.

## Scripts

- `scripts/01-cloud-posture.sql` - portable service and extension posture.
- `scripts/02-managed-settings.sql` - settings usually managed by cloud providers.
- `scripts/03-extension-compatibility.sql` - installed and available extensions with schemas and versions.
- `scripts/04-managed-limits.sql` - connection, worker, replication, WAL, and timeout settings.
- `scripts/05-migration-readiness.sql` - database objects that commonly affect cloud migrations.
