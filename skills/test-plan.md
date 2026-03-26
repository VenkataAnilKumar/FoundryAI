---
description: Generate a complete test plan — unit, integration, E2E, edge cases, and coverage targets
argument-hint: Describe the function, feature, or system to test
---

You are a QA engineer writing a test plan. Be specific — list actual test cases with inputs and expected outputs, not categories.

## What to Test
$ARGUMENTS

---

## Test Plan

### 1. Scope

**What is being tested**: [component/feature name]
**What is NOT being tested**: [explicit exclusions]
**Test environment**: unit / integration / E2E / all three
**Pass criteria**: what must be true before this can ship?

---

### 2. Unit Tests

Test individual functions and methods in isolation. Mock all external dependencies.

For each testable unit:

**`functionName()`**

| Test Case | Input | Expected Output | Notes |
|---|---|---|---|
| Happy path | typical valid input | expected return value | |
| Empty input | `""` / `null` / `[]` | error or default | |
| Boundary | min/max valid value | expected behavior | |
| Invalid type | wrong type | throws `TypeError` | |

Write test cases for:
- Every branch in conditional logic (if/else, switch)
- Every error throw
- Every return value variant
- Any time-dependent behavior (mock the clock)
- Any random behavior (mock the random source)

**Coverage target**: 80%+ line coverage, 100% for critical business logic paths

---

### 3. Integration Tests

Test how components work together. Use real dependencies where practical (real DB, real file system).

**Integration scenarios to test:**

| Scenario | Setup | Steps | Expected Outcome |
|---|---|---|---|
| [describe scenario] | [preconditions] | [actions] | [result + state] |

Common integration boundaries to test:
- API → Database (does data persist correctly?)
- API → External service (does the call format correctly? is error handling correct?)
- Service A → Service B (do they communicate correctly at the boundary?)
- Authentication middleware → protected routes

**Test data strategy:**
- Use a test database that is reset between test runs
- Use factory functions to create test data — not hardcoded IDs
- Clean up after each test

---

### 4. End-to-End Tests

Test the full user journey. Run against a staging environment.

**Critical user flows to test:**

| Flow | Steps | Pass Criteria |
|---|---|---|
| [primary happy path] | 1. [step] 2. [step] | [what the user sees/gets] |
| [error recovery flow] | | |
| [edge case flow] | | |

Automate with: Playwright (web) / Detox (mobile) / Supertest (API only)

Run on: every PR to main, every deploy to staging, before every production deploy

---

### 5. Edge Cases and Negative Tests

These are the tests that catch the bugs that unit tests miss:

**Input edge cases:**
- Empty string `""`
- String with only whitespace `"   "`
- Very long string (> 10,000 chars)
- String with special characters: `<>'"&\n\t\0`
- Unicode and emoji: `🔥`, `中文`, `العربية`
- SQL injection: `' OR '1'='1`
- XSS: `<script>alert('xss')</script>`
- Null, undefined, NaN
- Negative numbers, zero, extremely large numbers
- Arrays: empty, single element, very large (10,000+ items)
- Dates: past, future, invalid (`2024-13-45`), DST edge cases

**Concurrency edge cases:**
- Two requests modifying the same resource simultaneously
- Request interrupted mid-transaction
- Timeout during long operation

**State edge cases:**
- Operation on already-deleted resource
- Operation on resource in wrong state
- Duplicate request (idempotency check)

---

### 6. Performance Tests

Only include if performance requirements exist:

| Test | Setup | Pass Criteria |
|---|---|---|
| Latency baseline | 1 concurrent user | p50 < Xms, p95 < Xms |
| Load test | 100 concurrent users | p95 < Xms, error rate < 0.1% |
| Stress test | Ramp to breaking point | Graceful degradation, no data loss |
| Soak test | 100 users for 24h | No memory leak, stable latency |

---

### 7. Manual Test Checklist

Things that are hard to automate — do these before each release:

- [ ] [specific manual check 1]
- [ ] [specific manual check 2]
- [ ] Cross-browser: Chrome, Firefox, Safari (for web features)
- [ ] Mobile: iOS Safari, Android Chrome (for responsive features)
- [ ] Accessibility: tab navigation works, screen reader announces correctly

---

### 8. Test Execution Plan

| Phase | When to Run | Blocking? | Estimated Time |
|---|---|---|---|
| Unit tests | Every commit | Yes | < 2 min |
| Integration tests | Every PR | Yes | < 10 min |
| E2E tests | Pre-deploy to staging | Yes | < 20 min |
| Performance tests | Weekly / pre-major-release | No (review results) | 1-2 hours |
| Manual checklist | Pre-release | Yes | 30-60 min |
