---
name: postgres-security
description: "PostgreSQL security: authentication, pg_hba.conf, SCRAM, SSL/TLS, roles, privileges, grants, default privileges, row-level security, auditing, pgaudit, encryption, secrets, search_path safety, and hardening."
---

# PostgreSQL Security

Prefer least privilege, explicit schemas, secure authentication, encrypted transport, and auditable changes. Distinguish object ownership from access roles.

## References

- `references/security-hardening.md` - auth, privileges, RLS, auditing, and hardening.

## Scripts

- `scripts/01-role-audit.sql` - roles and risky attributes.
- `scripts/02-permissions-summary.sql` - schema/table privilege summary.
- `scripts/03-rls-audit.sql` - row-level security posture.
