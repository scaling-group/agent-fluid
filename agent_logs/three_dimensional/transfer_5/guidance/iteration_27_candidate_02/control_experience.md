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
  The assigned-parent child v29 provides the first direct intervention on the
  tail-side correlation: adding a posterior counter-tangent only on the
  yaw-supporting half-cycle improved arrival/mean distance from v24's
  `23.8315T`/`2.434073L` to `23.7930T`/`2.433953L`, but increased inside-`3L`
  mean/peak yaw from `1.684`/`3.208 rad/T` to `1.706`/`3.289 rad/T` and peak
  absolute moment from `0.01409` to `0.01512`. Thus posterior side is a
  consequential actuator coordinate, but another same-path counter-tangent is
  not a clean yaw/load remedy.
  The completed v33 reallocation supplies the positive counterpart: moving a
  phase-selected excess-yaw residual to the anterior oscillator while leaving
  posterior amplitude and lag unchanged captured at `23.8425T`, improved
  score/mean/final distance over sampled v30 to
  `-0.535091`/`2.433543L`/`0.746165L`, and reduced inside-`3L` peak yaw/moment
  from `3.2645 rad/T`/`0.014385` to `3.1848 rad/T`/`0.013730`. A subsequent
  fixed `25%` transfer of continuous course curvature to the anterior joint
  reduced yaw/load further but regressed score to `-0.535920`, mean/final
  distance to `2.434212/0.747022L`, and arrival to `23.8480T`; this falsifies
  another fixed allocation-share retune as a progress improvement. Moreover,
  replay of completed v33 shows its nominal carrier-rejected yaw still
  correlates `-0.954` with full-tail tangent velocity inside `3L` (RMS
  `0.635 rad/T` versus signed mean `0.111 rad/T`). Adding approximately
  `0.17*(phi_dot[1]+phi_dot[2])` reduces that same-trace correlation to
  `-0.053` and RMS to `0.216 rad/T`, but completed CFD now shows that observer
  role matters more than offline decorrelation. Feeding the cleaned residual
  into both continuous course curvature and phase-selected correction reduced
  terminal yaw yet regressed score/mean/final distance to
  `-0.536789/2.434939L/0.747952L`, delayed capture to `23.8700T`, and slightly
  raised peak moment. In contrast, keeping the anterior-only residual on the
  continuous course path and using the distributed rate only on the fast phase
  path captured one control step earlier than v33 at `23.8370T`, improved
  score/mean/final distance to `-0.535013/2.433468L/0.746096L`, and slightly
  reduced inside-`3L` mean cross-track speed and peak moment from
  `0.239236U/0.013730` to `0.238678U/0.013581`; mean yaw also held while peak
  yaw rose slightly (`3.1848` to `3.1939 rad/T`). The two sampled split-policy
  files are algebraically equivalent despite different metadata and reproduce
  the same trajectory and visual sheets, so this is closed-loop evidence for
  separating slow course authority from fast gait-phase observation, not a
  duplicate-score inference.
  Three completed descendants now close the immediate half-cycle-refinement
  branch. Using the phase selector but taking correction magnitude from the
  slow course residual reduced inside-`3L` mean/peak yaw to
  `1.6657/3.1702 rad/T`, yet raised peak moment to `0.0141` and regressed
  score/mean/final distance to `-0.535212/2.433604L/0.746410L`. Adding joint
  displacement-rate quadrature to the selector regressed those quantities to
  `-0.535561/2.433904L/0.746654L`; applying bounded anterior envelope relief
  on the selected half-cycle regressed them further to
  `-0.535880/2.434158L/0.746981L`. All three still captured at the split
  baseline's `23.8370T` and retained its visually coherent top-down and
  three-dimensional wake, so lower yaw or cross-track components alone did
  not survive as a progress improvement. Avoid another selector phase lead,
  response-magnitude blend, or half-cycle amplitude relief unless held-out
  evidence presents a different failure topology.
  A separate feasibility audit of the repeated split trajectory found `728`
  joint samples at the `260 deg/T` rate cap; `703` (`96.6%`) simultaneously
  commanded acceleration farther outward. This distinguishes cap-clipped
  command from the previously failed global posterior phase-lag damper: a
  later controller may test a narrow unilateral rate projection that removes
  only outward acceleration near the boundary while preserving all inward
  reversal and the established carrier. It is not yet a positive CFD result.
  Falsify that mechanism if it does not reduce cap residence, changes the
  coherent wake, or regresses split-scale capture, distance, yaw, moment, or
  command feasibility; do not infer efficiency from smaller commands alone.
  Therefore preserve v24's continuous target-course curvature, v33's anterior
  phase-selected actuator, and the coherent posterior carrier; use a
  distributed joint-rate coordinate only in a distinct fast phase role unless
  new CFD supports broader coupling. Avoid another moment lead, acceleration-
  headroom allocator, joint-velocity phase-lag residual, stronger posterior
  counter-tangent, fixed course-curvature transfer, posterior relief share, or
  observer that weakens both course and phase paths together. Offline signal
  cleanup remains diagnostic rather than success. This implication is limited
  to the sampled direct-uniform still-water capture topology; falsify the split
  architecture if it loses the coherent alternating wake, v33-scale capture or
  distance progress, or jointly worsens terminal cross-track motion, yaw,
  moment, and actuator-limit exposure.
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
