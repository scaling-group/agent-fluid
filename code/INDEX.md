# Code guide

| Directory | Purpose |
| --- | --- |
| [eve/2d/](eve/2d/) · [eve/3d/](eve/3d/) | EvE agent evolution framework, experiment configurations, prompts and initial guidance |
| [simulation/2d/](simulation/2d/) | 2D swimmer geometry, dynamics and CFD evaluation |
| [simulation/3d/experiments/](simulation/3d/experiments/) | 3D swimmer simulation, moving-window evaluation and flow rendering; experiment settings are in [configs/](simulation/3d/configs/) |
| [simulation/validation/](simulation/validation/) | Foil, cylinder and moving-window validation experiments |
| [generalization/](generalization/) | Fixed policies and configurations for the thirteen generalization conditions |
| [drl/](drl/) | Behavior cloning, PPO training and policy inference |
| [reproduction/](reproduction/) | Extract plotting inputs from experimental records and check numerical consistency |
| [plotting/](plotting/) | Generate manuscript panels and tables from `derived_data/` |

For extraction and plotting commands, see the [main README](../README.md#reproduce-the-results).
Simulation setup is described in the [CFD validation guide](simulation/validation/README.md);
fixed-policy evaluations are described in the [generalization guide](generalization/README.md).
DRL entry points and dependencies are listed in [drl/index.json](drl/index.json).
Each runtime includes its own dependency files.

The [2D](../agent_logs/two_dimensional/) and [3D](../agent_logs/three_dimensional/)
run archives contain `policies/`, `guidance/` and `agent_calls/`.
Policy scores are grouped by dimension in [raw_data/policy_scores/](../raw_data/policy_scores/).
