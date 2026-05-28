---
name: postgres-ha-replication
description: "PostgreSQL replication and high availability: streaming replication, physical standbys, logical replication, publications, subscriptions, replication slots, WAL shipping, failover, Patroni, repmgr, pg_auto_failover, synchronous commit, and disaster recovery."
---

# PostgreSQL HA And Replication

Diagnose lag by separating WAL generation, send, write, flush, replay, slots, and apply conflicts. For HA advice, identify whether the system uses native replication only or an orchestrator such as Patroni.

## References

- `references/replication-ha.md` - replication modes, lag, slots, failover, and DR.
- `../postgres/references/architecture.md` - WAL internals and recovery behavior.
- `../postgres/references/versions/postgresql-17.md` - failover slots and logical replication updates.

## Scripts

- `scripts/01-replication-status.sql` - primary-side streaming replication.
- `scripts/02-replication-slots.sql` - slot retention and risk.
- `scripts/03-standby-status.sql` - standby replay and receive status.
- `scripts/04-logical-replication.sql` - publications, subscriptions, and subscription workers.
- `scripts/05-replication-conflicts.sql` - standby conflicts and recovery settings.
- `scripts/06-wal-archive-posture.sql` - WAL archiving, sender, receiver, and retention settings.
- `scripts/07-failover-readiness.sql` - sync replication, slots, replay delay, and key HA settings.
