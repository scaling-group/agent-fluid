# Multi-Wake Target-Policy Candidate Notes

## Evidence diagnosis before editing

- The sampled shared-prewarm sheets are byte-identical common-initial-condition
  evidence: the fish stays held at the upper-right release pose while the four
  staggered cylinder streets develop and merge around the target. They cannot
  distinguish controller quality.
- The two sampled `anterior_steering_fraction=0.35` rollouts are exact finite
  replicas and the strongest current anchor. Their released sheets show active
  propulsion rather than passive advection: after the initial left-down turn,
  the fish leaves a dense alternating tail trail, enters the merged wake
  corridor, and crosses the `0.75L` target ring without collision, exit, or
  instability. Mean fish velocity `(-0.2829,-0.1181)` exceeds mean local flow
  in the leftward component `(-0.1703,-0.1656)`. Both arrive at `38.362`, with
  mean distance `1.812L`, command energy `53487.3`, power `4007.1`, relative-
  crossflow RMS `0.2244`, force/moment RMS `40.73/637.79`, and peak joint
  angles `0.494/0.521` rad.
- The two sampled fraction-`0.30` sheets preserve the same broad turn-then-
  diagonal route and target capture, but the later panels show less progress at
  comparable positions in the developed wake. Diagnostics make this a clear
  failed continuation of the allocation sweep: arrival regresses to `39.286`,
  mean distance to `1.850L`, energy to `56145.5`, power to `4263.2`, relative
  crossflow to `0.2447`, force/moment RMS to `42.06/662.67`, and peak angles to
  `0.512/0.583` rad. In particular, moving another five percent of steering
  center posteriorly raised the posterior excursion by about twelve percent
  rather than improving propulsion or load balance.
- The inherited fraction-`0.40` replicas and fraction-`0.45` hypothesis failure
  complete a local bracket. Fraction `0.40` reaches at `39.710` with mean
  distance `1.874L`, energy `54703.2`, crossflow `0.2265`, and peak angles
  `0.507/0.528` rad; it lowers force/moment RMS to `38.40/618.59` relative to
  `0.35`, so the strongest navigation anchor carries a measured lateral-load
  tradeoff. The inherited `0.45` keyframes remain self-propelled and successful
  but visibly traverse the same route more slowly, agreeing with its `43.323`
  arrival, `2.025L` mean distance, `60174.8` energy, `0.2456` crossflow,
  `41.96/709.54` force/moment RMS, and `0.544/0.562`-rad peaks.
- Thus the visual and diagnostic evidence rejects another equal `0.05`
  allocation step in either direction and retains the `0.55`-period,
  28-degree gait, gain-`1.7` positive bounded-bearing law, 12-degree steering
  bound, posterior phase lag, damping, and observation set. The older inherited
  mixed-feedback instability at `2.807` remains an outer boundary against
  adding an observation whose scale is not established here.

## Candidate hypothesis

Preserve the evaluated controller structure and change only
`anterior_steering_fraction` from `0.35` to `0.34`. The replicated `0.30`,
`0.35`, and `0.40` navigation results bracket the best measured allocation,
with their arrival and mean-distance curvature placing a local interpolant just
below `0.35`. The one-point shift is intentionally much smaller than the
falsified five-point continuation: at saturated steering it moves only `0.12`
degree of the unchanged total center toward the posterior joint. It introduces
no new signal, gain, total curvature, propulsion change, or global route.

The later CFD rollout supports this local refinement only if it retains clean
capture and active diagonal propulsion while improving at least one of the
`0.35` navigation/effort anchors—arrival `38.362`, mean distance `1.812L`,
energy `53487.3`, or power `4007.1`—without exceeding its `0.2244` relative-
crossflow, `40.73/637.79` force/moment, or `0.494/0.521`-rad joint envelopes.
No earlier arrival with a material posterior-excursion or load increase counts
as a clean improvement. Failure to beat the anchor makes `0.35`, rather than a
finer numeric fit, the allocation setting later workers should retain. Any
positive outcome remains limited to the certified wake phase and start pose
until those conditions are varied.
