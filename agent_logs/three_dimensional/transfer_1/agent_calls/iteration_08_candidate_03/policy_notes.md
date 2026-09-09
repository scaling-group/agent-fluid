# Wake-policy candidate diagnosis

## Evidence read before editing

- All four sampled solver episodes are finite, self-propelled
  `left_domain` failures from direct-uniform still water with
  `U_infinity=[0,0,0]`, no cylinders, and no prewarm. Both the top-down
  vorticity and oblique Lambda2 rows of all four combined sheets were
  inspected. They show coherent alternating wakes rather than ambient
  advection or numerical instability, so the `0.55T`, `28 deg` traveling-bend
  carrier remains the behavior to preserve.
- The prefilled phase-compensated bearing policy and achieved-course rate
  cascade keep nearly horizontal, wake-producing trajectories above the target
  and reach only `3.0031L` and `3.1135L`. The sampled mean-curvature and
  reserve-guarded half-cycle alternatives acquire the lower route but turn
  sharply downward and exit below after reaching `1.5454L` and `1.7708L`.
  At their closest sampled rows they still travel at `0.809L/T` and
  `0.779L/T`; target-normal speed is `0.745L/T` and `0.750L/T`. Sub-`3L`
  acceleration-envelope occupancy is about `72.6%/75.6%` for mean curvature
  and `61.6%/60.5%` for the reserve guard. The visible late wake is therefore
  propulsive but the terminal motion is mostly transverse to the capture line.
- The assigned parent's inherited terminal target-normal-velocity response is
  now evaluated: adding up to `5 deg` posterior mean tangent to the
  carrier-aligned `0.9532L` pass worsened closest approach to `1.0561L` and
  retained `left_domain` termination. This falsifies that additive curvature
  response as a capture fix, even though it was normalized, bounded, and
  inactive outside `3L`.
- A sampled alternate inherited log supplies a cleaner positive mechanism:
  response-triggered release of shared steering, without carrier attenuation,
  improved a `1.0435L` course-servo near miss to `0.9312L`. It still exited
  the domain, but it is the closest completed result available here and
  supports preserving both the achieved-course outer loop and the
  phase-compensated steering-release actuator rather than adding authority.

## Candidate mechanism and falsification

Start from the complete `0.9312L` response-released course servo. Add one
terminal approach-hold channel: compute the rotation-invariant body-frame
target-normal velocity and compare its magnitude with nonnegative closing
speed. Only inside `3L`, smoothly reduce carrier cadence when transverse
motion dominates closure. Retain carrier amplitude, posterior lag, direct
course steering, and the existing yaw-response release. This reallocates
limited acceleration away from rapid thrust production without adding mean
curvature, suppressing one beat half, reversing the route request, or using a
clock or world route.

Expected test: the far-field route and wake remain identical to the `0.9312L`
baseline; during the close pass, cadence relief reduces transverse momentum
and carrier acceleration occupancy while preserving alternating excursion,
giving the response-released steering enough time and headroom to cross the
remaining `0.181L` into the capture disk.

Falsification: reject if behavior outside `3L` changes, closest approach fails
to beat `0.9312L`, the terminal wake or joint excursion collapses, saturation
grows, or the same fast lower exit remains. In that case do not add more
curvature or course gain; test a non-propulsive-damping line-of-sight response
or a bounded phase-lag actuator with independently evidenced sign.

bookshelf_consulted: true
source_domain: terminal capture control and sensor-modulated robotic-fish rhythmic locomotion
source_mechanism: preserve the propulsive rhythm while near-target yaw or slip damping reduces excess approach motion
transferable_invariant: after route acquisition, use normalized response feedback to reduce excess terminal propulsion without erasing the traveling carrier
nontransferable_details: published gains, dimensional cadence, species or robot kinematics, prescribed CPG phase, exact vortex phases, and task-specific routes
policy_translation: inside a body-frame distance gate, reduce state-feedback oscillator cadence only when normalized target-normal velocity dominates nonnegative closing speed, while retaining carrier amplitude and response-released course steering
falsification: reject if the sub-0.9312L pass, saturation, coherent wake, joint excursion, or lower-exit termination class does not improve

## Non-CFD verification

- Replaying the new observation-to-cadence gate over the four sampled traces
  confirms it is identically zero at and beyond `3L`. The two sampled lower
  near misses have mean/max sub-`3L` gates of `0.353/0.727` and
  `0.323/0.615`; at closest approach their cadence multipliers are `0.855` and
  `0.877`. Thus the translated mechanism is localized and materially gentler
  than stopping the carrier.
- Every direct `params.FIELD` reference is owned by
  `target_policy_params()`, with no unused active field. The Julia 1.12.6
  policy-call smoke returns two finite bounded accelerations. The material
  guidance and solver editable-boundary checks pass; no CFD result is claimed.
