# Approach-gated crossflow pose-rejection candidate

## Evidence and visual diagnosis before editing

- All four sampled solver results satisfy the direct-uniform Phase-2 contract:
  still water with `U_infinity=(0,0,0)`, no cylinders or prewarm, finite
  dynamics, moving-window transport, and semantic `capture`.  Three v34
  materializations and the prefilled v36 geometry-release materialization
  produce the same trajectory and reproduce capture at `18.403006 T`, score
  `-0.140449`, total distance integral `2.027810 L`, and observed integral
  `1.418099 L`.  Their top-down and oblique keyframe sheets are byte-identical.
- I inspected the combined and view-specific top-down vorticity and oblique
  body/Lambda2 sheets for the sampled capture, the assigned parent's completed
  full-crossflow comparator, and the slower inherited v32 capture.  Each fish
  visibly self-propels from quiescent water along the same smooth target-signed
  arc.  Compact startup structures develop into a coherent alternating
  mid-plane wake and organized three-dimensional posterior structures; there
  is no visible background advection, wake collapse, collision, or instability.
  The current workspace contains no non-capture keyframe artifact, so the
  inherited whole-wave-rate `left_domain` case is used only through its durable
  logged metrics and is not misreported as a newly inspected visual failure.
- The assigned parent's full crossflow-weighted pose correction is a semantic
  tradeoff rather than a score improvement.  It captures earlier at
  `18.325987 T` and slightly improves observed integral from `1.418099` to
  `1.417990 L`, but worsens total integral to `2.028916 L` and score to
  `-0.141865` because the final discrete crossing is shallower (`0.748005`
  versus `0.747223 L`).  Peak speed rises from `0.9476` to `0.9631 L/T` and
  any-joint acceleration-limit residence from `42.14%` to `43.55%`; peak
  normalized force/moment remain comparable at `0.03068/0.01580`.
- The route comparison localizes the useful part of the fluid-side correction.
  Full crossflow correction is farther away than the reproduced winner by
  `0.0150/0.0187/0.0041 L` at `8/12/14 T`, then leads by
  `0.0103/0.0421/0.0653 L` at `16/17/18 T`.  A global application therefore
  spends extra authority during an unhelpful middle interval even though its
  later pose correction improves closing.  This supports regime arbitration,
  not another crossflow gain change.
- The durable negative boundary remains the inherited whole-wave route-rate
  projection: it changes a useful carrier into a wrong-sign `left_domain`
  trajectory at `8.4755 T`, reaches only `12.2107 L`, and raises peak
  normalized force/moment to `0.3025/0.1347`.  This candidate leaves route-rate
  feedback, direct actuation, and large-error redirect selection unchanged.

## One-candidate policy hypothesis

Preserve the prefilled state-feedback traveling carrier, posterior lag,
geometry-gated redirect and bearing-divergence recovery, mean-preserving
whole-wave joint-pose projection, head-only route-rate correction, raw
half-cycle steering, response-gated cadence, carrier-first allocation, and
physical bounds.  Add the already evaluated odd, bounded crossflow-weighted
joint-phase correction only to proportional route pose, but arbitrate it by
normalized approach geometry: zero authority at and beyond twice the existing
approach radius, a continuous ramp inside that band, and full authority at the
approach radius.  Persistent crossflow cannot set the turn sign, and no fluid
signal enters redirect selection, rate feedback, carrier dynamics, or actuator
commands directly.

The expected result is to follow the reproduced v34 route through the middle
interval, then recover part of the parent's late `16-18 T` lead without its
middle-route regression.  Falsify the mechanism if capture is lost or later
than `18.403 T`, observed or total distance integral exceeds
`1.418099/2.027810 L`, the target-directed wake changes qualitatively, or peak
speed, acceleration-limit residence, normalized force, or normalized moment
materially exceeds the full-crossflow envelope
`0.9631/43.55%/0.03068/0.01580` without compensating closure.

bookshelf_consulted: true
source_domain: terminal capture control and sensor-modulated robotic-fish locomotion
source_mechanism: separate broad route propulsion from near-target yaw or slip correction and gate the corrective residual with observed geometry
transferable_invariant: a bounded fast body-frame disturbance correction should act only in the regime where completed trajectories show useful closure, while preserving the target-signed traveling carrier elsewhere
nontransferable_details: published gains, species-specific kinematics, dimensional cadence, clocked CPG phase, exact vortex phase, linkage geometry, world-frame routes, and task-specific coordinates
policy_translation: multiply the evaluated odd crossflow-weighted de-meaned joint-pose correction by a continuous normalized distance gate that is zero beyond twice `approach_distance_L` and full at `approach_distance_L`, leaving both-joint feedback and bounds unchanged
falsification: reject if middle or late closure regresses, capture is lost or delayed, the alternating wake weakens, or saturation, speed, normalized force, or yaw moment rises beyond the completed comparator without useful progress

## Evidence boundary

All outcome claims above come from completed sampled CFD, the assigned parent,
and inherited optimizer logs.  The gated candidate receives formal CFD only
after this worker exits; no same-worker improvement is claimed.
