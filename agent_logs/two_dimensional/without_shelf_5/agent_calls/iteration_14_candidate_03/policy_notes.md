# Multi-Wake Target-Policy Candidate Notes

## Evidence diagnosis before editing

- The sampled shared-prewarm sheet shows the fish held at the upper-right
  release pose while the four staggered cylinder streets develop and merge
  through the target region. It is common initial-condition evidence and does
  not distinguish policies.
- Three current `tail_lag_gain=0.75`, fraction-`0.35` policies have identical
  released sheets and metrics, making them the strongest finite anchor. The
  fish turns left and down under a dense alternating tail trail, enters the
  merged wake corridor, and crosses the target ring without collision, exit,
  or instability. Mean fish velocity `(-0.2853,-0.1198)` versus mean local
  flow `(-0.1687,-0.1692)` confirms that the useful leftward traverse is
  self-propelled rather than passive advection. The repeats arrive at `38.049`,
  with mean distance `1.802L`, command energy `52895.0`, power `3965.3`,
  relative-crossflow RMS `0.2249`, force/moment RMS `42.01/653.13`, and joint
  peaks `0.496/0.521` rad. Both joints touch the rate and acceleration caps.
- The current `tail_lag_gain=0.80` prefill follows the same safe diagonal route
  but is slightly behind late in the sheet. It arrives at `38.362`, with mean
  distance `1.812L`, energy `53487.3`, and power `4007.1`. Its lower
  force/moment RMS `40.73/637.79` shows that the navigation gain at `0.75` is a
  load tradeoff, not evidence that reduced lag unloads the gait.
- No current sample is a semantic failure. The inherited
  `tail_lag_gain=0.70` rollout is the most informative failed extrapolation:
  its released sheet retains active turning and capture but is visibly farther
  from the target at matched middle and late frames and leaves a larger
  disturbed trail. Embedded diagnostics agree: mean velocity weakens to
  `(-0.2744,-0.1128)`, arrival/mean distance regress to `39.605/1.872L`,
  energy/power to `55461.0/4196.9`, crossflow to `0.2429`, force/moment to
  `43.11/675.66`, and posterior peak angle to `0.570` rad.
- The inherited in-bracket `tail_lag_gain=0.7675` test also falsifies the
  quadratic interpolation hypothesis. It preserves the route and captures,
  but regresses from `0.75` to `38.412` arrival, `1.817L` mean distance,
  `53565.6` energy, `4023.8` power, `0.2268` crossflow, `42.78/659.63` loads,
  and `0.533`-rad posterior peak. Together with the known allocation and
  bearing-gain brackets, this closes another fine lag, allocation, or steering
  gain step at the certified condition.

## Candidate hypothesis

Promote the replicated `tail_lag_gain=0.75` anchor and change only the newly
tested axis `tail_damping` from `0.65` to `0.675`. Preserve the measured
`0.55`-period, 28-degree oscillator, gain-`1.7` bounded body-frame bearing law,
12-degree steering limit, fraction-`0.35` allocation, and observation set.
This small `3.85%` increase strengthens only the posterior velocity damping;
it is intended to arrest posterior reversal overshoot responsible for the
larger joint excursion and load tradeoff without weakening the anterior
propulsive oscillator or target curvature. It is a bounded new-axis test, not
a claim that stronger damping must reduce command saturation.

The later CFD rollout supports this hypothesis only if it captures and
preserves the visible self-propelled turn-then-diagonal route while reducing
posterior excursion below `0.521` rad or force/moment below `42.01/653.13`
without regressing beyond the `0.80` navigation/effort anchors (`38.362`,
`1.812L`, `53487`, `4007`). Increased rate/acceleration cap contact, crossflow
above `0.2249`, loss of capture, or a material route change falsifies the
damping mechanism. Any positive result remains specific to the certified wake
phase and start pose until tested under held-out conditions.
