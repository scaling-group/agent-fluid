# Multi-wake candidate diagnosis

## Evidence coverage and visual diagnosis

I read the Phase 2 workspace and guidance contracts, the assigned-parent
experience and prefilled policy, all four sampled solver policies, scores,
compact observations, metrics, and embedded wake diagnostics, plus the
inherited optimizer notes for the static posterior-share, bearing-scheduled
share, constant-damping, and speed-gated damping experiments. I inspected the
common held-fish prewarm sheet before every released sheet. I used no omitted
Bookshelf material, neighboring configuration, repository history, global
coordinate route, elapsed-time cue, or external research.

The common prewarm sheet shows the held fish at the upper-right release pose
while the four staggered-cylinder vortex streets develop and merge around the
second-row target. All samples use this same initial condition, so its wake
phase and layout are not candidate-specific evidence.

The static `tail_steering_gain=0.70`, `tail_damping=0.65` anchor reaches the
target in `72.457` release units along a finite compact diagonal route. Its
mean world/local-flow x velocities `-0.15005/-0.08386` give `0.06620`
upstream-relative x speed, confirming self-propulsion rather than passive
advection. Mean distance is `2.45409L`, command energy is `51842`, RMS
relative crossflow is `0.13063`, and RMS force/moment are `23.85/408.89`.
Both commands touch the `28 rad/time^2` policy guard, but peak joint angles and
speeds remain within the episode envelope. The sheet shows no loop, collision,
domain exit, or instability; the fish enters the developed wake and makes a
bounded lower-to-target correction.

Two independently materialized copies of the assigned parent's high-speed
posterior damping policy are byte-identical and produce identical CFD metrics.
Relative to the static `0.70` anchor, the smooth normalized-speed gate preserves
the compact visual topology while improving arrival to `70.823`, mean distance
to `2.38538L`, upstream-relative x speed to `0.06972`, command energy to
`50756`, and RMS force/moment to `22.72/397.24`. It lowers posterior peak speed
from `3.293` to `3.260 rad/time`. Its measured costs are a small anterior
peak-speed rise from `3.086` to `3.112` and a negligible crossflow rise from
`0.13063` to `0.13092`; both acceleration channels still touch `28`, so the
aggregate evidence does not establish less clipping.

The independently evaluated bearing schedule for posterior steering share is
also finite and visibly compact. It uses the exact evaluated range `0.65` at
large bounded steering demand to `0.70` near alignment and improves the same
static anchor to `71.615` arrival, `2.42407L` mean distance, `51250` energy,
`0.07111` upstream-relative x speed, `0.13022` crossflow, and `23.26/402.06`
force/moment. It is weaker than the damping gate on arrival, compactness,
effort, and load but stronger on relative propulsion and crossflow. It also
raises anterior peak speed to `3.112`, and it does not reduce guard maxima.

No sampled rollout is a semantic termination failure. The inherited static
`tail_steering_gain=0.75` continuation is the most informative failed policy
hypothesis: it reaches but takes a visibly deeper final route, worsening mean
distance to `2.50932L` and energy to `52496` despite partial propulsion/load
gains. Constant `tail_damping=0.675` is a stronger negative boundary: it lowers
posterior peak speed but selects a deep kinked route with `91.50` arrival,
`2.788L` mean distance, `60660` energy, and `42.13/581.11` loads. These route
branches rule out static interpolation as a safe optimization assumption.

## Single-candidate hypothesis

Retain the exactly evaluated high-speed posterior damping gate and replace
only its static posterior steering share with the exactly evaluated bounded
bearing schedule: `0.65` at maximum steering-center magnitude, approaching
`0.70` quadratically as the fish aligns. Preserve the `0.75` period, `22 deg`
oscillator, `2.1` energy restoration, positive-bearing `0.75/10 deg` anterior
steering map, `0.55` posterior lag, base damping `0.65`, speed-gate increment
`0.025` at normalized posterior speed `1.0` with width `0.08`, and common
`28/28` guard. This uses only joint state and the existing normalized
body-frame bearing; it adds no coordinate, route, clock, external phase, flow
probe, force, or moment dependency.

This candidate is an explicit interaction test, not a claim that independent
benefits add linearly. The two constituent schedules separately improve the
same static anchor and act on distinct normalized signals, so combining their
exact evaluated forms is more evidence-grounded than interpolating either
schedule's parameters. The falsifiable expectation is finite compact capture
that retains the damping gate's `70.823` arrival, `2.38538L` mean distance,
`50756` effort, and `22.72/397.24` load envelope while approaching the bearing
schedule's `0.07111` relative x speed and lower crossflow. Reject the
interaction if it selects a deep route branch, loses capture, materially raises
either joint-speed peak or guard contact, or gives back the damping gate's
compactness, effort, or load gains. Even a same-snapshot improvement would not
establish robustness until later held-out wake-phase, inflow, geometry, and
target-placement evaluations.
