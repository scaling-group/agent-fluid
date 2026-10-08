# Multi-wake candidate diagnosis

## Evidence coverage and visual diagnosis

I read the workspace and guidance contracts, the assigned-parent experience,
all four sampled scores, observations, compact metrics, embedded wake
diagnostics, and policies, plus the inherited optimizer notes and evaluated
descendants available inside this Phase 2 workspace. I inspected the common
held-fish prewarm sheet first, then the released sheets for the duplicated
`oscillator_energy_gain=2.0` anchor, the assigned parent's `2.1` gain, the
sampled `28/27` split guard, and the inherited constant- and peak-damping
regressions. I used no omitted Bookshelf material, neighboring configuration,
repository history, hard-coded route, clock, or external research.

The prewarm sheet shows the fish held above and downstream of four developed,
interacting vortex streets, with the target inside the merged second-row wake.
It is identical initial-condition evidence for every candidate and supports
neither coordinate memorization nor a candidate-specific wake phase.

The duplicated `2.0`-gain, common-`28 rad/time^2` anchor remains the clean
physical baseline. Its released sheet shows a bounded down-left turn,
productive beating, compact diagonal wake entry, and target crossing without a
loop, collision, or boundary excursion. Capture takes `74.23` release units
with `2.561L` mean distance. Mean world x velocity `-0.14682` against mean
local-flow x `-0.08249` gives `0.06433` upstream-relative x speed, so the fish
is self-propelled rather than merely advected. Command energy is `50940`, RMS
force/moment are `22.39/393.08`, and angles and speeds remain within the hard
envelope although both commands touch the candidate's `28` guard.

The assigned parent's isolated increase to `oscillator_energy_gain=2.1` is the
strongest sampled result. Its sheet preserves the finite compact approach but
tracks a visibly shallower final corridor into the target rather than the
anchor's lower correction. The metrics corroborate the route improvement:
score rises from `-0.6617` to `-0.5806`, capture improves from `74.23` to
`73.86`, mean distance falls from `2.561L` to `2.480L`, and upstream-relative x
speed rises from `0.06433` to `0.06565`. This is useful propulsion and closure,
not passive wake drift.

The gain result is not a clean load improvement. Relative to the anchor,
command energy rises from `50940` to `51797`, mean power from `45.38` to
`46.71`, RMS force/moment from `22.39/393.08` to `24.94/410.68`, anterior
peak angle from `0.516` to `0.526 rad`, and posterior peak speed from `3.225`
to `3.323 rad/time`; both commands still touch `28`. The available diagnostics
do not expose time-resolved phase-space energy, so they cannot identify whether
the route change came from faster sub-orbit recovery, stronger excess-energy
damping, or their interaction with a particular vortex phase.

The most informative failed optimization is the inherited constant posterior
damping increase from `0.65` to `0.675`. Its keyframes show a deep, kinked lower
excursion and return from underneath; arrival regresses to `91.50`, mean
distance to `2.788L`, relative x propulsion to `0.05262`, and force/moment to
`42.13/581.11`. Restricting that extra damping to a normalized high-speed band
avoids the deep kink but still takes a lower, delayed route: `77.29` arrival,
`2.630L` mean distance, `53167` command energy, and `22.76/398.31` loads. The
sampled `28/27` guard likewise approaches from below and raises effort and load.
All these current comparisons remain finite and reach the target, so the
failure signal is route/effort regression rather than a safety termination.

## Single candidate hypothesis

Retain the assigned parent's evaluated positive-bearing gain `0.75`, `10 deg`
steering cap, `0.75` period, `22 deg` orbit, tail target and lag, `0.65`
posterior damping, and common `28 rad/time^2` guard. Increase only
`oscillator_energy_gain` from `2.1` to `2.2`. This continues the sole isolated
controller dimension whose first step improved score, arrival, mean distance,
and upstream-relative propulsion while leaving the nominal unit-energy orbit
and frequency unchanged. It is a bounded one-parameter mechanism probe, not an
assumption that gain response is monotone or that higher effort is desirable.

Later CFD should preserve finite capture and the `2.1` parent's shallower,
compact diagonal entry. Treat the continuation as an improvement only if it
beats or closely retains `73.86` arrival and `2.480L` mean distance without a
material rise above `51797` command energy or `24.94/410.68` RMS force/moment.
Reject it if it causes more guard residence, larger joint excursions, a lower
route branch, worse relative propulsion, load escalation, or loss of capture.
Even a same-snapshot improvement must be falsified under held-out wake phase,
inflow, geometry, and target placement.
