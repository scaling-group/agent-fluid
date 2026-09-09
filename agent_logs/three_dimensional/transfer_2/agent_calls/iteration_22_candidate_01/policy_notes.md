# Response-aware handoff restoration candidate

## Visual and diagnostic evidence before the policy edit

- All four sampled evaluations are valid direct-uniform still-water rollouts:
  `U_infinity=(0,0,0)`, no prewarm, no cylinders, stable moving-window
  transport, and `capture` termination. Their scores span
  `-0.19253-- -0.18047`, arrival times span `19.1620--19.3985T`, and distance
  integrals span `2.06924--2.08187L`. The controller already has propulsion,
  target steering, and a stable capture class; this iteration tests which
  observed-response semantic should govern its bounded gait handoff.
- Both rows of the combined keyframe sheets were inspected from release to
  termination for the strongest finite sample (`solver_bf9554cfba28`) and the
  informative weakest current sample (`solver_d9cd27837e6b`). In both
  top-down rows the fish self-propels from quiescent water, forms a coherent
  alternating vorticity street, follows a broadly straight middle-field path,
  and makes the established late target-entry hook. Both oblique rows show
  compact three-dimensional Lambda2 structures following the caudal region;
  neither rollout is passively advected and neither shows collision, wake
  breakup, or instability. The images localize the difference to path timing
  and control semantics, not success or wake class.
- The assigned parent changed the handoff release from target-turn/yaw
  agreement to velocity-course-correction/yaw agreement. Its completed sample
  captured at `19.3985T`, with distance integral `2.08187L`, score `-0.19253`,
  head path `12.341L`, and peak planar force/yaw moment `0.02587/0.01342`.
  Both byte-identical evaluations of the earlier target-turn/yaw response
  handoff are better: `19.1620/19.3380T`, `2.06924/2.07622L`, scores
  `-0.18047/-0.18691`, head paths `12.309/12.304L`, and peak force/moment
  `0.02537/0.01357` and `0.02535/0.01335`. The course-response sample also
  trails the distance-only handoff's `19.3545T`, `2.07892L`, and `-0.18968`.
- The course-response gate slightly lowers mean anterior command to
  `18.37 rad/T^2` from `18.45/18.46` for the response-aware repeats, but does
  not turn that effort change into better arrival, integral, path, load, or a
  meaningfully different useful trajectory. It therefore fails its inherited
  falsification boundary. Do not tune its agreement gain or interpret a
  velocity-course error as the release variable merely because that error is
  useful inside the separate terminal redirect.
- Preserve the architecture boundaries established by inherited logs:
  velocity-course redirect curvature outside the validated approach region
  caused a domain exit at `8.750T`, and added terminal corridor/slip curvature
  regressed the captured trajectory. The supported action is an exact return
  to the replicated target-turn/yaw handoff, not another mean-bend or scalar
  composition.

## One-candidate hypothesis

Restore the byte-identical sampled response-aware posterior-allocation
handoff. Keep the corrected 3D bend sign, fore/aft-aware body-frame target
mapping, distance/closing drive relief, bounded terminal velocity-course
redirect, anterior joint-phase half-cycle steering, far posterior carrier
allocation, and near posterior lag allocation. During only the existing
`6--4L` transition, advance the release when the normalized body-frame turn
request and measured recent yaw response agree. This is the earlier compact
sensor-response mechanism and adds no curvature, drive authority, clock,
world coordinate, route state, or raw flow-phase dependence.

Expected signature: remain in the coherent capture class and reproduce the
two-run response-aware envelope rather than the falsified course-response
result: arrival no later than about `19.34T`, distance integral no greater than
about `2.0763L`, head path near `12.31L`, and the existing force/moment and
joint-command classes. Falsify the restoration only if a new exact evaluation
falls outside the known repeat envelope in capture, arrival, integral, path,
command/rate residence, joint margin, loads, or either wake view. A same-class
result inside that envelope supports retaining the simpler target-turn/yaw
semantic; it does not justify increasing its scalar gain.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and biological response-gated redirect release
source_mechanism: remove transient turn-biased wave allocation once measured yaw follows the body-frame task turn request
transferable_invariant: use bounded agreement between normalized task-direction demand and observed directional response to return continuously toward an established propulsive rhythm
nontransferable_details: published gains, dimensional cadence, robot-specific envelopes, species-specific burst kinematics, clock phase, exact vortex phase, world coordinates, and task-specific routes
policy_translation: inside the existing normalized-distance transition, use positive body-frame turn-request/recent-yaw agreement to advance the posterior allocation from carrier-amplitude asymmetry toward the sampled posterior-lag allocation under the unchanged two-joint acceleration contract
falsification: reject if capture, arrival, distance integral, path, command or rate residence, joint margin, load class, or coherent top-down and oblique wakes fall outside the replicated response-aware envelope
