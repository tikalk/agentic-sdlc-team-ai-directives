# Discover relevant context from team-ai-directives for current feature

# Get repository root
function Get-RepoRoot {
    $dir = Get-Location
    while ($true) {
        if (Test-Path (Join-Path $dir ".specify") -PathType Container) {
            return $dir
        }
        $parent = Split-Path $dir -Parent
        if ($parent -eq $dir -or [string]::IsNullOrEmpty($parent)) {
            break
        }
        $dir = $parent
    }
    return $null
}

$repoRoot = Get-RepoRoot
if (-not $repoRoot) {
    Write-Output '{"constitution":"","personas":[],"rules":[],"examples":[],"skills":[],"search_metadata":{"keywords":[],"files_searched":0,"files_with_matches":0}}'
    exit 0
}

# Load team-ai-directives path
$teamDirectivesDir = $env:SPECIFY_TEAM_DIRECTIVES
if ([string]::IsNullOrEmpty($teamDirectivesDir)) {
    # Try to load from init-options.json
    $initOpts = Join-Path $repoRoot ".specify\init-options.json"
    if (Test-Path $initOpts) {
        try {
            $json = Get-Content $initOpts | ConvertFrom-Json
            $teamDirectivesDir = $json.team_ai_directives
        } catch {
            $teamDirectivesDir = $null
        }
    }
}

# Fallback to extensions directory
if ([string]::IsNullOrEmpty($teamDirectivesDir) -or -not (Test-Path $teamDirectivesDir)) {
    $teamDirectivesDir = Join-Path $repoRoot ".specify\extensions\team-ai-directives"
}

# If still not found, return empty results
if (-not (Test-Path $teamDirectivesDir)) {
    Write-Output '{"constitution":"","personas":[],"rules":[],"examples":[],"skills":[],"search_metadata":{"keywords":[],"files_searched":0,"files_with_matches":0}}'
    exit 0
}

# Get feature description from environment or context
$featureDesc = $env:SPECIFY_FEATURE_DESCRIPTION
$specifyFeature = $env:SPECIFY_FEATURE

# If no feature description provided, try to read from context.md
if ([string]::IsNullOrEmpty($featureDesc) -and -not [string]::IsNullOrEmpty($specifyFeature)) {
    $contextFile = Join-Path $repoRoot "specs\$specifyFeature\context.md"
    if (Test-Path $contextFile) {
        $content = Get-Content $contextFile -Raw
        if ($content -match '\*\*Mission\*\*:\s*(.+)') {
            $featureDesc = $matches[1].Trim()
        }
    }
}

# Extract keywords from feature description
function Extract-Keywords {
    param([string]$text)
    
    if ([string]::IsNullOrEmpty($text)) {
        return @()
    }
    
    # Convert to lowercase and split into words
    $words = $text.ToLower() -split '[^a-z0-9]+' | Where-Object { $_ -and $_.Length -gt 2 }
    return $words | Select-Object -Unique
}

$keywords = Extract-Keywords -text $featureDesc

# Initialize results
$constitution = ""
$personas = @()
$rules = @()
$examples = @()
$filesSearched = 0
$filesWithMatches = 0

# Find constitution
$constitutionPath1 = Join-Path $teamDirectivesDir "constitutions\constitution.md"
$constitutionPath2 = Join-Path $teamDirectivesDir "constitution.md"
if (Test-Path $constitutionPath1) {
    $constitution = $constitutionPath1
} elseif (Test-Path $constitutionPath2) {
    $constitution = $constitutionPath2
}

# Helper function to calculate simple relevance score
function Calculate-Score {
    param([string]$file, [array]$keywords)
    
    if (-not (Test-Path $file)) {
        return 0
    }
    
    $content = (Get-Content $file -Raw).ToLower()
    $score = 0
    
    foreach ($keyword in $keywords) {
        if ($content -match [regex]::Escape($keyword)) {
            $score++
        }
    }
    
    # Normalize score (0-100)
    if ($keywords.Count -gt 0) {
        $score = [math]::Min(100, ($score * 100 / $keywords.Count))
    }
    
    return $score
}

# Scan personas directory
$personasDir = Join-Path $teamDirectivesDir "personas"
if (Test-Path $personasDir) {
    Get-ChildItem $personasDir -Filter "*.md" -File | ForEach-Object {
        $filesSearched++
        $score = Calculate-Score -file $_.FullName -keywords $keywords
        if ($score -ge 30) {
            $filesWithMatches++
            $personas += @{
                name = $_.BaseName
                file = $_.FullName
                score = [math]::Round($score / 100, 2)
            }
        }
    }
}

# Scan rules directory
$rulesDir = Join-Path $teamDirectivesDir "rules"
if (Test-Path $rulesDir) {
    Get-ChildItem $rulesDir -Filter "*.md" -File | ForEach-Object {
        $filesSearched++
        $score = Calculate-Score -file $_.FullName -keywords $keywords
        if ($score -ge 30) {
            $filesWithMatches++
            $rules += @{
                name = $_.BaseName
                file = $_.FullName
                score = [math]::Round($score / 100, 2)
            }
        }
    }
}

# Scan examples directory
$examplesDir = Join-Path $teamDirectivesDir "examples"
if (Test-Path $examplesDir) {
    Get-ChildItem $examplesDir -Filter "*.md" -File | ForEach-Object {
        $filesSearched++
        $score = Calculate-Score -file $_.FullName -keywords $keywords
        if ($score -ge 30) {
            $filesWithMatches++
            $examples += @{
                name = $_.BaseName
                file = $_.FullName
                score = [math]::Round($score / 100, 2)
            }
        }
    }
}

# Read skills from .skills.json
$skills = @()
$skillsFile = Join-Path $teamDirectivesDir ".skills.json"
if (Test-Path $skillsFile) {
    try {
        $skillsJson = Get-Content $skillsFile | ConvertFrom-Json
        if ($skillsJson.skills.required) {
            $skillsJson.skills.required.PSObject.Properties | ForEach-Object {
                $skills += @{
                    id = $_.Name
                    name = if ($_.Value.name) { $_.Value.name } else { $_.Name }
                    required = $true
                }
            }
        }
    } catch {
        # Ignore errors reading skills file
    }
}

# Build output object
$output = @{
    constitution = $constitution
    personas = $personas
    rules = $rules
    examples = $examples
    skills = $skills
    search_metadata = @{
        keywords = @($keywords)
        files_searched = $filesSearched
        files_with_matches = $filesWithMatches
    }
}

# Output JSON
$output | ConvertTo-Json -Compress
