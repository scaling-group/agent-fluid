# Multi-Wake Target-Policy Candidate Notes

## Evidence diagnosis before the policy edit

- The assigned parent retains the `0.55`-period, `28 deg` traveling bend and
  splits a bounded target-bearing curvature across both joints. Its latest
  candidate adds a gait-relative circular average of `bearing_history`; the
  inherited hypothesis was that this would suppress beat-scale route-command
  motion without weakening propulsion.
- The shared prewarm sheet shows the fish held above four developed,
  interacting vortex streets. It is the identical initial condition for all
  candidates. On release, the filtered-bearing prefill turns toward the target
  immediately, remains visibly self-propelled, crosses the interacting wakes
  on a compact diagonal, and enters the capture circle without a late overshoot
  or a persistent wrong-way curl.
- Completed evaluation resolves the parent's filter hypothesis only partly.
  Relative to the otherwise identical instantaneous-bearing `45/55` policy,
  the filtered policy reaches the target sooner (`36.564` versus `39.737`) and
  improves mean distance (`1.808L` versus `1.934L`). It also increases mean
  command energy (`1416.8` versus `1278.8`), RMS force (`66.2` versus `53.7`),
  and RMS moment (`901.7` versus `761.9`). Both policies touch the joint-speed
  and acceleration envelopes, while the filtered policy has larger joint-angle
  extrema (`0.548/0.562` versus `0.536/0.539 rad`). Thus slow route extraction
  helps arrival but removes useful fast feedback or otherwise amplifies body
  yaw/load; it is not an evidenced load-reduction mechanism.
- The instantaneous-bearing `40/60` anterior/posterior sibling is a second
  useful contrast: it captures at `37.955`, keeps mean distance to `1.858L`,
  and has the lowest sampled RMS force/moment (`45.9/670.2`) and command total
  (`49166`). This supports preserving posterior authority, but a scalar split
  change alone cannot identify why filtering raised loads.
- No current sampled sheet is a failure: all four examples reach the target.
  The informative failure boundary therefore comes from the inherited visual
  diagnosis and metrics. A full anterior bias lost the traveling-wave thrust,
  moved only `(+2.195,-1.302)L`, never approached within `12.424L`, and exited
  after `18.683`; a slower `0.9/20 deg` gait repeated the wrong-way exit with
  only `17.02` mean command energy. The new mechanism must leave the evidenced
  gait and coherent two-joint curvature allocation intact.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: organized-wake interaction and sensor-feedback robotic-fish direction tracking
source_mechanism: separate persistent route steering from bounded fast yaw-disturbance rejection around an oscillatory gait
transferable_invariant: a slow body-frame direction request and a fast measured yaw response should occupy distinct feedback paths, with the fast path opposing rotation without cancelling the propulsive traveling bend
nontransferable_details: published gains, dimensional filters and beat rates, robot or species geometry, exact vortex phases, cylinder-specific flow signatures, and source-task routes
policy_translation: retain the filtered body-frame bearing as the route request, add a small gait-normalized `heading_rate` damping residual inside the same total-curvature envelope, split the resulting curvature across the existing joint centers, and leave the oscillator and posterior lag unchanged
falsification: reject the residual if target capture is lost or delayed, the diagonal trajectory degrades, propulsion collapses, or force/moment and command load do not improve enough to justify added feedback

## Candidate hypothesis

Make exactly one controller-mechanism change to the successful filtered policy:
add bounded yaw-rate damping to the mean-curvature command. The residual uses
the observed normalized heading change per control period, has only `3 deg` of
authority, and shares the existing `12 deg` total-curvature envelope rather
than adding actuation beyond it. The empirical sign is chosen so positive
heading rate requests the positive curvature known to produce negative yaw,
and conversely for negative heading rate. The `45/55` split, bearing filter,
oscillator, amplitude, posterior lag, and damping remain fixed.

Expected downstream evidence is retained `target_reached` behavior near the
prefill's compact `36.6`-unit route, with lower moment/force RMS, command mean,
or saturation severity. This worker does not claim that unevaluated outcome;
later evaluation must reject the mechanism if reduced loads are bought by a
slower approach or loss of capture.
