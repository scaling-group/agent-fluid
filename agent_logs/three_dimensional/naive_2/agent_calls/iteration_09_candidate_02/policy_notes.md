# Candidate wake-policy diagnosis

## Evidence read before the edit

All four sampled rollouts satisfy the released contract: direct uniform
initialization, `U_infinity=(0,0,0)`, no cylinders or prewarm, finite dynamics,
and `left_domain` termination. In both rows of the combined sheets, the fish
self-propels rather than drifting. The top-down views show a strong alternating
mid-plane street, while the oblique views show tail-connected three-dimensional
Lambda2 structures from roughly `4T` through exit. The wake stays organized as
each path bends above the target, so the shared failure is planar route response
rather than propulsion or numerical instability.

The unrelieved `3 deg` course-redistribution sample reaches `4.419L` and then
recedes to `6.383L` at its `23.260T` upper exit. Distance-only anterior
amplitude relief worsens the minimum to `5.126L`, and distance-times-course
damping worsens it further to `6.397L` while exiting earliest at `16.830T`.
Their shorter top-down and oblique wake paths agree with the scalar evidence:
lowering carrier energy did not rotate the route toward the target.

The assigned parent's completed closure-conditioned posterior-wave relief is
also negative for capture. It reaches `4.162L` and repeats the upper exit at
`6.363L`, instead of preserving the inherited full-wave `4 deg` carrier's
`3.161L` approach. Reconstructing the sampled trajectory at closest approach
gives bearing about `-0.969 rad`, target-to-velocity course error `-1.257 rad`,
speed about `0.824U`, and still-positive radial closure about `0.254U`. The
posterior wave scale nevertheless averages only about `0.887` inside `5L`
because the per-step closure signal later alternates with the beat. Although
the final distance is smaller than the unrelieved parent's reported `8.569L`,
the inherited hypothesis that closure-gated relief would retain the strong
inbound path is falsified. Together, the current samples do not support another
distance, damping, or closure scalar around either joint.

## Single candidate hypothesis

Restore the full-amplitude `4 deg` course-redistribution carrier: retain the
joint-state Van der Pol oscillator, complete posterior wave, body-frame bearing
and relative-crossflow route feedback, centerline course brake, recent-yaw
feedback, bounded posterior mean curvature, and smooth action envelope. Add one
different steering actuator: bounded maneuver-dependent posterior phase-lag
modulation.

Use the magnitude of the speed-gated body-frame target-to-velocity course error
as an even maneuver-intensity signal. Rotate the existing `(q1, qd1/omega)`
coefficients by at most `18 deg`, reducing the posterior lag as course
misalignment grows while preserving the wave's exact state-space amplitude.
The rotation is even in lateral reflection; the signed posterior mean remains
the sole turn-direction command. Thus the policy does not install a static
anterior bend, attenuate either half-cycle, or shed propulsion near the target.
An algebraic replay on the sampled full-wave `3 deg` trace gives a mean phase
change of about `5.3 deg` while at least `8L` away and `16.5 deg` inside `5L`,
with a bounded maximum of `17.3 deg`; this checks localization and boundedness,
not hydrodynamic improvement.

The expected semantic change is faster conversion of the already saturated
course request into yaw before the fish passes several body lengths above the
target, while retaining the strong alternating wake and leftward transit.
Falsify the mechanism if closest approach does not match or beat the inherited
`3.161L`, the same receding upper exit persists without a better trajectory,
the posterior wave loses coherence or thrust, or joint saturation and peak
loads materially exceed the inherited references near `0.0337` force and
`0.0175` moment coefficient.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG modulation and traveling-wave swimming control
source_mechanism: sensor-dependent modulation of inter-joint phase changes maneuver response while retaining a rhythmic propulsive amplitude
transferable_invariant: when a coherent full-amplitude carrier has the correct signed route request but responds too slowly, change posterior wave timing from bounded maneuver intensity while preserving the carrier and a separate signed steering mean
nontransferable_details: published phase offsets, gains, dimensional frequencies, robot or species kinematics, exact vortex phases, source-task routes, and capture distances
policy_translation: derive an even maneuver gate from normalized body-frame target-to-velocity course error and use it to rotate the joint-state posterior-wave coefficients; keep turn direction in the odd bearing, crossflow, course, and yaw posterior mean
falsification: reject if the 3.161L inbound approach is not retained, yaw and course do not redirect before recession, the upper-exit topology persists, or propulsion, wake coherence, actuator residence, force, or moment worsens materially
