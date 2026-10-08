# Wake-policy diagnosis and candidate hypothesis

## Evidence read before editing

- The shared prewarm sheets are byte-identical across all four sampled solver
  examples. They show the held fish at the common upper-right release pose and
  four fully developed, interacting vortex streets around the target; this is
  common initial-condition evidence rather than a controller difference.
- Both sampled controller families are successful finite rollouts and each is
  replicated exactly: the two `1700 deg/time^2` candidates share policy and
  released-sheet hashes, as do the two `1650 deg/time^2` candidates. No
  collision, exit, instability, or horizon-miss example is present in the
  current sampled rollout set, so the informative comparison is the stronger
  `1650` capture against the lower-scoring `1700` capture, cross-checked with
  inherited negative results rather than inventing a visual failure.
- In both released sheets the fish visibly self-propels down and left, turns
  onto the target bearing, enters the developed multi-wake corridor, and
  reaches the `0.75L` capture circle without approaching a cylinder. The
  lateral body oscillation produces an alternating trailing wake throughout
  the traverse; it is propulsion rather than passive advection because mean
  fish velocity is much larger than the mean local streamwise flow in the
  target direction.
- With every other policy field fixed, `1650` improves over `1700`: arrival
  `33.027` versus `34.331`, mean distance `1.6831L` versus `1.7137L`, command
  energy `42309.6` versus `45153.2`, power `3182.9` versus `3390.2`, mean
  velocity `(-0.3289,-0.1367)` versus `(-0.3164,-0.1322)`, and posterior
  excursion `0.4950` versus `0.5089` rad. The active posterior ceilings are
  exactly `28.798` and `29.671 rad/time^2`, respectively.
- The faster `1650` route is not a load improvement. Its relative-crossflow
  RMS rises from `0.2312` to `0.2358`, force RMS from `54.48` to `63.93`, and
  moment RMS from `766.14` to `859.31`; its released sheet also shows a more
  disturbed fish wake near target approach. The inherited `1800 -> 1750 ->
  1700` evidence already reported the same navigation/effort versus load
  direction, while inherited amplitude weakening regressed navigation and the
  earlier mixed-feedback controller became unstable. Those negative results
  rule out combining this cap choice with weaker gait or uncalibrated
  force/moment feedback.

## Single candidate hypothesis

Materialize the exact sampled `1650 deg/time^2` posterior acceleration bound,
leaving gait, lag, damping, bounded body-frame bearing law, steering
allocation, and observations unchanged. This is the best replicated finite
policy in the assigned evidence for score, arrival, mean distance, and effort,
and it retains the visually safe route. Do not extrapolate to `1600` in this
candidate: moment RMS at `1650` already slightly exceeds the inherited
`850` continuation boundary. The hypothesis is falsified if a repeat loses
capture or the visible diagonal route, regresses beyond the replicated `1700`
navigation/effort envelope, or materially exceeds the measured `1650`
`0.2358/63.93/859.31` crossflow/force/moment envelope. It remains specific to
the certified wake phase and start pose and makes no held-out robustness claim.
