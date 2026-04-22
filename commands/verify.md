---
description: Verify team-ai-directives installation and health check
---

## Goal

Verify that team-ai-directives is properly installed and healthy.

## Verification Checks

1. **Context Modules exist**:
   - `context_modules/constitution.md`
   - `context_modules/personas/`
   - `context_modules/rules/`
   - `context_modules_examples/`

2. **Skills registry**: `.skills.json` exists and is valid

3. **CDR tracking**: `CDR.md` exists

4. **Constitution alignment**: Project constitution inherits from team principles

## Verification Details

### Check 1-3: Standard Infrastructure

Run these checks as before:
- `[OK]` - Check passed
- `[FAIL]` - Check failed with reason

### Check 4: Constitution Alignment

1. Locate project constitution: `{REPO_ROOT}/.specify/memory/constitution.md`
2. If file exists, check for team source reference (e.g., "Based on team-ai-directives", "Inherits from")
3. Parse principles - team constitution has 12 core principles
4. Output:
   - `[OK]` - Project constitution exists and references team source
   - `[WARN]` - Project constitution exists but no team source reference (missing inheritance)
   - `[OK]` - Project constitution doesn't exist yet (not required, first-time setup)

## Output

Print verification status for each check:
- `[OK]` - Check passed
- `[FAIL]` - Check failed with reason
- `[WARN]` - Check passed with warnings