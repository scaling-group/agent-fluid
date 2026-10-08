# Multi-wake candidate diagnosis

## Evidence coverage and visual diagnosis

I read the Phase 2 workspace and guidance contracts, the assigned-parent
experience and prefilled policy, all four sampled solver policies, scores,
observations, compact metrics, and embedded wake diagnostics, plus the
available inherited optimizer notes relevant to posterior steering share and
damping. I inspected the common held-fish prewarm sheet first, then the
released sheets for the replicated static `tail_steering_gain=0.70` anchor,
the bearing-scheduled posterior-share candidate, the speed-gated damping
candidate, and the inherited static `0.75` posterior-share regression. I used
no omitted Bookshelf material, neighboring configurations, repository history,
global-coordinate route, elapsed-time cue, or external research.

The shared prewarm sheet shows the fish held at the upper-right release pose
while four staggered-cylinder vortex streets develop and merge around the
second-row target. The image hash is identical in every sample, so it is common
initial-condition evidence rather than support for a candidate-specific phase
or memorized route.

The static `0.70` anchor is reproduced exactly by the prefill and two sampled
copies. Its released sheet shows a bounded down-left turn, sustained lateral
beating, productive upstream travel through the developed wake, a modest lower
excursion, and correction into the capture circle without a loop, collision,
domain exit, or instability. Mean world/local-flow x velocities
`-0.15005/-0.08386` give `0.06620` upstream-relative x speed, so the fish is
self-propelled rather than passively advected. It reaches in `72.457` release
units with `2.45409L` mean distance, `51842` command energy, `0.13063` RMS
relative crossflow, and RMS force/moment `23.85/408.89`. Both acceleration
commands touch the `28 rad/time^2` guard, while joint angles and speeds remain
inside the task envelope.

The best sampled speed-gated damping sheet preserves the same compact diagonal
topology and productive wake entry, but its late lower-to-target correction is
slightly tighter and completes sooner. Metrics agree: arrival improves to
`70.823`, mean distance to `2.38538L`, upstream-relative x speed to `0.06972`,
command energy to `50756`, and RMS force/moment to `22.72/397.24`. The localized
damping lowers posterior peak speed from `3.293` to `3.260 rad/time`; its costs
are a small anterior peak-speed increase from `3.086` to `3.112` and a
negligible crossflow increase from `0.13063` to `0.13092`. The independent
bearing-scheduled posterior-share sample also improves the anchor—`71.615`
arrival, `2.42407L` mean distance, `51250` energy, and `23.26/402.06` loads—but
is weaker than the damping gate on those measures. Because both commands still
reach the common acceleration guard, neither result establishes reduced guard
contact.

No sampled rollout in this workspace is a semantic termination failure. The
inherited static `tail_steering_gain=0.75` continuation is the most informative
failed optimization hypothesis available for visual comparison: its sheet is
finite and reaches the target but shows a visibly deeper lower approach.
Metrics confirm worse compactness and effort than the `0.70` anchor
(`2.50932L` mean distance and `52496` energy), despite slightly better arrival,
relative propulsion, and aggregate loads. The inherited constant
`tail_damping=0.675` regression was more severe (`91.50` arrival, `2.788L`
mean distance, `60660` energy, and `42.13/581.11` loads). Together these
results warn that static interpolation and even apparently favorable joint
peak changes can select nonlinear wake-route branches.

## Single candidate hypothesis

Adopt exactly the evaluated high-speed posterior damping mechanism as the one
candidate. Preserve the static `0.70` controller's `0.75` period, `22 deg`
oscillator, `2.1` energy restoration, bounded positive-bearing `0.75/10 deg`
anterior steering, `0.55` posterior lag, base damping `0.65`, and common
`28/28 rad/time^2` command guard. Add at most `0.025` posterior damping through
a smooth gate as normalized posterior speed
`abs(qd2)/(omega*oscillator_amplitude)` crosses `1.0`, with transition width
`0.08`. This changes no morphology, coordinate, target identity, route, clock,
external phase, or forbidden wake probe, and it does not combine the mechanism
with the separately successful bearing schedule.

This is an evidence-backed adoption rather than an extrapolation: the sampled
CFD result already improves compact capture, arrival, upstream-relative
propulsion, effort, posterior peak speed, and force/moment loads over the exact
prefill. Later evaluation should reproduce those gains on the common snapshot;
reject the mechanism if it selects the inherited constant-damping deep route,
loses capture, materially raises crossflow or anterior speed, or fails to
reduce posterior speed and aggregate load. The current evidence is one
deterministic wake phase and does not establish robustness to held-out inflow,
geometry, target placement, or wake phase.
