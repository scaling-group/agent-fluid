# Evidence-selected v41 candidate at the carrier/terminal boundary

## Visual diagnosis before candidate selection

- The four sampled solver policies, their `4480`-row trajectories, and their
  combined keyframe sheets have identical hashes.  They are one replicated
  nominal condition: direct uniform still water (`U_infinity=[0,0,0]`), no
  cylinders, no prewarm snapshot, and capture at `24.640015T` and
  `0.748356L`, with mean distance `2.347937L`, score `-0.448328283`, and 284
  moving-window shifts.
- I inspected the combined sheet from release through capture in both required
  views.  The top-down row starts wake-free, develops a regular alternating
  mid-plane vortex street during diagonal self-propulsion, and finishes with a
  compact transverse hook through the target disk.  The oblique row retains
  compact paired three-dimensional Lambda2 structures through the hook.  With
  zero background flow the approach is not passive advection; neither view
  shows wake breakup, out-of-plane escape, collision, or instability.
- The trace supports the visual diagnosis.  Capture is a narrow dynamic
  crossing with only `0.001644L` margin and terminal yaw rate `1.887 rad/T`,
  while no joint occupies a position hard stop and the inherited peak planar
  force/yaw-moment class remains low.  The current sample set contains no
  distinct failure keyframe sheet, so a visual success/failure contrast cannot
  be manufactured.  The informative failures remain the inherited completed
  controls: v42 cross-joint headroom redistribution worsened final/mean
  distance and score to `0.749001/2.348455L/-0.448986`; v43 coupled
  anti-windup reduced crossing margin to `0.000397L` and worsened mean
  distance/score to `2.348909L/-0.449516`.  Older broad rate barriers and
  posterior reference-velocity feedforward changed the far route and lost
  capture despite improving selected saturation counts.
- A new distance-stratified audit sharpens why another terminal allocation is
  not justified.  Raw acceleration exceeds the owned `1800 deg/T^2` envelope
  on `3297/4480` rows (`73.594%`), but the exposure is `95.727%` on the 2434
  far rows above `6.5L`, `53.713%` on the 1562 middle rows from `2.1` to
  `6.5L`, and only `26.446%` on the 484 terminal rows at or below `2.1L`.
  Every terminal exceedance is anterior and none is posterior.  Thus the high
  raw count is primarily a far-route carrier/phase-anchor property, not unused
  posterior terminal authority and not evidence for another collision-course
  residual.

## Candidate hypothesis

Keep exactly one materializable candidate: the prefilled v41 terminal
phase-allocation policy, byte-identical in dynamics and schema to all four
sampled captures.  Preserve its observed-state anterior phase anchor, lagged
posterior traveling bend, normalized body-frame projected-miss corridor,
bounded aligned-half-cycle residual, posterior stopping-stroke reserve, and
posterior rate coast.  Do not manufacture a self-wake correction from a
nominal coherent wake, recover posterior authority through the anterior joint,
or treat the far-route raw-command count with another terminal tune.

This is a concrete negative selection after the semantic stall, not
scalar-only gain tuning and not a same-worker CFD claim.  Post-exit evaluation
should reproduce nominal capture, the coherent two-view wake, zero position
hard-stop occupancy, and the low-load class.  Reject the selection if nominal
capture fails.  Reopen the far-carrier saturation problem only with a distinct
phase-preserving mechanism tested against route topology and capture, and
reopen disturbance control only when reflected, perturbed-pose, or genuinely
disturbed evidence supplies a normalized body-frame trigger with an evidenced
sign and scale.

bookshelf_consulted: true
source_domain: elongated-body traveling-wave propulsion, sensor-modulated coupled-oscillator robotic-fish control, asymmetric fish turning, and terminal approach control
source_mechanism: preserve an observed anterior-to-posterior traveling bend, allocate bounded steering on a compatible joint-state half-cycle, and alter terminal drive only for a diagnosed terminal error
transferable_invariant: retain the anterior phase anchor and posterior lag, separate route-scale carrier behavior from terminal interception, and require a normalized body-frame trigger before adding corrective authority
nontransferable_details: published gains, dimensional cadence, prescribed duty ratios, species or robot kinematics, full-body waveforms, exact vortex phases, Strouhal targets, fixed capture geometry, and task-specific routes
policy_translation: retain v41's mirror-equivariant projected-miss residual and aligned lagged-wave phase gate with posterior stroke/rate safety kept joint-local; add no terminal scalar, cross-joint recovery, or uncalibrated wake residual
falsification: reject on loss of nominal capture, coherent wake, zero position hard-stop occupancy, or low-load class; reject a future far-carrier change if it lowers a saturation statistic but changes the captured route, and reject a disturbance residual if it activates without a distinct body-frame event

## Evaluation boundary

Formal CFD is deferred to the post-worker evaluator.  The retained candidate
does not establish robustness to reflection, release-pose perturbation,
imposed inflow, or external wakes.

## Pre-evaluation validation

- The single materializable candidate has LF SHA-256
  `9e6a29b253671527cc436021e572b18ba5bf6994d71936eadf98ca674753fadd`,
  matching every sampled v41 policy.  No sibling candidate was created.
- The configured check-runner was invoked, but its pinned `gpt-5.4-mini`
  model is unavailable on this account.  After removing the duplicated
  assigned-parent marker from the rendered README, its three declared no-CFD
  checks were run directly and separately: reusable-guidance semantics, the
  Julia public policy contract, and the solver editable-boundary audit pass.
  The contract returns finite accelerations
  `(-14.3858335, 0.0005062)`.
- The deterministic schema audit resolves all `87` direct `params.FIELD`
  references among the `89` fields returned by `target_policy_params()`.
  Formal CFD remains reserved for the post-worker evaluator.
