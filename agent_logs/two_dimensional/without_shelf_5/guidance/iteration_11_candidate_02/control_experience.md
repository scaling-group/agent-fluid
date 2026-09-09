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
  finite navigation anchor, but steering-gain response is non-monotonic. With
  the same `0.55`-period, 28-degree gait, the target-blind seed escaped downward
  at `50.127` with final distance `12.123L`, while gain `1.5` reached at
  `41.316` with mean distance `1.919L`. Four current gain-`1.7` samples have
  byte-identical keyframes and metrics: each visibly self-propels along the
  diagonal route and reaches at `39.710`, with mean distance `1.874L`,
  relative-crossflow RMS `0.2265`, force/moment RMS `38.40/618.59`, and joint
  maxima `0.507/0.528` rad. Gain `1.9` preserved capture but regressed to
  `40.034/1.901L`, `0.2329`, `41.31/657.28`, and `0.523/0.548` rad; the
  inherited `1.725` interpolation was worse again at `40.832/1.915L`,
  `0.2364`, `42.50/674.61`, and `0.526/0.556` rad. Both joints touch the same
  rate/acceleration caps in these runs. Therefore retain gain `1.7`, the
  vigorous gait, positive sign, and 12-degree bound; avoid more tiny gain fits.
  The assigned-parent allocation test then increased the anterior steering
  fraction from `0.40` to `0.45` without changing that gait or total steering
  command. It still captured, but regressed to `43.323/2.025L`, raised
  relative-crossflow RMS to `0.2456`, force/moment RMS to `41.96/709.54`, and
  total command energy to `60174.8`; critically, both joint maxima increased
  to `0.544/0.562` rad instead of equalizing. The opposite fraction-`0.35`
  test was then replicated twice and improved capture to `38.362`, mean
  distance to `1.812L`, energy to `53487.3`, crossflow to `0.2244`, and joint
  maxima to `0.494/0.521` rad relative to `0.40`, although force/moment RMS
  rose from `38.40/618.59` to `40.73/637.79`. Crucially, the next equal step to
  `0.30` was also replicated twice and reversed every claimed benefit: arrival
  regressed to `39.286`, mean distance to `1.850L`, energy to `56145.5`,
  crossflow to `0.2447`, force/moment RMS to `42.06/662.67`, and joint maxima
  to `0.512/0.583` rad. Therefore allocation response is non-monotonic: retain
  `0.35` as the measured anchor for this wake phase, do not extrapolate lower
  anterior share or infer direction from static peak-angle imbalance, and stop
  fine-fitting this interval until a changed wake phase or start pose tests
  robustness. Do not confound this boundary with slower propulsion or
  unscaled velocity/moment terms: the inherited mixed-feedback slow controller
  became unstable at `2.807`. These numeric gain and allocation conclusions
  are limited to the common wake phase/start pose and are falsified if `0.35`
  loses capture or ceases to dominate `0.30/0.40/0.45` on navigation and
  effort when either condition changes.
- Tail phase response is a useful isolated axis after steering gain and joint
  allocation are bracketed, but its navigation/load tradeoff is not yet known
  to be monotone. Three exact `tail_lag_gain=0.80` samples at the fraction-`0.35`
  anchor reached at `38.362`, with mean distance `1.812L`, energy/power
  `53487.3/4007.1`, relative-crossflow RMS `0.22437`, and force/moment RMS
  `40.73/637.79`. Holding every other parameter fixed, the sampled `0.75`
  policy visibly retained the same self-propelled diagonal wake crossing and
  improved arrival to `38.049`, mean distance to `1.802L`, energy/power to
  `52895.0/3965.3`, and mean route velocity from `-0.2829/-0.1181` to
  `-0.2853/-0.1198`; however, force/moment RMS rose to `42.01/653.13`,
  crossflow was essentially flat at `0.22494`, and both policies still touched
  identical rate/acceleration caps. Therefore treat `0.75` as a single-sample
  navigation-and-effort anchor, not evidence of load relief or a monotone
  sweep. A further bounded tail-lag step is informative only if it preserves
  capture and improves arrival/distance/effort without materially worsening
  crossflow, loads, posterior excursion, or cap-bound switching. This lesson
  applies to the unchanged vigorous gait, bearing controller, allocation, wake
  phase, and start pose; it is falsified if an exact `0.75` replicate departs
  materially or the next isolated step reverses its navigation benefit.
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
