---
description: Finish a development branch — verify tests, merge/PR/cleanup.
---

# Verify Tests
Run full test suite. If tests fail: STOP, fix before proceeding.

Report:
- Test command and result
- All passing? Any skipped?

# Present Options

Ask the user which option they prefer:

1. **Merge** back to main locally
2. **Push** and create a Pull Request
3. **Keep** the branch as-is
4. **Discard** this work

# Execute Choice

**Option 1 (Merge):**
```bash
git checkout main
git pull origin main
git merge <branch-name>
git branch -d <branch-name>
```

**Option 2 (PR):**
```bash
git push -u origin <branch-name>
gh pr create --fill
```
If `gh` is not available, provide the GitHub URL for manual PR creation.

**Option 3 (Keep):**
Report branch location, keep worktree if applicable.

**Option 4 (Discard):**
Require the user to type "discard" to confirm.
```bash
git checkout main
git branch -D <branch-name>
```

# Cleanup
Remove worktree if applicable (Options 1, 2, 4 only):
```bash
git worktree remove .worktrees/<branch-name>
```

Report final state: current branch, worktree status, remaining cleanup.
