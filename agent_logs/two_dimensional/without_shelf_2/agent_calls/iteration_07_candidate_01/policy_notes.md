# Multi-wake candidate diagnosis

## Evidence coverage and visual diagnosis

I read the assigned parent guidance, all four current solver scores,
observations, metrics, nested wake diagnostics, and policies, plus the
available inherited optimizer notes and their evaluated descendants, before
writing this hypothesis. I inspected the common held-fish prewarm sheet first,
then the released sheets for the best `0.75` sample, the slower `0.77` sample,
and the inherited `0.745` descendant. No omitted Bookshelf material,
neighboring configuration, repository history, coordinate route, clock, or
external research was used.

The prewarm sheet shows the common release condition: the fish is held in the
upper-right, above and downstream of four developed interacting vortex
streets, while the target lies in the second-row wake overlap. It is shared
initial-condition evidence, not candidate-specific evidence or support for a
memorized route.

The duplicated `steering_gain=0.75` sheets show the strongest finite behavior
in the available evidence. The fish makes a bounded down-left turn, produces a
compact upstream approach through the developed wake, and crosses the target
circle without a loop, collision, or boundary excursion in `74.23` release
units. Its mean world x velocity is `-0.14682` against mean local-flow x
velocity `-0.08249`, giving `0.06433` upstream-relative speed rather than mere
advection. Mean distance is `2.561L`; RMS force/moment are `22.39/393.08`.
Maximum joint angles (`0.516/0.427 rad`) and speeds (`3.121/3.225 rad/time`)
remain below the hard limits, though both accelerations touch the candidate's
`28 rad/time^2` guard.

The duplicated `0.77` samples preserve capture and route topology but make a
deeper lateral correction. Arrival regresses to `78.58`, mean distance to
`2.661L`, upstream-relative x speed to `0.06261`, RMS force to `23.77`, and
total command energy from `50940` to `52761`. The inherited duplicated
`0.745` descendants are a stronger negative result: despite being the prior
quadratic interpolation proposal, both take the visible route below the
target and return from underneath, reaching only at `86.99` with mean distance
`2.694L`, upstream-relative x speed `0.05865`, and RMS force/moment
`39.84/540.72`. Thus the gain response is wake-sensitive and non-smooth on
this snapshot; neither another lower-side interpolation nor upward gain
extrapolation is justified. The current four solver examples contain no
failure sheet. The inherited reversed-sign, `30 deg`, `0.82`-period
`unstable_dynamics` result remains only a logged safety boundary, with
`4.45`-unit termination and force/moment `5.50e4/5.68e5`, so it is not
misrepresented as newly inspected visual evidence.

## Single candidate hypothesis

Retain the exact successful positive-bearing gain `0.75`, its `10 deg`
steering cap, the `0.75` period, posterior lag and damping, and the
`28 rad/time^2` candidate guard. Increase only oscillator amplitude from
`22.0` to `22.25 deg`. The best route's advantage agrees with its highest
sampled upstream-relative x speed, while its joint angle and speed diagnostics
leave finite headroom. This `1.14%` propulsion probe is deliberately far from
the confounded unstable `30 deg` case; at the fixed period its nominal
anterior oscillatory speed is about `3.25 rad/time` and restoring acceleration
about `27.25 rad/time^2`, below the task's `4.54/31.42` hard speed/acceleration
limits and below the retained acceleration guard before steering transients.

Later CFD should preserve finite target capture and the compact `0.75` route
while increasing upstream-relative x speed above `0.06433` or reducing arrival
below `74.23`, without persistent clipping or moving loads materially toward
the `0.745` result. Reject the amplitude increase if arrival or mean distance
regresses, capture is lost, or the small propulsion gain costs a disproportionate
force/moment or command-effort increase. Even a same-snapshot improvement is
not evidence of wake-phase or geometry robustness; no outcome for this
unevaluated workspace candidate is claimed here.
