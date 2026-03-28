---
description: Route any design, UX, or product experience task to the right specialist — research, UX, visual design, or content
argument-hint: Describe the design challenge or experience you want to create
---

You are routing a design or user experience task to the right specialist.

## Design Challenge
$ARGUMENTS

---

## Step 1: Identify What Kind of Design Work This Is

| Type | Signals |
|---|---|
| **Discovery / research** | "We don't know what users want", "validate the concept", "understand the problem" |
| **UX / interaction design** | User flows, wireframes, navigation, AI interaction patterns, onboarding |
| **Visual / product design** | Hi-fi mockups, design system, brand, Figma files, production-ready specs |
| **Content / UX writing** | Microcopy, empty states, error messages, onboarding copy, product messaging |
| **Metrics / analytics** | "How do we know if the design is working?", A/B test, funnel analysis |
| **Developer product DX** | API/SDK experience, developer portal, technical documentation UX |
| **Full design process** | Greenfield feature — needs research → UX → visual → content end-to-end |

---

## Step 2: Route to the Right Specialist

| Need | Agent | What They Deliver |
|---|---|---|
| User research, discovery | `ux-researcher` | Interview guide, usability test plan, synthesis report, persona, JTBD framework, journey map |
| UX flows, wireframes, AI UX | `ai-ux-designer` | User flows, wireframes, interaction patterns, onboarding design, AI UX best practices |
| Hi-fi design, design system | `product-designer` | Production-ready mockups, design system components, tokens, Figma specs, dev handoff |
| Microcopy, UX writing | `content-designer` | Copy for UI elements, empty states, error messages, tooltips, onboarding sequences |
| Metrics, A/B testing | `product-analyst` | Success metrics, funnel definition, A/B test design, measurement plan |
| Developer portal / API DX | `technical-product-manager` | Developer experience audit, DX metrics, API portal structure, SDK documentation strategy |
| Accessibility review | `ai-accessibility-engineer` | WCAG 2.2 audit, screen reader testing, keyboard nav, ARIA patterns, remediation plan |

---

## Step 3: Standard Design Workflow (for new features)

When designing a feature end-to-end, run in this sequence:

```
1. ux-researcher     → Discovery: understand the user problem and validate assumptions
        ↓
2. ai-ux-designer    → UX: flows, wireframes, interaction model
        ↓
3. product-designer  → Visual: hi-fi mockups, design system integration
        ↓
4. content-designer  → Copy: all text in the UI (labels, errors, empty states, CTAs)
        ↓
5. product-analyst   → Metrics: define how success will be measured
        ↓
6. ai-accessibility-engineer → Audit: ensure WCAG 2.2 compliance before engineering
```

For smaller changes, skip steps that aren't needed — but never skip step 6 for user-facing UI.

---

## Step 4: Frame the Task for the Design Agent

When spawning a design agent, give them:
1. **The user problem** — who is struggling with what, and why it matters
2. **Constraints** — existing design system, brand guidelines, platform (web/mobile), tech stack
3. **What already exists** — existing screens, flows, or research to build on
4. **Deliverable format** — wireframe, mockup, copy doc, research report, design spec

---

## Step 5: Connecting Design to Engineering

After design is complete:
- `ai-frontend-engineer` implements the UI
- `ai-accessibility-engineer` reviews the implementation (not just the design)
- `product-analyst` sets up the measurement instrumentation

Always share design artifacts directly with the implementing engineer — don't summarize, hand off the actual spec.
