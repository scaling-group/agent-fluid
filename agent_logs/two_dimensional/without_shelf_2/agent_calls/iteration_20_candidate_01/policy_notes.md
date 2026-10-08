# Multi-wake candidate diagnosis

## Evidence coverage

I read the Phase 2 task and guidance contracts, the assigned-parent experience
and inherited posterior-share notes, all four sampled solver policies, scores,
observations, compact metrics, and embedded wake diagnostics, and the inherited
optimizer notes for the evaluated high-speed damping and static `0.75`
posterior-share policies. I inspected a shared held-fish prewarm sheet first,
then the released sheets for the static `0.70` anchor, the bearing-scheduled
posterior share, the speed-gated damping result, and the inherited `0.75`
regression. I used no omitted Bookshelf material, neighboring configuration,
repository history, coordinate route, elapsed-time cue, or external research.

## Visual and metric diagnosis

The shared prewarm sheet shows the fish held at the common upper-right release
pose while the four staggered-cylinder streets develop and merge around the
second-row target. This is common initial-condition evidence rather than a
candidate-specific wake phase or route.

The static `tail_steering_gain=0.70` anchor turns down-left, maintains a bounded
lateral beat, propels upstream through the developed wake, and returns from a
modest lower excursion into the capture circle without looping, collision,
domain exit, or instability. Mean fish/local-flow x velocities
`-0.15005/-0.08386` give `0.06620` upstream-relative speed, so the motion is
self-propelled rather than passive advection. It reaches in `72.457` release
units with `2.45409L` mean distance, `51842` command energy, and RMS
force/moment `23.85/408.89`; both acceleration commands touch the `28`
guard while joint states remain inside the episode envelope.

The sampled speed-gated posterior damping policy preserves that route topology
but visibly tightens the lower-to-target correction. Every reported aggregate
improves over the exact static anchor: arrival `70.823`, mean distance
`2.38538L`, upstream-relative x speed `0.06972`, energy `50756`, and RMS
force/moment `22.72/397.24`. Posterior peak speed falls from `3.293` to
`3.260 rad/time`; the boundary is a small anterior peak-speed increase from
`3.086` to `3.112` and essentially unchanged relative crossflow (`0.13063` to
`0.13092`). The independent bearing-scheduled posterior share also preserves
finite compact capture and improves the static anchor to `71.615` arrival,
`2.42407L` mean distance, `51250` energy, `0.07111` upstream-relative x speed,
and `23.26/402.06` loads. It is weaker than speed-gated damping on every one of
those measures except upstream-relative speed, but supplies a second positive,
bounded mechanism acting on steering demand rather than joint speed.

No sampled rollout is a semantic termination failure. The inherited static
`tail_steering_gain=0.75` continuation is the most informative failed
optimization hypothesis: its released sheet shows a deeper lower return, and
metrics regress to `2.50932L` mean distance and `52496` energy despite finite
`72.275` capture and lower aggregate loads. The inherited constant
`tail_damping=0.675` result is a stronger route-shift warning (`91.50` arrival,
`2.788L` mean distance, `60660` energy, and `42.13/581.11` loads). These
comparisons rule out static extrapolation and motivate retaining the two
evaluated bounded schedules exactly rather than increasing their ranges.

## Single candidate hypothesis

Compose the two independently positive posterior schedules while preserving
all shared anchors: `0.75` period, `22 deg` amplitude, `2.1` oscillator-energy
gain, bounded positive-bearing `0.75/10 deg` anterior steering, `0.55` tail
lag, `0.65` base damping, and the common `28/28` acceleration guard. Schedule
posterior steering share quadratically from `0.65` at maximum normalized
steering demand to `0.70` near alignment, and retain the evaluated maximum
`0.025` damping increment as normalized posterior speed crosses `1.0` with
transition `0.08`. Both schedules use bounded body/joint-state quantities and
add no coordinate, target identity, learned route, clock, external phase, or
forbidden wake probe.

This tests composability, not a further parameter extrapolation: each schedule
alone improves compact capture, arrival, relative propulsion, effort, and
loads over the same static anchor, while their gates depend on different state
signals. Later CFD should accept the composition only if it remains finite,
preserves a compact diagonal wake crossing, and matches or improves the
speed-damping result's `70.823` arrival, `2.38538L` mean distance, `50756`
energy, and `22.72/397.24` loads without further anterior-speed transfer or
guard saturation. Reject the combination if the coupled posterior changes
select a deeper route, merely recover either weaker parent, or worsen joint
redistribution. Same-snapshot success would still require held-out wake phase,
inflow, geometry, and target-placement testing.
