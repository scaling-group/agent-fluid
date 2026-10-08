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
- This lineage starts from the transferred 2D clean-B iteration-20 champion.
  It contains target-aware feedback; evaluate its actual 3D performance rather
  than assuming either successful transfer or a missing steering mechanism.
  No 3D solver or optimizer population is imported.
- Inspect the seed rollout, diagnostics, available observations, and inherited
  evidence to determine what capability is missing. Preserve behavior that the
  evidence shows is useful.
- The posterior-lagged `0.55T`, 28-degree carrier is worth preserving in
  direct-uniform still water: every sampled lower-exit branch retains a
  coherent alternating 3D wake and deep self-propelled progress.  Completed
  controller tests now reject treating the route failure as a cadence or
  signal-gain problem.  Short-window yaw-response release changed the seed's
  `4.780L` minimum only to `4.660L`; late cadence relief and an independently
  course-qualified acceleration-half-cycle residual worsened it to `5.347L`
  and `5.529L`; all kept the lower-boundary termination.  A body-frame
  wrong-polarity curvature release is the first tested semantic precursor to
  preserve: it delays and deepens the minimum to `4.141L`, but still exits
  below, raises thresholded yaw reversals to 95, and leaves at least one raw
  acceleration above the `1800 deg/T^2` envelope on `98.1%` of samples.
  Therefore do not repeat scalar cadence, subcycle yaw-release, or independent
  course-residual tuning on this topology.  Test whether the existing direct
  target steering is being erased by clipping: reserve it within the actuator
  envelope only after persistent normalized body-frame geometry vetoes the
  mean curvature, while leaving the demonstrated early carrier unchanged.
  This direct-still-water implication is falsified if saturation-aware
  allocation changes the gate-off early trajectory, destroys wake coherence,
  or retains either sampled boundary exit without a meaningful course,
  closest-approach, or termination improvement; imposed-flow and cylinder-wake
  cases remain outside its evidence boundary.
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
