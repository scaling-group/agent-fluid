# Phase-separated course candidate

## Evidence read before the policy edit

- All four sampled rollouts use direct uniform initialization in still water
  (`U_infinity=(0,0,0)`), have no cylinders or prewarm, remain finite, and end
  with `left_domain`. Their translation and wakes are therefore self-generated
  rather than imposed advection.
- In both the top-down vorticity and oblique Lambda2 rows,
  `solver_adc862529891` visibly sustains a coherent alternating posterior wake
  and strong self-propulsion. It is the best finite sample by score
  (`-7.550`, minimum `5.658L`, final `5.843L`), but its center rises from
  `14.00L` to `15.20L` and exits the upper boundary at `16.77T`; the target is
  still about `5.84L` away. Small local flow (about `0.03U` in the inherited
  diagnosis) and the intact wake make this a route-control failure, not
  advection or collapsed propulsion.
- The contrasting combined sheet for `solver_b22e8cf1f277` also shows an
  intact alternating top-down street and three-dimensional vortex structures.
  Its speed-gated slip and two-joint yaw projection reduce range further to
  `4.158L` and bend the late path modestly downward, but the fish continues
  through the target's x station and exits the left boundary at `29.52T` with
  final distance `9.037L`. Thus the inherited course/slip idea improves
  approach but does not supply a stable release/return trajectory.
- `solver_7108cd3d3374` supplies the direct negative test of unfiltered course
  response: it reaches `4.358L`, then continues almost horizontally around
  `y=13.9L` to the left boundary at `24.99T`, finishing `9.767L` away. This is
  the same useful-approach/route-loss topology as the slip candidate, not a
  semantic improvement.
- The trajectory histories explain why the course feedback is unreliable.
  Raw body-lateral velocity remains beat-dominated even when the net path is
  smooth. A fixed state projection
  `v_lateral_slow = v_lateral + 0.11*phi_dot1 - 0.035*phi_dot2` reduces lateral
  RMS from `0.385` to `0.140U` in `solver_7108cd3d3374`, `0.269` to `0.086U`
  in the assigned parent `solver_97bc3c03d55b`, `0.353` to `0.133U` in
  `solver_adc862529891`, and `0.307` to `0.119U` in
  `solver_b22e8cf1f277`. It retains the latter rollout's post-`6T` mean drift
  (`-0.0743U` raw and `-0.0746U` projected), so the transform removes carrier
  recoil without erasing the useful slow route sign.
- The inherited logs already reject scalar-only curvature tuning, raw
  sub-beat yaw feedback, response lead, and a confounded weak-carrier
  half-cycle experiment. The evaluated Phase-5 candidates show that yaw can be
  phase-separated while the velocity-angle branch is still left raw. The
  present experiment isolates that missing separation and preserves the
  strongest evidenced `28 degree`, `0.55T` traveling-bend carrier.

## Policy hypothesis recorded before editing

Use one compact mechanism: apply the same joint-state disturbance-observer
principle to lateral body velocity that the best completed policies apply to
rigid yaw. Start from `solver_b22e8cf1f277` so its carrier, target bearing,
speed gate, two-joint yaw residual, and posterior mean-curvature actuator stay
unchanged; replace only raw lateral slip with the cross-rollout phase-projected
slow slip above. This should stop alternating recoil from reversing the route
request within each beat while retaining persistent cross-track motion as an
early brake. Expected evidence is a coherent wake, less within-beat steering
chatter, closest approach below `4.158L`, and a trajectory that turns toward
the target instead of repeating the left exit. Reject the mechanism if the
projected signal remains beat-dominated, propulsion degrades, the upper/lower
boundary topology returns, or another left exit occurs without a meaningful
closest-approach or final-distance improvement.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG direction control and tail-beat averaging
source_mechanism: preserve a rhythmic propulsive carrier while separating gait-correlated fast body motion from the slower sensory route residual
transferable_invariant: joint-state-correlated recoil should not be interpreted as persistent course error; bounded steering should respond to the residual motion after that carrier component is removed
nontransferable_details: published CPG gains, robot geometry, clock phase, dimensional beat rates, species kinematics, exact vortex phases, and task-specific routes
policy_translation: preserve the two-joint state-feedback carrier; use normalized body-frame target bearing and speed, subtract the evidenced joint-rate component from lateral velocity, and feed only the bounded phase-separated slip through the existing posterior-curvature route loop
falsification: reject if lateral phase content is not reduced, the coherent wake or propulsion weakens, or the same left-boundary route loss remains without beating the `4.158L` sampled minimum and improving final distance
