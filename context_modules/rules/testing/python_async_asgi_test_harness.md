---
type: Rule
title: Async ASGI Test Harness with Time Compression
description: Fast, reliable testing of async ASGI applications using in-memory transports, isolated app factories, fixture time compression, and monotonic deadline polling.
tags: [python, testing, asgi, async, pytest, httpx, time-compression]
timestamp: 2026-11-01T00:00:00Z
id: rule-python-async-asgi-test-harness
cdr_ref: CDR-005
created: 2026-11-01
modified: 2026-11-01
verified: 2026-11-01
age_days: 0
evidence:
  - gui/tests/conftest.py:27-39 (scaled fixture durations)
  - gui/tests/conftest.py:42-52 (app factory client + task cleanup)
  - gui/tests/conftest.py:68-81 (wait_for monotonic deadline polling)
---

> ⚠️ **Memory Verification**
> This directive is 0 days old. Before applying:
> - [ ] Pattern still exists in current codebase
> - [ ] Rule is actively followed by team
> - [ ] No conflicting rules introduced
> 
> **Verification Date**: 2026-11-01
> **Verify Again After**: 2026-12-01 (30 days)

# Rule: Async ASGI Test Harness with Time Compression

## Core Principles

1. **Factory-isolated applications**: Construct a fresh application instance per test via an application factory (`create_app()`). Never share mutable module-level application state between tests.
2. **In-memory ASGI transport**: Drive the application with `httpx.AsyncClient(transport=ASGITransport(app=app))`. Avoid opening real TCP network sockets for internal API / UI tests.
3. **Compress time in test fixtures, not runtime timers**: Keep production durations realistic for humans, but clone and scale down fixture durations (e.g. 0.02s per stage) inside test fixtures. The entire 70-test suite runs in ~4s without modifying production logic.
4. **Monotonic predicate polling**: Never use `await asyncio.sleep(fixed_duration)` to wait for state changes. Poll a predicate with `asyncio.sleep(0.01)` against a `time.monotonic()` deadline, raising informative timeout errors showing actual state on failure.
5. **Guaranteed task cleanup**: Ensure background tasks and runners are cancelled in fixture `finally` blocks to avoid task leakage across test boundaries.

Companion working code example: `context_modules/examples/python/async_asgi_test_harness.md`.

## Source

Contributed from: tech-pioneer
CDR: CDR-005
Date: 2026-11-01

## Evidence

- `gui/tests/conftest.py:27-108`
- `gui/tests/test_runner.py` (timing-tested runner suite running in <4s)

## Verification Log

| Date | Verified By | Notes |
|------|-------------|-------|
| 2026-11-01 | tech-pioneer | Initial publication via /levelup.implement |
