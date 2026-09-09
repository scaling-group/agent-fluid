# Multi-wake target-policy diagnosis and hypothesis

## Evidence diagnosis before editing

- All four sampled solver episodes satisfy the frozen direct-uniform contract:
  still water with `U_infinity=(0,0,0)`, no cylinders or prewarm, finite
  moving-window transport, and capture termination. The two executable-
  identical redistribution policies capture at `18.8265--18.8815T` with
  score-defined mean distance `2.08855--2.08896L`; the clean-envelope
  ablation captures at `18.6010T` and `2.09042L`; and the rearward composition
  captures at `18.9640T` and `2.09072L` without exercising its rearward branch.
  The score spread is therefore repeatability evidence, not a distinct
  semantic improvement.
- I inspected both rows of all four sampled combined keyframe sheets from
  direct release through first crossing. Each top-down row grows a coherent
  alternating target-bending street, and each oblique row retains compact
  bilateral and caudal Lambda2 structures. With zero background flow their
  translation is self-propelled rather than advected. No sampled sheet shows
  collision, wake collapse, domain exit, or numerical instability.
- Sampled diagnostics agree with the visual comparison. The redistribution,
  clean, and unexercised-recovery captures contact the anterior/posterior
  acceleration limit on `60.85--61.17%`/`72.95--73.27%` of samples and the
  joint-rate limit on `10.88--11.07%`/`14.73--14.96%`; peak planar force is
  `0.03066--0.03259` and peak yaw moment is `0.01603--0.01656`. Thus coherent
  capture still carries structural rhythmic demand, and neither envelope
  choice nor the inactive recovery branch is actuator relief.
- The assigned parent's newly evaluated common radial allocator supplies the
  informative failure contrast. I inspected its direct-uniform combined
  sheet: instead of the sampled alternating street, the early top-down wake is
  weak and becomes a broad smeared turn, while the oblique row lacks the
  sustained compact caudal sequence. It improves distance only from
  `12.3277L` to `11.5409L`, then exits left at `9.702T` and `11.8262L`.
  Lower acceleration contact (`19.54%`/`42.87%`), zero rate contact, and lower
  peak force/moment (`0.01905`/`0.00950`) diagnose lost propulsion and steering,
  not useful demand relief. Scaling the anterior phase generator whenever the
  posterior request dominates is therefore rejected.
- A second inherited direct-uniform failure closes response-gate repetition.
  Target-bearing-window release captures once at `18.7220T` with mean distance
  `2.09370L`, but the semantically identical replacement later retains an
  energetic alternating two-view wake, reaches only `1.4437L`, and exits left
  at `30.938T` and `8.9897L`. Bearing progress is a useful diagnostic, not a
  robust replacement for the sampled yaw-release gate. Inherited evidence also
  rejects velocity-based steering phase, posterior phase voting, posterior-
  only gait allocation, rate barriers, terminal compounds, target-axis
  filtering, and stacked broadside/rearward recovery.

## Structured bookshelf transfer

bookshelf_consulted: true
source_domain: coupled-oscillator robotic-fish control together with Taylor/Lighthill traveling-wave propulsion
source_mechanism: regulate a low-dimensional rhythmic oscillator as a bounded state-dependent limit cycle while retaining a directed posterior-lagged traveling bend
transferable_invariant: use normalized displacement-velocity energy to stop injecting propulsive energy when the observed joint cycle is already energetic, without changing target-owned turn sign or the interjoint lag law
nontransferable_details: published oscillator gains, dimensional cadence, species or robot kinematics, full-body envelopes, muscle models, exact vortex phases, world coordinates, and task-specific routes
policy_translation: replace only the anterior Van-der-Pol displacement-only energy injection with normalized phase-plane energy regulation; preserve body-lateral route sign, non-inverting yaw response release, anterior-displacement half-cycle steering, common-envelope redistribution, differential curvature, posterior lag, and independent final acceleration projection
falsification: reject if capture or either coherent wake row is lost, the early weak/smeared allocator wake or a downward near-miss/left-exit topology recurs, arrival or mean distance leaves sampled spread without material demand/load relief, or acceleration and rate contact fail to decrease

## Exactly one candidate hypothesis

The candidate tests one feedback mechanism: phase-plane energy regulation of
the anterior oscillator. The current Van-der-Pol term decides whether to inject
energy from centered displacement alone, so it still adds energy near a joint
zero crossing even when normalized joint speed is already high. The new radial
coordinate is the sum of squared centered displacement and normalized velocity.
It injects only below the parameter-owned target energy and damps above it.
Velocity therefore regulates carrier energy but does not vote on steering
phase, which remains centered anterior displacement only.

Everything downstream remains the sampled redistribution carrier: normalized
body-lateral target geometry, one-sided yaw response release, non-inverting
differential curvature, displacement half-cycle steering and envelope
redistribution, posterior lag, and independent exact final clipping. This adds
no flow/force residual, recovery or terminal branch, explicit time, step,
world coordinate, mutable state, or memorized phase. Formal CFD occurs only
after handoff, so no outcome is claimed for this unevaluated candidate.
