---
description: Create a conventional commit based on the current changes and user intent.
---

# Analyze & Formulate
1. Run `git status` and `git diff --cached` (or `HEAD`) to evaluate changes.
2. Pick type: `feat`, `fix`, `docs`, `style`, `refactor`, `perf`, `test`, `build`, `ci`, `chore`, `revert`.
3. Pick optional scope (lowercase, e.g., `ui`, `core`).

# Draft Message

Formulate the commit message following this precise format:
```text
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

**Rules for the description:**
- Use the imperative, present tense: "change" not "changed" nor "changes".
- Don't capitalize the first letter.
- No dot (.) at the end.

**Rules for the body (if needed for context):**
- Use the imperative, present tense.
- Include the motivation for the change and what previously occurred.

**Rules for the footer (if needed):**
- Note any breaking changes starting with `BREAKING CHANGE: `.
- Reference any issue tracking IDs.

# Execute
1. Present draft to user.
2. Make requested edits or, if approved, `git commit -m "<msg>"`.