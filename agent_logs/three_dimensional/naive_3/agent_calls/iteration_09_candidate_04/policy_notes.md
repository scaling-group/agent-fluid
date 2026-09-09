# Wake-policy candidate notes

## Evidence diagnosis before the policy edit

- The assigned parent, sampled solver results, and inherited optimizer logs
  all report direct uniform still-water initialization with
  `U_infinity=(0,0,0)`, no cylinders, no prewarm snapshot, and finite
  dynamics. The translations and wakes are therefore self-propelled rather
  than advection or an initialization artifact.
- I inspected the top-down vorticity and oblique body/Lambda2 rows of all four
  combined keyframe sheets. Each policy establishes a coherent alternating
  mid-plane street and compact three-dimensional wake structures, then remains
  powered after passing below the target and exits the lower boundary. The
  informative slip-phase failure reaches `2.822L`; its coherent wake but
  unchanged steep route confirms that phase relief did not repair course
  control. This is not a wake-collapse or numerical-instability failure.
- The latest posterior counter-bend is a useful mechanism despite its
  `left_domain` termination. It improves closest approach from the restrained
  carrier's `2.443L` at `17.869T` to `2.187L` at `18.073T`, shifts the `16T`
  center upward from about `8.83L` to `9.00L`, and slightly reduces mean
  absolute lateral force and yaw moment. Its top-down and oblique wakes remain
  coherent. This is a meaningful trajectory improvement, not a scalar-score
  win: its score is slightly lower because it still recedes to the boundary.
- The remaining error is now localized. At closest approach the counter-bend
  rollout has normalized body-frame lateral target fraction about `+0.997`
  but lateral velocity about `-0.051U`; the target is nearly broadside while
  translation still opposes it. The wrong-side-only gate has consequently
  faded to about `0.28 deg`, even though terminal lateral correction is still
  required. Posterior acceleration clamp residence rises from `35.4%` for the
  carrier to `38.1%`, but neither joint reaches its angle limit and mean load
  magnitudes are not worse, so the existing bounded posterior channel remains
  usable without raising command or curvature limits.
- Prior evidence rules out nearby alternatives: distance-only drive relief,
  full-direction thrust gating, slip-magnitude phase rotation, stronger static
  C-bending, and posterior half-cycle gain asymmetry all keep the lower-exit
  topology or worsen approach; unrestricted course-angle compensation reverses
  the useful release. The edit must therefore preserve the successful early
  counter-bend while avoiding a large far-field velocity correction.

## Policy hypothesis

Start from the evidenced counter-bend candidate and change only its feedback
trigger. Replace the reactive wrong-side test with a target-ray lateral-speed
deficit: the normalized lateral target fraction requests a bounded lateral
velocity, and the posterior S-shaped counter-bend remains active until measured
body-frame lateral motion is adequate in that direction. A smooth target-side
factor makes the residual reflection-equivariant and suppresses it when the
target is near the centerline. The carrier, mean-curvature reflex, posterior
lag, alignment gate, frequency, amplitude, maximum counter-bend, and command
limit remain unchanged.

Replaying completed observations through the proposed gate is a static
control-input check, not a new hydrodynamic result. On the counter-bend trace it
would request about `0.09 deg` at release, `4.45 deg` at `8T` versus the old
`4.06 deg`, `6.62 deg` at `16T` versus `5.48 deg`, and `5.95 deg` at the
`2.187L` closest approach versus `0.28 deg`. It releases again when measured
lateral motion meets the target-ray request. Expected CFD evidence is the same
coherent early wake and closing route followed by a later upward redirect,
closest approach below `2.187L`, and ideally capture or a new useful
termination class. Falsify it if release turns upward, wake coherence or early
progress degrades, posterior clamping/load rises materially, a tight curl
appears, or the powered lower exit persists without a meaningfully better
trajectory.

```text
bookshelf_consulted: true
source_domain: terminal target capture and sensor-modulated robotic-fish direction tracking, with elongated-body posterior-kinematics emphasis
source_mechanism: near a target, retain a propulsive carrier while measured slip relative to the target ray sustains bounded posterior steering
transferable_invariant: normalized target-ray lateral-velocity deficit can maintain a reflection-equivariant posterior correction after wrong-side velocity alone has faded
nontransferable_details: published gains, dimensional speeds and frequencies, species envelopes, robot geometry, exact vortex phases, amplitude ratios, duty ratios, and task-specific routes
policy_translation: derive a bounded desired lateral speed from target_body_L/distance_L and subtract a posterior equilibrium counter-bend until velocity_body_U supplies that target-signed motion
falsification: reject on wrong-sign release, wake or progress loss, increased posterior limit residence or loads, failure to beat 2.187L, or an unchanged powered lower exit
```

## Implemented candidate and pre-CFD checks

The candidate implements only the target-ray lateral-speed-deficit trigger
described above around the sampled counter-bend policy. Static checks confirm
that every direct `params.FIELD` reference exists, mirrored target/velocity/
joint/yaw states produce exactly sign-mirrored finite accelerations, the gate
is neutral on the target centerline, and target-opposed velocity strengthens
the posterior correction relative to adequate target-side motion. The required
semantic-guidance, lightweight policy-contract, and solver-boundary checks all
pass. Formal CFD remains deferred to the evaluator.
