# Wake-policy candidate notes

## Evidence diagnosis before editing

- All four sampled evaluations are valid direct-uniform still-water episodes:
  `U_infinity=(0,0,0)`, no cylinders, no prewarm, finite moving-window shifts,
  and no unstable termination. Their translation is self-propulsion rather
  than advection.
- Both visual rows show that propulsion is already useful. The top-down sheets
  develop coherent alternating vorticity behind each moving fish, while the
  oblique sheets show organized three-dimensional Lambda2 structures rather
  than breakup. The strongest-score compact controller reaches `5.3570L` and
  exits the upper boundary; the branch-heavy inherited 2D-sign controller
  reaches `6.1797L`, reverses progress, and exits the lower boundary. Changing
  the steering observation or actuator map is therefore better supported than
  replacing the posterior-lag gait or adding flow rejection in quiescent water.
- The assigned-parent logs proposed aligning the anterior steering acceleration
  and posterior mean-tangent signs. That candidate is now evaluated as
  `solver_ae0c621b2f7d`: it preserves the coherent wake, respects the smooth
  `31 rad/T^2` command bound, changes the upper exit to a left exit, and improves
  closest approach from the compact parent's `5.3570L` to `2.5794L`. This is
  positive evidence for the aligned two-joint mean-bend map.
- The same rollout also supplies a concrete failure boundary. It passes above
  the target: head position is about `(8.65,12.06)L` at closest approach near
  `19.88T`, after which distance grows to `8.7363L` at the left boundary.
  Reconstructed body-frame geometry changes from target-ahead
  (`target_body_L[1] < 0`) to target-astern (`target_body_L[1] > 0`) near the
  closest pass. The supplied scalar bearing computes its denominator from the
  absolute longitudinal component, so later values such as a small bearing
  cannot distinguish a target far ahead from one far astern. Merely retuning
  its gain or rate brake cannot restore the missing fore/aft semantics.

## Policy hypothesis

Preserve the evaluated aligned anterior/posterior mean-curvature actuator,
joint-state oscillator, posterior lag, smooth command bounds, and observed yaw
rate brake. Replace only the fore/aft-ambiguous scalar bearing in the route
request with the full signed body-frame target angle
`atan(target_body_L[2], -target_body_L[1])`, bounded before the existing
request map. For targets well ahead of the bearing calculation's `0.25L`
longitudinal floor this is the same normalized geometric error; near abeam and
after an overshoot it retains a large signed re-acquisition request instead of
folding the target astern onto the forward half-plane.

Expected result: preserve the coherent, bounded, leftward propulsive trajectory
through the first pass, then maintain turn authority after the longitudinal
target component changes sign, avoid the straight left-boundary escape, and
re-approach or capture the target. Falsify the mechanism if the fish does not
turn back after the target goes astern, repeats the left exit with growing
distance, loses wake coherence, or increases joint/command-limit residence.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop direction tracking and classical fish mean-curvature turning
source_mechanism: a persistent body-relative target-direction error modulates a bounded average bend superposed on a propulsive rhythm
transferable_invariant: preserve the traveling wave while the full signed body-frame target vector, including its fore/aft sense, continuously commands bounded mean curvature
nontransferable_details: published gains, dimensional cadence, species-specific envelopes, exact vortex phases, full-body waveforms, and task-specific routes
policy_translation: keep joint state as gait phase and the evaluated aligned two-joint bend, but replace the fore/aft-ambiguous bearing request with a bounded `atan(target_body_L[2], -target_body_L[1])` re-acquisition error
falsification: reject if target-astern geometry does not produce a return turn, the same left-exit topology persists, closest approach does not lead to re-approach, or wake coherence and actuator-limit histories worsen
