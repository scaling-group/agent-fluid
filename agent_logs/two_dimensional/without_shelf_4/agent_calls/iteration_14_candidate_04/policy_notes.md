# Multi-wake candidate diagnosis and hypothesis

## Evidence read before the policy edit

- The sampled shared-prewarm sheets show the same held fish at the upper-right
  release pose while the four staggered-cylinder streets develop through the
  target corridor. This is the certified common initial condition and cannot
  rank controller changes.
- Two sampled `0.08` sign-gated lateral-counter-drift policies reproduce
  exactly. Their released sheets show a broad self-propelled acquisition turn,
  a lower/central wake-corridor transit, and nearly horizontal target entry by
  rendered frame `25`. They capture at `224.488`, with score `-4.310836`, mean
  distance `6.310611L`, controller-relative upstream transport `0.016022`,
  RMS relative crossflow `0.134270`, RMS force/moment `17.9429/361.014`, and
  total command energy `157453.9`.
- Two sampled `0.07` policies also reproduce exactly and provide the direct
  negative test of the inherited claim that reducing the counter-drift gain
  would retain the `0.08` arrival and load benefits. Their sheets show a longer
  upper/central sequence of wake-band reversals before target entry at rendered
  frame `28`. Mean distance improves by only `0.005971L` and score improves by
  `0.020107`, while capture is `20.961` later at `245.449`, upstream transport
  falls to `0.012845`, total command energy rises by `12195.1`, and RMS
  force/moment rise to `18.3994/363.453`. Lower relative crossflow `0.131256`
  does not establish a route or load improvement.
- Both gains remain self-propelled: mean head velocity x is `-0.048951` for
  `0.08` and `-0.044256` for `0.07`, more upstream than their respective mean
  local-flow x values `-0.032929/-0.031412`. Maximum lateral target offset
  remains `4.293L` and maximum anterior acceleration remains
  `31.055 rad/time^2` under the `31.2` policy guard, so the observed trade is
  steering timing rather than added propulsion, a changed excursion envelope,
  or anterior saturation.
- Every current sampled sheet terminates in target capture, so there is no
  current hard-failure keyframe to invent a visual diagnosis from. The
  inherited optimizer logs retain the hard boundary: a sign-asymmetric
  bearing-rate policy made wide jagged reversals, lost corridor retention, and
  missed the horizon at `3.632L` after a `3.290L` minimum with the same
  anterior acceleration maximum. That result argues against adding another
  rate decomposition to this isolated translational-gain comparison.

## Single candidate hypothesis

Preserve the demonstrated `20.25 deg`, `0.67`-period propulsion shell,
posterior lag/damping, `10 deg` steering bound, `0.30` bearing scale, `0.25`
bearing-rate lookahead, `0.10` lateral-velocity clamp, sign gate, and `31.2`
acceleration guard. Change only `lateral_velocity_lookahead` from the assigned
parent's `0.08` to `0.075`, halfway to the evaluated `0.07` endpoint. This
bounds the added pre-nonlinearity correction to `0.0075 rad`, keeps it exactly
zero during stationary or targetward lateral translation, and uses only
normalized body-frame feedback.

The endpoint comparison shows a non-monotone route trade rather than a safe
direction for extrapolation. The midpoint tests whether a smaller reduction
can retain the `0.07` mean-distance/score benefit while recovering some of the
`0.08` arrival, upstream-transport, and load advantage. Require target capture,
arrival earlier than `245.449`, mean distance no worse than `6.310611L`,
upstream margin above `0.012845`, and force/moment below `18.3994/363.453`.
Reject the midpoint if it is dominated by either evaluated endpoint, loses
capture, shows a longer late corridor reversal, contacts the policy guard, or
raises switching, effort, crossflow, force, or moment without a compensating
route gain. No same-worker CFD result is claimed; transfer beyond the certified
wake phase remains unevaluated.
