# Multi-wake candidate diagnosis and hypothesis

## Evidence read before the policy edit

- The current shared-prewarm sheet shows the fish held at the upper-right
  release pose while the four staggered-cylinder streets develop and overlap
  across the target corridor. This is the certified common initial condition,
  not candidate-ranking evidence.
- All four current sampled sheets terminate in target capture. The strongest
  finite policy is reproduced exactly by two samples: its sign-gated lateral
  counter-drift lookahead is selected between `0.07` and `0.08` from rolling
  closing speed. The fish is visibly self-propelled through a broad release
  turn and several alternating wake bands, then approaches the target almost
  horizontally without collision, domain exit, instability, or rebound. It
  captures at `213.659`, with score/mean distance `-3.863/5.856L`, positive
  controller-relative upstream transport `0.01261`, RMS relative crossflow
  `0.13353`, RMS force/moment `17.761/354.838`, and total command energy
  `148694.7`.
- Relative to the current prefill's constant `0.07` correction, the rolling
  schedule advances capture by `31.790`, lowers mean distance by `0.449L`,
  lowers RMS force/moment by `0.638/8.616`, and cuts total command energy by
  `20954.3`. Both retain the same `4.293L` maximum lateral offset and
  `31.055 rad/time^2` anterior maximum below the `31.2` guard, so this is a
  steering-timing gain rather than extra propulsion or saturation.
- The current away-drift-magnitude schedule is the fastest success at
  `196.900` and has slightly lower force/moment `17.672/352.909`, but its
  score/mean distance regress to `-4.230/6.211L`. Arrival alone therefore does
  not select the better route topology.
- The inherited `0.75` progress / `0.25` away-drift convex blend is the hard
  failure contrast. Its sheet shows active oscillation but a widened zig-zag,
  a deep lower-corridor turn, and recovery that remains far from the target at
  the horizon. It misses with final/minimum/mean distance
  `3.689/3.381/7.507L`, maximum lateral offset `5.342L`, and mean upstream head
  velocity only `-0.02694` versus `-0.05083` for pure progress scheduling.
  Unchanged anterior acceleration (`31.055`), finite loads, and no collision,
  exit, or instability isolate loss of corridor retention rather than a gait
  or numerical failure. Even a bounded convex interpolation of individually
  successful schedule signals is therefore not locally safe.

## Single candidate hypothesis

Adopt the evaluated pure rolling-closing-speed policy as the one candidate.
Preserve the demonstrated `20.25 deg`, `0.67`-period propulsion shell,
posterior lag/damping, `10 deg` steering bound, `0.30` bearing scale, `0.25`
bearing-rate lookahead, `0.10` lateral-velocity clamp, and `31.2` acceleration
guard. Select counter-drift lookahead smoothly between `0.08` while the rolling
distance signal is receding and `0.07` while it is closing, using the evaluated
`0.02L/time` transition scale. Retain the target-away translation gate so the
added term is exactly zero for stationary or targetward lateral motion and is
bounded by `0.008 rad` before the steering nonlinearity.

This conservative candidate is supported twice by current fixed-prewarm CFD
and removes the drift-magnitude contribution that caused the inherited hard
failure. It uses normalized body-frame and rolling-distance feedback without
coordinates, a route, a clock, prescribed inflow, or remote wake probes. The
expected local result is capture near `213.659` with mean distance near
`5.856L`, positive upstream transport, finite loads, and unchanged actuation
and excursion bounds. Falsify transfer on a miss, later capture, mean distance
above `5.856L`, nonpositive controller-relative upstream transport, larger
lateral excursion, guard contact, visible switching, or material load/effort
growth. A held-out wake phase is still required before treating the schedule
as transferable; no same-worker CFD result is claimed.
