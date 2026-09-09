# Wake-policy candidate diagnosis

## Evidence read before the policy edit

- The shared prewarm sheet is common initial-condition evidence: it shows the
  fish held far above and downstream of the target while developed streets from
  the four staggered cylinders overlap through the second-row target corridor.
  None of the released sheets enters that corridor. The current problem is
  therefore far-field course retention, not wake exploitation or `0.75L`
  capture.
- The assigned parent's `behind_bearing_fraction=-0.125` rollout is genuinely
  self-propelled during its useful diagonal leg. Its mean x velocity/local flow
  are `-0.0709/-0.0481`, and the keyframes show sustained leftward translation
  before the fish curls nose-up and exits the upper boundary. Among the current
  samples it has the best score (`-11.241`), head-x travel (`-4.55L`), minimum
  range (`6.61L`), progress (`0.247`), and mean/final range (`9.42/9.36L`). It
  does not reach the target or useful wake, however, and survives only `69.85`
  released time.
- This result improves the approach-quality side of the parent's midpoint
  hypothesis but falsifies its recovery and speed-margin conditions. The
  anterior joint reaches `0.598 rad` (`34.2 deg`), `4.536 rad/time` (`260
  deg/time`), and about `1592 deg/time^2`; the posterior reaches only `25.9
  deg`, `191 deg/time`, and about `1463 deg/time^2`. RMS force/moment remain
  finite at `75.9/1004`, slightly below the sampled `-0.25` anchor, but the
  visible upper-return topology is unchanged.
- The independently repeated `-0.25` policy confirms that the comparison is
  deterministic under the shared prewarm. It travels `-4.44L` upstream,
  reaches `6.63L`, records progress `0.241`, and survives longer (`74.48`), but
  has worse mean/final range (`9.45/9.43L`) and slightly higher RMS force/moment
  (`76.8/1030`). Its anterior/posterior peak speeds are about `254/191
  deg/time`. Thus `-0.125` is the new exploitation anchor for approach metrics,
  not evidence that further rearward-bearing interpolation will remove the
  upper exit.
- The informative delayed-reversal failure adds another `-0.25` of bearing
  authority only when the target is more than `1L` aft. Its sheet still makes
  the same nose-up exit; head-x travel falls to `-4.32L`, progress to `0.232`,
  mean/final range worsen to `9.52/9.54L`, and RMS force/moment rise to
  `78.1/1072`. Together with inherited logs for the harmful `-0.50` abeam
  continuation and abeam-only overspeed damping, this rules out stronger late
  reversal or speed damping as the next isolated mechanism.

## Candidate hypothesis

Preserve the best sampled `-0.125` target-ahead/rearward steering law,
oscillator, `0.04` turn-rate damping, joint guards, and acceleration limiter.
Change exactly one parameter: lower `anterior_steering_fraction` from `0.35`
to `0.25`. Because the anterior and posterior fractions still sum to one, this
keeps the requested total mean curvature unchanged while transferring one
tenth of the bounded steering bias from the joint that touched `260 deg/time`
and `34.2 deg` to the joint with measured headroom at `191 deg/time` and `25.9
deg`. This is a structural curvature-allocation test, not another interpolation
of the rearward-bearing authority and not a claim that cap proximity alone
caused the exit.

The hypothesis is supported only if the rollout remains finite, retains about
`-4.4L` upstream head travel and a `6.7L` or better approach, lowers the
anterior speed/angle excursion without pushing the posterior joint near its
`34 deg` guard or the `260 deg/time` hard cap, and materially delays or changes
the upper return or improves mean/final range. It is falsified if it repeats the
upper exit with no navigation gain, loses the demonstrated closing leg, merely
transfers saturation posteriorly, or raises loads above roughly the sampled
`77/1030` RMS force/moment scale. The policy uses only normalized body-frame
target geometry, joint state, and measured recent turn rate; it contains no
coordinate, clock, route, prescribed inflow, remote wake probe, target-station
signal, or omitted-shelf dependency. Its CFD result is deferred to EvE and is
not claimed as current evidence.
