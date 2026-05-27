---
name: postgres-cloud
description: "Managed PostgreSQL cloud platforms: Amazon RDS for PostgreSQL, Aurora PostgreSQL, Google Cloud SQL, AlloyDB, Azure Database for PostgreSQL Flexible Server, Supabase, Neon, migrations, cloud limits, backups, monitoring, HA, read replicas, and parameter groups."
---

# PostgreSQL Cloud

Map the managed service to its control-plane limits before giving operational advice. Superuser, filesystem access, extensions, replication, parameters, and backup controls differ by provider.

## References

- `references/managed-postgres.md` - provider-specific constraints and migration notes.

## Scripts

- `scripts/01-cloud-posture.sql` - portable service and extension posture.
- `scripts/02-managed-settings.sql` - settings usually managed by cloud providers.
