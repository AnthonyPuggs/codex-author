# Runtime Activation

This file defines the active runtime contract for the repo-local `clo-author` plugin.

## Contract

- The repo-local plugin is registered through `.agents/plugins/marketplace.json`.
- The marketplace entry must set `policy.installation` to `INSTALLED_BY_DEFAULT`.
- The plugin manifest lives at `plugins/clo-author/.codex-plugin/plugin.json`.
- The runtime may claim that Clo-Author skills trigger from natural language only when a fresh Codex session exposes those skills.

## Activation Smoke Test

Run this check at the start of a new Codex session before relying on the workflow:

1. Open the repository root in Codex.
2. Confirm the `clo-author` plugin is present in the local plugin surface.
3. Confirm the 10 skill names are available:
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
4. If the skill surface is missing, treat the runtime as blocked rather than silently assuming fallback behaviour is equivalent.

## Blocked Runtime Policy

If a session does not expose the `clo-author` skills:

- do not claim the repo-local plugin is active
- do not claim natural-language skill routing is in effect
- use `AGENTS.md` plus the active reference files as the fallback control plane
- record the blocked activation state in the session log
- direct the user to restart the session after confirming the repo-local plugin is installed

## Why This Matters

The worker-critic workflow depends on the active skill surface. If the plugin is not loaded, the session may fall back to generic Codex behaviour and silently skip the approval, scoring, and escalation semantics that the repo promises.
