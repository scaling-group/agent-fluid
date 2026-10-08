# Multi-wake candidate diagnosis

## Evidence coverage and visual diagnosis

I read the workspace contract, assigned parent guidance, all four sampled
solver scores, observations, metrics, nested wake diagnostics, and policies,
plus the available inherited optimizer notes and their evaluated descendants.
I inspected the shared held-fish prewarm sheet first, followed by the released
keyframe sheets for the duplicated `28/28 rad/time^2` anchor, the current
posterior-only `27` guard, and both inherited copies of the `27.5` midpoint.
No omitted Bookshelf material, neighboring configuration, repository history,
coordinate route, clock, or external research was used.

The prewarm sheet shows the common release state: the fish is held above and
downstream of four developed interacting vortex streets, while the target lies
in the merged second-row wake. This is common initial-condition evidence, not
candidate-specific evidence or justification for a memorized route.

Three sampled copies of the `28/28` policy reproduce exactly. Their sheets
show a bounded down-left turn, a compact diagonal entry into the developed
wake, and target crossing without a loop, collision, boundary excursion, or
visible loss of posture. They reach in `74.23` release units with `2.561L`
mean distance. Mean world x velocity `-0.14682` versus mean local-flow x
`-0.08249` gives `0.06433` upstream-relative speed, confirming active
propulsion rather than passive advection. RMS force/moment are `22.39/393.08`,
command energy is `50940`, and posterior peak speed is `3.225 rad/time`.
Joint angles and speeds remain within the hard envelope, although both
commands touch the candidate's `28 rad/time^2` guard.

The current posterior-only `27` sample is a mixed scalar improvement, not a
clean physical improvement. It preserves capture and slightly reduces mean
distance to `2.555L`, raising score from `-0.661705` to `-0.654416`, but its
sheet finishes lower and approaches from underneath. Arrival slows to `76.44`,
upstream-relative x speed falls to `0.06199`, command energy rises to `53200`,
RMS force/moment rise to `24.69/417.71`, and posterior peak speed increases to
`3.233`. Lowering the command bound therefore did not lower tail speed or
hydrodynamic load.

The inherited `27.5` midpoint is the most informative failed optimization
hypothesis even though it eventually reaches the target. Two independent
worker copies produce identical metrics and visible behavior: the fish enters
the wake, makes a much deeper downward excursion, passes beneath the target,
and turns back upward to cross only at `95.96`. Mean distance regresses to
`2.806L`, upstream-relative x speed to `0.05344`, command energy to `64918`,
and RMS force/moment to `51.98/665.46`; posterior peak speed rises again to
`3.242`. Thus a numerical midpoint between two finite guards is not an
intermediate controller in this clipped, wake-sensitive closed loop. The
current sample has no collision, exit, or unstable sheet; the older
reversed-sign instability remains only an inherited logged safety boundary.

## Single candidate hypothesis

Restore the exactly reproduced `28/28` anchor and retain its positive-bearing
gain `0.75`, `10 deg` steering cap, `0.75` period, `22 deg` energy-regulated
oscillator, tail steering share `0.60`, tail lag `0.55`, and all actuation
bounds. Change only posterior damping from `0.65` to `0.67`. This tests an
orthogonal mechanism suggested by the guard regressions: suppress posterior
velocity at the tail dynamics rather than reshaping the trajectory through a
lower clipping threshold. It leaves the target, oscillator energy, mean tail
curvature, and nominal phase-lag target unchanged and introduces no new
observation.

Later CFD should retain finite target capture and the compact diagonal route
while reducing posterior peak speed below `3.225 rad/time`, command effort, or
RMS force/moment without materially degrading the anchor's `74.23` arrival,
`2.561L` mean distance, and `0.06433` upstream-relative x speed. Reject the
damping increase if it recreates a lower excursion, slows closure materially,
raises load, or loses capture. Even a same-snapshot improvement would require
falsification across held-out wake phase, inflow, geometry, and target
placement; no result is claimed for this unevaluated candidate.
