# Hook Replacements

The Claude version relied on event hooks. The Codex version keeps the behavior, but not the hidden automation.

## Active Policy

| Legacy Hook Behavior | Codex Replacement |
|----------------------|-------------------|
| File protection before edits | State protected paths in `AGENTS.md` and review the target files before editing |
| Pre-compact reminder | Keep plan, spec, session log, and memory on disk continuously |
| Session restore after compaction | Resume by reading `AGENTS.md`, the latest plan, and the latest session log |
| Post-merge reminder | Use the `tools` skill to review changes and extract durable lessons into `MEMORY.md` |
| Post-edit linting | Run `plugins/clo-author/hooks/lint-scripts.sh [file|dir]` manually or from an external wrapper before code review |

## Utility Scripts

- `plugins/clo-author/hooks/legacy/` preserves the original Claude hook scripts for reference only.
- `plugins/clo-author/hooks/lint-scripts.sh` is the active Codex-native lint helper.
- `plugins/clo-author/hooks/post-edit-lint.sh` is an optional wrapper for environments that expose edited file paths through environment variables.

## Practical Recovery Routine

When resuming work after interruption:

1. Read `AGENTS.md`.
2. Read the latest file in `quality_reports/plans/`.
3. Read the latest file in `quality_reports/session_logs/`.
4. Read recent `[LEARN:*]` entries in `MEMORY.md`.
5. Continue from the next explicit step in the saved plan.
