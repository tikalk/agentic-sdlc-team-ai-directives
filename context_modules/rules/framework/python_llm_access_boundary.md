---
type: Rule
title: Single LLM Access Boundary (Tiers, Credentials, Tracing)
description: Centralize LLM access in a single factory choke point requesting abstract tiers, forbidding vendor SDK imports elsewhere, asserting keys early, and attaching tracing.
tags: [python, llm, architecture, credentials, tracing, observability]
timestamp: 2026-11-01T00:00:00Z
id: rule-python-llm-access-boundary
cdr_ref: CDR-006
created: 2026-11-01
modified: 2026-11-01
verified: 2026-11-01
age_days: 0
evidence:
  - pioneer_pipeline/config.py:12-22 (ModelTier abstract mapping)
  - pioneer_pipeline/llm.py:1-28 (sole client construction factory)
  - pioneer_pipeline/observability.py:1-24 (centralized tracing callbacks)
  - specs/002-mocked-eval-gui/tasks.md:T035 (boundary grep audit)
---

> ⚠️ **Memory Verification**
> This directive is 0 days old. Before applying:
> - [ ] Pattern still exists in current codebase
> - [ ] Rule is actively followed by team
> - [ ] No conflicting rules introduced
> 
> **Verification Date**: 2026-11-01
> **Verify Again After**: 2026-12-01 (30 days)

# Rule: Single LLM Access Boundary (Tiers, Credentials, Tracing)

## Core Principles

1. **Request abstract tiers, never hardcoded models**: Callers request a semantic tier (`cheap`, `balanced`, `premium`). Mapping to concrete models lives in configuration and environment variables, allowing seamless provider switches without touching application logic.
2. **Single factory choke point**: All LLM client construction MUST happen inside one dedicated module (`llm.py`). Importing raw vendor SDKs (OpenAI, Anthropic, LiteLLM) outside this module is strictly forbidden.
3. **Fail loud with actionable remediation**: Assert required API keys and credentials immediately upon client factory invocation. Raise clear configuration errors stating the missing environment variable name and where to get credentials.
4. **Centralized observability**: Wire tracing and telemetry callbacks (e.g. LangFuse, OpenTelemetry) at factory construction time. Callers do not manage telemetry sessions manually.

## Checklist

- [ ] Model strings abstracted behind an Enum / Tier mapping.
- [ ] No direct imports of LLM client SDKs in feature code.
- [ ] CI / pre-commit grep audit confirms no vendor SDK imports outside boundary module.
- [ ] Missing API key produces immediate loud exception with remediation guidance.

## Source

Contributed from: tech-pioneer
CDR: CDR-006
Date: 2026-11-01

## Evidence

- `pioneer_pipeline/config.py:12-22`
- `pioneer_pipeline/llm.py:1-28`
- `pioneer_pipeline/observability.py:1-24`

## Verification Log

| Date | Verified By | Notes |
|------|-------------|-------|
| 2026-11-01 | tech-pioneer | Initial publication via /levelup.implement |
