---
type: Example
title: Async ASGI Test Harness (FastAPI + In-Memory Transport + Scaled Fixtures)
description: Production-tested conftest harness for async FastAPI/Starlette testing with fixture time compression, client factory, monotonic wait polling, and clean teardown.
tags: [python, testing, example, asgi, httpx, pytest, fastapi]
timestamp: 2026-11-01T00:00:00Z
id: example-python-async-asgi-test-harness
cdr_ref: CDR-008
created: 2026-11-01
modified: 2026-11-01
verified: 2026-11-01
age_days: 0
evidence:
  - gui/tests/conftest.py:27-108
  - gui/tests/test_runner.py (70 tests in 3.91s)
---

> ⚠️ **Memory Verification**
> This example is 0 days old. Verify before use:
> - [ ] Code still compiles/runs
> - [ ] API signatures unchanged
> - [ ] Best practices still current

# Example: Async ASGI Test Harness

Working harness pattern from `tech-pioneer` for testing async ASGI applications with background tasks, streaming, and state machines without network sockets or sleep-based delays.

Pairs with rule `context_modules/rules/testing/python_async_asgi_test_harness.md`.

```python
"""Async ASGI test harness with time-compressed fixtures and deadline polling."""

import asyncio
import time
from typing import AsyncIterator, Callable, TypeVar

import httpx
import pytest
from httpx import ASGITransport

from gui.app import create_app
from gui.fixtures import ScenarioFixture, load_all
import gui.runner as runner

T = TypeVar("T")

@pytest.fixture(scope="session")
def anyio_backend() -> str:
    return "asyncio"

@pytest.fixture
def scaled_fixtures() -> dict[str, ScenarioFixture]:
    """Clone production fixtures with milliseconds-scale durations for fast testing."""
    base = load_all()
    scaled: dict[str, ScenarioFixture] = {}
    for name, fix in base.items():
        scaled_stages = [
            stage.model_copy(update={"duration_s": 0.02})
            for stage in fix.stages
        ]
        scaled[name] = fix.model_copy(update={"stages": scaled_stages})
    return scaled

@pytest.fixture
async def make_client(scaled_fixtures: dict[str, ScenarioFixture]) -> AsyncIterator[Callable[..., httpx.AsyncClient]]:
    """Factory yielding isolated ASGI client instances with guaranteed task teardown."""
    clients: list[httpx.AsyncClient] = []

    def _factory(**kwargs) -> httpx.AsyncClient:
        app = create_app(fixtures=scaled_fixtures, **kwargs)
        client = httpx.AsyncClient(
            transport=ASGITransport(app=app),
            base_url="http://testserver",
        )
        clients.append(client)
        return client

    try:
        yield _factory
    finally:
        for c in clients:
            await c.aclose()
        # Clean up background tasks to prevent leak between tests
        runner.cancel_all()

async def wait_for(
    predicate: Callable[[], T],
    timeout: float = 2.0,
    interval: float = 0.02,
    error_msg: str = "Condition not met in time",
) -> T:
    """Poll predicate against monotonic deadline, failing with diagnostic on timeout."""
    deadline = time.monotonic() + timeout
    while time.monotonic() < deadline:
        res = predicate()
        if res:
            return res
        await asyncio.sleep(interval)
    raise TimeoutError(f"{error_msg} (timed out after {timeout}s)")
```

## Source

CDR: CDR-008
Date: 2026-11-01
