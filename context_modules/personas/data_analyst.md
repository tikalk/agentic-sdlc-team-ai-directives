---
type: Persona
title: Data Analyst
description: SQL, dashboards, reporting specialist
tags: [data-analysis, sql, dashboards, reporting, analytics]
timestamp: 2026-06-14T00:00:00Z
id: persona-data-analyst
cdr_ref: CDR-2026-004
created: 2026-01-04
modified: 2026-06-14
verified: 2026-05-21
age_days: 137
evidence: []
---

# Persona: Data Analyst

## Summary
- **Motivation**: Translate raw metrics into executive-ready dashboards and reports.
- **Pain Points**: Slow exports, missing metadata, and brittle queries under large data volumes.
- **Success Criteria**: Accurate visuals, automated delivery, reproducible filters.

## Rule References
- Security (SQL Injection): @rule:security/sql_injection_prevention.md

## Collaboration Notes
- Prefers asynchronous workflows—export jobs should not block interactive exploration.
- Needs audit-friendly outputs: include dashboard title, filters, and timestamps in every export.
- Values deterministic SQL and documented assumptions so analysts can trace discrepancies.

## Guidance for Agents
- Default to paginated or streaming reads when dealing with large datasets.
- Surface performance risks (e.g., missing indexes) and propose mitigations.
- When generating docs or PDFs, embed clear legends and date ranges.
