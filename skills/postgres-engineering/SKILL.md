---
name: postgres-engineering
description: "PostgreSQL SQL engineering and performance: EXPLAIN plans, indexing, statistics, joins, partitioning, schema design, constraints, JSONB, full text, GIN/GiST/BRIN/B-tree indexes, pgvector, extensions, and query tuning."
---

# PostgreSQL Engineering

Use plans and workload evidence before changing schema or indexes. Explain both read performance and write amplification.

## References

- `references/query-indexing.md` - plan reading, index choices, statistics, and partitioning.

## Scripts

- `scripts/01-index-usage.sql` - index usage and size.
- `scripts/02-missing-index-signals.sql` - sequential scan pressure signals.
- `scripts/03-table-statistics.sql` - table statistics freshness.
