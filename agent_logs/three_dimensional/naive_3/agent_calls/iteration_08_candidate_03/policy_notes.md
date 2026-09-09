# Wake-policy candidate notes

## Evidence diagnosis before the policy edit

- The assigned parent, all four sampled solver evaluations, and inherited
  optimizer logs use direct uniform still-water initialization with
  `U_infinity=(0,0,0)`, no cylinders, no prewarm snapshot, and finite
  dynamics. Their translation is self-propulsion rather than advection or an
  initialization artifact.
- I inspected the top-down vorticity and oblique body/Lambda2 rows in all four
  combined keyframe sheets. The strongest finite sample (`2.443L` minimum at
  `17.869T`) and the informative slip-phase failure (`2.822L`) both retain
  coherent alternating mid-plane streets and compact three-dimensional
  structures through the approach. All four tracks are nearly coincident:
  they cross the target's height with substantial downward translation, pass
  below it, and remain powered to a lower-boundary exit. This is a lateral
  course-control failure, not wake collapse or instability.
- The completed mechanism evidence is consistently negative beyond the
  alignment-gated `7 deg` carrier. Distance energy relief reached `2.845L`,
  full-direction gating `2.494L`, slip-gated posterior phase rotation
  `2.822L`, target-ray-rate lead `3.167L`, closing-gated C-bending
  `2.468L` with larger loads, and posterior half-cycle gain asymmetry
  `3.661L`; every one retained the lower exit. Unrestricted course-angle
  compensation instead reversed release and exited above after reaching only
  `12.150L`.
- The parent trace identifies a more specific actuator question. At its
  inbound `8L/6L` crossings, normalized body-frame target direction is about
  `+0.11 rad` while body-frame lateral velocity is about `-0.53U`: the
  fish points near the target but translates to the opposite side. Joint 1 is
  already at the candidate acceleration clamp for about `74.6%` of samples,
  versus `35.4%` for joint 2. The inherited wrong-side guard added up to
  `5 deg` of same-sign posterior mean bend yet worsened minimum distance to
  `2.697L`, so more posterior C-curvature is not supported.

## Policy hypothesis

Preserve the strongest sampled anterior mean-curvature oscillator, yaw-rate
release, alignment-gated posterior traveling wave, frequency, amplitude,
phase lag, and command reserve. Add one actuator mechanism only: when the
normalized target ray has a lateral side and measured body-frame translation
opposes it, subtract a bounded target-signed posterior equilibrium bend.
This trades the failed extra C-curvature for a mild S-shaped/counter-bend
component in the less-saturated joint, is zero at rest and for corrective
motion, and flips exactly under reflection.

Expected evidence is the parent's coherent far-field wake and early closing,
followed by a shallower wrong-side translation by `8--16T` and a closest
approach below `2.443L`, ideally capture or a different useful termination.
Falsify the mechanism if release turns upward, propulsion or wake coherence
degrades, the posterior joint curls or occupies its limits materially more,
loads spike, or the same powered lower exit persists without a meaningfully
better trajectory.

```text
bookshelf_consulted: true
source_domain: elongated-body reactive tail-kinematics theory and sensor-modulated robotic-fish direction tracking
source_mechanism: posterior wave shape and mean tail bend alter reactive lateral force while an anterior rhythm preserves propulsion
transferable_invariant: persistent normalized wrong-side lateral translation can gate a bounded posterior counter-bend without replacing the state-feedback traveling wave
nontransferable_details: published gains, dimensional frequencies, species envelopes, robot geometry, exact vortex phases, amplitude ratios, duty ratios, and task-specific routes
policy_translation: target side from normalized target_body_L and opposing body-frame lateral velocity subtract a reflection-equivariant posterior equilibrium component around the evidenced two-joint carrier
falsification: reject on wrong-side release, wake or progress loss, increased posterior limit residence or loads, failure to beat 2.443L, or an unchanged powered lower exit
```

## Implemented candidate and pre-CFD checks

The candidate changes only the posterior equilibrium term described above.
Replaying the completed parent observations through the gate, without claiming
a new hydrodynamic result, requests about `1.67 deg` at the inbound `8L`
crossing and `2.46 deg` at `6L`, then releases to zero by the inbound
`4L` and `3L` crossings and remains zero at the `2.443L` closest
approach. This is the intended early wrong-side course correction rather than
a persistent terminal curl.

The required guidance-difference, policy-contract, and solver-boundary checks
pass. Synthetic mirrored target, velocity, joint, and yaw states produce
exactly sign-mirrored finite commands; corrective lateral motion removes the
counter-bend; and the full `324`-assertion repository test suite passes.
Formal CFD remains deferred to the evaluator.
