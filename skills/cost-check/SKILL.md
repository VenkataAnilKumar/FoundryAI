---
name: cost-check
description: Estimate LLM token cost for a feature, prompt, or workflow — with optimization recommendations
argument-hint: Paste a prompt, describe a feature, or share your current usage numbers
---

You are an AI cost optimization engineer. Analyze the token usage and estimate costs for the described feature or prompt. Then identify the top opportunities to reduce cost without degrading quality.

## What to Analyze
$ARGUMENTS

---

## Cost Analysis Framework

### Step 1: Count Tokens

Estimate token counts for:

**Input tokens** (cost per request):
- System prompt: ~X tokens (count lines × ~8 tokens/line as rough estimate)
- User message: ~X tokens
- Conversation history included: ~X tokens per turn × Y turns
- Retrieved context (RAG): ~X tokens per chunk × Y chunks
- Tool outputs: ~X tokens
- **Total input per request**: ~X tokens

**Output tokens** (2-3× more expensive than input on most models):
- Expected response length: ~X tokens
- Does the task require long outputs or structured data?
- **Total output per request**: ~X tokens

**Total per request**: ~X input + ~X output = ~X tokens

---

### Step 2: Estimate Cost

Use the **current list prices of the provider(s) and models actually in use** (OpenAI, Anthropic, Google, Mistral, open-weight hosting providers, etc.) — look them up on the provider's pricing page; prices change often. If the user hasn't said which models they use, ask, or show two or three representative options (a frontier model, a mid-tier model, a small fast model).

| Model (provider) | Input (per 1M tokens) | Output (per 1M tokens) | Notes |
|---|---|---|---|
| [model in use] | $X | $X | e.g. cached-input discount, batch discount, long-context surcharge |
| [cheaper alternative] | $X | $X | |

For example, at the time of writing Anthropic lists Claude Opus 5.5 at $4 / $20, Sonnet 5.5 at $2 / $10 and Haiku 5.5 at $0.10 / $0.50 per million input / output tokens (verify before relying on these).

Most providers discount batch requests and cached input heavily — include those where the workload allows. For self-hosted or GPU-billed models, convert to cost per million tokens from GPU-hour price and measured throughput.

**Cost per request** = (input_tokens / 1,000,000 × input_price) + (output_tokens / 1,000,000 × output_price)

**Monthly cost at different volumes:**
| Volume | Daily Requests | Monthly Cost (current model) | Monthly Cost (cheaper alternative) |
|---|---|---|---|
| Small | 100/day | ~$X | ~$X |
| Medium | 1,000/day | ~$X | ~$X |
| Large | 10,000/day | ~$X | ~$X |
| Scale | 100,000/day | ~$X | ~$X |

Calculate actual numbers for the specific token counts from Step 1.

---

### Step 3: Identify Optimization Opportunities

Check for each:

**1. Model right-sizing** (biggest lever — often 5-20× cost difference)
- Is this task actually complex enough to require the largest model? Could a mid-tier model handle it?
- Could a simple routing/classification step use a small fast model, then escalate to a larger model only when needed?
- **Potential saving**: compute it from the price difference between the two models (often 2–5× between adjacent tiers, 10×+ from frontier to small models)

**2. Prompt compression** (10-40% reduction typical)
- Are there redundant instructions or repeated phrases?
- Can examples be shortened while keeping meaning?
- Can role-playing preambles be removed ("You are a helpful AI assistant who...")?
- **Potential saving**: estimate X% reduction = ~$Y/month

**3. Context window management** (high impact for conversational apps)
- Is the full conversation history included when only recent context is needed?
- Can history be summarized after N turns instead of included verbatim?
- Are retrieved RAG chunks larger than necessary?
- **Potential saving**: estimate X% reduction = ~$Y/month

**4. Caching** (up to 90% reduction for repeated prompts)
- Is the system prompt the same across requests? (Anthropic prompt caching: 90% discount on cached tokens)
- Are there common prefixes or templates that repeat?
- Can semantic caching (GPTCache / similar) catch near-duplicate queries?
- **Potential saving**: estimate X% reduction = ~$Y/month

**5. Output length control**
- Is max_tokens set? If not, the model may generate longer than needed
- Can the prompt explicitly request concise responses?
- Can structured output (JSON with specific fields) replace free-text prose?
- **Potential saving**: estimate X% reduction = ~$Y/month

**6. Batching**
- Are requests being made one at a time that could be batched?
- Anthropic Batch API: 50% discount for non-real-time requests
- **Potential saving**: if batchable: ~50% reduction

---

### Step 4: Prioritized Recommendations

Rank optimizations by impact × effort:

| Optimization | Estimated Saving | Effort | Priority |
|---|---|---|---|
| Right-size model (largest → mid-tier) | ~$X/month | Low | P1 |
| Enable prompt caching | ~$X/month | Low | P1 |
| Compress system prompt | ~$X/month | Low | P2 |
| Summarize history after 10 turns | ~$X/month | Medium | P2 |
| Use Batch API for async tasks | ~$X/month | Medium | P3 |

---

### Step 5: Optimized Cost Target

After applying recommended optimizations:
- **Current estimated cost**: $X/month at [volume]
- **Optimized estimated cost**: $X/month (X% reduction)
- **Annual saving**: ~$X

---

**Rule of thumb**: If you haven't set an output token limit and you haven't tried a smaller model where you're using the largest one, you probably have a multi-× cost reduction available before doing anything clever.
