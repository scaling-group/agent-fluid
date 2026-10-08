# Multi-wake candidate diagnosis and hypothesis

## Evidence read before the policy edit

- The shared prewarm sheet shows the held fish above and downstream of four
  developed, interacting vortex streets. The target lies in the merged
  second-row wake. This is common initial-condition evidence, not a controller
  difference.
- The prefilled steering-reserve policy and its duplicate reach the target in
  `49.142` released time with `2.1560L` mean distance, total/mean command energy
  `62522/1272.3`, and RMS force/moment `39.05/617.13`. Their released sheet
  shows a sharp initial clockwise redirect followed by a coherent, actively
  propelled upstream traverse; the regular posterior wake and leftward head
  displacement `-10.914L` rule out passive advection as the main transport.
- The bearing-scheduled-reserve sibling preserves that trajectory topology but
  reaches in `46.035`, improves mean distance to `2.0695L`, and lowers
  total/mean command energy to `56948/1237.1`. Its sheet shows the same useful
  redirect and long leftward traverse, with a slightly faster target entry.
  The benefit is not free: RMS force/moment increase to `51.40/761.46`, while
  both commands still touch their candidate-owned `30.0` envelope and both
  joint speeds still touch the episode limit.
- The course-slip sibling also succeeds in `48.032` with force/moment
  `37.92/605.38`, but uses higher total/mean command energy `62427/1299.7` and
  has a larger mean distance `2.1003L` than the scheduled-reserve sibling.
  Thus the sampled evidence supports scheduled directional authority as the
  best current arrival/effort trade, but not as a load-reduction mechanism.
- No failed keyframe sheet is present among the current sampled solver
  examples. The inherited optimizer logs provide the informative failure
  boundary: wholesale replacement by a slower/smaller curvature-equilibrium
  carrier stayed at least `9.238L` from the target and became unstable after
  `121.517`, with RMS relative crossflow/force/moment
  `1.138/16749.8/290421`. This rules out sacrificing the validated carrier to
  chase lower scalar command effort.

## Candidate policy hypothesis

Adopt exactly the sampled bearing-scheduled-reserve mechanism. Preserve the
validated `0.55`-period joint-state oscillator, posterior lag, positive
body-frame bearing residual, joint steering split, and `30.0` acceleration
envelope. Increase only the fraction of finite actuator authority reserved for
steering as the magnitude of current bearing grows, using a smooth even
schedule; return continuously to the evaluated cruise reservation as bearing
shrinks. This is target-error-conditioned carrier/residual allocation, not a
scalar gait retune or a hidden phase/stage controller.

Expected test: reproduce target reach with earlier arrival, smaller distance
integral, and lower command effort than the prefill while retaining coherent
leftward propulsion. Falsify this mechanism if capture is lost, arrival is not
materially better than `49.142`, the lower-exit or unstable-loop topology
returns, commands exceed `30.0`, or the extra load relative to the baseline is
not repaid by the sampled arrival/effort improvement. A changed wake phase is
still required before claiming robustness. The current candidate is not
formally evaluated until this worker exits.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG turning and sensor-conditioned direction tracking
source_mechanism: bounded target-error-conditioned turning authority layered on a rhythmic propulsive carrier
transferable_invariant: large persistent body-frame direction error should receive finite redirect authority, then release continuously back toward cruise as alignment improves while preserving the traveling bend
nontransferable_details: published gains, robot actuator ratings, clocked phases, species kinematics, dimensional beat rates, exact vortex phases, and source-task routes
policy_translation: schedule the already-validated two-joint bearing residual's reserved share from current dimensionless body-frame bearing, and fit the unchanged joint-state carrier inside the remaining candidate-owned acceleration envelope
falsification: reject if target capture or coherent upstream propulsion is lost, or if earlier arrival and lower effort do not justify the observed force and moment increase
