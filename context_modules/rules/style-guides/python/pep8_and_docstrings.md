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
