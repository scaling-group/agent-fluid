# Multi-wake candidate diagnosis and hypothesis

## Evidence read before the policy edit

- The byte-identical shared-prewarm sheets show the fish held at the common
  upper-right release pose while four staggered-cylinder streets develop into
  an overlapping corridor through the target. This certifies a common wake
  phase and layout; it does not distinguish policies.
- All four sampled solver results exactly reproduce the symmetric
  `0.015 L/time` rolling-closing-speed selector. Their released sheet shows
  active oscillation through a broad far-field turn and several wake-band
  crossings, followed by an almost horizontal target entry. Capture occurs at
  `210.370`, with score/mean distance `-3.528/5.519L`, `4.293L` maximum
  lateral offset, `0.01672` mean controller-relative upstream transport, and
  `147846` command energy. The fish's `-0.05223` mean x velocity exceeds the
  magnitude of its `-0.03551` mean local-flow x, so this is self-propelled,
  wake-assisted progress rather than passive advection. RMS relative
  crossflow/force/moment remain finite at `0.13289/18.426/363.057`, and the
  `31.055 rad/time^2` anterior peak stays below the `31.2` policy guard.
- The assigned parent's receding-soft split retained `0.015` while closing and
  used `0.020` while receding. It remained finite and captured `3.899` time
  units earlier, but took a different middle wake band and regressed to
  `-3.956/5.943L` score/mean distance. Upstream transport fell to `0.01215`.
  Lower effort and force/moment (`142752`, `18.368/356.178`) do not compensate
  for the worse route integral, so smoother-looking recovery is not a useful
  route-quality proxy.
- The newest inherited closing-soft split is the informative failure. It kept
  `0.015` for recession but used `0.020` for positive closing speed. Its sheet
  shows the fish fail to acquire the useful central wake: after the broad
  release turn it makes a deep lower loop, reverses upward on the right side,
  and exits through the top boundary. Metrics agree: termination is
  `left_domain`, minimum/final/mean distances are
  `7.316/12.542/11.062L`, progress is `-0.00953`, maximum lateral offset grows
  to `6.011L`, and mean controller-relative upstream transport collapses to
  `0.00619`. Its lower relative crossflow and force (`0.13118/17.753`) do not
  indicate useful control, while moment rises to `368.309`.
- Propulsion, posterior lag/damping, steering bounds, rate lead, lookahead
  endpoints, and acceleration guard were unchanged in both sign splits. The
  paired outcomes therefore reject asymmetric softening of either transition
  half at `0.020`: the symmetric `0.015` timing is a coupled corridor-retention
  mechanism for this gait and certified wake phase. The prior failed
  progress/drift mixture also rules out changing selector identity.

## Single candidate hypothesis

Restore and preserve the reproduced `20.25 deg`, `0.67`-period gait,
posterior lag/damping, `10 deg` steering bound, `0.30` bearing scale, `0.25`
bearing-rate lead, pure rolling-progress selector, symmetric `0.015 L/time`
transition, `0.10` lateral-velocity clamp, and `31.2` acceleration guard. Make
one small opposite-direction endpoint test: reduce
`lateral_velocity_lookahead_min` from `0.070` to `0.069`, while leaving the
receding endpoint at `0.080`.

For the existing interpolation, this reduces target-away lateral preview by at
most `0.001` as positive closing becomes decisive, by `0.0005` at zero closing
speed, and negligibly as recession selects the unchanged `0.080` endpoint.
The latest failure moved effective positive-closing preview in the opposite
direction—toward the midpoint—by softening its transition, then lost central
wake acquisition and exited. The candidate tests whether slightly less
away-drift correction during already-positive progress can straighten the
anchor's broad/jagged approach without disturbing the sharp recovery timing.
It adds no coordinate, route, clock, prescribed inflow, remote wake probe,
target-station signal, or new observation.

Call this an improvement only if it captures with score/mean distance at least
as good as `-3.528/5.519L`, arrival no later than `210.370`, positive upstream
margin near or above `0.01672`, and no increase in the `4.293L` excursion,
force/moment, effort, switching, or guard contact. Falsify it on later or lost
capture, a renewed lower/right loop, weaker upstream margin, worse distance
integral, or load growth; those outcomes would establish `0.070--0.080` as the
local endpoint anchor and favor restoring the sampled policy unchanged. Scope
is limited to the retained gait and fixed prewarm phase until held-out wake
phase evidence exists. No same-worker CFD outcome is claimed.
