---
type: Rule
title: Server-Sent Events Contract for Long-Running Operations
description: Standard contract for live progress streaming over SSE with HTML fragments, multi-line prefixing, periodic keep-alives, and terminal reconnect snapshots.
tags: [python, sse, streaming, htmx, async, fastapi]
timestamp: 2026-11-01T00:00:00Z
id: rule-python-sse-live-progress
cdr_ref: CDR-004
created: 2026-11-01
modified: 2026-11-01
verified: 2026-11-01
age_days: 0
evidence:
  - gui/app.py:35-39 (_sse_frame multi-line prefixing)
  - gui/app.py:139-168 (queue polling, 15s keep-alive, terminal close)
  - gui/app.py:249-258 (reconnect snapshot event)
  - gui/templates/run.html:14-35 (htmx sse-connect and sse-swap wiring)
---

> ⚠️ **Memory Verification**
> This directive is 0 days old. Before applying:
> - [ ] Pattern still exists in current codebase
> - [ ] Rule is actively followed by team
> - [ ] No conflicting rules introduced
> 
> **Verification Date**: 2026-11-01
> **Verify Again After**: 2026-12-01 (30 days)

# Rule: Server-Sent Events Contract for Long-Running Operations

## Core Principles

1. **One dedicated stream endpoint**: Provide a clean streaming endpoint per operation (e.g. `GET /runs/{id}/events`), setting `media_type="text/event-stream"` and `Cache-Control: no-cache`. Add `X-Accel-Buffering: no` to disable proxy buffering.
2. **Every frame complete & prefixed**: Every event frame carries a complete HTML fragment or typed message targeting a specific DOM element: `event: <name>
data: <line1>
data: <line2>

`. Every line in multi-line fragments MUST be prefixed with `data: `.
3. **Periodic keep-alive comments**: Emit a `: keep-alive` comment at fixed intervals (≤15s) during idle periods to prevent reverse-proxy timeout disconnects.
4. **Terminal reconnect snapshot**: If a client connects after an operation has completed, emit exactly one closing snapshot frame and terminate the stream immediately. Never hang on keep-alives for finished operations.
5. **Stream termination**: Close the async generator once the terminal event (`done`, `review`, `failed`) is dispatched.

## Source

Contributed from: tech-pioneer
CDR: CDR-004
Date: 2026-11-01

## Evidence

- `gui/app.py:35-39, 139-168, 249-258`
- `gui/templates/run.html:14-35`
- `gui/tests/test_routes.py:180-240`

## Verification Log

| Date | Verified By | Notes |
|------|-------------|-------|
| 2026-11-01 | tech-pioneer | Initial publication via /levelup.implement |
