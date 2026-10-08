# Error-qualified line-of-sight route candidate

## Evidence reviewed before editing

- Read the assigned parent guidance, the four sampled scores, observations,
  diagnostics, metrics, trajectories, policies, and the available inherited
  optimizer notes. All sampled runs satisfy direct uniform still-water
  initialization with `U_infinity=(0,0,0)`, no prewarm, and capture
  termination. No true termination failure is present, so the weaker assigned
  solver parent is the informative negative control.
- Inspected both the top-down vorticity and oblique Lambda2 rows of the combined
  keyframe sheets for the best finite sample and the weaker parent. Both show
  self-propulsion from rest, a coherent alternating wake, and compact
  three-dimensional posterior structures through capture. Their wake topology
  is visually near-identical; the evidence does not support weakening the
  carrier or adding another saturation-oriented mechanism.
- The parent uses an unqualified line-of-sight residual and captures at
  `17.8750T`, score `-0.08710319`, mean distance `1.973290L`, final yaw rate
  `-3.1526 rad/T`, and 244 moving-window shifts. Three semantically identical
  error-qualified samples independently give the same `17.7265T` capture,
  score `-0.08139542`, mean distance `1.967391L`, final yaw rate
  `-0.9008 rad/T`, and 235 shifts. Inherited trajectory analysis also records
  a shorter `12.8468L` center path, `0.5120L` maximum head cross-track, and
  improved approach/final course alignment for the qualified controller.
- Prior inherited terminal-only course steering and posterior-load relief
  changed neither visible wake topology nor the route defect and worsened mean
  distance. Those negative results make another near-target injection or
  scalar carrier edit inappropriate for this candidate.

## One policy hypothesis

Replace the prefilled parent's unqualified line-of-sight route feedback with
the replicated error-qualified architecture. Preserve the anterior
phase-plane oscillator, posterior lag and emphasis, odd target-to-curvature
map, beat-synchronous steering, cadence schedule, and reversal-preserving rate
governor. Compute the existing co-windowed line-of-sight drift residual, but
multiply it by normalized current body-frame target error and a smooth
far/middle distance gate. Pass it through both existing steering channels and
make it exactly zero throughout the separately validated `2.10L` approach
regime. This is one feedback-architecture change, not scalar-only gain tuning.

Expected result: reproduce the sampled controller's coherent two-view wake and
capture while improving the assigned parent's arrival, distance integral,
route directness, and terminal yaw state. Falsify the candidate if it loses
capture or wake coherence, fails to improve the parent's score/mean distance,
returns to the late route crossing or high terminal yaw, or suppresses a
needed correction under a reflected or disturbed held-out condition.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and classical far/middle/near swimming control decomposition
source_mechanism: preserve a propulsive traveling-wave carrier while a bounded route correction is qualified by observed direction error and released continuously before terminal capture
transferable_invariant: a slower target-route feedback layer should have authority only while normalized body-frame route error persists and should hand off without disrupting the stable rhythmic carrier
nontransferable_details: published oscillator gains, clock phase, duty ratios, species kinematics, dimensional thresholds, exact vortex phases, target coordinates, and task-specific routes
policy_translation: multiply co-windowed line-of-sight drift by normalized bearing/vector-error and smooth far-distance gates, then feed it through the existing odd two-joint curvature and half-cycle steering path while leaving propulsion unchanged
falsification: reject if capture, mean distance, arrival, path, cross-track, terminal yaw, reflection symmetry, or either visual wake view regresses relative to the assigned parent and replicated sampled controller
