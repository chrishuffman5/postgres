---
name: postgres-ha-replication
description: "PostgreSQL replication and high availability: streaming replication, physical standbys, logical replication, publications, subscriptions, replication slots, WAL shipping, failover, Patroni, repmgr, pg_auto_failover, synchronous commit, and disaster recovery."
---

# PostgreSQL HA And Replication

Diagnose lag by separating WAL generation, send, write, flush, replay, slots, and apply conflicts. For HA advice, identify whether the system uses native replication only or an orchestrator such as Patroni.

## References

- `references/replication-ha.md` - replication modes, lag, slots, failover, and DR.

## Scripts

- `scripts/01-replication-status.sql` - primary-side streaming replication.
- `scripts/02-replication-slots.sql` - slot retention and risk.
- `scripts/03-standby-status.sql` - standby replay and receive status.
