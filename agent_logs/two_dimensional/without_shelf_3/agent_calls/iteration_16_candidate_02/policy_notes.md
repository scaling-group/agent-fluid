# Multi-wake candidate diagnosis and hypothesis

## Visual and metric diagnosis

- The shared prewarm sheet shows the fixed initial condition: the fish is held
  in the upper-right far field while the four staggered cylinders develop
  interacting wakes around the target. The released sheets for the assigned
  parent, the duplicated `-0.125` rearward-bearing baseline, and the best
  sampled candidate are nearly identical through the useful leg. The fish
  swims left under its own gait, then pitches into the same nose-up return and
  exits through the upper boundary without reaching the target or cylinder
  wakes. This is not a collision or numerical failure.
- The leftward leg is active propulsion rather than passive advection. For the
  best sampled candidate, mean fish x-velocity is `-0.07075` while mean local
  flow is `-0.04945`; it moves its head `-4.676L` upstream and reaches
  `6.609L`, but is still far outside the `0.75L` capture radius. Its positive
  mean y-velocity (`0.01712`) opposes the nearly zero mean local y-flow, which
  agrees with the visible controller-driven upper exit.
- The exact `-0.125` baseline is duplicated by two sampled rollouts and gives
  score `-11.2406`, `-4.555L` head-x travel, `6.609/9.415/9.360L`
  minimum/mean/final range, and `0.2466` progress. Its anterior joint reaches
  `34.24 deg` and `259.90 deg/time`, with RMS force/moment `75.9/1004`.
- Adding a deep-rearward gate that requires both instantaneous and windowed
  range opening, then reducing only the anterior steering allocation to
  `0.10`, produces the best sampled score (`-11.1487`). Against the exact
  baseline it preserves the same closest approach, improves head-x travel to
  `-4.676L`, mean/final range to `9.342/9.266L`, and progress to `0.2542`,
  while lowering anterior angle/speed peaks to `33.23 deg` and
  `251.35 deg/time` and RMS force/moment to `75.6/985`. The lifetime gain is
  only `0.29` time and the upper-return topology remains, so this is evidence
  for late anterior unloading, not evidence of recovery or wake entry.
- The assigned `-0.15625` parent also repeats the upper exit. Its lower loads
  are confounded by the different rearward-bearing fraction and do not support
  another interpolation; inherited logs already show that stronger rearward
  bearing, added turn damping, and conditional overspeed damping damage the
  approach without changing the topology.

## Candidate hypothesis

Use the sampled deep-rearward, dual-opening discriminator unchanged, retain
the exact `-0.125` approach law and posterior steering allocation, and make one
bounded amplification: reduce the terminal anterior steering fraction from
`0.10` to `0.0`. The gate is designed to stay inactive during closing, so the
demonstrated upstream leg should be preserved. Once the target is deeply
rearward and range is opening on both time scales, fully neutralizing the
anterior mean steering bias should extend the measured reduction in anterior
angle/speed without globally weakening the traveling body wave.

Falsify the hypothesis if the rollout loses roughly `-4.55L` upstream head
travel or the `6.7L` approach, raises loads above the exact baseline scale,
or merely repeats the upper exit without improving lifetime and mean/final
range. A successful result still requires later CFD evidence; this worker does
not claim an unevaluated candidate outcome.
