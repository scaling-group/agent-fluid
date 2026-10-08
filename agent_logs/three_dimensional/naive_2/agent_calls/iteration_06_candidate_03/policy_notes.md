# Candidate wake-policy diagnosis

## Evidence read before the edit

All sampled and inherited diagnostics satisfy the released experiment contract:
direct uniform initialization, zero background velocity, no cylinders or
prewarm snapshot, and finite `left_domain` termination.  The combined sheets
show self-propulsion rather than advection.  Their top-down rows develop an
alternating mid-plane vortex street, and their oblique rows show tail-connected
three-dimensional Lambda2 structures.  The useful cases retain those structures
through many beats, so the remaining defect is target-route control rather than
wake collapse.

The prefilled posterior course brake (`solver_80d41cb1405d`) exits through the
upper boundary at `11.594T`, reaching `9.880L`; its wake is coherent, but the
path rises while the target remains below-left.  The assigned parent's separate
posterior yaw-recoil channel (`solver_9ffd27c690f3`) is a negative inherited
result: it exits earlier at `10.626T` and reaches only `10.738L`, so independently
bounding more posterior feedback does not resolve the topology.  The sampled
large-bearing `7 deg` anterior redirect (`solver_bff3d6a0f652`) is also negative:
it reaches only `11.081L`, reduces anterior peak speed from `4.54` to
`3.42 rad/T`, and leaves a shorter visible wake path.  That actuator both shifts
the head strongly and adds the shift to the endpoint curvature, disturbing the
carrier.

The two course-triggered curvature-redistribution samples are qualitatively
different and materially positive.  A `3 deg` centerline redistribution
(`solver_c0a67102cc0a`) reaches `4.419L`, survives to `23.260T`, and has the best
sampled score (`-8.008`); the `4 deg` variant (`solver_6d90d1984e81`) reaches
`3.161L` and survives to `27.572T`.  Both use the actual anterior angle in the
posterior target, keeping requested endpoint mean curvature unchanged, and both
retain long alternating top-down streets and three-dimensional tail-connected
structures.  The `4 deg` trace lowers the head to `y=12.619L` at closest
approach, compared with the target at `9.5L`, but then recedes to `8.569L` and
exits at `y=15.455L`.  From roughly `16T` onward, bearing magnitude is commonly
`0.75--1.49 rad` and target-to-velocity course error is near `-pi/2`; the
fourth-power centerline gate therefore removes almost all anterior redistribution
exactly when the target remains several body lengths laterally displaced.
Posterior action is already near its soft limit for `46.7%` of this rollout, so
adding more posterior curvature inside the existing saturated request is not a
supported recovery mechanism.

## Single candidate hypothesis

Use the closest-approach sample's full anterior oscillator, lagged posterior
wave, crossflow residual, course brake, smooth action bound, and `4 deg`
centerline curvature redistribution.  Add one continuous middle/near-approach
extension of the same redistribution primitive: as normalized head distance
falls, allow a smaller `2.25 deg` target-to-velocity course correction outside
the narrow bearing window.  Speed gating keeps it silent at release, course
alignment releases it without relying on beat-scale body yaw, and the distance
gate is negligible far from the target.  The posterior target continues to use
the actual anterior angle, so this moves curvature forward without increasing
the established tail-end mean request.

Replaying the sampled observations through this bounded gate requests at most
`3.79 deg` of anterior shift and `1.58 deg` RMS on the `4 deg` rollout, below the
failed redirect's inferred `6.60 deg` maximum and `2.51 deg` RMS.  The expected
semantic change is to retain the strong downward/leftward approach but keep a
small translational-course lever after bearing leaves the centerline window,
reducing the rise and recession after `3.161L`.  Falsify it if it does not improve
closest or final distance, if the upper-exit topology is not delayed or changed,
if anterior oscillation collapses toward `3.42 rad/T`, or if the alternating wake,
the current `46.7%` near-limit tail action, `0.0337` peak force coefficient, or
`0.0175` peak moment coefficient worsens materially.

bookshelf_consulted: true
source_domain: terminal target capture and closed-loop robotic-fish CPG direction tracking
source_mechanism: continuously shift authority from broad propulsive approach toward bounded course correction as target distance closes while preserving the rhythmic carrier
transferable_invariant: after broad target-directed motion works, a near-approach controller should retain a small correction driven by measured target-relative translation and release it when that course aligns
nontransferable_details: published gains, dimensional distances and frequencies, robot or species kinematics, exact vortex phases, task coordinates, and prescribed routes
policy_translation: use normalized head distance to open a smaller off-center course-error redistribution of the anterior equilibrium, retain forward-speed gating, and compensate the posterior target with the actual anterior angle so endpoint mean curvature is unchanged
falsification: reject if the 3.161L closest approach or 8.569L final distance is not improved, the same upper exit persists without delay, the anterior carrier slows materially, or action saturation, loads, and wake coherence degrade
