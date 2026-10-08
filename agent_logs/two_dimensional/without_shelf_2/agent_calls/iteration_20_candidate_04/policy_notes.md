# Multi-wake candidate diagnosis

## Evidence coverage and visual diagnosis

I read the Phase 2 workspace and guidance contracts, the assigned-parent
experience and inherited speed-gate proposal, all four sampled solver policies,
scores, observations, compact metrics, and embedded wake diagnostics, plus the
available inherited optimizer notes for the static posterior-share, bearing
schedule, and damping experiments. I inspected the common held-fish prewarm
sheet first, then compared the released sheet for the best finite speed-gated
damping result with the prefilled static-damping result. I used no omitted
Bookshelf material, neighboring configuration, repository history, global
coordinate route, clock, external phase signal, or forbidden flow probe.

The prewarm sheet is byte-identical across all four samples. It shows the fish
held at the upper-right release pose while the staggered four-cylinder streets
develop and merge around the target. It is therefore common initial-condition
evidence, not support for a candidate-specific phase or memorized route.

The prefilled static `tail_steering_gain=0.70`, `tail_damping=0.65` controller
turns down-left, beats continuously, enters the developed wake, and closes on
the target along a compact diagonal path without collision, domain exit, loop,
or instability. Mean world/local-flow x velocities `-0.15005/-0.08386` imply
`0.06620` upstream-relative x speed, so its motion is self-propelled rather than
passive advection. It reaches in `72.457` release units with `2.45409L` mean
distance, `51842` command energy, `0.13063` RMS relative crossflow, RMS
force/moment `23.85/408.89`, and posterior peak speed `3.293 rad/time`; both
commands touch the common `28 rad/time^2` guard.

The best speed-gated damping sheet preserves that finite compact route and
shows a slightly tighter late lower-to-target correction. Metrics corroborate
the visual improvement: arrival is `70.823`, mean distance `2.38538L`,
upstream-relative x speed `0.06972`, energy `50756`, and RMS force/moment
`22.72/397.24`. Posterior peak speed falls to `3.260 rad/time`. Its boundaries
are a small anterior peak-speed increase from `3.086` to `3.112`, a negligible
crossflow increase to `0.13092`, and unchanged contact with both acceleration
guards. The two sampled copies have identical policy hashes, released-sheet
hashes, and all physical metrics; only wall time differs. This establishes
deterministic same-snapshot reproduction, not robustness to a changed wake.

No sampled rollout is a semantic termination failure. The inherited static
`tail_damping=0.675` result remains the most informative failed damping
hypothesis: applying the same increment throughout the orbit reduced posterior
speed but selected a visibly deeper route and regressed to `91.50` arrival,
`2.788L` mean distance, `60660` energy, and `42.13/581.11` RMS force/moment.
The sampled bearing-scheduled posterior-share result is finite and better than
the prefill on several metrics, but at `71.615` arrival, `2.42407L` mean
distance, `51250` energy, and `23.26/402.06` loads it is consistently weaker
than the speed gate. These comparisons support preserving localization and
avoiding a compound schedule in this candidate.

## Single candidate hypothesis

Adopt exactly the twice-evaluated speed-gated posterior damping policy as the
one candidate. Preserve the prefill's `0.75` period, `22 deg` oscillator,
`2.1` energy restoration, bounded positive-bearing `0.75/10 deg` anterior
steering, static `0.70` posterior share, `0.55` posterior lag, base damping
`0.65`, and common `28/28 rad/time^2` command guard. Add at most `0.025`
posterior damping through the evaluated smooth gate as normalized posterior
speed `abs(qd2)/(omega*oscillator_amplitude)` crosses `1.0`, with transition
width `0.08`. This adds no coordinate, route, target identity, elapsed-time
cue, external phase signal, or flow probe.

This candidate improves the prefill by adopting a reproduced sampled result
rather than extrapolating the gate or combining it with the separately tested
bearing schedule. Later CFD should reproduce finite compact capture and the
observed arrival, distance, relative-propulsion, effort, posterior-speed, and
load gains. Reject the mechanism if it selects the inherited constant-damping
deep route, loses capture, raises anterior speed or crossflow enough to erase
the aggregate benefit, or fails under a held-out wake phase, geometry, inflow,
or target placement. No outcome for this worker's post-exit evaluation is
claimed here.
