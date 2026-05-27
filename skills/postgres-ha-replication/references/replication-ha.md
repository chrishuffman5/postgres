# Replication And HA

Physical streaming replication copies WAL to a standby. Logical replication copies data changes through publications and subscriptions.

Replication slots prevent WAL removal until consumers confirm progress. Inactive or lagging slots can fill storage.

Synchronous replication improves data-loss guarantees but makes commit latency depend on standby acknowledgement. Failover tooling must handle leader election, fencing, DNS or proxy changes, and client reconnection.
