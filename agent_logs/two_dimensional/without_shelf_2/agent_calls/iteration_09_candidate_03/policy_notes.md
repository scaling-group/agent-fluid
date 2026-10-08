# Multi-wake candidate diagnosis

## Evidence coverage and visual diagnosis

I read the workspace contract, assigned parent guidance, all four current
sampled scores, observations, metrics, nested diagnostics, and policies, plus
the available inherited optimizer notes and their evaluated descendants. I
inspected the common held-fish prewarm sheet first, then the released sheets
for the duplicated `28 rad/time^2` anchor, the posterior-only `27` guard, and
the assigned parent's global `29` guard. No omitted Bookshelf material,
neighboring configuration, repository history, coordinate route, clock, or
external research was used. The current solver set contains no collision,
exit, or unstable keyframe sheet, so the older reversed-sign instability is
retained only as a documented safety boundary rather than presented as newly
inspected visual evidence.

The common prewarm frames show the held fish above and downstream of four
developed, interacting vortex streets, with the target in the merged
second-row wake. This is identical initial-condition evidence for every
candidate, not candidate-specific support or a route to memorize.

Three current samples reproduce the `0.75` positive-bearing gain, `10 deg`
cap, `0.75`-period, `22 deg` state-energy gait and common `28` action guard.
Their identical sheets show the strongest physical behavior: a bounded
down-left turn, compact diagonal self-propulsion through the developed wake,
and target crossing without a loop, collision, or boundary excursion. The
metrics confirm active upstream motion rather than passive advection: mean
world x velocity is `-0.14682` against mean local-flow x velocity `-0.08249`,
or `0.06433` upstream-relative speed. Capture takes `74.23` release units,
mean distance is `2.561L`, score is `-0.661705`, and RMS force/moment are
`22.39/393.08`. Both commands touch the `28` soft guard, but joint angles and
speeds remain below the task hard limits.

The assigned parent's evaluated global-guard probe is a concrete negative
result. Raising only the common guard from `28` to `29 rad/time^2` preserves
capture but visibly produces a deeper, more horizontal late correction. It
slows capture to `80.00`, raises mean distance to `2.658L`, lowers
upstream-relative x speed to `0.05804`, and raises RMS force/moment to
`33.84/488.89`; the posterior command reaches `29` while the anterior peaks at
`28.68`. Contact with the anchor's guard therefore does not show that more
global action authority improves tracking or propulsion.

The current highest-scoring sample isolates the opposite posterior-only
direction. Keeping the anterior guard at `28` and lowering the posterior guard
to `27` still reaches the target and improves score to `-0.654416` and mean
distance slightly to `2.555L`. Its sheet preserves the useful wake entry but
shows a somewhat lower late approach. The improvement is mixed: capture slows
to `76.44`, upstream-relative x speed falls to `0.06199`, RMS force/moment
rise to `24.69/417.71`, and posterior speed rises slightly to `3.233`. Thus
neither more global authority nor a full unit of posterior trimming is a
monotone physical improvement, even though the latter wins the configured
distance-integral score.

## Single candidate hypothesis

Retain the evaluated steering sign and gain, steering cap, gait amplitude and
period, energy regulation, tail target, lag, damping, and anterior guard. Split
the candidate-owned guards and set only the posterior guard to
`27.5 rad/time^2`, halfway between the two finite posterior limits. This is a
bounded posterior-response probe: it tests whether partial tail-burst trimming
can preserve the `27` sample's slightly tighter average target distance while
recovering some of the `28` anchor's faster closure and lower load. It does not
extrapolate below the evaluated interval or grant the harmful global authority
seen at `29`.

Later CFD should retain finite capture and the compact diagonal topology. A
useful result should improve score or mean distance over the common-`28`
anchor while keeping capture time, upstream-relative speed, and RMS
force/moment closer to `74.23`, `0.06433`, and `22.39/393.08` than the
posterior-`27` sample. Reject the interpolation if it loses capture, deepens
the lower excursion, exceeds the `27` sample's loads, or regresses both score
and route closure. Even a same-snapshot improvement must be falsified across
held-out wake phase, inflow, geometry, and target placement; no CFD result for
this unevaluated candidate is claimed here.
