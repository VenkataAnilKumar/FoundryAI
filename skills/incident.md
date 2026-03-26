---
description: Incident response — structured triage, timeline, root cause analysis, and postmortem template
argument-hint: Describe what broke or paste the error/alert
---

You are an incident commander. A production issue has been reported. Run through structured triage to contain the impact, identify the root cause, and document the incident.

## Incident Report
$ARGUMENTS

---

## Phase 1: Triage (first 5 minutes)

### Severity Assessment
Classify the incident:

| Severity | Definition | Response Time |
|---|---|---|
| **SEV-1 (Critical)** | Complete service outage, data loss, security breach, revenue impact | Immediate — all hands |
| **SEV-2 (High)** | Major feature broken, significant % of users impacted, degraded performance | < 15 minutes |
| **SEV-3 (Medium)** | Minor feature broken, small % of users impacted, workaround available | < 1 hour |
| **SEV-4 (Low)** | Cosmetic issue, logging/monitoring problem, no user impact | Next business day |

**Assign severity based on the description. State your reasoning.**

### Impact Assessment
Answer immediately:
- **Who is affected?** (all users / subset / internal only)
- **What is broken?** (specific feature, API endpoint, entire service)
- **Since when?** (exact time if known, or "unknown — investigating")
- **What is the blast radius?** (could this spread or get worse?)

---

## Phase 2: Contain (first 15 minutes)

Identify the fastest way to reduce impact, even if it doesn't fix the root cause:

- Can the feature be disabled via feature flag?
- Can traffic be rerouted to a backup or previous version?
- Can affected users be notified with a status page update?
- Is there an immediate rollback available?

**Recommend the fastest containment action. Do not wait for root cause to act.**

---

## Phase 3: Investigate

### Timeline
Build a chronological timeline of events:

```
[TIME] — [Event: what happened, what changed, what was deployed]
[TIME] — [First symptom observed]
[TIME] — [Alert fired / incident declared]
[TIME] — [Investigation started]
[TIME] — [Containment action taken]
[TIME] — [Root cause identified]
[TIME] — [Fix deployed]
[TIME] — [Service restored]
```

### Root Cause Analysis

Use the 5 Whys method:

**Why did X happen?**
→ Because Y

**Why did Y happen?**
→ Because Z

**Why did Z happen?**
→ ...

Continue until you reach a systemic or root cause — not just the proximate trigger.

**Root cause categories:**
- Code bug (logic error, edge case, regression)
- Configuration error (wrong env var, infrastructure misconfiguration)
- Dependency failure (third-party service, database, external API)
- Capacity issue (traffic spike, memory/disk exhaustion)
- Human error (manual operation, wrong command)
- Missing observability (failed silently — no alert fired)

---

## Phase 4: Fix and Verify

- What is the fix?
- How was it tested before deploying to production?
- How was service restoration confirmed? (specific metric, smoke test, user confirmation)
- Is the fix permanent or a temporary workaround?

---

## Phase 5: Postmortem Template

```markdown
# Postmortem: [Incident Title]

**Date**: [YYYY-MM-DD]
**Duration**: [X hours Y minutes]
**Severity**: SEV-[1/2/3/4]
**Author**: [Name]
**Status**: Draft / In Review / Final

## Summary
2-3 sentences: what happened, how long, what was the impact.

## Impact
- Users affected: [number or percentage]
- Features affected: [list]
- Revenue impact: [$X or "unknown"]
- Data loss: Yes / No — [details if yes]

## Timeline
[paste from Phase 3]

## Root Cause
[paste from Phase 3 — include the 5 Whys chain]

## Contributing Factors
What made this worse or harder to detect?
- Missing alert for X
- No feature flag to disable Y
- Documentation for Z was outdated

## What Went Well
Honest assessment — what worked during the response?

## Action Items
| Action | Owner | Priority | Due Date |
|---|---|---|---|
| Add alert for [metric] | | P1 | |
| Add feature flag for [component] | | P2 | |
| Write runbook for [scenario] | | P2 | |
| Fix the underlying bug in [location] | | P1 | |

## Lessons Learned
What should the team know after this incident?

---
*This postmortem is blameless. The goal is systemic improvement, not individual accountability.*
```
