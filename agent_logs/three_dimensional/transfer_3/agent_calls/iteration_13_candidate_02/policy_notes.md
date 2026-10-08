# Crossflow-supported posterior curvature-allocation candidate

## Evidence and visual diagnosis before the policy edit

- All four sampled evaluations satisfy the frozen physical contract: direct
  uniform initialization in still water with `U_infinity=(0,0,0)`, no
  cylinders or prewarm, active moving-window transport, finite dynamics, and
  capture. Three are byte-identical v26 evaluations at score
  `-0.5281078349`, mean distance `2.4291113720 L`, final distance
  `0.7461675406 L`, and capture `25.1185226 T`; the v23 comparator captures
  on the same solver step but is weaker at `-0.5283387731`,
  `2.4292937801 L`, and `0.7464101911 L`.
- I inspected both the top-down vorticity and oblique body/Lambda2 rows of the
  combined sheets for the strongest v26 sample and the informative v23
  comparator from release through termination. Both show self-propulsion
  along the same compact targetward arc, a coherent alternating outer wake,
  and a quiet held-bend terminal translation into the capture sphere. Neither
  shows passive advection, collision, a domain-exit precursor, wasteful late
  oscillation, or instability. The terminal difference is below the sheets'
  visual resolution, so the small ranking is supported by trajectory and
  diagnostics rather than vortex appearance alone.
- The sampled comparison validates the v26 cue and actuator locus: after
  target-helpful body-relative crossflow, positive closure, proximity, and
  joint settling agree, recovering a small amount of the existing paired
  carrier improves distance integral and crossing depth without changing the
  outer route or capture step. The assigned-parent log also records that
  directly scaling both held-curvature targets under the same cue regressed
  to score `-0.5285807072` and final distance `0.746665657 L`; the cue does not
  license generic mean-bend unloading.
- An earlier inherited completed zero-sum allocation test moved target-signed
  mean bend from the posterior joint to the anterior joint. It reduced final
  heading error from about `0.6670` to `0.6484 rad` and slightly raised
  crossing speed, yet regressed score to `-0.5288433734`, mean distance to
  `2.429624931 L`, and final distance to `0.747277439 L`. Better alignment
  through more anterior leverage is therefore not a capture improvement; its
  sign complement is a bounded, falsifiable allocation experiment rather
  than a request for more total curvature.

## Policy hypothesis

Preserve v26's outer state-feedback oscillator, posterior-lag carrier,
body-frame target-angle redirect, closure preview, damped two-joint terminal
equilibrium, response-conditioned paired carrier relief, and all limits. Add
one late allocation mechanism: once the inherited equilibrium is settled and
the already validated normalized target-side crossflow/closure/proximity cue
is active, move at most a small declared amount of the existing target-signed
mean tangent from the anterior equilibrium target to the posterior target.
The two targets retain an exact constant sum, so the edit changes neither
total requested curvature nor turn sign, and it is exactly inactive outside
the inherited `1.6 L` late gate.

This tests whether less anterior yaw leverage and more posterior reactive
allocation preserve the productive terminal crab better than the completed
opposite redistribution. Accept only if the compact capture is retained and
score, mean distance, crossing depth, or arrival improves without changing
the outer two-view wake. Reject if the gate is dormant, total target curvature
changes, capture is delayed or lost, distance metrics regress, or command
clipping, joint-stop dwell, terminal force/moment growth, wake degradation,
instability, or looping returns. The formal CFD evaluation happens only after
this worker exits and is not claimed here.

bookshelf_consulted: true
source_domain: Lighthill-style posterior reactive-thrust allocation and robotic-fish mean-curvature steering
source_mechanism: separate posterior propulsive authority from anterior steering leverage while preserving a proven traveling carrier and bounded total mean bend
transferable_invariant: with few joints, observed useful targetward response can redistribute a fixed target-signed mean curvature toward the posterior actuator without adding total bend or disturbing the outer carrier
nontransferable_details: published gains, dimensional cadence, species-specific curvature envelopes, full-body kinematics, exact vortex phases, inflow and cylinder details, and task-specific routes
policy_translation: smooth normalized body-frame target side, relative crossflow, positive range closure, proximity, and inherited two-joint settling gate a bounded zero-sum shift from the anterior terminal target to the posterior terminal target
falsification: reject if the shift is inactive or changes total curvature, the outer path or wake changes, compact capture or distance metrics regress, or saturation, joint stops, load spikes, instability, or looping returns
