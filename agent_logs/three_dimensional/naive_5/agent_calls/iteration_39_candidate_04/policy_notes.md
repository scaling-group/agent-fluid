# Wake-policy candidate notes

## Evidence diagnosis

All four sampled rollouts satisfy the direct-uniform still-water contract and
capture with an organized, self-propelled wake.  In both visual rows, the fish
maintains an alternating vortex street through the long approach and turns
down into the target only in the terminal frames; there is no collision,
advection-only motion, disordered 3D wake, or supplied failure rollout.  The
assigned parent is therefore the informative weak comparator: its shallow
capture is `0.749956L` at `25.6080T`, with mean distance `2.461948L`.  The two
byte-identical anterior-duty samples capture at `0.748598L` and `25.5090T`,
with mean distance `2.457773L`.  The parent's nested posterior-duty,
instantaneous-slip, and force-commutated additions slightly lower peak planar
force/yaw moment (`0.02023/0.01043` versus `0.02063/0.01065`) but delay capture
by `0.099T` and worsen mean distance by `0.004175L`; this is not evidence for
retaining their course interpretation.

From `18--24T`, the assigned parent's target-normal course velocity has mean
`0.355U`, ranges from `0.038U` to `0.617U`, and correlates `-0.962` with
anterior joint rate.  Its least-squares cadence component is approximately
`-0.0564 qdot1`, equivalent to `-0.124U` times the normalized anterior rate
`qdot1/(omega*amplitude)`.  Thus instantaneous body-normal velocity and force
commutation are beat-phase sensors, not reliable persistent-slip estimates.
The reusable evidence still supports target geometry as route authority and
shows that posterior motion opposite the requested course side is the
reaction half-cycle worth testing.

## Policy hypothesis

Replace the parent's instantaneous-slip and force branches with one bounded
phase-qualified posterior reaction stroke.  Subtract the sampled linear
joint-rate cadence component from normalized target-normal velocity, require
the remaining course response to agree with the body-frame geometric route,
and extend only the posterior half-cycle moving opposite that route.  Keep the
evaluated carrier, redirect, target-line response, upstream duty/vectoring,
terminal lag modulation, common acceleration envelope, and joint viability
guards unchanged.  This should reduce middle-approach course error without
letting either instantaneous force or a cadence-aligned velocity sample choose
the route.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG and asymmetric-flapping control
source_mechanism: sensor-modulated duty-ratio asymmetry for turning while retaining a propulsive rhythm
transferable_invariant: route geometry should set turn side while joint-state phase confines extra authority to the hydrodynamically useful half-cycle
nontransferable_details: published gains, robot morphology, clock-driven CPG phase, species envelopes, exact vortex phases, and task-specific routes
policy_translation: use body-frame target/velocity geometry, regress out the sampled anterior-rate cadence component, and add a bounded posterior acceleration only while the tail moves opposite the required course side
falsification: reject if capture or coherent wake is lost, actuator contact returns, load exposure materially exceeds the sampled regime, or full middle-approach course response and capture margin do not improve

## Static verification

Against the sampled anterior-duty-only policy on the assigned parent's frozen
trace, the candidate changes `393/4656` command rows from `18.766T` through
`23.177T`.  No command changes outside the intended `1.75--4.5L` target-head
distance window, and the largest post-governor action delta is
`0.3279 rad/T^2`, well below the `30 rad/T^2` policy limit.  Mirroring every
frozen body-frame state negates both actions to numerical tolerance.  The
workspace guidance check, Julia policy-contract check, and editable-boundary
check all pass.  These are contract and scope checks only; they do not claim a
new CFD outcome.
