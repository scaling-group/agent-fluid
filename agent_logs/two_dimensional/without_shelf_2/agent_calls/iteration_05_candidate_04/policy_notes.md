# Multi-wake candidate diagnosis

## Evidence coverage and visual diagnosis

I read the assigned parent guidance, all four sampled solver policies and
scores, their compact observations, released metrics and nested diagnostics,
and the inherited optimizer notes before writing this diagnosis. I inspected
the shared-prewarm sheet before every released sheet. No omitted Bookshelf,
neighboring configuration, repository history, external research, prescribed
inflow, coordinate route, or clock informed this candidate.

The shared sheet confirms the common release condition: the held fish starts
above and downstream of four fully developed, interacting vortex streets, with
the target inside the second-row wake overlap. The released sheets then provide
a clean local comparison because every sampled controller retains the same
`0.75`-period, `22 deg` state-energy gait, posterior phase relation, damping,
and `28 rad/time^2` action guard.

All four sampled controllers self-propel upstream, enter the developed wake,
and reach the target, but the three `10 deg` steering-limit samples show that
the previously improving static-gain trend has turned over. Gain `0.70` reaches
in `91.61` release units with mean distance `2.834L` and upstream velocity
relative to local flow `0.0515`. Gain `0.75` follows a visibly shallower final
approach, enters the capture circle with only `-4.246L` head displacement in y,
and improves those metrics to `74.23`, `2.561L`, and `0.0643`. Raising the same
bounded response to `0.82` sends the terminal path below the target again and
regresses to `83.83`, `2.668L`, and `0.0582` despite continued capture.

The gain-`0.75` sample is also the least hydrodynamically costly of this local
set: RMS lateral force/moment are `22.39/393.08`, versus `38.81/550.75` at
gain `0.70` and `36.11/515.17` at gain `0.82`; maximum anterior angle is
`0.516 rad`, versus `0.550` and `0.557 rad`. All three touch the candidate
acceleration guard and have nearly identical maximum lateral target offset
(`4.296--4.297L`), so neither more clipping nor a smaller initial excursion
explains the `0.75` advantage. The fourth sample, gain/limit `0.80/11 deg`, is
confounded by its larger curvature envelope and performs worse still
(`87.63`, `2.760L`, RMS force/moment `52.88/687.45`); it is evidence against
expanding the steering limit, not a clean gain point.

Inherited logs explain why this refinement should remain one-dimensional. A
positive windowed-bearing-rate lead changed a captured route into a downstream
exit, while reversed/larger gaits produced instability-scale loads. The current
samples instead isolate a narrow useful neighborhood for bounded positive
static bearing feedback without disturbing the demonstrated propulsion core.

## One candidate hypothesis

Keep the evaluated propulsion, posterior phase relation, `10 deg` steering
limit, damping, and action guard unchanged. Set only `steering_gain` to `0.77`,
inside the successful `0.75--0.82` bracket and much closer to the local best.
This is a small interpolation intended to preserve the low-load, fast approach
of gain `0.75` while testing whether slightly earlier small-error correction can
reduce its remaining approach time. Every active constant remains owned by
`target_policy_params()` and no derivative, flow, force, position, or route
channel is added.

Later CFD should retain capture, material upstream-relative propulsion, and
finite loads while matching or improving the `0.75` anchor's `74.23` release
time and `2.561L` mean distance. Reject this interpolation if either route
metric regresses, the terminal path again overshoots below the target, maximum
joint excursion rises toward the `0.82` sample, or RMS force/moment materially
exceed `22.39/393.08`. Such a result would bound the useful gain at or extremely
near `0.75`; it would not support increasing the steering limit or restoring
the falsified bearing-rate lead. No result is claimed for this unevaluated
candidate.
