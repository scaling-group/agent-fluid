# Multi-wake candidate visual diagnosis and hypothesis

## Evidence diagnosis before the policy edit

The shared prewarm sheet is common initial-condition evidence: the held fish
starts above and downstream of the target while four developed, interacting
wakes fill the route. The released sheets show controlled self-propulsion, not
passive advection. In the sampled `0.50` phase-headroom failure the mean head
velocity is about `-0.174` while mean local flow is `-0.123`, and the head
travels `-12.28L`. Visually, however, that fish stays above the target as it
enters the wake, passes the target's streamwise neighborhood, then makes the
lineage's repeated upward hook and exits the upper domain. Its `2.13L` closest
approach, `+1.78L` head-y displacement, and `left_domain` termination agree
with the sheet.

The assigned parent's inherited close-only continuation from opposition boost
`0.50` toward `0.55` does not repair that topology: it worsens closest approach
to `2.21L`, retains the upward exit and about `+1.72L` head-y motion, and raises
RMS force/moment from `535/5416` to `566/5660`. The sampled near-target blend
from angular bearing to lateral offset is another informative negative result.
It reaches `1.89L`, but still travels `+1.79L` in y, hooks upward, and leaves the
domain with `568/5495` RMS load. A lateral representation introduced only
inside `3L` is therefore too late to select the useful route.

In contrast, the sampled policy that adds
`0.18*tanh(target_body_L[2]/2L)` to the far-field bearing command visibly turns
downward early, enters the disturbed corridor, and ultimately crosses the
target circle instead of repeating the upper exit. The metrics confirm this is
a useful route change rather than a dramatic vortex artifact: it terminates
`target_reached` after `88.13` release units, reaches `0.747L`, moves the head
`-10.92L/-4.44L`, and lowers RMS relative crossflow and force/moment to
`0.289` and `445/4597`. Its mean head velocity x (`-0.124`) remains more
upstream than its mean local flow x (`-0.092`), so the route preserves active
propulsion. The posterior angle and both rate/command caps are still reached;
capture validates navigation, not actuator desaturation.

## Single candidate hypothesis

Promote the sampled successful controller unchanged: retain the complete
`0.50` opposing-posterior-headroom gait and add the bounded body-frame
cross-track command with gain `0.18` and scale `2L`. This uses target-relative
geometry early enough to correct the large lateral miss without weakening the
demonstrated propulsion command. It introduces no elapsed time, global
coordinates, fixed route, prescribed inflow, remote wake probe, or new
candidate-specific mechanism.

Because the fixed snapshot and duplicate-policy evidence indicate deterministic
evaluation, support is reproduction of `target_reached` near the sampled
`88.13` release units while retaining upstream self-propulsion. A loss of
capture, materially larger load, or return of the upper exit would falsify
reproducibility and should send later workers back to the exact sampled policy
before tuning cross-track gain or scale. Later refinements may target the long
terminal loop or saturation, but only one axis at a time and only while capture
survives.
