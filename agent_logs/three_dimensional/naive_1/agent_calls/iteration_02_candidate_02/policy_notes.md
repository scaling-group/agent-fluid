# Candidate diagnosis and hypothesis

## Evidence read before the edit

All four sampled rollouts report direct uniform quiescent initialization,
`U_infinity=[0,0,0]`, no cylinders, and finite `left_domain` termination.  The
combined sheets were inspected in both rows.  The top-down row shows that the
seed and the tail-only parent form alternating vorticity and translate under
their own actuation; the oblique row confirms coherent three-dimensional
Lambda2 structures trailing the physical caudal fan.  The motion is therefore
self-propelled rather than background advection.

The target-blind seed briefly improves from `12.3277L` to `12.0638L`, then its
heading sweeps from about `+0.60` to `-1.17 rad` and it exits the upper boundary
at `8.613T`.  The inherited tail-only mean-curvature parent preserves and
strengthens the visible wake and reaches `11.0960L`, but it also continues
upward into the same boundary at `10.026T`; its trajectory reaches about
`40.2 deg` at a joint, touches the velocity limit on `5.9%` of rows, and
requests acceleration beyond the envelope on `72.0%` of rows.  Its steering
channel has the correct measured sign but reverses too slowly after the target
bearing crosses zero.

The two anterior-bias examples identify the actuator-allocation hazard.  Equal
`+9 deg` head/tail offsets nearly suppress the traveling oscillation
(`max |phi_dot|=1.27 rad/T`), turn heading monotonically to `3.96 rad`, and
increase final distance to `15.3607L`.  The slip-aware `+8 deg` anterior bias
retains a strong wake and gives the most useful sampled trajectory, reaching
`8.1745L` and surviving `26.043T`, but its heading remains on the positive side
while reconstructed body-frame bearing grows from roughly `+0.13` toward
`+1.2 rad`; it passes below the target and exits the lower boundary.  Thus a
positive anterior offset has the opposite yaw effect from the parent's
positive posterior offset in this body, and using the same sign at both joints
creates positive bearing feedback rather than route regulation.

## Policy hypothesis

Keep the seed's state-feedback traveling bend.  Replace the single saturated
posterior offset with one bounded differential curvature request: positive
body-frame bearing commands a small negative anterior mean and a larger
positive posterior mean.  A bounded target turn-rate servo uses
`turn_rate_recent` to release or reverse that request as alignment is reached.
This is an architecture and actuator-allocation test, not a scalar-only gain
change.  It should retain posterior wake production, use the demonstrated
anterior yaw authority with the correcting sign, cross zero bearing without
the parent's prolonged upward sweep, and reduce posterior joint saturation.

Falsify the candidate if positive bearing again produces sustained positive
yaw, if it retains the parent's upper-boundary exit without a meaningfully
better distance record, if the differential bend suppresses the alternating
wake as in the equal-bias failure, or if joint saturation/load histories worsen.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG turning and biological burst-redirect control
source_mechanism: bounded target-driven curvature asymmetry with response-gated release
transferable_invariant: preserve the propulsive rhythm while steering through bounded bend asymmetry tied to persistent target error and measured turn response
nontransferable_details: published gains, clocked CPG phases, species-specific bend envelopes, exact vortex phases, and prescribed routes
policy_translation: map normalized body-frame bearing to a target turn rate, feed back normalized recent body turn rate, and distribute the bounded correction as opposite-sign anterior/posterior mean offsets around the two-joint state oscillator
falsification: reject if turn sign is wrong, zero-bearing crossing still causes a boundary sweep, wake coherence collapses, or saturation and load histories worsen
