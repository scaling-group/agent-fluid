# Candidate diagnosis and hypothesis

## Evidence read before editing

- All four sampled solver examples are valid direct-uniform still-water runs:
  `initialization_mode=uniform_direct`, background velocity `[0,0,0]`, no
  prewarm snapshot, and capture at `23.8755T`. Their numeric policy parameters,
  trajectory SHA-256, and combined-keyframe SHA-256 are identical; policy-file
  differences are comments and version labels. They therefore provide one
  replicated trajectory, not four independent behavioral comparisons.
- In the top-down row, motion begins from quiescence and develops a strong,
  alternating reverse-street-like wake. The fish makes a broad target-directed
  redirect, keeps translating under its own gait, and bends onto a second arc
  before crossing the capture circle. There is no visual sign of passive
  advection by background flow. The oblique Lambda2 row confirms coherent
  three-dimensional paired structures remain attached to the same traveling
  route rather than a weak-wake static-posture slide.
- The replicated capture reduces distance from `12.3277L` to `0.7490L`, with
  mean scoring distance `2.4357L`, and is stable. It also retains avoidable
  actuation and terminal-motion symptoms: anterior/posterior commands exceed
  95% of the `31.416 rad/T^2` command scale for `55.2%/39.3%` of samples;
  joint velocity reaches `4.538 rad/T`; and peak yaw is `2.949 rad/T`. Within
  `2.1L`, mean absolute yaw is `1.558 rad/T`, commands exceed 80% of the scale
  for `76.3%/69.6%` of samples, and capture occurs with yaw `1.781 rad/T` while
  both commands remain near the projection scale. Angle-limit exposure is
  absent, so the unresolved issue is competition for acceleration authority,
  not insufficient posture range.
- The current sample set contains no visual failure: all four sheets are the
  same capture. The informative failure comparator is consequently limited to
  inherited evidence: opposite-sign static-posture replacements caused weak-
  wake upper exits (one with 78% posterior angle-limit exposure), whereas the
  carrier-preserving same-sign C-bend captured. That boundary argues against
  replacing or globally weakening the traveling-wave carrier.
- Inherited scalar logs show the structural sequence: same-sign C-bend capture
  at `25.388T`, response release at `25.152T`, smooth final projection at
  `23.997T`, and the sampled composition at `23.876T`. The candidate should
  preserve those layers and test a new authority-allocation mechanism rather
  than retune cadence or bend gains.

## Policy hypothesis

Retain the successful carrier, C-bend polarity, response release, and smooth
physical envelope exactly outside the established `2.1L` approach region.
Inside that region, continuously blend from the existing projection toward a
bounded carrier/residual allocator: project the target-feedback steering into
a small fraction of the acceleration envelope first, project the rhythmic
carrier into the remaining component-wise budget, then add them. This gives
the already computed normalized body-frame steering residual enforceable
near-target authority without a clock, mode, route, or global direction.

The rollout should retain capture and coherent wake while reducing terminal
yaw and joint-velocity exposure; useful improvement is earlier capture and/or
mean distance below `2.4357L`. Falsify the allocator if capture is lost, arrival
is later than `23.8755T` without a material load/limit improvement, mean
distance rises, wake coherence degrades, or command/yaw histories worsen.

bookshelf_consulted: true
source_domain: robotic-fish CPG path following and terminal fish capture control
source_mechanism: bounded feedback residual over a rhythmic carrier, with near-field authority reallocation
transferable_invariant: preserve the propulsive rhythm while guaranteeing a small bounded share of actuator authority to observation-driven steering when terminal correction is needed
nontransferable_details: published CPG gains, species-specific envelopes, dimensional beat frequencies, exact vortex phases, and source-task routes
policy_translation: blend by normalized distance from the existing combined projection to a component-wise carrier/residual allocator driven only by the existing body-frame target and joint-state feedback
falsification: reject if the replicated 23.8755T capture topology or coherent wake is lost, or if arrival, mean distance, yaw, velocity-cap exposure, and load histories do not jointly justify the allocation
