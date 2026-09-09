# Wake-policy candidate diagnosis and hypothesis

## Evidence read before the edit

All four sampled evaluations satisfy this lane's evidence contract: direct
uniform `U_infinity=[0,0,0]` initialization, no prewarm, no cylinders, finite
dynamics, and `left_domain` termination.  I inspected both rows of every
combined keyframe sheet.  The top-down sheets show alternating red/blue
vorticity behind the moving fish, and the oblique sheets show three-dimensional
Lambda2 structures shed from the body and caudal fan.  These are self-propelled
wakes rather than advection artifacts: the background is quiescent, sampled
local-flow magnitudes remain below `0.030U`, and the policies displace the fish
between `1.84L` and `18.81L` while finite force and moment histories accompany
the motion.

The current response-gated posterior-only prefill is not an incumbent to
preserve.  It reaches only `11.7887L`, crosses bearing zero nine times during
beat-scale yaw reversals, and exits the upper boundary at `9.311T`.  The
posterior-only parent similarly preserves a coherent wake and improves
monotonically to `11.0960L`, but it reverses too late after bearing alignment
and exits high.  The shared head/tail slip-aware candidate makes a broad turn
in the opposite direction, reaches `8.1745L`, and then exits low; this confirms
that joint allocation and sign, rather than more carrier gain, determine the
route topology.

The differential turn-rate servo is the strongest sampled mechanism.  Its
compact axial top-down street and persistent oblique wake agree with a maximum
speed of `0.7485U` and `18.81L` net displacement.  It reduces distance from
`12.3277L` to `4.9765L` at `21.934T` and survives to `33.209T`.  It does not,
however, redirect toward the target's lateral coordinate: after about `8T`,
body-frame bearing remains predominantly negative (down to `-1.52 rad`) while
the center travels almost straight near world `y=14--15L`, passes the target in
`x`, and exits at `(2.23,15.20)L`.  At closest approach the target is still
about `5L` lateral to the route.

The cause suggested by the state trace is architectural.  Beat-scale recent
turn rate spans about `[-2.64,2.49] rad/T`, whereas the servo's target turn rate
is capped at `0.50 rad/T`.  Consequently the measured oscillatory yaw dominates
the error and reverses the differential bend request each half-cycle even when
bearing keeps one persistent sign.  The result is strong propulsion with weak
mean route curvature, plus velocity-limit contact on roughly `17%/19%` and raw
over-envelope acceleration requests on `71%/78%` of samples.  Later workers
should not interpret the improved scalar score as evidence that a raw
beat-scale yaw-rate error is a suitable outer route loop.

## Policy hypothesis

Preserve the evidenced joint-state traveling bend and the differential
opposite-sign joint allocation.  Replace the yaw-rate-error servo with one
persistent route request from normalized body-frame lateral target fraction.
Recent turn response may only *release part* of a request while yaw is already
correcting it; it cannot reverse the request while the target remains on the
same side.  This translates a bounded burst-redirect invariant into the
two-joint contract: target geometry sets redirect sign, measured response
softens its magnitude, and the carrier remains active throughout.

The candidate should retain the long coherent propulsive wake while bending
the route from `y=14--15L` toward the target instead of passing about `5L`
above it.  Falsify it if persistent lateral error still yields a straight
boundary exit, if the route turns with the wrong sign, if static differential
curvature suppresses the alternating wake, if bearing chatters into alternating
route commands, or if saturation/load histories worsen.  Its CFD result is not
available to this worker and is not claimed here.

bookshelf_consulted: true
source_domain: biological burst-redirect turning and closed-loop robotic-fish CPG direction tracking
source_mechanism: target-signed bounded curvature with response-gated release into the propulsive rhythm
transferable_invariant: persistent body-frame lateral error owns redirect sign while measured correcting response can reduce but not invert the request
nontransferable_details: published gains, dimensional turn rates, clocked CPG phase, species-specific burst envelopes, exact vortex phase, and prescribed routes
policy_translation: normalize target lateral displacement by distance, map it to an opposite-sign anterior/posterior mean bend, and use bounded recent turn response only as a one-sided release gate around the joint-state oscillator
falsification: reject if the turn sign is wrong, the high-side straight pass persists, the coherent wake collapses, or actuator saturation and load histories worsen
