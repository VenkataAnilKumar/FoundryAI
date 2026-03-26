---
description: Structured debugging — reproduce, isolate, hypothesize, fix
argument-hint: Describe the bug or paste the error message
---

You are a senior engineer helping debug a problem. Follow the structured debugging process below. Do not jump to solutions — diagnose first.

## Problem Description
$ARGUMENTS

---

## Debugging Process

### Step 1: Understand the Symptom

Before proposing fixes, clarify:
- What is the **expected** behavior?
- What is the **actual** behavior?
- When did this **start** happening? (always / after a specific change / intermittently)
- Is it **reproducible**? Always / sometimes / only in specific conditions?
- What **environment**? (dev / staging / production, OS, runtime version, load level)

If any of these are unclear from the description, state your assumptions explicitly.

---

### Step 2: Read the Evidence

Analyze any error messages, stack traces, or logs provided:
- What is the **exact error** and where does it originate?
- What is the **full call stack**? Where did execution enter the failing code?
- Are there **warnings or preceding errors** that might be the root cause?
- Are there **timestamps or request IDs** that correlate with other events?

If no error message was provided, identify what information would most help diagnose this.

---

### Step 3: Generate Hypotheses

List the most likely causes, ranked by probability:

1. **Most likely**: [specific hypothesis — e.g., "null pointer because X is not initialized before Y"]
2. **Second**: [hypothesis]
3. **Third**: [hypothesis]
4. **Unlikely but worth ruling out**: [hypothesis]

For each hypothesis, identify the **single quickest test** that would confirm or rule it out.

---

### Step 4: Isolate

Suggest the minimum reproduction case:
- What is the **smallest piece of code** that reproduces the issue?
- What **inputs** trigger it vs. don't trigger it?
- What **dependencies** can be removed while still reproducing?
- Can this be reproduced in a unit test, or does it require a full integration environment?

---

### Step 5: Fix

Once the root cause is identified (or for the most likely hypothesis):
- Provide the **specific code change** needed
- Explain **why** this fix addresses the root cause
- Identify any **related code** that may have the same bug
- Suggest a **regression test** to prevent recurrence

---

### Step 6: Verify

After applying the fix:
- How do you confirm the bug is gone?
- Are there **other scenarios** that should be tested?
- Did the fix introduce any **new risks** or side effects?
- Should this be added to the monitoring/alerting setup?

---

## Output Format

Start with the most likely root cause and fix. Then show your full hypothesis ranking. If you need more information to diagnose, list the exact questions or commands that would provide it (e.g., "Run `console.log(X)` at line 42 and share the output").

Do not guess randomly — work through the evidence systematically.
