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
- The `fish-control-primitives` shelf exists for mechanism-level transfer
  across biological swimming, robotic fish, CFD, and wake-control problems.
  Transfer qualitative invariants into this lane's observations and actuation;
  never copy numerical gains, species-specific kinematics, or a memorized
  route. The worker entrypoint defines the consultation protocol.
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
- When a target-blind joint oscillator starts outside the organized wake, an
  early domain exit can be a navigation-capability failure rather than evidence
  for wake-phase control. The naive seed traveled `(-3.545,-13.300)L`, left the
  lower boundary after `50.127`, never came within `8.615L`, and reached both
  joint-rate and acceleration caps. Adding an `8 deg` bounded body-frame
  target-bearing mean curvature while preserving the fast posterior-lagged
  carrier produced two identical target reaches after `93.032`, whereas a
  globally slower `0.90`-period/`14 deg` carrier and a `12 deg` static-bias
  variant both exited in under `17.5` with negative progress. Thus mean
  curvature is a demonstrated navigation mechanism here, but it depends on
  preserving the traveling-bend carrier and has a narrow authority boundary;
  do not infer that more static bend or broad scalar drive relief will improve
  it. Reassess this implication if a held-out wake phase reverses the turn sign
  or a carrier-preserving steering mechanism reaches with less cap contact.
- A distance-only terminal amplitude schedule is not meaningful load relief
  merely because it preserves first-crossing success. Reducing the successful
  carrier smoothly inside `2.5L` to an effective `0.804` scale at the `0.75L`
  boundary left arrival (`93.032`), all joint maxima, mean effort (within
  `0.001`), and visible trajectory topology unchanged; RMS force and moment
  rose slightly from `95.50/1146.61` to `95.55/1147.03`. For a cap-dominated
  first-crossing episode, avoid further shallow range-envelope tuning unless
  it demonstrably changes time-local cap contact; test a route/turn transient
  or actuator-state mechanism instead. This does not rule out stronger or
  earlier scheduling for dwell/overshoot objectives, but those uses require
  evidence that propulsion is not removed before capture.
