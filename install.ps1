$ErrorActionPreference = "Stop"

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$AgentsDir = Join-Path $ScriptDir "agents"

$GlobalInstall = $false
$Force = $false
$Target = ""

for ($i = 0; $i -lt $args.Count; $i++) {
    $arg = $args[$i]
    switch -Regex ($arg) {
        "^--global$" { $GlobalInstall = $true }
        "^--force$" { $Force = $true }
        "^--help$" {
            Write-Host "Usage: .\install.ps1 [OPTIONS] [TARGET_DIR]"
            Write-Host ""
            Write-Host "Install Superpowers rules, workflows, and skills for Antigravity."
            Write-Host ""
            Write-Host "Options:"
            Write-Host "  --global       Install globally to ~\.gemini\antigravity\"
            Write-Host "                 Rules  -> ~\.gemini\antigravity\rules\"
            Write-Host "                 Workflows -> ~\.gemini\antigravity\global_workflows\"
            Write-Host "                 Skills -> ~\.gemini\skills\"
            Write-Host "  --force        Overwrite existing files"
            Write-Host "  --help         Show this help"
            Write-Host ""
            Write-Host "Arguments:"
            Write-Host "  TARGET_DIR     Install to a specific project directory"
            Write-Host "                 (copies rules & workflows to TARGET_DIR\.agents\)"
            Write-Host "                 (skills are always installed to ~\.gemini\skills\)"
            Write-Host ""
            Write-Host "Examples:"
            Write-Host "  .\install.ps1 --global                  # Global install"
            Write-Host "  .\install.ps1 --global --force          # Global install, overwrite existing"
            Write-Host "  .\install.ps1 C:\path\to\project        # Project install (rules + workflows)"
            Write-Host "  .\install.ps1                           # Install to current directory"
            exit 0
        }
        "^--.*" {
            Write-Host "Unknown option: $arg"
            exit 1
        }
        default {
            $Target = $arg
        }
    }
}

if (-not (Test-Path (Join-Path $AgentsDir "rules")) -or -not (Test-Path (Join-Path $AgentsDir "workflows"))) {
    Write-Error "Error: agents\rules\ or agents\workflows\ not found in $ScriptDir"
    exit 1
}

$script:installed = 0
$script:skipped = 0

function Copy-Files {
    param(
        [string]$SrcDir,
        [string]$DestDir,
        [string]$Category
    )

    if (-not (Test-Path $SrcDir)) {
        return
    }

    $files = Get-ChildItem -Path $SrcDir -Filter "*.md" -File
    foreach ($file in $files) {
        $basename = $file.Name
        $dest = Join-Path $DestDir $basename

        if ((Test-Path $dest) -and (-not $Force)) {
            Write-Host "  SKIP  $Category/$basename (exists, use --force to overwrite)"
            $script:skipped++
        } else {
            Copy-Item -Path $file.FullName -Destination $dest -Force
            Write-Host "  COPY  $Category/$basename"
            $script:installed++
        }
    }
}

Write-Host ""

$SkillsDest = Join-Path $HOME ".gemini\skills"

if ($GlobalInstall) {
    # Global: rules + workflows
    $RulesDest = Join-Path $HOME ".gemini\antigravity\rules"
    $WorkflowsDest = Join-Path $HOME ".gemini\antigravity\global_workflows"
    
    New-Item -ItemType Directory -Force -Path $RulesDest | Out-Null
    New-Item -ItemType Directory -Force -Path $WorkflowsDest | Out-Null
    New-Item -ItemType Directory -Force -Path $SkillsDest | Out-Null

    Write-Host "Installing globally to ~\.gemini\antigravity\ and ~\.gemini\skills\"
    Write-Host ""
    Copy-Files -SrcDir (Join-Path $AgentsDir "rules") -DestDir $RulesDest -Category "rules"
    Copy-Files -SrcDir (Join-Path $AgentsDir "workflows") -DestDir $WorkflowsDest -Category "workflows"
    Copy-Files -SrcDir (Join-Path $AgentsDir "skills") -DestDir $SkillsDest -Category "skills"
} elseif ($Target) {
    # Project: both rules and workflows
    $RulesDest = Join-Path $Target ".agents\rules"
    $WorkflowsDest = Join-Path $Target ".agents\workflows"
    
    New-Item -ItemType Directory -Force -Path $RulesDest | Out-Null
    New-Item -ItemType Directory -Force -Path $WorkflowsDest | Out-Null
    New-Item -ItemType Directory -Force -Path $SkillsDest | Out-Null

    Write-Host "Installing to $Target\.agents\"
    Write-Host "Installing skills globally to ~\.gemini\skills\"
    Write-Host ""
    Copy-Files -SrcDir (Join-Path $AgentsDir "rules") -DestDir $RulesDest -Category "rules"
    Copy-Files -SrcDir (Join-Path $AgentsDir "workflows") -DestDir $WorkflowsDest -Category "workflows"
    Copy-Files -SrcDir (Join-Path $AgentsDir "skills") -DestDir $SkillsDest -Category "skills"
} else {
    # Current directory: both rules and workflows
    $RulesDest = ".agents\rules"
    $WorkflowsDest = ".agents\workflows"
    
    New-Item -ItemType Directory -Force -Path $RulesDest | Out-Null
    New-Item -ItemType Directory -Force -Path $WorkflowsDest | Out-Null
    New-Item -ItemType Directory -Force -Path $SkillsDest | Out-Null

    Write-Host "Installing to .agents\ in current directory"
    Write-Host "Installing skills globally to ~\.gemini\skills\"
    Write-Host ""
    Copy-Files -SrcDir (Join-Path $AgentsDir "rules") -DestDir $RulesDest -Category "rules"
    Copy-Files -SrcDir (Join-Path $AgentsDir "workflows") -DestDir $WorkflowsDest -Category "workflows"
    Copy-Files -SrcDir (Join-Path $AgentsDir "skills") -DestDir $SkillsDest -Category "skills"
}

Write-Host ""
Write-Host "Done: $script:installed installed, $script:skipped skipped"
Write-Host ""
Write-Host "Available workflows:"
Write-Host "  /magic-brainstorm      Brainstorm ideas into designs"
Write-Host "  /magic-write-plan      Write implementation plan"
Write-Host "  /magic-implement       Implement plan with TDD"
Write-Host "  /magic-verify          Verify implementation"
Write-Host "  /magic-code-review     Review code for production readiness"
Write-Host "  /magic-debug           Systematic debugging"
Write-Host "  /magic-git-worktree    Create isolated workspace"
Write-Host "  /magic-finish-branch   Finish and merge branch"
