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
- Completed direct-uniform siblings narrow the seed's lower-exit failure to an
  actuator/steering-structure problem, not missing propulsion.  The seed and a
  recent-yaw response-release child keep coherent alternating 3D wakes and
  reach `4.780/4.660L`, but both exit below with `82/84` thresholded yaw
  reversals and about `98%` exposure to a raw acceleration above the envelope.
  Releasing only the cycle-mean tail bend whose polarity contradicts material
  body-frame route error is a reusable partial improvement: it preserves that
  wake, deepens closest approach to `4.141L`, and extends survival from
  `28.37T` to `32.20T`.  It does not solve steering—the fish still exits below,
  raw exceedance remains `98.1%`, and reversals rise proportionally with the
  longer rollout to 95.  During its active off-axis interval, target-vector
  angle minus measured swimming-course angle keeps one sign on `99.88%` of
  samples (mean magnitude about `1.18 rad`), whereas the recent-yaw window is
  only about `0.0385T` and beat-dominated.  Thus retain the curvature release
  and use normalized translational course, not recent yaw, to qualify a
  bounded half-cycle or envelope-level allocation that survives clipping.
  Avoid another cadence gate or static-curvature magnitude: off-axis
  progress-loss cadence relief worsened the minimum to `5.347L`, global
  slowdown/soft limiting exited above at `8.752L`, and inherited `12 deg`
  static and `2 deg` course-released tail-curvature tests exited above before
  useful progress (`12.206L` and `12.083L`).  This implication is falsified if
  course-qualified allocation loses the coherent early approach, produces an
  upper exit, or cannot improve the lower-exit topology; it does not establish
  behavior under imposed inflow or cylinder wakes.
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
