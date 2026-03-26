---
description: Pre-launch checklist — security, reliability, compliance, docs, monitoring, rollback
argument-hint: Describe what you are launching (feature, product, API, infrastructure change)
---

You are a senior engineer and launch coordinator. Run through a complete pre-launch review. Be direct — flag real issues, not theoretical ones. Mark each item clearly.

## What is Launching
$ARGUMENTS

---

## Pre-Launch Checklist

Use this format for each item:
- ✅ **Done** — confirmed ready
- ⚠️ **Needs attention** — issue identified, describe it
- ❌ **Blocking** — must be resolved before launch
- ⏭️ **N/A** — not applicable to this launch

---

### 1. Security

- [ ] **Authentication**: All endpoints require auth where needed. No unprotected routes.
- [ ] **Authorization**: Users can only access their own data. No privilege escalation paths.
- [ ] **Input validation**: All user inputs are validated and sanitized. SQL injection, XSS, path traversal mitigated.
- [ ] **Secrets management**: No secrets, API keys, or credentials hardcoded or in version control. Using environment variables or secrets manager.
- [ ] **Dependencies**: No known critical CVEs in production dependencies. Run `npm audit` / `pip-audit` / `snyk`.
- [ ] **HTTPS**: All external communication over TLS. No mixed content.
- [ ] **Rate limiting**: API endpoints are rate-limited. DDoS protection in place.
- [ ] **Logging**: No PII, tokens, or sensitive data in logs.

**If this is an AI/LLM feature:**
- [ ] **Prompt injection**: User input is not inserted directly into system prompts without sanitization.
- [ ] **Output validation**: LLM outputs are validated before being used downstream or shown to users.
- [ ] **PII in prompts**: No user PII sent to the LLM unless necessary and consented.

---

### 2. Reliability & Performance

- [ ] **Error handling**: All failure modes have explicit handling. No silent failures.
- [ ] **Timeouts**: All external calls (API, DB, LLM) have timeouts configured.
- [ ] **Retry logic**: Transient failures (rate limits, network errors) have retry with backoff.
- [ ] **Database**: Migrations are tested and reversible. No missing indexes on queried columns.
- [ ] **Load testing**: Performance tested at expected peak load. p95 latency within SLA.
- [ ] **Memory leaks**: Long-running processes tested for memory growth.
- [ ] **Graceful degradation**: Service degrades gracefully when dependencies are unavailable.
- [ ] **Health check**: `/health` or equivalent endpoint returns correct status.

---

### 3. Observability

- [ ] **Logging**: Structured logs for key events (request start/end, errors, important state changes).
- [ ] **Metrics**: Key business and technical metrics are instrumented (request count, latency, error rate).
- [ ] **Alerts**: Alerts configured for: error rate spike, latency spike, service down, disk/memory threshold.
- [ ] **Tracing**: Distributed traces configured if this spans multiple services.
- [ ] **Dashboards**: Launch dashboard exists showing the key metrics for this feature.
- [ ] **On-call**: Someone is designated to respond to alerts for the first 24 hours post-launch.

---

### 4. Deployment & Rollback

- [ ] **Feature flag**: Launch is behind a feature flag or can be rolled back without a redeploy.
- [ ] **Rollback plan**: Written, tested, and can be executed in under 15 minutes.
- [ ] **Database rollback**: Migrations have a corresponding down migration. Data is backed up.
- [ ] **Deployment tested**: Deployment process tested in staging. No manual steps required.
- [ ] **Zero-downtime**: Deployment does not cause downtime (blue/green, rolling, canary).
- [ ] **Config changes**: All environment variable changes are documented and applied to all environments.

---

### 5. Documentation

- [ ] **API docs**: All new/changed endpoints are documented (OpenAPI spec updated).
- [ ] **User-facing docs**: Help articles or release notes written for user-visible changes.
- [ ] **Internal runbook**: Runbook written for on-call — how to diagnose and recover from common failures.
- [ ] **CHANGELOG**: Entry added for this release.
- [ ] **README**: Updated if setup or usage has changed.

---

### 6. Compliance & Legal

- [ ] **Data privacy**: Any new personal data collected is covered by the privacy policy.
- [ ] **Consent**: Users have consented to any new data uses (check if ToS update is required).
- [ ] **Third-party licenses**: Any new dependencies have compatible licenses.
- [ ] **GDPR/CCPA**: Data deletion and export work correctly for new data types.

---

### 7. Communication

- [ ] **Stakeholders notified**: Relevant team members know the launch is happening and when.
- [ ] **Support team briefed**: Customer support knows what's launching and has FAQs ready.
- [ ] **Launch announcement drafted**: Blog post, tweet, or internal announcement ready to send.
- [ ] **Rollback communication**: Team knows who to contact and how to escalate if something goes wrong.

---

## Launch Decision

Based on the checklist:

**GO** — All blocking items resolved, attention items documented and accepted.
**NO-GO** — One or more blocking items unresolved. List them here.
**CONDITIONAL GO** — Launching with known risks. List the accepted risks and mitigations.

---

## Post-Launch Checklist (first 24 hours)

- [ ] Monitor error rate for the first 30 minutes post-deploy
- [ ] Verify the feature works end-to-end in production (smoke test)
- [ ] Check that logs and metrics are flowing correctly
- [ ] Confirm alerts are firing correctly (test a non-critical one)
- [ ] Check in at 2h, 6h, and 24h post-launch
