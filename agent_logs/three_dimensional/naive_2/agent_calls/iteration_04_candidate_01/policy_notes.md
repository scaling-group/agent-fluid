# Wake-policy candidate notes

## Evidence and visual diagnosis before editing

- The assigned parent guidance and inherited notes preserve the common
  `0.55T` joint-state carrier, posterior lag, and shared half-cycle steering.
  Prior static/mean-curvature variants either weakened translation or made a
  wrong-way loop, while the sampled course-residual plus joint-rate-barrier
  combination removed all logged `260 deg/T` contacts but still exited the
  upper boundary at `9.135T` and reached only `11.643L`.  Rate reserve by
  itself is therefore not evidence of useful route control.
- All four sampled evaluations satisfy the direct-uniform still-water
  contract: diagnostics report `uniform_direct`, `U_infinity=(0,0,0)`, no
  prewarm, and no cylinders.  Their motion and wakes are self-generated.
- In the strongest finite sample, `solver_a4eae6d626b3`, the top-down row
  shows a coherent alternating wake growing behind a fish that travels
  `3.801L` left, but also climbs `1.202L` into the upper virtual boundary at
  `10.324T`; the target remains below-left.  The oblique row shows connected
  three-dimensional Lambda2 structures behind the posterior body and tail,
  so its improved translation is productive self-propulsion rather than
  advection.  Distance falls monotonically at termination to `9.759L`.
- The informative fixed-authority shared-half-cycle sample,
  `solver_77089a0404da`, has the same alternating three-dimensional wake and
  upper-exit topology, but travels only `2.041L` left and reaches `11.347L`.
  Thus response-gated authority is a real progress mechanism even though it
  does not yet change the termination class.  Its cost is higher joint-rate
  occupancy: the parent has about `80/81` hard-rate samples versus `21/57`
  for fixed authority, while both retain smooth commands below `30 rad/T^2`.
- The parent gate uses `max(-bearing * velocity_body_y, 0)`.  Reconstructing
  the normalized body-frame histories exposes its applicability boundary.
  At `7T` and again near `10T`, the bearing and full line-of-sight course
  residual have the same sign, meaning the velocity course is diverging from
  the target line, but body-frame lateral velocity alone has the target-side
  sign and releases the redirect.  Near `10T` the parent therefore falls back
  from roughly `0.65` to `0.35` authority while the fish is still too high.
  The target-direction/velocity cross product includes the forward-velocity
  contribution that the lateral-only gate omits.

## Single candidate hypothesis

Retain the evaluated carrier, bearing-minus-lateral-response turn request,
posterior emphasis, and bounded acceleration.  Change only the redirect
condition from lateral slip to a normalized line-of-sight course residual:
compute the signed cross product of unit `target_body_L` with
`velocity_body_U`, and raise the asymmetry ceiling when its sign agrees with
the bearing.  This preserves the parent's strong propulsion/progress while
keeping redirect authority active when forward motion carries the fish across
the wrong side of the target line.  It is falsified if the same upper exit
persists without improved closest approach or horizon, if leftward propulsion
or wake coherence deteriorates, or if the longer redirect materially worsens
rate-limit occupancy or loads.

```text
bookshelf_consulted: true
source_domain: biological C-start redirect and robotic-fish sensor-modulated asymmetric flapping
source_mechanism: preserve the propulsive rhythm, increase bounded turn authority when observed course diverges from the requested direction, and release when course response recovers
transferable_invariant: normalized body-frame target geometry and measured translational course can gate a bounded redirect without a clock, fixed route, or prescribed vortex phase
nontransferable_details: species-specific C-start shapes, robot linkage geometry, published gains, dimensional frequencies, duty ratios, exact vortex phases, and task-specific routes
policy_translation: retain the evaluated half-cycle controller but gate its higher authority with positive bearing times the normalized target-direction/velocity cross product instead of lateral velocity alone
falsification: reject if termination topology and closest approach do not improve together, or if propulsion, coherent alternating wake, actuator occupancy, or load histories deteriorate
```

## Dry validation (not rollout evidence)

The mandated guidance, finite-action policy-contract, parameter-schema, and
editable-boundary checks pass.  A grid over joint state, bearing, body-frame
target direction, and velocity is finite, stays below the configured smooth
`30 rad/T^2` envelope, and is exactly reflection equivariant to floating-point
precision (`max_error=0.0`).  A reconstructed late-parent wrong-course state
activates the new redirect gate at `0.9996`, while velocity aligned with the
same target direction releases it to zero.  These checks establish only the
intended normalized state-feedback semantics; the next CFD evaluation must
decide every trajectory, wake, rate-occupancy, load, and termination falsifier.
