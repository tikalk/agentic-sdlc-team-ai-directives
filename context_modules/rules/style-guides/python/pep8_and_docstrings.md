---
type: Rule
title: Python Style Guide
description: PEP 8 conventions and docstring standards for Python code
resource: ./context_modules/rules/style-guides/python/pep8_and_docstrings.md
tags: [python, style-guide, pep8, docstrings, formatting]
generated: { by: agent:legacy, at: 2026-06-14T00:00:00Z }
id: rule-rules-style-guides-python-pep8_and_docstrings
cdr_ref: null
created: 2026-05-23
verified:
  - { by: process:team-repair, at: 2026-05-23T00:00:00Z }
status: stable
stale_after: 180d
---


# Rule: Python Style Guide

## Checklist
- Follow PEP 8 formatting (4-space indents, 79 char lines unless blackened).
- Use type hints on public functions.
- Write module, class, and function docstrings describing purpose, params, and return values.
- Prefer f-strings over `%` formatting or `str.format`.
- Run `ruff` or `flake8` plus `black` before submitting changes.

## Rationale
Consistency and readability help both humans and agents maintain the codebase confidently.

## String Enums (Python 3.12+)

- Use `enum.StrEnum` for all typed string constant sets in Python 3.12+ codebases.
- Do NOT use `class MyEnum(str, Enum)` — `StrEnum` is the standard library idiom since Python 3.11, providing cleaner definitions and unambiguous `str` subclassing.
- Legacy `class MyEnum(str, Enum)` is permitted only in projects that must support Python 3.10 or earlier.

<!-- CDR: CDR-INC-001, Date: 2026-11-01, ID: rule-style-guides-python-strenum -->
