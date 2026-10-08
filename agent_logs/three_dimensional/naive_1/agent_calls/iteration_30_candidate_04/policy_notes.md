# Candidate wake-policy notes

## Visual and numerical diagnosis before the edit

- All four sampled solvers are finite captures from the required direct-uniform
  still-water initialization with `U_infinity=(0,0,0)`, no cylinders, no
  prewarm snapshot, and no reported instability. The prefilled
  velocity-quadrature policy and its comment-only repeat reproduce exactly
  `23.122009T`, `2.133413L` scored mean distance, `0.749507L` crossing, and
  score `-0.237071`.
- Both visual rows were inspected from release through termination. The
  top-down sheets show self-propelled S-shaped approaches with an attached
  alternating red/blue caudal street rather than passive advection or wake
  collapse. The line-of-sight-lead sample has a complete oblique row: discrete
  three-dimensional Lambda2 structures form behind the caudal region by `4T`
  and persist through its earlier capture. The target-error allocation sample
  and one base repeat have blank oblique render artifacts, so their coherent
  top-down wakes do not independently establish the same 3D structure.
- The assigned-parent target-error convex allocation is the best sampled score
  and a partial positive result. It retains the `23.122009T` capture, lowers
  mean distance to `2.127679L`, and improves score to `-0.231273`. It is ahead
  of the base at `4T` and `9T` (`11.300/7.959L` versus
  `11.450/8.096L`) but behind at `12T` and `20T`
  (`6.203/2.104L` versus `6.171/2.029L`), so it recovers the inherited
  whole-carrier launch benefit without recovering the phase-only policy's
  entire later-route advantage. Mean action and anterior/posterior exact
  rate-cap occupancy fall from `60.062` and `11.92/7.06%` to `58.990` and
  `11.68/6.21%`; peak normalized moment falls slightly to `0.015817`, while
  peak normalized force rises slightly from `0.030360` to `0.030527`.
- The independently sampled line-of-sight lead is a distinct semantic
  improvement. It is identical to the base through `9T`, then reaches
  `1.976L` rather than `2.029L` at `20T` and captures `0.550T` earlier at
  `22.572023T`. Mean distance improves to `2.127978L` and score to
  `-0.232481`; the base peak force/moment are unchanged, while mean action and
  rate-cap occupancy rise modestly to `60.545` and `12.09/7.21%`. The
  assigned-parent half-cycle redistribution is the informative negative
  control: it preserved the visible top-down route and capture but delayed it
  to `23.452015T`, raised mean distance to `2.142002L`, and raised peak loads.
  Another phase-local modifier is therefore not justified.

## One candidate hypothesis

Materialize one small compatible combination of the two independently positive
step-29 mechanisms. Use the target-error-allocated posterior recovery policy as
the base, preserving its fixed `0.12` recovery budget and convex blend between
whole-carrier amplitude and anterior-velocity phase lag. Add the sampled,
bounded line-of-sight predictor only to the existing distance-gated posterior
rudder error gate: subtract recent body turn from short-window bearing rate,
clamp the residual to `0.5 rad/T`, and project one `0.55T` carrier cycle ahead.
Keep rudder sign, magnitude, lateral target geometry, carrier, anterior redirect,
and terminal relief unchanged.

The hypothesis is that the allocated carrier can retain its evidenced early
distance-integral benefit while the slow target-line predictor recovers the
independently evidenced late approach and earlier crossing. The two feedback
paths use different observations and gates, but they meet in the posterior
target, so compatibility is unproven rather than assumed. Falsify the
composition if capture is lost or later than `22.572023T`, mean distance
exceeds `2.127679L`, the early `4--9T` lead disappears, or distance at `20T`
exceeds `1.976L`. Also reject it if mean action exceeds `60.545`, exact
anterior/posterior rate-cap occupancy exceeds `12.09/7.21%`, peak normalized
force/moment exceed `0.030527/0.015861`, or a valid two-view sheet does not
retain the established alternating 3D wake. Any gain remains fixed-pose
still-water evidence, not robustness to changed pose or hydrodynamics.

bookshelf_consulted: true
source_domain: elongated-body reactive swimming and sensor-modulated robotic-fish CPG direction tracking
source_mechanism: preserve a posterior-delayed traveling bend while separating bounded gait allocation from a slow measured target-line steering response
transferable_invariant: a fixed posterior carrier budget can be allocated by body-frame steering demand while a target-bearing-change residual, separated from rhythmic body yaw, anticipates only the slow rudder gate
nontransferable_details: published gains, dimensional frequencies and speeds, species-specific envelopes, distributed-body kinematics, robot calibration, exact vortex phases, source-task look-ahead horizons, fixed coordinates, and task-specific routes
policy_translation: convexly allocate the evidenced posterior recovery budget with full body-frame target error, then use clamped `bearing_window_rate - turn_rate_recent` to project only the existing distance-gated rudder error one carrier cycle ahead
falsification: reject if capture is later than 22.572023T or lost, mean distance exceeds 2.127679L, either the early allocation lead or late predictor gain disappears, or valid two-view wake, action, saturation, force, or moment envelopes worsen
