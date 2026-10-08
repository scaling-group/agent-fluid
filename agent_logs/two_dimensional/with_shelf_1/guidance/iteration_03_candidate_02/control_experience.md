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
- Direct bounded bearing feedback has now separated navigation from the seed's
  propulsion failure topology: adding a positive `tanh(bearing/scale)`
  acceleration residual to both joints (with a smaller posterior share) kept
  the posterior-lag carrier, moved the head `(-10.92,-4.15)L`, and reached the
  `0.75L` target boundary in `62.30` time with mean distance `2.46L`. The
  target-blind seed instead moved `(-3.55,-13.30)L` and exited after `50.13`,
  while an opposite-sign centered-curvature interpretation moved right
  (`+2.75L` in x), made negative progress, and exited after `13.92`. Thus infer
  the bearing-to-actuator sign from comparative rollouts, not a guessed body
  axis convention, and prefer a bounded acceleration residual over scalar gait
  tuning for this wrong-heading topology. This lesson establishes directional
  authority, not effort or phase robustness: the successful run touched joint
  speed/acceleration limits, so falsify or refine it if later phases lose
  capture, sustain saturation, or reproduce either exit trajectory.
- Once that correct-sign bearing residual had established capture, explicit
  carrier/residual allocation improved the same fixed-wake behavior without a
  scalar gait retune. Reserving a small steering share inside a `30.0`
  candidate acceleration envelope preserved target reach, shortened arrival
  from `62.30` to `49.14`, improved mean distance from `2.460L` to `2.156L`,
  and reduced total command energy from `89.5k` to `62.5k` relative to the
  otherwise matched unallocated controller; the keyframes also retain a
  coherent left/down wake traversal rather than the centered-bias loop and
  blow-up. Reuse this mechanism only after the bearing sign and propulsive
  carrier are independently validated: it bounded acceleration at `30.0` but
  did not remove joint speed-limit contact, and RMS lateral force/moment rose
  from `27.3/525.8` to `39.0/617.1`. Thus falsify it under changed wake phase or
  persistent high loads, and do not interpret envelope allocation as evidence
  for uncalibrated force/crossflow rejection or general load reduction.
- Record candidate-specific hypotheses under `logs/optimize/`; every successful
  worker must update this file with a durable lesson that should survive across
  later iterations.
