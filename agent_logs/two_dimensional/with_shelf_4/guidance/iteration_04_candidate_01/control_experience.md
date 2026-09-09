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
- The target-blind seed's bottom exit and saturated joints establish the need
  for target-directed steering, but the inherited static-mean-curvature repair
  is now falsified: it replaces the exit with a full-horizon far-right loop
  (`10.28L` closest distance), and two simpler static-bias variants are advected
  out the right boundary in under `20` units.  In contrast, two deterministic
  evaluations of zero-mean anterior half-cycle asymmetry both reach the target
  in `179.22` units, while also modulating the posterior half-cycle reaches in
  `268.49` units.  Thus, when a static joint center trades away translation,
  preserve a posterior-lagged traveling bend and put bounded body-frame route
  error in one half-cycle envelope; do not reopen mean-offset or scalar gait
  tuning unless a later ablation reverses this success/loop topology.
- A small normalized yaw-moment residual is a supported addition only after
  zero-mean target steering succeeds.  On otherwise identical anterior
  half-cycle policies it improves arrival `179.22 -> 149.57`, mean distance
  `5.04L -> 4.38L`, RMS lateral force `18.42 -> 16.22`, and RMS yaw moment
  `338.91 -> 314.99`; the keyframes also show a shorter target-reaching route.
  Preserve the residual as a separate bounded fast-load channel rather than
  raising gait authority: relative crossflow rises slightly and peak anterior
  acceleration increases `30.40 -> 30.92` rad/time^2, already near the
  `31.42` limit.  This lesson is falsified outside the matched scaffold if
  success, distance integral, or load histories regress, and further work
  should test route damping or disturbance gating before increasing its gain.
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
