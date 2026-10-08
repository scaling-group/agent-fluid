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
  consequential actuator coordinate, but later evidence resolves the resulting
  regulation/progress trade. The assigned v30 load-selective posterior counter-
  tangent retained v24's `23.8315T` capture and improved scoring mean distance
  to `2.433642L`, but terminal mean/peak yaw remained
  `1.682/3.264 rad/T` and peak moment rose to `0.014385`. Relieving the
  yaw-supporting posterior half-cycle reduced mean/peak yaw to
  `1.606/3.063 rad/T` and mean moment to `0.006137`, but delayed capture to
  `23.8755T`; inherited moment gating, course gating, and equal relief/boost
  redistribution did not recover the lost progress. In contrast, moving the
  phase-selected excess-yaw residual to the anterior oscillator while leaving
  posterior amplitude and lag unchanged produced the best sampled score/mean
  distance (`-0.535091`/`2.433543L`) and capture at `23.8425T`, while lowering
  peak yaw/moment from the assigned v30 parent to
  `3.185 rad/T`/`0.013730`. Extending that result by transferring a fixed
  `25%` share of continuous course curvature anteriorly further lowered
  mean/peak yaw to `1.644/3.121 rad/T`, but regressed score and mean/final
  distance to `-0.535920` and `2.434212/0.747022L`. Therefore preserve the
  continuous body-frame course bend and coherent carrier; prefer a bounded,
  state-phase-selected anterior residual over posterior waveform edits, and do
  not assume fixed route-curvature transfer is a free yaw improvement. This
  implication is limited to the sampled direct-uniform still-water capture
  topology and current joint conventions; falsify it if v33-scale capture and
  distance progress fail to reproduce, the alternating wake weakens, or
  terminal yaw/load and actuator-limit exposure worsen materially.
- Four sampled artifacts now reproduce the exact v33 policy, trajectory, and
  `23.8425T` capture, so that result is a stable behavioral base but the copies
  are repeat evidence rather than distinct mechanisms. The inherited v35
  two-joint carrier-rate observer is a concrete warning against optimizing an
  offline decomposition metric: adding a `0.30` full-tail-rate share greatly
  reduced replay residual correlation and its completed CFD lowered inside-
  `3L` mean/peak yaw from v33's `1.680/3.185` to
  `1.610/3.050 rad/T`, target-transverse speed from `0.239` to `0.222U`, and
  mean moment from `0.006382` to `0.006106`, yet delayed capture from
  `23.8425T` to `23.8975T` and regressed score and mean/final distance from
  `-0.535091` and `2.433543/0.746165L` to `-0.535811` and
  `2.434232/0.746866L`. Thus cleaner carrier rejection, yaw, or slip is not a
  useful objective by itself when along-target progress falls. Preserve v33's
  one-joint observer unless a new intervention retains its distance integral;
  avoid another carrier-rate share or curvature-allocation retune, and test an
  orthogonal bounded mechanism against capture, progress, regulation, and
  actuator exposure together. This lesson applies to the present direct-
  uniform still-water capture topology; falsify it if a held-out pose or flow
  shows distributed carrier sensing improves distance progress as well as
  terminal dynamics.
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
