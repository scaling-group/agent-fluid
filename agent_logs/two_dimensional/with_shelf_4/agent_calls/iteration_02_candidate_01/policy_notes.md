# Multi-wake target-policy candidate

## Evidence diagnosis recorded before the policy edit

The assigned parent guidance correctly identifies the common seed's first
missing capability: a target-blind traveling bend produced some upstream
motion, but saturated both joint-speed and acceleration limits, displaced the
head `13.300L` laterally, and left the domain after `50.127` released units.
The shared prewarm keyframes show that every candidate begins above and to the
right of the same developed four-cylinder wake; the target is inside the
interacting second-row streets, so remaining near the release boundary is not
useful wake exploitation.

The completed first-generation comparisons sharpen the parent's lesson.  The
simple bearing-to-static-curvature policies with `16`, `10`, and `8` degree
limits all moved about `2.18--2.22L` in positive x, never entered the wake, and
left the domain after only `16.63--19.87` released units.  Their different
effort levels (`2.44`, `64.44`, and `277.51` mean command energy) did not change
that failure topology, so another scalar gain choice within the same static
bias architecture is poorly supported.  In contrast, the normalized
phase-plane oscillator with bounded bearing and bearing-rate curvature
completed the full `300`-unit horizon, improved progress to `0.156`, reduced
RMS yaw moment from the seed's `541.7` to `271.0`, and stayed below the joint
speed and acceleration caps.  Its released keyframes nevertheless show
repeated tight loops outside the organized wake: upstream head displacement
was only `1.187L`, closest distance remained `10.276L`, and no capture or wake
entry occurred.  This is evidence that realizable oscillation plus damped
target feedback improved the termination class, but persistent static
curvature did not preserve enough targetward propulsion.

## Policy hypothesis

Retain the finite phase-plane traveling-bend scaffold from the sole
horizon-completing result, but replace its static mean-curvature offset with a
body-frame target-driven half-cycle amplitude asymmetry.  Positive target
bearing strengthens the positive-bend half-cycle and weakens its opposite;
the inherited sign audit says positive bend produces the required negative-yaw
response.  Bearing-window rate damps the request as the target direction
converges.  This preserves a zero-centered alternating wave and posterior lag
instead of holding the fish in the continuously curved shape visible during
the looping rollout.

The next CFD evaluation should retain horizon-scale stability while producing
substantially more negative-x displacement, a non-looping approach toward the
green target, and a closest distance below `10.276L`.  Falsify the mechanism if
it restores an early domain exit, turns with the wrong sign, keeps the same
closed-loop trajectory, loses the alternating wake, or reaches the joint caps.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop direction tracking with asymmetric flapping or duty-ratio modulation
source_mechanism: sensor-driven half-cycle amplitude asymmetry layered on a propulsive rhythm
transferable_invariant: persistent body-frame direction error can strengthen the bend half-cycle that produces the requested yaw while preserving alternating posterior-lagged propulsion
nontransferable_details: published gains, linkage geometry, clock-driven CPG phase, dimensional beat settings, species kinematics, exact vortex phases, and task-specific routes
policy_translation: map bounded body-frame bearing plus bearing-window-rate damping to a smooth state-phase amplitude asymmetry in joint 1, then propagate the asymmetric wave through the existing lagged joint-2 target
falsification: reject if targetward upstream progress and survival do not improve together, or if wrong-sign turning, the same looping topology, thrust loss, load growth, or actuator saturation appears

## Pre-evaluation audit

A joint-only numerical integration of the final feedback law (not CFD and not
new rollout evidence) used the configured `8/-8` degree initial pose and
constant representative bearings from `-0.5` to `0.5` radians.  The resulting
steady extrema stayed within about `22` degrees, `154` degrees/time, and `1168`
degrees/time-squared across both joints, below the formal `45/260/1800`
envelope.  Positive and negative bearings produced corresponding same-sign
mean bends in both joints, while zero bearing retained an approximately
symmetric wave.  This verifies only bounded command realization and the
intended controller symmetry; hydrodynamic turn sign, propulsion, and target
approach remain falsifiable in the next evaluator rollout.
