# Postgres Plugin

This repository contains a PostgreSQL database expert plugin. Keep the plugin shape aligned with the SQL Server reference repository:

- `.codex-plugin/plugin.json` is the Codex manifest.
- `.claude-plugin/` is retained for parity with the source plugin layout.
- `skills/postgres/SKILL.md` is the top-level router.
- Domain folders under `skills/` contain concise skill instructions, references, and read-only SQL diagnostics.

When updating a skill, keep `SKILL.md` focused on workflow and routing. Move detailed matrices, examples, and command catalogs into `references/`.
