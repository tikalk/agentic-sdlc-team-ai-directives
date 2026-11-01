---
type: Rule
title: FastAPI HTTP Convention Patterns
description: Five non-obvious HTTP conventions for FastAPI handlers — correct vs common-but-wrong alternatives for redirects, response models, status codes, and form validation
tags: [fastapi, python, http, forms, state-machine, redirect, response-model, status-codes]
timestamp: 2026-11-01T00:00:00Z
id: rule-fastapi-http-conventions
cdr_ref: CDR-004
created: 2026-11-01
modified: 2026-11-01
verified: 2026-11-01
age_days: 0
evidence:
  - path: pioneer_pipeline/web/routes/evaluate.py
  - path: pioneer_pipeline/web/routes/run.py
  - path: pioneer_pipeline/web/routes/hitl.py
---

> ⚠️ **Memory Verification**
> This directive is 0 days old. Before applying:
> - [ ] Pattern still exists in current codebase
> - [ ] Rule is actively followed by team
> - [ ] No conflicting rules introduced
>
> **Verification Date**: 2026-11-01
> **Verify Again After**: 2026-12-01 (30 days)

# FastAPI HTTP Convention Patterns

## 1. POST-Redirect-GET with HTTP 303 (not 302)

```python
return RedirectResponse(f"/run/{run.id}", status_code=303)
```

**Why 303 not 302**: HTTP 303 guarantees the browser issues a GET for the redirect target regardless of the original method. HTTP 302 is ambiguous — some browsers re-POST. All form submission handlers MUST use 303.

## 2. `response_model=None` for Union Return Types

```python
@router.post("/evaluate", response_model=None)
async def create_evaluation(...) -> RedirectResponse | HTMLResponse:
```

**Why**: FastAPI infers a response model from the return annotation and validates/serialises the response through it. For `Response` subclasses (redirects, HTML, streaming), this strips headers and breaks non-JSON responses. Set `response_model=None` on any handler that returns more than one type or a `Response` subclass.

## 3. HTTP Status Code for State Violations

| Situation | Status | Rationale |
|-----------|--------|-----------|
| Resource not found | 404 | Resource doesn't exist |
| Operation not valid in current state | **409 Conflict** | Resource exists but state machine rejects the operation |
| Invalid input data | 422 Unprocessable Entity | Semantically invalid even if structurally correct |

```python
# POST when run is not AWAITING_REVIEW
raise HTTPException(status_code=409, detail="Review gate is not active")
```

## 4. State-Guard Redirect on GET (not 404)

When a GET route is only meaningful in a specific resource state, redirect to the canonical resource URL rather than returning 404 or 400:

```python
@router.get("/run/{run_id}/hitl", response_model=None)
async def hitl_page(run_id: str) -> ...:
    run = state_module.store.get_run(run_id)
    if run.status != RunStatus.AWAITING_REVIEW:
        return RedirectResponse(f"/run/{run_id}", status_code=303)
    ...
```

**Why**: The resource exists and the URL is valid — the user just arrived at the wrong time. A 404 would be misleading. Redirecting to the canonical view keeps the user in context.

## 5. Form Validation: 422 + Template Re-render (not redirect)

```python
if not topic.strip():
    return templates.TemplateResponse(
        request, "evaluate.html",
        context={"error": "Topic is required"},
        status_code=422
    )
```

**Why 422 not 302**: Re-renders the form with the error and keeps the user's input visible. Returns 422 so test assertions on failure don't need to follow a redirect. Do NOT redirect on validation failure — the user loses their input.

## Source

Contributed from: tech-pioneer
CDR: CDR-004
Date: 2026-11-01

## Evidence

- Cross-sub-system: pipeline-engine + web-api (2/3 sub-systems)
- `pioneer_pipeline/web/routes/evaluate.py` — 303 redirect, `response_model=None`, 422 form validation
- `pioneer_pipeline/web/routes/hitl.py` — 409 state violation, state-guard redirect

## Verification Log

| Date | Verified By | Notes |
|------|-------------|-------|
| 2026-11-01 | tech-pioneer | Initial publication via /levelup-implement |
