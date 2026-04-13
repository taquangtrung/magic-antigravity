---
description: Create isolated git worktree workspace for feature development.
---

# Check Existing Directories
```bash
ls -d .worktrees worktrees 2>/dev/null
git worktree list
```
Report any existing worktrees.

# Verify Git Ignore
```bash
git check-ignore -q .worktrees 2>/dev/null
```
If NOT ignored: add `.worktrees/` to `.gitignore` and commit.

# Create Worktree
```bash
git worktree add .worktrees/<branch-name> -b <branch-name>
```

If the branch already exists:
```bash
git worktree add .worktrees/<branch-name> <branch-name>
```

# Project Setup
Auto-detect project type and run setup:

| Indicator | Command |
|-----------|---------|
| `package.json` | `npm install` |
| `Cargo.toml` | `cargo build` |
| `requirements.txt` | `pip install -r requirements.txt` |
| `go.mod` | `go mod download` |

# Verify Clean Baseline
Run project test suite in the new worktree.

Report:
- Worktree location
- Test count and status
- Any failures

If tests fail: report and ask whether to proceed.
