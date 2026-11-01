---
type: Rule
title: FastAPI TestClient Patterns — False Confidence Traps
description: Four guards every FastAPI route test must apply to avoid silently passing tests that hide real bugs
tags: [fastapi, pytest, testclient, false-confidence, testing, async, python]
timestamp: 2026-11-01T00:00:00Z
id: rule-testing-python-fastapi-testclient-patterns
cdr_ref: CDR-003
created: 2026-11-01
modified: 2026-11-01
verified: 2026-11-01
age_days: 0
evidence:
  - path: tests/conftest.py
  - path: tests/test_routes.py
---

> ⚠️ **Memory Verification**
> This directive is 0 days old. Before applying:
> - [ ] Pattern still exists in current codebase
> - [ ] Rule is actively followed by team
> - [ ] No conflicting rules introduced
>
> **Verification Date**: 2026-11-01
> **Verify Again After**: 2026-12-01 (30 days)

# FastAPI TestClient Patterns — False Confidence Traps

Extends @rule:testing/python/pytest_patterns.md with FastAPI-specific guards.

Apply all four guards in every FastAPI route test file.

## 1. Always set `raise_server_exceptions=True`

```python
client = TestClient(create_app(), raise_server_exceptions=True)
```

**Without this**: unhandled server-side exceptions become 500 responses. Tests checking for non-5xx status codes pass silently while hiding real bugs. With it, exceptions propagate as test errors.

## 2. Always pass `follow_redirects=False` when asserting 3xx

```python
response = client.post("/evaluate", data={...}, follow_redirects=False)
assert response.status_code == 303
assert response.headers["location"] == "/run/abc123"
```

**Without this**: TestClient follows the redirect, returns the final 200. The 303 and Location header are never asserted. A missing or wrong redirect is invisible.

## 3. Mock background tasks at the route module level

```python
@pytest.fixture(autouse=True)
def mock_pipeline(monkeypatch):
    import myapp.routes.evaluate as evaluate_module
    async def _noop(run_id: str) -> None: pass
    monkeypatch.setattr(evaluate_module, "run_pipeline", _noop)
```

**Why**: Starlette's `TestClient` executes `BackgroundTasks` *synchronously* inline with the response. A real pipeline that sleeps for seconds blocks the test event loop indefinitely. Route tests should test HTTP behavior, not pipeline execution.

**Why at the route module level**: The route has already imported `run_pipeline` at import time. Patching the runner module has no effect on the already-imported reference. (See @rule:python/module_import_for_testability.md.)

## 4. Per-test state reset via `autouse=True` fixture

```python
@pytest.fixture(autouse=True)
def reset_store(monkeypatch):
    import myapp.web.state as state_module
    monkeypatch.setattr(state_module, "store", RunStore())
    yield
    monkeypatch.setattr(state_module, "store", RunStore())
```

**Why**: Module-level singletons accumulate state across tests. `autouse=True` ensures every test gets a clean store without authors having to remember to include the fixture. The yield teardown handles cleanup even if the test raises.

## Source

Contributed from: tech-pioneer
CDR: CDR-003
Date: 2026-11-01

## Evidence

- Cross-sub-system: tests + pipeline-engine (2/3 sub-systems)
- `tests/conftest.py` — all four guards applied
- Extends existing `pytest_patterns.md` (CDR-2026-027) into FastAPI-specific territory

## Verification Log

| Date | Verified By | Notes |
|------|-------------|-------|
| 2026-11-01 | tech-pioneer | Initial publication via /levelup-implement |
