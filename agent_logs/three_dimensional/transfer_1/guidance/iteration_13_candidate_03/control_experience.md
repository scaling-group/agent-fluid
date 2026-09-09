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
- Do not equate a centered body-axis target bearing with a centered achieved
  course in a free swimmer. In the sampled 2D-champion transfer, the alternating
  3D wake and early propulsion remained coherent, but near `4T` the target
  bearing was only about `-0.04 rad` while the body-frame velocity course was
  about `-0.95 rad`; the controller then reversed its initially useful turn,
  reached only `6.13L`, and exited the lower boundary. When this signed
  bearing/course discrepancy is present, preserve the demonstrated gait and
  test a speed-gated target-versus-velocity course residual before adding
  propulsion or cadence. Falsify that implication if it weakens early distance
  closure, disrupts wake coherence, saturates the joints, or retains the same
  long-turn `left_domain` topology.
- Do not treat a close pass as evidence for deeper scalar cadence relief when
  the achieved-course command already has the correct saturated sign. The
  inherited course servo reached `1.044L`; continuously lowering oscillator
  frequency from `4L` toward a `0.72` floor slowed the sampled terminal pass to
  about `0.738L/T` but worsened closest approach to `1.542L`, retained the same
  below-target lower exit, reached the `260 deg/T` joint-speed limit, and left
  raw acceleration outside the envelope on about `95.5%` of trace rows. In
  this regime preserve the coherent far-field carrier and change how bounded
  steering authority is realized within the beat, or test terminal yaw/slip
  estimation, rather than increasing route gain or reducing cadence again.
  This implication applies only after broad route acquisition and a coherent
  finite wake; falsify it if a later cadence-relief evaluation improves the
  capture class while materially reducing saturation without stalling.
- Treat terminal carrier collapse as distinct from insufficient route gain.
  Relative to the inherited cadence-relief miss at `1.542L`, opposing-half
  carrier attenuation improved closest approach to `1.267L`, but the combined
  wake sheet and trace show that it then stopped laying down a substantial new
  alternating wake: joint motion and commands became small after the pass even
  though inertial speed remained about `0.78--0.85L/T`, and the fish coasted
  below the target into the same lower exit. Once broad course acquisition is
  established, avoid further terminal carrier suppression in this topology;
  test a bounded mean-curvature or wave-shape steering realization that keeps
  the traveling bend active. Falsify this implication if preserved terminal
  oscillation worsens the `1.267L` pass, raises saturation, or redirects the
  route before the evidenced terminal regime.
- Treat projected-intercept gating as a useful terminal discriminator, not a
  sufficient capture mechanism. The same LOS-guarded policy bytes first
  crossed at `0.7493L` and then exited after a `1.7715L` pass; adding a
  body-frame projected-pass/approach veto sharpened the next completed pass to
  `1.0509L` while preserving about `0.866L/T` speed and a coherent wake, but it
  still exited the lower boundary. At closest approach its projected miss was
  `1.047L`, turn command was already saturated with release vetoed, and action
  clamped on about `70.4%/69.7%` of rows. A separate posterior mean-curvature
  realization regressed to `1.5454L` with the same exit and roughly
  `70.0%/72.2%` clamping. Completed within-beat alternatives did not unlock
  that saturated correction: intercept-guarded half-cycle steering retained a
  coherent wake but worsened the pass to `1.7456L` with about `70.2%/72.3%`
  clamping and exact `260 deg/T` speed-limit contact, while posterior phase-lag
  transfer also retained propulsion yet missed at `1.6818L`. A later
  intercept-guarded, outward-only speed-reserve realization produced a new
  semantic success at `0.7480L` in `18.205T`, slightly earlier than the sampled
  LOS success at `0.7493L` in `18.606T`; its sheets retain the alternating
  mid-plane and three-dimensional terminal wake and place the head higher on
  the target side at `16T--18T`. This does not establish an effort benefit:
  within `4L`, action still clamps on about `71.6%/74.6%` of rows versus
  `72.6%/75.5%` for the LOS capture, speed-limit contact remains about
  `10.6%/10.7%`, and mean absolute yaw moment is similar. Treat directional
  reserve as a provisional within-beat route-shaping mechanism, not permission
  for deeper carrier relief. For this coherent, broadly acquired topology,
  retain the intercept veto and traveling bend; avoid more route gain, tighter
  corridors, cadence tuning, carrier suppression, static curvature, half-cycle
  weights, or phase-lag tuning. Next test steering allocation by instantaneous
  directional actuator room while preserving nominal total steering, or use a
  separately normalized yaw/slip residual. Falsify the reserve lesson if exact
  repeats do not preserve capture, if allocation weakens the alternating wake
  or raises clamp/speed contact or loads, or if LOS-only control proves equally
  robust across exact repeats.
- Do not rank successful policies by scalar score alone. Compare semantic
  success, arrival, distance integral, final/mean distance, clearance,
  saturation, switching, effort, and force/moment loads.
- The hard limits are an actuation envelope, not a muscle-power model. Reject
  persistent bang-bang action, implausible load spikes, and fragile success
  even when scalar score improves.
- Record candidate-specific hypotheses under `logs/optimize/`; every successful
  worker must update this file with a durable lesson that should survive across
  later iterations.
