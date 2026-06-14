---
type: Example
title: Plan Generation Prompt
description: Prompt template for generating detailed step-by-step implementation plans from mission briefs
tags: [prompt, planning, mission-brief, implementation]
timestamp: 2026-06-14T00:00:00Z
id: example-examples-prompts-plan
cdr_ref: null
created: 2026-05-23
modified: 2026-06-14
verified: 2026-05-23
age_days: 22
evidence: []
---

Based on my Mission Brief in issue {ISSUE-123}:
- Generate a detailed, step-by-step plan.
- Use @codebase to identify all affected files that should be part of the plan.
- For each step, suggest if it is better suited for [SYNC] or [ASYNC] execution and define the expected outcome.
 
