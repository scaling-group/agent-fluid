# Multi-Wake Target-Policy Candidate Notes

## Evidence diagnosis before editing

- The four sampled shared-prewarm sheets are byte-identical. They show the fish
  held at the upper-right release pose while the asymmetric four-cylinder
  streets develop and merge through the target region. This is a common
  initial condition and cannot distinguish policies.
- Three sampled policies and released sheets are byte-identical
  `tail_lag_gain=0.75`, `anterior_steering_fraction=0.35` replicas. They show an
  actively self-propelled early turn, a dense alternating tail trail, a direct
  left-down traverse into the merged wake, and collision-free target-ring
  crossing. Mean fish velocity `(-0.2853,-0.1198)` versus mean local flow
  `(-0.1687,-0.1692)` confirms that their leftward progress is not passive
  advection. All three reproduce arrival `38.049`, mean distance `1.802L`,
  command energy `52895.0`, power `3965.3`, relative-crossflow RMS `0.2249`,
  force/moment RMS `42.01/653.13`, and joint peaks `0.496/0.521` rad exactly at
  the recorded precision. The assigned parent's `0.75` promotion is therefore
  reproducible in this certified wake realization rather than a one-rollout
  fluctuation.
- The remaining sampled policy changes only tail lag to `0.80`. Its sheet keeps
  the same safe self-propelled route but is slightly behind at matched frames.
  Metrics confirm later arrival (`38.362`), higher mean distance (`1.812L`),
  higher energy (`53487.3`) and power (`4007.1`), and weaker mean velocity
  `(-0.2829,-0.1181)`. Its lower force/moment RMS (`40.73/637.79`) and nearly
  unchanged crossflow (`0.2244`) remain important: reducing lag to `0.75`
  improved navigation and effort, but did not unload the gait. Both lag values
  touch the same rate and acceleration caps, and posterior peak angle is
  unchanged to four decimals (`0.5208` rad).
- No supplied sampled sheet is a semantic failure. The inherited
  fraction-`0.30` rollout is the most informative policy-hypothesis failure:
  visually it retains the broad route and captures, but lags the `0.75` fish at
  matched frames. Its `39.286` arrival, `1.850L` mean distance, `56145.5`
  energy, `0.2447` crossflow, `42.06/662.67` loads, and `0.512/0.583`-rad peaks
  reject further steering-allocation extrapolation. Together with inherited
  fraction-`0.45` and gain-`1.725/1.9` regressions and the older mixed-signal
  instability, this supports leaving allocation, bearing feedback, propulsion,
  and the observation set unchanged.

## Candidate hypothesis

Preserve the replicated `0.55`-period, 28-degree gait, positive gain-`1.7`
bounded body-frame bearing law, 12-degree steering bound, fraction-`0.35`
allocation, damping, and observation set. Change only `tail_lag_gain` from
`0.75` to `0.70`. This is one equally sized, bounded continuation of the only
tail-response step that improved both navigation and effort; it reduces the
velocity-derived posterior phase-lag component by another `6.67%` without
altering target curvature, route logic, or the anterior propulsion oscillator.
The three exact `0.75` replicas justify testing beyond the promoted anchor, but
do not establish monotonicity or predict unloading.

The later CFD rollout supports this isolated test only if it still captures,
arrives before `38.049`, lowers mean distance below `1.802L`, and reduces
command energy/power below `52895/3965` without materially exceeding the
`0.2249/42.01/653.13` crossflow/force/moment envelope or the `0.521`-rad
posterior peak. Loss of capture, a slower approach, higher effort, enlarged
posterior excursion, or further load growth falsifies continuation below
`0.75`; later workers should then restore the replicated anchor and stop
stepping this parameter. Any positive result remains limited to the certified
wake phase and start pose until tested under changed conditions.
