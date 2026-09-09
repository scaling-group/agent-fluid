# Multi-Wake Target-Policy Candidate Notes

## Evidence diagnosis before editing

- The four sampled shared-prewarm sheets are byte-identical. They show the fish
  held at the upper-right release pose while the staggered cylinder streets
  develop and merge around the target, so they establish a common initial
  condition and give no candidate-specific credit.
- The released `anterior_steering_fraction=0.35` sheet shows active propulsion,
  not passive advection: the mean fish velocity is `(-0.2829,-0.1181)` while
  mean local flow is `(-0.1703,-0.1656)`, and the fish leaves a dense alternating
  tail trail while turning left-down into the developed wake corridor. It
  reaches the `0.75L` ring without collision, exit, or instability. The two
  sampled `0.35` policies, keyframes, and metrics are exact replicas: arrival
  `38.362`, mean distance `1.812L`, total command energy `53487.3`, power proxy
  `4007.1`, relative-crossflow RMS `0.2244`, force/moment RMS `40.73/637.79`,
  and maximum joint angles `0.494/0.521` rad.
- The two sampled fraction-`0.40` replicas follow the same self-propelled
  turn-then-diagonal topology but make less progress at corresponding keyframes
  and reach later at `39.710`. Relative to `0.35`, they have higher mean distance
  (`1.874L`), energy (`54703.2`), power (`4092.5`), and crossflow (`0.2265`),
  but lower force/moment RMS (`38.40/618.59`). Their peak angles are also higher
  at `0.507/0.528` rad. Thus `0.35` is a replicated navigation, effort, crossflow,
  and excursion improvement, with a real lateral-load tradeoff rather than a
  uniformly superior controller.
- No current sampled rollout is a semantic failure. The most informative
  policy-hypothesis failure with available keyframes is the inherited fraction-
  `0.45` run. It still self-propels and captures, but its slower, less effective
  approach reaches at `43.323`, with mean distance `2.025L`, energy `60174.8`,
  power `4557.0`, crossflow `0.2456`, force/moment RMS `41.96/709.54`, and both
  peak angles increased to `0.544/0.562` rad. The older inherited mixed-feedback
  instability at `2.807` has no available keyframe here and is used only as an
  outer boundary against adding unscaled observations or changing several axes.
- Across the controlled allocation tests, navigation and effort improve in the
  sequence `0.45 -> 0.40 -> 0.35`, while load response is non-monotonic and is
  best at `0.40`. This supports one equal-size continuation of the allocation
  axis, but not a claim that reducing the anterior share is generally monotone
  or that a faster arrival alone is a clean improvement.

## Candidate hypothesis

Preserve the evaluated `0.55`-period, 28-degree oscillator, gain-`1.7` bounded-
bearing law, positive steering sign, 12-degree total steering command, posterior
phase lag, damping, and observation set. Change only
`anterior_steering_fraction` from the prefilled `0.40` to `0.30`. Relative to
the strongest sampled `0.35` policy, this is one more five-point allocation
step toward the posterior joint; it does not increase total target curvature,
alter the propulsion gait, add an unscaled signal, or encode a global route.

The later CFD rollout should preserve the visible active turn into the wake and
target capture. Evidence for continuing this direction would be arrival no later
than `38.362`, mean distance no greater than `1.812L`, and improvement in at
least one of energy `53487.3`, power `4007.1`, or crossflow `0.2244` without
raising force/moment above the `0.35` envelope `40.73/637.79` or posterior
excursion above `0.521` rad. Loss of capture, later arrival, worse mean distance,
or a load/excursion increase would falsify this continuation and make `0.35` the
allocation anchor for this certified wake phase. Any positive result remains
limited to this common phase and start pose until held-out conditions are run.
