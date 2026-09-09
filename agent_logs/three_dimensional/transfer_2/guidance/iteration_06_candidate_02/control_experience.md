# Dogfish L64 3D Moving-Window Still-Water Policy Experience

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
  import. Its logical Phase-2 population is always four workers even when the
  four CFD evaluations are mapped across different PBS/GPU allocations.
- The fixed task is WaterLily 3D at `L64`, `Re=1000`, target `(9,9.5)L`,
  first-crossing radius `0.75L`, still water `U_infinity=0`, direct uniform
  initialization without prewarm, released horizon `100T`, a `24L x 16L`
  inertial virtual field stored in a `4L x 3L x 1.5L` moving window, and the
  actuator envelope `45/260/1800` in degree-based units.
- The common naive seed has only a state-feedback oscillator and posterior
  phase lag. It reads joint state but not the task target, flow, force, moment,
  world position, learned route, or any external phase signal, and it is not
  intended to complete the task.
- Inspect the seed rollout, diagnostics, available observations, and inherited
  evidence to determine what capability is missing. Preserve behavior that the
  evidence shows is useful.
- Identify route feedback and the two-joint actuator sign separately. The
  transferred 2D controller's mean-curvature map produced a coherent wake but
  exited the lower boundary at `6.18L`, while compact controllers with opposed
  anterior/posterior steering contributions exited above the target at
  `5.36L` and `7.53L`. Aligning both steering contributions in
  `solver_ae0c621b2f7d` preserved the organized wake and improved closest
  approach to `2.579L`; at `19.88T` its head was nearly x-aligned with the
  target but still `2.56L` too high, after which it passed the target and left
  the left boundary. This is positive evidence for the aligned bounded
  mean-curvature actuator, not for its folded-bearing/recent-yaw guidance. At
  the closest pass both folded bearing and full LOS were already about
  `-1.32 rad`, but at `2T` and `4T` the yaw-rate term converted small opposite
  bearings into nearly full alternating commands. By `28T`, after the target
  passed behind, folded bearing was only `-0.285 rad` versus full normalized
  aim `-1.230 rad`, and the yaw brake reversed the total request. Conversely,
  the inherited speed-gated LOS test combined new geometry with opposed
  actuator signs, curled upward, and reached only `11.899L`; it falsifies that
  conflicted combination but does not isolate LOS geometry. Preserve the
  aligned traveling-wave actuator and test persistent normalized target
  geometry without beat-scale yaw/course direction. Reject this implication
  if full line-of-sight mismatch does not contract, closest approach fails to
  beat `2.579L`, wake coherence degrades, or joint-speed and command-limit
  residence exceed the aligned parent's roughly 17%/17% and 35%/45%
  near-limit fractions.
- Prefer normalized body-frame feedback changes that are bounded and carry a
  falsifiable expectation. Let evidence choose the observation and mechanism;
  do not hard-code a global-direction command, coordinates, target identity,
  elapsed time, step count, iteration number, or a case-specific route.
- The `fish-control-primitives` shelf exists for mechanism-level transfer
  across biological swimming, robotic fish, CFD, and wake-control problems.
  Transfer qualitative invariants into this lane's observations and actuation;
  never copy numerical gains, species-specific kinematics, or a memorized
  route. The worker entrypoint defines the consultation protocol.
- Inspect both top-down and oblique 3D keyframe rows before policy edits, then
  cross-check visual claims against distance progress, local/relative flow,
  force, moment, joint state, previous action, and termination. A prewarm
  artifact is a contract failure in this direct-uniform experiment.
- Prefer normalized body-frame feedback. Inflow, target position, initial pose,
  and hydrodynamic conditions are intended held-out axes; coordinate
  memorization is not a valid solution.
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
