# Closing-speed interception-hold candidate

## Evidence and visual diagnosis before editing

All sampled and inherited evaluations used direct-uniform still water with
`U_infinity=(0,0,0)`, no cylinders, and no prewarm. In both rows of the
combined sheets, the fish translates behind a body-connected alternating
vorticity street and compact three-dimensional Lambda2 structures. The wake is
self-generated and propulsive; passive advection is not the failure mechanism.
The sampled policies all continue left while passing high of the target and
then curl after the useful pass. The prefilled posterior-bend release reaches
only `3.312L`, raises peak normalized planar force/moment to `0.890/0.414`,
and occupies a joint-rate limit for about `9%` of logged joint samples.

The inherited trajectories identify a much better starting mechanism than the
prefill. Course-residual steering changes the approach topology, reaches
`1.276L`, and keeps the alternating wake, but passes below the target at
`0.983L/T`. A smooth target-bearing mean-curvature handoff improves the pass to
`1.033L` with zero dwell above `40 deg` and peak normalized planar
force/moment of only `0.034/0.017`. It still misses: at the closest logged
point (`16.516T`) its head is `(9.481,8.586)L`, velocity is
`(-0.732,-0.777)L/T`, and speed is `1.067L/T`; the target lies up-left while
the body keeps translating down-left. The head has already rotated toward an
up-left heading, so the remaining `0.283L` capture deficit is consistent with
excess closing momentum and delayed course response, not absent steering
sign or insufficient far-field propulsion.

## Single candidate hypothesis

Replace the weaker prefill with the evidenced course-residual carrier and
terminal mean-curvature handoff. Add one compatible terminal mechanism: a
continuous interception hold recruited only by the product of normalized
proximity, positive body-frame radial closing speed, and target/course
misalignment. The hold blends the propulsive traveling-bend acceleration
toward a slower damped posture centered on the existing target-signed mean
curvature; it also fades phase-sensitive half-cycle steering in the same
proportion. Thus far-field course steering remains unchanged, an aligned
approach retains propulsion, and a near predicted miss sheds drive without
discarding directional authority or using time, route, or world coordinates.

Support requires capture, or at minimum a closest approach below `1.033L`
with a target-side recovery or better termination while preserving the
far-field wake, translation, zero `40 deg` dwell, and low loads. Falsify if
the hold coasts before the capture region, loses the course-residual approach,
repeats the lower-left escape without a closer pass, or increases joint/load
occupancy without capture.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and target-directed mean-curvature turning
source_mechanism: retain a rhythmic carrier for translation, then use measured approach state to hand authority to a bounded damped turning posture
transferable_invariant: separate far-field propulsive rhythm from a continuously gated near-target hold, and recruit the hold only when closing motion is geometrically misaligned
nontransferable_details: published gains, clock phase, robot linkage geometry, species kinematics, dimensional frequency, exact vortex phase, and task-specific routes
policy_translation: combine normalized body-frame target and velocity with distance to blend the two-joint course-residual carrier toward a damped target-bearing mean-curvature hold
falsification: reject if closest approach does not beat 1.033L or if capture/termination, far-field wake, translation, joint reserve, and loads do not improve together

## Dry validation only

A `77,760`-state grid spanning joint angles/rates, fore/aft and lateral target
geometry, velocity, and distance produced finite commands strictly inside the
smooth `30 rad/T^2` envelope and exact left/right reflection (maximum error
`0.0`). Against the inherited terminal-mean controller, action difference was
`5.0e-15` in a far-field probe and exactly zero for a near aligned closing
probe, while a near off-course closing probe changed action norm by `1.375`.
The schema, policy contract, guidance materiality, and editable boundary checks
passed separately. These are algebraic checks, not CFD evidence; formal
evaluation after this worker exits must decide the physical falsifiers above.
