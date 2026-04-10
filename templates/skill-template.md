# Codex Skill Template

Use this template when adding a new repo-local Clo-Author skill under `plugins/clo-author/skills/`.

## When to Create a Skill

Create a skill when:

- the workflow has 3 or more steps
- the same routine recurs across projects
- the workflow benefits from named roles or references
- the outputs should always land in the same place

Do not create a skill for one-off tasks or tiny operations that are better handled directly in the conversation.

## File Location

Create the skill at:

```text
plugins/clo-author/skills/[your-skill-name]/SKILL.md
```

## Template

```markdown
---
name: your-skill-name
description: Explain what the skill does, when it should trigger, and the kinds of user requests that should activate it.
---

# Your Skill Name

[One sentence describing the workflow.]

## Read First

- `AGENTS.md`
- `plugins/clo-author/references/[relevant-reference].md`

## Procedure

1. [First major step]
2. [Second major step]
3. [Verification or review step]
4. [Output and persistence step]

## Outputs

- [Path or artifact 1]
- [Path or artifact 2]
```

## Writing Good Descriptions

The description should answer:

- what the skill does
- when it should trigger
- what kinds of user requests should activate it

Good example:

```yaml
description: Review econometric code for reproducibility and strategy alignment. Use when the user asks to audit R, Stata, Python, or Julia scripts, check regression code, verify clustering and fixed effects, or run a code review before submission.
```

Bad example:

```yaml
description: Helps with code
```

## Repo Conventions

- Prefer natural-language triggering over command syntax.
- Save substantial artifacts under `quality_reports/`.
- Point the skill to the active Codex references, not the legacy `.claude/` tree.
- Use worker-critic separation when the workflow benefits from review.
