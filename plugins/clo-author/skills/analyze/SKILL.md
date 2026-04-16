---
name: analyze
description: End-to-end data analysis using Data-engineer, Coder, and coder-critic. Use when the user asks to clean data, build a panel, estimate a design, reproduce a strategy, or perform a dual-language replication.
---

# Analyze

Run end-to-end data analysis by dispatching Data-engineer for cleaning/figures, Coder for estimation, and coder-critic for review.

## Read First

- `AGENTS.md`
- `plugins/clo-author/references/runtime-activation.md`
- `plugins/clo-author/references/codex-workflow.md`
- `plugins/clo-author/references/agent-catalog.md`
- `plugins/clo-author/references/critic-runtime-contract.md`
- `plugins/clo-author/references/domain-profile.md`
- `plugins/clo-author/references/content-invariants.md`
- `plugins/clo-author/references/logging.md`

## Workflow

### Step 1: Context Gathering

1. Read the approved strategy memo and its saved strategist-critic review if they exist.
2. Read the domain profile for field conventions.
3. Check the existing script layout under `scripts/`.
4. Confirm the implementation language and output obligations.

Do not present code work as approved-strategy execution unless a saved strategist-critic artefact shows the strategy cleared the gate.

### Step 2: Pre-Code Report

Before editing, produce a `Pre-Code Report` that states:

- the strategy memo path or that no memo was found
- whether the domain profile was loaded
- the implementation language and paper type
- the naming map from paper concepts to code variables
- the estimator, clustering rule, and required robustness checks
- any missing strategic inputs that prevent full alignment checks

### Step 3: Data Preparation

If raw data or unfinished cleaning work exists, dispatch Data-engineer first to:

- clean and wrangle the data
- construct variables per the approved strategy
- document merges, sample restrictions, and data losses
- generate descriptive outputs and figure plumbing

Review Data-engineer output through `plugins/clo-author/references/active-critics/data-engineer-critic.md` before treating the data pipeline as approved.

### Step 4: Main Analysis

Dispatch Coder to:

- load cleaned or raw data
- estimate the main specification
- run the required robustness checks
- produce publication-ready tables in `paper/tables/`
- produce publication-ready figures in `paper/figures/`
- save a mandatory `results_summary_[topic].md` for the writing stage

The implementation should follow these principles:

- no hardcoded absolute paths
- reproducible script structure
- outputs written to the repository-standard locations
- clustering and estimands aligned with the approved strategy

### Step 5: Mechanical Screen

Run `plugins/clo-author/hooks/lint-scripts.sh [file|dir]` before or alongside deeper review. Treat it as an advisory screen, not a substitute for coder-critic.

### Step 6: Code Review

Dispatch `plugins/clo-author/references/active-critics/coder-critic.md` and review at least these categories:

1. code-strategy alignment
2. sanity checks on outputs
3. robustness sufficiency
4. structure
5. console hygiene
6. reproducibility
7. function extraction and duplication control
8. figure quality
9. serialised intermediate outputs where appropriate
10. comments and section headers
11. error handling
12. polish and consistency

Save the review report under `quality_reports/`.

### Step 7: Revision Loop

Re-dispatch Coder with specific fixes (max 3 rounds).

If the pair still cannot converge, escalate according to the active agent catalog rather than silently proceeding.

### Step 8: Dual-Language Replication

If the user asks for dual-language replication:

- run two implementations independently
- review both with `plugins/clo-author/references/active-critics/coder-critic.md`
- compare outputs against the domain-profile tolerances
- report divergence sources explicitly before declaring parity

## Outputs

- Updated `scripts/`
- Tables in `paper/tables/`
- Figures in `paper/figures/`
- `quality_reports/results_summary_[topic].md`
- `quality_reports/[script_or_topic]_code_review.md`

Append a research-journal entry for each worker-critic round with score, approval, report path, and next actor.
