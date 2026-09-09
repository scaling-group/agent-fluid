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
- In the direct-uniform seed rollout, the alternating top-down wake and oblique
  Lambda2 structures show genuine self-propulsion, and joint angles stay near
  `26 deg`, yet heading ranges from about `+0.60` to `-1.17 rad`: distance only
  improves from `12.3277L` to `12.0638L` transiently before a `left_domain`
  exit at `8.613T` and `12.3510L`. The same trace touches the velocity limit on
  `4.0%` of rows and exceeds the raw acceleration envelope on `52.6%`, so a
  coherent wake proves self-propulsion but not efficient control authority.
  For this failure topology, preserve the joint-state traveling-bend structure
  and first add bounded body-frame
  target-vector-to-mean-curvature feedback rather than retuning propulsion.
  This implication applies when a coherent wake and finite translation are
  visible without target alignment; falsify it if the added curvature turns
  with the wrong sign, destroys wake coherence, worsens saturation, or leaves
  the same exit topology and distance record; do not answer a failed turn by
  blindly increasing already actuator-heavy propulsion.
- The successful direct-uniform family bounds a steering package, an interface
  distinction, and what its extra observations have not yet earned. Sampled
  base, final-command-projected, progress-qualified-release, and terminal raw
  body-lateral-velocity-lead variants all retain the target-directed
  alternating top-down street and compact caudal Lambda2 structures, capture
  at `0.7464--0.7493L` in `19.019--19.228T`, and keep mean distance within
  `2.1154--2.1259L`. The terminal lead has the best sampled score, but its
  timing change is inside the inherited repeatability spread, while requiring
  a progress-qualified release makes no semantic improvement and is the
  weakest sampled score. Preserve the normalized lateral target request,
  opposite-sign anterior/posterior mean curvature, and correctly signed yaw
  used only for bounded release; do not stack more instantaneous kinematic
  qualifiers unless an isolated rollout changes capture robustness, route, or
  wake class. Exact final projection at the plant's existing
  `1800 deg/T^2` envelope is separately supported by two captures: it bounds
  public commands at `31.416 rad/T^2` without changing the successful route
  class, but sampled trajectory rows still touch the joint-rate limit on about
  `11.1--11.3%`/`14.3--15.0%`. Use that projection as interface ownership, not
  evidence of actuator relief. Falsify these boundaries on repeated loss of
  capture, a returned high/low exit, lost wake coherence, materially worse
  rate contact and loads, or a matched repeat showing that one added signal
  produces a result outside the established variation band.
- A terminal line-of-sight transverse-velocity residual is a concrete negative
  result around the captured carrier. Despite preserving an alternating wake,
  it missed the capture circle at `0.9490L` near `20.014T`, when the target was
  already aft/lateral in the body frame, then continued away to a left-domain
  exit at `32.065T` and `8.7907L`. Do not replace the sign-preserving raw
  body-lateral lead with that instantaneous course projection or infer that a
  smaller closest approach is safe terminal control. A later course correction
  must use an evidenced slower trend or phase-aware release and retain target
  geometry as the route authority; falsify this caution only if an isolated
  alternative repeatedly captures without the post-near-miss departure.
- An isolated actuator-relief test is a negative result: tapering only
  same-sign acceleration above `80%` of the joint-rate envelope and clamping
  returned acceleration preserved an alternating 3D wake, but lost capture,
  worsened minimum distance from the repeated `~0.75L` crossing to `5.3386L`,
  and exited the upper boundary at `21.203T` and `5.8866L`. In this saturated
  state-feedback oscillator, do not equate bounded commands with preserved
  gait phase or steering authority, and do not retry pointwise clipping or the
  same outward-rate gate as a generic efficiency fix. A later limiter must
  first demonstrate phase- and turn-allocation preservation; falsify this
  caution only if an isolated alternative retains capture and wake topology
  while reducing rate contact across repeated rollouts.
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
