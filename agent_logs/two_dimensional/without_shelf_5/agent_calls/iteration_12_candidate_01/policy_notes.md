# Multi-Wake Target-Policy Candidate Notes

## Evidence diagnosis before editing

- The four current shared-prewarm sheets are byte-identical. They show the fish
  held at the upper-right release pose while the four staggered cylinder wakes
  develop and merge through the target region. This is common initial-condition
  evidence and does not distinguish controller quality.
- Three current `tail_lag_gain=0.75`, fraction-`0.35` policies, released sheets,
  and metric sets are exact replicas. The sheets show an early left-down turn,
  a dense alternating tail trail, diagonal entry into the merged wake, and a
  clean target-ring crossing without collision, domain exit, or instability.
  Mean fish velocity `(-0.2853,-0.1198)` versus mean local flow
  `(-0.1687,-0.1692)` confirms active leftward propulsion rather than passive
  advection. Each reaches at `38.049`, with mean distance `1.802L`, command
  energy `52895.0`, power `3965.3`, relative-crossflow RMS `0.2249`,
  force/moment RMS `42.01/653.13`, and joint peaks `0.496/0.521` rad.
- The current `tail_lag_gain=0.80`, fraction-`0.35` comparator preserves the
  same safe turn-then-diagonal topology but reaches later at `38.362`. Its mean
  distance, command energy, and power regress to `1.812L`, `53487.3`, and
  `4007.1`, with weaker mean velocity `(-0.2829,-0.1181)`. It has modestly
  lower force/moment RMS `40.73/637.79`; crossflow is effectively unchanged
  at `0.2244`, the posterior peak remains `0.521` rad, and both variants touch
  the same rate and acceleration caps. Thus the replicated `0.75` result is a
  navigation/effort improvement, not a demonstrated unloading mechanism.
- No current sample is a semantic failure. The inherited fraction-`0.30`,
  lag-`0.80` rollout is the most informative policy-hypothesis failure: its
  frames retain self-propulsion and capture but visibly lag along the same
  route, while metrics regress to `39.286` arrival, `1.850L` mean distance,
  `56145.5` energy, `4263.2` power, `0.2447` crossflow, `42.06/662.67` loads,
  and `0.512/0.583`-rad peaks. Together with the inherited fraction-`0.45` and
  steering-gain regressions, this rules out another allocation or bearing-gain
  step. The older mixed-signal instability at `2.807` supplies no safe scale
  for adding flow, velocity, force, or moment feedback.

## Candidate hypothesis

Preserve the replicated `0.55`-period, 28-degree gait, positive gain-`1.7`
bounded body-frame bearing law, 12-degree steering bound, fraction-`0.35`
allocation, damping, and observation set. Change only `tail_lag_gain` from
`0.75` to `0.70`. This is one further equal-size step on the only newly
replicated axis that improved both navigation and command effort; it reduces
the velocity-derived posterior target component by `6.67%` relative to `0.75`
without changing target curvature, propulsion amplitude, or controller inputs.

The later CFD rollout supports the hypothesis only if it preserves the visible
self-propelled wake-corridor capture and improves arrival, mean distance, or
effort relative to the replicated `0.75` anchors (`38.049`, `1.802L`,
`52895`, and `3965`). It is falsified by loss of capture, arrival no better
than the `0.80` comparator's `38.362`, mean distance above `1.812L`, or a
material route change. Because `0.75` did not unload the joints, force/moment
above the inherited negative envelope `42.06/662.67`, greater posterior
excursion than `0.521` rad, or worse cap contact rejects a nominal speed gain
as an unsafe extrapolation. Any positive result remains specific to the
certified wake phase and start pose and does not establish monotonic response
below `0.70`.
