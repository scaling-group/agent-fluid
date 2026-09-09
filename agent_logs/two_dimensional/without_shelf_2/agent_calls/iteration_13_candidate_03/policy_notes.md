# Multi-wake candidate diagnosis

## Evidence coverage and visual diagnosis

I read the Phase 2 workspace and guidance contracts, the assigned-parent
experience, all four sampled solver observations, metrics, embedded wake
diagnostics, and policies, and the available inherited optimizer notes and
their evaluated descendants. I inspected the common held-fish prewarm sheet
first, then the released keyframes for the three identical
`oscillator_energy_gain=2.1` results, the sampled `2.2` regression, the
inherited `2.05` result, and the assigned parent's high-speed damping
regression. No sampled rollout is a termination failure, so the latter two
comparisons are failed optimization hypotheses rather than collision, domain
exit, horizon-miss, or numerical-instability examples. I used no omitted
Bookshelf material, neighboring configuration, repository history, clock,
global-coordinate route, or external research.

The shared prewarm sheet shows the fish held above and downstream of the four
staggered cylinders while their interacting vortex streets develop, with the
target in the merged second-row wake. This is common initial-condition
evidence, not candidate-specific support for a memorized route or wake phase.

The three exact `2.1` policies reproduce the same bounded down-left turn,
productive lateral beat, compact diagonal entry into the developed wake, and
target crossing. Their identical metrics (`73.859` release units, `2.480L`
mean distance, and score `-0.5806`) are evidence of same-snapshot
reproducibility, not robustness to a changed wake. Mean world x velocity
`-0.14784` versus local-flow x `-0.08219` gives `0.06565` upstream-relative x
speed, confirming self-propulsion rather than passive advection. The result
uses `51797` command energy and reaches RMS force/moment `24.94/410.68`; both
commands touch the candidate's `28 rad/time^2` guard while joint angles and
speeds remain within the task envelope.

Increasing only the static energy gain to `2.2` visibly takes a slightly lower,
less compact correction before capture. Metrics agree with a regression:
arrival slows to `77.726`, mean distance rises to `2.541L`, upstream-relative
x speed falls to `0.06006`, command energy rises to `55790`, and RMS
force/moment rise to `26.42/423.30`. Thus more energy-restoration authority is
not monotone improvement. Conversely, the inherited static `2.05` result
follows the same broad diagonal corridor and arrives faster (`72.699`) with
essentially the same upstream-relative x speed (`0.06562`) as `2.1`, while
using less energy (`50630`) and lower RMS force/moment (`21.05/379.50`); its
mean distance and score are worse (`2.511L`, `-0.6125`). Static `2.05` is
therefore a load/arrival benefit but not the best compact-distance route.

The assigned parent's normalized high-speed tail-damping schedule is an
independent warning against treating a lower joint-speed peak as a complete
improvement. Its sheet shows a lower, kinked correction and its metrics regress
to `77.291` arrival and `2.630L` mean distance despite remaining finite. It is
not combined with the present experiment.

## Single candidate hypothesis

Retain the evaluated positive-bearing steering map, `0.75` period, `22 deg`
orbit, posterior steering share and lag, `0.65` damping, and common
`28 rad/time^2` guard. Split only the oscillator's existing normalized
phase-space recovery by the sign of its energy error: use the score-leading
gain `2.1` when normalized oscillator energy is at or below one and needs
injection, and the lower-load evaluated gain `2.05` when energy exceeds one
and the feedback term is dissipative. The drive is continuous at unit energy
because its `(1 - energy)` factor vanishes there. Both active gains are owned
by `target_policy_params`; the controller adds no observation, coordinate,
route, timing signal, wake probe, or unbounded response.

This tests whether the compact `2.1` startup/recovery behavior can be retained
without paying its full-cycle damping effort. Later CFD should count the split
as an improvement only if it still reaches through the compact diagonal wake
corridor, keeps mean distance near or below `2.480L`, and moves command effort
and force/moment toward the `2.05` result without reducing upstream-relative
propulsion. Reject it if weaker excess-energy damping enlarges joint motion,
selects the lower `2.2`/damping-schedule route, raises load, or loses capture.
The aggregate evidence does not identify how much time either energy regime is
active, so the split is deliberately falsifiable; any same-snapshot gain would
still require held-out wake-phase, inflow, geometry, and target tests.
