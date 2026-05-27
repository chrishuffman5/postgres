# Security Hardening

Use SCRAM-SHA-256 instead of MD5 where possible. Enforce SSL/TLS for untrusted networks.

Separate login roles from owner roles and application privilege roles. Avoid granting application users `SUPERUSER`, `CREATEDB`, `CREATEROLE`, or object ownership.

Set safe `search_path` values, especially for security definer functions. Use row-level security only with clear tests for bypass roles and owner behavior.
