# Multi-wake candidate diagnosis

## Evidence coverage and visual diagnosis

I read the assigned parent guidance, all four current sampled policies and
results, their observation summaries, compact metrics and nested diagnostics,
and the inherited optimizer notes before forming this hypothesis. I inspected
the common held-fish prewarm sheet first and then the two distinct released
keyframe sheets. The current four samples contain two exact reproductions of
each distinct rollout and no failed termination; the inherited notes therefore
supply the applicable failure boundaries, while the current `0.77` result is
the most informative finite regression. I did not use the omitted Bookshelf,
neighboring configurations, repository history, coordinates, or a clock.

The prewarm sheet shows the fish held near the upper-right boundary while four
developed, interacting vortex streets occupy the diagonal corridor toward the
second-row target. Its identical checksum across all four samples confirms a
common release condition, not a policy-specific wake-phase advantage.

Both current controllers visibly sustain an alternating traveling bend, turn
down-left, cross the developed wake, and reach the target from the right. This
is active upstream propulsion rather than advection alone. With gain `0.75`,
mean world x velocity is `-0.14682` against local flow `-0.08249`; with gain
`0.77`, those values are `-0.13827` and `-0.07566`. The sheets show nearly the
same route topology and identical `4.2965L` maximum lateral target offset, so
the regression is not a new gross loop or collision mechanism. Instead, the
`0.77` path closes more slowly near the developed target wake: capture moves
from `74.23` to `78.58` release units and mean distance rises from `2.561L` to
`2.661L`.

The diagnostics agree with that visual reading. Relative upstream speed falls
from `0.06433` to `0.06261`, while RMS lateral force rises from `22.39` to
`23.77` and maximum joint angles/speeds rise from `0.516/0.427 rad` and
`3.121/3.225 rad/time` to `0.532/0.434 rad` and `3.162/3.305 rad/time`.
Moment remains essentially flat (`393.08` versus `393.44`), and both policies
touch the candidate-owned `28 rad/time^2` guard without reaching the hard
joint angle or speed limits. Lower mean command energy at `0.77` (`671.40`
versus `686.26`) does not compensate for its slower, less compact capture.
Exact duplicate outcomes for both gains make this a deterministic same-snapshot
gain effect rather than sample noise.

The inherited sequence broadens the boundary: otherwise identical `0.70`,
`0.75`, `0.77`, and `0.82` pure-bearing controllers all capture, but `0.75`
is the best observed point for arrival, mean distance, and finite loads. The
parent's explicit instruction after an upward-gain regression is to probe below
`0.75`, not continue increasing gain. Earlier inherited evidence also rejects
the bearing-window-rate lead (downstream exit) and the combined reversed-sign,
`30 deg`, `0.82`-period gait (near-release instability), so neither mechanism
is reintroduced.

## One candidate hypothesis

Preserve the evaluated `0.75`-period, `22 deg` energy-regulated oscillator,
positive-bearing sign, `10 deg` steering cap, posterior phase relation,
damping, and `28 rad/time^2` action guard. Change only the steering gain from
the regressed prefill value `0.77` to `0.745`. This is a `0.7%` move below the
best observed `0.75` anchor and lies well inside the successful `0.70--0.75`
bracket. It is deliberately small because the current same-snapshot results
show that a `0.02` gain change can alter wake-entry timing without changing the
macroscopic route.

Later CFD should retain finite first capture and the compact down-left path
while improving release time or mean distance from the `0.75` anchor's
`74.23`/`2.561L`, or at least preserve those measures with lower joint/load
peaks. Reject the probe if capture is slower, mean distance rises, the route
develops a lateral overshoot, action clipping becomes persistent, or force and
moment move materially above `22.39/393.08`. A rejection would keep `0.75` as
the local static-gain anchor and argue against further fine gain interpolation
until a different feedback mechanism is isolated by evidence. No result for
this unevaluated candidate is claimed here.
