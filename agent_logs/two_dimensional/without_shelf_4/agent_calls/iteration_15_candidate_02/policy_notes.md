# Multi-wake candidate diagnosis and hypothesis

## Evidence read before the policy edit

- The sampled shared-prewarm sheets are the same certified initial condition:
  the fish is held at the upper-right release pose while four staggered-cylinder
  streets develop and overlap across the target corridor. This developed flow
  is common to the candidates and does not rank their policies.
- All four current rollout sheets terminate in finite target capture; there is
  no current hard-failure sheet. The inherited logs identify the informative
  hard boundary as a sign-asymmetric bearing-rate horizon miss with repeated
  wide reversals and lost corridor retention. Among current samples, the
  constant `0.07` lateral counter-drift policy is the weakest control contrast:
  its sheet still enters the useful wake and approaches almost horizontally,
  but only after a longer sequence of far-field reversals. It captures at
  `245.449`, with score `-4.291`, mean distance `6.305L`, controller-relative
  upstream transport `0.01284`, RMS lateral force/moment `18.399/363.454`, and
  total command energy `169649.0`.
- The best finite sample schedules the same sign-gated counter-drift lookahead
  between `0.07` and `0.08` using rolling closing speed. Its sheet shows a
  self-propelled fish making a broad release turn, crossing several interacting
  wake bands, and entering the target almost horizontally without collision,
  domain exit, instability, or visible high-frequency switching. It captures
  at `213.659`; score and mean distance improve to `-3.863/5.856L`, RMS lateral
  force/moment fall to `17.761/354.838`, and total command energy falls to
  `148694.7`. Mean upstream head velocity `-0.05083` exceeds the magnitude of
  mean local-flow x `-0.03822`, leaving positive controller-relative upstream
  transport `0.01261`; the route is wake-assisted rather than passive
  advection.
- The independently scheduled away-drift-magnitude sample is the fastest
  current capture at `196.900` and has slightly lower force/moment
  `17.672/352.909`, but its `-4.230` score and `6.211L` mean distance are worse
  than the rolling-progress result. The constant `0.08` sample also captures
  later at `224.488` with `6.311L` mean distance. Thus current evidence favors
  closing-speed phase selection for distance-integral quality while showing
  that arrival time alone is not a sufficient route criterion.
- All four current policies retain the same `4.293L` maximum lateral target
  offset and `31.055 rad/time^2` maximum anterior acceleration beneath the
  `31.2` policy guard. Their behavior difference is therefore attributable to
  bounded steering timing, not increased drive, a smaller excursion envelope,
  or actuator saturation. Inherited `0.10` and heading-rate continuations
  regressed, so neither a larger counter-drift bracket nor rotational damping
  has positive support.

## Single candidate hypothesis

Adopt the evaluated rolling-closing-speed counter-drift policy as the one
candidate. Preserve the demonstrated `20.25 deg`, `0.67`-period propulsion
shell, posterior lag/damping, `10 deg` steering bound, `0.30` bearing scale,
`0.25` bearing-rate lookahead, `0.10` lateral-velocity clamp, and `31.2`
acceleration guard. Smoothly select lookahead `0.08` while the rolling distance
signal is receding and `0.07` while it is closing, with the evaluated
`0.02L/time` transition scale. Retain the existing target-away translation
gate, so the added term is zero for stationary or targetward lateral motion
and remains bounded by `0.008 rad` before the steering nonlinearity.

This candidate is preferred to an unevaluated extrapolation because its
fixed-prewarm rollout already improves the assigned `0.07` parent in score,
mean distance, arrival, loads, and total effort while preserving finite
self-propulsion and the actuator/excursion envelope. It uses normalized
body-frame and rolling-distance feedback without coordinates, a route, a
clock, prescribed inflow, or remote wake probes. Treat its benefit as local to
the certified wake phase. Falsify transfer on lost or later-than-`213.659`
capture, mean distance above `5.856L`, score below `-3.863`, loss of positive
controller-relative upstream transport, material crossflow/load/effort growth,
guard contact, a larger excursion, or visible switching. The current worker
claims no new CFD result; held-out wake phase evidence is still required for a
transferable conclusion.
