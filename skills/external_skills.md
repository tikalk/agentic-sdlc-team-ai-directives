# External Skills Registry

Curated collection of external skills available for use in projects. External skills are referenced by URL and fetched on-demand by spec-kit when needed.

## How External Skills Work

1. **Discovery**: Spec-kit scans this registry and matches skills to your feature description using LLM
2. **Selection**: You choose which external skills to use
3. **Fetch**: Spec-kit uses the agent's webfetch tool to fetch the SKILL.md from the external URL
4. **Context**: The fetched skill is injected into your workflow context
5. **Usage**: You can reference the skill during `/speckit.plan` and `/speckit.implement`

## Available External Skills

### Frontend

#### React Best Practices
- **Source**: https://github.com/vercel-labs/agent-skills
- **Skill URL**: https://raw.githubusercontent.com/vercel-labs/agent-skills/main/skills/react-best-practices/SKILL.md
- **Description**: React and Next.js performance optimization guidelines from Vercel Engineering. Contains 40+ rules across 8 categories prioritized by impact. Use when writing React components, optimizing performance, or reviewing code for best practices.
- **Categories**: Performance optimization, bundle size, server-side rendering, client-side data fetching, re-render optimization

#### Web Design Guidelines
- **Source**: https://github.com/vercel-labs/agent-skills
- **Skill URL**: https://raw.githubusercontent.com/vercel-labs/agent-skills/main/skills/web-design-guidelines/SKILL.md
- **Description**: Review UI code for compliance with web interface best practices. Audits your code for 100+ rules covering accessibility, performance, and UX. Use when reviewing UI, checking accessibility, or auditing design.
- **Categories**: Accessibility, focus states, forms, animation, typography, images, performance, navigation

#### Composition Patterns
- **Source**: https://github.com/vercel-labs/agent-skills
- **Skill URL**: https://raw.githubusercontent.com/vercel-labs/agent-skills/main/skills/composition-patterns/SKILL.md
- **Description**: React composition patterns that scale. Helps avoid boolean prop proliferation through compound components, state lifting, and internal composition. Use when refactoring components or building reusable libraries.
- **Categories**: Compound components, state lifting, component architecture

### Mobile

#### React Native Guidelines
- **Source**: https://github.com/vercel-labs/agent-skills
- **Skill URL**: https://raw.githubusercontent.com/vercel-labs/agent-skills/main/skills/react-native-guidelines/SKILL.md
- **Description**: React Native best practices optimized for AI agents. Contains 16 rules across 7 sections covering performance, architecture, and platform-specific patterns. Use when building React Native or Expo apps.
- **Categories**: Performance, layout, animation, images, state management, architecture, platform-specific

### DevOps

#### Vercel Deploy (Claimable)
- **Source**: https://github.com/vercel-labs/agent-skills
- **Skill URL**: https://raw.githubusercontent.com/vercel-labs/agent-skills/main/skills/vercel-deploy-claimable/SKILL.md
- **Description**: Deploy applications and websites to Vercel instantly. Designed for use with claude.ai and Claude Desktop to enable deployments directly from conversations. Deployments are "claimable" - users can transfer ownership to their own Vercel account.
- **Categories**: Deployment, CI/CD, hosting

## Adding External Skills

To add a new external skill to this registry:

1. Ensure the skill follows the [Agent Skills](https://agentskills.io/) format
2. Verify the SKILL.md URL is publicly accessible
3. Create a PR with a new entry in this file
4. Include:
   - Source repository URL
   - Direct SKILL.md URL (for webfetch)
   - Clear description with trigger keywords
   - Relevant categories

## Skill Format Requirements

External skills must follow the vercel-labs structure:

```
skills/{skill-name}/
  SKILL.md              # Required: skill definition with frontmatter
  scripts/              # Optional: executable scripts
    {script-name}.sh
  references/           # Optional: supporting documentation
```

**SKILL.md frontmatter:**
```yaml
---
name: skill-name
description: One sentence with trigger keywords like "Deploy my app", "Review UI", etc.
---
```

## Contributing to External Skills

If you maintain an external skill repository:

1. Follow the [Agent Skills](https://agentskills.io/) format
2. Keep SKILL.md under 500 lines (use progressive disclosure)
3. Write specific descriptions with trigger keywords
4. Ensure the skill works standalone (no external dependencies at runtime)
5. Test with multiple agents (Claude Code, Cursor, Copilot, etc.)
6. Submit a PR to add your skill to this registry

## Notes

- External skills are fetched fresh each time (always up-to-date)
- Private repositories require authentication (SSH keys)
- Skills are cached for the session to improve performance
- Spec-kit uses the agent's webfetch tool (no custom implementation needed)