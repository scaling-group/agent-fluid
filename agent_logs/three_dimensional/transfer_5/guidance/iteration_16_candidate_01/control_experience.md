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
- Terminal mechanism comparisons separate stroke selection, actuator choice,
  and impulse preservation. All sampled policies retain capture and the same
  coherent, self-propelled alternating wake in both visual rows, so trace-level
  progress and loads—not vortex prominence—decide among them. The v24
  continuous body-frame course brake captured at `23.8315T` with scoring mean
  distance `2.434073L` and inside-`3L` mean/peak absolute yaw of
  `1.684/3.208 rad/T`; hard course/yaw consensus arrived later, so preserve the
  carrier and continuous course bend. A tail-side-selected posterior
  counter-tangent arrived earlier but increased yaw and peak moment, and its
  reinforcing-moment-gated sibling still had `1.682/3.264 rad/T` terminal yaw,
  `0.254U` body-lateral speed, and `0.014385` peak moment. Posterior half-cycle
  relief instead reduced yaw to `1.606/3.063 rad/T`, body-lateral speed to
  `0.241U`, mean absolute moment to `0.006137`, and lateral force to `0.011351`,
  but delayed capture to `23.8755T` and worsened mean distance to `2.433993L`:
  the relieved stroke contains useful impulse. The assigned parent's anterior
  half-cycle counter-curvature gives the best sampled score/mean distance
  (`-0.535091`, `2.433543L`) with capture at `23.8425T`, and improves peak yaw,
  target-transverse speed, and peak moment over the load-gated posterior
  counter-tangent (`3.185 rad/T`, `0.239U`, `0.014094`), but its mean yaw and
  body-lateral speed remain baseline-scale (`1.680 rad/T`, `0.252U`). Thus the
  anterior residual is a progress-preserving allocation, not sufficient yaw
  cleanup; static counter-tangents and unconditioned posterior relief expose
  opposite sides of a propulsion/stability trade. Inherited optimizer evidence
  also reports that instantaneous reinforcing-moment admission of relief did
  not recover arrival while retaining cleanup, so do not repeat that gate or
  tune the relief scalar alone. A distinct next test is bounded posterior
  authority redistribution from the yaw-supporting half-cycle to the opposing
  half-cycle while retaining the anterior residual and continuous course bend.
  This applies only to the sampled direct-uniform still-water capture topology;
  falsify redistribution unless it retains capture, parent-scale arrival and
  distance integral, the coherent wake, and actuator-limit behavior while
  moving yaw/lateral loads toward the relief result without a higher peak
  moment.
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
