# Terminal turn-response candidate notes

## Evidence diagnosis before the policy edit

- All four sampled rollouts satisfy the frozen Phase 2 contract: direct
  uniform initialization in still water with `U_infinity=(0,0,0)`, no
  cylinders or prewarm, finite dynamics, and `horizon` termination at `100T`.
  I inspected both the top-down mid-plane-vorticity and oblique body/Lambda2
  rows of the combined keyframe sheets for the strongest sample and the broad
  orbit failure. Both are self-propelled and retain coherent alternating planar
  wakes with compact three-dimensional structures through repeated turns;
  passive advection, wake collapse, collision, exit, and instability do not
  explain the misses.
- The inherited response-conditioned carrier contraction is a completed
  negative result: it did not create the intended turn-in-place response and
  retained the broad powered orbit. The sampled response-held C-turn likewise
  remains outside `2L` at `2.377L`. Do not add another scalar drive contraction
  or merely retune the recovery radius.
- The sampled course-response reserve (`solver_951085a20092`) established the
  first tight recovery orbit (`1.314L` minimum, `3.077L` final) with coherent
  propulsion. Extending that reserve by normalized target-ray/course alignment
  (`solver_6eb170b0d70a`) is the strongest current result: it improves minimum
  and final distance to `1.241/2.082L`, spends about `0.47T` inside `1.25L`,
  and leaves posterior clamp residence near `0.102`. This course-selected hold
  is more useful than the prefilled lateral-only bridge, which regresses to
  `1.371/3.303L` minimum/final distance and never enters `1.25L`.
- The remaining best-sample gap is a measured turn-response deficit. At its
  closest pass (`97.092T`) speed is `0.669U`, target-ray/course error is
  `1.692 rad`, normalized course is slightly receding (`course_dot=-0.121`),
  and the requested-sign yaw response is only about `0.13 rad/T`. Both joints
  have settled near `(-0.396,-0.418) rad` and their commands are only
  `(0.75,0.92) rad/T^2`, so the miss is not caused by command clipping. The
  visual return path remains a powered tangential arc rather than an inward
  terminal turn.

## Policy hypothesis

Use `solver_6eb170b0d70a` as the scaffold and preserve its oscillator, bearing
curvature, posterior brake and lag modulation, geometry-released C-turn,
course-response reserve, terminal course hold, wave envelope, and command
limits. Add one compact response-released mechanism: while the existing
terminal selector is active, course error is large, and measured yaw has not
developed in the requested direction, add a bounded anterior-only equilibrium
curvature burst. Release only the burst continuously as useful yaw appears.
The posterior equilibrium and traveling wave remain unchanged, so this tests a
transient turn response rather than more scalar curvature or carrier relief.

Support requires preservation of the coherent first pass plus capture, a pass
below `1.24L`, more residence inside `1.25L`, or a materially smaller terminal
orbit with improved final/mean distance and comparable clamp/load residence.
Reject if the first pass changes materially, the wake curls or stalls, useful
yaw does not appear, clamp/load residence rises, or the same tangential
noncapturing orbit remains.

```text
bookshelf_consulted: true
source_domain: biological C-start redirects and sensor-modulated robotic-fish CPG direction tracking
source_mechanism: a large direction error requests a bounded anterior bend that releases when useful measured turn response develops into the posteriorly emphasized propulsive rhythm
transferable_invariant: separate a transient turn-response deficit from sustained course response; retain the propulsive carrier and add bounded curvature only until requested-sign yaw develops
nontransferable_details: species-specific C-start stages, full-body kinematics, published gains, dimensional beat frequency, clocked CPG phase, exact vortex phase, capture radius, target coordinates, and prescribed routes
policy_translation: normalized body-frame distance, target and velocity directions, finite speed, and signed measured heading rate gate a reflection-equivariant anterior equilibrium burst within the existing two-joint terminal course hold
falsification: reject if cruise or the first pass changes, useful yaw does not appear, the wake curls or stalls, clamp/load residence rises, or closest, near-target residence, mean, and final distance retain the same noncapturing class
```

## Evaluation boundary

The new coupled CFD rollout occurs only after this worker exits. Frozen-trace
selector replay and dry controller checks can establish locality, action scale,
reflection equivariance, finiteness, bounds, and parameter ownership, but not
hydrodynamic improvement.

## Implemented candidate and non-CFD probes

The candidate starts from the completed terminal course-hold policy and adds
five owned response-deficit parameters. The burst is selected by the existing
normalized terminal distance/speed/course gate, large absolute course error,
and a deficit in requested-sign measured yaw. It changes only the anterior
equilibrium; the posterior terminal hold, lagged wave, brake, oscillator, and
command bound are unchanged. There is no clock, step count, hidden state,
world coordinate, target identity, route, or file access.

Frozen replay on the completed `solver_6eb170b0d70a` trace is exactly unchanged
at release. At the `2.466L` first pass, the action change is only about
`(-0.0012,-0.0003) rad/T^2`; over all states beyond `3L`, mean/maximum absolute
action change is `0.00047/0.0114 rad/T^2`. At the `1.241L` closest pass, the
burst changes the frozen-state action by about `(-5.89,-1.87) rad/T^2`, with
mean/maximum absolute change `5.30/5.89 rad/T^2` inside `1.5L`. The posterior
change is the bounded instantaneous consequence of the preserved lag target's
dependence on measured anterior state, not a changed posterior equilibrium.
These values establish locality and material terminal authority only; they do
not predict a coupled trajectory.

All `49` direct parameter references are returned by
`target_policy_params()`. Representative terminal, cruise, zero-speed, and
large finite states remain finite and within the declared `+/-28 rad/T^2`
reserve; mirrored target, velocity, joint, and yaw states negate both actions
with zero observed residual. The maximum nominal anterior equilibrium plus
recovery wave envelope is `43.6 deg`, below the `45 deg` joint limit. The
mandated material guidance/notes check, lightweight Julia policy contract,
parameter-schema audit, and solver editable-boundary check pass. No formal CFD
was run.
