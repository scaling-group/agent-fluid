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
  `41.316` with mean distance `1.919L`. Four earlier fraction-`0.40`, gain-`1.7`
  samples have byte-identical keyframes and metrics: each visibly self-propels
  along the diagonal route and reaches at `39.710`, with mean distance `1.874L`,
  relative-crossflow RMS `0.2265`, force/moment RMS `38.40/618.59`, and joint
  maxima `0.507/0.528` rad. Gain `1.9` preserved capture but regressed to
  `40.034/1.901L`, `0.2329`, `41.31/657.28`, and `0.523/0.548` rad; the
  inherited `1.725` interpolation was worse again at `40.832/1.915L`,
  `0.2364`, `42.50/674.61`, and `0.526/0.556` rad. Both joints touch the same
  rate/acceleration caps in these runs. Therefore retain gain `1.7`, the
  vigorous gait, positive sign, and 12-degree bound; avoid more tiny gain fits
  or confounding the next test with slower propulsion or unscaled velocity/
  moment terms, because the inherited mixed-feedback slow controller became
  unstable at `2.807`. The numeric gain conclusion is limited to the common
  wake phase/start pose and must be retested when either changes.
- Steering-center allocation is locally non-monotonic, so neither the joint
  peak imbalance nor one successful direction supports continued equal steps.
  Against the fraction-`0.40` anchor (`39.710` arrival, `1.874L` mean distance,
  `54703.2` energy, `0.2265` relative-crossflow RMS, `38.40/618.59` force/
  moment RMS, and `0.507/0.528`-rad peaks), moving anteriorly to `0.45` slowed
  arrival to `43.323` and worsened distance, effort, crossflow, both peaks, and
  loads. Moving posteriorly to `0.35` produced two exact replicas at `38.362`,
  `1.812L`, `53487.3`, `0.2244`, and `0.494/0.521` rad, although force/moment
  rose to `40.73/637.79`; continuing to `0.30` then regressed in two replicas
  to `39.286`, `1.850L`, `56145.5`, `0.2447`, `42.06/662.67`, and especially
  `0.512/0.583`-rad peaks. Retain `0.35` as the bracketed allocation anchor and
  avoid another `0.05` extrapolation in either direction. A finer allocation
  test is useful only if it preserves capture and improves navigation or
  effort without exceeding the `0.35` crossflow/load/joint envelope; otherwise
  stop fitting this axis and change one separately scaled mechanism. These
  numeric bounds apply only to the certified wake phase and start pose.
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
