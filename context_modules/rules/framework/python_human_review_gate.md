---
type: Rule
title: Idempotent Human Review Gate
description: Pattern for state-guarded human-in-the-loop review gates with atomic first-write-wins semantics, one-shot resume events, and strict HTTP status mapping.
tags: [python, human-in-the-loop, review, state-machine, idempotency, async]
timestamp: 2026-11-01T00:00:00Z
id: rule-python-human-review-gate
cdr_ref: CDR-003
created: 2026-11-01
modified: 2026-11-01
verified: 2026-11-01
age_days: 0
evidence:
  - gui/runner.py:86-110 (pause on review_signal, resume on decision)
  - gui/runner.py:121-134 (record_review atomic first-write-wins)
  - gui/app.py:170-212 (HTTP review status code contract)
  - gui/tests/test_runner.py:109-124 (idempotency unit tests)
---

> ⚠️ **Memory Verification**
> This directive is 0 days old. Before applying:
> - [ ] Pattern still exists in current codebase
> - [ ] Rule is actively followed by team
> - [ ] No conflicting rules introduced
> 
> **Verification Date**: 2026-11-01
> **Verify Again After**: 2026-12-01 (30 days)

# Rule: Idempotent Human Review Gate

## Core Principles

1. **Explicit awaiting state**: Model human-in-the-loop gates with an explicit `AWAITING_*` state and a one-shot async pause mechanism (e.g. `asyncio.Event`). The background task awaits the signal; it never busy-spins.
2. **First-write-wins**: Recording the review decision is atomic. The first valid submission wins; duplicate submissions return the existing state and MUST NOT overwrite the recorded decision.
3. **HTTP contract**:
   - `303 See Other`: New valid decision recorded; redirect to status page.
   - `200 OK`: Duplicate submission received after decision recorded (idempotent no-op).
   - `409 Conflict`: Review submitted when the workflow is not awaiting review.
   - `422 Unprocessable`: Validation failure (empty decision, notes too long).
4. **No auto-approval timeouts**: Gated workflows MUST NOT auto-approve on timeout (reinforces Constitution Principle 1: Human Oversight Mandatory).
5. **Fail loud on unbacked signal**: If the resume signal triggers without a recorded decision, the workflow MUST terminate immediately with an error.

## Source

Contributed from: tech-pioneer
CDR: CDR-003
Date: 2026-11-01

## Evidence

- `gui/runner.py:86-110, 121-134`
- `gui/app.py:170-212`
- `gui/tests/test_runner.py:109-124`

## Verification Log

| Date | Verified By | Notes |
|------|-------------|-------|
| 2026-11-01 | tech-pioneer | Initial publication via /levelup.implement |
