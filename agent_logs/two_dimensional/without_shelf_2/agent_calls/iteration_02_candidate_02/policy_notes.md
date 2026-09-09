# Multi-wake candidate diagnosis

## Evidence coverage

The assigned parent is the prefilled `optimizer_ed32d38962aa` guidance. I used
its seed-derived lesson, the sampled seed and three evaluated descendants, and
the inherited candidate notes. The shared prewarm sheet confirms a common
initial condition: the fish is held near the upper-right boundary while four
developed, interacting wakes occupy the target corridor to its left. The
released sheets, compact metrics, and the nested wake diagnostics in each
`wake_observation.json` were inspected before this note and before any policy
edit. No omitted Bookshelf material or evidence outside this workspace was
used.

The target-blind seed is the best finite score (`-14.2942`) but not a useful
incumbent. Its sheet shows a violent down-left sweep that passes far to the
target's right, turns nearly vertical, and exits below after `50.13` release
units. Distance improves only transiently to `8.615L` and rebounds to
`12.123L`; head displacement is `(-3.545,-13.300)L`. Mean velocity
`(-0.0725,-0.2633)` remains close to local flow `(-0.0414,-0.2414)`, while
both joint velocity and acceleration reach the hard caps and RMS lateral
force/moment rise to `21.94/541.70`. It demonstrates that the state oscillator
can start and move upstream, but its `0.55` period and `28 deg` bend spend that
authority on saturation and uncontrolled yaw.

The three evaluated target-aware descendants provide a consistent negative
comparison. Although their periods (`1.0--1.1`), amplitudes (`12--24 deg`),
tail rules, and damping signals differ, each maps positive `state.bearing` to
positive mean curvature. All three released sheets show the fish barely bend,
move up/right, and leave through the nearby right boundary before turning
toward the down-left target. They last only `16.27--16.73`, displace about
`(+2.18 to +2.36,-0.86 to -1.06)L`, never improve on the initial
`12.423L` distance, and finish `14.262--14.391L` away. Their world velocity is
about `(+0.132,-0.054)L/time` against local flow about
`(+0.148,-0.066)`, so the reduced gaits supply only `0.016--0.023` upstream
relative speed and cannot clear the downstream advection before the boundary.
The repeatability across three controllers makes another positive-bearing gain
tweak unsupported; steering sign and propulsive margin must be tested together.

## One candidate hypothesis

Use the body-frame convention explicitly: forward is body `-x`, and the
initial positive bearing is the target on the clockwise side of that forward
axis. Therefore map positive bearing (plus bounded positive heading rate) to a
negative curvature center. This reverses the unproductive sign shared by all
three evaluated descendants. Retain state-encoded oscillator phase, but use a
`30 deg`, `0.82`-period energy-regulated bend. Its nominal restoring
acceleration is about `30.74 rad/time^2`, just below the `31.416` hard cap,
while its amplitude-squared frequency is materially closer to the seed than
the three under-driven descendants. Limit steering to `8 deg`, carry the same
mean sign into the posterior joint, and smoothly bound accelerations below the
episode cap. Every active constant remains in `target_policy_params()`.

The later CFD evaluation should show an immediate leftward component rather
than the descendants' repeated right exit, decreasing bearing without the
seed's one-way downward pivot, survival beyond `16.7`, and stronger upstream
velocity relative to local flow without persistent hard clipping. A right
exit falsifies the propulsive margin or the claimed sign correction; a renewed
lower exit with growing yaw falsifies the steering damping/limit; weak bending
with low relative speed falsifies the proposed amplitude-period compromise.
No improvement from this unevaluated candidate is claimed here.
