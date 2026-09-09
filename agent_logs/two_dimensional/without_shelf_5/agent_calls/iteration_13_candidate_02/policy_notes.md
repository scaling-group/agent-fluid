# Multi-Wake Target-Policy Candidate Notes

## Evidence diagnosis before editing

- The sampled shared-prewarm sheet shows the fish held at the upper-right
  release pose while the four staggered cylinder streets develop and merge
  through the target region. It is common initial-condition evidence and does
  not distinguish policies.
- Three sampled `tail_lag_gain=0.75`, fraction-`0.35` policies have
  byte-identical released sheets and metrics, making them the strongest finite
  anchor. The fish turns left and down under a dense alternating tail trail,
  enters the merged wake corridor, and crosses the target ring without
  collision, exit, or instability. Mean fish velocity
  `(-0.2853,-0.1198)` versus mean local flow `(-0.1687,-0.1692)` confirms that
  the useful leftward traverse is self-propelled, not passive advection. The
  repeats arrive at `38.049`, with mean distance `1.802L`, command energy
  `52895.0`, power `3965.3`, relative-crossflow RMS `0.2249`, force/moment RMS
  `42.01/653.13`, and joint peaks `0.496/0.521` rad.
- The sampled `tail_lag_gain=0.80` rollout is the direct higher-side
  comparator. Its keyframes retain the same active turn, diagonal corridor,
  and safe capture but are slightly behind late in the rollout. It arrives at
  `38.362`, with mean distance `1.812L`, energy `53487.3`, and power `4007.1`.
  Its crossflow and loads are slightly lower at `0.2244/40.73/637.79`, so the
  navigation gain at `0.75` is a measured load tradeoff rather than unloading.
- The newest inherited `tail_lag_gain=0.70` rollout is the decisive failed
  extrapolation. Its released sheet still shows active turning and capture, but
  the fish is visibly farther from the target at matched middle and late
  frames and leaves a larger-amplitude disturbed trail. The embedded wake
  diagnostics and CSV agree: mean velocity weakens to
  `(-0.2744,-0.1128)`, arrival regresses to `39.605`, mean distance to
  `1.872L`, energy/power to `55461.0/4196.9`, crossflow to `0.2429`, and
  force/moment to `43.11/675.66`; posterior peak angle rises to `0.570` rad.
  Both joints still touch the same rate and acceleration caps. Therefore the
  `0.80 -> 0.75` gain is non-monotonic and must not justify another reduction.
- Inherited allocation and bearing-gain logs give the same methodological
  boundary: fractions `0.30` and `0.45` regress around the measured `0.35`
  anchor, steering gains `1.725` and `1.9` regress around `1.7`, and an older
  mixed-signal controller became unstable at `2.807`. This candidate therefore
  does not add an unscaled observation or change bearing feedback, steering
  allocation, propulsion, or damping.

## Candidate hypothesis

Change only `tail_lag_gain` from the prefilled `0.75` to `0.7675`, preserving
the replicated `0.55`-period, 28-degree oscillator, gain-`1.7` bounded
body-frame bearing law, 12-degree steering limit, fraction-`0.35` allocation,
damping, and observation set. This value lies inside the measured successful
`[0.75,0.80]` bracket. Separate quadratic interpolations of arrival, mean
distance, command energy, power, and scalar score across the deterministic
`0.70/0.75/0.80` samples place their local optima between approximately
`0.766` and `0.769`; `0.7675` is a single bounded bracket-refinement test, not
a claim that those three points establish a globally quadratic response.

The later CFD rollout supports this candidate only if it captures, preserves
the visible turn-then-diagonal route, and improves on the `0.75` anchor in
arrival or mean distance without exceeding its `52895/3965` energy/power and
`0.2249/42.01/653.13` crossflow/load envelopes. It is falsified by loss of
capture, regression past the `0.80` anchors (`38.362`, `1.812L`, `53487`,
`4007`), or materially increased joint excursion or cap contact. Any positive
result remains specific to the certified wake phase and start pose until it is
tested under held-out conditions.
