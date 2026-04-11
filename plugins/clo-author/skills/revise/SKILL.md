---
name: revise
description: Structure referee and editor feedback into a tracked revision plan, routed tasks, and response-letter drafts. Use when the user provides referee reports, editor letters, or asks for an R&R action plan.
---

# Revise

Turn referee feedback into a tracked response plan with explicit routing.

## Read First

- `AGENTS.md`
- `plugins/clo-author/references/codex-workflow.md`
- `plugins/clo-author/references/agent-catalog.md`
- `plugins/clo-author/references/logging.md`
- `plugins/clo-author/references/legacy-rules/revision.md`

## Workflow

### Step 1: Parse Inputs

1. Read the referee report or editor letter.
2. Read the current paper.
3. Read existing analysis scripts and recent review artefacts.

### Step 2: Classify Every Comment

| Class | Routing | Action |
|------|---------|--------|
| `NEW ANALYSIS` | Coder or Data-engineer | Requires explicit implementation work |
| `CLARIFICATION` | Writer | Textual clarification |
| `REWRITE` | Writer | Structural rewrite |
| `DISAGREE` | User | Needs explicit human judgement |
| `MINOR` | Writer | Low-risk direct fix |

### Step 3: Build the Tracker

Save `quality_reports/referee_response_tracker.md` with:

- counts by referee and class
- priority ordering
- owner for each item
- current status

### Step 4: Route Work

- CLARIFICATION and REWRITE -> Writer workflow
- NEW ANALYSIS -> analysis workflow after user approval if the task is substantial
- DISAGREE -> draft diplomatic pushback and flag for user review

### Step 5: Draft the Response Letter

Generate a point-by-point response letter that includes:

- summary of major changes
- exact referee comments
- response text
- page or section references for changes already made

### Step 6: Diplomatic Disagreement Protocol

When the classification is DISAGREE:

- acknowledge the concern
- provide evidence
- offer a partial concession when appropriate
- never frame the referee as incompetent or wrong

## Outputs

- `quality_reports/referee_response_tracker.md`
- response letter draft in `quality_reports/`
- routed revision checklist in `quality_reports/`

Append a research-journal entry whenever the tracker changes project direction or triggers new analysis.
