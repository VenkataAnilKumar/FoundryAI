# Agent Team Workflow Recipes

Copy-paste these prompts into Claude Code to launch pre-configured multi-agent teams.
Replace `[placeholders]` with your specifics before running.

---

## 1. Build a Production RAG System

```
Create an agent team to design and build a production-grade RAG system.

Team:
- ai-architect: design overall system architecture, vector store selection, chunking strategy
- ai-engineer: implement embedding pipeline, retrieval layer, hybrid search
- ai-backend-engineer: build API layer, streaming responses, session management
- ai-database-engineer: design vector schema, indexing, query optimization
- ai-qa-engineer: design RAG evaluation framework (RAGAS metrics, faithfulness, relevance)
- ai-responsible-engineer: review for data privacy and content safety

Goal: Complete RAG architecture document, working implementation plan, and
evaluation framework for a document Q&A system over a [X]-document corpus.

Start with ai-architect presenting the high-level design, then fan out.
```

---

## 2. AI Product MVP

```
Create an agent team to ship a complete AI product MVP.

Product idea: [describe your product idea]

Team:
- ai-product-manager: write lean PRD with core user stories and MVP scope
- ux-researcher: conduct 3-5 user interviews to validate key assumptions
- product-designer: design key flows and main UI screens
- ai-fullstack-engineer: implement MVP end-to-end
- ai-devops-engineer: set up deployment and CI/CD
- ai-prompt-engineer: design and optimize core prompts

Constraint: Shippable demo in 2 days. Cut scope aggressively. Use managed services.
Start with PRD + research in parallel, then design, then engineering.
```

---

## 3. Product Launch Readiness Review

```
Create an agent team for a full launch readiness review.

Product: [describe your AI product]

Team:
- ai-legal-engineer: EU AI Act classification, GDPR compliance, T&C gaps
- ai-responsible-engineer: bias audit, fairness review, harmful output risk
- ai-security-engineer: threat model, prompt injection, API security
- ai-qa-engineer: go/no-go quality metrics, final eval suite run
- ai-technical-writer: docs completeness review
- ai-analytics-engineer: verify launch metrics and dashboards are ready
- product-marketing-manager: messaging readiness, sales enablement, launch comms plan

Deliverable: Launch readiness report with GO / NO-GO recommendation
and blocking vs. non-blocking issues. Each agent provides their section.
```

---

## 4. AI Cost Optimization Sprint

```
Create an agent team to reduce AI infrastructure costs.

Context: Currently spending $[X]/month. Main usage: [describe features and patterns]

Team:
- ai-finance-engineer: cost breakdown analysis, top optimization opportunities
- ai-prompt-engineer: audit prompts for token inefficiency, optimize for cost
- ai-engineer: identify caching opportunities, implement semantic cache
- ai-platform-engineer: model serving config, right-sizing, batching
- ai-data-scientist: usage pattern analysis, routing opportunities

Goal: Identify and implement changes targeting 40%+ cost reduction
without degrading output quality. Prioritize highest-impact changes first.
```

---

## 5. Architecture Review for New System

```
Create an architecture review team for [system name].

Context: [describe the system — purpose, scale, key requirements]

Team:
- software-architect: application architecture, patterns, NFRs, ADR
- security-architect: threat model, trust boundaries, compliance requirements
- data-architect: data model, storage strategy, data contracts, lineage
- integration-architect: service communication, event design, API contracts
- cloud-architect: infrastructure design, cost estimate, reliability posture
- staff-engineer: code structure standards, tech debt assessment

Deliverable: Architecture review report covering each domain with
trade-offs, risks, recommendations, and open decisions requiring input.
```

---

## 6. Research Spike — Implement New AI Technique

```
Create an agent team to research and implement [technique name,
e.g. "self-RAG" / "HyDE retrieval" / "Constitutional AI" / "long-context reranking"].

Team:
- ai-research-engineer: review the paper, summarize contributions, design implementation plan
- ai-engineer: implement the core technique in our existing stack
- ai-prompt-engineer: design prompts required for the technique
- ai-qa-engineer: design evaluation to compare against current baseline
- software-architect: review implementation for production readiness

Deliverable: Working implementation + evaluation results + recommendation
on whether to deploy to production with rationale.
```

---

## 7. Build a Streaming Chat UI

```
Create an agent team to build a production-quality streaming chat interface.

Requirements:
- Streaming responses with typewriter effect
- Multi-turn conversation with context management
- File upload and analysis capability
- Feedback (thumbs up/down) and regenerate controls
- Mobile responsive

Team:
- product-designer: design chat UI components, interaction patterns, all states
- ai-frontend-engineer: implement chat UI with Vercel AI SDK streaming
- ai-backend-engineer: build chat API with streaming, session management, history
- ai-qa-engineer: write tests and define quality metrics

Start with product-designer, then fan out to parallel frontend/backend.
Reconvene for integration and testing.
```

---

## 8. AI Strategy Document

```
Create an agent team to produce a comprehensive AI strategy document.

Company context: [describe company, industry, current AI maturity level]

Team:
- ai-strategy-engineer: lead the strategy — vision, roadmap, investment thesis
- ai-architect: map specific AI use cases with feasibility and architecture sketches
- product-analyst: build ROI models and business impact quantification
- ai-responsible-engineer: responsible AI principles and governance framework
- ai-legal-engineer: key regulatory considerations for the industry

Deliverable: 10-15 page executive AI strategy document:
vision, prioritized use cases, 3-year roadmap, governance framework, investment case.
ai-strategy-engineer synthesizes the final document from each section.
```

---

## 9. MLOps Platform Setup

```
Create an agent team to design and implement an MLOps platform.

Current state: [describe — no CI/CD for models, manual deployments, etc.]
Target: Automated model training, evaluation, and deployment pipeline

Team:
- ml-engineer: design platform architecture, component selection, feature store
- ai-devops-engineer: CI/CD pipelines, model registry, deployment automation
- ai-data-engineer: data versioning and feature pipeline integration
- ai-platform-engineer: GPU infra, model serving (Triton/vLLM), scaling
- ai-qa-engineer: automated model evaluation and quality gates
- ai-technical-writer: runbooks and platform documentation

Deliverable: Working MLOps platform with CI/CD, model registry, automated
evaluation, monitoring, and full documentation.
```

---

## 10. User Research & Product Discovery Sprint

```
Create an agent team to run a product discovery sprint for [feature/product area].

Research questions:
1. [What do you need to learn?]
2. [What decisions will this inform?]

Team:
- ux-researcher: design and run 5-8 user interviews + usability tests
- product-analyst: analyze product analytics for behavioral patterns related to this area
- product-designer: synthesize findings into journey maps and opportunity areas
- ai-product-manager: translate insights into prioritized opportunity backlog

Timeline: 2-week sprint.
Deliverable: Research report with key insights, journey map, opportunity backlog,
and top 3 recommended product directions with evidence.
```

---

## 11. Security Red Team Review

```
Create an agent team for a comprehensive AI security review.

Scope: [describe your AI system — LLM API, RAG pipeline, agentic system, etc.]

Team:
- security-architect: lead threat model, trust boundaries, blast radius analysis
- ai-security-engineer: test for prompt injection, jailbreaks, data exfiltration
- ai-responsible-engineer: test for harmful outputs, PII leakage, safety bypasses
- ai-backend-engineer: API security, authentication, rate limiting, input validation
- ai-legal-engineer: compliance gaps, regulatory liability exposure

Deliverable: Security assessment report:
- Threat model diagram
- Ranked vulnerabilities (Critical / High / Medium / Low)
- Reproduction steps per finding
- Mitigations with effort estimates
- Compliance gap analysis
```

---

## 12. Developer Platform Launch

```
Create an agent team to design and launch a developer-facing API platform.

Product: [describe your API — what it does, target developers, use cases]

Team:
- technical-product-manager: API product strategy, pricing, DX roadmap, SDK plan
- integration-architect: API design patterns, gateway architecture, versioning strategy
- ai-api-designer: OpenAPI spec, endpoint design, error codes, DX review
- ai-backend-engineer: implement API with auth, rate limiting, webhooks
- ai-technical-writer: API reference docs, quickstarts, tutorials, developer portal
- developer-advocate: developer community plan, early access program, feedback loops
- ai-qa-engineer: API testing, contract testing, reliability verification

Deliverable: Launched developer platform with docs, SDKs, and community program.
```

---

## 13. Data Platform Architecture

```
Create an agent team to design a modern data platform.

Current state: [describe — scattered databases, no governance, ad-hoc analytics, etc.]
Scale: [data volume, team size, number of data consumers]

Team:
- data-architect: data strategy, governance framework, data mesh vs warehouse decision
- ai-data-engineer: pipeline design, lakehouse architecture, streaming vs batch
- ai-database-engineer: storage design, partitioning, indexing strategy
- ai-analytics-engineer: consumption layer — dashboards, metrics, BI tooling
- cloud-architect: infrastructure, cost model, regional requirements

Deliverable: Data platform architecture blueprint — current state, target state,
migration path, governance framework, technology decisions with rationale.
```

---

## 14. Incident Response & Postmortem

```
Create an agent team to handle an ongoing production incident.

Incident: [describe what's broken — service, symptoms, customer impact, severity]
Started: [time]

Team:
- site-reliability-engineer: incident commander — triage, mitigation, timeline
- ai-backend-engineer: root cause investigation, fix implementation
- ai-security-engineer: assess if security-related, check for data exposure
- release-manager: coordinate hotfix release or rollback
- ai-technical-writer: draft postmortem and customer communication

Immediate priority: restore service. Then root cause, then postmortem.
SRE leads — all other agents report findings to SRE for coordination.
```

---

## 15. AI Mobile App MVP

```
Create an agent team to ship a production AI mobile app.

App concept: [describe — e.g. AI journaling, document scanner, voice assistant]
Platforms: iOS + Android (cross-platform)

Team:
- ai-product-manager: lean PRD with core user stories and MVP scope
- ux-researcher: rapid concept validation (3 interviews + prototype test)
- product-designer: key screens, onboarding flow, AI interaction patterns
- ai-mobile-engineer: implement in React Native (Expo) or Flutter
- ai-backend-engineer: API layer connecting mobile to AI services
- ai-engineer: integrate specific AI capabilities (LLM, vision, speech)

Target: TestFlight/Play Console internal testing in 2 weeks.
Start with research + product in parallel, then design, then mobile + backend in parallel.
```

---

## 16. GTM & Positioning Sprint

```
Create an agent team to develop go-to-market strategy for [product/feature].

Context: [describe product, current customers, market, stage]
Key question: [e.g. "How do we differentiate from X?" / "Which segment to focus on?"]

Team:
- product-marketing-manager: positioning framework, messaging hierarchy, GTM plan
- ux-researcher: customer discovery interviews (focus on jobs-to-be-done and buying signals)
- product-analyst: analyze current adoption data, identify best-fit customer characteristics
- ai-product-manager: connect GTM strategy to product roadmap

Deliverable: Positioning document, ICP definition, messaging framework,
launch plan with channels + timeline, sales battlecard.
```
