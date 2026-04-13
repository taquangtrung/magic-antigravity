#!/usr/bin/env bash
set -euo pipefail

# Superpowers for Antigravity — Install Script
# Copies rules and workflows to Antigravity's expected locations.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILL_DIR="$SCRIPT_DIR/skills"

usage() {
    cat <<EOF
Usage: ./install.sh [OPTIONS] [TARGET_DIR]

Install Superpowers rules and workflows for Antigravity.

Options:
  --global       Install globally to ~/.gemini/antigravity/
                 Rules  → ~/.gemini/antigravity/rules/
                 Workflows → ~/.gemini/antigravity/global_workflows/
  --force        Overwrite existing files
  --help         Show this help

Arguments:
  TARGET_DIR     Install to a specific project directory
                 (copies to TARGET_DIR/.agents/{rules,workflows}/)

Examples:
  ./install.sh --global                  # Global workflows only
  ./install.sh --global --force          # Global workflows, overwrite existing
  ./install.sh /path/to/project          # Project install (rules + workflows)
  ./install.sh                           # Install to current directory
EOF
}

# Parse arguments
GLOBAL=false
FORCE=false
TARGET=""

for arg in "$@"; do
    case "$arg" in
        --global) GLOBAL=true ;;
        --force) FORCE=true ;;
        --help) usage; exit 0 ;;
        --*) echo "Unknown option: $arg"; usage; exit 1 ;;
        *) TARGET="$arg" ;;
    esac
done

# Copy helper
installed=0
skipped=0

copy_files() {
    local src_dir="$1"
    local dest_dir="$2"
    local category="$3"

    for file in "$src_dir"/*.md; do
        [ -f "$file" ] || continue
        local basename=$(basename "$file")
        local dest="$dest_dir/$basename"

        if [ -f "$dest" ] && [ "$FORCE" = false ]; then
            echo "  SKIP  $category/$basename (exists, use --force to overwrite)"
            ((skipped++)) || true
        else
            cp "$file" "$dest"
            echo "  COPY  $category/$basename"
            ((installed++)) || true
        fi
    done
}

# Verify source exists
if [ ! -d "$SKILL_DIR/rules" ] || [ ! -d "$SKILL_DIR/workflows" ]; then
    echo "Error: skills/rules/ or skills/workflows/ not found in $SCRIPT_DIR"
    exit 1
fi

echo ""

if [ "$GLOBAL" = true ]; then
    # Global: rules + workflows
    RULES_DEST="$HOME/.gemini/antigravity/rules"
    WORKFLOWS_DEST="$HOME/.gemini/antigravity/global_workflows"
    mkdir -p "$RULES_DEST" "$WORKFLOWS_DEST"
    echo "Installing globally to ~/.gemini/antigravity/"
    echo ""
    copy_files "$SKILL_DIR/rules" "$RULES_DEST" "rules"
    copy_files "$SKILL_DIR/workflows" "$WORKFLOWS_DEST" "workflows"
elif [ -n "$TARGET" ]; then
    # Project: both rules and workflows
    RULES_DEST="$TARGET/.agents/rules"
    WORKFLOWS_DEST="$TARGET/.agents/workflows"
    mkdir -p "$RULES_DEST" "$WORKFLOWS_DEST"
    echo "Installing to $TARGET/.agents/"
    echo ""
    copy_files "$SKILL_DIR/rules" "$RULES_DEST" "rules"
    copy_files "$SKILL_DIR/workflows" "$WORKFLOWS_DEST" "workflows"
else
    # Current directory: both rules and workflows
    RULES_DEST=".agents/rules"
    WORKFLOWS_DEST=".agents/workflows"
    mkdir -p "$RULES_DEST" "$WORKFLOWS_DEST"
    echo "Installing to .agents/ in current directory"
    echo ""
    copy_files "$SKILL_DIR/rules" "$RULES_DEST" "rules"
    copy_files "$SKILL_DIR/workflows" "$WORKFLOWS_DEST" "workflows"
fi

echo ""
echo "Done: $installed installed, $skipped skipped"
echo ""
echo "Available workflows:"
echo "  /magic-brainstorm      Brainstorm ideas into designs"
echo "  /magic-write-plan      Write implementation plan"
echo "  /magic-implement       Implement plan with TDD"
echo "  /magic-verify          Verify implementation"
echo "  /magic-code-review     Review code for production readiness"
echo "  /magic-debug           Systematic debugging"
echo "  /magic-git-worktree    Create isolated workspace"
echo "  /magic-finish-branch   Finish and merge branch"
