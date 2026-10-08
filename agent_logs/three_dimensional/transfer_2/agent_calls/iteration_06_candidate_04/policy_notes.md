# Multi-wake target-policy candidate notes

## Evidence diagnosis before the edit

- All four sampled evaluations satisfy the frozen evidence contract: direct
  uniform still-water initialization (`U_infinity=[0,0,0]`), no cylinders or
  prewarm, finite dynamics, and moving-window transport. Their translation
  and wakes are self-generated, not imposed advection.
- Both top-down vorticity and oblique Lambda2 rows were inspected for every
  sampled solver. The common `0.55T`, `28 deg` posterior-lagged carrier forms
  an organized alternating mid-plane street and compact three-dimensional
  vortex packets in all four. Body speed remains about `0.63--0.69U` after
  the closest pass while local flow is only about `0.02U`; wake collapse or
  ambient crossflow is not the remaining failure.
- The assigned/prefilled abeam-burst candidate reaches `3.035L` and exits left
  at `(0.799,6.853)L` after `40.210T`. The persistent-route candidate reaches
  `2.999L` and exits left at `(0.799,6.983)L` after `40.887T`, while the
  original phase-selective parent reaches `3.033L` and exits left at
  `(0.797,5.995)L` after `40.331T`. These nearly coincident westward runouts
  show that a `3 deg` abeam bend and route/response channel separation do not
  supply recapture authority; another threshold or direct-steering gain would
  repeat a completed negative.
- The strongest finite sample is qualitatively different. Its `7 deg`
  target-passage curvature burst preserves the first approach, reaches
  `3.031L`, produces a visible late hairpin, survives to `49.319T`, and
  improves final distance to `7.528L`. It then exits the upper boundary at
  `(4.230,15.201)L`. From `24T` through `48T`, speed stays near `0.64U`, the
  target remains behind and strongly lateral in the body frame, and the
  velocity-to-target course cross-error remains roughly `-0.76` to `-1.00`.
  The recapture bend therefore has real turn authority but drives an
  unbraked, translation-dominated orbit rather than reacquisition.
- Inherited negatives rule out a globally slower carrier, an always-on mean
  bend, another cadence gate as the sole mechanism, and another subcycle-yaw
  release. The open test is to preserve the evidenced burst but separate its
  turning curvature from posterior propulsive authority only on the observed
  target-behind geometry.

## Policy hypothesis

Start from the evaluated target-passage recapture sample. Preserve its action
bit-for-bit while the target is ahead, including the coherent carrier,
off-axis curvature release, phase-selective opposing-half-cycle relief, and
the bounded mirror-equivariant recapture bend. Add one compact mechanism in
the posterior target: as the normalized recapture request grows, continuously
unload only the oscillatory posterior carrier toward a nonzero floor while
leaving the mean recapture curvature intact. Full posterior wave authority
returns continuously as forward/lateral geometry is reacquired.

This converts the already-evidenced hairpin into a lower-translation pivot and
release maneuver without a clock, hidden stage, world-frame route, or global
cadence change. Expected evidence is the same first pass through about `3.03L`,
followed by a tighter turn inside the virtual field and a second targetward
approach instead of the upper exit. Falsify the mechanism if it changes any
target-ahead action, destroys the alternating wake, stalls without
reacquisition, materially worsens joint/load exposure, or retains either the
westward runout or the large upper orbit without a closer or semantically
better trajectory.

bookshelf_consulted: true
source_domain: biological C-start redirection and sensor-modulated robotic-fish CPG maneuver control
source_mechanism: separate a strong bounded curvature response from the propulsive carrier, then restore posterior beating as observed route geometry is recovered
transferable_invariant: large-error recapture can temporarily trade posterior propulsive wave authority for turning curvature and release continuously back to cruise from body-frame feedback
nontransferable_details: species-specific C-start shape, published gains, motor timing, dimensional cadence, clock-driven phase, exact vortex phase, and task-specific routes
policy_translation: use the existing normalized behind/lateral recapture request as a reflection-invariant magnitude gate that unloads only posterior oscillatory target amplitude while retaining the signed mean tail curvature in the two-joint state-feedback carrier
falsification: reject the transfer if the proven first approach changes, wake coherence is lost, the fish stalls, loads worsen materially, or recapture still ends in a left or upper exit without a closer or meaningfully useful second approach

## Pre-evaluation checks

- Fixed-state reconstruction over all `8,967` states of the evaluated
  passage-recapture trace leaves all `4,058` target-ahead actions bit-for-bit
  identical. The new carrier-unloading branch first activates at `21.670T`,
  after the proven first approach, and is active on `4,858` recorded states.
  Its posterior-wave scale remains in `[0.405,1.0]` on the trace under the
  configured `[0.40,1.0]` bound.
- On those same fixed recorded states, exposure to at least one reconstructed
  raw command beyond `1800 deg/T^2` decreases from `92.785%` to `86.740%`.
  The maximum instantaneous posterior action difference is
  `50.100 rad/T^2`, reflecting deliberate carrier unloading rather than an
  added acceleration bias. This replay establishes selectivity and bounded
  algebraic behavior only; it cannot predict the closed-loop path, stall
  margin, or hydrodynamic loads.
- A `5,103`-state grid over mirrored body-frame target geometry, joint state,
  bearing trend, and yaw rate remains finite. The recapture request is
  antisymmetric, its posterior-wave scale is reflection invariant, and every
  sampled scale lies inside `[0.40,1.0]`.
- The required check-runner was invoked, but its pinned model is unavailable
  for this account. Its three prescribed no-CFD commands were therefore run
  directly and separately: reusable-guidance semantic change, lightweight
  Julia public contract, and solver editable-boundary checks all pass. All
  `63` direct `params.FIELD` references resolve among the `65` fields returned
  by `target_policy_params()`. Formal CFD remains deferred to EvE.
