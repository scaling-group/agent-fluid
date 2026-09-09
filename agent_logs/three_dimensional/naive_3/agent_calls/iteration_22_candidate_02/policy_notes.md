# Wake-policy candidate notes

## Evidence diagnosis before the policy edit

- The four sampled rollouts satisfy the Phase 2 contract: direct uniform
  initialization with `U_infinity=(0,0,0)`, no cylinders or prewarm, finite
  dynamics, and `left_domain` termination. I inspected every combined
  keyframe sheet from release to termination, including both the top-down
  mid-plane vorticity row and the oblique body/Lambda2 row. All four fish
  self-propel along nearly the same diagonal inbound arc, shed a long coherent
  alternating planar wake with compact three-dimensional structures, pass
  laterally outside the `0.75L` target, and remain powered on a steep lower
  exit around `31.2--31.7T`. The evidence shows neither passive advection nor
  a weak-wake or instability failure.
- The sampled fixed-proximity posterior phase-lag policy is the strongest
  current result: `2.326/8.424L` minimum/mean distance versus `2.385/8.436L`
  for the response-selected brake. It also beats sampled anterior duty
  asymmetry (`2.433L`) and the prefilled differential equilibrium S-bend
  (`2.469L`), while retaining the same coherent wake and anterior/posterior
  clamp residence near `0.749/0.355`. At its `17.908T` minimum the speed is
  still `0.687U` and target-ray-to-course error is `1.088 rad`, so its
  remaining failure is a powered lateral pass rather than insufficient drive.
- Two inherited rollouts close the previous guidance's selector and
  amplitude-allocation branches. Moving the phase action earlier with a
  forming-miss selector worsened minimum/mean distance to `2.684/8.474L`;
  attenuating the presumed harmful posterior wave half-cycle worsened them to
  `2.738/8.473L`. Both preserved the same coherent wake and lower-exit class.
  Thus earlier activation and posterior amplitude removal are not recovery
  mechanisms on this carrier.
- Replaying the sampled phase formula on its completed trace separates the
  timing hypothesis from scalar phase authority. Inside `3L`, its lag shift
  alternates sign on nearly balanced halves (`47.6%` negative), with mean
  negative and positive shifts of `-0.123` and `+0.143`; at the best minimum,
  the measured joint state selects the negative shift and reduces posterior
  lag from `0.8` to `0.613`. The only sampled improvement therefore contains
  a concrete beneficial-phase candidate, while the inherited failure warns
  against realizing asymmetry by reducing posterior wave amplitude.

## Policy hypothesis

Start from the sampled `2.326L` policy, preserving its state-feedback
oscillator, bearing/yaw cruise curvature, alignment envelope,
response-selected brake, fixed proximity/course-error envelope, full
posterior wave amplitude, and command reserve. Change only the posterior
wave-timing topology: rectify the signed phase modulation so measured joint
state may reduce lag on the half-cycle active at the sampled closest approach,
but may not increase lag on the opposite half-cycle. This one-sided phase
reset converts the symmetric zero-mean lag oscillation into bounded steering
through wave timing without another static bend, earlier gate, amplitude cut,
clock, or world-frame route.

Support requires the coherent inbound wake plus capture, a return leg, a new
useful termination class, or a material improvement below `2.326L` without
worse mean distance or clamp/load residence. The mechanism is falsified by a
changed far-field release, wake collapse, tight curl, increased limit/load
residence, or the same powered lower exit without a material closest-approach
improvement. Formal CFD occurs only after this worker exits; trace replay and
controller probes below can establish only locality, symmetry, and bounds.

```text
bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and classical posteriorly lagged traveling-wave swimming
source_mechanism: measured directional error and oscillator state apply a bounded phase reset while retaining the propulsive traveling wave
transferable_invariant: steer a productive rhythm by changing posterior timing on one selected half-cycle while preserving wave direction, posterior amplitude, and the opposite carrier half-cycle
nontransferable_details: published CPG gains, duty ratios, dimensional beat frequencies, species-specific envelopes, prescribed waveforms, exact vortex phases, capture radius, and task-specific routes
policy_translation: normalized body-frame target-ray/course error and measured anterior joint velocity select a reflection-equivariant nonpositive posterior-lag shift inside the evidenced proximity envelope under the two-joint acceleration contract
falsification: reject if cruise or wake coherence changes, posterior clamp/load residence rises, a tight curl appears, or the result cannot improve on 2.326L or change the powered lower-exit class
```

## Evaluation boundary

The new candidate has no same-worker CFD evidence. Non-CFD replay and contract
checks performed after the edit will be recorded here without presenting them
as hydrodynamic validation.

## Implemented candidate and non-CFD probes

The candidate differs from the sampled `2.326L` controller only by rectifying
its signed posterior-lag modulation: negative, lag-reducing phase shifts remain
unchanged and positive shifts become zero. Replaying that selector on the
completed sampled trace leaves release effectively unchanged (mean shift below
display precision and maximum lag reduction `4e-9` during the first `2T`).
Inside `3L`, candidate lag has mean/minimum/maximum
`0.742/0.585/0.800`, and it retains lag `0.613` at the sampled minimum. These
are counterfactual selector measurements, not a coupled-flow prediction.

The mandated guidance-difference, policy-contract, and solver-boundary checks
pass. All `27` direct `params.FIELD` references are declared by
`target_policy_params()`. Representative mirrored states produce exactly
negated actions with zero floating-point residual; zero-speed and extreme
finite states remain finite and respect the declared `+/-28 rad/T^2` command
reserve. No formal CFD was run.
