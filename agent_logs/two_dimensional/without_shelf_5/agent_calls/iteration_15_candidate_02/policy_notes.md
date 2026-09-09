# Multi-Wake Target-Policy Candidate Notes

## Evidence diagnosis before editing

- The four assigned shared-prewarm sheets are byte-identical. They show the
  fish held at the upper-right release pose while the four staggered cylinder
  streets develop and merge through the target region. This is a common
  initial condition and cannot distinguish controller quality.
- All four current solver samples are byte-identical `tail_lag_gain=0.75`,
  `tail_damping=0.65`, fraction-`0.35` policies and exactly reproduce the
  strongest finite rollout. The released sheet shows an immediate active
  left-down turn, a dense alternating propulsive trail, diagonal entry into
  the merged wake corridor, and target-ring crossing without collision,
  domain exit, or instability. Mean fish velocity `(-0.2853,-0.1198)` versus
  mean local flow `(-0.1687,-0.1692)` confirms that leftward progress is
  self-propelled rather than passive advection. Each reaches at `38.049`, with
  mean distance `1.802L`, command energy/power `52895/3965`, relative-crossflow
  RMS `0.2249`, force/moment RMS `42.01/653.13`, joint peaks `0.496/0.521` rad,
  and both joints touching the `260/1800` degree rate/acceleration caps.
- The assigned parent's `tail_lag_gain=0.7675` rollout is the closest
  informative policy-hypothesis failure. Its keyframes retain the same active
  route and semantic capture, but the fish is visibly behind the `0.75` anchor
  at matched middle and late frames. Diagnostics confirm later arrival
  `38.412`, mean distance `1.817L`, energy/power `53566/4024`, crossflow
  `0.2268`, force/moment `42.78/659.63`, and posterior peak `0.533` rad. It
  therefore fails the inherited local-interpolation hypothesis on navigation,
  effort, crossflow, and load together.
- The inherited `tail_lag_gain=0.70` extrapolation strengthens the stopping
  boundary: it still captures, but slows to `39.605`, raises mean distance to
  `1.872L`, energy/power to `55461/4197`, crossflow to `0.2429`, force/moment
  to `43.11/675.66`, and posterior peak to `0.570` rad. The assigned guidance
  also records regressions for anterior fractions `0.30/0.40/0.45`, steering
  gains above and below `1.7`, and an unstable mixed-signal controller. Thus
  another lag, allocation, bearing-gain, or new unscaled-observation test is
  not supported by the available evidence.
- Across the closest comparisons, larger posterior excursion accompanies
  slower progress and higher crossflow/load, while the best controller still
  has a larger posterior than anterior peak and touches the actuator caps.
  This supports one separately bounded posterior-response test; it does not
  establish that more damping will improve the coupled gait.

## Candidate hypothesis

Preserve the replicated `0.55`-period, 28-degree oscillator, `tail_lag_gain=0.75`,
gain-`1.7` bounded body-frame bearing law, 12-degree steering limit,
fraction-`0.35` allocation, and observation set. Change only `tail_damping`
from `0.65` to `0.70`. This modest `7.7%` increase is an orthogonal,
dimensionless posterior-response probe: it is intended to reduce posterior
overshoot and the associated lateral/load penalty without changing the
propulsive frequency, steering center, target feedback, or phase-lag target.

The later CFD rollout supports the hypothesis only if it still captures along
the visible turn-then-diagonal corridor and either improves on the replicated
`38.049` arrival / `1.802L` mean distance or reduces posterior peak, crossflow,
and loads without a material navigation regression. It is falsified by loss
of capture, collision, exit, instability, arrival later than the `0.7675`
failure (`38.412`), mean distance above `1.817L`, or effort/load beyond the
current `52895/3965` and `0.2249/42.01/653.13` envelopes. A lower posterior
peak alone is not success if it merely weakens propulsion. Any positive result
remains specific to the certified wake phase and start pose until a held-out
condition preserves it.
