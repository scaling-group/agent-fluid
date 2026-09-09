# Candidate diagnosis and hypothesis

## Evidence diagnosis

- All four sampled evaluations satisfy the direct-uniform still-water contract
  (`U_infinity=[0,0,0]`), remain finite to the `100T` horizon, and show a
  coherent self-propelled wake in both the top-down vorticity and oblique
  Lambda2 rows. Their nearly coincident broad return loops therefore diagnose
  a control attractor, not advection, wake collapse, or numerical failure.
- The sampled response-lag, independent-posterior-energy, joint-state-unbend,
  and harmful-impulse-damping variants reach only `2.439`, `2.320`, `2.215`,
  and `2.294L`, with mean distance `3.861--3.877L` and final distance
  `3.310--3.471L`. At each closest sample speed remains about `0.677--0.681U`,
  yaw rate is only about `-0.253-- -0.266 rad/T`, both joint speeds are near
  zero, and the joints share a negative C-bend near `(-0.36,-0.38) rad`.
  Local flow remains small and wake-relative rather than an imposed inflow.
- The assigned parent and inherited score logs show that posterior roles,
  static bend changes, and one-sided pulses repeatedly preserve this broad
  orbit. The inherited symmetric anterior phase-balanced carrier is the useful
  exception (`1.175L` minimum and about `2.35T` inside `1.25L`), so the current
  independent posterior-energy edit must be removed rather than tuned.

## Policy hypothesis

Restore the evidenced symmetric anterior energy carrier exactly and add one
new role: a bounded anterior maneuver acceleration proportional to terminal
yaw-rate deficit. The desired yaw rate combines measured target-ray rotation
with a course-closing term; the acceleration is gated by body-frame
target-behind geometry, terminal distance, finite speed, and nonaligned course.
It acts even at zero joint velocity, unlike the failed quadratic half-cycle
pulse, and continuously releases when measured yaw reaches the request. This
should leave the first approach and traveling wave unchanged while supplying a
nonsteady counter to the tight tangential return. Reject the mechanism if it
changes the first return, recreates a parked bend, broadens the wake/orbit,
raises joint-limit residence materially, or fails to improve both closest
approach and terminal residence; capture is the decisive positive result.

bookshelf_consulted: true
source_domain: biological C-start or burst redirect and sensor-modulated robotic-fish CPG turning
source_mechanism: strong bounded curvature demand released when observed heading response appears, then return to the propulsive rhythm
transferable_invariant: separate a transient response-released turn maneuver from the persistent traveling-wave carrier
nontransferable_details: published gains, dimensional timing, species kinematics, prescribed CPG phase, exact vortex phase, and task-specific routes
policy_translation: use normalized body-frame target/course geometry and measured yaw rate to gate a bounded anterior acceleration inside the existing two-joint state-feedback carrier
falsification: reject if the first return changes, joint motion parks, the loop or wake broadens, load or limit residence rises, or closest approach and near-target residence do not improve
