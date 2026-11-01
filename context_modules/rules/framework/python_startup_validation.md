---
type: Rule
title: Python Static Configuration and Startup Validation
description: Validate static configuration, fixtures, and credentials at startup with dedicated domain exceptions and fail-loud semantics before serving traffic.
tags: [python, validation, startup, configuration, error-handling, fail-fast]
timestamp: 2026-11-01T00:00:00Z
id: rule-python-startup-validation
cdr_ref: CDR-001
created: 2026-11-01
modified: 2026-11-01
verified: 2026-11-01
age_days: 0
evidence:
  - gui/fixtures.py:76-194 (explicit schema + cross-field validation)
  - gui/app.py:42-47 (load_all called inside create_app)
  - pioneer_pipeline/llm.py:16-22 (missing API key assertion)
  - scripts/verify_setup.py:132-151 (preflight exit codes)
---

> ⚠️ **Memory Verification**
> This directive is 0 days old. Before applying:
> - [ ] Pattern still exists in current codebase
> - [ ] Rule is actively followed by team
> - [ ] No conflicting rules introduced
> 
> **Verification Date**: 2026-11-01
> **Verify Again After**: 2026-12-01 (30 days)

# Rule: Python Static Configuration and Startup Validation

## Core Principles

1. **Validate at startup, never on first use**: Static configuration, schema files, and bundled fixtures MUST be validated during application factory / startup phase, never lazily on the first user request.
2. **Total, explicit validation**: Validate every field explicitly with type assertions, positive ranges, and cross-field invariants (e.g. failure blocks required only when scenario is `failure`).
3. **Dedicated domain exceptions**: Startup failures MUST raise a dedicated domain exception (e.g., `FixtureSchemaError`, `ConfigurationError`) carrying the file path, field name, and actionable remediation text.
4. **No silent recovery**: Corrupted or missing configuration MUST prevent the server or pipeline from starting up completely.

## Checklist

- [ ] Configuration / fixtures loaded and validated in application factory or `lifespan` handler.
- [ ] Schema asserts types strictly (reject bools masquerading as ints, ensure positive durations).
- [ ] Cross-field dependencies explicitly checked before serving requests.
- [ ] Unit tests verify startup failure on missing files, malformed JSON, and invalid schema invariants.

## Source

Contributed from: tech-pioneer
CDR: CDR-001
Date: 2026-11-01

## Evidence

- `gui/fixtures.py:76-194` (`parse_scenario`, `load_all`)
- `gui/app.py:42-47` (app factory startup validation)
- `gui/tests/test_fixtures.py` (20+ negative fixture cases)

## Verification Log

| Date | Verified By | Notes |
|------|-------------|-------|
| 2026-11-01 | tech-pioneer | Initial publication via /levelup.implement |
