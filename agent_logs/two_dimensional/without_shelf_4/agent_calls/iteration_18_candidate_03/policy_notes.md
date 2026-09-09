# Multi-wake candidate diagnosis and hypothesis

## Evidence read before the policy edit

- The shared-prewarm sheet shows the fish fixed at the common upper-right
  release pose while four developed cylinder streets overlap across the target
  corridor. This is common initial-condition evidence only; it cannot rank
  candidates or justify a phase-specific route.
- Three current samples use executable-equivalent `0.015L/time` pure
  rolling-closing-speed selectors and reproduce the same strongest finite
  result exactly. Their released sheets show active body oscillation through a
  broad release turn and several wake-band crossings, followed by a nearly
  horizontal target entry without collision, exit, instability, or terminal
  rebound. Each captures at `210.370`, scores `-3.528`, and has `5.519L` mean
  distance and `4.293L` maximum lateral offset.
- The metrics support self-propelled, wake-assisted transport rather than
  passive advection. Mean upstream head speed is `0.05223L/time` against mean
  local-flow magnitude `0.03551`, leaving `0.01672` controller-relative
  upstream speed. The same runs use `147846.5` command energy, retain maximum
  anterior acceleration `31.055 rad/time^2` below the `31.2` policy guard, and
  have RMS relative crossflow/force/moment `0.13289/18.426/363.057`.
- The current `0.020L/time` comparator also captures, but later at `213.659`
  with worse score/mean distance `-3.863/5.856L`, lower upstream margin
  `0.01261`, and slightly higher total effort `148694.7`. Its sheet has the
  same broad acquisition topology but a different late wake-band turn before
  horizontal entry. Lower RMS force/moment `17.761/354.838` establishes a
  real load tradeoff: the `0.015` route improvement is not free and does not
  prove that sharper transitions improve monotonically.
- No current sampled keyframe sheet is a failure. The most informative failure
  comparison is therefore the inherited optimizer log's anchored visual and
  metric diagnosis, not a newly invented visual claim: an executable-equivalent
  `0.020` rollout approached to `0.960L`, rebounded out of the target corridor,
  and ended at `2.904L` with `6.613L` mean distance and `5.835L` excursion
  despite positive upstream transport, unchanged propulsion acceleration, and
  finite lower loads. The separate inherited `75%` progress / `25%`
  drift-magnitude blend missed at `3.689L` final distance after repeated
  reversals and a deep lower-corridor overshoot. These failures argue against
  more drive, signal blending, or weakening the pure-progress selector.

## Single candidate hypothesis

Preserve the replicated `20.25 deg`, `0.67`-period propulsion shell,
posterior lag/damping, `10 deg` steering bound, `0.30` bearing scale, `0.25`
bearing-rate lead, target-away lateral gate, `0.07--0.08` lookahead envelope,
`0.10` lateral-velocity clamp, and `31.2` acceleration guard. Change only the
pure rolling-closing-speed transition scale from `0.015` to `0.0125L/time`.

This is a deliberately smaller second step than the evidenced
`0.020`-to-`0.015` change. It keeps the selector continuous, leaves its zero
closing-speed midpoint and evaluated endpoint bounds unchanged, and tests
whether more decisive endpoint selection reduces time spent on the broad
far-field reversals. It adds no coordinate, route, clock, prescribed inflow,
remote wake probe, new signal, or additional steering authority.

The falsifiable fixed-prewarm expectation is retained capture with score above
`-3.528` or mean distance below `5.519L`, without arrival later than `210.370`,
excursion above `4.293L`, loss of positive upstream margin, guard contact, or
material growth beyond `18.426/363.057` RMS force/moment and `147846.5`
effort. Reject the sharper selector on a near-entry rebound, larger detour,
visible switching, worse route integral, later or lost capture, or a load
increase that outweighs route gain. The prior evidence supports this isolated
test, not its outcome; no same-worker CFD result is claimed.
