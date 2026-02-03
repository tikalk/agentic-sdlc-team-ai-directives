# Generic Skill Development Templates

**Skill Overview**: Basic patterns and templates for creating self-contained, portable agent skills following the Agent Skills standard.

**When to Use This Skill**:
- Creating new agent skills for any platform (Claude Code, Cursor, Copilot, etc.)
- Implementing skill development patterns and best practices
- Setting up skill directory structures and organization
- Managing skill frontmatter and documentation

**Quick Setup Guide:**

### Prerequisites
- Understanding of Agent Skills standard (see `AGENTS.md`)
- YAML frontmatter knowledge
- Basic file system operations

### Initialize Skill Project
```bash
# Create skill directory structure
mkdir -p my-skill/{scripts,references}
cd my-skill

# Create main skill file
touch SKILL.md

# Create references directory (if needed)
mkdir -p references
```

---

## Generic Skill Structure

### Standard Directory Layout

**Rule**: Use consistent directory structure for all skills

**Rationale**: Maintainability, discoverability, consistency across skills

**Implementation**:
```
skill-name/
├── SKILL.md              # Required: Main instructions with YAML frontmatter
├── references/             # Optional: References to context_modules
│   └── *.md           # Local references, not copied content
└── scripts/               # Optional: Automation scripts
    └── *.sh            # Bash scripts (if needed)
```

**Reference**: @skills/AGENTS.md

### Required Frontmatter Structure

**Rule**: All SKILL.md files must include simple YAML frontmatter

**Rationale**: Basic identification for skills, LLM-friendly discovery

**Implementation**:
```yaml
---
name: skill-name              # Required: kebab-case, 1-64 chars
description: One-sentence description with trigger keywords. 1-1024 chars.
license: MIT                   # Optional: License identifier
---
```

**Reference**: @skills/AGENTS.md

---

## Generic Skill Development Patterns

### Skill Content Organization

**Rule**: Structure skill content with progressive disclosure

**Rationale**: Context efficiency, user experience, maintainability

**Implementation**:
```markdown
# Skill Name

## What This Skill Provides
# (Brief overview - 3-5 bullet points)

## When to Use This Skill
# (Use cases and scenarios - 3-5 bullet points)

## Core Patterns
# (Main patterns and approaches - 3-5 sections)

## Implementation Details
# (Detailed implementation - 5-10 sections)

## References
# (Local references to context_modules)
```

### Progressive Disclosure Levels

**Level 1: Metadata (Startup)**
- YAML frontmatter with name, description
- ~100 tokens for quick skill discovery
- Loaded when skill is triggered

**Level 2: Instructions (Main)**
- Complete skill instructions
- ~5000 tokens for detailed guidance
- Loaded when skill is activated

**Level 3: Resources (On-Demand)**
- Files in `references/` directory
- Loaded as needed via tools
- Local references to context_modules

**Reference**: @skills/AGENTS.md

### Self-Contained Rule

**Rule**: Skills MUST NOT reference context_modules using `@rule:`, `@persona:`, or `@example:` syntax

**Rationale**: Skills should be portable and work standalone

**Implementation**:
- ✅ **DO**: Use local references: `See @rule:security/prevent_sql_injection.md`
- ✅ **DO**: Use relative paths: `[Link text](references/file.md)`
- ❌ **DON'T**: Use `@rule:security/prevent_sql_injection.md` in skill content
- ❌ **DON'T**: Copy content from context_modules

**Reference**: @skills/AGENTS.md

---

## Naming Conventions

- **Skill directory**: `kebab-case` (e.g., `dbt-cli-tooling`)
- **SKILL.md**: Always uppercase, exact filename
- **References**: Descriptive names (e.g., `constitution.md`)
- **Scripts**: `kebab-case.sh` (e.g., `validate-dag.sh`)

---

## Progressive Disclosure

Skills load in three levels for context efficiency:

1. **Level 1 (metadata)**: `name` + `description` loaded at startup (~100 tokens)
2. **Level 2 (instructions)**: Full `SKILL.md` loaded when triggered (~5000 tokens)
3. **Level 3 (resources)**: Files in `references/` directory loaded on-demand via tools

This pattern mirrors how you'd onboard a new team member—give them overview first, detailed instructions second, and reference materials on demand.

---

## Platform Compatibility

This approach works with all agents:
- ✅ Claude Code (uses Read, Grep, Bash tools)
- ✅ Cursor (uses standard filesystem tools)
- ✅ Copilot (uses standard filesystem tools)
- ✅ Any agent with Read + Grep/Bash capabilities

---

## Script Guidelines

If including automation scripts:
- Use `#!/bin/bash` shebang
- Use `set -e` for fail-fast
- Write status to stderr: `echo "Message" >&2`
- Output JSON to stdout for machine readability
- Include cleanup trap for temp files

---

## Validation

Use standard tools for validation:
```bash
# Check YAML syntax (if tool available)
# Validate frontmatter format
# Test script execution
# Verify all file references exist
```

---

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

---

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

---

## Reference Format Summary

| Type | Use In | Syntax |
|-------|-----------|---------|
| Skills → Context Modules | **Not allowed** | N/A - skills must be self-contained |
| Skills → Skills | Optional | `[Link text](../other-skill/SKILL.md)` |
| Skills → Internal | Required | `[Link text](references/file.md)` + local references |
| Skills → External | Optional | See `external_skills.md` for URL-based references |

---

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