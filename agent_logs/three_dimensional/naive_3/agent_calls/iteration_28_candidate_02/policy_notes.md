# Terminal posterior-course residual candidate

## Evidence diagnosis before the policy edit

- All four sampled rollouts satisfy the frozen Phase 2 contract: direct
  uniform initialization in still water with `U_infinity=(0,0,0)`, no
  cylinders or prewarm, finite dynamics, and `horizon` termination at `100T`.
  I inspected both the top-down mid-plane-vorticity and oblique body/Lambda2
  rows of every combined keyframe sheet. Every fish self-propels from rest and
  retains a coherent alternating planar wake with compact three-dimensional
  structures; passive advection, wake collapse, collision, domain exit, and
  instability do not explain the misses.
- The course-response reserve (`solver_951085a20092`) remains the clean tight-
  orbit scaffold at `1.314/4.056/3.077L` minimum/mean/final distance, with
  `5.379T` inside `1.5L` and anterior/posterior command-clamp residence of
  about `0.249/0.103`. The assigned prefill's broader terminal course hold
  (`solver_6eb170b0d70a`) shifts the late return inward to
  `1.241/4.158/2.082L` and is the only sample to enter `1.25L`, but it does so
  for only `0.473T`, reaches its minimum at `97.092T`, and raises anterior
  clamp residence to `0.329`. Its sheets still show a coherent powered loop,
  not terminal alignment or stall.
- At the prefill minimum, speed is `0.669U`, normalized target-ray/course dot
  product is `-0.121`, course cross is `0.993` (about `1.69 rad` error), and
  heading rate is only `-0.129 rad/T`. Both joints are already near a same-sign
  static C-bend (`-0.396/-0.418 rad`) while their commands are only
  `0.747/0.923 rad/T^2`, so more held equilibrium curvature is not justified.
- The two current alternatives close that branch. An ahead/lateral response
  bridge (`solver_34419dc4414e`) reaches only `1.371L`, never enters `1.25L`,
  and spends only `5.616T` inside `2L`. Adding a response-released anterior
  equilibrium burst (`solver_123b18cedff4`) is a stronger negative result: it
  never enters `2L`, worsening closest approach from `1.241L` to `2.125L`
  while preserving a broad coherent powered orbit. The assigned parent's
  inherited trace analysis instead finds unused posterior command authority
  inside `2L` and an empirical posterior-acceleration-to-yaw response at about
  `0.16--0.22T` lag. This supports changing actuator topology rather than
  retuning scalar curvature or carrier gain.

## Policy hypothesis

Preserve the complete prefilled terminal-course-hold controller: oscillator,
bearing curvature, geometry-released C-turn, course-response reserve, terminal
hold, posterior brake, joint-state phase modulation, wave envelope, and
command bound. Add one compact posterior dynamic residual only when the target
is inside the existing terminal distance envelope, measured speed is finite,
and normalized target-ray/course response is tangential or receding. Sign the
residual with the bounded body-frame course error and continuously release it
as radial closure appears. This leaves the established static bend and
traveling-wave carrier unchanged and directly tests the unused posterior
actuator instead of repeating the failed anterior equilibrium burst.

Support requires capture, a pass below `1.241L`, longer residence inside
`1.5L`, or a clearly inward terminal recovery while preserving the coherent
release and comparable clamp/load residence. Reject the mechanism if the
first pass changes materially, posterior clamping or force/moment loads rise,
the wake stalls or becomes strongly one-sided, or the same noncapturing
`1.2--2L` powered orbit remains.

```text
bookshelf_consulted: true
source_domain: Lighthill tail-emphasized reactive swimming, biological burst redirects, and residual control over robotic-fish CPG locomotion
source_mechanism: preserve a posteriorly lagged propulsive rhythm while a measured directional-response deficit selects bounded maneuver authority that releases on useful course response
transferable_invariant: separate the coherent traveling-wave carrier and held turn equilibrium from a small response-selected dynamic residual; apply the residual only during finite-speed tangential or receding terminal motion and remove it as radial closure appears
nontransferable_details: published gains, dimensional beat frequencies, species-specific burst kinematics, full-body waveforms, exact vortex phases, capture radius, target coordinates, and prescribed routes
policy_translation: normalized body-frame target and velocity directions, distance, and speed gate a reflection-equivariant posterior acceleration residual within the existing two-joint state-feedback contract; all cruise and equilibrium terms remain unchanged
falsification: reject if cruise or first-pass geometry changes, wake coherence degrades, posterior clamp/load residence rises, or no capture, closer pass, longer near-target residence, or inward terminal recovery appears
```

## Evaluation boundary

The coupled CFD rollout occurs only after this worker exits. Frozen-trace
selector replay and dry controller checks after the edit can establish
locality, sign, boundedness, reflection equivariance, finiteness, and parameter
ownership, but not hydrodynamic improvement.

## Implemented candidate and non-CFD probes

The candidate retains the complete prefilled controller and adds three owned
parameters for one posterior acceleration residual. The selector reuses the
existing normalized terminal-distance and finite-speed envelopes and adds a
smooth tangent/receding course-dot gate. Its sign comes only from bounded
body-frame target-ray/course error. It changes neither oscillator state nor
either joint equilibrium, carrier phase, target identity, coordinates, route,
or environment state.

Frozen selector replay on the completed `solver_6eb170b0d70a` trace is zero at
release, about `4e-13 rad/T^2` at `2T`, and `4.6e-9 rad/T^2` at `12T`. At the
original `2.466L` first pass it adds only `0.00086 rad/T^2`; at the `1.241L`
receding minimum it adds `2.965 rad/T^2` to the posterior command. Inside
`2L`, mean/maximum absolute residual is `1.224/3.083 rad/T^2`; beyond `3L`,
mean/maximum is only `0.00032/0.0071 rad/T^2`. These are frozen-state locality
and authority probes, not a coupled trajectory prediction.

Direct Julia comparison with the unedited prefill reproduces a terminal action
change of `(0.0, 2.9646) rad/T^2`, exactly zero change for a radially closing
near-target probe, and exact action negation under mirrored target, velocity,
joint, bearing, and yaw states to within `1e-10`. Representative release,
terminal, closing, and mirrored probes remain finite and within the declared
`+/-28 rad/T^2` reserve. All `47` direct parameter references are returned by
`target_policy_params()`. The mandated material-guidance check, lightweight
Julia policy contract, parameter-schema guard, and solver editable-boundary
check pass. No formal CFD was run.
