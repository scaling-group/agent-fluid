# Multi-wake visual diagnosis and candidate hypothesis

## Evidence read before the policy edit

- The shared prewarm sheet shows the held fish at the common upper-right
  release pose while four developed, interacting vortex streets extend across
  the target and release corridor. This is common initial-condition evidence,
  not a candidate difference.
- The sampled policies reduce to two deterministic trajectories. The
  `20.25 deg`, `0.67`-period, `0.30/0.25` anchor captures at `244.547` with
  mean distance `6.452L`; adding the `0.08` sign-gated lateral-velocity
  lookahead captures at `224.488` with mean distance `6.311L`. Each result is
  reproduced exactly by two sampled workers.
- Both released sheets show self-propelled upstream motion into the central
  wake rather than passive advection. The anchor's mean x velocity/local flow
  are `-0.04443/-0.03649`, giving a `0.00793` controller-relative upstream
  margin. The sign-gated policy improves these to `-0.04895/-0.03293`, a
  `0.01602` margin, while also lowering RMS force/moment from
  `18.263/362.214` to `17.943/361.014`.
- Both trajectories retain the same broad release excursion (`4.293L` maximum
  lateral target offset), but the faster sheet recovers through the wake and
  reaches the final near-horizontal central approach without the slower
  anchor's longer late zigzag. Identical anterior maxima (`0.3531 rad` angle,
  `3.3161 rad/time` velocity, and `31.0554 rad/time^2` acceleration) isolate
  the observed difference to steering timing rather than stronger propulsion.
  Neither run collides, exits, becomes unstable, or touches the `31.2` local
  acceleration guard.
- No sampled rollout is a visual failure, so no collision or horizon-miss
  mechanism is inferred from a missing sheet. The inherited score-only branch
  that captured at `263.346` is useful negative scalar evidence: its lower RMS
  relative crossflow (`0.13295`) coincided with worse mean distance (`6.974L`)
  and higher lateral force (`18.310`) than the sign-gated policy. Lower
  crossflow alone is therefore not a route-quality target.

## Single candidate

Keep the demonstrated propulsion shell, posterior lag/damping, static bearing
scale, rate lead, velocity clamp, continuous away-drift gate, and acceleration
guard unchanged. Increase only `lateral_velocity_lookahead` from `0.08` to
`0.10`. This is a bounded 25% extension of the only sampled corridor signal
that improved capture, distance, upstream margin, and loads together. Its
purpose is to start slightly more counter-steering during measured target-away
lateral translation while leaving targetward wake-band crossings untouched;
it is not a global lateral damper.

The hypothesis is falsified if the formal rollout captures later than
`224.488`, raises mean distance above `6.311L`, reduces the `0.01602` upstream
margin, increases the `4.293L` excursion or `17.943/361.014` loads, contacts
the acceleration guard, chatters near zero bearing, collides, or misses the
horizon. Because the current evidence uses one certified prewarm phase, even a
positive result would remain local until a held-out wake phase reproduces it.
