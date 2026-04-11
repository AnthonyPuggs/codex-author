---
name: review
description: All quality reviews for manuscripts, methods, code, talks, and replication packages. Use when the user asks for code review, paper review, causal audit, proofreading, peer review simulation, stress testing, or a weighted quality score.
---

# Review

Unified review workflow that routes to the appropriate critic or referee roles based on the target and requested mode.

## Read First

- `AGENTS.md`
- `plugins/clo-author/references/runtime-activation.md`
- `plugins/clo-author/references/codex-workflow.md`
- `plugins/clo-author/references/content-invariants.md`
- `plugins/clo-author/references/quality-scoring.md`
- `plugins/clo-author/references/logging.md`
- `plugins/clo-author/references/agent-catalog.md`
- `plugins/clo-author/references/domain-profile.md`
- `plugins/clo-author/references/journal-profiles.md` when journal calibration is requested

## Routing Logic

### Auto-detect by target

- manuscript source -> comprehensive manuscript review
- R, Python, Stata, or Julia script -> code review
- talk source -> storyteller-critic audit

### Explicit modes

- code review
- manuscript review
- methods-only review
- proofread / polish
- peer review simulation
- hostile stress test
- cross-language replication review
- full weighted review

## Mode Details

### Comprehensive Manuscript Review

Dispatch in parallel when appropriate:

1. strategist-critic for the causal design audit
2. writer-critic for manuscript polish
3. Verifier for mechanical checks

Compute the weighted outcome using `plugins/clo-author/references/quality-scoring.md`.

### Code Review

1. Run `plugins/clo-author/hooks/lint-scripts.sh [file|dir]` first.
2. Dispatch coder-critic in read-only mode.
3. Save the report and quality outcome before proposing revisions.

### Methods-Only Review

Dispatch strategist-critic standalone and run the four-phase econometric review.

### Proofread / Polish

Dispatch writer-critic standalone, with `content-invariants.md` as the hard invariant layer for mechanical issues.

### Full Peer Review

The peer-review route is explicit: editor desk review -> referee dispatch -> editorial decision.

1. Editor runs a desk review and assigns referees.
2. domain-referee and methods-referee review independently and blindly.
3. Editor synthesizes the reports into FATAL / ADDRESSABLE / TASTE and produces the decision memo.

Save outputs to `quality_reports/` with separate artefacts for desk review, referee reports, and the editorial decision.

### Hostile Stress Test

Use the same peer-review routing but instruct the editor to select more adversarial calibration when the user asks for a stress test.

### Cross-Language Replication Review

If the user asks for replication review:

- dispatch a second implementation in the requested language
- review both implementations
- compare output parity against the active tolerances before issuing a verdict

## Reporting Rules

- For manuscripts and talks, cite invariant numbers when the issue is mechanical and non-negotiable.
- When reporting a weighted score, ground it in the active scoring rubric.
- Save findings before proposing revisions.
- Append a research-journal entry whenever the review changes project status or produces a formal gate outcome.

## Outputs

- Review memo in `quality_reports/`
- Weighted score or pass/fail result when applicable
- Peer-review decision memo when the editor/referee flow runs
- Clear next-step recommendation grounded in the saved review artefacts

Do not edit source files while running the review workflow. Review first, then route revisions explicitly.
