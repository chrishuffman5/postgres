# Query And Indexing

Use `EXPLAIN (ANALYZE, BUFFERS)` to compare estimates and actuals. Bad estimates often point to stale stats, correlated columns, skew, or missing extended statistics.

B-tree is the default for equality and range predicates. GIN is common for arrays, JSONB containment, and full text. GiST supports geometric/range use cases. BRIN is effective for large naturally ordered tables.

Indexes speed reads but slow writes and consume cache. Consolidate overlapping indexes before adding new ones.
