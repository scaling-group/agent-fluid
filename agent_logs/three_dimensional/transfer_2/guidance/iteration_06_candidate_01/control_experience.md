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
- Inspect the seed rollout, diagnostics, available observations, and inherited
  evidence to determine what capability is missing. Preserve behavior that the
  evidence shows is useful.
- Separate route geometry from beat-scale motion; normalizing instantaneous
  body velocity does not make it a slow course observation. The assigned
  parent's speed-blended unit target/course cross-product changed sign on
  successive early beats, produced a tight curl with weak downstream wake,
  and reached only `11.47L` before an upper exit (score `-14.19`), despite no
  acceleration-limit residence and maximum speed only `0.525`. Let normalized
  body-frame target geometry own steering sign; use unnormalized forward speed
  only as nonnegative authority, and avoid short-window yaw/bearing release or
  unit instantaneous course feedback unless a genuinely tailbeat-scale course
  estimator is first evidenced. Falsify this separation if a target-signed,
  propulsion-gated bend still curls before translation or loses the coherent
  wake with bounded actuator histories.
- Treat the distributed two-joint steering sign as a mechanism, not an
  interchangeable convention. With the same bounded oscillator and posterior
  lag, making anterior acceleration and posterior mean tangent agree improved
  closest approach from the compact parent's `5.3570L` to `2.5794L` while both
  visual rows retained an organized alternating wake. That rollout still passed
  about `2.66L` above the target and exited left at final distance `8.7363L`;
  its recent-yaw term remained beat-scale and commands sat above 95% of the
  acceleration envelope on roughly 25%/41% of rows. Preserve the empirically
  aligned actuation sign when testing slower full line-of-sight feedback, but
  do not claim capture or terminal control from this pass. Reject the sign base
  if a rate-free target-vector controller returns to the sampled lower overturn,
  fails to improve the `2.5794L` pass, or worsens wake and limit residence.
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
