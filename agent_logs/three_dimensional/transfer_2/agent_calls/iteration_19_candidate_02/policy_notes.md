# Speed-gated middle-field course-redirect candidate

## Visual and diagnostic evidence before the policy edit

- All four sampled episodes satisfy the frozen evidence contract: direct
  uniform `U_infinity=(0,0,0)` initialization, no prewarm, no cylinders,
  stable free planar motion, and capture. They arrive in `19.360--19.552T`,
  have distance integrals of `2.08911--2.09458L`, and score
  `-0.20560-- -0.19989`. There is no missing-success problem to solve.
- Both rows of the combined keyframe sheets for the strongest sampled result
  (`solver_1af6c62469a7`) and the lowest-scoring sampled result
  (`solver_cb03d3cda781`) were inspected from release to capture. Both fish
  self-propel from quiescent water, shed a coherent alternating top-down wake
  with compact three-dimensional Lambda2 structures, and execute a smooth
  late hook into the capture circle. Neither sheet shows passive advection,
  collision, wake breakup, or instability. Their useful visual topology is
  effectively the same.
- Diagnostics agree with the images. Across the four samples, peak planar
  force/yaw-moment coefficients remain about `0.0249--0.0254` and
  `0.0131--0.0134`, respectively, while both joints reach the `260 deg/T`
  rate limit and roughly `33--37%` of actions lie above 90% of the smooth
  command bound. More posterior authority is therefore not supported as the
  next intervention.
- The assigned parent's byte-identical response-gated posterior-bend repeat
  captured at `19.591T`, `2.09637L`, and `-0.20651`, versus the earlier exact
  policy's `19.360T`, `2.08911L`, and `-0.19989`. This establishes meaningful
  repeat variation and does not validate another response-gate or posterior
  gain composition. The current posterior-lag, posterior-amplitude,
  response-bend, and approach-authority samples likewise add no new semantic
  success or visibly distinct useful trajectory.
- A body-frame reconstruction from each sampled trajectory compared target
  bearing with actual velocity course after speed exceeded `0.03L/T`. Mean
  absolute course error while farther than `6L` is `0.530--0.549 rad`, yet the
  current redirect weight is identically zero there because it is multiplied
  by `approach_weight`. The same error falls to `0.216--0.239 rad` in the
  `2--6L` band for three of four samples, while the visually obvious correction
  remains concentrated in the late hook. This supports testing when course
  feedback acts, not increasing terminal or carrier authority.

## One-candidate hypothesis

Preserve the established state-feedback oscillator, constant posterior lag,
fore/aft-aware body-frame target mapping, distance/closing drive relief,
target-derived half-cycle asymmetry, terminal course/LOS redirect, and smooth
command limit. Remove the unsupported posterior-lag half-cycle modulation from
the prefill. Add one mechanism: permit a small fraction of the existing
velocity-course residual outside the `6L` approach region, gated continuously
by measured speed and residual magnitude. Full redirect authority remains
distance scheduled near the target. This is a bounded CPG residual rather than
a world-frame route, clock, or scalar increase to propulsion.

The predicted signature is a smaller far/middle body-frame course error and a
shorter or less pronounced late hook, improving arrival, distance integral, or
head-path length beyond the exact-policy repeat envelope without degrading the
coherent two-view wake, load class, joint margin, or command residence. Falsify
the mechanism if it merely shifts beat-scale weaving earlier, increases path
or action cost, destroys the traveling wake, or fails to improve trajectory
metrics beyond repeat variation. A held-out pose or inflow remains necessary
before claiming portable path-following benefit.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and residual CPG path following
source_mechanism: retain the rhythmic gait while a bounded observation-driven residual corrects direction error instead of replacing the gait with raw torque or a memorized route
transferable_invariant: gate a small course-alignment residual by normalized body-frame velocity direction and established swimming speed, with authority increasing continuously near the target
nontransferable_details: published CPG gains, robot-specific tail kinematics, dimensional speeds, learned route parameters, clock phase, exact vortex phase, and world-frame waypoints
policy_translation: remove unsupported posterior lag modulation and blend a small far-field fraction of the existing body-frame velocity-course redirect into the two-joint mean bend, using only speed, target bearing, LOS response, and the existing continuous approach weight
falsification: reject if far or middle course error, late-hook path length, arrival, or distance integral does not improve beyond repeat variation, or if command residence, joint margin, loads, capture, or either wake view regresses
