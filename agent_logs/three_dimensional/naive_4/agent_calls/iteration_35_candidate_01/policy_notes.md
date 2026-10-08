# Wake-policy candidate notes

## Prior-evidence diagnosis

All four sampled evaluations satisfy the direct-uniform still-water contract
(`U_infinity=0`) and terminate in capture.  In both the top-down mid-plane row
and the oblique Lambda2 row, they self-propel from rest, build the same coherent
alternating three-dimensional wake, retain a traveling posterior bend, and
reach the target without a visible instability or boundary encounter.  The
`solver_2acfcfa19ef8` and `solver_883a064fe477` combined sheets are byte-identical;
the other sheets preserve the same trajectory and wake topology, so the useful
distinction is in route-scale metrics rather than vortex appearance.

The assigned parent `solver_0d0db1d9cf71` captures at `15.768509T` with
distance integral `1.924067L`, final distance `0.745720L`, and score
`-0.041674`.  Adding the carrier-demodulated, opposition-only yaw-moment
correction in two source-distinct samples advances every `8/6/4/2/1.25/0.9L`
milestone, captures at `15.735508T`, lowers the integral to `1.919818L`, and
improves score to `-0.037222`; this is the route mechanism to preserve.

The sampled additive load-consensus variant `solver_006ebd822d4e` retains
capture and the coherent two-view wake, but adding another `1 deg` of curvature
when demodulated moment and lateral force both oppose the requested redirect
delays every milestone relative to the moment-only controller, captures at
`15.746509T`, raises the integral to `1.921600L`, and regresses score to
`-0.039050`.  Its posterior acceleration-limit residence and peak lateral
force actually fall (`23.30%` and `0.03327`, versus `23.59%` and `0.03380`),
while peak yaw moment rises to `0.01985` from `0.01920`.  Thus lower limiting or
lateral load does not rescue the longer route, and lateral-load consensus is
not evidence for stacking more target-directed curvature.

## Candidate hypothesis

Start from the proven moment-residual controller and retain its carrier,
target-error direction, axial-response wave allocation, redirect law, and
terminal shaping.  Carrier-demodulate the already normalized body-lateral
force exactly as in the sampled factorial branch, but use its opposition gate
to release at most one half of the *supplemental moment correction* instead of
adding a third curvature term.  The base target steering is untouched and the
moment correction remains target-directed, so this tests action allocation
rather than a sign reversal or a scalar-only gain edit.  The inherited trace
shows force/moment consensus over nontrivial route support, so the branch
changes feasible posterior action rather than wrapping an inactive clamp.

Falsify the hypothesis if any pre-approach milestone is delayed, capture or
two-view wake coherence is lost, distance integral/final crossing regresses,
or the change merely reproduces the parent.  Accept an actuator-load change
only together with route benefit.

bookshelf_consulted: true
source_domain: wake-interaction control and sensor-modulated rhythmic swimming
source_mechanism: preserve useful carrier motion and apply the smallest bounded sensory residual instead of cancelling or strengthening every lateral response
transferable_invariant: response observations may allocate a bounded residual command while the propulsive carrier and target-defined correction direction remain intact
nontransferable_details: organized cylinder wakes, species-specific kinematics, exact vortex or tail-beat phase, published gains, and task-specific routes
policy_translation: use normalized body-frame lateral-force residual only to attenuate the supplemental moment-rejection bend; never reverse base target steering or modify the traveling wave
falsification: reject if route milestones, capture, distance integral, force envelope, or coherent top-down and oblique wake regress, or if the gate has no feasible-action support
