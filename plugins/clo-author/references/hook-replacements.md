# Hook Replacements

The Claude version relied on event hooks. The Codex version keeps the behavior, but not the hidden automation.

## Active Policy

| Legacy Hook Behavior | Codex Replacement |
|----------------------|-------------------|
| File protection before edits | State protected paths in `AGENTS.md` and review the target files before editing |
| Pre-compact reminder | Keep plan, spec, session log, and memory on disk continuously |
| Session restore after compaction | Resume by reading `AGENTS.md`, the latest plan, and the latest session log |
| Post-merge reminder | Use the `tools` skill to review changes and extract durable lessons into `MEMORY.md` |

## Legacy Scripts

The original hook scripts are preserved under `plugins/clo-author/hooks/legacy/` as optional reference utilities. They are not auto-wired into Codex.

## Practical Recovery Routine

When resuming work after interruption:

1. Read `AGENTS.md`.
2. Read the latest file in `quality_reports/plans/`.
3. Read the latest file in `quality_reports/session_logs/`.
4. Read recent `[LEARN:*]` entries in `MEMORY.md`.
5. Continue from the next explicit step in the saved plan.
