# Independent reproduction of direction-conditioned limiter coupling

## Evidence and visual diagnosis before the policy edit

- The prefilled solver is the reproduced `v33` partially coupled limiter. It
  captures from `12.327720 L` at `23.435516 T`, with score `-0.4079736071`,
  mean distance `2.305032573 L`, and final distance `0.749060333 L`. Its
  outer-only `12%` blend toward common-scale limiting is therefore the
  established baseline, while its normalized body-frame guidance and quiet
  below-`4 L` terminal glide remain protected behavior.
- The assigned parent's inherited note proposed a distinct outer rate-headroom
  guard because `v33` repeatedly reached the physical joint-rate limit. Its
  completed rollout is positive but not dominant: it captures at
  `22.891006 T`, improves score to `-0.3709551729` and mean distance to
  `2.267155038 L`, and lowers below-`4 L` force/moment maxima to about
  `0.01233/0.00646`. It still reaches the rate limit on `234/257` stored
  anterior/posterior states, so common attenuation is not evidence that rate
  contact itself must be minimized.
- The other two sampled limiter variants separate the useful mechanism.
  Replacing the reproduced `12%` floor with distortion-only coupling is nearly
  neutral (`23.369514 T`, score `-0.4035179823`, mean distance
  `2.300524064 L`) and raises global force/moment maxima to about
  `0.03069/0.01618`. In contrast, retaining the `12%` floor and adding at most
  six percentage points only when component clipping rotates the raw command
  captures at `21.912008 T`, with score `-0.3246592933`, mean distance
  `2.218947189 L`, and final distance `0.747680604 L`. This improves the
  prefill by `1.523508 T` and `0.086085 L` in mean distance, and also beats the
  assigned parent's rate guard by `0.978998 T` and `0.048208 L`.
- I inspected the combined keyframe sheets for the direction-conditioned
  winner and the least-improved prefill/distortion-gated contrasts, including
  both the top-down vorticity row and the oblique body/Lambda2 row from release
  through capture. All confirm direct uniform still-water initialization with
  `U_infinity=(0,0,0)` and self-propulsion rather than advection. They show a
  compact target-directed arc, a coherent alternating posterior wake, finite
  localized three-dimensional structures, and a quiet held-bend terminal
  glide; none shows a loop, boundary-exit precursor, wake collapse, collision,
  or instability. No sampled rollout is a termination failure, so the
  distortion-gated near-neutral result is the informative negative contrast.
- Telemetry resolves a useful difference below sheet resolution. At `12 T`,
  the direction-conditioned candidate has `6.956639 L` remaining at speed
  `0.872646 L/T`, versus `7.200078 L` at `0.805035 L/T` for `v33`; by `20 T`
  the distances are `1.874311 L` and `2.803681 L`. Neither clips acceleration
  inside `4 L`. The winner does increase posterior acceleration-cap incidence
  from `33.0%` to `40.5%` and posterior rate-cap samples from `234` to `295`,
  while keeping angles below `44 deg` and global force/moment finite at about
  `0.02988/0.01558`. Thus its semantic gain supports selectively preserving
  the commanded traveling-bend direction; it does not support claiming that
  lower saturation counts are intrinsically better.

## Policy hypothesis

Promote the sampled `v34` direction-conditioned policy unchanged as this
workspace's one candidate. Preserve the state-feedback oscillator, posterior
lag, target-angle redirect, closure preview, shared terminal mean bend,
helpful-crossflow and settled-response gates, center-velocity intercept
corridor, paired terminal release, and the reproduced base `12%` outer
coupling. Outside `4 L` only, retain the one bounded increment toward common
scaling when component clipping materially rotates the current raw two-joint
command. Do not stack the assigned parent's rate-headroom attenuation in the
same outer regime until this faster result is independently reproduced and the
interaction can be isolated.

This is an independent reproduction of one actuator-coordination mechanism,
not scalar-only gain tuning. The policy uses current joint state and normalized
body-frame target feedback, adds no time, route, target identity, world
coordinate, force cancellation, reconstructed rate, cadence change, mean-bend
change, beat-side selector, or joint-role split. Falsify the positive result if
the new CFD rollout does not reproduce capture near `21.912 T`, lower mean
distance, the compact outer path, coherent two-view wake, finite loads, and
exact terminal noninterference, or if the increased posterior envelope contact
becomes angle-stop dwell or instability.

bookshelf_consulted: true
source_domain: classical traveling-wave and elongated-body propulsion together with sensor-modulated coupled-oscillator robotic-fish control
source_mechanism: preserve coordinated anterior-to-posterior traveling-bend structure when a bounded actuator envelope engages
transferable_invariant: a bounded limiter should preserve the direction of a coordinated multi-joint rhythmic command most strongly when independent component clipping would rotate that direction
nontransferable_details: published gains, dimensional cadence, species-specific kinematics and actuator envelopes, full-body waveforms, exact phase lags, vortex phases, capture geometry, and task-specific routes
policy_translation: retain normalized body-frame targeting and the reproduced base outer coupling, then use the sine of the raw-versus-clipped joint-space angle to gate one small additional common-scale contribution outside the normalized terminal band
falsification: reject on non-reproduction of faster capture and lower mean distance, any terminal-command interference, changed compact path or mean bend, lost capture, joint-stop dwell, material load growth, instability, or degradation of top-down or oblique wake coherence

The candidate's CFD evaluation occurs only after this worker exits and is not
claimed as evidence here.

## Non-CFD implementation audit

- The candidate is byte-identical to the evaluated direction-conditioned
  sample (`SHA-256 2c717baeab46ef4e3b148517b6fca1d8adf4b3ac3c681d11bde166550c082d45`).
  This establishes exact reproduction of its controller source, not a new CFD
  result.
- The prescribed check-runner was invoked, but its pinned `gpt-5.4-mini` model
  is unavailable on this account and failed before executing a command. Its
  three configured checks were then run directly and separately: the material
  guidance update, finite two-acceleration Julia contract, and solver edit
  boundary all pass. A deterministic schema audit confirms that all `81`
  direct `params.FIELD` references resolve in the `82`-field object returned by
  `target_policy_params()`; only the version label is not used by the control
  algebra.
