# Agent Instructions

This repository contains reusable AI agent directives.

## Structure

- `context_modules/constitution.md` - Core principles (always load)
- `context_modules/personas/` - Role-specific guidance
- `context_modules/rules/` - Domain-specific patterns
- `context_modules/examples/` - Code examples and prompt templates
- `skills/` - Self-contained capabilities
- `.skills.json` - Skills registry and policy
- `.cdrs.json` - Context module registry and status tracking

## Loading Order

1. Constitution (foundational principles)
2. Relevant persona (based on task context)
3. Skill (triggered by user request)

## Context Module Registry (.cdrs.json)

All context modules (personas, rules, examples) are tracked in `.cdrs.json`:

```json
{
  "modules": {
    "senior_python_developer": {
      "path": "personas/senior_python_developer.md",
      "type": "persona",
      "status": "active"
    }
  }
}
```

### Module Types

| Type | Location | Description |
|------|----------|-------------|
| `persona` | `context_modules/personas/` | Role-specific guidance |
| `rule` | `context_modules/rules/` | Domain-specific patterns |
| `example` | `context_modules/examples/` | Code examples and prompts |

### Status Values

Each module has a `status` field for lifecycle tracking:

- `discovered` - Identified but not yet proposed
- `proposed` - Under consideration
- `accepted` - Approved for use
- `active` - Currently in use (default for new modules)
- `deprecated` - No longer recommended

### Finding Context Modules

1. Check `.cdrs.json` for all available modules
2. Filter by `type` (persona, rule, example)
3. Filter by `status` (use `active` for current modules)
4. Load the file from the path specified

## Using Skills

Skills are in `skills/{skill-name}/`:

- `SKILL.md` - Read this first (has trigger keywords in description)
- `references/` - Supporting content (load on-demand)
- `scripts/` - Automation (if present)

To find relevant skills:

1. Check `.skills.json` for available skills
2. Match user request to skill descriptions
3. Load SKILL.md when triggered

## Using Rules

Rules are in `context_modules/rules/{domain}/`. Access them via:

1. Persona Rule References sections
2. Direct exploration of rules directory

## External Skills

`.skills.json` registry section lists external skills. Fetch via URL when needed.
