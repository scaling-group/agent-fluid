# Multi-wake candidate diagnosis

## Evidence coverage and visual diagnosis

I read the Phase 2 workspace and guidance contracts, the assigned-parent
experience and prefilled policy, all four current sampled solver scores,
observations, compact metrics, embedded wake diagnostics, and policies, and the
available assigned-parent optimizer notes and evaluated descendants. I used no
omitted Bookshelf material, neighboring configuration, repository history,
global-coordinate route, elapsed-time cue, or external research.

I inspected a shared held-fish prewarm sheet before the released sheets. Its
hash is identical across all four current samples. It shows the fish held at
the upper-right release pose while the four staggered-cylinder vortex streets
develop and merge around the second-row target. This is common
initial-condition evidence, not support for a memorized phase or route.

The assigned static `tail_steering_gain=0.70`, `tail_damping=0.65` prefill
turns down-left, sustains a productive lateral beat, travels upstream through
the developed wake, and corrects from modestly below into the capture circle.
It neither loops nor collides, exits, or becomes unstable. Mean world/local
flow x velocities of `-0.15005/-0.08386` give `0.06620` upstream-relative x
speed, confirming self-propulsion rather than passive advection. It reaches in
`72.457` release units with `2.45409L` mean distance, `51842` command energy,
posterior peak speed `3.293`, and RMS force/moment `23.85/408.89`. Both
commands touch the candidate's `28 rad/time^2` guard, while joint angles and
speeds remain within the task envelope.

Two independent current samples of the exact speed-gated damping controller
produce identical keyframe hashes and metrics. Their sheets retain the same
compact diagonal wake corridor but tighten the late lower-to-target correction
and finish sooner. Relative to the prefill, arrival improves to `70.823`, mean
distance to `2.38538L`, upstream-relative x speed to `0.06972`, command energy
to `50756`, posterior peak speed to `3.260`, and RMS force/moment to
`22.72/397.24`. RMS relative crossflow changes only from `0.13063` to
`0.13092`, and anterior peak speed rises slightly from `3.086` to `3.112`.
Both commands still reach the common guard, so aggregate metrics do not prove
less guard contact.

The inherited static `tail_steering_gain=0.75` experiment is the most
informative visually available failed optimization hypothesis. It remains
finite and reaches, but its penultimate sheet shows a deeper lower excursion;
center y displacement grows from `-4.285L` at the prefill to `-4.590L`, mean
distance regresses to `2.50932L`, and command energy to `52496`, despite lower
RMS force/moment. No available current or inherited keyframe is a semantic
termination failure. The older reversed-sign instability therefore remains a
textual inherited safety boundary rather than a visual comparison: do not
infer or fabricate its missing sheet.

## Single candidate hypothesis

Adopt exactly the duplicated speed-gated posterior damping mechanism as the
one candidate. Preserve the prefill's `0.75` period, `22 deg` oscillator,
static `2.1` energy restoration, bounded positive-bearing `0.75/10 deg`
anterior steering, `0.70` posterior steering share, `0.55` lag, base damping
`0.65`, and common `28/28 rad/time^2` command guard. Add at most `0.025`
posterior damping through a smooth tanh gate as normalized posterior speed
`abs(qd2)/(omega*oscillator_amplitude)` crosses `1.0`, with transition width
`0.08`. The candidate uses only joint state and the existing body-frame
bearing; it adds no coordinate, target identity, route, clock, external phase,
or forbidden wake probe.

This is evidence-backed adoption, not an extrapolation or combination. Later
CFD should reproduce finite compact capture and the duplicated gains in
arrival, distance, relative propulsion, effort, posterior speed, and load.
Reject the mechanism if it selects the inherited constant-damping deep route,
loses capture, materially raises crossflow or anterior speed, or fails to
reduce posterior speed and aggregate load. The duplicate result establishes
determinism on the common wake snapshot, not robustness; falsify reuse under
held-out wake phase, inflow, geometry, or target placement if those tests lose
compact capture or acceptable loads.
