# Session Log: 2026-04-11 -- Restore Clo-Author Workflow Parity

**Status:** COMPLETED

## Objective

Restore the active Codex control plane so the repo-local `clo-author` plugin once again enforces the worker-critic workflow instead of merely describing it.

## Runtime State

- Plugin activation: ACTIVE-CONTRACT UPDATED, FRESH-SESSION UI CHECK STILL REQUIRED
- Smoke test: repo-local marketplace policy changed to default-install and the startup smoke-test contract was documented in the active references, README, AGENTS, and guide

## Changes Made

| File | Change | Reason | Quality Score |
|------|--------|--------|---|
| `.agents/plugins/marketplace.json` | Changed `clo-author` installation policy to `INSTALLED_BY_DEFAULT` | Make runtime activation explicit instead of assumed | 95/100 |
| `plugins/clo-author/references/runtime-activation.md` | Added the active runtime activation contract and smoke test | Prevent silent fallback to generic Codex behaviour | 96/100 |
| `plugins/clo-author/references/codex-workflow.md`, `plugins/clo-author/references/agent-catalog.md`, `plugins/clo-author/references/logging.md` | Promoted gating, escalation, dependency, and round-tracking rules into the active control plane | Remove reliance on legacy-only enforcement semantics | 94/100 |
| `plugins/clo-author/skills/*.md` | Rebuilt all 10 active skills into explicit workflow contracts | Restore dispatch, review, save, and escalation semantics | 93/100 |
| `AGENTS.md`, `README.md`, `guide/*.qmd`, `plugins/clo-author/.codex-plugin/plugin.json`, `CHANGELOG.md` | Updated public contract, metadata, and release notes | Align docs with actual enforced behaviour | 92/100 |
| `tests/workflow_parity.sh` | Added a regression-style parity check | Provide a fast local verification target for future maintenance | 95/100 |

## Design Decisions

| Decision | Alternatives Considered | Rationale |
|----------|------------------------|-----------|
| Default the local marketplace entry to `INSTALLED_BY_DEFAULT` | Keep `AVAILABLE` and rely on manual installation docs only | The observed failure mode was dormant plugin behaviour; default install is the strongest repo-level contract supported by the local marketplace schema |
| Add `runtime-activation.md` as a first-class reference | Spread activation notes across README and guide only | Activation is now part of the control plane, not just onboarding prose |
| Use a shell-based parity regression check | Rely on manual greps or narrative verification | The repo needed a repeatable local proof that the active surface still contains the required workflow semantics |
| Port the legacy workflow into the active skill files rather than referring back to legacy paths | Keep thin active summaries and tell users to consult legacy materials | The active skill files must themselves be the executable contract in Codex |

## Incremental Work Log

**10:05 AEST:** Confirmed that the current session was not exposing the `clo-author` skills despite the repo advertising them as active.

**10:15 AEST:** Saved the approved implementation plan and added a failing parity regression script.

**10:25 AEST:** Promoted approval gates, escalation rules, and round-tracking semantics into the active references.

**10:40 AEST:** Rebuilt the active skill files so `new-project`, `discover`, `strategize`, `analyze`, `write`, `review`, `revise`, `talk`, `submit`, and `tools` again define concrete workflow behaviour.

**10:50 AEST:** Updated README, AGENTS, guide pages, plugin metadata, and changelog entries to document the activation smoke test and blocked-runtime fallback.

**10:56 AEST:** Re-ran the parity regression, diff hygiene check, and Quarto guide render.

## Learnings & Corrections

- [LEARN:workflow] In this repo, the main regression risk is not missing concepts but missing enforcement semantics in the active skill files.
- [LEARN:runtime] A repo-local plugin should not be described as active unless the runtime contract also explains how to detect and handle blocked activation.

## Verification Results

| Check | Result | Status |
|-------|--------|--------|
| Workflow parity regression | `bash tests/workflow_parity.sh` -> `workflow parity checks passed` | PASS |
| Diff hygiene | `git diff --check` -> no output | PASS |
| Guide render | `quarto render guide` -> `Output created: ../docs/index.html` | PASS |
| Guide render warnings | Quarto warned about `docs/site_libs` path configuration but still rendered successfully | PASS |

## Open Questions / Blockers

- [ ] Fresh-session Codex UI verification is still required to confirm the repo-local plugin now appears automatically after the marketplace-policy change.

## Next Steps

- [ ] Open a fresh Codex session in this repo and confirm the `clo-author` plugin plus all 10 skills are visible before prompting.
- [ ] Keep `tests/workflow_parity.sh` in the verification loop whenever the active skills, references, or plugin metadata are changed.
