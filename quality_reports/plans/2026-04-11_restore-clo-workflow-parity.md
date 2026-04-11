# Plan: Restore Full Clo-Author Workflow Parity in Codex

**Date:** 2026-04-11
**Status:** Approved for implementation
**Source:** User-approved parity restoration plan

## Summary

Restore full worker-critic workflow parity between the active Codex control plane and the preserved Claude-era Clo-Author workflow.

## Objectives

1. Fix plugin activation so the repo-local `clo-author` plugin is active by default or clearly documented as blocked.
2. Promote workflow enforcement rules from legacy-only references into the active Codex references.
3. Rebuild the active skill files so they again serve as executable workflow contracts, not thin summaries.
4. Reinstate durable round tracking through saved review artefacts and research-journal entries.
5. Update public docs only after the runtime contract and active workflow surfaces are aligned.

## Acceptance Targets

- The repo-local plugin contract no longer relies on implicit activation.
- Active references state critic gating, revision rounds, escalation rules, and logging requirements explicitly.
- `strategize`, `analyze`, `review`, and `new-project` restore explicit dispatch and approval semantics.
- Docs describe only behaviour that the active repo now enforces.
- A local regression check can assert the new parity expectations.

## Verification Targets

- Plugin activation contract check
- Worker-critic gating check
- Round-tracking/logging check
- Skill contract check for `strategize`, `analyze`, `review`, and `new-project`
- Documentation truthfulness check
