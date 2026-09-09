# Step 33 multi-wake target-policy diagnosis and hypothesis

## Evidence read before editing

- All four sampled rollouts satisfy the frozen contract: direct uniform
  initialization in still water with `U_infinity=(0,0,0)`, no cylinders or
  prewarm, finite moving-window transport, and capture termination. Three
  execute the prefilled common-envelope redistribution policy byte-for-byte.
  They capture at `18.6505--18.8815T` with score-defined mean distance
  `2.08855--2.09222L`; the only different policy adds a rearward-only route
  multiplier, captures at `18.9640T` and `2.09072L`, and leaves demand and
  loads inside the clean-repeat spread. Because the target stays forward on
  the successful route, that branch demonstrates non-interference rather than
  recovery or a new useful mechanism.
- I inspected all four combined keyframe sheets from release through capture.
  Their top-down rows begin in quiescent fluid and develop a coherent
  alternating street along a smooth target-bending path. Their oblique rows
  retain compact bilateral/caudal Lambda2 structures through first crossing.
  With zero background flow, translation is self-propelled; the lateral beat
  is productive rather than wasteful, and no sheet shows collision, wake
  collapse, domain exit, or numerical instability. The current sample has no
  failure-class rollout, so the slower rearward-branch capture is used only as
  an architectural contrast, not mislabeled as a failure.
- Trajectory metrics corroborate the visual diagnosis. The three identical
  clean captures contact the anterior/posterior acceleration limit on
  `60.85--61.00%`/`72.97--73.27%` of rows and the rate limit on
  `11.01--11.07%`/`14.88--15.07%`; the rearward variant overlaps at
  `61.17%`/`73.00%` and `10.90%`/`14.73%`. Peak planar force and yaw moment
  likewise overlap. Repetition strengthens capture compatibility and wake
  coherence, but does not establish actuation relief or make raw score spread
  a gain-selection signal.
- The assigned-parent guidance and inherited logs provide the semantic
  counterevidence absent from this all-capture sample: the same redistribution
  bytes have also missed at `0.81206L` and `1.25093L`, with energetic wakes
  followed by downward/left exits. The simpler geometry-scheduled
  displacement-phase carrier has three inherited captures at
  `18.6505--18.7550T` and `2.09340--2.09542L`. A cruise-only posterior-lag
  boost worsened mean distance to `2.10021L`, while rate barriers, posterior-
  specific allocation, instantaneous velocity residuals, observation-phase
  filtering, and stacked recovery channels already have completed negative
  route evidence. Those mechanisms are not reopened here.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: robotic-fish asymmetric flapping and closed-loop CPG gait modulation
source_mechanism: allocate target-signed steering on an observed useful beat half while preserving a coordinated posterior-lagged traveling wave
transferable_invariant: preserve the target-owned positive half-cycle curvature factor and traveling-bend carrier, but remove a second beat-phase envelope modulation when completed semantics show route sensitivity despite coherent propulsion
nontransferable_details: published gains, dimensional cadence, robot geometry, clock phase, species-specific kinematics, exact vortex phases, and task-specific routes
policy_translation: retain normalized body-lateral route sign, non-inverting correcting-yaw release, displacement-only half-cycle curvature steering, common geometry-owned mean amplitude relief, posterior lag, and final acceleration projection; remove only phase-dependent redistribution of the drive envelope
falsification: reject if the rollout loses capture or either coherent wake row, repeats the downward near-miss/left-exit topology, or fails to return near the inherited geometry-scheduled `2.09340--2.09542L` mean-distance band; do not accept lower limit contact without route retention

## Single-candidate hypothesis

The prefilled controller stacks two beat-phase allocations: a supported,
positive target-signed curvature factor and a separate redistribution of the
common amplitude-relief envelope. The candidate removes only the latter.
Target geometry still owns turn sign, correcting yaw can release but never
invert the request, observed anterior displacement remains the clock-free beat
signal, and the mean-curvature shares, common mean relief, posterior lag, and
exact acceleration projection remain unchanged.

This is a one-mechanism architectural ablation, not scalar-only gain tuning.
It adds no terminal schedule, velocity or flow residual, posterior-only
allocation, rate barrier, recovery channel, explicit time, step count, world
coordinate, mutable state, or memorized route. Formal CFD runs only after this
worker exits, so no outcome is claimed for this unevaluated candidate.
