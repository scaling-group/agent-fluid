# Multi-wake candidate diagnosis

## Evidence coverage and visual diagnosis

I read the Phase 2 workspace and guidance contracts, the assigned-parent
experience, all four sampled scores, observations, compact metrics, nested wake
diagnostics, and policies, and the available inherited optimizer notes and
their evaluated descendants. I inspected the common held-fish prewarm sheet
first, then the released sheets for the replicated static energy-gain `2.1`
anchor, inherited static `2.05`, and inherited asymmetric `2.1/2.05` result.
No sampled or inherited sheet available here has a safety termination, so the
asymmetric result is the most informative finite failed policy hypothesis, not
a collision, exit, horizon miss, or instability example. I used no omitted
Bookshelf material, neighboring configuration, repository history, clock,
global-coordinate route, or external research.

The prewarm sheet shows the fish held above and downstream of the four
staggered cylinders while their interacting streets develop, with the target
inside the merged second-row wake. This is common initial-condition evidence
and does not justify a memorized route or candidate-specific wake phase.

All four current static-`2.1` samples are exact same-snapshot reproductions.
Their released sheet shows a bounded down-left turn, productive lateral
beating, compact diagonal entry into the developed wake, and target crossing
without a loop, collision, or boundary excursion. Mean world x velocity
`-0.14784` versus mean local-flow x `-0.08219` gives `0.06565`
upstream-relative speed, confirming self-propulsion rather than passive
advection. Capture takes `73.859` release units and mean distance is `2.480L`,
with `51797` command energy and `24.94/410.68` RMS force/moment. Both commands
touch the candidate's `28 rad/time^2` guard; peak anterior/posterior speeds are
`3.150/3.323 rad/time`. The duplicates establish deterministic
reproducibility on the common snapshot, not robustness to changed wake phase.

Inherited static gain `2.05` follows the same broad wake corridor but ends
slightly farther below (`-4.135L` head displacement y versus `-3.991L` at
`2.1`). It nevertheless captures faster at `72.699`, retains essentially the
same `0.06562` upstream-relative x speed, and lowers energy to `50630`, RMS
force/moment to `21.05/379.50`, and peak joint speeds to `3.111/3.246`; its
mean distance is modestly worse at `2.511L`. This is a genuine arrival/load
tradeoff, not the unidentified mechanism described by an older inherited
note: the available evaluated candidate attributes it to static gain `2.05`.

The evaluated asymmetric controller used gain `2.1` for energy deficit
(injection) and `2.05` for energy excess (dissipation). Its keyframes and
diagnostics show the deepest approach of these comparisons, with head
displacement y `-4.493L`; mean distance regresses to `2.574L` and score to
`-0.6755`. It reaches in `73.062` with `51336` energy and `21.85/389.56` RMS
force/moment, so it remains finite and lower-load than static `2.1`, but static
`2.05` is faster, more compact, and lower-effort/lower-load. Weakening only the
excess-energy damping therefore did not preserve the compact route or combine
the static endpoints' advantages.

## Single candidate hypothesis

Retain the evaluated positive-bearing steering map, `0.75` period, `22 deg`
orbit, posterior target and lag, `0.65` damping, and common
`28 rad/time^2` guard. Reverse only the tested phase-space gain assignment:
use `2.05` while normalized oscillator energy is at or below one, limiting
energy injection to the faster/lower-load static setting, and use `2.1` when
energy exceeds one, retaining the compact anchor's stronger excess-energy
damping. The drive remains continuous at unit energy because its
`(1 - energy)` factor vanishes there. Both gains are candidate-owned, and the
change adds no observation, coordinate, timing signal, wake probe, or
unbounded response.

Later CFD should count this inverse split as an improvement only if it reaches
the target through a route no deeper than static `2.05`, keeps arrival no
slower than the static-`2.1` anchor, moves mean distance toward `2.480L`, and
keeps effort and load below `51797` and `24.94/410.68`. Reject the mechanism if
it repeats the prior split's deep correction, is dominated by either static
endpoint, loses upstream-relative propulsion, or loses capture. Even a
same-snapshot improvement remains subject to held-out wake-phase, inflow,
geometry, and target-placement tests; no CFD result for this candidate is
claimed here.
