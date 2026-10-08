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
- Terminal comparisons now reject repeated cue arbitration, command-pressure
  allocation, and joint-velocity phase-lag damping, while isolating an
  actuation-coupling trade. The v24 continuous
  course brake captured at `23.8315T` with mean distance `2.434073L`, but had
  `3.208 rad/T` peak yaw and `1.684 rad/T` mean absolute yaw inside `3L`.
  Hard course/yaw consensus and yaw-selected static damping arrived at
  `23.8590T`/`23.8535T` with essentially unchanged terminal yaw/load. A
  moment lead reached the boundary at `23.8260T`, but worsened mean/final
  distance to `2.435488L`/`0.748944L` without material yaw cleanup; a
  pressure-gated residual allocator likewise worsened mean distance to
  `2.435590L` and raised inside-`3L` yaw to `1.704 rad/T`. In contrast,
  half-cycle-only terminal curvature reduced inside-`3L` yaw and cross-track
  speed to `1.616 rad/T` and `0.213U`, but delayed capture to `23.9085T`.
  A posterior phase-lag damper then preserved the coherent capture topology
  but worsened mean/final distance to `2.435327L`/`0.748560L`, while changing
  inside-`3L` yaw only from `1.684` to `1.678 rad/T`.
  A posterior counter-tangent applied only on the yaw-supporting half-cycle
  showed that tail side is consequential, but traded earlier arrival for higher
  terminal yaw and moment; the later load-selective version preserved v24's
  `23.8315T` arrival and improved scoring mean distance from `2.434073L` to
  `2.433642L`, yet raised target-transverse speed from `0.2393U` to `0.2449U`,
  peak yaw from `3.208` to `3.264 rad/T`, and peak absolute moment from
  `0.01406` to `0.01439`. Another same-path counter-tangent is therefore not a
  clean yaw/load remedy.
  The assigned parent's posterior half-cycle amplitude relief is the first
  direct stabilizing result on this coordinate: it preserved capture and the
  coherent wake while reducing inside-`3L` mean/peak yaw from
  `1.684/3.208` to `1.606/3.063 rad/T`, body-lateral speed from `0.2535U` to
  `0.2414U`, and mean absolute moment from `0.006402` to `0.006137`, without
  new angle or acceleration-limit exposure. Its cost was capture at `23.8755T`,
  consistent with removing useful posterior impulse. Inherited v31 evidence
  further shows that multiplying this relief by instantaneous reinforcing yaw
  moment neither recovered arrival nor retained all cleanup. Equal posterior
  relief/boost then retained the cleanup (`1.603 rad/T` mean yaw, `0.2410U`
  body-lateral speed, and `0.006126` mean moment) but also retained the
  `23.8755T` arrival and worsened mean/final distance to
  `2.434499/0.747290L`; preserving cycle-scale amplitude did not restore the
  useful posterior impulse. Do not repeat posterior relief authorization,
  compensation, or redistribution without a different evidenced actuator
  model.
  Moving the same tail-side-selected residual to the anterior oscillator center
  is the first progress-positive allocation result: v33 kept posterior amplitude
  and lag unchanged, captured at `23.8425T`, and produced the best sampled score
  and mean/final distance (`-0.535091`, `2.433543/0.746165L`). It also modestly
  improved v24's inside-`3L` mean/peak yaw to `1.680/3.185 rad/T`, body-lateral
  speed to `0.2522U`, and mean/peak moment to `0.006382/0.013730`, without new
  angle or projected-command exposure. Therefore preserve v33's continuous
  target-course curvature, coherent carrier, and anterior/posterior allocation;
  avoid another sign gate, moment lead, acceleration-headroom allocator,
  joint-velocity phase-lag residual, posterior counter-tangent, or posterior
  amplitude compensation. Its remaining `0.011T` arrival cost makes observed-
  response release of the anterior residual a distinct falsifiable next test,
  not a reason to retune its curvature gain. This implication is limited to the
  sampled direct-uniform still-water capture topology; accept release only if it
  retains v33-scale distance, wake coherence, terminal yaw/load behavior, and
  joint limits while matching or improving arrival.
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
