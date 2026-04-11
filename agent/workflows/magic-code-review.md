---
description: Review code changes against requirements for production readiness. Evaluate technically, no rubber stamping.
---

# Get Diff
```bash
git diff --stat HEAD~N..HEAD
git diff HEAD~N..HEAD
```
Identify all changed files and scope of changes.

# Review Checklist

**Code Quality:**
- Separation of concerns — each unit does one thing
- Error handling — all failure paths covered
- DRY — no duplicated logic
- Edge cases — boundary conditions handled

**Architecture:**
- Design decisions align with spec
- No unnecessary complexity

**Testing:**
- Tests verify real logic (not mocks of behavior)
- Edge cases covered
- Tests are readable and maintainable

**Requirements:**
- Plan alignment — all tasks completed
- Spec match — no missing requirements
- No scope creep — nothing extra built

# Categorize Issues
- **Critical** (must fix): bugs, security vulnerabilities, data loss risks
- **Important** (should fix): architecture issues, missing tests, test gaps
- **Minor** (nice to have): style improvements, optimization, docs

# Report
## Strengths
What was done well.

## Issues (with file:line references)
Each issue with: severity, file:line, description, suggested fix.

## Assessment
Ready to merge? [Yes / No / With fixes]

# Transition
If ready to merge (or after fixes applied): automatically proceed to
the branch finishing process (or the user can invoke /magic-finish-branch manually).
If critical issues found: fix, re-run /magic-verify, then /magic-code-review.
