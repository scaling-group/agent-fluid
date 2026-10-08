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
- The completed direct-uniform comparisons show that 3D actuator polarity must
  be established before adding steering allocation or a second redirect path.
  The inherited asymmetric map self-propelled with a coherent wake but missed
  below the target (`4.78L` closest approach). Smooth steering-reserve
  allocation eliminated raw acceleration exceedance yet exited the upper
  boundary at `17.58T`, no closer than `6.28L`; separately signed course and
  geometry redirects also exited, at best reaching `4.02L` and `5.77L`.
  Replacing the map with one bounded odd posterior-curvature relation was the
  only sampled semantic success, capturing at `23.35T` and `0.7497L` while
  retaining the alternating wake. For coherent-wake course failures, infer the
  target-request-to-curvature sign from measured motion and pass later
  body-frame route residuals through that same map; do not let a separately
  signed posture or allocator obscure the base polarity. This implication is
  limited to the sampled pose and still-water dynamics: falsify it if a
  reflected or held-out target breaks the odd response, or if desaturating the
  validated signed map preserves capture while improving arrival and loads.
- Raw command exceedance alone did not diagnose the course failure: the
  captured signed-curvature policy requested beyond `1800 deg/T^2` in roughly
  `70%/52%` of joint samples but remained stable, whereas the bounded reserve
  allocator failed with zero raw exceedance. Continue to treat sustained
  clipping as an actuator-quality concern, but do not redesign a productive
  carrier from saturation fractions alone; require a measured loss of course
  authority, wake coherence, stability, or capture under the already-correct
  curvature polarity.
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
