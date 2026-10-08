# Multi-wake candidate diagnosis

## Evidence coverage and visual diagnosis

I used the assigned `optimizer_c4db5d3847f5` parent guidance, the sampled
solver scores, observations, metrics and nested diagnostics, and the inherited
optimizer notes. I inspected the shared prewarm sheet before the released
sheets and did not use the omitted Bookshelf, neighboring workspaces,
repository history, a clock, or a coordinate route.

The common prewarm sheet shows the fish held near the upper-right boundary
above four developed, interacting vortex streets, with the target in the
second-row overlap. This is shared initial-condition evidence only. The strong
released example (`0.70` gain, `10 deg` limit, bearing only) visibly develops a
sustained traveling bend, turns down-left, crosses the downstream wake field,
and reaches the target from the right on a compact sloping path. Its metrics
confirm active upstream propulsion rather than favorable advection: mean world
x velocity is `-0.1208` versus mean local flow `-0.0693`. It reaches `0.7490L`
in `91.61` release units with mean distance `2.834L`, `0.9397` progress, and
maximum lateral target offset `4.297L`. Joint angles and speeds stay below the
hard envelope, although both actions touch the `28 rad/time^2` candidate guard;
RMS force/moment are finite but elevated at `38.81/550.75`.

The weaker `0.55/8 deg` bearing-only anchor uses the identical propulsion core
and also reaches the target, but its sheet shows a broad excursion below the
target before recovery. It takes `130.23` units, has mean distance `3.516L` and
maximum lateral offset `5.425L`, and produces RMS force/moment `26.34/427.54`.
Thus the jointly stronger pure-bearing package shortened arrival by `38.62`
units and removed the visible below-target overshoot, at the boundary cost of
higher hydrodynamic load while leaving mean command energy essentially
unchanged (`679.54` versus `681.12`).

The current prefill is an especially informative failure because it is exactly
the successful `0.55/8 deg` anchor plus a bounded bearing-window-rate lead
(`0.10` horizon, `0.45 rad/time` rate limit). Its sheet initially shows an
active bend and some down-left motion, but the path folds into a hairpin on the
right, never enters the useful cylinder-wake region, and ultimately leaves the
right/downstream boundary. It survives `158.42` units yet moves `+2.200L` in x,
finishes `13.964L` away with `-0.1240` progress, and has mean world x velocity
`+0.0139` in mean local flow `+0.0362`. Comparable joint maxima to the
bearing-only success (`3.22 rad/time` anterior speed and about `0.522 rad`
anterior angle) rule out failed gait startup; lower effort and loads
(`291.37` mean command energy, `19.44/310.48` RMS force/moment) did not produce
useful propulsion or steering. Under this common snapshot, the added rate lead
is therefore falsified at this scale and sign.

## One candidate hypothesis

Remove bearing-rate feedback and retain the evaluated `0.75`-period, `22 deg`
energy-regulated oscillator, posterior phase lag, damping, and
`28 rad/time^2` guard. Use the successful `10 deg` pure-bearing limit and make
one cautious extrapolation in its small-error response: increase steering gain
from the evaluated `0.70` to `0.75` while keeping the maximum steering center
unchanged. This is only a `7.1%` gain increment and preserves the nominal
`22 + 10 = 32 deg` anterior excursion below the `45 deg` joint limit.

The falsifiable expectation for later CFD is continued target capture with the
same upstream gait and compact route as the `0.70/10 deg` sample, but a slightly
earlier correction and no increase in maximum steering bend. Reject the
extrapolation if capture is lost, arrival or mean distance regresses from
`91.61`/`2.834L`, the path develops a new lateral overshoot, action clipping
becomes persistent, or force/moment rise materially above `38.81/550.75`. In
that case, restore the evaluated `0.70/10 deg` pure-bearing controller rather
than reintroducing the falsified window-rate lead.
