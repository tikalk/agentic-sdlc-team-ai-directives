---
type: Example
title: LevelUp Contribution Prompt
description: Prompt template for extracting successful workflow patterns and contributing them to team-ai-directives
tags: [prompt, levelup, contribution, team-ai-directives]
timestamp: 2026-06-14T00:00:00Z
id: example-examples-prompts-leveling_up
cdr_ref: null
created: 2026-05-23
modified: 2026-06-14
verified: 2026-05-23
age_days: 22
evidence: []
---

The work for issue {ISSUE-123} is complete, and this chat history represents a successful workflow. Let's formalize this success for the team.
1. Analyze and Extract: Review our entire interaction and extract the single most valuable new rule or code exemplar that made this workflow effective.
2. Prepare a Pull Request: Draft a complete Pull Request to our team-ai-directives repository that adds this new asset. The draft must include:
	A clear PR Title.
	A PR Description explaining what the new asset is and why it's valuable to the team,
referencing {ISSUE-123} for context.
	The complete File Content for the new rule or exemplar, including a title, description, and code examples.
3. Update the Issue Tracker: Independently, draft a concise comment to post directly to {ISSUE-123}. This comment should be a Trace Summary of our work on the original task, including:
	The problem that was solved.
	The key decisions made.
	The final accepted code solution.
Present the full Pull Request draft and the Issue Tracker Comment in separate, clearly marked code blocks for my final review before you proceed.