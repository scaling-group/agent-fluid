# Multi-Wake Policy Candidate Notes

## Evidence diagnosis before the policy edit

- The assigned parent guidance records the seed's missing steering mechanism,
  while its inherited worker note proposed a full-anterior `10 deg` bearing
  bias plus a `0.5` posterior share. The evaluated parent
  (`solver_ad1db499142c`) falsified that particular translation: released
  keyframes show an immediate downstream/right departure, head displacement
  was `(2.195,-1.302)L`, closest distance was still `12.424L`, and the fish
  left the domain after only `18.683` released time units. Its low loads do not
  rescue a controller that swims away from the target.
- The common prewarm sheet shows the same developed, interacting four-wake
  field for all candidates. The target-blind seed then visibly sustains a
  traveling bend but curls almost vertically down and exits; metrics agree
  with `(-3.545,-13.300)L` head displacement, `8.615L` closest approach, and
  both joint velocity and acceleration reaching their caps. This establishes
  that the propulsive scaffold is useful but cannot navigate by itself.
- The two successful samples isolate a more useful curvature distribution.
  `solver_cf905c92f9f7` uses at most `8 deg` anterior plus `5.2 deg`
  posterior mean bend and reaches the target in `42.856` units.
  `solver_96495c5b1e65`, which is the prefilled candidate, bounds total
  curvature at `12 deg` but assigns only `5.4 deg` anterior and `6.6 deg`
  posterior at full demand; it follows a similarly direct diagonal path and
  reaches in `39.737` units with the best sampled mean distance (`1.934L`).
  Thus target-bearing curvature is validated, but the failed parent shows that
  front-loading the bend is not interchangeable with distributing it.
- The faster success also reaches both velocity and acceleration caps and has
  higher RMS lateral force/moment (`53.736`/`761.948`) than the slower success
  (`50.401`/`712.999`). The current evidence supports preserving its total
  authority and gait scalars, not increasing drive or adding uncalibrated
  flow/force cancellation.

## Candidate hypothesis

Keep the best sampled policy's state-feedback oscillator, posterior lag,
`12 deg` total curvature bound, and bearing scale. Replace its fixed `45/55`
anterior/posterior curvature split with one smooth wave-shape mechanism: use a
near-balanced split at small steering demand, then shift a modest amount of the
same bounded total curvature toward the posterior joint as normalized
body-frame bearing demand grows. This retains anterior oscillation headroom
during large redirects and returns close to the already successful allocation
as alignment improves; it neither increases total bend nor uses a route,
clock, wake phase, or world coordinate.

Expected evidence is preservation of target capture and the initial direct
diagonal topology, with equal or earlier arrival and no increase in joint-limit
residence or force/moment loads. Falsify the mechanism if target capture is
lost, the turn reverses, mean distance worsens materially from `1.934L`, the
trajectory acquires a new lateral excursion, or posterior bias increases
saturation/load without an arrival benefit.

bookshelf_consulted: true
source_domain: elongated-body propulsion and robotic-fish wave-shape steering
source_mechanism: posterior emphasis preserves a traveling bend while bounded joint-distribution modulation supplies turning
transferable_invariant: allocate a fixed bounded curvature request across the body so large steering demand does not consume the anterior oscillator's propulsive excursion
nontransferable_details: published gains, species envelopes, dimensional frequencies, actuator geometry, exact vortex phase, and source-task routes
policy_translation: map only bounded body-frame bearing demand to a smooth anterior/posterior allocation of the validated total curvature, retaining joint-state phase and posterior lag
falsification: reject if capture or direct targetward motion is lost, arrival slows materially, the turn sign changes, or posterior joint saturation and wake loads grow without benefit
