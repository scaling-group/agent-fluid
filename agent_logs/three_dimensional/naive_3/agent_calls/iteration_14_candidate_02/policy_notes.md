# Candidate diagnosis and hypothesis

## Evidence read before editing

All four sampled diagnostics confirm direct uniform quiescent initialization
(`U_infinity=0`) with no prewarm. The combined top-down vorticity and oblique
Lambda2 sheets show self-propulsion rather than advection: each policy leaves a
long alternating, coherent three-dimensional wake, follows the same diagonal
approach, then turns sharply below the target and powers into the lower virtual
boundary. There is no visible wake collapse or instability before exit.

The strongest sampled finite rollout is the measured-target-response posterior
brake (`solver_563a0d75514e`): it reaches `2.385L` at about `17.87T`, compared
with `2.443L` for the unmodified alignment-gated carrier, `2.512L` for the
joint-wave-phase counterbend, and `2.536L` for the bearing-response equilibrium
S-bend. At its minimum, the best trace still has about `1.38 rad` full target
direction error, `2.19 rad/T` heading rate in the error-growing direction,
only `0.014 L/T` closure, and `0.705U` translational speed. The four traces
have nearly identical force, moment, and wake scales and all end near `31T` by
lower exit. The inherited optimizer score logs likewise contain no success or
new termination class after the best brake (later minima include about
`2.444L` and `2.633L`).

Inside `3L`, heading rate is anticorrelated with anterior joint velocity at
`|r|=0.992--0.998`, and its target-error-growing sign occupies about
`47.3--50.2%` of samples. Thus raw yaw is principally a useful measured
half-cycle selector here, not a beat-averaged course estimate. The best brake
used that selector to discard posterior wave authority, which slightly helped
the minimum but left the trajectory topology unchanged. The current prefill's
joint-state-only half-cycle counterbend lacks the measured body-response
selector and regressed to `2.512L`.

## Policy hypothesis

Preserve the best brake's anterior oscillator, bounded target-relative mean
curvature, alignment envelope, approach/direction gates, and measured
wrong-way-yaw selector. On only that selected near-target half-cycle, retain
the brake but reverse a bounded fraction of the posterior traveling-wave
component it would otherwise discard. This is a response-selected posterior
counterstroke: outside the gate the proven carrier is exactly unchanged, and
inside it the tail target changes actuator topology rather than merely tuning
the brake floor. The counterstroke remains joint-state phased, normalized,
body-frame, reflection-equivariant, and within the existing command clamp.

Expected result: the selected counterstroke should reduce the persistent
lateral direction error while preserving the coherent cruise wake. Falsify it
if the rollout keeps the same lower-exit/minimum topology, loses far-field
progress or wake coherence, produces a short tight curl, or increases
posterior clamp/load residence materially.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG turning and asymmetric flapping
source_mechanism: measured directional response selects a bounded asymmetric tail-beat intervention while the propulsive rhythm continues
transferable_invariant: preserve the traveling-wave carrier and apply corrective posterior authority only on the observed error-growing response half-cycle
nontransferable_details: published gains, clock-driven CPG phase, robot geometry, species kinematics, exact tail-beat timing, and task routes
policy_translation: use normalized body-frame target direction, distance, measured heading rate, and joint-state wave phase to reverse part of only the posterior authority removed by the approach brake
falsification: reject if capture class and minimum do not improve, the lower-exit topology persists, the coherent wake shortens or collapses, or actuator/load residence worsens
