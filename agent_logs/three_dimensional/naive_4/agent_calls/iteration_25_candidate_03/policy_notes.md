# Carrier-residual crossflow wave-shaping candidate

## Evidence diagnosis before the policy edit

- All four sampled evaluations satisfy the frozen contract: direct uniform
  still-water initialization with `U_infinity=(0,0,0)`, no prewarm or
  cylinders, finite dynamics, and capture at `16.054375T` after 2,919 steps
  and 239 moving-window shifts. I inspected the combined sheets for the
  highest-scoring total line-of-sight damper (`solver_8474fe870fa5`) and the
  lowest-scoring terminal phase-relief sample (`solver_a03406b458eb`). In both
  the top-down vorticity and oblique body/Lambda2 rows, both fish self-propel
  along the same smooth target-directed arc and retain a coherent alternating
  three-dimensional wake through capture. There is no passive advection,
  standing wiggle, wake breakup, collision, virtual exit, or instability.
- The four outcomes have the same capture step, every sampled
  `8/6/4/2/1.75/1.25/0.9/0.8L` milestone, 239 shifts, `49.20/21.86%`
  anterior/posterior acceleration-limit residence, and visually equivalent
  wake sheets. Their differences are terminal-scale: the sampled net
  line-of-sight damper is best at final distance `0.745854L`, distance
  integral `1.929846L`, and score `-0.046908`; the separate yaw-plus-slip
  parent reaches `0.745869L`, `1.929859L`, and `-0.046924`. Adding
  slip-conditioned terminal wave relief changes the latter only to
  `0.745867L`, `1.929858L`, and `-0.046923`, while bearing-rate-conditioned
  terminal relief regresses to `0.745940L`, `1.929919L`, and `-0.046998`.
  Further terminal thresholds or phase allocation are not supported as a new
  physical trajectory mechanism.
- The strongest trace supplies a distinct hydrodynamic observation. Over the
  established cruise (`distance > 2L`), normalized anterior position and
  velocity explain `92.2%` of body-frame relative-crossflow variance with
  coefficients `0.28` and `0.66`; the carrier-residual crossflow has standard
  deviation `0.103U` and 95th-percentile magnitude `0.188U`. In the middle
  `2-8L` segment, target-signed residual crossflow and carrier-residual yaw
  opposing the requested redirect coincide on `41.5%` of samples. The
  reconstructed posterior wave opposes the requested turn on `81.5%` of
  those jointly supported samples. This motivates a response-confirmed wave
  attenuation test, not indiscriminate crossflow cancellation.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: wake-adaptive biological swimming and sensor-modulated robotic-fish control
source_mechanism: separate a repeatable propulsive carrier from measured flow response, then reduce only the rhythmic action that reinforces an adverse response
transferable_invariant: preserve persistent target-directed mean steering and the traveling-wave carrier while a carrier-residual hydrodynamic signal selectively yields the counterproductive wave lobe
nontransferable_details: Karman-gait routes, organized-vortex phase locking, published gains, dimensional frequencies, species-specific envelopes, exact vortex phases, morphology, and task-specific coordinates
policy_translation: subtract the evidenced normalized anterior-joint carrier model from body-frame relative crossflow; before the established terminal approach and only during a reliable redirect with measured yaw opposition, use target-signed residual crossflow to attenuate the posterior wave lobe that opposes the redirect, without amplifying either lobe or changing mean curvature
falsification: reject if the term changes action without jointly supported residual crossflow and yaw opposition, attenuates the aiding wave lobe, disrupts the coherent two-view wake, delays or loses capture, regresses any pre-terminal milestone or distance integral, or trades lower limiting for worse target progress

## One candidate hypothesis

Start from the strongest sampled net line-of-sight terminal damper and preserve
its oscillator, response-conditioned mean redirect, yaw-residual correction,
approach scaffold, redirect handoff, acceleration allocator, and exact speed-
boundary projection. Add one mid-route hydrodynamic feedback mechanism. Infer
the repeatable relative-crossflow carrier from normalized anterior joint
state. Before the established terminal approach, when its residual is target-
signed, measured carrier-residual yaw still opposes a reliable redirect, and
the posterior wave itself opposes that turn, attenuate only that posterior
lobe by a bounded amount. Mean steering is unchanged, the aiding lobe is
unchanged, neither lobe is amplified, and all signals are instantaneous
normalized body-frame observations.

Expected evidence is a route-level difference rather than another last-beat
perturbation: at least one earlier `8/6/4/2L` milestone or a lower distance
integral, retained capture and two-view wake coherence, and no material load or
limit-residence increase. The new CFD result is unavailable to this worker and
is not claimed here.

## Non-CFD verification after the edit

- Candidate SHA-256:
  `f6fd2662a2e545e15cd722eeeca185913304c726c29ebe84ee00f1edb2bff086`.
  All 52 direct `params.FIELD` references are present among the 52 fields
  returned by `target_policy_params()`.
- The lightweight contract probe returns two finite accelerations. A
  deterministic sweep of 3,240 paired states across target side/distance,
  course, crossflow, yaw response, and joint phase stays within the
  `31.416 rad/T^2` envelope, has zero numerical lateral-reflection error,
  rejects outward acceleration at the exact joint-speed boundary, and keeps a
  finite fallback for non-finite target/flow observations.
- Counterfactual evaluation on reconstructed states from the strongest sampled
  trace changes only posterior action on 78 rows. The first difference is at
  `3.108T`, `11.967L`; 17 changed rows occur before the `2L` crossing, and the
  mechanism has no changed action at or below `0.8L`, where the sampled net
  line-of-sight terminal law remains intact. Maximum posterior action change is
  bounded at `8.442 rad/T^2`; every anterior action is unchanged. This verifies
  nonterminal feasible-action support, not an unevaluated closed-loop result.
- The configured check-runner was invoked, but its pinned `gpt-5.4-mini` model
  is unavailable for this account. Its three prescribed commands were then
  run directly and separately: the material guidance/notes check, lightweight
  Julia contract, and solver editable-boundary check pass; the deterministic
  schema guard also passes. No CFD was run.
