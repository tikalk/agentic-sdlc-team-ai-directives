# Getting Started

A 5-minute guide to setting up your team AI directives.

## 1. Fork & Clone

```bash
git clone git@github.com:YOUR_ORG/team-ai-directives.git
cd team-ai-directives
```

## 2. Configure MCP

Edit `.mcp.json` to add your tools (GitHub, GitLab, Linear, etc.)

## 3. Customize

- `context_modules/constitution.md` - Add your team principles
- `context_modules/personas/` - Define your team roles
- `skills/` - Add your capabilities

## 4. Create a Skill

```bash
mkdir -p skills/my-skill
```

Create `skills/my-skill/SKILL.md`:

```yaml
---
name: my-skill
description: What it does. Use when user asks to [trigger phrases].
---

# My Skill

## Instructions
[Your instructions here]
```

## 5. Test

Ask your AI agent: "What skills are available?"

## Resources

- `AGENTS.md` - How agents use this repo
- `.skills.json` - Skills registry
- `context_modules/constitution.md` - Core principles
