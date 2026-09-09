# Response-signed terminal-curvature candidate

## Evidence and visual diagnosis before editing

All sampled and inherited rollouts satisfy the direct-uniform still-water
contract (`U_infinity=(0,0,0)`, no cylinders, no prewarm).  In the combined
keyframe sheets, the top-down rows show sustained leftward self-propulsion
behind an alternating vorticity street, and the oblique rows show compact
body-connected Lambda2 structures.  The carrier creates a coherent
three-dimensional wake; passive advection or missing thrust is not the common
failure.

The sampled phase-compensated policies all cross the target region at about
`0.95--1.0L/T`, miss by `2.595--4.650L`, and then leave the left boundary.
The continuous approach hold reaches `2.703L` but leaves its joints beyond
`40 deg` for `22.7%/35.4%` of samples; the course-responsive and bend-release
variants reach `2.595L/2.664L` but retain substantial posterior angle dwell.
Their later visual arcs are therefore steering/translation failures, not wake
collapse.

The assigned parent's inherited sequence supplies the stronger terminal
comparison.  Course-residual steering changed the route and reached `1.276L`;
the closing-speed interception hold then reached `1.00784L`, eliminated
`>40 deg` dwell, and held peak normalized planar force/moment to about
`0.028/0.018`, but still exited left at `9.228L` final distance.  Its closest
logged state at `16.132T` is head `(9.756,8.834)L`, velocity
`(-0.737,-0.692)L/T`, speed `1.011L/T`, and mean joint bend `+7.6 deg`.
Body-frame reconstruction gives target bearing `+1.168 rad`, course error
`+1.475 rad`, and carrier-separated yaw residual `+0.201 rad/T`.  Positive
bearing here requires decreasing world heading, but the quiet positive common
bend instead sustains increasing heading; the top-down and oblique terminal
frames agree with the resulting nearly vertical lower-boundary escape.  The
hold did not shed translational momentum, and its target-to-curvature sign was
opposite to the measured terminal response.

## Single candidate hypothesis

Use the inherited course-residual traveling carrier and closing-speed-gated
hold because they provide the best evidenced approach, joint reserve, and load
quality.  Change one terminal actuator mapping: command common mean curvature
opposite to positive pursuit bearing, as required by the measured quiet-posture
yaw response.  Reflection symmetry implies the correction reverses on the
opposite target side.  Keep the far/middle course residual, hold gate, carrier,
and limits unchanged so the evaluation isolates this semantic feedback-sign
correction rather than another gain search.

Expected support is capture or a pass below `1.00784L` with target-side
recovery or a better termination class, while retaining the coherent cruise
wake, zero `40 deg` dwell, and low loads.  Falsify if the route loses the
inherited close approach, if terminal yaw still follows the wrong sign, if the
fish repeats the lower-left escape without a closer pass, or if joint/load
occupancy grows materially.

bookshelf_consulted: true
source_domain: robotic-fish mean-curvature turning and sensor-modulated CPG direction tracking
source_mechanism: target geometry biases a rhythmic carrier toward a bounded average bend, with measured response determining the feedback sign
transferable_invariant: preserve the propulsive rhythm outside capture approach and map persistent body-frame direction error to bounded reflection-equivariant curvature using the observed yaw response
nontransferable_details: published gains, clock phase, linkage geometry, species kinematics, dimensional frequencies, exact wake phase, and task-specific routes
policy_translation: retain normalized target-versus-velocity course steering and the closing/misalignment hold, but reverse only the terminal common-bend request because inherited quiet-posture evidence shows positive bend creates wrong-sign yaw for positive pursuit error
falsification: reject if capture or closest pass and termination do not improve together without loss of wake coherence, far-field translation, joint reserve, or load quality

## Dry validation only

An `8,748`-state grid spanning joint angles/rates, fore/aft and lateral target
geometry, and body velocity produced finite commands strictly inside the smooth
`30 rad/T^2` envelope with exact left/right reflection (maximum error `0.0`).
On the inherited closest-pass state, the evaluated hold returns
`(1.257,0.162) rad/T^2`, while the response-signed candidate returns the
bounded corrective reversal `(-20.733,-27.547) rad/T^2`.  This confirms that
the edit is semantically active and directionally reflected; it is not CFD
evidence, and the load/trajectory falsifiers above remain decisive.
