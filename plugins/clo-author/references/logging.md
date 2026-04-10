# Logging

This is the active Codex-native logging reference. The goal is resumability from disk without relying on hidden session state.

## 1. Primary Session Log

Use `quality_reports/session_logs/YYYY-MM-DD_description.md` as the default task-level record for any multi-stage or multi-file task.

Minimum contents:

- objective
- major files changed or reviewed
- design decisions
- verification results
- current status and next steps

The template at `templates/session-log.md` is the default format.

## 2. Research Journal

Use `quality_reports/research_journal.md` as an optional append-only coordination index when multiple roles, long-running reviews, or repeated stage transitions need a compact shared timeline.

Entry format:

```markdown
### YYYY-MM-DD HH:MM — [Role or Workflow]
**Phase:** [Discovery/Strategy/Execution/Peer Review/Presentation/Infrastructure]
**Target:** [file, artifact, or topic]
**Score:** [XX/100 or PASS/FAIL or N/A]
**Verdict:** [one-line outcome]
**Report:** [path to the detailed artifact]
```

Create the file on first use. One entry per major role invocation or workflow transition.

## 3. Decision Records

Use `quality_reports/decisions/` when the workflow closes a meaningful discovery or strategy choice that future sessions should not silently re-open.

Use `templates/decision-record.md` for the default structure.

## 4. Retired Legacy Surface

- `SESSION_REPORT.md` is legacy Claude-era infrastructure and is not required in the active Codex workflow.
- Legacy hook reminders under `plugins/clo-author/hooks/legacy/` remain preserved for migration reference only.

## 5. Logging Rules

- Prefer append-only updates for shared journals.
- Keep logs factual and resumable.
- When a task materially changes direction, record the decision and why.
- If a task is interrupted, the latest plan plus the latest session log should be enough to resume work.
