# Bidirectional phase-consistent speed-allocation candidate

## Evidence-led visual diagnosis recorded before the policy edit

- All four sampled rollouts report direct uniform still-water initialization
  with `U_infinity=(0,0,0)`, no cylinders, and no prewarm. Every case captures;
  therefore the informative failure in this sample is failure to improve the
  mechanically unsafe soft-envelope reference, not a failed termination.
- I inspected the combined top-down-vorticity and oblique-Lambda2 sheets from
  release through capture for the strongest soft-envelope reference and both
  one-way `0.94` speed-allocation variants. Each top-down row shows the body
  translating toward the target while an alternating red/blue street grows
  behind it, without a standing wiggle or one-sided collapse. Each oblique row
  retains compact three-dimensional structures around and behind the caudal
  region through the final approach. The metrics support self-propulsion:
  sampled peak body speeds are `1.383--1.395U`, whereas peak local flow is only
  `0.0315--0.0329U`.
- The duplicated unguarded soft-envelope reference remains the scalar and
  route leader: capture at `16.943T`, mean distance `2.08985L`, score
  `-0.205386`, and force/yaw-moment peaks `0.03609/0.01766`. Its unresolved
  defect is exact `260 deg/T` occupancy for `3.73/3.54%` of the two joint
  traces. The inherited no-transfer `0.94` positive-work guard removes those
  contacts but captures at `17.115T` with mean distance `2.09800L`.
- Both sampled one-way reallocations improve on that guarded reference without
  restoring a hard-speed contact. Posterior-to-anterior allocation captures at
  `17.060T`, reaches mean distance `2.09311L`, peaks at
  `258.92/259.19 deg/T`, and has `0.03546/0.01767` force/moment peaks.
  Anterior-to-posterior allocation captures at `17.053T`, reaches mean
  distance `2.09541L`, peaks at `258.92/259.19 deg/T`, and has
  `0.03631/0.01750` peaks. Thus each phase-local branch recovers part of the
  guard cost, but neither alone recovers the reference's route score.

## Single-candidate policy hypothesis

Start from the captured soft-envelope body-frame velocity-course controller
and retain its zero-centered anterior oscillator, lagged posterior carrier,
terminal steering reserve, acceleration shoulder, high-onset positive-work
speed guard, and continuous posterior angle projection. Combine the two
sampled one-way speed-allocation branches into one bidirectional layer. First
guard each original command independently and measure the removed
speed-increasing acceleration. Because the donor must be above the `0.94`
guard onset while a receiver gate closes by `0.90`, only one transfer direction
can be active at a time. Admit transfer only into a receiver already doing
positive joint work, fade it with normalized receiver-speed headroom, and cap
it by a sub-limit acceleration reserve. This preserves braking, steering sign,
and carrier phase rather than routing clipped magnitude solely by nominal joint
identity.

Expected result: retain capture, coherent alternating three-dimensional
shedding, and zero exact speed-limit occupancy while combining the arrival
benefit of anterior-to-posterior allocation with the mean-distance and load
benefit of posterior-to-anterior allocation. Falsify the mechanism if capture
is lost, either speed limit is touched, the wake becomes standing or one-sided,
arrival fails to beat `17.053T`, mean distance fails to beat `2.09311L`, peak
force/moment exceeds `0.0361/0.0177`, or posterior angle use exceeds the
unguarded reference's `0.5907 rad`.

```text
bookshelf_consulted: true
source_domain: robotic-fish closed-loop central-pattern-generator control
source_mechanism: sensor feedback modulates coupled low-dimensional rhythmic actuators while preserving their carrier phase relation
transferable_invariant: redirect only unavailable positive work into another actuator that is already in a compatible positive-work phase and has normalized state headroom
nontransferable_details: published CPG gains, dimensional frequencies, species-specific envelopes, full-body kinematics, exact vortex phases, and task-specific routes
policy_translation: use normalized joint-speed fractions and joint-state phase to make the two guarded-work transfer directions mutually exclusive, positive-work consistent, and bounded by receiver speed and acceleration headroom
falsification: reject if speed contact returns, capture or alternating three-dimensional shedding is lost, both one-way route references are not improved, or force, moment, and posterior-angle peaks exceed the soft-envelope bounds
```
