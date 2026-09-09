# Step 34 multi-wake target-policy diagnosis and hypothesis

## Evidence read before editing

- All four sampled episodes satisfy the frozen contract: direct uniform
  initialization in still water with `U_infinity=(0,0,0)`, no cylinders or
  prewarm, finite moving-window transport, and capture termination. Three
  execute the clean common-envelope redistribution controller exactly and
  capture at `18.6505--18.8815T`, with mean distance
  `2.08855--2.09222L`. The prefilled variant adds a rearward-only route
  multiplier and captures at `18.9640T` with mean distance `2.09072L`; the
  inherited reconstruction says its target stays forward, so the branch is
  not evidence of exercised recovery.
- I inspected all four combined keyframe sheets from release through capture.
  Their top-down rows begin in quiescent water and develop coherent alternating
  vortex streets along smooth target-bending trajectories. Their oblique rows
  retain compact bilateral and caudal Lambda2 structures through first
  crossing. Zero background flow makes the translation self-propelled; lateral
  oscillation remains part of a productive traveling bend, and no sampled view
  shows collision, wake collapse, domain exit, or numerical instability.
- The all-capture sampled set has no failure-class sheet, so the assigned-parent
  logs and durable guidance provide the required contrast. The same
  redistribution executable has previously missed at `0.81206L` and
  `1.25093L`, then bent downward and exited left despite energetic wakes and
  finite loads. This is route-semantic inconsistency, not propulsion collapse.
  Pointwise rate barriers, posterior-specific allocation, velocity residuals,
  observation-phase filtering, and stacked recovery channels already have
  completed negative evidence and are not reopened.
- The assigned parent's completed geometry-scheduled envelope ablation
  captures at `18.9585T`, minimum distance `0.74740L`, and mean distance
  `2.09594L`; I inspected its sheet and found the same coherent top-down street
  and compact caudal 3D structures. An executable-equivalent inherited sibling
  also captures at `18.7220T` and mean distance `2.09898L`. Together with the
  earlier clean-carrier captures, these results strengthen semantic
  repeatability for separating observed-phase steering from drive-envelope
  modulation, although their distance integral is modestly worse than the
  sampled redistribution band and they do not establish actuator relief.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: biological mean-curvature turning and robotic-fish closed-loop CPG asymmetric flapping
source_mechanism: bounded target-signed curvature modulated on an observed useful beat half while retaining a posterior-lagged traveling wave
transferable_invariant: preserve the coordinated traveling bend and let normalized body-frame target geometry own turn sign while joint displacement supplies clock-free steering phase
nontransferable_details: published gains, dimensional cadence, duty ratios, species-specific envelopes, exact vortex phases, and task-specific routes
policy_translation: retain normalized body-lateral curvature, non-inverting correcting-yaw release, displacement-only half-cycle steering, common geometry-owned mean amplitude relief, posterior lag, and final acceleration projection; remove rearward route gain and phase-dependent drive-envelope redistribution
falsification: reject if capture or either coherent wake row is lost, the downward near-miss/left-exit topology recurs, or route/load metrics fall outside the completed clean-carrier class without a distinct semantic benefit

## Single-candidate hypothesis

The prefill stacks an unexercised rearward recovery multiplier and two separate
beat allocations: supported positive target-signed curvature modulation and a
second phase-dependent redistribution of the common drive envelope. The
candidate removes the rearward branch and the disputed envelope allocation,
leaving one compact mechanism: body-frame target curvature allocated by
observed anterior displacement over the existing posterior-lagged carrier.

Expected result: independently retain capture and both coherent wake views in
the geometry-scheduled class, accepting its small mean-distance cost only as a
test of whether clean mechanism separation avoids redistribution's rare route
loss. This is an architectural ablation, not scalar-only gain tuning. It adds
no explicit time, step, velocity/flow residual, world coordinate, target
identity, mutable state, or memorized route. Formal CFD occurs after handoff,
so no result is claimed for this unevaluated candidate.
