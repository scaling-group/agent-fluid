# Multi-wake candidate diagnosis

## Evidence coverage and visual diagnosis

I read the workspace and guidance contracts, assigned-parent experience, all
four sampled scores, observations, compact metrics, embedded wake diagnostics,
and policies, plus the inherited optimizer notes and their evaluated
descendants available inside this Phase 2 workspace. I inspected the common
held-fish prewarm sheet before the released sheets for the duplicated `28/28`
anchor and the inherited `28/27.5` guard and `0.675` posterior-damping
regressions. No omitted Bookshelf material, neighboring configuration,
repository history, hard-coded route, clock, or external research was used.

The prewarm sheet shows the fish held above and downstream of four developed,
interacting vortex streets, with the target inside the merged second-row wake.
This is identical initial-condition evidence for every policy. It establishes
the wake layout at release but does not support coordinate memorization or a
candidate-specific wake phase.

The duplicated common-`28 rad/time^2` anchor remains the strongest physical
reference. Its released sheet shows a bounded down-left turn, productive
lateral beating, a compact diagonal entry into the developed wake, and target
crossing without a loop, collision, or boundary excursion. Capture occurs at
`74.23` release units with `2.561L` mean distance. Mean world x velocity
`-0.14682` differs materially from mean local-flow x `-0.08249`, yielding
`0.06433` upstream-relative x speed rather than passive advection. Command
energy is `50940`, RMS force/moment are `22.39/393.08`, and the joint angles
and speeds remain within the hard envelope, although both acceleration
commands touch the candidate's `28` guard.

The sampled alternatives do not justify changing the anchor's orbit or hard
guard. Lowering only the posterior guard to `27` improves configured score and
mean distance slightly (`-0.6544`, `2.555L`) but slows capture to `76.44`,
reduces upstream-relative speed to `0.06199`, and raises energy and force/moment
to `53200` and `24.69/417.71`. Raising amplitude from `22` to `22.25 deg`
also slows capture to `76.95`, raises mean distance to `2.579L`, lowers
relative speed to `0.05926`, and raises load to `24.75/420.04`.

The inherited `28/27.5` midpoint is the most informative failed optimization
hypothesis. Its sheet visibly leaves the anchor corridor through a deep lower
excursion, then returns from underneath. Metrics agree: capture regresses to
`95.96`, mean distance to `2.806L`, upstream-relative speed to `0.05344`,
command energy to `64918`, and RMS force/moment to `51.98/665.46`. It remains
finite, so this is a nonlinear route/load regression rather than a dynamics
failure. The assigned parent's subsequent isolated damping increase from
`0.65` to `0.675` produces a similar lower detour. Although posterior peak
speed decreases from `3.225` to `3.145` and mean power proxy from `45.38` to
`44.91`, capture slows to `91.50`, mean distance rises to `2.788L`,
upstream-relative speed falls to `0.05262`, total command energy rises to
`60660`, and force/moment nearly double to `42.13/581.11`. Thus lower tail
speed or mean power is not evidence of a better wake interaction.

The other inherited structural probe reinforces that boundary. Reducing
oscillator amplitude by up to five percent during large turns, on the `28/27`
parent, lowers joint-speed and mean-power proxies but still regresses arrival,
mean distance, relative propulsion, and force/moment. Current evidence therefore
supports restoring the exact anchor trajectory package and testing a controller
dimension that does not change its requested orbit, steering map, posterior
phase target, damping, or action authority.

## Single candidate hypothesis

Retain the reproducible anchor's positive-bearing gain `0.75`, `10 deg`
steering cap, `0.75` period, `22 deg` target amplitude, posterior steering
share and lag, `0.65` damping, and common `28 rad/time^2` guard. Increase only
`oscillator_energy_gain` from `2.0` to `2.1`. In the existing state-space
oscillator, this leaves the nominal unit-energy orbit and its natural frequency
unchanged; it only strengthens bounded restoration toward that orbit when the
wake drives the anterior joint below or above the requested phase-space energy.
This is an isolated robustness probe, not a claim that more command effort or
static amplitude is beneficial.

Later CFD should preserve finite capture, compact diagonal useful-wake entry,
and upstream-relative propulsion while reducing off-orbit joint excursions or
their load consequences. Treat it as an improvement only if it remains close
to or beats the anchor's `74.23` arrival and `2.561L` mean distance without
raising `50940` command energy or `22.39/393.08` RMS force/moment materially.
Reject it if stronger radial restoration causes additional guard residence,
a lower route branch, slower closure, higher load, or loss of capture. The
available summaries do not expose time-resolved oscillator energy, so that
mechanism remains falsifiable rather than established; any same-snapshot gain
would still require held-out wake-phase, inflow, geometry, and target tests.
