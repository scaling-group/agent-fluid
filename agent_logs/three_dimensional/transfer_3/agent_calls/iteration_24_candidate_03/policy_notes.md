# Posterior-response-conditioned outer limiter coupling

## Evidence and visual diagnosis before the policy edit

- All four sampled rollouts satisfy the frozen experiment contract: direct
  uniform initialization in still water with `U_infinity=(0,0,0)`, no
  cylinders or prewarm, finite moving-window dynamics, and capture. Three are
  byte-identical evaluations of the prefilled `v34` direction-conditioned
  limiter and reproduce exactly: capture at `21.912008 T`, score
  `-0.3246592933`, mean distance `2.218947189 L`, and final distance
  `0.747680604 L`. This is strong reproduction of the assigned parent's
  semantic improvement rather than three distinct mechanisms.
- I inspected the complete combined keyframe sheets for a reproduced `v34`
  result and the sampled `v35` rate-headroom contrast, including the top-down
  mid-plane vorticity and oblique body/Lambda2 rows from release through
  capture. Both fish self-propel from quiescent flow along the same compact
  target-directed arc, establish a coherent alternating posterior wake, retain
  finite localized three-dimensional wake structures, and enter a quiet
  held-bend terminal glide. Neither view shows passive advection, a loop,
  collision, boundary-exit precursor, wake collapse, or out-of-plane
  instability. The rate-headroom change is below sheet resolution, so its
  trajectory and actuator telemetry provide the negative contrast.
- `v35` stacks the previously sampled `5%` common attenuation when either
  joint has little rate headroom and its acceleration points farther outward.
  It still captures, but one step block later at `22.038506 T`; score regresses
  to `-0.3276334301`, mean distance to `2.222065709 L`, and final distance to
  `0.748223662 L`. Exact posterior acceleration-cap incidence falls from
  `40.54%` to `33.99%`, yet exact posterior rate-cap incidence rises from
  `7.41%` to `7.64%`; below `4 L`, the coupled trajectory now reaches about
  `30.42 rad/T^2` posterior acceleration rather than the reproduced parent's
  `21.82 rad/T^2`. Lower acceleration clipping therefore neither reduced rate
  contact nor improved the captured trajectory. Do not stack more rate-only
  attenuation or treat saturation counts as a proxy objective.
- The surviving signal is coordinated command geometry. The reproduced
  `v34` improvement came from retaining the established `12%` common-scale
  floor and adding at most six percentage points only when independent
  clipping rotated the requested two-joint acceleration. The wake remains
  productive despite posterior envelope contact. A next intervention should
  condition that same mechanism on the realized posterior response rather
  than weaken both commands merely because one observed rate is large.

## Policy hypothesis

Preserve the reproduced state-feedback oscillator, target-angle redirect,
posterior lag, base and direction-conditioned common limiter, closure preview,
shared terminal mean bend, crossflow/settled-response support, center-intercept
corridor, and paired terminal release. Add one outer-only response condition
to the existing limiter: normalize the posterior error from its current
state-feedback tail target by the declared drive amplitude, and permit one
small additional move toward common scaling only when both this realized lag
error and raw-versus-clipped command-direction distortion are present.

This is a feedback-structure test of traveling-bend coordination, not a scalar
gain increase and not another rate-headroom guard. It introduces no clock,
route, world coordinate, target identity, reconstructed derivative, cadence
change, force cancellation, mean-bend change, beat-side selector, or terminal
authority. The existing normalized distance gate makes the new contribution
exactly zero at and below `4 L`. Falsify it if stored-state checks show terminal
interference, nonfinite or over-limit output, or excessive outer command loss;
later CFD should reject it on delayed or lost capture, worse distance integral,
changed compact path, degraded top-down or oblique wake coherence, joint-stop
dwell, material load growth, or instability.

bookshelf_consulted: true
source_domain: classical traveling-wave and elongated-body propulsion together with sensor-modulated coupled-oscillator robotic-fish control
source_mechanism: preserve an anterior-to-posterior traveling bend by coupling rhythmic joints while sensor feedback corrects loss of the desired posterior phase response
transferable_invariant: actuator limiting should preserve coordinated command direction most strongly when observed joint response shows the posterior member departing from its state-feedback lag target
nontransferable_details: published gains, dimensional cadence, species-specific amplitude envelopes, full-body waves, exact phase lags, actuator models, vortex phases, capture geometry, and task-specific routes
policy_translation: use posterior target-tracking error normalized by drive amplitude together with the existing dimensionless clipping-angle signal to gate one bounded extra common-scale contribution outside the normalized terminal band
falsification: reject on terminal-command interference, excessive carrier reduction, slower or lost capture, worse distance integral, changed path or mean bend, renewed stop dwell, material load growth, instability, or degraded top-down or oblique wake coherence

The new candidate's CFD evaluation occurs only after this worker exits and is
not claimed as evidence here.

## Non-CFD implementation audit

- Comparing the candidate against the byte-identical reproduced `v34` parent
  on 3,240 deterministic states gives bit-identical commands for every tested
  state at or below `4 L`. The response gate changes 804 outer test states,
  with a maximum command difference of `0.6991 rad/T^2`; every result is finite
  and remains inside the declared acceleration limit. Direct limiter probes
  confirm smooth bounded activation and sign symmetry. These checks establish
  implementation activity and terminal noninterference, not a coupled-flow
  improvement.
- The material-guidance check, full finite two-output Julia contract, solver
  edit-boundary check, and deterministic parameter-schema guard pass. All 84
  direct `params.FIELD` references resolve in the 85-field object returned by
  `target_policy_params()`; only the version label is intentionally unused by
  the control algebra.
- The prescribed check-runner was invoked, but its pinned `gpt-5.4-mini` model
  is unavailable on this account and failed before executing a command. Its
  three configured non-CFD checks were therefore run directly and separately.
  The guidance check first exposed the inherited duplicate assigned-parent
  marker in `README.md`; removing only that duplicate repaired the comparison.
