# Multi-wake candidate visual diagnosis and hypothesis

## Evidence diagnosis before the policy edit

The shared prewarm sheet is common initial-condition evidence: the held fish
starts above and downstream of four developed, interacting wakes while the
target lies in the second-row corridor. In all released sheets the fish is
self-propelled rather than passively advected. For the sampled `0.50`
opposing-posterior-headroom policy, mean head velocity x is `-0.174` while
mean local flow x is `-0.123`; the head travels `-12.28L` upstream. Visually
the fish enters the disturbed wake, descends toward the target, passes its
streamwise neighborhood on the upper side, then makes a sharp upward hook and
leaves the domain. This agrees with the `2.13L` minimum distance, about
`+1.78L` terminal head-y displacement, and `left_domain` rather than collision
or numerical-instability termination.

The isolated phase-headroom sweep is now a bounded approach result, not an
open steering knob. Raising the coefficient from `0.35` to `0.50` improves
head-x travel and closest approach from `-11.33L/3.03L` to
`-12.28L/2.13L`, but keeps the upper hook and raises RMS force/moment from
`511/5305` to `535/5416`. The inherited global `0.55` branch collapses to
`-3.89L` travel, `5.70L` closest approach, `0.206` progress, and RMS moment
`5969`. The newly sampled close-only continuation toward `0.55` also fails:
it regresses closest approach to `2.21L`, retains the same upper exit, and
raises RMS force/moment to `566/5660`, despite slightly more upstream travel.
Thus no further phase-headroom increase survives the evidence. Prior
bearing-rate, receding, fore-aft, lateral-velocity, yaw-moment, and desired
posterior-clipping overlays likewise lose approach or propulsion without
changing the terminal route.

## Single candidate hypothesis

Restore the complete sampled `0.50` phase-headroom controller and remove the
failed close-only continuation. Add one bounded body-frame cross-track term to
the steering command: a small gain times
`tanh(state.target_body_L[2] / scale)`. The current bearing term measures an
angle and is initially modest even though the target remains almost two body
lengths to the side; it becomes most aggressive near a streamwise pass. The
new normalized lateral component instead asks for earlier correction while
the cross-track miss is large and smoothly vanishes as lateral alignment is
achieved. It does not use bearing rate, body velocity, global coordinates,
elapsed time, prescribed flow, or a fixed route. Steering remains posterior
only and every propulsion, steering, scale, and limit parameter is policy
owned.

Support requires entry below the `2.13L` closest-approach anchor, a material
reduction of the upper-side pass/hook, or capture while retaining approximately
the `-12.28L` upstream leg. Falsify the term if it merely increases loads or
early curvature, repeats the upper exit without an approach gain, or collapses
upstream propulsion. In that event later workers should remove cross-track
augmentation and return to the isolated `0.50` anchor before testing another
observation.
