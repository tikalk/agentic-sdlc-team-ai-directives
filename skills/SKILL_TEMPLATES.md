# Generic Skill Development Templates

**Skill Overview**: Comprehensive patterns and templates for creating self-contained, portable agent skills following the Agent Skills standard.

**When to Use This Skill**:
- Creating new agent skills for any platform (Claude Code, Cursor, Copilot, etc.)
- Implementing skill development patterns and best practices
- Setting up skill directory structures and organization
- Managing skill metadata, frontmatter, and documentation
- Creating reusable skill templates and automation scripts

**Quick Setup Guide:**

### Prerequisites
- Understanding of Agent Skills standard (see `AGENTS.md`)
- YAML frontmatter knowledge
- Basic file system operations
- Script development (Bash, Python, etc.)

### Initialize Skill Project
```bash
# Create skill directory structure
mkdir -p my-skill/{scripts,references}
cd my-skill

# Create main skill file
touch SKILL.md

# Create references directory (if needed)
mkdir -p references
```

---

## Generic Skill Structure

### Standard Directory Layout

**Rule**: Use consistent directory structure for all skills

**Rationale**: Maintainability, discoverability, consistency across skills

**Implementation**:
```
skill-name/
├── SKILL.md              # Required: Main instructions with YAML frontmatter
├── references/             # Optional: Extracted content for offline use
│   └── *.md           # Copied from context_modules
└── scripts/               # Optional: Automation scripts
    ├── setup.sh          # Skill setup automation
    ├── validate.sh       # Skill validation
    └── deploy.sh        # Skill deployment
```

**Reference**: @skills/AGENTS.md

### Required Frontmatter Structure

**Rule**: All SKILL.md files must include YAML frontmatter with required fields

**Rationale**: Metadata for skill discovery, versioning, and categorization

**Implementation**:
```yaml
---
name: skill-name              # Required: kebab-case, 1-64 chars
description: One-sentence description with trigger keywords. 1-1024 chars.
license: MIT                   # Optional: License identifier
metadata:
  author: your-name          # Optional: Skill author
  version: "1.0.0"          # Optional: Skill version
  category: category-name       # Optional: Skill category
---
```

**Reference**: @skills/AGENTS.md

---

## Generic Skill Development Patterns

### Skill Content Organization

**Rule**: Structure skill content with progressive disclosure

**Rationale**: Context efficiency, user experience, maintainability

**Implementation**:
```markdown
# Skill Name

## Quick Setup Guide
# (Brief setup instructions - 5-10 lines)

## When to Use This Skill
# (Use cases and scenarios - 3-5 bullet points)

## Core Patterns
# (Main patterns and approaches - 3-5 sections)

## Implementation Details
# (Detailed implementation - 5-10 sections)

## Examples
# (Practical examples - 3-5 examples)

## References
# (Extracted content links)
```

### Progressive Disclosure Levels

**Level 1: Metadata (Startup)**
- YAML frontmatter with name, description, metadata
- ~100 tokens for quick skill discovery
- Loaded when skill is triggered

**Level 2: Instructions (Main)**
- Complete skill instructions
- ~5000 tokens for detailed guidance
- Loaded when skill is activated

**Level 3: Resources (On-Demand)**
- Files in `references/` directory
- Loaded as needed via tools
- Extracted from context_modules

**Reference**: @skills/AGENTS.md

### Self-Contained Rule

**Rule**: Skills MUST NOT reference context_modules using `@rule:`, `@persona:`, or `@example:` syntax

**Rationale**: Skills should be portable and work standalone

**Implementation**:
- ✅ **DO**: Use relative paths: `[Link text](references/file.md)`
- ✅ **DO**: Use grep for search: `grep -l "pattern" references/`
- ❌ **DON'T**: Use `@rule:security/prevent_sql_injection.md`
- ❌ **DON'T**: Use `@persona:senior_java_developer.md`

**Reference**: @skills/AGENTS.md

---

## Generic Skill Templates

### Template 1: CLI Tooling Skill

**Use Case**: Skills that provide command-line interfaces and automation

**Structure**:
```markdown
---
name: cli-tooling-skill
description: Generic CLI tooling patterns for command-line interfaces, task automation, and script development. Use when creating CLI tools, automation scripts, or command-line applications.
license: MIT
metadata:
  author: generic-team
  version: "1.0.0"
  category: automation
---

# CLI Tooling Skill

## Quick Setup Guide

### Prerequisites
- Python 3.10+
- Click for command-line interfaces
- Poetry for dependency management
- Task runner (optional)

### Initialize CLI Project
```bash
# Create CLI structure
mkdir -p scripts/cli/commands scripts/cli/resources/templates

# Install dependencies
poetry install

# Initialize task runner
task --init
```

## Core Patterns

### Command Development

**Rule**: Use argparse for consistent command interfaces with proper help and validation

**Implementation**:
```python
# scripts/cli/commands/main_command.py
import argparse
import sys
from pathlib import Path

def create_command(args):
    """Create new resource with validation."""
    resource_name = args.name
    
    # Validate resource name
    if not resource_name.replace('_', '').isalnum():
        print(f"ERROR: Resource name '{resource_name}' must contain only alphanumeric characters and underscores")
        sys.exit(1)
    
    # Create resource
    resource_path = Path("resources") / resource_name
    resource_path.mkdir(parents=True, exist_ok=True)
    
    print(f"Created resource: {resource_path}")
```

### Task Runner Integration

**Rule**: Use task runners for automation and workflow management

**Implementation**:
```yaml
# Taskfile.yml
version: '3'

tasks:
  setup:
    cmds:
      - poetry install
      - task --init
  
  validate:
    cmds:
      - python -m py_compile scripts/cli/**/*.py
      - python -m pytest tests/
  
  deploy:
    cmds:
      - poetry build
      - python scripts/cli/deploy.py
```

## Implementation Details

### Command Interface Patterns

**Rule**: Use consistent command patterns with proper argument handling

**Implementation**:
```python
# scripts/cli/main.py
import argparse
import sys
from .commands import main_command, helper_command

def main():
    parser = argparse.ArgumentParser(description="Generic CLI Tool")
    subparsers = parser.add_subparsers(dest='command', help='Available commands')
    
    # Add subcommands
    main_command.add_parser(subparsers)
    helper_command.add_parser(subparsers)
    
    args = parser.parse_args()
    
    # Execute command
    if args.command == 'main':
        main_command.execute(args)
    elif args.command == 'helper':
        helper_command.execute(args)
    else:
        parser.print_help()
        sys.exit(1)

if __name__ == "__main__":
    main()
```

### Validation Patterns

**Rule**: Implement comprehensive validation for inputs and configurations

**Implementation**:
```python
# scripts/validate/validate.py
import os
import sys
from pathlib import Path

def validate_skill_structure():
    """Validate skill directory structure."""
    required_files = ['SKILL.md']
    required_dirs = ['scripts', 'references']
    
    for file_path in required_files:
        if not Path(file_path).exists():
            print(f"ERROR: Required file '{file_path}' not found")
            return False
    
    for dir_path in required_dirs:
        if not Path(dir_path).exists():
            print(f"ERROR: Required directory '{dir_path}' not found")
            return False
    
    return True

def validate_frontmatter(skill_file):
    """Validate YAML frontmatter in skill file."""
    try:
        with open(skill_file, 'r') as f:
            content = f.read()
        
        if not content.startswith('---'):
            print("ERROR: SKILL.md must start with YAML frontmatter")
            return False
        
        # Parse frontmatter
        frontmatter_end = content.find('\n---', 3)
        if frontmatter_end == -1:
            print("ERROR: Invalid YAML frontmatter format")
            return False
        
        frontmatter = content[:frontmatter_end]
        yaml_content = frontmatter[3:]
        
        try:
            import yaml
            metadata = yaml.safe_load(yaml_content)
            
            # Validate required fields
            required_fields = ['name', 'description']
            for field in required_fields:
                if field not in metadata:
                    print(f"ERROR: Required field '{field}' missing from frontmatter")
                    return False
            
            return True
            
        except yaml.YAMLError as e:
            print(f"ERROR: Invalid YAML frontmatter: {e}")
            return False
            
    except Exception as e:
        print(f"ERROR: Failed to parse frontmatter: {e}")
        return False
```

## Generic Examples

### Example 1: Complete CLI Skill

**File**: `SKILL.md`
```markdown
---
name: generic-cli-tool
description: Generic CLI tooling patterns for command-line interfaces, task automation, and script development. Use when creating CLI tools, automation scripts, or command-line applications.
license: MIT
metadata:
  author: generic-team
  version: "1.0.0"
  category: automation
---

# Generic CLI Tooling

## Quick Setup Guide

### Prerequisites
- Python 3.10+
- Click for command-line interfaces
- Poetry for dependency management
- Task runner (optional)

### Initialize CLI Project
```bash
# Create CLI structure
mkdir -p scripts/cli/commands scripts/cli/resources/templates

# Install dependencies
poetry install

# Initialize task runner
task --init
```

## Core Patterns

### Command Development
- Use argparse for consistent interfaces
- Implement proper error handling
- Add comprehensive help text
- Use subcommands for complex tools

### Task Runner Integration
- Use Taskfile.yml for automation
- Define setup, validate, deploy tasks
- Integrate with Poetry for dependencies

### Validation Patterns
- Validate command arguments
- Check file system state
- Verify configuration consistency
```

### Example 2: Data Processing Skill

**File**: `SKILL.md`
```markdown
---
name: data-processor
description: Generic data processing patterns for file operations, data transformation, and validation. Use when processing CSV files, JSON data, or implementing ETL workflows.
license: MIT
metadata:
  author: generic-team
  version: "1.0.0"
  category: data-engineering
---

# Data Processor

## Quick Setup Guide

### Prerequisites
- Python 3.10+
- Pandas for data manipulation
- Pydantic for data validation
- Click for CLI interface

### Initialize Project
```bash
# Create data processing structure
mkdir -p data/{input,output,processed}
mkdir -p scripts/processors
mkdir -p tests

# Install dependencies
poetry install
```

## Core Patterns

### Data Processing Pipeline
- Read from multiple input formats
- Apply transformation logic
- Validate output data
- Write to multiple output formats

### Validation Patterns
- Use Pydantic models for data validation
- Implement custom validators
- Add comprehensive error handling
```

### Example 3: API Integration Skill

**File**: `SKILL.md`
```markdown
---
name: api-integration
description: Generic API integration patterns for HTTP clients, authentication, and error handling. Use when integrating with REST APIs, GraphQL endpoints, or web services.
license: MIT
metadata:
  author: generic-team
  version: "1.0.0"
  category: integration
---

# API Integration

## Quick Setup Guide

### Prerequisites
- Python 3.10+
- Requests for HTTP clients
- Pydantic for response validation
- Click for CLI interface

### Initialize Project
```bash
# Create API integration structure
mkdir -p scripts/api/{clients,auth}
mkdir -p tests/api
mkdir -p models/api

# Install dependencies
poetry install
```

## Core Patterns

### HTTP Client Patterns
- Use requests for HTTP operations
- Implement retry logic for resilience
- Add proper error handling
- Use session management for connections

### Authentication Patterns
- Support multiple auth methods (Basic, Bearer, OAuth)
- Implement token refresh logic
- Use secure credential storage
- Add authentication middleware

### Response Validation
- Use Pydantic models for response parsing
- Implement custom validators
- Add comprehensive error handling
- Log API interactions for debugging
```

---

## Generic Automation Scripts

### Setup Script Template

**File**: `scripts/setup.sh`
```bash
#!/bin/bash
set -e

echo "Setting up skill: {{ skill_name }}"

# Create directory structure
mkdir -p scripts/{commands,resources,templates}
mkdir -p references

# Install dependencies
if [ -f "pyproject.toml" ]; then
    echo "Installing Python dependencies..."
    pip install -e .
fi

# Initialize task runner if needed
if [ ! -f "Taskfile.yml" ] && command -v task >/dev/null 2>&1; then
    echo "Initializing task runner..."
    task --init
fi

# Create validation script
cat > scripts/validate.sh << 'EOF'
#!/bin/bash
set -e

echo "Validating skill structure..."

# Validate required files
required_files=("SKILL.md")
for file in "${required_files[@]}"; do
    if [ ! -f "$file" ]; then
        echo "ERROR: Required file '$file' not found"
        exit 1
    fi
done

# Validate directories
required_dirs=("scripts" "references")
for dir in "${required_dirs[@]}"; do
    if [ ! -d "$dir" ]; then
        echo "ERROR: Required directory '$dir' not found"
        exit 1
    done
done

echo "✅ Skill validation passed"
EOF

chmod +x scripts/validate.sh

echo "✅ Skill setup complete"
```

### Deploy Script Template

**File**: `scripts/deploy.sh`
```bash
#!/bin/bash
set -e

echo "Deploying skill: {{ skill_name }}"

# Run validation
./scripts/validate.sh

# Run tests if available
if [ -d "tests" ] && [ "$(ls tests/*.py 2>/dev/null | wc -l)" -gt 0 ]; then
    echo "Running tests..."
    python -m pytest tests/
fi

# Build if needed
if [ -f "pyproject.toml" ]; then
    echo "Building skill..."
    pip install -e .
fi

echo "✅ Skill deployment complete"
```

---

## Generic Best Practices

### Skill Development Guidelines

#### **Content Organization**
- Start with clear use cases and scenarios
- Provide progressive disclosure of complexity
- Include practical examples and templates
- Document integration patterns

#### **Metadata Management**
- Use descriptive names and categories
- Include version information for tracking
- Add author and license information
- Use consistent YAML formatting

#### **Reference Management**
- Extract only necessary content from context_modules
- Use relative paths for internal references
- Keep references lightweight and focused
- Update references when context changes

#### **Script Development**
- Use shebangs and proper exit codes
- Implement comprehensive error handling
- Add logging for debugging
- Make scripts idempotent and safe

#### **Validation Patterns**
- Validate directory structure and required files
- Check frontmatter format and required fields
- Test script functionality before deployment
- Add comprehensive error messages

### Integration Patterns

#### **Cross-Skill References**
- Use relative paths to reference other skills
- Avoid circular dependencies between skills
- Document integration requirements clearly
- Test skill independence

#### **Platform Compatibility**
- Ensure skills work on any agent platform
- Avoid platform-specific dependencies
- Use standard file formats and tools
- Test portability across environments

#### **Maintenance Patterns**
- Keep skills focused and single-purpose
- Update references when context changes
- Version skills independently
- Document breaking changes clearly

---

## Generic Tool Integration

### Integration with Development Tools

**Rule**: Use standard development tools for skill creation and maintenance

**Implementation**:
```bash
# Skill creation workflow
mkdir new-skill
cd new-skill
cp skill-templates/SKILL.md.template SKILL.md
# Edit SKILL.md with skill-specific content
# Add scripts and references as needed

# Skill validation workflow
cd new-skill
./scripts/validate.sh
./scripts/setup.sh

# Skill deployment workflow
cd new-skill
./scripts/deploy.sh
```

### Integration with Testing Frameworks

**Rule**: Use standard testing frameworks for skill validation

**Implementation**:
```python
# tests/test_skill_structure.py
import pytest
import os
from pathlib import Path

def test_skill_structure():
    """Test that skill has required structure."""
    skill_dir = Path(".")
    
    # Check required files
    assert (skill_dir / "SKILL.md").exists(), "SKILL.md is required"
    
    # Check required directories
    assert (skill_dir / "scripts").exists(), "scripts directory is required"
    
    # Check frontmatter
    with open(skill_dir / "SKILL.md", 'r') as f:
        content = f.read()
        assert content.startswith('---'), "SKILL.md must start with YAML frontmatter"

def test_frontmatter_validation():
    """Test that frontmatter contains required fields."""
    from scripts.validate import validate_frontmatter
    
    assert validate_frontmatter("SKILL.md"), "Frontmatter validation failed"
```

### Integration with Documentation Tools

**Rule**: Use standard documentation tools for skill documentation

**Implementation**:
```markdown
# README.md (skill documentation)
# Generic CLI Tooling Skill

This skill provides comprehensive patterns for creating command-line tools and automation scripts.

## Quick Start
```bash
# Clone or create skill directory
git clone <skill-repository>
cd <skill-directory>

# Setup skill
./scripts/setup.sh

# Use skill
python scripts/cli/main.py --help
```

---

## Rationale

Generic skill development templates provide a foundation for creating consistent, maintainable, and portable agent capabilities. These templates ensure:

- **Consistency**: Standard structure and organization across skills
- **Portability**: Skills work on any agent platform without dependencies
- **Maintainability**: Clear patterns for updates and extensions
- **Testability**: Comprehensive validation and testing approaches
- **Flexibility**: Adaptable to any domain or use case

**Integration Benefits:**
- Works with any agent platform (Claude Code, Cursor, Copilot, etc.)
- Integrates with standard development tools and workflows
- Compatible with any testing framework or validation system
- Adapts to any documentation or deployment approach

**Universal Applicability:**
- Generic patterns work with any skill type or domain
- Standalone examples require no external dependencies
- Templates can be adapted to any specific use case
- Automation scripts work with any platform or environment