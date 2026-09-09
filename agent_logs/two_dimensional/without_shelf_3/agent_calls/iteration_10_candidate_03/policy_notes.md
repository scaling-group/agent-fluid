# Multi-Wake Candidate Diagnosis and Hypothesis

## Visual and quantitative diagnosis

- The shared prewarm sheet shows the fish held at the common upper-right
  release pose while four developed, interacting cylinder streets pass through
  the target region. This is identical initial-condition evidence, not a
  controller effect.
- Every sampled released sheet stays to the right and above the useful
  target-centered wake corridor. The fish actively swims upstream before a
  sharp upper pitch and U-turn: the strongest finite policy moves at mean
  x velocity `-0.0673` while its mean local flow is only `-0.0457`, then exits
  after head displacement `(-4.08,+1.80)L`. Its `6.71L` minimum range,
  `0.217` progress, and RMS force/moment `66.5/958` make this guarded
  gain-`0.60`, limit-`12 deg`, turn-damping-`0.04` policy the far-field
  anchor, not evidence of wake entry or capture.
- The higher-authority prefill, the `14 deg` ceiling sample, and the current
  lateral-velocity sample show the same visible upper-loop topology but
  shorten head-x travel to `-2.45L`, `-2.46L`, and `-2.72L`. Their minimum
  ranges are `10.35L`, `8.85L`, and `8.20L`, respectively. The tested
  `-velocity_body_y` correction therefore remains finite and lower-load than
  the prefill, but it does not preserve the anchor's approach.
- The assigned parent's inherited `0.0425` and `0.0375` turn-damping results
  close both sides of the local scalar bracket. They retain the upper exit
  while cutting head-x travel to `-1.93L` and `-0.63L`, with minimum ranges
  `8.42L` and `9.92L`; inherited `0.045`, `0.05`, range-gated damping, lower
  bearing gain, and large-bearing rolloff are negative as well. Another
  steering-gain, limit, derivative-gain, absolute-bearing, or direct lateral
  damping interpolation is not supported before wake entry.
- The anchor's joint diagnostics expose an untested allocation asymmetry.
  Joint one reaches `0.568 rad` (`32.6 deg`) and `4.36 rad/time`
  (`250 deg/time`), close to the `34 deg` guard and `260 deg/time` hard limit;
  joint two reaches only `0.453 rad` (`26.0 deg`) and `3.34 rad/time`
  (`191 deg/time`). Both joints currently receive the same guard thresholds,
  while the anterior fraction has stayed `0.35` in all sampled and inherited
  scalar course tests.

## One candidate hypothesis

Restore the strongest finite controller exactly and change only its steering
allocation from `0.35/0.65` to `0.25/0.75` anterior/posterior. The fractions
still sum to one, so the bounded bearing/turn-rate request and `12 deg` total
steady-curvature command are unchanged. At maximum steering this transfers
only `1.2 deg` of mean bias from the joint whose angle and speed approach their
guards to the joint with measured excursion headroom. The `0.75`-period
angle-only oscillator, posterior traveling-bend lag, `0.04` turn damping,
joint protections, and smooth `1600 deg/time^2` demand bound remain fixed.

This is supported only if the reallocation remains finite, preserves the
anchor's active upstream leg, and delays or redirects the upper pitch without
raising posterior excursions or force/moment loads materially. Strong evidence
would improve on `-4.08L` head-x travel or `6.71L` minimum range while moving
head y toward the target rather than the upper boundary. It is falsified if
upstream travel collapses, the same upper U-turn persists without a closer
approach, joint two reaches its guard or hard limits, a lower return appears,
or loads rise. The policy uses only body-frame bearing, recent turn rate, and
joint state; it adds no coordinates, clock, route, prescribed inflow, remote
probe, target-station signal, or omitted research-shelf dependency. Its CFD
outcome is not claimed here because evaluation occurs after this worker exits.
