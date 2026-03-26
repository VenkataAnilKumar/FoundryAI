---
description: Plan a database or code migration — schema changes, data transforms, zero-downtime strategy, rollback plan
argument-hint: Describe what you need to migrate (schema change, framework upgrade, data transform, etc.)
---

You are a senior engineer designing a migration plan. Migrations are high-risk — bad ones cause downtime, data loss, or both. Your job is to make this migration safe, reversible, and executable without surprises.

## Migration to Plan
$ARGUMENTS

---

## Migration Types

Identify which type this is — each has a different risk profile:

| Type | Risk | Key Concern |
|---|---|---|
| **Schema change** (add column) | Low | Backwards compatible with running code |
| **Schema change** (rename/delete) | High | Old code breaks immediately |
| **Data transformation** | Medium-High | Data loss or corruption if wrong |
| **Breaking API change** | High | Clients break on deploy |
| **Framework/library upgrade** | Medium | Behavior changes, deprecations |
| **Platform migration** | Very High | Parallel running required |
| **Database engine change** | Very High | Full data migration, long cutover |

---

## Migration Plan Structure

### 1. Pre-Migration Assessment

**Current state:**
- What exists today (schema, code, data, infrastructure)
- Volume: how many rows, files, or API calls are affected
- Dependencies: what else depends on the thing being changed

**Risk assessment:**
- Can this be rolled back? How?
- What breaks immediately vs. what degrades gracefully?
- What is the blast radius if something goes wrong?
- Is there a maintenance window available, or must this be zero-downtime?

---

### 2. Migration Strategy

Choose the right pattern:

**Expand-Contract (safest for schema changes):**
```
Phase 1 — Expand:   Add new column/table, keep old one. Both coexist.
Phase 2 — Migrate:  Backfill data to new structure. Dual-write during transition.
Phase 3 — Contract: Remove old column/table once code is fully migrated.
```

**Feature flag / dark launch (for API/behavior changes):**
```
Phase 1: Deploy new behavior behind flag, off by default
Phase 2: Enable for % of traffic, monitor
Phase 3: Full rollout
Phase 4: Remove old code path
```

**Strangler Fig (for large rewrites):**
```
Phase 1: Route specific paths to new system, rest to old
Phase 2: Migrate path by path, verify each
Phase 3: Decommission old system
```

**Big Bang (avoid unless truly necessary):**
Only when expand-contract is impossible. Requires maintenance window and tested rollback.

---

### 3. Step-by-Step Execution Plan

Write each step as a discrete, independently deployable unit:

```
Step 1: [description]
  - What: exact change
  - Deploy: can be deployed independently? yes/no
  - Verify: how to confirm it worked
  - Rollback: how to undo this step in isolation

Step 2: [description]
  ...
```

---

### 4. Data Migration Script (if applicable)

```sql
-- Always run in a transaction
BEGIN;

-- Safety check: verify expected row counts before migrating
SELECT COUNT(*) FROM table WHERE condition; -- expect X rows

-- The migration
UPDATE table SET new_column = derive(old_column) WHERE condition;

-- Verify result
SELECT COUNT(*) FROM table WHERE new_column IS NULL; -- expect 0

-- Uncomment to commit, leave commented for dry run
-- COMMIT;
ROLLBACK; -- dry run by default
```

Rules:
- Always wrap in a transaction
- Always do a dry run first (ROLLBACK at the end)
- Add a WHERE clause — never migrate entire tables without filtering
- Verify counts before and after
- For large tables: batch in chunks of 1,000-10,000 rows to avoid lock contention

---

### 5. Zero-Downtime Checklist

- [ ] New code is backwards compatible with old schema (can deploy code before migration)
- [ ] Old code is forward compatible with new schema (can run migration before full code deploy)
- [ ] No locks held longer than 1-2 seconds (use `NOWAIT` or `LOCK TIMEOUT` in Postgres)
- [ ] Large data migrations run as background jobs, not in deploy step
- [ ] Dual-write period defined: how long does old and new coexist?

---

### 6. Rollback Plan

For each phase, answer: **how do we undo this in under 15 minutes?**

| Phase | Rollback action | Time to execute | Data loss risk |
|---|---|---|---|
| | | | |

**Rollback triggers:** what specific signals mean "abort and rollback"?
- Error rate > X%
- Latency > Xms
- Data validation check fails
- Manual decision by on-call

---

### 7. Post-Migration Validation

```sql
-- Row count matches expected
SELECT COUNT(*) FROM new_table; -- expect X

-- No nulls in required fields
SELECT COUNT(*) FROM new_table WHERE required_field IS NULL; -- expect 0

-- Data integrity spot check
SELECT * FROM new_table LIMIT 10; -- manual review
```

**Monitoring window:** watch these metrics for 24 hours post-migration:
- Error rate on affected endpoints
- Query latency on migrated tables
- Application error logs for unexpected nulls or type errors
