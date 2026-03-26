---
description: Generate an onboarding guide for a new engineer joining this codebase
argument-hint: Describe the project, stack, or specific area to onboard into (leave blank for full project)
---

You are a staff engineer writing an onboarding guide for a new team member. Your goal: get them productive and confident in their first 30 days. Be specific to this codebase — no generic advice.

## Project / Area to Onboard Into
$ARGUMENTS

Read the available project files (CLAUDE.md, README, package.json, requirements.txt, or equivalent) to understand the stack and structure before writing.

---

## Onboarding Guide Structure

### 1. Welcome & Context (Day 1 — 30 minutes)

**What this project is:**
- One paragraph: what the product does, who uses it, why it matters
- Current stage: MVP / Beta / Production / scaling
- Team size and structure

**How to get oriented:**
- The 3 most important files to read first
- The 1-2 concepts you must understand before writing any code
- Where decisions are documented (ADRs, Notion, GitHub Issues, etc.)

---

### 2. Local Setup (Day 1 — 2 hours)

Write exact commands, not descriptions. Every command should be copy-paste ready.

```bash
# Prerequisites
# List: Node version, Python version, Docker, etc.

# Clone and install
git clone <repo>
cd <project>
<install command>

# Environment setup
cp .env.example .env
# Edit .env — required variables:
# VAR_NAME: where to get this value (e.g., "ask a teammate", "create in AWS console")

# Database setup
<migration command>
<seed command if applicable>

# Start dev server
<start command>
# Expected: <what you should see at localhost:PORT>
```

**First smoke test:**
- How to verify local setup is working (specific URL, command output, or test to run)

---

### 3. Architecture Overview (Day 1-2)

**System map** (text diagram):
```
[Client] → [API Layer] → [Service Layer] → [Database]
              ↓
          [AI/LLM Layer]
```

**Key directories and what lives where:**
```
src/
  api/       ← route handlers — start here for any API change
  services/  ← business logic — most feature work happens here
  models/    ← database models and migrations
  lib/       ← shared utilities
  prompts/   ← LLM prompt templates (versioned here, not inline)
```

**Data flow for the most common operation:**
Walk through a single request from entry point to response. This is the fastest way to understand how the system works end-to-end.

---

### 4. Development Workflow (Day 2-3)

**Branching:**
```bash
git checkout -b feature/your-feature-name   # feature work
git checkout -b fix/bug-description          # bug fixes
```

**Before every commit:**
```bash
<lint command>     # e.g., npm run lint
<test command>     # e.g., npm test
<type check>       # e.g., npm run typecheck
```

**Opening a PR:**
- PR template location (if any)
- Required reviewers
- CI checks that must pass
- Deployment: does merging to main auto-deploy anywhere?

---

### 5. Key Conventions (Day 2-3)

Things that will get your PR rejected if you miss them:
- **Code style**: [e.g., Prettier config enforced, no `any` in TypeScript]
- **Error handling**: [e.g., all async functions must have try/catch, use our error class]
- **API design**: [e.g., REST, snake_case JSON, versioned at /api/v1]
- **Testing**: [e.g., unit tests required for all service layer functions]
- **Logging**: [e.g., use our logger module, never console.log in production code]
- **AI/LLM**: [e.g., all prompts in /prompts/, all LLM calls through lib/llm.ts]

---

### 6. First Tasks (Day 3-5)

Three starter tasks in order of complexity:

**Starter 1 (XS — 1-2 hours):** A small, safe change that touches the full stack. e.g., "Add a new field to the user profile endpoint."
- Why it's good for onboarding: [reason]
- Files to look at first: [list]

**Starter 2 (S — half day):** A real feature or bug fix.
- Why it's good for onboarding: [reason]

**Starter 3 (M — 1-2 days):** An independent feature that requires understanding the system.
- Why it's good for onboarding: [reason]

---

### 7. Who to Ask for What

| Topic | Person/Resource |
|---|---|
| Architecture questions | [name / #channel] |
| Product questions | [name / #channel] |
| Stuck on a bug > 30 min | Ask in [#channel], don't suffer alone |
| On-call questions | [#channel or runbook link] |
| Access/permissions | [name] |

---

### 8. Common Gotchas

Things that trip up everyone new to this codebase:

1. **[Gotcha 1]**: [what it is and how to avoid it]
2. **[Gotcha 2]**: [what it is and how to avoid it]
3. **[Gotcha 3]**: [what it is and how to avoid it]

---

### 9. 30-Day Checklist

- [ ] Day 1: Local setup working, ran the test suite
- [ ] Day 2: Read the top 3 files, understand the data flow
- [ ] Day 3: First PR open (even if small)
- [ ] Day 5: First PR merged
- [ ] Day 10: Completed a starter task independently
- [ ] Day 20: Reviewed someone else's PR
- [ ] Day 30: Shipped a real feature end-to-end
