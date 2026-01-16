# Skills Authoring Guidelines

## Philosophy

Skills in this repository are **self-contained** and **portable**. They must work standalone on any agent platform (Claude Code, Cursor, Copilot, etc.) without requiring to context_modules repository at runtime.

## Directory Structure

```
skill-name/
├── SKILL.md              # Required: Main instructions
├── references/             # Optional: Extracted content at build time
│   └── *.md           # Copied from context_modules for offline use
└── scripts/               # Optional: Automation scripts
    └── *.sh            # Bash scripts (preferred)
```

## Self-Contained Rule

✅ **Skills MUST NOT reference context_modules using `@rule:`, `@persona:`, or `@example:` syntax.**

Instead:
- Extract content into `references/` at build time
- Use relative paths: `[Link text](references/file.md)`
- Use grep for on-demand search: `grep -l "pattern" references/`

**Why?** Skills should be portable. Copying a skill directory anywhere should work without needing the full context_modules repository.

## Frontmatter Requirements

All SKILL.md files must include YAML frontmatter:

```yaml
---
name: skill-name              # kebab-case, 1-64 chars
description: One-sentence description with trigger keywords. 1-1024 chars.
license: MIT                   # Optional
metadata:
  author: your-name          # Optional
  version: "1.0.0"          # Optional
  category: category-name       # Optional
---
```

## Content Extraction (Build-Time)

When a skill needs content from context_modules:

1. **Extract at creation time:**
   ```bash
   cp context_modules/rules/security/prevent_sql_injection.md \
      skills/my-skill/references/rule_sql_injection.md
   ```

2. **Document in SKILL.md:**
   ```markdown
   ## References
   - [SQL Injection Prevention](references/rule_sql_injection.md)
   ```

3. **Use grep for search:**
   ```markdown
   To find specific patterns:
   ```
   grep -l "sql" references/
   ```
   ```

## Naming Conventions

- **Skill directory**: `kebab-case` (e.g., `dbt-cli-tooling`)
- **SKILL.md**: Always uppercase, exact filename
- **References**: Descriptive names (e.g., `persona_data_analyst.md`)
- **Scripts**: `kebab-case.sh` (e.g., `validate-dag.sh`)

## Progressive Disclosure

Skills load in three levels for context efficiency:

1. **Level 1 (metadata)**: `name` + `description` loaded at startup (~100 tokens)
2. **Level 2 (instructions)**: Full `SKILL.md` loaded when triggered (~5000 tokens)
3. **Level 3 (resources)**: Files in `references/` loaded on-demand via tools

This pattern mirrors how you'd onboard a new team member—give them overview first, detailed instructions second, and reference materials on demand.

## Platform Compatibility

This approach works with all agents:
- ✅ Claude Code (uses Read, Grep, Bash tools)
- ✅ Cursor (uses standard filesystem tools)
- ✅ Copilot (uses standard filesystem tools)
- ✅ Any agent with Read + Grep/Bash capabilities

## Script Guidelines

If including automation scripts:
- Use `#!/bin/bash` shebang
- Use `set -e` for fail-fast
- Write status to stderr: `echo "Message" >&2`
- Output JSON to stdout for machine readability
- Include cleanup trap for temp files

## Validation

Use standard tools for validation:
```bash
# Check YAML syntax (if tool available)
# Validate frontmatter format
# Test script execution
# Verify all file references exist
```

## Example Complete Skill

See `dbt-template/` for reference implementation of:
- Build-time content extraction
- Local references directory
- Grep-based search patterns
- Multi-file references

## Reference Format Summary

| Type | Use In | Syntax |
|-------|-----------|---------|
| Skills → Context Modules | **Not allowed** | N/A - skills must be self-contained |
| Skills → Skills | Optional | `[Link text](../other-skill/SKILL.md)` |
| Skills → Internal | Required | `[Link text](references/file.md)` + `grep -l "pattern" references/` |
