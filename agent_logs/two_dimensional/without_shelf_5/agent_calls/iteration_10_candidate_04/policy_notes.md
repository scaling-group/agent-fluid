# Multi-Wake Target-Policy Candidate Notes

## Evidence diagnosis before editing

- The four sampled shared-prewarm sheets are byte-identical. They show the fish
  held at the upper-right release pose while the asymmetric four-cylinder
  streets develop and merge near the target, so they establish the common
  initial condition but cannot distinguish controller quality.
- The two sampled `anterior_steering_fraction=0.35` rollouts are exact finite
  replicas and are the strongest current evidence. Their released sheets show
  active propulsion rather than passive advection: after an early turn the
  fish leaves a dense alternating tail trail, travels left and down through the
  developed wake corridor, and crosses the `0.75L` ring without collision,
  domain exit, or instability. Mean fish velocity `(-0.2829,-0.1181)` versus
  mean local flow `(-0.1703,-0.1656)` confirms self-propelled leftward progress.
  Both reach at `38.362`, with mean distance `1.812L`, command energy `53487.3`,
  power proxy `4007.1`, relative-crossflow RMS `0.2244`, force/moment RMS
  `40.73/637.79`, and joint maxima `0.494/0.521` rad.
- The two sampled fraction-`0.30` rollouts are also exact replicas. Their sheets
  retain the same safe turn-then-diagonal topology and target capture, but the
  continuation below `0.35` is a measured policy-hypothesis failure: arrival
  regresses to `39.286`, mean distance to `1.850L`, mean velocity to
  `(-0.2764,-0.1132)`, command energy to `56145.5`, power to `4263.2`,
  relative crossflow to `0.2447`, force/moment RMS to `42.06/662.67`, and peak
  joint angles to `0.512/0.583` rad. The posterior excursion increase is
  especially strong even though the total bounded-bearing command is unchanged.
- No current sampled rollout is a semantic failure. Fraction `0.30` is the most
  informative current negative comparator because it directly falsifies the
  inherited equal-step extrapolation from `0.40 -> 0.35`. Combined with the
  inherited fraction-`0.45` regression (`43.323`, `2.025L`, `60174.8`,
  `0.2456`, `41.96/709.54`, `0.544/0.562`), the allocation response is visibly
  and metrically non-monotonic around the replicated `0.35` anchor. Inherited
  gain-`1.725`/`1.9` regressions and the older unstable mixed-feedback result
  provide no evidence for changing gain or adding unscaled flow/load signals.

## Candidate hypothesis

Restore `anterior_steering_fraction` from the prefilled `0.30` to the replicated
`0.35` anchor. Preserve the evaluated `0.55`-period, 28-degree oscillator,
gain-`1.7` bounded body-frame bearing law, positive steering sign, 12-degree
total steering bound, posterior phase lag, damping, and observation set. This
candidate reverses only the failed allocation extrapolation; it neither
strengthens total curvature nor encodes a global direction, coordinate, route,
or external phase.

Because this is the exact previously evaluated `0.35` policy, the later CFD
rollout should reproduce safe capture near `38.362`, mean distance `1.812L`,
energy `53487.3`, crossflow `0.2244`, loads `40.73/637.79`, and peak angles
`0.494/0.521` within deterministic tolerance. Failure to capture, material
departure from those replicated values, or posterior excursion above the
`0.30` result's `0.583` rad would falsify either reproducibility or the anchor
selection. The allocation conclusion applies only to the tested `0.30--0.45`
interval at the certified wake phase and start pose; changed wake phase or pose
remains a required robustness test.
