# Multi-wake candidate diagnosis

## Evidence coverage and visual diagnosis

I read the workspace and guidance contracts, the assigned-parent experience,
all four sampled scores, observations, compact metrics, nested wake diagnostics,
and policies, plus the inherited optimizer notes and their evaluated descendants
available inside this Phase 2 workspace. I inspected the common held-fish
prewarm sheet first, then the released sheets for the duplicated energy-gain
`2.0` anchor, the energy-gain `2.1` best sample, and the posterior-guard
regression. The sampled set has no collision, exit, horizon miss, or unstable
termination; the guard result is therefore an informative failed optimization
hypothesis rather than a termination failure. The inherited reversed-sign
instability is retained only as a logged safety boundary, not claimed as newly
inspected visual evidence. No omitted Bookshelf material, neighboring
configuration, repository history, coordinate route, clock, or external
research was used.

The prewarm sheet shows the fish held above and downstream of four staggered
cylinders after their interacting streets have developed, with the target in
the merged second-row wake. This is identical initial-condition evidence for
all candidates and does not support a memorized route or a candidate-specific
wake phase.

The duplicated energy-gain `2.0` anchor self-propels through a bounded
down-left turn and compact diagonal approach, enters the developed useful-wake
region, and crosses the target without a loop, collision, or boundary
excursion. It captures in `74.23` release units with `2.561L` mean distance.
Mean world x velocity is `-0.14682` versus mean local-flow x `-0.08249`, so
`0.06433` upstream-relative x speed confirms propulsion rather than passive
advection. Command energy is `50940`, RMS force/moment are `22.39/393.08`,
joint angles and speeds remain within the hard envelope, and both acceleration
commands touch the candidate's `28 rad/time^2` guard.

Increasing only oscillator energy restoration from `2.0` to `2.1` preserves
the same visible corridor and finite compact capture while reducing the lower
excursion and improving closure. Metrics agree: capture improves to `73.86`,
mean distance to `2.480L`, and upstream-relative x speed to `0.06565`. The
benefit is not free robustness: command energy rises to `51797`, RMS
force/moment to `24.94/410.68`, peak anterior/posterior speeds to
`3.150/3.323`, and both commands still touch `28`. Relative crossflow changes
only from `0.12919` to `0.13097`, so the distance gain is not evidence that
larger lateral response is intrinsically beneficial.

The posterior-only `27` guard demonstrates why authority should not be changed
at the same time. Its released sheet finishes through a lower correction;
capture slows to `76.44`, upstream-relative x speed falls to `0.06199`, and
command energy and force/moment rise to `53200` and `24.69/417.71` despite the
lower tail clamp. The assigned parent's inherited `27.5` guard and `0.675`
damping descendants took much deeper lower detours with still larger loads.
These regressions rule out combining the current energy-gain bracket with a
guard, damping, orbit, or steering change.

## Single candidate hypothesis

Retain the evaluated anchor's positive-bearing gain `0.75`, `10 deg` steering
cap, `0.75` period, `22 deg` nominal oscillator orbit, posterior target and
lag, `0.65` damping, and common `28 rad/time^2` guard. Change only
`oscillator_energy_gain` from the prefilled `2.0` to `2.05`, halfway to the
evaluated `2.1` sample. This is a load-aware bracket of the only sampled change
that improved arrival, distance integral, and relative propulsion together;
it does not assume a smooth optimum or claim an outcome before CFD evaluation.

Later CFD should preserve target capture, the compact diagonal useful-wake
entry, and material upstream-relative propulsion. Count the midpoint as useful
only if it retains a material portion of the `2.1` mean-distance improvement
while recovering toward the anchor's `50940` command energy and
`22.39/393.08` RMS force/moment. Reject it if it selects a lower route branch,
does not improve `2.561L` mean distance, materially slows `74.23` capture,
increases load toward or beyond the `2.1` result, or loses capture. Any
same-snapshot result remains subject to held-out wake-phase, inflow, geometry,
and target tests.
