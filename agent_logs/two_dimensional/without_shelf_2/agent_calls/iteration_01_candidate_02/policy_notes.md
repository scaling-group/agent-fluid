# Candidate Wake-Policy Notes

## Evidence and visual diagnosis

The assigned parent is the fresh-lineage guidance, and the only sampled solver
is the deliberately target-blind seed. No inherited optimizer rollout log is
present in this workspace, so the candidate is based on that parent, the
sampled score/observation/metrics/diagnostics, and the two canonical keyframe
sheets only.

The shared prewarm sheet shows the held fish above and well downstream of four
developed, asymmetric vortex streets; it is common initial-condition evidence,
not evidence for the seed controller. In the released sheet the fish begins
nearly pointed toward the target, then actively swims down-left while rapidly
rotating clockwise. It never enters the target-centered wake corridor. Its
track becomes nearly vertical, passes well to the target's right and below it,
and ends at the bottom boundary. The motion is self-propelled rather than
passive advection: the fish remains strongly bent and sheds its own alternating
vortices as the long downward displacement develops.

The numeric evidence supports that reading. The rollout terminates
`left_domain` after only `50.1269` of the `300` release horizon, with head
displacement `(-3.545, -13.300)L`, final/mean/minimum distance
`12.123/11.903/8.615L`, and progress only `0.0243`. Its mean velocity is
`(-0.0725, -0.2633)` while mean local flow is `(-0.0414, -0.2414)`, and the
relative-flow mean remains finite; it is therefore not a numerical blow-up or
collision. RMS lateral force/moment are `21.94/541.70`, command-energy mean is
`1496.25`, and both joints reach the configured acceleration and velocity caps
(`31.416 rad/time^2` and `4.538 rad/time`). The `0.55` control period also gives
a tailbeat/shedding ratio of `32.83`. Together these observations make the
seed's saturated, target-blind oscillator an unsafe steering anchor even though
it demonstrates ample propulsion.

## One candidate hypothesis

Preserve the useful state-feedback traveling bend, but slow it enough that its
nominal accelerations fit below the hard envelope. Add a bounded body-frame
target-bearing curvature bias with body-turn-rate damping. In this coordinate
system forward is body `-x`; a positive `state.bearing` places the target to the
fish's right, so it must request negative curvature, while the heading-rate term
must oppose an already excessive turn. Center the anterior oscillator around
that bias and make the posterior joint cancel only the oscillatory component,
leaving the bias as a low-frequency body bend rather than adding a global route
or clock.

The falsifiable expectation is that the fish will retain negative-x propulsion
but arrest the visible clockwise over-turn, remain in-domain well beyond
`50.1`, and convert the early minimum-distance improvement into sustained
closing. The mechanism is not established as successful until later CFD. It
should be rejected or retuned if the next rollout still saturates persistently,
turns with the opposite sign, loses forward propulsion, or fails to lower
distance while surviving longer.
