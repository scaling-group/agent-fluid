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
- The first two generations establish a useful separation between carrier,
  redirect, response release, and command feasibility. The transferred carrier
  formed a coherent wake but missed below after reaching `4.780L`; replacing it
  with opposite-sign static posture turns produced weak-wake upper exits, one
  with `78.0%` posterior angle-limit exposure. Preserving the carrier while
  shifting its oscillator centers into the sampled same-sign, body-frame-error-
  gated C-bend instead captured at `25.388T` (mean distance `2.557L`). On that
  same capture topology, response-triggered bend release independently improved
  arrival to `25.152T` and mean distance to `2.522L`, while a component-wise
  smooth acceleration projection improved them further to `23.997T` and
  `2.438L` and kept recorded raw commands below `31.42 rad/T^2`. Therefore
  preserve the successful bend polarity and carrier, and treat response release
  and final command projection as compatible but distinct control layers rather
  than cadence gains or wholesale posture replacement. Applicability is limited
  to the present joint/observation conventions and sampled still-water pose;
  projection alone did not reduce all kinematic symptoms (`4.5%` posterior
  velocity-cap exposure and `2.922 rad/T` peak yaw), so falsify a combined design
  if capture/wake coherence regresses or joint/yaw histories worsen despite
  bounded acceleration.
- Once the response-released, smoothly projected C-bend captures reliably,
  terminal mechanisms must distinguish route motion from beat-synchronous body
  motion. Among four direct-uniform captures with visually coherent alternating
  top-down and oblique wakes, a target-relative course residual gave the best
  score (`-0.535986`) and reduced mean scoring distance from the sampled v22
  amplitude-relief result's `2.435490L` to `2.434313L` at the same `23.881T`
  arrival. A phase-compensated yaw brake reached sooner (`23.760T`) but raised
  peak yaw to `3.472 rad/T`, mean absolute yaw inside `3L` to `1.865 rad/T`,
  and mean absolute cross-track speed inside `1L` to `0.539U`, versus `2.975`,
  `1.556`, and `0.360` for the course residual; an approach command allocator
  was later (`23.925T`) and had worse mean distance (`2.435081L`) despite less
  high-command exposure. Do not promote earlier capture or actuator headroom
  alone when course/yaw histories regress. Also do not feed raw terminal course
  speed back as though it were purely route-scale: inside `3L`, cross-track
  speed correlates `0.841` with anterior joint velocity, while body lateral
  velocity correlates `-0.961` with a fitted slope near `-0.083`; comparable
  slopes survive all four sampled controllers. The reusable implication is to
  preserve the proven carrier and reject its joint-state-correlated lateral
  component before a bounded target-relative course correction. This relation
  is specific to the sampled gait and still-water pose, not a universal gain;
  falsify it if the correlation/sign changes under another gait or condition,
  or if carrier rejection fails to improve capture/directness and joint, load,
  yaw, and wake histories jointly.
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
