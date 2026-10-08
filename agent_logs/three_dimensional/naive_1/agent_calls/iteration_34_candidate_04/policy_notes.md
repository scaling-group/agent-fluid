# Candidate wake-policy notes

## Visual and numerical diagnosis before the edit

- All four sampled evaluations are finite captures from the required direct
  uniform still-water initialization with `U_infinity=(0,0,0)`, no cylinders,
  no prewarm snapshot, and no reported instability. The assigned parent is the
  best sample: it captures at `22.159500T`, with `0.748393L` crossing distance,
  `2.105808L` scored mean distance, and score `-0.211168`. Two executable-
  equivalent descendants without anterior course preview reproduce exactly
  `22.187000T`, `0.748118L`, `2.106255L`, and `-0.211504`; the fixed-lead-only
  comparison captures at `22.307997T`, with `2.107401L` mean distance and score
  `-0.212396`.
- Both rows of the assigned-parent and fixed-lead comparison sheets were
  inspected from release through capture. Their top-down rows show
  self-propulsion rather than advection: a compact alternating red/blue
  mid-plane street forms behind the caudal region by `4T`, follows the curved
  S-route, and remains coherent through the target crossing. The assigned
  parent's oblique row is complete and shows discrete three-dimensional
  Lambda2 structures following the moving caudal region at `4/12/20T` and
  capture. The weaker comparison's oblique row is black after its frame labels,
  so it is a render-evidence failure and supplies no independent 3D-wake claim.
- The sampled sequence isolates two compatible prediction paths. Extending
  only posterior-rudder prediction with the normalized `8.0--5.5L` proximity
  gate advances capture from `22.307997T` to `22.187000T`. Adding the same
  bounded de-yawed target-line preview only to the slow anterior curvature
  request advances it again to `22.159500T` and lowers mean distance from
  `2.106255L` to `2.105808L`. The assigned-parent route is unchanged through
  `8T`, then reaches about `6.148/3.980/1.861/0.818L` at
  `12/16/20/22T`, versus `6.148/3.983/1.872/0.830L` without the course preview.
- The gain is a route-allocation result, not free thrust. Relative to the two
  no-course-preview repeats, mean action falls only from `59.850` to `59.830`,
  anterior/posterior exact-rate-cap occupancy remains comparable at
  `11.47/6.40%` versus `11.53/6.40%`, and peak normalized force/moment remain
  exactly `0.030897/0.015839`. Reconstructing the normalized observations from
  the parent trace shows full head-relative error near `0.70--0.79 rad` over
  `12--20T`; the half-cycle proximity preview raises the smooth anterior
  redirect gate by only about `0.04--0.07` while the clamped de-yawed target-
  line rate has the same sign as the current error. Thus the still-
  instantaneous anterior redirect is an untested bounded allocation path.
- The inherited response-qualified negative control is decisive about sign:
  allowing proximity prediction only to release posterior rudder regresses
  exactly to the fixed-lead `22.307997T`, `2.107401L`, `-0.212396` result. The
  useful current mechanism therefore includes predicted recruitment when
  target-line motion reinforces error; it should not be converted into a
  release-only rule. Earlier inherited failures also rule out increasing the
  recovery share, stacking posterior angle amplitude, unloading the successful
  velocity quadrature near the rate cap, or adding the unqualified yaw-moment
  residual.

## One candidate hypothesis

Preserve the assigned parent's through-water course observation, anterior
speed recovery, full body-frame target geometry, proximity-previewed slow
curvature center, fixed-lead posterior recovery allocation, proximity-led
reactive rudder, phase-selective traveling carrier, and stroke-qualified
terminal relief. Add one separately named response path: use at most a half
carrier cycle of the already clamped de-yawed target-line rate, grown by the
existing proximity gate, to predict only the full-angle error magnitude that
recruits the anterior redirect. Keep the instantaneous redirect gate on
posterior carrier relief and half-cycle shaping, and keep the `16 rad/T^2`
anterior redirect ceiling and every existing parameter value unchanged.

The hypothesis is that the parent now anticipates both slow anterior mean
curvature and posterior steering while its complementary anterior burst still
waits for current error. The sampled parent trace predicts that this new gate
will recruit a small amount of existing target-signed anterior acceleration
over `12--20T`, when line-of-sight motion is worsening alignment, without
changing the launch, carrier phase, posterior target, or any authority limit.
This is a bounded body-frame observation-to-actuator allocation, not scalar
tuning. It adds no clock, step count, coordinate, route memory, target identity,
external phase, force/moment residual, or mutable state.

Falsify the mechanism if capture is lost or later than `22.159500T`, scored
mean distance exceeds `2.105808L`, score does not exceed `-0.211168`, or the
unchanged pre-proximity route no longer reaches about `11.300/8.629L` at
`4/8T`. Also reject it if the `12/16/20/22T` distance sequence does not improve,
mean action exceeds `59.850`, anterior/posterior exact-rate-cap occupancy
materially exceeds `11.47/6.40%`, peak normalized force/moment exceed
`0.030897/0.015839`, or valid top-down and oblique sheets do not preserve the
established alternating three-dimensional wake. Any positive outcome remains
fixed-pose still-water evidence, not robustness to changed pose, inflow,
hydrodynamics, or external wakes.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and bounded biological burst redirect
source_mechanism: preserve a posterior-delayed propulsive rhythm while predicted measured target-line demand recruits a separate anterior redirect without changing its ceiling
transferable_invariant: a bounded body-frame response predictor can advance a target-signed anterior redirect while leaving the traveling carrier and posterior load paths intact
nontransferable_details: published gains, dimensional frequencies and speeds, species-specific envelopes, distributed-body kinematics, robot calibration, source prediction horizons, exact vortex phases, fixed coordinates, and task-specific routes
policy_translation: apply at most a half-cycle of clamped `bearing_window_rate - turn_rate_recent` through the existing proximity gate only to the smooth anterior-redirect error gate, while every carrier, posterior, threshold, and authority value remains unchanged
falsification: reject if capture is later than 22.159500T or lost, mean distance exceeds 2.105808L, the pre-proximity route changes, or valid two-view wake, action, saturation, force, or moment envelopes worsen
