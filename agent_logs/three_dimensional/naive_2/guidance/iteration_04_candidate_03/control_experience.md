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
- Across the sampled direct-uniform descendants of the naive carrier, the two
  wake views and metrics rank response-gated shared half-cycle steering as the
  useful mechanism: it preserves a coherent three-dimensional alternating wake
  and reaches `9.759L` at `10.32T`, versus `11.359L` for fixed shared
  asymmetry, `11.977L` for posterior-only phase scaling, and `11.683L` for a
  course-residual/rate-barrier variant. Preserve the traveling carrier and
  shared beat-side redirect rather than reverting to static curvature or
  posterior-only steering, but do not call it sufficient: every sampled law
  still exits through center `y=15.20L`. Falsify this ranking if a later
  controller improves termination and distance together without the shared
  mechanism, or if it loses wake coherence or increases limit/load occupancy.
- A smooth joint-rate barrier is a concrete negative result in this carrier:
  it removes the sampled `260 deg/T` occupancy but reduces mean speed from
  `0.453` to `0.279 L/T`, regresses closest distance from `9.759L` to
  `11.643L`, and repeats the upper-boundary exit. Do not equate suppressed
  joint rate with usable steering reserve. Because sampled yaw rate is strongly
  joint-phase-correlated (`|r|=0.899--0.956` with anterior rate), test slow
  response feedback only after phase compensation; reject that hypothesis if
  it weakens targetward propulsion, worsens actuation/load behavior, or fails
  to change both closest approach and the upper-exit topology.
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
