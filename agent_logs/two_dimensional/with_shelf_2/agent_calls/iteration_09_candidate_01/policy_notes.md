# Multi-wake candidate diagnosis and hypothesis

## Evidence read before editing

- The shared prewarm sheet shows the fixed fish held near the upper-right
  release while four staggered cylinder streets develop and merge around the
  target. It is common initial-condition evidence, not a candidate effect.
- All four sampled released sheets are successful and visually share the same
  useful topology: a self-propelled traveling body wave carries the fish
  diagonally upstream and downward from the release, the fish enters the
  interacting wake corridor, and it turns nearly horizontal before the first
  `0.75L` target crossing. No sampled failure sheet is available, so the most
  informative current contrast is the slower alignment-only success; inherited
  failure summaries are used only as boundaries.
- The prefilled progress-conditioned candidate is the strongest finite sample:
  `target_reached` at `45.48`, mean/final/minimum distance
  `1.724/0.748/0.748L`, head displacement `-10.97/-4.59L`, and force/moment
  RMS `405/4029`. The alignment-only policy reached at `46.80` with mean
  distance `1.745L` and higher `441/4259` loads. The symmetric closing-speed
  modulation and progress-deficit variants also reached, but at `46.66` and
  `46.31`; the deficit variant reduced load to `393/3878` while giving up the
  parent's arrival and distance advantage. Thus observed positive closure is
  the evidenced condition for extra posterior propulsion in this route.
- The current policy already reaches joint-rate caps (`4.538` rad/time) and
  nearly fills its candidate acceleration soft limit (about `28.8`), while its
  maximum joint angles remain below the hard bend bound. Inherited evidence
  also says direction-blind headroom allocation destroyed the successful route
  and caused a lower-cylinder collision. Preserve the sum-then-soft-limit
  composition, yaw-magnitude steering gate, and current posterior amplitude
  envelope.

## Candidate hypothesis

Add one new mechanism: when predicted bearing is aligned and normalized
closing efficiency is positive, increase posterior phase lag slightly while
renormalizing the harmonic lag basis to preserve its nominal amplitude. Keep
the parent's `10%` alignment plus `5%` progress-conditioned posterior envelope
unchanged. This tests whether a more clearly traveling posterior bend converts
the already useful progress state into earlier capture without another scalar
amplitude increase. The phase correction vanishes while turning, stalled, or
moving away, so it should not add steering authority during the vulnerable
diagonal redirect.

Reject the mechanism if it loses `target_reached`, changes the established
diagonal-to-horizontal route, arrives later than `45.48`, raises mean distance
above `1.724L`, or worsens joint-cap residence and force/moment load without a
route or arrival benefit. Because the new rollout is unavailable to this
worker, these remain falsification criteria rather than claimed results.

bookshelf_consulted: true
source_domain: classical elongated-body reactive swimming
source_mechanism: coherent traveling bend with posterior phase lag and tail-end emphasis
transferable_invariant: posterior timing should sustain a directed body wave, and phase should be testable separately from amplitude
nontransferable_details: published gains, dimensional beat frequencies, species envelopes, exact vortex phases, and full-body kinematics
policy_translation: use bounded predicted-bearing alignment and closing-speed-to-body-speed efficiency to modulate the two-joint posterior lag, with harmonic amplitude normalization
falsification: reject if capture, route topology, arrival, distance history, cap residence, or load is worse than the sampled progress-gated parent
