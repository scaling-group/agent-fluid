# Multi-Wake Target-Policy Candidate Notes

## Evidence diagnosis before editing

- The sampled shared-prewarm sheet shows the fish held at the upper-right
  release pose while four staggered cylinder wakes develop and merge through
  the target region. This is common initial-condition evidence and cannot
  distinguish policies.
- Three sampled `tail_lag_gain=0.75`, fraction-`0.35` policies have identical
  released keyframes and metrics, making them the strongest finite anchor.
  The fish turns left and down under a dense alternating tail trail, traverses
  the developed wake under active propulsion, and crosses the target ring
  without collision, exit, or instability. Its `-10.913L` head displacement
  in `38.049` compared with mean local x flow `-0.1687` confirms that the
  leftward traverse is not passive advection. Each repeat records mean distance
  `1.802L`, command energy/power `52895/3965`, relative-crossflow RMS `0.2249`,
  force/moment RMS `42.01/653.13`, and joint peaks `0.496/0.521` rad.
- The prefilled `tail_lag_gain=0.80` policy preserves the same visible safe
  corridor and capture but trails the `0.75` rollouts at matched late frames.
  It reaches at `38.362`, with mean distance `1.812L`, energy/power
  `53487/4007`, crossflow `0.2244`, and force/moment `40.73/637.79`. Thus the
  measured navigation and effort benefit at `0.75` accepts a modest load
  tradeoff rather than demonstrating a uniformly quieter gait.
- The assigned parent's new `tail_lag_gain=0.7675` interpolation is a concrete
  failed policy hypothesis. Its released sheet follows the same active
  turn-then-diagonal route but is visibly behind the `0.75` anchor at the
  middle and late frames. It reaches at `38.412`, raises mean distance to
  `1.817L`, energy/power to `53566/4024`, crossflow to `0.2268`, and
  force/moment to `42.78/659.63`. It therefore fails every claimed local-fit
  improvement and even regresses past the `0.80` arrival and distance values.
- The inherited `0.70` rollout is the lower-side failed extrapolation. It
  remains finite and reaches the ring, but the keyframes show a still slower
  approach and larger disturbed trail; metrics regress to `39.605`, `1.872L`,
  `55461/4197`, `0.2429`, and `43.11/675.66`. Together, `0.70`, `0.7675`, and
  `0.80` close further tail-lag refinement around the three exact `0.75`
  repeats. Inherited allocation and bearing-gain regressions, plus the older
  unscaled mixed-feedback instability at `2.807`, also rule out combining
  this promotion with a second speculative change.
- The compact evidence bundles contain no local `wake_diagnostics.json`.
  Claims here are restricted to the supplied keyframes, `wake_metrics.csv`,
  score diagnostics, and inherited optimizer notes; no omitted shelf,
  neighboring configuration, repository history, MP4, VTK field, or external
  artifact was consulted.

## Candidate hypothesis

Change only `tail_lag_gain` from the prefilled `0.80` to the replicated best
value `0.75`. Preserve the `0.55`-period, 28-degree oscillator, gain-`1.7`
bounded body-frame bearing law, 12-degree steering limit, fraction-`0.35`
allocation, damping, and observation set. This is evidence-backed promotion,
not another interpolation: it restores the only lag value that repeatedly
improved arrival, mean distance, command energy, and power while preserving
the visible self-propelled route and semantic success.

The later CFD rollout supports promotion only if it captures and remains close
to the replicated `38.049` arrival, `1.802L` mean distance, `52895/3965`
energy/power, and `0.2249/42.01/653.13` crossflow/load envelope. It is
falsified by loss of capture, regression beyond the `0.80` navigation anchors
(`38.362`, `1.812L`), a material load increase, or a different trajectory
topology. Agreement is repeatability evidence only for the certified wake
phase and start pose; it does not establish held-out robustness.
