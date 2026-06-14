---
type: Rule
title: File Organization and Structure
description: Standards for file organization, sizing, and code structure across all languages
tags: [style-guide, file-organization, code-structure, maintainability]
timestamp: 2026-06-14T00:00:00Z
id: rule-rules-style-guides-file_organization
cdr_ref: CDR-2026-022
created: 2026-05-03
modified: 2026-06-14
verified: 2026-05-21
age_days: 42
evidence: []
---

# Rule: File Organization and Structure

## File Size Limits

- **Target**: 200-400 lines per file
- **Maximum**: 800 lines per file
- **Rationale**: Smaller files are easier to understand, test, and maintain. They reduce cognitive load and make code reviews more effective.

## Function and Method Limits

- **Target**: <50 lines per function/method
- **Maximum**: 100 lines per function/method
- **Rationale**: Short functions do one thing well. They're easier to test, debug, and reuse.

## Nesting Depth

- **Maximum**: 4 levels of nesting (ifs, loops, callbacks)
- **Rationale**: Deep nesting makes code hard to follow and indicates potential for extraction into separate functions.

## Organization Principles

### Organize by Feature/Domain, Not by Type

**Avoid:**
```
project/
├── controllers/
│   ├── user_controller.py
│   └── order_controller.py
├── models/
│   ├── user.py
│   └── order.py
└── services/
    ├── user_service.py
    └── order_service.py
```

**Prefer:**
```
project/
├── users/
│   ├── controller.py
│   ├── model.py
│   ├── service.py
│   └── test_user.py
└── orders/
    ├── controller.py
    ├── model.py
    ├── service.py
    └── test_order.py
```

### Keep Related Code Together

- Group related functions and classes in the same file
- Co-locate tests with source files or in mirrored directory structures
- Keep configuration, types, and interfaces close to their usage

## Language-Specific Guidelines

### Java

See `@rule:style-guides/java/google_style_guide.md` for additional Java-specific organization patterns.

Key points:
- One public class per file
- Class name matches filename
- Package structure mirrors directory structure

### Python

See `@rule:style-guides/python/pep8_and_docstrings.md` for Python-specific guidance.

Key points:
- Module-level functions at the top
- Classes follow
- Private helpers at the bottom
- `__init__.py` for package organization

## When to Split Files

Split a file when:
- It exceeds 800 lines
- It contains multiple unrelated features
- Different parts change for different reasons
- Parts could be reused independently

## When to Merge Files

Consider merging when:
- Files are always edited together
- Splitting creates excessive indirection
- Related logic is scattered across many small files

## References

- `@rule:style-guides/python/pep8_and_docstrings.md` - Python-specific style guidance
- `@rule:style-guides/java/google_style_guide.md` - Java-specific style guidance
