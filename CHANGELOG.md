# Changelog

## [v1.8.2] - 2026-06-28

### Changed

- **Constitution expanded to 14 principles** — integrated findings from @mnilax's 12-rule behavioral contract study:
  - New Principle 2: Appropriate Delegation (deterministic logic → deterministic code)
  - Principle 3 (Observability): Added "fail visibly — surface every skipped/rolled-back/bypassed step"
  - Principle 5 (Tests): Added "passing test that tests nothing useful is failure"
  - Principle 10 (Think Before Coding): Added "read before you write" + "surface conflicts, don't average them"
  - Principle 12 (Surgical Changes): Added "convention beats novelty"
  - Principle 13 (Goal-Driven Execution): Added "long-running operations require checkpoints"

## [v1.7.4] - 2026-05-28

### Fixed

- **Command files renamed** to align with architect extension naming convention:
  - `commands/adlc.team-ai-directives.constitution.md` → `commands/constitution.md`
  - `commands/adlc.team-ai-directives.discover.md` → `commands/discover.md`
  - `commands/adlc.team-ai-directives.verify.md` → `commands/verify.md`
  - `commands/adlc.team-ai-directives.release.md` → `commands/release.md`
- **`constitution.md`**: Now dynamically reads principles from `context_modules/constitution.md` instead of hardcoding 12 stale principles. Removed hardcoded version `1.3.0`.
- **`discover.md`**: Replaced non-existent `${SPECIFY_TEAM_DIRECTIVES}` env var with registry-based extension root resolution via `.specify/extensions/.registry`.
- **`verify.md`**: Removed hardcoded principle count (was 12, now dynamically checks alignment by comparing project constitution against team principles).

### Changed

- **`extension.yml`**: Updated `provides.commands[].file` fields to short names. Bumped version to `1.7.4`.
- **`extensions/catalog.json`**: Updated version and timestamp.

## [v1.7.2] - 2026-05-23

### Fixed

- **AGENTS.md**: Repaired missing sections (`## Functional Categories (Rules)` and `## CDR.md`)
- **Context modules**: Added YAML frontmatter to 17 orphan files:
  - `rules/style-guides/java/google_style_guide.md`
  - `rules/style-guides/java/null_safety_and_optional.md`
  - `rules/style-guides/python/pep8_and_docstrings.md`
  - `rules/testing/java/junit5_best_practices.md`
  - `rules/devops/crossplane_compositions.md`
  - `rules/devops/gke_workload_identity.md`
  - `rules/devops/helm_chart_library.md`
  - `rules/devops/helm_packaging.md`
  - `rules/devops/helm_template_helpers.md`
  - `rules/devops/helm_wrapper_charts.md`
  - `rules/devops/secrets_management.md`
  - `rules/orchestration/airbyte_integration.md`
  - `rules/orchestration/airflow_dag_patterns.md`
  - `rules/architecture/dependency_injection.md`
  - `rules/data/spring_boot_patterns.md`
  - `examples/prompts/plan.md`
  - `examples/prompts/risk_based_test.md`

### Changed

- **Memory Verification**: Updated verification timestamps (2026-05-23) and reset age_days to 0 for all 33 context modules

## [v1.7.1] - 2026-05-22

### Fixed

- **Release command**: Repository URL check now uses git remote instead of hardcoded `tikalk`
  - Works correctly for both upstream and fork repositories
  - Auto-corrects both `extension.yml` and `catalog.json` to match git remote
  - No longer incorrectly "fixes" fork repository URLs

### Changed

- **CONTRIBUTING.md**: Updated validation table to reflect repository URL consistency check

## [v1.7.0] - 2026-05-22

### Added

- **New `release` command** (`adlc.team-ai-directives.release` / `team.release`)
  - Validates and auto-corrects release readiness
  - Checks version sync between `extension.yml` and `catalog.json`
  - Validates repository URL (correct org: `tikalk`)
  - Refreshes stale timestamps in `catalog.json`
  - Detects forks and validates version format
  - Checks if git tag already exists
  - Auto-corrects issues by default, use `RELEASE_DRY_RUN=true` to validate only

- **Version consistency check in `verify` command**
  - Added Check 5: Version consistency (warning only)
  - Detects version mismatch between `extension.yml` and `catalog.json`
  - Non-blocking warning that suggests running `release` command

- **Fork versioning guidelines**
  - Format: `{upstream_version}+{fork_name}{fork_release_number}`
  - Examples: `1.7.0+acme1`, `1.7.0+tikal2`
  - Documented fork workflow and upstream merge process

### Changed

- **CONTRIBUTING.md**: Added comprehensive release process documentation
  - Validation checks table with auto-correct indicators
  - Dry run mode instructions
  - Exit codes
  - Output examples
  - Fork versioning guidelines

- **AGENTS.md**: Added "Contributing" section referencing CONTRIBUTING.md

- **extension.yml**: Updated repository URL from `tikal` to `tikalk` (correct org)

- **extensions/catalog.json**: 
  - Updated version to 1.7.0
  - Updated `provides.commands` from 3 to 4
  - Updated `updated_at` timestamp

### Fixed

- Repository URL inconsistency: `extension.yml` now uses correct org `tikalk` (was `tikal`)

## [v1.6.1] - 2026-05-21

### Changed

- **CDR.md Re-indexing**: Complete inventory of all repository modules
  - Removed 8 placeholder files (domain_driven_design, state_management, collector_contract, memory_management, provenance, auth_middleware, metaprogramming, pydantic_patterns)
  - Added 25 full CDR entries (CDR-2026-003 through CDR-2026-027)
  - All 5 personas now documented with CDR entries
  - All 20 rules now documented with CDR entries
  - All entries marked as "Accepted" with file creation dates from git history
  - Updated verification timestamps to 2026-05-21

**Total CDRs**: 27 (2 original consolidations + 25 initial content modules)

## [v1.6.0] - 2026-05-21

### Added

- **New directory structure** for improved organization:
  - `rules/architecture/` - Architecture patterns (moved from style-guides/)
  - `rules/data/` - Data patterns (renamed from framework/)
  - `rules/style-guides/java/` - Java-specific style guides
  - `rules/style-guides/python/` - Python-specific style guides
  - `rules/testing/java/` - Java testing patterns
  - `rules/testing/python/` - Python testing patterns

- **New placeholder rules** for future content:
  - `architecture/domain_driven_design.md`
  - `architecture/state_management.md`
  - `data/collector_contract.md`
  - `data/memory_management.md`
  - `data/provenance.md`
  - `security/auth_middleware.md`
  - `style-guides/python/metaprogramming.md`
  - `style-guides/python/pydantic_patterns.md`

### Changed

- **Reorganized existing rules** to match new structure:
  - `style-guides/dependency_injection.md` → `architecture/dependency_injection.md`
  - `framework/spring_boot_patterns.md` → `data/spring_boot_patterns.md`
  - `style-guides/java_*.md` → `style-guides/java/*.md`
  - `style-guides/python_*.md` → `style-guides/python/*.md`
  - `testing/java_*.md` → `testing/java/*.md`
  - `testing/python_*.md` → `testing/python/*.md`

- **Updated all rule references** across personas and documentation
- **Updated CDR.md** with new verification timestamps

### Removed

- `framework/` directory (renamed to `data/`)

## [v1.5.0] - 2026-05-03

### Added

- **New constitution principle**: Immutability by Default (Principle #5)
  - Always create new objects, never mutate shared state
  - Prevents side effects and simplifies debugging

- **New style guide rule**: File Organization and Structure
  - File size limits: Target 200-400 lines, max 800
  - Function limits: Target <50 lines, max 100
  - Nesting depth: Max 4 levels
  - Organize by feature/domain, not by type

- **New security rule**: Pre-Commit Security Checklist
  - Critical checks: No hardcoded secrets, SQL injection prevention, input validation
  - High priority: XSS prevention, CSRF protection, authentication/authorization
  - Medium priority: Rate limiting, error handling, dependencies
  - References existing rules using `@rule:` syntax

### Changed

- **Constitution renumbering**: All principles after #4 renumbered (now 1-13)
- Fixed indentation inconsistencies in constitution

## [v1.4.0] - 2026-04-29

### Added

- **Consolidated rules** for improved maintainability:
  - New `sql_injection_prevention.md` - Comprehensive SQL injection rules with universal checklist and language-specific patterns (Java, Python, Node.js)
  - New `secrets_management.md` - Integrated secrets management combining External Secrets Operator, DRY patterns, and GKE Workload Identity

### Changed

- **Rule consolidation**:
  - Removed duplicate SQL injection rules (java_prevent_sql_injection.md, prevent_sql_injection.md) → merged into sql_injection_prevention.md
  - Removed duplicate secrets rules (external_secrets_operator.md, secrets_management_dry.md) → merged into secrets_management.md

- **CDR.md updated** with consolidation records (CDR-2026-001, CDR-2026-002)

## [v1.3.0] - 2026-04-22

### Added

- **Constitution hooks** for spec-kit integration:
  - `before_constitution` hook (optional: false) - Auto-loads team principles before project constitution update

- **New command**: `adlc.team-ai-directives.constitution` - Discovers and loads team constitution principles

- **extension.yml** updated:
  - Added `before_constitution` hook
  - Registered new `constitution` command

- **verify.md** enhanced:
  - Added Check #4: Constitution alignment verification

### Changed

- **Consolidated commands**:
  - Renamed `constitution-discover.md` → `constitution.md`
  - Merged constitution verification into `verify.md` (Check #4)
  - Removed separate `constitution-verify` command (now part of verify)

## [v1.1.0] - 2026-04-20

### Added

- **extension.yml** - Spec-kit extension manifest
  - `adlc.team-ai-directives.verify` command for health checks
  - Enables spec-kit extension system integration

- **Documentation**:
  - README.md: Added installation section (extension vs clone)
  - AGENTS.md: Added installation locations section

## [v1.4.0] - 2026-03-13

### Changed

- **Breaking**: Reverted CDR storage from `.cdrs.json` to markdown-based `CDR.md`
  - CDRs now stored in `.specify/memory/cdr.md` in project directories (local)
  - Approved CDRs copied to `{TEAM_DIRECTIVES}/CDR.md` during `/levelup.implement`
  - Status values simplified: `Accepted` | `Rejected`
  - `/levelup.skills` now requires CDR status = "Accepted" (not "Proposed")
- **Removed `.cdrs.json`** - Single source of truth is now markdown-based
- **Removed `status` field from `.skills.json`** - Skills no longer have lifecycle status

### Updated Documentation

- **AGENTS.md** - Updated to reference CDR.md instead of .cdrs.json
- **README.md** - Added CDR.md to repository layout

## [v1.3.0] - 2026-03-12

### Added

- **`.cdrs.json`** - Context Module Registry (reverted in v1.4.0)
  - Centralized tracking of all context modules (personas, rules, examples)
  - 34 modules pre-populated with `status` field
  - Status values: `discovered` | `proposed` | `accepted` | `active` | `deprecated`
  - Enables lifecycle management of context modules

### Changed

- **Updated `AGENTS.md`** - Added Context Module Registry documentation
- **Updated `README.md`** - Added `.cdrs.json` to repository layout
- **`.skills.json`** - Added `status` field to skills for lifecycle tracking

### Note

This version was superseded by v1.4.0 which reverted the CDR storage approach.

## [v1.2.0] - 2025-02-14

### Lean Starter Kit Refactor
- **Added root `AGENTS.md`**: Instructions for AI agents on how to use the repository
- **Added `GETTING_STARTED.md`**: 5-minute quickstart guide for new users
- **Updated `README.md`**: Repositioned as "Team AI Directives Starter Kit"
- **Updated personas**: Added Rule References to Java, Python, Data Analyst, DevOps personas

### Architecture Simplification
- **Skills are self-contained**: Removed all `@rule:/@example:` references from SKILL.md files
- **Rules via personas**: Rules now accessed through persona Rule References, not skills
- **Deleted redundant files**:
  - `skills/AGENTS.md` (moved to root)
  - `skills/SKILL_TEMPLATES.md` (redundant with AGENTS.md)
  - `skills/external_skills.md` (replaced by `.skills.json` registry)

### Breaking Changes
- `skills/AGENTS.md` deleted - use root `AGENTS.md` instead
- `skills/SKILL_TEMPLATES.md` deleted - use root `AGENTS.md` instead
- Skills no longer contain `@rule:` or `@example:` references

## [v1.1.0] - 2025-02-01

### Skills Simplification & External Skills Registry
- **Added skills/external_skills.md**: URL-based registry for external skills from vercel-labs and other sources
- **Simplified skills frontmatter**: Removed complex metadata, keeping only name + description (vercel-labs format)
- **Refactored skills/ directory structure**: Moved vercel-react-best-practices to skills/ root, removed fullstack/ directory
- **Updated skills/AGENTS.md**: Removed metadata references, added external skills section
- **Updated CONTRIBUTING.md**: Removed metadata requirements, added external skills contribution guidelines
- **Updated README.md**: Removed skills.manifest.yml references, added external skills explanation
- **Simplified vercel-react-best-practices skill**: Updated frontmatter to vercel-labs simple format

### Key Features
- **External Skills**: URL-based registry for skills from other repositories, fetched on-demand via agent webfetch
- **Simple Frontmatter**: Adopted vercel-labs format (name + description only) for better LLM compatibility
- **LLM-Based Discovery**: Skills discovered using natural language matching instead of structured metadata
- **Flattened Structure**: Simplified skills directory structure following vercel-labs patterns

### Breaking Changes
- Removed complex skill metadata (category, platforms, keywords, requires_context, use_cases)
- Deleted skills.manifest.yml - skills discovered via LLM matching instead
- Deleted docs/SKILL_METADATA_STANDARD.md - no longer needed with simple format
- External skills now referenced via URL instead of being copied/wrapped

### Migration Notes
- Existing skills with complex metadata will still work but should be simplified gradually
- Teams using git submodules will automatically get new external skills registry
- Skill discovery now relies on LLM matching rather than structured metadata
- External skills are fetched on-demand via agent webfetch capabilities

## [Unreleased] - 2025-01-10
- Refactored repository structure to match final layout
- Merged principles into constitution.md at root
- Moved templates to context_modules/examples/patterns/
- Added skills/ and prompts/ directories
- Moved skills/ from context_modules/skills/ to skills/ (same level as context_modules/)
- Updated README.md to reflect new structure
- Restructured constitution: moved language-specific items (dependency injection, null safety) to rules/style-guides/
- Generalized dependency injection as neutral rule
- Renamed examples/patterns/ to examples/prompts/ for clarity (contains prompt templates)
- Moved constitution.md from root to context_modules/ for better organization of guidance content
## [Unreleased] - 2025-01-16
- Added Spring Boot framework patterns (constructor injection, JPA, testing, configuration)
- Added DevOps Engineer persona (generic DevOps philosophy, tool-agnostic)
- Added AGENTS.md meta-pattern for skills (self-contained, portable, progressive disclosure)
- Added DevOps rules directory with 7 generic patterns:
  - GitHub Actions workflows and reusable actions
  - Helm packaging and values design principles
  - Helm chart library pattern for DRY template management
  - Helm wrapper charts for extending upstream charts
  - Helm template helpers for consistent naming and labels
  - External Secrets Operator patterns for secret management
  - GKE Workload Identity for cloud authentication
- Added Phase 2 generic patterns with complete abstraction:
  - Generic DRY secrets management pattern with standalone Helm templates
  - Generic Crossplane compositions with provider-agnostic examples
  - Updated DevOps Engineer persona with complete rule references
  - All patterns work with any cloud provider without competitive advantage loss
- Added Phase 3 comprehensive externalization:
  - Added Python testing rule with pytest patterns and class-based organization
  - Added orchestration rules directory with generic Airflow and Airbyte patterns
  - Added generic skill templates for skill development patterns
  - Added Cloud Native Platform Architect persona with generic rule references
  - Updated DevOps Engineer persona with complete rule coverage
  - All patterns work with any cloud provider without competitive advantage loss