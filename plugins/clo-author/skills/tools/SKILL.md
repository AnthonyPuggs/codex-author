---
name: tools
description: Run utility workflows for compiling papers, validating bibliographies, inspecting context status, maintaining project memory, bootstrapping the template into a working project, and refreshing infrastructure docs. Use when the user asks to compile, validate citations, summarize session state, initialize the template, extract learnings, or run utility checks.
---

# Tools

Use this skill for small, mechanical, or maintenance-focused workflows.

## Read First

- `AGENTS.md`
- `plugins/clo-author/references/codex-workflow.md`
- `plugins/clo-author/references/logging.md`
- `MEMORY.md` when the task concerns learning or continuity

## Common Subroutines

- Compile paper or talk
- Validate bibliography keys
- Summarize project context from plans and logs
- Extract durable lessons into `MEMORY.md`
- Build or refresh docs when the repo changes materially
- Bootstrap the template into a filled-in working project
- Refresh plugin and documentation infrastructure without overwriting user research content

## Procedure

1. Keep these tasks lightweight; avoid unnecessary orchestration.
2. Prefer deterministic commands and scripts over free-form reasoning when possible.
3. When updating memory, write concise `[LEARN:*]` entries grounded in actual mistakes or durable workflow discoveries.
4. For paper compilation, use the active `xelatex -> biber -> xelatex -> xelatex` chain from `AGENTS.md`.
5. For template bootstrap, update placeholders and project-state stubs deliberately rather than mixing template defaults with project facts.
6. For infrastructure refreshes, preserve user content under `paper/`, `scripts/`, `data/`, `quality_reports/`, `MEMORY.md`, and project-specific calibrations in the domain and journal profiles.

## Outputs

- Updated `MEMORY.md` when requested
- Compile or validation output summarized back to the user
- Bootstrap or infrastructure-refresh checklist when requested
- Short maintenance note in `quality_reports/` only when the utility run is substantial
