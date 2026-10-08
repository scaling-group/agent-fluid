# Course-gated terminal carrier relief

## Visual diagnosis and inherited evidence

- All four sampled rollouts, the assigned parent's completed rollout, and the
  alternate inherited near miss use direct uniform still-water initialization
  with `U_infinity=(0,0,0)`, no cylinders, and no prewarm. Peak local-flow
  speed remains only `0.027--0.032U` while body speed reaches
  `0.947--1.052U`, so the trajectories and wakes are controller-generated.
- The sampled `2.989L` response-released carrier and `2.999L` held redirect
  show the established failure in both visual rows: a coherent alternating
  mid-plane vorticity street and three-dimensional Lambda2 shedding propel the
  broad approach, then the joints lose rhythmic corrective work and the path
  hooks into the upper boundary. The sampled anterior stiffness asymmetry
  remains visibly rhythmic but reaches only `4.859L`, lowers peak speed to
  `0.947U`, and raises raw acceleration-envelope exceedance to about
  `53/64%`; altering anterior restoring stiffness is not supported.
- The assigned parent's receding-gated anterior counterstroke brake preserves
  the roughly `2.960L` approach and lowers raw acceleration-envelope
  exceedance to about `41/51%`, versus about `57/67%` for its immediate
  response-gated posterior predecessor. It modestly improves final distance
  from `7.027L` to `6.853L`, but still exits through the upper boundary at
  `24.893T`. Selective dissipation can manage effort without supplying the
  missing net yaw; more counterstroke-brake tuning is not a recovery mechanism.
- The alternate inherited velocity-course controller is the only semantic
  trajectory change in the available evidence. Its top-down and oblique rows
  retain alternating wake structures through the target neighborhood, change
  the common upper hook to a long left-boundary trajectory, and reach
  `0.831873L`, only `0.081873L` outside capture. Increasing its posterior mean
  curvature from `12` toward `18 deg` inside `3L` improves its parent's
  reproduced `0.857L` near miss only marginally. At closest approach
  (`19.074T`) speed is still `0.846U`, wrapped target-ray/course error is
  `-1.379 rad`, the turn request and scheduled curvature are saturated, and
  raw acceleration-envelope exceedance remains about `58/68%`. More scalar
  steering gain or another global curvature increase is therefore unsupported.

## Policy hypothesis

Start from the alternate inherited velocity-course controller and preserve its
zero-centered anterior oscillator, lagged traveling carrier, full-quadrant
target-ray/course feedback, and evidenced distance-scheduled posterior
curvature. Add one terminal allocation mechanism: only inside `1.5L`, and only
when the wrapped velocity course materially misses the target ray, smoothly
reduce the oscillatory posterior carrier toward a `0.70` floor while retaining
the complete mean-curvature steering channel and anterior rhythm.

The course-error gate is phase-insensitive because both angles are measured in
the same normalized body frame; unlike instantaneous yaw rate, their wrapped
difference does not inherit the body's beat rotation. The expected result is
the same broad approach and alternating wake, followed by less transverse
overshoot and more turning distance during the final body length, moving the
`0.832L` pass inside the `0.75L` capture boundary without a held bend. Reject
the mechanism if it changes the trajectory outside `1.5L`, loses the sub-`1L`
approach, suppresses the alternating wake, coasts before capture, raises limit
occupancy, or fails to improve termination class.

```text
bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG direction tracking and terminal capture control
source_mechanism: preserve the slow steering bias while sensor feedback reduces rhythmic drive only in a misaligned near-target regime
transferable_invariant: once broad target-directed propulsion works, separate final steering authority from excess carrier drive and schedule only the latter from normalized distance and target-ray versus velocity-course alignment
nontransferable_details: published CPG gains, dimensional speed thresholds, linkage or species kinematics, clock phase, exact vortex phase, and task-specific routes
policy_translation: keep the joint-state oscillator and bounded posterior curvature of the inherited near miss; inside 1.5L use wrapped body-frame target-ray/course error to mildly attenuate only the posterior oscillatory target while retaining anterior rhythm and mean curvature
falsification: reject if pre-terminal motion changes, the alternating wake or sub-1L approach is lost, the fish coasts before capture, actuator-limit occupancy rises, or termination does not improve
```
