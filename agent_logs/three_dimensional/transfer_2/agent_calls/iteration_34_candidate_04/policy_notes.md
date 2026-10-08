# Evidence-selected v41 candidate after the replicated-self-wake audit

## Visual diagnosis before candidate selection

- All four sampled solvers have byte-identical policies, `4480`-row
  trajectories, and combined keyframe sheets.  Each is a direct-uniform
  still-water run (`U_infinity=[0,0,0]`) with no cylinders or prewarm; each
  captures at `24.640015T` and `0.748356L`, with mean distance
  `2.347937L`, score `-0.448328283`, and 284 moving-window shifts.  These
  are deterministic repetitions of one v41 experiment, not four distinct
  controller mechanisms or held-out robustness evidence.
- I inspected the combined sheet from release through capture in both views.
  The top-down row begins wake-free, shows sustained self-propelled diagonal
  travel and an orderly alternating mid-plane vortex street, then forms a
  compact transverse hook through the capture disk.  The oblique row retains
  compact three-dimensional Lambda2 structures through that hook.  With zero
  background flow this is propulsion rather than advection; neither view
  shows wake breakup, collision, out-of-plane escape, or instability.
- Metrics agree with the images: the terminal head crossing has only a
  `0.001644L` margin, terminal yaw rate is `1.887 rad/T`, neither joint
  occupies a position hard stop, peak absolute planar body-force/yaw-moment
  coefficients remain in the low `0.02303/0.03169/0.01559` class, and raw
  acceleration-envelope exposure is still `73.594%`.  The result is a narrow
  dynamic capture, not a settled or unsaturated hold.
- No current sample supplies a distinct failure sheet, so a current visual
  success/failure contrast would be fabricated.  The informative inherited
  controls are v42 and v43 on the same terminal hook.  Redistributing rejected
  posterior authority to the anterior joint makes v42 cross one integration
  row earlier but worsens final/mean distance to `0.749001/2.348455L`, raises
  raw acceleration exposure to `74.124%`, and worsens score to `-0.448986`.
  V43 couples in the opposite direction by vetoing the anterior share when
  posterior safety rejects its mate; it delays capture to `24.656513T`, cuts
  crossing margin to `0.000397L`, and worsens mean distance/score to
  `2.348909L/-0.449516`.  Neither creates a better load or rate class.

## Candidate hypothesis

Keep exactly one candidate: the existing v41 terminal phase-allocation policy,
byte-identical in dynamics and parameter schema to all four sampled successful
solvers.  Preserve its state-derived anterior phase anchor, lagged posterior
traveling bend, normalized body-frame predicted-miss corridor, bounded
aligned-half-cycle terminal allocation, posterior stopping-stroke reserve,
and posterior rate coast.  Do not add an uncalibrated local-flow, force, yaw,
or cross-joint recovery branch: the sampled runs expose only the policy's own
coherent wake, while both completed cross-joint alternatives consume capture
margin without a semantic or load-class improvement.

This is an evidence-selected negative result after a semantic stall, not a
scalar-only tune and not a claim about this worker's unevaluated rollout.
Post-exit CFD should reproduce capture, the two-view coherent wake, zero
position hard-stop occupancy, and the low-load class.  Reject the selection
if nominal capture does not repeat.  A later active disturbance mechanism
requires reflected, perturbed-release, or genuinely disturbed evidence that
identifies a distinct normalized body-frame trigger and its corrective sign;
it must remain inactive before that trigger and preserve the established far
route.

bookshelf_consulted: true
source_domain: elongated-body traveling-wave propulsion, sensor-modulated robotic-fish oscillators, asymmetric turning, and wake-adaptive swimming
source_mechanism: retain an anterior-to-posterior traveling bend and apply bounded sensory phase modulation only for an evidenced persistent control error
transferable_invariant: infer propulsion phase from joint state, preserve the independent anterior phase anchor and posterior lag, and require a normalized body-frame disturbance signal with an observed corrective sign before adding feedback
nontransferable_details: published gains, dimensional cadence, prescribed duty ratios, species or robot kinematics, full-body waveforms, exact vortex phases, Strouhal targets, capture geometry, and task-specific routes
policy_translation: retain v41's mirror-equivariant predicted-miss residual, aligned-half-cycle gate, anterior anchor, posterior stopping reserve, and posterior coast; add no self-wake residual or cross-joint authority transfer without divergent evidence
falsification: reject on loss of nominal capture, coherent wake, zero hard-stop occupancy, low-load class, or the completed advantage over v42 and v43; reject a future disturbance residual if it activates before a distinct body-frame event or changes the established far route

## Evaluation boundary

Formal CFD is deferred to the post-worker evaluator.  The available fixed-case
evidence does not establish robustness to reflection, release-pose
perturbation, imposed inflow, or an external wake.

## Pre-evaluation validation

- The sole materializable candidate remains byte-identical to the four
  sampled v41 policies (LF SHA-256
  `9e6a29b253671527cc436021e572b18ba5bf6994d71936eadf98ca674753fadd`).
  No sibling candidate was created.
- The configured check-runner was invoked but its pinned `gpt-5.4-mini` model
  returned an infrastructure error, consistent with the inherited optimizer
  logs.  Its declared no-CFD checks were therefore run directly and
  separately: reusable-guidance semantics, the full-fixture Julia public
  contract, and the solver editable-boundary audit pass.  The contract returns
  finite accelerations `(-14.3858335, 0.0005062)`.
- The deterministic schema audit resolves all `87` direct `params.FIELD`
  references among the `89` fields returned by `target_policy_params()`.
  Formal CFD remains reserved for the post-worker evaluator.
