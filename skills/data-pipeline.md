---
description: Design data pipelines — ETL/ELT, streaming vs batch, data warehouse, quality gates, lineage
argument-hint: Describe the data you need to move, transform, or serve
---

You are a data engineer. Design reliable, maintainable data pipelines. Optimize for correctness first, performance second, and elegance last.

## Pipeline to Design
$ARGUMENTS

---

## Step 1: Classify the Pipeline

| Pattern | Latency | Use case |
|---|---|---|
| **Batch ETL** | Minutes–hours | Daily aggregations, reports, ML feature prep |
| **Micro-batch** | Seconds–minutes | Near-real-time dashboards, delayed alerting |
| **Streaming** | Milliseconds–seconds | Real-time features, fraud detection, live analytics |
| **ELT** | Variable | Load raw first, transform in warehouse (Snowflake, BigQuery, Redshift) |
| **Reverse ETL** | Minutes | Push warehouse data back to operational systems (CRM, Salesforce) |

**Decision rule:** Use batch unless you have a real use case for freshness <5 minutes. Streaming is 5–10x harder to operate than batch.

---

## 2. Source Systems

For each data source:

| Source | Type | Volume | Freshness SLA | Schema change risk |
|---|---|---|---|---|
| [Source 1] | DB / API / file / stream | rows/day | | High / Low |
| [Source 2] | | | | |

**Extraction strategy per source type:**
- **Relational DB:** Change Data Capture (CDC) with Debezium/Airbyte — avoids full table scans
- **REST API:** Paginated pull with cursor-based incremental sync
- **Event stream:** Kafka/Kinesis consumer with offset management
- **Files:** Object storage event notifications trigger ingestion (don't poll)
- **SaaS tools:** Managed connectors (Fivetran, Airbyte) — don't build what you can buy

---

## 3. Transformation Design

### Transformation Layers (Medallion Architecture)

```
Raw / Bronze    ← Exact copy of source, no transformation, schema preserved
     ↓
Cleaned / Silver ← Deduplicated, nulls handled, types cast, PII masked
     ↓
Aggregated / Gold ← Business logic applied, ready for analytics/ML/product
```

**Rule:** Never apply business logic in Bronze. Never expose Bronze directly to analytics.

### Transformation Checklist
- [ ] **Idempotency:** Running the pipeline twice produces the same result (no duplicate rows)
- [ ] **Backfill support:** Can replay historical data without side effects
- [ ] **Null handling:** Explicit decision for every nullable field (drop, fill, propagate)
- [ ] **Deduplication:** Unique key defined; last-write-wins or first-write-wins documented
- [ ] **Type safety:** No implicit type coercion — all casts are explicit
- [ ] **Business logic documented:** Complex transformations have comments explaining the why

### SQL / dbt Conventions
```sql
-- Bad: logic buried in a single 300-line query
-- Good: CTEs that each do one thing

with source as (
    select * from raw.events
),

cleaned as (
    select
        event_id,
        user_id,
        event_type,
        occurred_at::timestamp as occurred_at,
        -- Remove bot traffic
        case when user_agent ilike '%bot%' then null else session_id end as session_id
    from source
    where event_id is not null
),

final as (
    select * from cleaned
)

select * from final
```

---

## 4. Data Quality Gates

Every pipeline stage should have quality checks **before** data is promoted:

```python
# Quality checks to implement at each stage
checks = {
    "row_count": "must be > 0, must not drop > 20% from previous run",
    "null_rate": "primary key: 0%. Critical fields: < 1%",
    "uniqueness": "primary key must be unique",
    "freshness": "max(event_time) must be within SLA of pipeline trigger time",
    "distribution": "key metric distributions must not shift > 2 std devs",
    "referential_integrity": "all foreign keys resolve in dimension tables",
    "business_rules": "e.g., order_total >= 0, age between 0 and 120",
}
```

**Data quality tools:** Great Expectations / dbt tests / Soda / Monte Carlo

**On failure:**
- [ ] Block pipeline from promoting bad data downstream
- [ ] Alert data team (Slack, PagerDuty) with details of which check failed
- [ ] Log failure with sample of failing rows (redact PII before logging)

---

## 5. Schema Management

- [ ] **Schema registry:** All streaming schemas registered (Confluent Schema Registry or equivalent)
- [ ] **Schema evolution policy:**
  - Adding a nullable column → backward compatible, OK
  - Removing a column → breaking change, requires migration and consumer updates
  - Renaming a column → breaking change — use add + deprecate + remove pattern
- [ ] **Schema drift detection:** Alert when source schema changes unexpectedly
- [ ] **Contracts:** Source team notifies data team of schema changes ≥2 weeks in advance

---

## 6. Orchestration

**Tool selection:**
| Tool | Best for |
|---|---|
| **Airflow** | Complex DAGs, existing Python ecosystem, on-prem |
| **Prefect** | Modern Python, easier local dev, cloud or self-hosted |
| **Dagster** | Asset-oriented, excellent observability, software-first |
| **dbt Cloud** | SQL-first transformations with scheduling |
| **Managed (MWAA, Cloud Composer)** | Don't want to operate Airflow yourself |

**DAG design principles:**
- One task = one logical unit of work
- Tasks are idempotent
- Dependencies are explicit (never implicit time coupling)
- Retries with backoff on transient failures
- Timeout set on every task

---

## 7. Data Lineage & Observability

**Every pipeline must have:**
- [ ] End-to-end lineage: which source table → which transform → which output table
- [ ] Data freshness monitoring: alert if data is more than X hours stale
- [ ] Volume anomaly detection: alert if row count is significantly above/below baseline
- [ ] Pipeline duration tracking: alert if runtime significantly exceeds normal
- [ ] Cost tracking: compute cost per pipeline run logged and trended

**Lineage tools:** dbt's built-in lineage, OpenLineage/Marquez, DataHub, Atlan

---

## 8. Streaming Pipeline Design (if applicable)

```
Producer → Kafka/Kinesis topic → Consumer group → Processor → Sink

Key decisions:
1. Partition key: determines ordering guarantee (order guaranteed within partition only)
2. Consumer group: each group reads independently — scale consumers per group
3. Exactly-once semantics: configure idempotent producer + transactional consumer
4. Retention: how long does Kafka retain messages? (default 7 days — set explicitly)
5. Backpressure: consumer must handle slower processing than producer rate

Dead letter queue (DLQ):
- Messages that fail processing 3x → routed to DLQ
- DLQ is monitored and retried manually or on a schedule
- Never silently drop failed messages
```

---

## 9. Cost Optimization

| Lever | Potential saving |
|---|---|
| Partition pruning (query only relevant partitions) | 50–90% query cost reduction |
| Columnar storage (Parquet/ORC vs. CSV) | 70% storage, 10x query speed |
| Compression (Snappy/Zstd) | 60–80% storage reduction |
| Incremental loads (CDC vs. full table scans) | Proportional to change rate |
| Clustering/Z-ordering on filter columns | 20–50% query cost |
| Autoscaling compute (scale down when idle) | Up to 80% compute cost |
| Data lifecycle (archive or delete old data) | Storage cost over time |
