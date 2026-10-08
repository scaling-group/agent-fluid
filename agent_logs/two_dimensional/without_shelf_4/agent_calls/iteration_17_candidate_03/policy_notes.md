# Multi-wake candidate diagnosis and hypothesis

## Evidence read before the policy edit

- The sampled shared-prewarm sheet shows the fish held at the upper-right
  release pose while four developed, overlapping cylinder streets occupy the
  target corridor. It is the certified common initial condition and does not
  distinguish controllers.
- The two `0.015L/time` samples reproduce one another exactly. Their released
  sheet shows active oscillation through the broad initial turn and jagged
  wake-band crossings, followed by a nearly horizontal target entry without
  collision, exit, instability, or terminal rebound. This is self-propelled,
  wake-assisted motion rather than passive advection: mean head velocity x is
  `-0.05223`, versus mean local-flow x `-0.03551`, leaving `0.01672L/time`
  controller-relative upstream transport. Capture occurs at `210.370`, with
  score/mean distance `-3.528/5.519L`, total effort `147846.5`, RMS relative
  crossflow `0.13289`, and maximum lateral offset `4.293L`.
- The otherwise matched `0.020L/time` parent is also reproduced exactly by two
  samples. It follows the same useful wake corridor but captures later at
  `213.659` and has worse score/mean distance `-3.863/5.856L`; upstream
  transport is only `0.01261L/time`, and total effort is slightly higher at
  `148694.7`. Thus narrowing the pure rolling-progress transition from `0.020`
  to `0.015` is a positive route and transport result, not merely an arrival
  improvement.
- The improvement has a load boundary. Relative to `0.020`, the `0.015` policy
  raises RMS lateral force from `17.761` to `18.426`, RMS moment from `354.838`
  to `363.057`, mean command energy from `695.945` to `702.794`, and mean power
  proxy from `47.287` to `47.750`, although relative crossflow falls slightly.
  Both retain maximum anterior acceleration `31.055 rad/time^2` beneath the
  `31.2` policy guard, so this is a steering-transition tradeoff rather than a
  propulsion or saturation difference.
- The inherited `75%` progress / `25%` away-drift selector is the informative
  failure. Its sheet shows continued propulsion but repeated far-field
  reversals, a deep lower-corridor overshoot, and a return that never enters the
  target. It misses the horizon at final/minimum/mean distance
  `3.689/3.381/7.507L`, maximum lateral offset `5.342L`, and only
  `0.01033L/time` upstream transport. Its lower RMS force `17.475` confirms
  that bounded, low-load selector mixing can destroy corridor retention. The
  candidate must therefore keep rolling closing speed as the sole selector.

## Single candidate hypothesis

Preserve the demonstrated `20.25 deg`, `0.67`-period gait, posterior
lag/damping, `10 deg` steering bound, `0.30` bearing scale, `0.25` bearing-rate
lead, `0.10` lateral-velocity clamp, sign-gated target-away translation term,
evaluated `0.07--0.08` counter-drift interval, and `31.2` acceleration guard.
Change only the rolling closing-speed transition scale from `0.015` to
`0.0125L/time`. This is a conservative half-step continuation of the successful
`0.020 -> 0.015` absolute reduction. It keeps the midpoint and exact evaluated
lookahead endpoints while selecting `0.08` more decisively during progress
loss and `0.07` during closing; the correction remains zero for stationary or
targetward lateral translation and bounded by `0.008 rad` before the steering
nonlinearity.

The falsifiable expectation is retained capture with score above `-3.528` or
mean distance below `5.519L`, without arrival after `210.370` or material
growth beyond the current `0.13289/18.426/363.057` crossflow/force/moment and
`702.794/47.750` mean effort/power values. Reject further sharpening on a
miss, a larger far-field loop, later capture without integral improvement,
upstream transport below `0.01672L/time`, larger lateral excursion, guard
contact, visible selector-induced switching, or additional load/effort growth.
This scope is limited to the certified fixed-prewarm phase until held-out wake
phase evidence exists. No same-worker CFD outcome is claimed.
