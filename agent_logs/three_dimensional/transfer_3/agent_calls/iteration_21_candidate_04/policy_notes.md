# Candidate diagnosis and hypothesis

## Evidence read before editing

- All four sampled rollouts use direct uniform still-water initialization with
  `U_infinity=[0,0,0]`, no prewarm snapshot, and capture termination. Three
  samples, including the assigned prefill, are byte-identical v29 policies and
  reproduce score `-0.52807723`, capture at `25.11852 T`, mean distance
  `2.42908721 L`, and final distance `0.74613529 L`.
- The combined top-down/oblique sheets show that v29 is self-propelled rather
  than advected: it lays down a coherent alternating mid-plane wake and finite
  three-dimensional Lambda2 structures while following a compact curved path
  to the target. Its informative weakness is not capture failure but outer
  joint-space distortion: independent clipping reaches the acceleration cap on
  about `39.4%/31.5%` of anterior/posterior commands, although no command above
  `30 rad/T^2` occurs inside `4 L`.
- The sampled v33 partial common-scale limiter keeps the same coherent wake
  topology in both views and advances materially farther by the middle and late
  keyframes. It captures at `23.43552 T`, improves score to `-0.40797361` and
  mean distance to `2.30503257 L`, and raises peak planar speed from `0.69257`
  to `0.82242 L/T`. Anterior cap incidence falls to `26.9%`; posterior incidence
  is `33.3%`. Joint excursions remain below the `45 deg` stops and terminal
  commands remain below `30 rad/T^2`. The tradeoff is a small rise in whole-run
  lateral-force and yaw-moment maxima (`0.02647` versus `0.02620`, and
  `0.01520` versus `0.01499`), so load growth is a falsification boundary, not
  an established benefit.
- Inherited optimizer logs also show that terminal cadence recovery regressed
  to `-0.52812468`, while multiple v29/intercept samples reproduced the same
  plateau. This supports moving the mechanism to the independently active outer
  saturation locus and leaving the captured terminal glide unchanged.

## Policy hypothesis

Adopt the already sampled v33 limiter exactly: outside the terminal
reallocation band, blend a small fraction of per-joint clipping toward one
common command scale. This preserves more of the raw anterior/posterior command
direction when either joint exceeds the envelope, while the normalized
target-range gate makes the mechanism dormant at and inside `4 L`. Reproducing
the evaluated mechanism from the assigned parent is more diagnostic than
stacking another terminal cue or changing its scalar strength.

bookshelf_consulted: true
source_domain: classical traveling-wave swimming and coupled-oscillator robotic-fish control
source_mechanism: preserve interjoint phase and amplitude coordination so a bounded command remains a directed traveling bend rather than a clipped standing distortion
transferable_invariant: actuator limiting should preserve the relative two-joint command direction when possible because posterior lag and anterior-posterior coordination carry propulsion
nontransferable_details: published gains, dimensional cadence, species-specific amplitude envelopes, exact phase lags, full-body waveforms, and task-specific routes
policy_translation: use normalized target range to activate a bounded partial common-scale limiter only outside the validated terminal band; retain the existing body-frame target feedback and two-joint state-feedback oscillator
falsification: reject if reproduction loses capture, delays closure, changes the compact target-directed topology, degrades either wake view, reaches a joint stop, activates above 30 rad/T^2 inside 4 L, or materially increases force or yaw-moment loads
