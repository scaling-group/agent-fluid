# Carrier-synchronous local-flow residual candidate

## Visual and metric diagnosis before the policy edit

- All four sampled solvers are byte-identical policy and combined-keyframe
  repeats of the assigned parent's controller. They satisfy the released
  direct-uniform still-water contract with `U_infinity=(0,0,0)`, no cylinders,
  no prewarm, finite moving-window dynamics, and capture at `16.604496T`,
  score `-0.1137286`, and final distance `0.743958L`. Exact fixed-case
  replication does not establish held-out pose, flow, or wake robustness.
- I inspected both rows of the sampled combined sheet from release through
  capture. The top-down row shows self-propelled left/down target closure, a
  shallow target-crossing arc, and a coherent alternating mid-plane
  vorticity street. The oblique row shows finite, compact, tail-connected 3D
  Lambda2 structures along the traveled path. There is no passive advection,
  inherited wake, collision, boundary exit, breakup, or instability.
- I also inspected both rows for the completed closure-qualified yaw release
  and projected-capture-corridor controls. Their wake and route classes remain
  visually indistinguishable from the incumbent, but directional metrics
  regress: closure-qualified release captures one step earlier yet scores
  `-0.1140375` at `0.744276L`, and the projected corridor retains the
  `16.604496T` arrival but scores `-0.1146249` at `0.744813L`. Together with
  the inherited closure-deficit redirect, these are negative controls against
  further nominal terminal gating, not evidence for changing propulsion.
- The incumbent reaches the released `4.537856 rad/T` joint-speed boundary
  while remaining below the acceleration limit; mean absolute requested
  accelerations are `21.733/22.674 rad/T^2`, and peak planar force/moment are
  `0.037165/0.018356`. The full carrier and its narrow one-sided feasibility
  guard should therefore remain unchanged.
- A body-frame reconstruction over the completed approach traces exposes a
  narrower observation inconsistency. Relative crossflow is measured as local
  flow minus body velocity. The incumbent removes fitted anterior-carrier sway
  from body velocity before posterior crossflow feedback, but leaves the
  carrier-synchronous part of local flow inside that same feedback channel.
  Within the incumbent's approach, a zero-intercept fit of local lateral flow
  to mean-removed `q1` and `q1_dot` gives coefficients near `-0.0252` and
  `-0.0010`, explaining about `77%` of its variance; the fitted signs and
  scales persist across the completed terminal descendants. This is a
  measured self-wake decomposition in direct still water, not a claim that all
  local flow should be cancelled.

## Sole policy hypothesis

Preserve the evaluated oscillator, raw body-frame target geometry, raw-course
anterior center, velocity and yaw demodulators, posterior route/yaw feedback,
phase-selective tail steering, acceleration bound, and final-one-percent speed
guard. Add one approach-gated local-flow carrier residual: reconstruct only
the small anterior-phase component measured in body-frame local lateral flow
and subtract it from the posterior relative-crossflow cue. Leave its mean and
all non-carrier flow residuals intact.

This mechanism completes the existing kinematic decomposition rather than
adding thrust, a terminal hold, or another transformed target signal. It is
bounded by the existing crossflow nonlinearity, reflection-equivariant,
clock-free, and exactly inactive before the existing approach gate opens.
Expected test: preserve capture and the connected two-view wake while reducing
self-wake-driven posterior steering enough to improve distance cost or crossing
depth. Falsify it if capture, arrival, route, score, wake connection, joint
feasibility, effort, force, or moment worsens, or if a held-out imposed wake
shows that the residual removes useful environmental crossflow.

bookshelf_consulted: true
source_domain: wake-interaction and sensor-modulated robotic-fish CPG control
source_mechanism: separate productive rhythmic locomotion and its carrier-synchronous flow signature from bounded external-disturbance feedback
transferable_invariant: a disturbance channel should respond to crossflow not explained by the internally generated beat while retaining slow and non-carrier environmental flow
nontransferable_details: published gains, species or robot kinematics, dimensional frequencies, prescribed routes, exact vortex phases, and source-specific wake geometry
policy_translation: use normalized body-frame joint state to reconstruct the evidenced local-lateral-flow carrier component and subtract it only from the approach-gated posterior relative-crossflow cue
falsification: reject if nominal capture, approach cost, crossing depth, connected wake, joint feasibility, effort, force, or moment regresses, or if held-out wake response is weakened

## Evaluation boundary

No CFD outcome is claimed for this candidate. The favorable capture and load
envelope belong to the completed sampled incumbent; the terminal regressions
belong to inherited completed controls. Later evaluation should require
capture and the same top-down/oblique wake class first, then compare arrival,
distance integral, final crossing depth, route topology, crossflow activity,
joint contact, near-limit residence, requested action, force, moment, and score
against the exact `-0.1137286` control. The phase fit is carrier- and
direct-still-water-specific; a changed gait, pose, or imposed wake is a direct
falsification test rather than evidence for copying its coefficients.
