---
description: Draft release notes — what's new, breaking changes, upgrade steps, migration guide
argument-hint: Version number and optionally what changed (e.g. "2.0.0 — new auth system")
---

You are writing release notes for a software release. Your audience is developers and users who are deciding whether to upgrade. Be clear, specific, and honest.

## Release
$ARGUMENTS

---

## Release Notes Structure

### 1. Release Header
```
# Release [VERSION] — [Date]
```
One sentence: what is the theme of this release? e.g., "Performance and reliability improvements" or "Introduces the new agent routing system."

### 2. Highlights (top 3-5 changes)
The most important things in this release. Write these for a user who will spend 30 seconds skimming.
- Lead with the user benefit, not the technical implementation
- Each highlight gets 1-2 sentences max
- If there are no exciting highlights, skip this section

### 3. Breaking Changes
⚠️ **This section is mandatory if any breaking changes exist.**

For each breaking change:
```
### BREAKING: [What changed]
**Who is affected**: [describe affected users]
**Migration required**: Yes / No
**Steps to migrate**:
1. [step]
2. [step]
**Deadline**: [if there is a deprecation period]
```

If there are no breaking changes, write: "No breaking changes in this release."

### 4. What's New
Grouped by area (e.g., API, CLI, UI, Performance). For each new feature:
- Feature name in bold
- One sentence on what it does
- How to use it (code snippet or command if applicable)
- Link to documentation

### 5. Bug Fixes
A clean list. Format: "Fixed [symptom]. ([#issue])"
- Only include fixes that users could have encountered
- Skip internal/test fixes

### 6. Performance Improvements
If applicable: what improved, by how much, under what conditions.
- Be specific: "Reduced p95 latency from 450ms to 120ms under 1000 concurrent users"
- Not specific enough: "Improved performance"

### 7. Security Fixes
Always list security fixes, even if patched silently. Format:
- **[CVE-XXXX-XXXX / Severity]**: Brief description. No exploit details. Credit to reporter if they consented.

### 8. Deprecations
Features that still work but will be removed in a future version:
- What is deprecated
- What replaces it
- When it will be removed
- Migration path

### 9. Upgrade Instructions
Step-by-step for the most common upgrade path:
```bash
# Example
npm install package@VERSION
# or
pip install package==VERSION
```
Include any post-upgrade steps (run migrations, restart services, clear cache, update config).

### 10. Known Issues
Be honest. List known issues that will be fixed in the next release. Users appreciate transparency more than discovering surprises.

---

## Tone Guidelines
- Direct and factual, not promotional
- Use "you" and "your" — write to the reader
- Don't say "exciting", "powerful", "robust", or "seamless" — show don't tell
- If something broke, say it broke and that it's fixed — don't soften it
