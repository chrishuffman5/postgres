---
name: postgres-security
description: "PostgreSQL security: authentication, pg_hba.conf, SCRAM, SSL/TLS, roles, privileges, grants, default privileges, row-level security, auditing, pgaudit, encryption, secrets, search_path safety, and hardening."
---

# PostgreSQL Security

Prefer least privilege, explicit schemas, secure authentication, encrypted transport, and auditable changes. Distinguish object ownership from access roles.

## References

- `references/security-hardening.md` - auth, privileges, RLS, auditing, and hardening.
- `../postgres/references/best-practices.md` - imported domain-expert `pg_hba.conf`, role management, auditing, and hardening material.
- `../postgres/references/versions/postgresql-15.md` - public schema permission changes.
- `../postgres/references/versions/postgresql-17.md` - `MAINTAIN` privilege notes.

## Scripts

- `scripts/01-role-audit.sql` - roles and risky attributes.
- `scripts/02-permissions-summary.sql` - schema/table privilege summary.
- `scripts/03-rls-audit.sql` - row-level security posture.
- `scripts/04-hba-and-auth.sql` - parsed HBA rules and auth-related settings.
- `scripts/05-default-privileges.sql` - default privilege grants.
- `scripts/06-security-definer-functions.sql` - security definer functions and search path risk.
- `scripts/07-public-schema-and-ownership.sql` - public schema, owners, and broad grants.
- `scripts/08-ssl-audit.sql` - SSL posture and active SSL connections.
