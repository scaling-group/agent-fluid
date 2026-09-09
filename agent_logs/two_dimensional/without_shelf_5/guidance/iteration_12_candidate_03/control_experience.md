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
- A posterior-minus-anterior peak-angle gap is not evidence that shifting the
  steering center anteriorly will balance the coupled gait. Against four exact
  fraction-`0.40` gain-`1.7` replicas (`39.710` arrival, `1.874L` mean
  distance, `0.507/0.528` rad joint peaks), the isolated fraction-`0.45` test
  still captured but slowed to `43.323`, raised mean distance to `2.025L`,
  raised both peaks to `0.544/0.562` rad, weakened mean x/y speed, and raised
  crossflow, force/moment, power, and command energy. Avoid increasing the
  anterior fraction or predicting load transfer from the quasi-static formula
  alone. If distribution is revisited, test the opposite bounded direction as
  a separate axis and require preserved capture plus improved navigation and
  load metrics; this one wake phase does not establish monotonicity or
  robustness to another start, wake phase, or geometry.
- Posterior phase lag has one reproducible beneficial step but no established
  monotone trend. At the fraction-`0.35`, gain-`1.7` anchor, three exact
  `tail_lag_gain=0.75` samples preserve the visible self-propelled diagonal
  capture and improve on the sampled `0.80` result in arrival
  (`38.049` versus `38.362`), mean distance (`1.802L` versus `1.812L`),
  command energy (`52895` versus `53487`), and power (`3965` versus `4007`).
  The inherited unloading hypothesis is falsified: posterior peak remains
  `0.521` rad, both policies touch the same rate/acceleration caps, and
  force/moment RMS rise from `40.73/637.79` to `42.01/653.13`. Treat `0.75`
  as the measured navigation/effort anchor, not a load repair. A lower-lag
  bracket extension is informative only as an isolated test that preserves
  capture and the route while improving arrival or effort without exceeding
  the `0.2249/42.01/653.13` crossflow/load envelope; stop on reversal rather
  than extrapolating again. This boundary is specific to the certified wake
  phase/start pose and is falsified by non-replication or held-out failure.
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
