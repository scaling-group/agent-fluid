# Wake-policy candidate notes

## Evidence diagnosis before the policy edit

- The assigned parent guidance and inherited worker notes establish a useful
  carrier/steering split: the naive joint-state oscillator self-propels in
  still water but exits the upper boundary at `8.602T`, while restrained
  body-frame bearing-to-curvature feedback preserves propulsion and turns the
  route toward the target. All four sampled rollouts are finite, direct-uniform
  `U_infinity=(0,0,0)` cases with no cylinders or prewarm snapshot, so their
  trajectory differences are controller evidence rather than advection or an
  initialization artifact.
- Both rows of all four combined keyframe sheets were inspected. The static
  `14 deg` split-bias failure `solver_b8ee16f26af1` curls upward with only a
  short, weak oblique wake and almost no useful displacement (`12.291L`
  minimum, upper exit at `9.663T`). In contrast, the three restrained `7 deg`
  policies leave long alternating top-down vortex chains and coherent 3D
  Lambda2 structures while translating left and down. This supports retaining
  their state-feedback carrier and low-authority mean bend rather than adding
  more static curvature from release.
- The ungated restrained policy `solver_6f1e6108928b` reaches `4.067L` at a
  speed near `0.872 U`; state-phased half-cycle forcing
  `solver_c48783322a44` reaches `3.587L` near `0.899 U`; both then cross below
  the target and leave the lower boundary by about `25T`. The assigned parent's
  alignment-gated posterior wave `solver_2e1178a92e4c` is the strongest finite
  sample: it reaches `2.443L` at about `0.685 U` and survives to `31.097T`.
  Its top-down and oblique rows retain a productive wake, so lower approach
  speed—not wake collapse—coincides with the materially better near pass.
- The parent still overshoots. Its target is strongly lateral by `15--17T`,
  crosses from the head-side to the tail-side body half near `18T`, and then
  recedes until the lower-boundary exit. The policy continues a roughly
  `0.6 U` trajectory and clamps anterior acceleration at `28 rad/T^2` for
  about `75%` of logged steps (posterior about `35%`). Absolute-bearing gating
  therefore reduces tail thrust usefully but leaves too much anterior carrier
  energy for the `0.75L` terminal capture.

## Policy hypothesis

Retain the parent's evidenced `7 deg` bearing/yaw-rate mean-curvature reflex,
joint-state phase carrier, and alignment gate. Add one approach-hold mechanism:
a smooth normalized-distance envelope relaxes the anterior oscillator's limit
cycle and the posterior traveling-wave component as the head enters the target
neighborhood, while leaving the signed mean bend active. Far from the target
the equations reduce continuously to the parent; near it, reduced wave energy
and retained curvature should trade straight-line momentum for redirection
without recreating the release-time `14 deg` static-bend failure.

Expected evidence is preservation of the parent's coherent far-field wake and
left/down progress, followed by lower speed, less acceleration-limit residence,
and a closest approach below `2.443L` rather than another powered lower exit.
Falsify the mechanism if propulsion fades before the current `4L` neighborhood,
the fish stalls outside capture, the initial route changes materially, the same
target-behind/lower-exit topology survives, or joint/load histories worsen.

```text
bookshelf_consulted: true
source_domain: biological burst-redirect behavior and robotic-fish terminal approach control
source_mechanism: preserve broad propulsive steering far away, then reduce rhythmic drive while retaining bounded curvature during the near-target redirect
transferable_invariant: normalized target proximity should continuously trade traveling-wave energy for turning time without deleting the state-feedback phase carrier
nontransferable_details: species-specific C-start kinematics, published gains and distances, dimensional beat settings, exact vortex phases, robot geometry, and task-specific routes
policy_translation: a bounded function of state.distance_L relaxes anterior oscillator energy and posterior lag-wave authority around the existing body-frame bearing/yaw-rate mean bend
falsification: reject if far-field propulsion changes, approach stalls outside capture, closest approach does not beat 2.443L, the same lower-boundary overshoot remains, or actuator/load histories deteriorate
```
