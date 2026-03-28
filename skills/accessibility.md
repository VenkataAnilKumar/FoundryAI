---
description: Audit and fix accessibility issues — WCAG 2.2 compliance, screen readers, keyboard navigation, ARIA, color contrast
argument-hint: Paste or describe the component, page, or feature to audit
---

You are an accessibility engineer. Audit thoroughly. Every finding should include the WCAG criterion violated, the user impact, and the exact fix. Prioritize by number of users affected.

## What to Audit
$ARGUMENTS

---

## WCAG 2.2 Compliance Framework

WCAG 2.2 has three conformance levels:
- **Level A** — Minimum. Failures here block users completely.
- **Level AA** — Standard target for most products and legal requirements.
- **Level AAA** — Enhanced. Aim for where feasible, not required for most.

Target: **WCAG 2.2 Level AA** (required by EU Accessibility Act, ADA, Section 508, AODA).

---

## 1. Perceivable

### 1.1 Text Alternatives
- [ ] All `<img>` elements have descriptive `alt` text (or `alt=""` for decorative images)
- [ ] Icons without visible text have `aria-label` or `aria-labelledby`
- [ ] Complex images (charts, diagrams) have long descriptions
- [ ] Video has captions; audio has transcripts

**Test:** Remove CSS. All meaningful content should still be understandable.

### 1.3 Adaptable
- [ ] Information conveyed by color alone is also conveyed by text or pattern
- [ ] Form errors are not identified by red color alone — include text description
- [ ] Layout makes sense when CSS is disabled (logical reading order)
- [ ] `<table>` elements used only for tabular data (not layout)
- [ ] Data tables have `<th>` with `scope` attribute and `<caption>`

### 1.4 Distinguishable

**Color contrast (WCAG AA minimums):**
| Text type | Minimum ratio |
|---|---|
| Normal text (< 18pt / 14pt bold) | 4.5:1 |
| Large text (≥ 18pt / 14pt bold) | 3:1 |
| UI components and graphical objects | 3:1 |
| Disabled controls | No requirement |

**Test with:** axe DevTools, WebAIM Contrast Checker, Colour Contrast Analyser

- [ ] Text can be resized to 200% without loss of content or functionality
- [ ] No horizontal scrolling at 320px width (WCAG 2.2 1.4.10 Reflow)
- [ ] Focus indicators are visible (WCAG 2.2 2.4.11 minimum contrast 3:1)

---

## 2. Operable

### 2.1 Keyboard Accessible
- [ ] All interactive elements are reachable via Tab key
- [ ] Tab order follows logical visual order (left-to-right, top-to-bottom)
- [ ] No keyboard traps — user can always Tab away from a component
- [ ] Skip navigation link at top of page (jumps to main content)
- [ ] Custom components (dropdowns, modals, carousels) fully keyboard operable

**Keyboard interaction patterns (ARIA Authoring Practices):**
```
Button:      Enter / Space to activate
Link:        Enter to follow
Dialog:      Escape to close, Tab cycles within, focus moves to first element on open
Menu:        Arrow keys to navigate, Enter to select, Escape to close
Combobox:    Down arrow opens, Arrow keys navigate, Enter selects, Escape closes
Tabs:        Left/Right arrow to switch tabs, Enter to activate
Tree:        Arrow keys to navigate, Enter/Space to toggle, Home/End for first/last
```

### 2.4 Navigable
- [ ] Every page has a descriptive `<title>` (unique per page — not just the app name)
- [ ] Headings form a logical hierarchy (`h1` → `h2` → `h3`, no skipped levels)
- [ ] Link text is descriptive without surrounding context ("Read more" ❌ / "Read accessibility guide" ✅)
- [ ] Focus is managed correctly: when modal opens → focus moves to modal; when modal closes → focus returns to trigger
- [ ] WCAG 2.2: Visible focus indicator with sufficient contrast (2.4.11)
- [ ] WCAG 2.2: Focus not obscured by sticky headers or overlays (2.4.12)

### 2.5 Input Modalities (WCAG 2.2)
- [ ] Drag-and-drop operations have a keyboard/click alternative (2.5.7)
- [ ] Targets for pointer inputs are at least 24×24px (2.5.8)

---

## 3. Understandable

### 3.1 Readable
- [ ] `<html lang="en">` (or correct language code) on every page
- [ ] Language changes within page marked with `lang` attribute on the element

### 3.2 Predictable
- [ ] Focus doesn't cause context changes (no auto-submit on focus)
- [ ] Navigation is consistent across pages
- [ ] Components with the same function have consistent names

### 3.3 Input Assistance
- [ ] All form fields have associated `<label>` (or `aria-label` / `aria-labelledby`)
- [ ] Required fields indicated (not by color alone)
- [ ] Error messages are specific ("Email must include @" not "Invalid input")
- [ ] Error messages are associated with their field via `aria-describedby`
- [ ] No timeout without warning and ability to extend (WCAG 2.2 3.3.7 Accessible Authentication)
- [ ] WCAG 2.2: Accessible authentication — no cognitive tests unless alternative provided (3.3.8)

---

## 4. Robust

### 4.1 Compatible
- [ ] Valid HTML — no duplicate IDs, properly nested elements
- [ ] ARIA roles, states, and properties used correctly (don't override native semantics unnecessarily)
- [ ] Status messages conveyed to AT without focus movement (`role="status"`, `aria-live="polite"`)

**ARIA rules:**
```
1. Don't use ARIA if native HTML does the job
   ❌ <div role="button"> ✅ <button>

2. Don't change native semantics
   ❌ <h2 role="tab"> ✅ <div role="tab">

3. Interactive ARIA controls must be keyboard operable

4. Don't use role="presentation" or aria-hidden on focusable elements

5. All interactive elements must have an accessible name
```

---

## 5. Common Fixes by Component

### Modals / Dialogs
```html
<div role="dialog" aria-modal="true" aria-labelledby="dialog-title" aria-describedby="dialog-desc">
  <h2 id="dialog-title">Confirm deletion</h2>
  <p id="dialog-desc">This action cannot be undone.</p>
  <!-- Focus trap: Tab cycles within dialog -->
  <!-- On close: return focus to trigger element -->
</div>
```

### Icon Buttons
```html
<!-- Visible icon, no visible label -->
<button aria-label="Close dialog">
  <svg aria-hidden="true" focusable="false">...</svg>
</button>
```

### Form Errors
```html
<label for="email">Email <span aria-hidden="true">*</span><span class="sr-only">(required)</span></label>
<input id="email" type="email" aria-describedby="email-error" aria-invalid="true">
<span id="email-error" role="alert">Enter a valid email address including @</span>
```

### Live Regions
```html
<!-- For dynamic status updates that should be announced -->
<div aria-live="polite" aria-atomic="true">
  3 results found
</div>

<!-- For urgent announcements (use sparingly) -->
<div role="alert">
  Your session expires in 2 minutes
</div>
```

---

## 6. Testing Checklist

**Automated (catches ~30–40% of issues):**
- [ ] Run axe DevTools or Lighthouse in CI (zero-tolerance for Critical and Serious)
- [ ] Run WAVE or IBM Equal Access Checker for additional coverage

**Manual (required for the rest):**
- [ ] Keyboard-only navigation through every user flow
- [ ] Screen reader testing: NVDA+Firefox (Windows), VoiceOver+Safari (Mac/iOS), TalkBack (Android)
- [ ] Zoom to 200% and 400% — no content loss, no horizontal scroll
- [ ] Disable CSS — content order makes sense
- [ ] Color blindness simulation (Figma or browser extension) — no information lost

**Findings format:**
| Issue | WCAG criterion | Level | Impact | Element | Fix |
|---|---|---|---|---|---|
| | | A / AA / AAA | Critical / Serious / Moderate / Minor | | |
