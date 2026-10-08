# Candidate diagnosis and hypothesis

## Evidence read before the edit

All four sampled rollouts satisfy the direct-uniform still-water contract:
`U_infinity=(0,0,0)`, no prewarm, and `capture` termination. Their combined
top-down sheets show self-propelled motion with a persistent alternating
reverse-wake street rather than passive advection. The oblique Lambda2 sheets
show the same posterior-originating three-dimensional structures persisting
from release to capture; none shows wake collapse or instability. The visual
differences are subtle, so the trajectory and score histories determine the
useful control distinction.

The strongest finite example, `solver_c668b8e0b865`, is the error-qualified
line-of-sight controller: score `-0.0813954`, mean score-distance `1.967391L`,
capture at `17.7265T`, center path `12.8468L`, maximum straight-line head
cross-track `0.5120L`, and final target-course alignment `0.601`. The most
informative lower-performing example is the prefilled
`solver_6a68ab190967`: it sends the line-of-sight residual only through mean
curvature and captures at `18.6175T` with score `-0.0912779`, mean distance
`1.978602L`, path `13.6033L`, cross-track `0.7700L`, and final course
alignment `-0.530`. The two unqualified line-of-sight variants are
intermediate. `solver_ea4eb1868930` captures at `17.8750T` with score
`-0.0871032`, path `12.9663L`, and final course alignment `0.113`;
`solver_da4e7c2190b0` adds direct terminal course steering but slips to
`17.8805T` and `-0.0886814` with essentially unchanged RMS force and moment.
Thus the evidence favors current-error qualification and the ordinary dynamic
turn channel, while direct terminal course correction and mean-curvature-only
allocation are negative controls. There is no sampled failure-class rollout.

## Policy hypothesis

Start from `solver_c668b8e0b865`, preserving its posterior-priority carrier,
odd target-to-curvature map, rate governor, smooth far-distance release, and
target-error-qualified line-of-sight correction. Add one semantic mechanism:
outside the approach regime, use normalized target-course misalignment as an
authority gate, not as an additive steering command. When the measured course
already closes on the target, body yaw and bearing can still oscillate with
the gait; suppressing the route residual in that condition should avoid
turning against useful momentum. When the course departs from the target, the
winning line-of-sight correction recovers continuously. This does not alter
terminal control and does not attenuate propulsion.

Expected result: retain capture and the coherent wake while reducing the
`0.5120L` cross-track/path excess and preserving or improving the `17.7265T`
arrival and `1.967391L` mean distance. Reject the mechanism if the course gate
removes the early line-of-sight benefit (slower `4L` crossing or arrival), if
path/cross-track rises toward the mean-curvature-only rollout, or if wake
coherence, force/moment scale, capture, or actuator behavior degrades.

```text
bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG direction tracking and wake-aware swimming control
source_mechanism: sensor feedback modulates a low-dimensional rhythmic command while useful carrier motion is preserved
transferable_invariant: give a corrective residual authority only when normalized target-relative motion shows that correction is needed
nontransferable_details: clocked CPG equations, published gains, robot and species kinematics, exact vortex phase, and task-specific routes
policy_translation: smoothly gate only the far, body-frame target-error-qualified line-of-sight residual with measured target-course misalignment; preserve the two-joint carrier and established approach controller
falsification: reject if early closure, capture, path, cross-track, wake coherence, loads, or actuator behavior regresses relative to solver_c668b8e0b865
```
