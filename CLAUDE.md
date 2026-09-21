# Agent Instructions

This repository contains team AI directives for context-aware development.

> **OKF v0.1 Conformance**: All context modules (constitution, personas, rules, examples, skills) follow the Open Knowledge Format v0.1 specification. Each concept document includes YAML frontmatter with a `type` field (Constitution, Persona, Rule, Example, or Skill) plus standard OKF fields (`title`, `description`, `tags`, `timestamp`) alongside team-ai-directives-specific memory tracking fields.

## Structure

- `context_modules/constitution.md` - Core principles (always load first)
- `context_modules/personas/` - Role-specific guidance
- `context_modules/rules/` - Domain-specific patterns organized by functional category
- `context_modules/examples/` - Code examples by technology
- `skills/` - Self-contained capabilities with SKILL.md
- `.skills.json` - Skills registry and policy
- `CDR.md` - Context Directive Records (approved contributions tracker)

## Loading Order

1. **Constitution** (`context_modules/constitution.md`) - Foundational principles
2. **Persona** (`context_modules/personas/*.md`) - Role-specific context
3. **Skill** (`skills/*/SKILL.md`) - Task-specific capabilities (triggered on demand)

## Governance Commands and Skills

Governance capabilities (`team.discover`, `team.curate`, `team.evolve`, `team.skills`, `team.verify`, `team.repair`) are bundled with the Specify CLI as the `team-ai-directives` extension. They are installed automatically when a project is initialized with `--team-ai-directives <this-repo>`.

This repository contains only **domain skills** (for example `dbt-template`, `helm-charts`, `github-actions`). Register new domain skills in `.skills.json` and place them under `skills/{skill-name}/SKILL.md`.

## Using Rules

Access rules via:

1. **Persona Rule References** - Personas link to relevant rules
2. **Direct exploration** - Browse `context_modules/rules/{category}/`
3. **CDR.md** - Check for recently approved contributions

## CDR.md

Context Directive Records track approved contributions from various projects. Review to:

- Find patterns added by other teams
- Understand evolution of standards
- Check for recent additions in your domain

## External Skills

`.skills.json` registry section lists external skills. Fetch via URL when referenced.
