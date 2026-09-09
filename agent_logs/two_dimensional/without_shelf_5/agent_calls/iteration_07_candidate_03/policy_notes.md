# Multi-Wake Target-Policy Candidate Notes

## Evidence diagnosis before editing

- The shared prewarm sheet establishes the common initial condition: the fish
  is held at the upper-right release pose while four staggered vortex streets
  develop and merge around the target. It is identical across the sampled
  candidates and therefore gives no controller-specific credit.
- The four current sampled candidates, including the prefill, are byte-identical
  gain-`1.7` policies with byte-identical released keyframe sheets. Each visibly
  self-propels rather than drifting passively: it makes an early turn, leaves a
  dense alternating tail trail, crosses left and down into the developed wake,
  and reaches the `0.75L` ring without collision, exit, or instability. Their
  metrics also repeat exactly: arrival `39.710`, mean distance `1.874L`,
  relative-crossflow RMS `0.2265`, force/moment RMS `38.40/618.59`, and total
  command energy `54703.2`.
- The inherited gain-`1.725` sheet follows the same broad route and still
  captures, but its flatter late approach does not improve navigation. It is
  slower (`40.832`), has greater mean distance (`1.915L`), crossflow (`0.2364`),
  force/moment RMS (`42.50/674.61`), power proxy (`4263.5`), and total command
  energy (`56614.5`) than gain `1.7`. Its maximum joint excursions also rise to
  `0.526/0.556` rad from `0.507/0.528` rad. The inherited gain-`1.9` result is
  likewise weaker than `1.7`, so the evidence rejects another tiny steering-gain
  interpolation while retaining positive, bounded bearing steering.
- The gain-`1.7` diagnostics show a small but repeatable distribution imbalance:
  the posterior joint reaches `0.528` rad versus `0.507` rad anteriorly, while
  both touch the same `4.538` rad/time rate and `31.416` rad/time-squared
  acceleration envelopes. The current compact evidence does not establish the
  scale of bearing-rate, force, or moment feedback, and inherited mixed-feedback
  changes became unstable; adding those signals would confound this test.

## Candidate hypothesis

Preserve the triply inherited and four-way sampled `0.55`-period, 28-degree
oscillator, gain-`1.7` bounded-bearing law, posterior phase lag, damping, and
12-degree total steering command. Change only `anterior_steering_fraction` from
`0.40` to `0.45`. In the existing formula this reallocates five percent of the
same steering center from the posterior joint to the anterior joint; it does
not strengthen total target curvature or change the propulsive oscillator.
The hypothesis is that a more even joint allocation will reduce the larger
posterior excursion and associated moment/crossflow load while preserving the
successful diagonal route.

The later CFD evaluation falsifies this distribution test if it loses capture,
arrives later than `39.710`, raises mean distance above `1.874L`, or fails to
lower either the `0.528`-rad posterior maximum or the `0.2265/38.40/618.59`
crossflow/force/moment envelope. Because all evidence uses one certified wake
phase and start pose, even a positive result would require held-out wake/start
testing before the allocation is treated as generally optimal.
