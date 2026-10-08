# Multi-wake candidate diagnosis

## Evidence coverage and visual diagnosis

I read the workspace contract, assigned parent guidance, all four sampled solver
scores, observations, compact metrics, nested wake diagnostics, and policies,
plus the available inherited optimizer notes and their evaluated descendants,
before writing this hypothesis. I inspected the common held-fish prewarm sheet
first, then the released sheets for the duplicated `28/28` anchor, the current
`28/27` split-guard probe, and the inherited `0.745` steering-gain regression.
The current sample contains no collision, exit, or unstable rollout; the
split-guard result is the most informative failed optimization hypothesis, and
the older reversed-sign instability is used only as an inherited logged safety
boundary. No omitted Bookshelf material, neighboring configuration, repository
history, coordinate route, clock, or external research was used.

The shared prewarm sheet shows the fish held in the upper-right, above and
downstream of four developed interacting vortex streets, with the target in the
second-row wake overlap. This is common initial-condition evidence, not support
for a memorized route or candidate-specific wake phase.

Three sampled copies of the assigned-parent `28/28` policy reproduce exactly.
Their sheets show a bounded down-left turn and a compact diagonal approach that
enters the useful developed wake from the right and crosses the target circle
without a loop, collision, or boundary excursion. Capture takes `74.23`
release units and mean distance is `2.561L`. Mean world x velocity is
`-0.14682` against mean local-flow x `-0.08249`, yielding `0.06433`
upstream-relative speed rather than passive advection. RMS force/moment are
`22.39/393.08`, total command energy is `50940`, joint angles and speeds remain
below the hard envelope, and both acceleration commands touch the candidate's
`28 rad/time^2` guard.

The current isolated split-guard rollout keeps the anterior limit at `28` and
lowers only the posterior limit to `27 rad/time^2`. It still self-propels into
the useful wake and captures, but the sheet shows a lower final correction and
arrival from underneath relative to the compact anchor. Capture slows to
`76.44`, upstream-relative x speed falls to `0.06199`, command energy rises to
`53200`, and RMS force/moment rise to `24.69/417.71`; posterior peak speed also
rises slightly from `3.225` to `3.233 rad/time`. Its center finishes `0.343L`
farther downward. The only favorable changes are the scalar score
`-0.6544` versus `-0.6617` and a very small mean-distance decrease from
`2.5613L` to `2.5554L`. Thus lower command authority did not lower physical
load, and the scalar improvement is a route-integral tradeoff rather than a
clean improvement in propulsion, arrival, or effort.

This result complements the inherited upper-side global-guard probe: raising
the common limit to `29` also slowed capture to `80.00`, reduced
upstream-relative x speed to `0.05804`, and raised RMS force/moment to
`33.84/488.89`. Along with the inherited amplitude and steering-gain
regressions, it argues against another broad authority or gait change. The
posterior-limit evidence now brackets the anchor from below, but the known
non-smooth wake-route response means interpolation is a hypothesis, not a
fitted optimum.

## Single candidate hypothesis

Retain the evaluated positive-bearing gain `0.75`, `10 deg` steering cap,
`0.75` period, `22 deg` state-energy oscillator, energy gain, tail target,
lag, damping, and anterior `28 rad/time^2` guard. Set only the posterior guard
to `27.5 rad/time^2`, halfway between the compact `28` anchor and the
score-favored but slower `27` probe. This one-parameter candidate tests whether
the small distance-integral benefit begins before the full lower-route/load
regression. It introduces no clock, global coordinate, target identity, flow
probe, or new observation.

Later CFD should retain finite capture and material upstream-relative
propulsion. Treat the midpoint as an improvement only if it beats the anchor's
score or mean distance while recovering materially toward its `74.23` arrival,
`0.06433` upstream-relative x speed, `50940` command energy, and
`22.39/393.08` loads. Reject midpoint interpolation if it reproduces the lower
route, slower arrival, or higher loads of the `27` probe, even if the scalar
score rises slightly. Any same-snapshot result remains subject to falsification
under held-out wake phase, inflow, geometry, and target placement; no outcome
for this unevaluated candidate is claimed here.
