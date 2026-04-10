---
name: review
description: Review manuscripts, code, methods, talks, and replication packages using worker-critic or editor-referee workflows. Use when the user asks for a code review, paper review, methods audit, proofreading pass, peer review simulation, stress test, or weighted quality score.
---

# Review

Use this skill for quality control and peer-review simulation.

## Read First

- `AGENTS.md`
- `plugins/clo-author/references/codex-workflow.md`
- `plugins/clo-author/references/quality-scoring.md`
- `plugins/clo-author/references/logging.md`
- `plugins/clo-author/references/agent-catalog.md`
- `plugins/clo-author/references/domain-profile.md`
- `plugins/clo-author/references/journal-profiles.md` when journal calibration is requested

## Modes

- Code review
- Manuscript review
- Methods-only review
- Proofread / polish
- Peer review simulation
- Stress test
- Cross-language replication review
- Full weighted review

## Procedure

1. Detect the review mode from the request and target files.
2. For code: use coder-critic.
3. For manuscripts: combine writer-critic, strategist-critic, and Verifier as needed.
4. For peer review:
   - run Editor first for desk review and referee assignment
   - run domain-referee and methods-referee independently
   - have Editor synthesize the decision into FATAL / ADDRESSABLE / TASTE
5. When reporting a weighted score, ground it in `plugins/clo-author/references/quality-scoring.md`.
6. For journal-specific peer review, calibrate with `plugins/clo-author/references/journal-profiles.md`.
7. Save findings before proposing revisions, and append a research-journal entry when the review changes project status or produces a formal gate outcome.

## Outputs

- Review memo in `quality_reports/`
- Weighted score or pass/fail result when applicable, grounded in the active scoring rubric
- Clear next-step recommendation
