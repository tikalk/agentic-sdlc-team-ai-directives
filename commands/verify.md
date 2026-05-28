---
description: Verify team-ai-directives installation and health check
---

## Goal

Verify that team-ai-directives is properly installed and healthy.

## Verification Checks

### Check 1: Context Modules exist

1. Locate extension root via `.specify/extensions/.registry` (see constitution command for method)
2. Verify:
   - `{EXTENSION_ROOT}/context_modules/constitution.md`
   - `{EXTENSION_ROOT}/context_modules/personas/`
   - `{EXTENSION_ROOT}/context_modules/rules/`
   - `{EXTENSION_ROOT}/context_modules/examples/`

Output: `[OK]` or `[FAIL]` with reason

### Check 2: Skills registry

- `{EXTENSION_ROOT}/.skills.json` exists and is valid JSON

Output: `[OK]` or `[FAIL]` with reason

### Check 3: CDR tracking

- `{EXTENSION_ROOT}/CDR.md` exists

Output: `[OK]` or `[FAIL]` with reason

### Check 4: Constitution Alignment

1. Read team constitution from `{EXTENSION_ROOT}/context_modules/constitution.md`
2. Locate project constitution: `{REPO_ROOT}/.specify/memory/constitution.md`
3. If project constitution exists:
   - Check if it references team-ai-directives (e.g., "Based on team-ai-directives", "Inherits from")
   - Check if team principles are present in project constitution (compare principle titles)
   - Output:
     - `[OK]` - Project constitution exists and inherits team principles
     - `[WARN]` - Project constitution exists but missing team inheritance
4. If project constitution doesn't exist:
   - `[INFO]` - Project constitution doesn't exist yet (first-time setup)

### Check 5: Version Consistency (Warning Only)

1. Read `{EXTENSION_ROOT}/extension.yml` → extract `extension.version`
2. Read `{EXTENSION_ROOT}/extensions/catalog.json` → extract `extensions.*.version`
3. Compare versions
4. Output:
   - `[OK]` - Versions match
   - `[WARN]` - Version mismatch: extension.yml=X, catalog.json=Y
   - `[INFO]` - Run 'adlc.team-ai-directives.release' to fix

This check does NOT fail the verification, only warns.

## Output

Print verification status for each check:
- `[OK]` - Check passed
- `[FAIL]` - Check failed with reason
- `[WARN]` - Check passed with warnings (non-blocking)
- `[INFO]` - Informational only

**Exit codes:**
- 0 - All checks passed (including warnings)
- 1 - One or more checks failed
