---
description: Quick security scan of the current file or code — OWASP top 10, common vulnerabilities, fast triage
argument-hint: Paste code to scan or leave blank for current file
---

You are a security engineer doing a fast triage scan. Flag real vulnerabilities with specific line references and fixes. Skip theoretical risks — focus on exploitable issues.

## Code to Scan
$ARGUMENTS

If nothing provided, scan the most recently discussed code in this session.

---

## OWASP Top 10 Quick Scan

Check each category. Only flag if a real issue exists — do not pad the report.

### A01 — Broken Access Control
- [ ] Authorization checked on every endpoint that needs it?
- [ ] Can a user access another user's data by changing an ID in the request?
- [ ] Are admin-only routes protected beyond just hiding the UI?
- [ ] IDOR (Insecure Direct Object Reference): `GET /users/{id}` — is `id` validated against the authenticated user?

### A02 — Cryptographic Failures
- [ ] Passwords hashed with bcrypt/argon2/scrypt? (not MD5, SHA1, or plain SHA256)
- [ ] Sensitive data (PII, tokens, keys) encrypted at rest?
- [ ] TLS enforced? No HTTP fallback for sensitive operations?
- [ ] JWT secrets: strong, rotated, not hardcoded?

### A03 — Injection
- [ ] SQL: parameterized queries used? No string interpolation into queries?
- [ ] NoSQL: input validated before use in queries?
- [ ] Command injection: `exec`, `shell`, `subprocess` — is user input ever passed in?
- [ ] LDAP, XPath, expression injection if applicable?

### A04 — Insecure Design
- [ ] Rate limiting on auth endpoints (login, password reset, OTP)?
- [ ] Account enumeration possible via error message differences?
- [ ] Sensitive operations require re-authentication?

### A05 — Security Misconfiguration
- [ ] Debug mode / verbose errors in production?
- [ ] Default credentials or example configs?
- [ ] CORS: wildcard `*` on sensitive endpoints?
- [ ] Security headers: CSP, X-Frame-Options, HSTS, X-Content-Type-Options?

### A06 — Vulnerable Components
- [ ] Any dependencies with known CVEs? (flag if you can identify versions)
- [ ] Outdated runtime versions?

### A07 — Auth Failures
- [ ] Brute force protection on login?
- [ ] Session tokens: sufficient entropy, HttpOnly, Secure, SameSite flags?
- [ ] Password reset tokens: single use, expiring, not predictable?
- [ ] JWT: signature verified? Algorithm pinned (not `alg: none` exploitable)?

### A08 — Integrity Failures
- [ ] Deserialization of untrusted data?
- [ ] Auto-update mechanisms without integrity checks?

### A09 — Logging Failures
- [ ] Auth events logged (success and failure)?
- [ ] Sensitive data (passwords, tokens, PII) NOT logged?
- [ ] Logs tamper-evident?

### A10 — SSRF
- [ ] User-controlled URLs fetched by the server?
- [ ] Internal metadata endpoints accessible (169.254.169.254)?
- [ ] URL allowlist in place for outbound requests?

---

## AI/LLM Specific (if applicable)
- [ ] Prompt injection: user input inserted into prompts unsanitized?
- [ ] Tool outputs trusted as safe input back to the model?
- [ ] Sensitive data or secrets accessible to the LLM?

---

## Output Format

### Vulnerabilities Found
```
[CRITICAL/HIGH/MEDIUM/LOW] Vulnerability type
Location: file:line or function name
Issue: what is exploitable and how
Fix: exact code change to resolve
```

### Clean
Brief note on security practices that are done correctly (1-3 items max).

### Not Checked
List anything that requires dynamic analysis or external context to verify.

---

**Speed target:** This is a triage scan, not a full pentest. Flag the real issues fast. For a comprehensive review, use `/review-ai` or invoke the `ai-security-engineer` agent.
