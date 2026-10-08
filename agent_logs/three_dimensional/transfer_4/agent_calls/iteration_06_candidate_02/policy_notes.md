# Wake-policy candidate notes

## Evidence diagnosis before editing

All four sampled solver evaluations satisfy the Phase-2 contract: direct
uniform still-water initialization with `U_infinity=(0,0,0)`, no cylinders or
prewarm, and complete combined top-down vorticity and oblique Lambda2 sheets.
Three byte-identical rate-governor policies reproduce the strongest sampled
capture (`23.3640T`, score `-0.51274776`); the prefilled controller also
captures but scores `-0.51527750`. No current sample is a semantic failure, so
the prefill is the finite visual contrast and the inherited lower-boundary
exit remains the informative route failure.

- Both current visual rows show self-propulsion rather than advection: a
  compact alternating caudal wake develops by `4T`, remains coherent through
  the transit, and bends with the fish during the late target turn. The two
  current policies have no visible wake collapse, terminal overshoot,
  collision, or out-of-plane instability. The assigned parent's newly
  evaluated soft-injection envelope has the same useful wake topology, so
  actuator softening did not create a new useful trajectory.
- The sampled rate governor remains the best controller. Relative to the
  prefill it improves mean score-distance from `2.412601L` to `2.409486L`,
  shortens center path from `13.4189L` to `13.3177L`, and removes sampled
  `99.9%` joint-rate-limit residence without materially changing the wake.
- The assigned-parent soft-injection envelope did reduce acceleration-ceiling
  residence from `69.61/50.68%` to `53.59/35.17%`, but it delayed capture by
  `0.2200T`, lengthened path to `13.4414L`, increased mean score-distance to
  `2.431383L`, and worsened score to `-0.53380988`. Inherited sibling phase-load
  gating and shared velocity damping likewise retained capture but scored
  `-0.53312008` and `-0.53004112`. Acceleration residence is therefore not a
  useful primary objective for this established gait; further soft gates would
  repeat a falsified direction.
- The best rollout still has a route-level defect that those actuator edits do
  not address. Once moving faster than `0.05L/T`, mean target-course alignment
  is only `0.8206`, alignment is below `0.85` for `38.96%` of samples, and the
  head bows as far as `2.0139L` from its initial target line. Its course error
  changes sign during the transit, so a fixed steering bias or memorized route
  would be inappropriate; the useful signal is signed body-frame target versus
  velocity direction.

## Policy hypothesis

Start from the demonstrated rate-governor policy, preserving its normalized
target geometry, same-sign odd mean curvature, half-cycle steering,
course-conditioned terminal cadence, state-feedback traveling wave, and
direction-selective rate protection. Add one route mechanism: form the signed
normalized cross product between body-frame target direction and observed
swimming-velocity direction, smoothly activate it with measured speed, and add
the bounded residual to the geometric turn request. The residual is odd under
lateral reflection and vanishes when the course points at the target; it has no
world-frame direction, clock, stage, or stored route.

This should reduce the broad cross-track bow and distance integral without
weakening propulsion or altering the posterior traveling wake. Falsify it if
capture is lost, arrival or score-distance worsens materially, peak loads or
joint-limit residence rise, target-course alignment and cross-track error do
not improve, or either visual row loses the compact alternating wake. The new
candidate has not yet been evaluated and is not evidence of improvement.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop direction tracking and CPG path following
source_mechanism: retain the rhythmic propulsive carrier while target-relative course error supplies a bounded steering residual
transferable_invariant: compare desired and observed swimming directions in the body frame and feed their signed normalized mismatch into mean turning without replacing the traveling wave
nontransferable_details: published gains, dimensional cadence, robot or species kinematics, full-body waveforms, exact vortex phase, and task-specific routes
policy_translation: add a speed-gated cross product of normalized `target_body_L` and `velocity_body_U` directions to the two-joint controller's existing odd turn request while retaining the sampled rate governor
falsification: reject if capture, distance integral, path, load scale, actuator residence, course alignment, cross-track error, or top-down and oblique wake coherence worsen
