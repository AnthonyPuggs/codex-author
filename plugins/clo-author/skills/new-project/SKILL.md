---
name: new-project
description: Full research pipeline from idea to paper for the Codex-native Clo-Author. Use when starting a new empirical research project from scratch or bootstrapping this template into a live project.
---

# New Project

Launch the full research pipeline from idea to paper, orchestrated through the dependency graph.

## Read First

- `AGENTS.md`
- `MEMORY.md`
- `plugins/clo-author/references/runtime-activation.md`
- `plugins/clo-author/references/codex-workflow.md`
- `plugins/clo-author/references/agent-catalog.md`
- `plugins/clo-author/references/critic-runtime-contract.md`
- `plugins/clo-author/references/domain-profile.md`
- `plugins/clo-author/references/logging.md`

## Pipeline Overview

This skill orchestrates the full dependency graph. Each phase activates when its dependencies are met. The active workflow manages worker dispatch, three-strikes escalation, and quality gates.

```text
Phase 1: Discovery
  -> discover interview -> research spec + domain profile calibration
  -> discover literature -> literature synthesis + frontier map
  -> discover data -> data assessment

Phase 2: Strategy (depends on Discovery inputs)
  -> strategize -> strategy memo + strategist-critic review

Phase 3: Execution (depends on approved strategy)
  -> analyze -> Data-engineer + data-engineer-critic, then Coder + coder-critic
  -> write -> manuscript sections + writer-critic review

Phase 4: Review (depends on approved paper + approved code)
  -> review full -> weighted quality score
  -> review peer -> editor + blind referees + editorial synthesis

Phase 5: Submission (depends on final gate readiness)
  -> submit target / package / audit / final
```

## Workflow

### Step 0: Bootstrap and Plan

1. Confirm the runtime activation contract before assuming the repo-local skill surface is loaded.
2. Clarify the topic, field, target contribution, target journals, and any current materials.
3. If the repo is still in template mode, update the project placeholders only after the user confirms the direction.
4. Create a requirements spec when the request is broad or ambiguous.
5. Save a plan to `quality_reports/plans/YYYY-MM-DD_new-project.md`.
6. Save an initial session log because this workflow spans multiple phases.

### Step 1: Discovery Phase

1. If no research spec exists, start with a discovery interview.
2. Run the literature workflow:
   - Librarian collects the literature
   - librarian-critic checks coverage, recency, and frontier gaps
3. Run the data workflow:
   - Explorer inventories viable datasets
   - explorer-critic checks feasibility, measurement, and identification fit
4. Save the discovery outputs in `quality_reports/`.

**Gate:** a usable research spec plus at least one of literature review or data assessment must exist before advancing to strategy.

### Step 2: Strategy Phase

1. Run the strategize workflow.
2. Require a saved strategy memo plus a saved strategist-critic review.
3. Do not treat the design as approved until the strategist-critic score clears the active gate.

**Gate:** the strategy memo must pass strategist-critic review with score >= 80.

### Step 3: Execution Phase

1. Run analyze from the approved strategy artefact.
2. Run write only after the code/output side has produced a usable results summary.
3. Save scripts, figures, tables, and manuscript artefacts in the standard paths.

**Gate:** data-preparation work must pass data-engineer-critic review before it becomes approved pipeline input. Estimation code must pass coder-critic review before it becomes approved analysis. Paper sections must be backed by approved results and evidence.

### Step 4: Review Phase

1. Run a comprehensive review for the current artefacts when the paper is ready for integrated quality control.
2. Run peer review when the user wants a realistic editorial/referee simulation.
3. Save every review artefact and update the research journal with score, approval state, and next step.

**Gate:** the project is commit-ready at >= 80, PR-ready at >= 90, and submission-ready only under the final gate.

### Step 5: Submission Phase

1. Run submit target for journal recommendations.
2. Run submit package to assemble the replication package.
3. Run submit audit or submit final for the final gate.

## User Interaction Points

Pause for user review at the major decision boundaries:

- after the discovery interview if it materially defines the project
- after the strategy memo if multiple credible designs remain
- after the first approved analysis results
- after peer-review synthesis when revisions are required
- before final journal choice or submission packaging

Between those boundaries, the workflow should proceed autonomously through the active worker-critic gates.

## Outputs

- `quality_reports/specs/YYYY-MM-DD_*.md`
- `quality_reports/plans/YYYY-MM-DD_*.md`
- `quality_reports/session_logs/YYYY-MM-DD_*.md`
- `quality_reports/research_journal.md` when multi-role coordination is active
- Updated `AGENTS.md` and `plugins/clo-author/references/domain-profile.md` when the template is being converted into a real project
