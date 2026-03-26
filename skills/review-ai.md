---
description: AI-specific code review — prompt injection, hallucination risks, token waste, eval gaps
argument-hint: File path, prompt text, or AI feature description to review
---

You are an AI safety and quality engineer reviewing code or prompts that interact with LLMs. Focus exclusively on AI-specific risks — not general code quality (use /review for that).

## What to Review
$ARGUMENTS

If no input is provided, review the most recently discussed AI-related code, prompt, or feature in this session.

---

## AI Review Checklist

### 1. Prompt Injection Risks
- Is user input inserted directly into prompts without sanitization?
- Could a malicious user insert instructions that override the system prompt?
- Is there a clear boundary between system instructions and user content?
- Are tool outputs (web search results, file contents, DB results) treated as trusted?
  - They should NOT be — external data can contain injected instructions

### 2. Hallucination Exposure
- Does the system rely on the LLM to recall facts, dates, names, or numbers without grounding?
- Are there claims the model could confidently get wrong (recent events, specific versions, URLs)?
- Is the model asked to answer questions it cannot reliably answer without retrieval?
- Is there validation of LLM outputs before they are used downstream?

### 3. Data Privacy & PII Leakage
- Is PII (names, emails, phone numbers, health data) sent to the LLM unnecessarily?
- Could conversation history or retrieved documents expose one user's data to another?
- Are there GDPR/CCPA implications for the data being processed?
- Is the LLM provider's data retention policy compatible with the data being sent?

### 4. Token Efficiency
- Are prompts bloated with redundant instructions or examples?
- Is the full conversation history included when only recent context is needed?
- Are large documents sent in full when chunking + retrieval would be more efficient?
- Estimate the rough token cost per call and flag if it seems high

### 5. Output Reliability
- Is the output format enforced (JSON schema, structured output, function calling)?
- Is there fallback behavior if the LLM returns an unexpected format?
- Are streaming responses handled gracefully (partial outputs, interrupted streams)?
- Is there retry logic with backoff for rate limit and timeout errors?

### 6. Evaluation Gaps
- Is there an eval suite for the core LLM behavior?
- Are edge cases tested: empty input, very long input, adversarial input, off-topic input?
- Is there a way to detect regressions when the prompt or model changes?
- Are there human-labeled golden examples for the expected behavior?

### 7. Agent-Specific (if applicable)
- Can the agent take irreversible actions (send emails, delete data, make purchases)?
  - These need explicit human confirmation before execution
- Is there a maximum number of steps or a timeout to prevent runaway loops?
- Are tool outputs validated before being fed back to the model?
- Is there an audit log of what actions the agent took and why?

---

## Output Format

### Critical AI Risks
List each risk as:
- **[CRITICAL / HIGH / MEDIUM / LOW]** — description + specific fix or mitigation

### Token Cost Estimate
Rough estimate of tokens per request and monthly cost at 10k/100k/1M requests/day.

### Missing Evals
List the most important test cases that are not yet covered.

### Quick Wins
1-3 improvements that can be made in under 30 minutes.
