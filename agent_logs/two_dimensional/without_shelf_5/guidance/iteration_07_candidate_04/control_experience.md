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
- In this shared-prewarm task, positive bounded body-frame bearing curvature
  across both joints is the finite navigation anchor, but its near-zero gain is
  non-monotonic. With the unchanged `0.55`-period, 28-degree gait, the
  target-blind seed exited downward at `50.127` with final distance `12.123L`;
  gain `1.5` reached at `41.316` with mean distance `1.919L`, and gain `1.7`
  preserved the visible self-propelled turn-then-diagonal route while improving
  arrival/mean distance to `39.710/1.874L`, crossflow RMS to `0.2265`, and
  force/moment RMS to `38.40/618.59`. Gain `1.9` then regressed to
  `40.034/1.901L`, `0.2329`, and `41.31/657.28`, while the closer interpolated
  gain `1.725` regressed further to `40.832/1.915L`, `0.2364`, and
  `42.50/674.61`; both retained capture and the same visible route. Exact
  gain-`1.7` policies subsequently reproduced identical results across four
  current samples, establishing deterministic replay only for this certified
  snapshot. Stop extrapolating or interpolating this gain: hold `1.7`, the
  positive sign, vigorous gait, and 12-degree total-curvature bound while
  testing one orthogonal bounded axis at a time. Falsify any such probe on loss
  of capture, arrival later than `39.710`, mean distance above `1.874L`, or
  increased crossflow/load, and do not combine it with the inherited
  slower mixed flow/moment feedback that became unstable.
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
