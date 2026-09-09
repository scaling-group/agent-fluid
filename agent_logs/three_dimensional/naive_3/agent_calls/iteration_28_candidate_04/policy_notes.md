# Joint-state terminal-stroke candidate notes

## Evidence diagnosis before the policy edit

- All four sampled rollouts satisfy the frozen Phase 2 contract: direct
  uniform initialization in still water with `U_infinity=(0,0,0)`, no
  cylinders or prewarm, finite dynamics, and `horizon` termination at `100T`.
  I inspected both the top-down mid-plane-vorticity and oblique body/Lambda2
  rows of every combined keyframe sheet. All four fish self-propel and retain
  coherent alternating planar wakes with compact three-dimensional structures;
  passive advection, wake collapse, collision, exit, and instability do not
  explain the misses.
- The prefilled terminal course hold (`solver_6eb170b0d70a`) is the strongest
  sampled trajectory: it reaches `1.241L`, finishes at `2.082L`, and scores
  `-4.374`. Its top-down return arc is visibly tighter than the lateral bridge
  and the assigned parent's burst, while the oblique row retains a compact
  wake through the late approach. The course reserve without the hold
  (`solver_951085a20092`) reaches `1.314L`, and the ahead-only lateral bridge
  (`solver_34419dc4414e`) regresses to `1.371L`; both remain wider powered
  orbits.
- The assigned parent's anterior response-deficit burst
  (`solver_123b18cedff4`) is a completed negative result. Relative to the
  prefill, it worsens closest/final distance from `1.241/2.082L` to
  `2.125/3.601L`, although its mean distance improves from `4.158L` to
  `3.901L`. At its closest pass the target-ray/course error is still about
  `1.70 rad` and course dot product is `-0.13`; both joints have settled near
  `(-0.366,-0.379) rad` with commands only about `(0.000,0.023) rad/T^2`.
  The top-down and oblique rows show a coherent powered arc, not wake failure.
  More anterior equilibrium curvature therefore created another nearly static
  C-bend without the missing inward course response.
- At the prefill's `97.092T` closest pass, speed remains `0.669U`, course dot
  product is `-0.121`, target-ray/course error is `1.692 rad`, yaw is only
  `-0.129 rad/T`, and the joints are already a same-sign bend near
  `(-0.396,-0.418) rad`. The existing controller contracts its recovery wave
  while holding this bend. The remaining test should change the transition
  from established bend to dynamic stroke, not add another static offset,
  raw acceleration residual, scalar carrier contraction, or terminal-radius
  retune.

## Policy hypothesis

Preserve the complete prefilled course-hold scaffold: far/middle oscillator,
bearing curvature, posterior brake and phase lag, geometry-released C-turn,
course-response reserve, terminal persistence, and command limit. Add one
clock-free terminal-stroke transition. When the existing terminal course gate
is active and measured joint state confirms that the requested-sign C-bend is
already established, continuously reduce only the posterior equilibrium share
while restoring a bounded amount of posterior traveling-wave authority. As the
posterior joint unbends, the joint-state gate releases and the established
C-turn can rebuild. This produces a smooth bend-and-stroke cycle from measured
state without reversing posterior mean curvature or changing cruise.

Support requires the coherent first pass plus capture, a pass below `1.24L`,
longer residence inside `1.5L`, or a clearly inward terminal course with
improved final/mean distance and comparable clamp/load residence. Reject if
the first pass changes materially, posterior limits or loads rise, the wake
stalls or strongly one-sides, the tail mean reverses, or the same tangential
noncapturing orbit remains.

```text
bookshelf_consulted: true
source_domain: biological C-start redirects and sensor-modulated robotic-fish CPG turning
source_mechanism: accumulate a bounded whole-body bend for a large direction error, then release that bend into a posteriorly emphasized propulsive stroke
transferable_invariant: separate bend formation from dynamic redirection; once measured joint state confirms the bend, shift authority from static posterior curvature into a bounded posterior traveling stroke and let state feedback rebuild the bend
nontransferable_details: species-specific C-start stages, full-body kinematics, published gains, dimensional beat frequency, clocked CPG phase, exact vortex phase, capture radius, target coordinates, and prescribed routes
policy_translation: normalized body-frame target/course geometry and the signed mean of the two measured joint angles gate a reflection-equivariant reduction of posterior equilibrium share paired with bounded posterior wave restoration inside the existing two-joint terminal selector
falsification: reject if cruise or the first pass changes, the tail equilibrium reverses, wake coherence or propulsion degrades, posterior clamp/load residence rises, or closest, near-target residence, mean, and final distance retain the same noncapturing class
```

## Evaluation boundary

The new coupled CFD rollout occurs only after this worker exits. Frozen-trace
selector replay and dry controller checks can establish locality, action scale,
reflection equivariance, finiteness, bounds, and parameter ownership, but not
hydrodynamic improvement.

## Implemented candidate and non-CFD probes

The candidate retains the complete prefilled controller and adds four owned
parameters for a joint-state-selected posterior stroke. The existing terminal
distance, speed, and course gate is multiplied by a smooth requested-sign bend
readiness gate from `(phi1 + phi2) / 2`. During the selected state, posterior
redirect share moves only from `1.05` toward `0.85` while posterior wave scale
moves from the local redirect value toward `0.58`. The posterior mean therefore
keeps the requested C-bend sign; the mechanism transfers authority rather than
adding an offset, raw acceleration residual, or clocked stage.

Frozen replay on the completed prefill trace changes anterior acceleration by
exactly zero. At the `2.466L` first pass, the posterior change is below
`3e-10 rad/T^2`; outside `3L` the selector's maximum weight is about `0.001`.
Inside `2L`, mean absolute posterior change is `1.766 rad/T^2`; inside `1.5L`
it is `3.943 rad/T^2` with a `5.361 rad/T^2` maximum. At the original `1.241L`
closest pass the selector weight is `0.503` and posterior change is
`5.244 rad/T^2`. These counterfactual values establish first-pass locality and
material terminal authority only; they do not predict the coupled trajectory.

All `48` direct parameter references are returned by
`target_policy_params()`. Representative terminal, zero-speed, and large
finite states remain finite and respect the declared `+/-28 rad/T^2` reserve;
mirrored target, velocity, bearing, yaw, joint-angle, and joint-rate probes
negate both actions with zero observed residual. The nominal posterior
equilibrium-plus-wave envelope is about `43.44 deg` in the established C-turn
and `42.90 deg` at full stroke transfer, both below the `45 deg` joint limit.
The mandated material-guidance check, lightweight Julia policy contract,
deterministic parameter-schema audit, and solver editable-boundary check pass.
The duplicated assigned-parent marker in the rendered workspace `README.md`
was removed so the guidance checker could resolve its parent unambiguously.
No formal CFD was run.
