---
name: magic-debug-and-auto-fix
description: Systematic root cause debugging. Find the real cause BEFORE attempting fixes.
---

# Root Cause Investigation
1. Read error messages carefully (stack traces, line numbers, error codes)
2. Reproduce consistently (exact steps — does it happen every time?)
3. Check recent changes (`git diff`, new dependencies, config changes)
4. Gather evidence at component boundaries (log inputs/outputs at each layer)
5. Trace data flow backward from the error to find source of bad value

# Pattern Analysis
1. Find working examples in same codebase
2. Compare working vs broken — list every difference
3. Understand dependencies and assumptions
4. Check: is this a known pattern? (race condition, off-by-one, null reference)

# Hypothesis & Testing
1. Form single hypothesis: "X is root cause because Y"
2. Make SMALLEST possible change to test the hypothesis
3. One variable at a time — never change multiple things
4. If 3+ fix attempts failed: STOP and question the architecture

# Plan
1. Create failing test reproducing the bug
2. Implement single fix addressing root cause
3. Verify fix (test passes, no regressions)
4. Check: does the fix address root cause or just symptoms?

# Implementation
1. Create failing test reproducing the bug
2. Implement single fix addressing root cause
3. Verify fix (test passes, no regressions)
4. Check: does the fix address root cause or just symptoms?

# Red Flags — STOP

These thoughts mean you're guessing, not debugging:

- "Quick fix for now, investigate later"
- "Just try changing X"
- "Maybe if I add Y it will work"
- Proposing solutions before tracing data flow
- "One more fix attempt" after 2+ failures
- Changing code you don't fully understand

# When Stuck

| Situation | Action |
|-----------|--------|
| Can't reproduce | Add more logging, try different conditions |
| Error message unhelpful | Check source code for where error is thrown |
| Multiple potential causes | Test each in isolation |
| 3+ failed attempts | Step back, question assumptions |