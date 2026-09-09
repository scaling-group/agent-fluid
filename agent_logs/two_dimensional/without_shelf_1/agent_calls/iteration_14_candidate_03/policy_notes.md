# Multi-wake candidate visual diagnosis and hypothesis

## Evidence diagnosis before the policy edit

The shared prewarm sheet confirms the common initial condition: the held fish
starts above and downstream of the target while four developed vortex streets
interact across the route.  The released sheets and diagnostics show genuine
self-propulsion rather than passive advection.  The phase-opposition anchor
moves the head `-11.33L` while its mean local flow x is `-0.119`, reaches
`3.03L`, and improves progress to `0.517`; its alternating lateral motion is
therefore productive through the upstream approach.  It nevertheless turns
into the same upper hook as every sampled variant, exits with `+1.69L` head-y
displacement, reaches `0.780 rad` posterior bend and both joint rate/command
caps, and carries `511/5305` RMS force/moment.

The newly evaluated recovery compositions do not repair that hook.  Activating
receding-distance reversal across `4--3L` or `3.75--2.75L` worsens closest
approach to `3.13L` and `3.10L`, progress to `0.495` and `0.507`, and upstream
travel to `-10.15L` and `-10.83L`; both still exit high with about `+1.8L`
head-y drift and the same joint caps.  Their modest load reductions do not buy
a route change.  The symmetric signed-fore-aft gate is more destructive:
because it attenuates bearing drive whenever the target approaches abeam even
while still ahead, it falls to `-8.49L` upstream travel, `3.45L` closest
approach, and `0.449` progress before the same exit.

The trajectory resolves why radial recovery is mistimed.  At the anchor's
`3.03L` minimum, the target remains `2.35L` forward in the body frame and
`1.91L` laterally below; distance begins increasing before longitudinal
overshoot.  Receding speed therefore reverses steering while the target is
still ahead and sacrifices the first pass.  Only later, as distance reopens
through `3.25L`, does the target pass `0.49L` behind in the body frame while
the visible upward turn is developing.  Bearing itself uses the absolute
forward separation, so without an asymmetric correction it requests the same
turn direction for geometrically opposite ahead/behind states.

## Single candidate hypothesis

Restore the complete phase-opposition anchor through the first pass.  Change
only its bearing geometry after measured longitudinal overshoot: keep a gain
of exactly one whenever `state.forward_distance_L >= 0`, then smoothly change
the gain from `+1` to `-1` over the first `0.75L` that the target moves behind.
This one-sided gate avoids the sampled symmetric gate's ahead-of-target
attenuation and cannot trigger at the radial minimum merely because lateral
motion makes distance increase.  It supplies bounded countersteering only
during the target-behind portion of the upper hook; propulsion, posterior-only
phase-headroom allocation, body-rate damping, and all actuator limits remain
unchanged.

This is a prospective mechanism, not a claimed CFD result.  It is supported
only by a second approach, capture, or a material reduction of the terminal
upper hook while retaining the anchor's first-pass `3.03L` approach and
far-field trajectory.  It is falsified if the pre-overshoot route diverges,
the first pass regresses, or the fish still exits high without reduced
posterior excursion or load.
