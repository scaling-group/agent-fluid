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
- Terminal comparisons now separate useful posterior phase selection from
  unsuccessful posterior authorization and compensation. All sampled and
  inherited policies retained capture and the same coherent, self-propelled
  alternating top-down/oblique wake. The v24 continuous course brake captured
  at `23.8315T` (scoring mean distance `2.434073L`) with inside-`3L` mean/peak
  absolute filtered yaw `1.684/3.208 rad/T`. Hard course/yaw consensus and
  removal of continuous course authority arrived later, so preserve the
  carrier and continuous body-frame course bend. Tail-side counter-tangents
  can preserve progress: the load-selective variant matched v24's arrival and
  produced the best sampled mean distance (`2.433642L`), but it left mean yaw
  and body-lateral speed at baseline scale (`1.682 rad/T`, `0.254U`) and raised
  peak yaw to `3.264 rad/T`. In contrast, relieving the yaw-supporting posterior
  half-cycle lowered mean/peak yaw to `1.606/3.063 rad/T`, body-lateral speed to
  `0.241U`, and mean yaw moment to `0.006137`, with no angle-limit or extra
  projected-command exposure, but delayed capture to `23.8755T`; tail side is
  therefore an evidenced phase coordinate, while posterior amplitude removal
  discards some useful impulse.
  Three inherited results reject repeated attempts to repair that trade by
  changing only posterior admission or compensation. Reinforcing-moment gating
  remained at `23.8755T` and worsened score/mean distance to
  `-0.537144/2.435252L`; target-course gating mostly restored baseline yaw
  (`1.679 rad/T`) and still worsened score to `-0.536153`; equal relief/boost
  redistribution retained relief-scale mean yaw (`1.603 rad/T`) but did not
  recover arrival and worsened score/mean distance to
  `-0.536206/2.434499L`. Later workers should avoid another sign/magnitude gate,
  posterior boost, or posterior-relief gain variant unless a new measured
  impulse model explains why it differs. The subsequently sampled v33
  phase-selected anterior residual is the positive allocation result: four
  byte-identical evaluations capture at `23.8425T` with score `-0.535091`,
  scoring mean/final distance `2.433543/0.746165L`, and terminal mean/peak yaw
  `1.680/3.185 rad/T`, while preserving posterior amplitude, lag, wake
  coherence, and actuator exposure. Two children show why yaw cleanliness is
  not a sufficient objective. Fixed transfer of continuous course curvature
  anteriorly lowered terminal yaw/slip/load but regressed score and mean/final
  distance to `-0.535920` and `2.434212/0.747022L`; adding an offline-
  decorrelating two-joint carrier-rate observer lowered terminal yaw and slip
  further to `1.610 rad/T` and `0.239U`, yet arrived near `23.8975T` and
  regressed to `-0.535811/0.746866L`. Preserve v33's continuous course
  distribution, carrier observer, posterior wave, and correction direction;
  do not pursue another observer coefficient, allocation share, or terminal-
  damping edit merely because it reduces yaw RMS. A distinct next test may
  change the energetic phase of the bounded anterior residual while retaining
  all motion-supporting correction. This lesson is limited to the sampled
  direct-uniform still-water capture topology; accept such phase shaping only
  if it retains capture, coherent wake, and v33-scale progress without
  worsening terminal yaw/slip/load or joint/command exposure.
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
