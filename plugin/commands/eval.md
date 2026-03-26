---
description: Design an eval suite for any LLM feature — metrics, test cases, pass/fail criteria, regression strategy
argument-hint: Describe the LLM feature, prompt, or agent behavior to evaluate
---

You are an AI evaluation engineer. Design a comprehensive eval suite for the described LLM feature. Be concrete — specify exact test cases, not categories.

## What to Evaluate
$ARGUMENTS

---

## Eval Design Framework

### 1. Define What "Good" Looks Like

Before writing test cases, establish ground truth:
- What is the **ideal output** for a typical input? Write 1-2 examples.
- What are the **hard requirements** (must always be true)?
- What are the **soft preferences** (usually true, but has valid exceptions)?
- What does a **failing output** look like? Give a concrete bad example.

### 2. Evaluation Dimensions

Rate which of these apply and design tests for each:

**Correctness** — Is the answer factually right?
- Does it apply here? Y/N
- How to measure: exact match / LLM-as-judge / human review

**Completeness** — Does it cover all required parts?
- Does it apply here? Y/N
- How to measure: checklist of required elements

**Format compliance** — Does it follow the required output structure?
- Does it apply here? Y/N
- How to measure: schema validation / regex / parser

**Safety** — Does it avoid harmful, biased, or inappropriate outputs?
- Does it apply here? Y/N
- How to measure: classifier / keyword filter / LLM judge

**Instruction following** — Does it do what was asked, not something adjacent?
- Does it apply here? Y/N
- How to measure: LLM-as-judge with rubric

**Robustness** — Does it handle edge cases without breaking?
- Does it apply here? Y/N
- How to measure: adversarial test cases

### 3. Test Suite

Write 15-20 specific test cases across these categories:

#### Happy Path (5 cases)
Typical, well-formed inputs that should produce correct outputs every time.
| Input | Expected Output | Pass Criteria |
|---|---|---|
| | | |

#### Edge Cases (5 cases)
Valid but unusual inputs: very short, very long, unusual formatting, rare scenarios.
| Input | Expected Output | Pass Criteria |
|---|---|---|
| | | |

#### Adversarial Cases (3 cases)
Inputs designed to break the system: prompt injection attempts, misleading inputs, boundary violations.
| Input | Expected Behavior | Pass Criteria |
|---|---|---|
| | | |

#### Regression Cases (3 cases)
Known past failures or behaviors that must remain fixed.
| Input | Expected Output | Why This Matters |
|---|---|---|
| | | |

#### Latency Baseline (1 case)
The typical production input. Used to track response time regressions.
| Input | Expected p50 latency | Expected p95 latency |
|---|---|---|
| | | |

### 4. Scoring Method

Choose the right evaluation approach for each dimension:

| Method | Use When | Tool |
|---|---|---|
| **Exact match** | Output must be a specific value | string comparison |
| **Contains** | Output must include certain elements | regex / substring check |
| **Schema validation** | Output must be valid JSON/structured data | Pydantic / Zod / JSON Schema |
| **LLM-as-judge** | Quality too nuanced for rules | GPT-4 / Claude with rubric |
| **Human review** | High-stakes or subjective outputs | label studio / spreadsheet |
| **RAGAS** | RAG system quality (faithfulness, relevance) | ragas library |

Define a **pass threshold** for the full suite: e.g., "95% of happy path cases pass, 100% of adversarial cases pass."

### 5. Regression Strategy

How to prevent regressions when the prompt or model changes:
- Which test cases are **blocking** (must pass before deploy)?
- Which are **non-blocking** (tracked but won't block deploy)?
- How often should the eval suite run? (every PR / daily / weekly)
- Where should results be stored? (LangSmith / Braintrust / custom DB / CSV)

### 6. Implementation Plan

```python
# Suggested eval structure
eval_suite = {
    "name": "feature_name_eval",
    "version": "1.0.0",
    "cases": [...],           # test cases defined above
    "judges": [...],          # LLM-as-judge prompts
    "thresholds": {
        "happy_path_pass_rate": 0.95,
        "adversarial_pass_rate": 1.0,
        "p95_latency_ms": 2000
    }
}
```

Suggested libraries:
- `pytest` + `anthropic` SDK for basic test harness
- `ragas` for RAG evaluation
- `braintrust` or `langsmith` for tracking over time
- `deepeval` for LLM-as-judge scoring

### 7. Quick Start

The 3 test cases to write first (minimum viable eval):
1. The single most important happy path case
2. The most dangerous adversarial case
3. The most common edge case from production

Ship these before any other eval work. Imperfect evals shipped today beat perfect evals shipped in a month.
