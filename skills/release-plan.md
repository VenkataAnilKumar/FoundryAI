---
description: Plan a release rollout — phased deployment, feature flags, canary, rollback strategy, launch coordination
argument-hint: Describe what you're releasing — feature, service, infrastructure change, or breaking API change
---

You are a release manager. A release plan is not release notes (use /release for that). This is the operational plan for how a change gets from staging to 100% of production safely.

## What You're Releasing
$ARGUMENTS

---

## Step 1: Release Classification

| Class | Definition | Approval required | Rollback time |
|---|---|---|---|
| **Patch** | Bug fix, no behavior change, no schema change | Engineer + tech lead | < 5 minutes |
| **Minor** | New feature, backward-compatible, no infra change | Tech lead | < 15 minutes |
| **Major** | Breaking change, schema migration, new infra, external-facing API change | Team + stakeholders | 30+ minutes (may need migration) |
| **Emergency** | Hotfix for production incident | On-call lead + one approver | < 5 minutes (patch only) |

**This release is:** [Patch / Minor / Major / Emergency]

---

## 2. Pre-Release Checklist

### Code & Testing
- [ ] All tests pass in CI (unit, integration, E2E)
- [ ] Security scan clean (no new critical/high vulnerabilities)
- [ ] Performance benchmarks show no regression (run load test if applicable)
- [ ] Code reviewed and approved by required reviewers
- [ ] Feature branch is up-to-date with main (no merge conflicts)

### Database / Schema Changes
- [ ] Migration is backward-compatible (old code can run against new schema)
- [ ] Migration has been tested on a production-size data snapshot
- [ ] Down migration exists and has been tested
- [ ] Migration runtime estimated (> 1 minute → requires downtime window or online migration)
- [ ] Indexes added online (not blocking), not during peak traffic

### Infrastructure
- [ ] New infrastructure provisioned and tested in staging
- [ ] Environment variables / secrets added to production secret manager
- [ ] DNS changes pre-staged (TTL lowered 24–48h before release if needed)
- [ ] Load balancer / routing configuration tested

### Feature Flags
- [ ] Feature is behind a flag if it's a significant user-facing change
- [ ] Flag is in the "off" state in production before deployment
- [ ] Flag removal date is scheduled (don't let flags accumulate permanently)

### Monitoring
- [ ] Dashboard created or updated for this feature
- [ ] Alerts configured (error rate, latency, business metric anomalies)
- [ ] Runbook written for the 3 most likely failure scenarios

---

## 3. Deployment Strategy

Choose the rollout pattern:

### Canary Deployment (recommended default)
```
Deploy to 1% of traffic → monitor 30 minutes
    ↓
Promote to 5% → monitor 1 hour
    ↓
Promote to 25% → monitor 2 hours
    ↓
Promote to 100%

Go/No-Go criteria at each stage:
- Error rate ≤ baseline + 0.1%
- P99 latency ≤ baseline × 110%
- Primary business metric not degrading
```

### Blue/Green Deployment (for major changes)
```
Blue (current production): 100% traffic
Green (new version): deployed but 0% traffic
    ↓
Test green thoroughly (smoke tests, internal traffic)
    ↓
Switch load balancer: green = 100% traffic
Blue stays warm for instant rollback
    ↓
Decommission blue after 24h monitoring window
```

### Feature Flag Rollout (for user-facing features)
```
Internal users only → 1% of users → 10% → 50% → 100%
Roll out by: user_id hash (consistent experience per user)
Never by: session (same user gets inconsistent experience)
```

### Dark Launch (for backend changes)
```
New code runs in parallel, results discarded (or logged for comparison)
No user impact
Compare outputs of old vs new code in logs
Ship when outputs match on representative traffic sample
```

---

## 4. Rollback Plan

Define the exact rollback procedure **before** deploying:

**Rollback trigger conditions** (automatic or manual decision):
| Metric | Threshold | Action |
|---|---|---|
| Error rate | > [X]% | Immediate rollback |
| P99 latency | > [Y] ms | Immediate rollback |
| [Business metric] | Drops > [Z]% | Human decision within 15 min |

**Rollback procedure:**

For canary:
```
1. Route 100% traffic back to previous version (< 2 minutes)
2. Verify error rate returns to baseline (< 5 minutes)
3. Investigate root cause before re-attempting
```

For blue/green:
```
1. Repoint load balancer to blue (< 1 minute)
2. Verify traffic flowing to blue
3. Blue remains as-is until investigation complete
```

For schema migrations (the hard one):
```
Pre-migration (required): All new code must tolerate both old and new schema
During migration: Migration runs online, backward-compatible
Post-migration rollback: Requires reverting code before reverting schema
Never: Apply a schema change that old code can't handle
```

**Rollback communication:**
- Who to notify immediately: [on-call lead, PM, CTO if major]
- Internal status update within 15 minutes of rollback decision
- External status page update if customer-visible impact

---

## 5. Launch Coordination

### Communication Plan

| Audience | Message | Channel | When |
|---|---|---|---|
| Engineering team | Technical details, monitoring links | Slack #eng | -1 day |
| Support team | What's changing, how to handle user questions | Slack #support | -1 day |
| Stakeholders | What's shipping, expected impact | Email / Slack | -1 day |
| Users (if applicable) | What's new and any action required | In-app / email | Day of |

### Day-of Release Checklist

**T-2h:** Final staging smoke test, team standup to align on schedule
**T-1h:** Confirm monitoring dashboard is up, on-call is aware
**T-0:** Begin deployment per rollout plan
**T+30min:** First checkpoint — check metrics against go/no-go criteria
**T+1h:** Second checkpoint for canary promotion decision
**T+4h:** Final check before end of day
**T+24h:** Post-release review

### Launch Day Communication Template
```
[Pre-launch] Deploying [feature/change] to production.
Rollout plan: [canary/blue-green/flag].
Dashboard: [link].
On-call: [name].
Rollback: [who and how].

[During] Now at X% traffic. Error rate: X%. P99: Xms. Proceeding/Pausing.

[Post-launch] [Feature] fully deployed.
Final metrics: error rate X% (baseline: Y%), P99 Xms (baseline: Yms).
All systems nominal / [Issues noted].
```

---

## 6. Post-Release

**24-hour review:**
- [ ] All metrics stable and within target
- [ ] Support ticket volume not elevated
- [ ] Any unexpected behaviors documented
- [ ] Feature flag cleanup scheduled
- [ ] Rollback artifacts (blue instance, old image) can be decommissioned

**Incident retrospective** (if anything went wrong):
- What happened (timeline)
- What we did
- Why it happened (root cause, not blame)
- What we're doing to prevent recurrence
- Document in runbook for next time
