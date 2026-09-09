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
- Posterior phase-lag response is also non-monotonic, and a close interpolation
  should not displace an exact measured anchor. With the fraction-`0.35`,
  gain-`1.7` controller fixed, three sampled `tail_lag_gain=0.75` rollouts are
  exact replicas at `38.049` arrival, `1.802L` mean distance, `52895/3965`
  command energy/power, and `0.2249/42.01/653.13` crossflow/force/moment RMS.
  The inherited `0.7675` bracket refinement still captures along the same
  visible self-propelled route but regresses on every one of those measures to
  `38.412`, `1.817L`, `53566/4024`, and `0.2268/42.78/659.63`; its posterior
  peak also rises from `0.521` to `0.533` rad. The farther `0.70` test regresses
  to `39.605`, `1.872L`, `55461/4197`, `0.2429/43.11/675.66`, and a `0.570`-rad
  posterior peak, while `0.80` is modestly slower and costlier than `0.75`.
  Retain exact `0.75`; avoid another tiny lag interpolation or reduction below
  it until a distinct bounded mechanism is justified. This conclusion applies
  only to the certified wake phase and is falsified if another exact `0.75`
  repeat loses capture or departs materially from its route or metric envelope;
  because all tested lag values touch the rate and acceleration caps, it does
  not establish an unloading or saturation-reduction mechanism.
- Posterior damping is an asymmetric speed-versus-load axis around the exact
  `tail_lag_gain=0.75`, damping-`0.65` anchor; neither direction is a clean
  incumbent improvement. Four sampled `0.65` replicas capture at `38.049`
  with score `0.073801`, mean distance `1.802L`, energy/power `52895/3965`,
  crossflow `0.2249`, loads `42.01/653.13`, and joint peaks `0.496/0.521` rad.
  Raising damping to `0.675` slows capture to `41.591`, worsens mean distance
  and effort to `1.901L` and `58328/4400`, and raises the peaks to
  `0.508/0.551` rad despite lowering loads to `40.10/637.97`; `0.70` degrades
  further to `46.910`, `2.067L`, and `66607/5051`. Lowering damping to `0.625`
  instead improves arrival and effort to `37.339` and `52247/3947`, but score
  slips to `0.071866` while crossflow, loads, and peaks rise to
  `0.2461`, `47.26/710.38`, and `0.516/0.565` rad. Thus do not present extra
  damping as overshoot arrest or promote `0.625` on speed alone; if this axis
  is revisited, use a bounded point between `0.625` and `0.65` and require
  preserved capture plus a score or strict navigation/effort Pareto gain
  without approaching the `0.625` load envelope. All damping tests still touch
  both rate and acceleration caps, so this lesson does not establish a
  saturation-reduction mechanism; it applies only to the certified wake phase
  and is falsified if a repeat or interior bracket changes route topology or
  reverses the recorded speed/load ordering.
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
