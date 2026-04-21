#!/usr/bin/env bash
# Discover relevant context from team-ai-directives for current feature

set -e

# Get repository root
get_repo_root() {
    local dir="$(pwd)"
    while true; do
        if [ -d "$dir/.specify" ]; then
            echo "$dir"
            return 0
        fi
        if [ "$dir" = "/" ]; then
            break
        fi
        dir="$(dirname "$dir")"
    done
    echo ""
}

REPO_ROOT=$(get_repo_root)
if [ -z "$REPO_ROOT" ]; then
    echo '{"constitution":"","personas":[],"rules":[],"examples":[],"skills":[],"search_metadata":{"keywords":[],"files_searched":0,"files_with_matches":0}}'
    exit 0
fi

# Load team-ai-directives path
TEAM_DIRECTIVES_DIR="${SPECIFY_TEAM_DIRECTIVES:-}"
if [ -z "$TEAM_DIRECTIVES_DIR" ]; then
    # Try to load from init-options.json
    INIT_OPTS="$REPO_ROOT/.specify/init-options.json"
    if [ -f "$INIT_OPTS" ] && command -v python3 >/dev/null 2>&1; then
        TEAM_DIRECTIVES_DIR=$(python3 -c "import json; print(json.load(open('$INIT_OPTS')).get('team_ai_directives', ''))" 2>/dev/null || echo "")
    fi
fi

# Fallback to extensions directory
if [ -z "$TEAM_DIRECTIVES_DIR" ] || [ ! -d "$TEAM_DIRECTIVES_DIR" ]; then
    TEAM_DIRECTIVES_DIR="$REPO_ROOT/.specify/extensions/team-ai-directives"
fi

# If still not found, return empty results
if [ ! -d "$TEAM_DIRECTIVES_DIR" ]; then
    echo '{"constitution":"","personas":[],"rules":[],"examples":[],"skills":[],"search_metadata":{"keywords":[],"files_searched":0,"files_with_matches":0}}'
    exit 0
fi

# Get feature description from environment or context
FEATURE_DESC="${SPECIFY_FEATURE_DESCRIPTION:-}"
SPECIFY_FEATURE="${SPECIFY_FEATURE:-}"

# If no feature description provided, try to read from context.md
if [ -z "$FEATURE_DESC" ] && [ -n "$SPECIFY_FEATURE" ]; then
    CONTEXT_FILE="$REPO_ROOT/specs/$SPECIFY_FEATURE/context.md"
    if [ -f "$CONTEXT_FILE" ]; then
        FEATURE_DESC=$(grep -E "^\\*\\*Mission\\*\\*:" "$CONTEXT_FILE" 2>/dev/null | sed 's/^\\*\\*Mission\\*\\*:[[:space:]]*//' | head -1)
    fi
fi

# Extract keywords from feature description
extract_keywords() {
    local text="$1"
    # Convert to lowercase, remove punctuation, split into words
    echo "$text" | tr '[:upper:]' '[:lower:]' | tr -c '[:alnum:]' ' ' | tr ' ' '\n' | grep -v '^$' | sort -u
}

KEYWORDS=$(extract_keywords "$FEATURE_DESC")

# Initialize results
CONSTITUTION=""
PERSONAS=()
RULES=()
EXAMPLES=()
FILES_SEARCHED=0
FILES_WITH_MATCHES=0

# Find constitution
if [ -f "$TEAM_DIRECTIVES_DIR/constitutions/constitution.md" ]; then
    CONSTITUTION="$TEAM_DIRECTIVES_DIR/constitutions/constitution.md"
elif [ -f "$TEAM_DIRECTIVES_DIR/constitution.md" ]; then
    CONSTITUTION="$TEAM_DIRECTIVES_DIR/constitution.md"
fi

# Helper function to calculate simple relevance score
calculate_score() {
    local file="$1"
    local keywords="$2"
    local score=0
    
    if [ ! -f "$file" ]; then
        echo "0"
        return
    fi
    
    local content=$(cat "$file" | tr '[:upper:]' '[:lower:]')
    
    while IFS= read -r keyword; do
        [ -z "$keyword" ] && continue
        if echo "$content" | grep -q "$keyword"; then
            score=$((score + 1))
        fi
    done <<< "$keywords"
    
    # Normalize score (0-100)
    local keyword_count=$(echo "$keywords" | wc -l)
    if [ "$keyword_count" -gt 0 ]; then
        score=$((score * 100 / keyword_count))
    fi
    
    # Cap at 100
    if [ "$score" -gt 100 ]; then
        score=100
    fi
    
    echo "$score"
}

# Scan personas directory
if [ -d "$TEAM_DIRECTIVES_DIR/personas" ]; then
    while IFS= read -r file; do
        [ -z "$file" ] && continue
        FILES_SEARCHED=$((FILES_SEARCHED + 1))
        score=$(calculate_score "$file" "$KEYWORDS")
        if [ "$score" -ge 30 ]; then
            FILES_WITH_MATCHES=$((FILES_WITH_MATCHES + 1))
            name=$(basename "$file" .md)
            PERSONAS+=("{\"name\":\"$name\",\"file\":\"$file\",\"score\":0.$score}")
        fi
    done < <(find "$TEAM_DIRECTIVES_DIR/personas" -name "*.md" -type f 2>/dev/null)
fi

# Scan rules directory
if [ -d "$TEAM_DIRECTIVES_DIR/rules" ]; then
    while IFS= read -r file; do
        [ -z "$file" ] && continue
        FILES_SEARCHED=$((FILES_SEARCHED + 1))
        score=$(calculate_score "$file" "$KEYWORDS")
        if [ "$score" -ge 30 ]; then
            FILES_WITH_MATCHES=$((FILES_WITH_MATCHES + 1))
            name=$(basename "$file" .md)
            RULES+=("{\"name\":\"$name\",\"file\":\"$file\",\"score\":0.$score}")
        fi
    done < <(find "$TEAM_DIRECTIVES_DIR/rules" -name "*.md" -type f 2>/dev/null)
fi

# Scan examples directory
if [ -d "$TEAM_DIRECTIVES_DIR/examples" ]; then
    while IFS= read -r file; do
        [ -z "$file" ] && continue
        FILES_SEARCHED=$((FILES_SEARCHED + 1))
        score=$(calculate_score "$file" "$KEYWORDS")
        if [ "$score" -ge 30 ]; then
            FILES_WITH_MATCHES=$((FILES_WITH_MATCHES + 1))
            name=$(basename "$file" .md)
            EXAMPLES+=("{\"name\":\"$name\",\"file\":\"$file\",\"score\":0.$score}")
        fi
    done < <(find "$TEAM_DIRECTIVES_DIR/examples" -name "*.md" -type f 2>/dev/null)
fi

# Read skills from .skills.json
SKILLS_JSON="[]"
if [ -f "$TEAM_DIRECTIVES_DIR/.skills.json" ] && command -v jq >/dev/null 2>&1; then
    SKILLS_JSON=$(jq -c '.skills.required // {} | to_entries | map({id: .key, name: (.value.name // .key), required: true})' "$TEAM_DIRECTIVES_DIR/.skills.json" 2>/dev/null || echo "[]")
fi

# Build JSON output
echo "{"
echo "  \"constitution\": \"$CONSTITUTION\","
echo "  \"personas\": [$(IFS=,; echo "${PERSONAS[*]}")],"
echo "  \"rules\": [$(IFS=,; echo "${RULES[*]}")],"
echo "  \"examples\": [$(IFS=,; echo "${EXAMPLES[*]}")],"
echo "  \"skills\": $SKILLS_JSON,"
echo "  \"search_metadata\": {"
echo "    \"keywords\": [$(echo "$KEYWORDS" | awk '{printf "\"%s\",", $0}' | sed 's/,$//')]"
echo "    \"files_searched\": $FILES_SEARCHED,"
echo "    \"files_with_matches\": $FILES_WITH_MATCHES"
echo "  }"
echo "}"
