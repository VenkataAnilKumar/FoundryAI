---
description: Route architecture decisions to the right specialist — AI systems, cloud, data, integration, security, application, or cross-team
argument-hint: Describe the architecture decision or design challenge
---

You are routing an architecture decision or design challenge to the right specialist.

## Architecture Challenge
$ARGUMENTS

---

## Step 1: Identify the Architecture Type

Read the challenge and identify which domain it primarily belongs to:

| Type | Signals |
|---|---|
| **AI / LLM system** | RAG pipelines, agent systems, model serving, embeddings, inference |
| **Cloud infrastructure** | AWS/GCP/Azure, IaC, multi-cloud, networking, compute, storage |
| **Data platform** | Lakehouse, data warehouse, data modeling, lineage, real-time vs batch |
| **Integration** | API gateways, event mesh, microservices wiring, third-party systems |
| **Security** | Trust boundaries, zero-trust, auth models, secret management |
| **Application** | Hexagonal/DDD/clean arch, module boundaries, monolith vs microservices |
| **Cross-cutting** | Touches multiple domains — needs more than one architect |

---

## Step 2: Route to the Right Architect

| Domain | Agent | Best For |
|---|---|---|
| AI/LLM systems | `ai-architect` | RAG architecture, LLM pipelines, embedding strategy, agent system design, model selection, MLOps integration |
| Cloud infrastructure | `cloud-architect` | AWS/GCP/Azure design, multi-cloud strategy, IaC (Terraform/Pulumi), networking, FinOps |
| Data platform | `data-architect` | Data lakehouse, warehouse (Snowflake/BigQuery/Redshift), data modeling, lineage, ingestion patterns |
| Integrations | `integration-architect` | API gateway design, event-driven architecture, Kafka/Pub-Sub, microservices contracts, third-party API integration |
| Security | `security-architect` | Zero-trust design, threat modeling, security frameworks, auth/authz patterns, secret management |
| Application | `software-architect` | Hexagonal/clean/DDD architecture, module design, ADRs, refactoring strategy, tech debt remediation |
| Cross-cutting | `staff-engineer` | Engineering-wide standards, cross-team design review, platform decisions affecting all teams |

---

## Step 3: Frame the Problem for the Architect

When spawning the architect agent, give them:
1. **The decision to make** — what specifically needs to be designed or decided
2. **Constraints** — existing stack, team size, budget, timeline, scale requirements
3. **Options already considered** — what's been ruled out and why
4. **Deliverable expected** — ADR, design doc, diagram, technical recommendation, proof-of-concept

---

## Step 4: For Complex Cross-Domain Problems

If the challenge spans multiple architecture domains, run architects in parallel then synthesize:

```
Example: "Build a real-time AI personalization system"
→ ai-architect (LLM/RAG layer design)
→ data-architect (feature store + real-time pipeline)
→ cloud-architect (infrastructure and scaling)
→ integration-architect (API contracts and event flow)
→ security-architect (data privacy and access control)

Then: staff-engineer synthesizes into a unified architecture
```

---

## Step 5: Deliverable

The chosen architect should produce one of:
- **Architecture Decision Record (ADR)** — for a discrete decision with trade-offs
- **System design document** — for a new component or system
- **Architecture review** — for evaluating an existing design
- **Migration plan** — for moving from current to target state

Always include: the decision made, alternatives considered, trade-offs accepted, and open risks.
