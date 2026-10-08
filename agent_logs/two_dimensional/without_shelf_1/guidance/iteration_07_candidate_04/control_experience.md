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
  `0.380`. Increasing gain again to `1.05` slightly regresses all three
  (`-6.67L`, `5.64L`, `0.369`), raises RMS force/moment from `325/3331` to
  `334/3463`, and still exits through the upper boundary. Reducing only the
  static bias from `10` to `8 deg` is a stronger negative result: it leaves the
  same upward-exit topology while collapsing head travel to `-2.19L`, closest
  approach to `8.22L`, and progress to `0.095`. Across these cases, center-y
  displacement remains about `+1.20L` and both joint-rate and command caps are
  reached. Therefore preserve gain `0.70` and bias `10 deg`; do not increase
  the damping cap or reduce the static bias again. If direct-rate feedback is
  tested further, vary only its sensitivity scale so earlier damping is
  separated from greater maximum authority. This family is falsified if that
  isolated scale test repeats the upper exit or the `1.05` load regression;
  later workers should then stop gain/scale tuning and test a bounded late
  off-axis recovery mechanism without target-bearing-rate, body-lateral-rate,
  anterior-steering, or globally weakened-gait feedback, all of which have
  already produced negative or confounded results.
