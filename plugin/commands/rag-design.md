---
description: Design a RAG system — chunking strategy, embedding model, vector DB selection, retrieval approach
argument-hint: Describe your use case, document types, and scale requirements
---

You are an AI architect designing a RAG (Retrieval-Augmented Generation) system. Make concrete recommendations based on the specific use case — no generic advice.

## Use Case
$ARGUMENTS

---

## RAG Design Framework

### Step 1: Understand the Requirements

Before recommending anything, clarify:

- **Document types**: PDFs, web pages, code, structured data, mixed?
- **Corpus size**: < 1k docs / 1k-100k docs / 100k-10M docs / > 10M docs
- **Query types**: Factual lookup / semantic search / multi-hop reasoning / summarization?
- **Latency budget**: < 200ms / < 1s / < 5s / batch OK?
- **Update frequency**: Static corpus / daily updates / real-time ingestion?
- **Languages**: English only / multilingual?
- **Access control**: Single-tenant / multi-tenant (user can only see their data)?

---

### Step 2: Chunking Strategy

The most underestimated part of RAG. Wrong chunking kills retrieval quality.

**Choose a chunking approach:**

| Strategy | Use When | Chunk Size |
|---|---|---|
| **Fixed size** | Homogeneous documents, simple content | 256-512 tokens |
| **Sentence/paragraph** | Natural text, articles, documentation | Sentence boundaries |
| **Semantic** | Mixed content, want coherent chunks | ~300-500 tokens |
| **Recursive** | Code, structured documents | By structure (function, section) |
| **Parent-child** | Need both precision and context | Small chunks + larger parent |
| **Document-level** | Short documents, emails, tickets | Entire document |

**Overlap**: Always add 10-20% overlap between chunks to prevent context splitting at boundaries.

**Metadata to attach to every chunk:**
- `document_id` — for filtering and access control
- `chunk_index` — for ordering retrieved chunks
- `source_url` or `file_path` — for citations
- `created_at` / `updated_at` — for freshness filtering
- `section_title` — improves retrieval relevance

**Recommendation for this use case**: [specific recommendation with rationale]

---

### Step 3: Embedding Model Selection

| Model | Dimensions | Best For | Cost |
|---|---|---|---|
| `text-embedding-3-small` (OpenAI) | 1536 | General English, fast, cheap | $0.02/1M tokens |
| `text-embedding-3-large` (OpenAI) | 3072 | High accuracy, English | $0.13/1M tokens |
| `voyage-3` (Voyage AI) | 1024 | Best-in-class retrieval quality | ~$0.06/1M tokens |
| `voyage-code-3` (Voyage AI) | 1024 | Code search | ~$0.06/1M tokens |
| `nomic-embed-text` (open source) | 768 | Self-hosted, good quality | Free |
| `mxbai-embed-large` (open source) | 1024 | Self-hosted, multilingual | Free |
| Cohere `embed-v3` | 1024 | Multilingual, reranking | ~$0.10/1M tokens |

**Recommendation for this use case**: [specific model + rationale based on requirements]

---

### Step 4: Vector Database Selection

| Database | Best For | Deployment | Standout Feature |
|---|---|---|---|
| **pgvector** | < 5M vectors, PostgreSQL users | Your existing Postgres | Zero new infra, SQL joins |
| **Qdrant** | 5M–500M vectors, self-hosted | Docker / cloud | Best OSS performance |
| **Pinecone** | Fully managed, any scale | Serverless | Zero-ops, auto-scaling |
| **Weaviate** | Hybrid search, multi-modal | Cloud / self-hosted | Built-in BM25 + vector |
| **Milvus** | > 100M vectors, high throughput | Kubernetes | Massive scale |
| **Chroma** | Prototyping, local dev | In-process | Simplest to start with |
| **LanceDB** | Columnar storage, ML workflows | Embedded | Works with Pandas |

**Decision tree:**
- Already using PostgreSQL? → **pgvector** first
- Need fully managed, don't want ops? → **Pinecone**
- Self-hosted, serious scale? → **Qdrant**
- Prototyping? → **Chroma**
- Need hybrid (keyword + vector) out of the box? → **Weaviate**

**Recommendation for this use case**: [specific DB + rationale]

---

### Step 5: Retrieval Strategy

Don't use naive top-k vector search in production.

**Hybrid retrieval** (recommended for most cases):
- Vector search (semantic) + BM25/keyword search, merged with RRF (Reciprocal Rank Fusion)
- Catches both semantic matches and exact keyword matches
- ~20-30% better recall than vector-only in most benchmarks

**Reranking** (recommended for accuracy-critical cases):
- After retrieving top-20 candidates, rerank with a cross-encoder
- Models: `cross-encoder/ms-marco-MiniLM-L-6-v2` (OSS) or Cohere Rerank API
- Adds ~100-300ms latency but significantly improves top-3 precision

**Multi-vector / late interaction** (ColBERT):
- Better quality than bi-encoders, works well for technical content
- Use if accuracy > speed is the priority

**Query expansion**:
- Generate 3-5 alternative phrasings of the user query before retrieval
- Especially useful for vague or short queries
- Small prompt + cheap model (Haiku) to generate variants

**Retrieval parameters:**
- Top-k: 10-20 candidates before reranking, 3-5 final chunks to LLM
- Score threshold: filter out chunks below 0.7 cosine similarity
- Max context: don't exceed 60-70% of model's context window with retrieved chunks

---

### Step 6: Complete Architecture

```
User Query
    ↓
[Query preprocessing]
  - Clean and normalize
  - Detect language
  - Expand query (optional)
    ↓
[Hybrid Retrieval]
  - Vector search (top-20)
  - BM25 search (top-20)
  - RRF merge
    ↓
[Reranking] (optional, +100ms)
  - Cross-encoder rerank
  - Return top-5
    ↓
[Context assembly]
  - Format chunks with metadata
  - Add citations
  - Check context window budget
    ↓
[LLM Generation]
  - System prompt + context + query
  - Return answer with source references
    ↓
[Post-processing]
  - Validate answer is grounded in context
  - Format response
  - Log for eval
```

---

### Step 7: Evaluation Setup

Before deploying, set up these RAGAS metrics:
- **Faithfulness**: Is the answer grounded in the retrieved context?
- **Answer relevancy**: Does the answer address the question?
- **Context precision**: Are retrieved chunks relevant to the query?
- **Context recall**: Are all relevant chunks retrieved?

Target: Faithfulness > 0.85, Answer Relevancy > 0.80 before production.

---

### Summary: Recommended Stack for This Use Case

| Component | Recommendation | Rationale |
|---|---|---|
| Chunking | | |
| Embedding model | | |
| Vector database | | |
| Retrieval strategy | | |
| Reranking | | |
| Eval framework | RAGAS | Industry standard |
