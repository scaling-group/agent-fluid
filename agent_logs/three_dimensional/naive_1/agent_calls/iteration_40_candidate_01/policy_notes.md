# Phase 2 multi-wake policy diagnosis and hypothesis

## Evidence diagnosis before editing

- All four assigned solver examples satisfy the direct-uniform still-water
  contract: `U_infinity=(0,0,0)`, no cylinders or prewarm, finite moving-window
  transport, and capture termination. The two executable-identical
  redistribution runs capture at `18.8265--18.8815T` with score-defined mean
  distance `2.08855--2.08896L`; the clean-envelope comparator captures at
  `18.6010T` and `2.09042L`; the rearward-route composition captures at
  `18.9640T` and `2.09072L`, but inherited reconstruction says its target stays
  forward, so it establishes only branch non-interference.
- I inspected both rows of the combined sheets for the best redistribution
  capture, the clean capture, the inherited target-progress capture, and the
  inherited target-progress failure. The assigned captures start in quiescent
  water, grow coherent alternating target-bending top-down streets, and retain
  compact bilateral/caudal Lambda2 structures through first crossing. Their
  translation is therefore self-propelled. The inherited failure also retains
  an energetic alternating street and compact 3D structures, but passes below
  the target, straightens onto an escaping path, and exits left; the failure is
  route loss rather than advection, wake collapse, collision, or instability.
- Assigned trajectory diagnostics agree with the images: anterior/posterior
  acceleration contact remains about `60.85--61.17%`/`72.95--73.27%`, rate
  contact about `10.88--11.07%`/`14.73--14.96%`, and peak planar force/moment
  `0.03066--0.03259`/`0.01603--0.01656`. Preserve the posterior-lagged
  traveling bend, displacement-only half-cycle allocation, and independent
  final acceleration projection; none of the assigned variants is actuator
  relief.
- Newly completed inherited logs falsify the prior expectation that replacing
  yaw response with target-bearing-window progress would improve semantic
  robustness. Executable-equivalent target-progress gates now include a
  `18.6835T`, mean-distance `2.09750L` capture and a coherent-wake left exit at
  `30.9375T` after reaching only `1.44371L`, alongside earlier captures. In the
  split step-39 pair, the failure has lower acceleration/rate contact
  (`58.90%/62.92%`, `6.77%/9.32%`) but larger peak planar force/moment
  (`0.03507/0.01792`) than the capture (`60.82%/73.15%`,
  `11.13%/15.10%`, `0.03330/0.01726`); lower contact is again not useful
  relief. Bearing-progress replacement is capture-compatible but neither a
  route improvement nor a robust discriminator.
- Removing response release globally previously lost capture, while broadside,
  rearward, terminal, velocity, and actuator-allocation compounds have their
  own negative boundaries. The remaining compact test is therefore not a new
  additive recovery channel: retain the evidenced yaw response but condition
  how much curvature it may release on the magnitude of the same normalized
  lateral target error that owns route sign.

## Structured bookshelf transfer

bookshelf_consulted: true
source_domain: biological C-start or burst redirect and closed-loop robotic-fish direction tracking
source_mechanism: maintain strong bounded curvature during large sensed direction error, then release continuously toward cruise after both geometric alignment and a corrective response appear
transferable_invariant: route-response feedback may release steering authority only in proportion to current normalized body-frame alignment; response alone is insufficient while target error remains large
nontransferable_details: published gains, dimensional cadence, species-specific burst kinematics, robot duty ratios, full-body waveforms, exact vortex phases, world coordinates, and task-specific routes
policy_translation: preserve normalized body-lateral route sign, differential curvature shares, anterior-displacement half-cycle steering, common-envelope redistribution, posterior lag, and independent acceleration projection; multiply the existing one-sided yaw-response release by a bounded alignment factor derived from absolute normalized lateral target error
falsification: reject if capture or either coherent wake row is lost, the below-target left-exit topology recurs, arrival or mean distance worsens outside established repeat spread without a semantic benefit, or actuator contact and planar loads materially exceed the carrier band; one ordinary capture establishes compatibility only, not robustness

## Exactly one candidate hypothesis

Materialize one error-qualified response-release controller on the assigned
redistribution carrier. The target's bounded body-lateral direction cosine
continues to own route sign and the current yaw response remains the only
release signal. The change is that a large lateral direction error suppresses
that release continuously, restoring the already-owned base curvature; as the
target aligns, correcting yaw can release up to the same bounded fraction as
the parent. The factor is nonnegative, so it can neither invert the requested
turn nor add curvature beyond the parent's base bias.

This is one response-scheduling mechanism rather than scalar-only tuning. It
adds no target-progress derivative, velocity/flow/force residual, recovery or
terminal branch, explicit time, step, world coordinate, mutable state, or
memorized phase. Formal CFD runs only after handoff, so no result is claimed
for this candidate.
