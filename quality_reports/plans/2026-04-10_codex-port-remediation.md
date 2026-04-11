# Plan: Codex Port Remediation

**Date:** 2026-04-10
**Source:** `quality_reports/codex-port-review.md`
**Status:** Approved and implemented in this session

## Objective

Bring the active Codex control plane into line with the intended hybrid template model:

- keep the repository usable as a starter template
- make template-to-project bootstrap explicit
- surface critical workflow references in the active Codex path
- remove incorrect bibliography instructions from live docs

## Implementation

1. Correct active compile instructions from `bibtex` to `biber`.
2. Add Codex-native references for:
   - content standards
   - quality scoring
   - logging and resumability
3. Wire those references into `AGENTS.md`, the relevant skills, and the guide/README.
4. Add explicit bootstrap and infrastructure-refresh guidance for template users.
5. Run consistency checks across active docs to confirm the live Codex surface is internally aligned.

## Acceptance Criteria

- No active Codex-facing compile instructions still recommend `bibtex`.
- `review` and `submit` explicitly route to an active weighted-scoring reference.
- Logging formats are defined in the active Codex path, not only in legacy material.
- `AGENTS.md` and README clearly describe template mode and the path to convert the repo into a filled-in project.
- `.claude/` remains preserved as migration source material, not promoted back into the active runtime.
