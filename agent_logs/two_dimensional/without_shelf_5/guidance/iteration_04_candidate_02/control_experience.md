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
- In this shared-prewarm task, retain the vigorous seed gait and tune the
  evaluated positive body-frame bearing center one bounded axis at a time. The
  target-blind seed's upstream motion ended in a lower-boundary exit at
  `50.127` and final distance `12.123L`, whereas adding bounded bearing feedback
  produced repeatable target capture. With propulsion, curvature sign,
  two-joint centering, and the 12-degree `tanh` bound fixed, raising only
  `steering_gain` from `1.5` to `1.7` improved arrival from `41.316` to `39.710`,
  mean distance from `1.9194L` to `1.8738L`, relative-crossflow RMS from
  `0.2364` to `0.2265`, and force/moment RMS from `41.98/660.23` to
  `38.40/618.59`. A further increase to `1.9` retained the same visible
  turn-then-diagonal capture topology but reversed the trend: arrival rose to
  `40.034`, mean distance to `1.9013L`, crossflow to `0.2329`, and force/moment
  to `41.31/657.28`. Thus the positive mechanism survives, but monotonic gain
  extrapolation does not: bracket locally between `1.7` and `1.9`, restoring
  the evaluated `1.7` value if interpolation cannot beat its distance and load
  metrics, and do not combine this test with weaker propulsion or unscaled
  flow/moment feedback. This bracket is established only for the fixed start
  pose and wake phase and must be revalidated before transfer to held-out flow
  conditions.
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
