---
type: Rule
title: Code Review Best Practices
description: Team-wide and role-specific (author/reviewer) code review practices covering process, standards, and the full pre/during/post-review lifecycle
tags: [process, code-review, collaboration, quality, checklist]
timestamp: "2026-08-06T00:00:00Z"
id: rule-rules-process-code_review_best_practices
cdr_ref: CDR-2026-032
created: 2026-08-05
modified: 2026-08-05
verified: 2026-08-06
age_days: 0
evidence: []
---


# Rule: Code Review Best Practices

Code review practices organized by audience and lifecycle stage. Team-wide practices set the process; author and reviewer sections walk through the review lifecycle from development through merge.

## Team-Wide Practices

- [ ] Document and standardize the code review process
- [ ] Ensure that the purpose of code reviews is clear to everyone
- [ ] Ensure that "Definition of Done" is documented and clear to everyone
- [ ] Encourage team members to participate in code reviews
- [ ] Define a process for conflict resolution in code reviews
- [ ] Have a definitive style guide for style preferences
- [ ] Use automation to speed up code reviews (linting, sniffing, etc.)
- [ ] Set clear expectations for code review turnaround times
- [ ] Provide adequate time for code reviews and ensure that it is a priority
- [ ] Use code reviews as an opportunity for knowledge sharing and learning
- [ ] Encourage reviewing code in unknown areas for cross-functional knowledge
- [ ] Constantly monitor and improve the code review process
- [ ] Provide recognition and rewards for those with a track record of quality feedback
- [ ] Encourage communication/collaboration; avoid treating code reviews as a one-way process
- [ ] Hold regular code review sessions to discuss broader trends or issues that arise during the review process
- [ ] Encourage authors to seek feedback during development before submitting a formal code review

**See also:** `@rule:style-guides/file_organization.md` for the file/function-level standards a style guide should codify.

## Development (Author)

- [ ] Follow coding standards and any other team guidelines
- [ ] Stay consistent with overall project design and architecture
- [ ] Write a failing test if the change is for a bug fix
- [ ] Break down complex tasks into smaller, easily manageable PRs
- [ ] Consider the impact of the change on other parts of the system
- [ ] Take notes on any questions or concerns about the change to discuss during review
- [ ] Write automated tests
- [ ] Write documentation for the feature or changes if required
- [ ] Update any documentation that may have been made obsolete through the changes

## Post-Development (Author)

- [ ] Review your code before submitting for review
- [ ] Ensure changes are complete and ready for review (including tests and documentation)
- [ ] Verify that code changes have been properly tested in a development environment
- [ ] Double-check that code adheres to project coding standards and best practices
- [ ] Identify potential performance, security, or scalability concerns and note them for discussion
- [ ] Ensure title, description, screenshots, relevant links, configuration changes, etc., are added to the PR
- [ ] Approach the review process with an open mind and willingness to learn/collaborate

## Before Review (Reviewer)

- [ ] Understand the requirements and context in which the change was made
- [ ] Prepare a list of items that should have been covered based on requirements
- [ ] Ensure you understand the codebase and its architecture
- [ ] Review documentation or design specifications related to the change
- [ ] Make a list of potential risks or issues that could arise with the change

## During Review (Reviewer)

- [ ] Focus feedback on code design, architecture, performance, security, and edge cases
- [ ] Verify test coverage and quality (unit, integration, and failure cases)
- [ ] Keep tone professional, empathetic, and constructive — comment on the code, not the person
- [ ] Explicitly distinguish between critical blocking issues, minor suggestions, and optional "nitpicks"
- [ ] Praise well-written code, clever solutions, or thorough documentation
- [ ] Avoid scope creep; keep the review limited to the actual scope of the PR
- [ ] Explain the why behind suggested changes rather than just giving mandates

## After Review (Author)

- [ ] Address all feedback, questions, and requested changes systematically
- [ ] Respond to every comment to explain what was changed or why a suggestion was not implemented
- [ ] Push updates in logical commits or request re-review once all requested changes are pushed
- [ ] Maintain an open mind — treat constructive criticism as a collaboration opportunity rather than a personal critique
- [ ] Ask for clarification immediately if a reviewer's feedback is unclear or ambiguous

## After Review & Merging (Reviewer & Author)

- [ ] Re-review resolved threads and updated code promptly
- [ ] Approve the pull request once all required changes and discussions are settled
- [ ] Confirm that all CI/CD checks, automated testing suites, and linting pass
- [ ] Merge the PR following team conventions (e.g., squash-and-merge vs. rebase)
- [ ] Delete feature branches post-merge to maintain clean repository hygiene
- [ ] Monitor deployment in staging or production to verify the changes work as intended

## References

- `@rule:style-guides/file_organization.md` - file/function-level standards referenced during review
- `@rule:security/pre_commit_checklist.md` - security checklist to verify before/during review
- `@rule:security/api_security_checklist.md` - API-specific security checklist for API changes
- `@rule:devops/github_actions.md` - CI/CD automation that gates merges (linting, tests, checks)
