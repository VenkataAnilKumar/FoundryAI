---
description: Write a lean PRD — user stories, acceptance criteria, scope boundaries, success metrics
argument-hint: Describe the feature or product idea
---

You are a product manager writing a lean PRD. Be specific and opinionated. No fluff — every line should inform an engineering decision.

## Feature / Product Idea
$ARGUMENTS

---

## PRD Structure

### 1. One-Line Summary
A single sentence: what this is, for whom, and the primary benefit.

### 2. Problem Statement
- What problem does this solve?
- Who experiences this problem? (be specific — not "users", but "solo founders who need X")
- How are they solving it today, and why is that insufficient?
- What is the cost of NOT solving this? (time, money, churn, missed revenue)

### 3. Goals
What does success look like in 30/60/90 days?
- List 2-3 measurable outcomes (not activities)
- Example: "70% of users complete onboarding without support" — not "improve onboarding"

### 4. Non-Goals (Out of Scope)
Explicitly list what this does NOT include. This prevents scope creep and sets expectations.
- At least 3 explicit non-goals
- If a stakeholder will ask "why isn't X included?" — answer it here

### 5. User Stories
Format: **As a [specific user type], I want to [action] so that [outcome].**

Write the 3-5 most critical stories. Include:
- **Happy path** — the primary use case that must work perfectly
- **Error case** — what happens when something goes wrong
- **Edge case** — an unusual but valid scenario

For each story, add **Acceptance Criteria** (testable, specific, not subjective):
```
Given [precondition]
When [action]
Then [expected result]
```

### 6. Functional Requirements
Numbered list of what the system must do. Use "must" for required, "should" for preferred, "may" for optional.

Keep each requirement to one sentence. If a requirement needs a paragraph, it's two requirements.

### 7. Non-Functional Requirements
- **Performance**: e.g., "API must respond in <200ms at p95"
- **Security**: e.g., "All user data must be encrypted at rest"
- **Reliability**: e.g., "Feature must work offline / degrade gracefully"
- **Scale**: e.g., "Must support 10,000 concurrent users at launch"

Only include constraints that will actually affect engineering decisions.

### 8. Success Metrics
How will we know this feature is working?
- Primary metric (the one number that matters most)
- 2-3 secondary metrics
- Guard metrics (metrics that must NOT degrade as a result of this feature)

### 9. Open Questions
List unresolved questions that need an answer before or during implementation. Assign an owner to each.

| Question | Owner | Due |
|---|---|---|
| | | |

### 10. Dependencies and Risks
- What must be built or decided first?
- What could block or delay this?
- What technical bets is this making that could be wrong?

---

**Complexity Estimate**: S / M / L / XL
**Suggested team**: [list agents or roles needed]
**Suggested first sprint scope**: [the absolute minimum that proves the core hypothesis]
