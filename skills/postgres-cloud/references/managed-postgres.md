# Managed PostgreSQL

Managed services patch, back up, and monitor parts of the stack, but the application still owns schema design, query tuning, roles, extensions, connection management, and restore objectives.

RDS and Aurora use parameter groups and expose restricted roles. Cloud SQL and Azure Flexible Server have similar managed knobs and extension allowlists. Supabase and Neon add platform abstractions around auth, branching, storage, pooling, and serverless behavior.

Migration planning should include extension compatibility, collation/locale, downtime tolerance, replication method, sequence synchronization, and cutover validation.
