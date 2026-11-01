---
type: Rule
title: Python Module-Level Import Pattern for Monkeypatching
description: Use module attribute access (not from-import) for any singleton or function that tests need to replace via monkeypatch.setattr
tags: [python, testing, monkeypatch, pytest, singleton, imports, testability]
timestamp: 2026-11-01T00:00:00Z
id: rule-python-module-import-for-testability
cdr_ref: CDR-002
created: 2026-11-01
modified: 2026-11-01
verified: 2026-11-01
age_days: 0
evidence:
  - path: pioneer_pipeline/web/app.py
  - path: pioneer_pipeline/web/routes/evaluate.py
  - path: pioneer_pipeline/web/state.py
  - path: tests/conftest.py
---

> ⚠️ **Memory Verification**
> This directive is 0 days old. Before applying:
> - [ ] Pattern still exists in current codebase
> - [ ] Rule is actively followed by team
> - [ ] No conflicting rules introduced
>
> **Verification Date**: 2026-11-01
> **Verify Again After**: 2026-12-01 (30 days)

# Python Module-Level Import Pattern for Monkeypatching

## Rule

Any singleton, function, or object that tests need to replace via `monkeypatch.setattr` MUST be imported as a module reference (`import module as m; m.thing`) not as a direct name binding (`from module import thing`).

## Why

`from module import thing` creates a local name binding in the importing module. Patching `monkeypatch.setattr(source_module, 'thing', replacement)` updates the source module's attribute but does NOT update the local binding. The calling code still calls the original.

## Pattern

```python
# ❌ Wrong — local binding is not affected by monkeypatch
from myapp.state import store

def get_runs():
    return store.runs  # store is a frozen local binding

# ✅ Correct — attribute access resolved at call time
from myapp import state as state_module

def get_runs():
    return state_module.store.runs  # resolved from module dict each call
```

## Test patch

```python
# Works correctly with the module-attribute pattern
monkeypatch.setattr(state_module, 'store', FreshRunStore())
```

## Applies to

- Module-level singletons (database connections, in-memory stores, caches)
- Functions injected as dependencies (background tasks, pipeline runners)
- Any object whose replacement must be visible to already-imported modules

## Corollary: Patch at the Call Site

When patching a function that is called from another module, always patch it on the *calling* module, not the *definition* module:

```python
# route_module imports run_pipeline from runner
# ❌ Patching runner.run_pipeline has no effect on already-imported reference
monkeypatch.setattr(runner, 'run_pipeline', noop)

# ✅ Patch on the module that calls it
import myapp.routes.evaluate as evaluate_module
monkeypatch.setattr(evaluate_module, 'run_pipeline', noop)
```

## Source

Contributed from: tech-pioneer
CDR: CDR-002
Date: 2026-11-01

## Evidence

- Cross-sub-system score: 1.0 (found in all 3 sub-systems — pipeline-engine, web-api, tests)
- `pioneer_pipeline/web/state.py` — module-level `store` singleton accessed via module attribute
- `pioneer_pipeline/web/routes/evaluate.py` — imports `run_pipeline` via module reference
- `tests/conftest.py` — `autouse` store reset patches via `state_module.store`

## Verification Log

| Date | Verified By | Notes |
|------|-------------|-------|
| 2026-11-01 | tech-pioneer | Initial publication via /levelup-implement |
