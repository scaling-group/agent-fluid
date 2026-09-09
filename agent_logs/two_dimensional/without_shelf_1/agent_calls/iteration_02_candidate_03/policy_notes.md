# Wake-policy candidate notes

## Evidence diagnosis

- The shared prewarm sheet shows the fish held above and to the right of the
  target while four developed vortex streets merge downstream; this is the
  common release state, not candidate-specific behavior.
- The target-blind `0.55`-period, `28 deg` seed is carried into a long downward
  exit. Its head moves `-3.55L` upstream but `-13.30L` laterally, its mean y
  velocity (`-0.263`) nearly follows mean local-flow y (`-0.241`), and both
  joints reach the `260 deg/time` rate and `1800 deg/time^2` acceleration
  limits. The sheet and diagnostics therefore indicate wasteful saturated
  oscillation plus advection, not useful wake entry.
- The low-load `1.10`-period, `11 deg` controller with a *negative* posterior
  tail-tangent bias turns down/right immediately and leaves after `17.26` time
  units: head x displacement is `+2.45L`, progress is `-0.153`, and minimum
  distance is only the release distance (`12.42L`). Its low RMS force/moment
  (`12.45`/`309`) show that this is a steering-direction failure rather than a
  wake-load failure.
- The strongest finite sample uses a *positive* posterior tail-tangent bias.
  It visibly self-propels left toward the wake, survives `73.39` time units,
  reaches `6.34L`, and obtains `0.132` progress. It later makes a large loop and
  exits through the upper boundary; its final distance regresses to `10.78L`.
  Both joint rates still hit `260 deg/time`, joint 2 reaches `45 deg`, and RMS
  force/moment rise to `196`/`2014`, so retaining the sign while reducing gait
  authority is better supported than increasing steering gain.
- Moving the steering bias into the first-joint oscillator is not supported:
  that sample curls almost in place and becomes unstable after `3.39` time
  units with RMS force/moment `56162`/`580120`.

## Candidate hypothesis

Keep the evidence-supported positive bearing sign and apply it only to the
mean posterior tail tangent. Combine it with the low-load sample's slower
`1.10` period, moderate the oscillator to `14 deg`, and cap requested
acceleration well below the hard envelope. A slightly larger amplitude than
the `11 deg` wrong-sign sample preserves a falsifiable chance of upstream
propulsion without copying the saturated `28 deg` gait. The candidate should
turn left/down toward the target without the immediate rightward escape, while
remaining below joint-rate and joint-angle limits long enough to improve on
the `6.34L` closest approach. Falsify this combination if it loses upstream
motion, repeats the large loop, or reaches the rate/angle caps despite the
reduced gait.
