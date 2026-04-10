# Plan: Realign the Codex Port with Canonical `hugosantanna/clo-author`

## Summary

As of 2026-04-11, this repo is a Codex-specific fork/port that still contains stale references to `scunning1975/clo-author`, while the canonical upstream is `hugosantanna/clo-author`. The local port appears to be based roughly on upstream `v4.0.0`, but canonical upstream has already moved to `v4.1.0` (2026-04-09) and `main` is newer still. This is not a simple link swap: the local repo has a Codex-only surface (`AGENTS.md`, `plugins/clo-author/`) that does not exist upstream, so the work needs a controlled parity pass rather than a blind overwrite.

## Implementation Changes

- Establish canonical upstream metadata everywhere user-facing or machine-readable.
  - Replace `scunning1975/clo-author` with `hugosantanna/clo-author` in the live local surfaces: `README.md`, `guide/index.qmd`, `guide/_quarto.yml`, and `plugins/clo-author/.codex-plugin/plugin.json`.
  - Update any plugin metadata fields that imply ownership or homepage identity so the Codex plugin clearly points to canonical upstream while still describing this repo as a Codex port.

- Define and document the sync model before changing content.
  - Treat upstream `.claude/`, guide docs, templates, and governance content as the source baseline.
  - Treat local `AGENTS.md`, `plugins/clo-author/`, `.agents/`, and Codex-only docs as the adaptation layer.
  - Add a short “upstream sync policy” note to local docs/changelog so future updates are explicit about what is mirrored vs. port-specific.

- Run a structured upstream parity audit against `v4.1.0` and current `main`.
  - Compare local `.claude/`, `guide/`, `templates/`, and top-level docs against upstream shallow clone or tagged snapshots.
  - Classify each upstream delta into one of three buckets: direct adopt, adopt-with-Codex-translation, or intentionally omit.
  - Record this as a file-backed artifact under `quality_reports/` so the port is resumable.

- Port upstream `v4.1.0` features into the Codex architecture where they are still relevant.
  - Add Codex-native equivalents for upstream enforcement additions now missing locally: `content-invariants`, decision-record template/workflow, lint tooling references, and the pre-strategy/pre-code report requirements.
  - Update local Codex skills and references so these features are surfaced through `plugins/clo-author/skills/` and `plugins/clo-author/references/`, not only via legacy `.claude/` paths.
  - Sync any upstream guide/changelog sections that describe these features, translating Claude-specific wording into Codex-native wording instead of copying it verbatim.

- Reconcile versioning and provenance.
  - Decide whether the Codex port keeps an independent semantic version stream or tracks upstream version plus a Codex suffix.
  - Update local `CHANGELOG.md` to state the upstream baseline explicitly, e.g. “Codex port synced to upstream `v4.1.0` plus local Codex adaptations”.
  - If needed, add the upstream commit/tag used for the sync to the changelog or a session log.

## Public Interfaces / Types / Artifacts

- Plugin metadata contract in `plugins/clo-author/.codex-plugin/plugin.json`:
  - `author.url`, `homepage`, `repository`, `interface.websiteURL`, `privacyPolicyURL`, `termsOfServiceURL` should point to canonical upstream or a consciously chosen Codex-port URL.
- Documentation bootstrap contract:
  - All clone/fork instructions should use `hugosantanna/clo-author` unless a sentence is explicitly about this Codex-port repo.
- New or updated parity artifacts:
  - A saved audit/report under `quality_reports/` listing adopted, translated, and omitted upstream changes.
  - Potential new Codex reference/template files for invariants, linting guidance, and decision records.

## Test Plan

- Search-based verification:
  - `rg` must return no live references to `scunning1975/clo-author` outside historical review/session-log artifacts.
  - `rg` must confirm canonical repo URLs in plugin metadata and guide navigation.
- Documentation verification:
  - Quarto guide pages and navbar link to `hugosantanna/clo-author`.
  - Quick-start instructions consistently distinguish canonical upstream from this Codex port.
- Parity verification:
  - A checklist confirms whether each upstream `v4.1.0` addition was adopted, translated, or intentionally skipped.
  - Local skills/references expose any adopted enforcement-layer features through Codex-native entrypoints.
- Change integrity:
  - No user-project content paths (`paper/`, `data/`, `scripts/`, project-specific `quality_reports/`) are overwritten by upstream template sync work.

## Assumptions and Defaults

- Default source of truth: canonical upstream is `hugosantanna/clo-author`, not the outdated `scunning1975` fork.
- Default comparison baseline: upstream `v4.1.0` dated 2026-04-09 plus current upstream `main` head `cec3c24c42f0daa4f74008a5eb60d9d0ff6df919`; local repo currently advertises `4.0.0`.
- Default migration rule: preserve the Codex-native architecture (`AGENTS.md`, `plugins/clo-author/`) and translate upstream Claude-only improvements into that architecture instead of replacing the port with upstream `.claude` wholesale.
- Historical artifacts such as `quality_reports/codex-port-review.md` can keep legacy references if they are clearly archival; live bootstrap/docs/plugin surfaces should not.
