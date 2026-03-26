---
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

Current Claude pricing (approximate — verify at anthropic.com/pricing):

| Model | Input (per 1M tokens) | Output (per 1M tokens) |
|---|---|---|
| claude-opus-4-6 | ~$15 | ~$75 |
| claude-sonnet-4-6 | ~$3 | ~$15 |
| claude-haiku-4-5 | ~$0.25 | ~$1.25 |

**Cost per request** = (input_tokens / 1,000,000 × input_price) + (output_tokens / 1,000,000 × output_price)

**Monthly cost at different volumes:**
| Volume | Daily Requests | Monthly Cost (Sonnet) | Monthly Cost (Opus) |
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
- Is this task actually complex enough to require Opus? Could Sonnet handle it?
- Could a simple routing/classification step use Haiku, then escalate to Sonnet only when needed?
- **Potential saving**: if moving from Opus → Sonnet: ~5× reduction

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
| Right-size model (Opus → Sonnet) | ~$X/month | Low | P1 |
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

**Rule of thumb**: If you haven't set a `max_tokens` limit and you haven't tried Sonnet where you're using Opus, you have at least a 5× cost reduction available before doing anything clever.
