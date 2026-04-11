# Requirements Specification: Critic CLI Summary Contract

**Date:** 2026-04-11
**Status:** DRAFT

---

## Objective

Require every active critic role in the Clo-Author workflow to surface a structured, verbose summary in the Codex CLI while preserving the existing read-only critic separation and saved report artefacts.

---

## Requirements

### MUST Have (Non-Negotiable)

- [ ] Every critic role must remain read-only.
- [ ] Every critic run must emit a fixed CLI header with `Role`, `Score`, `Approval`, `Blocking issues`, and `Next actor`.
- [ ] Every critic run must follow that header with a verbose near-full summary of the critic response in the Codex CLI.
- [ ] The saved critic artefact on disk must remain the authoritative record.
- [ ] The CLI summary requirement must apply to every critic role, not only execution-side critics.
- [ ] The active workflow references must state the rule explicitly.
- [ ] The critic-dispatching skills must remind the orchestrating workflow to surface the critic summary in the CLI.
- [ ] Regression checks must fail if the active control plane drops the critic-summary contract.

### SHOULD Have (Preferred)

- [ ] The verbose CLI section should preserve the critic's original severity labels and internal structure where available.
- [ ] `Blocking issues` should list true blockers concisely rather than printing an opaque count when a concise list is practical.
- [ ] The rule should be centralised in the active references and only lightly repeated in skills to reduce drift.

### MAY Have (Optional, If Time)

- [ ] Extend a similar CLI summary convention to blind referee and editor flows later.

---

## Design

### Governance Constraint

This change must not weaken the worker-critic separation codified in `AGENTS.md` and the active Clo-Author references. Critics review and score only; they do not edit files or produce replacement artefacts during review.

### Output Contract

Each critic run should surface the following CLI structure before the workflow advances:

```text
Critic Summary
Role: [critic-role]
Score: [NN/100 or N/A]
Approval: [APPROVED / BLOCKED / ADVISORY / N/A]
Blocking issues: [concise blocker list or None]
Next actor: [worker / user / strategist / writer / N/A]

Verbose summary:
[near-full critic response, trimmed only if needed for terminal practicality]
```

### Behavioural Rules

- If a critic does not provide a numeric score, the CLI should print `N/A` rather than infer one.
- If no blocking issue exists, the CLI should print `None`.
- The verbose section should preserve severity labels and report structure when available.
- The saved artefact remains authoritative; the CLI output is a required surfaced summary, not a substitute.
- The rule is scoped to critic roles only for this change.

### Implementation Surface

The rule should live in three layers:

1. Canonical contract in the active references, especially `plugins/clo-author/references/codex-workflow.md`.
2. Reinforcement in `plugins/clo-author/references/agent-catalog.md` so critic-role expectations are explicit.
3. Short operational reminders in the active skills that dispatch critics, including `discover`, `strategize`, `analyze`, `write`, `review`, `revise`, and `talk`.

### Verification Surface

`tests/workflow_parity.sh` should be extended so that removal of the critic-summary language from the active control plane causes the parity check to fail.

---

## Clarity Status

| Aspect | Status | Notes |
|--------|--------|-------|
| Apply to every critic role | CLEAR | User explicitly requested all critic roles |
| Summary verbosity | CLEAR | User chose verbose near-full CLI output |
| Structured header | CLEAR | User chose a fixed header before the detailed critic text |
| Critic edit permissions | CLEAR | Read-only critic behaviour remains required |
| Blind referee/editor flows | CLEAR | Explicitly outside current scope unless extended later |

---

## Success Criteria

- The active references explicitly require a structured verbose CLI summary for every critic run.
- All active skills that dispatch critics contain a reminder to surface that summary in the CLI.
- `tests/workflow_parity.sh` fails if the critic-summary contract is removed.
- The documented contract preserves read-only critics and the saved artefact as the authoritative record.

---

## Approval

[ ] User reviewed written spec file
