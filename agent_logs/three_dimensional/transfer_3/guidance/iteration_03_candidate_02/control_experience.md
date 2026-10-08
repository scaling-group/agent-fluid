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
- In direct-uniform still water, geometry-gated large-error curvature first
  improved the transferred carrier's `4.780L` lower-boundary miss to a
  `1.135L` near miss, but its full carrier consumed posterior excursion and it
  looped to an upper-left exit with force/moment coefficient maxima of
  `0.264/0.119`. Continuously reallocating the same two joints inside `4L`
  toward a damped shared-curvature equilibrium converted that topology into a
  `0.7469L` capture at `25.26T`, eliminated observed angle-stop occupancy, and
  held full-rollout force/moment maxima to `0.028/0.015`. When an otherwise
  propulsive two-joint swimmer has a fast terminal near miss, reserve joint
  excursion for mean curvature rather than stacking steering on the carrier.
  This result applies to finite-speed, geometry-correct terminal approaches;
  it is falsified by loss of the unchanged far approach, terminal stall, a
  repeated loop/exit, or renewed angle and load spikes.
- Velocity-course feedback is unsafe as a release-time route controller in
  this lineage: the inherited loss-of-closure course C-bend reduced saturation
  but reached only `11.865L` before an early upper exit. Reconsider course only
  as a subordinate, speed-qualified residual after geometry steering has
  established a useful approach. The captured allocation provides that test
  boundary: inside `4L` it averages `0.634U` with only `0.29%/0.00%` command-cap
  occupancy, yet its velocity-to-target angle still averages `0.599 rad`.
  Lower terminal course lag is useful only if capture timing and low
  angle/load occupancy survive; low-speed, externally advected, and
  geometry-incorrect motion remain outside this implication.
- Record candidate-specific hypotheses under `logs/optimize/`; every successful
  worker must update this file with a durable lesson that should survive across
  later iterations.
