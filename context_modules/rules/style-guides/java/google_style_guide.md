---
type: Rule
title: Java Google Style Guide
description: Google Java Style Guide conventions
resource: ./context_modules/rules/style-guides/java/google_style_guide.md
tags: [java, style-guide, google-style, formatting]
generated: { by: agent:legacy, at: 2026-06-14T00:00:00Z }
id: rule-rules-style-guides-java-google_style_guide
cdr_ref: null
created: 2026-05-23
verified:
  - { by: process:team-repair, at: 2026-05-23T00:00:00Z }
status: stable
stale_after: 180d
---


# Rule: Java Style Guide

## Checklist
- Follow Google Java Style Guide conventions (4-space indents, 100 char line limit, camelCase for methods/variables, PascalCase for classes).
- Use JavaDoc comments for all public classes, methods, and fields describing purpose, parameters, return values, and exceptions.
- See @rule:style-guides/java/null_safety_and_optional.md for null safety and Optional usage guidelines.
- Use meaningful variable and method names that clearly express intent.
- Keep methods focused and small (ideally under 20 lines, max 50 lines).
- Use `final` for immutable variables and method parameters when appropriate.
- Run `google-java-format` or `checkstyle` before submitting changes.
- Use modern Java features (Java 17+): records, pattern matching, sealed classes, text blocks where appropriate.
- Prefer `var` for local variables when the type is obvious from the right-hand side.
- One top-level class per file, file name matches class name.
- Group imports: static imports, then standard library, then third-party, then project imports.

## Rationale
Consistency and readability help both humans and agents maintain the codebase confidently. Following established style guides ensures code integrates seamlessly with existing codebases and tooling.

