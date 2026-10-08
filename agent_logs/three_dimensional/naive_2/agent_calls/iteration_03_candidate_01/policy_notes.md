# Phase 2 candidate diagnosis and hypothesis

## Evidence diagnosis before editing

All four sampled rollouts satisfy the direct-uniform quiescent initialization
contract, are finite, and terminate by leaving the upper virtual boundary; none
captures the target.  In the top-down rows, each fish moves under its own tail
actuation and sheds an alternating wake before hooking upward.  The oblique
Lambda2 rows confirm a coherent three-dimensional tail-connected vortex train,
not passive advection or a prewarm artifact.  The useful mechanism to preserve
is therefore the uncentered anterior oscillator and posterior traveling bend.

The assigned-parent half-cycle policy reaches only `12.038L` and finishes at
`12.314L` at `8.585T`.  The strongest sampled controller instead leaves the
anterior carrier untouched and applies bounded posterior mean curvature; it
moves the center left from `21.000L` to `19.253L`, improves minimum/final
distance to `11.512/11.518L`, and survives to `9.823T`.  Its top-down path and
trace nevertheless show why bearing plus yaw feedback is incomplete: bearing
crosses the body centerline during roughly `3.4--5.8T`, but lateral body speed
is already positive and reaches about `+0.32U` at `7T`.  At termination the
fish is still translating upward at `0.682U`; the body-frame target bearing is
about `-1.02 rad` and target-versus-velocity course sine about `-0.92`, so yaw
correction has begun too late to prevent the same exit.  The crossflow-assisted
half-cycle sample is weaker overall, but its `11.949L` minimum improves on the
otherwise similar assigned-parent half-cycle result and supports testing slip
feedback on the stronger posterior-mean-curvature actuator.

## Policy hypothesis

Preserve the naive anterior oscillator, posterior phase lag, posterior-only
mean-curvature steering, and smooth acceleration envelope.  Form the bounded
turn request from target bearing, measured yaw response, and one additional
normalized body-frame slip residual: head-local relative crossflow.  In this
still-water evidence, positive lateral translation away from the target gives
negative relative crossflow, which has the same sign as the corrective
posterior curvature after the bearing crossing.  This should reduce or reverse
upward course drift before geometry-only feedback accumulates a large error,
without recentering the anterior oscillator or prescribing a phase, route, or
world direction.

The first semantic test is retention of the alternating 3D wake and leftward
progress while avoiding the prior upper-boundary exit beyond `9.823T`.  Reject
the mechanism if minimum distance does not improve on `11.512L`, if relative
crossflow fails to shrink before `8T`, if the same exit topology remains, or if
joint-limit residence, acceleration saturation, or force/moment peaks become
dominant.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG direction tracking and asymmetric tail control
source_mechanism: sensor residual corrects translational slip while a posteriorly lagged rhythmic carrier supplies propulsion
transferable_invariant: preserve the propulsive traveling bend and use bounded target geometry plus observed lateral response to regulate signed mean turning
nontransferable_details: published gains, dimensional beat frequencies, robot or species kinematics, exact vortex phase, duty timing, and task-specific routes
policy_translation: add saturated head-local relative crossflow to bearing and yaw response, then map the odd bounded request only to the posterior mean-tangent target
falsification: reject if course drift and upper exit persist, target progress does not beat the posterior-bias sample, the alternating wake collapses, or actuator and hydrodynamic loads grow materially
