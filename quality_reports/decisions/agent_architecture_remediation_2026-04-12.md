# Decision Record — Infrastructure: Agent Architecture Remediation

**Date:** 2026-04-12
**Stage:** Infrastructure
**Decided by:** User + Codex review workflow

---

## Decision

Move the Codex port from a thin summary-based agent surface to an active prompt-driven surface, add a dedicated `data-engineer-critic`, encode explicit literature-search fan-out, and add a no-MCP-by-default rule for research subagents.

## Context

The review found that the high-level worker-critic structure survived the port, but the detailed critic rubrics, deduction tables, severity handling, and review formats largely remain archived under `legacy-*` rather than active. That explains the softness of critics more convincingly than any single runtime bug. The review also found that `Data-engineer -> coder-critic` is inherited design rather than an accidental omission, but that this shared arrangement is no longer ideal in the thinner active Codex surface. Finally, the claimed Vercel MCP stall was not reproducible in this session and is therefore treated as a platform-level issue unless future traces show otherwise.

## Alternatives Considered

| Alternative | Why rejected |
|-------------|-------------|
| Keep the current thin active skills and rely on `legacy-*` files as reference material only | Does not restore operative critic strictness or explicit execution contracts |
| Restore the preserved Claude-era prompts verbatim as the active surface | Too literal for the Codex runtime and still would not solve current MCP/tool-scope concerns cleanly |
| Keep `coder-critic` as the only execution critic and merely expand its active checklist | Better than the status quo, but still leaves data-pipeline review too broad and too easy to under-specify |
| Treat the Vercel MCP report as a repo defect and redesign around it immediately | The issue was not reproducible in controlled probes and no repo evidence points to Vercel-specific instructions |

## Key Assumptions

1. The current session's successful subagent probes are representative enough to reject a blanket “all subagents stall on Vercel” claim at the repo level.
2. Restoring active prompt detail will materially improve critic strictness even before any platform-level runtime fixes.
3. A dedicated `data-engineer-critic` will reduce review ambiguity rather than create harmful overlap, provided remit boundaries are explicit.

## What Would Invalidate This

- A future controlled reproduction shows that the repo's own instructions are directly triggering Vercel MCP initialisation or stalling.
- A stronger active `coder-critic` prototype fully captures data-engineering review quality without role overlap, making a dedicated `data-engineer-critic` unnecessary.
- Codex introduces a native, reliable role-prompt or tool-scope mechanism that makes a separate active prompt layer redundant.

## Approved By

User, 2026-04-12
