---
type: Rule
title: Zero-Cost Preflight Credential Verification
description: Fast, zero-credit preflight checks validating external credentials against usage/rate-limit endpoints before invoking pipelines, with non-zero exit codes.
tags: [devops, credentials, preflight, scripts, verification, api]
timestamp: 2026-11-01T00:00:00Z
id: rule-python-zero-cost-credential-check
cdr_ref: CDR-007
created: 2026-11-01
modified: 2026-11-01
verified: 2026-11-01
age_days: 0
evidence:
  - scripts/verify_setup.py:75-94 (Tavily zero-credit /usage check)
  - scripts/verify_setup.py:97-114 (GitHub /rate_limit quota check)
  - scripts/verify_setup.py:117-129 (single minimal smoke LLM call)
  - scripts/verify_setup.py:132-151 (aggregated exit code)
---

> ⚠️ **Memory Verification**
> This directive is 0 days old. Before applying:
> - [ ] Pattern still exists in current codebase
> - [ ] Rule is actively followed by team
> - [ ] No conflicting rules introduced
> 
> **Verification Date**: 2026-11-01
> **Verify Again After**: 2026-12-01 (30 days)

# Rule: Zero-Cost Preflight Credential Verification

## Core Principles

1. **Preflight before running expensive workflows**: Provide a single verification command (`make verify`) that validates every external credential required by the project before developers or CI start full pipeline runs.
2. **Zero-credit validation endpoints**: Prefer endpoints that validate credentials without consuming paid quota or search credits:
   - Tavily: `GET https://api.tavily.com/usage`
   - GitHub: `GET https://api.github.com/rate_limit`
   - Cloud providers: whoami / quota endpoints
3. **Single cheap end-of-chain smoke call**: For providers without zero-credit ping endpoints (LLM providers), perform exactly one minimal smoke call (e.g. `llm.invoke("Say 'ok'.")`) at the end of the check sequence.
4. **Never leak secrets in output**: Print only ✅/❌ status and quota numbers; never display raw token values or API keys in logs.
5. **Non-zero exit on any failure**: Aggregated exit code MUST be non-zero if any single check fails, enabling safe use as a CI / pre-commit guard.

## Source

Contributed from: tech-pioneer
CDR: CDR-007
Date: 2026-11-01

## Evidence

- `scripts/verify_setup.py:75-151`
- `Makefile:20` (`verify: uv run python scripts/verify_setup.py`)

## Verification Log

| Date | Verified By | Notes |
|------|-------------|-------|
| 2026-11-01 | tech-pioneer | Initial publication via /levelup.implement |
