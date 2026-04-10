---
name: submit
description: Prepare a paper for submission, including journal targeting, replication packaging, replication audits, and final quality-gate checks. Use when the user asks to target journals, build an AEA-style package, audit replication readiness, or run the final submission gate.
---

# Submit

Use this skill for the final packaging and gatekeeping stage.

## Read First

- `AGENTS.md`
- `plugins/clo-author/references/codex-workflow.md`
- `plugins/clo-author/references/quality-scoring.md`
- `plugins/clo-author/references/logging.md`
- `plugins/clo-author/references/agent-catalog.md`
- `plugins/clo-author/references/domain-profile.md`
- `plugins/clo-author/references/journal-profiles.md`

## Procedure

1. Determine whether the user needs targeting, packaging, auditing, or the full final gate.
2. For journal targeting, use the domain profile and current paper state to rank realistic targets.
3. For packaging, assemble `paper/replication/` with ordered scripts, README, and provenance notes.
4. For audits, use Verifier in submission mode.
5. For the final gate, apply `plugins/clo-author/references/quality-scoring.md` and ensure the overall score meets 95 and every component meets 80.
6. Record the audit or gate outcome in the active logging surface when the task produces a formal submission decision.

## Outputs

- Journal recommendation memo
- Replication package artifacts under `paper/replication/`
- Audit report in `quality_reports/`
- Final submission checklist
