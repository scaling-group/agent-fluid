# Multi-wake candidate diagnosis

## Evidence coverage and visual diagnosis

I read the assigned `optimizer_c4db5d3847f5` parent guidance, all four sampled
solver policies and results, their observation summaries, compact metrics and
nested wake diagnostics, and the available inherited optimizer notes before
writing this diagnosis. I inspected the common held-fish prewarm sheet first,
then every current released keyframe sheet, and compared the best finite sample
with the inherited aggressive-gait instability. No omitted Bookshelf material,
neighboring configuration, repository history, coordinate route, clock, or
external research was used.

The prewarm sheet confirms a common release condition: the fish is held near
the upper-right boundary while four developed, interacting vortex streets fill
the diagonal corridor to the second-row target. It is identical across the
samples and supports no candidate-specific wake-phase claim. The successful
released sheets all show the same state-energy gait turning down-left and
actively crossing the downstream wake field, rather than merely drifting with
it. Their metrics confirm that interpretation: mean world x velocity is more
negative than mean local-flow x velocity for every current sample.

The gain-only `10 deg` samples expose a non-monotone local steering response.
At gains `0.70`, `0.75`, and `0.82`, all three reach the target, but release
time is respectively `91.61`, `74.23`, and `83.83`, while mean distance is
`2.834L`, `2.561L`, and `2.668L`. The `0.75` sheet visibly completes the same
compact down-left approach in fewer stored frames and enters the developed
target-wake region without the slower samples' extra approach time. It also
has the strongest mean upstream-relative x speed (`-0.1468` world versus
`-0.0825` local) and, importantly, lower RMS force/moment (`22.39/393.08`)
than both `0.70` (`38.81/550.75`) and `0.82` (`36.11/515.17`). Maximum joint
angles and speeds remain below the hard envelope, although every sample touches
the candidate-owned `28 rad/time^2` action guard. The `0.80` gain combined
with an `11 deg` limit is a confounded but negative boundary: it needs `87.63`
units and raises loads to `52.88/687.45`, so the curvature limit should not be
enlarged while locating the gain optimum.

The inherited instability remains the relevant failure boundary. Its released
sheet shows the reversed, `30 deg`, `0.82`-period controller coiling and spinning
near release rather than entering the wake corridor; after only `4.45` units it
terminates as unstable with `3.139` RMS relative crossflow and force/moment RMS
of `5.50e4/5.68e5`. Those diagnostics support preserving the positive-bearing
sign, `22 deg`/`0.75`-period propulsion core, posterior phase relation, and soft
action guard instead of seeking improvement through a larger or reversed gait.

## One candidate hypothesis

Keep the evaluated best `0.75`-gain controller unchanged except for a small
gain-only probe at `0.77`, retaining the `10 deg` steering limit. This lies
inside the successful `0.75--0.82` bracket and changes the best anchor by only
`2.7%`; it tests whether the minimum in arrival time and mean distance lies
slightly above the sampled `0.75` point without reintroducing derivative
feedback or increasing maximum curvature. Every active constant remains owned
by `target_policy_params()`.

Later CFD should retain target capture, material upstream-relative propulsion,
and the compact target-wake entry while improving release time or mean distance
from `74.23`/`2.561L`. Reject the probe if either measure regresses, capture is
lost, clipping becomes persistent, joint state approaches the hard envelope,
or force/moment rises materially from `22.39/393.08` toward the `0.82` sample's
`36.11/515.17`. Such a result would keep `0.75` as the local static-gain anchor
and favor a probe below it rather than another upward extrapolation. No result
for this unevaluated candidate is claimed here.
