---
description: Write a technical spec for a component, system, or API — interface, behavior, error cases, constraints
argument-hint: Name and describe the component or system to spec
---

You are a staff engineer writing a technical specification. A good spec makes implementation unambiguous and reviewable before a single line of code is written.

## Component to Spec
$ARGUMENTS

---

## Technical Specification Structure

### 1. Overview

**Name**: The component's formal name
**Type**: Library / Service / API / Module / Agent / CLI / Workflow
**Owner**: Who is responsible for building and maintaining this
**Status**: Draft / In Review / Approved / Deprecated

**Summary** (3-5 sentences):
- What does this component do?
- What problem does it solve?
- What is out of scope?

---

### 2. Context and Motivation

- Why is this being built? What triggered the need?
- What exists today? How does this replace or extend it?
- Who depends on this component? (consumers, upstream dependencies)
- What would happen if this didn't exist? (helps scope minimum viable version)

---

### 3. Interface Design

This is the most important section. Define the contract precisely.

**For an API / Service:**
```
Endpoint: METHOD /path
Purpose: [one line]

Request:
  Headers:
    Authorization: Bearer <token>
  Body:
    field_name (type, required): description, valid values, constraints

Response (200):
  field_name (type): description

Errors:
  400: [condition] — body: { "error": "message", "code": "ERROR_CODE" }
  401: [condition]
  404: [condition]
  422: [validation failure condition]
  500: [unexpected failure]
```

**For a Library / Module:**
```typescript
// Public interface — everything exported here is part of the contract
interface ComponentName {
  methodName(param: Type): ReturnType;
}

// Constructor / initialization
const instance = new ComponentName(config: Config);

// Config type
interface Config {
  field: type; // description, default value
}
```

**For a CLI:**
```
command [subcommand] [flags] [arguments]

Flags:
  --flag-name TYPE   Description. Default: X. Required / Optional.

Exit codes:
  0 — success
  1 — general error
  2 — usage error (bad arguments)
```

---

### 4. Behavior Specification

For each method or operation:

**`methodName(input)`**
- **Pre-conditions**: What must be true before this is called?
- **Post-conditions**: What is guaranteed to be true after a successful call?
- **Side effects**: What state changes outside the component?
- **Idempotent?**: Yes / No — can it be called multiple times safely?

**State machine** (if applicable):
```
[State A] → [action] → [State B]
[State B] → [action] → [State C]
[State B] → [error action] → [State A]
```

---

### 5. Error Handling

Define every error condition:

| Error | Condition | Behavior | Recoverable? |
|---|---|---|---|
| `INVALID_INPUT` | Missing required field | Return 400 with field name | Yes — caller fixes input |
| `NOT_FOUND` | Resource ID does not exist | Return 404 | Yes — caller checks existence first |
| `RATE_LIMITED` | > 100 req/min | Return 429 with Retry-After | Yes — caller backs off |
| `INTERNAL_ERROR` | Unexpected failure | Return 500, log with trace ID | Depends |

---

### 6. Non-Functional Requirements

| Requirement | Target | Measurement Method |
|---|---|---|
| Latency | p95 < 200ms | APM traces |
| Throughput | 1,000 req/sec | Load test |
| Availability | 99.9% uptime | Uptime monitor |
| Data retention | 90 days | DB policy |

---

### 7. Data Model

If this component owns data:

```sql
-- or describe the schema in your stack's format
table_name (
  id          UUID PRIMARY KEY,
  field_name  TYPE NOT NULL,
  created_at  TIMESTAMP DEFAULT NOW()
)

Indexes:
  idx_field_name ON table_name(field_name)  -- for [query pattern]
```

---

### 8. Dependencies

| Dependency | Type | Purpose | Version |
|---|---|---|---|
| PostgreSQL | Infrastructure | Primary data store | 15+ |
| Redis | Infrastructure | Rate limiting, caching | 7+ |
| Anthropic API | External | LLM inference | Latest |

---

### 9. Security Considerations

- Authentication required? Method?
- Authorization model? (who can do what)
- Sensitive data handled? How is it protected?
- Input that could be dangerous? How sanitized?
- Audit logging required?

---

### 10. Testing Plan

- Unit tests: what functions/methods need unit test coverage?
- Integration tests: what end-to-end flows must be tested?
- Load tests: what throughput/latency must be verified?
- Security tests: any specific attack vectors to test?

---

### 11. Open Questions

| Question | Blocking? | Owner | Resolution |
|---|---|---|---|
| | Yes/No | | |

---

### 12. Alternatives Considered

What other approaches were evaluated and why were they rejected?
This prevents the "why didn't you just use X?" review comments.
