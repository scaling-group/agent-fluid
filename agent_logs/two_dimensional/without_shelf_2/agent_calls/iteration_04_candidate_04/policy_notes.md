# Multi-wake candidate diagnosis

## Evidence coverage and visual diagnosis

I read the assigned parent guidance, the four sampled solver results, their
observations, released metrics and nested wake diagnostics, and the inherited
optimizer notes before writing this diagnosis. I also inspected the canonical
shared-prewarm sheet before the released sheets. No omitted Bookshelf,
neighboring configuration, repository history, external research, prescribed
inflow, coordinate route, or clock is used.

The shared sheet shows the common release condition: the held fish is above
and downstream of four developed interacting wakes, with the target in the
second-row overlap. It is identical across policies and supports no
candidate-specific route or wake-phase inference.

The two successful released sheets isolate a useful static-steering trend.
With the same `0.75`-period, `22 deg` state-energy gait, posterior lag, and
`28 rad/time^2` action guard, the `0.55` gain / `8 deg` bearing controller
visibly dives far below the target and then makes a large corrective loop. It
reaches the capture circle after `130.23` release units with mean distance
`3.516L` and maximum lateral target offset `5.425L`. Raising only the static
bearing pair to `0.70` / `10 deg` produces a much straighter down-left
approach and reaches in `91.61` units; mean distance falls to `2.834L` and
maximum lateral offset to `4.297L`. The latter is actively self-propelled:
mean x velocity is `-0.1208` versus mean local flow `-0.0693`, and it retains
`0.9397` progress. Mean power proxy also falls from `48.56` to `46.66`, so the
shorter route is not explained by greater average power alone.

The stronger static response is not cost-free. RMS lateral force/moment rise
from `26.34/427.54` to `38.81/550.75`, maximum anterior angle rises from
`0.523` to `0.550 rad`, and both successful controllers touch their candidate
acceleration guard. Those values remain finite and below the hard angle and
speed limits, but they bound how aggressively to continue the trend.

The informative failure discourages adding target-bearing derivative lead.
It matches the slower successful `0.55/8 deg` controller except for a clipped
`+0.10` horizon contribution from `bearing_window_rate`; its keyframes show
the fish failing to commit to the upstream/down-left path and eventually
leaving the right boundary. It ends after `158.42` units with displacement
`(+2.20,-2.35)L`, progress `-0.124`, and only `0.0223` mean upstream velocity
relative to local flow. Thus this sampled rate term destroys the propulsive
route rather than damping the broad loop, despite finite loads. Inherited logs
independently warn that raw turn-rate coupling and larger or reversed gaits can
be unstable, while weak gait startup is swept out before steering can matter.

## One candidate hypothesis

Keep the evaluated best controller's propulsion, posterior phase relation,
`10 deg` steering bound, and candidate action guard unchanged, and increase
only `steering_gain` from `0.70` to `0.82`. This is a deliberately smaller
relative step than the successful `0.55` to `0.70` change. It strengthens the
smooth response at moderate bearing error without enlarging the maximum mean
curvature or adding the failed derivative channel. Every active constant
remains owned by `target_policy_params()`.

Later CFD should preserve material upstream velocity and target capture while
reducing release time or mean distance below the `0.70/10 deg` anchor. Reject
the refinement if it loses capture, increases the lateral excursion, produces
persistent clipping, approaches the hard angle/speed envelope, or pushes
force/moment materially above the anchor's `38.81/550.75` scale. A failure
would bound the useful static-gain trend at or below `0.70` for this gait; it
would not rehabilitate windowed bearing-rate lead.
