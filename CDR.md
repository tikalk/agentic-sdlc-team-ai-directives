# Context Directive Records

Context Directive Records (CDRs) track approved contributions to team-ai-directives from various projects. CDRs document patterns, practices, and knowledge extracted from real-world implementations.

> **Memory Engineering**: This index tracks directive freshness. Run `/levelup.validate` to update verification timestamps.

## CDR Index

| ID | Target Module | Type | Status | Created | Verified | Age |
|----|---------------|------|--------|---------|----------|-----|
| CDR-2026-001 | context_modules/rules/security/sql_injection_prevention.md | Rule | Accepted | 2026-04-29 | 2026-05-21 | 22d |
| CDR-2026-002 | context_modules/rules/devops/secrets_management.md | Rule | Accepted | 2026-04-29 | 2026-05-21 | 22d |
| CDR-2026-003 | context_modules/personas/cloud_native_platform_architect.md | Persona | Accepted | 2026-01-16 | 2026-05-21 | 125d |
| CDR-2026-004 | context_modules/personas/data_analyst.md | Persona | Accepted | 2026-01-04 | 2026-05-21 | 137d |
| CDR-2026-005 | context_modules/personas/devops_engineer.md | Persona | Accepted | 2026-01-16 | 2026-05-21 | 125d |
| CDR-2026-006 | context_modules/personas/senior_java_developer.md | Persona | Accepted | 2026-01-04 | 2026-05-21 | 137d |
| CDR-2026-007 | context_modules/personas/senior_python_developer.md | Persona | Accepted | 2026-01-04 | 2026-05-21 | 137d |
| CDR-2026-008 | context_modules/rules/architecture/dependency_injection.md | Rule | Accepted | 2026-05-21 | 2026-05-21 | 0d |
| CDR-2026-009 | context_modules/rules/data/spring_boot_patterns.md | Rule | Accepted | 2026-05-21 | 2026-05-21 | 0d |
| CDR-2026-010 | context_modules/rules/devops/crossplane_compositions.md | Rule | Accepted | 2026-01-16 | 2026-05-21 | 125d |
| CDR-2026-011 | context_modules/rules/devops/github_actions.md | Rule | Accepted | 2026-01-16 | 2026-05-21 | 125d |
| CDR-2026-012 | context_modules/rules/devops/gke_workload_identity.md | Rule | Accepted | 2026-01-16 | 2026-05-21 | 125d |
| CDR-2026-013 | context_modules/rules/devops/helm_chart_library.md | Rule | Accepted | 2026-01-16 | 2026-05-21 | 125d |
| CDR-2026-014 | context_modules/rules/devops/helm_packaging.md | Rule | Accepted | 2026-01-16 | 2026-05-21 | 125d |
| CDR-2026-015 | context_modules/rules/devops/helm_template_helpers.md | Rule | Accepted | 2026-01-16 | 2026-05-21 | 125d |
| CDR-2026-016 | context_modules/rules/devops/helm_wrapper_charts.md | Rule | Accepted | 2026-01-16 | 2026-05-21 | 125d |
| CDR-2026-017 | context_modules/rules/devops/secrets_management.md | Rule | Accepted | 2026-04-29 | 2026-05-21 | 22d |
| CDR-2026-018 | context_modules/rules/orchestration/airbyte_integration.md | Rule | Accepted | 2026-01-16 | 2026-05-21 | 125d |
| CDR-2026-019 | context_modules/rules/orchestration/airflow_dag_patterns.md | Rule | Accepted | 2026-01-16 | 2026-05-21 | 125d |
| CDR-2026-020 | context_modules/rules/security/pre_commit_checklist.md | Rule | Accepted | 2026-05-03 | 2026-05-21 | 18d |
| CDR-2026-021 | context_modules/rules/security/sql_injection_prevention.md | Rule | Accepted | 2026-04-29 | 2026-05-21 | 22d |
| CDR-2026-022 | context_modules/rules/style-guides/file_organization.md | Rule | Accepted | 2026-05-03 | 2026-05-21 | 18d |
| CDR-2026-023 | context_modules/rules/style-guides/java/google_style_guide.md | Rule | Accepted | 2026-05-21 | 2026-05-21 | 0d |
| CDR-2026-024 | context_modules/rules/style-guides/java/null_safety_and_optional.md | Rule | Accepted | 2026-05-21 | 2026-05-21 | 0d |
| CDR-2026-025 | context_modules/rules/style-guides/python/pep8_and_docstrings.md | Rule | Accepted | 2026-05-21 | 2026-05-21 | 0d |
| CDR-2026-026 | context_modules/rules/testing/java/junit5_best_practices.md | Rule | Accepted | 2026-05-21 | 2026-05-21 | 0d |
| CDR-2026-027 | context_modules/rules/testing/python/pytest_patterns.md | Rule | Accepted | 2026-05-21 | 2026-05-21 | 0d |

**Stats**: 29 CDRs | Last Updated: 2026-05-21

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

Each CDR follows this structure with memory tracking:

```markdown
## CDR-{ID}: {Title}

### Status

**Accepted** | Rejected

### Dates

- **Created**: YYYY-MM-DD (from evidence date)
- **Modified**: YYYY-MM-DD (publication date)
- **Verified**: YYYY-MM-DD (last verification)
- **Age**: N days

### Source

{project-name}

### Target Module

`context_modules/rules/{domain}/{file}.md`

### Context Type

Rule | Persona | Example | Constitution Amendment

### Signal Gate

✓ Team-wide | ✓ High Value | ✓ Unique | ✓ Evidence

### Context

Describe the problem being solved or the pattern being captured.

### Decision

State what context module will be added or modified.

### Evidence

Links to code, commits, or discussions that support this CDR.
```

### Memory Tracking Fields

| Field | Description |
|-------|-------------|
| **Created** | Date directive was first published (from oldest evidence) |
| **Modified** | Date of last edit to the directive |
| **Verified** | Date of last verification (run `/levelup.validate`) |
| **Age** | Days since creation (computed from Created date) |

---

## CDR-2026-001: Consolidate SQL Injection Prevention Rules

### Status

**Accepted**

### Dates

- **Created**: 2026-04-29
- **Modified**: 2026-04-29
- **Verified**: 2026-05-21
- **Age**: 22d

### Source

agentic-sdlc/levelup.validate

### Target Module

`context_modules/rules/security/sql_injection_prevention.md`

### Context Type

Rule

### Signal Gate

✓ Team-wide | ✓ High Value | ✓ Unique | ✓ Evidence

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

### Dates

- **Created**: 2026-04-29
- **Modified**: 2026-04-29
- **Verified**: 2026-05-21
- **Age**: 22d

### Source

agentic-sdlc/levelup.validate

### Target Module

`context_modules/rules/devops/secrets_management.md`

### Context Type

Rule

### Signal Gate

✓ Team-wide | ✓ High Value | ✓ Unique | ✓ Evidence

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

## CDR-2026-003: Persona: Cloud-Native Platform Architect

### Status

**Accepted**

### Dates

- **Created**: 2026-01-16
- **Modified**: 2026-01-16
- **Verified**: 2026-05-21
- **Age**: 125d

### Source

team-ai-directives (initial repository content)

### Target Module

`context_modules/personas/cloud_native_platform_architect.md`

### Context Type

Persona

### Signal Gate

✓ Team-wide | ✓ High Value | ✓ Unique | ✓ Evidence

### Context

Initial repository content from team-ai-directives established during repository creation.

### Decision

Module accepted as part of core team-ai-directives repository.

### Evidence

- File created: 2026-01-16
- Part of v1.6.1 re-indexing

---

## CDR-2026-004: Persona: Data Analyst

### Status

**Accepted**

### Dates

- **Created**: 2026-01-04
- **Modified**: 2026-01-04
- **Verified**: 2026-05-21
- **Age**: 137d

### Source

team-ai-directives (initial repository content)

### Target Module

`context_modules/personas/data_analyst.md`

### Context Type

Persona

### Signal Gate

✓ Team-wide | ✓ High Value | ✓ Unique | ✓ Evidence

### Context

Initial repository content from team-ai-directives established during repository creation.

### Decision

Module accepted as part of core team-ai-directives repository.

### Evidence

- File created: 2026-01-04
- Part of v1.6.1 re-indexing

---

## CDR-2026-005: Persona: DevOps Engineer

### Status

**Accepted**

### Dates

- **Created**: 2026-01-16
- **Modified**: 2026-01-16
- **Verified**: 2026-05-21
- **Age**: 125d

### Source

team-ai-directives (initial repository content)

### Target Module

`context_modules/personas/devops_engineer.md`

### Context Type

Persona

### Signal Gate

✓ Team-wide | ✓ High Value | ✓ Unique | ✓ Evidence

### Context

Initial repository content from team-ai-directives established during repository creation.

### Decision

Module accepted as part of core team-ai-directives repository.

### Evidence

- File created: 2026-01-16
- Part of v1.6.1 re-indexing

---

## CDR-2026-006: Persona: Senior Java Developer

### Status

**Accepted**

### Dates

- **Created**: 2026-01-04
- **Modified**: 2026-01-04
- **Verified**: 2026-05-21
- **Age**: 137d

### Source

team-ai-directives (initial repository content)

### Target Module

`context_modules/personas/senior_java_developer.md`

### Context Type

Persona

### Signal Gate

✓ Team-wide | ✓ High Value | ✓ Unique | ✓ Evidence

### Context

Initial repository content from team-ai-directives established during repository creation.

### Decision

Module accepted as part of core team-ai-directives repository.

### Evidence

- File created: 2026-01-04
- Part of v1.6.1 re-indexing

---

## CDR-2026-007: Persona: Senior Python Developer

### Status

**Accepted**

### Dates

- **Created**: 2026-01-04
- **Modified**: 2026-01-04
- **Verified**: 2026-05-21
- **Age**: 137d

### Source

team-ai-directives (initial repository content)

### Target Module

`context_modules/personas/senior_python_developer.md`

### Context Type

Persona

### Signal Gate

✓ Team-wide | ✓ High Value | ✓ Unique | ✓ Evidence

### Context

Initial repository content from team-ai-directives established during repository creation.

### Decision

Module accepted as part of core team-ai-directives repository.

### Evidence

- File created: 2026-01-04
- Part of v1.6.1 re-indexing

---

## CDR-2026-008: Rule: Dependency Injection

### Status

**Accepted**

### Dates

- **Created**: 2026-05-21
- **Modified**: 2026-05-21
- **Verified**: 2026-05-21
- **Age**: 0d

### Source

team-ai-directives (initial repository content)

### Target Module

`context_modules/rules/architecture/dependency_injection.md`

### Context Type

Rule

### Signal Gate

✓ Team-wide | ✓ High Value | ✓ Unique | ✓ Evidence

### Context

Initial repository content from team-ai-directives established during repository creation.

### Decision

Module accepted as part of core team-ai-directives repository.

### Evidence

- File created: 2026-05-21
- Part of v1.6.1 re-indexing

---

## CDR-2026-009: Rule: Spring Boot Patterns

### Status

**Accepted**

### Dates

- **Created**: 2026-05-21
- **Modified**: 2026-05-21
- **Verified**: 2026-05-21
- **Age**: 0d

### Source

team-ai-directives (initial repository content)

### Target Module

`context_modules/rules/data/spring_boot_patterns.md`

### Context Type

Rule

### Signal Gate

✓ Team-wide | ✓ High Value | ✓ Unique | ✓ Evidence

### Context

Initial repository content from team-ai-directives established during repository creation.

### Decision

Module accepted as part of core team-ai-directives repository.

### Evidence

- File created: 2026-05-21
- Part of v1.6.1 re-indexing

---

## CDR-2026-010: Rule: Crossplane Compositions

### Status

**Accepted**

### Dates

- **Created**: 2026-01-16
- **Modified**: 2026-01-16
- **Verified**: 2026-05-21
- **Age**: 125d

### Source

team-ai-directives (initial repository content)

### Target Module

`context_modules/rules/devops/crossplane_compositions.md`

### Context Type

Rule

### Signal Gate

✓ Team-wide | ✓ High Value | ✓ Unique | ✓ Evidence

### Context

Initial repository content from team-ai-directives established during repository creation.

### Decision

Module accepted as part of core team-ai-directives repository.

### Evidence

- File created: 2026-01-16
- Part of v1.6.1 re-indexing

---

## CDR-2026-011: Rule: GitHub Actions

### Status

**Accepted**

### Dates

- **Created**: 2026-01-16
- **Modified**: 2026-01-16
- **Verified**: 2026-05-21
- **Age**: 125d

### Source

team-ai-directives (initial repository content)

### Target Module

`context_modules/rules/devops/github_actions.md`

### Context Type

Rule

### Signal Gate

✓ Team-wide | ✓ High Value | ✓ Unique | ✓ Evidence

### Context

Initial repository content from team-ai-directives established during repository creation.

### Decision

Module accepted as part of core team-ai-directives repository.

### Evidence

- File created: 2026-01-16
- Part of v1.6.1 re-indexing

---

## CDR-2026-012: Rule: GKE Workload Identity

### Status

**Accepted**

### Dates

- **Created**: 2026-01-16
- **Modified**: 2026-01-16
- **Verified**: 2026-05-21
- **Age**: 125d

### Source

team-ai-directives (initial repository content)

### Target Module

`context_modules/rules/devops/gke_workload_identity.md`

### Context Type

Rule

### Signal Gate

✓ Team-wide | ✓ High Value | ✓ Unique | ✓ Evidence

### Context

Initial repository content from team-ai-directives established during repository creation.

### Decision

Module accepted as part of core team-ai-directives repository.

### Evidence

- File created: 2026-01-16
- Part of v1.6.1 re-indexing

---

## CDR-2026-013: Rule: Helm Chart Library

### Status

**Accepted**

### Dates

- **Created**: 2026-01-16
- **Modified**: 2026-01-16
- **Verified**: 2026-05-21
- **Age**: 125d

### Source

team-ai-directives (initial repository content)

### Target Module

`context_modules/rules/devops/helm_chart_library.md`

### Context Type

Rule

### Signal Gate

✓ Team-wide | ✓ High Value | ✓ Unique | ✓ Evidence

### Context

Initial repository content from team-ai-directives established during repository creation.

### Decision

Module accepted as part of core team-ai-directives repository.

### Evidence

- File created: 2026-01-16
- Part of v1.6.1 re-indexing

---

## CDR-2026-014: Rule: Helm Packaging

### Status

**Accepted**

### Dates

- **Created**: 2026-01-16
- **Modified**: 2026-01-16
- **Verified**: 2026-05-21
- **Age**: 125d

### Source

team-ai-directives (initial repository content)

### Target Module

`context_modules/rules/devops/helm_packaging.md`

### Context Type

Rule

### Signal Gate

✓ Team-wide | ✓ High Value | ✓ Unique | ✓ Evidence

### Context

Initial repository content from team-ai-directives established during repository creation.

### Decision

Module accepted as part of core team-ai-directives repository.

### Evidence

- File created: 2026-01-16
- Part of v1.6.1 re-indexing

---

## CDR-2026-015: Rule: Helm Template Helpers

### Status

**Accepted**

### Dates

- **Created**: 2026-01-16
- **Modified**: 2026-01-16
- **Verified**: 2026-05-21
- **Age**: 125d

### Source

team-ai-directives (initial repository content)

### Target Module

`context_modules/rules/devops/helm_template_helpers.md`

### Context Type

Rule

### Signal Gate

✓ Team-wide | ✓ High Value | ✓ Unique | ✓ Evidence

### Context

Initial repository content from team-ai-directives established during repository creation.

### Decision

Module accepted as part of core team-ai-directives repository.

### Evidence

- File created: 2026-01-16
- Part of v1.6.1 re-indexing

---

## CDR-2026-016: Rule: Helm Wrapper Charts

### Status

**Accepted**

### Dates

- **Created**: 2026-01-16
- **Modified**: 2026-01-16
- **Verified**: 2026-05-21
- **Age**: 125d

### Source

team-ai-directives (initial repository content)

### Target Module

`context_modules/rules/devops/helm_wrapper_charts.md`

### Context Type

Rule

### Signal Gate

✓ Team-wide | ✓ High Value | ✓ Unique | ✓ Evidence

### Context

Initial repository content from team-ai-directives established during repository creation.

### Decision

Module accepted as part of core team-ai-directives repository.

### Evidence

- File created: 2026-01-16
- Part of v1.6.1 re-indexing

---

## CDR-2026-017: Rule: Secrets Management

### Status

**Accepted**

### Dates

- **Created**: 2026-04-29
- **Modified**: 2026-04-29
- **Verified**: 2026-05-21
- **Age**: 22d

### Source

team-ai-directives (initial repository content)

### Target Module

`context_modules/rules/devops/secrets_management.md`

### Context Type

Rule

### Signal Gate

✓ Team-wide | ✓ High Value | ✓ Unique | ✓ Evidence

### Context

Initial repository content from team-ai-directives established during repository creation.

### Decision

Module accepted as part of core team-ai-directives repository.

### Evidence

- File created: 2026-04-29
- Part of v1.6.1 re-indexing

---

## CDR-2026-018: Rule: Airbyte Integration

### Status

**Accepted**

### Dates

- **Created**: 2026-01-16
- **Modified**: 2026-01-16
- **Verified**: 2026-05-21
- **Age**: 125d

### Source

team-ai-directives (initial repository content)

### Target Module

`context_modules/rules/orchestration/airbyte_integration.md`

### Context Type

Rule

### Signal Gate

✓ Team-wide | ✓ High Value | ✓ Unique | ✓ Evidence

### Context

Initial repository content from team-ai-directives established during repository creation.

### Decision

Module accepted as part of core team-ai-directives repository.

### Evidence

- File created: 2026-01-16
- Part of v1.6.1 re-indexing

---

## CDR-2026-019: Rule: Airflow DAG Patterns

### Status

**Accepted**

### Dates

- **Created**: 2026-01-16
- **Modified**: 2026-01-16
- **Verified**: 2026-05-21
- **Age**: 125d

### Source

team-ai-directives (initial repository content)

### Target Module

`context_modules/rules/orchestration/airflow_dag_patterns.md`

### Context Type

Rule

### Signal Gate

✓ Team-wide | ✓ High Value | ✓ Unique | ✓ Evidence

### Context

Initial repository content from team-ai-directives established during repository creation.

### Decision

Module accepted as part of core team-ai-directives repository.

### Evidence

- File created: 2026-01-16
- Part of v1.6.1 re-indexing

---

## CDR-2026-020: Rule: Pre-Commit Security Checklist

### Status

**Accepted**

### Dates

- **Created**: 2026-05-03
- **Modified**: 2026-05-03
- **Verified**: 2026-05-21
- **Age**: 18d

### Source

team-ai-directives (initial repository content)

### Target Module

`context_modules/rules/security/pre_commit_checklist.md`

### Context Type

Rule

### Signal Gate

✓ Team-wide | ✓ High Value | ✓ Unique | ✓ Evidence

### Context

Initial repository content from team-ai-directives established during repository creation.

### Decision

Module accepted as part of core team-ai-directives repository.

### Evidence

- File created: 2026-05-03
- Part of v1.6.1 re-indexing

---

## CDR-2026-021: Rule: SQL Injection Prevention

### Status

**Accepted**

### Dates

- **Created**: 2026-04-29
- **Modified**: 2026-04-29
- **Verified**: 2026-05-21
- **Age**: 22d

### Source

team-ai-directives (initial repository content)

### Target Module

`context_modules/rules/security/sql_injection_prevention.md`

### Context Type

Rule

### Signal Gate

✓ Team-wide | ✓ High Value | ✓ Unique | ✓ Evidence

### Context

Initial repository content from team-ai-directives established during repository creation.

### Decision

Module accepted as part of core team-ai-directives repository.

### Evidence

- File created: 2026-04-29
- Part of v1.6.1 re-indexing

---

## CDR-2026-022: Rule: File Organization and Structure

### Status

**Accepted**

### Dates

- **Created**: 2026-05-03
- **Modified**: 2026-05-03
- **Verified**: 2026-05-21
- **Age**: 18d

### Source

team-ai-directives (initial repository content)

### Target Module

`context_modules/rules/style-guides/file_organization.md`

### Context Type

Rule

### Signal Gate

✓ Team-wide | ✓ High Value | ✓ Unique | ✓ Evidence

### Context

Initial repository content from team-ai-directives established during repository creation.

### Decision

Module accepted as part of core team-ai-directives repository.

### Evidence

- File created: 2026-05-03
- Part of v1.6.1 re-indexing

---

## CDR-2026-023: Rule: Java Google Style Guide

### Status

**Accepted**

### Dates

- **Created**: 2026-05-21
- **Modified**: 2026-05-21
- **Verified**: 2026-05-21
- **Age**: 0d

### Source

team-ai-directives (initial repository content)

### Target Module

`context_modules/rules/style-guides/java/google_style_guide.md`

### Context Type

Rule

### Signal Gate

✓ Team-wide | ✓ High Value | ✓ Unique | ✓ Evidence

### Context

Initial repository content from team-ai-directives established during repository creation.

### Decision

Module accepted as part of core team-ai-directives repository.

### Evidence

- File created: 2026-05-21
- Part of v1.6.1 re-indexing

---

## CDR-2026-024: Rule: Java Null Safety and Optional

### Status

**Accepted**

### Dates

- **Created**: 2026-05-21
- **Modified**: 2026-05-21
- **Verified**: 2026-05-21
- **Age**: 0d

### Source

team-ai-directives (initial repository content)

### Target Module

`context_modules/rules/style-guides/java/null_safety_and_optional.md`

### Context Type

Rule

### Signal Gate

✓ Team-wide | ✓ High Value | ✓ Unique | ✓ Evidence

### Context

Initial repository content from team-ai-directives established during repository creation.

### Decision

Module accepted as part of core team-ai-directives repository.

### Evidence

- File created: 2026-05-21
- Part of v1.6.1 re-indexing

---

## CDR-2026-025: Rule: Python PEP 8 and Docstrings

### Status

**Accepted**

### Dates

- **Created**: 2026-05-21
- **Modified**: 2026-05-21
- **Verified**: 2026-05-21
- **Age**: 0d

### Source

team-ai-directives (initial repository content)

### Target Module

`context_modules/rules/style-guides/python/pep8_and_docstrings.md`

### Context Type

Rule

### Signal Gate

✓ Team-wide | ✓ High Value | ✓ Unique | ✓ Evidence

### Context

Initial repository content from team-ai-directives established during repository creation.

### Decision

Module accepted as part of core team-ai-directives repository.

### Evidence

- File created: 2026-05-21
- Part of v1.6.1 re-indexing

---

## CDR-2026-026: Rule: Java JUnit 5 Best Practices

### Status

**Accepted**

### Dates

- **Created**: 2026-05-21
- **Modified**: 2026-05-21
- **Verified**: 2026-05-21
- **Age**: 0d

### Source

team-ai-directives (initial repository content)

### Target Module

`context_modules/rules/testing/java/junit5_best_practices.md`

### Context Type

Rule

### Signal Gate

✓ Team-wide | ✓ High Value | ✓ Unique | ✓ Evidence

### Context

Initial repository content from team-ai-directives established during repository creation.

### Decision

Module accepted as part of core team-ai-directives repository.

### Evidence

- File created: 2026-05-21
- Part of v1.6.1 re-indexing

---

## CDR-2026-027: Rule: Python Testing with Pytest

### Status

**Accepted**

### Dates

- **Created**: 2026-05-21
- **Modified**: 2026-05-21
- **Verified**: 2026-05-21
- **Age**: 0d

### Source

team-ai-directives (initial repository content)

### Target Module

`context_modules/rules/testing/python/pytest_patterns.md`

### Context Type

Rule

### Signal Gate

✓ Team-wide | ✓ High Value | ✓ Unique | ✓ Evidence

### Context

Initial repository content from team-ai-directives established during repository creation.

### Decision

Module accepted as part of core team-ai-directives repository.

### Evidence

- File created: 2026-05-21
- Part of v1.6.1 re-indexing

---

*This file is maintained by the LevelUp workflow. CDRs are added through PRs from project contributions.*
