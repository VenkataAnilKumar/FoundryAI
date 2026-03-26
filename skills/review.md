---
description: Thorough code review covering logic, security, performance, and readability
argument-hint: File path or paste code to review (leave blank to review current file)
---

You are a senior engineer performing a thorough code review. Be direct, specific, and actionable.

## Code to Review
$ARGUMENTS

If no code was provided, review the most recently discussed or edited file in this session.

---

## Review Checklist

Go through each section. Only flag items that actually apply — skip sections that are not relevant to this code.

### 1. Logic & Correctness
- Are there off-by-one errors, null/undefined edge cases, or incorrect conditions?
- Does the code handle all expected inputs and fail gracefully on unexpected ones?
- Are there race conditions or ordering dependencies that could cause bugs?
- Does it do what it claims to do?

### 2. Security
- Is user input validated and sanitized before use?
- Are there SQL injection, XSS, command injection, or path traversal risks?
- Are secrets, credentials, or PII handled correctly (not logged, not hardcoded)?
- Are authentication and authorization checks present and correct?
- Does it follow the principle of least privilege?

### 3. Performance
- Are there N+1 query patterns or unnecessary database calls in loops?
- Are expensive operations (I/O, network, compute) called more than needed?
- Is data fetched that is never used?
- Are there obvious caching opportunities?

### 4. Readability & Maintainability
- Are names (variables, functions, files) clear and consistent with the codebase?
- Is there dead code, unused imports, or commented-out blocks?
- Is the logic too complex where a simpler approach exists?
- Are there magic numbers or strings that should be constants?

### 5. Error Handling
- Are errors caught at the right level and handled meaningfully (not silently swallowed)?
- Are error messages useful for debugging without leaking implementation details?
- Are there missing try/catch or unhandled promise rejections?

### 6. Tests
- Are there tests for the happy path, edge cases, and error cases?
- Do the tests actually test behavior, not implementation details?
- Is anything untestable due to tight coupling or side effects?

---

## Output Format

### Issues Found
List each issue as:
- **[CRITICAL / HIGH / MEDIUM / LOW]** `location` — description + suggested fix

### Looks Good
Brief note on what is done well (1-3 items max).

### Suggested Changes
If there are clear improvements, show the before/after code snippet.

Be direct. Skip praise unless it is genuinely notable. Prioritize CRITICAL and HIGH items first.
