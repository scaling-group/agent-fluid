# Actuator-consistent stroke-aware course-preview candidate

## Evidence diagnosis before the policy edit

- All four sampled solver rollouts use direct uniform still-water
  initialization with `U_infinity=[0,0,0]`, no cylinders or prewarm snapshot,
  finite dynamics, and moving-window transport. The inherited failed comparator
  satisfies the same contract, so the visible motion and wakes are self-generated
  rather than imposed advection.
- Both rows of the combined keyframe sheets were inspected for the assigned
  course-preview parent (`solver_f6caa4a4502f`), the sampled stroke-aware child
  (`solver_162cce0ac49b`), the inherited actuator-consistent child
  (`solver_61067b0066e0`), and the informative pre-preview failure
  (`solver_c420dcf10314`). The top-down row shows a coherent alternating
  propulsive wake in all four. The failure passes outside the capture circle at
  `1.092L`, makes a broad post-passage hairpin, and leaves the upper boundary at
  `37.493T`; the course-preview family bends toward the target before passage
  and captures near `24.6T`. The oblique row retains compact three-dimensional
  Lambda2 structures through each redirect. Wake breakup, passive advection,
  and propulsion loss are therefore not the present intervention targets.
- The assigned v27 parent captures at `24.5795T`, final distance `0.746968L`,
  mean distance `2.36044L`, and score `-0.460673`, but holds the posterior joint
  at its hard stroke on `23.38%` of samples and emits at least one acceleration
  beyond `1800 deg/T^2` on `72.84%` of samples.
- The sampled v28 proprioceptive allocator preserves the same visual route and
  capture class at `24.6180T`, `0.748724L`, and mean distance `2.36225L`. It
  cuts posterior hard-stop occupancy to `12.60%`, mean absolute posterior raw
  acceleration from `42.65` to `39.50 rad/T^2`, and peak planar force/yaw
  moment from `0.323/0.143` to `0.203/0.089`. Its raw acceleration-envelope
  exposure remains `72.65%` and joint-rate exposure remains `15.10%`, so this
  is specifically a stroke/load improvement, not a command-feasibility result.
- The inherited v30 rollout closes that remaining software-contract gap. It
  has exactly the v28 termination, arrival, distance score, moving-window shift
  count, and every logged physical/feedback trajectory column; only the two
  returned acceleration columns differ. Direct CSV analysis gives `72.6542%`
  samples above the envelope and a `112.974 rad/T^2` peak for v28, versus zero
  samples above the envelope and an exact `31.415927 rad/T^2` peak for v30.
  Its top-down and oblique sheets are visually identical to v28. Thus final
  projection exposes the same command the downstream actuator already applies;
  it does not claim new hydrodynamic or joint-rate relief.
- Recent inherited conditional refinements are negative controls for further
  gating: course-alignment relief returned posterior stop occupancy toward
  `22%` and delayed capture, while inward-phase release was effectively neutral
  relative to v28. The evidence does not support another response threshold,
  phase blend, or scalar guard retune.

## Policy hypothesis

Materialize the evaluated v30 controller as this workspace's single candidate.
Preserve v27's normalized body-frame velocity/target course preview and v28's
joint-state stroke-aware posterior allocation. After the carrier and steering
requests have been fully combined, project both returned accelerations onto the
owned symmetric `joint_accel_priority_limit`, the same envelope enforced by the
actuator. This adds no authority, clock, world-frame direction, stored mode, or
case-specific route.

The falsifiable expectation is a repeated v28-class capture and reduced-load
trajectory with no raw acceleration beyond the owned envelope. Reject the
candidate if formal CFD loses capture, differs materially from the v28 route or
arrival, restores posterior hard-stop occupancy toward the v27 `23.38%` class,
returns peak load toward `0.323/0.143`, or emits a non-finite/out-of-envelope
action. Do not interpret raw-command feasibility as evidence of lower rate
limiting or hydrodynamic load; those remain separate outcomes.

## Bookshelf transfer

The mandatory three-consecutive-stagnant-iteration trigger is not met because
the recent completed lineage introduced semantic capture and then a distinct
stroke/load improvement. The shelf was nevertheless consulted after the
current visuals and metrics, and its bounded sensor-modulated rhythmic-control
invariant informs the final feasible-action projection rather than a scalar-only
gain edit.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and elongated-body posterior reactive propulsion
source_mechanism: combine a state-feedback propulsive rhythm and target steering within finite actuator authority
transferable_invariant: preserve the observed traveling-wave and route-feedback allocation while ensuring the final commanded action contains no unavailable actuator authority
nontransferable_details: published gains, dimensional cadence, motor torque curves, species-specific kinematics, full-body envelopes, exact vortex phase, and task-specific routes
policy_translation: retain normalized body-frame target/course feedback and observed posterior joint-state allocation, then project both returned joint accelerations onto the owned symmetric envelope at the two-joint policy boundary
falsification: reject if capture or the stroke-aware physical trajectory/load class changes, posterior pinning rises, or any returned acceleration exceeds the owned envelope

## Pre-evaluation checks

- The candidate SHA-256 is
  `091ca36b3bdf5eaa03810a24a1ce27c2d0cbdcd5fd4a1ecdd6ac72de03d6dd8b`
  and it is byte-for-byte identical to the inherited evaluated v30 controller.
  This prior rollout is evidence for candidate selection; no outcome is claimed
  for the post-worker evaluation.
- All `82` direct `params.FIELD` references resolve among the `84` fields
  returned by `target_policy_params()`. The prescribed public-contract state
  returns two finite accelerations. A deterministic `27,000`-state grid over
  distance, target side, bearing, translational course, posterior stroke/rate,
  and closing state returns finite actions bounded by
  `31.41592653589793 rad/T^2`.
- The configured check-runner was invoked, but its pinned `gpt-5.4-mini` model
  is unsupported on this account. Its three prescribed no-CFD commands were
  therefore run directly and separately. The reusable-guidance check first
  exposed two identical assigned-parent markers in the rendered README;
  removing only the duplicate repaired parent selection. The material-guidance
  check, lightweight Julia public contract, and solver editable-boundary audit
  then all passed. No formal CFD was run.
