# Multi-Wake Policy Candidate Notes

## Evidence diagnosis

- The assigned parent is the common target-blind seed. No inherited optimizer
  rollout log is present in this workspace, and the only sampled solver result
  is the finite `left_domain` failure `solver_0ce0f9203505`; it therefore serves
  as both the best available finite example and the informative failure rather
  than as evidence of a prior improvement.
- The shared prewarm sheet shows a developed, interacting four-cylinder wake
  reaching the held fish. After release, the rollout sheet shows the fish leave
  the upper-right release pose on a steep path toward the lower boundary while
  the target marker stays well to its left. The path never visibly establishes
  a target-directed turn and exits below the useful wake corridor.
- The trajectory evidence matches the pictures: in only `50.127` released time
  the head moves `-3.545L` in x but `-13.300L` in y. Distance initially falls to
  `8.615L`, then grows to `12.123L`; this is a transient crossing of the target's
  lateral level, not useful approach.
- Mean velocity `(-0.0725,-0.2633)` and mean local flow
  `(-0.0414,-0.2414)` differ by only about `0.038U` in magnitude, so the large
  world displacement is mostly wake advection rather than strong controlled
  swimming. Meanwhile both joints hit `31.416 rad/time^2` acceleration and
  `4.538 rad/time` velocity limits, with command energy `75002`, so more scalar
  drive is not supported by this evidence.

## Candidate hypothesis

Keep the seed's state-feedback oscillator and lagged posterior bend, since it
stays finite and supplies a continuous traveling-bend scaffold. Add one new
mechanism: map normalized body-frame target bearing through a smooth bounded
nonlinearity to a mean-curvature bias, then run both joint oscillations about
that bias. This supplies the missing persistent turn command without clock
time, coordinates, wake phase, or a route. Do not add crossflow/load rejection
yet because this sampled rollout has aggregate RMS values but no sign-resolved
event evidence with which to calibrate such a residual.

Expected evidence after evaluation: the fish should bend and recover toward
the target instead of retaining the same steep lower-boundary topology, with a
better termination class and/or materially smaller mean and minimum distance.
Reject this translation if the turn sign is wrong, the same early
`left_domain` path remains, or saturation clips away the mean bias without
changing trajectory topology. If target-directed turning appears but wake
events later reverse it, a subsequent worker can then test a separately
bounded disturbance residual.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG and fish turning by tail-beat bias
source_mechanism: target-feedback modulation of a propulsive rhythm through bounded mean curvature
transferable_invariant: persistent body-frame direction error should shift mean joint curvature while the oscillatory traveling bend remains intact
nontransferable_details: published gains, dimensional frequencies, species-specific envelopes, exact vortex phases, and task-specific routes
policy_translation: smoothly saturate observed bearing into a joint-center bias and express both oscillator and posterior-lag targets around that bias
falsification: reject if turn sign or trajectory topology does not improve, thrust collapses, or actuator saturation prevents the bias from affecting the path
