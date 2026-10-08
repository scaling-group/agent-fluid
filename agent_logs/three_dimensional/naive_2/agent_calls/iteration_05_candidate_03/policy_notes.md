# Candidate wake-policy notes

## Visual and metric diagnosis before editing

All four sampled evaluations satisfy the direct-uniform still-water contract:
`U_infinity=(0,0,0)`, no cylinders, and no prewarm snapshot.  In both the
top-down vorticity row and oblique Lambda2 row, each fish self-propels and
develops an alternating three-dimensional wake.  None of the failures is
passive advection or wake collapse.  All four trajectories nevertheless hook
upward and cross the upper virtual boundary while the target remains below and
left.

The centerline-gated course/crossflow posterior controller is the strongest
sample (`solver_80d41cb1405d`): it reaches and finishes at `9.880L` and remains
finite to `11.594T`.  This is a material distance and survival improvement over
the assigned parent's course-aware posterior controller (`11.303L` at
`9.906T`) and the sampled phase-conditioned yaw and response-gated anterior
redirects (`11.165L` at `9.823T` and `11.081/11.155L` at `10.324T`).  The
strongest sample also advances much farther left, to `x=17.386L`, but still
ends at `y=15.201L`; its view sheets show a longer coherent wake aligned with
the same upper-exit topology rather than a target-directed turn.

The strongest trajectory localizes the missing response.  Beat-averaged
bearing approaches zero around `4.4--4.8T`, while the speed-gated course term
has already changed to the countersteering sign.  From roughly `5--7T`, the
posterior request is corrective but accumulated rotation and lateral motion
carry the fish upward; by `8T`, bearing is about `-0.67 rad` and the course
error about `-0.34 rad`.  More posterior amplitude is a poor next test: the
strong run already raises force/moment peaks to about `0.0257/0.0138` and
places about `31.4%` of posterior commands above 95% of the soft acceleration
limit.  Conversely, the sampled large-error anterior redirect reduces peak
anterior joint speed from `4.54` to `3.42 rad/T`, lowers peak swim speed from
`0.76` to `0.57U`, and loses the strong run's distance progress.  Its steep
large-bearing gate also turns on only after the useful centerline correction
window has passed.

## Policy hypothesis

Use the strongest sampled posterior mean-curvature controller as the complete
route, response, and propulsion baseline.  Add one centerline course-curvature
redistribution mechanism: after forward motion is established, use the same
bounded target-versus-velocity course signal and alignment window to shift a
small part of the requested body curve into the anterior oscillator
equilibrium.  Keep the posterior target referenced to the actual anterior
angle, so this moves curvature forward without increasing the total requested
tail tangent or weakening the lagged traveling-wave scaffold.  The shift is
negligible at release, outside the target-line crossing window, and after
large bearing error develops; it therefore differs from the failed persistent
or large-error anterior centers.

The first semantic test is an earlier corrective yaw and reduced upward drift
through `4--7T`, while retaining the strong sample's leftward speed and
alternating wake.  Falsify the mechanism if it repeats the upper exit without
beating the `9.880L` closest approach, if anterior peak speed falls materially
below the `4.54 rad/T` carrier, if posterior saturation or load peaks grow, or
if the trajectory loses the strong sample's leftward progress.

bookshelf_consulted: true
source_domain: biological whole-body turning and closed-loop robotic-fish CPG direction tracking
source_mechanism: transiently redistribute curvature toward anterior body segments when observed course response must change, then release back into the thrust-producing rhythmic gait
transferable_invariant: preserve the traveling-wave carrier and total tail-tangent envelope while allocating a small bounded share of steering curvature anteriorly only from normalized target-relative motion
nontransferable_details: species-specific C-start shapes, published gains, clock phases, dimensional thresholds, exact vortex timing, morphology-specific envelopes, and prescribed routes
policy_translation: use the existing body-frame speed-gated target-to-velocity angle and bearing alignment window to shift a bounded part of mean curvature into the anterior oscillator; reference the posterior target to actual anterior angle so total curvature remains bounded
falsification: reject if corrective yaw is not advanced through the prior 4--7T crossing, the 9.880L minimum is not improved, anterior oscillation slows materially, the wake loses coherence, or saturation and hydrodynamic loads increase
