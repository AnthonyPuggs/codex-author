---
name: tools
description: Utility workflows for compile, bibliography validation, journal/log inspection, runtime smoke tests, memory updates, bootstrap tasks, and infrastructure refresh. Use when the user asks for mechanical project maintenance rather than substantive research work.
---

# Tools

Run lightweight utility workflows for project maintenance and infrastructure.

## Read First

- `AGENTS.md`
- `plugins/clo-author/references/runtime-activation.md`
- `plugins/clo-author/references/codex-workflow.md`
- `plugins/clo-author/references/logging.md`
- `MEMORY.md` when the task concerns durable learnings

## Supported Subroutines

- commit preparation
- compile
- validate bibliography
- journal timeline summary
- context summary
- deploy docs
- learn
- runtime activation smoke test
- bootstrap template
- upgrade infrastructure

## Common Procedures

### Compile

Use the active paper chain:

```bash
cd paper && TEXINPUTS=preambles:$TEXINPUTS xelatex -interaction=nonstopmode main.tex
biber main
TEXINPUTS=preambles:$TEXINPUTS xelatex -interaction=nonstopmode main.tex
TEXINPUTS=preambles:$TEXINPUTS xelatex -interaction=nonstopmode main.tex
```

### Validate Bibliography

Cross-check `\cite{}` keys against `Bibliography_base.bib` and report:

- missing keys
- unused keys
- duplicates

### Runtime Activation Smoke Test

Use `plugins/clo-author/references/runtime-activation.md` as the contract and report whether the session is active or blocked before claiming the plugin is available.

### Journal / Context Summary

Summarise the latest plan, session log, and research journal when the user asks for current state or recovery context.

### Learn

When updating memory, write concise `[LEARN:*]` entries grounded in actual mistakes or durable workflow discoveries.

### Upgrade Infrastructure

Refresh the Codex-native infrastructure selectively:

- update `plugins/clo-author/skills/`
- update `plugins/clo-author/references/`
- update templates and guide docs
- preserve user research content under `paper/`, `scripts/`, `data/`, `quality_reports/`, and `MEMORY.md`

## Principles

- Keep these tasks lightweight.
- Prefer deterministic commands and scripts.
- Treat compile, lint, and activation checks as evidence-producing workflows.
- Never overwrite user research content during infrastructure refreshes.
