# Multi-wake candidate diagnosis and hypothesis

## Evidence read before the policy edit

- The four current shared-prewarm sheets are byte-identical and show the fish
  held at the common upper-right release pose while the four staggered-cylinder
  streets develop through the target corridor. This anchors the fixed initial
  condition; it does not rank controllers.
- Three current samples and one inherited rollout reproduce the pure
  rolling-progress controller with `closing_speed_scale=0.015L/time` exactly.
  Their released sheets are byte-identical: active body oscillation carries the
  fish through the broad release turn and several wake-band reversals, then a
  lower central-wake passage ends in an almost horizontal target entry. Every
  run captures at `210.370` with score/mean distance `-3.528/5.519L`, upstream
  head displacement `11.040L`, controller-relative upstream transport
  `0.01672`, maximum lateral offset `4.293L`, and command energy `147846.5`.
  This is self-propelled, wake-assisted progress rather than passive advection:
  mean upstream head speed `0.05223` exceeds the `0.03551` magnitude of mean
  local-flow x.
- The sampled `0.020L/time` parent captures at `213.659`, with worse
  score/mean distance `-3.863/5.856L`, lower upstream margin `0.01261`, and
  higher command energy `148694.7`. The isolated narrowing to `0.015` leaves
  anterior angle, velocity, acceleration (`31.055 rad/time^2`), and maximum
  lateral offset unchanged, so the improvement is selector timing rather than
  more propulsion or a relaxed guard. It does carry a load tradeoff: RMS
  force/moment rise from `17.761/354.838` to `18.426/363.057`, despite slightly
  lower relative crossflow (`0.13289` versus `0.13353`).
- The inherited failure contrast uses a candidate file byte-identical to the
  successful `0.020` parent and the same byte-identical prewarm sheet. Its fish
  remains actively propelled, reaches the central wake, and comes within
  `0.960L`, but a deep lower-corridor turn is followed by a vertical rebound
  past the target; it finishes `2.904L` away at the `300` horizon. Diagnostics
  show positive `0.01639` controller-relative upstream transport, unchanged
  `31.055` anterior acceleration, finite `17.154/355.540` RMS force/moment, and
  no collision, exit, or instability. This is terminal corridor-retention
  sensitivity, not gait loss. Because an identical policy and certified
  prewarm also captured, the evidence does not identify a deterministic wake-
  phase cause and does not justify adding coordinates, a route, or a mixed
  selector.
- Inherited optimizer logs also show that a bounded `75%` progress / `25%`
  away-drift-magnitude schedule blend missed with `3.381L` minimum distance and
  a `5.342L` lateral excursion. Constant lookahead, heading damping, and
  bearing-rate sweeps likewise failed to improve the whole route. The remaining
  supported local experiment is an isolated transition-width bracket while
  retaining pure progress selection and the evaluated `0.07--0.08` envelope.

## Single candidate hypothesis

Change only `closing_speed_scale` from `0.015` to `0.0125L/time`. This modest
one-sixth narrowing keeps the selector continuous, preserves its `0.075`
midpoint at zero progress and its evaluated `0.07--0.08` endpoints, and makes
the receding/closing distinction slightly more decisive without admitting the
falsified drift-magnitude mixture. Preserve the `20.25 deg`, `0.67`-period
propulsion shell, posterior lag/damping, `10 deg` steering bound, `0.30`
bearing scale, `0.25` bearing-rate lead, target-away lateral sign gate,
`0.10` lateral-velocity clamp, and `31.2` acceleration guard.

The falsifiable local expectation is retained capture with score above
`-3.528` or mean distance below `5.519L`, no arrival later than `210.370`,
positive controller-relative upstream transport, unchanged excursion and
actuation maxima, and no material growth beyond the anchor's
`18.426/363.057` RMS force/moment. A later miss, terminal rebound, worse route
integral, later uncompensated arrival, switching, nonpositive upstream margin,
guard contact, larger excursion, or further material load growth rejects the
narrower transition and should stop further sharpening below the replicated
`0.015` anchor. This is one controlled bracket test, not a claim of monotonic
benefit, and no same-worker CFD outcome is claimed.
