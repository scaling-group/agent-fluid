# Multi-Wake Target-Policy Candidate Notes

## Evidence diagnosis before editing

- The four sampled shared-prewarm sheets are byte-identical. They show the fish
  held at the upper-right release pose while the asymmetric four-cylinder
  streets develop and merge through the target region, so they establish the
  common initial condition but cannot distinguish controller quality.
- Three sampled policies are exact `tail_lag_gain=0.80`,
  `anterior_steering_fraction=0.35` replicas. Their released sheets show an
  actively self-propelled early turn followed by a left-down traverse into the
  merged wake and target-ring crossing; mean fish velocity
  `(-0.2829,-0.1181)` versus local flow `(-0.1703,-0.1656)` confirms that the
  leftward motion is not passive advection. Each reaches safely at `38.362`,
  with mean distance `1.812L`, command energy `53487.3`, power `4007.1`,
  relative-crossflow RMS `0.2244`, force/moment RMS `40.73/637.79`, and joint
  maxima `0.494/0.521` rad.
- The strongest sampled finite policy changes only `tail_lag_gain` from `0.80`
  to `0.75`. Its released sheet preserves the same early turn, dense
  alternating tail trail, wake-corridor entry, and collision-free target
  crossing, with slightly more progress at corresponding frames. Diagnostics
  confirm earlier arrival (`38.049`), lower mean distance (`1.802L`), lower
  command energy (`52895.0`) and power (`3965.3`), and stronger mean velocity
  `(-0.2853,-0.1198)`. Posterior peak angle is unchanged to four decimals
  (`0.5208` rad) and crossflow changes only `0.2244 -> 0.2249`, but anterior
  peak rises `0.4941 -> 0.4964` rad and force/moment RMS rise by about
  `3.1%/2.4%` to `42.01/653.13`. Both policies touch the same rate and
  acceleration caps. Thus `0.75` is a navigation/effort improvement, not the
  originally hypothesized load or saturation repair.
- The inherited fraction-`0.30` rollout is the most informative policy-
  hypothesis failure because none of the current samples has a semantic
  failure. Its sheet retains the broad safe route and target crossing but lags
  visibly at matched frames; metrics regress to `39.286` arrival, `1.850L`
  mean distance, `56145.5` energy, `0.2447` crossflow, `42.06/662.67` loads,
  and `0.512/0.583`-rad peaks. Together with the inherited fraction-`0.45`
  regression, this rejects further allocation extrapolation around the
  replicated `0.35` anchor. Inherited gain-`1.725`/`1.9` regressions and the
  older mixed-feedback instability likewise give no support for another gain
  fit or an unscaled new state signal.

## Candidate hypothesis

Adopt the strongest sampled policy exactly: retain the evaluated `0.55`-period,
28-degree gait, positive gain-`1.7` bounded body-frame bearing law, 12-degree
steering bound, fraction-`0.35` allocation, and damping, while changing only
`tail_lag_gain` from the prefilled `0.80` to `0.75`. This produces one bounded,
target-relative controller without a fixed coordinate, route, elapsed-time
switch, or omitted-shelf mechanism.

Because this exact policy has already been evaluated once, the later CFD run
should reproduce safe capture near `38.049`, mean distance `1.802L`, energy
`52895`, crossflow `0.2249`, loads `42.01/653.13`, and joint peaks
`0.496/0.521` within deterministic tolerance. Loss of capture or material
departure from those values falsifies reproducibility. The improvement is
also rejected as a useful control lesson if the modest force/moment increase
becomes a failure or substantially worsens under changed wake phase or start
pose; no monotonic claim is made for tail-lag values below `0.75`.
