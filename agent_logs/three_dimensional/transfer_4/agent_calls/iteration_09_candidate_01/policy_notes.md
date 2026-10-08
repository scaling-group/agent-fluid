# Candidate diagnosis and hypothesis

No inherited file was present under `logs/optimize/`; the lineage mechanism
history was therefore taken from the assigned parent experience bank and
cross-checked against the sampled policies and their rollout artifacts.

The four sampled rollouts all satisfy the direct-uniform still-water contract
(`U_infinity=0`) and capture with a coherent self-propelled wake. In both rows
of the combined sheets, wake vorticity/Lambda2 is absent at release, forms
behind the moving posterior body by `4T`, and remains an alternating,
downstream structure through capture. There is no visible passive advection,
wake breakup, or out-of-plane instability. The lowest-scoring sampled case
(`solver_6f3a1c010b70`, `-0.09585`) is therefore an informative mechanism
negative rather than a failure termination: terminal posterior relief leaves
the established far trajectory unchanged and shortens arrival by only
`0.0110T`, while mean distance worsens from `1.98002L` to `1.98185L`.
Terminal course correction is similarly late and weak (`1.98085L`).

The strongest sample, `solver_ea4eb1868930`, adds co-windowed line-of-sight
rate feedback to the parent and improves mean distance to `1.97329L` and score
to `-0.08710`, with capture retained. Its benefit occurs before the terminal
corridor: at `14T` the head is about `0.24L` closer to the target in the
cross-target direction than the parent. Its cost is a longer center path
(`12.9663L` versus `12.8148L`), higher RMS yaw (`2.0577` versus `2.0285
rad/T`), higher RMS planar force coefficient (`0.01578` versus `0.01557`),
and a `0.0165T` later capture. The sheets agree that propulsion remains
coherent; the defect is excess route-steering activity, not loss of thrust.

Policy hypothesis: preserve the sampled line-of-sight observer and its odd,
bounded correction, but allocate that persistent route residual only to the
posterior mean-curvature target. Keep half-cycle acceleration steering on the
base target-geometry and turn-rate loop. This should retain the earlier
target-directed displacement while avoiding the additional phase-dependent
steering that lengthened the path and raised yaw/force. It is a feedback
architecture test, not a gain-only variant.

A synthetic lateral-reflection probe confirms that the new line-of-sight term
changes sign exactly. The inherited request shaper as a whole does not, because
`negative_turn_request_gain=0.78` intentionally gives the two request signs
different authority. That inherited mechanism is left unchanged so this
rollout tests only route-channel allocation; a later reflected-condition
evaluation should decide whether the older asymmetry remains justified.

bookshelf_consulted: true
source_domain: classical fish turning and closed-loop robotic-fish direction tracking
source_mechanism: bounded mean-curvature bias kept distinct from phase-dependent propulsive steering
transferable_invariant: a persistent body-frame route correction can bias the mean bend while the observed joint-state traveling wave and its half-cycle steering remain separate
nontransferable_details: published CPG gains, species envelopes, dimensional cadence, exact tail phases, and task-specific routes
policy_translation: compute normalized co-windowed line-of-sight drift as in the best sample; pass the shaped combined request to posterior mean curvature but pass the shaped base target/rate request to half-cycle steering
falsification: reject the allocation if capture is lost, mean distance returns to or above `1.98002L`, wake coherence degrades, or path/RMS yaw/RMS force do not improve relative to the sampled full-channel line-of-sight policy
