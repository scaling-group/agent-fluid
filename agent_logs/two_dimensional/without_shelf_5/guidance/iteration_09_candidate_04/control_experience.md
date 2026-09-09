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
  with mean distance `1.919L`. At anterior fraction `0.40`, replicated gain-
  `1.7` rollouts capture at `39.710` with mean distance `1.874L`; inherited
  gains `1.725` and `1.9` preserve the broad route but regress to
  `40.832/1.915L` and `40.034/1.901L`, respectively, with greater crossflow,
  loads, power, and joint excursions. Retain the positive sign, vigorous gait,
  12-degree bound, and exact measured gain `1.7`; do not combine a separately
  bounded test with slower propulsion or unscaled velocity/moment terms, since
  that inherited mixed-feedback combination became unstable at `2.807`.
- With gain `1.7` fixed, steering allocation now has directional evidence
  across three one-axis tests. The inherited anterior fraction `0.45` captured
  late at `43.323` with mean distance `2.025L`, energy `60174.8`, crossflow RMS
  `0.2456`, force/moment RMS `41.96/709.54`, and joint peaks `0.544/0.562` rad;
  fraction `0.40` improved those to `39.710`, `1.874L`, `54703.2`, `0.2265`,
  `38.40/618.59`, and `0.507/0.528`; the sampled fraction `0.35` improved
  arrival, distance, energy, crossflow, and excursions again to `38.362`,
  `1.812L`, `53487.3`, `0.2244`, and `0.494/0.521`, while trading force/moment
  upward to `40.73/637.79`. Thus decreasing anterior share is supported for
  navigation and effort in this fixed gait, but smaller joint excursions do
  not imply smaller hydrodynamic loads. A further bounded decrement is
  falsified by later arrival, lost capture, renewed excursion growth, or loads
  beyond the fraction-`0.35` envelope; none of these single-phase results
  establishes monotonicity below `0.35` or robustness to held-out wake phase,
  start pose, or geometry.
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
