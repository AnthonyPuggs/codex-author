# Codex Workflow

This is the active operating workflow for the Codex-native Clo-Author.

## 1. Plan First

For any non-trivial task:

1. Read `AGENTS.md`, `MEMORY.md`, and any relevant references.
2. If the request is ambiguous or high-effort, create a requirements spec in `quality_reports/specs/YYYY-MM-DD_description.md`.
3. Create a plan in `quality_reports/plans/YYYY-MM-DD_description.md`.
4. Get user approval unless the user explicitly wants immediate execution.
5. Save an initial session log when the work will span multiple stages or files.

For template bootstrap work, save the initialization plan before replacing placeholders or project-state stubs.

## 2. File-Backed Persistence

Codex does not rely on hidden memory for this project.

- Durable lessons go in `MEMORY.md`.
- Active task strategy goes in `quality_reports/plans/`.
- Decision history goes in `quality_reports/session_logs/`.
- Structured requirements go in `quality_reports/specs/`.

Use `plugins/clo-author/references/logging.md` for the canonical session-log and research-journal formats.

If a task cannot be resumed from disk, the workflow is incomplete.

## 3. Worker-Critic Execution

After planning:

1. Select the relevant worker role.
2. Produce the artifact.
3. Run the paired critic in read-only mode.
4. Fix issues and re-run review up to 3 rounds.
5. Verify outputs mechanically whenever possible.
6. Record the outcome and next step.

## 4. Delegation Policy

- Use sub-agents only for bounded work with clear ownership.
- Keep critics read-only.
- Run blind reviews independently.
- Prefer sequential execution when the next step depends tightly on the previous result.
- Preferred parallelism is 2-4 concurrent roles.

## 5. Fast-Track Explorations

Exploratory work belongs in `explorations/` and can run on a lighter process:

1. Create a subfolder under `explorations/`.
2. Document goal, hypotheses, and stop conditions in the local `README.md`.
3. Use a lower quality threshold while exploring.
4. Graduate promising work into production folders only after it reaches the normal quality gate.

## 6. Verification

Verification is mandatory before presenting work:

- Papers: compile with XeLaTeX and Biber.
- Talks: compile or render the slide source.
- Code: run the script or the smallest safe reproducer.
- Reviews: ensure referenced files exist and cited claims are supported.
- Submission packages: verify script order, README completeness, data provenance, and output freshness.

## 7. Quality Gates

- Commit gate: 80+
- PR gate: 90+
- Submission gate: 95+ overall and every scored component >= 80
- Talks: advisory score only

Use `plugins/clo-author/references/quality-scoring.md` for the active weighted rubric and severity calibration.
`scripts/quality_score.py` remains a lightweight mechanical checker, not the full multi-role review system.
