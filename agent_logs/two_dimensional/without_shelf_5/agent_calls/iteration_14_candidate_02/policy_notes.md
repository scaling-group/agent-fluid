# Multi-Wake Target-Policy Candidate Notes

## Evidence diagnosis before editing

- The four sampled shared-prewarm sheets are byte-identical. They show the
  fish held at the upper-right release pose while the four staggered cylinder
  streets develop and merge through the target region. This is a common
  initial condition and does not distinguish controller quality.
- Three sampled `tail_lag_gain=0.75`, fraction-`0.35` rollouts have
  byte-identical released sheets and metrics. From release, the fish actively
  turns left and down, leaves a dense alternating propulsive trail, enters the
  merged wake corridor, and crosses the target ring without collision, domain
  exit, or instability. Mean fish velocity `(-0.2853,-0.1198)` versus mean
  local flow `(-0.1687,-0.1692)` confirms that its useful leftward traverse is
  self-propelled rather than passive advection. Each repeat reaches at
  `38.049`, with mean distance `1.802L`, command energy `52895.0`, power
  `3965.3`, relative-crossflow RMS `0.2249`, force/moment RMS
  `42.01/653.13`, and joint peaks `0.496/0.521` rad.
- The prefilled `tail_lag_gain=0.80` rollout follows the same safe
  turn-then-diagonal topology but is slightly behind in the matched late
  keyframes. It reaches at `38.362`, with mean distance `1.812L`, command
  energy `53487.3`, and power `4007.1`. Its lower crossflow and force/moment
  values, `0.2244/40.73/637.79`, show that the navigation and effort advantage
  at `0.75` is a load tradeoff, not an unloading result.
- The newest inherited `tail_lag_gain=0.7675` bracket refinement is the closest
  failed policy hypothesis. It remains finite, self-propelled, and successful,
  with no visibly different route, but reaches later at `38.412`; mean distance
  rises to `1.817L`, energy/power to `53565.6/4023.8`, crossflow to `0.2268`,
  force/moment RMS to `42.78/659.63`, and joint peaks to `0.499/0.533` rad.
  The embedded wake diagnostics agree with the frames: mean velocity weakens
  to `(-0.2827,-0.1180)` while mean local flow remains close to the sampled
  anchor. This directly falsifies the inherited quadratic-interpolation
  hypothesis and supplies no evidence for another tiny interior lag step.
- The inherited `tail_lag_gain=0.70` rollout is the stronger extrapolation
  boundary. Its matched middle and late frames show slower progress and a
  larger disturbed trail; diagnostics record arrival `39.605`, mean distance
  `1.872L`, energy/power `55461.0/4196.9`, crossflow `0.2429`, loads
  `43.11/675.66`, mean velocity `(-0.2744,-0.1128)`, and joint peaks
  `0.519/0.570` rad. All tested lag values still touch the same joint rate and
  acceleration caps, so neither lower lag nor close interpolation has reduced
  saturation. The assigned parent also rules out another steering-gain or
  allocation continuation and records an older mixed-signal instability, so
  this candidate does not mix in an unsupported observation or second axis.

## Candidate hypothesis

Change only `tail_lag_gain` from the prefilled `0.80` to the exactly replicated
`0.75`, preserving the `0.55`-period, 28-degree oscillator, gain-`1.7` bounded
body-frame bearing law, 12-degree steering limit, fraction-`0.35` allocation,
damping, and observation set. This is promotion of the best measured policy,
not another interpolation or a claim that tail-lag response is monotone. It
should retain the visible active turn and wake-corridor capture while recovering
the sampled navigation and effort advantage over the prefill.

The later CFD rollout supports promotion only if it reaches the target without
collision, exit, or instability and remains close to the three exact `0.75`
replicas: arrival `38.049`, mean distance `1.802L`, energy/power
`52895/3965`, and crossflow/load envelope `0.2249/42.01/653.13`. Loss of
capture, a materially different route, regression beyond the prefilled `0.80`
anchors, or loads above the replicated `0.75` envelope falsifies promotion.
Agreement would establish repeatability only for this certified wake phase and
start pose; it would not establish held-out robustness.
