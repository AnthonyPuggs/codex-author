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

## Procedure

1. Read the research question, available data, and any discovery artifacts.
2. If requirements remain unclear, create a spec before planning.
3. Produce a strategy memo that covers:
   - estimand
   - estimator
   - identifying assumptions
   - threats to inference
   - robustness plan
   - falsification tests
4. Run strategist-critic review before treating the design as approved.
5. If the user asks for a PAP, adapt the memo to the requested registry or format and mark assumptions explicitly.

## Outputs

- `quality_reports/strategy_memo_[topic].md`
- PAP draft when requested
- Follow-up implementation plan when the strategy becomes execution-ready
