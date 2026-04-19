---
description: Systematic root cause debugging. Find the real cause and confirm BEFORE attempting fixes.
---

# The Iron Law

```
DO NOT WRITE ANY FIX CODE UNTIL THE USER CONFIRMS THE ROOT CAUSE.
```

**Debugging code IS allowed** during investigation — logging, reproduction scripts, diagnostic instrumentation, temporary assertions. These help gather evidence.

**Fix code is NOT allowed** until after the approval gate — production changes, refactors, behavior modifications, "quick patches."

Investigation and fixing are SEPARATE phases with a hard gate between them.

# Phase 1: Root Cause Investigation

1. Read error messages carefully (stack traces, line numbers, error codes)
2. Reproduce consistently (exact steps — does it happen every time?)
3. Check recent changes (`git diff`, new dependencies, config changes)
4. Gather evidence at component boundaries (log inputs/outputs at each layer)
5. Trace data flow backward from the error to find source of bad value

# Phase 2: Pattern Analysis

1. Find working examples in same codebase
2. Compare working vs broken — list every difference
3. Understand dependencies and assumptions
4. Check: is this a known pattern? (race condition, off-by-one, null reference)

# Phase 3: Hypothesis & Testing

1. Form single hypothesis: "X is root cause because Y"
2. Gather evidence supporting or refuting the hypothesis (debugging code allowed)
3. One variable at a time — never change multiple things simultaneously
4. If hypothesis is wrong: form a new one from evidence, repeat
5. If 3+ hypotheses failed: STOP and question your assumptions

# ⛔ MANDATORY GATE — Present Findings & Wait for Approval

**STOP HERE. Do NOT proceed to fixing.**

Present to the user:
1. **Root cause**: Single clear statement of what is broken and why
2. **Evidence**: Specific code paths, values, logs, or diffs that prove it
3. **Impact**: What this bug affects (other components, edge cases)
4. **Proposed fix**: High-level description of what you would change
5. **Risk assessment**: What could break, what else to verify

Then **wait for the user to explicitly approve** before proceeding.

```
IF user says "go ahead" / "fix it" / approves → proceed to Phase 4
IF user asks questions → answer, update findings, wait again
IF user disagrees → re-investigate with their input
```

# Phase 4: Plan & Implement Fix (ONLY after approval)

1. Remove debugging instrumentation from investigation phases
2. Create failing test reproducing the bug
3. Implement single fix addressing the confirmed root cause
4. Verify fix (test passes, no regressions)
5. Check: does the fix address root cause or just symptoms?

# Red Flags — STOP

**During investigation (Phases 1–3):**

- "Quick fix for now, investigate later"
- "Maybe if I add Y it will work"
- Proposing solutions before tracing data flow
- Changing production code you don't fully understand
- Writing fix code disguised as "debugging"

**At the gate:**

- **Skipping the approval gate because "it's obvious"**
- **Presenting a fix without evidence for the root cause**
- Conflating symptoms with root cause

**During fix (Phase 4):**

- Fixing something different from the approved root cause
- Scope creep — "while I'm here, let me also..."

# When Stuck

| Situation | Action |
|-----------|--------|
| Can't reproduce | Add more logging, try different conditions |
| Error message unhelpful | Check source code for where error is thrown |
| Multiple potential causes | Test each in isolation |
| 3+ failed hypotheses | Step back, question assumptions |
| Can't determine root cause | Present partial findings at the gate, ask the user for direction |
| User disagrees with root cause | Re-investigate with their perspective |