# Multi-Wake Target-Policy Candidate Notes

## Evidence diagnosis before editing

- The shared prewarm sheet is common initial-condition evidence: the fish is
  held at the upper-right release pose while the four asymmetric cylinder
  streets develop and merge near the target. It cannot distinguish controller
  quality.
- The two current fraction-`0.35` samples are byte-identical policies and exact
  rollout replicas. Their released sheet shows active self-propulsion rather
  than passive advection: the fish makes an immediate left-down correction,
  leaves a dense alternating tail trail, traverses diagonally into the developed
  wake corridor, and reaches the `0.75L` ring at `38.362` without collision,
  exit, or instability. Mean fish velocity `(-0.283,-0.118)` exceeds the local
  flow's leftward component `(-0.170,-0.166)`, corroborating self-propulsion.
- Relative to the two exact fraction-`0.40` samples, fraction `0.35` arrives
  `1.348` time units sooner, lowers mean distance from `1.874L` to `1.812L`,
  command energy from `54703.2` to `53487.3`, power from `4092.5` to `4007.1`,
  relative-crossflow RMS from `0.2265` to `0.2244`, and peak joint excursions
  from `0.507/0.528` to `0.494/0.521` rad. The faster result does trade higher
  force/moment RMS (`40.73/637.79` versus `38.40/618.59`), so it is a navigation
  and effort improvement, not a uniform load improvement; both touch the same
  rate and acceleration caps.
- The inherited fraction-`0.45` rollout is the informative failed hypothesis.
  Its keyframes preserve the same broad self-propelled route and eventual
  capture, but the fish spends longer turning and approaching and leaves a
  broader disturbed trail. Metrics confirm arrival at `43.323`, mean distance
  `2.025L`, energy `60174.8`, crossflow RMS `0.2456`, force/moment RMS
  `41.96/709.54`, and joint peaks `0.544/0.562` rad. Across `0.45`, `0.40`, and
  `0.35`, reducing the anterior steering share is therefore directionally
  supported for navigation, effort, crossflow, and joint excursion, but not
  yet for hydrodynamic loads.
- Inherited gain-`1.725` and gain-`1.9` regressions rule out another small gain
  interpolation, while the older simultaneous velocity/moment and propulsion
  changes became unstable. This candidate retains the replicated positive
  bearing law, vigorous oscillator, phase lag, damping, steering bound, and
  observation set.

## Candidate hypothesis

Change only `anterior_steering_fraction` from `0.35` to `0.30`. In the existing
equations this transfers at most another `0.6` degree of the unchanged bounded
steering center from the anterior joint to the posterior joint; it neither
strengthens total target curvature nor prescribes a route. The hypothesis is
that the same direction that improved `0.45 -> 0.40 -> 0.35` will complete the
early turn and diagonal wake traverse more efficiently while preserving target
capture.

The later CFD rollout should retain the visible active-propulsion topology and
capture no later than `38.362`, with mean distance no higher than `1.812L` and
without raising the `53487.3` command energy, `0.2244` crossflow RMS, or
`0.494/0.521`-rad joint peaks. Arrival regression, loss of capture, posterior
excursion above the fraction-`0.40` value `0.528` rad, or force/moment growth
beyond `40.73/637.79` falsifies continuation and makes fraction `0.35` the
finite anchor. Even a positive result is specific to the certified wake phase
and start pose until held-out conditions test it.
