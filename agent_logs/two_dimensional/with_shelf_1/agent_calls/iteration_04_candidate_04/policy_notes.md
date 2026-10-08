# Multi-wake candidate diagnosis

## Evidence read before the policy edit

- The shared prewarm sheet shows the fish held above and downstream of four
  staggered cylinders while their wakes develop into interacting vortex
  streets. The target sits inside the merged second-row wake. This is the
  common initial condition and not candidate-specific evidence.
- All four sampled released sheets, metrics, and policies represent the same
  steering-prioritized carrier/residual controller and reproduce the same
  finite success: `target_reached` after `49.1424`, final/minimum distance
  `0.749267L`, mean distance `2.15598L`, head displacement
  `(-10.9144,-4.20656)L`, and command-energy mean `1272.25`.
- Visually, the successful fish is self-propelled rather than merely advected.
  It makes a sharp initial clockwise correction, establishes a long upstream
  traverse through the merged wake, and reaches the target without a visible
  collision or late reversal. The metrics agree: progress is `0.939692`, mean
  velocity inferred from displacement and arrival is leftward/downward, and
  RMS relative crossflow remains finite at `0.230062`.
- The four samples also reproduce actuator contact and load evidence:
  `max_abs_phi_ddot=(30,30)`, both joint speeds reach the episode limit, and
  RMS force/moment are `39.049/617.129`. Exact repetition under the same held
  prewarm is a deterministic comparison baseline, not evidence of robustness
  to a different wake phase.
- The most informative inherited failure is the slower/smaller
  curvature-equilibrium trial: it became unstable after `121.517`, stayed at
  least `9.238L` from the target, and raised RMS relative crossflow/force/moment
  to `1.138/16749.8/290421` despite lower mean command energy `419.1`.
  Therefore the validated `0.55`-period traveling-bend carrier, same-sign
  bearing residual, and bounded allocator should remain intact.

## Policy hypothesis

The visible initial redirect is useful, but constant bearing-only steering
cannot distinguish target error from lateral motion already carrying the fish
toward that target. Preserve the successful bearing residual and add a small,
smoothly regularized body-frame course-slip damping term before its existing
saturation. This is a new feedback mechanism, not a scalar gait retune:
lateral body velocity in the same direction as the target reduces redundant
steering, while opposite slip increases correction. The carrier, steering
sign, joint split, envelope, and reserve allocator remain unchanged.

Expected result: retain `target_reached` and leftward propulsion while
softening the sharp redirect or wake-driven lateral excursions enough to
reduce command effort, force/moment load, or limit contact. Falsify the edit if
arrival is lost or delayed materially, the route returns to the lower-domain
exit topology, RMS loads grow, or effort fails to improve without a route or
load benefit.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop direction tracking and wake-interaction control
source_mechanism: sensor feedback modulates a rhythmic carrier; persistent route error is separated from lateral disturbance motion
transferable_invariant: retain the propulsive rhythm and correct the bounded body-frame direction request by measured lateral slip rather than treating all lateral motion as new target error
nontransferable_details: published CPG gains, robot geometry, species kinematics, exact vortex phases, dimensional speeds, and source-task routes
policy_translation: subtract a small bounded body-frame course-slip signal, regularized to vanish at zero speed, from bearing before the existing two-joint acceleration residual and steering-prioritized allocator
falsification: reject if target reach or upstream progress is lost, if the lower-exit topology returns, or if effort and force/moment loads do not improve without another measurable trajectory benefit
