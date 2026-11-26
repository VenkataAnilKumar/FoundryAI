# AGENTS.md — Vision & Document AI Product

Drop this file into your project root as `AGENTS.md`. It tells your AI agents your stack and how to use the FoundryAI team.

> **Works in any AI workspace.** Codex, Cursor, GitHub Copilot, Windsurf, Zed, Amp and most other agents read `AGENTS.md` directly.
> **Claude Code:** add a `CLAUDE.md` containing the single line `@AGENTS.md`.
> **Gemini CLI:** add `"context": { "fileName": ["AGENTS.md", "GEMINI.md"] }` to `.gemini/settings.json`.
> **Chat workspaces** (ChatGPT / Claude / Gemini projects): upload this file as project knowledge.

---

## Project Overview

**Type**: Vision / multimodal / document AI
**Stage**: [Idea / MVP / Early customers / PMF / Scale]
**AI startup type**: vision / multimodal
**Team size**: [e.g. 2 founders, 1 engineer]
**Inputs**: [photos / video streams / scanned documents / PDFs]
**Runs on**: [cloud API / own GPU endpoints / edge devices]

---

## Tech Stack

```
Models:       [multimodal model API] for the long tail; [YOLO / SAM / CLIP / OCR] specialists for high-volume paths
Training:     PyTorch, Ultralytics / timm / Hugging Face; experiment tracking [MLflow / W&B]
Labeling:     [Label Studio / CVAT / Roboflow] with model-assisted pre-labels
Serving:      [GPU endpoints / serverless GPU] or edge runtime [ONNX Runtime / TensorRT / Core ML]
Pipeline:     queue-based ingestion, object storage for images, PostgreSQL for results and corrections
Review UI:    human review queue for low-confidence results
```

---

## Agent Routing

- Model approach, labeling loop, evaluation, edge deployment → `ai-vision-engineer`
- VLM API vs trained model decision → `/model-strategy`
- Ingestion and labeling pipelines → `ai-data-engineer`
- Review queue UI → `ai-frontend-engineer`
- GPU serving and cost → `ai-platform-engineer` + `ai-finance-engineer`
- Faces, plates, biometrics, retention → `ai-legal-engineer` + `ai-responsible-engineer`
- Everything else → `/cofounder "describe task"`

---

## Stage Guidance

| Stage | Do | Avoid |
|---|---|---|
| MVP | VLM API + structured output, 200-example eval set, human review on low confidence | Training models before you have an eval set |
| Early customers | Log predictions and corrections, start active-learning labeling, cost per image | Random splits that leak the same customer into train and test |
| Scale | Specialist models for volume, VLM for the long tail, edge where latency/privacy needs it | One global confidence threshold for all customers |

## Key Metrics

- Accuracy on your golden set, by slice (device, lighting, document type, site)
- Field-level extraction accuracy / mAP / precision at target recall
- Human review rate and correction rate
- Latency and cost per image or per page
- Time from correction to model improvement

---

## Conventions

```
- Golden eval set versioned in /evals/golden; never trained on
- Splits by customer/site to prevent leakage
- Every prediction stores model version, confidence and input hash
- Images resized/cropped before inference; originals retained only per retention policy
- Faces and plates blurred unless the product explicitly needs them, with consent
- Model changes ship only if no slice regresses beyond the agreed threshold
```

## Directory Structure

```
data/
  raw/ labeled/      ← tracked with dataset versioning
labeling/            ← guidelines and tool config
models/              ← training configs and scripts
serving/             ← inference service or edge build
evals/
  golden/            ← held-out hard cases
  slices.yaml
review/              ← human review queue
```

## Useful Skills

`/model-strategy` · `/eval` · `/data-pipeline` · `/cost-check` · `/data-rights` · `/experiment`
