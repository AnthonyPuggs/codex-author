# Codex Workflow

This is the active operating workflow for the Codex-native Clo-Author.

Use `plugins/clo-author/references/runtime-activation.md` for the plugin activation contract before relying on natural-language skill routing.

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
- Decision records go in `quality_reports/decisions/` when discovery or strategy work locks an important choice.
- Decision history goes in `quality_reports/session_logs/`.
- Structured requirements go in `quality_reports/specs/`.

Use `plugins/clo-author/references/logging.md` for the canonical session-log and research-journal formats.

If a task cannot be resumed from disk, the workflow is incomplete.

## 3. Worker-Critic Execution

After planning:

1. Select the relevant worker role.
2. For strategy work, start with a Pre-Strategy Report that states which discovery inputs were actually read and which are missing.
3. For analysis work, start with a Pre-Code Report that states the strategy memo, naming map, estimator, and robustness obligations before editing code.
4. Produce the artifact.
5. Run the paired critic in read-only mode.
6. Fix issues and re-run review up to 3 rounds.
7. Verify outputs mechanically whenever possible.
8. Record the outcome and next step.

### Enforcement

- No artifact advances to the next phase without its critic's score >= 80.
- If a creator artifact exists without a critic score, it is not approved.
- Critics review and score only. Creators draft and revise only. Do not collapse those roles into one pass.
- If a worker-critic pair still fails after 3 rounds, escalate according to `plugins/clo-author/references/agent-catalog.md` instead of looping indefinitely.
- Phase dependencies are real gates:
  - execution code requires an approved strategy
  - execution writing requires approved code output
  - peer review requires approved paper plus approved code
  - submission requires verifier pass plus the final weighted gate

### Dependency-Driven Loop

```text
Plan approved -> identify eligible phase -> dispatch worker -> dispatch paired critic
-> score >= 80?
   yes -> verify mechanically -> log outcome -> advance if dependencies are met
   no  -> route fixes back to the worker -> critic re-reviews -> max 3 rounds
         -> if still blocked, escalate
```

### Standalone Skill Rule

Direct skill invocations still obey the same approval semantics. A standalone `strategize` run is not "approved strategy" unless the saved strategist-critic report clears the gate. A standalone `analyze` run must refuse to present code work as strategy-aligned if no approved strategy artefact exists.

## 4. Mechanical Enforcement

Before deeper review, run the fastest deterministic checks you can:

- Apply `plugins/clo-author/references/content-invariants.md` as the hard invariant layer.
- For R, Python, and Julia scripts, run `plugins/clo-author/hooks/lint-scripts.sh [file|dir]` as an advisory pre-check.
- Treat lint output as a screen for grep-able mistakes, not as a substitute for critic review.

## 5. Delegation Policy

- Use sub-agents only for bounded work with clear ownership.
- Keep critics read-only.
- Run blind reviews independently.
- Prefer sequential execution when the next step depends tightly on the previous result.
- Preferred parallelism is 2-4 concurrent roles.

## 6. Fast-Track Explorations

Exploratory work belongs in `explorations/` and can run on a lighter process:

1. Create a subfolder under `explorations/`.
2. Document goal, hypotheses, and stop conditions in the local `README.md`.
3. Use a lower quality threshold while exploring.
4. Graduate promising work into production folders only after it reaches the normal quality gate.

## 7. Verification

Verification is mandatory before presenting work:

- Papers: compile with XeLaTeX and Biber.
- Talks: compile or render the slide source.
- Code: run the script or the smallest safe reproducer.
- Reviews: ensure referenced files exist and cited claims are supported.
- Submission packages: verify script order, README completeness, data provenance, and output freshness.

## 8. Quality Gates

- Commit gate: 80+
- PR gate: 90+
- Submission gate: 95+ overall and every scored component >= 80
- Talks: advisory score only

Use `plugins/clo-author/references/quality-scoring.md` for the active weighted rubric and severity calibration.
Mechanical helpers such as `plugins/clo-author/hooks/lint-scripts.sh` are advisory screens, not substitutes for full multi-role review.
