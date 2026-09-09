# Wake-policy candidate notes

## Evidence diagnosis

All four sampled evaluations report direct uniform quiescent initialization,
so the observed translation is self-propulsion rather than imposed advection.
The top-down and oblique rows show a persistent, alternating three-dimensional
wake behind every policy; preserving the joint-state oscillator and posterior
lag is therefore preferable to replacing the gait.

Route control is the limiting mechanism.  The compact parent
`solver_b6bb94d9cdaf` has the best score (`-7.64`) and mean distance (`6.50L`),
but crosses from the initial `+0.155 rad` body bearing to sustained negative
bearing, reaches only `5.357L`, and exits the upper boundary at `21.79T`.  Its
top-down row visibly climbs away from the target while its oblique row retains
a coherent wake.  The response-release variant `solver_59bc4ebdddec` has the
same upper-exit topology earlier (`14.65T`, `7.531L` minimum), so releasing a
same-sign curvature command from bearing rate does not cure the actuator-map
error.  The inherited 2D-sign policy `solver_e699ec5c28f1` instead turns toward
the lower boundary and reverses progress after `6.180L`.  The explicitly
3D-sign-corrected complex policy `solver_e450df1efa49` changes the failure to a
left exit and improves closest approach to `4.128L`, although it passes the
target corridor and commands above `30 rad/T^2` on about 97% of logged steps.

The compact parent's anterior term requests `turn_command`, but its posterior
mean tangent uses the opposite sign.  The candidate will make those two
steering contributions agree by changing only the posterior curvature map.
It retains body-frame bearing, observed recent turn rate, joint-state phase,
the posterior lag, and the existing smooth controller-owned acceleration
bound.  This isolates a semantic actuator-sign correction rather than another
scalar-gain probe.

## Policy hypothesis

For positive body bearing, the bounded request is negative.  Applying that
same negative request to both the anterior steering acceleration and posterior
mean tangent should produce the empirically indicated opposite-signed
cycle-mean heading response, reduce the early bearing crossing/upper drift,
and preserve the compact parent's thrust-producing wake.  Reject the change
if it reproduces the lower exit of the inherited 2D sign, fails to beat the
parent's `5.357L` closest approach or `left_domain` trajectory quality, loses
wake coherence, or increases joint/acceleration-limit residence.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG turning and fish mean-curvature turning
source_mechanism: sensor-driven bounded mean-curvature bias layered on a propulsive rhythm
transferable_invariant: preserve the traveling wave while a persistent body-frame direction error adds a bounded average bend with empirically calibrated actuator sign
nontransferable_details: published gains, duty ratios, clock phase, species-specific amplitudes, exact routes, and task-specific vortex phases
policy_translation: keep joint angle and velocity as oscillator phase; map normalized bearing plus observed recent turn rate to one bounded request shared by anterior acceleration and the posterior mean-tangent target
falsification: reject if closest approach and exit topology do not improve, the coherent alternating wake collapses, or action and joint-limit residence increase
