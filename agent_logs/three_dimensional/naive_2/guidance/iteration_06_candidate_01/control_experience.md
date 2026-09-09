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
- In the sampled direct-uniform naive rollout, both wake views show a coherent
  alternating tail wake and self-propelled motion, yet the target-blind carrier
  changes heading from `0.506` rad to as low as `-1.186` rad, improves distance
  only from `12.328L` to `12.069L`, then exits the upper virtual boundary at
  `8.596T` with both joint rates reaching `260 deg/T`. Treat that topology as a
  directional-feedback failure, not a reason for scalar-only carrier tuning:
  preserve the joint-state oscillator and test bounded body-frame
  target-to-mean-curvature steering with yaw-rate release. This implication is
  falsified if the steering turn has the wrong sign, fails to beat `12.069L`,
  repeats the upper-boundary exit, or sacrifices the coherent wake by worsening
  joint saturation.
- Separate beat-scale yaw from directional response before feeding yaw back to
  shared half-cycle steering. Restoring the response-gated controller and
  subtracting its joint-rate-correlated yaw component changed the sampled
  `9.759L` closest approach and `10.324T` upper exit into a coherent
  target-directed trajectory lasting `27.429T` and reaching `3.174L` before a
  left exit. That useful topology also raised mean speed from `0.453` to
  `0.800L/T` and hard-rate-neighborhood occupancy from about `6%` to `12%` per
  joint, so the residual defect is a high-speed lateral pass and missing
  approach turn radius, not weak propulsion. Preserve the phase separation and
  condition any approach reserve on directional state: among the next sampled
  branches, distance-only carrier relief worsened closest approach to `3.600L`
  and retained a nearly straight left exit, while unconditional proximity or
  target-plane hold reached `2.703L` but exited sooner with the largest sampled
  lateral-force and yaw-moment peaks. In contrast, full body-frame pursuit
  angle plus proximity-and-misalignment gating reached `2.319L` and visibly
  produced a return arc without losing the alternating 3D wake. It still did
  not capture, occupied the hard-rate neighborhood for about `12%` per joint,
  and exited near the upper boundary. Therefore retain the full-vector,
  direction-conditioned approach structure, but do not treat proximity alone,
  broad hold, or a general rate brake as steering reserve. When beat-scale yaw
  transiently aligns posture while translational velocity still crosses the
  target line, test a normalized body-frame course-response gate and require a
  closer pass or better termination without higher loads or limit occupancy.
  Falsify this ranking if another initial pose reverses the turn sign, or if
  course conditioning loses pre-approach translation or wake coherence.
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
