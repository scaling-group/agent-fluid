# Acceleration-projected capture candidate

## Evidence and visual diagnosis before editing

- All four sampled rollouts satisfy the frozen evidence contract: direct
  uniform initialization in still water, `U_infinity=(0,0,0)`, no cylinders,
  no prewarm, finite dynamics, and `capture` termination.  The top-down motion
  and the oblique Lambda2 structures are therefore self-propelled rather than
  ambient advection.
- Three samples are byte-identical copies of the completion-gated redirect.
  Their top-down rows show a continuous target-directed arc and a coherent
  alternating red/blue wake through the capture corridor.  The oblique rows
  show discrete three-dimensional structures shed behind the posterior body
  without a visible collapse or load event.  Metrics agree: capture occurs at
  `26.411 T` and `0.7496 L`, score is `-0.71050`, mean distance is `2.6134 L`,
  mean/max speed is `0.501/0.667 L/T`, and peak force and moment coefficients
  are about `0.0332` and `0.0268`.
- The only structurally different sample adds both componentwise acceleration
  clipping and a near-speed-limit outward-acceleration guard.  Its two visual
  rows retain the same wake family and target arc, and it still captures, but
  it trails the parent throughout the route: at `20 T` its distance is
  `4.7526 L` versus `4.6086 L`, and at `26 T` it is at `1.2366 L` versus
  `1.0057 L`.  Capture is `0.4015 T` later, mean distance worsens to
  `2.6382 L`, and score falls to `-0.73429`.  Mean/max speed drops from
  `0.501/0.667` to `0.496/0.657 L/T`; nearly unchanged peak force/moment
  magnitudes provide no compensating stability evidence.  This is the most
  informative poorer contrast available; there is no sampled collision,
  boundary exit, or unstable rollout in the current set.
- The successful parent emits at least one raw acceleration beyond the
  `1800 deg/T^2` envelope in `82.53%` of rows, with raw peaks of
  `74.20/85.64 rad/T^2`.  The evaluator already applies the componentwise
  `31.416 rad/T^2` clamp before integrating the joints.  Thus an identical
  clamp at the policy boundary is an idempotent feasibility projection,
  whereas the sampled speed guard is an additional dynamics-changing
  intervention and is not supported by the slower result.

## Policy hypothesis

Preserve the evaluated completion-gated redirect, posterior-lag carrier,
target feedback, cadence scheduling, and half-cycle steering exactly.  Add
only a componentwise finite acceleration projection at the policy output,
with the limit owned by `target_policy_params`.  Do not add the sampled
near-speed-limit outward guard.  Since the downstream integrator already
computes the same clamp, the applied joint trajectory and coherent capture
topology should be unchanged, while the public policy no longer requests
accelerations outside its physical interface.

Expected result: reproduce the `26.411 T` capture and its distance, wake,
speed, and load histories to deterministic tolerance, while raw action maxima
become `31.416 rad/T^2`.  Falsify the mechanism if capture, applied joint
states, trajectory, or score differs materially from the completion-gated
parent; do not reintroduce a speed-envelope guard unless a later isolated test
shows a benefit that outweighs the observed `0.4015 T` delay.

bookshelf_consulted: true
source_domain: actuator-constrained robotic-fish CPG and residual joint control
source_mechanism: preserve the feedback-generated propulsive rhythm while enforcing the physical two-joint command envelope at the actuator boundary
transferable_invariant: feasibility projection should bound the issued command without changing the lower-amplitude feedback law or adding a new maneuver state
nontransferable_details: published actuator gains, robot torque models, species kinematics, clocked CPG phase, exact vortex phases, and task-specific routes
policy_translation: retain the normalized body-frame completion-gated controller and componentwise clamp its two finite acceleration commands to the parameter-owned L64 actuator envelope, without the unsupported joint-speed guard
falsification: reject if the fixed evaluation fails to reproduce capture and applied joint histories, or if bounded raw commands hide a material trajectory, wake, load, or score regression

## Scope

No same-worker CFD outcome is claimed.  The formal evaluator runs only after
this candidate exits; the equivalence and bounded-output claims above are the
next rollout's test.
