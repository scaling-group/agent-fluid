# Multi-wake candidate diagnosis

## Evidence coverage and visual diagnosis

I read the Phase 2 workspace and guidance contracts, assigned-parent
experience, all four sampled policies, scores, observations, metrics, embedded
wake diagnostics, and the available inherited optimizer notes and evaluated
descendants. I inspected the common held-fish prewarm sheet first, followed by
the released sheets for the localized high-speed damping policy, the assigned
parent's bearing-dependent posterior-share policy, the replicated static
`tail_steering_gain=0.70` anchor, and the inherited static `0.75` continuation.
I used no omitted Bookshelf material, neighboring configuration, repository
history, global route, clock, or external research.

The four sampled prewarm sheets are byte-identical. They show the fish held at
the upper-right release pose while the staggered-cylinder streets develop and
merge around the second-row target. This establishes a shared initial
condition, not candidate-specific support for memorizing a wake phase or
coordinate route.

The two executable static-`0.70` samples are also byte-identical. Their
released sheet shows a bounded lateral beat, a down-left turn, self-propelled
upstream travel into the developed wake, and a compact approach from just
below the target without looping, collision, exit, or instability. Mean
world/local-flow x velocities `-0.15005/-0.08386` give `0.06620` mean
upstream-relative x speed, confirming that the diagonal advance is not passive
advection. Capture takes `72.457` release units with `2.45409L` mean distance,
`51842` command energy, `0.13063` relative crossflow, `23.85/408.89` RMS
force/moment, and anterior/posterior peak speeds `3.086/3.293 rad/time`; both
commands touch the common `28 rad/time^2` guard.

The assigned-parent schedule changes posterior steering share from `0.65` at
large bounded bearing demand to `0.70` near alignment. Its sheet retains the
same finite diagonal topology while slightly tightening the final approach.
Against static `0.70`, it improves arrival to `71.615`, mean distance to
`2.42407L`, relative x propulsion to `0.07111`, total energy to `51250`, and
force/moment to `23.26/402.06`. Its mean command energy is essentially flat
(`715.63` versus `715.49`), posterior speed rises slightly to `3.299`, and both
guards still engage. This is a useful bounded steering-regime mechanism on the
common snapshot, not evidence that tail-share interpolation is generally
smooth.

The sampled normalized high-speed damping policy preserves static `0.70` but
adds at most `0.025` posterior damping through a smooth gate at normalized tail
speed `1.0` with width `0.08`. Its released sheet is the most compact current
route: it enters the same useful wake corridor and captures without a deeper
lower excursion. It improves score from `-0.55577` to `-0.48790`, arrival to
`70.823`, mean distance to `2.38538L`, upstream-relative x speed to `0.06972`,
total energy to `50756`, and force/moment to `22.72/397.24`. Posterior peak
speed falls to `3.260`, but anterior peak speed rises to `3.112` and mean
command energy rises slightly to `716.66`; this partially violates the prior
no-transfer expectation even though route, effort integral, and loads improve.

No current sampled rollout is a semantic termination failure. The inherited
static `tail_steering_gain=0.75` continuation is therefore the most informative
failed optimization hypothesis with a local visual sheet: it remains finite
but takes a lower final route, regresses mean distance to `2.50932L`, and raises
energy to `52496` despite improved relative x speed and lower aggregate loads.
The inherited constant `tail_damping=0.675` result is the relevant negative
mechanism boundary: it lowered posterior peak speed but shifted the whole route
and work to the anterior joint, arriving at `91.50` with `2.788L` mean
distance, `60660` energy, and `42.13/581.11` force/moment. The older reversed-
sign instability remains a safety boundary in guidance, but no corresponding
keyframe is available here, so I infer no new visual detail from it.

## Single-candidate hypothesis

Keep the assigned parent's evaluated bearing-dependent posterior-share
schedule, `0.75` period, `22 deg` oscillator, `2.1` energy restoration,
positive bounded `0.75/10 deg` anterior steering, `0.55` tail lag, `0.65` base
damping, and common `28/28 rad/time^2` guards. Add only the exact evaluated
high-speed posterior damping gate: maximum increment `0.025`, normalized-speed
threshold `1.0`, and transition width `0.08`. This combines two individually
positive normalized state-feedback mechanisms without extrapolating either
mechanism's gains, changing propulsion authority, or adding a coordinate,
route, clock, external phase, or forbidden wake probe.

The falsifiable expectation is finite capture through the same compact
diagonal corridor, with arrival and mean distance competitive with the sampled
`70.823` and `2.38538L` high-speed-damping anchor while retaining or improving
the parent's `0.07111` relative x propulsion and `23.26/402.06` loads. Reject
the combination if the two posterior modulations interact to select a deeper
route, materially increase anterior speed or mean effort, lose target capture,
or raise loads without better closure. A positive result on the deterministic
common snapshot would still require held-out wake phase, inflow, geometry, and
target placement before it supports a robustness claim. No CFD outcome for
this candidate is claimed.
