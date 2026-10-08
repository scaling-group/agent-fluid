# Multi-wake candidate diagnosis and hypothesis

## Evidence read before the policy edit

- The shared-prewarm sheet shows the held fish at the common upper-right
  release pose while the four staggered-cylinder streets develop into a broad,
  overlapping corridor around and downstream of the target. This is common
  initial-condition evidence and cannot distinguish controllers.
- All four current solver samples reproduce the symmetric `0.015 L/time` pure
  rolling-closing-speed selector and its outcome exactly. The released sheet
  shows active body oscillation through a broad far-field turn, several wake
  bands, and a nearly horizontal target entry. The fish is not merely advected:
  its mean upstream head speed is `0.05223`, versus `0.03551` mean local-flow
  magnitude in x, leaving `0.01672` controller-relative upstream transport.
  It captures finitely at `210.370`, with score `-3.528`, mean distance
  `5.519L`, RMS lateral force/moment `18.426/363.057`, and no collision, exit,
  instability, or guard contact (`31.055` maximum anterior acceleration under
  the `31.2` policy guard).
- The assigned parent hypothesized that retaining `0.015` for positive closing
  speed while relaxing only recession to `0.020` would preserve the central
  wake route and lower loads. The inherited evaluation falsifies the route
  part. Its sheet remains finite and self-propelled and reaches the target
  `3.899` time units earlier, but takes a different middle wake-band path;
  mean distance worsens to `5.943L`, score to `-3.956`, and controller-relative
  upstream transport to `0.01215`. Effort falls from `147846` to `142752` and
  RMS force/moment to `18.368/356.178`, so earlier arrival and lower loads do
  not establish better corridor retention. Maximum lateral target offset and
  anterior acceleration remain unchanged at `4.293L` and `31.055`, isolating
  progress-selector timing rather than extra propulsion, saturation, or a
  gross excursion.
- No current sampled rollout terminates in failure; the inherited optimizer
  notes retain the informative failure boundary. A `75%` progress / `25%`
  drift-magnitude selector blend kept the gait and low loads but developed
  wide reversals and a lower-corridor excursion, then missed the `300` horizon
  at `3.689L` final and `7.507L` mean distance. This candidate therefore keeps
  rolling closing speed as the sole scheduling observation and does not mix
  selectors.

## Single candidate hypothesis

Preserve the replicated `20.25 deg`, `0.67`-period gait, posterior lag and
damping, `10 deg` steering bound, `0.30` bearing scale, `0.25` bearing-rate
lead, target-away lateral-velocity gate, `0.07--0.08` lookahead envelope,
`0.10` velocity clamp, and `31.2` acceleration guard. Reverse the falsified
asymmetry: use `0.020 L/time` for positive closing speed and retain the
score-leading `0.015 L/time` scale for zero or negative closing speed. This is
the one untested half-isolation supported by the three evaluated combinations:
the sharp receding side is the change associated with the anchor's better mean
distance and upstream margin, while comparison with the symmetric `0.020`
parent associates sharp positive-closing selection with higher force and an
earlier but poorer-integral route. The selector remains continuous at zero,
bounded by evaluated `0.015--0.020` scales and `0.07--0.08` outputs, and uses no
coordinate, route, clock, prescribed inflow, wake probe, or station-flow input.

The falsifiable expectation is that sharp recession/recovery retains the
symmetric `0.015` anchor's central-wake acquisition while gentler positive
closing selection reduces unnecessary steering load. Count it as an
improvement only if it captures with mean distance and score at least as good
as `5.519L/-3.528`, keeps controller-relative upstream transport near or above
`0.01672`, and lowers force/moment without later arrival, larger excursion,
switching, guard contact, or effort growth. Reject the mechanism if mean
distance exceeds the symmetric `0.020` parent's `5.856L`, upstream margin falls
below `0.01261`, capture is delayed or lost, or loads do not improve. The
inference is local to the retained gait and certified wake phase; nonlinear
interaction between the two transition halves can falsify it, and no
same-worker CFD result is claimed.
