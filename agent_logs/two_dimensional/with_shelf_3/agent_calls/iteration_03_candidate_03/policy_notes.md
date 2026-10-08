# Multi-Wake Target-Policy Candidate Notes

## Evidence diagnosis before the policy edit

- The assigned parent guidance preserves the `0.55`-period, `28 deg`
  traveling-bend scaffold and identifies a bounded total curvature split across
  the two joints as the first successful target-aware mechanism. It also warns
  that reducing the gait to `0.9/20 deg` removed upstream propulsion despite
  greatly reducing command effort.
- All four current sampled solver results execute the same parameter values and
  control equations (their policy-file differences are comments only) from the
  same held-fish snapshot. Accordingly they reproduce exactly the same
  `target_reached` result: `39.737` released time, `1.934L` mean distance,
  `0.747L` final/minimum distance, and head displacement
  `(-10.912,-4.332)L`. This is strong deterministic replay evidence for the
  current mechanism, but it is not evidence of robustness to a changed wake or
  target.
- The shared prewarm sheet shows the fish held above four developed,
  interacting vortex streets. The successful released sheet shows an early
  targetward turn followed by sustained self-propelled diagonal travel through
  those streets and direct entry into the capture circle; it does not show a
  persistent wrong-way curl or an obvious late target overshoot.
- The inherited full-anterior-bias failure provides the informative contrast.
  Its sheet ends after a small downstream-right departure, and the metrics
  confirm a `left_domain` exit after `18.683` units, displacement
  `(+2.195,-1.302)L`, and no approach inside `12.424L`. Its small
  `0.249/0.191 rad` joint excursions and `187.66` mean command energy identify
  loss of propulsion, rather than a near-target wake disturbance, as the
  failure. The inherited `0.9/20 deg` variant repeats that topology with only
  `17.02` mean command energy.
- The successful path still reaches both `260 deg/time` joint-velocity limits
  and both `1800 deg/time^2` acceleration limits, with `761.95` moment RMS and
  visible beat-scale body oscillation. Aggregate evidence cannot assign those
  peaks solely to steering, and the keyframes show no signed wake event that
  would calibrate a force or crossflow residual. Therefore this candidate does
  not alter the evidenced gait and does not add wake-force cancellation. It
  tests whether instantaneous body-yaw oscillation is unnecessarily entering
  the mean-curvature route command through raw bearing feedback.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: organized-wake fish interaction and sensor-feedback robotic-fish direction tracking
source_mechanism: separate slow persistent route error from fast alternating yaw or crossflow before modulating an oscillatory gait
transferable_invariant: mean-curvature steering should follow the persistent body-frame target direction rather than every beat-scale bearing fluctuation
nontransferable_details: published filter gains, history durations, dimensional beat rates, robot or species geometry, exact vortex phases, and source-task routes
policy_translation: use an owned gait-relative filter horizon to exponentially weight and circular-average the provided body-frame `bearing_history`, then map that bounded persistent bearing through the existing total-curvature budget and joint split while leaving propulsion unchanged
falsification: reject the history filter if capture is lost or delayed, mean distance worsens, the compact diagonal trajectory changes adversely, or velocity/acceleration saturation and moment load do not improve enough to justify the added response lag

## Candidate hypothesis

Make one architecture change: replace instantaneous bearing in the successful
mean-curvature path with an exponentially weighted circular mean of the
testbed-provided short bearing history. The filter horizon is owned by the
policy as a fraction of the gait period. The history is padded with the current
observation at release, so the initial targetward request is preserved; later,
the mean should attenuate beat-scale angular motion without introducing
explicit time, mutable state, wake phase, coordinates, or a memorized route.
The existing `12 deg` total-curvature budget, `45/55` anterior/posterior split,
oscillator, damping, and posterior lag remain fixed.

Expected downstream evidence is retained target capture on the compact
diagonal trajectory with no slower arrival or worse distance integral, plus a
measurable reduction in command saturation or moment RMS. This worker does not
claim those effects before the downstream CFD evaluation.
