# Course-error steering candidate

## Evidence and visual diagnosis

- All four sampled rollouts satisfy the direct-uniform still-water contract
  (`U_infinity=0`, no cylinders, no prewarm). Their top-down rows show
  self-propelled leftward motion and an alternating, coherent wake through the
  useful approach; the oblique Lambda2 rows confirm three-dimensional shed
  structures rather than background advection.
- The strongest closest approaches are the static and response-gated
  full-quadrant redirects (`2.999L` and `2.989L`), but both pass above the
  target and hook upward into `left_domain`. In the static redirect the joints
  settle near `(-0.175,-0.209) rad` after `18T`; in the response-gated case the
  carrier decays toward zero anterior mean while the same wrong-way yaw
  continues. The `3.592L` approach hold likewise suppresses the carrier after
  the miss. These are not recovery arcs.
- The anterior half-cycle policy has the best scalar score and final distance
  (`-7.690`, `6.014L`) but worsens closest approach to `4.859L`; its visible
  wake remains alternating while sampled raw acceleration reaches the envelope
  much more often (about `0.872` of trajectory samples by the logged command
  columns versus `0.584` for the static redirect). It is not evidence that
  stronger phase asymmetry improves targeting.
- The common path exposes a course/heading mismatch before any late redirect.
  At about `4T` in the static-redirect rollout, body velocity is approximately
  `(-0.15,+0.30)U`, so actual course is `+1.09 rad` from the head-facing axis
  while target bearing is only `+0.19 rad`. The inherited linear residual
  `bearing - 0.45*lateral_velocity` is still about `+0.05 rad`, so it does not
  request the opposite correction even though the fish is translating toward
  the high side. At `12T`, course bearing is about `+0.68 rad` while target
  bearing has crossed to `-0.04 rad`; the high pass is already established.

## Policy hypothesis

Replace the dimensional linear-slip residual with a bounded signed angle
between actual body-frame velocity course and the body-frame target vector.
Blend from heading bearing at low translational speed to course error once the
velocity direction is meaningful, then use that request only in the existing
posterior mean-curvature channel. This preserves the demonstrated
zero-centered traveling carrier and acts during the approach instead of
freezing it after the target has passed. The candidate is falsified if it
raises limit occupancy materially, destroys the alternating wake, fails to
reduce the roughly `3L` high miss, or repeats the upper exit without a
meaningfully lower/body-frame-course-correcting trajectory.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG direction tracking
source_mechanism: sensor feedback modulates a stable rhythmic carrier for direction tracking
transferable_invariant: preserve the propulsive rhythm while bounded feedback acts on observed target-relative course error
nontransferable_details: published CPG gains, clock phase, robot geometry, species kinematics, and task-specific routes
policy_translation: compute target and velocity directions from normalized body-frame observations, speed-gate their signed angular error, and map it to bounded posterior mean curvature
falsification: reject if course feedback loses coherent propulsion, materially increases saturation, does not improve closest approach, or preserves the same pass-and-upper-exit topology
