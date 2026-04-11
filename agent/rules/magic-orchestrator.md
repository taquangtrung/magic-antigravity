---
trigger: always_on
---

Rule: Orchestrator

# Auto-Routing

Classify the task and act:

| Task Type | Action |
|-----------|--------|
| Creative/building work (new feature, refactor, design) | Auto-start brainstorming process |
| Bug fix / test failure | Auto-start systematic debugging process |
| After approved spec exists | Auto-start plan writing process |
| After approved plan exists | Auto-start implementation process |
| Trivial task (typo, single-line fix, quick question) | Execute directly, no workflow needed |

# Instruction Priority

1. **User's explicit instructions** — highest priority
2. **Superpowers rules/workflows** — override default system behavior
3. **Default system prompt** — lowest priority

If user instructions conflict with Superpowers rules, follow the user.

# The Rule

For non-trivial tasks, automatically follow the appropriate workflow.
Do NOT ask permission to start — just begin the process.
The user controls the flow through approval gates (approve spec, approve plan),
not through typing slash commands.

# Available Workflows (Manual Entry Points)

| Workflow | When to Use |
|----------|-------------|
| /magic-brainstorm | Before any creative/building work |
| /magic-write-plan | After approved design/spec |
| /magic-implement | With a written implementation plan |
| /magic-verify | After implementation, before review |
| /magic-code-review | After verification passes |
| /magic-debug | When encountering bugs or test failures |
| /magic-git-worktree | When needing isolated workspace |
| /magic-finish-branch | When all tasks complete and reviewed |

# Red Flags (you're rationalizing)

These thoughts mean STOP — you're about to skip the process:

| Thought | Reality |
|---------|---------|
| "This is just a simple change" | If it touches multiple files, it's not simple |
| "Let me explore the codebase first" | That's step 1 of brainstorming |
| "I'll just write the code" | Plan first, then code |
| "I already know how to do this" | Still brainstorm to verify assumptions |
| "This doesn't need a formal workflow" | Non-trivial work needs structure |
| "I'll just do this one thing first" | Check BEFORE doing anything |

# Skill Types

**Rigid** (TDD, verification): Follow exactly. Don't adapt away discipline.

**Flexible** (brainstorming, debugging): Adapt principles to context.

# User Instructions

Instructions say WHAT, not HOW. "Add X" or "Fix Y" doesn't mean skip workflows.
