# Multi-wake candidate visual diagnosis and hypothesis

## Evidence diagnosis before the policy edit

The shared prewarm sheet establishes the common initial condition: the held
fish begins above and downstream of the target while the four developed,
interacting cylinder wakes fill the route. The four sampled released sheets
are byte-identical deterministic reproductions, not independent gain trials.
Their controller actively self-propels diagonally into the disturbed corridor,
makes a broad loop, and crosses the `0.75L` target circle after `88.13` release
units. The metrics corroborate the visual reading: head displacement is
`(-10.92,-4.44)L`, mean head velocity x is more upstream than mean local flow
x (`-0.124` versus `-0.092`), mean/minimum distance is `2.736/0.747L`, and RMS
relative crossflow and force/moment are `0.289` and `445/4597`. The posterior
angle and both joint rate/command limits are reached, so capture establishes a
navigation anchor but not actuator desaturation.

The assigned parent's isolated `cross_track_gain=0.20` failure is the most
informative visual contrast. It preserves active upstream motion and gets to
`1.123L`, but turns nearly vertical just short of capture and exits the upper
domain with head displacement `(-11.03,+1.78)L`, mean distance `6.365L`, and
RMS force/moment `490/4800`. The inherited lower-side `0.17` result also exits
upward, approaches only `3.267L`, and raises loads to `478/5138`. Thus the
sampled evidence brackets `0.18` as a narrow route-selecting value rather than
a monotone authority knob. Independently, lowering the command ceiling to
`1550` or raising it to `1700 deg/time^2` loses capture, so command authority
is also not a supported tuning axis.

The released success and `0.20` failure sheets expose a narrower structural
boundary. Both approach the target, but the failure turns away after entering
the existing `0.75--1.50L` band where one scalar fade suppresses bearing,
body-rate damping, and the body-frame cross-track request together. Bearing is
poorly conditioned near a pass, while the bounded lateral target offset still
shrinks geometrically toward zero and remains a direct capture-error signal.
No sampled result has isolated those two attenuation roles.

## Single candidate hypothesis

Preserve the exact reproduced `0.18`, `2L`, `0.50`, and `1650 deg/time^2`
controller outside the final fade band. Inside it, continue fading the bounded
combined bearing/body-rate command exactly as before, but restore only the
fraction of `0.18*tanh(target_body_L[2]/2L)` removed by that fade. The resulting
command is identical to the sampled success when distance is at least `1.5L`;
near capture, angular and yaw-rate terms vanish while the small normalized
cross-track residual tends to zero with lateral error. This adds no global
coordinate, route, elapsed-time, prescribed-flow, remote-probe, or
target-station signal and does not retune a bracketed gain.

Support requires repeat target capture with release time below `88.13`, mean
distance below `2.736L`, or visibly reduced terminal looping without a material
increase over `445/4597` RMS force/moment. Loss of capture, an upper exit,
greater saturation/load without a shorter route, or oscillation around the
circle falsifies residual cross-track authority in the fade band; later
workers should then restore the exact sampled fade rather than tuning the
already bracketed cross-track gain or command ceiling.
