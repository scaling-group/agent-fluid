# Target-crossing-gated anterior response candidate

## Evidence diagnosis before the policy edit

- All four sampled rollouts satisfy the frozen Phase 2 contract: direct
  uniform initialization in still water with `U_infinity=(0,0,0)`, no
  cylinders or prewarm, finite dynamics, and `horizon` termination at `100T`.
  I inspected both rows of every combined keyframe sheet. The top-down
  mid-plane views show sustained alternating wakes through repeated turns, and
  the oblique body/Lambda2 views show compact three-dimensional wake structures
  rather than passive advection, wake collapse, collision, exit, or numerical
  instability. The remaining failure is a controlled powered orbit.
- The assigned parent's terminal course-hold scaffold is the strongest current
  near miss: `1.241/4.158/2.082L` minimum/mean/final distance, roughly `0.47T`
  inside `1.25L`, and a coherent return loop through the horizon. The sampled
  course-response reserve reaches `1.314/4.056/3.077L`; the lateral terminal
  bridge reaches `1.282/4.119/2.862L`. Those comparisons preserve the broad
  response reserve and continuous course hold, but do not support another
  static-curvature, distance-gate, or scalar-drive edit.
- The ungated anterior response burst is now a completed negative result. It
  keeps a coherent wake and improves mean distance to `3.901L`, but loses the
  parent's close return, reaching only `2.125L` minimum and `3.601L` final
  distance. Inherited logs show that this and two other ungated dynamic
  residuals moved the original `2.466L` first recovery to `2.62--2.68L` and
  reversed yaw despite negligible frozen-trace action there. A frozen local
  delta therefore did not establish integrated locality around the
  target-crossing bifurcation.
- The inherited target-behind-gated posterior acceleration residual is also a
  completed negative result: it approximately preserves the ahead-side first
  recovery (`2.442L`, yaw `2.168 rad/T`, versus the parent's `2.466L` and
  `2.176 rad/T`) but reaches only `1.732/4.263/2.093L` minimum/mean/final
  distance. Full target-side geometry therefore isolates a late action, but
  posterior acceleration is not useful terminal authority on this scaffold.
  At the parent's late `1.241L` miss, the target is fully behind
  (`target_forward` about `-0.855`), speed remains `0.669U`, course dot is
  `-0.121`, course error is `1.692 rad`, and useful yaw is only about
  `0.13 rad/T`, while both commands are small. This leaves a late anterior
  turn-response deficit distinct from the already rejected posterior residual.

## Policy hypothesis

Preserve the assigned parent's oscillator, posterior lag and brake,
geometry-released C-turn, course-response reserve, terminal course hold, wave
envelope, equilibrium curvatures, and command limits. Add one response-released
mechanism: when the target is nearby, fully behind, course error is large, and
requested-sign yaw has not developed, add a bounded anterior-only equilibrium
bend. Multiply the earlier burst selector by the existing squared full-direction
target-behind weight. This makes the new action effectively absent at the
ahead-side first recovery while retaining material authority at the late
receding miss; the posterior equilibrium and lagged-wave formulation remain
unchanged.

Support requires preservation of the coherent first recovery plus capture, a
pass below `1.241L`, longer residence inside `1.25L`, or a materially more
inward terminal loop with improved final/mean distance and comparable clamp/load
residence. Reject if first-recovery geometry or yaw changes, the wake curls or
stalls, limit/load residence rises, useful yaw does not develop, or the same
noncapturing orbit remains.

```text
bookshelf_consulted: true
source_domain: biological C-start redirects and sensor-modulated robotic-fish CPG direction tracking
source_mechanism: a large direction error requests a bounded anterior bend that releases when measured useful turn response develops, while the posterior propulsive rhythm is retained
transferable_invariant: separate maneuver engagement from response release; apply transient anterior curvature only after target-side geometry identifies the missed pass, and remove it as requested-sign yaw develops
nontransferable_details: species-specific C-start stages, full-body kinematics, published gains, dimensional beat frequency, clocked CPG phase, exact vortex phase, capture radius, target coordinates, and prescribed routes
policy_translation: normalized body-frame distance, target-forward projection, target-ray/course error, finite speed, and signed measured heading rate gate a reflection-equivariant anterior equilibrium burst within the existing two-joint terminal course hold
falsification: reject if the ahead-side first recovery changes, useful late yaw does not develop, wake coherence or load margins degrade, or closest, near-target residence, mean, and final distance retain the noncapturing class
```

## Evaluation boundary

The new coupled CFD rollout occurs only after this worker exits. Frozen-trace
replay and dry controller checks can establish target-side locality, action
scale, reflection equivariance, finiteness, bounds, and parameter ownership,
but cannot establish hydrodynamic improvement.

## Implemented candidate and non-CFD probes

The candidate starts from the completed terminal course-hold policy and adds
five owned response-deficit parameters for one anterior equilibrium burst. Its
selector is the earlier distance/speed/course-error/yaw-response gate multiplied
by the existing squared target-behind weight. It does not change the posterior
equilibrium, lagged-wave formulation, phase lag, brake, carrier envelope,
course hold, maximum static response curvature, or command bound. It uses no
clock, step count, hidden state, world coordinate, target identity, route, or
file access.

Frozen replay on the completed parent trace changes the action by only
`9.8e-10 rad/T^2` at the `2.466L` ahead-side first recovery. Across all
ahead-side states, the mean/maximum absolute action change is
`1.91e-5/0.00755 rad/T^2`; beyond `3L` it is
`0.000459/0.0114 rad/T^2`. At the late `1.241L` minimum, the candidate changes
the frozen-state action from about `(0.970,0.868)` to
`(-4.923,-1.003) rad/T^2`; inside `1.5L`, mean/maximum absolute change is
`5.30/5.89 rad/T^2`. The posterior action delta is the instantaneous consequence
of the preserved lag target's dependence on anterior state, not a changed
posterior equilibrium. These probes establish target-side locality and material
late authority only; they do not predict the coupled trajectory.

All `49` direct parameter references are returned by
`target_policy_params()`. Full parent-trace replay remains finite and within
the declared `+/-28 rad/T^2` reserve; mirrored target, velocity, joint, and yaw
states negate both actions with zero observed residual. The maximum nominal
anterior recovery equilibrium plus contracted wave envelope is `43.6 deg`,
below the `45 deg` joint limit. The mandated material guidance/notes check,
lightweight Julia policy contract, parameter-schema audit, replay bounds and
reflection probes, and solver editable-boundary check pass. No formal CFD was
run.
