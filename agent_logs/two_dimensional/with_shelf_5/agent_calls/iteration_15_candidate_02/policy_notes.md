# Multi-wake target-policy candidate notes

## Evidence-first visual diagnosis

The shared prewarm sheet shows the held fish downstream and above four
cylinders while their staggered wakes develop into interacting vortex streets.
Because every candidate starts from this same certified field, the sheet
anchors the disturbance geometry rather than distinguishing policies.

All four sampled solvers reach the target, so there is no sampled
failure-termination keyframe to compare. The informative physical contrast is
instead between the strongest load-shaped success and the faster but
high-load bearing-history success, while the assigned parent's inherited logs
retain the common target-blind lower-boundary failure as the termination-class
boundary.

The distributed rate-projection sample preserves the visible immediate
correct-sign redirect, posterior traveling bend, and compact upstream-left
diagonal of the unguarded carrier. It reaches the target in the same
`43.9505` released time with slightly better mean distance
(`2.1372L` versus `2.1391L`). Its mean fish velocity
`(-0.2470,-0.1030)` differs materially from mean local flow
`(-0.1344,-0.1540)`, especially in the upstream component, so the route is
actively propelled rather than explained by wake advection. Relative to the
unguarded carrier it lowers RMS relative crossflow/force/moment from
`0.2111/49.44/701.26` to `0.2093/44.47/657.47`, command energy from
`53082.6` to `52868.1`, and power proxy from `3944.0` to `3889.8`.
Rate and acceleration caps remain reached, bounding the claim to distributed
load relief rather than peak avoidance.

The bearing-history sample visibly follows the same broad corridor and reaches
earlier at `41.5030`, but its larger realized joint excursions
(`0.579/0.527` rad versus `0.522/0.452`) coincide with higher RMS
crossflow/force/moment `0.2246/61.80/862.48`, higher command energy
`53802.7`, and higher power `4074.6`. Arrival alone therefore does not
justify observation-history filtering for this carrier. The inherited
posterior-only projection is a second useful contrast: repeated capture at
`44.0220` with `44.86/663.89` RMS force/moment shows the projection
mechanism is stable, while the sampled both-joint form recovers the baseline
arrival and slightly improves both loads. Inherited range localization and
phase selection weakened or erased the benefit, so the evidence supports
distributing the direction-aware projection, not tuning its thresholds or
retiming the oscillator.

## Policy hypothesis before the edit

Preserve the proven oscillator, bounded body-frame bearing curvature,
target-favored posterior half-cycle, posterior lag, and smooth approach
envelope. Add one compact mechanism: apply the assigned parent's smooth
alignment-gated directional rate projection to both joints. Large bearing
demand leaves the initial redirect untouched. Once aligned, each joint keeps
all reversal acceleration but sheds only the component that would drive an
already near-envelope rate farther outward.

The sampled rollout directly falsifies a concern that anterior projection
would weaken the route: it preserves `43.9505` capture while improving force,
moment, command, and power over the unguarded carrier and slightly improving
load and arrival over the repeatedly successful posterior-only form. Reject
the transfer on later wakes if the compact route changes, capture is delayed
or lost, reversal authority weakens, or load relief fails to reproduce. Do not
interpret continued cap contact as proof of no benefit, and do not respond by
scalar-only threshold tuning.

bookshelf_consulted: true
source_domain: elongated-body reactive propulsion and sensor-modulated robotic-fish rhythm control
source_mechanism: preserve the coordinated traveling bend and body-frame direction response while removing redundant actuator drive that reinforces an already near-envelope joint rate
transferable_invariant: retain target-directed curvature and every joint reversal, but distribute smooth outward-drive relief across the actuated body wave after alignment
nontransferable_details: published gains and actuator envelopes, dimensional frequencies, species or robot kinematics, prescribed oscillator phase, exact vortex phase, cylinder coordinates, and task-specific routes
policy_translation: use bounded normalized body-frame bearing demand as the alignment gate and each joint rate divided by its owned envelope as the actuator-state gate, then project only same-direction outward acceleration from both raw joint commands
falsification: reject if direct capture is delayed or lost, the compact trajectory or reversal pattern changes, or force and moment fail to remain below the unguarded and posterior-only carriers

## Pre-evaluation verification

The prescribed check-runner reports PASS for the semantic guidance/notes check
and PASS for the solver editable-boundary check; no CFD was run. Static schema
inspection found all `15` direct `params.FIELD` references among the `15`
fields returned by `target_policy_params()`, with no missing field. The 2D
candidate is byte-identical to the sampled distributed-projection policy whose
formal rollout supplies the stated `43.9505` capture and lower-load evidence.
The lightweight Julia include/assertion could not start because this runtime
has no `julia` executable (exit `127`), so that is an unavailable runtime
check rather than a pass or a candidate failure.
