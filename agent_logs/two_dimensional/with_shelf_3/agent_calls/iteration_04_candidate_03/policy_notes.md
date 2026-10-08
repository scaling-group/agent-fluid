# Multi-Wake Target-Policy Candidate Notes

## Evidence diagnosis before the policy edit

- The assigned parent preserves the seed's `0.55`-period, `28 deg`
  posterior-lagged traveling bend and uses instantaneous body-frame bearing to
  request one bounded `12 deg` mean-curvature budget split `40/60` across the
  two joints. Its sampled rollout (`solver_e3c2e0960563`) visibly turns early,
  self-propels diagonally through the developed four-cylinder wakes, and enters
  the `0.75L` capture circle. Metrics confirm `target_reached` at `37.955`
  release-time units with `1.858L` mean distance.
- The shared prewarm sheet shows the common held fish above interacting,
  developed vortex streets. This is identical initial-condition evidence, not
  a policy advantage. The released sheets for the parent and the strongest
  sampled policy both show the same useful topology: sustained traveling-wave
  propulsion, a compact targetward diagonal, and direct first entry rather
  than passive downstream advection or a terminal overshoot.
- The strongest sample (`solver_2bde45adf1e2`) adds an exponentially weighted
  circular mean of short body-frame bearing history to the older `45/55`
  allocation. It reaches in `36.564`, improves mean distance to `1.808L`, and
  has the best sampled score (`0.06689`). Relative to the instantaneous
  `45/55` replay (`39.737`, `1.934L`), this is evidence that separating
  persistent route error from beat-scale bearing motion can improve approach.
  It is not evidence that filtering damps loads: mean command energy rises
  from `1278.8` to `1416.8`, while RMS lateral force/moment rise from
  `53.74/761.95` to `66.17/901.74`.
- Moving the instantaneous controller from `45/55` to the assigned parent's
  `40/60` split improved arrival from `39.737` to `37.955` and mean distance
  from `1.934L` to `1.858L`, while reducing RMS force/moment to
  `45.93/670.16` and maximum joint angles from about `0.536/0.539` to
  `0.502/0.492 rad`. The filter and split were evaluated separately, so their
  combination remains an interaction hypothesis rather than an established
  additive improvement.
- The informative failures are available through inherited visual diagnoses
  and metrics rather than the current sampled keyframe set. The target-blind
  seed curled into a lower-domain exit after moving `(-3.545,-13.300)L`; an
  anterior-heavy `10/5 deg` bias lost upstream propulsion and exited after
  moving only `(+2.195,-1.302)L`. These failures bound the edit: retain the
  evidenced gait and posterior authority, and do not add wake cancellation or
  weaken propulsion merely to lower effort.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: organized-wake fish interaction and sensor-feedback robotic-fish direction tracking
source_mechanism: separate persistent direction error from fast oscillatory yaw before biasing an otherwise propulsive gait
transferable_invariant: mean-curvature steering should follow a short body-frame estimate of persistent target direction while the posterior-lagged traveling component remains intact
nontransferable_details: published filter constants and gains, dimensional frequencies, robot or species geometry, exact vortex phases, and task-specific routes
policy_translation: circular-average the provided normalized body-frame bearing history with an owned gait-relative decay horizon, then feed that estimate into the parent's existing bounded curvature request and `40/60` joint split without changing propulsion
falsification: reject the combination if capture is lost, arrival or mean distance fails to improve over the `37.955` and `1.858L` parent baselines, or force/moment and joint excursions rise toward the filtered `45/55` rollout enough to erase the parent's load advantage

## Candidate hypothesis

Make one controller-mechanism change to the assigned parent: replace raw
instantaneous bearing with the sampled policy's short-history, exponentially
weighted circular bearing estimate. Keep the parent's `40/60` curvature split
and every propulsion parameter unchanged. The history is supplied in the
public observation, is padded with the current value at release, and receives
a current-bearing fallback, so this remains bounded state feedback without
explicit time, mutable memory, fixed coordinates, or wake-phase knowledge.

The downstream CFD test should determine whether persistent-bearing steering
and posterior-weighted curvature are compatible: retain the parent's compact
diagonal capture and lower-load envelope while approaching the filtered
policy's faster arrival and smaller distance integral. This worker does not
claim that unevaluated combination as an improvement.
