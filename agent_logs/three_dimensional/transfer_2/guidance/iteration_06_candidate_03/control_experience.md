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
- Calibrate the complete two-joint steering map in 3D, not only the sign of one
  curvature gain. The inherited 2D-sign controller formed a coherent
  self-propelled wake but reached only `6.18L` before reversing progress and
  exiting the lower boundary at `10.60L`; its explicitly 3D-sign-corrected
  descendant changed the failure topology to a left exit and improved closest
  approach to `4.13L`, yet passed the target corridor and had at least one
  action component above `30 rad/T^2` on about 97% of logged steps. The best
  compact sample lowered mean distance to `6.50L`, but its anterior steering
  and posterior mean-tangent maps used opposing request signs; it crossed to
  sustained negative bearing and exited the upper boundary after a `5.36L`
  closest approach. Aligning both steering contributions in another compact
  sample preserved the alternating wake and improved closest approach to
  `2.58L`, but at `19.88T` its head crossed the target's streamwise station near
  `(8.65,12.06)L`, about `2.56L` too high; it then left the target astern and
  continued to the left boundary, finishing at `8.74L`. This establishes a
  concrete negative result: consistent curvature sign plus short-window yaw
  braking is not sufficient course control. Preserve the traveling-wave drive
  and aligned two-joint mean-curvature map, but compare normalized target
  direction with observed body-frame velocity course once speed is nonzero.
  Because the supplied bearing folds the longitudinal target sign with
  `abs(target_body_x)`, retain a bounded `target_body_L[1]` ahead/astern gate
  so an abeam miss increases redirect authority and then releases after
  reacquisition; do not respond with another bearing-gain increase or a
  beat-scale yaw-rate branch. Reject this implication if target/course mismatch
  and closest approach do not improve, the same left-exit topology persists,
  wake coherence degrades, or action/joint-limit residence increases.
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
