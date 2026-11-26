# AGENTS.md — Robotics & Embodied AI

Drop this file into your project root as `AGENTS.md`. It tells your AI agents your stack and how to use the FoundryAI team.

> **Works in any AI workspace.** Codex, Cursor, GitHub Copilot, Windsurf, Zed, Amp and most other agents read `AGENTS.md` directly.
> **Claude Code:** add a `CLAUDE.md` containing the single line `@AGENTS.md`.
> **Gemini CLI:** add `"context": { "fileName": ["AGENTS.md", "GEMINI.md"] }` to `.gemini/settings.json`.
> **Chat workspaces** (ChatGPT / Claude / Gemini projects): upload this file as project knowledge.

---

## Project Overview

**Type**: Robotics / embodied AI
**Stage**: [Prototype / Pilot customers / Scale]
**AI startup type**: robotics
**Team size**: [e.g. 3 founders, 2 engineers]
**Robot**: [arm / mobile base / humanoid / drone] — [hardware and sensors]
**Task**: [e.g. bin picking in warehouses]

---

## Tech Stack

```
Middleware:   ROS 2 [distro], DDS tuned for the network
Perception:   cameras/depth/LiDAR → detection, pose, segmentation models
Control:      MoveIt 2 / Nav2 for classical planning; learned policies where they win
Learning:     teleoperation data collection, imitation learning / VLA fine-tuning (e.g. LeRobot, Isaac Lab)
Simulation:   [Isaac Sim / MuJoCo / Gazebo] with a digital twin of the work cell
Compute:      onboard [Jetson-class / x86 + GPU]; cloud for training and fleet monitoring
Fleet:        OTA updates, remote monitoring, teleop fallback
```

---

## Agent Routing

- Robot architecture, learning, sim-to-real, safety → `ai-robotics-engineer`
- Perception models → `ai-vision-engineer`
- Policy training at scale and compute → `ai-model-training-engineer` + `ai-platform-engineer`
- Fleet monitoring, incidents, on-call → `site-reliability-engineer`
- Cloud backend and dashboards → `ai-backend-engineer`, `ai-frontend-engineer`
- Safety standards, liability, customer contracts → `ai-legal-engineer`
- Everything else → `/cofounder "describe task"`

---

## Stage Guidance

| Stage | Do | Avoid |
|---|---|---|
| Prototype | One task, one environment, teleop fallback, measure success and interventions | Generalist ambitions before one task works reliably |
| Pilot customers | Data flywheel from deployments, simulation regression suite, written safety case | Shipping policy changes without sim regression |
| Scale | Fleet ops, OTA, hardware cost-down, certification, robot-hour unit economics | Unmonitored autonomy in shared human spaces |

## Key Metrics

- Task success rate and cycle time
- Interventions per hour (remote or on-site)
- Mean time between failures; safety incidents (target: zero)
- Sim-to-real gap: success in sim vs real on the same scenarios
- Cost per robot-hour vs value delivered per hour

---

## Conventions

```
- Safety controller and e-stop paths are deterministic and independent of learned components
- Learned policies run inside a monitored safety envelope (speed, force, workspace limits)
- Every policy release passes the simulation scenario suite and a staged real-world test
- All field runs logged as episodes (sensors, actions, outcomes) for the data flywheel
- Control loop timing budgets documented and monitored
- Teleoperation fallback available for every deployed robot
```

## Directory Structure

```
ros2_ws/src/         ← ROS 2 packages (drivers, perception, planning, control)
policies/            ← learned policy training and export
sim/                 ← simulation assets, scenarios, digital twin
data/episodes/       ← teleop and field episodes
safety/              ← safety case, hazard analysis, limits config
fleet/               ← OTA, monitoring, teleop services
```

## Useful Skills

`/model-strategy` · `/eval` · `/experiment` · `/spec` · `/incident` · `/release-plan`
