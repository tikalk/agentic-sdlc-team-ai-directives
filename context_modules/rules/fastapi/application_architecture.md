---
type: Rule
title: FastAPI Application Architecture Patterns
description: Five co-occurring architectural decisions for FastAPI apps — factory, deferred imports, shared templates, conditional static files, custom 404
tags: [fastapi, python, architecture, testing, circular-imports, jinja2]
timestamp: 2026-11-01T00:00:00Z
id: rule-fastapi-application-architecture
cdr_ref: CDR-001
created: 2026-11-01
modified: 2026-11-01
verified: 2026-11-01
age_days: 0
evidence:
  - path: pioneer_pipeline/web/app.py
  - path: pioneer_pipeline/web/routes/evaluate.py
  - path: pioneer_pipeline/web/templates/not_found.html
---

> ⚠️ **Memory Verification**
> This directive is 0 days old. Before applying:
> - [ ] Pattern still exists in current codebase
> - [ ] Rule is actively followed by team
> - [ ] No conflicting rules introduced
>
> **Verification Date**: 2026-11-01
> **Verify Again After**: 2026-12-01 (30 days)

# FastAPI Application Architecture Patterns

Every FastAPI project should follow five co-occurring architectural decisions that prevent startup errors, circular imports, and test isolation failures. These are non-obvious; omitting any one causes hard-to-diagnose failures.

## 1. Application Factory (`create_app()`)

Always expose a `create_app()` factory function. Keep a module-level `app = create_app()` for the ASGI server.

**Why**: Tests construct fresh isolated instances via `TestClient(create_app())`. A module-level bare `app = FastAPI()` means all tests share one instance and its state.

```python
def create_app() -> FastAPI:
    app = FastAPI(...)
    # ... setup ...
    return app

app = create_app()  # for uvicorn; tests call create_app() directly
```

## 2. Deferred Router Imports Inside `create_app()`

Import router modules *inside* the factory function body, not at module top-level.

**Why**: Route modules import `templates` from `app.py`. If `app.py` also imports routes at the top level, Python gets a circular import. Deferring the import until the factory body runs breaks the cycle.

```python
def create_app() -> FastAPI:
    from myapp.routes import users, items  # deferred — breaks circular import
    app.include_router(users.router)
    ...
```

## 3. Shared `Jinja2Templates` Singleton at Module Level

Define one `templates = Jinja2Templates(directory=...)` at module level in `app.py`, *outside* `create_app()`. Route modules import it from there.

**Why**: Centralises template directory configuration. Path resolved with `Path(__file__).parent` for portability.

```python
# app.py
TEMPLATES_DIR = Path(__file__).parent / "templates"
templates = Jinja2Templates(directory=str(TEMPLATES_DIR))

# routes/foo.py
from myapp.web.app import templates  # single shared instance
```

## 4. Conditional Static Files Mount

Guard the static files mount with an existence check.

**Why**: `StaticFiles(directory=...)` raises `RuntimeError` at startup if the directory doesn't exist (e.g., fresh clone, CI, pre-build). The guard makes the app runnable in minimal environments.

```python
static_dir = Path(__file__).parent / "static"
if static_dir.exists():
    app.mount("/static", StaticFiles(directory=str(static_dir)), name="static")
```

## 5. Custom 404 Handler for HTML Apps

Register a custom 404 exception handler that renders a Jinja2 template.

**Why**: Without it, FastAPI returns bare JSON `{"detail": "Not Found"}` which is unusable in HTML-first apps. The 404 page also inherits any global theming from the base template.

```python
@app.exception_handler(404)
async def not_found_handler(request: Request, exc: Exception) -> HTMLResponse:
    return templates.TemplateResponse(request, "not_found.html", status_code=404)
```

## Source

Contributed from: tech-pioneer
CDR: CDR-001
Date: 2026-11-01

## Evidence

- Cross-sub-system: pipeline-engine + web-api (2/3 sub-systems)
- `pioneer_pipeline/web/app.py` — implements all five patterns
- `pioneer_pipeline/web/routes/evaluate.py` — deferred import + factory usage
- Feature `002-tikal-ui-theme` FR-008: confirmed custom 404 handler propagates global CSS theme

## Verification Log

| Date | Verified By | Notes |
|------|-------------|-------|
| 2026-11-01 | tech-pioneer | Initial publication via /levelup-implement |
