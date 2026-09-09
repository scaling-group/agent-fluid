# Multi-wake candidate diagnosis

## Evidence coverage and visual diagnosis

I read the complete Phase 2 workspace and guidance contracts, the assigned
parent experience and policy, all four sampled solver scores, observations,
compact metrics, embedded wake diagnostics, and policies, plus the inherited
optimizer notes and evaluated descendants relevant to the current posterior
steering-share experiment. I inspected a shared held-fish prewarm sheet first,
then the released sheets for the distinct `tail_steering_gain=0.65` result, the
three replicated `0.70` anchors, and the three inherited `0.75` regressions. I
used no omitted Bookshelf material, neighboring configuration, repository
history, coordinate route, clock, or external research.

The common prewarm sheet shows the fish held at the upper-right release pose
while the four asymmetric cylinder streets develop and merge around the
second-row target. This is shared initial-condition evidence, not support for a
memorized wake phase or route.

The three executable `tail_steering_gain=0.70` samples reproduce the same
finite compact route. The fish turns down-left, sustains a productive lateral
beat, crosses upstream through the developed wake, passes modestly below the
target, and bends into the `0.75L` capture circle without looping, collision,
domain exit, or numerical instability. Capture takes `72.457` release units
with `2.45409L` mean distance. Mean fish/local-flow x velocities
`-0.15005/-0.08386` give `0.06620` upstream-relative x speed, so this is
self-propulsion rather than passive advection. Command energy is `51842`, RMS
relative crossflow is `0.13063`, and RMS force/moment are `23.85/408.89`.
Both commands touch the policy's `28 rad/time^2` guard while joint angles and
speeds remain within the task envelope.

The sampled isolated `0.65` share reaches slightly faster (`72.160`) and has a
shallower center displacement (`-4.030L` in y versus `-4.285L` at `0.70`),
slightly greater upstream-relative x speed (`0.06732`), and lower total command
energy (`51284`). It gives back a small amount of route compactness
(`2.46383L` mean distance) and raises crossflow and RMS force/moment to
`0.13603` and `25.32/420.32`. Thus `0.65` supplies evidence for a shallower,
quicker large correction, not for full-episode load reduction.

The newest inherited experiment supplies three deterministic copies of the
same isolated `0.75` policy and result. Its keyframe sheet remains finite and
visibly turns toward the target, but the penultimate frame shows a deeper
lower excursion before return. Diagnostics corroborate that route change:
center displacement reaches `-4.590L` in y, mean distance regresses to
`2.50932L`, score to `-0.610985`, and command energy to `52496`, compared with
`-4.285L`, `2.45409L`, `-0.555772`, and `51842` for `0.70`. Arrival is slightly
faster (`72.275`) and upstream-relative x speed rises to `0.06873`; RMS
crossflow and force/moment fall to `0.12785` and `22.60/394.40`, but posterior
peak speed rises from `3.293` to `3.370` while anterior peak speed falls from
`3.086` to `3.048`. More posterior sharing therefore redistributes joint
motion and load while worsening target-relative route compactness. No current
sample is a semantic termination failure; `0.75` is the most informative
failed optimization hypothesis, while the older reversed-sign instability is
retained only as an inherited safety boundary.

## Single candidate hypothesis

Preserve the replicated `0.70` controller's `0.75` period, `22 deg` oscillator,
static `2.1` energy restoration, bounded positive-bearing `0.75/10 deg`
anterior steering, `0.55` posterior lag, `0.65` damping, and common
`28/28 rad/time^2` command guard. Replace only the constant posterior steering
share with a smooth body-frame schedule between the two positively evaluated
values: use `0.65` when the bounded anterior steering center is at its largest
magnitude, and approach `0.70` quadratically as steering demand tends to zero.
The normalized blend is `(|steering_center| / steering_limit)^2`, so the share
always remains in `[0.65, 0.70]`; it adds no coordinate, target identity, route,
clock, wake probe, discontinuity, or observation beyond the existing bearing.

The mechanism tests whether the shallower, quicker `0.65` response belongs to
the high-demand turn while the more compact and lower-load `0.70` response is
preferable after alignment. Later CFD should count it as an improvement only
if it preserves finite capture and meaningful upstream-relative propulsion,
reduces the visible lower excursion or arrival without losing the `0.70`
anchor's mean-distance and load advantage, and does not increase guard contact
or command effort. Reject the schedule if state-dependent blending creates a
new wake-route branch, shifts loads or speed to either joint, or merely
reproduces the `0.65` tradeoff. The current aggregate diagnostics do not reveal
the time history of steering demand, so this allocation is deliberately
falsifiable; any same-snapshot gain would still require held-out wake phase,
inflow, geometry, and target-placement tests.
