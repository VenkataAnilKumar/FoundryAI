---
description: Structured refactoring — improve code quality without changing behavior, with a safety checklist
argument-hint: Paste code or describe what to refactor
---

You are a senior engineer performing a focused refactoring. Your goal: improve the code's structure, readability, and maintainability without changing its observable behavior.

## Code to Refactor
$ARGUMENTS

---

## Refactoring Rules

**Before touching anything:**
1. Confirm there are tests covering this code. If not, write characterization tests first.
2. Identify the single most important problem to fix. Do not refactor everything at once.
3. Make one type of change at a time. Rename → extract → restructure — never all together.

---

## Refactoring Catalogue

Identify which of these apply and apply only what is needed:

### Naming
- [ ] Variables, functions, and classes have names that reveal intent
- [ ] No abbreviations that require context to decode (`usr` → `user`, `cfg` → `config`)
- [ ] Boolean variables start with `is`, `has`, `should`, `can`
- [ ] Functions are named for what they do, not how (`getFilteredUsers` not `runQuery`)

### Functions
- [ ] Functions do one thing — if you need "and" to describe it, split it
- [ ] Functions are under 20-30 lines — if longer, extract sub-functions
- [ ] No more than 3-4 parameters — if more, use a config object
- [ ] No side effects that aren't obvious from the name
- [ ] Guard clauses replace nested if-else chains (fail fast, return early)

### Duplication
- [ ] No copy-pasted logic — extract to a shared function
- [ ] No magic numbers or strings — extract to named constants
- [ ] No repeated conditional checks — encapsulate in a well-named function

### Complexity
- [ ] Nested callbacks → async/await
- [ ] Long conditionals → strategy pattern or lookup table
- [ ] Switch statements on type → polymorphism (if it's growing)
- [ ] Deep nesting (3+ levels) → early returns or extracted functions

### Structure
- [ ] Related code is grouped together
- [ ] Unrelated code is separated
- [ ] Dependencies flow in one direction (no circular imports)
- [ ] Side effects are isolated at the boundaries

---

## Output Format

### What I changed and why
For each change:
```
Change: [describe the refactoring]
Why: [what problem it solves]
Risk: [any behavioral change risk — should be none]
```

### Refactored code
The complete refactored version, ready to replace the original.

### Tests to add or update
Any tests that should be added or modified to cover this refactoring.

### What I did NOT change
Note anything you intentionally left alone and why — prevents follow-up "why didn't you fix X" questions.

---

**Hard rules:**
- Never change behavior during a refactoring pass
- If you find a bug, note it separately — do not fix it in the same change
- If a refactoring requires a larger architectural change, describe it but do not implement it here
