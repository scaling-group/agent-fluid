# Candidate wake-policy notes

## Visual and numerical diagnosis before the edit

- All four sampled solvers are finite captures from the required direct-uniform
  still-water initialization with `U_infinity=(0,0,0)`, no cylinders, no
  prewarm snapshot, and no reported instability. The assigned parent and two
  executable-identical samples reproduce the exact `22.187000T` capture,
  `0.748118L` crossing, `2.106255L` scored mean distance, and `-0.211504`
  score. The distinct course-preview sample is the best finite result:
  `22.159500T`, `0.748393L`, `2.105808L`, and `-0.211168`.
- Both rows of the best course-preview sheet and the repeated-parent control
  were inspected from release through capture. Their top-down rows show
  self-propulsion rather than advection: a compact alternating red/blue street
  grows behind the caudal region, stays attached along the S-shaped route, and
  remains coherent at capture. The best sample's oblique row shows discrete
  three-dimensional Lambda2 structures following the caudal region at
  `4/12/20T` and capture. The repeated parent's black oblique row is a render
  failure and supplies no independent 3D-wake claim.
- The isolated sampled difference is positive but narrow. Adding at most one
  half-cycle of proximity-weighted, clamped de-yawed target-line preview to
  only the slow anterior curvature request leaves the route unchanged through
  `9T`, then improves distance at `12/16/20T` from
  `6.1482/3.9827/1.8720L` to `6.1478/3.9796/1.8606L`. Mean action falls
  slightly from `59.850` to `59.830`, anterior/posterior exact-rate-cap
  occupancy remains comparable at `11.47/6.40%`, and peak normalized
  force/moment remain exactly `0.030897/0.015839`. This is evidence for a
  bounded route-allocation mechanism, not more carrier or rudder gain.
- The inherited optimizer logs provide two decisive negative controls that
  are not visible in the four current scalar summaries. A response-qualified
  release-only posterior gate becomes trajectory-identical to the slower
  fixed-lead controller (`22.307997T`, `2.107401L`). More importantly, two
  executable-identical descendants extend the same preview through the entire
  proximity interval to the phase-coupled anterior redirect. They gain at
  `12/16T` (`6.1455/3.9781L`) but fall behind the course-preview parent by
  `18/20/22T` (`2.9333/1.8820/0.8692L` versus
  `2.9271/1.8606/0.8175L`), delaying capture to `22.285997T`, raising mean
  distance to `2.106929L`, and regressing score to `-0.212075`. Loads remain
  bounded, so the failure is late route over-allocation rather than
  instability or wake collapse.

## One candidate hypothesis

Use the completed course-preview policy as the base. Preserve its through-water
course observation, anterior speed recovery, proximity-previewed curvature
center, full body-frame target geometry, fixed-lead posterior recovery
allocation, proximity-led reactive rudder, phase-selective traveling carrier,
stroke-qualified terminal relief, and every authority ceiling.

Add one response path with an explicit middle/near separation. Form a smooth
middle-approach window as `4 * distance_gate * (1 - distance_gate)`, using the
existing normalized `8.0--5.5L` proximity schedule. Apply at most the already
sampled half-cycle of clamped de-yawed target-line preview through that window
only to the anterior redirect magnitude gate. The preview is therefore zero
before approach recruitment, peaks while proximity is transitioning, and
returns exactly to the successful instantaneous redirect once the posterior
rudder is fully recruited. Current target-side geometry continues to select
redirect sign, and all posterior paths remain unchanged.

The hypothesis is that the middle-only window can retain the inherited
redirect-preview trajectory gain near `12T` without carrying its harmful burst
allocation through the `18--22T` terminal route. This is a state-dependent
allocation change rather than a scalar gain increase, and it adds no clock,
step count, fixed coordinate, route memory, target identity, external phase,
force/moment residual, or mutable state. Falsify it if capture is lost or not
earlier than `22.159500T`, mean distance is not below `2.105808L`, or score
does not exceed `-0.211168`. Also reject it if the unchanged `4/8/9T` route
moves materially, the `12T` gain is absent, the `18/20/22T` sequence is worse
than `2.9271/1.8606/0.8175L`, mean action exceeds `59.830`, exact
anterior/posterior rate-cap occupancy materially exceeds `11.47/6.40%`, peak
normalized force/moment exceed `0.030897/0.015839`, or valid top-down and
oblique sheets fail to retain the established alternating three-dimensional
wake. Any gain remains fixed-pose still-water evidence, not robustness to
changed pose, inflow, hydrodynamics, or external wakes.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and distance-scheduled terminal capture
source_mechanism: preserve a posterior-delayed propulsive rhythm while confining a predicted phase-coupled redirect to the middle approach and returning to the completed terminal controller near capture
transferable_invariant: bounded body-frame steering augmentation can correct middle-approach displacement without remaining active after a separately capped terminal steering path is fully recruited
nontransferable_details: published gains, dimensional frequencies and speeds, species-specific envelopes, distributed-body kinematics, robot calibration, source prediction horizons, exact vortex phases, fixed coordinates, and task-specific routes
policy_translation: window the clamped `bearing_window_rate - turn_rate_recent` anterior-redirect preview by `4 * distance_gate * (1 - distance_gate)`, while retaining the completed course preview, current redirect sign, traveling carrier, posterior allocations, and every authority ceiling
falsification: reject if capture is not earlier than 22.159500T, mean distance is not below 2.105808L, the inherited middle gain or terminal route is lost, or valid two-view wake, action, saturation, force, or moment envelopes worsen

## Verification without CFD

- The required guidance-delta check, lightweight policy contract, and solver
  boundary check pass. The configured check-runner agent itself was
  unavailable on this account, so its three commands were executed directly
  and separately as specified by `.codex/agents/check-runner.toml`.
- Deterministic state tests confirm that the candidate matches the completed
  course-preview parent before the proximity transition and after full rudder
  recruitment, differs within the middle window, returns finite two-joint
  accelerations, and preserves lateral-reflection equivariance.
- Every one of the 34 direct `params.FIELD` references names a field returned
  by `target_policy_params()`, and every returned field is used. No CFD rollout
  was run; the candidate hypothesis remains unevaluated until EvE executes it.
