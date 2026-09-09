# Candidate diagnosis and hypothesis

All four sampled diagnostics confirm direct uniform still-water initialization
with `U_infinity=(0,0,0)` and no cylinders or prewarm.  The combined sheets
show that the fish is self-propelled: an alternating reverse-street-like
mid-plane wake and paired three-dimensional Lambda2 structures grow behind the
body as it translates.  There is no background advection to explain the
motion.  Both capture examples retain that traveling wake through arrival.  In
contrast, the two rate-cascade failures also retain a substantial coherent
wake, but their top-down trajectories pass below the target, reach only
`3.0031L` and `3.1135L`, and continue to the lower/left virtual boundary.  The
failure is therefore steering realization, not absent propulsion or terminal
carrier collapse.

The strongest sampled finite policy is the intercept-guarded speed-reserve
controller: it captures at `0.7480L` in `18.205T`, compared with `0.7493L` in
`18.606T` for the LOS-guarded controller.  At `16T--18T` its head is visibly
higher on the target side while the top-down and oblique wake remains coherent.
The improvement is not a general effort reduction: over the whole trace its
actions clamp on about `68.6%/71.0%` of rows, and within `4L` on about
`71.6%/74.6%`, only about one percentage point below the LOS capture.  It also
contacts the `260 deg/T` speed limit on roughly `10.6%/10.7%` of terminal rows.
Thus the useful signal is directional actuator occupancy within the beat, not
a reason for another scalar reduction in carrier frequency, amplitude, or
steering gain.

Policy hypothesis: retain the sampled capture controller byte-for-byte in its
geometry, intercept veto, carrier, and outward-only speed relief, then add a
bounded directional-reserve allocator for the existing additive steering
residual.  At each call, compare the signed carrier command with the requested
turn direction.  Preserve the total nominal steering share, but smoothly move
it away from a joint whose carrier already occupies the requested acceleration
direction and toward the joint with usable directional headroom.  A nonzero
allocation floor prevents either joint from becoming a switched-off carrier.
This should make more of the already-commanded steering survive the final
clamp while preserving the evidenced traveling bend; it does not add route
gain or suppress propulsion.

bookshelf_consulted: true
source_domain: slender-fish reactive propulsion and sensor-modulated robotic-fish turning
source_mechanism: anterior bending sustains and steers the body wave while lagged posterior motion remains the main reactive-thrust contributor
transferable_invariant: preserve the traveling bend and posterior emphasis while realizing a bounded target-driven steering residual through the actuator that currently has directional authority
nontransferable_details: published gains, continuum body envelopes, species-specific joint kinematics, dimensional cadence, exact vortex phase, and prescribed routes
policy_translation: use normalized body-frame target and velocity geometry for the existing turn request, then redistribute only its two-joint additive steering shares using current carrier commands normalized by the acceleration envelope
falsification: reject if capture becomes a near miss or boundary exit, the alternating terminal wake weakens, total clamp or speed-limit contact rises materially, steering chatters between joints, or force and yaw-moment loads exceed the sampled captures

## Dry policy replay boundary

A one-call counterfactual replay over the sampled speed-reserve capture trace
(not a coupled CFD evaluation) confirms that the terminal gate leaves every
row at `distance_L >= 4` identical to the captured parent.  It changes the
returned action on 243 of 3310 rows, conserves the nominal steering-share sum
at every call, and shifts predicted clamp incidence only from about
`69.09%/71.48%` to `69.06%/71.36%`.  This is a scope and arithmetic check, not
evidence that the new trajectory will capture; the next formal rollout must
decide whether the small amount of recovered directional authority is useful.
