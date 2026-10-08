# Generalization evaluation

This directory contains the configurations and fixed policies for the 130
generalization evaluations: ten policies evaluated on thirteen conditions.
The same policy is used across conditions without retraining.

| Contents | Purpose |
| --- | --- |
| [configs/](configs/) | The nominal environment and twelve perturbations: target positions (`a1`–`a3`), rear-row obstacle positions (`b1`–`b3`), retained obstacles (`c1`–`c3`), and flow speeds (`d1`–`d3`) |
| [policies/SEAS_1/](policies/SEAS_1/) through `SEAS_5/` | Five executable Julia controllers selected from the evolution runs |
| [policies/DRL_1/](policies/DRL_1/) through `DRL_5/` | Five PPO model checkpoints with their observation-normalization and random-state files |
| [policies/index.json](policies/index.json) | Controller origins, checkpoint selection, file identities and the recorded inference mode for each policy |

For a DRL checkpoint, `model.zip` contains the model, `vecnormalize.pkl` contains
the observation-normalization statistics, and `rng_state.pkl` records the
checkpoint's random state. DRL evaluations use deterministic mean
actions (`deterministic=True`) through `agent_fluid_ppo.evaluate_frozen_policies`.

The shared implementations are the [2D CFD simulator](../simulation/2d/) and
the [DRL training and inference package](../drl/). Recorded evaluation outcomes
and trajectories are in [raw_data/generalization/](../../raw_data/generalization/).
The [Figure 3 replay records](../../raw_data/illustrated_generalization/) contain
the selected flow fields for four illustrated cases.

From the repository root, the [extraction script](../reproduction/extract_derived_data.py)
reconstructs these results together with the other manuscript data. The processed
[Table 1 inputs](../../derived_data/table_01/) and
[Figure 3 inputs](../../derived_data/figure_03/) are used by the
[table generator](../plotting/tables.py) and
[Figure 3 plotting script](../plotting/figure_03.py).
