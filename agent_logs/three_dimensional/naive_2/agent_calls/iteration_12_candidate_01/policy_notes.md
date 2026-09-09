# Course-response burst candidate

## Evidence and visual diagnosis before editing

All four sampled rollouts satisfy the direct-uniform still-water contract:
`U_infinity=(0,0,0)`, no cylinders, and no prewarm.  In both rows of every
combined keyframe sheet, the fish translates behind a body-connected
alternating vorticity street and compact three-dimensional Lambda2 structures.
The wake remains coherent through the useful approach, so passive advection,
missing thrust, and numerical instability are not the common failures.

The sampled terminal mechanisms all leave through the upper virtual boundary
at `y=15.20L`.  Continuous approach hold reaches `2.703L` but spends
`22.7%/35.4%` of logged samples with the head/tail joints beyond `40 deg`.
Mean-bend release reaches `2.664L` with `24.2%` posterior angle dwell, while
the prefilled posterior-bend release reduces that dwell to `4.0%` but regresses
to `3.312L` and raises peak normalized planar force/moment from `0.488/0.220`
to `0.890/0.414`.  The best scalar sample finishes at `5.706L`, but never gets
closer than `4.650L`; its quieter final score is not better interception.  The
top-down late arcs and oblique body/wake orientations agree with the trajectory
metrics: propulsion persists while steering becomes useful only after the fish
has crossed high of the target.

The assigned-parent history contains a stronger signal than any sampled
full-circle variant.  Rotation-invariant target-versus-velocity course
feedback changed the route and reached `1.276L`; a closing-speed hold then
reached `1.00784L` with zero `>40 deg` dwell and low `0.028/0.018` peak
force/moment, but still crossed at `1.011L/T` and escaped left.  Reversing only
the terminal common-curvature sign in the next completed iteration did not
validate the quiet-posture sign inference: closest approach worsened to
`1.106L`, capture still failed, and termination remained `left_domain`, even
though final distance improved from `9.228L` to `8.686L`.  Another persistent
terminal posture or scalar-only drive hold is therefore not supported.

## Single candidate hypothesis

Preserve the sampled traveling-bend carrier, posterior lag, phase-separated
yaw response, and shared-joint half-cycle actuator.  Replace the prefilled
distance/bend release with one response-gated interception mechanism.  Once
body-frame speed is established, form the signed angle from velocity to the
target vector; because both are expressed in the same body frame, this course
error is invariant to the carrier's instantaneous yaw.  Blend from pursuit
bearing to course error only in the evidenced approach region.  Increase the
bounded half-cycle authority when the course miss is large and the
carrier-separated yaw has the wrong sign, then release it continuously as soon
as yaw becomes corrective.  Keep the complete traveling carrier active so the
opposed restoring half-cycle is never removed.

Support requires capture or a closest pass below `1.00784L` with a better
termination/recovery while retaining the coherent far-field wake and avoiding
the sampled angle/load growth.  Falsify if the course handoff loses targetward
translation, if wrong-side yaw is not released, if the same upper/left escape
persists without a closer pass, or if joint-limit occupancy and normalized
loads materially exceed the mean-bend sample.

bookshelf_consulted: true
source_domain: biological C-start redirect and sensor-modulated robotic-fish CPG direction tracking
source_mechanism: recruit a bounded asymmetric burst for a large observed direction error and release it when the measured heading response becomes corrective
transferable_invariant: preserve the rhythmic propulsive scaffold, gate redirect authority by persistent target/course geometry and response rather than time or accumulated bend, and restore cruise as soon as the response is correct
nontransferable_details: species-specific C-start curvature, maneuver duration, published CPG gains, robot linkage geometry, dimensional frequency, exact vortex phase, and task-specific routes
policy_translation: use normalized body-frame target and velocity to form course error, remove joint-rate-correlated yaw, and gate shared two-joint half-cycle authority by near-target wrong-side yaw while leaving the state-feedback carrier active
falsification: reject if capture/closest pass and termination do not improve together without loss of far-field translation, wake coherence, joint reserve, or load quality

## Dry validation only

The mandated independent checker passed guidance materiality, the Julia policy
contract and parameter-schema guard, and the editable boundary check.  A
`43,740`-state grid spanning joint state, fore/aft and lateral target geometry,
body velocity, and yaw response produced finite commands strictly inside the
smooth `30 rad/T^2` envelope with exact left/right reflection (maximum error
`0.0`).  At a near `+pi/4` course miss, changing only carrier-separated yaw
from wrong-side `+0.5` to corrective `-0.5 rad/T` changed the command by
`2.426 rad/T^2`, confirming that response release is semantically active.
These are algebraic checks, not CFD evidence; downstream evaluation must decide
the capture, trajectory, wake, joint, and load falsifiers above.
