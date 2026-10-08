# Geometry-agreed course allocation

## Evidence and visual diagnosis before the policy edit

- All four sampled rollouts satisfy the frozen Phase-2 contract: direct
  uniform initialization in still water with `U_infinity=(0,0,0)`, no
  cylinders or prewarm, finite moving-window dynamics, and capture. Three are
  exact reproductions of `v37_response_exclusive_allocation`: their policy,
  trajectory, and combined keyframe hashes match, and each captures at
  `19.612991 T` with score `-0.282941223`, mean distance `2.172435105 L`, and
  final distance `0.748660505 L`.
- The sampled `v38_course_supported_response_exclusive_allocation` is a real
  but mixed semantic improvement. It raises score to `-0.271582682`, lowers
  mean distance to `2.162124221 L`, and lowers final distance to
  `0.747272313 L`. Its course correction establishes an early range advantage:
  relative to reproduced `v37`, distance is lower by about `0.040/0.127/0.131
  L` at `4/8/10 T`, and it crosses `4 L` slightly earlier at `15.614507 T`
  instead of `15.664007 T`.
- That gain does not establish an unqualified course-priority mechanism.
  `v38` reaches the `4 L` crossing more slowly (`0.8264` versus `0.8764 L/T`),
  is only level with `v37` at the `3 L` crossing, and then captures
  `0.38501 T` later. Its terminal target geometry changes qualitatively:
  body-frame target angle is about `0.021 rad` at `3 L`, then `-0.413 rad` at
  `2 L`, and the redirect gate grows to about `0.861` at `1 L`; `v37` never
  activates that redirect gate at the same crossings. Thus the outer selector
  creates a more direct early path but hands the terminal controller a
  different, strongly redirected state.
- The changed terminal state has a useful physical side. Below `4 L`, `v38`
  reduces `|action|>30 rad/T^2` incidence from `508/589` to `322/390`
  anterior/posterior samples and lowers force/moment maxima from about
  `0.02847/0.01519` to `0.02630/0.01384`. It captures at speed `0.7175 L/T`
  with modest final commands, versus `0.8679 L/T` with posterior acceleration
  at the software cap for `v37`. Global force/moment maxima nevertheless rise
  from about `0.02959/0.01558` to `0.03154/0.01678`, so lower terminal loads do
  not justify broader course authority.
- I inspected the combined and view-specific keyframe sheets for the strongest
  `v38` rollout and reproduced `v37` from release through capture. Both fish
  visibly self-propel from quiescent water along compact target-directed paths,
  retain coherent alternating top-down vortex shedding, and show finite
  localized oblique Lambda2 structures. Neither shows passive advection, a
  loop, collision, boundary-exit precursor, wake collapse, or out-of-plane
  instability. The useful distinction is allocation and approach topology,
  not loss of propulsion or wake coherence. There is no failed termination in
  the sample, so reproduced `v37` is the informative lower-score contrast.
- The current outer course support uses the magnitude of instantaneous center
  velocity cross-track error. Reconstructing its normalized body-frame inputs
  shows positive course-miss support on `876/2838` `v38` states outside `4 L`.
  The signed course cross and geometry-only target angle agree on `417` of
  those states and oppose on `459`; this near-even split is consistent with a
  fast gait-scale lateral signal being treated as an unsigned route cue. The
  selected edit tests sign agreement, not another course threshold or
  authority increase.

## Policy hypothesis

Preserve the evaluated `v38` oscillator, target guidance, posterior lag,
redirect equilibrium, closure preview, terminal intercept law, and exclusive
response/course allocator. Convert the normalized course cross from an
unsigned magnitude into a signed observation, and allow its existing outer
priority transfer only when it agrees continuously with the geometry-only
target-turn direction. The agreement scale reuses the existing normalized
centerline angle bands. No gain, cadence, mean curvature, terminal allocation,
course threshold, or acceleration authority is increased.

This is a cross-timescale consistency gate: persistent target geometry says
which direction low-frequency correction should take, while instantaneous
center course only supplies evidence that translation is departing that ray.
Opposed signs leave posterior-response coordination in control rather than
spending shared authority against a likely gait-scale lateral excursion. The
expected benefit is to retain `v38`'s early distance advantage and lower-load
terminal approach without its unnecessary alternating priority changes,
global load increase, or delayed capture. Falsify the candidate if the new
gate is dormant, changes commands at or below `4 L`, removes all useful course
allocation, loses the early range advantage, delays or loses capture, worsens
mean/final distance, raises global or terminal loads, introduces joint-stop
dwell or instability, or degrades either wake view. The new CFD evaluation
occurs only after this worker exits and is not claimed here.

bookshelf_consulted: true
source_domain: sensor-modulated coupled-oscillator robotic-fish path following and wake-interaction control
source_mechanism: separate slow target-directed steering from fast alternating lateral motion before reallocating authority away from inter-joint wave coordination
transferable_invariant: a fast transverse-motion cue should modify a bounded rhythmic controller only when its signed correction agrees with the low-frequency target geometry
nontransferable_details: published gains, dimensional cadence, species-specific kinematics, full-body waveforms, exact vortex or beat phase, actuator models, target coordinates, capture geometry, and task-specific routes
policy_translation: outside the normalized terminal band, multiply the existing course-supported exclusive priority by smooth agreement between signed normalized center-course cross and the geometry-only body-frame target angle; preserve the existing two-joint residual and response branches
falsification: reject on dormancy, loss of all course support, terminal same-state interference, loss of the early range advantage, slower or lost capture, worse distance integral, material load growth, instability, or degraded top-down or oblique wake coherence

## Non-CFD implementation audit

- Reconstructing normalized observations from the evaluated trajectories shows
  that the agreement gate changes `535` stored `v37`-trajectory states and
  `563` stored `v38`-trajectory states relative to the evaluated unsigned
  `v38` law, with maximum same-state differences of about `1.411` and `1.440
  rad/T^2`. The candidate also remains distinct from reproduced `v37` on `328`
  stored states of the `v38` trajectory, with a maximum difference of about
  `2.810 rad/T^2`; it therefore narrows rather than deletes course support.
  Every stored state at or below `4 L` is exactly identical to both parents.
- A deterministic `95,256`-state grid spanning range, target angle, course
  angle, translation speed, both joint positions, and both joint velocities
  has `12,772` cases changed from `v38`. All candidate outputs are finite and
  within the declared acceleration limit. All `47,628` states at or below
  `4 L` and all `23,814` zero-translation states are exactly `v38`-identical.
  These checks establish activity, boundedness, and same-state
  noninterference, not coupled-flow improvement.
- The deterministic parameter-schema audit resolves all `87` direct
  `params.FIELD` references in the `88`-field object returned by
  `target_policy_params()`; only the version label is intentionally unused.
  The material-guidance, lightweight Julia two-output contract, and solver
  edit-boundary checks pass.
- The prescribed check-runner was invoked, but its pinned `gpt-5.4-mini`
  model is unsupported on this ChatGPT account and failed before executing a
  command. Its three configured non-CFD checks were therefore run directly and
  separately. The guidance check initially found the inherited duplicate
  assigned-parent marker in the rendered root `README.md`; removing only that
  duplicate repaired parent resolution, and the rerun passes. No formal CFD
  was run in this workspace.
