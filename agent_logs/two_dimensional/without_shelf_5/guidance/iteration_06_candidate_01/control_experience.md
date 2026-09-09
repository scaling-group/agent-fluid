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
  finite navigation anchor, but its near-zero gain is locally non-monotonic.
  With the same `0.55`-period, 28-degree gait, the target-blind seed escaped
  downward at `50.127` with final distance `12.123L`, while gain `1.5` reached
  at `41.316` with mean distance `1.919L`. Gain `1.7` preserved the visible
  self-propelled diagonal route and improved arrival/mean distance to
  `39.710/1.874L`, relative-crossflow RMS to `0.2265`, and force/moment RMS to
  `38.40/618.59`. Three separately sampled exact gain-`1.7` evaluations now
  reproduce every reported navigation, effort, flow, and load metric exactly,
  confirming deterministic replay of that anchor at the certified snapshot;
  this is an implementation baseline, not three independent wake-phase tests.
  Three gain-`1.9` replicas captured along the same route but regressed to
  `40.034/1.901L`, `0.2329`, and `41.31/657.28`; an inherited gain-`1.725`
  interpolation regressed further to `40.832/1.915L`, `0.2364`, and
  `42.50/674.61`, with power proxy `4263.51` versus `4092.50` at `1.7`. Its
  maximum joint angles also rose to `0.526/0.556` from `0.507/0.528` rad,
  while both cases touched the same rate/acceleration caps. Therefore retain
  the positive sign, two-joint distribution, vigorous gait, 12-degree outer
  bound, and exact measured gain `1.7`; do not spend another candidate on a
  tiny static-gain fit or another identical common-snapshot replay. The repeat
  boundary now supports testing one separately bounded, target-relative
  temporal axis whose zero-rate limit recovers the static anchor, but that test
  must not be combined with slower propulsion or auxiliary flow/moment terms:
  the inherited mixed-feedback slow controller became unstable at `2.807`.
  Restore the static anchor if the temporal term loses capture or exceeds the
  `39.710` arrival, `1.874L` mean distance, or recorded crossflow/load values.
  Generalization beyond the common wake phase/start pose remains unproven and
  requires a changed wake phase or pose, not another identical replay.
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
