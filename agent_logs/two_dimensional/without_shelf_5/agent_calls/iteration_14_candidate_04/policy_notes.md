# Multi-Wake Target-Policy Candidate Notes

## Evidence diagnosis before editing

- The shared-prewarm sheet is common initial-condition evidence only. It shows
  the fish held at the upper-right release pose while four staggered cylinder
  streets develop and merge through the target region; it cannot distinguish
  controller quality.
- Three current `tail_lag_gain=0.75`, `tail_damping=0.65` samples are exact
  policy, metric, and released-keyframe replicas and are the strongest finite
  evidence. The fish actively turns left-down from release, leaves a dense
  alternating propulsive trail, traverses the broad diagonal wake corridor,
  and crosses the target ring without collision, domain exit, or instability.
  Mean fish velocity `(-0.2853,-0.1198)` versus mean local flow
  `(-0.1687,-0.1692)` confirms that useful leftward travel is self-propelled,
  not passive advection. Each reaches at `38.049`, with mean distance
  `1.802L`, command energy/power `52895/3965`, relative-crossflow RMS `0.2249`,
  force/moment RMS `42.01/653.13`, and joint peaks `0.496/0.521` rad.
- No supplied current or inherited keyframe sheet is a semantic failure. The
  inherited `tail_lag_gain=0.70` rollout is the most informative
  policy-hypothesis failure: it keeps the same safe self-propelled topology and
  still captures, but is visibly behind at matched middle and late frames.
  Metrics confirm arrival `39.605`, mean distance `1.872L`, energy/power
  `55461/4197`, crossflow `0.2429`, loads `43.11/675.66`, weaker mean velocity
  `(-0.2744,-0.1128)`, and posterior peak `0.570` rad. The `0.80` comparator
  is closer but also slower and costlier than `0.75` at `38.362`, `1.812L`,
  and `53487/4007`; its lower `40.73/637.79` force/moment envelope shows that
  the `0.75` navigation gain is a load tradeoff, not unloading.
- The assigned-parent `0.765` interpolation and the separately inherited
  `0.7675` interpolation are new decisive negative evidence. Both preserve the
  visible turn-then-diagonal capture, yet regress from `0.75`: respectively
  arrival/mean distance `38.494/1.815L` and `38.412/1.817L`, energy/power
  `53592/4013` and `53566/4024`, crossflow `0.2274/0.2268`, and posterior
  peaks `0.523/0.533` rad. The latter also raises force/moment to
  `42.78/659.63`. Thus the quadratic interpolation cue did not survive CFD;
  `0.75` is the measured phase-lag anchor, and another smaller phase-lag step
  should not be tested.
- Earlier inherited allocation and bearing-gain results likewise bracket their
  anchors: fractions `0.30` and `0.45` regress around `0.35`, while gains
  `1.725` and `1.9` regress around `1.7`. The older multi-signal controller
  became unstable at `2.807`, so there is no evidence-backed scale for adding
  flow, force, moment, velocity, or another steering term. Inherited
  trajectory summaries instead identify a persistent posterior response issue:
  at a successful anchor the posterior acceleration is capped on about `60%`
  of recorded rows, its rate touches the cap on 531 rows, and the `0.75`
  lag change did not reduce the `0.521`-rad peak or cap contact.

## Candidate hypothesis

Preserve the replicated `0.55`-period, 28-degree gait, positive gain-`1.7`
bounded body-frame bearing law, 12-degree steering limit, fraction-`0.35`
allocation, measured `tail_lag_gain=0.75`, and observation set. Change only
`tail_damping` from `0.65` to `0.70`. This modest `7.7%` increase is a separate
bounded tail-response test: it seeks to arrest posterior rate and overshoot
without moving the now-closed phase-lag, allocation, bearing-gain, or
propulsion axes. It does not assume that a larger damping coefficient must
reduce raw acceleration command; the rollout must establish whether lower
excursion and cap contact outweigh the stronger instantaneous damping term.

The later CFD rollout supports this candidate only if it preserves the visible
self-propelled diagonal capture and improves posterior excursion, saturation,
effort, or force/moment without regressing arrival beyond `38.362`, mean
distance beyond `1.812L`, energy/power beyond `53487/4007`, or crossflow beyond
`0.2249`. It is falsified by loss of capture, any route/collision/exit/
instability change, a posterior peak above `0.521` rad, or increased cap
contact. Even a positive result applies only to the certified wake phase and
start pose; a negative result should restore damping `0.65` and stop increasing
damping until another independently measured bracket is available.
