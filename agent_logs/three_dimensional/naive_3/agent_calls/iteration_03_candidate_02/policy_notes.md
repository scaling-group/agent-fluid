# Wake-policy candidate notes

## Evidence diagnosis before the policy edit

- The assigned parent, all four sampled evaluations, and the inherited worker
  note were read before proposing the controller. Every sampled rollout is a
  finite, direct-uniform still-water release with `U_infinity=(0,0,0)`, no
  cylinder and no prewarm snapshot, so the differences are valid policy
  evidence rather than advection or initialization differences.
- Both the top-down vorticity row and oblique body/Lambda2 row were inspected
  for the prefilled finite near-miss and the most informative failure. The
  prefill retains a long alternating wake and visibly self-propels left/down;
  its local-flow magnitude near mid-rollout is only about `0.02 U` while body
  speed is about `0.77 U`. It improves distance from `12.328L` to `2.443L` at
  `17.869T`, then keeps crossing below the target and exits the lower boundary
  at `31.097T` with final distance `9.193L`. At `15T--18T`, derived body-frame
  bearing rises from about `0.80` to `1.47 rad` while forward speed remains
  roughly `0.66--0.77 U`; this is a powered misalignment, not wake loss or
  lateral passive drift.
- The `14 deg` static-curvature sample scarcely translates before curling
  upward: its short weak wake, `12.291L` minimum, and upper exit at `9.663T`
  reject more persistent bend. The ungated `7 deg` carrier reaches `4.067L`;
  adding state-phased toward-bend acceleration reaches `3.587L`, while the
  inherited posterior gate reaches `2.443L`. Thus state-phased steering and
  drive-to-turn exchange are individually useful, but the gate is the stronger
  carrier to preserve.
- Saturation distinguishes the next change. The toward-bend half-cycle sample
  clamps each acceleration about `75%` of its rollout. The prefill clamps the
  anterior acceleration about `75%` and the posterior about `35%`, with joint
  rates at the envelope about `13%` and `6%`. Adding more acceleration in the
  already strong direction is therefore likely to be hidden by the clamp and
  to worsen bang-bang residence.

## Policy hypothesis

Preserve the prefill's `7 deg` body-frame mean-curvature reflex, yaw-rate
release, bearing-gated posterior traveling wave, and `28 rad/T^2` command
reserve. Add one reflection-equivariant state-phased mechanism at joint 1:
when joint velocity moves away from the requested mean bend, apply a smooth
opposing brake; apply no brake on the toward-bend half-cycle. This weakens the
return half-cycle instead of strengthening an already saturated one, producing
bounded duty/asymmetry without a clock, higher static curvature, or a larger
command ceiling. The effect fades quadratically with steering request so the
aligned carrier is unchanged.

Expected evidence is the same coherent, correct-sign approach as the prefill,
followed by a larger mean yaw response while bearing is grossly misaligned,
closest approach below `2.443L`, and reduced lower-boundary overshoot without
increased clamp or joint-rate residence. Falsify the mechanism if early
propulsion or alternating wake coherence collapses, the trajectory repeats
the tight-turn failures, the large-bearing forward crossing remains, or
actuator residence increases.

```text
bookshelf_consulted: true
source_domain: robotic-fish CPG asymmetric flapping and biological target-gated redirect control
source_mechanism: create turn moment by weakening the beat half-cycle that moves away from the requested bend while preserving the propulsive rhythm
transferable_invariant: body-frame turn demand and measured oscillator phase can continuously bias half-cycle duty without a clock or persistent static bend
nontransferable_details: published CPG gains, dimensional beat settings, robot geometry, species-specific kinematics, exact vortex phase, and task-specific routes
policy_translation: normalized bearing and heading rate form the bounded turn request; measured joint-1 velocity identifies the away half-cycle, which receives a bounded opposing brake around the inherited posterior-gated carrier
falsification: reject if target progress or alternating wake coherence collapses, the powered lower-boundary overshoot remains, tight turning replaces it, or acceleration and joint-rate residence increase
```
