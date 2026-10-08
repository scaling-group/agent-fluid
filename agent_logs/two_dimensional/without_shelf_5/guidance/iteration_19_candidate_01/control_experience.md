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
  posterior-minus-anterior peak-angle gap does not predict closed-loop load
  transfer. Against four exact fraction-`0.40`, gain-`1.7` replicas (`39.710`
  arrival, `1.874L` mean distance), fraction `0.45` regressed to
  `43.323/2.025L` and raised both joint peaks, crossflow, loads, power, and
  energy. Three exact fraction-`0.35` samples improved arrival/mean distance to
  `38.362/1.812L`, energy to `53487.3`, power to `4007.1`, crossflow to
  `0.2244`, and joint peaks to `0.494/0.521` rad, though force/moment rose from
  `38.40/618.59` to `40.73/637.79`. Continuing to fraction `0.30` failed:
  arrival/mean distance regressed to `39.286/1.850L`, energy/power to
  `56145.5/4263.2`, crossflow and force/moment to `0.2447/42.06/662.67`, and
  the posterior peak to `0.583` rad. Retain `0.35` as the measured allocation
  anchor; avoid further allocation steps or quasi-static peak-balancing
  claims. This bracket applies only to the certified wake phase/start pose and
  is falsified by materially different repeated or held-out trajectories.
- Reducing posterior phase-lag gain from `0.80` to `0.75` at the fraction-`0.35`
  anchor is now a replicated navigation/effort improvement, not an unloading
  result. Four current `0.75` policies and released sheets are byte-identical
  and reproduce the self-propelled diagonal capture at `38.049`, mean distance
  `1.802L`, energy `52895.0`, power `3965.3`, and mean velocity
  `(-0.2853,-0.1198)`, improving the replicated `0.80` anchors at `38.362`,
  `1.812L`, `53487.3`, `4007.1`, and `(-0.2829,-0.1181)`. The tradeoff also
  repeats: posterior peak remains `0.521` rad, both rate/acceleration caps are
  touched, and force/moment RMS remain higher at `42.01/653.13` versus
  `40.73/637.79`, so the tail-relief hypothesis is falsified even though the
  navigation gain is reproducible. Both continuations failed: `0.70` regressed
  to `39.605/1.872L`, `55461/4197` energy/power,
  `0.2429/43.11/675.66` crossflow/loads, and a `0.570`-rad posterior peak,
  while the in-bracket `0.7675` interpolation regressed to `38.412/1.817L`,
  `53566/4024`, `0.2268/42.78/659.63`, and `0.533` rad. Retain exact `0.75`
  and avoid further lower, interior, or fitted lag refinements; the response is
  non-monotonic even inside the successful interval. This anchor applies only
  to the certified wake phase/start pose, is falsified if an exact repeat
  materially departs from its recorded navigation/load envelope, and does not
  establish robustness to held-out wake phase or geometry.
- Posterior damping is now closed on both sides of the replicated `0.65`
  anchor; neither lower loads nor earlier arrival alone is a durable gain.
  The four current exact `0.65` policies capture on the same visible active
  route at `38.049`, with `1.802L` mean distance, `52895/3965` energy/power,
  `0.2249` relative crossflow, `42.01/653.13` force/moment RMS, and
  `0.496/0.521`-rad joint peaks. Raising damping to `0.675` visibly falls
  behind and regresses to `41.591/1.901L` and `58328/4400`; `0.70` extends
  that failure to `46.910/2.067L` and `66607/5051`. Their lower load RMS is
  bought by weaker active traverse, while posterior excursion rises to
  `0.551/0.569` rad and cap contact remains. The assigned-parent `0.625`
  opposite probe reaches earlier at `37.339` and lowers total energy/power to
  `52247/3947`, but score/mean distance slip to `0.07187/1.803L`, posterior
  excursion rises to `0.565` rad, and crossflow plus force/moment RMS exceed
  its stated rejection envelope at `0.2461` and `47.26/710.38`. Retain exact
  damping `0.65`; avoid further damping continuation or interpolation and do
  not infer persistent bang-bang merely from recorded maxima. Because every
  damping variant still touches the `31.416` posterior acceleration envelope,
  cap sensitivity may be tested only as a separately parameterized posterior
  output-bound axis with gait, lag, bearing law, allocation, and observations
  fixed. Reject such a test if it loses the visible route/capture, exceeds the
  lag-`0.80` navigation bounds (`38.362`, `1.812L`), or fails to reduce load,
  excursion, or effort without increasing the `0.2249` crossflow anchor. This
  bracket applies only to the certified wake phase/start pose and is falsified
  if exact repeats materially depart from the recorded tradeoffs.
- Posterior acceleration capping is a replicated navigation/effort axis with
  an opposing wake-load cost, not an unloading knob. Against four inherited
  `1800 deg/time²` captures (`38.049` arrival, `1.802L` mean distance,
  `52895/3965` energy/power, `0.2249` relative crossflow, `42.01/653.13`
  force/moment RMS, and `0.521`-rad posterior excursion), the four available
  `1700` records from sampled results and inherited logs reproduce the same
  visible safe, self-propelled diagonal capture at `34.331/1.714L`, reduce
  energy/power to `45153/3390` and excursion to `0.509` rad, but raise
  crossflow and loads to `0.2312/54.48/766.14`. Two exact `1650` policies and
  released sheets then preserve that route and improve score, arrival/mean
  distance, energy/power, and posterior excursion again to
  `0.189303`, `33.027/1.683L`, `42310/3183`, and `0.495` rad. The tradeoff also
  continues: crossflow rises to `0.2358` and force/moment RMS to
  `63.93/859.31`, while the posterior ceiling is active and the anterior
  acceleration and both joint-rate envelopes remain touched. Retain exact
  `1650` as the measured navigation/effort anchor, but do not infer robustness
  or a general tighter-is-better law and do not continue to `1600`: moment RMS
  already edges beyond the inherited `850` continuation boundary. Reject this
  anchor if an exact repeat loses the route/capture, regresses beyond the
  replicated `1700` navigation/effort envelope, or materially exceeds the
  measured `1650` `0.2358/63.93/859.31` crossflow/load envelope. This local
  result applies only to the certified wake phase/start pose and is falsified
  by a materially different repeat or held-out trajectory.
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
