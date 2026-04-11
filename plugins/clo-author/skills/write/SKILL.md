---
name: write
description: Draft or revise manuscript sections with Writer plus writer-critic support. Use when the user asks for introductions, strategy sections, results sections, abstracts, conclusions, or a humanising rewrite pass.
---

# Write

Draft paper sections or apply a humaniser pass by dispatching the Writer workflow.

## Read First

- `AGENTS.md`
- `plugins/clo-author/references/runtime-activation.md`
- `plugins/clo-author/references/codex-workflow.md`
- `plugins/clo-author/references/agent-catalog.md`
- `plugins/clo-author/references/content-invariants.md`
- `plugins/clo-author/references/domain-profile.md`
- `plugins/clo-author/references/logging.md`

## Modes

- introduction
- strategy
- results
- conclusion
- abstract
- full draft
- humanise / rewrite

## Context Gathering

Before drafting, read as much relevant context as exists:

1. current manuscript files
2. supporting notes or specs
3. the latest strategy memo
4. the latest results summary
5. current tables and figures
6. available citations in `Bibliography_base.bib`
7. the domain profile for field conventions

## Drafting Workflow

1. Determine the requested section or rewriting mode.
2. Dispatch Writer with the relevant evidence base.
3. Draft only claims supported by existing outputs and citations.
4. Use writer-critic review for notation consistency, unsupported claims, hedging, and LaTeX quality.
5. Save the section under `paper/sections/` or update `paper/main.tex` when the repo structure demands it.

## Humaniser / Rewrite Workflow

When the task is "humanise" or "rewrite":

- preserve the meaning
- preserve valid citations and factual claims
- strip repetitive AI phrasing
- keep the author's disciplinary voice rather than generic polished prose

## Quality Self-Check

Before presenting the draft:

- every empirical claim maps to an existing result
- notation is consistent
- citation keys exist
- effect sizes include units where relevant
- no placeholder claims are presented as final
- invariant violations are called out rather than ignored

## Outputs

- updated manuscript section files
- review notes in `quality_reports/` when the pass is substantial

Append a research-journal entry when a writing pass changes project status or closes a reviewer request.
