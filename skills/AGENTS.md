# Skills Authoring Guidelines

## Philosophy

This repository supports **two types of skills**:

### Local Skills
- **Self-contained** and **portable** for team-specific customization
- Work standalone on any agent platform
- Include team context, references, and scripts
- Must not require context_modules repository at runtime

### External Skills  
- **URL-based** references to skills from other repositories
- Fetched on-demand using agent webfetch capabilities
- No local wrapper or customization needed
- Listed in `external_skills.md` registry
- Always up-to-date from external maintainers

## Directory Structure

```
skill-name/
├── SKILL.md              # Required: Main instructions
├── references/             # Optional: References to context_modules
│   └── *.md           # Local references, not copied content
└── scripts/               # Optional: Automation scripts
    └── *.sh            # Bash scripts (if needed)
```

## Self-Contained Rule

✅ **Skills MUST NOT reference context_modules using `@rule:`, `@persona:`, or `@example:` syntax.**

Instead:
- Use local references: `See @rule:security/prevent_sql_injection.md`
- Use relative paths: `[Link text](references/file.md)`
- Use grep for on-demand search: `grep -l "pattern" references/`

**Why?** Skills should be portable. Copying a skill directory anywhere should work without needing the full context_modules repository.

## Frontmatter Requirements

All SKILL.md files must include simple YAML frontmatter:

```yaml
---
name: skill-name              # Required: kebab-case, 1-64 chars
description: One-sentence description with trigger keywords. 1-1024 chars.
license: MIT                   # Optional
---
```

**Note**: External skills are referenced via URL in `external_skills.md` and fetched on-demand.

## Content Extraction (Local References)

When a skill needs content from context_modules:

1. **Create local reference at creation time:**
   ```bash
   # Create reference file with local pointer
   echo "See @rule:security/prevent_sql_injection.md for detailed implementation" > references/security_rule.md
   ```

2. **Document in SKILL.md:**
   ```markdown
   ## References
   - [Security Prevention](references/security_rule.md)
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
- **References**: Descriptive names (e.g., `constitution.md`)
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

## Example Complete Skills

### Local Skill Example
See `dbt-template/` for reference implementation of local skills with:
- Simple frontmatter structure
- Local references directory
- Team-specific patterns
- Progressive disclosure organization

### External Skill Example
See `external_skills.md` for URL-based external skills like:
- vercel-react-best-practices (fetched from Vercel repository)
- vercel-web-design-guidelines (fetched on-demand)
- vercel-composition-patterns (React component patterns)

## External Skills

External skills are referenced via URL in `external_skills.md` and fetched on-demand using agent webfetch capabilities.

### When to Use External Skills
- When you need standardized, community-maintained skills
- When you want up-to-date content from external repositories
- When you don't need team-specific customization
- When you want to leverage existing skill ecosystems

### External Skills Registry
See `external_skills.md` for the complete registry of available external skills from:
- Vercel agent-skills repository
- Community skill repositories
- Third-party skill providers

## Reference Format Summary

| Type | Use In | Syntax |
|-------|-----------|---------|
| Skills → Context Modules | **Not allowed** | N/A - skills must be self-contained |
| Skills → Skills | Optional | `[Link text](../other-skill/SKILL.md)` |
| Skills → Internal | Required | `[Link text](references/file.md)` + local references |
| Skills → External | Optional | See `external_skills.md` for URL-based references |

## Local vs External Skills Decision Guide

### Use Local Skills When:
- You need team-specific context or customization
- You have internal references to context_modules
- You need scripts or automation specific to your team
- You want to maintain full control over skill content
- You have proprietary or sensitive guidelines

### Use External Skills When:
- You need standardized best practices from external experts
- You want always-up-to-date content from maintainers
- You don't need team-specific customization
- You want to reduce maintenance overhead
- You want to leverage community knowledge

### Hybrid Approach
You can combine both approaches:
- Use external skills for standardized guidelines
- Create local skills for team-specific customization
- Reference external skills from local skills when needed
- Mix and match based on your specific needs