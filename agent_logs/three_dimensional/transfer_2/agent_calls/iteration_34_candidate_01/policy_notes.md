# Evidence-selected v41 candidate after repeated nominal aliasing

## Visual diagnosis before candidate selection

- All four sampled solver policies, `4480`-row trajectories, and combined
  keyframe sheets are byte-identical.  Each is a direct-uniform still-water
  rollout (`U_infinity=[0,0,0]`) without cylinders or a prewarm snapshot and
  captures at `24.640015T` and `0.748356L`, with mean distance
  `2.347937L`, score `-0.448328283`, and 284 moving-window shifts.  The four
  copies therefore represent one deterministic nominal condition, not four
  distinct hydrodynamic responses or held-out robustness evidence.
- I inspected the release-to-capture sequence in both required views.  The
  top-down row starts wake-free, develops an orderly alternating mid-plane
  street during sustained diagonal self-propulsion, and finishes with a
  compact transverse hook through the target disk.  The oblique row retains
  compact three-dimensional Lambda2 structures through that hook.  Because
  the background velocity is zero, the approach is self-propelled rather than
  passive advection; neither view shows wake breakup, out-of-plane escape,
  collision, or numerical instability.
- The trace supports the visual diagnosis: no joint occupies a position hard
  stop, peak absolute planar body-force/yaw-moment coefficients remain in the
  low `0.02303/0.03169/0.01559` class, and the terminal crossing margin is
  `0.001644L`.  The result is nevertheless a narrow dynamic capture: terminal
  yaw rate is `1.887 rad/T`, any-joint exact-rate exposure is about `13.84%`,
  and raw acceleration-envelope exposure is `73.59%`.
- No sampled solver supplies a distinct failure keyframe sheet, so a visual
  success/failure contrast cannot be manufactured.  The informative completed
  controls are inherited metric/trace contrasts on the same terminal hook:
  v42's posterior-to-anterior headroom redistribution crosses one row earlier
  but worsens final/mean distance to `0.749001/2.348455L`, score to
  `-0.448986`, and raw acceleration exposure to `74.124%`; v43's opposite
  coupled anti-windup choice captures later at `24.656513T`, reduces crossing
  margin to `0.000397L`, and worsens mean distance/score to
  `2.348909L/-0.449516`.  Older broad rate and reference-velocity phase
  corrections lower saturation statistics but change the route and lose
  capture.

## Candidate hypothesis

Keep exactly one candidate: the prefilled v41 terminal phase-allocation policy,
byte-identical in dynamics and parameter schema to the four sampled captures.
It retains the observed-state anterior phase anchor, lagged posterior traveling
bend, normalized body-frame projected-miss corridor, bounded half-cycle
steering allocation, posterior stopping-stroke reserve, and posterior rate
coast.  Do not add a nominally dormant branch, a force/flow/yaw residual, a
scalar terminal tune, or cross-joint authority recovery: the present fixed
case supplies no distinct trigger from which to calibrate one, while the
completed nearby controls either consume the narrow margin or destroy the
captured route.

This is an evidence-selected negative transfer result, not a same-worker CFD
claim.  Post-exit evaluation should reproduce capture, the coherent two-view
wake, zero hard-stop occupancy, and the low-load class.  Reject the selection
on nominal non-replication.  Reopen active mechanism search only when a
reflected pose, perturbed release, or genuinely disturbed rollout supplies a
distinct normalized body-frame trigger and sign; reject any later residual if
it activates before that trigger or changes the established far route.

bookshelf_consulted: true
source_domain: elongated-body traveling-wave propulsion, sensor-modulated coupled-oscillator robotic-fish control, and asymmetric fish turning
source_mechanism: retain an observed anterior-to-posterior traveling bend and spend bounded sensory steering only on a compatible joint-state half-cycle after a measured route error exists
transferable_invariant: preserve the anterior phase anchor and posterior lag, and require any new correction to be localized by an evidenced normalized body-frame error rather than replication count
nontransferable_details: published gains, dimensional cadence, prescribed duty ratios, species or robot kinematics, full-body waveforms, exact vortex phases, Strouhal targets, fixed capture geometry, and task-specific routes
policy_translation: retain v41's mirror-equivariant projected-miss residual, lagged-wave phase gate, independent anterior anchor, posterior stroke reserve, and posterior coast; add no uncalibrated self-wake residual or cross-joint authority transfer
falsification: reject if nominal replication loses capture, coherent wake, zero hard-stop occupancy, low-load class, or the completed advantage over v42 and v43; reject a future mechanism if it activates without a distinct body-frame trigger or removes necessary correction on a held-out route

## Evaluation boundary

Formal CFD is deferred to the post-worker evaluator.  The current evidence
supports retaining the single materializable candidate but does not establish
robustness to reflection, release-pose perturbation, imposed inflow, or an
external wake.

## Pre-evaluation validation

- The single materializable candidate remains LF SHA-256
  `9e6a29b253671527cc436021e572b18ba5bf6994d71936eadf98ca674753fadd`,
  byte-identical to every current sampled v41 policy.  No sibling candidate
  was created.
- The configured check-runner was invoked, but its pinned `gpt-5.4-mini`
  model is unsupported on this account.  Its three declared no-CFD checks
  were therefore run directly and separately after removing the duplicate
  assigned-parent marker from the rendered workspace README.  The reusable
  guidance check, public Julia policy contract, and solver editable-boundary
  audit pass; the contract returns finite accelerations
  `(-14.3858335, 0.0005062)`.
- The deterministic schema audit resolves all `87` direct `params.FIELD`
  references among the `89` fields returned by `target_policy_params()`.
  Formal CFD remains reserved for the post-worker evaluator.
