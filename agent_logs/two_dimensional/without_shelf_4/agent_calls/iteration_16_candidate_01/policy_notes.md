# Multi-wake candidate diagnosis and hypothesis

## Evidence read before the policy edit

- The sampled shared-prewarm sheet shows the fish held at the upper-right
  release pose while the four staggered-cylinder vortex streets develop and
  overlap through the target corridor. It is the certified common initial
  condition and therefore cannot rank candidate control changes.
- All four current released sheets end in finite target capture, so no current
  failure sheet is available. The score-leading assigned parent is the best
  finite visual reference: it actively oscillates through a broad release turn
  and several interacting wake bands, then enters the target almost
  horizontally without collision, exit, instability, or visible terminal
  rebound. Metrics confirm self-propelled, wake-assisted progress rather than
  passive advection: capture occurs at `213.659`, score/mean distance are
  `-3.863/5.856L`, mean upstream head speed exceeds mean local-flow magnitude,
  and RMS relative crossflow/force/moment remain finite at
  `0.13353/17.761/354.838`.
- The constant `0.07` comparator reaches the same useful central-wake region
  only after a longer far-field route and captures at `245.449`. Its
  `6.305L` mean distance, `18.399/363.454` RMS force/moment, and `169649`
  total effort all regress from the parent's `5.856L`, `17.761/354.838`, and
  `148695`. Identical sampled excursion and anterior-acceleration maxima
  isolate steering timing rather than propulsion loss or saturation.
- The away-drift-magnitude selector is a useful but distinct contrast: it
  captures earlier at `196.900` with slightly lower force/moment and effort,
  yet regresses to `6.211L` mean distance and score `-4.230`. More importantly,
  the inherited optimizer log's bounded `75%` progress / `25%` drift-magnitude
  convex blend misses at the `300` horizon with minimum/final/mean distances
  `3.381/3.689/7.507L` and effort `213651`. Its RMS force remains low at
  `17.475`, so safe-looking bounds and load reduction did not preserve the
  progress selector's route. This is a corridor-retention failure, not
  evidence for increasing drive or mixing the two selectors more gently.
- Every current sample retains maximum anterior acceleration near
  `31.055 rad/time^2` under the `31.2` policy guard. Inherited `0.10`
  counter-drift, heading-rate, and bearing-rate variants also delayed or lost
  capture. The supported exploration surface is therefore the pure rolling
  progress schedule's timing, while propulsion, rotational feedback, and the
  evaluated `0.07--0.08` lookahead envelope remain fixed.

## Single candidate hypothesis

Preserve the assigned parent's demonstrated `20.25 deg`, `0.67`-period gait,
posterior lag/damping, `10 deg` steering bound, `0.30` bearing scale, `0.25`
bearing-rate lead, `0.10` lateral-velocity clamp, target-away translation
gate, and `31.2` acceleration guard. Keep the schedule exclusively driven by
rolling closing speed, but reduce its smooth transition scale from
`0.020L/time` to `0.015L/time`. The new scale lies inside the sampled
`0.0126--0.0174L/time` controller-relative upstream-transport range and makes
the existing phase distinction slightly cleaner: lookahead approaches `0.08`
more promptly while receding and `0.07` more promptly while closing. It stays
continuous, equals `0.075` at zero progress, and never leaves the fully
evaluated `0.07--0.08` interval. The sign gate still makes the correction zero
for stationary or targetward lateral translation and bounds it by `0.008 rad`
before the steering nonlinearity.

This tests transition sharpness without reintroducing the falsified
drift-magnitude mixture, changing gait drive, or adding coordinates, route,
clock, prescribed inflow, or remote wake probes. Call it an improvement only
if it retains capture and beats the parent on score or `5.856L` mean distance
without arriving after `213.659` or materially increasing the parent's
crossflow, `17.761/354.838` force/moment, `148695` effort, excursion, or guard
contact. Falsify the sharper transition on a miss, a larger far-field loop or
late rebound, worse distance integral, later capture without a compensating
integral gain, nonpositive controller-relative upstream transport, switching,
or load/effort growth. Its scope remains the certified fixed-prewarm phase
until a held-out wake phase is evaluated; no same-worker CFD outcome is
claimed.
