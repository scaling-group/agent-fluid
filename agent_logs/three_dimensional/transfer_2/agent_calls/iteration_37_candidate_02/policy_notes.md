# Evidence-selected v41 candidate after the repeated semantic-stall audit

## Visual diagnosis before candidate selection

- The four sampled solver policies, trajectories, and combined keyframe sheets
  are byte-identical.  The assigned parent adds three more completed v41
  rollouts with the same policy and score.  Each direct-uniform still-water run
  captures at `24.640015T` and `0.748356L`, with mean distance `2.347937L`,
  score `-0.448328283`, and 284 moving-window shifts.  These are seven nominal
  replicas of one fixed-case response, not seven independent wake encounters.
- I inspected the combined release-to-capture sheet in both required views.
  The top-down row starts wake-free, develops a coherent alternating street
  behind sustained diagonal motion, and ends in a compact transverse hook
  through the capture disk.  The oblique Lambda2 row retains compact
  three-dimensional wake structures through the same hook.  With
  `U_infinity=[0,0,0]`, no cylinders, and no prewarm snapshot, the trajectory
  is self-propelled rather than passively advected; neither view shows wake
  breakup, out-of-plane escape, collision, or numerical instability.
- The trace agrees with the images: zero joint-position hard-stop occupancy,
  low peak absolute planar body-force/yaw-moment coefficients
  (`0.02303/0.03169/0.01559`), and a coherent capture.  The result remains a
  narrow dynamic crossing: margin is only `0.001644L`, terminal yaw rate is
  `1.887 rad/T`, and raw acceleration-envelope exposure is `73.594%`.
- No sampled or assigned-parent rollout contains a distinct failure sheet, so
  a visual success/failure contrast cannot be manufactured.  The informative
  inherited completed controls are trace-level contrasts: v42 transfers
  rejected posterior authority to the anterior anchor and worsens final/mean
  distance to `0.749001/2.348455L`, score to `-0.448986`, and raw acceleration
  exposure to `74.124%`; v43 vetoes the anterior share and reduces crossing
  margin to `0.000397L` while worsening mean distance/score to
  `2.348909L/-0.449516`.  Older broad rate barriers and posterior
  reference-velocity feedforward lower saturation statistics but lose the
  captured route.

## Candidate hypothesis

Keep exactly one candidate: the prefilled v41 terminal phase-allocation policy,
byte-identical in dynamics and parameter schema to the seven completed nominal
replicas.  It preserves the state-feedback anterior phase anchor, lagged
posterior traveling bend, normalized body-frame projected-miss corridor,
bounded half-cycle steering allocation, posterior stopping-stroke reserve, and
posterior rate coast.  The semantic-stall bookshelf audit does not justify a
new controller mechanism: traveling-wave propulsion, target steering,
phase-selective asymmetry, and approach scheduling are already represented,
while wake rejection lacks any distinct disturbance observation in the
available evidence.  Adding a gain-only variation, an uncalibrated wake
residual, or another cross-joint authority transfer would contradict the
completed controls rather than test an evidenced deficiency.

This is a concrete negative transfer result and evidence selection, not a
same-worker CFD claim.  Post-exit evaluation should reproduce capture, the
coherent two-view wake, zero hard-stop occupancy, and the low-load class.
Reject the candidate on nominal non-replication.  Reopen active mechanism
search only when a reflected pose, perturbed release, or genuinely disturbed
rollout supplies a distinct normalized body-frame trigger and calibrated sign;
require the new branch to remain null before that trigger and preserve the far
route.

bookshelf_consulted: true
source_domain: elongated-body propulsion, sensor-modulated robotic-fish oscillators, asymmetric turning, terminal approach control, and wake interaction
source_mechanism: preserve a traveling anterior-to-posterior bend and spend bounded phase-selective feedback only after a measured target or disturbance error exists
transferable_invariant: retain the anterior phase anchor and posterior lag, and require any new correction to be localized by a distinct normalized body-frame error with an evidenced sign and scale
nontransferable_details: published gains, dimensional cadence, duty ratios, species or robot kinematics, full-body waveforms, exact vortex phases, Strouhal targets, capture geometry, and task-specific routes
policy_translation: retain v41's mirror-equivariant projected-miss residual, lagged-wave phase gate, independent anterior anchor, posterior stroke reserve, and posterior coast; do not manufacture an unobserved disturbance residual from repeated nominal replicas
falsification: reject on loss of nominal capture, coherent wake, zero hard-stop occupancy, low-load class, or the established advantage over v42 and v43; reject a future residual if it activates without a distinct body-frame disturbance or changes the captured far route

## Evaluation boundary

Formal CFD is deferred to the post-worker evaluator.  Current evidence supports
this single fixed-case candidate but does not establish robustness to
reflection, release-pose perturbation, imposed inflow, or an external wake.

## Pre-evaluation validation

- The single materializable candidate is non-empty and remains LF SHA-256
  `9e6a29b253671527cc436021e572b18ba5bf6994d71936eadf98ca674753fadd`,
  byte-identical to every sampled v41 policy.  No sibling candidate was
  created.
- The configured check-runner was invoked, but its pinned `gpt-5.4-mini` model
  is unsupported on this account.  Its declared no-CFD checks were therefore
  run directly and separately after removing the duplicate assigned-parent
  marker from the rendered workspace README.  The reusable-guidance check,
  Julia public-contract check, and solver editable-boundary audit pass; the
  contract returns finite accelerations
  `(-14.3858335, 0.0005062)`.
- The deterministic schema audit resolves all `87` direct `params.FIELD`
  references among the `89` fields returned by `target_policy_params()`.
  Formal CFD remains reserved for the post-worker evaluator.
