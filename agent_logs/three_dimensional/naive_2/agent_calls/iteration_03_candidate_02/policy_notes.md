# Candidate wake-policy notes

## Visual and metric diagnosis before editing

All four sampled solver examples and the inherited `be67` rollout report the
required direct-uniform still-water initialization. Their combined keyframe
sheets show self-propelled fish with coherent alternating mid-plane wakes and
three-dimensional Lambda2 structures, not passive advection or wake collapse.
They also show the same broad failure topology: the path hooks upward and exits
the upper virtual boundary while the target remains far to the lower left.

The assigned prefill's relative-crossflow half-cycle controller exits at
`8.701T`, reaching only `11.949L` before ending at `12.181L`. The two other
sampled half-cycle variants reach `12.038L` and `11.989L`. The inherited
course-aware half-cycle test is also negative: despite explicitly using a
speed-gated target-versus-velocity angle, it exits at `8.690T`, with minimum
and final distances of `11.967L` and `12.226L`. Thus neither half-cycle gain
tuning nor the presence of a course signal alone explains useful steering.

The strongest sampled mechanism instead keeps the anterior oscillator
uncentered and puts a bounded mean tangent only in the posterior target. It
moves the center from `x=21.000L` to `19.253L`, reaches `11.512L` at about
`9.22T`, and retains the most developed coherent wake through its `9.823T`
exit. Its route response is still late: reconstructed bearing changes sign
repeatedly from roughly `3.4T` through `5.8T`; at `7T` bearing is about
`-0.22 rad` while body-frame lateral velocity is about `+0.32U`, and the fish
continues accumulating upper displacement. This separates a useful actuator
translation (posterior mean curvature) from a missing response cue (persistent
velocity-course error).

## Policy hypothesis

Use the strongest posterior-mean controller as the carrier and steering
baseline. Keep its joint-state Van der Pol oscillator, posterior lag, yaw-rate
damping, curvature bound, and smooth acceleration envelope. Add one bounded
course-response residual to the same posterior mean-tangent request. Compute
the target-versus-velocity angle entirely in the body frame and gate it by
forward swimming speed, so direction noise at release or during backward
motion cannot steer. The residual should reduce the prior bearing command when
the translational course has already swept past the target, and strengthen the
opposite correction before negative bearing and upper drift become persistent.

The candidate is falsified if it fails to improve on `11.512L`, repeats the
upper-boundary exit without delaying or changing the trajectory usefully,
quenches the alternating carrier, or increases persistent joint-limit or load
excursions. The course observation itself is not vindicated unless applying it
through the already useful posterior-mean actuator improves route response;
the inherited half-cycle result has already falsified that earlier translation.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG direction tracking and tail-beat-bias turning
source_mechanism: sensor feedback modulates a bounded mean tail bias around a posteriorly lagged rhythmic carrier
transferable_invariant: retain the thrust-producing rhythm while closing the steering loop on observed motion relative to the target, and ignore unreliable direction feedback near rest
nontransferable_details: published gains, clock phase, duty timing, robot or species kinematics, dimensional frequencies, exact vortex phases, and prescribed routes
policy_translation: combine normalized body-frame bearing, speed-gated target-versus-velocity course error, and measured yaw response into a bounded posterior mean-tangent target while leaving the anterior oscillator unchanged
falsification: reject if course and bearing do not converge before the prior upper exit, minimum distance does not beat 11.512L, propulsion collapses, or actuator and hydrodynamic loads become persistently larger
