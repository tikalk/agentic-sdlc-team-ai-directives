# Team AI Directives Starter Kit

A forkable foundation for version-controlled AI agent behavior.

**Built on the [Twelve-Factor Agentic SDLC](https://github.com/tikalk/agentic-sdlc-12-factors)** — this repository implements Factor XI: Directives as Code, treating all AI instructions as version-controlled assets.

**Quick Start:** See [GETTING_STARTED.md](GETTING_STARTED.md) for a 5-minute setup guide.

## Who This Is For

- Engineering teams wanting consistent AI agent behavior
- Platform teams building developer self-service with AI
- Consultancies creating reusable AI patterns across clients
- Organizations adopting the Agentic SDLC methodology

## What's Included

This repository provides the building blocks for teaching AI agents how your team works:

- **Constitution** - Core principles that govern all AI behavior
- **Personas** - Role-specific guidance (DevOps, Java, Python, Data, Platform)
- **Rules** - Domain-specific patterns (security, testing, style guides)
- **Skills** - Self-contained capabilities with trigger-based activation

## Repository Layout

```text
team-ai-directives/
├── AGENTS.md                  # Instructions for AI agents on how to use this repo
├── README.md                  # This file (for humans)
├── GETTING_STARTED.md         # Quick start guide
├── CONTRIBUTING.md            # Contribution guidelines
├── CHANGELOG.md               # Version history
├── .mcp.json                  # MCP server configuration
├── .skills.json               # Skills registry and policy
├── context_modules/           # The knowledge library
│   ├── constitution.md        # Core principles
│   ├── personas/              # Role-specific guidance
│   ├── rules/                 # Domain-specific patterns
│   │   ├── style_guides/
│   │   ├── security/
│   │   └── testing/
│   └── examples/              # Code examples and prompt templates
│       ├── testing/
│       └── prompts/
└── skills/                    # Self-contained agent capabilities
    └── {skill-name}/
        ├── SKILL.md           # Main instructions with YAML frontmatter
        ├── references/        # Supporting content
        └── scripts/           # Automation (optional)
```

## How It Works

1. **AI agents read `AGENTS.md`** for instructions on using this repo
2. **Constitution** provides foundational principles
3. **Personas** provide role-specific guidance with rule references
4. **Skills** are triggered by user requests (matched via `.skills.json`)
5. **Rules** are accessed through personas, not directly from skills

## Versioning

Use git tags (v1.0.0, v2.0.0, etc.) to manage breaking changes. Downstream consumers can pin to specific versions.

## Customization

Fork this repository and customize:

1. **Constitution** - Add your team's principles
2. **Personas** - Define roles matching your team
3. **Rules** - Add domain-specific patterns
4. **Skills** - Create capabilities for your workflows
5. **`.mcp.json`** - Configure your MCP servers
6. **`.skills.json`** - Register your skills

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines. All changes require pull request review.
