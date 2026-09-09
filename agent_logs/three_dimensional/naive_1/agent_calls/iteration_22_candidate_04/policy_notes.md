# Candidate diagnosis and hypothesis

## Evidence read before editing

- All four sampled evaluations report `uniform_direct` initialization,
  `U_infinity=(0,0,0)`, no cylinders, and capture. Thus this sample contains
  no new termination failure to compare against; the informative failure is
  the assigned parent's inherited executable-equivalent envelope rollout that
  missed at `0.81206L` and exited left at `34.2320T`/`10.67789L`.
- In both the best-score current sheet (`solver_649d7e789a5a`) and the prefill
  sheet (`solver_8687829e1d01`), the top-down row develops an alternating,
  target-directed vorticity street from release through capture. The oblique
  row shows compact alternating caudal Lambda2 lobes rather than passive
  advection or a diffuse/unstable wake. There is no visible collision or wake
  collapse before termination.
- The images agree with the metrics: the two executable-identical envelope
  samples capture at `18.82649T` and `18.88149T`, with score-metric mean
  distances `2.08855L` and `2.08896L`. The clean prefill captures at
  `18.68350T` and `2.09405L`. All three still contact the acceleration limits
  on about `60.85--61.00%`/`72.97--73.27%` and the velocity limits on about
  `10.92--11.07%`/`14.81--14.93%` of rows; peak planar force and yaw moment
  stay in the common `0.031--0.033` and `0.016--0.017` bands. The scalar spread
  therefore does not support another propulsion or gain edit.
- The rearward-boost sample (`solver_bae498322681`) also captures with the same
  coherent wake, but its reconstructed forward target fraction remains
  positive (`0.35412--1.0`) on every row. Its rearward branch is exactly
  inactive, so that rollout establishes compatibility with the target-ahead
  carrier, not efficacy after a miss.
- The assigned parent records the post-miss deficiency: after the fragile
  envelope carrier missed, the target became rearward and the lateral
  direction cosine decayed from `0.361` to `0.128` while the existing turn
  request remained saturated at closest approach. A recovery qualifier must
  preserve lateral geometry as the sign source and must not alter any of the
  four current target-ahead captures.

## Policy hypothesis

Keep the prefilled clean displacement-half-cycle carrier, its one-sided
correcting-yaw release, its posterior lag, and its final acceleration
projection unchanged. Add one bounded body-longitudinal qualifier: when and
only when the normalized target lies behind the fish, smoothly amplify the
lateral route input by up to a policy-owned factor while allowing the lateral
component alone to own turn sign. The product remains zero at the
directly-astern sign ambiguity. This isolates post-miss recovery from the
non-repeatable envelope-redistribution mechanism and is exactly identical to
the clean parent on every currently sampled target-ahead row.

Expected result: ordinary captures retain the clean carrier's trajectory and
wake. If CFD variability produces the inherited overshoot, the route request
does not decay merely because the target becomes nearly astern, so the fish
should keep turning into a recovery arc rather than reproduce the left-domain
exit.

Reject the mechanism if it changes a target-ahead capture, chatters when the
target is directly astern, reverses target-owned turn sign, destroys the
alternating top-down/caudal-Lambda2 wake, or still exits with a decaying turn
after a miss. A nominal capture alone does not validate recovery; a rollout
must exercise rearward target geometry to do that.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop direction tracking and target-vector-to-mean-curvature turning
source_mechanism: persistent body-frame target geometry schedules bounded rhythmic steering while joint-state phase preserves propulsion
transferable_invariant: use normalized target geometry to own route sign and smoothly schedule turn authority without a clock or memorized route
nontransferable_details: published gains, species kinematics, CPG frequencies, exact wake phase, and task-specific paths
policy_translation: preserve the clean two-joint traveling-bend carrier; multiply only its lateral route input by a bounded rearward body-longitudinal qualifier, with lateral target geometry retaining turn sign
falsification: reject if target-ahead behavior changes, direct-astern ambiguity chatters, wake coherence or capture is lost, or an exercised post-miss branch retains the same decaying-turn exit
