# Step 37 multi-wake target-policy diagnosis and hypothesis

## Evidence diagnosis before editing

- All four sampled rollouts satisfy the frozen experiment contract: direct
  uniform initialization in still water with `U_infinity=(0,0,0)`, no
  cylinders or prewarm, finite moving-window transport, and capture
  termination. Three execute the prefilled common-envelope redistribution
  policy exactly (one differs only in comments) and capture at
  `18.7165--18.8815T`, with score-defined mean distance
  `2.08855--2.09266L`. The clean-envelope ablation captures at `18.6010T` and
  `2.09042L`; this one fast sample does not dominate the redistribution repeat
  band.
- I inspected both rows of every sampled combined keyframe sheet and compared
  the best-integral redistribution capture with the most informative inherited
  failure. The sampled top-down rows start without a wake and develop coherent
  alternating streets along target-bending paths; their oblique rows retain
  compact bilateral and caudal Lambda2 structures through capture. Because the
  background velocity is zero, their translation is self-propelled rather than
  advected, and the lateral oscillation remains productive. No sampled sheet
  shows collision, wake collapse, domain exit, or instability.
- The inherited clean-envelope failure begins with the same productive two-view
  wake but turns down past the target: after reaching only `1.16972L`, heading
  rises to `1.26404 rad`, the fish continues down-left, and it exits at
  `33.0825T` with final distance `10.05586L`. Its lower rate contact
  (`9.06%/10.46%`) than the best redistribution capture
  (`11.07%/14.93%`) is not useful relief because capture is lost. Peak local
  body-frame flow remains essentially unchanged (`0.02561` versus `0.02557`),
  and the wake stays energetic, so this is route loss rather than advection or
  propulsion collapse.
- The assigned parent's clean-envelope evaluation does capture, but at
  `19.0795T` and mean distance `2.10426L`, outside both current sampled bands.
  Together with the exact clean-envelope failure, it overturns the inherited
  preference based on six earlier clean captures without a known miss. Clean
  and redistributed envelopes now both have contradictory semantic repeats;
  the current three-repeat batch and lower distance-integral band support
  retaining redistribution as the route carrier for one new ablation.
- Independent final clipping is structural rather than exceptional. In the
  best redistribution capture, anterior/posterior acceleration contact is
  `60.85%/73.27%` and rate contact is `11.07%/14.93%`; the sampled clean
  capture overlaps at `60.88%/72.95%` and `10.88%/14.96%`. Their peak planar
  force and moment also overlap (`0.03171/0.01632` and
  `0.03259/0.01656`). Route-envelope selection therefore has not relieved the
  actuator-heavy carrier, while pointwise rate barriers have already destroyed
  capture in inherited tests.

## Structured bookshelf transfer

bookshelf_consulted: true
source_domain: Taylor/Lighthill traveling-wave propulsion and low-dimensional robotic-fish CPG control
source_mechanism: preserve a directed posterior-lagged traveling bend by coordinating joint commands when the actuator envelope is active
transferable_invariant: saturation handling should preserve the instantaneous anterior/posterior command ratio and hence the coordinated traveling-wave shape instead of independently flattening either joint
nontransferable_details: published gains, dimensional cadence, species-specific envelopes, full-body kinematics, exact vortex phases, world coordinates, and task-specific routes
policy_translation: retain normalized body-lateral target steering, displacement-phase redistribution, non-inverting response release, differential mean curvature, and posterior lag; replace only independent acceleration clipping with one positive common scale that projects the two-joint demand vector inside the existing acceleration limit
falsification: reject if capture or either coherent wake row is lost, mean distance leaves the sampled redistribution `2.08855--2.09266L` band without a distinct load or demand benefit, the downward near-miss/left-exit topology recurs, rate contact does not materially improve, or planar force and moment exceed the sampled carrier range

## Exactly one candidate hypothesis

The candidate keeps the prefilled route and gait architecture and changes only
the actuator-envelope mechanism. When either raw joint acceleration exceeds
the existing limit, both commands receive the same bounded positive scale;
below the limit both pass unchanged. This radial allocation preserves command
sign, anterior/posterior ratio, target-owned curvature, observed displacement
phase, and posterior lag, whereas independent component clipping distorts the
traveling bend whenever only one joint saturates.

Expected result: retain the current capture topology and coherent two-view wake
while reducing clipping-induced interjoint phase distortion and, if that
distortion drives joint speeds, rate-limit contact. This is a coupled
state-feedback allocation mechanism, not scalar gain tuning. It adds no clock,
new route or terminal branch, flow/velocity residual, coordinate, mutable
state, or memorized phase. Formal CFD occurs after handoff, so no outcome is
claimed for this unevaluated candidate.
