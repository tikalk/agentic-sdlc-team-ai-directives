---
type: Rule
title: Java Null Safety and Optional
description: Java null safety and Optional usage patterns
tags: [java, style-guide, null-safety, optional]
timestamp: 2026-06-14T00:00:00Z
id: rule-rules-style-guides-java-null_safety_and_optional
cdr_ref: null
created: 2026-05-23
modified: 2026-06-14
verified: 2026-05-23
age_days: 22
evidence: []
---

# Java Null Safety and Optional

Prefer `Optional<T>` for methods that may return null, making the possibility of absence explicit in the type system. Avoid returning null from methods; use `Optional.empty()` instead. Use `Optional` for chaining operations and providing default values. For nullable fields, document them clearly and validate at boundaries. Consider using `@Nullable` and `@NonNull` annotations (from JSR-305 or similar) to document nullability contracts in APIs.