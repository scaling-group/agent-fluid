# Multi-wake candidate diagnosis

## Evidence coverage and visual diagnosis

I read the workspace contract, assigned parent guidance, all four sampled solver
scores, observations, compact metrics, nested wake diagnostics, and policies,
plus the inherited optimizer notes and evaluated descendants available inside
this Phase 2 workspace. I inspected the shared held-fish prewarm sheet first,
then the released sheets for the score-leading `28/27` parent, the duplicated
`28/28` physical anchor, the inherited `22.25 deg` amplitude probe, and the
inherited `27.5` posterior-guard interpolation. No omitted Bookshelf material,
neighboring configuration, repository history, coordinate route, clock, or
external research was used.

The shared prewarm sheet shows the common release condition: the fish is held
in the upper-right above and downstream of four developed, interacting vortex
streets, and the target lies in the merged second-row wake. This is identical
initial-condition evidence for every candidate, not support for memorizing a
route or treating wake phase as candidate-specific.

All current sampled rollouts are finite target reaches. The three duplicated
`28/28 rad/time^2` anchor sheets show the strongest physical closure: a bounded
down-left turn, productive lateral oscillation, compact diagonal entry into the
developed wake, and target crossing without collision, looping, or boundary
excursion in `74.23` release units. Mean world x velocity is `-0.14682` against
mean local-flow x `-0.08249`, so its `0.06433` upstream-relative speed confirms
self-propulsion rather than passive advection. It has `2.561L` mean distance,
`50940` command energy, and RMS force/moment `22.39/393.08`. Joint angles and
speeds remain inside the hard envelope, although both acceleration commands
touch the candidate guard.

The score-leading assigned parent keeps anterior authority at `28` and trims
the posterior guard to `27`. It remains self-propelled and enters the useful
wake, while its keyframes show a lower late correction and arrival from beneath
the anchor route. Its small score/mean-distance gain (`-0.654416`, `2.555L`)
comes with slower `76.44` capture, lower `0.06199` upstream-relative speed,
higher `53200` command energy, and higher RMS force/moment `24.69/417.71`.
Lowering the action ceiling therefore did not lower hydrodynamic load.

The inherited `27.5` midpoint falsifies interpolation between those two guard
settings. Its sheet shows a pronounced downward turn, a long lateral excursion,
and a return to the target from underneath. It still reaches, but only after
`95.96` units with `2.806L` mean distance, `0.05344` upstream-relative speed,
`64918` command energy, and RMS force/moment `51.98/665.46`. The posterior
command touches `27.5`; joint angles and speeds remain finite, so this is a
nonlinear route/load regression rather than numerical instability. The older
`22.25 deg` fixed-amplitude probe is milder but points to the same interaction:
both commands clip, its sheet takes a slightly lower late correction, and it
regresses from the anchor to `76.95`, `2.579L`, `0.05926`, and
`24.75/420.04`. Thus neither more fixed amplitude nor finer hard-guard tuning is
supported. The current evidence contains no collision, domain-exit, or unstable
sheet; the older reversed-sign instability remains only an inherited logged
safety boundary.

## Single candidate hypothesis

Retain the assigned parent's evaluated positive-bearing gain `0.75`, `10 deg`
steering cap, `0.75` period, `22 deg` aligned-swimming amplitude, energy gain,
tail sharing/lag/damping, and `28/27` anterior/posterior guards. Add one bounded
parameter, `turn_amplitude_reduction=0.05`, and scale oscillator amplitude by
`1 - turn_amplitude_reduction * turn_fraction^2`, where `turn_fraction` is the
absolute steering-center demand normalized by its existing steering limit.
This preserves the full `22 deg` propulsive cycle when target-relative heading
error is small, while reducing it smoothly to `20.9 deg` only at the saturated
`10 deg` turn demand. The normalized body-frame schedule introduces no new
sensor, time signal, global coordinate, wake probe, or case route.

The hypothesis is that persistent fixed-amplitude propulsion competes with
large mean-curvature demand and drives the guard-sensitive route switches seen
in the `22.25 deg` and `27.5` descendants. A modest turn-only reduction should
leave acceleration headroom during the initial and late corrections without
discarding the parent's score-favored route or the established aligned
propulsion gait. Later CFD should retain finite target capture and useful-wake
entry, beat the parent's score or `2.555L` mean distance, and recover toward the
anchor's arrival, upstream-relative speed, effort, and loads. Reject the
schedule if it reproduces the midpoint's lower excursion, loses material
upstream-relative propulsion, slows capture, or raises load despite reduced
turning amplitude. No outcome is claimed for this unevaluated candidate, and
any same-snapshot gain remains subject to held-out wake-phase and geometry
falsification.
