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
- Terminal mechanism comparisons now separate stroke selection, actuator
  choice, and load authorization. All sampled policies retained capture and the
  same coherent, self-propelled alternating top-down/oblique wake. The v24
  continuous course brake captured at `23.8315T` (scoring mean distance
  `2.434073L`) with peak/inside-`3L` absolute filtered yaw of
  `3.208/1.684 rad/T`. Hard course/yaw consensus and removal of continuous
  course authority arrived later, so preserve the carrier and continuous
  body-frame course bend. An always-authorized, tail-side-selected posterior
  counter-tangent improved arrival to `23.7930T`, but raised terminal mean/peak
  yaw to `1.706/3.289 rad/T` and peak moment. Gating that counter-tangent by
  reinforcing normalized yaw moment instead captured at v24's `23.8315T` and
  produced the best sampled scoring mean distance (`2.433642L`); however,
  inside-`3L` mean yaw and body-lateral speed remained at baseline scale
  (`1.682 rad/T`, `0.254U`) and peak yaw stayed elevated (`3.264 rad/T`). In
  contrast, relieving the yaw-supporting posterior half-cycle reduced terminal
  mean/peak yaw to `1.606/3.063 rad/T`, body-lateral speed to `0.241U`, and the
  associated mean body-force component from `0.01180` to `0.01135`, with no
  angle-limit exposure or extra command saturation, but delayed capture to
  `23.8755T`. Load reinforcement is therefore actuator-specific rather than a
  universal authorization cue: multiplying the relief by the same reinforcing-
  moment gate retained capture at `23.8755T` but regressed score from
  `-0.535565` to `-0.537144`, scoring mean/final distance from
  `2.433993/0.746615L` to `2.435252/0.748217L`, terminal mean yaw from `1.606`
  to `1.634 rad/T`, body-lateral speed from `0.241` to `0.244U`, and lateral
  force from `0.01135` to `0.01151`. Its realized reinforcing-moment gate was
  nonzero for roughly `76%` of terminal states but reduced the mean combined
  relief weight from about `0.251` to `0.207`, weakening yaw cleanup without
  recovering the discarded posterior impulse. Preserve the continuous course
  bend; do not reuse instantaneous moment as a multiplicative relief gate
  unless a different phase-resolved impulse model is evidenced. If recovering
  progress from amplitude relief, test where the removed stroke authority goes
  (for example bounded opposing-half-cycle redistribution), not another scalar
  gate on whether it acts. This lesson is limited to the sampled direct-uniform
  still-water capture topology; falsify redistribution if it cannot preserve
  the relief child's yaw/load cleanup while recovering arrival or distance
  integral, or if wake coherence, joint-speed exposure, or projected-command
  exposure worsens.
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
