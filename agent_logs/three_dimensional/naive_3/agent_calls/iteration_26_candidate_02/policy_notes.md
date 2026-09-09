# Terminal course-hold candidate

## Evidence diagnosis before the policy edit

- All four sampled rollouts satisfy the frozen Phase 2 contract: direct
  uniform initialization in still water with `U_infinity=(0,0,0)`, no
  cylinders or prewarm, finite dynamics, and `horizon` termination at `100T`.
  I inspected both the top-down mid-plane-vorticity and oblique body/Lambda2
  rows of every combined keyframe sheet. All four fish self-propel and retain
  coherent alternating planar and compact three-dimensional wakes; passive
  advection, wake collapse, collision, domain exit, and instability do not
  explain their misses.
- The assigned parent counterbend (`solver_bac4e1917fd6`) is a concrete
  negative result. It reaches `2.249L` minimum and `4.355L` mean distance,
  better than the response-held C-turn's `2.377/4.458L` and the carrier
  contraction's `2.484/4.545L`, but it retains the same broad orbit and never
  enters `2L`. At its closest pass it still travels at `0.594U` with
  `1.525 rad` target-ray/course error, and its anterior/posterior acceleration
  clamp residence is about `0.730/0.099`. Restoring the wave through a
  yaw-selected posterior counterbend therefore does not supply the missing
  inward course response.
- The sampled course-response curvature reserve (`solver_951085a20092`) is the
  first current mechanism to materially improve the recovery topology. Its
  coherent loops contract to `1.314L`, it spends about `15.9T` inside `2L`
  and `5.4T` inside `1.5L`, improves mean/final distance to
  `4.056/3.077L`, and lowers anterior clamp residence to about `0.249` while
  posterior residence remains `0.103`; its 99th-percentile planar load and yaw
  moment are no larger than the other sampled policies. This is not a scalar
  score-only improvement.
- The remaining capture gap has a localized observable signature. At the best
  pass (`69.283T`) the fish is still moving at `0.652U`, the target is behind
  and lateral in the body frame (`target_unit=(0.789,0.614)`), translational
  velocity is `(-0.451,0.471)U`, target-ray/course error is `1.672 rad`, and
  measured yaw is only `-0.137 rad/T`; the existing nonclosing reserve is only
  `0.461` of its bounded authority. At an earlier `1.616L` pass the target is
  almost exactly lateral, course error remains `1.237 rad`, but the
  target-behind-squared onset releases the reserve nearly completely. The
  strongest candidate therefore has useful inward curvature, but releases it
  during a close, still-tangential crossing and settles into a roughly
  `1.3L` powered orbit.

## Policy hypothesis

Use `solver_951085a20092` as the scaffold, preserving its cruise carrier,
posterior brake and phase lag, geometry-released C-turn, nonclosing
course-response reserve, command limits, and full far/middle trajectory.
Add one continuous terminal course-hold selector: inside a narrow distance
envelope, at finite translational speed, keep the same bounded response
curvature active while target-ray/course alignment remains poor even if the
target is briefly ahead or radial closure is positive. Combine terminal and
existing reserve weights by a bounded union, so the mechanism adds neither a
hidden stage nor new maximum curvature and vanishes before the evidenced first
pass. This tests response persistence across target-side geometry, not a
scalar curvature-gain retune.

Support requires capture, a minimum below `1.31L`, longer residence inside
`1.5L`, or a smaller stable orbit with improved mean/final distance, while
preserving the coherent first pass and comparable clamp/load residence. Reject
if the `2.38L` first pass materially changes, the fish stalls or loses its
alternating wake, loads or posterior clamping rise, or it merely retains a
tight noncapturing orbit.

```text
bookshelf_consulted: true
source_domain: fish terminal-approach control and sensor-modulated robotic-fish CPG direction tracking
source_mechanism: preserve the productive propulsive carrier, but hold bounded steering through a near-target tangential crossing until measured course alignment appears
transferable_invariant: far and middle pursuit can release steering by broad geometry, whereas terminal capture should retain bounded target-relative turn authority while finite-speed course remains misaligned
nontransferable_details: species-specific approach stages, published CPG gains, dimensional beat frequency, exact vortex phase, capture radius, world coordinates, and task-specific routes
policy_translation: a normalized body-frame distance envelope, translational-speed weight, and target-ray/course dot product extend the existing reflection-equivariant curvature-reserve selector without changing its bound or two-joint carrier
falsification: reject if the first pass changes, propulsion or wake coherence degrades, clamp/load residence rises, or no capture, closer pass, longer near-target residence, or smaller useful orbit appears
```

## Evaluation boundary

The candidate has no same-worker CFD evidence. Frozen-trace selector replay
and dry controller checks after the edit can establish locality, boundedness,
reflection equivariance, parameter ownership, and finite actions only. EvE
performs the coupled CFD evaluation after this worker exits.

## Implemented candidate and non-CFD probes

The candidate starts from the completed course-response curvature policy and
adds four owned parameters for one terminal selector. The selector forms a
bounded union with both the existing recovery blend and its curvature reserve;
it uses only normalized distance, translational speed, and target-ray/course
dot product. It introduces no clock, stage state, world coordinate, route,
target identity, file access, or new maximum steering authority.

Frozen replay on the completed `solver_951085a20092` trace makes the terminal
weight exactly zero through `2T`, with mean/maximum `0.0017/0.0177` through the
first `20T`. At the preserved `2.377L` first pass it is `0.0164`, changing the
effective recovery blend only from `0.0008` to `0.0172` and requesting about
`0.12 deg` of the bounded reserve. At the diagnosed `1.616L` lateral crossing
it raises the recovery blend to `0.453` and the combined reserve weight to
`0.405`; at the `1.314L` minimum it raises reserve use from `0.461` to `0.736`
(`3.66` to `5.85 deg`). On states beyond `3L`, its mean/maximum weight is only
`0.00009/0.00116`. These are selector-locality results, not coupled-flow
predictions.

All `44` direct parameter references are returned by
`target_policy_params()`. Representative cruise, terminal, zero-speed, and
large finite probes produce finite actions within the declared
`+/-28 rad/T^2` reserve; mirrored target, velocity, joint, bearing, and yaw
states negate both actions to within `1e-10`. The required material-guidance
check, lightweight Julia policy contract, deterministic parameter-schema
guard, and solver editable-boundary check pass. No formal CFD was run.
