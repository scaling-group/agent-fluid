# Step 33 wake-policy diagnosis and hypothesis

## Evidence read before editing

- All four sampled rollouts use direct uniform still-water initialization at
  `U_infinity=(0,0,0)`, with no cylinders or prewarm, and all terminate in
  capture. Three execute the prefilled half-cycle envelope-redistribution
  policy byte-for-byte and capture at `18.6505--18.8815T`, with mean distance
  `2.08855--2.09222L`. The fourth adds a rearward-only route multiplier and
  captures at `18.9640T` and `2.09072L`; the target stays forward on that
  successful route, so this is not evidence for the recovery mechanism.
- I inspected the combined keyframe sheets for the strongest sampled capture,
  the distinct rearward-route capture, the inherited clean-ablation capture,
  and two additional inherited capture variants. Every sheet starts in
  visibly quiescent water. From release through first crossing, the top-down
  rows form coherent alternating streets along target-bending paths and the
  oblique rows retain compact bilateral/caudal Lambda2 structures. Translation
  is self-propelled, lateral oscillation remains productive, and no sheet shows
  collision, wake collapse, domain exit, or numerical instability.
- The inherited record contains two more informative semantic failures of the
  executable-identical redistribution carrier. One approaches to `0.81206L`
  before exiting left; the other bends below the target, reaches only
  `1.25093L`, and exits left at `32.6370T` and `9.94426L`. The latter retains
  an energetic two-view wake, has finite peak planar loads, and contacts the
  acceleration/rate limits on `64.27%/70.48%` and `9.22%/10.57%` of rows, so
  neither wake collapse nor a singular load event explains away its route.
- Crucially, the inherited Step-32 evaluation has completed: deleting only the
  phase-dependent redistribution of common amplitude relief preserves capture
  at `18.6395T`, mean distance `2.09383L`, and both coherent wake rows. Its
  acceleration contact (`60.81%/73.12%`), rate contact (`11.12%/15.05%`), and
  peak planar force/moment (`0.01537/0.02894`, `0.01656`) overlap the sampled
  redistribution captures. Thus the ablation is a validated semantic carrier,
  not demand relief or a proven distance-integral improvement.
- A separate inherited `6%` cruise-aligned posterior-lag boost also captures,
  but worsens mean distance to `2.10021L` without reducing saturation or loads.
  This excludes another lag or thrust compound as the present candidate.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: robotic-fish asymmetric flapping and closed-loop CPG gait modulation
source_mechanism: apply target-signed steering on an observed useful beat half while preserving a coordinated posterior-lagged traveling wave
transferable_invariant: preserve the observed-phase steering factor and traveling-bend carrier, but keep the common propulsive envelope independent of beat phase when repeated route semantics contradict that extra allocation
nontransferable_details: published gains, dimensional cadence, robot geometry, prescribed clock phase, species-specific kinematics, exact vortex phase, and task-specific routes
policy_translation: retain normalized body-lateral route sign, one-sided correcting-yaw release, displacement-only half-cycle curvature steering, geometry-owned common amplitude relief, posterior lag, and final acceleration projection; remove only phase-dependent relief redistribution
falsification: reject this promoted ablation if an independent repeat loses capture or either coherent wake row, reproduces the downward near-miss/left-exit topology, or materially worsens the established `2.09340--2.09542L` geometry-scheduled distance band or load/contact envelope

## Single candidate hypothesis

Promote the completed clean geometry-scheduled ablation as the one candidate.
The controller keeps target-owned mean curvature, positive displacement-phase
steering, the non-inverting response-release gate, posterior lag, and exact
acceleration projection. It removes only the phase-dependent redistribution of
common amplitude relief, which the completed evaluation shows is unnecessary
for capture or the coherent two-view wake and which two executable-equivalent
failures implicate as a semantic robustness risk.

This is a one-mechanism structural ablation, not scalar gain tuning. It adds no
recovery channel, terminal schedule, velocity/flow residual, posterior-specific
allocation, explicit time, step count, world coordinate, mutable state, or
memorized route. The promoted single evaluation supports viability, not
repeatability; later workers should require independent captures before calling
the robustness question resolved.
