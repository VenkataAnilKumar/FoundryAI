# Agent Capability Reference

Full details on all 34 specialist agents and when to use each one.

---

## How to invoke an agent

In Claude Code, just tell it which agent to use:

```
Use the ai-architect agent to design a scalable architecture for my AI SaaS.
```

Or use the routing commands (requires plugin):
```
/team "design a scalable architecture for my AI SaaS"
```

---

## Engineering Agents (14)

### `ai-architect`
**Model**: claude-opus-4-6 (most capable)
**Best for**: System architecture, technology selection, scalability design, architecture reviews, ADRs
**Use when**: You need a high-level design decision, want to evaluate trade-offs, or need an architecture document

### `ai-engineer`
**Model**: claude-sonnet-4-6
**Best for**: LLM integration, RAG systems, embedding pipelines, vector search, Claude/OpenAI API usage
**Use when**: You're building AI features — the AI core, not the surrounding infrastructure

### `ai-backend-engineer`
**Model**: claude-sonnet-4-6
**Best for**: REST APIs, background jobs, async processing, database design, microservices
**Use when**: Building server-side logic, API endpoints, or backend services

### `ai-frontend-engineer`
**Model**: claude-sonnet-4-6
**Best for**: React/Next.js, streaming chat UI, real-time updates, responsive design, accessibility
**Use when**: Building UI components, especially for AI products with streaming responses

### `ai-fullstack-engineer`
**Model**: claude-sonnet-4-6
**Best for**: End-to-end features that span frontend and backend
**Use when**: You need one agent to handle a complete feature rather than coordinating two

### `ai-mobile-engineer`
**Model**: claude-sonnet-4-6
**Best for**: React Native, Flutter, Swift/SwiftUI, Kotlin/Jetpack Compose, on-device ML
**Use when**: Building iOS/Android apps or cross-platform mobile

### `ai-database-engineer`
**Model**: claude-sonnet-4-6
**Best for**: PostgreSQL, vector databases (pgvector, Pinecone, Qdrant), schema design, migrations, query optimization
**Use when**: Database design decisions, performance issues, or vector search architecture

### `ai-api-designer`
**Model**: claude-sonnet-4-6
**Best for**: REST API design, OpenAPI/Swagger specs, GraphQL schemas, gRPC, API versioning, DX
**Use when**: Designing APIs for others to consume or reviewing existing API design

### `ai-software-engineer`
**Model**: claude-sonnet-4-6
**Best for**: General coding in any language (Python, TypeScript, Go, Java, Rust, C#)
**Use when**: General purpose coding that doesn't fit a specialist category

### `ai-agentic-autonomous-engineer`
**Model**: claude-sonnet-4-6
**Best for**: Multi-agent systems, tool use, planning loops, memory systems, autonomous workflows
**Use when**: Building agent-to-agent systems, autonomous workflows, or anything that uses LLMs to make decisions

### `ai-devops-mlops-engineer`
**Model**: claude-sonnet-4-6
**Best for**: CI/CD, Docker, Kubernetes, model deployment, GitHub Actions, infrastructure as code
**Use when**: Setting up deployment pipelines, containerization, or MLOps workflows

### `ai-platform-engineer`
**Model**: claude-sonnet-4-6
**Best for**: Internal AI platform, model serving (vLLM, TGI), GPU infrastructure, developer tooling
**Use when**: Building internal infrastructure that other teams use to ship AI features

### `ai-qa-evaluation-engineer`
**Model**: claude-sonnet-4-6
**Best for**: LLM evaluation frameworks, adversarial testing, RAGAS, automated quality gates
**Use when**: Setting up evals for LLM outputs, designing test suites, or validating model behavior

### `ai-research-engineer`
**Model**: claude-opus-4-6
**Best for**: Implementing techniques from papers, running experiments, model benchmarking, novel approaches
**Use when**: You want to implement a research paper or experiment with new AI techniques

---

## Product Agents (7)

### `ai-product-manager`
**Model**: claude-sonnet-4-6
**Best for**: PRDs, user stories, roadmaps, OKRs, AI product metrics, GTM planning
**Use when**: Defining what to build and why

### `ai-product-builder`
**Model**: claude-sonnet-4-6
**Best for**: Rapid MVP scoping, prototype planning, demo building, fast iteration
**Use when**: You need to ship something fast and need help defining minimal viable scope

### `ai-ux-designer`
**Model**: claude-sonnet-4-6
**Best for**: User flows, wireframes, AI interaction patterns, onboarding design, error states
**Use when**: Designing how users will interact with your product

### `ai-solution-architect`
**Model**: claude-opus-4-6
**Best for**: Client-facing proposals, PoC design, build-vs-buy analysis, feasibility assessment
**Use when**: Designing solutions for specific client problems or evaluating technical feasibility

### `ai-strategy-engineer`
**Model**: claude-opus-4-6
**Best for**: AI strategy documents, competitive analysis, Wardley mapping, 3-year roadmaps
**Use when**: Executive-level strategy documents or major technology direction decisions

### `prompt-engineer`
**Model**: claude-sonnet-4-6
**Best for**: Prompt design, optimization, few-shot examples, chain-of-thought, structured output
**Use when**: Your LLM outputs aren't good enough and you need to improve prompts systematically

### `multi-agent-orchestrator`
**Model**: claude-opus-4-6
**Best for**: Coordinating teams of agents, complex multi-step projects, parallel workstreams
**Use when**: A task is too complex for one agent and needs a coordinator

---

## Business Agents (13)

### `ai-finance-cost-optimization`
**Best for**: LLM cost reduction, model routing by cost, token optimization, ROI analysis
**Use when**: Your AI costs are too high or you need to justify AI investment

### `ai-sales-customer-success`
**Best for**: Sales playbooks, demo scripts, customer onboarding flows, QBR prep, churn analysis
**Use when**: Building sales materials or improving customer retention

### `ai-growth-marketing`
**Best for**: AI-powered content, SEO strategy, campaign planning, growth experiments
**Use when**: Marketing and growth tasks

### `ai-security-risk`
**Best for**: Prompt injection testing, threat modeling, adversarial attacks, API security review
**Use when**: Security review of your AI system or API

### `responsible-ai-engineer`
**Best for**: Bias audits, fairness evaluation, EU AI Act compliance, harmful output testing
**Use when**: Ethics review, safety testing, or regulatory compliance (EU AI Act, NIST)

### `legal-compliance-agent`
**Best for**: GDPR, CCPA, IP risk, data processing agreements, AI-specific regulatory analysis
**Use when**: Legal review of your AI product before launch

### `analytics-insights-agent`
**Best for**: KPI dashboards, funnel analysis, cohort analysis, executive reporting
**Use when**: Building analytics or extracting insights from your data

### `autonomous-ops-agent`
**Best for**: Incident response, runbook execution, monitoring setup, deployment automation
**Use when**: Operational tasks, live incidents, or setting up automated operations

### `data-scientist`
**Best for**: Statistical analysis, ML models, A/B testing, experimentation design
**Use when**: Data analysis, building ML models, or designing experiments

### `data-engineer`
**Best for**: ETL/ELT pipelines, data warehouse design, data quality, stream processing
**Use when**: Building data infrastructure or data pipelines

### `domain-expert`
**Best for**: Deep subject matter knowledge, expert validation, domain-specific training data
**Use when**: You need specialized knowledge in a specific industry or domain

### `ai-documentation-knowledge-engineer`
**Best for**: API docs, architecture docs, runbooks, knowledge base design, developer guides
**Use when**: Creating technical documentation for internal or external audiences

### `technical-writer`
**Best for**: User guides, tutorials, how-to articles, SOPs, release notes, FAQs
**Use when**: Creating user-facing documentation or step-by-step guides

---

## The `founder` Agent

The `founder` agent is the master orchestrator. It knows all 34 specialists and can:
- Decompose complex tasks into subtasks
- Assign the right agents to each subtask
- Run agents in parallel where possible
- Synthesize results into a coherent output

Use it for large, multi-domain projects where you want intelligent routing without specifying agents yourself.

```
Use the founder agent to plan and execute a complete AI product launch,
including architecture, engineering, compliance, documentation, and marketing.
```
