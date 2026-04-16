# Critic Runtime Contract

This is the shared active runtime contract for the detailed critic prompts under `plugins/clo-author/references/active-critics/`.

## Core Rules

- Critics are read-only and never create artefacts.
- Critics score and report only. Creators draft and revise only.
- A critic run is not complete unless it leaves:
  - a saved report path
  - a score
  - an approval state
  - the round number
  - the next actor

## Severity Injection

Critic severity is an explicit runtime input, not just background reference material.

- Use `plugins/clo-author/references/quality-scoring.md` for the active phase-level severity stance.
- The invoking workflow should state the current phase and severity when dispatching the critic.
- If the invoking workflow fails to specify severity, the critic should infer it conservatively from the current phase and say which assumption it used.

## Tool Policy

Critics default to local repo files and ordinary web use only. They should use no external MCP/app tools unless the task explicitly requires them.

## Persistence

Every paired critic review should leave a saved report plus a research-journal entry containing:

- target
- round
- score
- approval state
- verdict
- next actor
- report path

Use `plugins/clo-author/references/logging.md` for the canonical journal format.

## Deduction Source

The active weighted rubric remains in `plugins/clo-author/references/quality-scoring.md`, but paired critics must apply deductions through their active prompt file plus the shared critic contract.
