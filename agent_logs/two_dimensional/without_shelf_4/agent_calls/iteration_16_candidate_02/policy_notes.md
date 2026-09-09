# Multi-wake candidate diagnosis and hypothesis

## Evidence read before the policy edit

- The shared-prewarm sheet shows the fish held at the common upper-right
  release pose while four developed, overlapping cylinder streets fill the
  target corridor. This is identical initial-condition evidence, not a reason
  to rank policies.
- The current score-leading progress schedule is reproduced exactly by two
  samples. Its sheet shows active self-propulsion through a broad release turn,
  repeated wake-band crossings, and an almost horizontal target entry. It
  captures without collision, exit, or instability at `213.659`, scores
  `-3.863`, and has `5.856L` mean distance. Mean upstream head velocity
  `0.05083` exceeds the `0.03822` magnitude of mean local-flow x, leaving
  `0.01261` controller-relative upstream transport. RMS relative crossflow,
  force, and moment are `0.13353`, `17.761`, and `354.838`; maximum anterior
  acceleration is `31.055` against the `31.2` policy guard.
- The complementary away-drift-magnitude schedule captures earlier at
  `196.900`, increases upstream transport to `0.01735`, lowers RMS force and
  moment to `17.672/352.909`, and uses less total command energy. Its more
  direct late approach does not repair its larger early detour: mean distance
  is `6.211L` and score is `-4.230`. The constant `0.07` comparator is also
  dominated on route quality (`245.449`, `6.305L`), while inherited constant
  `0.08` evidence captures at `224.488` with `6.311L` mean distance. The
  progress variable, rather than either constant endpoint or drift magnitude,
  is therefore the evidenced route-selection signal.
- The inherited `75%` progress / `25%` away-drift schedule blend is the
  informative failure. Its sheet shows continued propulsion but repeated
  reversals, followed by a deep lower-corridor overshoot and return that never
  enters the target circle. It reaches the horizon with final/minimum/mean
  distance `3.689/3.381/7.507L`, only `8.120L` upstream head displacement,
  `0.01033` controller-relative upstream transport, and `5.342L` maximum
  lateral target offset. This is not collision, domain exit, instability, or
  lost gait: maximum anterior acceleration remains `31.055`, and lower RMS
  force `17.475` does not compensate for the miss. A bounded convex blend can
  therefore be phase-destructive even when each source schedule captured on
  its own.

## Single candidate hypothesis

Preserve the score-leading policy's `20.25 deg`, `0.67`-period propulsion,
posterior lag/damping, `10 deg` steering bound, `0.30` bearing scale, `0.25`
bearing-rate lookahead, sign-gated target-away lateral correction, and `31.2`
acceleration guard. Keep rolling distance progress as the only selector and
change only its smooth transition scale from `0.02` to `0.015 L/time`.

The observed `0.01261L/time` upstream margin is only `0.63` of the parent's
`0.02` scale, so the current selector spends appreciable authority between its
two successful endpoints. The proposed scale is 25% narrower: it keeps the
same midpoint and the exact evaluated `0.07--0.08` bounds, but more decisively
selects `0.08` while stalled/receding and `0.07` while closing. It does not
admit the away-drift magnitude into schedule timing, add a coordinate, route,
clock, prescribed inflow, or remote wake probe, or alter the correction's
maximum `0.008 rad` pre-nonlinearity contribution.

This is one isolated transition-width test, not another constant-lookahead
sweep. The falsifiable expectation is retained capture with score above
`-3.863` and mean distance below `5.856L`, without arrival later than `213.659`
or force/moment above `17.761/354.838`. Reject the narrower selector on a miss,
later capture without better route integral, upstream transport below
`0.01261`, increased lateral excursion, guard contact, load/effort growth, or
visible switching. Its scope is the certified fixed-prewarm phase until a
later evaluation and held-out wake-phase test supply evidence; no same-worker
CFD result is claimed.
