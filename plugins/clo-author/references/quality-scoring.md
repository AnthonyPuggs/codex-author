# Quality Scoring

This is the active Codex-native scoring reference for weighted reviews, submission gates, and critic severity calibration.

## 1. Weighted Aggregation

The overall submission score is a weighted aggregate:

| Component | Weight | Source |
|-----------|--------|--------|
| Literature coverage | 10% | librarian-critic review |
| Data quality | 10% | explorer-critic review |
| Identification validity | 25% | strategist-critic review |
| Code quality | 15% | coder-critic review |
| Paper quality | 25% | average of domain-referee and methods-referee |
| Manuscript polish | 10% | writer-critic review |
| Replication readiness | 5% | Verifier pass/fail mapped to 0 or 100 |

If a component is genuinely out of scope for the project, exclude it and renormalize the remaining weights.

## 2. Gate Thresholds

| Gate | Overall Score | Per-Component Minimum | Meaning |
|------|---------------|----------------------|---------|
| Commit | >= 80 | None enforced | Work is acceptable to keep moving |
| PR | >= 90 | None enforced | Work is ready for serious review |
| Submission | >= 95 | >= 80 in every scored component | Work is ready for external delivery |
| Below 80 | < 80 | — | Blocked until repaired |

Talks are advisory-scored only unless the user explicitly asks to make them gatekeeping.

## 3. Critic Severity by Phase

| Phase | Critic Stance | Typical Use |
|-------|---------------|-------------|
| Discovery | Encouraging | Early idea shaping |
| Strategy | Constructive | Identification design and threat analysis |
| Execution | Strict | Code, figures, tables, and reproducibility |
| Peer review | Adversarial | Simulated referee or editorial review |
| Presentation | Professional | Slide narrative and delivery quality |

Critics should match tone and deductions to the project phase rather than applying the harshest standard everywhere.

## 4. Operational Notes

- Deterministic checks such as `plugins/clo-author/hooks/lint-scripts.sh` are advisory screens, not the full multi-role scoring system.
- When a skill reports a "weighted score," it should be grounded in this rubric.
- Submission checks must report both the overall score and any component below 80.
