---
description: Generate a standup update from recent git activity and session context
argument-hint: Optional context — team name, any blockers, or what you're working on today
---

You are generating a standup update. Read the recent git history and session context to produce a clear, concise update.

## Context
$ARGUMENTS

---

## Process

### Step 1: Gather Context

Run `git log --oneline --since="yesterday" --author="$(git config user.name)"` to see recent commits.

Also check:
- Any files currently open or recently discussed in this session
- Any errors, blockers, or issues mentioned in this conversation

### Step 2: Write the Standup

Format (keep each section to 1-3 bullet points, max):

---

**Yesterday**
- What you completed or made meaningful progress on
- Focus on outcomes, not activities ("shipped the auth API" not "worked on auth")
- Link to PRs or commits if useful

**Today**
- What you plan to work on — be specific
- If continuing yesterday's work, say what the next concrete step is
- One primary focus, one secondary at most

**Blockers**
- Anything preventing progress or requiring someone else's input
- Be specific: who you need, what you need from them, by when
- If no blockers: "None"

---

### Format Options

**Short (Slack / async):**
```
Yesterday: [1-2 lines]
Today: [1-2 lines]
Blockers: None / [specific blocker]
```

**Detailed (team standup):**
```
## [Your name] — [Date]

### Done
- [item]

### In Progress / Today
- [item]

### Blocked
- [item or "None"]

### Notes
- [anything the team should know — upcoming time off, PR ready for review, question for the team]
```

Produce the short format by default. If the context suggests a team standup, produce the detailed format.

Keep it honest and direct. Standups are for coordination, not status theater.
