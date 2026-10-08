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
- The transferred 2D champion's first 3D rollout formed a coherent wake and
  closed from `12.33L` to `4.78L`, but raw acceleration exceeded the fixed
  envelope on `70.5%`/`77.5%` of joint commands before distance reversed and
  the fish exited the lower boundary.  When useful propulsion coexists with
  this clipping and a growing body-frame target angle, do not stack a small
  steering residual on the saturated carrier; test a continuous allocation
  that reserves authority for bounded mean curvature and restores the
  posterior-lag gait after alignment.  This implication applies to clipped
  large-error departures, not to an unsaturated near-capture miss, and is
  falsified if allocation fails to improve closest approach, termination
  class, trajectory topology, or angle/velocity saturation.
- In the shared large-error-redirect lineage, a near-target cadence/rate hold
  missed its first pass and captured only after a full loop at `51.65T`, while
  amplitude/curvature allocation still missed at `1.108L`; explicitly moving
  the oscillator state toward a damped two-joint curvature equilibrium instead
  preserved the common coherent approach and coasted through first-pass
  capture at `25.26T`, with negligible terminal joint rate and command. Thus,
  for a fast, persistently misaligned approach, reserve both acceleration and
  joint excursion by changing the terminal attractor, not merely by reducing
  cadence or scaling the still-oscillatory carrier. This applies only after
  broad target-directed propulsion is established; it is falsified by a stall,
  loss of capture under other initial conditions or wake disturbances, or a
  terminal trajectory that needs continued thrust rather than an intercepting
  glide.
- Record candidate-specific hypotheses under `logs/optimize/`; every successful
  worker must update this file with a durable lesson that should survive across
  later iterations.
