# Agent Team Workflow Recipes

Copy-paste these prompts into Claude Code to launch pre-configured multi-agent teams for common AI project tasks. Requires Agent Teams enabled.

---

## 🏗️ 1. Build a Production RAG System

```
Create an agent team to design and build a production-grade RAG system.

Team composition:
- AI Architect: design overall system architecture and component selection
- AI Engineer: implement the embedding pipeline, chunking strategy, and retrieval layer
- AI Backend Engineer: build the API layer and integrate with the vector database
- ai-qa-engineer: design the evaluation framework and RAG metrics
- ai-responsible-engineer: review for data privacy and content safety

Shared goal: Deliver a complete RAG architecture document, working implementation
plan, and evaluation framework for a document Q&A system over a 10k-document corpus.

Start by having the AI Architect present the high-level design, then fan out to parallel workstreams.
```

---

## 🚀 2. AI Product MVP in a Weekend

```
Create an agent team to ship a complete AI product MVP.

Product idea: [describe your product idea here]

Team composition:
- AI Product Manager: write a lean PRD with core user stories and acceptance criteria
- AI UX Designer: design the key user flows and main UI screens
- AI Full Stack Engineer: implement the MVP end-to-end (frontend + backend + AI layer)
- ai-devops-engineer: set up deployment and CI/CD
- ai-prompt-engineer: design and optimize the core prompts for the product

Constraint: Ship a working demo in 2 days. Cut scope aggressively. Use managed services.
Start with the PRD, then parallelize design and engineering.
```

---

## 🛡️ 3. AI Product Launch Readiness Review

```
Create an agent team to conduct a full launch readiness review for our AI product.

Team composition:
- ai-legal-engineer: assess EU AI Act classification, GDPR compliance, and T&C gaps
- ai-responsible-engineer: audit for bias, fairness, and harmful output risks
- ai-security-engineer: conduct threat model review and test for prompt injection
- ai-qa-engineer: define go/no-go quality metrics and run final eval suite
- ai-docs-engineer: review docs completeness for launch
- ai-analytics-engineer: verify that all launch metrics and dashboards are in place

Deliverable: A launch readiness report with a clear GO / NO-GO recommendation
and a list of blocking vs. non-blocking issues. Each agent provides their section.
```

---

## 📊 4. AI Cost Optimization Sprint

```
Create an agent team to reduce our AI infrastructure costs.

Context: We are currently spending $[X]/month on LLM API calls.
Main usage: [describe your AI features and usage patterns]

Team composition:
- ai-finance-engineer: analyze cost breakdown and identify top opportunities
- ai-prompt-engineer: audit prompts for token inefficiency and optimize for cost
- AI Engineer: identify caching opportunities and implement semantic cache
- AI Platform Engineer: review model serving configuration and right-sizing
- ai-data-scientist: analyze usage patterns to find batching and routing opportunities

Goal: Identify and implement changes targeting a 40%+ cost reduction
without degrading output quality. Prioritize highest-impact changes first.
```

---

## 🔬 5. Research Spike — Implement New AI Technique

```
Create an agent team to research and implement [technique name, e.g. "self-RAG" / "HyDE retrieval" / "Constitutional AI"].

Team composition:
- AI Research Engineer: review the paper, summarize key contributions, and design implementation plan
- AI Engineer: implement the core technique in our existing stack
- ai-prompt-engineer: design the prompts required for the technique
- ai-qa-engineer: design the evaluation to compare against our baseline
- AI Architect: review the implementation for production readiness

Deliverable: Working implementation + evaluation results + recommendation
on whether to deploy to production with rationale.
```

---

## 📱 6. Build a Streaming Chat UI

```
Create an agent team to build a production-quality streaming chat interface.

Requirements:
- Streaming responses with typewriter effect
- Multi-turn conversation with context management
- File upload and analysis capability
- Feedback (thumbs up/down) and regenerate controls
- Mobile responsive

Team composition:
- AI UX Designer: design the chat UI components and interaction patterns
- AI Frontend Engineer: implement the chat UI with Vercel AI SDK streaming
- AI Backend Engineer: build the chat API with streaming, session management, and history
- ai-qa-engineer: write tests and define quality metrics

Start with UX designs, then fan out to parallel frontend/backend development.
Reconvene for integration and testing.
```

---

## 📋 7. AI Strategy Document for Executive Team

```
Create an agent team to produce a comprehensive AI strategy document.

Company context: [brief description of company, industry, current AI maturity]

Team composition:
- AI Strategy Engineer: lead the strategy document — vision, roadmap, investment thesis
- AI Solution Architect: map specific AI use cases to business outcomes with feasibility scores
- ai-analytics-engineer: build the ROI models and expected business impact quantification
- ai-responsible-engineer: write the responsible AI principles and governance framework
- ai-legal-engineer: summarize key regulatory considerations for the industry

Deliverable: A 10-15 page executive AI strategy document including:
vision, prioritized use cases, 3-year roadmap, governance framework, and investment case.
Each agent contributes their section; AI Strategy Engineer synthesizes the final document.
```

---

## 🔧 8. MLOps Platform Setup

```
Create an agent team to design and implement our MLOps platform from scratch.

Current state: [describe current state — no CI/CD for models, manual deployments, etc.]
Target: Fully automated model training, evaluation, and deployment pipeline

Team composition:
- AI Platform Engineer: design the platform architecture and component selection
- ai-devops-engineer: implement CI/CD pipelines, model registry, and deployment automation
- ai-data-engineer: design the data versioning and feature pipeline integration
- ai-qa-engineer: set up automated model evaluation and quality gates
- ai-docs-engineer: write runbooks and platform documentation

Deliverable: Working MLOps platform with CI/CD, model registry, automated evaluation,
and monitoring. Include full documentation and runbooks.
```

---

## 🎙️ 9. Build a Voice AI Product

```
Create an agent team to build a production voice AI application.

Requirements:
- Real-time speech-to-text (streaming transcription)
- LLM-powered response generation
- Text-to-speech output with natural voice
- Mobile + web support

Team composition:
- AI UX Designer: design the voice interaction flow and visual feedback patterns
- AI Frontend Engineer: implement the voice UI (waveform, recording controls, playback)
- AI Mobile Engineer: build the native mobile voice experience (iOS/Android)
- AI Backend Engineer: build the voice pipeline API (STT → LLM → TTS)
- AI Engineer: integrate Whisper, Claude API, and ElevenLabs/OpenAI TTS

Start with the backend pipeline, then build web and mobile clients in parallel.
```

---

## 🔍 10. Fine-tune a Model for Custom Use Case

```
Create an agent team to fine-tune a language model for our specific domain.

Context: [describe your domain, e.g. legal contract review, medical coding, customer support]
Goal: [e.g. improve accuracy on domain tasks, reduce hallucinations, match brand voice]

Team composition:
- AI Research Engineer: select base model, design fine-tuning approach (SFT, DPO, LoRA)
- ai-data-scientist: analyze existing data, identify quality signals, build training dataset
- ai-data-engineer: build the data pipeline — collect, clean, format, version training data
- ai-devops-engineer: set up training infrastructure (GPU cluster, experiment tracking)
- ai-qa-engineer: design evaluation suite to measure improvement vs. baseline
- ai-prompt-engineer: optimize system prompts to complement the fine-tuned model

Deliverable: Fine-tuned model with evaluation results showing improvement on target tasks,
training pipeline for future iterations, and deployment plan.
```

---

## 🛒 11. AI-Powered E-commerce Features

```
Create an agent team to build AI features for an e-commerce platform.

Features:
- Semantic product search (natural language queries)
- Personalized recommendations
- AI product description generation
- Visual search (search by image)

Team composition:
- AI Architect: design the overall AI feature architecture and vector search infrastructure
- AI Engineer: build embedding pipeline, product indexing, and semantic search layer
- AI Backend Engineer: build recommendation API and product generation endpoints
- AI Frontend Engineer: build search UI with AI suggestions and visual search upload
- ai-data-engineer: build the product catalog ETL and embedding update pipeline
- ai-qa-engineer: design offline and online evaluation for search quality

Start with semantic search (highest impact), then recommendations, then generation.
```

---

## 🔐 12. AI Security Red Team Review

```
Create an agent team to conduct a comprehensive AI security review.

Scope: [describe your AI system — LLM API, RAG pipeline, agentic system, etc.]

Team composition:
- ai-security-engineer: lead the threat model, test for prompt injection, jailbreaks, data exfiltration
- ai-responsible-engineer: test for harmful outputs, bias, PII leakage, and safety bypasses
- AI Backend Engineer: review API security, authentication, rate limiting, and input validation
- ai-legal-engineer: assess regulatory compliance gaps and liability exposure

Deliverable: Security assessment report with:
- Threat model diagram
- Ranked list of vulnerabilities (Critical / High / Medium / Low)
- Reproduction steps for each finding
- Recommended mitigations with effort estimates
- Compliance gap analysis
```

---

## 📊 13. Data Pipeline for AI Training

```
Create an agent team to build a production data pipeline for AI model training.

Data sources: [describe sources — user interactions, documents, databases, APIs]
Target: Clean, versioned, labeled training dataset with automated refresh

Team composition:
- ai-data-engineer: design and build the ingestion, transformation, and storage pipeline
- ai-data-scientist: define quality criteria, label schema, and statistical validation
- ai-devops-engineer: automate pipeline scheduling, monitoring, and alerting
- ai-responsible-engineer: audit data for bias, PII, and consent compliance
- ai-docs-engineer: document data lineage and schema

Deliverable: Automated data pipeline with monitoring, data quality gates, versioned
dataset artifacts, and full lineage documentation.
```

---

## 📱 14. AI Mobile App MVP

```
Create an agent team to ship a production AI mobile app.

App concept: [describe your app — e.g. AI journaling, document scanner, voice assistant]
Platforms: iOS + Android (cross-platform)

Team composition:
- AI Product Manager: write lean PRD with core user stories and MVP scope definition
- AI UX Designer: design key screens, onboarding flow, and AI interaction patterns
- AI Mobile Engineer: implement the app in React Native (Expo) or Flutter
- AI Backend Engineer: build the API layer connecting mobile to AI services
- AI Engineer: integrate the specific AI capabilities (LLM, vision, speech, etc.)

Constraint: Ship to TestFlight/Play Console internal testing within 2 weeks.
Start with product and UX, then build mobile and backend in parallel.
```

---

## 🗄️ 15. Vector Database Migration & RAG Optimization

```
Create an agent team to optimize our RAG system and migrate to a better vector database.

Current state: [describe current setup — e.g. Chroma, basic chunking, low retrieval accuracy]
Goal: Improve retrieval accuracy by 30%+ and scale to [X] documents

Team composition:
- AI Architect: design the target RAG architecture and select optimal vector store
- AI Database Engineer: design vector schema, indexing strategy, and migration plan
- AI Engineer: implement improved chunking, embedding, and hybrid retrieval pipeline
- ai-qa-engineer: build RAG evaluation framework (RAGAS metrics) and run A/B tests
- ai-devops-engineer: automate the migration and set up ongoing index maintenance

Deliverable: Migrated RAG system with measurable accuracy improvements, evaluation
report comparing old vs. new system, and automated re-indexing pipeline.
```
