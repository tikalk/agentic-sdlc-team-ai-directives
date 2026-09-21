---
type: Example
title: Mission Brief Creation Prompt
description: "Prompt template for creating a Mission Brief with goal, success criteria, and constraints"
resource: ./context_modules/examples/prompts/mission_brief.md
tags: [prompt, mission-brief, planning, specification]
generated: { by: agent:legacy, at: 2026-06-14T00:00:00Z }
id: example-examples-prompts-mission_brief
cdr_ref: null
created: 2026-05-23
verified:
  - { by: process:team-repair, at: 2026-05-23T00:00:00Z }
status: stable
stale_after: 180d
---


I need to create a new Mission Brief in our issue tracker for the objective: "{YOUR_OBJECTIVE}".
- Propose a one-sentence “{Goal}”, measurable “{Success Criteria}” and define the key “{Constraints}”.
- Using @web, research best practices for this task.
Help me choose the best components from our team's library for the Context Packet.
- Using `@team`, search `/context_modules/personas/` and suggest the most appropriate persona.
- Using `@team`, search `/context_modules/rules/` for relevant style guides and security rules.
- Using `@team`, search `/context_modules/examples/` for a high-quality example related to my objective.
   
