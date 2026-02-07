# The team-ai-directives Repository

## The Central Library for Version-Controlled Agent Behavior

The team-ai-directives repository is the practical codification of
**Factor XI: Directives as Code**. It is the central, version-controlled library
that houses the collective AI-related intelligence of our engineering team.
It serves as the single source of truth for all reusable components that guide
our AI agents, consumed directly by **Agentic SDLC spec-kit CLI** and any
**Orchestration Hub (MCP Server) implementation**.

## Core Philosophy

The repository's philosophy is centered on serving a central system,
not individual developers.

1. **A Library for a Service:** This repository's sole purpose is to store
   the "what"—the canonical, version-controlled context modules.
   The "how" and "why" of a specific task—the Mission Brief—lives in our
   issue tracker and is orchestrated by the **spec-kit CLI**
   (and any MCP server), which fetches the necessary modules from a
   **local clone of this library** on-demand.

2. **The System of Record for Guidance:** This repository stores the building
   blocks of agentic guidance. The CLI and MCP server assemble these blocks
   based on a Mission Brief to guide an agent. This separation is critical:
   * The **Repository** is for stable, reusable, versioned knowledge.
   * The **Orchestration Layer** (spec-kit CLI, MCP server, or other automation)
     is for dynamic, task-specific assembly and execution.

3. **Controlled Local Replication**: Each project maintains a local checkout
   (e.g., `.specify/memory/team-ai-directives` or a configured path exported
   via `SPECIFY_TEAM_DIRECTIVES`). Scripts and CLI commands pull from that
   checkout so every agent session—autonomous or human supervised—operates
   with identical directives.

## Repository Layout

```text
team-ai-directives/
├── README.md                  # Overview of the repository's purpose,
│                              # layout, and usage instructions.
├── CONTRIBUTING.md            # Guidelines for contributing, PR processes,
│                              # code standards, and governance rules.
├── CHANGELOG.md               # Log of changes for each version tag,
│                              # documenting updates and breaking changes.
├── .mcp.json                  # Configuration manifest for the platform,
│                              # defining approved agents and tools.
├── .skills.json               # Skills Package Manager manifest:
│                              # required/recommended/internal/blocked
│                              # skills, registry, and policies.
├── context_modules/           # The "Library": versioned, consumable
│   │                          # context modules for spec-kit CLI.
│   ├── constitution.md        # The foundational "Why": non-negotiable
│   │                          # engineering principles.
│   ├── rules/                 # Guidelines for style, security,
│   │   │                      # testing, and architecture.
│   │   ├── style_guides/
│   │   ├── security/
│   │   └── testing/
│   ├── examples/              # High-quality code examples serving as
│   │   │                      # "gold standard" for AI to follow.
│   │   ├── testing/
│   │   └── prompts/
│   └── personas/
└── skills/                    # Specialized capabilities and tools.
```

## Directory Functions

### Top-Level Files

* **README.md:** This file. Provides an overview of the repository's purpose,
  layout, and usage instructions for contributors and consumers.
* **CONTRIBUTING.md:** Guidelines for contributing to the repository,
  including pull request processes, code standards, and governance rules.
* **CHANGELOG.md:** A log of changes for each version tag, documenting
  updates, fixes, and breaking changes to support versioning.
* **.mcp.json:** Configuration manifest for the platform, defining approved
  autonomous agents and specialized tools.

### Context Modules

* **context_modules/:** The "Library": The versioned, consumable "How".
  Contains canonical context modules for the spec-kit CLI and MCP server.
* **context_modules/constitution.md:** The single, foundational "Why".
  Contains the non-negotiable engineering principles that govern all
  AI behavior.
* **context_modules/rules/:** Explicit guidelines for style, security
  standards, testing practices, and architectural patterns.
* **context_modules/examples/:** High-quality code examples that serve as a
  "gold standard" for the AI to follow, including testing and reusable prompts.
* **context_modules/personas/:** Pre-defined AI personalities tailored for
  specific tasks (e.g., "senior python developer," "security expert").

### Skills

* **skills/:** Specialized capabilities and tools available to agents.
* **.skills.json:** Team skills manifest for the Skills Package Manager.
  Defines required, recommended, internal, blocked skills, and a discoverable
  registry.

#### Skills Ecosystem

The skills subsystem provides intelligent discovery and context scaffolding:

* **Skill Discovery**: Agents discover relevant skills based on feature
  descriptions using LLM matching
* **Progressive Refinement**: Skills are refined during `/speckit.specify` →
  `/speckit.plan` workflow
* **Feature-Scoped Context**: Each feature gets its own
  `specs/{feature}/skills.md` that scaffolds implementation
* **Multi-Skill Orchestration**: Wrapper documentation shows how multiple
  skills work together
* **Skill Registry**: Discover additional skills in `.skills.json` registry
  section for manual installation

#### Skills Package Manager Integration

This repository integrates with the **Agentic SDLC Skills Package Manager**
via `.skills.json`:

* **Required Skills**: Auto-installed during `specify init`
  (e.g., `dbt-template`)
* **Recommended Skills**: Suggested to users but optional
  (e.g., `devops-engineer`, external React best practices)
* **Internal Skills**: Local team skills in `skills/` directory
* **Blocked Skills**: Disallowed skills prevented from installation
* **Registry**: Additional discoverable skills available for manual installation
* **Policy Settings**: Control auto-installation and enforcement behavior

When a project initializes with `--team-ai-directives`,
the Skills Package Manager:

1. Reads `.skills.json` from this repository
2. Auto-installs required skills to `.specify/skills/`
3. Shows recommended skills to users
4. Enforces blocked skill policies

##### How Skills Work

**Skills** are reusable, versioned knowledge packages that guide AI agents
in making consistent technical decisions. They embed:

* **Best Practices** - Framework patterns, testing strategies, code
  organization
* **Team Standards** - Coding conventions, naming patterns, architectural
  principles
* **Domain Knowledge** - Business logic, compliance requirements, domain
  patterns
* **Quality Guidelines** - Performance optimization, security hardening,
  accessibility

**Auto-Discovery Flow**:

1. User runs `/speckit.specify "Build a React component with TypeScript"`
2. Skills Package Manager analyzes the feature description
3. Calculates relevance score for each installed skill (60% description
   match, 40% content match)
4. Injects top 3 matching skills into `specs/{feature}/context.md`
5. AI agent follows skill guidance during `/speckit.plan` and
   `/speckit.implement`

**Example** - When creating a React feature:

```markdown
## Relevant Skills (Auto-Detected)

- **react-best-practices**@1.2.0 (confidence: 0.95)
  - Component composition, hooks patterns, performance optimization

- **typescript-guidelines**@1.0.0 (confidence: 0.82)
  - Type safety, interface design, error handling

- **testing-strategies**@2.0.1 (confidence: 0.78)
  - Test organization, coverage targets, component testing patterns
```

##### Managing Team Skills

As a team admin, you control which skills are available:

* **required** - Team-wide practices everyone must follow
* **recommended** - Encouraged but optional skills
* **internal** - Custom skills built by your team (in `skills/` directory)
* **blocked** - Deprecated or unsafe skills that prevent installation

Example `.skills.json` configuration:

```json
{
  "version": "1.0.0",
  "source": "team-ai-directives",
  "skills": {
    "required": {
      "github:vercel-labs/agent-skills/react-best-practices": "^1.2.0",
      "github:your-org/internal-skills/company-patterns": "~2.0.0"
    },
    "recommended": {
      "github:vercel-labs/agent-skills/web-design-guidelines": "~1.0.0"
    },
    "internal": {
      "local:./skills/dbt-workflow": "*"
    },
    "blocked": [
      "github:unsafe-org/deprecated-skill"
    ]
  },
  "policy": {
    "auto_install_required": true,
    "enforce_blocked": true,
    "allow_project_override": true
  }
}
```

##### Available CLI Commands

Team members can manage skills via the `specify skill` command:

```bash
# Search for skills in the public registry
specify skill search "react best practices"

# Install a skill from GitHub
specify skill install github:vercel-labs/agent-skills/react-best-practices

# List installed skills
specify skill list

# Evaluate skill quality (100-point scoring)
specify skill eval ./my-skill --review

# Sync with team manifest
specify skill sync-team --dry-run

# Update skills
specify skill update --all
```

See [.skills.json](.skills.json) for current team skill configuration and
[Skills Package Manager Documentation](https://github.com/tikalk/agentic-sdlc-spec-kit#-skills-package-manager)
for detailed information.

### Versioning

* **A Note on Versioning:** Treating our directives as a versioned library is
  non-negotiable. We use git tags (v1.0.0, v2.0.0, etc.) to manage breaking
  changes gracefully and support multiple standards across different projects.

## Usage

Point your Agentic SDLC Spec Kit or orchestration tooling at this repository
to resolve `@team/...` references. Use git tags (v1.0.0, v2.0.0, etc.) when
evolving personas, examples, or rules so downstream consumers can opt in to
breaking changes safely.

## Governance and Contribution

This repository is a living asset, maintained by the **AI Development Guild**.
It is treated with the same rigor as our production code.

* All changes must be submitted via a Pull Request.
* The PR process is defined in CONTRIBUTING.md and requires peer review.
* This structured process ensures that all contributions are high-quality,
  align with our team's standards, and are well-documented before becoming
  part of our official library, guaranteeing downstream automation
  (spec-kit CLI, MCP, IDE scripts) remains trustworthy.
