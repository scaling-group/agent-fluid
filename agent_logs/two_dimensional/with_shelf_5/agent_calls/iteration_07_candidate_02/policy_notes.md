# Multi-wake course-alignment candidate

## Evidence diagnosis

- The shared prewarm sheet shows the common held fish above and downstream of
  four fully developed, interacting vortex streets; it is initial-condition
  evidence rather than a candidate difference.
- The best finite sampled rollout (`solver_09b5b834b2ae`, reproduced exactly by
  `solver_a64551a56856` and `solver_5049b3347a65`) reaches the target without
  collision or instability in `43.9505` released time. Its six-frame sheet
  shows a correct-sign initial redirect, an alternating self-generated body
  wake, and final entry into the cylinder-wake corridor. Mean velocity differs
  from mean local flow by about `(-0.113, 0.054)`, so the fast displacement is
  not passive advection. The remaining visible inefficiency is the early hooked
  path: the body turns sharply before the realized trajectory straightens onto
  the target course.
- The clean half-cycle ablation `solver_a520b6aa6665` is the most informative
  sampled comparison because no failed keyframe sheet is present in this
  workspace. Removing the `2.5L` amplitude taper leaves the same visible path,
  termination, `43.9505` arrival, actuator cap hits, and approximately
  `49.4/701` RMS force/moment. Tapering changes mean distance only from
  `2.1412L` to `2.1391L`; this does not support another scalar terminal
  schedule. The inherited seed failure remains the relevant negative boundary:
  target-blind motion was advection dominated and exited the lower domain.

## Policy hypothesis

Preserve the demonstrated `0.55`-period traveling-bend carrier, bounded
body-frame bearing bias, posterior lag, half-cycle steering allocation, and
existing approach envelope. Add one bounded course-alignment residual to the
route error: compare target bearing with the direction of the measured
body-frame velocity, and enable the residual smoothly only when forward speed
is resolved. This distinguishes where the fish points from where it is moving,
so wake advection and inertia cannot make a transiently aligned body suppress
steering too early. The expected useful change is a straighter early redirect,
smaller distance integral, and no new load or saturation class; the final wake
entry and capture topology should remain intact.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG direction tracking
source_mechanism: sensor feedback modulates a stable rhythmic gait using the error between desired direction and measured motion
transferable_invariant: retain the propulsive rhythm while a bounded feedback residual corrects disagreement between target course and realized course
nontransferable_details: published CPG gains, robot geometry, dimensional speeds, species-specific kinematics, exact vortex phase, and task-specific routes
policy_translation: form target and velocity-course angles only from normalized body-frame observations, gate the course residual by observed forward speed, and feed it into the existing two-joint bearing-to-curvature loop
falsification: reject the residual if it preserves the same hook and arrival, causes low-speed sign chatter or a trajectory reversal, loses target capture, collapses the traveling bend, or raises force, moment, or saturation without a distance-integral benefit

