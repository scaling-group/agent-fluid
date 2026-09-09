# Multi-wake candidate diagnosis

## Evidence coverage and visual diagnosis

I read the workspace and guidance contracts, assigned-parent experience, all
four sampled solver scores, observations, compact metrics, nested diagnostics,
and policies, plus the inherited optimizer notes and evaluated descendants
available in this Phase 2 workspace. I inspected the common held-fish prewarm
sheet first, then the released sheets for the score-leading `28/27` split
guard, the duplicated `28/28` physical anchor, the `22.25 deg` amplitude
probe, the assigned parent's turn-amplitude schedule, and the inherited
posterior-guard and posterior-damping regressions. No omitted Bookshelf
material, neighboring configuration, repository history, global-coordinate
route, clock, or external research was used.

The prewarm sheet shows the common release condition: the fish is held in the
upper-right above and downstream of four developed, interacting vortex
streets, while the target lies in their merged second-row wake. This is shared
initial-condition evidence, not a candidate-specific wake phase or a route to
memorize.

Every currently available sheet terminates by target capture; there is no
current collision, exit, or numerical-instability keyframe to compare. The
most informative failed control hypothesis is therefore the finite `28/27.5`
posterior-guard interpolation. Its fish turns toward and eventually enters the
useful wake, but frames 4--6 show a deep lower excursion and long return rather
than the anchor's compact diagonal closure. Arrival regresses to `95.96`, mean
distance to `2.806L`, and upstream-relative x speed to `0.05344`, while RMS
force/moment rise to `51.98/665.46`. Both joints remain finite, so this is a
route/load regression rather than passive advection or unstable dynamics. The
older reversed-sign instability is retained only as an inherited safety
boundary, not claimed as newly inspected visual evidence.

The duplicated `28/28 rad/time^2` anchor supplies the strongest physical
reference. Its sheets show a bounded down-left turn, productive lateral beat,
compact diagonal self-propulsion into the developed wake, and target crossing
without a loop or boundary excursion in `74.23` release units. Mean world x
velocity `-0.14682` exceeds the magnitude of mean local-flow x `-0.08249`, so
the `0.06433` upstream-relative speed confirms active propulsion. Mean distance
is `2.561L`, command energy is `50940`, and RMS force/moment are
`22.39/393.08`; both acceleration commands touch the candidate guard, but
joint angles and speeds remain below the hard envelope.

The score-leading `28/27` sample keeps useful wake entry and slightly improves
mean distance to `2.555L`, but its lower final correction slows capture to
`76.44`, reduces upstream-relative x speed to `0.06199`, and raises command
energy and RMS force/moment to `53200` and `24.69/417.71`. The sampled fixed
amplitude increase to `22.25 deg` similarly takes a lower late route and
regresses to `76.95`, `2.579L`, `0.05926`, and `24.75/420.04`. Static guard or
amplitude changes therefore do not provide monotone load or route control.

The assigned parent's normalized `5%` turn-amplitude reduction is an evaluated
negative result. Relative to its `28/27` parent, it lowers command energy to
`51887` and joint speeds, yet slows capture to `79.70`, raises mean distance to
`2.594L`, reduces upstream-relative x speed to `0.06073`, and increases RMS
force/moment to `28.03/438.71`; its sheet still approaches from below. The
independent damping increase from `0.65` to `0.675` is a stronger negative:
against `28/28` it deepens the late route, slows capture to `91.50`, raises mean
distance to `2.788L`, reduces upstream-relative x speed to `0.05262`, and raises
RMS force/moment to `42.13/581.11`. Reducing oscillator demand or posterior
motion did not directly reduce hydrodynamic load because the changed route
dominated.

## Single candidate hypothesis

Restore the reproducible `28/28` anchor and retain its positive-bearing gain
`0.75`, `10 deg` steering cap, `0.75` period, `22 deg` oscillator, energy gain,
tail lag, and damping. Change exactly one controller dimension: raise the
posterior mean-curvature share from `tail_steering_gain=0.60` to `0.625`. This
does not increase the anterior propulsion cycle, alter phase lag or damping,
interpolate a clipping guard, add an observation, or exceed the existing
bounded action envelope.

The hypothesis is that the three regressions produced by lower posterior
authority, reduced turn-time oscillator demand, and higher posterior damping
all expose route sensitivity to posterior under-response. A small increase in
mean-curvature sharing may keep the posterior joint aligned with the requested
turn and avoid the long lower correction while preserving the anchor's
oscillatory traveling bend. This is an isolated response probe, not a claim
that more tail sharing is generally beneficial.

Later CFD should retain finite target capture, self-propelled useful-wake entry,
and the anchor's compact diagonal topology. Treat the candidate as useful only
if it stays near or improves `74.23` arrival and `2.561L` mean distance without
reducing `0.06433` upstream-relative x speed or raising `22.39/393.08` RMS
force/moment materially. Reject it if extra shared curvature deepens the lower
excursion, increases clipping or load, or slows closure. Any same-snapshot gain
must still be falsified across held-out wake phase, inflow, geometry, and target
placement; no outcome is claimed for this unevaluated candidate.
