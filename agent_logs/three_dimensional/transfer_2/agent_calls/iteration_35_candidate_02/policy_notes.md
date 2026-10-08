# Evidence-selected v41 candidate after the semantic-stall shelf audit

## Visual diagnosis before candidate selection

- The four sampled solvers and both completed rollouts in the assigned parent
  are not six independent responses: all six have the same policy, `4480`-row
  trajectory, and combined keyframe hashes.  Each direct-uniform still-water
  run captures at `24.640015T` and `0.748356L`, with mean distance
  `2.347937L`, score `-0.448328283`, and 284 moving-window shifts.  This is one
  deterministic nominal trajectory replicated six times, not evidence about
  reflection, release-pose perturbation, or external-wake rejection.
- I inspected the combined sheet from release through capture in both required
  views.  The top-down mid-plane row starts wake-free, develops a coherent
  alternating street behind sustained diagonal self-propulsion, and ends in a
  compact transverse hook through the target disk.  The oblique Lambda2 row
  shows compact three-dimensional structures following the body through the
  same hook.  With `U_infinity=[0,0,0]`, no cylinders, and no prewarm snapshot,
  the motion is self-propelled rather than advected.  Neither row shows wake
  breakup, out-of-plane escape, collision, or instability.
- The metrics agree with the images: the run is a stable capture with
  `0.939295` progress and `2.347937L` distance integral.  Inherited trace
  analysis reports zero joint-position hard-stop occupancy and low peak
  absolute planar body-force/yaw-moment coefficients
  (`0.02303/0.03169/0.01559`).  The `0.001644L` crossing margin and `73.594%`
  raw acceleration-envelope exposure make this a dynamic, narrow capture,
  not a settled or unsaturated hold.
- No sampled solver or assigned-parent rollout provides a distinct failure
  sheet, so a visual success/failure comparison cannot be manufactured.  The
  informative failures are the inherited completed mechanism controls: v42
  transfers rejected posterior terminal authority to the anterior anchor and
  worsens final/mean distance to `0.749001/2.348455L`, raw acceleration
  exposure to `74.124%`, and score to `-0.448986`; v43 instead vetoes the
  anterior share and reduces crossing margin to `0.000397L` while worsening
  mean distance/score to `2.348909L/-0.449516`.  Older dual-joint rate barriers
  and posterior reference-velocity feedforward reduce saturation measures but
  change the route and lose capture.

## Candidate hypothesis

Keep exactly one candidate: the prefilled v41 terminal phase-allocation policy,
byte-identical in dynamics and schema to the six realized nominal captures.  It
preserves the observed-state anterior phase anchor, lagged posterior traveling
bend, normalized body-frame projected-miss corridor, bounded half-cycle
steering allocation, posterior stopping-stroke reserve, and posterior rate
coast.  Do not add a flow/force/yaw residual, nominally dormant branch,
cross-joint authority recovery, or scalar terminal tune.  Current evidence has
no divergent trigger from which to infer such a correction's sign or scale,
and the completed adjacent controls consume capture margin or lose the route.

This is a concrete negative mechanism-transfer result, not a same-worker CFD
claim or a claim of new robustness.  Post-exit CFD should reproduce capture,
the coherent two-view wake, zero position hard-stop occupancy, and the low-load
class.  Reject this selection on nominal non-replication.  Reopen active
mechanism search only when a reflected pose, perturbed release, or genuinely
disturbed rollout supplies a distinct normalized body-frame trigger and a
calibrated sign; any future correction must remain null before that trigger and
must preserve the established far route.

bookshelf_consulted: true
source_domain: elongated-body propulsion, sensor-modulated robotic-fish oscillators, asymmetric turning, and wake interaction
source_mechanism: preserve a traveling anterior-to-posterior bend and spend bounded phase-selective feedback only after a measured target or disturbance error exists
transferable_invariant: retain the anterior phase anchor and posterior lag, and localize any correction with an evidenced normalized body-frame error whose sign and scale come from a divergent rollout
nontransferable_details: published gains, dimensional cadence, duty ratios, species or robot kinematics, full-body waves, exact vortex phases, Strouhal targets, capture geometry, and task-specific routes
policy_translation: retain v41's mirror-equivariant projected-miss residual, lagged-wave phase gate, independent anterior anchor, posterior stroke reserve, and posterior coast; introduce no uncalibrated self-wake residual or cross-joint authority transfer
falsification: reject on loss of nominal capture, coherent wake, zero hard-stop occupancy, low-load class, or the established advantage over v42 and v43; reject a future residual if it activates without a distinct body-frame disturbance or changes the captured far route

## Evaluation boundary

Formal CFD is deferred to the post-worker evaluator.  The present evidence
supports retaining this one materializable fixed-case candidate but does not
establish held-out robustness.

## Pre-evaluation validation

- The single candidate remains LF SHA-256
  `9e6a29b253671527cc436021e572b18ba5bf6994d71936eadf98ca674753fadd`,
  byte-identical to the four sampled and two assigned-parent policies.  No
  sibling candidate was created.
- The configured check-runner was invoked, but its pinned `gpt-5.4-mini` model
  is unsupported on this account.  Its three declared no-CFD checks were run
  directly and separately after removing a duplicate assigned-parent marker
  from the rendered workspace README.  The reusable-guidance check, Julia
  public-contract check, and solver editable-boundary audit pass; the contract
  returns finite accelerations `(-14.3858335, 0.0005062)`.
- The deterministic schema audit resolves all `87` direct `params.FIELD`
  references among the `89` fields returned by `target_policy_params()`.
  Formal CFD remains reserved for the post-worker evaluator.
