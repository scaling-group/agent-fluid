# Candidate wake-policy diagnosis

## Evidence read before the edit

All four sampled diagnostics satisfy the released experiment contract:
`uniform_direct` initialization, zero background velocity, no prewarm snapshot,
and finite `left_domain` termination.  Their combined keyframe sheets show
self-propulsion rather than advection.  By about `4T` each top-down row has an
alternating mid-plane vortex street and each oblique row has tail-connected
three-dimensional Lambda2 loops.  The carrier remains coherent through exit,
but every visible path bends toward the upper boundary while the target stays
below and to the left.

The assigned parent added a centerline-gated course brake to the established
crossflow-assisted posterior mean.  Its completed rollout
(`solver_80d41cb1405d`) is the strongest sampled result: it improves the
inherited crossflow controller's `10.513L` minimum/final distance to
`9.880/9.880L`, lowers mean distance to `10.062L`, and extends the finite path
from `10.785T` to `11.594T`.  Thus the course brake is a positive mechanism to
preserve even though it does not change the upper-exit class.  Removing
crossflow (`solver_1c13be698c3a`) reaches only `11.303L`, while the
phase-conditioned yaw-residual variant (`solver_cf64f889c21c`) reaches
`11.165L` and exits earlier.

The prefilled gated anterior redirect (`solver_bff3d6a0f652`) is a concrete
negative comparison.  It reduces maximum joint speeds to `3.42/4.11 rad/T`
and tail near-soft-limit residence to `12.9%`, but reaches only `11.081L`,
recedes to `11.155L`, and exits at `10.324T`.  Its top-down sheet retains a
wake but shows less leftward advance; the oblique sheet likewise shows a
shorter wake path rather than a useful redirect.  Reduced effort did not
compensate for disturbing the anterior carrier.

The strongest trace isolates the remaining control defect.  At `8T`, bearing
is about `-0.666 rad`, course error `-0.341 rad`, and yaw rate
`-2.147 rad/T`; at `9T` the bearing remains about `-0.661 rad` while yaw has
reversed to `+2.395 rad/T`.  Yet geometry, crossflow, course, and yaw are added
before one `12 deg` saturation, so the posterior mean remains approximately
`-12 deg` at both phases.  The fast measured response therefore cannot release
the persistent route request.  Both joints touch the `4.54 rad/T` velocity
limit and the tail action lies above 95% of its soft acceleration bound for
`31.4%` of the run.  More curvature inside the same saturated sum is not a
distinct or supported remedy.

## Single candidate hypothesis

Return to the assigned parent's full zero-mean anterior oscillator, complete
lagged posterior wave, relative-crossflow residual, and centerline-gated
course brake.  Split posterior mean curvature into two physical channels:
a slowly varying bounded route term from bearing, crossflow, and course, and a
smaller independently bounded recoil term from recent yaw rate.  Soft-bound
their sum before adding it to the unchanged posterior wave.  This preserves
the route direction while allowing positive yaw to release a negative route
request and negative yaw to reinforce it, rather than losing both cases inside
one saturated turn state.

The expected semantic change is smaller beat-scale yaw reversal after the
target-line crossing, with the coherent full-amplitude wake and the parent's
leftward progress retained.  Falsify the mechanism if it does not beat the
`9.880L` minimum/final distance or improve the upper-exit topology, if the yaw
oscillation is not reduced or released when its sign becomes corrective, or
if velocity/acceleration saturation, force/moment peaks, or wake coherence
worsen materially.  The new CFD result is not available to this worker and is
not claimed here.

bookshelf_consulted: true
source_domain: wake-interaction control and closed-loop robotic-fish CPG modulation
source_mechanism: separate slow target-geometry steering from bounded fast yaw-disturbance rejection while retaining the propulsive rhythm
transferable_invariant: persistent route error and alternating measured yaw response require independently bounded feedback channels so fast corrective motion can release rather than disappear inside saturated route authority
nontransferable_details: published gains, dimensional frequencies, robot or species kinematics, cylinder phases, exact vortex timing, and task-specific routes
policy_translation: retain normalized body-frame bearing, relative crossflow, target-to-velocity course, and the joint-state traveling wave; map the first three to bounded posterior route curvature and recent yaw to a smaller separately bounded posterior recoil curvature
falsification: reject if the same upper exit recurs without beating 9.880L, corrective yaw still fails to release posterior curvature, the alternating 3D wake degrades, or actuator and hydrodynamic load excursions grow materially
