# Multi-wake candidate visual diagnosis and hypothesis

## Evidence diagnosis before the policy edit

The shared prewarm sheet establishes the common initial condition: the held
fish starts above and downstream of the target while the four cylinder wakes
are fully developed. The released sheets then separate two route topologies.
The assigned `0.50` phase-headroom parent actively self-propels upstream (mean
head velocity x `-0.174` versus mean local flow x `-0.123`), enters the
disturbed wake, and travels `-12.28L`, but it passes above the capture circle,
curls sharply upward, and leaves the domain. Its `2.13L` closest approach,
`+1.78L` head-y displacement, and `left_domain` termination agree with that
visual diagnosis rather than collision, passive advection, or instability.

Adding the sampled body-frame cross-track term is the first inherited change
that repairs that topology. The fish descends through the wake to the target
and reaches the `0.75L` circle after `88.13` release units, with final/minimum
distance `0.747L`, progress `0.940`, and head displacement
`(-10.92,-4.44)L`. Mean head velocity x remains upstream of mean local flow x,
so capture is propelled rather than wake advection. Although both joints
still touch the angle/rate/command envelope, RMS relative crossflow, force,
and moment fall from the parent values `0.306/535/5416` to
`0.289/445/4597`. Thus the route change is supported by distance and load
diagnostics, not only by the visually dramatic wake.

The comparisons also bound the mechanism. Reducing the phase coefficient to
`0.35` or replacing bearing by lateral offset only inside `3L` still produces
the high exit. The latter reaches `1.89L` but retains `+1.79L` head-y drift and
raises RMS force/moment to `568/5495`. Consequently, lateral offset is useful
as a small additive far-field correction to the complete bearing command; it
is not evidence for near-target bearing replacement, another recovery gate,
or weakening the propulsion anchor.

## Single candidate hypothesis

Preserve the successful controller exactly except for an isolated, modest
increase of `cross_track_gain` from `0.18` to `0.20`. The added term remains
bounded by `0.20`, is normalized by the same `2L` body-frame lateral scale,
and naturally vanishes at lateral alignment. The successful sample terminates
at the edge of the tight capture circle after nearly five shedding cycles, so
slightly earlier lateral allocation may shorten the high-side approach without
changing gait, phase-headroom allocation, yaw damping, fade, or actuator cap.
No global coordinate, elapsed time, prescribed inflow, or remote wake signal
is introduced.

The next CFD result supports this continuation only if capture is retained and
arrival or distance integral improves without higher RMS load or more severe
saturation. It is falsified by a lower-side miss, loss of upstream approach,
reappearance of the upper exit, or greater load without an arrival benefit.
If falsified, later workers should restore the demonstrated `0.18/2L`
cross-track pair rather than stacking another route or recovery term.
