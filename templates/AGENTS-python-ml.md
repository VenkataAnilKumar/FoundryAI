# AGENTS.md — Python ML / AI Research Project

Drop this file into your project root as `AGENTS.md`. It tells your AI agents your stack and how to use the FoundryAI team.

> **Works in any AI workspace.** Codex, Cursor, GitHub Copilot, Windsurf, Zed, Amp and most other agents read `AGENTS.md` directly.
> **Claude Code:** add a `CLAUDE.md` containing the single line `@AGENTS.md`.
> **Gemini CLI:** add `"context": { "fileName": ["AGENTS.md", "GEMINI.md"] }` to `.gemini/settings.json`.
> **Chat workspaces** (ChatGPT / Claude / Gemini projects): upload this file as project knowledge.


---

## Project Overview

**Type**: ML / AI research project
**Stack**: Python + PyTorch/HuggingFace + FastAPI + PostgreSQL
**Stage**: [Research / Prototype / Production]
**AI startup type**: [LLM app / copilot · agent product · AI devtools or infra · voice · vision / multimodal · generative media · model training · vertical AI (health / finance / legal / education) · other]
**Team size**: [e.g. 2 founders, 1 engineer]

---

## Tech Stack

```
ML framework:   PyTorch / HuggingFace Transformers / scikit-learn
Experiment tracking: MLflow / Weights & Biases
Data:           pandas, polars, DuckDB, S3
API:            FastAPI, Pydantic
Vector store:   pgvector / Qdrant / Chroma
Deploy:         Docker, Modal / AWS SageMaker / Replicate
Notebooks:      Jupyter, nbstripout for git hygiene
```

---

## Agent Routing

### Research & Experimentation
- Novel technique, paper implementation → `ai-research-engineer`
- Experiment design, A/B testing → `ai-data-scientist`
- Prompt design, LLM optimization → `ai-prompt-engineer`
- Eval framework, benchmarking → `ai-qa-engineer`

### Data & Infrastructure
- Data pipelines, ETL, feature stores → `ai-data-engineer`
- Vector DB design, embedding pipelines → `ai-database-engineer`
- RAG architecture decisions → `ai-architect`
- Model serving, deployment → `ai-devops-engineer`
- GPU infra, model serving (vLLM, TGI) → `ai-platform-engineer`

### API & Integration
- FastAPI endpoints → `ai-backend-engineer`
- API design, versioning → `ai-api-designer`

### Quality & Safety
- Model bias, fairness audits → `ai-responsible-engineer`
- Data privacy, GDPR for training data → `ai-legal-engineer`
- Security for model serving → `ai-security-engineer`

### Documentation
- Model cards, experiment docs → `ai-technical-writer`
- Research write-ups → `ai-technical-writer`

### Everything else
- `/cofounder "describe task"` — routes automatically

---

## Coding Conventions

```
- Python 3.11+, type hints everywhere
- ruff for linting, black for formatting
- All config via Pydantic BaseSettings / hydra
- No hardcoded hyperparameters — all in config files
- Experiments tracked in MLflow/W&B — never just print() results
- Models versioned with DVC or MLflow Model Registry
- No data files in git — use DVC or S3 references
- Notebooks for exploration only — production code in src/
```

## ML-Specific Conventions
```
- Reproducibility: seed everything (random, numpy, torch)
- Datasets versioned — never modify raw data
- Train/val/test split defined once in data/splits/, never recreated
- All preprocessing in sklearn Pipeline or HuggingFace datasets map()
- Evaluation metrics defined before training, not after
- Model checkpoints saved every N epochs to /checkpoints/
- Experiment configs in /configs/, results in /results/
```

## Directory Structure
```
src/
  data/            ← data loading, preprocessing, datasets
  models/          ← model architectures
  training/        ← training loops, loss functions
  evaluation/      ← metrics, eval pipelines
  serving/         ← FastAPI app, inference code
  utils/           ← shared utilities
configs/           ← hydra/yaml experiment configs
notebooks/         ← exploration (not production code)
data/
  raw/             ← never modified (DVC tracked)
  processed/       ← derived, reproducible
  splits/          ← fixed train/val/test splits
experiments/       ← MLflow experiment artifacts
checkpoints/       ← model checkpoints (DVC tracked)
evals/             ← evaluation suite
```

## Common Tasks

```bash
# Setup
pip install -e ".[dev]"
dvc pull                          # Pull data from remote

# Training
python src/training/train.py experiment=my_config
mlflow ui                         # View experiment results

# Evaluation
python evals/run.py --model checkpoints/best_model

# Serving
uvicorn src.serving.app:app --reload   # API on :8000
docker build -t model-api . && docker run -p 8000:8000 model-api

# Code quality
ruff check src/
pytest tests/
```
