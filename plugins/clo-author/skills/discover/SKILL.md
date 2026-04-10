---
name: discover
description: Run discovery workflows for literature review, data discovery, research interviews, and idea generation. Use when the user asks to review the literature, find datasets, scope a topic, brainstorm research questions, or populate the domain profile for a field.
---

# Discover

Use this skill for the Discovery phase.

## Read First

- `AGENTS.md`
- `plugins/clo-author/references/codex-workflow.md`
- `plugins/clo-author/references/agent-catalog.md`
- `plugins/clo-author/references/domain-profile.md`

## Modes

- Interview / scoping
- Literature review
- Data discovery
- Research ideation

## Procedure

1. Determine which discovery mode the user needs.
2. Browse when current literature, data availability, or journal expectations matter.
3. For literature review:
   - use the Librarian role to collect and synthesize sources
   - use the librarian-critic role to check gaps, recency, and bias
4. For data discovery:
   - use the Explorer role to build a ranked inventory
   - use the explorer-critic role to stress-test feasibility and measurement
5. For ideation or interviews:
   - gather constraints, target contribution, data reality, and identification possibilities
   - save a structured research note or spec
6. Always end with a recommended next step: strategy, more discovery, or abandon the idea.

## Outputs

- Literature memo or bibliography note in `quality_reports/`
- Data inventory in `quality_reports/`
- Updated domain profile inputs when field calibration changes
- Saved spec in `quality_reports/specs/` when the discovery interview becomes the basis for planning
