---
name: magic-brainstorm
description: Turn ideas into fully formed designs through collaborative dialogue. Do NOT write any code until the user approves the design.
---

# Explore Project Context
Check files, docs, recent commits to understand the current state.
Identify existing patterns, conventions, and constraints.

# Ask Clarifying Questions
- One question at a time
- Prefer multiple choice when possible
- Focus on: purpose, constraints, success criteria
- If scope too large, help decompose into sub-projects first

# Propose Approaches
- Present 2-3 approaches with trade-offs
- Lead with your recommendation and reasoning
- Include: complexity, risk, maintainability for each

# Present Design
- Present design in sections, scaled to complexity
- Ask after each section if it looks right
- Cover: architecture, components, data flow, error handling, testing
- Design for isolation: each unit has one clear purpose
- Include: what is NOT in scope (YAGNI boundaries)

# Write Design Doc
Save to `.agents/specs/YYYY-MM-DD-hh-mm-ss-<topic>-design.md` where the time is based on the current machine's timezone.

The doc should contain:
- Goal and constraints
- Chosen approach with reasoning
- Architecture / component overview
- Data flow
- Error handling strategy
- Testing strategy
- Out of scope items

# Spec Self-Review
Check for: placeholders/TODOs, internal contradictions, scope creep,
ambiguous requirements. Fix inline.

# User Review Gate
Ask user to review the written spec before proceeding.
Wait for explicit approval.

# Transition
Once the user approves the spec, automatically proceed to the plan
writing process: choose among the existing plan skills or ask the user to manually choose it.

# Key Principles
- YAGNI ruthlessly — remove unnecessary features
- One question at a time — don't overwhelm
- Incremental validation — present, approve, move on
- Design for testability — if it's hard to test, simplify