# Plan: Agent Architecture Review

**Date:** 2026-04-12
**Status:** Approved for implementation
**Source:** User-approved agent architecture review plan

## Summary

Review the Codex port's agent architecture against four reported failures:

1. sequential literature-review search behaviour
2. unnecessary Vercel MCP connection attempts in subagents
3. absence of a dedicated `data-engineer-critic`
4. critics that pass work too easily relative to the Claude-era Clo-Author

## Objectives

1. Build an active-vs-legacy parity matrix for roles, critics, orchestration, severity, and tool policy.
2. Reproduce the literature-review concurrency issue with bounded read-only checks.
3. Reproduce the subagent MCP/tool-scope issue with controlled read-only subagent tasks.
4. Audit critic strictness and the `Data-engineer` review path.
5. Save a review memo and a remediation decision record with explicit classifications and recommended next actions.

## Acceptance Targets

- Each reported issue is classified as `repo defect`, `migration gap`, `runtime limitation`, `intentional design`, or `platform-owned` where appropriate.
- The review memo includes evidence-backed findings and a parity matrix.
- The decision record states whether to introduce `data-engineer-critic`, restore detailed active agent prompts, add no-MCP-by-default guardrails, and add an explicit literature-search concurrency contract.

## Verification Targets

- Active-vs-legacy parity evidence assembled from repo files
- Controlled literature-review reproduction completed
- Controlled subagent reproduction completed
- Review memo saved under `quality_reports/`
- Decision record saved under `quality_reports/decisions/`
