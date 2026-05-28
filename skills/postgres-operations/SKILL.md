---
name: postgres-operations
description: "PostgreSQL operations for backups, restores, PITR, pg_dump, pg_restore, pg_basebackup, WAL archiving, vacuum, autovacuum, bloat, transaction ID wraparound, maintenance jobs, upgrades, and capacity management."
---

# PostgreSQL Operations

Focus on recoverability, maintenance safety, and capacity. Always distinguish logical backups from physical backups and require restore validation for production.

## References

- `references/backup-maintenance.md` - backup, restore, PITR, vacuum, and bloat guidance.
- `../postgres/references/best-practices.md` - imported domain-expert backup, vacuum, bloat, and configuration material.
- `../postgres/references/architecture.md` - MVCC, WAL, checkpoint, heap, FSM/VM, and XID internals.

## Scripts

- `scripts/01-backup-readiness.sql` - archiving and WAL settings.
- `scripts/02-vacuum-health.sql` - autovacuum and transaction ID risk.
- `scripts/03-table-bloat-signals.sql` - dead tuple and table-size signals.
- `scripts/04-xid-wraparound-risk.sql` - database and table freeze-age risk.
- `scripts/05-autovacuum-configuration.sql` - global and per-table autovacuum settings.
- `scripts/06-relation-capacity.sql` - largest relations, tablespaces, and database sizes.
- `scripts/07-maintenance-progress.sql` - active vacuum, analyze, cluster, create-index, and base-backup progress.
- `scripts/08-invalid-unlogged-toast.sql` - invalid indexes, unlogged tables, TOAST, and persistence risks.
