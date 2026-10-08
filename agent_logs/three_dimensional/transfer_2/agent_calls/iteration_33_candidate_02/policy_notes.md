# Evidence-selected v41 candidate after the source-transfer audit

## Visual diagnosis before candidate selection

- All four sampled solver policies, `4480`-row trajectories, and combined
  keyframe sheets are byte-identical.  Each uses direct uniform still-water
  initialization (`U_infinity=[0,0,0]`) without cylinders or prewarm, captures
  at `24.640015T` and `0.748356L`, has mean distance `2.347937L` and score
  `-0.448328283`, and performs 284 moving-window shifts.  This is deterministic
  fixed-case replication of v41, not four distinct mechanisms or held-out
  robustness evidence.
- I inspected the combined sheet from release through capture in both views.
  The top-down row begins wake-free, shows sustained self-propelled diagonal
  progress and a coherent alternating mid-plane street, then a compact
  transverse hook through the capture disk.  The oblique row retains compact
  three-dimensional Lambda2 structures throughout the hook.  With zero
  background flow this motion is not passive advection; there is no visible
  wake breakup, out-of-plane escape, collision, or numerical instability.
- The trace agrees with the images.  Neither joint occupies a position hard
  stop; peak absolute planar body-force/yaw-moment coefficients are only
  `0.02303/0.03169/0.01559`; and the terminal crossing margin is
  `0.001644L`.  Raw acceleration-envelope exposure remains `73.594%`, so the
  result is a dynamically narrow crossing, not a settled or unsaturated hold.
- No sampled solver has a failed termination or distinct sheet, so a visual
  success/failure comparison is unavailable and must not be manufactured.
  The informative failures are inherited trace-level mechanism controls:
  v42's posterior-to-anterior headroom redistribution crosses one row earlier
  but worsens final/mean distance to `0.749001/2.348455L`, raises raw
  acceleration exposure to `74.124%`, and worsens score to `-0.448986`; v43's
  coupled anti-windup veto captures later at `24.656513T`, consumes crossing
  margin to `0.000397L`, and worsens mean distance/score to
  `2.348909L/-0.449516`.  Older dual-joint rate barriers and posterior
  reference-velocity feedforward lower saturation statistics but change the
  established route and lose capture.

## Candidate hypothesis

Keep exactly one candidate: the current v41 terminal phase-allocation policy,
byte-identical in dynamics and parameter schema to all four sampled rollouts.
Preserve its observed-state anterior phase anchor, lagged posterior traveling
bend, normalized body-frame projected-miss corridor, bounded half-cycle
steering allocation, posterior stopping-stroke reserve, and posterior rate
coast.  Do not add flow/force/yaw rejection, approach hold, scalar gain, or
cross-joint authority recovery: the current rollout exposes only coherent
self-wake, while completed nearby controls either consume the narrow capture
margin or destroy the captured route.

This is a concrete negative transfer result and evidence selection, not a
same-worker CFD claim or an assertion of semantic improvement.  Post-exit CFD
should reproduce capture, the coherent two-view wake, zero position hard-stop
occupancy, and the low-load class.  Reject the selection on nominal
non-replication.  A later active mechanism requires reflected, perturbed-pose,
or genuinely disturbed evidence that supplies a divergent normalized
body-frame trigger and a calibrated sign; it must remain null before that
trigger appears on the established route.

bookshelf_consulted: true
source_domain: elongated-body traveling-wave propulsion, asymmetric robotic-fish turning, and sensor-modulated approach control
source_mechanism: retain a stable anterior-to-posterior traveling bend and add bounded phase or disturbance feedback only for a diagnosed measured error
transferable_invariant: preserve the observed anterior phase anchor and posterior lag, and localize any added correction with a normalized body-frame error whose sign and scale are evidenced by a divergent rollout
nontransferable_details: published gains, dimensional cadence, prescribed duty ratios, species or robot kinematics, full-body waveforms, exact vortex phases, Strouhal targets, capture geometry, and task-specific routes
policy_translation: retain v41's mirror-equivariant projected-miss residual, lagged-wave phase gate, anterior anchor, posterior stroke reserve, and posterior coast; add no uncalibrated self-wake residual or cross-joint authority transfer
falsification: reject if nominal replication loses capture, coherent wake, zero hard-stop occupancy, low-load class, or the completed advantage over v42 and v43; reject a future residual if it activates before a new body-frame disturbance or removes necessary correction on held-out poses

## Evaluation boundary

Formal CFD is deferred to the post-worker evaluator.  The current evidence
supports the retained single candidate but does not establish robustness to
reflection, release-pose perturbation, imposed inflow, or external wakes.

## Pre-evaluation validation

- The single materializable candidate remains byte-identical to the four
  sampled v41 policies (LF SHA-256
  `9e6a29b253671527cc436021e572b18ba5bf6994d71936eadf98ca674753fadd`).
  No sibling candidate was created.
- The configured check-runner was invoked, but its pinned `gpt-5.4-mini`
  model is unsupported on this account.  Its three declared no-CFD checks
  were therefore run directly and separately.  The reusable-guidance check,
  public Julia policy contract, and solver editable-boundary audit pass; the
  contract returns finite accelerations
  `(-14.3858335, 0.0005062)`.
- The deterministic schema audit resolves all `87` direct `params.FIELD`
  references among the `89` fields returned by `target_policy_params()`.
  Formal CFD remains reserved for the post-worker evaluator.
