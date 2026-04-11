---
description: Write comprehensive implementation plans with TDD tasks. Every step has real code, no placeholders.
---

# Load Spec
Read the design spec from `.agents/plans/specs/`. If no spec exists,
suggest /magic-brainstorm first.

# Scope Check
If spec covers multiple independent subsystems, suggest breaking into
separate plans — one per subsystem.

# Map File Structure
List files to create/modify with responsibilities. Design units with
clear boundaries. Prefer smaller, focused files.

For each file, note:
- Purpose (single responsibility)
- Dependencies (what it imports/uses)
- Test file location

# Define Tasks
Each task = 2-5 minutes of work with this structure:

## Task N: [Name]
**Files:** Create/Modify/Test paths
- [ ] Write failing test (with code)
- [ ] Run test, verify it fails
- [ ] Write minimal implementation (with code)
- [ ] Run test, verify it passes
- [ ] Commit

**Verification:** exact command to run

# No Placeholders
Every step must contain actual content. Never write:
- "TBD", "TODO", "implement later"
- "Add appropriate error handling"
- "Similar to Task N" (repeat the code)
- Steps without code blocks for code steps

# Self-Review
Check: spec coverage, placeholder scan, type consistency across tasks.
Fix issues inline.

Verify:
- Every spec requirement has a corresponding task
- Every task has a verification command
- No circular dependencies between tasks

# Save Plan
Save to `.agents/plans/YYYY-MM-DD-hh-mm-ss-<feature-name>.md`

# Transition
Once the user approves the plan, automatically proceed to
implementation (or the user can invoke /magic-implement manually).
