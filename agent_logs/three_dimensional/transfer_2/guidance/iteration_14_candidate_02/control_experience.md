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
- Inspect the seed rollout, diagnostics, available observations, and inherited
  evidence to determine what capability is missing. Preserve behavior that the
  evidence shows is useful.
- The far-field response-release hypothesis has a concrete negative result in
  direct-uniform still water.  Relative to the transferred seed, gating only
  geometric steering when measured yaw had the requested sign changed minimum
  and final distance from `4.780/9.709L` to `4.660/9.604L`, but preserved the
  lower-boundary exit, roughly `98%` exposure to at least one raw acceleration
  command above the actuator envelope, and essentially the same thresholded
  yaw-reversal count (82 versus 84).  The evaluator's seven-sample
  `turn_rate_recent` window spans only about `0.0385T`, so it is dominated by
  within-beat rotation and must not be treated as a route-scale response signal
  or repaired by another release-gain tweak.  Preserve the coherent carrier
  and deep early approach, but test steering authority upstream of clipping.
  Do not replace the carrier wholesale: a corrected-sign `12 deg` static mean
  curvature reached only `12.206L` before an upper exit, while the assigned
  parent's globally slower, soft-limited progress redirect removed raw
  acceleration exceedance but degraded closest approach to `8.752L` and also
  exited above.  The inherited course-response experiment closes an important
  loophole: even an initial negative tail-tangent bias below `0.5 deg`, released
  and reversed using measured swimming direction, reached only `12.083L` and
  exited above at `8.618T`.  Thus correct actuator polarity or course alignment
  alone does not make an always-on mean bend safe at the release pose.  In this
  direct-uniform, fixed-initial-joint regime, keep the demonstrated carrier and
  leave mean curvature dormant near the initial centerline.  The completed
  materially off-axis wrong-polarity veto now closes the release-only branch:
  relative to the response-release child it improved minimum distance from
  `4.660L` to `4.141L` and delayed the lower exit from `28.369T` to `32.197T`,
  but still finished at `9.570L` through the same lower boundary with a
  coherent unrecovered diagonal wake.  Thus geometric withdrawal can preserve
  and modestly extend the useful approach, but another veto threshold or
  release gain is unlikely to supply route-scale turning.  Its completed
  phase-selective successor validates a distinct useful mechanism: attenuating
  only the contradicted posterior half-cycle improved closest approach again
  from `4.141L` to `3.033L`, reduced raw acceleration-envelope exposure from
  `98.09%` to `93.63%` and joint-rate-limit exposure from `19.41%` to
  `12.68%`, preserved the coherent wake, and changed the lower exit into a
  later left-boundary exit at `40.331T`.  Preserve that allocation rather than
  retuning it as a scalar.  The new trajectory exposes a sharper missing
  state: at closest approach the target is nearly lateral in the body frame
  (`0.672,2.957L`), then crosses behind and is never reacquired during roughly
  `10L` of westward runout.  The completed recapture family now closes the
  proposed behind-only remedy.  A bounded `7 deg` posterior bend does create
  route-scale authority, changing the westward runout into a coherent broad
  northward hairpin, and unloading its posterior carrier reduces raw
  acceleration-envelope exposure from `92.77%` to `82.97%`; nevertheless the
  passage, unloaded, and persistent-route variants all miss at
  `2.996--3.031L` and leave through the upper edge near `49.4T` at
  `7.42--7.53L` without reacquisition.  Do not spend another candidate on a
  behind-gate threshold, persistence term, or late curvature gain unless a
  new release observable can demonstrably turn that hairpin into renewed
  closing.  The separately completed closing-sector intercept is the useful
  upstream mechanism: combined with the unloaded recapture it improves the
  pass to `2.579L` and mean distance to `6.913L` while preserving the coherent
  wake, but still exits above and presents at least one raw acceleration
  command beyond the envelope on `82.76%` of samples.  The completed
  steering-priority allocator validates that bounded allocation, rather than
  more curvature, is the useful mechanism: giving the existing sector
  steering first claim on the acceleration envelope improves closest approach
  from `2.579L` to `1.076L`, mean distance from `6.913L` to `6.178L`, and raw
  acceleration-envelope exposure from `82.76%` to `74.65%` while preserving
  the coherent wake.  It still misses the `0.75L` capture, increases
  joint-rate-limit exposure slightly from `12.59%` to `13.09%`, and exits the
  upper edge earlier at `37.823T` and `6.307L`.  Preserve steering priority
  and do not turn this result into another curvature-gain edit.  Its reusable
  boundary is the trigger handoff: near the `1.076L` pass, positive closing
  speed releases sector priority while the target remains posterior-lateral
  and recapture still requests signed curvature; on the evaluated trace this
  permits a carrier-dominated posterior command near `+75.8rad/T^2` against
  about `-21.8rad/T^2` of steering.  The completed body-frame translational-course
  preview validates that bridge as the lineage's semantic success: three
  sampled direct-uniform rollouts reproduce capture at `24.5795T`, final
  distance `0.74697L`, mean distance `2.36044L`, and the same coherent
  alternating three-dimensional wake; inherited optimizer score logs further
  preserve capture across three later recorded descendants at terminal
  distances `0.74858--0.74984L`.  Preserve the collision-course error
  (the normalized cross product of body-frame velocity and target direction),
  its closing/range gates, and the existing steering-priority allocator rather
  than returning to a behind-gate or curvature-gain edit.  The sampled
  predictive stopping-stroke guard exposes a compatible safety lesson: it
  retains capture at `24.5960T` while reducing hard-angle exposure from
  `23.38%` to `12.63%` and peak force/moment coefficients from
  `0.3228/0.1426` to `0.1543/0.0667`; however, its slightly worse score
  (`-0.46227` versus `-0.46067`) and unchanged raw acceleration-envelope
  exposure (`72.74%` versus `72.84%`) show that a posterior guard alone is not
  command bounding.  Apply it only as a load-protection refinement of the
  proven course preview, and project the final two-joint command onto the
  owned envelope if raw-action safety is required.  Falsify that composition
  if capture or the useful route changes materially, raw exceedance survives,
  hard-angle exposure rises above the guarded sample, or the coherent wake
  degrades.
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
