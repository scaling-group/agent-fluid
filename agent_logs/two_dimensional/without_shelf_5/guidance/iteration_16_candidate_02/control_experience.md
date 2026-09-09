# Dogfish L64 Second-Row Wake-Policy Experience

## Persistence contract

This file is mutable optimizer state, not a static task description. Every
successful worker must leave it with at least one material, evidence-backed
lesson added or revised from its assigned parent. Distill sampled solver results
and available inherited logs into a reusable control implication plus an
applicability or falsification boundary. When prior evidence shows no
improvement, record the concrete negative result and what later workers should
avoid or test; do not use a generic no-progress sentence or a cosmetic or
identifier-only change. The current worker's new CFD evaluation occurs after
it exits and therefore becomes evidence for a later sampled worker.

- This is a fresh 40-iteration lineage with no solver or optimizer population
  import. The same guidance is used by matched 2-, 3-, and 4-worker runs.
- The fixed task is `L64`, target `(9,9.5)L`, first-crossing radius `0.75L`,
  inflow `0.18`, held-fish prewarm `200`, released horizon `300`, and actuator
  envelope `45/260/1800` in degree-based units.
- The common naive seed has only a state-feedback oscillator and posterior
  phase lag. It reads joint state but not the task target, flow, force, moment,
  world position, learned route, or any external phase signal, and it is not
  intended to complete the task.
- Inspect the seed rollout, diagnostics, available observations, and inherited
  evidence to determine what capability is missing. Preserve behavior that the
  evidence shows is useful.
- Prefer normalized body-frame feedback changes that are bounded and carry a
  falsifiable expectation. Let evidence choose the observation and mechanism;
  do not hard-code a global-direction command, coordinates, target identity,
  elapsed time, step count, iteration number, or a case-specific route.
- This no-Bookshelf ablation provides no cross-domain research shelf. Derive
  mechanisms only from the task contract, inherited guidance, sampled solver
  results and logs, and current rollout evidence; do not search for or
  reconstruct the omitted shelf.
- Inspect shared prewarm and released keyframe sheets before policy edits, then
  cross-check visual claims against distance progress, local/relative flow,
  force, moment, joint state, previous action, and termination.
- Prefer normalized body-frame feedback. Wake phase, inflow, cylinder layout,
  and target position are intended held-out axes; coordinate memorization is
  not a valid solution.
- Treat every proposed observation as an empirical hypothesis: establish its
  scale, convention, and measurable effect from the current evidence before
  relying on it.
- Positive, bounded body-frame bearing curvature across both joints is the
  finite navigation anchor, but its near-zero gain is non-monotonic. With the
  same `0.55`-period, 28-degree gait, the target-blind seed escaped downward at
  `50.127` with final distance `12.123L`, while gain `1.5` reached at `41.316`
  with mean distance `1.919L`. Three current gain-`1.7` samples exactly
  replicate the visible self-propelled diagonal capture at `39.710`, mean
  distance `1.874L`, relative-crossflow RMS `0.2265`, force/moment RMS
  `38.40/618.59`, power `4092.5`, and joint maxima `0.507/0.528` rad. The
  gain-`1.9` parent/prefill evidence preserves the same route but regresses to
  `40.034/1.901L`, `0.2329`, `41.31/657.28`, `4136.9`, and
  `0.523/0.548` rad. More decisively, the inherited gain-`1.725` interpolation
  regresses further to `40.832/1.915L`, `0.2364`, `42.50/674.61`, `4263.5`,
  and `0.526/0.556` rad; all tested gains touch the same rate/acceleration
  caps. Therefore retain the positive sign, two-joint distribution, vigorous
  gait, 12-degree outer bound, and exact measured gain `1.7`; avoid fitting or
  testing another tiny gain sub-step until a separately bounded axis is
  justified. Do not combine that test with slower propulsion or auxiliary
  velocity/moment terms: the inherited mixed-feedback controller became
  unstable at `2.807`. Exact replication establishes repeatability only for
  the certified wake phase/start pose; the lesson is falsified if another
  exact `1.7` repeat misses the target or materially departs from its recorded
  arrival, distance, crossflow, and load envelope, and it does not establish
  robustness to held-out wake phase or geometry.
- Steering-center allocation is bracketed rather than monotone, and a static
  posterior-minus-anterior peak gap does not predict closed-loop load transfer.
  With the gain-`1.7`, lag-`0.80` controller fixed, fraction `0.35` improves
  the fraction-`0.40` anchor from `39.710/1.874L` arrival/mean distance to
  `38.362/1.812L` and lowers energy, power, crossflow, and both joint peaks,
  although force/moment rise from `38.40/618.59` to `40.73/637.79`. Moving
  either way beyond that point fails: fraction `0.45` slows to
  `43.323/2.025L`, while fraction `0.30` slows to `39.286/1.850L`, raises
  energy/power to `56146/4263`, crossflow/load to `0.2447/42.06/662.67`, and
  posterior peak to `0.583` rad. Retain exact `0.35`; avoid further allocation
  steps or quasi-static peak-balancing claims. This bracket is certified only
  for the sampled wake phase/start pose and is falsified by materially
  different repeated or held-out trajectories.
- Posterior phase lag is also non-monotone. At fraction `0.35`, five inherited
  and current `tail_lag_gain=0.75`, `tail_damping=0.65` rollouts reproduce the
  self-propelled diagonal capture at `38.049`, `1.802L` mean distance,
  `52895/3965` energy/power, and `0.2249/42.01/653.13` crossflow/force/moment.
  Lag `0.80` is modestly slower and costlier, the close `0.7675` interpolation
  regresses to `38.412/1.817L` and `53566/4024`, and `0.70` regresses further
  to `39.605/1.872L`, `55461/4197`, and a `0.570`-rad posterior peak. Retain
  exact `0.75`; do not infer a smooth optimum or test another lag interpolation
  until a distinct mechanism changes the evidence. Replication establishes
  repeatability only at the certified condition, not wake-phase or geometry
  robustness, and all tested lags still touch both rate/acceleration caps.
- Posterior damping presents an asymmetric speed-load tradeoff rather than an
  unloading direction. Relative to damping `0.65`, increasing to `0.675`
  lowers force/moment slightly (`40.10/637.97`) but slows arrival to `41.591`,
  raises mean distance and energy/power to `1.901L` and `58328/4400`, raises
  both joint peaks, and leaves cap contact unchanged. Decreasing to `0.625`
  reaches earlier at `37.339` and lowers energy/power to `52247/3947`, but
  slightly lowers scalar score, raises crossflow from `0.2249` to `0.2461`,
  force/moment from `42.01/653.13` to `47.26/710.38`, and peaks from
  `0.496/0.521` to `0.516/0.565` rad. Avoid extrapolating beyond this bracket
  or calling arrival alone an improvement. At most one interior lower-damping
  test is justified; it must preserve capture and route, beat the `0.65`
  navigation/effort anchor, and remain materially below the `0.625` load and
  excursion envelope. This boundary is specific to the certified wake phase
  and is falsified if an exact repeat departs materially from these envelopes.
- Compare successful, near-miss, and failed trajectories without assuming a
  particular causal decomposition in advance.
- Do not rank successful policies by scalar score alone. Compare semantic
  success, arrival, distance integral, final/mean distance, clearance,
  saturation, switching, effort, and force/moment loads.
- The hard limits are an actuation envelope, not a muscle-power model. Reject
  persistent bang-bang action, implausible load spikes, and fragile success
  even when scalar score improves.
- Record candidate-specific hypotheses under `logs/optimize/`; every successful
  worker must update this file with a durable lesson that should survive across
  later iterations.
