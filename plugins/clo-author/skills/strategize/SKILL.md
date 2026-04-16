---
name: strategize
description: Design identification strategy or pre-analysis plans using Strategist plus strategist-critic. Use when the user asks for a causal design, robustness plan, falsification tests, estimator choice, or a PAP.
---

# Strategize

Design an identification strategy or pre-analysis plan by dispatching the Strategist (proposer) and strategist-critic (validator).

## Read First

- `AGENTS.md`
- `plugins/clo-author/references/runtime-activation.md`
- `plugins/clo-author/references/codex-workflow.md`
- `plugins/clo-author/references/agent-catalog.md`
- `plugins/clo-author/references/critic-runtime-contract.md`
- `plugins/clo-author/references/domain-profile.md`
- `plugins/clo-author/references/logging.md`
- `templates/decision-record.md` when a major strategy choice is being locked

## Modes

- Identification strategy
- Pre-analysis plan
- Interactive PAP interview

## Identification Strategy Workflow

### Step 1: Gather Inputs

1. Read the research spec, literature review, and data assessment if they exist.
2. Read `plugins/clo-author/references/domain-profile.md` for common identification patterns and referee concerns in the field.
3. If key requirements are still unclear, create a spec before proceeding.

### Step 2: Produce a Pre-Strategy Report

Before proposing a design, produce a `Pre-Strategy Report` that states:

- which research spec, literature review, and data assessment files were found
- whether the domain profile was loaded
- the current research question in one sentence
- the key findings from the literature and the data variation available
- any missing inputs that will be carried forward as explicit `[ASSUMED]` items

### Step 3: Dispatch Strategist

The Strategist should produce:

- a strategy memo with design choice, estimand, treatment, comparison group, and assumptions
- pseudo-code or implementation sketch for the main estimation
- a robustness plan ordered by priority
- falsification tests that should not show effects
- top referee objections with proposed responses

The strategy memo should cover:

- estimand
- estimator
- identifying assumptions
- threats to inference
- robustness plan
- falsification tests

### Step 4: Dispatch strategist-critic

Run strategist-critic review through `plugins/clo-author/references/active-critics/strategist-critic.md` before treating the design as approved. The strategist-critic should review through the preserved four-phase protocol:

1. Claim identification
2. Core design validity
3. Inference soundness
4. Polish and completeness

The review must produce:

- a saved review report under `quality_reports/`
- severity-labelled issues
- a score
- an approval state for the research journal

### Step 5: Revision Loop

If CRITICAL issues found, iterate (max 3 rounds per three-strikes rule).

- Round 1: strategist revises from the critic's blocking issues
- Round 2: strategist-critic re-reviews the revised memo
- Round 3: if still blocked, escalate to the user because the disagreement is strategic rather than editorial

The design is not approved until the saved strategist-critic artefact clears the active gate.

### Step 6: Save Outputs

Save to:

- `quality_reports/strategy_memo_[topic].md`
- `quality_reports/strategy_memo_[topic]_review.md`
- `quality_reports/decisions/strategy_[topic].md` when a design choice is locked

Append a research-journal entry with round number, score, approval, report path, and next actor.

## PAP Workflow

When the user asks for a PAP, adapt the strategy output into the requested registration format.

### Interactive PAP Interview

For an interactive PAP flow, ask for:

1. the research question
2. the study design
3. the primary outcomes
4. the source of identifying variation or assignment mechanism
5. pre-specified subgroup analyses
6. the multiple-testing plan

### PAP Requirements

The PAP should specify:

- study overview
- outcomes
- estimating equations
- subgroup analyses
- multiple-testing correction
- power assumptions when relevant
- sample and exclusion rules
- data and analysis plan
- timeline
- deviations log template

Mark every unresolved item with `[ASSUMED]`, and end with a review checklist so the user can confirm assumptions before registration.

## Principles

- Strategist proposes, strategist-critic critiques.
- The strategy memo is the contract for later execution.
- Catch design problems before code is written.
- Multiple candidate strategies are acceptable, but the approved path must be explicit.
- The user resolves strategic deadlocks after the third failed round.
