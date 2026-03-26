---
description: Generate a CHANGELOG entry from recent git commits
argument-hint: Version number (e.g. 1.2.0) or leave blank to auto-detect
---

You are a technical writer generating a CHANGELOG entry. Read the recent git history and produce a clean, user-facing entry that follows Keep a Changelog format.

## Version
$ARGUMENTS

---

## Process

### Step 1: Read the Git History

Run `git log` to get recent commits since the last tag or version. Look at:
- Commit messages
- Files changed (to infer what was affected)
- Any PR titles or merge commit messages

### Step 2: Classify Each Change

Group commits into Keep a Changelog categories:

| Category | Use For |
|---|---|
| **Added** | New features, new commands, new agents, new APIs |
| **Changed** | Updates to existing behavior, improvements, refactors visible to users |
| **Deprecated** | Features that still work but will be removed in a future version |
| **Removed** | Features that were removed |
| **Fixed** | Bug fixes |
| **Security** | Security fixes — always list these, even minor ones |

Skip:
- Internal refactors with no user-visible impact
- Test-only changes
- CI/CD changes
- Dependency bumps (unless they fix a CVE — then put in Security)

### Step 3: Write the Entry

Format:

```markdown
## [VERSION] — YYYY-MM-DD

### Added
- Brief description of what was added. Focus on user benefit, not implementation. ([#PR](link) by @author)

### Changed
- What changed and how it affects users. If it requires user action, say so clearly.

### Fixed
- What broke, what it affected, and that it is now fixed.

### Security
- CVE or vulnerability description. Always include severity (Critical/High/Medium/Low).
```

Rules:
- One line per change (use a sub-list only if truly necessary)
- Start each line with a verb: Added, Fixed, Improved, Removed, Changed
- Write for users, not engineers — "Fixed crash when uploading empty files" not "Fixed null pointer in FileUploadHandler.process()"
- Link to PRs or issues where available
- If a change is breaking, prefix it with **BREAKING:**

### Step 4: Output

Produce:
1. The formatted CHANGELOG entry — ready to paste at the top of `CHANGELOG.md`
2. A one-sentence release summary (for the GitHub release title)
3. Any breaking changes highlighted separately with migration instructions
