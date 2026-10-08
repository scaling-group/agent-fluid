# Candidate wake-policy notes

## Visual and numerical diagnosis before the edit

- All four sampled solvers are finite captures from the required direct-uniform
  still-water initialization with `U_infinity=(0,0,0)`, no cylinders, no
  prewarm snapshot, and no reported instability. The two executable-identical
  no-course-preview samples reproduce exactly `22.187000T` capture,
  `0.748118L` crossing, `2.106255L` scored mean distance, and score
  `-0.211504`. The fixed-rudder-lead comparison is the informative weaker
  finite result: it captures at `22.307997T`, with `2.107401L` mean distance
  and score `-0.212396`.
- Both visual rows were inspected from release through termination. Every
  sampled top-down row shows self-propulsion rather than advection: an
  alternating red/blue mid-plane street forms behind the caudal region by
  `4T`, remains attached along the S-shaped approach, and persists through
  capture. The assigned-parent sheet is the only current complete oblique
  view; its discrete three-dimensional Lambda2 structures persist behind the
  rhythmic caudal region at `4T`, `12T`, `20T`, and capture. The other three
  oblique rows are black render artifacts and provide no independent 3D-wake
  evidence.
- Applying at most one half-cycle of proximity-weighted, de-yawed target-line
  preview to only the slow anterior curvature request is a small reproduced
  semantic gain. Relative to the two no-course-preview samples, the assigned
  parent advances capture from `22.187000T` to `22.159500T`, lowers mean
  distance from `2.106255L` to `2.105808L`, and improves score from
  `-0.211504` to `-0.211168`. The route is unchanged through `9T`, then
  distance improves at `16/20/22T` from `3.982730/1.872011/0.829695L` to
  `3.979636/1.860628/0.817512L`.
- That route gain does not enlarge the measured load envelope. Peak normalized
  force/moment remain exactly `0.030897/0.015839`; mean action falls slightly
  from about `59.850` to `59.830`, anterior exact-rate-cap occupancy falls
  from `11.53%` to `11.47%`, and posterior occupancy remains about `6.40%`.
  The separately inherited response-qualified minimum gate is a concrete
  negative control: it is trajectory-identical to the `22.307997T` fixed-lead
  policy because the proximity prediction reinforces error on this route, so
  a release-only minimum cannot express the observed useful response.

## One candidate hypothesis

Preserve the assigned parent's through-water course observation, anterior
speed recovery, proximity-previewed anterior curvature center, full body-frame
target geometry, fixed-lead posterior recovery allocation, proximity-led
reactive rudder, phase-selective carrier, and stroke-qualified terminal relief.
Compute a separate smooth anterior-redirect gate from the full target error
plus the same bounded, proximity-weighted half-cycle target-line preview already
validated on the curvature path. Use that predicted gate only in the existing
anterior redirect acceleration. Keep instantaneous target geometry on the
redirect sign and on all posterior carrier-shaping paths, and keep every gain,
threshold, authority ceiling, gait parameter, and actuator limit unchanged.

The current route retains only moderate instantaneous full target error at
`16T` and `20T` (about `-0.067` and `+0.354 rad`) while the validated
target-line trend is already improving the slow curvature response. The
hypothesis is that prediction can recruit the existing anterior redirect as
the error is growing, before its current-error gate reaches `0.45 rad`, without
adding authority or perturbing the completed posterior allocations. This is a
single observation-to-actuator scheduling mechanism using normalized
body-frame geometry, distance, measured line-of-sight response, and joint
state. It adds no clock, step count, coordinate, target identity, route memory,
modeled vortex phase, force/moment residual, or mutable state.

Falsify the mechanism if capture is lost or later than `22.159500T`, scored
mean distance exceeds `2.105808L`, score does not exceed `-0.211168`, or the
unchanged pre-proximity route no longer reaches about `11.300/8.629/7.929L`
at `4/8/9T`. Also reject it if the `16/20/22T` distance sequence fails to
improve, mean action exceeds about `59.830`, anterior/posterior exact-rate-cap
occupancy materially exceeds `11.47/6.40%`, peak normalized force/moment
exceed `0.030897/0.015839`, or valid top-down and oblique sheets fail to retain
the established alternating 3D wake. A positive fixed-pose still-water result
would establish compatible state scheduling, not robustness to changed pose,
inflow, hydrodynamics, or external wakes.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and bounded asymmetric fish turning
source_mechanism: preserve a posterior-delayed propulsive rhythm while measured target-line evolution schedules a bounded anterior turning response
transferable_invariant: body-frame target-line prediction may recruit an existing phase-coupled steering path before current error grows, without increasing its authority or replacing the traveling carrier
nontransferable_details: published gains, dimensional frequencies, species-specific envelopes, distributed-body kinematics, robot calibration, source prediction horizons, exact vortex phases, fixed coordinates, and task-specific routes
policy_translation: use the existing clamped `bearing_window_rate - turn_rate_recent` and normalized proximity gate to predict only the anterior redirect magnitude gate, while retaining current target-side sign and all completed posterior paths
falsification: reject if capture is later than 22.159500T or lost, mean distance exceeds 2.105808L, the pre-proximity route changes, or valid two-view wake, action, saturation, force, or moment envelopes worsen
