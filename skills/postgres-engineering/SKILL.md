---
name: postgres-engineering
description: "PostgreSQL SQL engineering and performance: EXPLAIN plans, indexing, statistics, joins, partitioning, schema design, constraints, JSONB, full text, GIN/GiST/BRIN/B-tree indexes, pgvector, extensions, and query tuning."
---

# PostgreSQL Engineering

Use plans and workload evidence before changing schema or indexes. Explain both read performance and write amplification.

## References

- `references/query-indexing.md` - plan reading, index choices, statistics, and partitioning.
- `../postgres/references/diagnostics.md` - imported domain-expert plan analysis, `EXPLAIN ANALYZE`, and diagnostics material.
- `../postgres/references/versions/` - version-specific SQL and optimizer features.

## Scripts

- `scripts/01-index-usage.sql` - index usage and size.
- `scripts/02-missing-index-signals.sql` - sequential scan pressure signals.
- `scripts/03-table-statistics.sql` - table statistics freshness.
- `scripts/04-duplicate-indexes.sql` - structurally duplicate indexes.
- `scripts/05-foreign-key-index-check.sql` - foreign keys without matching leading-column indexes.
- `scripts/06-partition-inventory.sql` - partitioned tables, partition children, and bounds.
- `scripts/07-extended-statistics.sql` - extended statistics definitions and collected data.
- `scripts/08-function-volatility.sql` - function volatility, parallel safety, and security-definer posture.
