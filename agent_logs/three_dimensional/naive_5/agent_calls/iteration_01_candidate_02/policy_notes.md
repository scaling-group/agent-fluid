# Candidate diagnosis and policy hypothesis

## Available inherited evidence

The assigned parent guidance is the fresh-lineage contract and contains no
completed candidate lesson beyond its evidence-reading rules. No inherited
optimizer log is present. The only sampled solver is the common naive seed
`solver_5c7c5c0e3ed9`, so it is simultaneously the strongest finite example
available and the informative failure; there is no second sampled rollout to
compare.

The rollout is valid direct-uniform still water (`U_infinity=0`) with no
cylinders or prewarm. In both the top-down mid-plane and oblique Lambda2 views,
the fish visibly self-propels and sheds an increasingly strong three-dimensional
wake, but its path curls broadly toward the upper virtual boundary instead of
settling onto the target direction. The body is nearly horizontal by 5T, then
continues rotating and translating upward; the curved wake at 8T agrees with a
control-driven turn rather than passive advection in the quiescent background.

The scalar and trace evidence agree with that diagnosis. Distance falls only
from 12.328L to 12.078L, then rises to 12.380L before `left_domain` at 8.547T.
Instantaneous heading rate spans about -2.79 to +2.24 rad/T. Joint speed reaches
the 260 deg/T cap, while raw acceleration requests reach roughly 60 and
75 rad/T^2, beyond the 1800 deg/T^2 envelope. Thus the existing coherent drive
is useful, but its short-period, large-amplitude carrier leaves little clean
steering authority and has no target-dependent mechanism to arrest the curl.

## Hypothesis

Retain the joint-state oscillator and posterior lag, but place the carrier in a
sub-limit regime and add one target-to-curvature mechanism. A bounded body-frame
bearing sets a desired turn rate; the error between that desired rate and the
recent measured turn rate produces a bounded mean posterior-joint bend. This
should initiate the small required target turn, reverse the bias when yaw
overshoots, preserve an alternating traveling bend around the mean, and avoid
the seed's speed/acceleration clipping. It is falsified if the next rollout
keeps the same broad upper-boundary curl, loses coherent downstream wake and
forward progress, or still spends material time at joint limits.

```text
bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG direction tracking and mean-curvature or tail-beat-bias turning
source_mechanism: sensor feedback modulates the mean bend of an otherwise rhythmic propulsive gait
transferable_invariant: persistent body-frame target error should create bounded curvature, while observed turn response should release or reverse that curvature without erasing the alternating wave
nontransferable_details: published gains, robot or species kinematics, clock-driven phase, exact vortex phase, and task-specific routes
policy_translation: normalized bearing defines a bounded desired yaw rate; recent body turn rate closes the loop; their error shifts only the posterior joint's mean target inside the existing two-joint state-feedback oscillator
falsification: reject the transfer if target progress does not outlive 8.55T, the upper-boundary curl persists, propulsion visibly collapses, or joint speed and acceleration remain persistently clipped
```
