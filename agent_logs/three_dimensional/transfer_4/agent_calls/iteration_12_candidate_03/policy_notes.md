# Wake-policy candidate notes

## Evidence diagnosis

- All four sampled L64 rollouts use direct uniform still-water initialization
  (`U_infinity=[0,0,0]`), terminate in capture at `17.726505T`, and reproduce
  score `-0.081395415`, mean score-distance `1.967391L`, minimum/final distance
  `0.747287L`, and 235 moving-window shifts. Their combined keyframe sheets are
  byte-identical. Three candidate files are byte-identical; the fourth differs
  only by whitespace, so this sample supplies determinism evidence rather than
  four independent mechanisms or an informative failure topology.
- The top-down row shows self-propelled target closure with a coherent,
  alternating posterior wake from release through capture. The oblique
  Lambda2 row confirms organized three-dimensional trailing structures rather
  than passive advection or wake collapse. The metrics agree: distance falls
  from `12.327720L` to capture in still water, with no instability.
- The remaining useful defect is route-feedback selectivity, not propulsion.
  Mean target-course alignment is about `0.831` beyond `4L`, `0.943` over the
  `4L--2.1L` middle regime, and `0.899` inside `2.1L`, while RMS yaw rate stays
  near `2 rad/T`. The inherited controller qualifies its far/middle
  line-of-sight residual by instantaneous body-frame target error. Because the
  body axis oscillates with the productive beat, that gate can retain route
  authority even when the inertial velocity vector is already aimed at the
  target. The approach release itself is preserved: the residual remains
  exactly zero at and inside `2.1L`.
- The assigned parent reports that the error-qualified residual is the best
  completed route controller (`17.7265T`, score `-0.08140`), while an
  unqualified residual (`17.8750T`, `-0.08710`), a mean-curvature-only handoff
  (`18.6175T`, `-0.09128`), and terminal course injection (`17.8805T`,
  `-0.08868`) regress. Therefore this candidate preserves the residual's sign,
  gain, two-joint actuator path, and distance release; it changes only the
  observable condition under which an already-aligned course no longer needs
  that correction. The inherited `-0.0841666` capture has score-only evidence,
  so no mechanism is attributed to it.

## Policy hypothesis

Multiply the existing body-error qualification by a continuous course-miss
gate derived from the already computed body-frame target/velocity dot product.
Reuse the established capture-alignment thresholds: retain full line-of-sight
correction at alignment at or below `0.82`, fade it continuously through
`0.96`, and release it at or above `0.96`. This is a feedback-structure test,
not a new carrier-gain experiment. It should reduce unnecessary far/middle
steering during already productive target closure, shortening path or distance
integral without changing wake coherence, capture, or the ordinary approach
controller. Reject it if capture is lost, arrival/mean distance/path regress,
or the top-down and oblique wake loses the inherited traveling-wave structure.

bookshelf_consulted: true
source_domain: sensory CPG modulation and wake-interaction control
source_mechanism: separate slow persistent route error from fast alternating body and wake motion before applying a steering residual
transferable_invariant: route correction should act only when target geometry and inertial course both show a miss, and should release continuously once closure is aligned
nontransferable_details: published oscillator gains, species kinematics, exact vortex phase, cylinder-wake synchronization, and source-task routes
policy_translation: multiply the existing far/middle line-of-sight residual by a bounded course-miss gate computed from normalized body-frame target and velocity alignment; preserve the two-joint carrier, steering path, and near-target release
falsification: reject if capture, score-distance, arrival, or path worsens, or if either visual view shows degraded posterior traveling-wave coherence
