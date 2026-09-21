# Team AI Directives Starter Kit

A forkable foundation for version-controlled AI agent behavior.

**Built on the [Twelve-Factor Agentic SDLC](https://github.com/tikalk/agentic-sdlc-12-factors)** — this repository implements Factor XI: Directives as Code, treating all AI instructions as version-controlled assets.

**How the pieces fit:**

- **[12-Factor Agentic SDLC](https://github.com/tikalk/agentic-sdlc-12-factors)** — the methodology (strategic mindset, structured planning, directives as code, traceability)
- **This repo** — the version-controlled team knowledge base (constitution, personas, rules, skills, CDRs)
- **[agentic-sdlc-spec-kit](https://github.com/tikalk/agentic-sdlc-spec-kit)** — the Spec-Driven Development toolkit; consumes this knowledge base via the bundled `team-ai-directives` extension
- **[adlc-team-skills](https://github.com/tikalk/adlc-team-skills)** — agent skills that implement the methodology; consume this knowledge base via `team-*` and `levelup-*` skills

**Quick Start:** See [GETTING_STARTED.md](GETTING_STARTED.md) for a 5-minute setup guide.

## Installation

This knowledge base is consumed in two ways at runtime — pick the one that matches your project setup. Fork and clone for authoring and customization.

### Option 1: Spec Kit Projects

For projects managed with the [Agentic SDLC Spec Kit](https://github.com/tikalk/agentic-sdlc-spec-kit), install via the `specify` CLI using the `--team-ai-directives` flag:

```bash
# Initialize project with team-ai-directives
specify init <project> --team-ai-directives https://github.com/your-org/team-ai-directives.git
```

The Specify CLI installs the bundled `team-ai-directives` extension (governance commands and skills) and copies this repository's `default` domain skills into the agent's skills directory. Context modules are referenced through the `agent-context` extension.

```bash
# Or from a specific release tag
specify init <project> --team-ai-directives https://github.com/your-org/team-ai-directives/archive/refs/tags/v1.3.0.zip
```

### Option 2: Any Skills-Capable Agent

For agents that support the [Agent Skills standard](https://agentskills.io) (Claude Code, Codex, OpenCode, Cursor, Gemini, and others), install the governance and architecture skills from [adlc-team-skills](https://github.com/tikalk/adlc-team-skills):

```bash
npx skills add tikalk/adlc-team-skills
```

Then invoke the `team-setup` skill in your project to clone, point at, or scaffold this knowledge base. The skills locate it via `.adlc/init-options.json` or the `ADLC_TEAM_AI_DIRECTIVES` environment variable.

### Option 3: Authoring (Fork and Clone)

Fork this repository and clone it locally to customize the knowledge base itself:

```bash
git clone https://github.com/your-org/team-ai-directives.git
cd team-ai-directives
```

Then reference it in your project initialization or configuration.

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
├── CDR.md                     # Context Directive Records (approved contributions)
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

## File Format

All directives (rules, personas, examples, skills) published via LevelUp include **YAML frontmatter** for memory management:

```yaml
---
id: rule-python-error-handling
cdr_ref: CDR-2026-001
created: 2026-04-15
modified: 2026-05-18
verified: 2026-05-18
age_days: 33
evidence:
  - commit: abc123
    file: src/error_handler.py
---
```

### Frontmatter Fields

| Field | Description | Example |
|-------|-------------|---------|
| `id` | Unique identifier | `rule-python-error-handling` |
| `cdr_ref` | Source CDR reference | `CDR-2026-001` |
| `created` | Original publication date | `2026-04-15` |
| `modified` | Last edit date | `2026-05-18` |
| `verified` | Last verification date | `2026-05-18` |
| `age_days` | Days since creation | `33` |
| `evidence` | List of supporting commits/files | YAML list |

### Freshness Warning

Published directives include a verification banner:

```markdown
> ⚠️ **Memory Verification**
> This directive is 33 days old. Before applying:
> - [ ] Pattern still exists in current codebase
> - [ ] Rule is actively followed by team
> - [ ] No conflicting rules introduced
```

### Verification Workflow

1. Scan the knowledge base — `/levelup.validate` in spec-kit projects, or `team-repair --freshness` / `team-repair --conflicts` in skills-based projects
2. Valid directives get their `verified` timestamp updated
3. Stale directives (>30 days) are flagged for review
4. Update or deprecate stale directives as needed

See [CONTRIBUTING.md](CONTRIBUTING.md) for the full verification workflow.

## How It Works

1. **AI agents read `AGENTS.md`** for instructions on using this repo
2. **Constitution** provides foundational principles
3. **Personas** provide role-specific guidance with rule references
4. **Skills** are triggered by user requests (matched via `.skills.json`)
5. **Rules** are accessed through personas, not directly from skills

### Two Delivery Mechanisms

The same knowledge base is consumed through two complementary mechanisms:

- **Spec Kit extension** — governance commands (canonical names `adlc.team-ai-directives.*`, invoked via short aliases like `team.discover`). Hooks auto-run `team.discover` before `specify` and `plan`. The knowledge base path is stored in `.specify/init-options.json`.
- **Agent Skills ([adlc-team-skills](https://github.com/tikalk/adlc-team-skills))** — model-invoked skills following the [Agent Skills standard](https://agentskills.io). `team-boot` auto-loads the constitution at session start; `team-discover` auto-finds relevant context per task. The knowledge base path is resolved from `.adlc/init-options.json` or the `ADLC_TEAM_AI_DIRECTIVES` environment variable.

Both mechanisms read the same files — `AGENTS.md`, `CDR.md`, `.skills.json`, and `context_modules/` — and can coexist in one project.

---

## Personas

Personas define the role, expertise, preferences, and rule references that shape how an AI agent behaves for a given engineering context. Loading a persona tells the agent _who_ it is for this session — its values, collaboration style, and which domain-specific rules to apply.

### How Personas Work

When an agent begins a session, it loads context in this order:

1. **Constitution** (`context_modules/constitution.md`) — non-negotiable team principles applied to every interaction.
2. **Persona** (`context_modules/personas/*.md`) — role-specific defaults, rules, and collaboration style.
3. **Skills** (`skills/*/SKILL.md`) — on-demand capabilities triggered by the user's request.

A persona sits between the universal constitution and the task-specific skill. It tells the agent:
- What domain knowledge to prioritize
- Which rule files are relevant to its role
- How to collaborate (communication style, review preferences, workflow assumptions)
- Agent-specific guidance (e.g., always propose infra changes as code)

Personas are **passive by default** — they don't activate automatically unless your tooling or prompt instructs the agent to load one. You attach a persona to an agent through your IDE settings, a system prompt, or a prompt prefix.

### Persona Folder Structure

All personas live in `context_modules/personas/`:

```
context_modules/personas/
├── cloud_native_platform_architect.md
├── data_analyst.md
├── devops_engineer.md
├── senior_java_developer.md
└── senior_python_developer.md
```

Each persona is a single Markdown file. There is no sub-folder nesting — one file per role.

### Persona File Anatomy

A well-formed persona file contains some or all of the following sections:

#### `# Persona: <Name>` (required)

The heading names the persona. Agents use this as the persona identifier.

```markdown
# Persona: DevOps Engineer
```

#### `## Summary` (required)

Describes the persona's **motivation**, **pain points**, and **success criteria**. This is the first context an agent reads to understand its role.

```markdown
## Summary
- **Motivation**: Enable reliable, scalable, and secure software delivery through automation, IaC, and observability.
- **Pain Points**: Manual deployments, configuration drift, lack of visibility.
- **Success Criteria**: Fully automated CI/CD pipelines, declarative infrastructure, secure secret management.
```

#### `## Rule References` (recommended)

Links the persona to domain-specific rule files using the `@rule:<path>` syntax. Agents resolve these paths relative to `context_modules/rules/`.

```markdown
## Rule References
- CI/CD Pipelines: @rule:devops/github_actions.md
- Secrets Management: @rule:devops/external_secrets_operator.md, @rule:devops/secrets_management_dry.md
- Testing: @rule:testing/python/pytest_patterns.md
```

#### `## Collaboration Preferences` (recommended)

Describes how the persona prefers to work: communication style, review expectations, workflow assumptions, and advocacy positions.

```markdown
## Collaboration Preferences
- Prefers infrastructure changes reviewed through pull requests with clear descriptions
- Values declarative configurations over imperative scripts
- Expects "everything as code" — infrastructure, configs, and pipelines in version control
```

#### `## Tool Context` (optional)

Lists the tooling ecosystem this persona operates in. Helps agents make appropriate technology choices without asking the user every time.

```markdown
## Tool Context
- CI: GitHub Actions, GitLab CI
- CD/GitOps: ArgoCD, Flux
- IaC: Terraform, Crossplane
- Secrets: HashiCorp Vault, AWS Secrets Manager
```

#### `## Guidance for Agents` (optional)

Explicit behavioral instructions for agents taking actions on behalf of this persona.

```markdown
## Guidance for Agents
- Always propose infrastructure changes as code, never manual operations
- When working with secrets, always use secret management services — never hardcode or commit secrets
- Always consider disaster recovery, backup strategies, and rollback procedures
```

### Built-In Personas

| File | Persona | Primary Domain |
|---|---|---|
| `senior_python_developer.md` | Senior Python Developer | Python, PEP 8, testing, CI/CD |
| `senior_java_developer.md` | Senior Java Developer | Java, Spring Boot, JUnit 5, Google Style |
| `devops_engineer.md` | DevOps Engineer | CI/CD, Helm, IaC, secrets management, GitOps |
| `cloud_native_platform_architect.md` | Cloud-Native Platform Architect | Kubernetes, Crossplane, ArgoCD, platform engineering |
| `data_analyst.md` | Data Analyst | SQL, dashboards, reproducible reporting, large datasets |

Each built-in persona is self-contained and production-ready. Fork and adjust them to match your team's specific tooling and standards.

### Creating a Custom Persona

1. Create a new file in `context_modules/personas/`:

   ```bash
   touch context_modules/personas/my_role.md
   ```

2. Add the following template and fill it in:

   ```markdown
   # Persona: My Role

   ## Summary
   - **Motivation**: [What drives this role]
   - **Pain Points**: [What slows them down]
   - **Success Criteria**: [What good looks like]

   ## Rule References
   - [Domain]: @rule:[domain]/[rule-file].md

   ## Collaboration Preferences
   - [How this persona prefers to work]

   ## Tool Context
   - [Tools and platforms this persona uses]

   ## Guidance for Agents
   - [Behavioral instructions for autonomous actions]
   ```

3. Reference any applicable rule files from `context_modules/rules/`. Browse the available rules:

   ```
   context_modules/rules/
   ├── architecture/
   ├── data/
   ├── devops/
   ├── orchestration/
   ├── security/
   ├── style-guides/
   │   ├── java/
   │   └── python/
   └── testing/
       ├── java/
       └── python/
   ```

4. Attach the persona in your agent configuration.

### Using Personas

#### Option A: IDE Custom Instructions (GitHub Copilot)

In VS Code with GitHub Copilot, add the persona content directly to a `.github/copilot-instructions.md` file or reference it in your workspace settings:

```json
// .vscode/settings.json
{
  "github.copilot.chat.codeGeneration.instructions": [
    { "file": "context_modules/personas/devops_engineer.md" }
  ]
}
```

#### Option B: System Prompt Prefix

Prepend the persona content to your agent's system prompt:

```
[Load persona: context_modules/personas/devops_engineer.md]

User request: ...
```

#### Option C: Prompt Reference at Session Start

Tell the agent explicitly which persona to adopt at the start of a conversation:

```
You are acting as the DevOps Engineer persona defined in
context_modules/personas/devops_engineer.md. Load that file
and apply it to all responses in this session.
```

### Personas vs. Skills

| | Persona | Skill |
|---|---|---|
| **Purpose** | Defines _who_ the agent is | Defines _what_ the agent can do |
| **Scope** | Entire session | Triggered per task |
| **Location** | `context_modules/personas/` | `skills/*/SKILL.md` |
| **Activation** | Loaded at session start | Loaded on-demand by trigger phrases |
| **Registered in `.skills.json`?** | No | Yes |
| **Contains rules?** | References rules via `@rule:` | May embed rules inline |

A persona provides the stable identity and preferences for a session. Skills provide the domain-specific execution instructions for individual tasks. They complement each other and are both loaded alongside the constitution.

---

## Skills

Skills are self-contained, reusable AI agent capabilities. Each skill packages a domain's instructions, context, and optional automation so an AI agent can reliably apply it on demand without requiring the user to supply background knowledge each time.

### How Skills Work

When a user makes a request, an agent:

1. Reads `.skills.json` to discover available skills.
2. Matches the user's intent against each skill's `description` and trigger phrases.
3. Loads the relevant `SKILL.md` to obtain domain-specific instructions.
4. Optionally loads files from `references/` for deeper context.
5. Applies the skill while completing the task.

Skills are loaded **on-demand** — only the skills relevant to the current request are activated. Default skills listed in `.skills.json` are auto-installed into the agent's skills directory during project init.

### Skill Folder Structure

All internal skills live under `skills/{skill-name}/`:

```
skills/
└── my-skill/
    ├── SKILL.md          # Required — primary instructions for the agent
    ├── references/       # Optional — supplementary reference documents
    │   ├── guide.md
    │   └── patterns.md
    └── scripts/          # Optional — automation scripts for the skill
        └── setup.sh
```

#### `SKILL.md`

The entry point for every skill. It uses a YAML front matter block to declare metadata, followed by Markdown instructions:

```yaml
---
name: my-skill
description: >
  Short description of the skill's purpose.
  Use when [trigger phrases that describe when to activate this skill].
---

# My Skill

## What This Skill Provides
...

## When to Use This Skill
...

## Core Patterns
...
```

The `description` field is critical — it tells the agent **when** to activate the skill. Write it in natural language and include representative phrases a user might say.

### The `.skills.json` Manifest

`.skills.json` is the single source of truth for skill discovery and policy. It defines which local skills are auto-installed during project init, which external skills are available on demand, and which skills are blocked.

```json
{
  "version": "2.0.0",
  "source": "team-ai-directives",
  "description": "Team skills manifest. The `default` list contains skill names that are auto-installed during project init. The `external` map contains on-demand skills fetched by URL. The `blocked` list contains skills that must never be installed.",
  "default": [ ... ],
  "external": { ... },
  "blocked": [ ... ],
  "policy": { ... }
}
```

#### Skill Categories in `.skills.json`

| Category | Meaning |
|---|---|
| `default` | Local skills (from this repository's `skills/` directory) auto-installed into the agent's skills directory during project init |
| `external` | Skills fetched on demand from a URL; not stored locally |
| `blocked` | Skills explicitly prohibited; the agent must refuse to use them |

#### Skill Entry Format

**Local skills** are listed by folder name in the `default` array:

```json
"default": [
  "dbt-template",
  "github-actions",
  "helm-charts"
]
```

**External skills** are keyed by name with metadata pointing to the raw `SKILL.md`:

```json
"external": {
  "react-best-practices": {
    "version": "^1.0.0",
    "description": "...",
    "categories": ["frontend", "react"],
    "source": "https://github.com/org/repo",
    "url": "https://raw.githubusercontent.com/org/repo/main/skills/skill-name/SKILL.md"
  }
}
```

### Configuring Skills

#### Adding a Local Skill

1. Create the skill folder and `SKILL.md` (see Creating a New Skill below).
2. Add the skill's folder name to the `default` array in `.skills.json`:

```json
"default": [
  "dbt-template",
  "my-skill"
]
```

#### Adding an External Skill

External skills are fetched from a URL at runtime. Add them to the `external` map:

```json
"external": {
  "my-external-skill": {
    "version": "^1.0.0",
    "description": "Short description with trigger phrases.",
    "categories": ["relevant", "tags"],
    "source": "https://github.com/org/repo",
    "url": "https://raw.githubusercontent.com/org/repo/main/skills/skill-name/SKILL.md"
  }
}
```

#### Blocking a Skill

To prevent an agent from using a specific skill (e.g., a deprecated or insecure external skill), add it to the `blocked` list:

```json
"blocked": [
  {
    "id": "github:unsafe-org/deprecated-skill",
    "reason": "Security vulnerability - deprecated by maintainer"
  }
]
```

### Creating a New Skill

```bash
mkdir -p skills/my-skill/references
```

Create `skills/my-skill/SKILL.md`:

```yaml
---
name: my-skill
description: >
  Describe what the skill does. Use when the user asks to [action],
  [another action], or [trigger phrase].
---

# My Skill

## What This Skill Provides

Brief overview of the domain knowledge and capabilities this skill covers.

## When to Use This Skill

- Scenario 1
- Scenario 2

## Core Patterns

### Pattern Name

**Rule**: State the rule clearly.

**Implementation**:
- Step or detail
- Step or detail

**References**: See references/guide.md
```

Then register it in `.skills.json`.

### Using Skills as an Agent

When processing a request, an agent resolves skills in this order:

1. **Constitution** — `context_modules/constitution.md` (always loaded).
2. **Persona** — relevant file from `context_modules/personas/` based on task context.
3. **Skill** — triggered by matching the user's intent to a skill description.

To activate a skill manually, tell the agent which skill to use:

> "Using the `github-actions` skill, create a reusable workflow for deploying to Kubernetes."

The agent will read `skills/github-actions/SKILL.md` and any referenced rule files before responding.

### How Personas and Skills Work Together

A persona and one or more skills are loaded at the same time. They complement rather than duplicate each other.

For example, a DevOps Engineer session might look like:

1. **Constitution** — foundational team principles always apply
2. **Persona**: `devops_engineer.md` — sets the role identity, collaboration preferences, and tool context
3. **Skill**: `github-actions` — activated when the user asks about CI/CD pipelines
4. **Skill**: `helm-charts` — activated when the user asks about packaging for Kubernetes

The persona tells the agent _who it is_. The skills tell it _how to execute_ specific tasks.

### External Skills

External skills are fetched at runtime from their `url` field in `.skills.json`. They are not stored locally in this repository.

To discover external skills, ask your AI agent:

> "What skills are available in the external registry?"

The agent will read `.skills.json`, list the `external` entries, and describe when each is useful. To use one, the agent fetches the `SKILL.md` from the provided `url`.

### Policy Settings

The `policy` section of `.skills.json` controls agent behavior:

```json
"policy": {
  "auto_install_default": true,
  "enforce_blocked": true,
  "allow_project_override": true
}
```

| Setting | Default | Description |
| --- | --- | --- |
| `auto_install_default` | `true` | Skills in the `default` list are automatically installed during project init |
| `enforce_blocked` | `true` | The agent refuses to use any skill in the `blocked` list |
| `allow_project_override` | `true` | Individual projects can override manifest settings locally |

---

## Governance Commands and Skills

Governance capabilities are available through both delivery mechanisms — as **spec-kit commands** from the bundled `team-ai-directives` extension (installed by `specify init --team-ai-directives <this-repo>`) and as **agent skills** from [adlc-team-skills](https://github.com/tikalk/adlc-team-skills):

| Capability | Spec Kit command | Agent Skill | Purpose |
|---|---|---|---|
| Bootstrap session | `team.boot` | `team-boot` (auto) | Load the constitution and orient the agent before any task |
| Discover context | `team.discover` | `team-discover` (auto) | Find relevant personas, rules, examples, and skills for the current task |
| Set up knowledge base | `specify init --team-ai-directives` | `team-setup` | Clone, point at, or scaffold the knowledge base |
| Repair | `team.repair` | `team-repair` | Re-index CDR.md, .skills.json, and AGENTS.md; health check; conflict scan; freshness verification |
| Manage skills | `team.skills` | `team-skills` | Browse and install team skills from the knowledge base |
| Verify health | `team.verify` | `team-repair --health-only` | Verify knowledge base config, skills registry, CDR tracking, and constitution alignment |
| Curate CDRs | `team.curate`, `levelup.init` / `levelup.specify` | `levelup-init` / `levelup-specify` | Propose Context Directive Records from a codebase or completed feature |
| Review CDRs | `levelup.clarify` | `levelup-clarify` | Accept, reject, or defer proposed CDRs |
| Publish CDRs | `team.evolve`, `levelup.implement` | `levelup-implement` | Compile accepted CDRs into knowledge base artifacts and a draft PR |
| Validate | `levelup.validate` | `team-repair --conflicts` / `--freshness` | Scan for rule conflicts and update verification timestamps |

**Naming conventions:** spec-kit commands are canonically named `adlc.team-ai-directives.*` / `adlc.levelup.*` and are invoked via the short aliases shown above (`team.discover`, `levelup.init`). Agent skills use dash-names (`team-discover`, `levelup-init`) and are model-invoked through the [Agent Skills standard](https://agentskills.io).

### Integration

In **spec-kit projects**, the `agent-context` extension injects team-directives awareness into the project's context file during `specify init`. It prompts the agent to invoke `team.discover` before feature work and to inherit the team constitution when updating project principles. Run verification anytime by invoking the `team.verify` command.

In **skills-based projects**, `team-boot` performs the equivalent role — loading the constitution at session start and chaining into `team-discover`. Run health checks anytime with the `team-repair` skill.

---

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
