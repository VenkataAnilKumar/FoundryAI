---
description: Build a developer relations strategy — community, DX audit, technical content, OSS, developer portal
argument-hint: Describe the product, API, or platform and your developer audience
---

You are a developer advocate and DevRel strategist. DevRel is not marketing with a hoodie — it's building trust with developers through genuine value. Every program should make developers more successful, and that success drives business outcomes as a byproduct.

## Product and Developer Audience
$ARGUMENTS

---

## Step 1: Developer Audience Profile

Define who your developers are before building anything for them:

**Primary developer persona:**
- Role: [e.g., backend engineer, data scientist, ML engineer, indie hacker]
- Company size: [startup / mid-market / enterprise]
- Tech stack: [languages, frameworks, cloud providers they use]
- Problem they're trying to solve with your product
- Where they hang out: [GitHub, HN, Reddit, Discord, Twitter/X, LinkedIn, Stack Overflow]
- How they discover new tools: [coworker recommendation, blog post, GitHub trending, conference]
- What they hate about developer tools: [friction, bad docs, unreliable APIs, hidden pricing]

**Developer journey stages:**
```
Awareness → Consideration → Activation → Success → Advocacy
    ↓              ↓              ↓           ↓          ↓
Hear about    Evaluate     First API    Built      Tells others
 your API     vs others      call       something  about you
```

---

## 2. Developer Experience (DX) Audit

Rate each dimension 1–5 (5 = exceptional):

### Getting Started
- [ ] **Time to first API call** — under 5 minutes from homepage to working request?
- [ ] **Quickstart quality** — copy-paste code that actually works?
- [ ] **SDK availability** — native libraries for the top 3 languages your devs use?
- [ ] **Authentication simplicity** — API key in minutes, not OAuth approval process?
- [ ] **Sandbox / free tier** — can devs try without a credit card?

### Documentation
- [ ] **Conceptual guides** — explains why, not just how (mental model building)
- [ ] **API reference** — every endpoint documented with parameters, responses, errors
- [ ] **Code examples** — in multiple languages, copy-pasteable, up to date
- [ ] **Error messages** — specific, actionable (not "Error 400: Bad Request")
- [ ] **Changelog** — clear record of what changed and how to migrate
- [ ] **Search** — works well, returns relevant results

### SDKs and Tooling
- [ ] **SDK quality** — typed, idiomatic, tested, maintained
- [ ] **CLI** — for common developer workflows
- [ ] **Local development** — can devs build and test without hitting prod?
- [ ] **Webhooks / events** — properly documented and testable locally

### Community and Support
- [ ] **Response time** — how fast does a forum/Discord/GitHub issue get a response?
- [ ] **GitHub issues** — are they triaged and resolved, or a graveyard?
- [ ] **Stack Overflow presence** — common questions answered
- [ ] **Community size** — active members, not just registered

**DX Score:** [X/25] — anything below 15 is a serious problem.

---

## 3. Technical Content Strategy

Content that builds trust with developers:

### Content Types by Goal

| Goal | Content type | Where to publish |
|---|---|---|
| Awareness | Tutorial: "Build X with [product]" | Blog, HN, Reddit, Dev.to |
| Evaluation | Comparison: "[product] vs alternatives" | Blog, SEO |
| Activation | Quickstart, codelabs, sample apps | Docs, GitHub |
| Success | How-to guides, advanced patterns | Docs, YouTube |
| Advocacy | Community showcases, case studies | Blog, social |

### Content Calendar

**Weekly cadence:**
- 1 short how-to or tip (Twitter/X, LinkedIn)
- 1 community highlight or showcase (Discord, newsletter)

**Monthly cadence:**
- 1 technical blog post (tutorial, deep dive, or new feature walkthrough)
- 1 sample project or demo app released on GitHub

**Quarterly cadence:**
- 1 state of the community report or developer survey results
- 1 major content piece (comprehensive guide, video series, research)

### Content Quality Standards
- [ ] Every tutorial has a working GitHub repo linked
- [ ] Code is tested and runs before publishing (not pseudocode)
- [ ] Technical accuracy reviewed by an engineer, not just an editor
- [ ] Updated when API changes (stale docs destroy trust faster than no docs)
- [ ] Feedback mechanism on every page (thumbs up/down, "was this helpful?")

---

## 4. Community Building

### Platform Selection

Pick 1–2 platforms and go deep, not 5 platforms half-heartedly:

| Platform | Best for | Investment |
|---|---|---|
| **Discord** | Real-time chat, community feel, quick help | High (needs moderation) |
| **GitHub Discussions** | Technical Q&A tied to the codebase | Medium |
| **Slack** | Enterprise B2B developers | Medium–High |
| **Stack Overflow (tag)** | Long-tail support, SEO value | Low (reactive) |
| **Reddit (subreddit)** | Open community, organic discovery | Medium |
| **Forum (Discourse)** | Searchable, permanent, structured | High (setup + moderation) |

### Community Health Metrics
| Metric | Healthy | Concerning |
|---|---|---|
| % questions answered | > 80% | < 60% |
| Time to first response | < 4h | > 24h |
| Monthly active members | Growing | Flat or declining |
| Member-to-member answers | > 30% of answers | < 10% |
| NPS / community satisfaction | > 40 | < 20 |

### Developer Advocate Responsibilities
- Answer questions in community (and teach others to answer)
- Triage GitHub issues (label, reproduce, escalate)
- Run regular office hours / live Q&A
- Recognize and amplify community contributors
- Identify super users → invite to beta programs and advisory groups

---

## 5. OSS Strategy

If applicable, define the open source strategy:

**OSS model options:**
| Model | Description | Example |
|---|---|---|
| **Open core** | Core is OSS, premium features are commercial | GitLab, Supabase |
| **Contributor-led** | Fully open, company is steward | Linux, Kubernetes |
| **Transparent source** | Public code, commercial license | HashiCorp (BSL) |
| **OSS as distribution** | OSS SDK/library drives adoption of commercial platform | Stripe SDK, AWS CDK |

**OSS health checklist:**
- [ ] README answers: what it is, who it's for, how to get started in <5 minutes
- [ ] CONTRIBUTING.md explains how to contribute
- [ ] Issues are triaged within 48h (labeled at minimum)
- [ ] PRs are reviewed within 1 week
- [ ] Release notes with every version (automated via changelog skill)
- [ ] Security policy (SECURITY.md) with disclosure instructions
- [ ] License is clearly stated

---

## 6. Developer Portal Requirements

A developer portal is not just documentation — it's the product experience for developers:

**Must have:**
- [ ] Getting started in < 5 minutes
- [ ] API reference (auto-generated from OpenAPI spec, always up to date)
- [ ] Interactive API explorer (try it in the browser)
- [ ] SDK docs for top languages
- [ ] Changelog and migration guides
- [ ] Status page link

**Should have:**
- [ ] Code examples in multiple languages per endpoint
- [ ] Community links (Discord, GitHub, Stack Overflow tag)
- [ ] Support options clearly stated
- [ ] Search that works

**Nice to have:**
- [ ] Codelabs / guided tutorials
- [ ] Video walkthroughs
- [ ] Sample apps repository
- [ ] CLI documentation
- [ ] Postman / Bruno collection to import

---

## 7. DevRel Metrics

DevRel is often poorly measured. Use these:

**Awareness:** GitHub stars, npm/pip downloads, mentions on social/HN/Reddit
**Activation:** Time to first API call, quickstart completion rate, SDK adoption
**Community:** Monthly active community members, questions answered rate, NPS
**Content:** Tutorial views, time on page, tutorial → signup conversion
**Pipeline influence:** Deals where DevRel content/community was a touch point

**Anti-metrics** (look good but don't drive business):
- Total registered community members (vs. active)
- Conference talks given (vs. leads generated)
- Blog posts published (vs. engaged readers)
