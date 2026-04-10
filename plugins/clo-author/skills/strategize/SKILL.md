---
name: strategize
description: Design and critique empirical strategies for causal research questions. Use when the user asks for an identification strategy, robustness plan, falsification tests, estimator choice, or a pre-analysis plan.
---

# Strategize

Use this skill for identification design and pre-analysis planning.

## Read First

- `AGENTS.md`
- `plugins/clo-author/references/codex-workflow.md`
- `plugins/clo-author/references/agent-catalog.md`
- `plugins/clo-author/references/domain-profile.md`
- `templates/decision-record.md` when the task closes a major strategy choice

## Procedure

1. Read the research question, available data, and any discovery artifacts.
2. Before proposing any design, produce a `Pre-Strategy Report` that states:
   - which research spec, literature review, and data assessment files were found
   - whether the domain profile was loaded
   - the current research question in one sentence
   - the key findings from the literature and the available variation in the data
   - any missing inputs that will be carried forward as explicit `[ASSUMED]` items
3. If requirements remain unclear, create a spec before planning.
4. Produce a strategy memo that covers:
   - estimand
   - estimator
   - identifying assumptions
   - threats to inference
   - robustness plan
   - falsification tests
5. Run strategist-critic review before treating the design as approved.
6. If the user asks for a PAP, adapt the memo to the requested registry or format and mark assumptions explicitly.
7. Save a decision record under `quality_reports/decisions/` whenever discovery or strategy work narrows multiple viable designs to one chosen path.

## Outputs

- `quality_reports/strategy_memo_[topic].md`
- `quality_reports/decisions/strategy_[topic].md` when a design choice is locked
- PAP draft when requested
- Follow-up implementation plan when the strategy becomes execution-ready
