# Terminal turn-rate-deficit candidate

## Evidence diagnosis before the policy edit

- All four sampled solver rollouts and the assigned-parent rollout use direct
  uniform still-water initialization with `U_infinity=(0,0,0)`, no cylinders,
  no prewarm, finite dynamics, and `horizon` termination at `100T`. I inspected
  both the top-down mid-plane-vorticity and oblique body/Lambda2 rows. The fish
  self-propels in every case and retains a coherent alternating planar wake
  with compact three-dimensional structures; passive advection, wake collapse,
  collision, boundary exit, and numerical instability do not explain the
  misses.
- The four sampled candidates share broad repeated return loops. The prefilled
  joint-state bend release has their best minimum at `2.215L`, but its joints
  are nearly parked there (`phi_dot=(0.0027,0.0020) rad/T`) while speed remains
  `0.677U`. Rear-selector, fixed-restart, and posterior-turn variants reach only
  `2.366--2.439L`; none enters `1.5L`. Their lower mean distances therefore do
  not provide a terminal capture mechanism.
- The inherited phase-balanced controller remains the strongest useful
  scaffold: it reaches `1.175L`, spends about `2.35T` inside `1.25L`, and keeps
  both joints active near the target while preserving the coherent wake. The
  assigned parent's equal-and-opposite counterphase burst reaches only
  `1.192L`, shortens residence inside `1.25L` to about `1.24T`, and slightly
  worsens mean distance from about `4.041L` to `4.043L`; its `3.222L` final
  distance is only `0.021L` better. Thus the paired joint-velocity trigger is
  now a completed negative result, not an unevaluated recommendation.
- The remaining miss is observable as a maneuver-response deficit. At the
  phase-balanced minimum, speed is `0.683U`, course error is `1.682 rad`,
  normalized closing is negative (`-0.076 L/T`), the target ray rotates at
  about `-0.578 rad/T`, and measured yaw is only `-0.061 rad/T`. The paired
  parent improves yaw to `-0.335 rad/T`, but that still trails the target-ray
  rate of `-0.568 rad/T` while the fish is already receding at `-0.071 L/T`.
  Static curvature, scalar energy, one-joint duty, posterior phase response,
  and joint-phase propagation have all preserved a miss; measured yaw response
  relative to target-ray motion has not yet acted directly on the C-turn
  equilibrium.

## Policy hypothesis

Start from the completed `1.175L` phase-balanced moving-equilibrium controller,
preserving its cruise, target-behind C-turn, course hold, low-activity energy,
posterior lag/brake, wave envelope, and command limit. Add one new closed-loop
mechanism only in the existing target-behind terminal region. Compute target-ray
angular rate from normalized body-frame target and translational velocity, ask
for that rate plus a bounded inward course-alignment margin, and compare it with
measured yaw. Translate the signed deficit into a bounded additional mean
curvature shared through the existing anterior and posterior C-turn targets.
The reserve vanishes continuously when yaw catches the requested rate, so it is
neither a constant bend shift nor another scalar energy adjustment.

On the inherited `1.175L` minimum state, the proposed selector requests a
clockwise rate near `-0.93 rad/T`; the roughly `-0.87 rad/T` yaw deficit adds
about `-0.09 rad` of terminal mean curvature after the existing continuous
gates. The resulting mean remains within the `45 deg` joint envelope with the
existing reduced recovery-wave amplitude. This frozen-state calculation tests
sign, scale, locality, and reflection symmetry only; the new hydrodynamic
result is unavailable until this worker exits.

Support requires capture, a pass below `1.175L`, longer residence inside
`1.25L`, or a materially tighter final loop while retaining active joint motion,
the coherent wake, and comparable clamp/load residence. Reject if the first
approach broadens, the extra mean curvature parks either joint, yaw overshoots
the requested target-ray rate into a tighter but noncapturing orbit, joint
limits/load residence rise materially, or minimum, near-target residence, mean,
and final distance do not improve together.

```text
bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and nonsteady biological C-start redirection
source_mechanism: persistent directional error recruits bounded turning asymmetry, while observed heading response releases the maneuver back into the propulsive rhythm
transferable_invariant: compare the target-ray-relative turn rate required for inward alignment with measured body yaw and retain only the bounded response deficit, continuously releasing it when the requested response appears
nontransferable_details: published gains, dimensional beat frequency, species-specific C-start envelopes, robot duty ratios, clocked CPG phase, exact vortex phase, target coordinates, capture radius, and prescribed routes
policy_translation: normalized body-frame target and velocity give target-ray rate and course error; their bounded yaw-rate deficit adds a reflection-equivariant terminal curvature reserve to both joint equilibrium targets without changing the phase-balanced carrier
falsification: reject if the approach broadens, either joint parks or reaches its angle limit, yaw overshoots into another noncapturing orbit, wake/load coherence degrades, or closest approach, near-target residence, mean distance, and final distance fail to improve over the phase-balanced scaffold
```

## Evaluation boundary

No formal CFD is run in this workspace. Dry contract, schema, reflection, and
frozen-state probes can test implementation semantics but cannot establish a
hydrodynamic improvement.
