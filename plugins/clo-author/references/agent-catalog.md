# Agent Catalog

This is the active Codex-native role catalog for the Clo-Author. Use it when deciding which sub-agent to spawn, what inputs to provide, and whether the role is allowed to edit files.

Detailed active critic prompts live under `plugins/clo-author/references/active-critics/`. The preserved Claude-era prompt copies remain under `plugins/clo-author/references/legacy-agents/` as migration source material rather than the live runtime surface.

## Roles

| Role | Phase | Primary Output | Critic / Pairing | Can Edit Files | Recommended Reasoning |
|------|-------|----------------|------------------|----------------|-----------------------|
| Librarian | Discovery | Annotated bibliography, frontier map | librarian-critic | No by default | High |
| librarian-critic | Discovery | Coverage review, missing-paper list, score | Reviews Librarian | No | High |
| Explorer | Discovery | Ranked data inventory, feasibility grades | explorer-critic | No by default | High |
| explorer-critic | Discovery | Measurement and feasibility critique | Reviews Explorer | No | High |
| Strategist | Strategy | Identification strategy memo, PAP outline | strategist-critic | Yes | High |
| strategist-critic | Strategy | Threats-to-identification review, score | Reviews Strategist | No | High |
| Data-engineer | Execution | Cleaning scripts, panel builds, figures | data-engineer-critic | Yes | Medium |
| data-engineer-critic | Execution | Data pipeline, merge, provenance, and sample-flow review | Reviews Data-engineer | No | High |
| Coder | Execution | Estimation scripts, tables, robustness checks | coder-critic | Yes | Medium |
| coder-critic | Execution | Reproducibility, correctness, strategy alignment review | Reviews Coder | No | High |
| Writer | Paper | Section drafts, rewrite passes, humanizer edits | writer-critic | Yes | Medium |
| writer-critic | Paper | Notation, claims-vs-evidence, LaTeX review | Reviews Writer | No | Medium |
| Editor | Peer review | Desk review, referee assignment, editorial synthesis | Coordinates referees | No | High |
| domain-referee | Peer review | Blind report on contribution and positioning | Independent blind review | No | High |
| methods-referee | Peer review | Blind report on identification and inference | Independent blind review | No | High |
| Storyteller | Presentation | Beamer or Quarto talk draft | storyteller-critic | Yes | Medium |
| storyteller-critic | Presentation | Narrative and slide audit | Reviews Storyteller | No | Medium |
| Verifier | Infrastructure | Compile, run, package audit status | Standalone infrastructure role | No | Medium |
| Orchestrator | Infrastructure | Routing, escalation, score synthesis | Coordinates others | No | High |

## Delegation Rules

- Default to local execution if the task is small or tightly coupled.
- Use sub-agents for independent subtasks with clear ownership and minimal overlap.
- Creators may draft or edit files. Critics are always read-only.
- Run blind reviewers independently. Do not let one referee see the other referee's report before the editor synthesizes.
- Preferred parallelism is **2-4 concurrent roles**. Beyond that, orchestration overhead usually dominates.
- If a worker-critic pair fails to converge after 3 rounds, escalate rather than looping indefinitely.

## Approval Rules

- If a creator artifact exists without a critic score, it is not approved.
- No artifact advances to the next phase without its critic's score >= 80.
- A creator cannot self-score its own work.
- Critics do not edit files or produce replacement artefacts during review.
- Every worker-critic round should leave a saved report path plus a research-journal entry.

## Phase Dependencies

| Phase | Requires |
|------|----------|
| Discovery | Research idea |
| Strategy | Literature review or data assessment |
| Execution (Code) | Approved strategy artefact |
| Execution (Write) | Approved code artefact |
| Peer Review | Approved paper plus approved code |
| Submission | Verifier pass plus final weighted gate |
| Presentation | Approved paper |

## Escalation Table

| Pair | Escalate To |
|------|-------------|
| Librarian + librarian-critic | User |
| Explorer + explorer-critic | User |
| Strategist + strategist-critic | User |
| Data-engineer + data-engineer-critic | Strategist |
| Coder + coder-critic | Strategist |
| Writer + writer-critic | Strategist or User |
| Storyteller + storyteller-critic | Writer |

## Three-Strikes Protocol

```text
Round 1: critic reviews -> worker revises
Round 2: critic reviews -> worker revises
Round 3: critic reviews -> worker revises
Still failing? Escalate.
```

Escalation is part of the workflow, not a special case. When a pair deadlocks, the next actor should be explicit in the research journal rather than inferred from chat context.

## Default Artifact Paths

- Discovery artifacts: `quality_reports/`
- Strategy memos and PAPs: `quality_reports/`
- Plans: `quality_reports/plans/`
- Specs: `quality_reports/specs/`
- Session reasoning: `quality_reports/session_logs/`
- Replication package: `paper/replication/`
