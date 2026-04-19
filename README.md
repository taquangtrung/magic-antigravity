# Magic Skills for Antigravity

A structured development workflow system for [Google Antigravity](https://antigravity.google). Enforces disciplined software engineering practices: brainstorm before coding, plan before implementing, test before committing, verify before claiming, review before merging.

Ported from the awesome project [Superpowers](https://github.com/obra/superpowers) by [Jesse Vincent](https://github.com/obra/) since Superpowers does not support Antigravity directly.

## Quick Start

```bash
# Clone this repo
git clone https://github.com/taquangtrung/antigravity-magicskills.git
cd antigravity-magicskills

# Install globally on Linux/macOS
./install.sh --global

# Install globally on Windows (PowerShell)
.\install.ps1 --global
```

## The Pipeline

```
User prompt → Orchestrator auto-routes:

  Creative work → Brainstorm → [approve] → Write Plan → [approve] → Implement (TDD: Test-Driven Development) → Verify → Review → Finish
  Bug fix       → Systematic Debug
  Trivial task  → Direct execution
```

The orchestrator rule automatically classifies tasks and starts the appropriate workflow. You control the flow through **approval gates** (approve spec, approve plan), not by typing slash commands.

## What Gets Installed

### Rules (always-on discipline)

| File | Purpose |
|------|---------|
| `magic-orchestrator.md` | Auto-routes tasks to the right workflow |
| `magic-test-driven-development.md` | Enforces TDD: write test → fail → implement → pass |
| `magic-verification-discipline.md` | Requires evidence before completion claims |
| `magic-code-review-reception.md` | Technical evaluation over performative agreement |

### Workflows (slash commands)

| Command | Purpose |
|---------|---------|
| `/magic-brainstorm` | Turn ideas into designs through dialogue |
| `/magic-write-plan` | Create detailed implementation plans |
| `/magic-implement` | Execute plan tasks with TDD discipline |
| `/magic-verify` | Run tests, lint, build, spec compliance |
| `/magic-code-review` | Review code for production readiness |
| `/magic-debug` | Systematic root cause analysis |
| `/magic-git-worktree` | Create isolated workspace for branches |
| `/magic-finish-branch` | Merge, PR, or cleanup branch |

## Installation Options

- On Linux/macOS:

  ```bash
  # Global (all projects)
  ./install.sh --global

  # Specific project
  ./install.sh /path/to/project

  # Current directory
  ./install.sh

  # Overwrite existing files
  ./install.sh --global --force
  ```

- On Windows (PowerShell):

  ```powershell
  # Global (all projects)
  .\install.ps1 --global

  # Specific project
  .\install.ps1 C:\path\to\project

  # Current directory
  .\install.ps1

  # Overwrite existing files
  .\install.ps1 --global --force
  ```

### Where Files Go

Files are installed to the same relative paths on both Linux/macOS and Windows:

| Install Type | Rules | Workflows | Skills |
|:-------------|:------|:----------|:-------|
| Global | `~/.gemini/antigravity/rules/` | `~/.gemini/antigravity/global_workflows/` | `~/.gemini/skills/` |
| Project | `<project>/.agents/rules/` | `<project>/.agents/workflows/` | `~/.gemini/skills/` |

*Note on Windows: `~` resolves to your user home directory (e.g., `C:\Users\Username`).*

## Workflow Artifacts

Workflows save specs and plans to `.agents/plans/` in the target project:
- Specs: `.agents/specs/YYYY-MM-DD-hh-mm-ss-<topic>-design.md`
- Plans: `.agents/plans/YYYY-MM-DD-hh-mm-ss-<feature-name>.md`

## Reference Docs

The `docs/` folder contains supplementary reference material (not installed):
- `testing-anti-patterns.md` — Common testing mistakes and fixes
- `root-cause-tracing.md` — How to trace bugs to their source
- `defense-in-depth.md` — Multi-layer validation strategy
- `condition-based-waiting.md` — Fix flaky tests with condition polling

## Credits

Based on [Superpowers](https://github.com/obra/superpowers) by [Jesse Vincent](https://github.com/obra/).

Adapted for [Google Antigravity](https://antigravity.google) using native Rules and Workflows.
