---
type: Rule
title: Single Canonical Report Projection with Export Parity
description: Derive every human- and machine-readable report view from one canonical projection function, enforcing terminal state overrides and cross-format parity tests.
tags: [python, reporting, projection, parity, export, architecture]
timestamp: 2026-11-01T00:00:00Z
id: rule-python-report-projection-parity
cdr_ref: CDR-002
created: 2026-11-01
modified: 2026-11-01
verified: 2026-11-01
age_days: 0
evidence:
  - gui/reports.py:26-58 (build_report single projection)
  - gui/reports.py:16-23 (_verdict terminal state overrides)
  - gui/app.py:222-244 (export download routes)
  - gui/tests/test_reports.py (cross-format parity assertions)
---

> ⚠️ **Memory Verification**
> This directive is 0 days old. Before applying:
> - [ ] Pattern still exists in current codebase
> - [ ] Rule is actively followed by team
> - [ ] No conflicting rules introduced
> 
> **Verification Date**: 2026-11-01
> **Verify Again After**: 2026-12-01 (30 days)

# Rule: Single Canonical Report Projection with Export Parity

## Core Principles

1. **One canonical projection**: Every user-facing and machine-readable export (HTML partial, Markdown document, JSON payload) MUST be rendered from a single projection data structure returned by one canonical builder (e.g., `build_report(run)`). Never allow templates or export routes to compute metrics or extract fields directly from raw domain entities.
2. **Terminal state overrides source metadata**: Terminal run states MUST override stage-level or fixture data. A rejected or failed run MUST NOT present a passing verdict in any output format.
3. **Automated parity tests**: Test suites MUST assert field-by-field equality across all exported formats for every lifecycle outcome (success, flagged/approved, flagged/rejected, failed).

## Checklist

- [ ] Single `build_report` / projection function produces presentation models.
- [ ] HTML templates receive only the projected report, not raw entity models.
- [ ] Export routes (`/export/markdown`, `/export/json`) call the same projection function.
- [ ] Terminal override logic tested across all terminal states.
- [ ] Parity test asserts matching scores, verdict, and review notes in HTML, Markdown, and JSON.

## Source

Contributed from: tech-pioneer
CDR: CDR-002
Date: 2026-11-01

## Evidence

- `gui/reports.py:1-125` (`build_report`, `to_markdown`, `to_json_dict`)
- `gui/tests/test_reports.py` (`test_export_downloads_match_report_and_run`)

## Verification Log

| Date | Verified By | Notes |
|------|-------------|-------|
| 2026-11-01 | tech-pioneer | Initial publication via /levelup.implement |
