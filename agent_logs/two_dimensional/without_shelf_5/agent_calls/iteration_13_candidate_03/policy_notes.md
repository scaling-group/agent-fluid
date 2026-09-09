# Multi-Wake Target-Policy Candidate Notes

## Evidence diagnosis before editing

- The shared-prewarm sheet is common initial-condition evidence only. It shows
  the fish held at the upper-right release pose while the four staggered
  cylinder streets develop and merge through the target region; it gives no
  candidate-specific control credit.
- Three current `tail_lag_gain=0.75`, fraction-`0.35` samples are exact metric
  and released-keyframe replicas and remain the strongest finite evidence.
  Their sheets show an active early left-down turn, a dense alternating tail
  trail, diagonal entry into the merged wake, and a clean target-ring crossing.
  Mean fish velocity `(-0.2853,-0.1198)` versus mean local flow
  `(-0.1687,-0.1692)` confirms self-propelled leftward travel rather than
  passive advection. Each reaches at `38.049`, with mean distance `1.802L`,
  command energy `52895.0`, power `3965.3`, relative-crossflow RMS `0.2249`,
  force/moment RMS `42.01/653.13`, joint peaks `0.496/0.521` rad, and no
  collision, domain exit, or instability.
- The current `tail_lag_gain=0.80` comparator follows the same visible safe
  turn-then-diagonal route but is slightly weaker on navigation and effort:
  arrival `38.362`, mean distance `1.812L`, command energy `53487.3`, power
  `4007.1`, and mean velocity `(-0.2829,-0.1181)`. It has lower force/moment
  RMS `40.73/637.79` and essentially equal crossflow `0.2244`, so the `0.75`
  improvement is a load tradeoff rather than tail unloading.
- Two inherited `tail_lag_gain=0.70` evaluations are exact replicas of the
  most informative policy-hypothesis failure. Their keyframes retain active
  propulsion and the broad safe corridor, but show no new useful wake
  interaction. Metrics regress sharply to arrival `39.605`, mean distance
  `1.872L`, energy `55461.0`, power `4196.9`, crossflow `0.2429`, loads
  `43.11/675.66`, mean velocity `(-0.2744,-0.1128)`, and joint peaks
  `0.519/0.570` rad. Thus the improvement from `0.80` to `0.75` is local and
  non-monotonic; lower lag is not a reusable improvement direction.
- The evenly spaced `0.70/0.75/0.80` bracket places independent quadratic
  minima for arrival, mean distance, command energy, and power near
  `0.7666/0.7689/0.7656/0.7674`. This is only a deterministic single-wake
  interpolation cue, not proof of smoothness or held-out robustness. The
  inherited allocation and steering-gain regressions rule out combining this
  test with another control-axis change, while the older mixed-feedback
  instability supplies no safe scale for adding velocity, flow, force, or
  moment feedback.
- The compact evidence bundles contain no local `wake_diagnostics.json`.
  Visual claims above are therefore restricted to the supplied keyframes,
  `wake_metrics.csv`, score files, `wake_observation.json` diagnostics, and
  inherited optimizer notes; no artifact outside this workspace was read.

## Candidate hypothesis

Preserve the replicated `0.55`-period, 28-degree oscillator, positive
gain-`1.7` bounded body-frame bearing law, 12-degree steering bound,
fraction-`0.35` allocation, damping, and observation set. Change only
`tail_lag_gain` from `0.75` to `0.765`. This stays inside the measured safe
`0.75`--`0.80` bracket and uses deliberately coarse precision near the common
navigation/effort interpolation estimate; it does not extrapolate through the
failed `0.70` direction or strengthen target curvature.

The later CFD rollout supports this one-axis interpolation only if it preserves
the visible self-propelled corridor and clean capture while improving arrival
below `38.049`, mean distance below `1.802L`, or effort below `52895/3965`,
without exceeding the `0.75` crossflow/load envelope `0.2249/42.01/653.13`.
It is falsified by loss of capture, a material route change, posterior excursion
above `0.521` rad, or regression beyond the `0.80` anchors (`38.362`, `1.812L`,
`53487`, `4007`). Even a positive result applies only to the certified wake
phase and start pose; a miss should restore the replicated `0.75` anchor and
end fine interpolation on this axis rather than trigger another smaller step.
