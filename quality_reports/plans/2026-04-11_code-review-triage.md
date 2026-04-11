# Code Review Triage and Remediation Plan

## Summary

- Save the approved implementation plan as `quality_reports/plans/2026-04-11_code-review-triage.md` before any edits, per `AGENTS.md`.
- Use a **Safe Hybrid** policy for `.claude/`: it remains non-authoritative for this repo, but it should be safe if someone opens the project in Claude Code.
- **Worth implementing:** items 1, 4, 5, 6, 7, 8, 9, 10.
- **Valid concern but overstated:** item 2. The real cross-version hazard is `dict | None` in the runnable Claude hook files; `list[str]` is fine on Python 3.9.
- **Reject / no repo change:** item 3. `quality_reports/.Rhistory` exists locally but is already ignored by `.gitignore` and is not tracked.
- **Reject as already addressed:** item 11. `README.md` already documents the upstream refresh workflow under “Refresh the Infrastructure”.

## Behaviour and Code Changes

- Harden the live Claude compatibility surface in `.claude/settings.json`.
  - Remove the stale migration-only allow-list entries (`do if`, `then echo`, `fi`, the one-off `mkdir`, `mv`, and `echo` commands).
  - Leave the hook wiring in place under the Safe Hybrid assumption, but ensure every referenced script is safe to execute.
- Stop the legacy protection hook from blocking maintenance of `.claude/settings.json`.
  - In `.claude/hooks/protect-files.sh`, remove `settings.json` from the basename protection list rather than refactoring the matcher more broadly.
- Route Claude post-edit linting to the canonical Codex linter.
  - Update `.claude/hooks/post-edit-lint.sh` to call `plugins/clo-author/hooks/lint-scripts.sh` via `$CLAUDE_PROJECT_DIR`, with a local fallback only if the canonical script is missing.
  - Do not change `plugins/clo-author/hooks/lint-scripts.sh`; it is already the canonical implementation.
- Make the runnable Claude Python hooks internally consistent and Python-3.9-safe.
  - In `.claude/hooks/pre-compact.py` and `.claude/hooks/post-compact-restore.py`, replace `dict | None` annotations with 3.9-safe typing.
  - Align `find_active_plan()` in both files: scan recent plans, skip completed plans, use the same status mapping, and identify the next unchecked task the same way.
  - While touching `pre-compact.py`, make the decision ellipsis conditional and remove the unnecessary `f` prefix on the literal separator write.
- Add small shell-script hardening.
  - In `tests/workflow_parity.sh`, fail fast with a clear message when `rg` is unavailable.
  - In `scripts/install_codex_skill_link.sh`, make `--force` refuse a real directory at `~/.agents/skills/clo-author`; only symlinks should be replaced, and removal should use symlink-safe deletion rather than `rm -rf`.

## Important Interface and Runtime Effects

- Opening this repo in Claude Code will still read `.claude/settings.json`, but it will no longer carry stale migration allowances.
- Claude post-edit linting will use the same canonical linter as the Codex-side documentation points to.
- `scripts/install_codex_skill_link.sh --force` will become intentionally narrower: it replaces an existing symlink, not an arbitrary directory.
- `tests/workflow_parity.sh` will report a missing dependency explicitly instead of failing with `command not found`.

## Test Plan

- Validate `.claude/settings.json` remains valid JSON with `jq empty .claude/settings.json` or equivalent.
- Run `python3 -m py_compile .claude/hooks/pre-compact.py .claude/hooks/post-compact-restore.py` after the typing changes.
- Create a temporary `quality_reports/plans/` fixture with `COMPLETED`, `APPROVED`, `DRAFT`, and unchecked-task cases; run both Claude hook scripts with temporary `CLAUDE_PROJECT_DIR` and `HOME` values to confirm they report the same active plan and status.
- Run `bash tests/workflow_parity.sh` in a normal environment and once with `PATH` adjusted to exclude `rg`, confirming the second run fails with the new explicit message.
- Run `HOME="$(mktemp -d)" bash scripts/install_codex_skill_link.sh --check` and forced-install scenarios against both a symlink target and a real directory target, confirming the directory case is refused.

## Assumptions and Defaults

- `.claude/` is not the supported runtime, but it should remain execution-safe for accidental Claude usage.
- `plugins/clo-author/hooks/legacy/` remains archival reference material and is not part of this fix set.
- Item 3 gets no repository edit because the ignore policy is already correct.
- Item 11 gets no mandatory documentation edit because the sync workflow already exists in `README.md`; add only a cross-reference later if you want stronger discoverability.
