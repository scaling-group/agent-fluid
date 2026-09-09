# Multi-wake candidate diagnosis

## Evidence coverage and visual diagnosis

I read the assigned parent guidance, all four current solver policies, scores,
observations, metrics, and nested diagnostics, plus the available inherited
optimizer notes and their evaluated descendants, before writing this
hypothesis. Following the wake-visual procedure, I inspected a common held-fish
prewarm sheet first, then the released sheets for the duplicated `22 deg`,
`28 rad/time^2` anchor, the `22.25 deg` amplitude probe, the inherited
`29 rad/time^2` guard probe, and the inherited `0.745` steering-gain probe. No
omitted Bookshelf material, neighboring configuration, repository history,
coordinate route, clock, or external research was used.

The prewarm sheet confirms the shared release condition: the fish is held in
the upper-right while four interacting vortex streets develop, with the target
in the second-row wake overlap. The held pose, cylinder layout, target, and
developed flow are common initial-condition evidence rather than support for a
candidate-specific route.

The duplicated parent sheets show the strongest finite behavior in the
available evidence. After release, the fish turns down-left toward the target,
then follows a compact upstream center path through the interacting wake and
crosses the capture circle from the right without looping, collision, or a
boundary excursion. Its body oscillates while the center path remains bounded;
the images alone do not establish beneficial wake harvesting. Metrics do
establish self-propulsion rather than passive advection: mean world x velocity
is `-0.14682` against mean local-flow x velocity `-0.08249`, for `0.06433`
upstream-relative speed. It captures in `74.23` release units with `2.561L`
mean distance, total command energy `50940`, and finite RMS force/moment
`22.39/393.08`. Joint angles and speeds stay below the hard envelope, although
both requested accelerations touch the candidate's `28 rad/time^2` guard.

Two authority-increase probes fail to improve that anchor. Raising only
oscillator amplitude from `22` to `22.25 deg` preserves capture and broadly the
same route, but slows it to `76.95`, raises mean distance to `2.579L`, reduces
upstream-relative x speed to `0.05926`, raises total command energy to `54203`,
and raises RMS force/moment to `24.75/420.04`. Raising only the acceleration
guard from `28` to `29 rad/time^2` visibly produces a deeper excursion below
the compact corridor before recovery. It slows capture to `80.00`, raises mean
distance to `2.658L`, reduces upstream-relative x speed to `0.05804`, and raises
RMS force/moment sharply to `33.84/488.89`; lower mean power does not compensate
for poorer route closure and higher fluid loads. The earlier `0.745` gain probe
is the most severe accessible failed-improvement sheet: it also dives below
the direct corridor and returns, taking `86.99` units with `2.694L` mean
distance and `39.84/540.72` RMS force/moment.

No accessible current or inherited keyframe sheet terminates in collision,
domain exit, or numerical instability, so I do not claim to have visually
re-inspected a semantic failure. The inherited reversed-sign, `30 deg`,
`0.82`-period `unstable_dynamics` rollout remains a textual safety boundary
only (`4.45` release units and `5.50e4/5.68e5` force/moment). The accessible
failed improvement probes still consistently show that adding gait or action
authority to the parent does not improve target-relative propulsion on this
snapshot.

## Single candidate hypothesis

Retain the directly evaluated parent values for positive-bearing gain
`0.75`, steering limit `10 deg`, oscillator period `0.75`, amplitude `22 deg`,
energy gain, and the complete posterior traveling-bend response. Change only
the candidate-owned acceleration guard from `28` to `27.5 rad/time^2`. This
small tightening remains just above the anterior oscillator's nominal
`omega^2 * amplitude = 26.95 rad/time^2` restoring peak, so it preserves the
intended gait while clipping only more aggressive steering/wake transients.
It is the inverse isolated test suggested by the evaluated `29`-guard
regression, without revisiting the non-smooth steering-gain neighborhood or
the failed amplitude increase.

Later CFD should retain finite capture and the parent's compact approach while
reducing force/moment or total command effort, and should not reduce
upstream-relative x speed below `0.06433` or slow capture beyond `74.23`.
Reject the tightening if it causes persistent clipping, weakens the traveling
bend enough to deepen the route, or loses target capture. Even a positive
same-snapshot result would apply only to this local guard neighborhood; it must
be falsified across held-out wake phase, geometry, or inflow before being
treated as a robust guard optimum. No result for this unevaluated candidate is
claimed here.
