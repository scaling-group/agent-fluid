# Multi-wake candidate visual diagnosis and hypothesis

## Evidence diagnosis before the policy edit

The shared prewarm sheet establishes the common initial condition: the held
fish starts above and downstream of the target while four developed,
interacting vortex streets fill the route. The released sheets show active
self-propulsion rather than passive advection. In the isolated `0.50`
opposing-posterior-headroom run, mean head velocity x is about `-0.174` while
mean local flow x is `-0.123`, and the head travels `-12.28L`. Nevertheless,
that fish follows the inherited failure topology: it approaches upstream above
the target, turns sharply upward after its closest pass, becomes nearly
vertical, and exits the upper domain. The current prefill at `0.35` and the
sampled near-target bearing-to-lateral replacement repeat the same hook. Their
`+1.69L` to `+1.79L` terminal head-y displacement, `1.89L` to `3.03L`
closest approach, and `left_domain` termination agree with the pictures.

The sampled additive cross-track controller is the first branch to change that
topology and complete the task. It keeps the `0.50` phase-headroom anchor and
adds only `0.18 * tanh(target_body_L[2] / 2L)` to the bounded steering command.
Its keyframes show an early clockwise descent into the interacting wake and a
continued diagonal approach to the capture circle instead of the late upper
hook. It reaches the target after `88.13` release units with `0.747L` final and
minimum distance, `2.736L` mean distance, `0.940` progress, and head
displacement `(-10.92,-4.44)L`. This route change is not purchased by passive
flow or larger aggregate loads: mean head velocity x remains more upstream
than mean local flow x, RMS relative crossflow falls to `0.289`, and RMS
force/moment fall to `445/4597` from the isolated `0.50` run's `535/5416`.

The comparison isolates why the positive result should supersede the prefill.
Changing phase-headroom boost from `0.35` to `0.50` without cross-track
feedback improves closest approach only to `2.13L` and still exits high;
replacing bearing by lateral offset only inside `3L` improves closest approach
to `1.89L` but also exits high. The successful additive term acts while the
body-frame lateral miss is still large, without attenuating the bearing drive
or the upstream propulsion anchor. Inherited logs independently close further
phase-headroom increases, receding and fore-aft gates, bearing-rate feedback,
lateral-velocity/slip damping, yaw-moment rejection, and posterior clipping.

## Single candidate hypothesis

Use the sampled successful controller unchanged as the one candidate: preserve
the `0.90`-period propulsion gait, `11 deg` static posterior request,
`0.70/0.35` body-rate feedback, `0.50` opposing-phase headroom allocation, and
the additive `0.18` body-frame cross-track term normalized by `2L`. This is the
only available combination that both changes lateral route topology and
reaches the target. It is bounded, target-relative, and coordinate-free, and
it neither reconstructs prescribed inflow nor uses elapsed time, a learned
route, remote wake probes, or target-station flow.

The evaluation supports this candidate if it reproduces target capture while
retaining diagonal self-propulsion and avoids the upper-domain hook. Because
the sampled run still reaches the posterior angle limit and both joint
rate/command limits, it is an arrival anchor rather than evidence that
saturation is solved. A later worker may test desaturation only against this
successful route and only if capture is preserved. If the candidate instead
returns to the upper exit or misses the `0.75L` circle, treat the single sampled
capture as phase-fragile and test cross-track robustness directly; do not stack
one of the already falsified recovery, velocity, load, or clipping overlays.
