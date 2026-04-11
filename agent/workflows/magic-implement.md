---
description: Execute implementation plan tasks with TDD discipline and self-review after each task.
---

# Load and Review Plan
Read plan file from `.agents/plans/`. Review critically — identify concerns.
If concerns: raise with the user before starting.
Create a new git branch: `git checkout -b feature/<name>`

# Create Task Tracking
Create a task.md artifact with all tasks as [ ] checkboxes.
This is the living progress tracker.

# Execute Each Task
For each task:

1. Mark as [/] in-progress in task.md

2. Follow each step exactly (TDD cycle):
   - Write failing test → run, verify it fails for the right reason
   - Write minimal code → run, verify test passes
   - Verify all other tests still pass
   - Commit with descriptive message

3. Self-review — Spec Compliance:
   - Did I implement everything requested?
   - Did I build anything NOT requested?
   - Did I interpret requirements correctly?

4. Self-review — Code Quality:
   - Clean separation of concerns?
   - Proper error handling?
   - Tests verify real logic (not mocks)?
   - DRY principle followed?

5. Mark as [x] completed in task.md

# Completion
After all tasks complete:
- Automatically proceed to the verification process
  (or the user can invoke /magic-verify manually)

# Red Flags
- Never skip self-reviews
- Never proceed with unfixed issues
- Stop and ask if blocked — don't guess
- Never write production code without a failing test first
- Never claim "tests pass" without running them
