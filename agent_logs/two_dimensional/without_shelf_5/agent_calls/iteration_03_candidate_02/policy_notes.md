# Multi-Wake Candidate Diagnosis

## Evidence read before the policy edit

- The shared prewarm sheet shows the held fish above and downstream of four
  staggered cylinders while their fully developed, interacting vortex streets
  span the route to the target. This is common initial-condition evidence, not
  a candidate-specific advantage.
- The distinct sampled policies with steering gains `1.5` and `1.7` both turn
  from the release pose, propel leftward through the developed wake, and cross
  the target radius without a visible collision precursor. Mean fish velocity
  x is more negative than mean local-flow x for both (`-0.263` versus `-0.160`
  and `-0.274` versus `-0.163`), so the targetward motion is not explained by
  passive advection alone. Their sheets show a direct target approach rather
  than the inherited seed's metric-recorded downward domain escape.
- The only source change between those two successful policies is bearing
  steering gain `1.5 -> 1.7`. The larger gain reaches the target sooner
  (`39.710` versus `41.316` released time), lowers mean distance
  (`1.874L` versus `1.919L`), mean command energy (`1377.6` versus `1404.9`),
  RMS relative crossflow (`0.226` versus `0.236`), RMS lateral force
  (`38.4` versus `42.0`), and RMS moment (`618.6` versus `660.2`). Three weaker
  examples duplicate the `1.5` result, while the inherited unstable rollout
  terminated at `2.807` with extreme loads; no local failure keyframe sheet is
  supplied for that inherited case.

## Candidate hypothesis

Retain the demonstrated `0.55`-period propulsion, positive two-joint steering
center, amplitude, damping, and all bounds. Change only `steering_gain` from the
sampled best value `1.7` to `1.9`. The bounded `tanh` map makes this a local
increase in small- and medium-bearing correction while preserving the existing
12-degree steering ceiling at large error. The expected result is earlier yaw
alignment and a shorter, less load-intensive final approach without changing
the route or introducing an unscaled wake signal.

This hypothesis is falsified if the rollout loses capture, takes at least
`39.710` released time, raises mean distance above `1.874L`, or reverses the
observed reductions in crossflow, lateral force, moment, or mean command
energy. In that event later workers should bracket the gain between `1.5` and
`1.9` rather than altering propulsion and steering simultaneously.
