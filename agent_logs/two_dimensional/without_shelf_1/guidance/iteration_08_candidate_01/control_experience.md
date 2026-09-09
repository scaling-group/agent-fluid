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
- Retain the positive bearing-to-posterior-tail sign, `0.90`-period propulsion,
  and posterior-only steering, but do not treat their saturating upper-loop
  trajectory as solved. Direct normalized heading-rate damping has a real but
  bounded upstream benefit: with the gait and `10 deg` bias fixed, gains
  `0.35` and `0.70` improve upstream head travel from `-4.69L` to `-6.93L`,
  closest approach from `7.30L` to `5.33L`, and progress from `0.255` to
  `0.380`. Increasing gain to `0.80` or `1.05` regresses progress to `0.351`
  or `0.369`; the latter also raises RMS force/moment from `325/3331` to
  `334/3463`. The isolated sensitivity continuation is now a concrete
  negative result: lowering only the rate scale from `0.35` to `0.25` at gain
  `0.70` preserves the approximately `+1.20L` center-y upper exit, while head
  travel falls to `-5.30L`, closest approach worsens to `6.41L`, mean distance
  rises from `8.03L` to `9.02L`, and progress falls to `0.291`. Reducing the
  static bias from `10` to `8 deg` likewise leaves the exit topology and
  collapses progress to `0.095`. Therefore restore gain/scale `0.70/0.35` and
  bias `10 deg`; stop tuning their maxima or sensitivity. A next posterior-only
  recovery may be state-gated after windowed distance first trends away, but
  it must remain inactive while closing so it is distinguishable from the
  failed global-bias reduction. Falsify that distance-trend gate if it harms
  early upstream progress, switches rapidly, or repeats the upper exit; do not
  respond by reviving target-bearing-rate, body-lateral-rate, anterior
  steering, or a globally weakened gait, which are already negative or
  confounded.
