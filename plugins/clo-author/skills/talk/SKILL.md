---
name: talk
description: Create, audit, or compile presentations derived from the paper. Use when the user asks for a job market talk, seminar, short talk, lightning talk, Quarto reveal deck, slide audit, or slide compilation.
---

# Talk

Use this skill for presentation work.

## Read First

- `AGENTS.md`
- `plugins/clo-author/references/codex-workflow.md`
- `plugins/clo-author/references/agent-catalog.md`
- `plugins/clo-author/references/content-invariants.md`
- `paper/main.tex` or the current manuscript source

## Procedure

1. Determine the requested format and duration.
2. Use Storyteller to derive the talk directly from the paper; do not invent results.
3. Use storyteller-critic to review narrative flow, visual density, fidelity to the paper, and any invariant violations around notation or unsupported slide claims.
4. Compile or render the output when the user asks for verification.

## Outputs

- Beamer talk in `paper/talks/`
- Quarto talk in `paper/quarto/`
- Audit memo in `quality_reports/` when reviewing an existing talk
