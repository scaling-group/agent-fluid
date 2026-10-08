# Multi-Wake Target-Policy Candidate Notes

## Evidence diagnosis before the policy edit

- The assigned parent guidance establishes the `0.55`-period, `28 deg`
  state-feedback traveling bend and bounded total-curvature steering as the
  reachability scaffold. It also records two useful failure boundaries: a
  full anterior steering bias left the domain after `18.683` units without
  approaching inside `12.424L`, and weakening the rhythm to `0.9/20 deg`
  reduced mean command energy to `17.02` but again lost upstream propulsion.
- The common prewarm sheet shows the fish held above four fully developed,
  interacting wakes. All current sampled released sheets then show active
  diagonal swimming across those wakes and first entry into the target circle;
  none of the current four samples is a failure. The inherited failure
  contrast therefore comes from the optimizer notes rather than an available
  failed current keyframe sheet. The successful sheets show no collision,
  terminal overshoot, or obvious passive downstream advection.
- The two instantaneous-bearing `45/55` policies are equation-identical and
  replay exactly: capture at `39.737`, mean distance `1.934L`, mean command
  energy `1278.79`, RMS force `53.74`, and RMS moment `761.95`. This is one
  deterministic control result, not two independent mechanisms.
- Moving the instantaneous split to `40/60` remains successful and improves
  capture to `37.955` and mean distance to `1.858L`; it also lowers RMS force
  and moment to `45.93` and `670.16`. This supports posterior steering
  authority, but by itself is a scalar allocation result rather than a new
  feedback mechanism.
- The assigned prefill's circular history filter is the best current navigation
  result: capture at `36.564`, mean distance `1.808L`, and score `0.06689`.
  Relative to the identical instantaneous `45/55` result, however, mean command
  energy rises to `1416.82`, relative-crossflow RMS to `0.245`, force RMS to
  `66.17`, and moment RMS to `901.74`; both joints still touch the velocity and
  acceleration envelopes. Thus the filter is evidenced as a faster route
  mechanism, not as load attenuation.
- Visually, the filtered and instantaneous policies share the same compact
  diagonal topology and sustained posterior traveling wave. The filtered sheet
  terminates in five sampled release frames rather than six, consistent with
  its shorter elapsed time, but the compact images do not calibrate the sign or
  timing of a force, moment, or crossflow disturbance. A wake-force residual
  would therefore outrun the current evidence.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: sensor-feedback robotic-fish direction tracking and organized-wake fish interaction
source_mechanism: separate target-directed modulation of a rhythmic gait from fast alternating body and wake motion
transferable_invariant: persistent body-frame direction error should set the mean turn, while a bounded trend term should release that turn as the observed bearing is already converging instead of letting filtered route error keep driving curvature
nontransferable_details: published controller gains, dimensional frequencies, robot or species geometry, exact vortex phases, force signatures, kinematic envelopes, and source-task routes
policy_translation: retain the circularly filtered body-frame bearing and evidenced traveling bend, then add one bounded gait-normalized `bearing_window_rate` correction before the existing total-curvature saturation; a decreasing bearing reduces turn demand and an increasing bearing restores it
falsification: reject the trend feedback if target capture is lost or delayed, mean distance worsens, the diagonal trajectory develops oscillation, or command and load metrics stay at the filtered parent's elevated levels without a navigation gain

## Candidate hypothesis

This candidate makes one architecture change to the successful history-filter
parent: a bounded route-trend damping term is added to the persistent bearing
before it enters the existing `12 deg` total-curvature map. The trend is the
provided body-frame `bearing_window_rate` multiplied by the owned gait period,
smoothly limited to `10 deg` of observed change and admitted at a `0.35` share.
Early padded history yields zero trend, so the initial targetward command is
unchanged. The term is target-relative feedback, not a clock, route, wake-phase
estimate, or scalar-only gait retune.

The `0.55/28 deg` oscillator, posterior lag, history filter, and `45/55`
curvature split remain fixed. Downstream evidence should retain first-crossing
capture and the filtered parent's short route while reducing correction
persistence as bearing converges. This worker does not claim that unevaluated
effect; later evaluation must compare arrival, mean distance, saturation,
command effort, force, and moment against both the filtered parent and the
lower-load `40/60` instantaneous sibling.
