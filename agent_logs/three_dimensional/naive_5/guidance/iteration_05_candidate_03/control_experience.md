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
- The common naive seed has only a state-feedback oscillator and posterior
  phase lag. It reads joint state but not the task target, flow, force, moment,
  world position, learned route, or any external phase signal, and it is not
  intended to complete the task.
- Static mean curvature and posterior-only asymmetry do not repair the seed's
  wrong-way curl in this lane: two sampled sub-limit descendants still exit
  upward near `9T`, with minima of only `12.226L` and `12.263L`. Anterior
  phase-gated half-cycle authority is the useful topology change: it preserves
  a coherent alternating three-dimensional wake, survives to roughly `39T`,
  and reaches about `5L`. Preserve that carrier instead of returning to static
  curvature or moving steering to the posterior joint.
- Within that useful topology, do not treat raw within-beat yaw as slow route
  response. The original long rollout has
  `corr(heading_rate, phi_dot1)=-0.935`, crosses the target x-station at
  `y=14.655L`, and spends `60.5%` of post-start samples near the joint-speed
  cap. The sampled phase-rejected sign pair calibrates the actuator mapping:
  changing to the response-consistent selector lowers target-x crossing from
  `y=14.779L` to `14.181L` and improves minimum distance from `5.264L` to
  `4.676L`, while avoiding sampled `44 deg` angle occupancy. Yet its normalized
  target-versus-course error is still `+0.962` at crossing and positive on
  `92.3%` of post-start samples. A course-biased policy closed through raw yaw
  instead exits upward at `20.79T`, reaches only `6.268L`, and retains final
  course error `+0.999`; this rejects that mapping, not the course observation.
  Therefore test speed-gated body-frame course error only through the
  phase-rejected, response-calibrated anterior half-cycle, with angle and speed
  headroom. Falsify this lesson if course error is not reduced before target-x
  crossing, the upper-exit topology returns, the alternating wake collapses,
  or saturation remains material.
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
