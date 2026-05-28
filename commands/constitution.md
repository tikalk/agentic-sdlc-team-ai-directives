---
description: Discover and load team constitution principles before project constitution update
---

## Goal

Load team constitution from team-ai-directives to inherit principles BEFORE updating the project constitution. Output is auto-populated into agent context.

## Discovery Process

### Step 1: Locate Extension Root

Read `.specify/extensions/.registry` (JSON) and find the `team-ai-directives` entry.

- If `source` is `"reference"`: use the `path` field as the extension root.
- If `source` is `"local"` or `"bundled"`: use `.specify/extensions/team-ai-directives` as the extension root.
- If not found: output warning and exit.

### Step 2: Read Version

Read `{EXTENSION_ROOT}/extension.yml` and extract `extension.version`.

### Step 3: Read Constitution

Read `{EXTENSION_ROOT}/context_modules/constitution.md`.

### Step 4: Output (Auto-populate Context)

Output exactly:

```markdown
## Team Constitution Principles (Loaded from team-ai-directives)

**Source**: team-ai-directives
**Version**: {version from Step 2}

{full contents of context_modules/constitution.md from Step 3}
```

## Usage

Automatically executed via **before_constitution** hook (optional: false).

## Failure Handling

If constitution files cannot be read:
1. Output a warning notice
2. Include `**Warning**: Team constitution not found in team-ai-directives`
3. Exit successfully (code 0) - don't block the preset command
