# Context Directive Records

Context Directive Records (CDRs) track approved contributions to team-ai-directives from various projects. CDRs document patterns, practices, and knowledge extracted from real-world implementations.

## CDR Index

| ID | Target Module | Context Type | Status | Date | Source |
|----|---------------|--------------|--------|------|--------|
| CDR-2026-001 | context_modules/rules/security/sql_injection_prevention.md | Rule | Accepted | 2026-04-29 | agentic-sdlc/levelup.validate |
| CDR-2026-002 | context_modules/rules/devops/secrets_management.md | Rule | Accepted | 2026-04-29 | agentic-sdlc/levelup.validate |

---

## CDR Status Reference

| Status | Description |
|--------|-------------|
| **Accepted** | Approved for inclusion in team-ai-directives |
| **Rejected** | Not accepted (reason documented in CDR) |

## CDR Workflow

1. **Discovery**: Run `/levelup.init` in a project to discover patterns
2. **Clarification**: Run `/levelup.clarify` to validate and accept patterns
3. **Implementation**: Run `/levelup.implement` to create PR with:
   - Context modules (rules, personas, examples)
   - Skills (if applicable)
   - This CDR.md file with accepted CDRs

## CDR Format

Each CDR follows this structure:

```markdown
## CDR-{ID}: {Title}

### Status

**Accepted** | Rejected

### Date

YYYY-MM-DD

### Source

{project-name}

### Target Module

`context_modules/rules/{domain}/{file}.md`

### Context Type

Rule | Persona | Example | Constitution Amendment

### Context

Describe the problem being solved or the pattern being captured.

### Decision

State what context module will be added or modified.

### Evidence

Links to code, commits, or discussions that support this CDR.
```

---

## CDR-2026-001: Consolidate SQL Injection Prevention Rules

### Status

**Accepted**

### Date

2026-04-29

### Source

agentic-sdlc/levelup.validate

### Target Module

`context_modules/rules/security/sql_injection_prevention.md`

### Context Type

Rule

### Context

**Problem**: Two overlapping rules existed:
- `prevent_sql_injection.md` - Generic SQL injection prevention
- `java_prevent_sql_injection.md` - Java-specific implementation

This created scope overlap (Level 4) and potential confusion about which rule to reference.

### Decision

Consolidated into single comprehensive rule `sql_injection_prevention.md`:
- Universal checklist applicable to all languages
- Language-specific patterns section (Java, Python, JavaScript/Node.js)
- SQL testing payloads for regression tests
- References to related rules for framework-specific details

### Evidence

Original files removed:
- `rules/security/java_prevent_sql_injection.md`
- `rules/security/prevent_sql_injection.md`

New file created:
- `rules/security/sql_injection_prevention.md`

---

## CDR-2026-002: Consolidate Secrets Management Rules

### Status

**Accepted**

### Date

2026-04-29

### Source

agentic-sdlc/levelup.validate

### Target Module

`context_modules/rules/devops/secrets_management.md`

### Context Type

Rule

### Context

**Problem**: Three overlapping rules existed:
- `external_secrets_operator.md` - External Secrets Operator CRD patterns
- `secrets_management_dry.md` - DRY pattern using External Secrets Operator
- (related) `gke_workload_identity.md` - GKE-specific authentication

This created scope overlap (Level 4) as these rules reference each other extensively.

### Decision

Consolidated into single comprehensive rule `secrets_management.md`:
- Part 1: External Secrets Operator patterns (ESO CRD configuration)
- Part 2: DRY Secrets Pattern (two-pattern approach: local vs cloud)
- Part 3: GKE Workload Identity integration
- Security best practices section
- References to related rules (helm, github_actions, gke)

### Evidence

Original files removed:
- `rules/devops/external_secrets_operator.md`
- `rules/devops/secrets_management_dry.md`

New file created:
- `rules/devops/secrets_management.md`

---

*This file is maintained by the LevelUp workflow. CDRs are added through PRs from project contributions.*
