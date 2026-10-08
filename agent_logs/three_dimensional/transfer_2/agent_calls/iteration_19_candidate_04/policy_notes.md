# Phase-reversal steering-residual follower candidate

## Evidence diagnosis before the policy edit

- All four sampled rollouts satisfy the frozen evidence contract: direct
  uniform initialization in still water with `U_infinity=[0,0,0]`, no
  cylinders or prewarm, finite dynamics, and inertial moving-window transport.
  Two byte-identical v34 posterior-coast controls capture at `25.0635T`,
  minimum/final distance `0.749973L`, mean distance `2.352216L`, and score
  `-0.452083`; v27 captures at `24.5795T` and `0.746968L` but has a worse
  `2.360439L` mean distance and `-0.460673` score.  The strongest sampled
  result is the v35 steering-residual coast control: capture at `24.6730T`,
  minimum/final distance `0.748684L`, mean distance `2.348256L`, and score
  `-0.448647`.
- Both rows of the v35, v34, and v27 combined keyframe sheets were inspected
  from release through capture.  Their top-down rows start wake-free and show
  self-propelled diagonal translation, spatially coherent alternating
  mid-plane streets, and bounded terminal hooks into the capture disk.  Their
  oblique rows show compact three-dimensional Lambda2 structures persisting
  through the redirect.  V35 stays in the established route family; its
  improvement is not passive advection, wake breakup, or numerical
  instability.  No failed rollout image is present in the assigned solver
  artifacts, so the failure contrast comes from inherited audited logs: two
  dual-joint velocity barriers retained coherent wakes but converted capture
  into left exits after `0.933L/0.848L` near misses.
- The state and load histories support preserving v35.  Relative to v34 it
  improves score by `0.003437`, mean distance by `0.003960L`, and capture time
  by `0.3905T`, retains zero sampled hard-stop occupancy, slightly lowers raw
  acceleration-envelope exposure from `73.930%` to `73.473%`, and remains in
  the low peak planar force/yaw-moment class
  (`0.0253/0.0309/0.0156`).  Posterior/total exact-rate occupancy instead
  rises slightly from `4.586/13.869%` to `4.637/13.932%`.  Thus preserving
  already-requested velocity-opposing steering is useful trajectory
  allocation, not a saturation cure or evidence for retuning the coast band.
- V35 still has 242 samples within `0.000053 rad/T` of the posterior rate
  boundary, with mean/maximum absolute posterior angle only
  `0.0627/0.1724 rad`; these are centerline transits, not stroke-stop events.
  At a conservative `omega=13.2`, differentiating the existing carrier
  reference `-q1-drive_tail_lag_gain*qd1/omega` from measured anterior rate
  and the acceleration-envelope-bounded anterior command shows that the
  reference already opposes posterior motion in 219 of those 242 samples.
  Across the owned `250--260 deg/T` band there are 306 such mismatches, 302
  while the target remains farther than `6.5L`.  The residual defect is a
  lagging follower continuing an old half-cycle, not insufficient route
  steering or proximity to the posterior angle stop.

## Policy hypothesis

Preserve v35's anterior state-feedback phase anchor, course-preview route,
steering-priority allocation, predictive stroke gate, posterior braking
reserve, steering-residual coast guard, cadence, and terminal steering.  Add
one role-separated follower mechanism before the final coast guard:
differentiate the already-computed anterior-derived posterior carrier target
using observed anterior rate and the bounded current anterior command.  Only
when posterior speed is inside the owned high-rate band and moving opposite
that reference, add the bounded reference-velocity term missing from the
damped target follower.  Leave the anterior command unchanged, synthesize no
route-independent brake, and do nothing when reference and follower agree.

This is a phase-reversal tracking term, not scalar-only gain tuning.  Expected
evidence is capture in the v35 trajectory family, a coherent three-dimensional
wake, zero posterior hard-stop occupancy, the existing low-load class, and
posterior/total exact-rate occupancy below `4.637/13.932%` without losing
v35's distance-integral benefit.  Falsify it if capture or the far route
changes materially, if the correction ever accelerates the measured
posterior motion, if hard-stop contact returns, if peak planar loads leave the
roughly `0.035` class, or if rate occupancy does not improve.  A lower rate
statistic without capture and route preservation remains a failure.

bookshelf_consulted: true
source_domain: Lighthill elongated-body reactive swimming and sensor-modulated coupled-oscillator robotic-fish control
source_mechanism: an anterior phase anchor propagates a lagged traveling bend to a posterior reactive-thrust follower whose phase is corrected through proprioceptive state feedback
transferable_invariant: preserve wave direction and anterior phase while using reversal of the upstream carrier reference, rather than rate magnitude alone, to correct a lagging posterior follower
nontransferable_details: published gains, dimensional cadence, species-specific kinematics and envelopes, full-body waveforms, exact vortex phases, Strouhal targets, motor models, and task-specific routes
policy_translation: retain v35 and use normalized joint state plus the owned rate and acceleration envelopes to add bounded posterior reference-velocity following only when a high-rate tail opposes the anterior-derived carrier direction
falsification: reject if capture, the established route and coherent wake, zero posterior hard-stop occupancy, or the v35 low-load class is lost, or if posterior rate occupancy fails to improve

## Pre-evaluation validation

- The prescribed public-contract state returns exactly two finite
  accelerations.  All `84` direct `params.FIELD` references resolve among the
  `86` fields returned by `target_policy_params()`.
- A `750,141`-case direct helper-and-final-guard grid spanning signed anterior
  and posterior rates, anterior and posterior commands, cadence, carrier
  scaling, half-cycle relief, and steering is finite and sign-symmetric to
  numerical tolerance.  The follower is exactly inactive below
  `250 deg/T`, exactly inactive when posterior motion agrees with the carrier
  reference, and every active correction opposes measured posterior motion.
  The signed coast residual remains non-outward at either `260 deg/T`
  boundary.
- A `437,400`-state whole-policy grid spanning distance, target side, bearing
  trend, closing behavior, body velocity, turn rate, both joint positions, and
  both joint rates is finite.  All `262,440` sub-band cases are byte-identical
  to evaluated v35; only the posterior output can change above the existing
  band.
- Conservative scale-one application of the follower helper to the completed
  v35 trace at `omega=13.2` changes `306/4,486` posterior commands from
  `2.079T` through `13.734T`; 302 changes occur above `6.5L`.  Every delta
  opposes posterior velocity and the maximum is `7.669 rad/T^2`, below one
  quarter of the owned acceleration envelope.  This is a fixed-state command
  audit, not a trajectory prediction.
- A `20T` joint-only envelope integration leaves the anterior state exactly
  parent-identical, preserves zero hard-stop samples, and reduces posterior
  exact-rate samples from 84 to 68.  Final posterior angle/rate change by only
  `0.00743 rad` and `0.11064 rad/T`.  This rejects gross local phase
  disruption; only post-exit CFD can establish capture, wake, route, and load
  consequences.
- The configured check-runner was invoked, but its pinned `gpt-5.4-mini` model
  is unsupported on this account.  Its three declared no-CFD commands were
  run directly: the reusable-guidance semantic check, exact Julia
  public-contract check, and solver editable-boundary audit pass.  No formal
  CFD was run.
