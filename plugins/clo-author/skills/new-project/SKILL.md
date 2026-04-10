---
name: new-project
description: Set up a new empirical social-science research project inside this repository. Use when the user wants to start a new project, initialize the repo for a topic, fill in project metadata, build a research spec, or kick off the full research pipeline from idea to paper.
---

# New Project

Use this skill to launch the Codex-native Clo-Author workflow for a fresh research project.

## Read First

- `AGENTS.md`
- `MEMORY.md`
- `plugins/clo-author/references/codex-workflow.md`
- `plugins/clo-author/references/agent-catalog.md`
- `plugins/clo-author/references/domain-profile.md`

## Procedure

1. Clarify the project topic, field, target contribution, and current materials.
2. If the request is broad or ambiguous, create a requirements spec in `quality_reports/specs/`.
3. Create and save an implementation plan in `quality_reports/plans/`.
4. Update `AGENTS.md` placeholders and the active domain profile when the user wants the repository customized to their project.
5. Produce the initial discovery outputs:
   - research question framing
   - initial literature search brief
   - initial data search brief
   - recommended next phase
6. Save an initial session log when the work will continue beyond one short interaction.

## Delegation

- Default worker roles: Librarian, Explorer, Strategist
- Default critic roles: librarian-critic, explorer-critic, strategist-critic
- Run discovery roles in parallel only when their scopes are independent

## Outputs

- `quality_reports/specs/YYYY-MM-DD_*.md` when needed
- `quality_reports/plans/YYYY-MM-DD_*.md`
- `quality_reports/session_logs/YYYY-MM-DD_*.md`
- Updated `AGENTS.md` and `plugins/clo-author/references/domain-profile.md` when customization is requested
