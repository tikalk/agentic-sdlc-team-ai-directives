---
type: Rule
title: Python Style Guide
description: PEP 8 conventions and docstring standards for Python code
tags: [python, style-guide, pep8, docstrings, formatting]
timestamp: "2026-08-06T00:00:00Z"
id: rule-rules-style-guides-python-pep8_and_docstrings
cdr_ref: CDR-2026-025
created: 2026-05-23
modified: 2026-06-14
verified: 2026-08-06
age_days: 0
evidence: []
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
