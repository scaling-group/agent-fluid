# Intercept-qualified redirect candidate

## Visual and trace diagnosis before the edit

- All four sampled evaluations are contract-valid direct-uniform still-water
  rollouts (`U_infinity=(0,0,0)`, no cylinders, no prewarm). The top-down
  vorticity and oblique Lambda2 rows therefore show self-propulsion and a
  body-generated three-dimensional wake, not imposed advection or moving-window
  transport.
- The assigned parent, `solver_b6ed3f84ab58`, has the best scalar score
  (`-7.654`) but its posterior half-cycle redistribution is a negative control,
  not a useful steering advance. Both visual rows retain an alternating wake,
  yet its centerline stays above the target and ends at the upper margin near
  `(8.770,15.201)L` after `26.043T`; minimum distance is `5.386L`, worse than
  the unredistributed `solver_8b43d67d5abc` carrier's `4.516L`. It also spends
  `2.9%` of samples at or above `44.5 deg` and produces peak planar force and
  yaw moment of about `0.211` and `0.0968`, roughly ten times the maxima in the
  other long-wake samples. This falsifies headroom-gated posterior wave
  asymmetry as a safe second steering channel in its tested form.
- `solver_4365157e5ac8` is the strongest semantic trajectory despite its worse
  final-distance score. Its top-down row visibly turns the wake down through
  the target neighborhood, while the oblique row preserves a coherent
  three-dimensional trail through the redirect and later recovery loop. It
  reaches `1.165L` at `27.055T`, versus `4.516--6.268L` for the other samples,
  without touching the angle boundary; speed- and acceleration-limit residence
  falls to about `32.8%` and `35.5%`. The run is stable but passes the target
  and exits left, so this validates a large-error two-joint redirect while
  falsifying its release logic as sufficient for capture.
- At closest approach the head is `(8.184,10.331)L`, planar speed is about
  `0.679L/T`, closing speed has fallen to nearly zero, and the normalized
  velocity/target cross product predicts a `1.165L` miss. The local body-frame
  flow is only about `(-0.018,0.001)U`, so the miss is not passive crossflow.
  Earlier, from `18--23T`, the redirect weight falls to roughly `0.02--0.14`
  when phase-rejected yaw has the requested sign, even as the projected miss
  stays about `2.5--3.9L` and generally worsens. Correct-sign yaw is therefore
  a response observation, but it is not evidence that the translating body is
  on a capture course.

## Policy hypothesis

Discard the parent's falsified posterior redistribution and recover the sampled
state-feedback traveling carrier plus bounded same-sign two-joint redirect that
produced the `1.165L` approach. Change one controller semantic: qualify the
redirect's yaw-based release by measured interception. Compute the projected
miss distance from the normalized body-frame target and velocity vectors, and
permit release back to the propulsive wave only when that miss lies inside a
small body-length corridor and `closing_speed_L` is positive. Large bearing,
a course outside that corridor, or receding motion retains bounded redirect
authority. The construction remains continuous, reflection-equivariant, and
memoryless; it uses no time, world coordinate, target identity, or prescribed
route.

Expected evidence is a downward approach that preserves the coherent carrier
but crosses inside `0.75L`, or at minimum improves on `1.165L` before a lower
and later exit. Falsify the refinement if it over-turns before reaching the
target neighborhood, returns to the early upper-boundary topology, remains in
a static bend after acquiring an intercept, destroys the alternating 3D wake,
or restores the parent's large loads or actuator-limit residence.

bookshelf_consulted: true
source_domain: biological C-start redirects and sensor-modulated robotic-fish direction tracking
source_mechanism: use a bounded large-error body bend, then release into the rhythmic carrier only after sensed motion demonstrates useful directional response
transferable_invariant: a transient redirect should release on task-relevant kinematic response rather than yaw sign alone, while preserving the propulsive rhythm once an intercept is acquired
nontransferable_details: species-specific C-start timing and shape, published gains, clocked CPG phase, robot linkage geometry, dimensional cadence, exact vortex phases, capture route, and world coordinates
policy_translation: infer phase from joint state, retain the sampled body-frame bearing/course turn side, and multiply yaw-based release by smooth gates on normalized projected miss distance and positive observed closing speed
falsification: reject if intercept qualification prevents timely release, worsens the 1.165L approach, collapses the coherent wake, repeats an upper exit, or increases boundary and load exposure

## Non-CFD implementation audit

The candidate is finite at zero speed and exact reflection tests negate both
joint accelerations to machine precision. Replaying it on the frozen
`solver_4365157e5ac8` states changes mean absolute command by about
`4.00 rad/T^2` over the diagnosed `18--23T` premature-release interval while
reducing frozen-state acceleration-clamp incidence from `35.5%` to `34.0%`.
This checks that the new semantic is active without adding clamp exposure; it
does not predict the unevaluated fluid or trajectory response.
