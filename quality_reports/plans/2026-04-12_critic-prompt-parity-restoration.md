# Plan: Critic Prompt Parity Restoration

**Date:** 2026-04-12
**Status:** Implemented
**Source:** User-approved critic prompt parity restoration plan

## Summary

Restore a detailed active critic prompt layer for the Codex-native Clo-Author, add `data-engineer-critic`, and rewire the active skills, workflow references, and guides so the live review surface no longer depends on archived legacy critic prompts.

## Objectives

1. Add `plugins/clo-author/references/active-critics/` as the live detailed critic layer.
2. Add `plugins/clo-author/references/critic-runtime-contract.md` for shared Codex-era critic rules.
3. Rewire active skills and references to consume the new critic layer.
4. Add a regression script for critic prompt parity.

## Verification Targets

- `bash tests/critic_prompt_parity.sh`
- `bash tests/workflow_parity.sh`
