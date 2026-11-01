---
type: Rule
title: UI Test Assertion Strategy — Behaviour and Semantics vs Presentation Literals
description: Mandate semantic and accessibility assertions in UI tests; forbid asserting exact CSS property literals (hex colours, pixel/rem widths, font names) to prevent brittle suites.
tags: [testing, ui, web, accessibility, assertions, semantics]
timestamp: 2026-11-01T00:00:00Z
id: rule-testing-ui-assertion-strategy
cdr_ref: CDR-INC-002
created: 2026-11-01
modified: 2026-11-01
verified: 2026-11-01
age_days: 0
evidence:
  - gui/tests/test_routes.py:42-71 (presentation literal anti-pattern)
  - gui/tests/test_runner.py, test_reports.py (behaviour-first contrast)
  - Team Constitution Principle 5 (Tests Drive Confidence)
---

> ⚠️ **Memory Verification**
> This directive is 0 days old. Before applying:
> - [ ] Pattern still exists in current codebase
> - [ ] Rule is actively followed by team
> - [ ] No conflicting rules introduced
> 
> **Verification Date**: 2026-11-01
> **Verify Again After**: 2026-12-01 (30 days)

# Rule: UI Test Assertion Strategy — Behaviour and Semantics vs Presentation Literals

## Core Principles

1. **Assert contracts, not styling details**: UI and server-rendered route tests MUST assert semantic structure, accessibility attributes, and user-facing state:
   - Check `data-theme="dark"` / `data-theme="light"` on the root container.
   - Check `aria-pressed="true"` / `aria-expanded` on interactive controls.
   - Check presence of required form inputs, action URLs, and CSRF tokens.
   - Check that token blocks (`:root` / CSS bundle links) are referenced and load.
2. **Forbid literal CSS assertions**: Tests MUST NOT assert exact CSS property literals such as hex colour codes (`--accent: #b23a1b`), exact dimensional units (`inline-size: 5.4rem`), or font family strings (`Michroma`). Pinning decorative values couples tests to transient styling decisions, creating brittle test suites that break during visual redesigns while behaviour remains correct.
3. **Align with Constitution Principle 5**: "Tests verify behavior, not existence or implementation trivia." Passing tests must give confidence that the feature works; harmless design updates must not turn the CI suite red.

## Source

Contributed from: tech-pioneer
CDR: CDR-INC-002
Date: 2026-11-01

## Evidence

- `gui/tests/test_routes.py:42-71` vs `test_runner.py` / `test_reports.py`
- Team Constitution Principle 5

## Verification Log

| Date | Verified By | Notes |
|------|-------------|-------|
| 2026-11-01 | tech-pioneer | Initial publication via /levelup.implement |
