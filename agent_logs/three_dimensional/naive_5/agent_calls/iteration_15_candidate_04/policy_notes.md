# Predictive middle-course redirect candidate

## Visual and rollout diagnosis before the edit

- All four sampled evaluations report direct uniform initialization in still
  water with `U_infinity=(0,0,0)`, no cylinders, and no prewarm. In both rows
  of `solver_fe5535fc7da1/wake_keyframes.jpg`, the body translates with a
  body-attached alternating vorticity street and compact oblique Lambda2
  structures from release through the target station. The motion is therefore
  self-propelled, not ambient advection or a moving-window artifact.
- The prefilled terminal traveling-wave policy retains that coherent low-load
  wake and the useful lower route, but it misses at `0.870635L` and exits left.
  It is identical to the earlier low-load carrier until the head is inside
  about `1.75L`; by then the sampled head is already at `(9.137,11.192)L`,
  speed is about `0.657L/T`, and the velocity/target cross product predicts a
  miss of about `1.35L`. At closest approach, the body has yawed farther toward
  the target than the inherited static-redirect case, yet velocity has rotated
  back toward the old leftward course: speed is `0.633L/T`, joint 2 is near
  `-36.5 deg`, and the projected miss is about `0.809L`. The top-down `31T`
  panel likewise shows a thick curved wake beside the target followed by a
  regular street after passage. Joint motion and body yaw did not become useful
  course rotation.
- The informative `solver_b6ed3f84ab58` contrast remains in the high corridor,
  reaches only `5.386L`, touches the posterior angle limit, and has peak planar
  force/yaw moment near `0.212/0.0968`; its top-down and oblique sheets show a
  coherent but wastefully loaded trajectory. The low-load `solver_b3b6be8f076f`
  and `solver_12fc3441a636` cases also exit the upper margin at `4.278L` and
  `6.268L`. Thus coherent vortices alone do not validate either more posterior
  authority or an early, indiscriminate held C-bend.
- Inherited completed results close the local terminal-wave branch as well as
  the scalar and recovery branches. Mean-biased forward waves reached
  `0.875770L` and `0.870635L`; a reverse-wave brake reached `0.874118L` and
  still crossed near `0.656L/T`. Deeper curvature, isolated-joint recovery,
  and coordinated recoil all retained `left_domain` at `0.827823--0.846679L`.
  The common failure is not missing terminal activation but waiting until the
  projected intercept is already unsafe and then trying to repair it locally.

## Policy hypothesis

Recover the evaluated low-load carrier and miss-qualified C-redirect, removing
the failed terminal oscillator. Add one predictive middle-course mechanism:
derive projected miss and positive time-to-go from the normalized body-frame
target and velocity vectors, and smoothly re-engage the already calibrated
same-sign two-joint redirect when the current straight-line intercept lies
outside the capture corridor and time-to-go is shrinking. The gate vanishes
for a safe projected intercept, a receding target, low speed, or long
time-to-go, so it is response-based rather than a clock, route, or fixed-world
command.

This should start course correction around the observed `2--4T` interception
window, before the `1.75L` terminal station, while preserving the distant
carrier and the known turn side. The falsifiable expectation is a meaningfully
different lower trajectory whose projected miss is already smaller on entry
to the terminal neighborhood, followed by a first head crossing inside
`0.75L`. Reject the mechanism if it reproduces the same `0.83--0.88L` pass,
holds the redirect so early that it returns to the sampled high corridor,
fails to rotate velocity despite more body yaw, or moves force, moment, angle
contact, or actuator-limit residence toward the posterior-redistribution
failure.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG direction tracking and biological burst redirect, combined with the shelf's far-middle-near capture decomposition
source_mechanism: modulate a bounded rhythmic carrier with a response-released two-joint redirect before predicted interception error becomes a terminal miss
transferable_invariant: when a coherent carrier has a persistent unsafe projected intercept, corrective curvature must begin while positive time-to-go remains and must release on measured translational alignment rather than joint motion or yaw alone
nontransferable_details: published gains, dimensional frequencies, species-specific C-start timing and envelopes, prescribed waypoints, exact vortex phases, and task-specific world coordinates
policy_translation: compute projected miss, closing speed, and time-to-go only from normalized body-frame target and velocity; use them to blend the established two-joint redirect into the carrier and remove it continuously for a safe or receding intercept
falsification: reject if projected miss is not reduced before the terminal neighborhood, capture does not occur or beat the inherited `0.827823L` minimum, the route returns to the upper exit, or wake coherence, loads, clearance, and limit residence materially worsen

## Non-CFD implementation audit

Replaying the candidate on all `7263` frozen prefill states while disabling
only its new predictive layer changes `940` actions, from `19.035--27.071T`
and only at sampled distances below `4.981L`; no state at or beyond the `5L`
middle-range boundary changes. The largest component difference is
`21.949 rad/T^2`, while frozen-state acceleration-clamp incidence decreases
from `2649` to `2624` joint samples. All outputs are finite, a zero-speed
zero-error state returns `(0,0)`, and reflecting lateral target and velocity,
yaw rate, joint angles, and joint velocities negates both commands exactly
(maximum algebraic error `0`). These checks establish locality, material
activation, bounds, and reflection equivariance only; they do not predict the
pending CFD trajectory or claim a same-worker improvement.
