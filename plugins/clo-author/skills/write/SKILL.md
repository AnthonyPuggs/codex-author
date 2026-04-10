---
name: write
description: Draft, rewrite, or polish manuscript sections for empirical social-science papers. Use when the user asks to write an introduction, strategy section, results section, abstract, conclusion, or to remove AI-sounding patterns from existing prose.
---

# Write

Use this skill for manuscript drafting and revision.

## Read First

- `AGENTS.md`
- `plugins/clo-author/references/codex-workflow.md`
- `plugins/clo-author/references/agent-catalog.md`
- `plugins/clo-author/references/content-invariants.md`
- `plugins/clo-author/references/domain-profile.md`

## Procedure

1. Read the relevant paper section and the latest strategy or results artifacts.
2. Draft only claims supported by existing evidence.
3. Follow field notation and paper structure conventions from the domain profile.
4. Run writer-critic review for notation consistency, hedging, unsupported claims, LaTeX issues, and any relevant invariant violations.
5. If the task is "humanize" or "rewrite", preserve meaning while stripping repetitive AI prose patterns.

## Outputs

- Updated section files under `paper/sections/` or `paper/main.tex`
- Review notes in `quality_reports/` when the revision is substantial
