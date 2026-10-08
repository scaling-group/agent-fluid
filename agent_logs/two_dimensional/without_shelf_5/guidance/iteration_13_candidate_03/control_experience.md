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
- Steering-center allocation is a coupled navigation/load axis, not a static
  joint-balancing knob. Against two exact fraction-`0.40`, gain-`1.7` replicas
  (`39.710` arrival, `1.874L` mean distance, `54703.2` command energy,
  `0.2265` crossflow, and `0.507/0.528`-rad joint peaks), two fraction-`0.35`
  replicas preserve the visible self-propelled diagonal capture and improve
  arrival to `38.362`, mean distance to `1.812L`, energy to `53487.3`, power
  to `4007.1`, crossflow to `0.2244`, mean x/y speed to
  `-0.2829/-0.1181`, and peaks to `0.494/0.521` rad. However, force/moment RMS
  rise from `38.40/618.59` to `40.73/637.79`, so this is a navigation/effort
  improvement with a load tradeoff, not a uniformly cleaner gait. The inherited
  fraction-`0.45` test gives the opposite boundary: it still captures but
  regresses to `43.323`, `2.025L`, `60174.8`, `0.2456`, `41.96/709.54`, and
  `0.544/0.562` rad. Thus avoid increasing the anterior fraction and distrust
  peak-gap balancing from the quasi-static formula; a further isolated decrease
  is justified only as a bounded continuation and must stop if capture,
  navigation/effort, joint excursions, or the `0.35` load envelope regress.
  These ordered results cover one certified wake phase/start pose and do not
  establish monotonicity outside the tested `0.35`--`0.45` interval or
  robustness to another wake phase, start, or geometry.
- Posterior phase-lag response is locally bracketed and non-monotonic; do not
  treat lower lag as a general improvement direction. Three exact `0.75`
  samples preserve the self-propelled diagonal capture and improve the `0.80`
  anchor from `38.362` to `38.049` arrival, `1.812L` to `1.802L` mean
  distance, `53487.3` to `52895.0` command energy, and `4007.1` to `3965.3`
  power. This is not an unloading result: force/moment RMS rise from
  `40.73/637.79` to `42.01/653.13`, posterior peak remains `0.521` rad, and
  both joints still touch the rate/acceleration caps. More decisively, two
  exact inherited `0.70` replicas keep the same visible safe capture topology
  but regress to `39.605`, `1.872L`, `55461.0`, `4196.9`, crossflow `0.2429`,
  loads `43.11/675.66`, and peaks `0.519/0.570` rad. Therefore avoid further
  extrapolation below `0.75`; at most one isolated interpolation inside the
  measured `0.75`--`0.80` bracket is justified, holding gait, bearing law,
  allocation, damping, and inputs fixed. Reject that interpolation if it loses
  capture, departs from the diagonal corridor, exceeds the `0.75` load
  envelope, or regresses beyond the `0.80` navigation/effort anchors, and then
  restore `0.75` rather than fit another smaller step. This bracket is specific
  to the certified wake phase/start pose and is falsified by materially
  different repeated or held-out trajectories.
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
