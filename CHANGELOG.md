# Changelog

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