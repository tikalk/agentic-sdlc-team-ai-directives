---
type: Example
title: Risk-Based Test Generation Prompt
description: Prompt template for generating targeted tests against developer-identified risks
resource: ./context_modules/examples/prompts/risk_based_test.md
tags: [prompt, testing, risk-based, test-generation]
generated: { by: agent:legacy, at: 2026-06-14T00:00:00Z }
id: example-examples-prompts-risk_based_test
cdr_ref: null
created: 2026-05-23
verified:
  - { by: process:team-repair, at: 2026-05-23T00:00:00Z }
status: stable
stale_after: 180d
---


Generate targeted tests for @file:{path/to/your/code.py}.
- The primary goal is to validate against this risk I've identified: {DEVELOPER_IDENTIFIED_RISK}.
- As a secondary goal, ensure all {Success Criteria} from our Mission Brief in issue {ISSUE-123} are met.
- My IDE is configured with our team's standards, so all tests must adhere to the patterns and style guides defined there.
