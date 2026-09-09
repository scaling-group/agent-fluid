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
- Retain the `0.90`-period, `28 deg` anterior oscillator and positive
  posterior-only bearing sign as the finite propulsion anchor. Direct
  heading-rate damping is the only sampled rate channel with a repeatable
  upstream-approach benefit: raising its gain from zero to `0.35` and `0.70`
  improves mean head velocity from `-0.0447` to `-0.0878` and `-0.1300`,
  progress from `0.132` to `0.255` and `0.380`, and best approach from
  `6.34L` to `7.30L` and then `5.33L`. Do not equate that gain with loop
  stabilization: release survival falls from `73.39` to `56.93` and `55.38`,
  every sheet retains the same upper-exit topology and roughly `6.09L`
  lateral offset, and the `0.70` result still reaches both rate/command caps
  while RMS force/moment rise to `325/3331`. Its posterior angle peaks at
  `44.1 deg`, below the exact `45 deg` stop, so neither that stop nor still
  more heading damping is supported as the root loop repair. Use the `0.70`
  controller only as the current approach anchor, and isolate static bearing
  strength/sensitivity or posterior-servo bandwidth next; falsify such a
  repair if it loses the upstream gain or repeats the exit/cap signature.
- A bounded additive body-lateral-velocity damper is a concrete negative
  result at the sampled sign and scale. Adding a `0.20` correction to the
  `0.35` heading controller reduces upstream speed from `-0.0878` to
  `-0.0695`, progress from `0.255` to `0.174`, and closest approach from
  `7.30L` to `7.73L`, without removing the upper curl or actuator caps.
  Bearing-window-rate additions likewise retain saturation or lose upstream
  motion, while the inherited closing-bearing brake is swept `+2.28L`
  downstream and exits in `19.10` units. Avoid these rate-like brakes unless
  new diagnostics establish a different convention or activation regime;
  do not combine them with anterior steering or wholesale gait weakening.
