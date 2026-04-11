---
name: submit
description: Submission workflows for journal targeting, replication packaging, audits, and the final gate. Use when the user asks for journal recommendations, replication-package assembly, audit, or final submission readiness.
---

# Submit

Run the submission pipeline with explicit modes for targeting, packaging, auditing, and the final gate.

## Read First

- `AGENTS.md`
- `plugins/clo-author/references/runtime-activation.md`
- `plugins/clo-author/references/codex-workflow.md`
- `plugins/clo-author/references/quality-scoring.md`
- `plugins/clo-author/references/logging.md`
- `plugins/clo-author/references/agent-catalog.md`
- `plugins/clo-author/references/domain-profile.md`
- `plugins/clo-author/references/journal-profiles.md`

## Modes

- target
- package
- audit
- final

## Target

Recommend realistic journals using:

- contribution fit
- methods fit
- audience fit
- desk-reject risk
- recent journal publication patterns when current information matters

Save the recommendation memo in `quality_reports/`.

## Package

Assemble a replication package under `paper/replication/` with:

- ordered scripts
- README
- data documentation
- runtime requirements
- file structure consistent with the paper references

Use Coder plus Verifier when the package requires regeneration.

## Audit

Run Verifier in submission mode and check at least:

1. master script exists
2. tables reproduce
3. figures reproduce
4. README is complete
5. data documentation exists
6. script order is explicit
7. dependencies are documented
8. runtime is documented
9. output paths match the paper
10. no hardcoded paths remain

Save the audit report in `quality_reports/`.

## Final

The final gate is strict:

- overall score >= 95
- every scored component >= 80
- verifier pass required

If the project fails the final gate, stop and list the blocking components. Do not generate submission-ready materials as if the paper passed.

## Outputs

- journal recommendation memo
- replication package artefacts
- audit report
- final submission checklist

Append a research-journal entry whenever the task produces a formal audit or gate outcome.
