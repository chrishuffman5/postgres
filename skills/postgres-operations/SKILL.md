---
name: postgres-operations
description: "PostgreSQL operations for backups, restores, PITR, pg_dump, pg_restore, pg_basebackup, WAL archiving, vacuum, autovacuum, bloat, transaction ID wraparound, maintenance jobs, upgrades, and capacity management."
---

# PostgreSQL Operations

Focus on recoverability, maintenance safety, and capacity. Always distinguish logical backups from physical backups and require restore validation for production.

## References

- `references/backup-maintenance.md` - backup, restore, PITR, vacuum, and bloat guidance.

## Scripts

- `scripts/01-backup-readiness.sql` - archiving and WAL settings.
- `scripts/02-vacuum-health.sql` - autovacuum and transaction ID risk.
- `scripts/03-table-bloat-signals.sql` - dead tuple and table-size signals.
