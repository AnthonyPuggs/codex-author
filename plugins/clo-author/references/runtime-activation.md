# Runtime Activation

This file defines the active runtime contract for Clo-Author in Codex.

## Contract

- The repo-local skill bundle lives under `plugins/clo-author/skills/`.
- On this Codex harness, native skill discovery scans `~/.agents/skills/` at startup.
- The reliable machine-level installation path is `~/.agents/skills/clo-author -> <repo>/plugins/clo-author/skills`.
- The repo-local marketplace metadata in `.agents/plugins/marketplace.json` may remain useful for future or other harnesses, but it is not sufficient evidence that the live Codex skill surface will load Clo-Author.
- The runtime may claim that Clo-Author skills trigger from natural language only when a fresh Codex session exposes those skills.

## Activation Smoke Test

Run this check at the start of a new Codex session before relying on the workflow:

1. Verify the machine-level skill link exists:
   - `ls -la ~/.agents/skills/clo-author`
   - or run `bash scripts/install_codex_skill_link.sh --check`
2. Restart Codex.
3. Open the repository root in Codex.
4. Confirm the 10 skill names are available:
   - `new-project`
   - `discover`
   - `strategize`
   - `analyze`
   - `write`
   - `review`
   - `revise`
   - `talk`
   - `submit`
   - `tools`
5. If the skill surface is missing, treat the runtime as blocked rather than silently assuming fallback behaviour is equivalent.

## Blocked Runtime Policy

If a session does not expose the `clo-author` skills:

- do not claim Clo-Author is natively active
- do not claim natural-language skill routing is in effect
- use `AGENTS.md` plus the active reference files as the fallback control plane
- record the blocked activation state in the session log
- run `bash scripts/install_codex_skill_link.sh` if the home-level skill link is missing
- restart Codex after the link is installed
- if a fresh session still does not expose the skills, treat the problem as Codex-level plugin discovery rather than repo content

## Why This Matters

The worker-critic workflow depends on the active skill surface. If the skill bundle is not loaded into Codex's startup discovery path, the session may fall back to generic Codex behaviour and silently skip the approval, scoring, and escalation semantics that the repo promises.
