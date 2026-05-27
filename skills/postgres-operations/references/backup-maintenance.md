# Backup And Maintenance

Logical backups (`pg_dump`, `pg_dumpall`) are portable but not enough for low-RPO PITR at scale. Physical backups (`pg_basebackup`, filesystem snapshots with correct coordination, or tools such as pgBackRest/Barman) plus continuous WAL archiving support PITR.

Validate backups with actual restores. A successful backup command only proves bytes were written.

Autovacuum prevents bloat and transaction ID wraparound. Tune it per table when large or high-churn tables need more aggressive cleanup.
