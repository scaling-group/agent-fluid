# Multi-wake candidate diagnosis

## Evidence coverage and visual diagnosis

I read the workspace contract, assigned parent guidance, all four sampled
solver scores, observations, compact metrics, nested wake diagnostics, and
policies, plus the available inherited optimizer notes and their evaluated
descendants, before writing this hypothesis. I inspected the common held-fish
prewarm sheet first, then the released sheets for the strongest `0.75` anchor,
the sampled `0.77` gain and `22.25 deg` amplitude probes, and the inherited
`0.745` gain and `29 rad/time^2` guard probes. No omitted Bookshelf material,
neighboring configuration, repository history, coordinate route, clock, or
external research was used. The current solver set contains no semantic
failure sheet; the older reversed-sign instability is retained only as an
inherited logged safety boundary, not claimed as newly inspected visual
evidence.

The prewarm sheet shows the common initial condition: the fish is held in the
upper-right, above and downstream of four developed interacting vortex
streets, while the target lies in the second-row wake overlap. This establishes
the wake and release geometry but is not candidate-specific evidence and does
not justify memorizing a route.

The duplicated `22 deg`, gain-`0.75`, guard-`28` rollouts remain the strongest
finite evidence. Their sheets show a bounded down-left turn, a compact
self-propelled approach into the developed wake, and target crossing without a
loop, collision, or boundary excursion in `74.23` release units. Mean world x
velocity is `-0.14682` against mean local-flow x velocity `-0.08249`, yielding
`0.06433` upstream-relative speed rather than passive advection. Mean distance
is `2.561L`; RMS force/moment are `22.39/393.08`. Maximum joint angles
`0.516/0.427 rad` and speeds `3.121/3.225 rad/time` retain hard-limit margin,
although both acceleration commands touch the candidate's `28 rad/time^2`
guard.

The current assigned-parent amplitude probe is a concrete negative result.
Changing only amplitude from `22` to `22.25 deg` preserves capture, but slows
arrival to `76.95`, increases mean distance to `2.579L`, and reduces
upstream-relative x speed to `0.05926`. Anterior/posterior peak speeds rise to
`3.186/3.338`, while RMS force/moment rise to `24.75/420.04`; both action
guards still clip. Its sheet shows a slightly less compact lower correction
before capture. The sampled `0.77` gain similarly reaches only at `78.58` with
`2.661L` mean distance and `0.06261` upstream-relative x speed. The inherited
`0.745` interpolation is worse at `86.99`, `2.694L`, and `0.05865`, with a
visible excursion below the target and RMS force/moment `39.84/540.72`.
Together these results retain exact gain `0.75` rather than justify another
static-bearing interpolation.

The inherited global-guard probe supplies a second local negative result.
Changing only the common action guard from `28` to `29 rad/time^2` produces a
visibly deeper lower route, reaches at `80.00`, increases mean distance to
`2.658L`, and reduces upstream-relative x speed to `0.05804`. RMS force/moment
rise sharply to `33.84/488.89`; posterior acceleration reaches `29`, while the
anterior command reaches `28.68`. Thus the anchor's clipping is not evidence
that more global acceleration authority improves traveling-bend tracking on
this wake snapshot.

## Single candidate hypothesis

Retain the evaluated `0.75` positive-bearing gain, `10 deg` steering cap,
`0.75` period, `22 deg` state-energy oscillator, energy gain, tail target,
lag, and damping. Split the previously common action guard into candidate-owned
anterior and posterior guards. Keep the anterior guard at the proven
`28 rad/time^2`, but lower only the posterior guard to `27 rad/time^2`. This
preserves the direct propulsion loop and its nominal unit-energy anterior
restoring peak (about `26.9 rad/time^2`) while testing whether trimming tail
bursts reduces the deeper correction and load growth seen when amplitude or
global acceleration authority increased. It is a one-mechanism probe, not a
claim that lower action authority is generally optimal.

Later CFD should retain finite capture and material upstream-relative
propulsion while making the route at least as compact as the `74.23`-unit
anchor and reducing RMS moment or force without persistent posterior clipping.
Reject the split guard if capture slows or fails, mean distance rises,
upstream-relative x speed falls materially below `0.06433`, or the fish again
takes a deeper lower excursion. Even a same-snapshot win must be falsified
across held-out wake phase, inflow, geometry, and target placement; no result
for this unevaluated candidate is claimed here.
