# Candidate wake-policy notes

## Visual and numerical diagnosis before the edit

- All four sampled solvers are finite captures from the required direct-uniform
  still-water initialization with `U_infinity=(0,0,0)`, no cylinders, no
  prewarm snapshot, and no instability. The assigned parent is the best: it
  captures at `22.159500T`, with `0.748393L` crossing distance, `2.105808L`
  scored mean distance, and score `-0.211168`. Three executable-distinct but
  semantic-equivalent comparisons without anterior course preview reproduce
  `22.187000T`, `0.748118L`, `2.106255L`, and `-0.211504` exactly.
- Both rows of the assigned-parent and one repeated comparison sheet were
  inspected from release through capture. Their top-down rows show
  self-propulsion rather than advection: a compact alternating red/blue street
  forms behind the caudal region by `4T`, follows the curved S-route, and
  remains attached through capture. The parent's complete oblique row shows
  discrete three-dimensional Lambda2 structures following the moving caudal
  region at `4/12/20T` and capture. The comparison's oblique row is black
  after its labels, so it is a render-evidence failure and not an independent
  3D-wake confirmation.
- The inherited completed anterior-redirect preview is a decisive negative
  control. It preserves capture, the same complete two-view wake, peak
  normalized force/moment (`0.030897/0.015839`), and nearly identical
  anterior/posterior exact-rate-cap occupancy (`11.50/6.37%`), while slightly
  lowering mean action from `59.830` to `59.794`. Nevertheless, capture moves
  back to `22.285997T`, mean distance rises to `2.106929L`, and score regresses
  to `-0.212075`. Its route is marginally ahead at `12/16T`
  (`6.146/3.978L` versus `6.148/3.980L`) but behind by `20/22T`
  (`1.882/0.869L` versus `1.861/0.818L`). Do not spread the de-yawed
  target-line predictor into the anterior burst or treat lower effort as a
  route improvement.
- The parent still applies its full target-signed anterior redirect whenever
  geometric error is large, independent of measured hydrodynamic yaw response.
  Offline reconstruction from the trace gives target-signed moment magnitude
  near `0.0044--0.0049` at the median and about `0.0070--0.0076` at the 90th
  percentile over `12T` through capture, with a maximum below `0.0105` in that
  interval. Target-signed moment is absent during the high-error `0--8T`
  launch, occurs on about half the high-error samples after `12T`, and has
  `0.96--0.98` correlation with the next `0.0055--0.055T` change in
  target-signed yaw rate. This supplies a signed, normalized response signal
  for releasing redundant redirect effort without changing the early route.

## One candidate hypothesis

Preserve the assigned parent's through-water course observation, anterior
speed recovery, full body-frame target geometry, proximity-previewed slow
curvature center, fixed-lead posterior recovery allocation, proximity-led
reactive rudder, phase-selective traveling carrier, and stroke-qualified
terminal relief. Add one hydrodynamic response gate only to the anterior
redirect: smoothly release that redirect as target-signed normalized yaw
moment grows from zero to `0.008`, while leaving it unchanged for adverse yaw
moment. No positive residual is added, and every posterior target, carrier
term, geometry gate, and acceleration ceiling remains unchanged.

The hypothesis is that the current controller redundantly retains its burst
while the measured fluid load is already accelerating yaw toward the target.
Yielding only on that evidenced load half-cycle should keep the unchanged
launch and propulsive rhythm, reduce competing late steering, and recover a
straighter `20--22T` approach. This is a causal observation-to-actuator
allocation, not a gain increase: moment sign comes from current normalized
body-frame target geometry, its response scale comes from the parent trace,
and the two-joint state-feedback carrier continues to infer phase from joint
state. It adds no clock, step count, coordinate, target identity, route memory,
external phase, mutable state, or prescribed wake phase.

Falsify the mechanism if capture is lost or later than `22.159500T`, mean
distance exceeds `2.105808L`, score does not exceed `-0.211168`, or the
unchanged launch no longer reaches about `11.300/8.629L` at `4/8T`. Also reject
it if the `12/16/20/22T` distance sequence worsens, mean action exceeds
`59.830`, anterior/posterior exact-rate-cap occupancy materially exceeds
`11.47/6.40%`, peak normalized force/moment exceed `0.030897/0.015839`, or
valid top-down and oblique sheets do not preserve the established alternating
three-dimensional wake. A positive fixed-pose still-water result would not
establish robustness to changed pose, inflow, hydrodynamics, or external
wakes.

bookshelf_consulted: true
source_domain: bounded biological burst redirect and wake-responsive fish control
source_mechanism: release a transient redirect when measured target-signed body response appears, while preserving the delayed propulsive rhythm
transferable_invariant: target-signed hydrodynamic response can smoothly yield a bounded steering path without cancelling the carrier or adverse-load authority
nontransferable_details: published gains, dimensional moment scales, species-specific burst envelopes, distributed-body kinematics, robot calibration, exact vortex phases, fixed coordinates, and task-specific routes
policy_translation: use `geometric_turn * moment_z_L2` to release only the existing anterior redirect over the parent-evidenced normalized moment range, leaving adverse moment, posterior recovery, rudder, carrier, and all ceilings intact
falsification: reject if arrival or mean distance fails to beat `22.159500T/2.105808L`, the launch changes, or valid two-view wake, action, saturation, force, or moment envelopes worsen
