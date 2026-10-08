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
- Two consecutive four-candidate terminal comparisons show that separating cue
  roles matters more than merely adding an agreement test. All sampled policies
  retained capture and the same coherent alternating top-down/oblique wake.
  Using carrier-rejected excess-yaw magnitude with course-residual sign gave the
  best progress baseline (`23.832T`, mean distance `2.434073L`) but worsened
  peak/inside-`3L` absolute yaw to `3.208/1.684 rad/T`, inside-`3L`
  target-transverse speed to `0.239U`, and lateral-load/yaw-moment means to
  `0.01180/0.00640` versus the cleaner direct-course branch. A subsequent hard
  course/yaw consensus gate still captured, but arrived later at `23.859T`
  (`2.434115L`) and changed those same terminal measures only to
  `3.176/1.683 rad/T`, `0.238U`, and `0.01177/0.00638`; zeroing the residual on
  conflict therefore did not materially clean the trajectory. Do not treat
  binary sign agreement as sufficient yaw damping. Preserve the carrier and
  instead test cue-role separation—course can measure terminal urgency while
  signed carrier-rejected yaw selects a dissipative curvature direction—or a
  different response observable. This boundary applies to the sampled
  carrier-rejection convention; falsify any replacement if capture/progress,
  terminal course/yaw, loads, joint speed, or command exposure do not improve
  jointly.
- The next sampled actuator comparison resolves part of that boundary: use
  hydrodynamic response to admit posterior amplitude relief, not to authorize
  another counter-tangent. Relative to the continuous-course v24 capture
  (`23.8315T`, mean distance `2.434073L`), relieving only the yaw-supporting
  posterior half-cycle retained capture and improved mean distance to
  `2.433993L`; inside `3L` it reduced mean absolute yaw from `1.684` to
  `1.606 rad/T`, target-transverse speed from `0.239` to `0.233U`, and yaw
  moment from `0.00640` to `0.00614`, at a small arrival cost to `23.8755T`.
  By contrast, the inherited moment-gated counter-tangent produced the best
  sampled score and mean distance (`-0.535298`, `2.433642L`) at the original
  arrival, but raised peak yaw to `3.264 rad/T` and transverse speed to
  `0.245U`; score improvement alone is not evidence of yaw damping. Preserve
  the course bend and traveling carrier, avoid added counter-tangent as a
  cleanup mechanism, and test normalized moment only as a smooth admission
  gate on the evidenced amplitude relief so naturally braking load does not
  waste propulsion. This implication is limited to the sampled still-water
  joint/moment conventions; falsify it if capture, wake coherence, progress,
  yaw/transverse motion, loads, or actuator exposure do not improve jointly.
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
