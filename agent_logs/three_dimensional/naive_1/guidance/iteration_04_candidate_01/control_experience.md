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
- Opposite-sign anterior/posterior curvature is the first sampled allocation
  to produce sustained useful travel: its coherent axial vorticity street and
  oblique caudal structures accompany `18.81L` displacement, a closest
  approach of `4.9765L`, and survival to `33.209T`, versus `11.0960L` for the
  posterior-only turn and `8.1745L` for the shared-bias lower sweep.  But its
  outer turn-rate servo compares a route target capped at `0.50 rad/T` with
  beat-scale measured yaw spanning about `[-2.64,2.49] rad/T`; the resulting
  bend request reverses each half-cycle while bearing stays predominantly
  negative, so the fish passes the target near `y=14--15L` and exits high at
  `(2.23,15.20)L`.  It also touches joint-rate limits on roughly `17%/19%` and
  requests over-envelope acceleration on `71%/78%` of samples.  When a
  propulsive gait's yaw ripple exceeds the desired mean turn, keep persistent
  normalized target geometry authoritative over redirect sign and use raw yaw
  response only as bounded one-sided release or after genuine cycle-scale
  filtering; do not let it invert the route command.  This applies to coherent
  wake, same-sign bearing plateaus and straight-pass topology; falsify it if a
  target-signed differential bend turns the wrong way, suppresses propulsion,
  worsens saturation, or still cannot create mean lateral route curvature.
- The first capture confirms the mechanism-level correction to that failure:
  a normalized body-frame lateral target fraction kept redirect sign
  authoritative, while recent yaw could only release `35%` of an already
  correct request.  The same opposite-sign curvature carrier retained coherent
  top-down and oblique shedding, decreased distance on `97.3%` of rows, and
  captured at `19.228T` and `0.7482L`, whereas the assigned raw-rate servo
  passed about `5L` high.  A related full signed-course controller came within
  `1.0927L` at `19.058T` but, without one-sided response release, drove the
  behind-target angle toward `pi`, continued below the target, and exited at
  `y=0.796L`.  For a coherent carrier with beat-scale yaw reversals, retain
  bounded lateral geometry plus one-sided response release as the navigation
  scaffold; do not upgrade raw yaw or a large behind-target angle into route
  authority.  This evidence does not isolate which of lateral saturation or
  release gating was decisive, and it is not an efficiency result because the
  capture still touches joint-rate limits on about `10.8%/14.3%` and requests
  over-envelope acceleration on `61.9%/72.0%`; falsify the scaffold under
  held-out poses or if reducing saturation removes capture.
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
