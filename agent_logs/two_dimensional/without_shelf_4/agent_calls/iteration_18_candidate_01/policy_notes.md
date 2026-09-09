# Multi-wake candidate diagnosis and hypothesis

## Evidence read before the policy edit

- The shared-prewarm sheet shows the fish held at the common upper-right
  release pose while four developed, interacting cylinder streets fill the
  route to the target. This is common initial-condition evidence and cannot
  rank policies.
- Three sampled evaluations reproduce the current pure-progress `0.015`
  transition policy and its outcome exactly. The released sheet shows active
  body oscillation, a broad initial turn, several wake-band crossings, and an
  almost horizontal target entry without collision, exit, or instability.
  Capture occurs at `210.370`, with score `-3.528`, mean distance `5.519L`,
  upstream head displacement `11.040L`, and total command energy `147846`.
  Mean upstream head speed `0.05223` exceeds the `0.03551` magnitude of mean
  local-flow x, leaving `0.01672` controller-relative upstream transport; the
  fish is self-propelled and wake-assisted rather than passively advected.
- The matched `0.020` parent also captures finitely, but its sheet takes a
  different detour through the late wake bands and reaches the target at
  `213.659`. Narrowing both signs of the pure progress transition to `0.015`
  improves mean distance from `5.856L` to `5.519L`, score from `-3.863` to
  `-3.528`, upstream margin from `0.01261` to `0.01672`, and total energy from
  `148695` to `147846`. Identical `4.293L` maximum lateral target offset and
  `31.055 rad/time^2` anterior acceleration isolate steering timing rather
  than more propulsion, saturation, or a relaxed envelope.
- The route gain has a load tradeoff: RMS lateral force/moment rise from
  `17.761/354.838` with `0.020` to `18.426/363.057` with `0.015`, even though
  RMS relative crossflow falls slightly from `0.13353` to `0.13289`. This does
  not support assuming that still sharper symmetric switching is monotonic.
- Inherited optimizer logs supply the informative failure absent from the four
  current finite samples: mixing `25%` away-drift magnitude into the progress
  selector caused repeated reversals, a deep corridor overshoot, and a horizon
  miss at `3.689L` final distance despite unchanged anterior acceleration and
  lower RMS force. Safe bounds and a lower load did not make signal mixing a
  useful retention mechanism, so this candidate keeps progress as the sole
  schedule input.

## Single candidate hypothesis

Preserve the reproduced `20.25 deg`, `0.67`-period gait, posterior lag and
damping, `10 deg` steering bound, `0.30` bearing scale, `0.25` bearing-rate
lead, sign-gated target-away lateral correction, `0.07--0.08` lookahead
envelope, `0.10` lateral-velocity clamp, and `31.2` acceleration guard. Split
only the pure rolling-progress transition scale by progress sign: retain the
successful `0.015L/time` scale while stalled or receding, and restore the
smoother parent's `0.020L/time` scale while closing. The selector remains
continuous at zero closing speed because both branches produce weight `0.5`
there, remains bounded by the evaluated lookahead endpoints, and adds no
coordinate, route, clock, prescribed inflow, remote wake probe, or second
schedule signal.

This asymmetric candidate tests whether decisive target-loss recovery supplies
the `0.015` route/upstream benefit while a gentler closing branch can reduce
the observed force/moment cost. The falsifiable fixed-prewarm expectation is
retained capture no later than the `0.020` parent's `213.659`, mean distance
below `5.856L`, upstream margin above `0.01261`, and force or moment below the
symmetric `0.015` values `18.426/363.057`. Reject the decomposition if it loses
the symmetric anchor's route advantage, delays capture without compensating
distance/load improvement, expands the `4.293L` excursion, contacts the
acceleration guard, creates visible switching, or fails under a held-out wake
phase. The new candidate has no same-worker CFD result.
