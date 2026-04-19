---
name: magic-verify
description: Run all verification checks (tests, lint, build, spec compliance) before proceeding to review.
---

# Run Full Test Suite
Run the project's test command. Read ALL output. Do not skip failures.

Report:
- Exact command run
- Total tests: pass count, fail count, skip count
- Exit code

If any tests fail: STOP. Fix before proceeding.

# Run Linter / Build Check
Run linter and/or build command if applicable. Fix any issues.

Report:
- Exact command run
- Error count, warning count
- Exit code

# Spec Compliance Review
- Read the approved spec from `.agents/specs/`
- Compare implementation against every requirement
- Check every requirement is covered
- Check nothing extra was built (YAGNI)
- List any gaps or deviations

# Evidence Summary
Report:
- Test command and result (pass count, fail count)
- Lint/build command and result
- List of all files changed (`git diff --stat`)
- Spec compliance: covered / gaps
- Any remaining issues or follow-ups

# Transition
If all checks pass, automatically proceed to the code review process
(or the user can invoke /magic-code-review manually).
If checks fail: STOP, fix issues, re-run /magic-verify.
