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
  `10L` of westward runout.  After a safe target-ahead approach is established,
  future controllers may test a bounded, mirror-equivariant target-passage
  recapture maneuver gated by negative normalized forward target position;
  it must remain exactly dormant while the target is ahead and release when
  the target returns forward or lateral error closes.  Reject this implication
  if such a branch perturbs the early approach, produces a premature upper or
  lower exit, materially worsens limit exposure, or cannot create a useful
  turn-back after passage.
- The current sampled population establishes that pre-passage course mismatch,
  not post-passage terminal authority, is the useful discriminating state for
  this near-miss topology.  A bounded body-frame cross-product between measured
  translational course and target direction captured at `0.747L` and `24.580T`,
  whereas the assigned terminal-priority bridge and its steering-priority and
  carrier-relief siblings reached only `1.092L`, `1.076L`, and `1.148L` before
  the same northern domain-exit runout.  Both keyframe views show that all four
  retained coherent self-propelled wakes, while the capture also reduced raw
  acceleration-envelope exposure to `72.84%` from the bridge's `74.33%` and
  reduced peak normalized planar force/moment from `0.474/0.216` to
  `0.323/0.143`; the distinction is therefore route correction before passage,
  not recovery from lost propulsion or instability.  When body bearing can look
  aligned while inertial travel predicts a lateral miss, preserve the carrier
  and admit normalized course error through bounded sector-request headroom,
  gated by speed, closing behavior, range, and posterior target position.
  Prefer this to adding another recapture-priority or near-target carrier scalar.
  Its present applicability is direct-uniform still water with a formed closing
  trajectory; falsify it if held-out poses or flows change the early path, lose
  capture, activate after passage, destroy wake coherence, or increase command
  and load exposure.
- Posterior stroke-aware allocation is a validated safety mechanism, but
  dropping the released steering request is not a free improvement.  Relative
  to the repeated course-preview capture, releasing posterior priority only
  when the tail was near its hard stop and steering farther outward retained
  capture while reducing hard-stop occupancy from `23.38%` to `12.60%`, peak
  normalized planar force/moment from `0.323/0.143` to `0.203/0.089`, and raw
  acceleration-envelope exposure from `72.84%` to `72.65%`.  The same rollout
  arrived `0.0385T` later, worsened mean distance from `2.36044L` to
  `2.36225L`, and narrowed the capture margin from about `0.00303L` to
  `0.00128L`; rate-limit exposure was unchanged within `0.05` percentage
  points.  In this formed course-preview approach, preserve the state-gated
  tail release as a load/stroke guard, but do not compensate by restoring more
  posterior priority.  A later controller may test moving only the steering
  acceleration actually displaced by the guard into bounded anterior command
  headroom.  Falsify that allocation if the tail/load reductions disappear,
  the anterior joint develops a hard-stop class, the far route changes, or
  capture time and margin fail to recover without new envelope exceedance.
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
