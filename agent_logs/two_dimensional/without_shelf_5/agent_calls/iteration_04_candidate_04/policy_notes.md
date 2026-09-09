# Multi-Wake Target-Policy Candidate Notes

## Evidence diagnosis before editing

- The shared prewarm sheet is common initial-condition evidence: the held fish
  begins above and downstream of four developed, interacting staggered wakes.
  It cannot distinguish controller quality.
- The sampled `steering_gain=1.7` rollout is the strongest finite comparator.
  Its released sheet shows an early, bounded turn followed by a self-propelled
  diagonal traverse into the merged wake corridor and target ring. The metrics
  support that reading: target capture occurs at `39.710`, mean/final distance
  is `1.874/0.749L`, and relative-crossflow, force, and moment RMS are
  `0.2265`, `38.40`, and `618.59`.
- All three sampled `steering_gain=1.9` rollouts reproduce the same physical
  metrics (apart from wall time) and preserve the same safe visible path
  topology, so the result is a clean local gain comparison rather than a
  termination failure. Relative to `1.7`, they
  arrive later at `40.034`, increase mean distance to `1.901L`, increase
  relative-crossflow RMS to `0.2329`, and increase force/moment RMS to
  `41.31/657.28`. Total command energy also rises from `54703.2` to `54954.5`,
  despite a slightly lower time-mean command energy.
- Embedded wake diagnostics agree with the visual comparison. At `1.9`,
  maximum joint angles rise from `0.507/0.528` to `0.523/0.548` rad and mean
  lateral force shifts from nearly zero (`0.0015`) to `0.0279`, while both
  settings touch the same rate and acceleration envelopes. Increasing the
  bounded bearing gain therefore ceased to improve alignment before it
  relieved actuator saturation.
- The inherited notes establish the broader failure boundary: a controller
  that simultaneously slowed propulsion, reversed/rearranged steering, and
  added lateral-flow and moment feedback became unstable after `2.807` with
  extreme loads. No terminating failure sheet is present among the current
  four sampled examples, so the current visual comparison uses the strongest
  success and the informative finite `1.9` regression; the inherited failure
  is retained only as a reason not to mix mechanisms in this bracket test.

## Candidate hypothesis

Keep the evaluated `0.55`-period, 28-degree oscillator, positive curvature
sign, two-joint steering distribution, and 12-degree `tanh` bound. Change only
`steering_gain` from the prefilled `1.9` to `1.72`, an interior refinement near
the sampled `1.7` best. A three-point quadratic interpolation of the scores at
`1.5`, `1.7`, and `1.9` places its local vertex near `1.724`; this is only a
testable bracket choice, while the arrival, distance, and load metrics provide
the physical support for staying near `1.7`. The observed improvement followed
by regression argues against another gain increase, and `1.72` tests finer
near-zero bearing response without materially changing worst-case curvature.

The later CFD rollout should falsify this refinement if it loses capture,
arrives later than `39.710`, exceeds `1.874L` mean distance, or raises any of
relative-crossflow, force, or moment RMS above the `1.7` reference. If it does,
later workers should restore `1.7` rather than extrapolate above `1.9`, then
probe a small decrement below `1.7` as a separate single-axis test.
