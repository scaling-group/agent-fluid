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
- Use the proportional positive-bearing, posterior-only tail bias at `0.90`
  period as the finite anchor: it moved `2.73L` upstream in near-zero mean
  local flow, reached `6.34L`, and survived `73.39` units, but its keyframes
  end in a broad upward loop with the posterior angle at `45 deg`, both rates
  at `260 deg/time`, both commands at `1650 deg/time^2`, and RMS force/moment
  of `196/2014`. Bearing-rate feedback has now failed on both sides of this
  anchor. Adding `0.35*bearing_window_rate` with the anchor gait moved `2.24L`
  downstream, never came within `12.42L`, and exited after `22.61`; subtracting
  a bounded rate term while lowering bias from `10` to `8 deg` retained
  upstream motion but turned vertical earlier, exited after `53.53`, worsened
  minimum distance to `7.90L`, and left all posterior/rate/command saturation
  plus loads of `201/2115`. A broader reduced-gait/rate alteration likewise
  lost upstream authority (`+0.08L` x, `-0.062` progress) with loads of
  `329/5141`. Therefore avoid further unscaled bearing-rate terms at these
  magnitudes and do not weaken the upstream-capable anterior gait wholesale.
  First isolate the repeated actuator interaction by bounding the posterior
  target or command while retaining proportional bearing feedback. Keep such
  a bound only if it preserves upstream motion and reduces hard-stop contact,
  the late loop, and loads; otherwise relax that bound independently before
  testing any smaller rate term with an evidence-established scale.
