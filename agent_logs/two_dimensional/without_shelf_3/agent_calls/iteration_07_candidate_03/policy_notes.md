# Multi-Wake Candidate Diagnosis and Hypothesis

## Evidence diagnosis

- The shared prewarm keyframes show the held fish above and downstream of four
  developed, overlapping vortex streets. This is the common initial condition;
  it does not distinguish controllers. Every released sample remains to the
  right of the useful wake and target corridor, so the current decision is a
  far-field propulsion-and-course test rather than a wake-capture claim.
- The strongest sampled finite policy uses the `0.75`-period, `22 deg`
  angle-only oscillator, `12 deg` positive-bearing ceiling, `0.60` bearing
  gain, `0.04` opposing recent-turn-rate damping, localized joint guards, and
  a smooth acceleration bound. Its sheet shows coherent self-propelled motion
  leftward, followed by a broad upper loop and a nearly vertical top exit. The
  metrics agree: head displacement is `(-4.08,+1.80)L`, mean velocity x is
  `-0.0673` versus local-flow x `-0.0457`, minimum range is `6.71L`, and it
  remains finite for `65.47` released time with RMS force/moment `66.5/958`.
  It never reaches the developed cylinder streets; the late lateral motion is
  wasteful course reversal, not productive wake interaction.
- The prefilled `10 deg`-ceiling continuation visibly repeats the same early
  leftward leg and upper curl, but turns nearly vertical sooner and exits at
  the top with only `(-1.43,+1.81)L` head displacement. Its minimum range
  worsens to `9.00L`, progress falls from `0.217` to `0.0417`, and its
  `53.8/788` RMS loads do not reveal a compensating navigation benefit. This
  falsifies the inherited hypothesis that lowering the large-error steering
  ceiling from `12` to `10 deg` would delay the upper loop while retaining the
  useful upstream leg.
- The range-gated `0.04` to `0.06` damping sample also repeats the upper exit;
  it reaches only `8.59L` minimum range and `-2.48L` head x. Its smooth gate
  changes the controller before the nominal `8L` threshold, and the fish never
  reaches that threshold, so another range-gated derivative schedule in the
  same band is not supported. The guarded bearing-only sample has elevated
  RMS force/moment `350/5007` and curls upward as well, so removing damping is
  not a clean supported alternative.
- The assigned-parent logs now provide the opposite uniform-damping endpoint.
  With the strongest policy otherwise retained, `0.05` damping reaches a
  comparable `6.83L` minimum but ultimately moves `(+0.33,-13.31)L` and exits
  below/downstream after `92.81` time. Thus `0.04` and `0.05` bracket the
  needed lateral response: the former preserves the strongest upstream leg but
  under-corrects upward, whereas the latter over-corrects through a long lower
  excursion. Full-orbit radial regulation and compound rate/load feedback are
  already negative inherited boundaries and are not reopened here.

## One candidate hypothesis

Restore the complete strongest finite policy, including its `12 deg` steering
ceiling, and change only uniform opposing recent-turn-rate damping relative to
that anchor, from `0.04` to `0.045`. This is the unsampled midpoint of the
direct `0.04` upper-exit and `0.05` lower-exit bracket. Uniform damping avoids
the premature sensitivity of the failed distance gate, while preserving the
demonstrated angle-only gait, posterior lag, steering gain, local joint guards,
and `1600 deg/time^2` smooth action bound.

Every active constant remains in `target_policy_params`; feedback uses only
body-frame bearing, recent turn rate, and joint state. It encodes no fixed
coordinates, route, target identity, elapsed time, prescribed inflow, remote
wake probe, or omitted research shelf. The next CFD rollout supports the
hypothesis only if it retains negative head and relative-flow x, changes net y
from an upper exit toward moderate descent, improves on or passes through the
`6.71L` closest approach without either endpoint U-turn, and remains finite
without renewed joint/load growth. It is falsified if upstream propulsion
collapses, the topology remains an upper loop, or `0.045` already crosses to
the lower/downstream exit. No result for this unevaluated candidate is claimed.
