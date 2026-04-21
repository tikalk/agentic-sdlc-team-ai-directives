---
description: Discover relevant context from team-ai-directives for current feature
scripts:
  sh: scripts/bash/discover-context.sh
  ps: scripts/powershell/discover-context.ps1
---

## Goal

Discover relevant personas, rules, examples, and skills from team-ai-directives that apply to the current feature being specified or planned.

## Discovery Process

### Step 1: Load Feature Context

Read the feature description from:
- Environment variable: `SPECIFY_FEATURE_DESCRIPTION` (if set)
- Context file: `{REPO_ROOT}/specs/{SPECIFY_FEATURE}/context.md`
- Spec file: `{REPO_ROOT}/specs/{SPECIFY_FEATURE}/spec.md`

### Step 2: Extract Keywords

From the feature description, extract:
- **Domain keywords**: Business domain terms (e.g., "payment", "authentication", "analytics")
- **Technology keywords**: Tech stack terms (e.g., "API", "database", "frontend", "microservice")
- **Pattern keywords**: Architectural patterns (e.g., "CQRS", "event-driven", "REST")
- **Action keywords**: Feature actions (e.g., "create", "validate", "sync", "process")

### Step 3: Scan team-ai-directives

Scan these directories relative to `${SPECIFY_TEAM_DIRECTIVES}`:

1. **constitutions/** or **constitution.md** - Always include
2. **personas/** - Match to domain keywords
3. **rules/** - Match to technology and pattern keywords
4. **examples/** - Match to similar feature types
5. **skills/** - Check `.skills.json` for relevant skills

### Step 4: Score and Rank

For each discovered item:
- Calculate relevance score (0.0 to 1.0) based on keyword overlap
- Include items with score >= 0.3
- Sort by relevance (highest first)
- Limit to top 5 per category

### Step 5: Output

Output structured discovery results:

```json
{
  "constitution": "/path/to/constitution.md",
  "personas": [
    {"name": "Admin User", "file": "personas/admin.md", "score": 0.85}
  ],
  "rules": [
    {"name": "API Security", "file": "rules/api-security.md", "score": 0.92}
  ],
  "examples": [
    {"name": "Payment Flow", "file": "examples/payment-flow.md", "score": 0.78}
  ],
  "skills": [
    {"id": "speckit-adlc-security-auth", "name": "Security Auth", "required": true}
  ],
  "search_metadata": {
    "keywords": ["payment", "api", "security"],
    "files_searched": 42,
    "files_with_matches": 8
  }
}
```

## Failure Handling

If team-ai-directives is not configured:
1. Check for `${SPECIFY_TEAM_DIRECTIVES}` environment variable
2. Check init-options.json for `team_ai_directives` path
3. If not found, output empty results and exit with code 0 (don't fail the operation)

If discovery fails:
- Output error to stderr
- Exit with code 1 (will block specify/plan commands since hooks are mandatory)

## Usage in Preset Commands

The preset commands (`spec.specify`, `spec.plan`) will:
1. Execute this hook before running
2. Parse the JSON output
3. Inject discovered context into the feature context template
