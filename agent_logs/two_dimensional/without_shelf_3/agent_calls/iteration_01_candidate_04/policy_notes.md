# Wake-policy candidate notes

## Evidence diagnosis

- The assigned parent guidance and sampled optimizer guidance are identical,
  and no inherited optimizer log is present in this workspace. The only
  sampled solver is therefore the available finite reference and the
  informative failure; no unsampled comparison is inferred.
- The shared prewarm sheet shows the held fish in the far upper-right wake
  after four staggered cylinder streets have developed. On release, the fish
  turns into a steep downward path, reaches a minimum target distance of only
  `8.61495L`, and exits the lower domain after `50.1269` time units without a
  capture or collision. Its head moves `(-3.54522, -13.3003)L`, far steeper
  than the initial target direction.
- The descent is primarily advection rather than productive lateral swimming:
  mean fish velocity from the diagnostics is approximately
  `(-0.0725, -0.2633)`, close to mean local flow
  `(-0.0414, -0.2414)`, while mean relative-flow components are only
  `(0.0311, 0.0219)`. The strong visible body oscillation therefore does not
  reject the downward wake branch or turn the fish back toward the target.
- The seed also reaches both configured acceleration limits
  (`31.4159 rad/time^2`) and both velocity limits (`4.53786 rad/time`), with
  command-energy mean `1496.25`, RMS force-y `21.9428`, and RMS moment-z
  `541.704`. Its `0.55` period is about `32.8` times the estimated shedding
  frequency. This is evidence against merely strengthening the target-blind
  oscillator: it is already saturated and costly while making only `0.0243`
  progress.

## Candidate hypothesis

Retain the state-feedback oscillator, but slow and shrink it enough that its
nominal joint velocities and accelerations fit inside the actuator envelope.
Add a bounded mean tail-curvature command from normalized body-frame bearing,
opposed by normalized heading rate. This gives the policy a target-relative
way to reject the observed cross-wake advection without using coordinates,
elapsed time, cylinder identity, or unavailable flow probes. The command is
inserted as a tail-tangent bias while the first joint receives only a smaller
share, preserving an oscillatory traveling bend around the steering shape.

The next CFD evaluation should falsify this mechanism if the candidate still
hits persistent joint saturation, if positive target bearing drives bearing
away from zero, or if downward displacement remains comparable to the seed
before meaningful distance progress. Evidence for it would be a longer finite
rollout with bounded commands, reduced lateral target offset, and a trajectory
whose early direction remains near the target bearing; capture is not assumed
before that evaluation exists.
