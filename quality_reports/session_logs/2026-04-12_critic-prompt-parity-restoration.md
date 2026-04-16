# Session Log: 2026-04-12 -- Critic Prompt Parity Restoration

**Status:** COMPLETED

## Objective
Implement the critic-first prompt parity tranche by promoting detailed active critic prompts into the live Codex surface, adding `data-engineer-critic`, and rewiring the routing, workflow, and guide surfaces accordingly.

## Runtime State

- Plugin activation: ACTIVE
- Worktree: `/Users/anthonyp/Desktop/Coding/clo-author-codex/.worktrees/codex-critic-prompt-parity`
- Branch: `codex/critic-prompt-parity`

## Changes Made

| File | Change | Reason | Quality Score |
|------|--------|--------|---|
| `plugins/clo-author/references/active-critics/*` | Added live detailed critic prompts | Restore near-verbatim critic strictness to the active Codex surface | N/A |
| `plugins/clo-author/references/critic-runtime-contract.md` | Added shared critic runtime contract | Centralise cross-cutting Codex-era critic rules | N/A |
| `plugins/clo-author/references/agent-catalog.md` | Repointed pairings and introduced `data-engineer-critic` | Align active routing with the restored critic layer | N/A |
| `plugins/clo-author/references/codex-workflow.md` | Added active-critic loading and severity injection requirements | Make critic strictness executable rather than implicit | N/A |
| `plugins/clo-author/references/quality-scoring.md` | Tied deductions to the active prompt layer | Keep the weighted rubric while clarifying how active critics consume it | N/A |
| `plugins/clo-author/skills/*` | Rewired critic routing in discover, strategize, analyze, write, talk, review, and new-project | Make active workflows point to the live critic layer | N/A |
| `guide/architecture.qmd`, `guide/agents.qmd`, `guide/customization.qmd` | Documented the active critic layer and legacy archival status | Keep user-facing docs truthful | N/A |
| `tests/critic_prompt_parity.sh` | Added regression checks for the new active critic layer | Prevent drift back to thin critic summaries | N/A |

## Design Decisions

| Decision | Alternatives Considered | Rationale |
|----------|------------------------|-----------|
| Add `active-critics/` instead of inflating skill summaries | Keep critic logic embedded in skills | A separate prompt layer preserves detailed critic behaviour without turning skills into long prompt copies |
| Add `data-engineer-critic` and narrow `coder-critic` | Keep `coder-critic` reviewing both data prep and estimation code | The active surface had become too thin for one shared execution critic to remain specific enough |
| Keep legacy critic prompts archival | Replace `legacy-agents/` outright | Preserves a clear migration baseline and avoids losing the original comparator |

## Incremental Work Log

**19:10 AEST:** Confirmed baseline parity checks passed in the isolated worktree before any changes.

**19:14 AEST:** Added a new failing regression script, `tests/critic_prompt_parity.sh`, and verified the red state.

**19:24 AEST:** Added the shared critic runtime contract and the new active critic prompt layer, including `data-engineer-critic`.

**19:30 AEST:** Rewired the active references, skills, and guides to consume the new critic layer.

**19:31 AEST:** Verified both `tests/critic_prompt_parity.sh` and `tests/workflow_parity.sh` passed.

## Learnings & Corrections

- [LEARN:architecture] A critic-first parity tranche is manageable if the detailed prompt layer is separated cleanly from the shorter workflow skills.
- [LEARN:quality] Splitting `data-engineer-critic` from `coder-critic` clarifies the execution-stage review contract without forcing an immediate weighted scoring redesign.

## Verification Results

| Check | Result | Status |
|-------|--------|--------|
| `bash tests/critic_prompt_parity.sh` | `critic prompt parity checks passed` | PASS |
| `bash tests/workflow_parity.sh` | `workflow parity checks passed` | PASS |
| Drift scan | No stale `.claude` path usage in the new active critic layer or critic runtime contract | PASS |

## Open Questions / Blockers

- [ ] Decide in a future tranche whether editor/referee prompts should move into a matching active prompt layer.

## Next Steps

- [ ] Decide whether to fold the new critic parity regression into a broader aggregate test runner.
- [ ] Plan the separate literature-search fan-out and broader no-MCP default hardening tranche.
