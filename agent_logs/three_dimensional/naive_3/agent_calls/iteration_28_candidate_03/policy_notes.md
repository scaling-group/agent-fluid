# Target-crossing-gated posterior response candidate

## Evidence diagnosis before the policy edit

- The sampled and inherited rollouts satisfy the frozen Phase 2 contract:
  direct uniform initialization in still water with `U_infinity=(0,0,0)`, no
  cylinders or prewarm, finite dynamics, and `horizon` termination at `100T`.
  I inspected the top-down mid-plane-vorticity and oblique body/Lambda2 rows
  of the combined keyframe sheets for all four sampled solvers and the
  assigned parent's inherited rollout. They self-propel from rest with
  coherent alternating planar wakes and compact three-dimensional structures.
  The failures are controlled powered loops, not passive advection, wake
  collapse, collision, domain exit, or numerical instability.
- The strongest sampled terminal course hold reaches
  `1.241/4.158/2.082L` minimum/mean/final distance and preserves its late
  return to the target. The lateral-only terminal bridge is weaker at
  `1.371/4.121/3.303L`, so neither more lateral-threshold tuning nor removal of
  the course hold is supported.
- Three completed dynamic-response variants expose a sharper failure boundary.
  The sampled anterior equilibrium burst reaches only
  `2.125/3.901/3.601L`; the inherited posterior acceleration residual reaches
  `1.442/4.003/3.905L`; and the assigned parent's line-of-sight-rate versus
  yaw-rate residual reaches `1.578/4.361/4.478L`. All remain coherent and
  stable, but all lose the course-hold scaffold's `1.241L` pass and `2.082L`
  final distance. Their first recovery minima move from `2.466L` with yaw
  about `+2.18 rad/T` to `2.62--2.68L` with yaw about
  `-1.69..-1.75 rad/T`. This common reversal occurs even though each frozen
  replay predicted negligible action near the original first pass; small
  ungated terminal residuals therefore cross a coupled trajectory bifurcation
  before the intended late miss.
- Full body-frame geometry separates that unintended first-pass intervention
  from the evidenced late response deficit. At the original `2.466L` first
  recovery minimum the normalized target-forward projection is `+0.180`, so
  the target is still ahead and the existing target-behind selector is only
  about `9e-4`. At the `1.241L` late miss the projection is `-0.855`, course
  dot is `-0.121`, speed is `0.669U`, yaw is only `-0.129 rad/T`, and the
  target-behind selector is effectively one. The completed posterior residual
  also shows usable dynamic authority without greater posterior clamp
  residence, but it applied that authority on both sides of the target
  crossing.

## Policy hypothesis

Return to the strongest sampled terminal-course-hold scaffold. Preserve its
oscillator, posterior lag and brake, target-behind C-turn, course-response
reserve, terminal course hold, wave envelope, equilibrium curvatures, and
command limits. Add exactly one dynamic mechanism: the evidenced bounded
posterior acceleration residual for a nearby tangent or receding course, but
multiply its selector by the existing full-direction target-behind weight.
This makes the residual vanish before the target crossing and lets it act only
on the late receding recovery for which posterior response was diagnosed.

Support requires preservation of the coherent `2.466L` first recovery and
either capture, a pass below `1.241L`, longer residence inside `1.25L`, or a
materially better final/mean-distance combination with comparable clamp and
load residence. Reject the mechanism if first-pass yaw or geometry changes,
posterior clamping rises, the wake stalls or becomes one-sided, or the same
late tangential orbit persists without a closer or more inward return.

```text
bookshelf_consulted: true
source_domain: biological response-released redirects and residual control over robotic-fish rhythmic locomotion
source_mechanism: retain the propulsive rhythm while full maneuver geometry selects a bounded dynamic turn response after, rather than before, the target crossing
transferable_invariant: separate maneuver engagement from response release; dynamic turn authority should be gated by observed target-side geometry so a small premature command cannot redirect the preceding approach
nontransferable_details: species-specific C-start stages, published gains, dimensional beat frequency, exact burst timing, vortex phase, capture radius, target coordinates, and prescribed routes
policy_translation: normalized body-frame target-forward projection, distance, speed, and target-ray/course dot product gate a reflection-equivariant posterior acceleration residual inside the existing two-joint state-feedback carrier
falsification: reject if the ahead-side first recovery changes, useful late yaw does not develop, wake coherence or load margins degrade, or closest, near-target residence, mean, and final distance retain the noncapturing orbit class
```

## Evaluation boundary

The new coupled CFD evaluation occurs only after this worker exits. Frozen
trace replay and dry controller probes can establish target-side locality,
action scale, reflection equivariance, finiteness, bounds, and parameter
ownership, but cannot establish hydrodynamic improvement.

## Implemented candidate and non-CFD probes

The candidate starts from the completed terminal-course-hold policy and adds
three owned parameters for one posterior acceleration residual. Its distance,
speed, and tangent/nonclosing selectors match the completed posterior-response
probe, but the residual is additionally multiplied by the existing squared
target-behind weight. It does not alter anterior equilibrium, posterior
equilibrium, wave phase or envelope, the established course hold, target
identity, world coordinates, a route, or any environment surface.

Frozen replay on the completed course-hold trace changes posterior acceleration
by only `7.2e-10 rad/T^2` at the `2.466L` ahead-side first recovery, where the
target-behind weight is `0.000916`. The residual is `0.0039 rad/T^2` at the
radially closing `1.643L` pass, `1.928 rad/T^2` at the subsequent tangential
`1.713L` pass, and `2.965 rad/T^2` at the late `1.241L` receding minimum. Its
mean/maximum absolute value is `1.161/3.083 rad/T^2` inside `2L` and
`0.00032/0.0071 rad/T^2` beyond `3L`; counterfactual posterior action remains
inside the `+/-28 rad/T^2` command reserve. These establish selector locality
and material late authority only, not coupled-flow performance.

All `47` direct parameter references are returned by
`target_policy_params()`. Representative terminal, ahead-side, zero, and very
large finite probes remain finite and bounded, and mirrored target, velocity,
joint, bearing, and yaw states negate both actions to `1e-12`. The mandated
material-guidance check, lightweight Julia policy contract, deterministic
parameter-schema probe, reflection and bounds probes, and solver editable-
boundary check pass. No formal CFD was run.
