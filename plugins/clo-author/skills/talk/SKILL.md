---
name: talk
description: Create, audit, or compile presentations derived from the paper using Storyteller plus storyteller-critic. Use when the user asks for a job-market talk, seminar, short talk, lightning talk, or slide audit.
---

# Talk

Create, audit, or compile presentations derived from the paper.

## Read First

- `AGENTS.md`
- `plugins/clo-author/references/codex-workflow.md`
- `plugins/clo-author/references/agent-catalog.md`
- `plugins/clo-author/references/content-invariants.md`
- `paper/main.tex` or the active manuscript source

## Modes

- create
- audit
- compile

## Create

Supported formats:

| Format | Slides | Duration | Scope |
|--------|--------|----------|-------|
| `job-market` | 40-50 | 45-60 min | Full paper story |
| `seminar` | 25-35 | 30-45 min | Main result plus selected robustness |
| `short` | 10-15 | 15 min | Question, method, result, implication |
| `lightning` | 3-5 | 5 min | Hook, one result, so-what |

Workflow:

1. dispatch Storyteller to build the deck from the paper
2. prefer figures over tables, with tables in backup where possible
3. ensure every claim in the deck is supported by the paper
4. dispatch storyteller-critic to review narrative flow, visual quality, fidelity, scope control, and compilation
5. if there are critical issues, revise and re-review up to the normal round limit

## Audit

Audit existing slides for:

- text overflow
- font readability
- table readability
- figure sizing
- format compliance
- unsupported claims

## Compile

For Beamer:

```bash
cd paper/talks && TEXINPUTS=../preambles:$TEXINPUTS xelatex -interaction=nonstopmode talk.tex
```

For Quarto, render the requested file under `paper/quarto/`.

## Outputs

- Beamer talk in `paper/talks/`
- Quarto talk in `paper/quarto/`
- audit memo in `quality_reports/`

Talk scores remain advisory unless the user explicitly requests a gate.
