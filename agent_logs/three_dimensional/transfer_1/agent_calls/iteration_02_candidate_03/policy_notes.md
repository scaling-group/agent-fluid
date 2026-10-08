# Candidate hypothesis: capture-aligned redirect release

## Evidence diagnosis before editing

All four sampled rollouts are valid direct-uniform still-water evaluations
(`U_infinity=[0,0,0]`, no cylinders, no prewarm). Their combined keyframe
sheets were inspected in both the top-down mid-plane-vorticity and oblique
Lambda2 views, then cross-checked against `wake_metrics.csv`, diagnostics, and
trajectory samples.

- The transferred seed (`solver_2f352671b105`) is self-propelled and sheds a
  coherent alternating three-dimensional wake. It closes from `12.328L` to
  `4.780L` at `17.853T`, but continues through a broad downward arc and exits
  the lower boundary at `27.495T` with final distance `9.709L`.
- Shared mean curvature (`solver_6f966e269bf4`) destroys the useful trajectory
  topology: it makes negligible progress (`12.281L` minimum), shows only a
  short immature wake, and turns into the upper boundary by `7.711T`.
- The prefilled velocity-lead/posterior-curvature variant
  (`solver_d6318c8ad9e3`) retains a coherent wake but over-corrects downward,
  loops away after a `7.328L` minimum, and exits low with negative progress and
  `15.024L` final distance. Its stronger translational predictor is therefore
  not a supported base for another scalar retune.
- The response-gated redirect (`solver_8556f8eb9ecb`) is the strongest finite
  result. It preserves a staggered propulsive wake, improves minimum distance
  to `2.463L`, changes the exit from the lower to the left boundary, and stays
  stable through `33.412T`. At closest approach (`24.228T`) the head is near
  `(7.674,11.575)L`, already upper-left of the target, while velocity remains
  about `(-0.848,-0.409) U`. Correct-sign yaw has appeared, so the existing
  response gate releases most redirect curvature even though translational
  momentum is no longer aimed through the target. The subsequent coherent
  wake and left exit identify capture-corridor overshoot, not thrust collapse.

## Policy hypothesis

Restore the strongest response-gated redirect policy and change one mechanism:
inside a continuous body-length-normalized approach window, release the
large-error C-bend only when correct-sign recent yaw is accompanied by velocity
alignment with the body-frame line of sight. Far from the target, observed yaw
retains the prior release behavior; near the target, cross-track or departing
translation holds bounded curvature until the velocity vector points into the
capture corridor. This uses only `target_body_L`, `distance_L`,
`velocity_body_U`, recent turn rate, and joint state. It adds no clock, route,
world coordinate, or case identity, and leaves the evidenced posterior-lagged
carrier unchanged.

Expected result: retain the response-gated candidate's early closure and wake,
but begin a stronger final correction as its velocity starts carrying it past
the target, improving on `2.463L` and ideally crossing `0.75L`. Falsify the
mechanism if early closure degrades, the old upper-left pass/left exit remains,
the prefilled broad loop reappears, the redirect has the wrong sign, or the
coherent propulsive wake is lost.

bookshelf_consulted: true
source_domain: biological burst turning, robotic-fish closed-loop CPG modulation, and terminal approach control
source_mechanism: release a bounded redirect into the propulsive rhythm only after observed motion, not yaw alone, demonstrates target-directed response
transferable_invariant: near a tight target, correct rotation is insufficient evidence of interception; bounded curvature should persist until normalized translational velocity also aligns with the body-frame line of sight
nontransferable_details: species-specific C-start shapes, published gains, dimensional beat timing, exact vortex phases, full-body kinematics, and any prescribed world-frame route
policy_translation: smoothly gate the inherited body-frame target-angle redirect release by the dot-product alignment of `velocity_body_U` and `target_body_L` only in a normalized near-target window, while preserving joint-state phase and posterior lag
falsification: worse early closure, wrong-sign turn, renewed broad looping, unchanged upper-left pass and left exit, loss of coherent propulsion, or persistent actuator saturation
