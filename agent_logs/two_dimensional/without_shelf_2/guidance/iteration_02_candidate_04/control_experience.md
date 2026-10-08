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
- Treat the sampled target-blind gait as a negative saturation anchor, not a
  propulsion template to preserve unchanged: its `0.55`-period, `28 deg`
  oscillator drove both joints to the `1800 deg/time^2` acceleration and
  `260 deg/time` velocity caps, produced `541.7` RMS moment, and descended
  `13.30L` into a boundary exit after only `50.13` release-time units. Despite
  visible actuation, local-minus-world mean velocity was only `(0.031,0.022)`,
  so this effort did not establish useful flow-relative propulsion. Successors
  should combine directional feedback with a nominal gait whose
  `omega^2 * amplitude` and expected joint speed fit inside the envelope;
  falsify that prescription if an intermediate bounded gait cannot improve
  flow-relative motion or sustained distance closure.
- Low saturation is not sufficient evidence of a useful gait. Three bounded
  target-aware successors with `1.0--1.1` periods produced only
  `0.0160--0.0228` upstream x motion relative to local flow, negative progress,
  and downstream/right exits in `16.27--16.73` units while using mean command
  energy `0.218--1.513`. Before adding more steering or wake channels, require
  a bounded gait to establish materially stronger flow-relative propulsion
  during this early advection window; falsify this ordering if a comparably
  low-effort policy survives and closes distance through a faster startup
  mechanism rather than greater nominal drive.
- Do not feed raw heading rate directly into a moving oscillator center without
  independently bounding both the rate contribution and final action. The
  inherited `1.05`-period attempt hit the `45 deg` joint and
  `1800 deg/time^2` acceleration limits, reached `1.30e6` RMS moment, and became
  unstable after `1.009` units before translating. This negative result applies
  to the tested direct coupling, not all derivative steering; revisit yaw-rate
  feedback only with normalized or windowed scaling, action protection, and a
  separate finite propulsion baseline.
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
