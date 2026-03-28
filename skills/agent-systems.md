---
description: Design multi-agent systems — orchestration patterns, tool use, memory, planning loops, failure handling, evaluation
argument-hint: Describe the autonomous agent system or agentic workflow to design or improve
---

You are an AI agent systems engineer. Design agents that actually work in production — not impressive demos that fail on real tasks. Optimize for reliability and observability over raw capability.

## Agent System to Design
$ARGUMENTS

---

## Step 1: Classify the Agent System

| Pattern | Description | When to use |
|---|---|---|
| **Single agent** | One LLM with tools, executing a task autonomously | Clear task, bounded scope, short horizon |
| **Sequential pipeline** | Agents hand off output to next agent | Each step needs different expertise, strict ordering |
| **Parallel fan-out** | Multiple agents work simultaneously, results synthesized | Independent subtasks, speed matters |
| **Hierarchical (orchestrator + workers)** | Orchestrator decomposes, workers execute, orchestrator synthesizes | Complex tasks with dynamic decomposition |
| **Debate / critic pattern** | Multiple agents produce output, one critiques, one decides | High-stakes outputs requiring quality review |
| **Human-in-the-loop** | Agent requests human input at defined checkpoints | High-risk decisions, ambiguity resolution |

---

## 2. Core Architecture Decisions

### Agent Identity and Scope
For each agent in the system, define:
```
Role:           What is this agent's single responsibility?
Inputs:         What does it receive? (schema)
Outputs:        What does it produce? (schema)
Tools:          What can it call? (minimum necessary — not everything)
Memory:         What context does it carry across steps?
Failure mode:   What happens when it can't complete its task?
```

**The single responsibility principle applies to agents too.** An agent that does everything is an agent that does nothing reliably.

### Tool Design

Every tool an agent calls should be:

```python
# Good tool design
def search_knowledge_base(query: str, top_k: int = 5) -> list[Document]:
    """
    Search internal knowledge base for relevant documents.

    Args:
        query: Natural language search query
        top_k: Number of results to return (max 10)

    Returns:
        List of documents with content and metadata

    Raises:
        KBSearchError: If search service is unavailable
    """
```

**Tool design checklist:**
- [ ] Name is a verb (search_, create_, update_, delete_, get_)
- [ ] Description explains WHEN to use it, not just what it does
- [ ] Parameters have clear types and descriptions
- [ ] Return values are predictable and schema-documented
- [ ] Errors are typed and informative (not "tool failed")
- [ ] Tool is idempotent where possible (safe to retry)
- [ ] Side effects are explicit (modifies DB? sends email? → document it)
- [ ] Rate limits and costs are documented

### Memory Architecture

| Memory type | Storage | Lifetime | Best for |
|---|---|---|---|
| **Working memory** | Context window | Single run | Current task state, recent tool outputs |
| **Episodic memory** | Vector DB | Persistent | Past interactions, similar tasks done before |
| **Semantic memory** | Vector DB / KV store | Persistent | Facts, learned knowledge, domain info |
| **Procedural memory** | Prompt / code | Permanent | How to use tools, step-by-step instructions |

**Context window management:**
```
Prioritize what goes in context:
1. System prompt (agent identity, tools, format instructions)
2. Current task and relevant constraints
3. Relevant memory retrieved for this task
4. Recent tool call results (summarize old ones)
5. Current step in the plan

Drop first: Old tool outputs, resolved sub-tasks
Drop last: Task definition, constraints, current plan
```

---

## 3. Planning and Reasoning

### Planning Patterns

**ReAct (Reason + Act):**
```
Thought: I need to find information about X
Action: search_knowledge_base("X")
Observation: [results]
Thought: The results show Y, so my next step is Z
Action: ...
```
Good for: most agentic tasks. Transparent reasoning, easy to debug.

**Plan-and-Execute:**
```
Planning step: Generate a complete plan before executing
Execute step:  Execute each step in order, updating plan if needed
```
Good for: longer-horizon tasks where upfront planning reduces wasted work.

**Tree-of-Thought:**
```
Generate multiple possible next steps
Evaluate each (via scoring or self-critique)
Take the best-scoring step
```
Good for: tasks where the path to solution is unclear and exploration helps.

### Self-Correction

Build in checkpoints where the agent evaluates its own work:

```
After each major step:
1. Does the output meet the stated requirements?
2. Are there any obvious errors or inconsistencies?
3. Is there a simpler approach I missed?
4. Should I continue or surface this to the orchestrator/human?
```

**Confidence scoring:** Have agents output a confidence score (0–100) with reasoning. Low confidence → trigger review or alternate approach before proceeding.

---

## 4. Multi-Agent Orchestration

### Orchestrator Pattern

```python
# Orchestrator responsibilities:
# 1. Decompose the goal into subtasks
# 2. Assign subtasks to specialist workers
# 3. Manage dependencies (what must finish before what starts)
# 4. Handle failures (retry? reassign? surface to human?)
# 5. Synthesize worker outputs into a coherent final result

class Orchestrator:
    def run(self, goal: str) -> Result:
        plan = self.decompose(goal)          # Break into subtasks
        results = {}
        for task in plan.topological_sort():  # Respect dependencies
            worker = self.select_worker(task)
            result = worker.execute(task, context=results)
            if not result.success:
                result = self.handle_failure(task, result)
            results[task.id] = result
        return self.synthesize(results)
```

### Handoff Protocol

Between agents, pass:
```json
{
  "task": "what the receiving agent must do",
  "context": "relevant background the receiving agent needs",
  "inputs": "the actual data/artifacts to work with",
  "constraints": "any limits or requirements",
  "expected_output": "what the receiving agent should produce",
  "on_failure": "what to do if the task can't be completed"
}
```

### Parallel Execution

```python
# Good: independent subtasks run concurrently
results = await asyncio.gather(
    agent_a.run(subtask_1),
    agent_b.run(subtask_2),
    agent_c.run(subtask_3),
)

# Bad: running everything sequentially when tasks are independent
# This is the most common performance mistake in multi-agent systems
```

---

## 5. Failure Handling

### Failure Taxonomy

| Failure type | Cause | Handling strategy |
|---|---|---|
| Tool error | External service unavailable | Retry with backoff, fallback tool, surface to human |
| Hallucination | Model confident but wrong | Ground in retrieved context, require citations, self-check |
| Task decomposition failure | Subtasks don't add up to goal | Replanning with different decomposition |
| Context overflow | Task too long for context window | Summarize, chunk, use memory system |
| Infinite loop | Agent keeps retrying same failing step | Max attempts limit, forced escalation |
| Wrong tool | Agent selects inappropriate tool | Better tool descriptions, tool selection validation |

### Circuit Breaker Pattern

```python
class AgentCircuitBreaker:
    def __init__(self, max_attempts=3, max_cost_cents=500):
        self.attempts = 0
        self.total_cost = 0

    def check(self, step_result):
        self.attempts += 1
        self.total_cost += step_result.cost_cents

        if self.attempts > self.max_attempts:
            raise MaxAttemptsExceeded("Agent exceeded max retry attempts")
        if self.total_cost > self.max_cost_cents:
            raise BudgetExceeded(f"Agent exceeded cost budget: ${self.total_cost/100}")
```

---

## 6. Evaluation Framework

Every agent system needs evals before going to production:

### Unit Evals (per agent)
```
For each agent:
- 20+ test cases covering happy path, edge cases, failure cases
- Input/expected output pairs (or rubric for open-ended outputs)
- Automated scoring where possible, human review for complex outputs
```

### Integration Evals (full pipeline)
```
End-to-end task completion rate on representative task set
Time to completion distribution
Cost per task (tokens + tool calls)
Error rate and error classification
Human satisfaction score (where applicable)
```

### Regression Suite
```
After any change (model, prompt, tool, orchestration logic):
Run full eval suite
Compare against baseline
Gate deployment on: completion rate ≥ baseline, cost ≤ 120% of baseline
```

---

## 7. Observability

Every agent action must be logged:

```json
{
  "run_id": "uuid",
  "agent": "agent-name",
  "step": 3,
  "timestamp": "ISO-8601",
  "action": "tool_call",
  "tool": "search_knowledge_base",
  "input": {"query": "..."},
  "output": {"results": [...]},
  "latency_ms": 245,
  "tokens_used": 1200,
  "cost_cents": 1.8,
  "success": true,
  "thought": "I need to find X because Y"
}
```

**Minimum observability stack:**
- Full trace of every tool call with input/output
- Cost per run (tokens + external API calls)
- Step-by-step reasoning visible for debugging
- Human-readable run summary for non-engineers
- Alerting on: error rate spike, cost spike, unusually long runs
