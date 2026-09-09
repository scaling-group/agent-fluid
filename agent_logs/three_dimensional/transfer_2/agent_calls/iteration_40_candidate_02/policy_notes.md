# Candidate diagnosis and hypothesis

## Evidence read before editing

- All four sampled rollouts are valid direct-uniform still-water runs
  (`U_infinity=0`, no prewarm, no cylinders) and terminate by capture at
  `15.560--15.604T`. Their top-down sheets show self-propelled target progress
  with compact alternating mid-plane vortices; the oblique rows show coherent
  three-dimensional structures through the broad turn and final approach.
  There is no collision, passive-advection episode, wake breakup, or numerical
  instability to justify a wake-cancellation residual.
- `solver_cd24c4de2d66`, the assigned prefill, has the best score
  (`0.0941021`) and distance integral (`1.78768L`). It reaches the
  `10/8/6/4/2/1L` milestones at
  `5.687/7.541/9.350/11.352/13.822/15.191T`, earlier than the other three from
  `6L` inward, while retaining the sampled coherent-wake/load class.
- Releasing posterior positive work after course alignment
  (`solver_5672d12a7b42`) shortens the center path from `13.195L` to `13.033L`
  and slightly reduces peak planar force, but delays the `4/2/1L` milestones
  to `11.424/13.915/15.219T`, worsens the distance integral to `1.79252L`, and
  raises sub-`2L` mean absolute yaw rate from `0.103` to `0.128 rad/T`.
  A shared predictive carrier guard (`solver_6dada5e7a98a`) has the highest
  sampled load (`0.04226/0.02076` planar-force/yaw-moment coefficients) and the
  longest path among its nearest guard comparators. These results support
  preserving unresolved-course priority and joint-local work allocation.
- The remaining common defect is actuator contact: every sample reaches the
  exact `4.537856 rad/T` rate limit, with anterior greater-than-90%-rate
  residence of `17.31--17.45%` and greater-than-99% residence of
  `8.87--9.38%`. The current guard predicts contact from full demand but only
  withdraws outward rhythmic carrier work; target-conditioned steering remains
  able to do outward joint work even after the velocity course has aligned.

## Policy hypothesis

Preserve the complete capture scaffold, course-unresolved reversal priority,
and joint-local carrier guard. Add one energy-direction mechanism: after the
normalized body-frame velocity course aligns with the target, use each joint's
existing local rate-contact gate to withdraw only the same joint's outward
target-conditioned steering work. Inward steering, all steering while the
course is unresolved, carrier reversal, and the other joint's work remain
available. This should reduce hard-rate residence, path curvature, and loads
without sacrificing the early/middle milestones that distinguish the prefill.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG modulation and biological C-start redirect/release
source_mechanism: sensor-conditioned modulation of asymmetric rhythmic work; strong curvature is released after measured directional response appears
transferable_invariant: preserve redirect authority while direction error is unresolved, then continuously remove only actuator work that reinforces an already-resolved turn
nontransferable_details: published gains, oscillator timing, species-specific body envelopes, exact vortex phase, and any task-specific route
policy_translation: derive course resolution from bounded body-frame target-versus-velocity angle and combine it with normalized joint-rate phase to gate only same-joint outward steering acceleration
falsification: reject if capture or the prefill milestone class is lost, or if path, peak load, and greater-than-90/99%-rate residence do not improve together without degrading joint margin or two-view wake coherence

The new CFD result is not available to this worker; these expectations are for
the downstream evaluator and later workers to test.
