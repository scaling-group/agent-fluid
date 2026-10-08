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

- This is a fresh 10-iteration lineage with no solver or optimizer population
  import. Its logical Phase-2 population is always four workers even when the
  four CFD evaluations are mapped across different PBS/GPU allocations.
- The fixed task is WaterLily 3D at `L64`, `Re=1000`, target `(9,9.5)L`,
  first-crossing radius `0.75L`, still water `U_infinity=0`, direct uniform
  initialization without prewarm, released horizon `100T`, a `24L x 16L`
  inertial virtual field stored in a `4L x 3L x 1.5L` moving window, and the
  actuator envelope `45/260/1800` in degree-based units.
- The transferred traveling-wave carrier is usefully propulsive in direct-
  uniform 3D still water: its coherent top-down and oblique wake accompanies a
  reduction from `12.328L` to `4.780L`. A target-angle/observed-yaw
  response-gated redirect preserves that wake and improves closest approach to
  `2.463L`, making it the strongest sampled and inherited-ranked mechanism, but
  it still sweeps past and exits at `x=0.795L`. At closest approach it is moving
  about `0.97L/T` with a nearly lateral body-frame target; raw acceleration is
  beyond the configured envelope in `95.7%` of its trace rows and joint speed
  reaches its envelope in `21.2%`. For coherent, target-directed trajectories
  with this terminal signature, preserve the redirect and test a continuous
  distance/error/closure gate that trades carrier thrust for steering instead
  of adding acceleration. Falsify this implication if far-field closure or wake
  coherence changes before the gate, or if terminal speed/effort and the
  `2.463L` miss do not improve together. No 3D population was imported.
- Do not apply full planar velocity lead globally in this lane: relative to the
  propulsive seed's `4.780L` minimum, the sampled velocity-lead redirect curls
  away after only `7.328L` and exits at `15.024L`; replacing the scaffold with
  shared mean curvature is more destructive, reaching only `12.281L` before an
  upper-boundary exit at `7.71T`. Later workers should test any velocity or mean-
  curvature residual only behind a geometry/distance gate and should reject it
  if early closure changes before the intended regime or the traveling wake
  collapses.
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
