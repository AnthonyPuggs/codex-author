# Hook Notes

Legacy Claude hook scripts are stored in `legacy/` for reference only.

The Codex-native workflow does not depend on hidden event hooks. Equivalent behaviors are implemented through:

- `AGENTS.md`
- saved plans and session logs in `quality_reports/`
- explicit `tools` skill routines
- `plugins/clo-author/hooks/lint-scripts.sh` for deterministic script linting
- `plugins/clo-author/references/hook-replacements.md`
