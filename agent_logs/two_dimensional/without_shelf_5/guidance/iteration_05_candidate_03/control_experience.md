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
- Positive bounded body-frame bearing curvature across both joints is the
  finite navigation anchor, but its gain response is too sharp and
  non-monotonic for sparse curve fitting. The target-blind oscillator escaped
  downward at `50.127` with final distance `12.123L`; adding the unchanged
  vigorous gait's bounded steering at gain `1.5` reached at `41.316`, and gain
  `1.7` improved arrival/mean distance to `39.710/1.874L`, relative-crossflow
  RMS to `0.2265`, and force/moment RMS to `38.40/618.59`. Gain `1.9` then
  regressed to `40.034/1.901L` and `41.31/657.28` loads. More importantly, two
  inherited upper-side interpolation tests also regressed: gain `1.72` reached
  at `41.464` with mean distance `1.944L`, crossflow `0.2386`, and loads
  `41.85/675.43`; gain `1.725` reached at `40.832/1.915L` with crossflow
  `0.2364` and loads `42.50/674.61`. Their keyframes retain the same visible
  self-propelled turn-and-diagonal route, while gain `1.72` raises maximum joint
  angles from the `1.7` anchor's `0.507/0.528` to `0.529/0.563` rad and reaches
  the same rate/acceleration envelopes. Preserve the positive sign, two-joint
  distribution, `0.55`-period 28-degree gait, and 12-degree outer bound; test
  the immediate lower side of `1.7` or restore `1.7`, rather than extrapolating
  upward, fitting further sub-steps above it, or adding unscaled wake/force
  terms. This implication is limited to the common wake phase and start pose;
  falsify a lower-side probe at the first loss of capture, arrival later than
  `39.710`, mean distance above `1.874L`, or crossflow/load above the `1.7`
  anchor, then retain `1.7` and test one separately motivated axis.
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
