# CLAUDE.md — AI Agent Routing Guide

This file is automatically loaded by Claude Code in every session.
Use it as a quick reference to pick the right agent for any task.

---

## Agent Routing Guide

### Leadership & Program Management
- **Strategic judgment + multi-domain execution** → `founder`
- **Complex multi-step projects, multi-agent coordination** → `ai-orchestrator`
- **Cross-team programs, dependency mapping, OKRs, milestone tracking** → `technical-program-manager`
- **Sprint planning, velocity, team health, retrospectives** → `engineering-manager`
- **Technical leadership, build-vs-buy, team structure, tech bets** → `cto-advisor`

### Architecture
- **AI/ML system architecture, GenAI, RAG, agentic systems** → `ai-architect`
- **Application architecture, patterns (hexagonal/clean/DDD), NFRs, ADRs** → `software-architect`
- **Zero-trust, IAM, compliance frameworks (NIST/SOC2/HIPAA/GDPR)** → `security-architect`
- **Data strategy, governance, data mesh, MDM, data contracts, lineage** → `data-architect`
- **Event-driven architecture, microservices, API gateway, service mesh** → `integration-architect`
- **Cloud infrastructure, AWS/GCP/Azure, IaC, FinOps, landing zones** → `cloud-architect`
- **Architecture review, coding standards, tech debt, senior IC mentoring** → `staff-engineer`

### Product
- **AI/ML product strategy, roadmap, PRDs, prototypes, MVPs** → `ai-product-manager`
- **Technical products, APIs, SDKs, platforms, developer-facing roadmap** → `technical-product-manager`
- **User research, interviews, usability testing, personas, journey maps** → `ux-researcher`
- **Product design, wireframes, hi-fi mockups, design systems, handoff** → `product-designer`
- **AI UX patterns, conversational UI, AI interaction design** → `ai-ux-designer`
- **Go-to-market, positioning, messaging, launch plans, battlecards** → `product-marketing-manager`
- **Product metrics, funnel analysis, A/B tests, retention, adoption** → `product-analyst`
- **AI product strategy, roadmap, competitive landscape, AI maturity** → `ai-strategy-engineer`

### Engineering
- **LLM integration, RAG, embeddings, fine-tuning** → `ai-engineer`
- **Frontend components, streaming UI, React, Next.js** → `ai-frontend-engineer`
- **API endpoints, DB, background jobs, server-side AI** → `ai-backend-engineer`
- **Full feature (front + back + AI)** → `ai-fullstack-engineer`
- **iOS/Android/React Native/Flutter** → `ai-mobile-engineer`
- **Database schema, vector search, migrations, query optimization** → `ai-database-engineer`
- **API design, OpenAPI specs, developer experience** → `ai-api-designer`
- **Agent/autonomous workflow, tool use, memory, planning loops** → `ai-agent-engineer`
- **CI/CD, deployment pipelines, MLOps, infrastructure automation** → `ai-devops-engineer`
- **Testing, LLM evaluation, adversarial testing, quality gates** → `ai-qa-engineer`
- **General software engineering, code review, refactoring** → `ai-software-engineer`
- **Performance optimization, latency, throughput, Core Web Vitals** → `ai-performance-engineer`
- **MLOps platform, model serving, GPU infra, internal AI platform** → `ai-platform-engineer`
- **Accessibility, WCAG compliance, screen readers, inclusive design** → `ai-accessibility-engineer`

### Platform & Operations
- **SLOs, incidents, runbooks, observability, chaos engineering** → `site-reliability-engineer`
- **ML training pipelines, feature stores, MLflow/Kubeflow, model serving** → `ml-engineer`
- **Versioning, changelogs, hotfix, rollback, release notes** → `release-manager`

### Data & AI
- **Data pipelines, ETL/ELT, data warehouse, streaming** → `ai-data-engineer`
- **Statistical analysis, ML models, A/B testing, experiments** → `ai-data-scientist`
- **Model evaluation, benchmarking, eval frameworks** → `ai-qa-engineer`
- **Prompt design, optimization, system prompts, structured output** → `ai-prompt-engineer`
- **Dashboards, KPIs, funnel analysis, BI, executive reporting** → `ai-analytics-engineer`
- **Research paper implementation, novel techniques, benchmarking** → `ai-research-engineer`

### Safety & Compliance
- **Bias, fairness, explainability, responsible AI** → `ai-responsible-engineer`
- **Security testing, threat modeling, OWASP, vulnerability scanning** → `ai-security-engineer`
- **Legal review, GDPR/CCPA/HIPAA, contracts, regulatory compliance** → `ai-legal-engineer`

### Growth & Business
- **LLM cost modeling, token optimization, FinOps** → `ai-finance-engineer`
- **Growth marketing, SEO, campaigns, content, acquisition** → `ai-growth-engineer`
- **Sales enablement, demos, customer success, CRM automation** → `ai-sales-engineer`
- **Developer community, OSS strategy, DevRel, technical content** → `developer-advocate`

### Knowledge & Content
- **All documentation: API docs, runbooks, user guides, ADRs, SOPs** → `ai-technical-writer`
- **UI microcopy, error messages, onboarding copy, voice & tone** → `content-designer`
- **Domain expertise, specialized knowledge validation** → `ai-domain-expert`

---

## Pre-built Agent Teams

### Feature Development Team
```
ai-product-manager  → define PRD + acceptance criteria
software-architect  → design approach + ADR
ai-frontend-engineer + ai-backend-engineer  → build in parallel
ai-qa-engineer  → test and validate
```

### AI Quality Review Team
```
ai-qa-engineer  → evaluation framework + test suite
ai-prompt-engineer  → optimize prompts
ai-responsible-engineer  → fairness + safety check
ai-security-engineer  → adversarial testing
```

### Launch Readiness Team
```
ai-orchestrator  → coordinate
ai-legal-engineer  → compliance review
ai-technical-writer  → docs completeness
ai-devops-engineer  → deployment checklist
ai-analytics-engineer  → metrics + dashboards
product-marketing-manager  → launch messaging
```

### Architecture Review Team
```
software-architect  → application architecture review
security-architect  → security threat model
data-architect  → data contracts + governance
integration-architect  → communication patterns
cloud-architect  → infrastructure + cost
```

### AI Incident / Hotfix Team
```
site-reliability-engineer  → triage + incident command
ai-backend-engineer  → root cause analysis + fix
ai-security-engineer  → security impact assessment
release-manager  → hotfix release + rollback
site-reliability-engineer  → postmortem
```

---

## Frequently Delegated Tasks

```bash
# "Review this PR for AI-specific issues"
→ ai-qa-engineer + ai-security-engineer + ai-responsible-engineer

# "Optimize our LLM costs — we're at $15k/month"
→ ai-finance-engineer + ai-prompt-engineer

# "We need to be EU AI Act compliant before launch"
→ ai-legal-engineer + ai-responsible-engineer

# "Build the chat interface with streaming"
→ ai-frontend-engineer + ai-backend-engineer

# "Set up evaluation pipeline for our RAG system"
→ ai-qa-engineer + ai-engineer + ai-data-scientist

# "Design our microservices communication strategy"
→ integration-architect + software-architect

# "Conduct user research for our new feature"
→ ux-researcher + product-designer

# "Write the GTM plan for our product launch"
→ product-marketing-manager + ai-product-manager

# "Set up production observability"
→ site-reliability-engineer + ai-devops-engineer + ai-analytics-engineer

# "Architect our data platform"
→ data-architect + ai-data-engineer + cloud-architect
```
