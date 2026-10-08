# Phase-reversal posterior follower candidate

## Evidence diagnosis before the policy edit

- All four sampled rollouts satisfy the frozen evidence contract: direct
  uniform initialization in still water with `U_infinity=[0,0,0]`, no
  cylinders or prewarm, finite dynamics, and inertial moving-window
  transport.  Three are byte-identical v34 posterior-coast captures at
  `25.0635T`, minimum/final distance `0.749973L`, mean distance `2.35222L`,
  and score `-0.452083`; the distinct v27 course-preview control captures
  earlier at `24.5795T` and `0.746968L` but has a worse mean distance
  (`2.36044L`) and score (`-0.460673`).
- Both rows of the v34 and v27 combined keyframe sheets were inspected.  The
  top-down sequences start wake-free, translate under their own propulsion,
  form coherent alternating mid-plane streets along the long diagonal
  approach, and execute bounded terminal hooks into the capture disk.  The
  oblique rows show compact three-dimensional Lambda2 structures persisting
  through the redirect.  The small terminal difference is a controller
  trajectory difference, not passive advection, wake breakup, or numerical
  instability.
- The assigned-parent and inherited logs make v34 the mechanism to preserve.
  Relative to the v32 braking-reserve control, v34 retains capture, zero
  sampled posterior hard-stop occupancy, and the low peak planar
  force/yaw-moment class (`0.0244/0.0337/0.0162`), while lowering
  posterior/any-joint exact-rate occupancy from `5.806/15.163%` to
  `4.586/13.869%`.  It is not a complete saturation cure: raw acceleration
  exposure rises slightly to `73.93%`, and the untouched anterior anchor
  accounts for `9.282%` exact-rate occupancy.
- The inherited dual-joint rate barriers are the informative failures.  They
  reduce exact-rate occupancy to `0.236%` or zero, but change capture into
  coherent pass-and-turn exits after `0.933L` and `0.848L` near misses.
  Therefore lower saturation alone cannot justify another shared rate band,
  inward barrier, or scalar threshold retune.
- The v34 trace localizes a different defect.  Its 243 samples within
  `0.000053 rad/T` of the posterior rate boundary occur from `2.090T` through
  `14.383T`, with mean absolute posterior angle only `0.0621 rad` and maximum
  `0.1724 rad`; they are centerline transits, not stroke-stop events.  Using
  the controller's own follower reference
  `-q1 - drive_tail_lag_gain*qd1/omega`, its derivative estimated from the
  measured anterior rate and bounded anterior command points opposite the
  saturated posterior velocity in 221 of those 243 rows at the conservative
  high end of the sampled cadence range (and 237 at the base cadence).  The
  dominant posterior defect is therefore continuation of an old half-cycle
  after its upstream wave reference has already reversed.

## Policy hypothesis

Preserve v34's course preview, steering-priority allocation, posterior stroke
reserve, coast boundary, cadence, and anterior state-feedback oscillator.  Add
one role-separated follower mechanism before the coast guard: differentiate
the existing anterior-derived posterior carrier target using observed
anterior rate and the bounded current anterior acceleration command.  When
the posterior joint is already in the owned high-rate band and its velocity
opposes that reference velocity, add only the bounded reference-velocity term
missing from the current damped target follower.  Do not act when posterior
motion agrees with the reference, do not alter the anterior output, and retain
the coast guard as the final one-sided envelope layer.

This is phase-reversal feedforward, not a new rate gain or a global barrier.
It should begin posterior reversal because the upstream traveling-wave target
has reversed, while leaving the established wave and route unchanged outside
the high-rate mismatch.  Expected evidence is capture in the v34 trajectory
family, coherent three-dimensional wake, zero posterior hard-stop occupancy,
the existing low-load class, and posterior/total rate occupancy below
`4.586/13.869%`.  Falsify it if capture or the far route changes materially,
the correction acts while follower and reference velocities agree, hard-stop
contact returns, peak planar load leaves the roughly `0.035` class, or rate
occupancy does not improve.  The new CFD outcome is not available to this
worker and is not claimed here.

bookshelf_consulted: true
source_domain: Lighthill elongated-body reactive swimming and sensor-modulated coupled-oscillator robotic-fish control
source_mechanism: an anterior phase anchor propagates a lagged traveling bend to a posterior reactive-thrust follower whose phase is corrected from proprioceptive state
transferable_invariant: preserve wave direction and anterior phase while using the upstream reference reversal, rather than rate magnitude alone, to correct a lagging posterior follower
nontransferable_details: published gains, dimensional cadence, species kinematics, full-body amplitude envelopes, exact vortex phases, Strouhal targets, motor models, and task-specific routes
policy_translation: differentiate the existing posterior carrier target from observed anterior joint rate and bounded anterior acceleration, normalize activation by the owned posterior rate band, and add bounded mirror-equivariant reference-velocity feedforward only when posterior motion opposes the new carrier direction
falsification: reject if capture, established route, coherent wake, zero posterior hard-stop occupancy, or the low-load class is lost, or if posterior rate occupancy fails to improve on v34

## Pre-evaluation validation

- The public contract loads and returns exactly two finite accelerations.  All
  `84` direct `params.FIELD` references resolve among the `86` fields returned
  by `target_policy_params()`; no clock, step, random, cylinder, target-ID,
  route, or file-I/O token appears in the candidate.
- The new helper is exactly sign-symmetric on a `7,875`-state grid spanning
  both joint-rate signs, anterior commands, posterior commands, cadence, and
  carrier scaling.  All `3,375` sub-band cases are byte-identical to v34.
- Applying the helper to the completed v34 trace at a conservative
  `omega=13.2` changes `306/4,557` posterior commands.  Every correction
  opposes measured posterior velocity; none accelerates it.  The largest
  correction is `7.67 rad/T^2`, below one quarter of the owned acceleration
  envelope.  This fixed-trace audit does not predict the altered trajectory.
- A `20T` joint-only envelope integration leaves the anterior result exactly
  unchanged, preserves zero hard-stop samples, and reduces posterior exact-rate
  samples from `106` to `100`; final posterior angle/rate changes by only
  `0.0096 rad` and `0.0455 rad/T`.  This rejects gross local phase disruption,
  but only post-exit CFD can establish capture, wake, route, and load effects.
- The configured check runner was invoked, but its pinned `gpt-5.4-mini`
  model is unsupported on this account.  Its three declared no-CFD commands
  were therefore run directly and separately: the reusable-guidance semantic
  check, exact Julia public-contract check, and solver editable-boundary audit
  all pass.  No formal CFD was run.
