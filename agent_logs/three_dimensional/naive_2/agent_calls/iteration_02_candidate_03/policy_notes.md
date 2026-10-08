# Candidate wake-policy notes

## Evidence diagnosis before editing

- The assigned parent proposed bearing/yaw-damped mean curvature on both
  joints. Its completed rollout (`solver_0dbea11d1018`) is a concrete negative
  result: although initialization is contract-valid direct uniform still water,
  the joint oscillations collapse to roughly `[-9, 8] deg`, minimum distance
  improves by only `0.029L`, and the fish freezes into a clockwise bend before
  leaving the upper boundary at `10.945T` with distance `13.452L`. The sampled
  prefill (`solver_6dc885793e9d`) has the same topology and similarly small joint
  excursions, reaching only `12.271L` before exiting at `9.405T` with distance
  `13.455L`. Thus centering the anterior oscillator on persistent curvature is
  not a useful steering translation for this carrier.
- The strongest finite comparator is `solver_807c205ad607`. Its top-down row
  shows self-propelled leftward travel with an alternating vortex street and a
  much larger target-distance reduction before the path bends upward; the
  oblique Lambda2 row confirms a coherent three-dimensional posterior wake
  rather than passive advection. Metrics agree: mean distance is `11.567L`,
  minimum/final distance is about `11.512L`, and the run remains finite, but it
  still exits the upper boundary at `9.823T` after heading overshoot. Near its
  closest point the heading has passed to `-0.234 rad`, and by termination the
  recent yaw rate is `+2.34 rad/T` while the controller is trying to unwind.
- The drive-only seed also produces an organized wake in both views, but turns
  past alignment and exits upward at `8.547T`; its minimum distance is only
  `12.078L`. Its raw actions exceed the acceleration envelope frequently and
  joint speed reaches the hard limit, so more frequency, amplitude, or an
  ungated burst is not supported. Crossflow remains small in all sampled still-
  water rollouts (peak body-frame local crossflow about `0.019U`), so there is
  no evidence for a wake-rejection residual in this candidate.

## Policy hypothesis

Preserve the seed's uncentered anterior state-feedback oscillator and posterior
phase-lag carrier. Reuse the best sampled policy's body-frame bearing plus
recent-yaw damping, but translate the bounded turn request through posterior
half-cycle amplitude asymmetry instead of a persistent tail-angle center. The
asymmetry is proportional to the absolute phase-lagged tail carrier, so it is
zero at carrier crossings, strengthens one half-cycle, weakens the other, and
cannot become a static bend when the carrier loses amplitude. Smooth action
limiting retains the tested actuator-envelope behavior of the strongest sample.

This should keep the coherent propulsive wave, produce the calibrated negative
yaw for the initial positive bearing, and release turning earlier than a full
static tail offset. Falsify it if initial bearing grows, the joint-state carrier
collapses, minimum distance does not beat `11.512L`, joint-limit residence grows,
or the same upper-boundary exit occurs without a longer target-directed segment.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG turning and asymmetric flapping
source_mechanism: sensor-driven half-cycle amplitude asymmetry superposed on a phase-lagged propulsive rhythm
transferable_invariant: a bounded directional request can turn by strengthening one observed carrier half-cycle while preserving oscillation and posterior lag
nontransferable_details: published gains, clocked CPG phase, species-specific envelopes, exact vortex phase, and task-specific routes
policy_translation: map body-frame bearing with recent-yaw damping to an odd bounded command, then bias the posterior phase-lag target in proportion to its observed absolute carrier phase
falsification: reject if the initial turn sign is wrong, propulsion collapses, distance fails to improve beyond the best sampled 11.512L, actuator residence increases, or the upper-boundary hook is not materially delayed
