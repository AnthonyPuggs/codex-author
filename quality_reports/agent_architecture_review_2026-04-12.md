# Agent Architecture Review — 2026-04-12

## Scope

This review audited the active Codex-native Clo-Author control plane against four reported issues:

1. literature review appears to search sources one at a time
2. subagents allegedly stall while connecting to the Vercel MCP server
3. there is no dedicated `data-engineer-critic`
4. critics appear materially softer than in the Claude-era Clo-Author

The audit compared the active surfaces under `plugins/clo-author/` with the preserved Claude-era materials under `plugins/clo-author/references/legacy-*`, then ran bounded read-only subagent probes in the current session.

## Method

### Repo surfaces reviewed

- Active control plane:
  - `plugins/clo-author/references/agent-catalog.md`
  - `plugins/clo-author/references/codex-workflow.md`
  - `plugins/clo-author/references/quality-scoring.md`
  - `plugins/clo-author/references/runtime-activation.md`
  - `plugins/clo-author/skills/discover/SKILL.md`
  - `plugins/clo-author/skills/analyze/SKILL.md`
  - `plugins/clo-author/skills/strategize/SKILL.md`
  - `plugins/clo-author/skills/write/SKILL.md`
- Preserved Claude-era comparators:
  - `plugins/clo-author/references/legacy-rules/workflow.md`
  - `plugins/clo-author/references/legacy-rules/agents.md`
  - `plugins/clo-author/references/legacy-agents/librarian-critic.md`
  - `plugins/clo-author/references/legacy-agents/coder-critic.md`
  - `plugins/clo-author/references/legacy-agents/strategist-critic.md`
  - `plugins/clo-author/references/legacy-agents/writer-critic.md`

### Empirical probes run in this session

- Control subagent with no tools: returned immediately with no tool or MCP activity.
- Local-file inspection subagent, `fork_context = false`: completed normally.
- Local-file inspection subagent, `fork_context = true`: completed normally.
- Mini literature-review subagent, `fork_context = false`: used batched `web.search_query` calls; no Vercel or MCP initialisation issue observed.
- Mini literature-review subagent, `fork_context = true`: same result.

These probes were read-only and did not mutate the repository.

## Parity Matrix

| Behaviour | Active evidence | Legacy evidence | Status | Assessment |
|-----------|-----------------|----------------|--------|------------|
| Worker-critic pairings exist and gate advancement | `agent-catalog.md:11-28, 39-45` | `legacy-rules/agents.md:11-19, 29-33` | preserved | The high-level pairing and gate model survived the port. |
| `Data-engineer` reviewed by `coder-critic` | `agent-catalog.md:17-19` | `legacy-rules/agents.md:15, 65` | preserved | This is inherited design, not a missing port artefact. |
| Detailed critic rubrics and deduction tables are active | active skills only summarise review duties, e.g. `analyze/SKILL.md:73-90`, `write/SKILL.md:42-48` | `legacy-agents/librarian-critic.md:18-84`, `legacy-agents/coder-critic.md:18-159`, `legacy-agents/writer-critic.md:18-110` | missing | Detailed critic prompt bodies remain archived, not active. |
| Phase-based severity exists as an active rule | `quality-scoring.md:32-48` | `legacy-rules/quality.md` plus critic prompts | weakened | Severity exists abstractly, but active role prompts do not clearly consume it as an executable contract. |
| Three-strikes escalation is active | `agent-catalog.md:59-80` | `legacy-rules/agents.md:79-111`, `legacy-rules/workflow.md:77-80` | preserved | Escalation semantics remain in the active control plane. |
| Parallelism is part of the workflow contract | `agent-catalog.md:30-37` | `legacy-rules/workflow.md:74-75, 109-114, 177-182` | weakened | The active surface keeps generic parallelism guidance but loses concrete orchestration detail. |
| Literature-review fan-out contract is explicit | `discover/SKILL.md:41-56` | no strong explicit within-literature fan-out contract found; only broader phase parallelism in `legacy-rules/workflow.md:109-114, 177-182` | missing | The active workflow does not tell the Librarian how to batch or parallelise search work. |
| Research roles have an explicit no-MCP-by-default policy | none found in active repo surfaces | none found in preserved legacy surfaces | missing | This omission leaves tool-scope behaviour to generic runtime defaults. |
| Blocked-runtime fallback is explicit | `runtime-activation.md:13-49` | not comparable in Claude-era files | preserved / strengthened | The Codex port correctly documents that blocked activation can cause generic fallback behaviour. |

## Findings

### 1. Literature-review concurrency

**Classification:** `migration gap`

**Evidence**

- The active literature-review workflow is generic: read local context, browse, search journals, follow citation chains, save synthesis (`discover/SKILL.md:41-56`).
- The active catalogue preserves only generic subagent parallelism guidance (`agent-catalog.md:30-37`).
- The preserved Claude-era workflow does document parallel phase activation, but not a concrete, active literature-search fan-out contract (`legacy-rules/workflow.md:109-114, 177-182`).
- In this session, two independent literature-review probes used batched `web.search_query` calls within a single tool call and reported no search bottleneck at the tool level.

**Interpretation**

The current evidence does not support a hard claim that the Codex runtime can only search one source at a time. The stronger repo-level problem is that the active `discover` workflow does not require or even describe batched search fan-out, source buckets, or merge/synthesis sequencing. In practice, that leaves search concurrency to generic model behaviour.

**Decision**

Treat this as a missing active contract. The remediation should be to encode a concrete literature-search fan-out protocol in the active surface rather than assuming the runtime will infer it.

### 2. Subagent Vercel MCP stalls

**Classification:** `platform-owned` with a repo hardening opportunity

**Evidence**

- No active Clo-Author skill or reference file in the repo mentions Vercel, MCP usage, or an external tool scope for research roles.
- The active runtime contract explicitly warns that blocked skill activation can lead to generic fallback behaviour (`runtime-activation.md:35-49`).
- In this session, a toolless control subagent, two local-file probes, and two literature-review probes all completed without any visible Vercel initialisation issue.

**Interpretation**

The reported stall is not reproducible from the repo alone in the current session. That weakens the case for a repo defect and points instead to an intermittent harness-level or plugin-initialisation issue. However, the repo does not currently defend itself against unnecessary MCP/app use by research roles, so generic runtime behaviour is free to overreach.

**Decision**

Treat the stall as platform-owned unless a future session captures a concrete failure trace tied to repo instructions. Even so, add a repo-level “no external MCP/app tools unless explicitly required” rule for research roles and subagent dispatch.

### 3. No dedicated `data-engineer-critic`

**Classification:** `intentional design`, inherited from the Claude-era workflow

**Evidence**

- The active role catalogue pairs `Data-engineer` with `coder-critic` (`agent-catalog.md:17-19`).
- The active `analyze` workflow routes both data preparation and code review through `coder-critic` (`analyze/SKILL.md:42-49, 73-96`).
- The preserved Claude-era pairings do the same (`legacy-rules/agents.md:15, 65`), and the preserved `coder-critic` prompt explicitly covers a “Data Cleaning (Stage 0)” section (`legacy-agents/coder-critic.md:87-117`).

**Interpretation**

The absence of `data-engineer-critic` is not a porting mistake. It is the original architecture. The problem is different: in the active Codex surface, the shared critic arrangement has become under-specified because the detailed prompt bodies are no longer active. That makes data-pipeline review easier to underperform even if the historical pairing was once adequate.

**Decision**

Introduce a dedicated `data-engineer-critic` in the active Codex architecture. The historical shared-critic design was defensible when the full `coder-critic` prompt was active; it is no longer the best choice in a thinner active control plane.

### 4. Critics are softer than the Claude-era version

**Classification:** `migration gap`

**Evidence**

- The active catalogue explicitly says the detailed Claude-era prompt copies are preserved as migration source material and are not the active control plane (`agent-catalog.md:3-5`).
- The active skills mostly describe routing and artefact requirements rather than embedding the full critic rubrics. Examples:
  - `strategize/SKILL.md:63-87`
  - `analyze/SKILL.md:73-96`
  - `write/SKILL.md:42-48`
- The active `quality-scoring.md` defines severity by phase, but only as a high-level rubric (`quality-scoring.md:32-48`).
- By contrast, the preserved critic prompts remain highly specific:
  - `librarian-critic` has explicit checks and deductions (`legacy-agents/librarian-critic.md:18-84`)
  - `coder-critic` has 12 categories, deduction tables, and data-cleaning checks (`legacy-agents/coder-critic.md:18-159`)
  - `strategist-critic` has sequential phases, early-stop logic, and proportional severity rules
  - `writer-critic` has explicit deductions, blocking/advisory distinctions, and escalation targets (`legacy-agents/writer-critic.md:18-110`)
- The active runtime contract also warns that if the skill surface is not genuinely active, generic fallback behaviour may silently skip the intended approval and scoring semantics (`runtime-activation.md:47-49`).

**Interpretation**

The most plausible reason critics feel softer is that the active Codex surface is thinner and less executable than the preserved Claude-era prompt layer. The repo still names the gates, but it no longer gives critics the same active deduction tables, early-stop logic, blocking rules, and report templates. A blocked or partially loaded skill surface would make that worse by falling back to generic Codex behaviour.

**Decision**

Restore detailed active critic prompts and make phase severity an explicit dispatch input rather than a passive reference file.

## Recommended Remediation Backlog

### Priority 1 — Restore active critic prompt surfaces

- Create an active prompt layer for at least:
  - `librarian-critic`
  - `data-engineer-critic`
  - `coder-critic`
  - `strategist-critic`
  - `writer-critic`
- Do not leave the operative rubrics only under `legacy-agents/`.
- Ensure each active critic prompt includes:
  - explicit check categories
  - deduction tables
  - report format
  - blocking versus advisory semantics
  - escalation target and three-strikes behaviour

### Priority 2 — Add `data-engineer-critic`

- Narrow `coder-critic` to estimation scripts, reproducibility, output sanity, and code-quality review.
- Assign `data-engineer-critic` explicit responsibility for:
  - merges and match rates
  - sample restriction accounting
  - missing-data handling
  - variable-construction fidelity
  - provenance and transformation documentation
  - output plumbing for descriptive artefacts

### Priority 3 — Encode literature-search fan-out explicitly

- Update the active literature-review workflow so it no longer relies on generic model initiative.
- Require:
  - source buckets
  - batched search queries per bucket
  - bounded fan-out
  - deduplication before synthesis
  - explicit follow-up pass only after the first synthesis and critic review

### Priority 4 — Add a no-MCP-by-default rule for research roles

- In the active workflow and role catalogue, state that research roles should default to:
  - local repo files
  - ordinary web search when needed
  - no external MCP/app tools unless the task explicitly requires them
- This will not fix a platform bug on its own, but it will reduce avoidable tool-scope drift.

### Priority 5 — Tighten runtime activation and fallback messaging

- Keep the existing smoke test.
- Add a sharper warning in the active workflow that critic strictness and approval semantics are unreliable when the skill surface is blocked and the session falls back to generic Codex behaviour.

## Final Classification Summary

| Issue | Classification | Decision |
|-------|----------------|----------|
| Literature review appears one-at-a-time | `migration gap` | Add an explicit active fan-out contract |
| Subagents stall on Vercel MCP | `platform-owned` | Add no-MCP-by-default guardrails, but treat root cause as runtime-level until reproduced |
| No `data-engineer-critic` | `intentional design` | Change the design in Codex; add a dedicated critic |
| Critics too soft | `migration gap` | Restore detailed active critic prompts and explicit severity injection |

## Closing Assessment

The active Codex port preserves the skeleton of the Clo-Author workflow but not the full operative critic surface. The repo-level problem is therefore not that the architecture disappeared entirely; it is that too much of the enforcement logic was relegated to archived migration material. The result is a system that still names worker-critic gates, but no longer instructs those critics with the same specificity or operational discipline.
