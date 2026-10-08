# Candidate wake-policy notes

## Visual and numerical diagnosis before the edit

- All four sampled solver evaluations are finite captures from the required
  direct-uniform still-water initialization with `U_infinity=(0,0,0)`, no
  cylinders, no prewarm snapshot, and no reported instability. Two sampled
  descendants reproduce the prefilled policy's exact `22.187000T` capture,
  `2.106255L` scored mean distance, and `-0.211504` score. The fixed-lead-only
  comparison captures later at `22.307997T`, with `2.107401L` mean distance
  and `-0.212396` score.
- Both visual rows of the strongest sampled policy and the inherited
  response-qualified negative result were inspected from release through
  capture. Their top-down sheets show self-propulsion rather than advection: a
  compact alternating red/blue caudal street forms by `4T`, stays attached
  along the smooth S-shaped route, and persists into the target sphere. Their
  oblique sheets are valid and show discrete three-dimensional Lambda2
  structures behind the caudal region through capture. The fixed-lead sample's
  oblique row is blank, which is a render failure rather than contrary flow
  evidence.
- Adding a proximity-grown half-cycle target-line preview only to the slow
  anterior curvature request produces the current strongest sample. Relative
  to the prefilled proximity-led controller, capture advances from
  `22.187000T` to `22.159500T`, mean distance falls from `2.106255L` to
  `2.105808L`, and score improves from `-0.211504` to `-0.211168`. The route is
  unchanged at `4/8T` (`11.300/8.629L`) and improves at `16/20/22T` from
  `3.983/1.872/0.830L` to `3.980/1.861/0.818L`. Mean action also falls slightly
  from `59.850` to `59.830`; peak normalized force/moment remain exactly
  `0.030897/0.015839`, and anterior/posterior exact-rate-cap occupancy remains
  comparable at `11.47/6.40%`.
- The assigned-parent inherited log supplies the matched negative boundary.
  Capping the proximity-led rudder error gate by the fixed-lead gate so that
  prediction could release but never recruit load exactly restores the slower
  fixed-lead trajectory: `22.307997T`, `2.107401L`, and `-0.212396`, despite a
  valid two-view coherent wake and lower `59.675` mean action. The useful
  response is therefore not a generic steering-release or effort-reduction
  effect; target-line prediction must remain bidirectional on the established
  rudder path.

## One candidate hypothesis

Use the strongest sampled controller as the base. Preserve its through-water
course observation, anterior speed recovery, full body-frame target geometry,
fixed-lead posterior recovery allocation, proximity-led rudder, rudder sign and
ceiling, phase-selective carrier, terminal relief, and the successful
proximity-previewed anterior curvature center. Add one feedback-path change:
apply the same bounded half-cycle, distance-grown target-line preview to the
error magnitude that gates the existing phase-speed-qualified anterior
redirect. Keep instantaneous target lateral geometry for redirect sign and
retain the `16 rad/T^2` redirect ceiling.

This tests coordinated predictive anterior steering rather than another scalar
gain. The sampled preview currently advances the slow mean-curvature path while
the compatible anterior redirect still waits for instantaneous full target
error. Letting measured target-line evolution recruit or release that already
bounded residual should reduce the `12--22T` distance integral without changing
the launch, propulsive carrier, posterior allocations, or authority limits. It
uses only normalized body-frame geometry, distance, joint state, through-water
flow, and the clamped de-yawed bearing response; it adds no clock, coordinate,
route memory, target identity, modeled vortex phase, mutable state, or
force/moment residual.

Falsify the mechanism if capture is lost or not earlier than `22.159500T`,
scored mean distance is not below `2.105808L`, score does not exceed
`-0.211168`, or the unchanged pre-proximity route no longer reaches about
`11.300/8.629L` at `4/8T`. Also reject it if the `16/20/22T` distance sequence
does not improve on `3.980/1.861/0.818L`, mean action materially exceeds
`59.830`, anterior/posterior rate-cap occupancy exceeds `11.47/6.40%`, peak
normalized force/moment exceed `0.030897/0.015839`, or a valid two-view sheet
does not retain the alternating three-dimensional caudal wake. Any gain remains
fixed-pose still-water evidence, not robustness to changed pose, inflow,
hydrodynamics, or external wakes.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and bounded asymmetric fish turning
source_mechanism: preserve a posterior-delayed traveling carrier while measured route evolution schedules a bounded anterior steering residual
transferable_invariant: a slow body-frame target-line response can recruit or release a phase-qualified steering path without increasing its authority or replacing the propulsive rhythm
nontransferable_details: published gains, dimensional frequencies and speeds, species-specific envelopes, distributed-body kinematics, robot calibration, source prediction horizons, exact vortex phases, fixed coordinates, and task-specific routes
policy_translation: reuse the sampled bounded proximity preview only on the existing anterior redirect gate while retaining instantaneous body-frame target side for sign and all completed carrier, recovery, rudder, relief, and authority limits
falsification: reject if capture is not earlier than 22.159500T, mean distance is not below 2.105808L, or route, valid two-view wake, effort, saturation, force, or moment envelopes worsen
