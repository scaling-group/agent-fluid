# Candidate diagnosis and hypothesis

## Evidence read before the edit

- All four sampled rollouts report direct uniform quiescent initialization,
  `U_infinity=(0,0,0)`, and no cylinders, so their displacement is
  self-propelled rather than imposed-flow advection.
- In both rows of the combined keyframe sheets, the compact policies preserve
  a coherent alternating wake and a posterior traveling bend. The best-score
  sample (`solver_b6bb94d9cdaf`) remains stable but travels above the target,
  reaches only `5.36L`, and exits the upper boundary. Its trajectory has a
  persistent target-versus-course mismatch: at `8T` and `12T` the target is
  about `0.52` and `0.67 rad` off the body axis while the observed velocity
  course is on the other side of that axis.
- The most useful near miss (`solver_ae0c621b2f7d`) uses an aligned anterior
  and posterior curvature request, preserves the same coherent wake, and
  improves closest approach to `2.58L`. At closest approach (`19.88T`) the
  head is near `(8.65,12.06)L`: it has crossed the target's streamwise station
  about `2.56L` high. It then keeps swimming left until the target is astern
  and exits at `x=0.30L`, final distance `8.74L`. The evaluator bearing folds
  the longitudinal sign with `abs(target_body_x)`, so bearing alone cannot
  distinguish this recovery state.
- The prefill (`solver_e699ec5c28f1`) also forms a strong organized wake, but
  its inherited 2D steering drives too far downward, reverses progress after
  `6.18L`, exits the lower boundary at `10.60L`, and has at least one raw
  action above `30 rad/T^2` on about `98%` of samples. Its many coupled
  steering branches are therefore not a sound base for another scalar edit.
- The compact samples are bounded and avoid joint-angle residence near the
  `45 deg` limit, but still place at least one action above `30 rad/T^2` on
  roughly `52--65%` of samples. The new candidate must not add an unbounded
  recovery impulse or increase the existing command limit.

## Policy hypothesis

Use the aligned compact traveling-wave scaffold from the `2.58L` near miss,
but replace bearing-plus-beat-rate steering with one target-versus-course
mean-curvature mechanism. Compute an ahead/astern-aware bounded target
direction from normalized `target_body_L`, compute the actual course from
normalized `velocity_body_U`, and smoothly blend body-axis error into course
error once speed makes course observable. Because the retained forward target
component explicitly gates abeam/astern authority, the same feedback becomes
a bounded redirect after a crossing instead of continuing on the
bearing-folded left-exit trajectory. Map that request consistently into
anterior steering and posterior mean tangent while retaining the evidenced
lagged propulsion wave and the existing smooth action bound.

Expected result: earlier course correction should reduce the large vertical
offset of the near miss, while a missed crossing should change from a monotone
left exit to target reacquisition. Reject the mechanism if closest approach
does not beat `2.58L`, the target/course mismatch does not contract, the same
left-exit topology persists, the wake loses its alternating coherence, or
action/joint-limit residence increases.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop direction tracking and biological burst redirect
source_mechanism: target-feedback modulation of a propulsive oscillator through bounded mean-curvature bias, with large observed direction error triggering redirect and geometry triggering release
transferable_invariant: keep rhythmic propulsion in joint-state feedback while a slower observed target-versus-course error commands bounded asymmetric mean curvature; retain the target's ahead/astern quadrant so recovery reverses appropriately after passage
nontransferable_details: published CPG gains, oscillator frequencies, species-specific bends, exact maneuver timing, exact vortex phase, and task-specific routes
policy_translation: derive an ahead/astern-aware target angle and a velocity-course angle only from normalized body-frame `target_body_L` and `velocity_body_U`; blend them by observed speed and send one bounded request with consistent sign to the two-joint steering map
falsification: reject if target/course error and closest distance do not improve, an abeam miss still becomes monotone domain exit, or coherent thrust and bounded joint/action histories degrade
