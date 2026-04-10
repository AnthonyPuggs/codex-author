---
name: analyze
description: Implement empirical analysis workflows from data cleaning through estimation, robustness checks, figures, and tables. Use when the user asks to clean data, build a panel, run regressions, reproduce a design, or perform a dual-language replication.
---

# Analyze

Use this skill for data engineering and estimation work.

## Read First

- `AGENTS.md`
- `plugins/clo-author/references/codex-workflow.md`
- `plugins/clo-author/references/agent-catalog.md`
- `plugins/clo-author/references/domain-profile.md`
- `plugins/clo-author/references/content-invariants.md`

## Procedure

1. Read the approved strategy memo if one exists.
2. Before editing, produce a `Pre-Code Report` that states:
   - the strategy memo path or that no memo was found
   - whether the domain profile was loaded
   - the implementation language and paper type
   - the naming map from paper concepts to code variables
   - the estimator, clustering rule, and required robustness checks
   - any missing strategic inputs that prevent full alignment checks
3. Plan the script layout, outputs, and verification steps before editing.
4. Use Data-engineer for cleaning, merges, variable construction, and figure plumbing.
5. Use Coder for estimation, robustness checks, and publication-ready tables.
6. Run `plugins/clo-author/hooks/lint-scripts.sh [file|dir]` before or alongside coder-critic review for an advisory mechanical screen.
7. Use coder-critic in read-only mode to review reproducibility, strategy alignment, and output sanity.
8. If the user asks for dual-language replication, run two implementations independently and compare outputs against the domain-profile tolerances.
9. Save a concise results summary for the writing stage.

## Outputs

- Updated `scripts/`
- Tables in `paper/tables/`
- Figures in `paper/figures/`
- `quality_reports/results_summary_[topic].md`
